Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 78B4E3974EA
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jun 2021 16:04:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234198AbhFAOGj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 1 Jun 2021 10:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234176AbhFAOGi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 1 Jun 2021 10:06:38 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50DEEC061574;
        Tue,  1 Jun 2021 07:04:56 -0700 (PDT)
Date:   Tue, 01 Jun 2021 14:04:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622556292;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PsWWNQ2PLSLx/1t52F0rAz7tTR1IBpl5Q6yyoKHsiDI=;
        b=Xw6Ufrc8JaQlLLVlahqYjPjgRIKwzu88SUihSm7W+Py53v7ImSpOLCnzWmiAvC+9yBHux3
        xMieSK5AuqP5lx/UQ7ZG8ut5v1uRXY5x9NmQlqh94ktIszWgrJhwvmBpdtwv+QgGPDmNKb
        8zgw8FOdxocQpGKz65VJ7eooBicIIyeSn7uhWw6IbW6eK7xmGFSPW/Ybvq6rbl/xhDfQtc
        JWayMAKE+yZvf6WNmBXTmodom9wk1UCAUOJpBD4Uf0CGogZ9dFD1eGs5O1V8AK+2xqSZ+f
        ud3+3mGeV2g52jSgyuqorqCVajXnKPYnurecVB6Yp6N9ArnnvQVnUcitJSziPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622556292;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PsWWNQ2PLSLx/1t52F0rAz7tTR1IBpl5Q6yyoKHsiDI=;
        b=kYCrj5anVDIxpgRuwE2bHXYTLJCAgqfD+Gha8+T+DBHXR9CDPhSbRsQE/w0FTboQwPTAkH
        Stree2NEyz4oyQBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] kprobes: Remove kprobe::fault_handler
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Masami Hiramatsu <mhiramat@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210525073213.561116662@infradead.org>
References: <20210525073213.561116662@infradead.org>
MIME-Version: 1.0
Message-ID: <162255629157.29796.7887986702840298811.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     ec6aba3d2be1ed75b3f4c894bb64a36d40db1f55
Gitweb:        https://git.kernel.org/tip/ec6aba3d2be1ed75b3f4c894bb64a36d40db1f55
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 25 May 2021 09:25:19 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Jun 2021 16:00:08 +02:00

kprobes: Remove kprobe::fault_handler

The reason for kprobe::fault_handler(), as given by their comment:

 * We come here because instructions in the pre/post
 * handler caused the page_fault, this could happen
 * if handler tries to access user space by
 * copy_from_user(), get_user() etc. Let the
 * user-specified handler try to fix it first.

Is just plain bad. Those other handlers are ran from non-preemptible
context and had better use _nofault() functions. Also, there is no
upstream usage of this.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Link: https://lore.kernel.org/r/20210525073213.561116662@infradead.org
---
 Documentation/trace/kprobes.rst    | 24 +++++-------------------
 arch/arc/kernel/kprobes.c          | 10 ----------
 arch/arm/probes/kprobes/core.c     |  9 ---------
 arch/arm64/kernel/probes/kprobes.c | 10 ----------
 arch/csky/kernel/probes/kprobes.c  | 10 ----------
 arch/ia64/kernel/kprobes.c         |  9 ---------
 arch/mips/kernel/kprobes.c         |  3 ---
 arch/powerpc/kernel/kprobes.c      | 10 ----------
 arch/riscv/kernel/probes/kprobes.c | 10 ----------
 arch/s390/kernel/kprobes.c         | 10 ----------
 arch/sh/kernel/kprobes.c           | 10 ----------
 arch/sparc/kernel/kprobes.c        | 10 ----------
 arch/x86/kernel/kprobes/core.c     | 10 ----------
 include/linux/kprobes.h            |  8 --------
 kernel/kprobes.c                   | 19 -------------------
 samples/kprobes/kprobe_example.c   | 15 ---------------
 16 files changed, 5 insertions(+), 172 deletions(-)

diff --git a/Documentation/trace/kprobes.rst b/Documentation/trace/kprobes.rst
index b757b6d..998149c 100644
--- a/Documentation/trace/kprobes.rst
+++ b/Documentation/trace/kprobes.rst
@@ -362,14 +362,11 @@ register_kprobe
 	#include <linux/kprobes.h>
 	int register_kprobe(struct kprobe *kp);
 
-Sets a breakpoint at the address kp->addr.  When the breakpoint is
-hit, Kprobes calls kp->pre_handler.  After the probed instruction
-is single-stepped, Kprobe calls kp->post_handler.  If a fault
-occurs during execution of kp->pre_handler or kp->post_handler,
-or during single-stepping of the probed instruction, Kprobes calls
-kp->fault_handler.  Any or all handlers can be NULL. If kp->flags
-is set KPROBE_FLAG_DISABLED, that kp will be registered but disabled,
-so, its handlers aren't hit until calling enable_kprobe(kp).
+Sets a breakpoint at the address kp->addr.  When the breakpoint is hit, Kprobes
+calls kp->pre_handler.  After the probed instruction is single-stepped, Kprobe
+calls kp->post_handler.  Any or all handlers can be NULL. If kp->flags is set
+KPROBE_FLAG_DISABLED, that kp will be registered but disabled, so, its handlers
+aren't hit until calling enable_kprobe(kp).
 
 .. note::
 
@@ -415,17 +412,6 @@ User's post-handler (kp->post_handler)::
 p and regs are as described for the pre_handler.  flags always seems
 to be zero.
 
-User's fault-handler (kp->fault_handler)::
-
-	#include <linux/kprobes.h>
-	#include <linux/ptrace.h>
-	int fault_handler(struct kprobe *p, struct pt_regs *regs, int trapnr);
-
-p and regs are as described for the pre_handler.  trapnr is the
-architecture-specific trap number associated with the fault (e.g.,
-on i386, 13 for a general protection fault or 14 for a page fault).
-Returns 1 if it successfully handled the exception.
-
 register_kretprobe
 ------------------
 
diff --git a/arch/arc/kernel/kprobes.c b/arch/arc/kernel/kprobes.c
index cabef45..9f5b39f 100644
--- a/arch/arc/kernel/kprobes.c
+++ b/arch/arc/kernel/kprobes.c
@@ -324,16 +324,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned long trapnr)
 		kprobes_inc_nmissed_count(cur);
 
 		/*
-		 * We come here because instructions in the pre/post
-		 * handler caused the page_fault, this could happen
-		 * if handler tries to access user space by
-		 * copy_from_user(), get_user() etc. Let the
-		 * user-specified handler try to fix it first.
-		 */
-		if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
-			return 1;
-
-		/*
 		 * In case the user-specified fault handler returned zero,
 		 * try to fix up.
 		 */
diff --git a/arch/arm/probes/kprobes/core.c b/arch/arm/probes/kprobes/core.c
index a965311..7b9b9a5 100644
--- a/arch/arm/probes/kprobes/core.c
+++ b/arch/arm/probes/kprobes/core.c
@@ -358,15 +358,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
 		 */
 		kprobes_inc_nmissed_count(cur);
 
-		/*
-		 * We come here because instructions in the pre/post
-		 * handler caused the page_fault, this could happen
-		 * if handler tries to access user space by
-		 * copy_from_user(), get_user() etc. Let the
-		 * user-specified handler try to fix it.
-		 */
-		if (cur->fault_handler && cur->fault_handler(cur, regs, fsr))
-			return 1;
 		break;
 
 	default:
diff --git a/arch/arm64/kernel/probes/kprobes.c b/arch/arm64/kernel/probes/kprobes.c
index d607c99..f6b088e 100644
--- a/arch/arm64/kernel/probes/kprobes.c
+++ b/arch/arm64/kernel/probes/kprobes.c
@@ -284,16 +284,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int fsr)
 		kprobes_inc_nmissed_count(cur);
 
 		/*
-		 * We come here because instructions in the pre/post
-		 * handler caused the page_fault, this could happen
-		 * if handler tries to access user space by
-		 * copy_from_user(), get_user() etc. Let the
-		 * user-specified handler try to fix it first.
-		 */
-		if (cur->fault_handler && cur->fault_handler(cur, regs, fsr))
-			return 1;
-
-		/*
 		 * In case the user-specified fault handler returned
 		 * zero, try to fix up.
 		 */
diff --git a/arch/csky/kernel/probes/kprobes.c b/arch/csky/kernel/probes/kprobes.c
index 589f090..e0e973e 100644
--- a/arch/csky/kernel/probes/kprobes.c
+++ b/arch/csky/kernel/probes/kprobes.c
@@ -302,16 +302,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int trapnr)
 		kprobes_inc_nmissed_count(cur);
 
 		/*
-		 * We come here because instructions in the pre/post
-		 * handler caused the page_fault, this could happen
-		 * if handler tries to access user space by
-		 * copy_from_user(), get_user() etc. Let the
-		 * user-specified handler try to fix it first.
-		 */
-		if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
-			return 1;
-
-		/*
 		 * In case the user-specified fault handler returned
 		 * zero, try to fix up.
 		 */
diff --git a/arch/ia64/kernel/kprobes.c b/arch/ia64/kernel/kprobes.c
index fc1ff8a..6efed4e 100644
--- a/arch/ia64/kernel/kprobes.c
+++ b/arch/ia64/kernel/kprobes.c
@@ -851,15 +851,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 		kprobes_inc_nmissed_count(cur);
 
 		/*
-		 * We come here because instructions in the pre/post
-		 * handler caused the page_fault, this could happen
-		 * if handler tries to access user space by
-		 * copy_from_user(), get_user() etc. Let the
-		 * user-specified handler try to fix it first.
-		 */
-		if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
-			return 1;
-		/*
 		 * In case the user-specified fault handler returned
 		 * zero, try to fix up.
 		 */
diff --git a/arch/mips/kernel/kprobes.c b/arch/mips/kernel/kprobes.c
index 54dfba8..75bff0f 100644
--- a/arch/mips/kernel/kprobes.c
+++ b/arch/mips/kernel/kprobes.c
@@ -403,9 +403,6 @@ int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 	struct kprobe *cur = kprobe_running();
 	struct kprobe_ctlblk *kcb = get_kprobe_ctlblk();
 
-	if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
-		return 1;
-
 	if (kcb->kprobe_status & KPROBE_HIT_SS) {
 		resume_execution(cur, regs, kcb);
 		regs->cp0_status |= kcb->kprobe_old_SR;
diff --git a/arch/powerpc/kernel/kprobes.c b/arch/powerpc/kernel/kprobes.c
index 01ab216..75b4e87 100644
--- a/arch/powerpc/kernel/kprobes.c
+++ b/arch/powerpc/kernel/kprobes.c
@@ -509,16 +509,6 @@ int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 		kprobes_inc_nmissed_count(cur);
 
 		/*
-		 * We come here because instructions in the pre/post
-		 * handler caused the page_fault, this could happen
-		 * if handler tries to access user space by
-		 * copy_from_user(), get_user() etc. Let the
-		 * user-specified handler try to fix it first.
-		 */
-		if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
-			return 1;
-
-		/*
 		 * In case the user-specified fault handler returned
 		 * zero, try to fix up.
 		 */
diff --git a/arch/riscv/kernel/probes/kprobes.c b/arch/riscv/kernel/probes/kprobes.c
index 10b965c..923b5ea 100644
--- a/arch/riscv/kernel/probes/kprobes.c
+++ b/arch/riscv/kernel/probes/kprobes.c
@@ -284,16 +284,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, unsigned int trapnr)
 		kprobes_inc_nmissed_count(cur);
 
 		/*
-		 * We come here because instructions in the pre/post
-		 * handler caused the page_fault, this could happen
-		 * if handler tries to access user space by
-		 * copy_from_user(), get_user() etc. Let the
-		 * user-specified handler try to fix it first.
-		 */
-		if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
-			return 1;
-
-		/*
 		 * In case the user-specified fault handler returned
 		 * zero, try to fix up.
 		 */
diff --git a/arch/s390/kernel/kprobes.c b/arch/s390/kernel/kprobes.c
index aae24dc..ad631e3 100644
--- a/arch/s390/kernel/kprobes.c
+++ b/arch/s390/kernel/kprobes.c
@@ -453,16 +453,6 @@ static int kprobe_trap_handler(struct pt_regs *regs, int trapnr)
 		kprobes_inc_nmissed_count(p);
 
 		/*
-		 * We come here because instructions in the pre/post
-		 * handler caused the page_fault, this could happen
-		 * if handler tries to access user space by
-		 * copy_from_user(), get_user() etc. Let the
-		 * user-specified handler try to fix it first.
-		 */
-		if (p->fault_handler && p->fault_handler(p, regs, trapnr))
-			return 1;
-
-		/*
 		 * In case the user-specified fault handler returned
 		 * zero, try to fix up.
 		 */
diff --git a/arch/sh/kernel/kprobes.c b/arch/sh/kernel/kprobes.c
index 756100b..5826342 100644
--- a/arch/sh/kernel/kprobes.c
+++ b/arch/sh/kernel/kprobes.c
@@ -390,16 +390,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 		kprobes_inc_nmissed_count(cur);
 
 		/*
-		 * We come here because instructions in the pre/post
-		 * handler caused the page_fault, this could happen
-		 * if handler tries to access user space by
-		 * copy_from_user(), get_user() etc. Let the
-		 * user-specified handler try to fix it first.
-		 */
-		if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
-			return 1;
-
-		/*
 		 * In case the user-specified fault handler returned
 		 * zero, try to fix up.
 		 */
diff --git a/arch/sparc/kernel/kprobes.c b/arch/sparc/kernel/kprobes.c
index 217c21a..db4e341 100644
--- a/arch/sparc/kernel/kprobes.c
+++ b/arch/sparc/kernel/kprobes.c
@@ -353,16 +353,6 @@ int __kprobes kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 		kprobes_inc_nmissed_count(cur);
 
 		/*
-		 * We come here because instructions in the pre/post
-		 * handler caused the page_fault, this could happen
-		 * if handler tries to access user space by
-		 * copy_from_user(), get_user() etc. Let the
-		 * user-specified handler try to fix it first.
-		 */
-		if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
-			return 1;
-
-		/*
 		 * In case the user-specified fault handler returned
 		 * zero, try to fix up.
 		 */
diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index d3d6554..cfcdf4b 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -1110,16 +1110,6 @@ int kprobe_fault_handler(struct pt_regs *regs, int trapnr)
 		 * these specific fault cases.
 		 */
 		kprobes_inc_nmissed_count(cur);
-
-		/*
-		 * We come here because instructions in the pre/post
-		 * handler caused the page_fault, this could happen
-		 * if handler tries to access user space by
-		 * copy_from_user(), get_user() etc. Let the
-		 * user-specified handler try to fix it first.
-		 */
-		if (cur->fault_handler && cur->fault_handler(cur, regs, trapnr))
-			return 1;
 	}
 
 	return 0;
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 1883a4a..523ffc7 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -54,8 +54,6 @@ struct kretprobe_instance;
 typedef int (*kprobe_pre_handler_t) (struct kprobe *, struct pt_regs *);
 typedef void (*kprobe_post_handler_t) (struct kprobe *, struct pt_regs *,
 				       unsigned long flags);
-typedef int (*kprobe_fault_handler_t) (struct kprobe *, struct pt_regs *,
-				       int trapnr);
 typedef int (*kretprobe_handler_t) (struct kretprobe_instance *,
 				    struct pt_regs *);
 
@@ -83,12 +81,6 @@ struct kprobe {
 	/* Called after addr is executed, unless... */
 	kprobe_post_handler_t post_handler;
 
-	/*
-	 * ... called if executing addr causes a fault (eg. page fault).
-	 * Return 1 if it handled fault, otherwise kernel will see it.
-	 */
-	kprobe_fault_handler_t fault_handler;
-
 	/* Saved opcode (which has been replaced with breakpoint) */
 	kprobe_opcode_t opcode;
 
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 745f08f..e41385a 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1183,23 +1183,6 @@ static void aggr_post_handler(struct kprobe *p, struct pt_regs *regs,
 }
 NOKPROBE_SYMBOL(aggr_post_handler);
 
-static int aggr_fault_handler(struct kprobe *p, struct pt_regs *regs,
-			      int trapnr)
-{
-	struct kprobe *cur = __this_cpu_read(kprobe_instance);
-
-	/*
-	 * if we faulted "during" the execution of a user specified
-	 * probe handler, invoke just that probe's fault handler
-	 */
-	if (cur && cur->fault_handler) {
-		if (cur->fault_handler(cur, regs, trapnr))
-			return 1;
-	}
-	return 0;
-}
-NOKPROBE_SYMBOL(aggr_fault_handler);
-
 /* Walks the list and increments nmissed count for multiprobe case */
 void kprobes_inc_nmissed_count(struct kprobe *p)
 {
@@ -1330,7 +1313,6 @@ static void init_aggr_kprobe(struct kprobe *ap, struct kprobe *p)
 	ap->addr = p->addr;
 	ap->flags = p->flags & ~KPROBE_FLAG_OPTIMIZED;
 	ap->pre_handler = aggr_pre_handler;
-	ap->fault_handler = aggr_fault_handler;
 	/* We don't care the kprobe which has gone. */
 	if (p->post_handler && !kprobe_gone(p))
 		ap->post_handler = aggr_post_handler;
@@ -2014,7 +1996,6 @@ int register_kretprobe(struct kretprobe *rp)
 
 	rp->kp.pre_handler = pre_handler_kretprobe;
 	rp->kp.post_handler = NULL;
-	rp->kp.fault_handler = NULL;
 
 	/* Pre-allocate memory for max kretprobe instances */
 	if (rp->maxactive <= 0) {
diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
index c495664..4b2f318 100644
--- a/samples/kprobes/kprobe_example.c
+++ b/samples/kprobes/kprobe_example.c
@@ -94,26 +94,11 @@ static void __kprobes handler_post(struct kprobe *p, struct pt_regs *regs,
 #endif
 }
 
-/*
- * fault_handler: this is called if an exception is generated for any
- * instruction within the pre- or post-handler, or when Kprobes
- * single-steps the probed instruction.
- */
-static int handler_fault(struct kprobe *p, struct pt_regs *regs, int trapnr)
-{
-	pr_info("fault_handler: p->addr = 0x%p, trap #%dn", p->addr, trapnr);
-	/* Return 0 because we don't handle the fault. */
-	return 0;
-}
-/* NOKPROBE_SYMBOL() is also available */
-NOKPROBE_SYMBOL(handler_fault);
-
 static int __init kprobe_init(void)
 {
 	int ret;
 	kp.pre_handler = handler_pre;
 	kp.post_handler = handler_post;
-	kp.fault_handler = handler_fault;
 
 	ret = register_kprobe(&kp);
 	if (ret < 0) {
