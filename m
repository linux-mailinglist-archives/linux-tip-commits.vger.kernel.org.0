Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F1E440F883
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Sep 2021 14:58:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245102AbhIQM73 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Sep 2021 08:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245025AbhIQM71 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Sep 2021 08:59:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9C90C0613CF;
        Fri, 17 Sep 2021 05:58:05 -0700 (PDT)
Date:   Fri, 17 Sep 2021 12:58:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631883484;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=im82DMnZuI8wyEIS0BFfK7xjZiFKuvd2WuPBjg5xI1w=;
        b=DDTJqi1+dUSWtpBDg/A4bpefIksmbaCwYcVKwS2TrTBnIaeMjgCecUWjjblgM6ue6+IGla
        +ZkBoFp4aPA1+4lI+k5SABOonpRZ03ehsx8AsxoNk0fxxIObHbrhjy9gHmdGhLhfDQzBDt
        AUo9t/SEO0P01O7a6hLe2guZkoEUEca9CCIo17tJc7YlYQUkPKvvz1qQKzvYvQke4bblAr
        cNp0iMVg3XBazArVEaud3cUER7pi+yHGoWABei1j62yCDEW5tyWOWBycw06JKIoi6MzmMC
        tKMVLal0A/phw90TqUTf9qtpKwnJPkmH160GGIMj78wiJiYR7iMnNcu4P6kiiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631883484;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=im82DMnZuI8wyEIS0BFfK7xjZiFKuvd2WuPBjg5xI1w=;
        b=xD09aPzmmjsWh5LirfFAvDOgX1jucCjtDia/wrFkWRfFmD3NNfClaVvi1oKdqMdPiCkf38
        lIx71sS7qArNqYBw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/xen: Make irq_disable() noinstr
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210624095148.933869441@infradead.org>
References: <20210624095148.933869441@infradead.org>
MIME-Version: 1.0
Message-ID: <163188348353.25758.4544443640583479049.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     09c413071e2de71d1f28813c560ae0c06b344520
Gitweb:        https://git.kernel.org/tip/09c413071e2de71d1f28813c560ae0c06b344520
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 24 Jun 2021 11:41:20 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Sep 2021 13:20:23 +02:00

x86/xen: Make irq_disable() noinstr

vmlinux.o: warning: objtool: pv_ops[31]: native_irq_disable
vmlinux.o: warning: objtool: pv_ops[31]: __raw_callee_save_xen_irq_disable
vmlinux.o: warning: objtool: pv_ops[31]: xen_irq_disable_direct
vmlinux.o: warning: objtool: lock_is_held_type()+0x5b: call to pv_ops[31]() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20210624095148.933869441@infradead.org
---
 arch/x86/kernel/paravirt.c | 7 ++++++-
 arch/x86/xen/irq.c         | 4 ++--
 arch/x86/xen/xen-asm.S     | 3 +--
 3 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 75f0d24..ebc4536 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -243,6 +243,11 @@ static noinstr void pv_native_irq_enable(void)
 {
 	native_irq_enable();
 }
+
+static noinstr void pv_native_irq_disable(void)
+{
+	native_irq_disable();
+}
 #endif
 
 enum paravirt_lazy_mode paravirt_get_lazy_mode(void)
@@ -306,7 +311,7 @@ struct paravirt_patch_template pv_ops = {
 
 	/* Irq ops. */
 	.irq.save_fl		= __PV_IS_CALLEE_SAVE(native_save_fl),
-	.irq.irq_disable	= __PV_IS_CALLEE_SAVE(native_irq_disable),
+	.irq.irq_disable	= __PV_IS_CALLEE_SAVE(pv_native_irq_disable),
 	.irq.irq_enable		= __PV_IS_CALLEE_SAVE(pv_native_irq_enable),
 	.irq.safe_halt		= native_safe_halt,
 	.irq.halt		= native_halt,
diff --git a/arch/x86/xen/irq.c b/arch/x86/xen/irq.c
index 7fb4cf2..f52b60d 100644
--- a/arch/x86/xen/irq.c
+++ b/arch/x86/xen/irq.c
@@ -42,7 +42,7 @@ asmlinkage __visible noinstr unsigned long xen_save_fl(void)
 }
 __PV_CALLEE_SAVE_REGS_THUNK(xen_save_fl, ".noinstr.text");
 
-asmlinkage __visible void xen_irq_disable(void)
+asmlinkage __visible noinstr void xen_irq_disable(void)
 {
 	/* There's a one instruction preempt window here.  We need to
 	   make sure we're don't switch CPUs between getting the vcpu
@@ -51,7 +51,7 @@ asmlinkage __visible void xen_irq_disable(void)
 	this_cpu_read(xen_vcpu)->evtchn_upcall_mask = 1;
 	preempt_enable_no_resched();
 }
-PV_CALLEE_SAVE_REGS_THUNK(xen_irq_disable);
+__PV_CALLEE_SAVE_REGS_THUNK(xen_irq_disable, ".noinstr.text");
 
 asmlinkage __visible noinstr void xen_irq_enable(void)
 {
diff --git a/arch/x86/xen/xen-asm.S b/arch/x86/xen/xen-asm.S
index 2225195..220dd96 100644
--- a/arch/x86/xen/xen-asm.S
+++ b/arch/x86/xen/xen-asm.S
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/linkage.h>
 
+.pushsection .noinstr.text, "ax"
 /*
  * Disabling events is simply a matter of making the event mask
  * non-zero.
@@ -30,8 +31,6 @@ SYM_FUNC_START(xen_irq_disable_direct)
 	ret
 SYM_FUNC_END(xen_irq_disable_direct)
 
-.pushsection .noinstr.text, "ax"
-
 /*
  * Force an event check by making a hypercall, but preserve regs
  * before making the call.
