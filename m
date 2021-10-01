Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 093E241F05E
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Oct 2021 17:05:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354839AbhJAPHZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 1 Oct 2021 11:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354805AbhJAPHV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 1 Oct 2021 11:07:21 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4944C061775;
        Fri,  1 Oct 2021 08:05:31 -0700 (PDT)
Date:   Fri, 01 Oct 2021 15:05:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633100730;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e+f2zsERAo2vVyjF3l1lfHc6PjiAv41dEMfMago4mjo=;
        b=4xK+ywS9CNtWbKNRrt+idGkl3fqRXBnDjmbJhmOfwPbNFXGR0sW+I/mDleSz9ou6i/lv63
        r72orioJeLtZoc7UGF4vPbZvrEqF+nQGOPyibA3fK8ZtF/gnrTNxbJTtRUh794ePIldM6B
        8CqLQ+odYc1X6/bSkIbk80tIzxM3Oq4USX68WsMKJrO+I3JfRGUtqN4QD4SrV97xlq3R7i
        tPYNe+A5fTZX+xFoHbjWsFPbZ9SQQDY022dBQRotV2i+qGH8a5TZhJtsoKhG98/4VG0LLS
        yK/L3RKu40ykCX8VdLldxTMRehgA0opsxFSBDujEtj1SKIH1R1/FVQOxecGrgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633100730;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e+f2zsERAo2vVyjF3l1lfHc6PjiAv41dEMfMago4mjo=;
        b=QVwokyTKntJlb6+cXtcRQSB4UoqtDfb3hTXQu69Uapwqr4ZdrmEUpm9X47m6HKYeLUM8Y5
        GevrZA/OatMZZiDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] sched: Make RCU nest depth distinct in __might_resched()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210923165358.243232823@linutronix.de>
References: <20210923165358.243232823@linutronix.de>
MIME-Version: 1.0
Message-ID: <163310072958.25758.10394451272390798870.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     50e081b96e35e43b65591f40f7376204decd1cb5
Gitweb:        https://git.kernel.org/tip/50e081b96e35e43b65591f40f7376204decd1cb5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 23 Sep 2021 18:54:43 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 01 Oct 2021 13:57:51 +02:00

sched: Make RCU nest depth distinct in __might_resched()

For !RT kernels RCU nest depth in __might_resched() is always expected to
be 0, but on RT kernels it can be non zero while the preempt count is
expected to be always 0.

Instead of playing magic games in interpreting the 'preempt_offset'
argument, rename it to 'offsets' and use the lower 8 bits for the expected
preempt count, allow to hand in the expected RCU nest depth in the upper
bits and adopt the __might_resched() code and related checks and printks.

The affected call sites are updated in subsequent steps.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210923165358.243232823@linutronix.de
---
 include/linux/kernel.h |  4 ++--
 include/linux/sched.h  |  3 +++
 kernel/sched/core.c    | 28 ++++++++++++++++------------
 3 files changed, 21 insertions(+), 14 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index f95ee78..e8696e4 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -111,7 +111,7 @@ static __always_inline void might_resched(void)
 #endif /* CONFIG_PREEMPT_* */
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
-extern void __might_resched(const char *file, int line, int preempt_offset);
+extern void __might_resched(const char *file, int line, unsigned int offsets);
 extern void __might_sleep(const char *file, int line);
 extern void __cant_sleep(const char *file, int line, int preempt_offset);
 extern void __cant_migrate(const char *file, int line);
@@ -169,7 +169,7 @@ extern void __cant_migrate(const char *file, int line);
 # define non_block_end() WARN_ON(current->non_block_count-- == 0)
 #else
   static inline void __might_resched(const char *file, int line,
-				     int preempt_offset) { }
+				     unsigned int offsets) { }
 static inline void __might_sleep(const char *file, int line) { }
 # define might_sleep() do { might_resched(); } while (0)
 # define cant_sleep() do { } while (0)
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 7a989f2..b448c74 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2046,6 +2046,9 @@ extern int __cond_resched_lock(spinlock_t *lock);
 extern int __cond_resched_rwlock_read(rwlock_t *lock);
 extern int __cond_resched_rwlock_write(rwlock_t *lock);
 
+#define MIGHT_RESCHED_RCU_SHIFT		8
+#define MIGHT_RESCHED_PREEMPT_MASK	((1U << MIGHT_RESCHED_RCU_SHIFT) - 1)
+
 #define cond_resched_lock(lock) ({					\
 	__might_resched(__FILE__, __LINE__, PREEMPT_LOCK_OFFSET);	\
 	__cond_resched_lock(lock);					\
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 0a27cb8..8d3fa07 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -9468,12 +9468,6 @@ void __init sched_init(void)
 }
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
-static inline int preempt_count_equals(int preempt_offset)
-{
-	int nested = preempt_count() + rcu_preempt_depth();
-
-	return (nested == preempt_offset);
-}
 
 void __might_sleep(const char *file, int line)
 {
@@ -9505,7 +9499,16 @@ static void print_preempt_disable_ip(int preempt_offset, unsigned long ip)
 	print_ip_sym(KERN_ERR, ip);
 }
 
-void __might_resched(const char *file, int line, int preempt_offset)
+static inline bool resched_offsets_ok(unsigned int offsets)
+{
+	unsigned int nested = preempt_count();
+
+	nested += rcu_preempt_depth() << MIGHT_RESCHED_RCU_SHIFT;
+
+	return nested == offsets;
+}
+
+void __might_resched(const char *file, int line, unsigned int offsets)
 {
 	/* Ratelimiting timestamp: */
 	static unsigned long prev_jiffy;
@@ -9515,7 +9518,7 @@ void __might_resched(const char *file, int line, int preempt_offset)
 	/* WARN_ON_ONCE() by default, no rate limit required: */
 	rcu_sleep_check();
 
-	if ((preempt_count_equals(preempt_offset) && !irqs_disabled() &&
+	if ((resched_offsets_ok(offsets) && !irqs_disabled() &&
 	     !is_idle_task(current) && !current->non_block_count) ||
 	    system_state == SYSTEM_BOOTING || system_state > SYSTEM_RUNNING ||
 	    oops_in_progress)
@@ -9534,11 +9537,11 @@ void __might_resched(const char *file, int line, int preempt_offset)
 	       in_atomic(), irqs_disabled(), current->non_block_count,
 	       current->pid, current->comm);
 	pr_err("preempt_count: %x, expected: %x\n", preempt_count(),
-	       preempt_offset);
+	       offsets & MIGHT_RESCHED_PREEMPT_MASK);
 
 	if (IS_ENABLED(CONFIG_PREEMPT_RCU)) {
-		pr_err("RCU nest depth: %d, expected: 0\n",
-		       rcu_preempt_depth());
+		pr_err("RCU nest depth: %d, expected: %u\n",
+		       rcu_preempt_depth(), offsets >> MIGHT_RESCHED_RCU_SHIFT);
 	}
 
 	if (task_stack_end_corrupted(current))
@@ -9548,7 +9551,8 @@ void __might_resched(const char *file, int line, int preempt_offset)
 	if (irqs_disabled())
 		print_irqtrace_events(current);
 
-	print_preempt_disable_ip(preempt_offset, preempt_disable_ip);
+	print_preempt_disable_ip(offsets & MIGHT_RESCHED_PREEMPT_MASK,
+				 preempt_disable_ip);
 
 	dump_stack();
 	add_taint(TAINT_WARN, LOCKDEP_STILL_OK);
