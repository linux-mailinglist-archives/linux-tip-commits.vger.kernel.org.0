Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 364CC2CB91B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Dec 2020 10:41:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388259AbgLBJj0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 2 Dec 2020 04:39:26 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:32826 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388250AbgLBJjK (ORCPT
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
        bh=nkzENcagcuVbtLddpJKLtHogLWLHiYuYMHeji2fNcvE=;
        b=JXz4ysoESfGR4Io37NJlBcI+KgBELx9RivgNLGz+HbcnejGpQQ5Kbs7S+LxPaEBK1XavVv
        f+4VeLzxsGly8JIiLyZ61NKgAl4mGdb+e5C4BWrAGiSstrBUQ0+FIEtRrx/4wScFucms4+
        v4EEAd+HvYKHI5owzzduq+NMzMuGj8eSjqW8kokmPvPrjLaawBcQBI4sIxO2TLqrB2lhmN
        gy0G08Qv4qfcasX2XI7udejfNLnYepyC5y+MHFG/orgAxsqyx97aWkP950aOfxBx7Z+EHt
        HaeuQ+6Vmfs8/Qb8se4lC4dIGS4YUNALVEifj8Xn6OExLjRRNKcR9NdMD1bK3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606901907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nkzENcagcuVbtLddpJKLtHogLWLHiYuYMHeji2fNcvE=;
        b=c+dABYsQN1HsDvLoycqOSS7T69xsVGvO0F7Us9wFRssa7H2IP+7ucbZ+i0MUnd+H4xF3xV
        jo87yLKY9vX067AQ==
From:   "tip-bot2 for Sven Schnelle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] entry: Add exit_to_user_mode() wrapper
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201201142755.31931-5-svens@linux.ibm.com>
References: <20201201142755.31931-5-svens@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <160690190672.3364.7128119989932562048.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     7918e4b844d1481c2200445f758bb2d1cd14346c
Gitweb:        https://git.kernel.org/tip/7918e4b844d1481c2200445f758bb2d1cd14346c
Author:        Sven Schnelle <svens@linux.ibm.com>
AuthorDate:    Tue, 01 Dec 2020 15:27:54 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Dec 2020 10:32:18 +01:00

entry: Add exit_to_user_mode() wrapper

Called from architecture specific code when syscall_exit_to_user_mode() is
not suitable. It simply calls __exit_to_user_mode().

This way __exit_to_user_mode() can still be inlined because it is declared
static __always_inline.

[ tglx: Amended comments and moved it to a different place in the header ]

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201201142755.31931-5-svens@linux.ibm.com

---
 include/linux/entry-common.h | 23 +++++++++++++++++++++--
 kernel/entry/common.c        | 18 ++++++------------
 2 files changed, 27 insertions(+), 14 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index da60980..e370be8 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -301,6 +301,25 @@ static inline void arch_syscall_exit_tracehook(struct pt_regs *regs, bool step)
 #endif
 
 /**
+ * exit_to_user_mode - Fixup state when exiting to user mode
+ *
+ * Syscall/interrupt exit enables interrupts, but the kernel state is
+ * interrupts disabled when this is invoked. Also tell RCU about it.
+ *
+ * 1) Trace interrupts on state
+ * 2) Invoke context tracking if enabled to adjust RCU state
+ * 3) Invoke architecture specific last minute exit code, e.g. speculation
+ *    mitigations, etc.: arch_exit_to_user_mode()
+ * 4) Tell lockdep that interrupts are enabled
+ *
+ * Invoked from architecture specific code when syscall_exit_to_user_mode()
+ * is not suitable as the last step before returning to userspace. Must be
+ * invoked with interrupts disabled and the caller must be
+ * non-instrumentable.
+ */
+void exit_to_user_mode(void);
+
+/**
  * syscall_exit_to_user_mode - Handle work before returning to user mode
  * @regs:	Pointer to currents pt_regs
  *
@@ -322,8 +341,8 @@ static inline void arch_syscall_exit_tracehook(struct pt_regs *regs, bool step)
  *	- Architecture specific one time work arch_exit_to_user_mode_prepare()
  *	- Address limit and lockdep checks
  *
- *  3) Final transition (lockdep, tracing, context tracking, RCU). Invokes
- *     arch_exit_to_user_mode() to handle e.g. speculation mitigations
+ *  3) Final transition (lockdep, tracing, context tracking, RCU), i.e. the
+ *     functionality in exit_to_user_mode().
  */
 void syscall_exit_to_user_mode(struct pt_regs *regs);
 
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 17b1e03..48d30ce 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -117,18 +117,7 @@ noinstr void syscall_enter_from_user_mode_prepare(struct pt_regs *regs)
 	instrumentation_end();
 }
 
-/**
- * __exit_to_user_mode - Fixup state when exiting to user mode
- *
- * Syscall/interupt exit enables interrupts, but the kernel state is
- * interrupts disabled when this is invoked. Also tell RCU about it.
- *
- * 1) Trace interrupts on state
- * 2) Invoke context tracking if enabled to adjust RCU state
- * 3) Invoke architecture specific last minute exit code, e.g. speculation
- *    mitigations, etc.
- * 4) Tell lockdep that interrupts are enabled
- */
+/* See comment for exit_to_user_mode() in entry-common.h */
 static __always_inline void __exit_to_user_mode(void)
 {
 	instrumentation_begin();
@@ -141,6 +130,11 @@ static __always_inline void __exit_to_user_mode(void)
 	lockdep_hardirqs_on(CALLER_ADDR0);
 }
 
+void noinstr exit_to_user_mode(void)
+{
+	__exit_to_user_mode();
+}
+
 /* Workaround to allow gradual conversion of architecture code */
 void __weak arch_do_signal_or_restart(struct pt_regs *regs, bool has_signal) { }
 
