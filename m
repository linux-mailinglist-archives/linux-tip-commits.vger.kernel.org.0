Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 771DE1C78F2
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 May 2020 20:09:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729907AbgEFSIe (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 6 May 2020 14:08:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729301AbgEFSIe (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 6 May 2020 14:08:34 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 791E3C061A41;
        Wed,  6 May 2020 11:08:33 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jWOT5-0001Ev-VI; Wed, 06 May 2020 20:08:28 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 88CA21C0092;
        Wed,  6 May 2020 20:08:27 +0200 (CEST)
Date:   Wed, 06 May 2020 18:08:27 -0000
From:   "tip-bot2 for Reinette Chatre" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Support wider MBM counters
Cc:     Reinette Chatre <reinette.chatre@intel.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3C69d52abd5b14794d3a0f05ba7c755ed1f4c0d5ed=2E15887?=
 =?utf-8?q?15690=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
References: =?utf-8?q?=3C69d52abd5b14794d3a0f05ba7c755ed1f4c0d5ed=2E158871?=
 =?utf-8?q?5690=2Egit=2Ereinette=2Echatre=40intel=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <158878850741.8414.13438158465849452103.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     0c4d5ba1b998e713815b7790d3db6ced0ae49489
Gitweb:        https://git.kernel.org/tip/0c4d5ba1b998e713815b7790d3db6ced0ae49489
Author:        Reinette Chatre <reinette.chatre@intel.com>
AuthorDate:    Tue, 05 May 2020 15:36:18 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 06 May 2020 18:08:32 +02:00

x86/resctrl: Support wider MBM counters

The original Memory Bandwidth Monitoring (MBM) architectural
definition defines counters of up to 62 bits in the
IA32_QM_CTR MSR while the first-generation MBM implementation
uses statically defined 24 bit counters.

The MBM CPUID enumeration properties have been expanded to include
the MBM counter width, encoded as an offset from 24 bits.

While eight bits are available for the counter width offset IA32_QM_CTR
MSR only supports 62 bit counters. Add a sanity check, with warning
printed when encountered, to ensure counters cannot exceed the 62 bit
limit.

Signed-off-by: Reinette Chatre <reinette.chatre@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/69d52abd5b14794d3a0f05ba7c755ed1f4c0d5ed.1588715690.git.reinette.chatre@intel.com
---
 arch/x86/kernel/cpu/resctrl/internal.h | 8 +++++++-
 arch/x86/kernel/cpu/resctrl/monitor.c  | 8 +++++++-
 2 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 58b002c..f20a47d 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -31,7 +31,7 @@
 
 #define CQM_LIMBOCHECK_INTERVAL	1000
 
-#define MBM_CNTR_WIDTH			24
+#define MBM_CNTR_WIDTH_BASE		24
 #define MBM_OVERFLOW_INTERVAL		1000
 #define MAX_MBA_BW			100u
 #define MBA_IS_LINEAR			0x4
@@ -40,6 +40,12 @@
 
 #define RMID_VAL_ERROR			BIT_ULL(63)
 #define RMID_VAL_UNAVAIL		BIT_ULL(62)
+/*
+ * With the above fields in use 62 bits remain in MSR_IA32_QM_CTR for
+ * data to be returned. The counter width is discovered from the hardware
+ * as an offset from MBM_CNTR_WIDTH_BASE.
+ */
+#define MBM_CNTR_WIDTH_OFFSET_MAX (62 - MBM_CNTR_WIDTH_BASE)
 
 
 struct rdt_fs_context {
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index df964c0..837d7d0 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -618,12 +618,18 @@ static void l3_mon_evt_init(struct rdt_resource *r)
 
 int rdt_get_mon_l3_config(struct rdt_resource *r)
 {
+	unsigned int mbm_offset = boot_cpu_data.x86_cache_mbm_width_offset;
 	unsigned int cl_size = boot_cpu_data.x86_cache_size;
 	int ret;
 
 	r->mon_scale = boot_cpu_data.x86_cache_occ_scale;
 	r->num_rmid = boot_cpu_data.x86_cache_max_rmid + 1;
-	r->mbm_width = MBM_CNTR_WIDTH;
+	r->mbm_width = MBM_CNTR_WIDTH_BASE;
+
+	if (mbm_offset > 0 && mbm_offset <= MBM_CNTR_WIDTH_OFFSET_MAX)
+		r->mbm_width += mbm_offset;
+	else if (mbm_offset > MBM_CNTR_WIDTH_OFFSET_MAX)
+		pr_warn("Ignoring impossible MBM counter offset\n");
 
 	/*
 	 * A reasonable upper limit on the max threshold is the number
