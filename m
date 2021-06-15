Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5603A8745
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Jun 2021 19:14:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229494AbhFORQo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 15 Jun 2021 13:16:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbhFORQn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 15 Jun 2021 13:16:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34070C061574;
        Tue, 15 Jun 2021 10:14:39 -0700 (PDT)
Date:   Tue, 15 Jun 2021 17:14:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623777277;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mDR/YGyAZgSimPNRrDfBvwxLec5wq0fM6NlpkMaq+nk=;
        b=0NGt/tJVPZGwB7GrcDDrBfYcqQEhjew8TS32WcHCz62w/g80gVN36dD2sMPFcmQ9sjrhZV
        TOCcTIuOu6418PeAZJUootL+YH66eaHJc+l2KUPP97B4dcIgs3Pl1otmML4Svlpf6ufgG5
        fQTA3QWhstxJV60QXmZddhunooFYStRyYd68z0wNTXsL4LaNcOvQJgAjqT5gtdC538awSx
        rCGkIjghzVJjkzmy6GxLxsn+A4v5HfV18pTwzEpc9+Nnj8LUTiXR+gVmumXApyjv2GCG1w
        +E80slQY+v755TP62wh2fg0ayeKcLFA2AJr5iIFryda3ZHDJeSORcDX7UIJC3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623777277;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mDR/YGyAZgSimPNRrDfBvwxLec5wq0fM6NlpkMaq+nk=;
        b=7bXHTWaSMbMr/fP8Ozdm8O4TAkJ8cMmFqoi4m/LIC/wkf00nZFKQZ8LjpAsvojQviXlPIR
        XnmGiYlm4Pk24uBA==
From:   "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/tsx: Clear CPUID bits when TSX always force aborts
Cc:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Borislav Petkov <bp@suse.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andi Kleen <ak@linux.intel.com>,
        Tony Luck <tony.luck@intel.com>,
        Neelima Krishnan <neelima.krishnan@intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C5209b3d72ffe5bd3cafdcc803f5b883f785329c3=2E16237?=
 =?utf-8?q?04845=2Egit-series=2Epawan=2Ekumar=2Egupta=40linux=2Eintel=2Eco?=
 =?utf-8?q?m=3E?=
References: =?utf-8?q?=3C5209b3d72ffe5bd3cafdcc803f5b883f785329c3=2E162370?=
 =?utf-8?q?4845=2Egit-series=2Epawan=2Ekumar=2Egupta=40linux=2Eintel=2Ecom?=
 =?utf-8?q?=3E?=
MIME-Version: 1.0
Message-ID: <162377727623.19906.1364963884098563436.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     293649307ef9abcd4f83f6dac4d4400dfd97c936
Gitweb:        https://git.kernel.org/tip/293649307ef9abcd4f83f6dac4d4400dfd97c936
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Mon, 14 Jun 2021 14:14:25 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 15 Jun 2021 17:46:48 +02:00

x86/tsx: Clear CPUID bits when TSX always force aborts

As a result of TSX deprecation, some processors always abort TSX
transactions by default after a microcode update.

When TSX feature cannot be used it is better to hide it. Clear CPUID.RTM
and CPUID.HLE bits when TSX transactions always abort.

 [ bp: Massage commit message and comments. ]

Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Tested-by: Neelima Krishnan <neelima.krishnan@intel.com>
Link: https://lkml.kernel.org/r/5209b3d72ffe5bd3cafdcc803f5b883f785329c3.1623704845.git-series.pawan.kumar.gupta@linux.intel.com
---
 arch/x86/kernel/cpu/cpu.h   |  2 ++-
 arch/x86/kernel/cpu/intel.c |  4 +++-
 arch/x86/kernel/cpu/tsx.c   | 37 ++++++++++++++++++++++++++++++++++--
 3 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kernel/cpu/cpu.h b/arch/x86/kernel/cpu/cpu.h
index 6794412..9552130 100644
--- a/arch/x86/kernel/cpu/cpu.h
+++ b/arch/x86/kernel/cpu/cpu.h
@@ -48,6 +48,7 @@ extern const struct cpu_dev *const __x86_cpu_dev_start[],
 enum tsx_ctrl_states {
 	TSX_CTRL_ENABLE,
 	TSX_CTRL_DISABLE,
+	TSX_CTRL_RTM_ALWAYS_ABORT,
 	TSX_CTRL_NOT_SUPPORTED,
 };
 
@@ -56,6 +57,7 @@ extern __ro_after_init enum tsx_ctrl_states tsx_ctrl_state;
 extern void __init tsx_init(void);
 extern void tsx_enable(void);
 extern void tsx_disable(void);
+extern void tsx_clear_cpuid(void);
 #else
 static inline void tsx_init(void) { }
 #endif /* CONFIG_CPU_SUP_INTEL */
diff --git a/arch/x86/kernel/cpu/intel.c b/arch/x86/kernel/cpu/intel.c
index 8adffc1..861e919 100644
--- a/arch/x86/kernel/cpu/intel.c
+++ b/arch/x86/kernel/cpu/intel.c
@@ -717,8 +717,10 @@ static void init_intel(struct cpuinfo_x86 *c)
 
 	if (tsx_ctrl_state == TSX_CTRL_ENABLE)
 		tsx_enable();
-	if (tsx_ctrl_state == TSX_CTRL_DISABLE)
+	else if (tsx_ctrl_state == TSX_CTRL_DISABLE)
 		tsx_disable();
+	else if (tsx_ctrl_state == TSX_CTRL_RTM_ALWAYS_ABORT)
+		tsx_clear_cpuid();
 
 	split_lock_init();
 	bus_lock_init();
diff --git a/arch/x86/kernel/cpu/tsx.c b/arch/x86/kernel/cpu/tsx.c
index e2ad30e..9c7a5f0 100644
--- a/arch/x86/kernel/cpu/tsx.c
+++ b/arch/x86/kernel/cpu/tsx.c
@@ -2,7 +2,7 @@
 /*
  * Intel Transactional Synchronization Extensions (TSX) control.
  *
- * Copyright (C) 2019 Intel Corporation
+ * Copyright (C) 2019-2021 Intel Corporation
  *
  * Author:
  *	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
@@ -84,13 +84,46 @@ static enum tsx_ctrl_states x86_get_tsx_auto_mode(void)
 	return TSX_CTRL_ENABLE;
 }
 
+void tsx_clear_cpuid(void)
+{
+	u64 msr;
+
+	/*
+	 * MSR_TFA_TSX_CPUID_CLEAR bit is only present when both CPUID
+	 * bits RTM_ALWAYS_ABORT and TSX_FORCE_ABORT are present.
+	 */
+	if (boot_cpu_has(X86_FEATURE_RTM_ALWAYS_ABORT) &&
+	    boot_cpu_has(X86_FEATURE_TSX_FORCE_ABORT)) {
+		rdmsrl(MSR_TSX_FORCE_ABORT, msr);
+		msr |= MSR_TFA_TSX_CPUID_CLEAR;
+		wrmsrl(MSR_TSX_FORCE_ABORT, msr);
+	}
+}
+
 void __init tsx_init(void)
 {
 	char arg[5] = {};
 	int ret;
 
-	if (!tsx_ctrl_is_supported())
+	/*
+	 * Hardware will always abort a TSX transaction if both CPUID bits
+	 * RTM_ALWAYS_ABORT and TSX_FORCE_ABORT are set. In this case, it is
+	 * better not to enumerate CPUID.RTM and CPUID.HLE bits. Clear them
+	 * here.
+	 */
+	if (boot_cpu_has(X86_FEATURE_RTM_ALWAYS_ABORT) &&
+	    boot_cpu_has(X86_FEATURE_TSX_FORCE_ABORT)) {
+		tsx_ctrl_state = TSX_CTRL_RTM_ALWAYS_ABORT;
+		tsx_clear_cpuid();
+		setup_clear_cpu_cap(X86_FEATURE_RTM);
+		setup_clear_cpu_cap(X86_FEATURE_HLE);
 		return;
+	}
+
+	if (!tsx_ctrl_is_supported()) {
+		tsx_ctrl_state = TSX_CTRL_NOT_SUPPORTED;
+		return;
+	}
 
 	ret = cmdline_find_option(boot_command_line, "tsx", arg, sizeof(arg));
 	if (ret >= 0) {
