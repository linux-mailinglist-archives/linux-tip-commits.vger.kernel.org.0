Return-Path: <linux-tip-commits+bounces-4209-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8963EA60DB6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 10:47:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4800F7A4069
	for <lists+linux-tip-commits@lfdr.de>; Fri, 14 Mar 2025 09:46:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B671F3BA5;
	Fri, 14 Mar 2025 09:47:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Tu/ABUlp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KU8ZN0pT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47AFF1F1908;
	Fri, 14 Mar 2025 09:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741945625; cv=none; b=obJgrOvMP89SikVnLfbPbMNzFTNM2RFHtJNBXuir9jJalO/7sUkNIvVjwCVLdhW3QuLJxBpvmRBE9hWb7286yDNo4LJKc2WvAmtgm/C4S6v+xjFvafRsOXQvX2m0ZvQlJ7A20GbJphLd9VqdMkdM5SyKGQnyWy4IPnMR9tXu/gw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741945625; c=relaxed/simple;
	bh=EapeGXz7RxJp/jf0cCHU+Vpze1//DOlTXn4Casew+ro=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YQ3duCitQizYVTsrbZRBuiq5Ca4+B8kvhNLSD+A2MnORw1BLnX46RDkuYzo9G1K+mZJrBH1JNU9QlgHuRNTL7g6/7zFPWOjYEZf/xDV9KabTdX8UU20R49FNKFzn0TDiWhmrSkJgc6J3QK+cYUTbAGZf0z4Sr6U+k4K4Jn8nTo4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Tu/ABUlp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KU8ZN0pT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 14 Mar 2025 09:47:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741945621;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OgieQiKi2QoLZjZm036y1X+3O6U1sgHISBFtEFLINk8=;
	b=Tu/ABUlpn4kLkP5B8s7+NB8/poLcars1mlNtIKgO4uQsywWFljCu9kraMDOvwMy9mTqXfl
	4mztFZdCNqc92pEqVMlPyWK9qubzcNZ4JkFVUn6A7xDxk070t+Gb4hravFCfepmqgy4J08
	OSDCwoT+3zIS8S9l7i8EQeIbo+4qiKhNeqT5tR5JSrhXrQxkOq5wEmoNl5B6OKpk5d3nin
	Lpkm9o9g3YLFUzzszuvjb1OkfitkHhA2GLgGjLruTB2TwLMcx7IISum4N9jrLc48uOIBso
	RuxHaUInaBguuFm+WOms7wgq9vwcr6lDtEprCEW7a0GqrgtRPuCSgujPqQFiNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741945621;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OgieQiKi2QoLZjZm036y1X+3O6U1sgHISBFtEFLINk8=;
	b=KU8ZN0pTPK6jYSbxiAr6jCQVP6yn3PWru3XGbvaO6jjFTo2ywbUVmOZP0+MZU3xnEmYMv1
	aqXjOqSkLfhK8lBg==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] x86/xen: Move Xen upcall handler to Xen specific code files
Cc: Brian Gerst <brgerst@gmail.com>, Ingo Molnar <mingo@kernel.org>,
 Sohil Mehta <sohil.mehta@intel.com>, Andy Lutomirski <luto@kernel.org>,
 Juergen Gross <jgross@suse.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250313182236.655724-2-brgerst@gmail.com>
References: <20250313182236.655724-2-brgerst@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174194562029.14745.12496349660371729484.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     827dc2e36172e978d6b1c701b04bee56881f54bf
Gitweb:        https://git.kernel.org/tip/827dc2e36172e978d6b1c701b04bee56881f54bf
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Thu, 13 Mar 2025 14:22:32 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 14 Mar 2025 10:32:51 +01:00

x86/xen: Move Xen upcall handler to Xen specific code files

Move the upcall handler to Xen-specific files.

No functional changes.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Sohil Mehta <sohil.mehta@intel.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Link: https://lore.kernel.org/r/20250313182236.655724-2-brgerst@gmail.com
---
 arch/x86/entry/common.c     | 72 +------------------------------------
 arch/x86/xen/enlighten_pv.c | 46 +++++++++++++++++++++++-
 include/xen/xen-ops.h       | 19 ++++++++++-
 3 files changed, 65 insertions(+), 72 deletions(-)

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
index 5e57835..af9e43c 100644
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
@@ -94,6 +95,21 @@ void *xen_initial_gdt;
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
+#endif
+
 struct tls_descs {
 	struct desc_struct desc[3];
 };
@@ -687,6 +703,36 @@ DEFINE_IDTENTRY_RAW(xenpv_exc_machine_check)
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
diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
index 47f11be..174ef8e 100644
--- a/include/xen/xen-ops.h
+++ b/include/xen/xen-ops.h
@@ -208,10 +208,29 @@ static inline void xen_preemptible_hcall_end(void)
 	__this_cpu_write(xen_in_preemptible_hcall, false);
 }
 
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
 #else
 
 static inline void xen_preemptible_hcall_begin(void) { }
 static inline void xen_preemptible_hcall_end(void) { }
+static __always_inline bool get_and_clear_inhcall(void) { return false; }
+static __always_inline void restore_inhcall(bool inhcall) { }
 
 #endif /* CONFIG_XEN_PV && !CONFIG_PREEMPTION */
 

