Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02D529C617
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Oct 2020 19:26:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1825712AbgJ0SM7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 27 Oct 2020 14:12:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48280 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1825625AbgJ0SM6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 27 Oct 2020 14:12:58 -0400
Date:   Tue, 27 Oct 2020 18:12:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603822375;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L/T3qfd6/noedTp67gMlroGovqNWCG5vnoB1h4Ikd4I=;
        b=UPCbqo7+leMuPmTPED1zInRf+nJ8PPKIoDcTiPedy7oXN7UGULO9byJ2aYVXXdkd+ILoh+
        TUM+2GR64u/gl7o21bIJCHLIgkSn2cig/Nvz7F0PoWY8v6dQBaU8RIZkme4T92xkDVhasn
        kwYY8ndFRU9nk0jwVjQCo+CkHUD+XYt50AE6gzEYJYpHhNcfFUvSSJWl4Wox6oTVl7hsBA
        9NTOR/i2ljiu/wLYODrTlGjYBwkXPx3oRf2EiKcGPu8JGG+puvT9KubSbwdIFz4qUpIz0A
        qQtwjjAgvwJkSI554tDlsQxG1cSc3kFqRRXz8o+sm7DErPpbQ7EPyA6vWnuDcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603822375;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L/T3qfd6/noedTp67gMlroGovqNWCG5vnoB1h4Ikd4I=;
        b=aBp+yOjZKmcYUQOtK/cn1e4tKFdsuuj9BCV97IhhAOLMDLm3ZKJdad5SFT0dKQaWlu7pFo
        6Tj7ygOP1qk4rSBw==
From:   "tip-bot2 for Fenghua Yu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cache] x86/resctrl: Correct MBM total and local values
Cc:     Fenghua Yu <fenghua.yu@intel.com>, Borislav Petkov <bp@suse.de>,
        Tony Luck <tony.luck@intel.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201014004927.1839452-3-fenghua.yu@intel.com>
References: <20201014004927.1839452-3-fenghua.yu@intel.com>
MIME-Version: 1.0
Message-ID: <160382237255.397.11894584690572164364.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cache branch of tip:

Commit-ID:     4868a61d498af3627c3b571aa48107a845001e51
Gitweb:        https://git.kernel.org/tip/4868a61d498af3627c3b571aa48107a845001e51
Author:        Fenghua Yu <fenghua.yu@intel.com>
AuthorDate:    Wed, 14 Oct 2020 00:49:27 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 27 Oct 2020 18:57:22 +01:00

x86/resctrl: Correct MBM total and local values

Intel Memory Bandwidth Monitoring (MBM) counters may report system
memory bandwidth incorrectly on some Intel processors. The errata SKX99
for Skylake server, BDF102 for Broadwell server, and the correction
factor table are documented in Documentation/x86/resctrl.rst.

Intel MBM counters track metrics according to the assigned Resource
Monitor ID (RMID) for that logical core. The IA32_QM_CTR register
(MSR 0xC8E) used to report these metrics, may report incorrect system
bandwidth for certain RMID values.

Due to the errata, system memory bandwidth may not match what is
reported.

To work around the errata, correct MBM total and local readings using a
correction factor table. If rmid > rmid threshold, MBM total and local
values should be multiplied by the correction factor.

 [ bp: Mark mbm_cf_table[] __initdata. ]

Signed-off-by: Fenghua Yu <fenghua.yu@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Link: https://lkml.kernel.org/r/20201014004927.1839452-3-fenghua.yu@intel.com
---
 arch/x86/kernel/cpu/resctrl/core.c     |  4 +-
 arch/x86/kernel/cpu/resctrl/internal.h |  1 +-
 arch/x86/kernel/cpu/resctrl/monitor.c  | 82 ++++++++++++++++++++++++-
 3 files changed, 85 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/cpu/resctrl/core.c b/arch/x86/kernel/cpu/resctrl/core.c
index e5f4ee8..1a681fd 100644
--- a/arch/x86/kernel/cpu/resctrl/core.c
+++ b/arch/x86/kernel/cpu/resctrl/core.c
@@ -893,6 +893,10 @@ static __init void __check_quirks_intel(void)
 			set_rdt_options("!cmt,!mbmtotal,!mbmlocal,!l3cat");
 		else
 			set_rdt_options("!l3cat");
+		fallthrough;
+	case INTEL_FAM6_BROADWELL_X:
+		intel_rdt_mbm_apply_quirk();
+		break;
 	}
 }
 
diff --git a/arch/x86/kernel/cpu/resctrl/internal.h b/arch/x86/kernel/cpu/resctrl/internal.h
index 80fa997..6cb068f 100644
--- a/arch/x86/kernel/cpu/resctrl/internal.h
+++ b/arch/x86/kernel/cpu/resctrl/internal.h
@@ -616,6 +616,7 @@ void mon_event_read(struct rmid_read *rr, struct rdt_resource *r,
 void mbm_setup_overflow_handler(struct rdt_domain *dom,
 				unsigned long delay_ms);
 void mbm_handle_overflow(struct work_struct *work);
+void __init intel_rdt_mbm_apply_quirk(void);
 bool is_mba_sc(struct rdt_resource *r);
 void setup_default_ctrlval(struct rdt_resource *r, u32 *dc, u32 *dm);
 u32 delay_bw_map(unsigned long bw, struct rdt_resource *r);
diff --git a/arch/x86/kernel/cpu/resctrl/monitor.c b/arch/x86/kernel/cpu/resctrl/monitor.c
index 54dffe5..622073f 100644
--- a/arch/x86/kernel/cpu/resctrl/monitor.c
+++ b/arch/x86/kernel/cpu/resctrl/monitor.c
@@ -64,6 +64,69 @@ unsigned int rdt_mon_features;
  */
 unsigned int resctrl_cqm_threshold;
 
+#define CF(cf)	((unsigned long)(1048576 * (cf) + 0.5))
+
+/*
+ * The correction factor table is documented in Documentation/x86/resctrl.rst.
+ * If rmid > rmid threshold, MBM total and local values should be multiplied
+ * by the correction factor.
+ *
+ * The original table is modified for better code:
+ *
+ * 1. The threshold 0 is changed to rmid count - 1 so don't do correction
+ *    for the case.
+ * 2. MBM total and local correction table indexed by core counter which is
+ *    equal to (x86_cache_max_rmid + 1) / 8 - 1 and is from 0 up to 27.
+ * 3. The correction factor is normalized to 2^20 (1048576) so it's faster
+ *    to calculate corrected value by shifting:
+ *    corrected_value = (original_value * correction_factor) >> 20
+ */
+static const struct mbm_correction_factor_table {
+	u32 rmidthreshold;
+	u64 cf;
+} mbm_cf_table[] __initdata = {
+	{7,	CF(1.000000)},
+	{15,	CF(1.000000)},
+	{15,	CF(0.969650)},
+	{31,	CF(1.000000)},
+	{31,	CF(1.066667)},
+	{31,	CF(0.969650)},
+	{47,	CF(1.142857)},
+	{63,	CF(1.000000)},
+	{63,	CF(1.185115)},
+	{63,	CF(1.066553)},
+	{79,	CF(1.454545)},
+	{95,	CF(1.000000)},
+	{95,	CF(1.230769)},
+	{95,	CF(1.142857)},
+	{95,	CF(1.066667)},
+	{127,	CF(1.000000)},
+	{127,	CF(1.254863)},
+	{127,	CF(1.185255)},
+	{151,	CF(1.000000)},
+	{127,	CF(1.066667)},
+	{167,	CF(1.000000)},
+	{159,	CF(1.454334)},
+	{183,	CF(1.000000)},
+	{127,	CF(0.969744)},
+	{191,	CF(1.280246)},
+	{191,	CF(1.230921)},
+	{215,	CF(1.000000)},
+	{191,	CF(1.143118)},
+};
+
+static u32 mbm_cf_rmidthreshold __read_mostly = UINT_MAX;
+static u64 mbm_cf __read_mostly;
+
+static inline u64 get_corrected_mbm_count(u32 rmid, unsigned long val)
+{
+	/* Correct MBM value. */
+	if (rmid > mbm_cf_rmidthreshold)
+		val = (val * mbm_cf) >> 20;
+
+	return val;
+}
+
 static inline struct rmid_entry *__rmid_entry(u32 rmid)
 {
 	struct rmid_entry *entry;
@@ -260,7 +323,8 @@ static int __mon_event_count(u32 rmid, struct rmid_read *rr)
 	m->chunks += chunks;
 	m->prev_msr = tval;
 
-	rr->val += m->chunks;
+	rr->val += get_corrected_mbm_count(rmid, m->chunks);
+
 	return 0;
 }
 
@@ -280,7 +344,7 @@ static void mbm_bw_count(u32 rmid, struct rmid_read *rr)
 
 	chunks = mbm_overflow_count(m->prev_bw_msr, tval, rr->r->mbm_width);
 	m->chunks += chunks;
-	cur_bw = (chunks * r->mon_scale) >> 20;
+	cur_bw = (get_corrected_mbm_count(rmid, chunks) * r->mon_scale) >> 20;
 
 	if (m->delta_comp)
 		m->delta_bw = abs(cur_bw - m->prev_bw);
@@ -644,3 +708,17 @@ int rdt_get_mon_l3_config(struct rdt_resource *r)
 
 	return 0;
 }
+
+void __init intel_rdt_mbm_apply_quirk(void)
+{
+	int cf_index;
+
+	cf_index = (boot_cpu_data.x86_cache_max_rmid + 1) / 8 - 1;
+	if (cf_index >= ARRAY_SIZE(mbm_cf_table)) {
+		pr_info("No MBM correction factor available\n");
+		return;
+	}
+
+	mbm_cf_rmidthreshold = mbm_cf_table[cf_index].rmidthreshold;
+	mbm_cf = mbm_cf_table[cf_index].cf;
+}
