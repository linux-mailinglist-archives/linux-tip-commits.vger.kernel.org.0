Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 089332F5FF1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Jan 2021 12:31:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728150AbhANL3o (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 14 Jan 2021 06:29:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728046AbhANL3n (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 14 Jan 2021 06:29:43 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079E5C061757;
        Thu, 14 Jan 2021 03:29:03 -0800 (PST)
Date:   Thu, 14 Jan 2021 11:28:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610623739;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=J42GWu77OoELUcKUDm+C0nApYT5d3OxDVxhszQ9cGEw=;
        b=CCCwyjd1yhewnaDtd4mOrWpONgHJ0OgzjsMFCKvYDbj8v03x+o736JXwm7VLNvChcgtRvq
        Sk4Fq3hpU3iCIsf659eZCpJQ5kFbHT5M7xLtYPMU2fM7f6/N5u+N3EqR08QrTRUXhp+jMx
        2hABle73JBYKzue7F/LuKpY8OrzFhsMFB0uHSpIuBEXWqDu9ExwZ/zFsaN44CTAqilMK3T
        Zbwth8f8GnuRG55nWeu6V46yZnX88LGn2E7mJuJIdTy1oyLlB8LO2BT8frWf9KntfQyNfy
        WcAFee9Fx3Yyxt/DqZerme059OEA1S7FjS/eAzcpL6P2VFE82udq1JeIwTQ66Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610623739;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=J42GWu77OoELUcKUDm+C0nApYT5d3OxDVxhszQ9cGEw=;
        b=NblovBaXlgvADGDwzqGduFdxIH9geUZxpUxWnXshiQQOwV4I2NVhc+R613aViROCTYmae3
        eHrvFvixpJlThNAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/selftests: Add local_lock inversion tests
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161062373868.414.17492998364217228677.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     7e923e6a3ceb877497dd9ee70d71fa33b94f332b
Gitweb:        https://git.kernel.org/tip/7e923e6a3ceb877497dd9ee70d71fa33b94f332b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 09 Dec 2020 16:06:06 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 14 Jan 2021 11:20:18 +01:00

locking/selftests: Add local_lock inversion tests

Test the local_lock_t inversion scenarios.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 lib/locking-selftest.c | 97 +++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 97 insertions(+)

diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index 3306f43..2d85aba 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -24,6 +24,7 @@
 #include <linux/debug_locks.h>
 #include <linux/irqflags.h>
 #include <linux/rtmutex.h>
+#include <linux/local_lock.h>
 
 /*
  * Change this to 1 if you want to see the failure printouts:
@@ -51,6 +52,7 @@ __setup("debug_locks_verbose=", setup_debug_locks_verbose);
 #define LOCKTYPE_RWSEM	0x8
 #define LOCKTYPE_WW	0x10
 #define LOCKTYPE_RTMUTEX 0x20
+#define LOCKTYPE_LL	0x40
 
 static struct ww_acquire_ctx t, t2;
 static struct ww_mutex o, o2, o3;
@@ -136,6 +138,8 @@ static DEFINE_RT_MUTEX(rtmutex_Z2);
 
 #endif
 
+static local_lock_t local_A = INIT_LOCAL_LOCK(local_A);
+
 /*
  * non-inlined runtime initializers, to let separate locks share
  * the same lock-class:
@@ -1314,6 +1318,7 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion3_soft_wlock)
 # define I_MUTEX(x)	lockdep_reset_lock(&mutex_##x.dep_map)
 # define I_RWSEM(x)	lockdep_reset_lock(&rwsem_##x.dep_map)
 # define I_WW(x)	lockdep_reset_lock(&x.dep_map)
+# define I_LOCAL_LOCK(x) lockdep_reset_lock(&local_##x.dep_map)
 #ifdef CONFIG_RT_MUTEXES
 # define I_RTMUTEX(x)	lockdep_reset_lock(&rtmutex_##x.dep_map)
 #endif
@@ -1324,6 +1329,7 @@ GENERATE_PERMUTATIONS_3_EVENTS(irq_read_recursion3_soft_wlock)
 # define I_MUTEX(x)
 # define I_RWSEM(x)
 # define I_WW(x)
+# define I_LOCAL_LOCK(x)
 #endif
 
 #ifndef I_RTMUTEX
@@ -1364,11 +1370,15 @@ static void reset_locks(void)
 	I1(X1); I1(X2); I1(Y1); I1(Y2); I1(Z1); I1(Z2);
 	I_WW(t); I_WW(t2); I_WW(o.base); I_WW(o2.base); I_WW(o3.base);
 	I_RAW_SPINLOCK(A); I_RAW_SPINLOCK(B);
+	I_LOCAL_LOCK(A);
+
 	lockdep_reset();
+
 	I2(A); I2(B); I2(C); I2(D);
 	init_shared_classes();
 	raw_spin_lock_init(&raw_lock_A);
 	raw_spin_lock_init(&raw_lock_B);
+	local_lock_init(&local_A);
 
 	ww_mutex_init(&o, &ww_lockdep); ww_mutex_init(&o2, &ww_lockdep); ww_mutex_init(&o3, &ww_lockdep);
 	memset(&t, 0, sizeof(t)); memset(&t2, 0, sizeof(t2));
@@ -2649,6 +2659,91 @@ static void wait_context_tests(void)
 	pr_cont("\n");
 }
 
+static void local_lock_2(void)
+{
+	local_lock_acquire(&local_A);	/* IRQ-ON */
+	local_lock_release(&local_A);
+
+	HARDIRQ_ENTER();
+	spin_lock(&lock_A);		/* IN-IRQ */
+	spin_unlock(&lock_A);
+	HARDIRQ_EXIT()
+
+	HARDIRQ_DISABLE();
+	spin_lock(&lock_A);
+	local_lock_acquire(&local_A);	/* IN-IRQ <-> IRQ-ON cycle, false */
+	local_lock_release(&local_A);
+	spin_unlock(&lock_A);
+	HARDIRQ_ENABLE();
+}
+
+static void local_lock_3A(void)
+{
+	local_lock_acquire(&local_A);	/* IRQ-ON */
+	spin_lock(&lock_B);		/* IRQ-ON */
+	spin_unlock(&lock_B);
+	local_lock_release(&local_A);
+
+	HARDIRQ_ENTER();
+	spin_lock(&lock_A);		/* IN-IRQ */
+	spin_unlock(&lock_A);
+	HARDIRQ_EXIT()
+
+	HARDIRQ_DISABLE();
+	spin_lock(&lock_A);
+	local_lock_acquire(&local_A);	/* IN-IRQ <-> IRQ-ON cycle only if we count local_lock(), false */
+	local_lock_release(&local_A);
+	spin_unlock(&lock_A);
+	HARDIRQ_ENABLE();
+}
+
+static void local_lock_3B(void)
+{
+	local_lock_acquire(&local_A);	/* IRQ-ON */
+	spin_lock(&lock_B);		/* IRQ-ON */
+	spin_unlock(&lock_B);
+	local_lock_release(&local_A);
+
+	HARDIRQ_ENTER();
+	spin_lock(&lock_A);		/* IN-IRQ */
+	spin_unlock(&lock_A);
+	HARDIRQ_EXIT()
+
+	HARDIRQ_DISABLE();
+	spin_lock(&lock_A);
+	local_lock_acquire(&local_A);	/* IN-IRQ <-> IRQ-ON cycle only if we count local_lock(), false */
+	local_lock_release(&local_A);
+	spin_unlock(&lock_A);
+	HARDIRQ_ENABLE();
+
+	HARDIRQ_DISABLE();
+	spin_lock(&lock_A);
+	spin_lock(&lock_B);		/* IN-IRQ <-> IRQ-ON cycle, true */
+	spin_unlock(&lock_B);
+	spin_unlock(&lock_A);
+	HARDIRQ_DISABLE();
+
+}
+
+static void local_lock_tests(void)
+{
+	printk("  --------------------------------------------------------------------------\n");
+	printk("  | local_lock tests |\n");
+	printk("  ---------------------\n");
+
+	print_testname("local_lock inversion  2");
+	dotest(local_lock_2, SUCCESS, LOCKTYPE_LL);
+	pr_cont("\n");
+
+	print_testname("local_lock inversion 3A");
+	dotest(local_lock_3A, SUCCESS, LOCKTYPE_LL);
+	pr_cont("\n");
+
+	print_testname("local_lock inversion 3B");
+	dotest(local_lock_3B, FAILURE, LOCKTYPE_LL);
+	pr_cont("\n");
+}
+
 void locking_selftest(void)
 {
 	/*
@@ -2775,6 +2870,8 @@ void locking_selftest(void)
 	if (IS_ENABLED(CONFIG_PROVE_RAW_LOCK_NESTING))
 		wait_context_tests();
 
+	local_lock_tests();
+
 	if (unexpected_testcase_failures) {
 		printk("-----------------------------------------------------------------\n");
 		debug_locks = 0;
