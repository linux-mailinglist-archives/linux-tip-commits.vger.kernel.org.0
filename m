Return-Path: <linux-tip-commits+bounces-276-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 852C18449A0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 31 Jan 2024 22:16:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3BAC1286343
	for <lists+linux-tip-commits@lfdr.de>; Wed, 31 Jan 2024 21:16:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CDFE3A8D6;
	Wed, 31 Jan 2024 21:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gVUPDCas";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LrEThPwd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 445933A1A2;
	Wed, 31 Jan 2024 21:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706735689; cv=none; b=dt6GfnDHSokx+S6w9B5xWZ6oMjquW+5UxXsCJ1kYpGOY6hPkfYmgaI/8blHi5lA/yQynYciN6mLwJ6YbGSq70IbZ4/OuxyTwWiKgsBgLAYrBUT8woiuTAy95QCKU5+adeKDB7HmXLZO5ddGNkyUASc1P8Ece7QOb0LI9TnUEQhQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706735689; c=relaxed/simple;
	bh=mJaD8GaC0mUp6hp0wRV4c/oymSLAcj9ZxKnTKlbCM+w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lFpULIbD4XcFY4OABbso+Ng9eLt6RoIbkllEKBjDw/JW54Tz0S+3xg1C3Dr9bvBwjIKQUJ4+egBYxD12LW8F42jDY4B68iIP92j98hL4cCbAF7uV+NLbjOQPLuBR9ImAggdH82mrAJEGdgNIqk/P8vJndidXYWja0/EatP/vjks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gVUPDCas; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LrEThPwd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 31 Jan 2024 21:14:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1706735684;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONi4kjY46QpGYpRJoftC+0cCLeu/QLH9GHpGOpeZwis=;
	b=gVUPDCasrbR3A8t5vHKnEqlznJe1kpDWntoRs2j993yHgvLYtA0JEMpq1IbK6X1+qIXsTJ
	Ocv7PcrD7br0NUgujRbuIUpZb6v/9GrmIrDpoLNSaFMOfXYunRRQLrbI/I9SPzRq5aBxu8
	EZDbZ4HAOmWAeeE4g/8nK7wmBc9GeBM76igdXCYNgkT2ColYN6+VV0ZjGzOqnHI+N+i7zw
	d+d+WmLGn/SoiFr4cZ3VD5uXAeRAhsD9YVczfSZRIoU5/W/XDnk14kW1Q1bmpaD6XxdhSX
	BkUj08ehOrlow1/AcbMluOrCqgewW9xNDfKoDZyxa+jq+agHNHKrPIJXZZFPaA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1706735684;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ONi4kjY46QpGYpRJoftC+0cCLeu/QLH9GHpGOpeZwis=;
	b=LrEThPwdNpw6ItjQAZLvcUi8owylJquY4OYq6CO2/Y23S1SoFN2LUofnx1LOA3T0Dg3x+O
	Qhaco7x5FBAQ/wCg==
From: "tip-bot2 for Xin Li" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fred] x86/traps: Add sysvec_install() to install a system
 interrupt handler
Cc: Xin Li <xin3.li@intel.com>, Thomas Gleixner <tglx@linutronix.de>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Shan Kang <shan.kang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20231205105030.8698-28-xin3.li@intel.com>
References: <20231205105030.8698-28-xin3.li@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170673568387.398.1207259428456555073.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/fred branch of tip:

Commit-ID:     8f4a29b0e8a40d865040800684d7ff4141c1394f
Gitweb:        https://git.kernel.org/tip/8f4a29b0e8a40d865040800684d7ff4141c1394f
Author:        Xin Li <xin3.li@intel.com>
AuthorDate:    Tue, 05 Dec 2023 02:50:16 -08:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 31 Jan 2024 22:02:36 +01:00

x86/traps: Add sysvec_install() to install a system interrupt handler

Add sysvec_install() to install a system interrupt handler into the IDT
or the FRED system interrupt handler table.

Signed-off-by: Xin Li <xin3.li@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Shan Kang <shan.kang@intel.com>
Link: https://lore.kernel.org/r/20231205105030.8698-28-xin3.li@intel.com
---
 arch/x86/entry/entry_fred.c      | 14 ++++++++++++++
 arch/x86/include/asm/desc.h      |  2 --
 arch/x86/include/asm/idtentry.h  | 15 +++++++++++++++
 arch/x86/kernel/cpu/acrn.c       |  4 ++--
 arch/x86/kernel/cpu/mshyperv.c   | 15 +++++++--------
 arch/x86/kernel/idt.c            |  4 ++--
 arch/x86/kernel/kvm.c            |  2 +-
 drivers/xen/events/events_base.c |  2 +-
 8 files changed, 42 insertions(+), 16 deletions(-)

diff --git a/arch/x86/entry/entry_fred.c b/arch/x86/entry/entry_fred.c
index 125b623..3be0269 100644
--- a/arch/x86/entry/entry_fred.c
+++ b/arch/x86/entry/entry_fred.c
@@ -119,6 +119,20 @@ static idtentry_t sysvec_table[NR_SYSTEM_VECTORS] __ro_after_init = {
 	SYSVEC(POSTED_INTR_NESTED_VECTOR,	kvm_posted_intr_nested_ipi),
 };
 
+static bool fred_setup_done __initdata;
+
+void __init fred_install_sysvec(unsigned int sysvec, idtentry_t handler)
+{
+	if (WARN_ON_ONCE(sysvec < FIRST_SYSTEM_VECTOR))
+		return;
+
+	if (WARN_ON_ONCE(fred_setup_done))
+		return;
+
+	if (!WARN_ON_ONCE(sysvec_table[sysvec - FIRST_SYSTEM_VECTOR]))
+		 sysvec_table[sysvec - FIRST_SYSTEM_VECTOR] = handler;
+}
+
 static noinstr void fred_extint(struct pt_regs *regs)
 {
 	unsigned int vector = regs->fred_ss.vector;
diff --git a/arch/x86/include/asm/desc.h b/arch/x86/include/asm/desc.h
index ab97b22..ec95fe4 100644
--- a/arch/x86/include/asm/desc.h
+++ b/arch/x86/include/asm/desc.h
@@ -402,8 +402,6 @@ static inline void set_desc_limit(struct desc_struct *desc, unsigned long limit)
 	desc->limit1 = (limit >> 16) & 0xf;
 }
 
-void alloc_intr_gate(unsigned int n, const void *addr);
-
 static inline void init_idt_data(struct idt_data *data, unsigned int n,
 				 const void *addr)
 {
diff --git a/arch/x86/include/asm/idtentry.h b/arch/x86/include/asm/idtentry.h
index 570f286..47d4c04 100644
--- a/arch/x86/include/asm/idtentry.h
+++ b/arch/x86/include/asm/idtentry.h
@@ -459,6 +459,21 @@ __visible noinstr void func(struct pt_regs *regs,			\
 #define DEFINE_FREDENTRY_DEBUG		DEFINE_FREDENTRY_RAW
 #endif
 
+void idt_install_sysvec(unsigned int n, const void *function);
+
+#ifdef CONFIG_X86_FRED
+void fred_install_sysvec(unsigned int vector, const idtentry_t function);
+#else
+static inline void fred_install_sysvec(unsigned int vector, const idtentry_t function) { }
+#endif
+
+#define sysvec_install(vector, function) {				\
+	if (cpu_feature_enabled(X86_FEATURE_FRED))			\
+		fred_install_sysvec(vector, function);			\
+	else								\
+		idt_install_sysvec(vector, asm_##function);		\
+}
+
 #else /* !__ASSEMBLY__ */
 
 /*
diff --git a/arch/x86/kernel/cpu/acrn.c b/arch/x86/kernel/cpu/acrn.c
index bfeb18f..2c5b51a 100644
--- a/arch/x86/kernel/cpu/acrn.c
+++ b/arch/x86/kernel/cpu/acrn.c
@@ -26,8 +26,8 @@ static u32 __init acrn_detect(void)
 
 static void __init acrn_init_platform(void)
 {
-	/* Setup the IDT for ACRN hypervisor callback */
-	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, asm_sysvec_acrn_hv_callback);
+	/* Install system interrupt handler for ACRN hypervisor callback */
+	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_acrn_hv_callback);
 
 	x86_platform.calibrate_tsc = acrn_get_tsc_khz;
 	x86_platform.calibrate_cpu = acrn_get_tsc_khz;
diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
index 01fa06d..45e0e70 100644
--- a/arch/x86/kernel/cpu/mshyperv.c
+++ b/arch/x86/kernel/cpu/mshyperv.c
@@ -539,19 +539,18 @@ static void __init ms_hyperv_init_platform(void)
 	 */
 	x86_platform.apic_post_init = hyperv_init;
 	hyperv_setup_mmu_ops();
-	/* Setup the IDT for hypervisor callback */
-	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, asm_sysvec_hyperv_callback);
 
-	/* Setup the IDT for reenlightenment notifications */
+	/* Install system interrupt handler for hypervisor callback */
+	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_hyperv_callback);
+
+	/* Install system interrupt handler for reenlightenment notifications */
 	if (ms_hyperv.features & HV_ACCESS_REENLIGHTENMENT) {
-		alloc_intr_gate(HYPERV_REENLIGHTENMENT_VECTOR,
-				asm_sysvec_hyperv_reenlightenment);
+		sysvec_install(HYPERV_REENLIGHTENMENT_VECTOR, sysvec_hyperv_reenlightenment);
 	}
 
-	/* Setup the IDT for stimer0 */
+	/* Install system interrupt handler for stimer0 */
 	if (ms_hyperv.misc_features & HV_STIMER_DIRECT_MODE_AVAILABLE) {
-		alloc_intr_gate(HYPERV_STIMER0_VECTOR,
-				asm_sysvec_hyperv_stimer0);
+		sysvec_install(HYPERV_STIMER0_VECTOR, sysvec_hyperv_stimer0);
 	}
 
 # ifdef CONFIG_SMP
diff --git a/arch/x86/kernel/idt.c b/arch/x86/kernel/idt.c
index 660b601..0cd53fa 100644
--- a/arch/x86/kernel/idt.c
+++ b/arch/x86/kernel/idt.c
@@ -337,7 +337,7 @@ void idt_invalidate(void)
 	load_idt(&idt);
 }
 
-void __init alloc_intr_gate(unsigned int n, const void *addr)
+void __init idt_install_sysvec(unsigned int n, const void *function)
 {
 	if (WARN_ON(n < FIRST_SYSTEM_VECTOR))
 		return;
@@ -346,5 +346,5 @@ void __init alloc_intr_gate(unsigned int n, const void *addr)
 		return;
 
 	if (!WARN_ON(test_and_set_bit(n, system_vectors)))
-		set_intr_gate(n, addr);
+		set_intr_gate(n, function);
 }
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index dfe9945..b055579 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -829,7 +829,7 @@ static void __init kvm_guest_init(void)
 
 	if (kvm_para_has_feature(KVM_FEATURE_ASYNC_PF_INT) && kvmapf) {
 		static_branch_enable(&kvm_async_pf_enabled);
-		alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, asm_sysvec_kvm_asyncpf_interrupt);
+		sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_kvm_asyncpf_interrupt);
 	}
 
 #ifdef CONFIG_SMP
diff --git a/drivers/xen/events/events_base.c b/drivers/xen/events/events_base.c
index b8cfea7..e2813ba 100644
--- a/drivers/xen/events/events_base.c
+++ b/drivers/xen/events/events_base.c
@@ -2216,7 +2216,7 @@ static __init void xen_alloc_callback_vector(void)
 		return;
 
 	pr_info("Xen HVM callback vector for event delivery is enabled\n");
-	alloc_intr_gate(HYPERVISOR_CALLBACK_VECTOR, asm_sysvec_xen_hvm_callback);
+	sysvec_install(HYPERVISOR_CALLBACK_VECTOR, sysvec_xen_hvm_callback);
 }
 #else
 void xen_setup_callback_vector(void) {}

