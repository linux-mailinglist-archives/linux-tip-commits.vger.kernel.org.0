Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 45CCF31BBA7
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Feb 2021 15:59:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230263AbhBOO5n (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 15 Feb 2021 09:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbhBOO5S (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 15 Feb 2021 09:57:18 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB6DC0611C1;
        Mon, 15 Feb 2021 06:55:57 -0800 (PST)
Date:   Mon, 15 Feb 2021 14:55:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613400956;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wsxnDcMlpJkki1bD+3EV0U8LME79Eq3IinY7kBnm7Zw=;
        b=b3zLXgzoCdj9dwokAbKGnv+WIX2vC9FCnmmE7k7qUACxhJfPnYs+mQIvGqJezpHqwi/OqP
        24WXZiOryUvlRehOdubn3dSET/ut/UiOu5Ex9m6WFrHmjpIj9NfGzEzd+s40ezKHoboe7v
        wTjeXmXagI2ogL5T2QQyRUevGRFDIBQI+Jgv3AG6wgibDa9LLFuqSwzv7Dl7alauE6ZOtA
        70lwnLESKeuMgcgpdVxTnGFedVZy06hyePTuxUeMgQdHacnPoC7843dW052wbHo03stJTy
        rJnTK582UO6nVjEP6R2HdhoC1iGoVz8dViLH3NCOY8t96zO5GjQ3Q6E4KxTMgg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613400956;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=wsxnDcMlpJkki1bD+3EV0U8LME79Eq3IinY7kBnm7Zw=;
        b=J2oQ5LHUFmml+53bbNepPelis5VKb0/7J3jpIhew0e4Ey0MWih4TJN2n5SwAELDIcgWblO
        iI5HkMWtkq0JjNAw==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] kcsan: Rewrite kcsan_prandom_u32_max() without
 prandom_u32_state()
Cc:     Marco Elver <elver@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161340095583.20312.15815240255763140896.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     71a076f4a61a6c779794ad286f356b39725edc3b
Gitweb:        https://git.kernel.org/tip/71a076f4a61a6c779794ad286f356b39725edc3b
Author:        Marco Elver <elver@google.com>
AuthorDate:    Tue, 24 Nov 2020 12:02:09 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 14:39:07 -08:00

kcsan: Rewrite kcsan_prandom_u32_max() without prandom_u32_state()

Rewrite kcsan_prandom_u32_max() to not depend on code that might be
instrumented, removing any dependency on lib/random32.c. The rewrite
implements a simple linear congruential generator, that is sufficient
for our purposes (for udelay() and skip_watch counter randomness).

The initial motivation for this was to allow enabling KCSAN for
kernel/sched (remove KCSAN_SANITIZE := n from kernel/sched/Makefile),
with CONFIG_DEBUG_PREEMPT=y. Without this change, we could observe
recursion:

	check_access() [via instrumentation]
	  kcsan_setup_watchpoint()
	    reset_kcsan_skip()
	      kcsan_prandom_u32_max()
	        get_cpu_var()
		  preempt_disable()
		    preempt_count_add() [in kernel/sched/core.c]
		      check_access() [via instrumentation]

Note, while this currently does not affect an unmodified kernel, it'd be
good to keep a KCSAN kernel working when KCSAN_SANITIZE := n is removed
from kernel/sched/Makefile to permit testing scheduler code with KCSAN
if desired.

Fixes: cd290ec24633 ("kcsan: Use tracing-safe version of prandom")
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/kcsan/core.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/kcsan/core.c b/kernel/kcsan/core.c
index 3994a21..3bf98db 100644
--- a/kernel/kcsan/core.c
+++ b/kernel/kcsan/core.c
@@ -12,7 +12,6 @@
 #include <linux/moduleparam.h>
 #include <linux/percpu.h>
 #include <linux/preempt.h>
-#include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/uaccess.h>
 
@@ -101,7 +100,7 @@ static atomic_long_t watchpoints[CONFIG_KCSAN_NUM_WATCHPOINTS + NUM_SLOTS-1];
 static DEFINE_PER_CPU(long, kcsan_skip);
 
 /* For kcsan_prandom_u32_max(). */
-static DEFINE_PER_CPU(struct rnd_state, kcsan_rand_state);
+static DEFINE_PER_CPU(u32, kcsan_rand_state);
 
 static __always_inline atomic_long_t *find_watchpoint(unsigned long addr,
 						      size_t size,
@@ -275,20 +274,17 @@ should_watch(const volatile void *ptr, size_t size, int type, struct kcsan_ctx *
 }
 
 /*
- * Returns a pseudo-random number in interval [0, ep_ro). See prandom_u32_max()
- * for more details.
- *
- * The open-coded version here is using only safe primitives for all contexts
- * where we can have KCSAN instrumentation. In particular, we cannot use
- * prandom_u32() directly, as its tracepoint could cause recursion.
+ * Returns a pseudo-random number in interval [0, ep_ro). Simple linear
+ * congruential generator, using constants from "Numerical Recipes".
  */
 static u32 kcsan_prandom_u32_max(u32 ep_ro)
 {
-	struct rnd_state *state = &get_cpu_var(kcsan_rand_state);
-	const u32 res = prandom_u32_state(state);
+	u32 state = this_cpu_read(kcsan_rand_state);
+
+	state = 1664525 * state + 1013904223;
+	this_cpu_write(kcsan_rand_state, state);
 
-	put_cpu_var(kcsan_rand_state);
-	return (u32)(((u64) res * ep_ro) >> 32);
+	return state % ep_ro;
 }
 
 static inline void reset_kcsan_skip(void)
@@ -639,10 +635,14 @@ static __always_inline void check_access(const volatile void *ptr, size_t size,
 
 void __init kcsan_init(void)
 {
+	int cpu;
+
 	BUG_ON(!in_task());
 
 	kcsan_debugfs_init();
-	prandom_seed_full_state(&kcsan_rand_state);
+
+	for_each_possible_cpu(cpu)
+		per_cpu(kcsan_rand_state, cpu) = (u32)get_cycles();
 
 	/*
 	 * We are in the init task, and no other tasks should be running;
