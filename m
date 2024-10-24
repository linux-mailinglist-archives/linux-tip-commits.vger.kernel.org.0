Return-Path: <linux-tip-commits+bounces-2540-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id CB4049AE269
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Oct 2024 12:23:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4EF0BB20ECE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Oct 2024 10:23:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C53351A0BD6;
	Thu, 24 Oct 2024 10:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QSU/iG+n";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ATrCr48H"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD283399F;
	Thu, 24 Oct 2024 10:22:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729765381; cv=none; b=f2ylHj1/a850I2/EzimItfFJFdnt5Wp49lB+qpfW1BogN/aYBYe272lrhD+yv7dn6tPPvSnCtc4hV6HoIt5A7eICIrNYKqrUSGNNrElEMLgUy1PE4YTZ3fgPIJUiN/xWx0YcQjG3jNYIP9AjdSKMY2xVr+g+7yUdvM5Jub1x7jY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729765381; c=relaxed/simple;
	bh=d2PrWworP54vGMDjYcDE/erPr7IdIisIFZi9wyGmblI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sLF0EBRSrQ0auhf0in7ss0SBqfo2rCL5AAr6vhnhsGeF3BVtiZ564rG0WOJg68eBXpj7bb0B0G82Z28AMw1+YvqE9zZ8U/u/dy3xNWCR6xP2W0iZHruOxXbWzkpeMqjG5lRb+khLL6SIEVkNLVTTVV9qHK9a/YqdivY8y4w4LzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QSU/iG+n; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ATrCr48H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 24 Oct 2024 10:22:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1729765377;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=08iFft7sVuQpER5fbxoEWVZ3znTgjOYapPeqViWdRSQ=;
	b=QSU/iG+ncxgaiB62urkZrO+y1S6FMkw3NUH4OlnOuDkqpV+pucB4fGEnT3cmzSvk7C0Gt3
	1ld94wOoqSFoQ4mxq2L8ptJX1knOXEj7Fm+Xgin/xoolzkNRt1g8vNt7rCa9qCusJDNgqU
	cf52beUfY3ZffGnTeRMU9tQVNbppxCgKdEdTZkZXwR7kB+n9k0MWEF/PXk42WLmBhs9otd
	yb0hZbw8YfH/m1oHvWf7A9pWNn+pYihUuw4oKvOJD8l9N0GwdGfYRSHnMy6GpICIxdylen
	c0hY2UOX0e1vs+inl08XjxBTgqmFIQRJp9+eAh8Z2cX1OtUC60g5pCWpVytANw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1729765377;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=08iFft7sVuQpER5fbxoEWVZ3znTgjOYapPeqViWdRSQ=;
	b=ATrCr48H8X0o2HLrQudJLT/lEXGAhSXp4MEhcMFy/cogWCLwcy2lHoWmi8lUDVmT+A/xbd
	kaCoPKJv8tCEmhBA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/urgent] sched: Fix pick_next_task_fair() vs try_to_wake_up() race
Cc: syzbot+0ec1e96c2cdf5c0e512a@syzkaller.appspotmail.com,
 Kent Overstreet <kent.overstreet@linux.dev>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Marco Elver <elver@google.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241023093641.GE16066@noisy.programming.kicks-ass.net>
References: <20241023093641.GE16066@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172976537654.1442.4491396972715085236.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     b55945c500c5723992504aa03b362fab416863a6
Gitweb:        https://git.kernel.org/tip/b55945c500c5723992504aa03b362fab416863a6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 23 Oct 2024 11:36:41 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 23 Oct 2024 20:52:26 +02:00

sched: Fix pick_next_task_fair() vs try_to_wake_up() race

Syzkaller robot reported KCSAN tripping over the
ASSERT_EXCLUSIVE_WRITER(p->on_rq) in __block_task().

The report noted that both pick_next_task_fair() and try_to_wake_up()
were concurrently trying to write to the same p->on_rq, violating the
assertion -- even though both paths hold rq->__lock.

The logical consequence is that both code paths end up holding a
different rq->__lock. And looking through ttwu(), this is possible
when the __block_task() 'p->on_rq = 0' store is visible to the ttwu()
'p->on_rq' load, which then assumes the task is not queued and
continues to migrate it.

Rearrange things such that __block_task() releases @p with the store
and no code thereafter will use @p again.

Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
Reported-by: syzbot+0ec1e96c2cdf5c0e512a@syzkaller.appspotmail.com
Reported-by: Kent Overstreet <kent.overstreet@linux.dev>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Marco Elver <elver@google.com>
Link: https://lkml.kernel.org/r/20241023093641.GE16066@noisy.programming.kicks-ass.net
---
 kernel/sched/fair.c  | 21 ++++++++++++++-------
 kernel/sched/sched.h | 34 ++++++++++++++++++++++++++++++++--
 2 files changed, 46 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c157d48..8796146 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5625,8 +5625,9 @@ pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
 	struct sched_entity *se = pick_eevdf(cfs_rq);
 	if (se->sched_delayed) {
 		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
-		SCHED_WARN_ON(se->sched_delayed);
-		SCHED_WARN_ON(se->on_rq);
+		/*
+		 * Must not reference @se again, see __block_task().
+		 */
 		return NULL;
 	}
 	return se;
@@ -7176,7 +7177,11 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		/* Fix-up what dequeue_task_fair() skipped */
 		hrtick_update(rq);
 
-		/* Fix-up what block_task() skipped. */
+		/*
+		 * Fix-up what block_task() skipped.
+		 *
+		 * Must be last, @p might not be valid after this.
+		 */
 		__block_task(rq, p);
 	}
 
@@ -7193,12 +7198,14 @@ static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & DEQUEUE_SAVE))))
 		util_est_dequeue(&rq->cfs, p);
 
-	if (dequeue_entities(rq, &p->se, flags) < 0) {
-		util_est_update(&rq->cfs, p, DEQUEUE_SLEEP);
+	util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
+	if (dequeue_entities(rq, &p->se, flags) < 0)
 		return false;
-	}
 
-	util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);
+	/*
+	 * Must not reference @p after dequeue_entities(DEQUEUE_DELAYED).
+	 */
+
 	hrtick_update(rq);
 	return true;
 }
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 081519f..9f9d1cc 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2769,8 +2769,6 @@ static inline void sub_nr_running(struct rq *rq, unsigned count)
 
 static inline void __block_task(struct rq *rq, struct task_struct *p)
 {
-	WRITE_ONCE(p->on_rq, 0);
-	ASSERT_EXCLUSIVE_WRITER(p->on_rq);
 	if (p->sched_contributes_to_load)
 		rq->nr_uninterruptible++;
 
@@ -2778,6 +2776,38 @@ static inline void __block_task(struct rq *rq, struct task_struct *p)
 		atomic_inc(&rq->nr_iowait);
 		delayacct_blkio_start();
 	}
+
+	ASSERT_EXCLUSIVE_WRITER(p->on_rq);
+
+	/*
+	 * The moment this write goes through, ttwu() can swoop in and migrate
+	 * this task, rendering our rq->__lock ineffective.
+	 *
+	 * __schedule()				try_to_wake_up()
+	 *   LOCK rq->__lock			  LOCK p->pi_lock
+	 *   pick_next_task()
+	 *     pick_next_task_fair()
+	 *       pick_next_entity()
+	 *         dequeue_entities()
+	 *           __block_task()
+	 *             RELEASE p->on_rq = 0	  if (p->on_rq && ...)
+	 *					    break;
+	 *
+	 *					  ACQUIRE (after ctrl-dep)
+	 *
+	 *					  cpu = select_task_rq();
+	 *					  set_task_cpu(p, cpu);
+	 *					  ttwu_queue()
+	 *					    ttwu_do_activate()
+	 *					      LOCK rq->__lock
+	 *					      activate_task()
+	 *					        STORE p->on_rq = 1
+	 *   UNLOCK rq->__lock
+	 *
+	 * Callers must ensure to not reference @p after this -- we no longer
+	 * own it.
+	 */
+	smp_store_release(&p->on_rq, 0);
 }
 
 extern void activate_task(struct rq *rq, struct task_struct *p, int flags);

