Return-Path: <linux-tip-commits+bounces-4235-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B31F4A6352A
	for <lists+linux-tip-commits@lfdr.de>; Sun, 16 Mar 2025 12:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 04AC216E7D9
	for <lists+linux-tip-commits@lfdr.de>; Sun, 16 Mar 2025 11:02:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A7841A8405;
	Sun, 16 Mar 2025 11:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Upu4KY+Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NzdeTXGW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F2E1A5BA6;
	Sun, 16 Mar 2025 11:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742122907; cv=none; b=NJqP1cvoEh93z9uj6+65bjYecfPsm8tA/oym8zb6R30jfngHlbj+oUBSzXhcDqh8NjZ0nDiM6M94sx/RfbyyIxQSQx3JVaFgVgQm+LHGzyF0Xh4DklDu3bz/fkcuatche/8OvKpZxymAl+DvKVXoepYjLvSPUVqKDfYtLgg7VuA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742122907; c=relaxed/simple;
	bh=tdjek+HZaLUzkjUfsn+t6pJy+43x2LG2dAvd8ESa5gg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OA445+l5KMhSRgSt5BkpZni73eYcpEWNMmwjXTRs21TFUBg48LejEdZreZIHhCY6JkQh5AzaBInhvVrusZ1+GOPdDMt5NcxxAxvXAPz1QOc57GtPUESGlGu8h/5SFUNoNowUXDzDqVQGSPtaOPvuENRMsGI7VTmaMdKN+BQtXWk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Upu4KY+Q; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NzdeTXGW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 16 Mar 2025 11:01:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742122903;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGYn0KjoqjBQEbolbD382HTMfrBCQXd1FS1WlBGNI6w=;
	b=Upu4KY+Qx6BIvbss56qiza9B9J6fbscMrQ4/uZqmOfxEhoDFACfmdmvl2Lfa6f2PbkeTQK
	a07T9nrCnnsj3R5VshHWhZ43HURcEOIXrQUYVN0/Hh3ImnvAwaUpDBdnFjoD0o20g1oW60
	Co6TWc4+p287baDVd46t4b6FhTlMp8A7LT/Dn1MYUsVdq8EkQ7hOxfFhYynf2QCELimPH7
	hvWa60IeahFKvnKG+k/IG5hLyQ91bNinOwg94B9Zh/Y6jhnnWjin/5Wy/54DxpT08byNFv
	1AhkRr3b9i05EDijFAh1UnxzlAP+J07oNxzRzAER93lvVM2F9uy5wc1MsUrqTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742122903;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QGYn0KjoqjBQEbolbD382HTMfrBCQXd1FS1WlBGNI6w=;
	b=NzdeTXGWNo991Zq0bt6GRMQvMwZScyA5HKD8Jz/6vvCWrXYeb8p5zXlikEP0DpE1V8yLEN
	ATX0FSGyrlwYLRDA==
From: "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/xen: Move Xen upcall handler
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
Message-ID: <174212290285.14745.14526090013838699465.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     82d829091f62721166d3f1af93c4c94fc9afa13e
Gitweb:        https://git.kernel.org/tip/82d829091f62721166d3f1af93c4c94fc9afa13e
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 14 Mar 2025 11:12:14 -04:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 16 Mar 2025 11:49:41 +01:00

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

