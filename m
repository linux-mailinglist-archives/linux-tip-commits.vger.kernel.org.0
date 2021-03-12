Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DECA338BF5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Mar 2021 12:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229532AbhCLLys (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Mar 2021 06:54:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231294AbhCLLyk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Mar 2021 06:54:40 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09BCAC061574;
        Fri, 12 Mar 2021 03:54:40 -0800 (PST)
Date:   Fri, 12 Mar 2021 11:54:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615550078;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=13RM6KdJwh0IlN9E5OqSOdKz2ShwemPhB5xPZFUd3ic=;
        b=MkKCKyABFpdxWlVyCCigyLqvUtXO5TL3Vm9X8gbWgvQMGPpwHEDZ5brgQCnDiW3/rS39ue
        2HzyVgucaqwK3YvHx/5xanDzH/XCaRJd9DRlmBZvw7/qOmUO8FtbbTYaiqf9W1tVVM23d1
        fSPrdVCr/hZvFZldCK91bx+W4D3gYzp7Akv441ccdqygI6iwoGYZhqEZNl4levLq/RBk6t
        QJStYV5aGc/us6g6lfsd+nxTWTPgKtTPGxGXNbaOogqx2ye/muh4ojpP2YKQGAARs4NVA3
        PO7ZW6KrbkN1xIOdD/pVSaZ0iQm72Jbcmgz/E8SXmZ0STdh8yreOEBblGiSfKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615550078;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=13RM6KdJwh0IlN9E5OqSOdKz2ShwemPhB5xPZFUd3ic=;
        b=EAdQZZeFBNGo4KOkknHN+0dftLk8MUqa2uTKrtwnRv5xkAWrcSndQhkSk5cGdN9e1xyC/r
        OKSsj0c7bDgPr8BA==
From:   "tip-bot2 for Juergen Gross" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/paravirt: Switch iret pvops to ALTERNATIVE
Cc:     Juergen Gross <jgross@suse.com>, Borislav Petkov <bp@suse.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210311142319.4723-12-jgross@suse.com>
References: <20210311142319.4723-12-jgross@suse.com>
MIME-Version: 1.0
Message-ID: <161555007795.398.13495680851175333705.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     ae755b5a45482b5de4d96d6f35823076af77445e
Gitweb:        https://git.kernel.org/tip/ae755b5a45482b5de4d96d6f35823076af77445e
Author:        Juergen Gross <jgross@suse.com>
AuthorDate:    Thu, 11 Mar 2021 15:23:16 +01:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 11 Mar 2021 19:58:54 +01:00

x86/paravirt: Switch iret pvops to ALTERNATIVE

The iret paravirt op is rather special as it is using a jmp instead
of a call instruction. Switch it to ALTERNATIVE.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210311142319.4723-12-jgross@suse.com
---
 arch/x86/include/asm/paravirt.h       |  6 +++---
 arch/x86/include/asm/paravirt_types.h |  5 +----
 arch/x86/kernel/asm-offsets.c         |  5 +-----
 arch/x86/kernel/paravirt.c            | 26 ++------------------------
 arch/x86/xen/enlighten_pv.c           |  3 +--
 5 files changed, 7 insertions(+), 38 deletions(-)

diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index a780509..913acf7 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -747,9 +747,9 @@ extern void default_banner(void);
 #define PARA_INDIRECT(addr)	*addr(%rip)
 
 #define INTERRUPT_RETURN						\
-	PARA_SITE(PARA_PATCH(PV_CPU_iret),				\
-		  ANNOTATE_RETPOLINE_SAFE;				\
-		  jmp PARA_INDIRECT(pv_ops+PV_CPU_iret);)
+	ANNOTATE_RETPOLINE_SAFE;					\
+	ALTERNATIVE_TERNARY("jmp *paravirt_iret(%rip);",		\
+		X86_FEATURE_XENPV, "jmp xen_iret;", "jmp native_iret;")
 
 #ifdef CONFIG_DEBUG_ENTRY
 #define SAVE_FLAGS(clobbers)                                        \
diff --git a/arch/x86/include/asm/paravirt_types.h b/arch/x86/include/asm/paravirt_types.h
index 45bd216..0afdac8 100644
--- a/arch/x86/include/asm/paravirt_types.h
+++ b/arch/x86/include/asm/paravirt_types.h
@@ -151,10 +151,6 @@ struct pv_cpu_ops {
 
 	u64 (*read_pmc)(int counter);
 
-	/* Normal iret.  Jump to this with the standard iret stack
-	   frame set up. */
-	void (*iret)(void);
-
 	void (*start_context_switch)(struct task_struct *prev);
 	void (*end_context_switch)(struct task_struct *next);
 #endif
@@ -294,6 +290,7 @@ struct paravirt_patch_template {
 
 extern struct pv_info pv_info;
 extern struct paravirt_patch_template pv_ops;
+extern void (*paravirt_iret)(void);
 
 #define PARAVIRT_PATCH(x)					\
 	(offsetof(struct paravirt_patch_template, x) / sizeof(void *))
diff --git a/arch/x86/kernel/asm-offsets.c b/arch/x86/kernel/asm-offsets.c
index 7365080..ecd3fd6 100644
--- a/arch/x86/kernel/asm-offsets.c
+++ b/arch/x86/kernel/asm-offsets.c
@@ -61,11 +61,6 @@ static void __used common(void)
 	OFFSET(IA32_RT_SIGFRAME_sigcontext, rt_sigframe_ia32, uc.uc_mcontext);
 #endif
 
-#ifdef CONFIG_PARAVIRT_XXL
-	BLANK();
-	OFFSET(PV_CPU_iret, paravirt_patch_template, cpu.iret);
-#endif
-
 #ifdef CONFIG_XEN
 	BLANK();
 	OFFSET(XEN_vcpu_info_mask, vcpu_info, evtchn_upcall_mask);
diff --git a/arch/x86/kernel/paravirt.c b/arch/x86/kernel/paravirt.c
index a688edf..9b0f568 100644
--- a/arch/x86/kernel/paravirt.c
+++ b/arch/x86/kernel/paravirt.c
@@ -86,25 +86,6 @@ u64 notrace _paravirt_ident_64(u64 x)
 {
 	return x;
 }
-
-static unsigned paravirt_patch_jmp(void *insn_buff, const void *target,
-				   unsigned long addr, unsigned len)
-{
-	struct branch *b = insn_buff;
-	unsigned long delta = (unsigned long)target - (addr+5);
-
-	if (len < 5) {
-#ifdef CONFIG_RETPOLINE
-		WARN_ONCE(1, "Failing to patch indirect JMP in %ps\n", (void *)addr);
-#endif
-		return len;	/* call too long for patch site */
-	}
-
-	b->opcode = 0xe9;	/* jmp */
-	b->delta = delta;
-
-	return 5;
-}
 #endif
 
 DEFINE_STATIC_KEY_TRUE(virt_spin_lock_key);
@@ -136,9 +117,6 @@ unsigned paravirt_patch_default(u8 type, void *insn_buff,
 	else if (opfunc == _paravirt_ident_64)
 		ret = paravirt_patch_ident_64(insn_buff, len);
 
-	else if (type == PARAVIRT_PATCH(cpu.iret))
-		/* If operation requires a jmp, then jmp */
-		ret = paravirt_patch_jmp(insn_buff, opfunc, addr, len);
 #endif
 	else
 		/* Otherwise call the function. */
@@ -313,8 +291,6 @@ struct paravirt_patch_template pv_ops = {
 
 	.cpu.load_sp0		= native_load_sp0,
 
-	.cpu.iret		= native_iret,
-
 #ifdef CONFIG_X86_IOPL_IOPERM
 	.cpu.invalidate_io_bitmap	= native_tss_invalidate_io_bitmap,
 	.cpu.update_io_bitmap		= native_tss_update_io_bitmap,
@@ -419,6 +395,8 @@ struct paravirt_patch_template pv_ops = {
 NOKPROBE_SYMBOL(native_get_debugreg);
 NOKPROBE_SYMBOL(native_set_debugreg);
 NOKPROBE_SYMBOL(native_load_idt);
+
+void (*paravirt_iret)(void) = native_iret;
 #endif
 
 EXPORT_SYMBOL(pv_ops);
diff --git a/arch/x86/xen/enlighten_pv.c b/arch/x86/xen/enlighten_pv.c
index dc0a337..08dca7b 100644
--- a/arch/x86/xen/enlighten_pv.c
+++ b/arch/x86/xen/enlighten_pv.c
@@ -1070,8 +1070,6 @@ static const struct pv_cpu_ops xen_cpu_ops __initconst = {
 
 	.read_pmc = xen_read_pmc,
 
-	.iret = xen_iret,
-
 	.load_tr_desc = paravirt_nop,
 	.set_ldt = xen_set_ldt,
 	.load_gdt = xen_load_gdt,
@@ -1235,6 +1233,7 @@ asmlinkage __visible void __init xen_start_kernel(void)
 	pv_info = xen_info;
 	pv_ops.init.patch = paravirt_patch_default;
 	pv_ops.cpu = xen_cpu_ops;
+	paravirt_iret = xen_iret;
 	xen_init_irq_ops();
 
 	/*
