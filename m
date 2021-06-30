Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 787873B838A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:47:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235370AbhF3NuA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235256AbhF3Nt4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:49:56 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55BE2C061766;
        Wed, 30 Jun 2021 06:47:27 -0700 (PDT)
Date:   Wed, 30 Jun 2021 13:47:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060846;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=z+0O4gmSocSHIfxyCoDnZxujbzpjdQSoG2fmfZsXpEo=;
        b=UwD0hXWEYeEk9mBsRfPlnmBpppmIsIzTqpOnNVhOq6A7QawJslX0txIwONyx/uQAUNvzsb
        elSI6zETsHyRK0xDK6nLRhbyx//7UUZK5CH8VEvxF84j4//bMRk5arRAVXXSTr7YgykxxT
        1zGhayexseKJgzm8lmOOoFDoHsnE5EX456AAykoND3WK0oq1vLph4yLBxjeVLEqrk0xLx4
        /pqNcS70VrqEivkx9iW+K6VIhPCeHtvPOTnQNDape0C7KPTpMd7kuwrueA8BduynBtCcxy
        R0Yzq0/mEstX/RzoJH7WVCQA0oF57Cigf4qMuIzGjn4IroGZLURiPlNQ9HZ2cw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060846;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=z+0O4gmSocSHIfxyCoDnZxujbzpjdQSoG2fmfZsXpEo=;
        b=+crS8kKm5C6TsO2k2Abe5FBnfrSHzfxW41BlJ5OBePeopt/9BAoUXMqGZF1d1Jom8PCBGF
        tcLmz0mV44kS0nCg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Improve comments describing RCU read-side
 critical sections
Cc:     Michel Lespinasse <michel@lespinasse.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506084535.395.4381491579446685180.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     1893afd63409111c6edcee9d6e1196fc06cf4fd7
Gitweb:        https://git.kernel.org/tip/1893afd63409111c6edcee9d6e1196fc06cf4fd7
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 29 Apr 2021 11:18:01 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 13 May 2021 09:13:23 -07:00

rcu: Improve comments describing RCU read-side critical sections

There are a number of places that call out the fact that preempt-disable
regions of code now act as RCU read-side critical sections, where
preempt-disable regions of code include irq-disable regions of code,
bh-disable regions of code, hardirq handlers, and NMI handlers.  However,
someone relying solely on (for example) the call_rcu() header comment
might well have no idea that preempt-disable regions of code have RCU
semantics.

This commit therefore updates the header comments for
call_rcu(), synchronize_rcu(), rcu_dereference_bh_check(), and
rcu_dereference_sched_check() to call out these new(ish) forms of RCU
readers.

Reported-by: Michel Lespinasse <michel@lespinasse.org>
[ paulmck: Apply Matthew Wilcox and Michel Lespinasse feedback. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 35 ++++++++++++++++++++++++++++-------
 kernel/rcu/tree.c        | 24 ++++++++++++++----------
 2 files changed, 42 insertions(+), 17 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index b071d02..f0eecb9 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -532,7 +532,12 @@ do {									      \
  * @p: The pointer to read, prior to dereferencing
  * @c: The conditions under which the dereference will take place
  *
- * This is the RCU-bh counterpart to rcu_dereference_check().
+ * This is the RCU-bh counterpart to rcu_dereference_check().  However,
+ * please note that starting in v5.0 kernels, vanilla RCU grace periods
+ * wait for local_bh_disable() regions of code in addition to regions of
+ * code demarked by rcu_read_lock() and rcu_read_unlock().  This means
+ * that synchronize_rcu(), call_rcu, and friends all take not only
+ * rcu_read_lock() but also rcu_read_lock_bh() into account.
  */
 #define rcu_dereference_bh_check(p, c) \
 	__rcu_dereference_check((p), (c) || rcu_read_lock_bh_held(), __rcu)
@@ -543,6 +548,11 @@ do {									      \
  * @c: The conditions under which the dereference will take place
  *
  * This is the RCU-sched counterpart to rcu_dereference_check().
+ * However, please note that starting in v5.0 kernels, vanilla RCU grace
+ * periods wait for preempt_disable() regions of code in addition to
+ * regions of code demarked by rcu_read_lock() and rcu_read_unlock().
+ * This means that synchronize_rcu(), call_rcu, and friends all take not
+ * only rcu_read_lock() but also rcu_read_lock_sched() into account.
  */
 #define rcu_dereference_sched_check(p, c) \
 	__rcu_dereference_check((p), (c) || rcu_read_lock_sched_held(), \
@@ -634,6 +644,12 @@ do {									      \
  * sections, invocation of the corresponding RCU callback is deferred
  * until after the all the other CPUs exit their critical sections.
  *
+ * In v5.0 and later kernels, synchronize_rcu() and call_rcu() also
+ * wait for regions of code with preemption disabled, including regions of
+ * code with interrupts or softirqs disabled.  In pre-v5.0 kernels, which
+ * define synchronize_sched(), only code enclosed within rcu_read_lock()
+ * and rcu_read_unlock() are guaranteed to be waited for.
+ *
  * Note, however, that RCU callbacks are permitted to run concurrently
  * with new RCU read-side critical sections.  One way that this can happen
  * is via the following sequence of events: (1) CPU 0 enters an RCU
@@ -728,9 +744,11 @@ static inline void rcu_read_unlock(void)
 /**
  * rcu_read_lock_bh() - mark the beginning of an RCU-bh critical section
  *
- * This is equivalent of rcu_read_lock(), but also disables softirqs.
- * Note that anything else that disables softirqs can also serve as
- * an RCU read-side critical section.
+ * This is equivalent to rcu_read_lock(), but also disables softirqs.
+ * Note that anything else that disables softirqs can also serve as an RCU
+ * read-side critical section.  However, please note that this equivalence
+ * applies only to v5.0 and later.  Before v5.0, rcu_read_lock() and
+ * rcu_read_lock_bh() were unrelated.
  *
  * Note that rcu_read_lock_bh() and the matching rcu_read_unlock_bh()
  * must occur in the same context, for example, it is illegal to invoke
@@ -763,9 +781,12 @@ static inline void rcu_read_unlock_bh(void)
 /**
  * rcu_read_lock_sched() - mark the beginning of a RCU-sched critical section
  *
- * This is equivalent of rcu_read_lock(), but disables preemption.
- * Read-side critical sections can also be introduced by anything else
- * that disables preemption, including local_irq_disable() and friends.
+ * This is equivalent to rcu_read_lock(), but also disables preemption.
+ * Read-side critical sections can also be introduced by anything else that
+ * disables preemption, including local_irq_disable() and friends.  However,
+ * please note that the equivalence to rcu_read_lock() applies only to
+ * v5.0 and later.  Before v5.0, rcu_read_lock() and rcu_read_lock_sched()
+ * were unrelated.
  *
  * Note that rcu_read_lock_sched() and the matching rcu_read_unlock_sched()
  * must occur in the same context, for example, it is illegal to invoke
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2437960..4b00e4f 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3059,12 +3059,14 @@ __call_rcu(struct rcu_head *head, rcu_callback_t func)
  * period elapses, in other words after all pre-existing RCU read-side
  * critical sections have completed.  However, the callback function
  * might well execute concurrently with RCU read-side critical sections
- * that started after call_rcu() was invoked.  RCU read-side critical
- * sections are delimited by rcu_read_lock() and rcu_read_unlock(), and
- * may be nested.  In addition, regions of code across which interrupts,
- * preemption, or softirqs have been disabled also serve as RCU read-side
- * critical sections.  This includes hardware interrupt handlers, softirq
- * handlers, and NMI handlers.
+ * that started after call_rcu() was invoked.
+ *
+ * RCU read-side critical sections are delimited by rcu_read_lock()
+ * and rcu_read_unlock(), and may be nested.  In addition, but only in
+ * v5.0 and later, regions of code across which interrupts, preemption,
+ * or softirqs have been disabled also serve as RCU read-side critical
+ * sections.  This includes hardware interrupt handlers, softirq handlers,
+ * and NMI handlers.
  *
  * Note that all CPUs must agree that the grace period extended beyond
  * all pre-existing RCU read-side critical section.  On systems with more
@@ -3730,10 +3732,12 @@ static int rcu_blocking_is_gp(void)
  * read-side critical sections have completed.  Note, however, that
  * upon return from synchronize_rcu(), the caller might well be executing
  * concurrently with new RCU read-side critical sections that began while
- * synchronize_rcu() was waiting.  RCU read-side critical sections are
- * delimited by rcu_read_lock() and rcu_read_unlock(), and may be nested.
- * In addition, regions of code across which interrupts, preemption, or
- * softirqs have been disabled also serve as RCU read-side critical
+ * synchronize_rcu() was waiting.
+ *
+ * RCU read-side critical sections are delimited by rcu_read_lock()
+ * and rcu_read_unlock(), and may be nested.  In addition, but only in
+ * v5.0 and later, regions of code across which interrupts, preemption,
+ * or softirqs have been disabled also serve as RCU read-side critical
  * sections.  This includes hardware interrupt handlers, softirq handlers,
  * and NMI handlers.
  *
