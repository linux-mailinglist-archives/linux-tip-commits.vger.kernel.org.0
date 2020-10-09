Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A058E2884A9
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 10:02:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732691AbgJIIAM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 04:00:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56152 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732479AbgJIH6s (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 03:58:48 -0400
Date:   Fri, 09 Oct 2020 07:58:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602230325;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g/8bIQioG+lGE9iNKcOh+0Csa92HACZFGeAANgOSsYo=;
        b=nMpTN6HStqj6JHPqEUQJYqo0HB5KZ3UWtxBnvQP+06e8cycqv93JGsYvELjpHKBv8bC4/j
        3mmHzCsad7ij/rqJ76/CpJPNQM0HTxRJ3HwjA+sPKT5Y07643BtZa6yfKBDVb1mNctRSKp
        qTB+usNeCzWpyuffb9nFPmBIJFqFhfhUNHuqS5Iw+rLOYgkDJz6HBSdZSS4LOIHxjqiy8p
        NUSQsx7r6tksubv5FJCwQJoI6fq1df1jk7jLdhDSXnQwxZm+Agh/ldoaHZgjI2SxMIYEBM
        OZjlYv8WNb+MGxxrT8zcRD2LLvuMxXglr1t4fdeUGdP20+r8yN3JGeUQQ2n4AQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602230325;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=g/8bIQioG+lGE9iNKcOh+0Csa92HACZFGeAANgOSsYo=;
        b=+69QO63XustR/Nn3DH9u0Bek0gRPa4EfQc9PNoEs9khkH4BggIeH24qawsQsC30DNf5ULn
        qx/FiL6SQRfb85Aw==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] kcsan: Use tracing-safe version of prandom
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200821063043.1949509-1-elver@google.com>
References: <20200821063043.1949509-1-elver@google.com>
MIME-Version: 1.0
Message-ID: <160223032482.7002.16625104076456013961.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     cd290ec24633f51029dab0d25505fae7da0e1eda
Gitweb:        https://git.kernel.org/tip/cd290ec24633f51029dab0d25505fae7da0e1eda
Author:        Marco Elver <elver@google.com>
AuthorDate:    Fri, 21 Aug 2020 14:31:26 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Sun, 30 Aug 2020 21:50:13 -07:00

kcsan: Use tracing-safe version of prandom

In the core runtime, we must minimize any calls to external library
functions to avoid any kind of recursion. This can happen even though
instrumentation is disabled for called functions, but tracing is
enabled.

Most recently, prandom_u32() added a tracepoint, which can cause
problems for KCSAN even if the rcuidle variant is used. For example:
	kcsan -> prandom_u32() -> trace_prandom_u32_rcuidle ->
	srcu_read_lock_notrace -> __srcu_read_lock -> kcsan ...

While we could disable KCSAN in kcsan_setup_watchpoint(), this does not
solve other unexpected behaviour we may get due recursing into functions
that may not be tolerant to such recursion:
	__srcu_read_lock -> kcsan -> ... -> __srcu_read_lock

Therefore, switch to using prandom_u32_state(), which is uninstrumented,
and does not have a tracepoint.

Link: https://lkml.kernel.org/r/20200821063043.1949509-1-elver@google.com
Link: https://lkml.kernel.org/r/20200820172046.GA177701@elver.google.com
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/core.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 8a1ff60..3994a21 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -100,6 +100,9 @@ static atomic_long_t watchpoints[CONFIG_KCSAN_NUM_WATCHPOINTS + NUM_SLOTS-1];
  */
 static DEFINE_PER_CPU(long, kcsan_skip);
 
+/* For kcsan_prandom_u32_max(). */
+static DEFINE_PER_CPU(struct rnd_state, kcsan_rand_state);
+
 static __always_inline atomic_long_t *find_watchpoint(unsigned long addr,
 						      size_t size,
 						      bool expect_write,
@@ -271,11 +274,28 @@ should_watch(const volatile void *ptr, size_t size, int type, struct kcsan_ctx *
 	return true;
 }
 
+/*
+ * Returns a pseudo-random number in interval [0, ep_ro). See prandom_u32_max()
+ * for more details.
+ *
+ * The open-coded version here is using only safe primitives for all contexts
+ * where we can have KCSAN instrumentation. In particular, we cannot use
+ * prandom_u32() directly, as its tracepoint could cause recursion.
+ */
+static u32 kcsan_prandom_u32_max(u32 ep_ro)
+{
+	struct rnd_state *state = &get_cpu_var(kcsan_rand_state);
+	const u32 res = prandom_u32_state(state);
+
+	put_cpu_var(kcsan_rand_state);
+	return (u32)(((u64) res * ep_ro) >> 32);
+}
+
 static inline void reset_kcsan_skip(void)
 {
 	long skip_count = kcsan_skip_watch -
 			  (IS_ENABLED(CONFIG_KCSAN_SKIP_WATCH_RANDOMIZE) ?
-				   prandom_u32_max(kcsan_skip_watch) :
+				   kcsan_prandom_u32_max(kcsan_skip_watch) :
 				   0);
 	this_cpu_write(kcsan_skip, skip_count);
 }
@@ -285,16 +305,18 @@ static __always_inline bool kcsan_is_enabled(void)
 	return READ_ONCE(kcsan_enabled) && get_ctx()->disable_count == 0;
 }
 
-static inline unsigned int get_delay(int type)
+/* Introduce delay depending on context and configuration. */
+static void delay_access(int type)
 {
 	unsigned int delay = in_task() ? kcsan_udelay_task : kcsan_udelay_interrupt;
 	/* For certain access types, skew the random delay to be longer. */
 	unsigned int skew_delay_order =
 		(type & (KCSAN_ACCESS_COMPOUND | KCSAN_ACCESS_ASSERT)) ? 1 : 0;
 
-	return delay - (IS_ENABLED(CONFIG_KCSAN_DELAY_RANDOMIZE) ?
-				prandom_u32_max(delay >> skew_delay_order) :
-				0);
+	delay -= IS_ENABLED(CONFIG_KCSAN_DELAY_RANDOMIZE) ?
+			       kcsan_prandom_u32_max(delay >> skew_delay_order) :
+			       0;
+	udelay(delay);
 }
 
 void kcsan_save_irqtrace(struct task_struct *task)
@@ -476,7 +498,7 @@ kcsan_setup_watchpoint(const volatile void *ptr, size_t size, int type)
 	 * Delay this thread, to increase probability of observing a racy
 	 * conflicting access.
 	 */
-	udelay(get_delay(type));
+	delay_access(type);
 
 	/*
 	 * Re-read value, and check if it is as expected; if not, we infer a
@@ -620,6 +642,7 @@ void __init kcsan_init(void)
 	BUG_ON(!in_task());
 
 	kcsan_debugfs_init();
+	prandom_seed_full_state(&kcsan_rand_state);
 
 	/*
 	 * We are in the init task, and no other tasks should be running;
