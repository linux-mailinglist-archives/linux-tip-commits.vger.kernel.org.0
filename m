Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D8B43890A1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 May 2021 16:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347226AbhESOU6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 19 May 2021 10:20:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39748 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239458AbhESOUz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 19 May 2021 10:20:55 -0400
Date:   Wed, 19 May 2021 14:19:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621433973;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fyjJuSe2JWKj2Yl2CKQkhXSkM4G3G/g4lAapaaNE+Gg=;
        b=Icn2pc+QfWuy02vibSdyh/qiblzRWZMuTDGj1cnluUQtMgV+A08X4zzk/gwFIExgMVreMj
        UfwTCYgiju/V3YD7MwNJymWXDT2/HVtYYqAVG/9p7gFsLZVClTbOtMfj+xQRndDz347ZTD
        nHT4YXHnu/iSefTH+3jZRsTttEvdrHe1na3EBOj3AOSdRlDIEKrQEqANcxXpw15vbz/PY/
        K+KQljgzNaoEQoX0jbA/poeJGifNxMs7I5JqXkFK6QNOBlFHM/599PVnKRAT+sL4+MLRY+
        kvNGNk7JL2oZMQ/t1tn/HBL2q4p4aLaCWPYYk2QgTqh9xqnYamU+dcZEKLLrBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621433973;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fyjJuSe2JWKj2Yl2CKQkhXSkM4G3G/g4lAapaaNE+Gg=;
        b=T21pK6/oeU+XTDB3EQv/82UY1A2tVoFxo73swX4ynZ6qb4POxFguDlvpjhZ0R2ya4QKBh4
        JeygzfyiPn9tpRAw==
From:   "tip-bot2 for Chang S. Bae" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/signal: Detect and prevent an alternate signal
 stack overflow
Cc:     Florian Weimer <fweimer@redhat.com>, Jann Horn <jannh@google.com>,
        Andy Lutomirski <luto@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Borislav Petkov <bp@suse.de>, Len Brown <len.brown@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210518200320.17239-6-chang.seok.bae@intel.com>
References: <20210518200320.17239-6-chang.seok.bae@intel.com>
MIME-Version: 1.0
Message-ID: <162143397204.29796.14803503148266105380.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     2beb4a53fc3f1081cedc1c1a198c7f56cc4fc60c
Gitweb:        https://git.kernel.org/tip/2beb4a53fc3f1081cedc1c1a198c7f56cc4fc60c
Author:        Chang S. Bae <chang.seok.bae@intel.com>
AuthorDate:    Tue, 18 May 2021 13:03:19 -07:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 19 May 2021 12:40:30 +02:00

x86/signal: Detect and prevent an alternate signal stack overflow

The kernel pushes context on to the userspace stack to prepare for the
user's signal handler. When the user has supplied an alternate signal
stack, via sigaltstack(2), it is easy for the kernel to verify that the
stack size is sufficient for the current hardware context.

Check if writing the hardware context to the alternate stack will exceed
it's size. If yes, then instead of corrupting user-data and proceeding with
the original signal handler, an immediate SIGSEGV signal is delivered.

Refactor the stack pointer check code from on_sig_stack() and use the new
helper.

While the kernel allows new source code to discover and use a sufficient
alternate signal stack size, this check is still necessary to protect
binaries with insufficient alternate signal stack size from data
corruption.

Fixes: c2bc11f10a39 ("x86, AVX-512: Enable AVX-512 States Context Switch")
Reported-by: Florian Weimer <fweimer@redhat.com>
Suggested-by: Jann Horn <jannh@google.com>
Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Reviewed-by: Len Brown <len.brown@intel.com>
Acked-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20210518200320.17239-6-chang.seok.bae@intel.com
Link: https://bugzilla.kernel.org/show_bug.cgi?id=153531
---
 arch/x86/kernel/signal.c     | 24 ++++++++++++++++++++----
 include/linux/sched/signal.h | 19 ++++++++++++-------
 2 files changed, 32 insertions(+), 11 deletions(-)

diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 86e5386..2ddcf21 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -239,10 +239,11 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 	     void __user **fpstate)
 {
 	/* Default to using normal stack */
+	bool nested_altstack = on_sig_stack(regs->sp);
+	bool entering_altstack = false;
 	unsigned long math_size = 0;
 	unsigned long sp = regs->sp;
 	unsigned long buf_fx = 0;
-	int onsigstack = on_sig_stack(sp);
 	int ret;
 
 	/* redzone */
@@ -251,15 +252,23 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 
 	/* This is the X/Open sanctioned signal stack switching.  */
 	if (ka->sa.sa_flags & SA_ONSTACK) {
-		if (sas_ss_flags(sp) == 0)
+		/*
+		 * This checks nested_altstack via sas_ss_flags(). Sensible
+		 * programs use SS_AUTODISARM, which disables that check, and
+		 * programs that don't use SS_AUTODISARM get compatible.
+		 */
+		if (sas_ss_flags(sp) == 0) {
 			sp = current->sas_ss_sp + current->sas_ss_size;
+			entering_altstack = true;
+		}
 	} else if (IS_ENABLED(CONFIG_X86_32) &&
-		   !onsigstack &&
+		   !nested_altstack &&
 		   regs->ss != __USER_DS &&
 		   !(ka->sa.sa_flags & SA_RESTORER) &&
 		   ka->sa.sa_restorer) {
 		/* This is the legacy signal stack switching. */
 		sp = (unsigned long) ka->sa.sa_restorer;
+		entering_altstack = true;
 	}
 
 	sp = fpu__alloc_mathframe(sp, IS_ENABLED(CONFIG_X86_32),
@@ -272,8 +281,15 @@ get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size,
 	 * If we are on the alternate signal stack and would overflow it, don't.
 	 * Return an always-bogus address instead so we will die with SIGSEGV.
 	 */
-	if (onsigstack && !likely(on_sig_stack(sp)))
+	if (unlikely((nested_altstack || entering_altstack) &&
+		     !__on_sig_stack(sp))) {
+
+		if (show_unhandled_signals && printk_ratelimit())
+			pr_info("%s[%d] overflowed sigaltstack\n",
+				current->comm, task_pid_nr(current));
+
 		return (void __user *)-1L;
+	}
 
 	/* save i387 and extended state */
 	ret = copy_fpstate_to_sigframe(*fpstate, (void __user *)buf_fx, math_size);
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 3f6a0fc..ae60f83 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -537,6 +537,17 @@ static inline int kill_cad_pid(int sig, int priv)
 #define SEND_SIG_NOINFO ((struct kernel_siginfo *) 0)
 #define SEND_SIG_PRIV	((struct kernel_siginfo *) 1)
 
+static inline int __on_sig_stack(unsigned long sp)
+{
+#ifdef CONFIG_STACK_GROWSUP
+	return sp >= current->sas_ss_sp &&
+		sp - current->sas_ss_sp < current->sas_ss_size;
+#else
+	return sp > current->sas_ss_sp &&
+		sp - current->sas_ss_sp <= current->sas_ss_size;
+#endif
+}
+
 /*
  * True if we are on the alternate signal stack.
  */
@@ -554,13 +565,7 @@ static inline int on_sig_stack(unsigned long sp)
 	if (current->sas_ss_flags & SS_AUTODISARM)
 		return 0;
 
-#ifdef CONFIG_STACK_GROWSUP
-	return sp >= current->sas_ss_sp &&
-		sp - current->sas_ss_sp < current->sas_ss_size;
-#else
-	return sp > current->sas_ss_sp &&
-		sp - current->sas_ss_sp <= current->sas_ss_size;
-#endif
+	return __on_sig_stack(sp);
 }
 
 static inline int sas_ss_flags(unsigned long sp)
