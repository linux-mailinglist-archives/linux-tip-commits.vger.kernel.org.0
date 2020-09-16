Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3CAA026C394
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 16:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgIPOSg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 10:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgIPNcn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 09:32:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9468C014DA1;
        Wed, 16 Sep 2020 06:16:43 -0700 (PDT)
Date:   Wed, 16 Sep 2020 13:11:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600261879;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nEtD8RnQ7ym+xkai86OWicaRhtPBMHP7gde0ZIGcFvE=;
        b=T4owpgQc2BQvLiNMoQ4NiBMFFI4cdZPmhTTB91O8343O/y6BPcbYRV0Hk2UWT9uFq1ugOE
        wpUsQbsrvv0h/wnCTkO158GA/QES6DfWzBI6gljR+QVjASYLT/UbDK71LIoXckod7FU75X
        PesbBYh5rDE/5dF6KCtiB1MD/dTHS+e5VeD07RS/zpXVGWUlo0edMy7zkPwfZjl9wlFTmC
        u02r1oIwAkawo5xVEVUbKKqiIx4Qa/xMT1E4vBADwWiZphoSrhfsUNsqGNjyXuhZkAv0fC
        SZU/7G7yP4fDQzWadW+4wI3fXqqYCU9Xlc2oRXiZWX59RLhjCMMLI2fWiqtX1g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600261879;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nEtD8RnQ7ym+xkai86OWicaRhtPBMHP7gde0ZIGcFvE=;
        b=P7ACa/njV5j5hSrzk8JMynkC18zqgmTJ0bt0H9+NXnhm2GoH8JoE+6IKWcoPiBH5pVhJt2
        UFUvZcNBvmrw13CA==
From:   "tip-bot2 for Balbir Singh" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/pti] prctl: Hook L1D flushing in via prctl
Cc:     Balbir Singh <sblbir@amazon.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200729001103.6450-5-sblbir@amazon.com>
References: <20200729001103.6450-5-sblbir@amazon.com>
MIME-Version: 1.0
Message-ID: <160026187842.15536.285514864386042510.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/pti branch of tip:

Commit-ID:     b6724f118d44606fddde391ba7527526b3cad211
Gitweb:        https://git.kernel.org/tip/b6724f118d44606fddde391ba7527526b3cad211
Author:        Balbir Singh <sblbir@amazon.com>
AuthorDate:    Wed, 29 Jul 2020 10:11:02 +10:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 15:08:03 +02:00

prctl: Hook L1D flushing in via prctl

Use the existing PR_GET/SET_SPECULATION_CTRL API to expose the L1D
flush capability. For L1D flushing PR_SPEC_FORCE_DISABLE and
PR_SPEC_DISABLE_NOEXEC are not supported.

There is also no seccomp integration for the feature.

Signed-off-by: Balbir Singh <sblbir@amazon.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200729001103.6450-5-sblbir@amazon.com

---
 arch/x86/kernel/cpu/bugs.c | 54 +++++++++++++++++++++++++++++++++++++-
 arch/x86/mm/tlb.c          | 25 ++++++++++++++++-
 include/uapi/linux/prctl.h |  1 +-
 3 files changed, 79 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index d3f0db4..3923e48 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -296,6 +296,13 @@ enum taa_mitigations {
 	TAA_MITIGATION_TSX_DISABLED,
 };
 
+enum l1d_flush_out_mitigations {
+	L1D_FLUSH_OUT_OFF,
+	L1D_FLUSH_OUT_ON,
+};
+
+static enum l1d_flush_out_mitigations l1d_flush_out_mitigation __ro_after_init = L1D_FLUSH_OUT_ON;
+
 /* Default mitigation for TAA-affected CPUs */
 static enum taa_mitigations taa_mitigation __ro_after_init = TAA_MITIGATION_VERW;
 static bool taa_nosmt __ro_after_init;
@@ -379,6 +386,18 @@ out:
 	pr_info("%s\n", taa_strings[taa_mitigation]);
 }
 
+static int __init l1d_flush_out_parse_cmdline(char *str)
+{
+	if (!boot_cpu_has_bug(X86_BUG_L1TF))
+		return 0;
+
+	if (!strcmp(str, "off"))
+		l1d_flush_out_mitigation = L1D_FLUSH_OUT_OFF;
+
+	return 0;
+}
+early_param("l1d_flush_out", l1d_flush_out_parse_cmdline);
+
 static int __init tsx_async_abort_parse_cmdline(char *str)
 {
 	if (!boot_cpu_has_bug(X86_BUG_TAA))
@@ -1215,6 +1234,23 @@ static void task_update_spec_tif(struct task_struct *tsk)
 		speculation_ctrl_update_current();
 }
 
+static int l1d_flush_out_prctl_set(struct task_struct *task, unsigned long ctrl)
+{
+
+	if (l1d_flush_out_mitigation == L1D_FLUSH_OUT_OFF)
+		return -EPERM;
+
+	switch (ctrl) {
+	case PR_SPEC_ENABLE:
+		return enable_l1d_flush_for_task(task);
+	case PR_SPEC_DISABLE:
+		return disable_l1d_flush_for_task(task);
+	default:
+		return -ERANGE;
+	}
+	return 0;
+}
+
 static int ssb_prctl_set(struct task_struct *task, unsigned long ctrl)
 {
 	if (ssb_mode != SPEC_STORE_BYPASS_PRCTL &&
@@ -1306,6 +1342,8 @@ int arch_prctl_spec_ctrl_set(struct task_struct *task, unsigned long which,
 		return ssb_prctl_set(task, ctrl);
 	case PR_SPEC_INDIRECT_BRANCH:
 		return ib_prctl_set(task, ctrl);
+	case PR_SPEC_L1D_FLUSH_OUT:
+		return l1d_flush_out_prctl_set(task, ctrl);
 	default:
 		return -ENODEV;
 	}
@@ -1322,6 +1360,20 @@ void arch_seccomp_spec_mitigate(struct task_struct *task)
 }
 #endif
 
+static int l1d_flush_out_prctl_get(struct task_struct *task)
+{
+	int ret;
+
+	if (l1d_flush_out_mitigation == L1D_FLUSH_OUT_OFF)
+		return PR_SPEC_FORCE_DISABLE;
+
+	ret = test_ti_thread_flag(&task->thread_info, TIF_SPEC_L1D_FLUSH);
+	if (ret)
+		return PR_SPEC_PRCTL | PR_SPEC_ENABLE;
+	else
+		return PR_SPEC_PRCTL | PR_SPEC_DISABLE;
+}
+
 static int ssb_prctl_get(struct task_struct *task)
 {
 	switch (ssb_mode) {
@@ -1375,6 +1427,8 @@ int arch_prctl_spec_ctrl_get(struct task_struct *task, unsigned long which)
 		return ssb_prctl_get(task);
 	case PR_SPEC_INDIRECT_BRANCH:
 		return ib_prctl_get(task);
+	case PR_SPEC_L1D_FLUSH_OUT:
+		return l1d_flush_out_prctl_get(task);
 	default:
 		return -ENODEV;
 	}
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 6369a54..6b0f4c8 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -316,8 +316,31 @@ EXPORT_SYMBOL_GPL(leave_mm);
 
 int enable_l1d_flush_for_task(struct task_struct *tsk)
 {
+	int cpu, ret = 0, i;
+
+	/*
+	 * Do not enable L1D_FLUSH_OUT if
+	 * b. The CPU is not affected by the L1TF bug
+	 * c. The CPU does not have L1D FLUSH feature support
+	 * c. The task's affinity is on cores with SMT on.
+	 */
+
+	if (!boot_cpu_has_bug(X86_BUG_L1TF) ||
+			!static_cpu_has(X86_FEATURE_FLUSH_L1D))
+		return -EINVAL;
+
+	cpu = get_cpu();
+
+	for_each_cpu(i, &tsk->cpus_mask) {
+		if (cpu_data(i).smt_active == true) {
+			put_cpu();
+			return -EINVAL;
+		}
+	}
+
 	set_ti_thread_flag(&tsk->thread_info, TIF_SPEC_L1D_FLUSH);
-	return 0;
+	put_cpu();
+	return ret;
 }
 
 int disable_l1d_flush_for_task(struct task_struct *tsk)
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 07b4f81..1e86486 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -213,6 +213,7 @@ struct prctl_mm_map {
 /* Speculation control variants */
 # define PR_SPEC_STORE_BYPASS		0
 # define PR_SPEC_INDIRECT_BRANCH	1
+# define PR_SPEC_L1D_FLUSH_OUT		2
 /* Return and control values for PR_SET/GET_SPECULATION_CTRL */
 # define PR_SPEC_NOT_AFFECTED		0
 # define PR_SPEC_PRCTL			(1UL << 0)
