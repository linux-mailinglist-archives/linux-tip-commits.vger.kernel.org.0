Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20D7240F889
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Sep 2021 14:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344042AbhIQM7g (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Sep 2021 08:59:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245087AbhIQM72 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Sep 2021 08:59:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE894C061766;
        Fri, 17 Sep 2021 05:58:06 -0700 (PDT)
Date:   Fri, 17 Sep 2021 12:58:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631883485;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uH7uLShBmfRza/HS/nqexw0AsHR/VBdoWUYvKMZ1Q3g=;
        b=No9xT+Wi9hEO423PIZDKlIHyjFUJlBTXj4n3Tzll4o1q3LbjG1BzIwZ6/VIFLdLHl60kSS
        9iahqYLOVBz/4Y6aX1PaWKI6c0vdCHHFOcuw94GJsC0qaq0QGfvbA5Ipci3wYuYo671fav
        D7ONpga8+5lvX5pMQ1ZL2foETHRqYo2MNNQJzoSyYVD+Ba7Xu/PAB479ByHZpk/e86r9n1
        h8U0aIXgEYgCIPVZIt8gjaXsTGIuB/jXwbffp+Zhu/KVrPJ41334dXkBqLsWM36K7Y2gb3
        8A0V0uOI9D2KDicX/2R5GGk99uYsJWD/KEO9t/Z6bEgyZhG3uGbbeUza2Og9gA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631883485;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uH7uLShBmfRza/HS/nqexw0AsHR/VBdoWUYvKMZ1Q3g=;
        b=4DKJudj3BM3XULb5QwgT0YE4pHL42Ac1+f5yCh1Y1nzSpwu196RYcGZYjRfbD8KGUdzoGs
        1xubqkhRmCJ7KLDg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/xen: Make irq_enable() noinstr
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210624095148.872254932@infradead.org>
References: <20210624095148.872254932@infradead.org>
MIME-Version: 1.0
Message-ID: <163188348452.25758.1078497735772312412.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     d7bfc7d57cbe13382fd3eb739667fd0e2f74122b
Gitweb:        https://git.kernel.org/tip/d7bfc7d57cbe13382fd3eb739667fd0e2f74122b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 24 Jun 2021 11:41:19 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Sep 2021 13:17:12 +02:00

x86/xen: Make irq_enable() noinstr

vmlinux.o: warning: objtool: pv_ops[32]: native_irq_enable
vmlinux.o: warning: objtool: pv_ops[32]: __raw_callee_save_xen_irq_enable
vmlinux.o: warning: objtool: pv_ops[32]: xen_irq_enable_direct
vmlinux.o: warning: objtool: lock_is_held_type()+0xfe: call to pv_ops[32]() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20210624095148.872254932@infradead.org
---
 arch/x86/kernel/paravirt.c |  7 ++++-
 arch/x86/xen/irq.c         |  4 +--
 arch/x86/xen/xen-asm.S     | 56 ++++++++++++++++++-------------------
 3 files changed, 36 insertions(+), 31 deletions(-)

diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index cdaf862..75f0d24 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -238,6 +238,11 @@ static noinstr void pv_native_set_debugreg(int regno, unsigned long val)
 {
 	native_set_debugreg(regno, val);
 }
+
+static noinstr void pv_native_irq_enable(void)
+{
+	native_irq_enable();
+}
 #endif
 
 enum paravirt_lazy_mode paravirt_get_lazy_mode(void)
@@ -302,7 +307,7 @@ struct paravirt_patch_template pv_ops = {
 	/* Irq ops. */
 	.irq.save_fl		= __PV_IS_CALLEE_SAVE(native_save_fl),
 	.irq.irq_disable	= __PV_IS_CALLEE_SAVE(native_irq_disable),
-	.irq.irq_enable		= __PV_IS_CALLEE_SAVE(native_irq_enable),
+	.irq.irq_enable		= __PV_IS_CALLEE_SAVE(pv_native_irq_enable),
 	.irq.safe_halt		= native_safe_halt,
 	.irq.halt		= native_halt,
 #endif /* CONFIG_PARAVIRT_XXL */
diff --git a/arch/x86/xen/irq.c b/arch/x86/xen/irq.c
index 9c71f43..7fb4cf2 100644
--- a/arch/x86/xen/irq.c
+++ b/arch/x86/xen/irq.c
@@ -53,7 +53,7 @@ asmlinkage __visible void xen_irq_disable(void)
 }
 PV_CALLEE_SAVE_REGS_THUNK(xen_irq_disable);
 
-asmlinkage __visible void xen_irq_enable(void)
+asmlinkage __visible noinstr void xen_irq_enable(void)
 {
 	struct vcpu_info *vcpu;
 
@@ -76,7 +76,7 @@ asmlinkage __visible void xen_irq_enable(void)
 
 	preempt_enable();
 }
-PV_CALLEE_SAVE_REGS_THUNK(xen_irq_enable);
+__PV_CALLEE_SAVE_REGS_THUNK(xen_irq_enable, ".noinstr.text");
 
 static void xen_safe_halt(void)
 {
diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index 0883e39..2225195 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -22,33 +22,6 @@
 #include <linux/linkage.h>
 
 /*
- * Enable events.  This clears the event mask and tests the pending
- * event status with one and operation.  If there are pending events,
- * then enter the hypervisor to get them handled.
- */
-SYM_FUNC_START(xen_irq_enable_direct)
-	FRAME_BEGIN
-	/* Unmask events */
-	movb $0, PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_mask
-
-	/*
-	 * Preempt here doesn't matter because that will deal with any
-	 * pending interrupts.  The pending check may end up being run
-	 * on the wrong CPU, but that doesn't hurt.
-	 */
-
-	/* Test for pending */
-	testb $0xff, PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_pending
-	jz 1f
-
-	call check_events
-1:
-	FRAME_END
-	ret
-SYM_FUNC_END(xen_irq_enable_direct)
-
-
-/*
  * Disabling events is simply a matter of making the event mask
  * non-zero.
  */
@@ -57,6 +30,8 @@ SYM_FUNC_START(xen_irq_disable_direct)
 	ret
 SYM_FUNC_END(xen_irq_disable_direct)
 
+.pushsection .noinstr.text, "ax"
+
 /*
  * Force an event check by making a hypercall, but preserve regs
  * before making the call.
@@ -86,7 +61,32 @@ SYM_FUNC_START(check_events)
 	ret
 SYM_FUNC_END(check_events)
 
-.pushsection .noinstr.text, "ax"
+/*
+ * Enable events.  This clears the event mask and tests the pending
+ * event status with one and operation.  If there are pending events,
+ * then enter the hypervisor to get them handled.
+ */
+SYM_FUNC_START(xen_irq_enable_direct)
+	FRAME_BEGIN
+	/* Unmask events */
+	movb $0, PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_mask
+
+	/*
+	 * Preempt here doesn't matter because that will deal with any
+	 * pending interrupts.  The pending check may end up being run
+	 * on the wrong CPU, but that doesn't hurt.
+	 */
+
+	/* Test for pending */
+	testb $0xff, PER_CPU_VAR(xen_vcpu_info) + XEN_vcpu_info_pending
+	jz 1f
+
+	call check_events
+1:
+	FRAME_END
+	ret
+SYM_FUNC_END(xen_irq_enable_direct)
+
 /*
  * (xen_)save_fl is used to get the current interrupt enable status.
  * Callers expect the status to be in X86_EFLAGS_IF, and other bits
