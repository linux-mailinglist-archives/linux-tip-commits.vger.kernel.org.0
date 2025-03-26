Return-Path: <linux-tip-commits+bounces-4560-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ECEC2A711F5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Mar 2025 09:03:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B1BFD7A333C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Mar 2025 08:02:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15EB61A23AD;
	Wed, 26 Mar 2025 08:02:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZO1/qOFx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+NkWtUwz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E56B31A08DF;
	Wed, 26 Mar 2025 08:02:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742976177; cv=none; b=fEC6p2bgK+O/GU1FYHHFrFGy0yiBdAzp97Vg5cZ5GiV+LAZyxVFpPTOfhOPERtsiT3J3LxnGikJucG/n8Fgs3I1Ty8DfHAT3G7Ol9zBXBOFNSl8Kgy59nVsclZ6Fpns+2bpT6KBVy5yY/hjwy9FrSZXEgzga6jqZb6SyszWOUj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742976177; c=relaxed/simple;
	bh=aAnFnWA8MenkteD0UmIx0UcUn6Sw+DnK8WdDibn9DCc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=oKSt1pQEilp6Ji7Drpf++2BqxKYR4FetCGfSaVQZ7FKZJ5b8oqUIMCIJ3V3X1QvhePoEQWeeutmfSLXtAicz1finXF1A9CikWZt/bqFA6GkO/hDFfY//0Ee0rxyJAy2O6FmE0UVTTVeO6235M37JDHZrxYCqpMbPgaLauUC9/Vw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZO1/qOFx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+NkWtUwz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Mar 2025 08:02:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742976172;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A5GBnbF1Q4jrpSWPg4qZPotsfZgmgs3P7n5+238+n9o=;
	b=ZO1/qOFxEBjXthXylu32w+D9gd/Xv3PnAjv+ckf5kzQk25238wVK6v2zQoPB6jqOMAWVfp
	SNCCijVEcP3IVdWhq0SipgWRUd5NhJfQL3F/SmtJQvu3x3kYGDt0PQT2B4Mp9HPMunIIk6
	LgcDnEftmoeYPCzf0zCCh+KSfcwwav9BtEo1OFljgyQu/OYBZGWWKc3DChb1eoKzSmNTF6
	5mWadh+BWKpEUcZcU7S5Qo0oofVdISTN8JFiKjiXyUyT8TcLgV5bR/usA5c2hKIBveHlQr
	WCOpTNQlGWo/SPQt7EwjqJnTdu72n99m2HNhIixYCdgkwrOl4bOtW6ITH2Os5Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742976172;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=A5GBnbF1Q4jrpSWPg4qZPotsfZgmgs3P7n5+238+n9o=;
	b=+NkWtUwzvDerp4zzrfvIRKSYxxIN3maoqd3a60U5Btft3lawB3Sfk0mur7fFCZe3u+PlE1
	jyW4il9US32C1LCw==
From: "tip-bot2 for Kirill A. Shutemov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/tdx] x86/paravirt: Move halt paravirt calls under CONFIG_PARAVIRT
Cc: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>,
 Vishal Annapurve <vannapurve@google.com>, Ingo Molnar <mingo@kernel.org>,
 Andi Kleen <ak@linux.intel.com>, Tony Luck <tony.luck@intel.com>,
 Juergen Gross <jgross@suse.com>, Ryan Afranji <afranji@google.com>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, stable@kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250228014416.3925664-2-vannapurve@google.com>
References: <20250228014416.3925664-2-vannapurve@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174297617142.14745.9015165434643967922.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/tdx branch of tip:

Commit-ID:     22cc5ca5de52bbfc36a7d4a55323f91fb4492264
Gitweb:        https://git.kernel.org/tip/22cc5ca5de52bbfc36a7d4a55323f91fb4492264
Author:        Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
AuthorDate:    Fri, 28 Feb 2025 01:44:14 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 26 Mar 2025 08:48:18 +01:00

x86/paravirt: Move halt paravirt calls under CONFIG_PARAVIRT

CONFIG_PARAVIRT_XXL is mainly defined/used by XEN PV guests. For
other VM guest types, features supported under CONFIG_PARAVIRT
are self sufficient. CONFIG_PARAVIRT mainly provides support for
TLB flush operations and time related operations.

For TDX guest as well, paravirt calls under CONFIG_PARVIRT meets
most of its requirement except the need of HLT and SAFE_HLT
paravirt calls, which is currently defined under
CONFIG_PARAVIRT_XXL.

Since enabling CONFIG_PARAVIRT_XXL is too bloated for TDX guest
like platforms, move HLT and SAFE_HLT paravirt calls under
CONFIG_PARAVIRT.

Moving HLT and SAFE_HLT paravirt calls are not fatal and should not
break any functionality for current users of CONFIG_PARAVIRT.

Fixes: bfe6ed0c6727 ("x86/tdx: Add HLT support for TDX guests")
Co-developed-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Signed-off-by: Vishal Annapurve <vannapurve@google.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Reviewed-by: Tony Luck <tony.luck@intel.com>
Reviewed-by: Juergen Gross <jgross@suse.com>
Tested-by: Ryan Afranji <afranji@google.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: stable@kernel.org
Link: https://lore.kernel.org/r/20250228014416.3925664-2-vannapurve@google.com
---
 arch/x86/include/asm/irqflags.h       | 40 ++++++++++++++------------
 arch/x86/include/asm/paravirt.h       | 20 ++++++-------
 arch/x86/include/asm/paravirt_types.h |  3 +--
 arch/x86/kernel/paravirt.c            | 14 +++++----
 4 files changed, 41 insertions(+), 36 deletions(-)

diff --git a/arch/x86/include/asm/irqflags.h b/arch/x86/include/asm/irqflags.h
index abb8374..9a9b21b 100644
--- a/arch/x86/include/asm/irqflags.h
+++ b/arch/x86/include/asm/irqflags.h
@@ -76,6 +76,28 @@ static __always_inline void native_local_irq_restore(unsigned long flags)
 
 #endif
 
+#ifndef CONFIG_PARAVIRT
+#ifndef __ASSEMBLY__
+/*
+ * Used in the idle loop; sti takes one instruction cycle
+ * to complete:
+ */
+static __always_inline void arch_safe_halt(void)
+{
+	native_safe_halt();
+}
+
+/*
+ * Used when interrupts are already enabled or to
+ * shutdown the processor:
+ */
+static __always_inline void halt(void)
+{
+	native_halt();
+}
+#endif /* __ASSEMBLY__ */
+#endif /* CONFIG_PARAVIRT */
+
 #ifdef CONFIG_PARAVIRT_XXL
 #include <asm/paravirt.h>
 #else
@@ -98,24 +120,6 @@ static __always_inline void arch_local_irq_enable(void)
 }
 
 /*
- * Used in the idle loop; sti takes one instruction cycle
- * to complete:
- */
-static __always_inline void arch_safe_halt(void)
-{
-	native_safe_halt();
-}
-
-/*
- * Used when interrupts are already enabled or to
- * shutdown the processor:
- */
-static __always_inline void halt(void)
-{
-	native_halt();
-}
-
-/*
  * For spinlocks, etc:
  */
 static __always_inline unsigned long arch_local_irq_save(void)
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index bed346b..c4c2319 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -102,6 +102,16 @@ static inline void notify_page_enc_status_changed(unsigned long pfn,
 	PVOP_VCALL3(mmu.notify_page_enc_status_changed, pfn, npages, enc);
 }
 
+static __always_inline void arch_safe_halt(void)
+{
+	PVOP_VCALL0(irq.safe_halt);
+}
+
+static inline void halt(void)
+{
+	PVOP_VCALL0(irq.halt);
+}
+
 #ifdef CONFIG_PARAVIRT_XXL
 static inline void load_sp0(unsigned long sp0)
 {
@@ -165,16 +175,6 @@ static inline void __write_cr4(unsigned long x)
 	PVOP_VCALL1(cpu.write_cr4, x);
 }
 
-static __always_inline void arch_safe_halt(void)
-{
-	PVOP_VCALL0(irq.safe_halt);
-}
-
-static inline void halt(void)
-{
-	PVOP_VCALL0(irq.halt);
-}
-
 static inline u64 paravirt_read_msr(unsigned msr)
 {
 	return PVOP_CALL1(u64, cpu.read_msr, msr);
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 6291202..631c306 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -120,10 +120,9 @@ struct pv_irq_ops {
 	struct paravirt_callee_save save_fl;
 	struct paravirt_callee_save irq_disable;
 	struct paravirt_callee_save irq_enable;
-
+#endif
 	void (*safe_halt)(void);
 	void (*halt)(void);
-#endif
 } __no_randomize_layout;
 
 struct pv_mmu_ops {
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 9792563..1ccd05d 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -75,6 +75,11 @@ void paravirt_set_sched_clock(u64 (*func)(void))
 	static_call_update(pv_sched_clock, func);
 }
 
+static noinstr void pv_native_safe_halt(void)
+{
+	native_safe_halt();
+}
+
 #ifdef CONFIG_PARAVIRT_XXL
 static noinstr void pv_native_write_cr2(unsigned long val)
 {
@@ -100,11 +105,6 @@ static noinstr void pv_native_set_debugreg(int regno, unsigned long val)
 {
 	native_set_debugreg(regno, val);
 }
-
-static noinstr void pv_native_safe_halt(void)
-{
-	native_safe_halt();
-}
 #endif
 
 struct pv_info pv_info = {
@@ -161,9 +161,11 @@ struct paravirt_patch_template pv_ops = {
 	.irq.save_fl		= __PV_IS_CALLEE_SAVE(pv_native_save_fl),
 	.irq.irq_disable	= __PV_IS_CALLEE_SAVE(pv_native_irq_disable),
 	.irq.irq_enable		= __PV_IS_CALLEE_SAVE(pv_native_irq_enable),
+#endif /* CONFIG_PARAVIRT_XXL */
+
+	/* Irq HLT ops. */
 	.irq.safe_halt		= pv_native_safe_halt,
 	.irq.halt		= native_halt,
-#endif /* CONFIG_PARAVIRT_XXL */
 
 	/* Mmu ops. */
 	.mmu.flush_tlb_user	= native_flush_tlb_local,

