Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB96540B7CF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Sep 2021 21:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbhINTUu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 14 Sep 2021 15:20:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232823AbhINTUr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 14 Sep 2021 15:20:47 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38F29C061574;
        Tue, 14 Sep 2021 12:19:29 -0700 (PDT)
Date:   Tue, 14 Sep 2021 19:19:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631647167;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=on1JkDflhSlHGAgIMNmx25YtGtiz9D4EzPF2GY7fwrU=;
        b=I4kcrduyg7jNZtJiiu43ETPNkVIP7jOrTQrolAeOgNRzgEzG1A2ws6CQgRnQKSvYcRJd1U
        CSnBC4v8TOQI0x63dpKJglMxfb38VM42V9dByPs1kk3bM9RKKys6syeZ5GUbFvxv/+27NY
        6TTh42MtHBlNoypMs+cvKActO+FzmhvZrp1QIStSmOg7lb0elBR9I83X67uTrOTZJOWjKu
        2auwx8rImbW+dvZXlDvvLXrnl9Zrd4VB4aakO8HmvUcLHyXObI4aFI8+mMijG/jeudA9ay
        e+R+taw+WB7/z/vqfAFAdBNgY2K07N8KRp+gvGkL5qXG0tbtpjsNAyU2MN9R+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631647167;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=on1JkDflhSlHGAgIMNmx25YtGtiz9D4EzPF2GY7fwrU=;
        b=RjezS2ZU/fx6ZWiPPO1GxrtI0krzNaq0NnjYUUAzOfBGWYcfPBK5W0AMWnXbJL8uBqIECL
        hCG+NY1G5BHC0nBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/signal: Change return type of restore_sigcontext()
 to boolean
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210908132525.851280949@linutronix.de>
References: <20210908132525.851280949@linutronix.de>
MIME-Version: 1.0
Message-ID: <163164716703.25758.16541621557684628922.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     ee4ecdfbd28954086a09740dc931c10c93e39370
Gitweb:        https://git.kernel.org/tip/ee4ecdfbd28954086a09740dc931c10c93e39370
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 08 Sep 2021 15:29:35 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 14 Sep 2021 21:10:03 +02:00

x86/signal: Change return type of restore_sigcontext() to boolean

None of the call sites cares about the return code. All they are interested
in is success or fail.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210908132525.851280949@linutronix.de
---
 arch/x86/ia32/ia32_signal.c | 12 ++++++------
 arch/x86/kernel/signal.c    | 18 +++++++++---------
 2 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 023198e..0d6789b 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -57,8 +57,8 @@ static inline void reload_segments(struct sigcontext_32 *sc)
 /*
  * Do a signal return; undo the signal stack.
  */
-static int ia32_restore_sigcontext(struct pt_regs *regs,
-				   struct sigcontext_32 __user *usc)
+static bool ia32_restore_sigcontext(struct pt_regs *regs,
+				    struct sigcontext_32 __user *usc)
 {
 	struct sigcontext_32 sc;
 
@@ -66,7 +66,7 @@ static int ia32_restore_sigcontext(struct pt_regs *regs,
 	current->restart_block.fn = do_no_restart_syscall;
 
 	if (unlikely(copy_from_user(&sc, usc, sizeof(sc))))
-		return -EFAULT;
+		return false;
 
 	/* Get only the ia32 registers. */
 	regs->bx = sc.bx;
@@ -94,7 +94,7 @@ static int ia32_restore_sigcontext(struct pt_regs *regs,
 	 * normal case.
 	 */
 	reload_segments(&sc);
-	return fpu__restore_sig(compat_ptr(sc.fpstate), 1);
+	return !fpu__restore_sig(compat_ptr(sc.fpstate), 1);
 }
 
 COMPAT_SYSCALL_DEFINE0(sigreturn)
@@ -111,7 +111,7 @@ COMPAT_SYSCALL_DEFINE0(sigreturn)
 
 	set_current_blocked(&set);
 
-	if (ia32_restore_sigcontext(regs, &frame->sc))
+	if (!ia32_restore_sigcontext(regs, &frame->sc))
 		goto badframe;
 	return regs->ax;
 
@@ -135,7 +135,7 @@ COMPAT_SYSCALL_DEFINE0(rt_sigreturn)
 
 	set_current_blocked(&set);
 
-	if (ia32_restore_sigcontext(regs, &frame->uc.uc_mcontext))
+	if (!ia32_restore_sigcontext(regs, &frame->uc.uc_mcontext))
 		goto badframe;
 
 	if (compat_restore_altstack(&frame->uc.uc_stack))
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 5f623a1..140b7b2 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -79,9 +79,9 @@ static void force_valid_ss(struct pt_regs *regs)
 # define CONTEXT_COPY_SIZE	sizeof(struct sigcontext)
 #endif
 
-static int restore_sigcontext(struct pt_regs *regs,
-			      struct sigcontext __user *usc,
-			      unsigned long uc_flags)
+static bool restore_sigcontext(struct pt_regs *regs,
+			       struct sigcontext __user *usc,
+			       unsigned long uc_flags)
 {
 	struct sigcontext sc;
 
@@ -89,7 +89,7 @@ static int restore_sigcontext(struct pt_regs *regs,
 	current->restart_block.fn = do_no_restart_syscall;
 
 	if (copy_from_user(&sc, usc, CONTEXT_COPY_SIZE))
-		return -EFAULT;
+		return false;
 
 #ifdef CONFIG_X86_32
 	set_user_gs(regs, sc.gs);
@@ -136,8 +136,8 @@ static int restore_sigcontext(struct pt_regs *regs,
 		force_valid_ss(regs);
 #endif
 
-	return fpu__restore_sig((void __user *)sc.fpstate,
-			       IS_ENABLED(CONFIG_X86_32));
+	return !fpu__restore_sig((void __user *)sc.fpstate,
+				 IS_ENABLED(CONFIG_X86_32));
 }
 
 static __always_inline int
@@ -641,7 +641,7 @@ SYSCALL_DEFINE0(sigreturn)
 	 * x86_32 has no uc_flags bits relevant to restore_sigcontext.
 	 * Save a few cycles by skipping the __get_user.
 	 */
-	if (restore_sigcontext(regs, &frame->sc, 0))
+	if (!restore_sigcontext(regs, &frame->sc, 0))
 		goto badframe;
 	return regs->ax;
 
@@ -669,7 +669,7 @@ SYSCALL_DEFINE0(rt_sigreturn)
 
 	set_current_blocked(&set);
 
-	if (restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
+	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
 		goto badframe;
 
 	if (restore_altstack(&frame->uc.uc_stack))
@@ -927,7 +927,7 @@ COMPAT_SYSCALL_DEFINE0(x32_rt_sigreturn)
 
 	set_current_blocked(&set);
 
-	if (restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
+	if (!restore_sigcontext(regs, &frame->uc.uc_mcontext, uc_flags))
 		goto badframe;
 
 	if (compat_restore_altstack(&frame->uc.uc_stack))
