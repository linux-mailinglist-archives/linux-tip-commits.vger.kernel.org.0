Return-Path: <linux-tip-commits+bounces-5483-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 36875AAF80A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 12:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 05101174127
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 10:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CDEB22F758;
	Thu,  8 May 2025 10:34:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tAoyPrDf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="M2JQXfPi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6BB8215F46;
	Thu,  8 May 2025 10:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700444; cv=none; b=uUWpEG7Bam/+QAWwlBUNTJ6xNr9hTRousRsvyGcJ8NY1LU+GTGkjaenp6FoHP7fda7Zm/w+WqPwvjr8oU50cTDPbD6OymKrGZEjt9eoPsvXI5mg8P8nv/GbRGs9WugqXZID0f3IcdOZgRHmI8k3TeyxXfqSOf2NUbYRZqThwwsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700444; c=relaxed/simple;
	bh=NgWOOt0xpi/iYp84YdS1VkMT86Mp0ZiYH7zblZJoMSE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KgYL88dkZCL5+QSm/xvS8VxmxDoamjDV1fX4E+BuZBl6FwdFoc5iMKFqsWK1oQumXbeT+BHFjynu9/tHrQOGCsdH1obh2v6hb91/5QFHEtNABQiMcVX7wJB+LoK5mYkmWCuMHFFRfOua0SfubLR7hBEL1db2cMscAiilxOztv6M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tAoyPrDf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=M2JQXfPi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 10:33:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746700440;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aXtkpVzIpfJ6tuzcSZg2eh7X/vDnIbOOyD6S5IrTHfw=;
	b=tAoyPrDffqGtERVBXVppqV5Q4SDoJ6d6rgLUYnKjkBAHTdYARv7pegvJWte4lR3VAuT0GX
	skyAdwfmYcFxa/aA+yoydABTgPHGdPgqKoeNarKHvoI7ubMlYdUKhth0ruWSkODdy7ixg9
	INBd0jS8m1KTLaLBKPFwWrygxtVeTEMR1ipuwTnRV310WGng6uGe2es+c11ajDXoZLnA3Y
	FKYXgZUxVMvpwCTmz0cBu0LSKdtda14pJll2XlV7ZCaI5wykxPeQBfwGcclh1/3VASB6vn
	IxkfkH7Sp8RWh15CZjI9zfXnadAfd0cMF0lLWAbvI9iBR+8JTjKuxrAXKnnSag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746700440;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aXtkpVzIpfJ6tuzcSZg2eh7X/vDnIbOOyD6S5IrTHfw=;
	b=M2JQXfPizhKJ3ZeuWIcW7FBA8iGQ2Q03PyoWpcNau0WB85fGaFbaO6qUdWvr4UU6YtWqnk
	mUJjp2VyR5OlvGCg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: locking/futex] futex: Move futex_queue() into futex_wait_setup()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250416162921.513656-4-bigeasy@linutronix.de>
References: <20250416162921.513656-4-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174670043921.406.11188962604409445752.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     93f1b6d79a73b520b6875cf3babf4a09acc4eef0
Gitweb:        https://git.kernel.org/tip/93f1b6d79a73b520b6875cf3babf4a09acc4eef0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 16 Apr 2025 18:29:03 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 03 May 2025 12:02:05 +02:00

futex: Move futex_queue() into futex_wait_setup()

futex_wait_setup() has a weird calling convention in order to return
hb to use as an argument to futex_queue().

Mostly such that requeue can have an extra test in between.

Reorder code a little to get rid of this and keep the hb usage inside
futex_wait_setup().

[bigeasy: fixes]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250416162921.513656-4-bigeasy@linutronix.de
---
 io_uring/futex.c        |  4 +---
 kernel/futex/futex.h    |  6 ++---
 kernel/futex/requeue.c  | 28 +++++++++---------------
 kernel/futex/waitwake.c | 47 ++++++++++++++++++++++------------------
 4 files changed, 42 insertions(+), 43 deletions(-)

diff --git a/io_uring/futex.c b/io_uring/futex.c
index 0ea4820..e89c089 100644
--- a/io_uring/futex.c
+++ b/io_uring/futex.c
@@ -273,7 +273,6 @@ int io_futex_wait(struct io_kiocb *req, unsigned int issue_flags)
 	struct io_futex *iof = io_kiocb_to_cmd(req, struct io_futex);
 	struct io_ring_ctx *ctx = req->ctx;
 	struct io_futex_data *ifd = NULL;
-	struct futex_hash_bucket *hb;
 	int ret;
 
 	if (!iof->futex_mask) {
@@ -295,12 +294,11 @@ int io_futex_wait(struct io_kiocb *req, unsigned int issue_flags)
 	ifd->req = req;
 
 	ret = futex_wait_setup(iof->uaddr, iof->futex_val, iof->futex_flags,
-			       &ifd->q, &hb);
+			       &ifd->q, NULL, NULL);
 	if (!ret) {
 		hlist_add_head(&req->hash_node, &ctx->futex_list);
 		io_ring_submit_unlock(ctx, issue_flags);
 
-		futex_queue(&ifd->q, hb, NULL);
 		return IOU_ISSUE_SKIP_COMPLETE;
 	}
 
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 6b2f4c7..16aafd0 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -219,9 +219,9 @@ static inline int futex_match(union futex_key *key1, union futex_key *key2)
 }
 
 extern int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
-			    struct futex_q *q, struct futex_hash_bucket **hb);
-extern void futex_wait_queue(struct futex_hash_bucket *hb, struct futex_q *q,
-				   struct hrtimer_sleeper *timeout);
+			    struct futex_q *q, union futex_key *key2,
+			    struct task_struct *task);
+extern void futex_do_wait(struct futex_q *q, struct hrtimer_sleeper *timeout);
 extern bool __futex_wake_mark(struct futex_q *q);
 extern void futex_wake_mark(struct wake_q_head *wake_q, struct futex_q *q);
 
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index b47bb76..0e55975 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -769,7 +769,6 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 {
 	struct hrtimer_sleeper timeout, *to;
 	struct rt_mutex_waiter rt_waiter;
-	struct futex_hash_bucket *hb;
 	union futex_key key2 = FUTEX_KEY_INIT;
 	struct futex_q q = futex_q_init;
 	struct rt_mutex_base *pi_mutex;
@@ -805,29 +804,24 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	 * Prepare to wait on uaddr. On success, it holds hb->lock and q
 	 * is initialized.
 	 */
-	ret = futex_wait_setup(uaddr, val, flags, &q, &hb);
+	ret = futex_wait_setup(uaddr, val, flags, &q, &key2, current);
 	if (ret)
 		goto out;
 
-	/*
-	 * The check above which compares uaddrs is not sufficient for
-	 * shared futexes. We need to compare the keys:
-	 */
-	if (futex_match(&q.key, &key2)) {
-		futex_q_unlock(hb);
-		ret = -EINVAL;
-		goto out;
-	}
-
 	/* Queue the futex_q, drop the hb lock, wait for wakeup. */
-	futex_wait_queue(hb, &q, to);
+	futex_do_wait(&q, to);
 
 	switch (futex_requeue_pi_wakeup_sync(&q)) {
 	case Q_REQUEUE_PI_IGNORE:
-		/* The waiter is still on uaddr1 */
-		spin_lock(&hb->lock);
-		ret = handle_early_requeue_pi_wakeup(hb, &q, to);
-		spin_unlock(&hb->lock);
+		{
+			struct futex_hash_bucket *hb;
+
+			hb = futex_hash(&q.key);
+			/* The waiter is still on uaddr1 */
+			spin_lock(&hb->lock);
+			ret = handle_early_requeue_pi_wakeup(hb, &q, to);
+			spin_unlock(&hb->lock);
+		}
 		break;
 
 	case Q_REQUEUE_PI_LOCKED:
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index 25877d4..6cf1070 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -339,18 +339,8 @@ static long futex_wait_restart(struct restart_block *restart);
  * @q:		the futex_q to queue up on
  * @timeout:	the prepared hrtimer_sleeper, or null for no timeout
  */
-void futex_wait_queue(struct futex_hash_bucket *hb, struct futex_q *q,
-			    struct hrtimer_sleeper *timeout)
+void futex_do_wait(struct futex_q *q, struct hrtimer_sleeper *timeout)
 {
-	/*
-	 * The task state is guaranteed to be set before another task can
-	 * wake it. set_current_state() is implemented using smp_store_mb() and
-	 * futex_queue() calls spin_unlock() upon completion, both serializing
-	 * access to the hash list and forcing another memory barrier.
-	 */
-	set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
-	futex_queue(q, hb, current);
-
 	/* Arm the timer */
 	if (timeout)
 		hrtimer_sleeper_start_expires(timeout, HRTIMER_MODE_ABS);
@@ -578,7 +568,8 @@ int futex_wait_multiple(struct futex_vector *vs, unsigned int count,
  * @val:	the expected value
  * @flags:	futex flags (FLAGS_SHARED, etc.)
  * @q:		the associated futex_q
- * @hb:		storage for hash_bucket pointer to be returned to caller
+ * @key2:	the second futex_key if used for requeue PI
+ * task:	Task queueing this futex
  *
  * Setup the futex_q and locate the hash_bucket.  Get the futex value and
  * compare it with the expected value.  Handle atomic faults internally.
@@ -589,8 +580,10 @@ int futex_wait_multiple(struct futex_vector *vs, unsigned int count,
  *  - <1 - -EFAULT or -EWOULDBLOCK (uaddr does not contain val) and hb is unlocked
  */
 int futex_wait_setup(u32 __user *uaddr, u32 val, unsigned int flags,
-		     struct futex_q *q, struct futex_hash_bucket **hb)
+		     struct futex_q *q, union futex_key *key2,
+		     struct task_struct *task)
 {
+	struct futex_hash_bucket *hb;
 	u32 uval;
 	int ret;
 
@@ -618,12 +611,12 @@ retry:
 		return ret;
 
 retry_private:
-	*hb = futex_q_lock(q);
+	hb = futex_q_lock(q);
 
 	ret = futex_get_value_locked(&uval, uaddr);
 
 	if (ret) {
-		futex_q_unlock(*hb);
+		futex_q_unlock(hb);
 
 		ret = get_user(uval, uaddr);
 		if (ret)
@@ -636,10 +629,25 @@ retry_private:
 	}
 
 	if (uval != val) {
-		futex_q_unlock(*hb);
-		ret = -EWOULDBLOCK;
+		futex_q_unlock(hb);
+		return -EWOULDBLOCK;
 	}
 
+	if (key2 && futex_match(&q->key, key2)) {
+		futex_q_unlock(hb);
+		return -EINVAL;
+	}
+
+	/*
+	 * The task state is guaranteed to be set before another task can
+	 * wake it. set_current_state() is implemented using smp_store_mb() and
+	 * futex_queue() calls spin_unlock() upon completion, both serializing
+	 * access to the hash list and forcing another memory barrier.
+	 */
+	if (task == current)
+		set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
+	futex_queue(q, hb, task);
+
 	return ret;
 }
 
@@ -647,7 +655,6 @@ int __futex_wait(u32 __user *uaddr, unsigned int flags, u32 val,
 		 struct hrtimer_sleeper *to, u32 bitset)
 {
 	struct futex_q q = futex_q_init;
-	struct futex_hash_bucket *hb;
 	int ret;
 
 	if (!bitset)
@@ -660,12 +667,12 @@ retry:
 	 * Prepare to wait on uaddr. On success, it holds hb->lock and q
 	 * is initialized.
 	 */
-	ret = futex_wait_setup(uaddr, val, flags, &q, &hb);
+	ret = futex_wait_setup(uaddr, val, flags, &q, NULL, current);
 	if (ret)
 		return ret;
 
 	/* futex_queue and wait for wakeup, timeout, or a signal. */
-	futex_wait_queue(hb, &q, to);
+	futex_do_wait(&q, to);
 
 	/* If we were woken (and unqueued), we succeeded, whatever. */
 	if (!futex_unqueue(&q))

