Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3533240B7D3
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Sep 2021 21:20:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233096AbhINTUx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 14 Sep 2021 15:20:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35346 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232984AbhINTUu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 14 Sep 2021 15:20:50 -0400
Date:   Tue, 14 Sep 2021 19:19:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631647171;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3JZLVsFXHkNIURkEvPx08cZTRIwfmcaWZXCKcmYjxqk=;
        b=mIgDb58o75LVA7eCQ7KV7BedisIXdgzKlZ7DEu83Z8v8cboMWal3cBa468QcnXie8M+LbS
        bcZbopxHzO34X0T4ayQA/9wNDfHX/5U7q5+EQlsOqKQShSfMGDLKEstHkBgdb5bLxJPp95
        i2D+Fwy5czh49IvOFpYj1DePd1vBTqRGY1xE+hCpdRrYMKQveYsvFJ7npVkqWuSuzWFSPu
        GrQ6RBrJ3i+6hp+Bv+R0p0hdvOtaJET13/VD+gPZxnyIiYBK+sGhuUwgX+TBG18kPGz2ae
        7R+4WTH4ZK9vokQh2kJxYPilzoE9zfcIckGKMJjc4xLLgHqK3vdQ8aeYluSDnQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631647171;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3JZLVsFXHkNIURkEvPx08cZTRIwfmcaWZXCKcmYjxqk=;
        b=1Yc6SEFgnUzQzcIicu8Knb/pK0jPoZ+MBNZiyyqmtXzda//HgT6KcvYKTQy27VGNK8wn4e
        cBlTncYF78shKGDQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu/signal: Clarify exception handling in
 restore_fpregs_from_user()
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210908132525.506192488@linutronix.de>
References: <20210908132525.506192488@linutronix.de>
MIME-Version: 1.0
Message-ID: <163164717094.25758.9209973996162434229.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     4339d0c63c2d5bea1fe6de4091ee2fe9eeea09a7
Gitweb:        https://git.kernel.org/tip/4339d0c63c2d5bea1fe6de4091ee2fe9eeea09a7
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 08 Sep 2021 15:29:26 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 13 Sep 2021 18:26:05 +02:00

x86/fpu/signal: Clarify exception handling in restore_fpregs_from_user()

FPU restore from a signal frame can trigger various exceptions. The
exceptions are caught with an exception table entry. The handler of this
entry stores the trap number in EAX. The FPU specific fixup negates that
trap number to convert it into an negative error code.

Any other exception than #PF is fatal and recovery is not possible. This
relies on the fact that the #PF exception number is the same as EFAULT, but
that's not really obvious.

Remove the negation from the exception fixup as it really has no value and
check for X86_TRAP_PF at the call site.

There is still confusion due to the return code conversion for the error
case which will be cleaned up separately.

Suggested-by: Al Viro <viro@zeniv.linux.org.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20210908132525.506192488@linutronix.de
---
 arch/x86/include/asm/fpu/internal.h | 21 ++++++++-------------
 arch/x86/kernel/fpu/signal.c        |  5 +++--
 2 files changed, 11 insertions(+), 15 deletions(-)

diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index cb1ca60..4cfd40d 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -88,7 +88,10 @@ static inline void fpstate_init_soft(struct swregs_state *soft) {}
 #endif
 extern void save_fpregs_to_fpstate(struct fpu *fpu);
 
-/* Returns 0 or the negated trap number, which results in -EFAULT for #PF */
+/*
+ * Returns 0 on success or the trap number when the operation raises an
+ * exception.
+ */
 #define user_insn(insn, output, input...)				\
 ({									\
 	int err;							\
@@ -98,11 +101,7 @@ extern void save_fpregs_to_fpstate(struct fpu *fpu);
 	asm volatile(ASM_STAC "\n"					\
 		     "1: " #insn "\n"					\
 		     "2: " ASM_CLAC "\n"				\
-		     ".section .fixup,\"ax\"\n"				\
-		     "3:  negl %%eax\n"					\
-		     "    jmp  2b\n"					\
-		     ".previous\n"					\
-		     _ASM_EXTABLE_TYPE(1b, 3b, EX_TYPE_FAULT_MCE_SAFE)	\
+		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_FAULT_MCE_SAFE)	\
 		     : [err] "=a" (err), output				\
 		     : "0"(0), input);					\
 	err;								\
@@ -198,18 +197,14 @@ static inline void fxsave(struct fxregs_state *fx)
 #define XRSTORS		".byte " REX_PREFIX "0x0f,0xc7,0x1f"
 
 /*
- * After this @err contains 0 on success or the negated trap number when
- * the operation raises an exception. For faults this results in -EFAULT.
+ * After this @err contains 0 on success or the trap number when the
+ * operation raises an exception.
  */
 #define XSTATE_OP(op, st, lmask, hmask, err)				\
 	asm volatile("1:" op "\n\t"					\
 		     "xor %[err], %[err]\n"				\
 		     "2:\n\t"						\
-		     ".pushsection .fixup,\"ax\"\n\t"			\
-		     "3: negl %%eax\n\t"				\
-		     "jmp 2b\n\t"					\
-		     ".popsection\n\t"					\
-		     _ASM_EXTABLE_TYPE(1b, 3b, EX_TYPE_FAULT_MCE_SAFE)	\
+		     _ASM_EXTABLE_TYPE(1b, 2b, EX_TYPE_FAULT_MCE_SAFE)	\
 		     : [err] "=a" (err)					\
 		     : "D" (st), "m" (*st), "a" (lmask), "d" (hmask)	\
 		     : "memory")
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 445c57c..9bfffdb 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -13,6 +13,7 @@
 #include <asm/fpu/xstate.h>
 
 #include <asm/sigframe.h>
+#include <asm/trapnr.h>
 #include <asm/trace/fpu.h>
 
 static struct _fpx_sw_bytes fx_sw_reserved __ro_after_init;
@@ -275,7 +276,7 @@ retry:
 		fpregs_unlock();
 
 		/* Try to handle #PF, but anything else is fatal. */
-		if (ret != -EFAULT)
+		if (ret != X86_TRAP_PF)
 			return -EINVAL;
 
 		ret = fault_in_pages_readable(buf, size);
@@ -405,7 +406,7 @@ static int __fpu_restore_sig(void __user *buf, void __user *buf_fx,
 		u64 mask = user_xfeatures | xfeatures_mask_supervisor();
 
 		fpu->state.xsave.header.xfeatures &= mask;
-		ret = os_xrstor_safe(&fpu->state.xsave, xfeatures_mask_all);
+		ret = os_xrstor_safe(&fpu->state.xsave, xfeatures_mask_all) ? -EINVAL : 0;
 	} else {
 		ret = fxrstor_safe(&fpu->state.fxsave);
 	}
