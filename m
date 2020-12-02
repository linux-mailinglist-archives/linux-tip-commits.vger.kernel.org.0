Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 722942CB920
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Dec 2020 10:41:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388310AbgLBJjd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 2 Dec 2020 04:39:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388253AbgLBJjJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 2 Dec 2020 04:39:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AADAC0613D6;
        Wed,  2 Dec 2020 01:38:29 -0800 (PST)
Date:   Wed, 02 Dec 2020 09:38:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606901907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+wNEjWovfC5lVEA2MmAphkVW+CuCCuD6x0ulIda0COY=;
        b=qvoN486Ye4LhGLut1d8+dt1e+NFPGkOhvJ6qzgEpUlmfaWzx/5hCfeaaWW/g5oQx4l33Q2
        cR8RDOXVtAOrCiQrb4N0inW/W9bxQbpsn1fPHVPsvu2AfqK+UlMrPcoXIP3cJzUTKvwrfs
        ERI7dF4xliFKWWxUN+nUowJhwJ2vGcXbMxYIZ0ipuOirkmMhWFM0etyLS3U0dVdN5HIs0H
        yW6JlRKfohdXuuOcIaV5fUValAXN7GRiWwp3oFbRfEwO84oaM8e840AW9Ys4Lli+Se5Cz4
        Typ51d+pStc8U0pJl2NIe01Omzo0t26GAAqdQvJgQsQXI6r6dj1AqQNoXp2syQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606901907;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+wNEjWovfC5lVEA2MmAphkVW+CuCCuD6x0ulIda0COY=;
        b=FC3XJXfGgrdFg/E179jE0VQdbvacclIfIMUoy7pC9x0Bjg74YCC5cObGjt/PC38atunF6p
        EZoxClCQ/YH+ARCA==
From:   "tip-bot2 for Sven Schnelle" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] entry_Add_enter_from_user_mode_wrapper
Cc:     Sven Schnelle <svens@linux.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201201142755.31931-4-svens@linux.ibm.com>
References: <20201201142755.31931-4-svens@linux.ibm.com>
MIME-Version: 1.0
Message-ID: <160690190693.3364.6030796869296589113.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     6546601d7e7c8da38f5d87204aa01f7b394f4fb3
Gitweb:        https://git.kernel.org/tip/6546601d7e7c8da38f5d87204aa01f7b394f4fb3
Author:        Sven Schnelle <svens@linux.ibm.com>
AuthorDate:    Tue, 01 Dec 2020 15:27:53 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Dec 2020 10:32:18 +01:00

entry_Add_enter_from_user_mode_wrapper

To be called from architecture specific code if the combo interfaces are
not suitable. It simply calls __enter_from_user_mode(). This way
__enter_from_user_mode will still be inlined because it is declared static
__always_inline.

[ tglx: Amend comments and move it to a different location in the header ]

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201201142755.31931-4-svens@linux.ibm.com

---
 include/linux/entry-common.h | 24 +++++++++++++++++++++++-
 kernel/entry/common.c        | 16 ++++++----------
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index a6e98b4..da60980 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -102,6 +102,27 @@ static inline __must_check int arch_syscall_enter_tracehook(struct pt_regs *regs
 #endif
 
 /**
+ * enter_from_user_mode - Establish state when coming from user mode
+ *
+ * Syscall/interrupt entry disables interrupts, but user mode is traced as
+ * interrupts enabled. Also with NO_HZ_FULL RCU might be idle.
+ *
+ * 1) Tell lockdep that interrupts are disabled
+ * 2) Invoke context tracking if enabled to reactivate RCU
+ * 3) Trace interrupts off state
+ *
+ * Invoked from architecture specific syscall entry code with interrupts
+ * disabled. The calling code has to be non-instrumentable. When the
+ * function returns all state is correct and interrupts are still
+ * disabled. The subsequent functions can be instrumented.
+ *
+ * This is invoked when there is architecture specific functionality to be
+ * done between establishing state and enabling interrupts. The caller must
+ * enable interrupts before invoking syscall_enter_from_user_mode_work().
+ */
+void enter_from_user_mode(struct pt_regs *regs);
+
+/**
  * syscall_enter_from_user_mode_prepare - Establish state and enable interrupts
  * @regs:	Pointer to currents pt_regs
  *
@@ -110,7 +131,8 @@ static inline __must_check int arch_syscall_enter_tracehook(struct pt_regs *regs
  * function returns all state is correct, interrupts are enabled and the
  * subsequent functions can be instrumented.
  *
- * This handles lockdep, RCU (context tracking) and tracing state.
+ * This handles lockdep, RCU (context tracking) and tracing state, i.e.
+ * the functionality provided by enter_from_user_mode().
  *
  * This is invoked when there is extra architecture specific functionality
  * to be done between establishing state and handling user mode entry work.
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index dff07b4..17b1e03 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -10,16 +10,7 @@
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
-/**
- * __enter_from_user_mode - Establish state when coming from user mode
- *
- * Syscall/interrupt entry disables interrupts, but user mode is traced as
- * interrupts enabled. Also with NO_HZ_FULL RCU might be idle.
- *
- * 1) Tell lockdep that interrupts are disabled
- * 2) Invoke context tracking if enabled to reactivate RCU
- * 3) Trace interrupts off state
- */
+/* See comment for enter_from_user_mode() in entry-common.h */
 static __always_inline void __enter_from_user_mode(struct pt_regs *regs)
 {
 	arch_check_user_regs(regs);
@@ -33,6 +24,11 @@ static __always_inline void __enter_from_user_mode(struct pt_regs *regs)
 	instrumentation_end();
 }
 
+void noinstr enter_from_user_mode(struct pt_regs *regs)
+{
+	__enter_from_user_mode(regs);
+}
+
 static inline void syscall_enter_audit(struct pt_regs *regs, long syscall)
 {
 	if (unlikely(audit_context())) {
