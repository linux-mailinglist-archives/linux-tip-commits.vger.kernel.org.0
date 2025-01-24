Return-Path: <linux-tip-commits+bounces-3289-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1D32BA1B1EB
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Jan 2025 09:49:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BF79D3AE21C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Jan 2025 08:49:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7A561F5404;
	Fri, 24 Jan 2025 08:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S1Y68YlP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9a2RXssf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABB751DB134;
	Fri, 24 Jan 2025 08:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737708590; cv=none; b=a2CfOiPFj9tWv+Ag26CrgbZjxDX9BGnucHOpnYf5CBuzwNEQvqQNoFEVsuHIOpXw/lFonBWEx6ZeBGQE7P8UX8G1Q+pdIbF3xcx5gqlYenCzBf7naPFpNGUeN27AvczZDdn1V//+k01HBgt9A0CfE7ZUtLglsrnW2TJcET9AXSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737708590; c=relaxed/simple;
	bh=PWvbh4e8ltW+DC6ZdSV6jOHJ83/ZO15i3aDSSBU+3wA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dr6HTaerXtOsJAO1ef9RJYc/Dkg/sl9LuuWhJmTWcA6V4D7rXmknVBlrdmzhjBPUXIJzHIfTy7fkndskOWcD/JGsd7YOgWUhNQIb0DJVaO6bJ4j/e2jvBKWtHUfJABw8ZlvJYgvAJWhzXXwWbP9wjOGeoOlGHvy8TfxjrDc11O8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S1Y68YlP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9a2RXssf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 24 Jan 2025 08:49:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1737708586;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9K8HWz1tiwU1j257ljamPyyHH+JK/JJH709ywy0iV/w=;
	b=S1Y68YlPJRb63j2idxjfedNM/r/T/oYe9+m/COyrylY0aUqpD7teBMSZDBjNu0+9lEgEZz
	5zRwdXr2f2xAcEKOztcmt/iF5B3ehERbBPTstJmrd+Ukr3GJk3wcglRI0UtORQvPfE1CB/
	qVrXS6YW/Vyntm09dM0PVK9TfqzJOg7RB936bhVc6UL0xPc6+mZw1IonBH6LY1fP0K+lIU
	dr8ebfyk9ZcbjRVnxQ5Tpl/Qfx5o04TRp+wH4ENxYKn+0ZDbydQb2Pj2yJpiKw2Pgqqm83
	PmIzpg2e/9+SCbmWiPLr+MP1nFO10D+VR1slzLSoYJdPU9KSwAaKBfrsbFXGCg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1737708586;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9K8HWz1tiwU1j257ljamPyyHH+JK/JJH709ywy0iV/w=;
	b=9a2RXssfwY/0SAGkO6bgNtSMUVjA0OSesk75rzcnXf5ywN1LASxFYGCiFUu3FSpN7JksST
	ESubIZgbrlF1lMDg==
From: "tip-bot2 for Jens Axboe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] futex: Pass in task to futex_queue()
Cc: Jann Horn <jannh@google.com>, Jens Axboe <axboe@kernel.dk>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <22484a23-542c-4003-b721-400688a0d055@kernel.dk>
References: <22484a23-542c-4003-b721-400688a0d055@kernel.dk>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173770858263.31546.600894067702587583.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     5e0e02f0d7e52cfc8b1adfc778dd02181d8b47b4
Gitweb:        https://git.kernel.org/tip/5e0e02f0d7e52cfc8b1adfc778dd02181d8b47b4
Author:        Jens Axboe <axboe@kernel.dk>
AuthorDate:    Wed, 15 Jan 2025 09:05:15 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 24 Jan 2025 09:37:30 +01:00

futex: Pass in task to futex_queue()

futex_queue() -> __futex_queue() uses 'current' as the task to store in
the struct futex_q->task field. This is fine for synchronous usage of
the futex infrastructure, but it's not always correct when used by
io_uring where the task doing the initial futex_queue() might not be
available later on. This doesn't lead to any issues currently, as the
io_uring side doesn't support PI futexes, but it does leave a
potentially dangling pointer which is never a good idea.

Have futex_queue() take a task_struct argument, and have the regular
callers pass in 'current' for that. Meanwhile io_uring can just pass in
NULL, as the task should never be used off that path. In theory
req->tctx->task could be used here, but there's no point populating it
with a task field that will never be used anyway.

Reported-by: Jann Horn <jannh@google.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/22484a23-542c-4003-b721-400688a0d055@kernel.dk


---
 io_uring/futex.c        |  2 +-
 kernel/futex/core.c     |  5 +++--
 kernel/futex/futex.h    | 11 ++++++++---
 kernel/futex/pi.c       |  2 +-
 kernel/futex/waitwake.c |  4 ++--
 5 files changed, 15 insertions(+), 9 deletions(-)

diff --git a/io_uring/futex.c b/io_uring/futex.c
index 30139cc..e5cc208 100644
--- a/io_uring/futex.c
+++ b/io_uring/futex.c
@@ -338,7 +338,7 @@ int io_futex_wait(struct io_kiocb *req, unsigned int issue_flags)
 		hlist_add_head(&req->hash_node, &ctx->futex_list);
 		io_ring_submit_unlock(ctx, issue_flags);
 
-		futex_queue(&ifd->q, hb);
+		futex_queue(&ifd->q, hb, NULL);
 		return IOU_ISSUE_SKIP_COMPLETE;
 	}
 
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index ebdd76b..3db8567 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -532,7 +532,8 @@ void futex_q_unlock(struct futex_hash_bucket *hb)
 	futex_hb_waiters_dec(hb);
 }
 
-void __futex_queue(struct futex_q *q, struct futex_hash_bucket *hb)
+void __futex_queue(struct futex_q *q, struct futex_hash_bucket *hb,
+		   struct task_struct *task)
 {
 	int prio;
 
@@ -548,7 +549,7 @@ void __futex_queue(struct futex_q *q, struct futex_hash_bucket *hb)
 
 	plist_node_init(&q->list, prio);
 	plist_add(&q->list, &hb->chain);
-	q->task = current;
+	q->task = task;
 }
 
 /**
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 99b32e7..6b2f4c7 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -285,13 +285,15 @@ static inline int futex_get_value_locked(u32 *dest, u32 __user *from)
 }
 
 extern void __futex_unqueue(struct futex_q *q);
-extern void __futex_queue(struct futex_q *q, struct futex_hash_bucket *hb);
+extern void __futex_queue(struct futex_q *q, struct futex_hash_bucket *hb,
+				struct task_struct *task);
 extern int futex_unqueue(struct futex_q *q);
 
 /**
  * futex_queue() - Enqueue the futex_q on the futex_hash_bucket
  * @q:	The futex_q to enqueue
  * @hb:	The destination hash bucket
+ * @task: Task queueing this futex
  *
  * The hb->lock must be held by the caller, and is released here. A call to
  * futex_queue() is typically paired with exactly one call to futex_unqueue().  The
@@ -299,11 +301,14 @@ extern int futex_unqueue(struct futex_q *q);
  * or nothing if the unqueue is done as part of the wake process and the unqueue
  * state is implicit in the state of woken task (see futex_wait_requeue_pi() for
  * an example).
+ *
+ * Note that @task may be NULL, for async usage of futexes.
  */
-static inline void futex_queue(struct futex_q *q, struct futex_hash_bucket *hb)
+static inline void futex_queue(struct futex_q *q, struct futex_hash_bucket *hb,
+			       struct task_struct *task)
 	__releases(&hb->lock)
 {
-	__futex_queue(q, hb);
+	__futex_queue(q, hb, task);
 	spin_unlock(&hb->lock);
 }
 
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index daea650..7a94184 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -982,7 +982,7 @@ retry_private:
 	/*
 	 * Only actually queue now that the atomic ops are done:
 	 */
-	__futex_queue(&q, hb);
+	__futex_queue(&q, hb, current);
 
 	if (trylock) {
 		ret = rt_mutex_futex_trylock(&q.pi_state->pi_mutex);
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index 3a10375..a9056ac 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -350,7 +350,7 @@ void futex_wait_queue(struct futex_hash_bucket *hb, struct futex_q *q,
 	 * access to the hash list and forcing another memory barrier.
 	 */
 	set_current_state(TASK_INTERRUPTIBLE|TASK_FREEZABLE);
-	futex_queue(q, hb);
+	futex_queue(q, hb, current);
 
 	/* Arm the timer */
 	if (timeout)
@@ -461,7 +461,7 @@ retry:
 			 * next futex. Queue each futex at this moment so hb can
 			 * be unlocked.
 			 */
-			futex_queue(q, hb);
+			futex_queue(q, hb, current);
 			continue;
 		}
 

