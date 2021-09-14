Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3864D40B7CD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Sep 2021 21:20:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbhINTUt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 14 Sep 2021 15:20:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232764AbhINTUq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 14 Sep 2021 15:20:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61450C061762;
        Tue, 14 Sep 2021 12:19:28 -0700 (PDT)
Date:   Tue, 14 Sep 2021 19:19:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631647167;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8eSBqkJRmo/DzZkRqJxGwkXsKp7jG7WIuI7O4xJC6hk=;
        b=nVnCR+dDD9ti6bf0r4S7cyf244XdeajgOtSu4VyomwQew+FzXXudc3HzFuA+K8q4dyv+Js
        Efz/5CDSEf+X3HO1mFMPSV48wDVHJ/5f3xUS19KGPgRTLcpe+alvUCkRyP/0jFx2ugAHmT
        Hj1QTkvnXfjBYmg9ExC4/rHLqgFxv4v2oTZhoEB1wrMqTzthL0AsM0kxnfrkfdNsZjqKt6
        CqppgIEeaNBihBcWdSi8C5RDjmJS5I8Lo9A5aHU9iL9v1JepftOofeusTSTly6LOqtwYdc
        gIRRYIElwid2eDVFQzrTZhkpkaInsY9+sgB2Ql75WVl4nYFTvvpNcTfaULkINQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631647167;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8eSBqkJRmo/DzZkRqJxGwkXsKp7jG7WIuI7O4xJC6hk=;
        b=WSpPmRqPQ08wV4VHMilWDX+d8UZj14PE14Eeaof6lR2izcm+lYObcWSS/lr818zxp9tI0c
        rkkubPLkt2xXj1Dw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/signal: Change return type of
 fpu__restore_sig() to boolean
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210908132525.909065931@linutronix.de>
References: <20210908132525.909065931@linutronix.de>
MIME-Version: 1.0
Message-ID: <163164716625.25758.11071854219690378092.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     f3305be5feecae62adfa5a6a1441a76493fe7412
Gitweb:        https://git.kernel.org/tip/f3305be5feecae62adfa5a6a1441a76493fe7412
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 08 Sep 2021 15:29:37 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 14 Sep 2021 21:10:03 +02:00

x86/fpu/signal: Change return type of fpu__restore_sig() to boolean

None of the call sites cares about the error code. All they need to know is
whether the function succeeded or not.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210908132525.909065931@linutronix.de
---
 arch/x86/ia32/ia32_signal.c         |  2 +-
 arch/x86/include/asm/fpu/internal.h |  2 +-
 arch/x86/kernel/fpu/signal.c        | 22 ++++++++++------------
 arch/x86/kernel/signal.c            |  4 ++--
 4 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 0d6789b..828ab0a 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -94,7 +94,7 @@ static bool ia32_restore_sigcontext(struct pt_regs *regs,
 	 * normal case.
 	 */
 	reload_segments(&sc);
-	return !fpu__restore_sig(compat_ptr(sc.fpstate), 1);
+	return fpu__restore_sig(compat_ptr(sc.fpstate), 1);
 }
 
 COMPAT_SYSCALL_DEFINE0(sigreturn)
diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 74aa53e..89960e4 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -26,7 +26,7 @@
 /*
  * High level FPU state handling functions:
  */
-extern int  fpu__restore_sig(void __user *buf, int ia32_frame);
+extern bool fpu__restore_sig(void __user *buf, int ia32_frame);
 extern void fpu__drop(struct fpu *fpu);
 extern void fpu__clear_user_states(struct fpu *fpu);
 extern int  fpu__exception_code(struct fpu *fpu, int trap_nr);
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 1d10fe9..d418d28 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -433,17 +433,17 @@ static inline int xstate_sigframe_size(void)
 /*
  * Restore FPU state from a sigframe:
  */
-int fpu__restore_sig(void __user *buf, int ia32_frame)
+bool fpu__restore_sig(void __user *buf, int ia32_frame)
 {
 	unsigned int size = xstate_sigframe_size();
 	struct fpu *fpu = &current->thread.fpu;
 	void __user *buf_fx = buf;
 	bool ia32_fxstate = false;
-	int ret;
+	bool success = false;
 
 	if (unlikely(!buf)) {
 		fpu__clear_user_states(fpu);
-		return 0;
+		return true;
 	}
 
 	ia32_frame &= (IS_ENABLED(CONFIG_X86_32) ||
@@ -459,23 +459,21 @@ int fpu__restore_sig(void __user *buf, int ia32_frame)
 		ia32_fxstate = true;
 	}
 
-	if (!access_ok(buf, size)) {
-		ret = -EACCES;
+	if (!access_ok(buf, size))
 		goto out;
-	}
 
 	if (!IS_ENABLED(CONFIG_X86_64) && !cpu_feature_enabled(X86_FEATURE_FPU)) {
-		ret = fpregs_soft_set(current, NULL, 0,
-				      sizeof(struct user_i387_ia32_struct),
-				      NULL, buf);
+		success = !fpregs_soft_set(current, NULL, 0,
+					   sizeof(struct user_i387_ia32_struct),
+					   NULL, buf);
 	} else {
-		ret = __fpu_restore_sig(buf, buf_fx, ia32_fxstate);
+		success = !__fpu_restore_sig(buf, buf_fx, ia32_fxstate);
 	}
 
 out:
-	if (unlikely(ret))
+	if (unlikely(!success))
 		fpu__clear_user_states(fpu);
-	return ret;
+	return success;
 }
 
 unsigned long
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 140b7b2..02ee68e 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -136,8 +136,8 @@ static bool restore_sigcontext(struct pt_regs *regs,
 		force_valid_ss(regs);
 #endif
 
-	return !fpu__restore_sig((void __user *)sc.fpstate,
-				 IS_ENABLED(CONFIG_X86_32));
+	return fpu__restore_sig((void __user *)sc.fpstate,
+			       IS_ENABLED(CONFIG_X86_32));
 }
 
 static __always_inline int
