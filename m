Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D78B40C8AB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Sep 2021 17:49:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234391AbhIOPuk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 15 Sep 2021 11:50:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234360AbhIOPuk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 15 Sep 2021 11:50:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E86FC061575;
        Wed, 15 Sep 2021 08:49:20 -0700 (PDT)
Date:   Wed, 15 Sep 2021 15:49:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631720959;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6lIgzweGcvoMY/9slesmbDz7IjbT41ON23xchmtTQrg=;
        b=SrFrcTCuppV8jjnKAJqmfips+f1tuA9vYfYnk+0o1oVmvPrgUZ6lKrgcgil9ncUuwJQ3J/
        TtTTpjt+RjJKtLcBseLaTu1FyV6hwaO1Om1wUyx6caErENFLa8MQIFRr2VhJA3rROiBB06
        HDHxZzpNNthaQFSEbdC9p4ag2oXEV+uqX9MZaAXx6UU7gNYy6zbbm3g9HRcfE7mzjsZPSp
        q/fBKtE8I5S491bLnzFDoZGjqLRMEQIlPs3shY8+7QwGJkDodeIWeu78h1sotL2qNUpDLS
        j0LPk25kT2KZ0FbMW+54yBs2mWlRdG3jocSLnd0hpS/7y+lPC4guvq8YBlnXLQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631720959;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6lIgzweGcvoMY/9slesmbDz7IjbT41ON23xchmtTQrg=;
        b=G/QB9uM1cEDp5dEjZzphjV4Bonw9L76GQY9pJqakJwlYcFtKgfSR0UsArGCs+ZESp4el0C
        2jhX/qaBNovGQ3DQ==
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
Message-ID: <163172095854.25758.12386601411775102823.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     bf10b01f581231dc9d25a12dcfec272b981745dc
Gitweb:        https://git.kernel.org/tip/bf10b01f581231dc9d25a12dcfec272b981745dc
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 24 Jun 2021 11:41:20 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Sep 2021 15:51:50 +02:00

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
index a9b97a9..5a804de 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -263,6 +263,11 @@ static noinstr void pv_native_irq_enable(void)
 	native_irq_enable();
 }
 
+static noinstr void pv_native_irq_disable(void)
+{
+	native_irq_disable();
+}
+
 struct paravirt_patch_template pv_ops = {
 	/* Cpu ops. */
 	.cpu.io_delay		= native_io_delay,
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
