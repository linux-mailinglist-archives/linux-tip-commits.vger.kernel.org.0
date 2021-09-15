Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EF4D40C8B8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Sep 2021 17:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238138AbhIOPur (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 15 Sep 2021 11:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50110 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234567AbhIOPun (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 15 Sep 2021 11:50:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09009C061574;
        Wed, 15 Sep 2021 08:49:24 -0700 (PDT)
Date:   Wed, 15 Sep 2021 15:49:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631720962;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gMTWuZOjeV1lzP+FbhjQmO5WUhrduxvmqR8KciPFgko=;
        b=tOANiI8+7KQ8fup1/c0R/MD89Je0uNzJJcjdUovUJb4KbdPjWfs89MC0kQsbaYFJdvtsxA
        Rm10NAiW/mK8t/Aa7XmT3Q86Y95mKo6RqVCPB5SbSkhpE9GwcL0VuMKAths+Vu0TxpFJpE
        3d6MyFRvkyL0zpiRAg15saeJyiyNcnEXjvx5RU7n6vos20MldKQtQksPOOSIcH87ZAqrb5
        OsZgY9hNrmxRqseWONZpG/AomfqyHBseMKl3N2JM4WIxG2u0Rr2hLrUlBLxnVDX4Uw+ron
        m5kfotMGlOQosRtCuvCa1SWtOwQdvn1MQm5j5/AjRNGKQUC5UtDQUH+MSzS8zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631720962;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gMTWuZOjeV1lzP+FbhjQmO5WUhrduxvmqR8KciPFgko=;
        b=UVzFRTUh/acLFWm22Do3uSeB/DExKEmrZsiWhHV0UX2TwI2FGo2Y8jnbVtD+/vpOAz2rEc
        8TMwLHG79zMQGICA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/xen: Make set_debugreg() noinstr
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210624095148.687755639@infradead.org>
References: <20210624095148.687755639@infradead.org>
MIME-Version: 1.0
Message-ID: <163172096181.25758.8930025934141730355.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     9da62cacc7ed17e2186f82273762fe850078c8c3
Gitweb:        https://git.kernel.org/tip/9da62cacc7ed17e2186f82273762fe850078c8c3
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 24 Jun 2021 11:41:16 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 15 Sep 2021 15:51:49 +02:00

x86/xen: Make set_debugreg() noinstr

vmlinux.o: warning: objtool: pv_ops[2]: xen_set_debugreg
vmlinux.o: warning: objtool: pv_ops[2]: native_set_debugreg
vmlinux.o: warning: objtool: exc_debug()+0x3b: call to pv_ops[2]() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20210624095148.687755639@infradead.org
---
 arch/x86/include/asm/paravirt.h      |  2 +-
 arch/x86/include/asm/xen/hypercall.h |  2 +-
 arch/x86/kernel/paravirt.c           |  9 ++++++---
 arch/x86/xen/enlighten_pv.c          |  2 +-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index f48465c..34da790 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -118,7 +118,7 @@ static __always_inline unsigned long paravirt_get_debugreg(int reg)
 	return PVOP_CALL1(unsigned long, cpu.get_debugreg, reg);
 }
 #define get_debugreg(var, reg) var = paravirt_get_debugreg(reg)
-static inline void set_debugreg(unsigned long val, int reg)
+static __always_inline void set_debugreg(unsigned long val, int reg)
 {
 	PVOP_VCALL2(cpu.set_debugreg, reg, val);
 }
diff --git a/arch/x86/include/asm/xen/hypercall.h b/arch/x86/include/asm/xen/hypercall.h
index af92202..990b8aa 100644
--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -308,7 +308,7 @@ HYPERVISOR_platform_op(struct xen_platform_op *op)
 	return _hypercall1(int, platform_op, op);
 }
 
-static inline int
+static __always_inline int
 HYPERVISOR_set_debugreg(int reg, unsigned long value)
 {
 	return _hypercall2(int, set_debugreg, reg, value);
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index 9188ae1..4d98791 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -253,6 +253,11 @@ static noinstr unsigned long pv_native_get_debugreg(int regno)
 	return native_get_debugreg(regno);
 }
 
+static noinstr void pv_native_set_debugreg(int regno, unsigned long val)
+{
+	native_set_debugreg(regno, val);
+}
+
 struct paravirt_patch_template pv_ops = {
 	/* Cpu ops. */
 	.cpu.io_delay		= native_io_delay,
@@ -260,7 +265,7 @@ struct paravirt_patch_template pv_ops = {
 #ifdef CONFIG_PARAVIRT_XXL
 	.cpu.cpuid		= native_cpuid,
 	.cpu.get_debugreg	= pv_native_get_debugreg,
-	.cpu.set_debugreg	= native_set_debugreg,
+	.cpu.set_debugreg	= pv_native_set_debugreg,
 	.cpu.read_cr0		= native_read_cr0,
 	.cpu.write_cr0		= native_write_cr0,
 	.cpu.write_cr4		= native_write_cr4,
@@ -386,8 +391,6 @@ struct paravirt_patch_template pv_ops = {
 };
 
 #ifdef CONFIG_PARAVIRT_XXL
-/* At this point, native_get/set_debugreg has real function entries */
-NOKPROBE_SYMBOL(native_set_debugreg);
 NOKPROBE_SYMBOL(native_load_idt);
 
 void (*paravirt_iret)(void) = native_iret;
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 273e1fa..2b1a8ba 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -311,7 +311,7 @@ static void __init xen_init_capabilities(void)
 	}
 }
 
-static void xen_set_debugreg(int reg, unsigned long val)
+static noinstr void xen_set_debugreg(int reg, unsigned long val)
 {
 	HYPERVISOR_set_debugreg(reg, val);
 }
