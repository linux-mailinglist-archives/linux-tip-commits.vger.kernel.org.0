Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4711D40F892
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Sep 2021 14:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244969AbhIQM7u (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Sep 2021 08:59:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244995AbhIQM7e (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Sep 2021 08:59:34 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56B36C0613C1;
        Fri, 17 Sep 2021 05:58:08 -0700 (PDT)
Date:   Fri, 17 Sep 2021 12:58:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631883487;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WNHC11m9QIQ8NuB/Md4ap8jmk5R++bs3dM2roscgAQo=;
        b=kCvk+tJwdRAGRxbdgH09Ykkz5GdcA83L/FD0A2KyjhdWIjdysFFQdAhdJ7K/+uiIpL+cU0
        tRb8MUnxa0eExSnM9zMwCskxHJ9xhNS40owUJutU56y4Zb4Dn+CqyAEYHvGcPHrEuhnp2m
        NVSSfO+8jHlb4oG2X60vNk5YLn7SFFa/7gupaYhfDFZNHlseV6wzuDRQgafgP92OmMwrJh
        tZa9cgoGk/d+ePUPez4O+ao3wd2vdlESISnwQXi1NDmLj+wY2vhfYtvaz6pnyR/LMFOAvx
        9bUNVBB9RwOIXFnoA/0b9tZFc5WNbGwxVsdA/Kpdr8ARHN03JwmhHs1okzweLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631883487;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WNHC11m9QIQ8NuB/Md4ap8jmk5R++bs3dM2roscgAQo=;
        b=M+PycEF2dkDJfjtmOXTRS4adubGE5HoL6lZldln0aPvqcSdrVrJB3Dn5T1IHdiejAadVOu
        el238wlvVDtuv6AA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/xen: Make save_fl() noinstr
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210624095148.749712274@infradead.org>
References: <20210624095148.749712274@infradead.org>
MIME-Version: 1.0
Message-ID: <163188348613.25758.252625037575928649.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     20125c872a3f129cef7fdec2b7681da98502a55d
Gitweb:        https://git.kernel.org/tip/20125c872a3f129cef7fdec2b7681da98502a55d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 24 Jun 2021 11:41:17 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Sep 2021 13:14:44 +02:00

x86/xen: Make save_fl() noinstr

vmlinux.o: warning: objtool: pv_ops[30]: native_save_fl
vmlinux.o: warning: objtool: pv_ops[30]: __raw_callee_save_xen_save_fl
vmlinux.o: warning: objtool: pv_ops[30]: xen_save_fl_direct
vmlinux.o: warning: objtool: lockdep_hardirqs_off()+0x73: call to pv_ops[30]() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20210624095148.749712274@infradead.org
---
 arch/x86/include/asm/paravirt.h |  7 +++++--
 arch/x86/kernel/irqflags.S      |  2 ++-
 arch/x86/xen/irq.c              |  4 ++--
 arch/x86/xen/xen-asm.S          | 32 ++++++++++++++++----------------
 4 files changed, 25 insertions(+), 20 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index 34da790..cebec95 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -653,10 +653,10 @@ bool __raw_callee_save___native_vcpu_is_preempted(long cpu);
  * functions.
  */
 #define PV_THUNK_NAME(func) "__raw_callee_save_" #func
-#define PV_CALLEE_SAVE_REGS_THUNK(func)					\
+#define __PV_CALLEE_SAVE_REGS_THUNK(func, section)			\
 	extern typeof(func) __raw_callee_save_##func;			\
 									\
-	asm(".pushsection .text;"					\
+	asm(".pushsection " section ", \"ax\";"				\
 	    ".globl " PV_THUNK_NAME(func) ";"				\
 	    ".type " PV_THUNK_NAME(func) ", @function;"			\
 	    PV_THUNK_NAME(func) ":"					\
@@ -669,6 +669,9 @@ bool __raw_callee_save___native_vcpu_is_preempted(long cpu);
 	    ".size " PV_THUNK_NAME(func) ", .-" PV_THUNK_NAME(func) ";"	\
 	    ".popsection")
 
+#define PV_CALLEE_SAVE_REGS_THUNK(func)			\
+	__PV_CALLEE_SAVE_REGS_THUNK(func, ".text")
+
 /* Get a reference to a callee-save function */
 #define PV_CALLEE_SAVE(func)						\
 	((struct paravirt_callee_save) { __raw_callee_save_##func })
diff --git a/arch/x86/kernel/irqflags.S b/arch/x86/kernel/irqflags.S
index 8ef3506..760e1f2 100644
--- a/arch/x86/kernel/irqflags.S
+++ b/arch/x86/kernel/irqflags.S
@@ -7,9 +7,11 @@
 /*
  * unsigned long native_save_fl(void)
  */
+.pushsection .noinstr.text, "ax"
 SYM_FUNC_START(native_save_fl)
 	pushf
 	pop %_ASM_AX
 	ret
 SYM_FUNC_END(native_save_fl)
+.popsection
 EXPORT_SYMBOL(native_save_fl)
diff --git a/arch/x86/xen/irq.c b/arch/x86/xen/irq.c
index dfa091d..9c71f43 100644
--- a/arch/x86/xen/irq.c
+++ b/arch/x86/xen/irq.c
@@ -24,7 +24,7 @@ void xen_force_evtchn_callback(void)
 	(void)HYPERVISOR_xen_version(0, NULL);
 }
 
-asmlinkage __visible unsigned long xen_save_fl(void)
+asmlinkage __visible noinstr unsigned long xen_save_fl(void)
 {
 	struct vcpu_info *vcpu;
 	unsigned long flags;
@@ -40,7 +40,7 @@ asmlinkage __visible unsigned long xen_save_fl(void)
 	*/
 	return (-flags) & X86_EFLAGS_IF;
 }
-PV_CALLEE_SAVE_REGS_THUNK(xen_save_fl);
+__PV_CALLEE_SAVE_REGS_THUNK(xen_save_fl, ".noinstr.text");
 
 asmlinkage __visible void xen_irq_disable(void)
 {
diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index aef4a1e..0883e39 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -58,22 +58,6 @@ SYM_FUNC_START(xen_irq_disable_direct)
 SYM_FUNC_END(xen_irq_disable_direct)
 
 /*
- * (xen_)save_fl is used to get the current interrupt enable status.
- * Callers expect the status to be in X86_EFLAGS_IF, and other bits
- * may be set in the return value.  We take advantage of this by
- * making sure that X86_EFLAGS_IF has the right value (and other bits
- * in that byte are 0), but other bits in the return value are
- * undefined.  We need to toggle the state of the bit, because Xen and
- * x86 use opposite senses (mask vs enable).
- */
-SYM_FUNC_START(xen_save_fl_direct)
-	testb $0xff, PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_mask
-	setz %ah
-	addb %ah, %ah
-	ret
-SYM_FUNC_END(xen_save_fl_direct)
-
-/*
  * Force an event check by making a hypercall, but preserve regs
  * before making the call.
  */
@@ -103,6 +87,22 @@ SYM_FUNC_START(check_events)
 SYM_FUNC_END(check_events)
 
 .pushsection .noinstr.text, "ax"
+/*
+ * (xen_)save_fl is used to get the current interrupt enable status.
+ * Callers expect the status to be in X86_EFLAGS_IF, and other bits
+ * may be set in the return value.  We take advantage of this by
+ * making sure that X86_EFLAGS_IF has the right value (and other bits
+ * in that byte are 0), but other bits in the return value are
+ * undefined.  We need to toggle the state of the bit, because Xen and
+ * x86 use opposite senses (mask vs enable).
+ */
+SYM_FUNC_START(xen_save_fl_direct)
+	testb $0xff, PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_mask
+	setz %ah
+	addb %ah, %ah
+	ret
+SYM_FUNC_END(xen_save_fl_direct)
+
 SYM_FUNC_START(xen_read_cr2)
 	FRAME_BEGIN
 	_ASM_MOV PER_CPU_VAR(xen_vcpu), %_ASM_AX
