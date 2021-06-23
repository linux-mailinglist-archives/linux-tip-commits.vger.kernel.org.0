Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD9D33B2317
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbhFWWMJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:12:09 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39982 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230343AbhFWWLb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:31 -0400
Date:   Wed, 23 Jun 2021 22:09:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486152;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tnbwr4EZxxnzm/qeNPIHve7Qd79UYRIPAE3aSTO7nZY=;
        b=Kw2jkqc6q5ehRHzkiD3dY78R019gLtT6TDsTDGZXamH1FHNCQlKCrVxkG1nyL2MZiUVo18
        2fRxje1hgopWOA02CE9RnrDrH6nsS2WPKKB7+BsWX+hZF6ZpVokK6lhwRP+FrZMgbpnypI
        QpHY5x36+W1qFqeqTMmmYQdlhQ+3J4xdE5U5bKAxfnVb9+eDNXnR84bWR2tX32T6saLk60
        +7Gk/FwyHuzqxYHl0Ihvh/oxRDlDsm/ztigm0ruo0gC7GuJDwDoMGxgsj+oxv5c8nItj5a
        7Q6prFM2Cf73LHa9OHRW0drXiUiO7sKKEy6L6JAR6Y73PJuR1pq2JOB8spXR9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486152;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Tnbwr4EZxxnzm/qeNPIHve7Qd79UYRIPAE3aSTO7nZY=;
        b=HbXTl+NCEHtmLPRcsHMaqkCy+ls2d3Hcgh995Ze2l8Lh9SRg6Jm442eiCC00/CRfUgkOYT
        yZ8/9qFyYEoKgaCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/cpu: Sanitize X86_FEATURE_OSPKE
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121455.305113644@linutronix.de>
References: <20210623121455.305113644@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448615150.395.5774669821882939729.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     8a1dc55a3f3ef0a723c3c117a567e7b5dd2c1793
Gitweb:        https://git.kernel.org/tip/8a1dc55a3f3ef0a723c3c117a567e7b5dd2c1793
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:02:07 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 18:59:44 +02:00

x86/cpu: Sanitize X86_FEATURE_OSPKE

X86_FEATURE_OSPKE is enabled first on the boot CPU and the feature flag is
set. Secondary CPUs have to enable CR4.PKE as well and set their per CPU
feature flag. That's ineffective because all call sites have checks for
boot_cpu_data.

Make it smarter and force the feature flag when PKU is enabled on the boot
cpu which allows then to use cpu_feature_enabled(X86_FEATURE_OSPKE) all
over the place. That either compiles the code out when PKEY support is
disabled in Kconfig or uses a static_cpu_has() for the feature check which
makes a significant difference in hotpaths, e.g. context switch.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121455.305113644@linutronix.de
---
 arch/x86/include/asm/pkeys.h |  8 ++++----
 arch/x86/include/asm/pkru.h  |  4 ++--
 arch/x86/kernel/cpu/common.c | 24 +++++++++++-------------
 arch/x86/kernel/fpu/core.c   |  2 +-
 arch/x86/kernel/fpu/xstate.c |  2 +-
 arch/x86/kernel/process_64.c |  2 +-
 arch/x86/mm/fault.c          |  2 +-
 7 files changed, 21 insertions(+), 23 deletions(-)

diff --git a/arch/x86/include/asm/pkeys.h b/arch/x86/include/asm/pkeys.h
index 2ff9b98..4128f64 100644
--- a/arch/x86/include/asm/pkeys.h
+++ b/arch/x86/include/asm/pkeys.h
@@ -9,14 +9,14 @@
  * will be necessary to ensure that the types that store key
  * numbers and masks have sufficient capacity.
  */
-#define arch_max_pkey() (boot_cpu_has(X86_FEATURE_OSPKE) ? 16 : 1)
+#define arch_max_pkey() (cpu_feature_enabled(X86_FEATURE_OSPKE) ? 16 : 1)
 
 extern int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 		unsigned long init_val);
 
 static inline bool arch_pkeys_enabled(void)
 {
-	return boot_cpu_has(X86_FEATURE_OSPKE);
+	return cpu_feature_enabled(X86_FEATURE_OSPKE);
 }
 
 /*
@@ -26,7 +26,7 @@ static inline bool arch_pkeys_enabled(void)
 extern int __execute_only_pkey(struct mm_struct *mm);
 static inline int execute_only_pkey(struct mm_struct *mm)
 {
-	if (!boot_cpu_has(X86_FEATURE_OSPKE))
+	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
 		return ARCH_DEFAULT_PKEY;
 
 	return __execute_only_pkey(mm);
@@ -37,7 +37,7 @@ extern int __arch_override_mprotect_pkey(struct vm_area_struct *vma,
 static inline int arch_override_mprotect_pkey(struct vm_area_struct *vma,
 		int prot, int pkey)
 {
-	if (!boot_cpu_has(X86_FEATURE_OSPKE))
+	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
 		return 0;
 
 	return __arch_override_mprotect_pkey(vma, prot, pkey);
diff --git a/arch/x86/include/asm/pkru.h b/arch/x86/include/asm/pkru.h
index 35ffcfd..ec8dd28 100644
--- a/arch/x86/include/asm/pkru.h
+++ b/arch/x86/include/asm/pkru.h
@@ -32,7 +32,7 @@ static inline bool __pkru_allows_write(u32 pkru, u16 pkey)
 
 static inline u32 read_pkru(void)
 {
-	if (boot_cpu_has(X86_FEATURE_OSPKE))
+	if (cpu_feature_enabled(X86_FEATURE_OSPKE))
 		return rdpkru();
 	return 0;
 }
@@ -41,7 +41,7 @@ static inline void write_pkru(u32 pkru)
 {
 	struct pkru_state *pk;
 
-	if (!boot_cpu_has(X86_FEATURE_OSPKE))
+	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
 		return;
 
 	pk = get_xsave_addr(&current->thread.fpu.state.xsave, XFEATURE_PKRU);
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index f875dea..dbfb335 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -466,22 +466,20 @@ static bool pku_disabled;
 
 static __always_inline void setup_pku(struct cpuinfo_x86 *c)
 {
-	/* check the boot processor, plus compile options for PKU: */
-	if (!cpu_feature_enabled(X86_FEATURE_PKU))
-		return;
-	/* checks the actual processor's cpuid bits: */
-	if (!cpu_has(c, X86_FEATURE_PKU))
-		return;
-	if (pku_disabled)
+	if (c == &boot_cpu_data) {
+		if (pku_disabled || !cpu_feature_enabled(X86_FEATURE_PKU))
+			return;
+		/*
+		 * Setting CR4.PKE will cause the X86_FEATURE_OSPKE cpuid
+		 * bit to be set.  Enforce it.
+		 */
+		setup_force_cpu_cap(X86_FEATURE_OSPKE);
+
+	} else if (!cpu_feature_enabled(X86_FEATURE_OSPKE)) {
 		return;
+	}
 
 	cr4_set_bits(X86_CR4_PKE);
-	/*
-	 * Setting X86_CR4_PKE will cause the X86_FEATURE_OSPKE
-	 * cpuid bit to be set.  We need to ensure that we
-	 * update that bit in this CPU's "cpu_info".
-	 */
-	set_cpu_cap(c, X86_FEATURE_OSPKE);
 }
 
 #ifdef CONFIG_X86_INTEL_MEMORY_PROTECTION_KEYS
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 8762b1a..3866954 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -311,7 +311,7 @@ static inline void restore_fpregs_from_init_fpstate(u64 features_mask)
 	else
 		frstor(&init_fpstate.fsave);
 
-	if (boot_cpu_has(X86_FEATURE_OSPKE))
+	if (cpu_feature_enabled(X86_FEATURE_OSPKE))
 		copy_init_pkru_to_fpregs();
 }
 
diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
index 735d44c..bc71609 100644
--- a/arch/x86/kernel/fpu/xstate.c
+++ b/arch/x86/kernel/fpu/xstate.c
@@ -921,7 +921,7 @@ int arch_set_user_pkey_access(struct task_struct *tsk, int pkey,
 	 * This check implies XSAVE support.  OSPKE only gets
 	 * set if we enable XSAVE and we enable PKU in XCR0.
 	 */
-	if (!boot_cpu_has(X86_FEATURE_OSPKE))
+	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
 		return -EINVAL;
 
 	/*
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 4651ab0..40a9638 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -137,7 +137,7 @@ void __show_regs(struct pt_regs *regs, enum show_regs_mode mode,
 		       log_lvl, d3, d6, d7);
 	}
 
-	if (boot_cpu_has(X86_FEATURE_OSPKE))
+	if (cpu_feature_enabled(X86_FEATURE_OSPKE))
 		printk("%sPKRU: %08x\n", log_lvl, read_pkru());
 }
 
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index 6bda7f6..f33a61a 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -875,7 +875,7 @@ static inline bool bad_area_access_from_pkeys(unsigned long error_code,
 	/* This code is always called on the current mm */
 	bool foreign = false;
 
-	if (!boot_cpu_has(X86_FEATURE_OSPKE))
+	if (!cpu_feature_enabled(X86_FEATURE_OSPKE))
 		return false;
 	if (error_code & X86_PF_PK)
 		return true;
