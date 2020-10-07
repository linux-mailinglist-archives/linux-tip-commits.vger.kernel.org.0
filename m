Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AEFC28638A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 Oct 2020 18:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727739AbgJGQUR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 7 Oct 2020 12:20:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44626 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726181AbgJGQUQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 7 Oct 2020 12:20:16 -0400
Date:   Wed, 07 Oct 2020 16:20:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602087614;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m6kh9pcxQKv9/pNAu91+QKJd+WTE31eTaVQ/8hDpOuc=;
        b=KYeCp+NeO6eetMWYUmPJoebha0oAGe+brN5BcNYeF2nB3Rr1JZCgWmzNu2v+PxiTrPgpVq
        7orwArc1Q8R1b3+Caf5fwZWHS8mcKrsrfAmpbAyiyx/UZD9NuxaMnWFnxQnQf1PhmWChsj
        s3b3B4OToirKnX8KV3lwQBbBIRnRjRTFI4S0EP8pSiResNRxLy5W+yjQO3YJRN6PhEKE9+
        RsueUKFMNwo+hhqaVQTe9FAJVW7hGyoYcfK4YjeBPvK+tHT95g147T/z4teiGh7SMLdPpj
        mjJ8EmxZS06+3j1Wg1h50w1QTGbFbO0zOvee7uuo5LZxoiDTuLqXWHZuWxlTZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602087614;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=m6kh9pcxQKv9/pNAu91+QKJd+WTE31eTaVQ/8hDpOuc=;
        b=4mYL8I4AN9AttAyiq+TiexoCOSRHLYH1ul6XNvwbcOWZK+fOAQX2qN1GY/HbFt/jrd3XWG
        WBrZvoyVc9kuzbAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] lockdep: Fix usage_traceoverflow
Cc:     Qian Cai <cai@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200930094937.GE2651@hirez.programming.kicks-ass.net>
References: <20200930094937.GE2651@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <160208761332.7002.17400661713288945222.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     24d5a3bffef117ed90685f285c6c9d2faa3a02b4
Gitweb:        https://git.kernel.org/tip/24d5a3bffef117ed90685f285c6c9d2faa3a02b4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 30 Sep 2020 11:49:37 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Oct 2020 18:14:17 +02:00

lockdep: Fix usage_traceoverflow

Basically print_lock_class_header()'s for loop is out of sync with the
the size of of ->usage_traces[].

Clean things up a bit.

Fixes: 23870f122768 ("locking/lockdep: Fix "USED" <- "IN-NMI" inversions")
Reported-by: Qian Cai <cai@redhat.com>
Debugged-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Qian Cai <cai@redhat.com>
Link: https://lkml.kernel.org/r/20200930094937.GE2651@hirez.programming.kicks-ass.net
---
 include/linux/lockdep_types.h      |  8 +++++--
 kernel/locking/lockdep.c           | 32 +++++++++++++----------------
 kernel/locking/lockdep_internals.h |  7 ++++--
 3 files changed, 26 insertions(+), 21 deletions(-)

diff --git a/include/linux/lockdep_types.h b/include/linux/lockdep_types.h
index bb35b44..9a1fd49 100644
--- a/include/linux/lockdep_types.h
+++ b/include/linux/lockdep_types.h
@@ -35,8 +35,12 @@ enum lockdep_wait_type {
 /*
  * We'd rather not expose kernel/lockdep_states.h this wide, but we do need
  * the total number of states... :-(
+ *
+ * XXX_LOCK_USAGE_STATES is the number of lines in lockdep_states.h, for each
+ * of those we generates 4 states, Additionally we report on USED and USED_READ.
  */
-#define XXX_LOCK_USAGE_STATES		(1+2*4)
+#define XXX_LOCK_USAGE_STATES		2
+#define LOCK_TRACE_STATES		(XXX_LOCK_USAGE_STATES*4 + 2)
 
 /*
  * NR_LOCKDEP_CACHING_CLASSES ... Number of classes
@@ -106,7 +110,7 @@ struct lock_class {
 	 * IRQ/softirq usage tracking bits:
 	 */
 	unsigned long			usage_mask;
-	const struct lock_trace		*usage_traces[XXX_LOCK_USAGE_STATES];
+	const struct lock_trace		*usage_traces[LOCK_TRACE_STATES];
 
 	/*
 	 * Generation counter, when doing certain classes of graph walking,
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index cdb3892..b3b3161 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -600,6 +600,8 @@ static const char *usage_str[] =
 #include "lockdep_states.h"
 #undef LOCKDEP_STATE
 	[LOCK_USED] = "INITIAL USE",
+	[LOCK_USED_READ] = "INITIAL READ USE",
+	/* abused as string storage for verify_lock_unused() */
 	[LOCK_USAGE_STATES] = "IN-NMI",
 };
 #endif
@@ -2252,7 +2254,7 @@ static void print_lock_class_header(struct lock_class *class, int depth)
 #endif
 	printk(KERN_CONT " {\n");
 
-	for (bit = 0; bit < LOCK_USAGE_STATES; bit++) {
+	for (bit = 0; bit < LOCK_TRACE_STATES; bit++) {
 		if (class->usage_mask & (1 << bit)) {
 			int len = depth;
 
@@ -4345,7 +4347,7 @@ static int separate_irq_context(struct task_struct *curr,
 static int mark_lock(struct task_struct *curr, struct held_lock *this,
 			     enum lock_usage_bit new_bit)
 {
-	unsigned int old_mask, new_mask, ret = 1;
+	unsigned int new_mask, ret = 1;
 
 	if (new_bit >= LOCK_USAGE_STATES) {
 		DEBUG_LOCKS_WARN_ON(1);
@@ -4372,30 +4374,26 @@ static int mark_lock(struct task_struct *curr, struct held_lock *this,
 	if (unlikely(hlock_class(this)->usage_mask & new_mask))
 		goto unlock;
 
-	old_mask = hlock_class(this)->usage_mask;
 	hlock_class(this)->usage_mask |= new_mask;
 
-	/*
-	 * Save one usage_traces[] entry and map both LOCK_USED and
-	 * LOCK_USED_READ onto the same entry.
-	 */
-	if (new_bit == LOCK_USED || new_bit == LOCK_USED_READ) {
-		if (old_mask & (LOCKF_USED | LOCKF_USED_READ))
-			goto unlock;
-		new_bit = LOCK_USED;
+	if (new_bit < LOCK_TRACE_STATES) {
+		if (!(hlock_class(this)->usage_traces[new_bit] = save_trace()))
+			return 0;
 	}
 
-	if (!(hlock_class(this)->usage_traces[new_bit] = save_trace()))
-		return 0;
-
 	switch (new_bit) {
+	case 0 ... LOCK_USED-1:
+		ret = mark_lock_irq(curr, this, new_bit);
+		if (!ret)
+			return 0;
+		break;
+
 	case LOCK_USED:
 		debug_atomic_dec(nr_unused_locks);
 		break;
+
 	default:
-		ret = mark_lock_irq(curr, this, new_bit);
-		if (!ret)
-			return 0;
+		break;
 	}
 
 unlock:
diff --git a/kernel/locking/lockdep_internals.h b/kernel/locking/lockdep_internals.h
index b0be156..de49f9e 100644
--- a/kernel/locking/lockdep_internals.h
+++ b/kernel/locking/lockdep_internals.h
@@ -20,9 +20,12 @@ enum lock_usage_bit {
 #undef LOCKDEP_STATE
 	LOCK_USED,
 	LOCK_USED_READ,
-	LOCK_USAGE_STATES
+	LOCK_USAGE_STATES,
 };
 
+/* states after LOCK_USED_READ are not traced and printed */
+static_assert(LOCK_TRACE_STATES == LOCK_USAGE_STATES);
+
 #define LOCK_USAGE_READ_MASK 1
 #define LOCK_USAGE_DIR_MASK  2
 #define LOCK_USAGE_STATE_MASK (~(LOCK_USAGE_READ_MASK | LOCK_USAGE_DIR_MASK))
@@ -121,7 +124,7 @@ static const unsigned long LOCKF_USED_IN_IRQ_READ =
 extern struct list_head all_lock_classes;
 extern struct lock_chain lock_chains[];
 
-#define LOCK_USAGE_CHARS (1+LOCK_USAGE_STATES/2)
+#define LOCK_USAGE_CHARS (2*XXX_LOCK_USAGE_STATES + 1)
 
 extern void get_usage_chars(struct lock_class *class,
 			    char usage[LOCK_USAGE_CHARS]);
