Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98FF72CBF3C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Dec 2020 15:14:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730221AbgLBOMo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 2 Dec 2020 09:12:44 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34282 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728214AbgLBOMn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 2 Dec 2020 09:12:43 -0500
Date:   Wed, 02 Dec 2020 14:12:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606918322;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AUM2gaFkcDESZlL/Zs/AAuoicx/U5PFmtLiqQr58+Q4=;
        b=xW6QX1POm9lnYSPByR9vy7mZkSbEoDJSsa2hG+Qd4pPyPv9hmNaii78vnaBtSctKdeqyBJ
        JAX8Msim+0ifEAcKt51Zd3wbd9mZ936g2OHe/gL0x300m0mHHNeeJLcsII1+IQ7rsntdnZ
        jRrJnXsr2Hib2h6LBfXZW0cR9fptIVxMz71+YWnURV04DfvUBWVH/bPc6BaSUkkbXz0d0/
        GFN9OBZq+ljLl9BcsZa/L6cpLmh32NHJuWqOWvDNWKUSn0Kf23ude+Yzfjbx8rHY+pSfJa
        71zI04bQxaWwyM+JNyBUBLlrqPSVu+Py9QiRYnDpGA8SJTtaChDNkHFRNW6Lbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606918322;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AUM2gaFkcDESZlL/Zs/AAuoicx/U5PFmtLiqQr58+Q4=;
        b=h/L0Fac2V8Aqe1w66sE1MItVACRTzpPRYxkGhy9IG/GZZVzDidYfjMx8B2dAyLuwDpLr8U
        EikAoKtJnz2LJjBA==
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
Message-ID: <160691832132.3364.8915064201324508166.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     c6156e1da633f241e132eaea3b676d674376d770
Gitweb:        https://git.kernel.org/tip/c6156e1da633f241e132eaea3b676d674376d770
Author:        Sven Schnelle <svens@linux.ibm.com>
AuthorDate:    Tue, 01 Dec 2020 15:27:55 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Dec 2020 15:07:58 +01:00

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
