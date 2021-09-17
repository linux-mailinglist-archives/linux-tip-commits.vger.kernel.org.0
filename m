Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7661B40F896
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Sep 2021 14:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344360AbhIQNAD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Sep 2021 09:00:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344159AbhIQM7m (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Sep 2021 08:59:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED0C1C0613DF;
        Fri, 17 Sep 2021 05:58:09 -0700 (PDT)
Date:   Fri, 17 Sep 2021 12:58:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631883488;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4rpblKVnTInS7S+hNH5IXR4xoB86PjJeGLb+3jM973Q=;
        b=c9qpIHmctXONwggb9L40V1Hmn5YBxY+C3HLY8x8RwB238ZhVnKiyWU0fm3dc+L+p7Vf7KX
        EsIrB0ij/9BPUXFXpQAlc4PHUJtfCa3MY1/gD7PKOLQu/0uY+aNncTKJTebwpxOl3vuEV/
        aNJUxG2iEgMdR1sI1kgaMjgw7BpVyicAcz58tC2zOKbJxBnQpko35DFzQwkPqXMeD5zfOQ
        ddyvrkAB3gEXA4C2Kc/yvSWonFUymG0IuWZZYFkndXxUZ+PAuaqm97VMS8aRVU7cvac2ut
        hYQzzrdG1ftC0C9aF+JrrQ2jBaCjAaplHYsgH3lZaFmeoIBkC37NSOPRq1UH0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631883488;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4rpblKVnTInS7S+hNH5IXR4xoB86PjJeGLb+3jM973Q=;
        b=3bJg/kfLVkzgYGz9Byp6NQFvv9UN5hC9HcqxNrPu5/s5F24lgphrBQWfgsdsXnE7CaPJ1r
        aUgims+nyI8/WsCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: objtool/core] x86/xen: Make get_debugreg() noinstr
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juergen Gross <jgross@suse.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210624095148.625523645@infradead.org>
References: <20210624095148.625523645@infradead.org>
MIME-Version: 1.0
Message-ID: <163188348777.25758.635332105493029533.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the objtool/core branch of tip:

Commit-ID:     f4afb713e5c3a4419ba7aaecc31a8c8bd91d13fb
Gitweb:        https://git.kernel.org/tip/f4afb713e5c3a4419ba7aaecc31a8c8bd91d13fb
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 24 Jun 2021 11:41:15 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Sep 2021 13:12:34 +02:00

x86/xen: Make get_debugreg() noinstr

vmlinux.o: warning: objtool: pv_ops[1]: xen_get_debugreg
vmlinux.o: warning: objtool: pv_ops[1]: native_get_debugreg
vmlinux.o: warning: objtool: exc_debug()+0x25: call to pv_ops[1]() leaves .noinstr.text section

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juergen Gross <jgross@suse.com>
Link: https://lore.kernel.org/r/20210624095148.625523645@infradead.org
---
 arch/x86/include/asm/paravirt.h      | 2 +-
 arch/x86/include/asm/xen/hypercall.h | 2 +-
 arch/x86/kernel/paravirt.c           | 8 ++++++--
 arch/x86/xen/enlighten_pv.c          | 2 +-
 4 files changed, 9 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index be82b52..f48465c 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -113,7 +113,7 @@ static inline void __cpuid(unsigned int *eax, unsigned int *ebx,
 /*
  * These special macros can be used to get or set a debugging register
  */
-static inline unsigned long paravirt_get_debugreg(int reg)
+static __always_inline unsigned long paravirt_get_debugreg(int reg)
 {
 	return PVOP_CALL1(unsigned long, cpu.get_debugreg, reg);
 }
diff --git a/arch/x86/include/asm/xen/hypercall.h b/arch/x86/include/asm/xen/hypercall.h
index 454b208..af92202 100644
--- a/arch/x86/include/asm/xen/hypercall.h
+++ b/arch/x86/include/asm/xen/hypercall.h
@@ -314,7 +314,7 @@ HYPERVISOR_set_debugreg(int reg, unsigned long value)
 	return _hypercall2(int, set_debugreg, reg, value);
 }
 
-static inline unsigned long
+static __always_inline unsigned long
 HYPERVISOR_get_debugreg(int reg)
 {
 	return _hypercall1(unsigned long, get_debugreg, reg);
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index fc2cf2b..8af526c 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -228,6 +228,11 @@ static noinstr void pv_native_write_cr2(unsigned long val)
 {
 	native_write_cr2(val);
 }
+
+static noinstr unsigned long pv_native_get_debugreg(int regno)
+{
+	return native_get_debugreg(regno);
+}
 #endif
 
 enum paravirt_lazy_mode paravirt_get_lazy_mode(void)
@@ -254,7 +259,7 @@ struct paravirt_patch_template pv_ops = {
 
 #ifdef CONFIG_PARAVIRT_XXL
 	.cpu.cpuid		= native_cpuid,
-	.cpu.get_debugreg	= native_get_debugreg,
+	.cpu.get_debugreg	= pv_native_get_debugreg,
 	.cpu.set_debugreg	= native_set_debugreg,
 	.cpu.read_cr0		= native_read_cr0,
 	.cpu.write_cr0		= native_write_cr0,
@@ -382,7 +387,6 @@ struct paravirt_patch_template pv_ops = {
 
 #ifdef CONFIG_PARAVIRT_XXL
 /* At this point, native_get/set_debugreg has real function entries */
-NOKPROBE_SYMBOL(native_get_debugreg);
 NOKPROBE_SYMBOL(native_set_debugreg);
 NOKPROBE_SYMBOL(native_load_idt);
 
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index 753f637..273e1fa 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -316,7 +316,7 @@ static void xen_set_debugreg(int reg, unsigned long val)
 	HYPERVISOR_set_debugreg(reg, val);
 }
 
-static unsigned long xen_get_debugreg(int reg)
+static noinstr unsigned long xen_get_debugreg(int reg)
 {
 	return HYPERVISOR_get_debugreg(reg);
 }
