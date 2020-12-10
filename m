Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F52F2D5343
	for <lists+linux-tip-commits@lfdr.de>; Thu, 10 Dec 2020 06:27:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727291AbgLJF1W (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 10 Dec 2020 00:27:22 -0500
Received: from mga09.intel.com ([134.134.136.24]:7013 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726434AbgLJF1V (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 10 Dec 2020 00:27:21 -0500
IronPort-SDR: YGPG6Md4hw4U1ii42vayo0QyUJ4NcIchGGZAtaq66/aWQcIViNfz7+2PdbzUMgKVh3qmsjTH4E
 SKhqdxfE/iuQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9830"; a="174346308"
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="174346308"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 21:26:40 -0800
IronPort-SDR: lo7EoDzHT9S0ukNUp46sLr07ZFqRc17qbqchgU/rS41xUqqRqDzKVWi5TBt1ydWTohVSIlBqa2
 gAbrkdqPFfUw==
X-IronPort-AV: E=Sophos;i="5.78,407,1599548400"; 
   d="scan'208";a="408389993"
Received: from xshen14-linux.bj.intel.com ([10.238.155.105])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Dec 2020 21:26:38 -0800
From:   Xiaochen Shen <xiaochen.shen@intel.com>
To:     bp@alien8.de
Cc:     linux-tip-commits@vger.kernel.org, bp@suse.de, tony.luck@intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        xiaochen.shen@intel.com
Subject: [tip: x86/cache v2] x86/resctrl: Fix incorrect local bandwidth when mba_sc is enabled
Date:   Thu, 10 Dec 2020 13:49:17 +0800
Message-Id: <1607579357-15897-1-git-send-email-xiaochen.shen@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <20201209222328.GA20710@zn.tnic>
References: <20201209222328.GA20710@zn.tnic>
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

MBA software controller (mba_sc) is a feedback loop which periodically
reads MBM counters and tries to restrict the bandwidth below a user
specified bandwidth. It tags along MBM counter overflow handler to do
the updates with 1s interval in mbm_update() and update_mba_bw().

The purpose of mbm_update() is to periodically read the MBM counters to
make sure that the hardware counter doesn't wrap around more than once
between user samplings. mbm_update() calls __mon_event_count() for local
bandwidth updating when mba_sc is not enabled, but calls mbm_bw_count()
instead when mba_sc is enabled. __mon_event_count() will not be called
for local bandwidth updating in MBM counter overflow handler, but it is
still called when reading MBM local bandwidth counter file
'mbm_local_bytes', the call path is as below:

  rdtgroup_mondata_show()
    mon_event_read()
      mon_event_count()
        __mon_event_count()

In __mon_event_count(), m->chunks is updated by delta chunks which is
calculated from previous MSR value (m->prev_msr) and current MSR value.
When mba_sc is enabled, m->chunks is also updated in mbm_update() by
mistake by the delta chunks which is calculated from m->prev_bw_msr
instead of m->prev_msr. But m->chunks is not used in update_mba_bw() in
the mba_sc feedback loop.

When reading MBM local bandwidth counter file, m->chunks was changed
unexpectedly by mbm_bw_count(). As a result, the incorrect local
bandwidth counter which calculated from incorrect m->chunks is read out
to the user.

Fix this by removing incorrect m->chunks updating in mbm_bw_count() in
MBM counter overflow handler, and always calling __mon_event_count() in
mbm_update() to make sure that the hardware local bandwidth counter
doesn't wrap around.

Test steps:
  # Run workload with aggressive memory bandwidth (e.g., 10 GB/s)
  git clone https://github.com/intel/intel-cmt-cat && cd intel-cmt-cat
  && make
  ./tools/membw/membw -c 0 -b 10000 --read

  # Enable MBA software controller
  mount -t resctrl resctrl -o mba_MBps /sys/fs/resctrl

  # Create control group c1
  mkdir /sys/fs/resctrl/c1

  # Set MB throttle to 6 GB/s
  echo "MB:0=6000;1=6000" > /sys/fs/resctrl/c1/schemata

  # Write PID of the workload to tasks file
  echo `pidof membw` > /sys/fs/resctrl/c1/tasks

  # Read local bytes counters twice with 1s interval, the calculated
  # local bandwidth is not as expected (approaching to 6 GB/s):
  local_1=`cat /sys/fs/resctrl/c1/mon_data/mon_L3_00/mbm_local_bytes`
  sleep 1
  local_2=`cat /sys/fs/resctrl/c1/mon_data/mon_L3_00/mbm_local_bytes`
  echo "local b/w (bytes/s):" `expr $local_2 - $local_1`

Before fix:
  local b/w (bytes/s): 11076796416

After fix:
  local b/w (bytes/s): 5465014272

Fixes: ba0f26d8529c (x86/intel_rdt/mba_sc: Prepare for feedback loop)
Signed-off-by: Xiaochen Shen <xiaochen.shen@intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 622073f..7ac3121 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -343,7 +343,6 @@ static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
 		return;
 
 	chunks = mbm_overflow_count(m->prev_bw_msr, tval, rr->r->mbm_width);
-	m->chunks += chunks;
 	cur_bw = (get_corrected_mbm_count(rmid, chunks) * r->mon_scale) >> 20;
 
 	if (m->delta_comp)
@@ -514,15 +513,14 @@ static void mbm_update(struct rdt_resource *r, struct rdt_domain *d, int rmid)
 	}
 	if (is_mbm_local_enabled()) {
 		rr.evtid = QOS_L3_MBM_LOCAL_EVENT_ID;
+		__mon_event_count(rmid, &rr);
 
 		/*
 		 * Call the MBA software controller only for the
 		 * control groups and when user has enabled
 		 * the software controller explicitly.
 		 */
-		if (!is_mba_sc(NULL))
-			__mon_event_count(rmid, &rr);
-		else
+		if (is_mba_sc(NULL))
 			mbm_bw_count(rmid, &rr);
 	}
 }
-- 
1.8.3.1

