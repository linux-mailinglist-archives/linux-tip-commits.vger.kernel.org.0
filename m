Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DE4433F461
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 16:50:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232504AbhCQPtX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 11:49:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51080 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232286AbhCQPsz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 11:48:55 -0400
Date:   Wed, 17 Mar 2021 15:48:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615996134;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6hjnE+IA5FQLSR7yfiBz2zi672OXi5zkFX5blMDwTGA=;
        b=T5fAQtABS4T/H8qNHVGAc7IDh78t1HEFG0glrjidC3L1fdWgIAIaK0g0y5huVuKf2wvDSz
        vaaIw6CWJfwWv6PDCjp4NqnEFEw5Qkf1XogZxMh0iIDpdrTalEMbe9klvJhMMt9Q4El+Cx
        wWWEiypy1h9elNnT44xwDKkqypkPLNfA340n3RftakvsOgIn6r6qqz62SnApz/sJeHZ7sC
        zi/EMLuNo8leGoTw8kXHHvvSqyj9Hnkp6ps8vPxm6dfkOiweHrdn1n4/M27KoxEvdIvUsl
        kYsmN5SWuzIDDiynmkVE8xQRutjSxx0GuFhbPniB4qIy1llai/U/ax36TgCcNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615996134;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6hjnE+IA5FQLSR7yfiBz2zi672OXi5zkFX5blMDwTGA=;
        b=/GT0gRXpSSj6tZMIKk1mfmb7+1KoZd2gjsFnYZfGEJu9Xt0Qo+ta12BUPdBZQI3uGBErP9
        ho6f6jVniLtu/4BA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] softirq: Make softirq control and processing RT aware
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210309085727.426370483@linutronix.de>
References: <20210309085727.426370483@linutronix.de>
MIME-Version: 1.0
Message-ID: <161599613356.398.2321779206858751256.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     8b1c04acad082dec76f3f8f7e1fa13493d6cbb79
Gitweb:        https://git.kernel.org/tip/8b1c04acad082dec76f3f8f7e1fa13493d6cbb79
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 09 Mar 2021 09:55:56 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 17 Mar 2021 16:34:10 +01:00

softirq: Make softirq control and processing RT aware

Provide a local lock based serialization for soft interrupts on RT which
allows the local_bh_disabled() sections and servicing soft interrupts to be
preemptible.

Provide the necessary inline helpers which allow to reuse the bulk of the
softirq processing code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210309085727.426370483@linutronix.de

---
 include/linux/bottom_half.h |   2 +-
 kernel/softirq.c            | 188 +++++++++++++++++++++++++++++++++--
 2 files changed, 182 insertions(+), 8 deletions(-)

diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
index a19519f..e4dd613 100644
--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -4,7 +4,7 @@
 
 #include <linux/preempt.h>
 
-#ifdef CONFIG_TRACE_IRQFLAGS
+#if defined(CONFIG_PREEMPT_RT) || defined(CONFIG_TRACE_IRQFLAGS)
 extern void __local_bh_disable_ip(unsigned long ip, unsigned int cnt);
 #else
 static __always_inline void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
diff --git a/kernel/softirq.c b/kernel/softirq.c
index eaca333..1ed1c55 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -13,6 +13,7 @@
 #include <linux/kernel_stat.h>
 #include <linux/interrupt.h>
 #include <linux/init.h>
+#include <linux/local_lock.h>
 #include <linux/mm.h>
 #include <linux/notifier.h>
 #include <linux/percpu.h>
@@ -103,20 +104,189 @@ EXPORT_PER_CPU_SYMBOL_GPL(hardirq_context);
 #endif
 
 /*
- * preempt_count and SOFTIRQ_OFFSET usage:
- * - preempt_count is changed by SOFTIRQ_OFFSET on entering or leaving
- *   softirq processing.
- * - preempt_count is changed by SOFTIRQ_DISABLE_OFFSET (= 2 * SOFTIRQ_OFFSET)
+ * SOFTIRQ_OFFSET usage:
+ *
+ * On !RT kernels 'count' is the preempt counter, on RT kernels this applies
+ * to a per CPU counter and to task::softirqs_disabled_cnt.
+ *
+ * - count is changed by SOFTIRQ_OFFSET on entering or leaving softirq
+ *   processing.
+ *
+ * - count is changed by SOFTIRQ_DISABLE_OFFSET (= 2 * SOFTIRQ_OFFSET)
  *   on local_bh_disable or local_bh_enable.
+ *
  * This lets us distinguish between whether we are currently processing
  * softirq and whether we just have bh disabled.
  */
+#ifdef CONFIG_PREEMPT_RT
 
-#ifdef CONFIG_TRACE_IRQFLAGS
 /*
- * This is for softirq.c-internal use, where hardirqs are disabled
+ * RT accounts for BH disabled sections in task::softirqs_disabled_cnt and
+ * also in per CPU softirq_ctrl::cnt. This is necessary to allow tasks in a
+ * softirq disabled section to be preempted.
+ *
+ * The per task counter is used for softirq_count(), in_softirq() and
+ * in_serving_softirqs() because these counts are only valid when the task
+ * holding softirq_ctrl::lock is running.
+ *
+ * The per CPU counter prevents pointless wakeups of ksoftirqd in case that
+ * the task which is in a softirq disabled section is preempted or blocks.
+ */
+struct softirq_ctrl {
+	local_lock_t	lock;
+	int		cnt;
+};
+
+static DEFINE_PER_CPU(struct softirq_ctrl, softirq_ctrl) = {
+	.lock	= INIT_LOCAL_LOCK(softirq_ctrl.lock),
+};
+
+void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
+{
+	unsigned long flags;
+	int newcnt;
+
+	WARN_ON_ONCE(in_hardirq());
+
+	/* First entry of a task into a BH disabled section? */
+	if (!current->softirq_disable_cnt) {
+		if (preemptible()) {
+			local_lock(&softirq_ctrl.lock);
+			/* Required to meet the RCU bottomhalf requirements. */
+			rcu_read_lock();
+		} else {
+			DEBUG_LOCKS_WARN_ON(this_cpu_read(softirq_ctrl.cnt));
+		}
+	}
+
+	/*
+	 * Track the per CPU softirq disabled state. On RT this is per CPU
+	 * state to allow preemption of bottom half disabled sections.
+	 */
+	newcnt = __this_cpu_add_return(softirq_ctrl.cnt, cnt);
+	/*
+	 * Reflect the result in the task state to prevent recursion on the
+	 * local lock and to make softirq_count() & al work.
+	 */
+	current->softirq_disable_cnt = newcnt;
+
+	if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && newcnt == cnt) {
+		raw_local_irq_save(flags);
+		lockdep_softirqs_off(ip);
+		raw_local_irq_restore(flags);
+	}
+}
+EXPORT_SYMBOL(__local_bh_disable_ip);
+
+static void __local_bh_enable(unsigned int cnt, bool unlock)
+{
+	unsigned long flags;
+	int newcnt;
+
+	DEBUG_LOCKS_WARN_ON(current->softirq_disable_cnt !=
+			    this_cpu_read(softirq_ctrl.cnt));
+
+	if (IS_ENABLED(CONFIG_TRACE_IRQFLAGS) && softirq_count() == cnt) {
+		raw_local_irq_save(flags);
+		lockdep_softirqs_on(_RET_IP_);
+		raw_local_irq_restore(flags);
+	}
+
+	newcnt = __this_cpu_sub_return(softirq_ctrl.cnt, cnt);
+	current->softirq_disable_cnt = newcnt;
+
+	if (!newcnt && unlock) {
+		rcu_read_unlock();
+		local_unlock(&softirq_ctrl.lock);
+	}
+}
+
+void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
+{
+	bool preempt_on = preemptible();
+	unsigned long flags;
+	u32 pending;
+	int curcnt;
+
+	WARN_ON_ONCE(in_irq());
+	lockdep_assert_irqs_enabled();
+
+	local_irq_save(flags);
+	curcnt = __this_cpu_read(softirq_ctrl.cnt);
+
+	/*
+	 * If this is not reenabling soft interrupts, no point in trying to
+	 * run pending ones.
+	 */
+	if (curcnt != cnt)
+		goto out;
+
+	pending = local_softirq_pending();
+	if (!pending || ksoftirqd_running(pending))
+		goto out;
+
+	/*
+	 * If this was called from non preemptible context, wake up the
+	 * softirq daemon.
+	 */
+	if (!preempt_on) {
+		wakeup_softirqd();
+		goto out;
+	}
+
+	/*
+	 * Adjust softirq count to SOFTIRQ_OFFSET which makes
+	 * in_serving_softirq() become true.
+	 */
+	cnt = SOFTIRQ_OFFSET;
+	__local_bh_enable(cnt, false);
+	__do_softirq();
+
+out:
+	__local_bh_enable(cnt, preempt_on);
+	local_irq_restore(flags);
+}
+EXPORT_SYMBOL(__local_bh_enable_ip);
+
+/*
+ * Invoked from ksoftirqd_run() outside of the interrupt disabled section
+ * to acquire the per CPU local lock for reentrancy protection.
+ */
+static inline void ksoftirqd_run_begin(void)
+{
+	__local_bh_disable_ip(_RET_IP_, SOFTIRQ_OFFSET);
+	local_irq_disable();
+}
+
+/* Counterpart to ksoftirqd_run_begin() */
+static inline void ksoftirqd_run_end(void)
+{
+	__local_bh_enable(SOFTIRQ_OFFSET, true);
+	WARN_ON_ONCE(in_interrupt());
+	local_irq_enable();
+}
+
+static inline void softirq_handle_begin(void) { }
+static inline void softirq_handle_end(void) { }
+
+static inline bool should_wake_ksoftirqd(void)
+{
+	return !this_cpu_read(softirq_ctrl.cnt);
+}
+
+static inline void invoke_softirq(void)
+{
+	if (should_wake_ksoftirqd())
+		wakeup_softirqd();
+}
+
+#else /* CONFIG_PREEMPT_RT */
+
+/*
+ * This one is for softirq.c-internal use, where hardirqs are disabled
  * legitimately:
  */
+#ifdef CONFIG_TRACE_IRQFLAGS
 void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 {
 	unsigned long flags;
@@ -277,6 +447,8 @@ asmlinkage __visible void do_softirq(void)
 	local_irq_restore(flags);
 }
 
+#endif /* !CONFIG_PREEMPT_RT */
+
 /*
  * We restart softirq processing for at most MAX_SOFTIRQ_RESTART times,
  * but break the loop if need_resched() is set or after 2 ms.
@@ -381,8 +553,10 @@ restart:
 		pending >>= softirq_bit;
 	}
 
-	if (__this_cpu_read(ksoftirqd) == current)
+	if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
+	    __this_cpu_read(ksoftirqd) == current)
 		rcu_softirq_qs();
+
 	local_irq_disable();
 
 	pending = local_softirq_pending();
