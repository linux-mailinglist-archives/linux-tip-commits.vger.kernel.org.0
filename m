Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8BD8288F68
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 19:03:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390003AbgJIRBm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 13:01:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59278 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389959AbgJIRBb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 13:01:31 -0400
Date:   Fri, 09 Oct 2020 17:01:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602262888;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=bEiGaFe8w2yBnywMFDHpC8wya+x7LPwS1axpjWats5E=;
        b=ISVqq1VPRMcVrC5RPALNNp/X4xxlV3H4UsE4QokQSQhsXUdd63RcZ3J1jFKsLzHbSH1ggp
        F84Qu3MGR5PItTFJzI/kVVERHan8dYQXMJCahXxbYGdRkL7uofG+no9EXExPh1yHe/KtPM
        P27A+u+aCoAkCC7ZNZfFItYnO+ALZZ5FalTDM1JJJ7mZ/Cg24gw4SKnQXWpnoPWlYfl47I
        KlX9NG0+pqHSbCx7gdq+cDAU4/M5ujtYk/RSbfq4Hn8R+VwYrwaXvbWQPJESOxAL2noPcr
        AenbdiUyeJ0TIK6FM5z0R3M2Ei/GaL+QMr+y9DaS85Hsrvw4+vpwnNt1okxFpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602262888;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=bEiGaFe8w2yBnywMFDHpC8wya+x7LPwS1axpjWats5E=;
        b=umuIuKu7b8k8wbX5lAg9l6HlQymZYA8Ke4TGmvN/DQhljqGvAKEgChDszER1nz87Al9QzZ
        mjGY0aUHoW8HyqBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] preempt: Cleanup PREEMPT_COUNT leftovers
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160226288816.7002.14635860661393046833.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     a19bfa918cdfbb43157bb2ab5c8df364b241b77b
Gitweb:        https://git.kernel.org/tip/a19bfa918cdfbb43157bb2ab5c8df364b241b77b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 14 Sep 2020 19:21:01 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 28 Sep 2020 16:03:18 -07:00

preempt: Cleanup PREEMPT_COUNT leftovers

CONFIG_PREEMPT_COUNT is now unconditionally enabled and will be
removed. Cleanup the leftovers before doing so.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ben Segall <bsegall@google.com>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/preempt.h | 37 ++++---------------------------------
 1 file changed, 4 insertions(+), 33 deletions(-)

diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 7d9c1c0..513769b 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -56,8 +56,7 @@
 #define PREEMPT_DISABLED	(PREEMPT_DISABLE_OFFSET + PREEMPT_ENABLED)
 
 /*
- * Disable preemption until the scheduler is running -- use an unconditional
- * value so that it also works on !PREEMPT_COUNT kernels.
+ * Disable preemption until the scheduler is running.
  *
  * Reset by start_kernel()->sched_init()->init_idle()->init_idle_preempt_count().
  */
@@ -69,7 +68,6 @@
  *
  *    preempt_count() == 2*PREEMPT_DISABLE_OFFSET
  *
- * Note: PREEMPT_DISABLE_OFFSET is 0 for !PREEMPT_COUNT kernels.
  * Note: See finish_task_switch().
  */
 #define FORK_PREEMPT_COUNT	(2*PREEMPT_DISABLE_OFFSET + PREEMPT_ENABLED)
@@ -106,11 +104,7 @@
 /*
  * The preempt_count offset after preempt_disable();
  */
-#if defined(CONFIG_PREEMPT_COUNT)
-# define PREEMPT_DISABLE_OFFSET	PREEMPT_OFFSET
-#else
-# define PREEMPT_DISABLE_OFFSET	0
-#endif
+#define PREEMPT_DISABLE_OFFSET	PREEMPT_OFFSET
 
 /*
  * The preempt_count offset after spin_lock()
@@ -122,8 +116,8 @@
  *
  *  spin_lock_bh()
  *
- * Which need to disable both preemption (CONFIG_PREEMPT_COUNT) and
- * softirqs, such that unlock sequences of:
+ * Which need to disable both preemption and softirqs, such that unlock
+ * sequences of:
  *
  *  spin_unlock();
  *  local_bh_enable();
@@ -164,8 +158,6 @@ extern void preempt_count_sub(int val);
 #define preempt_count_inc() preempt_count_add(1)
 #define preempt_count_dec() preempt_count_sub(1)
 
-#ifdef CONFIG_PREEMPT_COUNT
-
 #define preempt_disable() \
 do { \
 	preempt_count_inc(); \
@@ -231,27 +223,6 @@ do { \
 	__preempt_count_dec(); \
 } while (0)
 
-#else /* !CONFIG_PREEMPT_COUNT */
-
-/*
- * Even if we don't have any preemption, we need preempt disable/enable
- * to be barriers, so that we don't have things like get_user/put_user
- * that can cause faults and scheduling migrate into our preempt-protected
- * region.
- */
-#define preempt_disable()			barrier()
-#define sched_preempt_enable_no_resched()	barrier()
-#define preempt_enable_no_resched()		barrier()
-#define preempt_enable()			barrier()
-#define preempt_check_resched()			do { } while (0)
-
-#define preempt_disable_notrace()		barrier()
-#define preempt_enable_no_resched_notrace()	barrier()
-#define preempt_enable_notrace()		barrier()
-#define preemptible()				0
-
-#endif /* CONFIG_PREEMPT_COUNT */
-
 #ifdef MODULE
 /*
  * Modules have no business playing preemption tricks.
