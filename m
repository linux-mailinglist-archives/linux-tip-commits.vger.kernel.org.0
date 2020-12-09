Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7BA92D49CF
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Dec 2020 20:09:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387475AbgLITHm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 9 Dec 2020 14:07:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:48758 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387423AbgLITHl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 9 Dec 2020 14:07:41 -0500
Date:   Wed, 09 Dec 2020 19:06:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607540819;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kI1bI5AtL9U1dWmckIrXrJ79KbBqG8wDpB1V+VlTzAQ=;
        b=xC1cYYb8FSHabC2tBew7UI3ot8V32FucS6u5iBsO4rjw/pGijMbOT7LheFiQeP6JKuTASd
        jaDFzvu5brvPNC3SyLQujjxY9CNtsTXToWVNEE5kb0IYsvMrviKJAUJSef99luDmgxd887
        0+2XBPBBtLX2zrvR4fELsxxDkm/msjz7R2RnW5do5r3sV8KQ/RPGPMPq3h40CAzot55PGC
        W1UUn1KhpBRUiBB/HFjDAk44eAnc7qhg6zc3kIuXlN9qQOK6LcUPArj7mmxX7YQcV9vmVO
        XvoRKJX9hOJThptCdcJtg2c6xv/wMZIcG9P5bPS8uWcxF+f5THzkVRGsAqxrig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607540819;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kI1bI5AtL9U1dWmckIrXrJ79KbBqG8wDpB1V+VlTzAQ=;
        b=rMxAOQi11MXJY4IRr7Ig0WoR6AMwBYXnYBac0ptIrBl37kuV+hgKPqntMdUY2w3gXqymKr
        pIDM7iH6iajmn2CQ==
From:   "tip-bot2 for Xiaochen Shen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Fix incorrect local bandwidth when
 mba_sc is enabled
Cc:     Xiaochen Shen <xiaochen.shen@intel.com>,
        Borislav Petkov <bp@suse.de>, Tony Luck <tony.luck@intel.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <1607063279-19437-1-git-send-email-xiaochen.shen@intel.com>
References: <1607063279-19437-1-git-send-email-xiaochen.shen@intel.com>
MIME-Version: 1.0
Message-ID: <160754081861.3364.12382697409765236626.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     2ba836dbe2467d31fffb439258c2f454c6f1a317
Gitweb:        https://git.kernel.org/tip/2ba836dbe2467d31fffb439258c2f454c6f1a317
Author:        Xiaochen Shen <xiaochen.shen@intel.com>
AuthorDate:    Fri, 04 Dec 2020 14:27:59 +08:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 09 Dec 2020 20:00:46 +01:00

x86/resctrl: Fix incorrect local bandwidth when mba_sc is enabled

The MBA software controller (mba_sc) is a feedback loop which periodically
reads MBM counters and tries to restrict the bandwidth below a user
specified bandwidth. It tags along the MBM counter overflow handler to do
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
bandwidth counter which calculated using incorrect m->chunks is shown to
the user.

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
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/1607063279-19437-1-git-send-email-xiaochen.shen@intel.com
---
 arch/x86/kernel/cpu/resctrl/monitor.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 622073f..93a33b7 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -320,7 +320,6 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
 	}
 
 	chunks = mbm_overflow_count(m->prev_msr, tval, rr->r->mbm_width);
-	m->chunks += chunks;
 	m->prev_msr = tval;
 
 	rr->val += get_corrected_mbm_count(rmid, m->chunks);
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
