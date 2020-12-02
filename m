Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B16862CBF3A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Dec 2020 15:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbgLBOMo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 2 Dec 2020 09:12:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730211AbgLBOMo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 2 Dec 2020 09:12:44 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06DABC0613D6;
        Wed,  2 Dec 2020 06:12:04 -0800 (PST)
Date:   Wed, 02 Dec 2020 14:12:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606918322;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WPxgew5A6guAqUSSJf4UurbV1iqa02ULtuLbNrRRjs0=;
        b=uLTGeXSFUY6zjoxteo2I+QaQ42qrkfCzeRD5jWVyMlrsjXiR6fIj+VLdxs736WfPBwbXkZ
        wDQ6PQIzw9V9r87tamMOPJ4IMwYia/BKt7cTvDz/oM5FY2CP+pP4G+z5bJBFN+GD7yawnd
        Eeyeipars7kOjd7KNPc69wC0/OCE34XY2+O63d2h0rte8A54RPUdzHBU6akvA9eanNsj7F
        pACim58NuJS4OBnLUAjfWXu229JxiGvRt4HfXevaDRu7pcF1by+uThKRiuGMJyRy2YbL9I
        RAgcxiFu2lL+jvVHVb9j/0/FhckbcHCLdgXFwJ4MrS9lQgGtuH1pOLXNaYcBwA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606918322;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WPxgew5A6guAqUSSJf4UurbV1iqa02ULtuLbNrRRjs0=;
        b=/hbuwHM36SIqirK508Ltv2wWCjlCmA7l+rVTVEsi2MTQCl1vcFVkHBlyjyycJT/meyQSm0
        LmV/n9XKsA+9nYAA==
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
Message-ID: <160691832190.3364.4719149142476327785.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     96e2fbccd0fc806364a964fdf072bfc858a66109
Gitweb:        https://git.kernel.org/tip/96e2fbccd0fc806364a964fdf072bfc858a66109
Author:        Sven Schnelle <svens@linux.ibm.com>
AuthorDate:    Tue, 01 Dec 2020 15:27:53 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Dec 2020 15:07:57 +01:00

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
