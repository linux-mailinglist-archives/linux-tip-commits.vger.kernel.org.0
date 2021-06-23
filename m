Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 009FE3B22F2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 00:08:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbhFWWLP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 18:11:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbhFWWLO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 18:11:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06B79C061756;
        Wed, 23 Jun 2021 15:08:55 -0700 (PDT)
Date:   Wed, 23 Jun 2021 22:08:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624486131;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i/tGz47QI39XVINhH8SfAWMgz5WE1DVQyszCm2FC4C0=;
        b=ZfW3hUEavzRLA6tEVZDKSyPvGfNPbDQx3OHKul2UonlSiumfUJxYG4qXR7wDA74N/D/oua
        K6bhHkfSQV4s+Jr7e6ap3QIpBSiV8w78AHlAG+1ny7QNyx5WFZdtxsJrz5LoqvdTeuwU2k
        bfI0mKE/5rtaoTRFuROYkLgWobWuYLlKDA1/oV0g8XzeLpgtbU/mTRMJH6aNrtpow+Nyl7
        hP2K9EEjgD/Dh6I4BqUWKBsmWxKOSAOhIXGPGHNJfAJLgLjaEygVCnZ20Hw62URk+kKlj+
        R6CQBMlWEc3VcVjy9sQAWeeu+P6NTTGliFt1iUd1Zegv7AuF0REjmWeawD3sPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624486131;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i/tGz47QI39XVINhH8SfAWMgz5WE1DVQyszCm2FC4C0=;
        b=nOjToCj3KxB9kcAlyvrasi40ABaKhxR72VMAqM4ZZpD8hz684Wv6fkYBkR7JXBoq3H1Ba/
        XwfAIvlpIo+WrWCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Return proper error codes from user access functions
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210623121457.601480369@linutronix.de>
References: <20210623121457.601480369@linutronix.de>
MIME-Version: 1.0
Message-ID: <162448613019.395.6925890977526999512.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     aee8c67a4faa40a8df4e79316dbfc92d123989c1
Gitweb:        https://git.kernel.org/tip/aee8c67a4faa40a8df4e79316dbfc92d123989c1
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 23 Jun 2021 14:02:30 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 23 Jun 2021 20:04:58 +02:00

x86/fpu: Return proper error codes from user access functions

When *RSTOR from user memory raises an exception, there is no way to
differentiate them. That's bad because it forces the slow path even when
the failure was not a fault. If the operation raised eg. #GP then going
through the slow path is pointless.

Use _ASM_EXTABLE_FAULT() which stores the trap number and let the exception
fixup return the negated trap number as error.

This allows to separate the fast path and let it handle faults directly and
avoid the slow path for all other exceptions.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210623121457.601480369@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index 528a868..5a18694 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -88,6 +88,7 @@ static inline void fpstate_init_soft(struct swregs_state *soft) {}
 #endif
 extern void save_fpregs_to_fpstate(struct fpu *fpu);
 
+/* Returns 0 or the negated trap number, which results in -EFAULT for #PF */
 #define user_insn(insn, output, input...)				\
 ({									\
 	int err;							\
@@ -95,14 +96,14 @@ extern void save_fpregs_to_fpstate(struct fpu *fpu);
 	might_fault();							\
 									\
 	asm volatile(ASM_STAC "\n"					\
-		     "1:" #insn "\n\t"					\
+		     "1: " #insn "\n"					\
 		     "2: " ASM_CLAC "\n"				\
 		     ".section .fixup,\"ax\"\n"				\
-		     "3:  movl $-1,%[err]\n"				\
+		     "3:  negl %%eax\n"					\
 		     "    jmp  2b\n"					\
 		     ".previous\n"					\
-		     _ASM_EXTABLE(1b, 3b)				\
-		     : [err] "=r" (err), output				\
+		     _ASM_EXTABLE_FAULT(1b, 3b)				\
+		     : [err] "=a" (err), output				\
 		     : "0"(0), input);					\
 	err;								\
 })
@@ -196,16 +197,20 @@ static inline void fxsave(struct fxregs_state *fx)
 #define XRSTOR		".byte " REX_PREFIX "0x0f,0xae,0x2f"
 #define XRSTORS		".byte " REX_PREFIX "0x0f,0xc7,0x1f"
 
+/*
+ * After this @err contains 0 on success or the negated trap number when
+ * the operation raises an exception. For faults this results in -EFAULT.
+ */
 #define XSTATE_OP(op, st, lmask, hmask, err)				\
 	asm volatile("1:" op "\n\t"					\
 		     "xor %[err], %[err]\n"				\
 		     "2:\n\t"						\
 		     ".pushsection .fixup,\"ax\"\n\t"			\
-		     "3: movl $-2,%[err]\n\t"				\
+		     "3: negl %%eax\n\t"				\
 		     "jmp 2b\n\t"					\
 		     ".popsection\n\t"					\
-		     _ASM_EXTABLE(1b, 3b)				\
-		     : [err] "=r" (err)					\
+		     _ASM_EXTABLE_FAULT(1b, 3b)				\
+		     : [err] "=a" (err)					\
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")
 
