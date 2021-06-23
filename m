Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27DCA3B235F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:12:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231614AbhFWWOM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbhFWWMx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:12:53 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3B758C061146;
        Wed, 23 Jun 2021 15:09:24 -0700 (PDT)
Date:   Wed, 23 Jun 2021 22:09:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486162;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NPPzFGKLaVJXO0pFYEDCNkjcfrvgaY32ul7wWO4ZAkE=;
        b=XE83ryiKo5x/+EdvaZdDZHK3fhEQte1WY2yIp1txAd1kVJFszhh5D3g00Kpo7z0PT6oZal
        E4WWmvY8lxopd35DJpjuY7EXeNuibMYb2Tw1BRxLFKXt0zTrJPBvgibhiW7e1UPBz/GhOZ
        f7JKskbkNQRhjiKRB9rQfNMpk4HoR9H/c5F0Gu/6Yypu6ASn2232mirlq1cjgiILen7Ehl
        s+MubzFclXPwAilu19yu6D4JTTCOVgWglomRVWeOHzY7PmgBrowUw9VyqSUyiuhPQaJo7V
        V/8zH0cA2f+4g6zyjRUyxpXhr9vC0WtndfkqZBS8RHmoLuwPgu830k+Ba+lDxg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486162;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NPPzFGKLaVJXO0pFYEDCNkjcfrvgaY32ul7wWO4ZAkE=;
        b=HVG/4f9TeuL20zAvWNItdQPzwSGqdmWsuGeTiPKv8YIpEyscQPbQWvYRB7ROkvAju7FvMW
        W8eQU44l0ZpLoVAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Rename fregs-related copy functions
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121454.223594101@linutronix.de>
References: <20210623121454.223594101@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448616157.395.7222806516706909436.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     6fdc908cb56123591baa4259400cfb0787582b11
Gitweb:        https://git.kernel.org/tip/6fdc908cb56123591baa4259400cfb0787582b11
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:01:56 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 18:20:27 +02:00

x86/fpu: Rename fregs-related copy functions

The function names for fnsave/fnrstor operations are horribly named and
a permanent source of confusion.

Rename:
	copy_kernel_to_fregs() to frstor()
	copy_fregs_to_user()   to fnsave_to_user_sigframe()
	copy_user_to_fregs()   to frstor_from_user_sigframe()

so it's clear what these are doing. All these functions are really low
level wrappers around the equally named instructions, so mapping to the
documentation is just natural.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121454.223594101@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h | 10 +++++-----
 arch/x86/kernel/fpu/core.c          |  2 +-
 arch/x86/kernel/fpu/signal.c        |  6 +++---
 3 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 7806f39..cd88233 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -124,7 +124,7 @@ static inline void fpstate_init_soft(struct swregs_state *soft) {}
 		     _ASM_EXTABLE_HANDLE(1b, 2b, ex_handler_fprestore)	\
 		     : output : input)
 
-static inline int copy_fregs_to_user(struct fregs_state __user *fx)
+static inline int fnsave_to_user_sigframe(struct fregs_state __user *fx)
 {
 	return user_insn(fnsave %[fx]; fwait,  [fx] "=m" (*fx), "m" (*fx));
 }
@@ -162,17 +162,17 @@ static inline int fxrstor_from_user_sigframe(struct fxregs_state __user *fx)
 		return user_insn(fxrstorq %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
-static inline void copy_kernel_to_fregs(struct fregs_state *fx)
+static inline void frstor(struct fregs_state *fx)
 {
 	kernel_insn(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
-static inline int copy_kernel_to_fregs_err(struct fregs_state *fx)
+static inline int frstor_safe(struct fregs_state *fx)
 {
 	return kernel_insn_err(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
 
-static inline int copy_user_to_fregs(struct fregs_state __user *fx)
+static inline int frstor_from_user_sigframe(struct fregs_state __user *fx)
 {
 	return user_insn(frstor %[fx], "=m" (*fx), [fx] "m" (*fx));
 }
@@ -385,7 +385,7 @@ static inline void __copy_kernel_to_fpregs(union fpregs_state *fpstate, u64 mask
 		if (use_fxsr())
 			fxrstor(&fpstate->fxsave);
 		else
-			copy_kernel_to_fregs(&fpstate->fsave);
+			frstor(&fpstate->fsave);
 	}
 }
 
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 035487d..1d25876 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -318,7 +318,7 @@ static inline void copy_init_fpstate_to_fpregs(u64 features_mask)
 	else if (use_fxsr())
 		fxrstor(&init_fpstate.fxsave);
 	else
-		copy_kernel_to_fregs(&init_fpstate.fsave);
+		frstor(&init_fpstate.fsave);
 
 	if (boot_cpu_has(X86_FEATURE_OSPKE))
 		copy_init_pkru_to_fpregs();
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 05f8445..430c66d 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -133,7 +133,7 @@ static inline int copy_fpregs_to_sigframe(struct xregs_state __user *buf)
 	else if (use_fxsr())
 		err = fxsave_to_user_sigframe((struct fxregs_state __user *) buf);
 	else
-		err = copy_fregs_to_user((struct fregs_state __user *) buf);
+		err = fnsave_to_user_sigframe((struct fregs_state __user *) buf);
 
 	if (unlikely(err) && __clear_user(buf, fpu_user_xstate_size))
 		err = -EFAULT;
@@ -274,7 +274,7 @@ static int copy_user_to_fpregs_zeroing(void __user *buf, u64 xbv, int fx_only)
 	} else if (use_fxsr()) {
 		return fxrstor_from_user_sigframe(buf);
 	} else
-		return copy_user_to_fregs(buf);
+		return frstor_from_user_sigframe(buf);
 }
 
 static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
@@ -465,7 +465,7 @@ static int __fpu__restore_sig(void __user *buf, void __user *buf_fx, int size)
 			goto out;
 
 		fpregs_lock();
-		ret = copy_kernel_to_fregs_err(&fpu->state.fsave);
+		ret = frstor_safe(&fpu->state.fsave);
 	}
 	if (!ret)
 		fpregs_mark_activate();
