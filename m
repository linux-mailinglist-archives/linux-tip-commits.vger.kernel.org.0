Return-Path: <linux-tip-commits+bounces-4364-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6AB5A68AD6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 12:11:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CBD2916B367
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 Mar 2025 11:09:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FC3525C6FC;
	Wed, 19 Mar 2025 11:03:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="egiN2Z6q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JPjCehxO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0294925C6EA;
	Wed, 19 Mar 2025 11:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742382235; cv=none; b=W7T5/uCFoWsFFQD2Kt2bNN5g69BM/95J5Y+sMRa5Br8Rjsa18Ruo/FEFk0lCaVGlBIlJ5VcO7BHp/4tG+aABJnR8bGYStayxv5p+paK2+wUOHc/QzsnBsAL9bkC3WBUah4ffLwE+aSj8loNDhROgMJcjVzC9wVQkXW5l9k6jleM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742382235; c=relaxed/simple;
	bh=R6YYRm0n117UhsDVit+bSKvuQz2n/R4+XJVUythbFJQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qTXuKr6A4u023Xqn/qCrNBkXGvWR84gj+tofalRHZNsVSFwGZeXoykqGTOGB3T2EDlAv2ZPx15kZvRW151v9OldiDacurMcD+krAyPSD8b0Q2T94xkn2TjWAkG+gP5LGRBrcbXdLq2YCaU0eeqYYIQSvZqAxSr+Zz8tuF+qSCyY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=egiN2Z6q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JPjCehxO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 19 Mar 2025 11:03:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742382231;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cRdJb5imMniA5fnLJvx/TN1HLza5Q38T/njciqvCVko=;
	b=egiN2Z6qOVNd7aAAKpdqRgg2GltFpHIC8XQ04RDMNT+vigxye5rfTw/eJ4u4+/Bql5mV/H
	riZfuLHax3HQsL7Fbxh3XAMMf68ivLdvlLTXhU8ews1CrStEBk8Odeq+XdtM7R0Y1ifB+a
	1AL07gOkIXqciVfBqYgdQLGBP6vlmiDcnSMhz3P3+uULDihj6Sybcip1ggHdqV2rSCOemO
	7jKZWDOclda6TNpi5YIE+ABdjHQaGUvzJZ3l9cSG6TBsV6sppllxQWFtAlAhB8aF+DAX5F
	GC+pvbCX8Fmr69iLwuYJubkQ0jeJ0KbYa9MCq6Ef5OzDMKQKKtXvcT2Aa8ecFA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742382231;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cRdJb5imMniA5fnLJvx/TN1HLza5Q38T/njciqvCVko=;
	b=JPjCehxO+tmliUdFscItmmIOxBPSrVc5ip3DAorZegcPdtuFUFHSHJlkIh7057RdvhumNy
	AKIdcNGFXhuWcqDQ==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/core] x86/xen: Move Xen upcall handler
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Juergen Gross <jgross@suse.com>, Sohil Mehta <sohil.mehta@intel.com>,
 Andy Lutomirski <luto@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250314151220.862768-2-brgerst@gmail.com>
References: <20250314151220.862768-2-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174238223094.14745.10299419038445932226.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/core branch of tip:

Commit-ID:     1ab7b5ed44ba9bce581e225f40219b793bc779d6
Gitweb:        https://git.kernel.org/tip/1ab7b5ed44ba9bce581e225f40219b793bc779d6
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 14 Mar 2025 11:12:14 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 19 Mar 2025 11:18:58 +01:00

x86/xen: Move Xen upcall handler

Move the upcall handler to Xen-specific files.

No functional changes.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250314151220.862768-2-brgerst@gmail.com
---
 arch/x86/entry/common.c     | 72 +------------------------------------
 arch/x86/xen/enlighten_pv.c | 69 +++++++++++++++++++++++++++++++++++-
 2 files changed, 69 insertions(+), 72 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index 3514bf2..ce4d88e 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -21,11 +21,6 @@
 #include <linux/uaccess.h>
 #include <linux/init.h>
 
-#ifdef CONFIG_XEN_PV
-#include <xen/xen-ops.h>
-#include <xen/events.h>
-#endif
-
 #include <asm/apic.h>
 #include <asm/desc.h>
 #include <asm/traps.h>
@@ -455,70 +450,3 @@ SYSCALL_DEFINE0(ni_syscall)
 {
 	return -ENOSYS;
 }
-
-#ifdef CONFIG_XEN_PV
-#ifndef CONFIG_PREEMPTION
-/*
- * Some hypercalls issued by the toolstack can take many 10s of
- * seconds. Allow tasks running hypercalls via the privcmd driver to
- * be voluntarily preempted even if full kernel preemption is
- * disabled.
- *
- * Such preemptible hypercalls are bracketed by
- * xen_preemptible_hcall_begin() and xen_preemptible_hcall_end()
- * calls.
- */
-DEFINE_PER_CPU(bool, xen_in_preemptible_hcall);
-EXPORT_SYMBOL_GPL(xen_in_preemptible_hcall);
-
-/*
- * In case of scheduling the flag must be cleared and restored after
- * returning from schedule as the task might move to a different CPU.
- */
-static __always_inline bool get_and_clear_inhcall(void)
-{
-	bool inhcall = __this_cpu_read(xen_in_preemptible_hcall);
-
-	__this_cpu_write(xen_in_preemptible_hcall, false);
-	return inhcall;
-}
-
-static __always_inline void restore_inhcall(bool inhcall)
-{
-	__this_cpu_write(xen_in_preemptible_hcall, inhcall);
-}
-#else
-static __always_inline bool get_and_clear_inhcall(void) { return false; }
-static __always_inline void restore_inhcall(bool inhcall) { }
-#endif
-
-static void __xen_pv_evtchn_do_upcall(struct pt_regs *regs)
-{
-	struct pt_regs *old_regs = set_irq_regs(regs);
-
-	inc_irq_stat(irq_hv_callback_count);
-
-	xen_evtchn_do_upcall();
-
-	set_irq_regs(old_regs);
-}
-
-__visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
-{
-	irqentry_state_t state = irqentry_enter(regs);
-	bool inhcall;
-
-	instrumentation_begin();
-	run_sysvec_on_irqstack_cond(__xen_pv_evtchn_do_upcall, regs);
-
-	inhcall = get_and_clear_inhcall();
-	if (inhcall && !WARN_ON_ONCE(state.exit_rcu)) {
-		irqentry_exit_cond_resched();
-		instrumentation_end();
-		restore_inhcall(inhcall);
-	} else {
-		instrumentation_end();
-		irqentry_exit(regs, state);
-	}
-}
-#endif /* CONFIG_XEN_PV */
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 5e57835..dcc2041 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -73,6 +73,7 @@
 #include <asm/mwait.h>
 #include <asm/pci_x86.h>
 #include <asm/cpu.h>
+#include <asm/irq_stack.h>
 #ifdef CONFIG_X86_IOPL_IOPERM
 #include <asm/io_bitmap.h>
 #endif
@@ -94,6 +95,44 @@ void *xen_initial_gdt;
 static int xen_cpu_up_prepare_pv(unsigned int cpu);
 static int xen_cpu_dead_pv(unsigned int cpu);
 
+#ifndef CONFIG_PREEMPTION
+/*
+ * Some hypercalls issued by the toolstack can take many 10s of
+ * seconds. Allow tasks running hypercalls via the privcmd driver to
+ * be voluntarily preempted even if full kernel preemption is
+ * disabled.
+ *
+ * Such preemptible hypercalls are bracketed by
+ * xen_preemptible_hcall_begin() and xen_preemptible_hcall_end()
+ * calls.
+ */
+DEFINE_PER_CPU(bool, xen_in_preemptible_hcall);
+EXPORT_SYMBOL_GPL(xen_in_preemptible_hcall);
+
+/*
+ * In case of scheduling the flag must be cleared and restored after
+ * returning from schedule as the task might move to a different CPU.
+ */
+static __always_inline bool get_and_clear_inhcall(void)
+{
+	bool inhcall = __this_cpu_read(xen_in_preemptible_hcall);
+
+	__this_cpu_write(xen_in_preemptible_hcall, false);
+	return inhcall;
+}
+
+static __always_inline void restore_inhcall(bool inhcall)
+{
+	__this_cpu_write(xen_in_preemptible_hcall, inhcall);
+}
+
+#else
+
+static __always_inline bool get_and_clear_inhcall(void) { return false; }
+static __always_inline void restore_inhcall(bool inhcall) { }
+
+#endif
+
 struct tls_descs {
 	struct desc_struct desc[3];
 };
@@ -687,6 +726,36 @@ DEFINE_IDTENTRY_RAW(xenpv_exc_machine_check)
 }
 #endif
 
+static void __xen_pv_evtchn_do_upcall(struct pt_regs *regs)
+{
+	struct pt_regs *old_regs = set_irq_regs(regs);
+
+	inc_irq_stat(irq_hv_callback_count);
+
+	xen_evtchn_do_upcall();
+
+	set_irq_regs(old_regs);
+}
+
+__visible noinstr void xen_pv_evtchn_do_upcall(struct pt_regs *regs)
+{
+	irqentry_state_t state = irqentry_enter(regs);
+	bool inhcall;
+
+	instrumentation_begin();
+	run_sysvec_on_irqstack_cond(__xen_pv_evtchn_do_upcall, regs);
+
+	inhcall = get_and_clear_inhcall();
+	if (inhcall && !WARN_ON_ONCE(state.exit_rcu)) {
+		irqentry_exit_cond_resched();
+		instrumentation_end();
+		restore_inhcall(inhcall);
+	} else {
+		instrumentation_end();
+		irqentry_exit(regs, state);
+	}
+}
+
 struct trap_array_entry {
 	void (*orig)(void);
 	void (*xen)(void);

