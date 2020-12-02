Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 85B5F2CB91E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Dec 2020 10:41:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388250AbgLBJjc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 2 Dec 2020 04:39:32 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:32818 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388224AbgLBJjK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 2 Dec 2020 04:39:10 -0500
Date:   Wed, 02 Dec 2020 09:38:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606901907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ezKbXJ1yIidyCH1EniAMx2ljpJDYSQEezEku9OErR4=;
        b=koG0K/109IsoIj2+N/c+dL2glh0+wnOTPFETnfdLUcluUey6EjASgOVgevEb9oopLZJwPH
        zLfnam5ZvHcgNgDLd99AvMTrgG3sts4wOiYVQEz1Jxysa4VLdYjmAS7yHGLfiBnNg8lq6l
        i3cvXUv/owwk0ttQYC65OGpZqWAo9E/Xc6y98oHNCLla4j2ieaOHZOqZGitSckV7P48gXL
        EcBaKu/csMkoIzmMkR+0Sj439mGUCSAxb6vrqPiIVMUy60YXQbfRwDOQHwDfQInPY+HUvj
        ncz5BtEEaWhTRh1Emq29Vh2KNwrTG0Lb82DMabVgWLmHetOeskmQEoLiGmKt2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606901907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1ezKbXJ1yIidyCH1EniAMx2ljpJDYSQEezEku9OErR4=;
        b=ZzVq8uZa6NzxhzAWgvAJedhGGfRSbdoP3jjZpDepMVHYLQK/QS00doooDXrJ2oyriORW8h
        KPlOT/1jSchdfVDA==
From:   "tip-bot2 for Sven Schnelle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] entry: Add syscall_exit_to_user_mode_work()
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201201142755.31931-6-svens@linux.ibm.com>
References: <20201201142755.31931-6-svens@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <160690190640.3364.10751265538936902967.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     1568b5540b3e6ff3fe43a2cf889cb777cf8149fc
Gitweb:        https://git.kernel.org/tip/1568b5540b3e6ff3fe43a2cf889cb777cf8149fc
Author:        Sven Schnelle <svens@linux.ibm.com>
AuthorDate:    Tue, 01 Dec 2020 15:27:55 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Dec 2020 10:32:18 +01:00

entry: Add syscall_exit_to_user_mode_work()

This is the same as syscall_exit_to_user_mode() but without calling
exit_to_user_mode(). This can be used if there is an architectural reason
to avoid the combo function, e.g. restarting a syscall without returning to
userspace. Before returning to user space the caller has to invoke
exit_to_user_mode().

[ tglx: Amended comments ]

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201201142755.31931-6-svens@linux.ibm.com

---
 include/linux/entry-common.h | 20 ++++++++++++++++++++
 kernel/entry/common.c        | 14 ++++++++++++--
 2 files changed, 32 insertions(+), 2 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index e370be8..7c581a4 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -316,10 +316,26 @@ static inline void arch_syscall_exit_tracehook(struct pt_regs *regs, bool step)
  * is not suitable as the last step before returning to userspace. Must be
  * invoked with interrupts disabled and the caller must be
  * non-instrumentable.
+ * The caller has to invoke syscall_exit_to_user_mode_work() before this.
  */
 void exit_to_user_mode(void);
 
 /**
+ * syscall_exit_to_user_mode_work - Handle work before returning to user mode
+ * @regs:	Pointer to currents pt_regs
+ *
+ * Same as step 1 and 2 of syscall_exit_to_user_mode() but without calling
+ * exit_to_user_mode() to perform the final transition to user mode.
+ *
+ * Calling convention is the same as for syscall_exit_to_user_mode() and it
+ * returns with all work handled and interrupts disabled. The caller must
+ * invoke exit_to_user_mode() before actually switching to user mode to
+ * make the final state transitions. Interrupts must stay disabled between
+ * return from this function and the invocation of exit_to_user_mode().
+ */
+void syscall_exit_to_user_mode_work(struct pt_regs *regs);
+
+/**
  * syscall_exit_to_user_mode - Handle work before returning to user mode
  * @regs:	Pointer to currents pt_regs
  *
@@ -343,6 +359,10 @@ void exit_to_user_mode(void);
  *
  *  3) Final transition (lockdep, tracing, context tracking, RCU), i.e. the
  *     functionality in exit_to_user_mode().
+ *
+ * This is a combination of syscall_exit_to_user_mode_work() (1,2) and
+ * exit_to_user_mode(). This function is preferred unless there is a
+ * compelling architectural reason to use the seperate functions.
  */
 void syscall_exit_to_user_mode(struct pt_regs *regs);
 
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 48d30ce..d6b7393 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -282,12 +282,22 @@ static void syscall_exit_to_user_mode_prepare(struct pt_regs *regs)
 		syscall_exit_work(regs, work);
 }
 
-__visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
+static __always_inline void __syscall_exit_to_user_mode_work(struct pt_regs *regs)
 {
-	instrumentation_begin();
 	syscall_exit_to_user_mode_prepare(regs);
 	local_irq_disable_exit_to_user();
 	exit_to_user_mode_prepare(regs);
+}
+
+void syscall_exit_to_user_mode_work(struct pt_regs *regs)
+{
+	__syscall_exit_to_user_mode_work(regs);
+}
+
+__visible noinstr void syscall_exit_to_user_mode(struct pt_regs *regs)
+{
+	instrumentation_begin();
+	__syscall_exit_to_user_mode_work(regs);
 	instrumentation_end();
 	__exit_to_user_mode();
 }
