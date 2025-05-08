Return-Path: <linux-tip-commits+bounces-5476-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B937AAF7FC
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 12:36:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1CFA21C0809E
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 10:36:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F3EB22ACEE;
	Thu,  8 May 2025 10:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LJRkmj6k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="i6VXWqRa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5EEA22688C;
	Thu,  8 May 2025 10:33:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700438; cv=none; b=pBSIyjCHLdOnylbSqPyPJ2HwVaB4UvARtA5OtbkClpjm5WKZbSluj8NhK+27iq5zDiYbSVOCRKZJqQCeG8sPGEdAwXWjsF/f5VyK0KkJnoB9SPHEq5TXH1CPgVoaS/yHiCvUx/xePuWvSbIBWfoAxYJ3G8Hfh3EOrOqrGBZxL8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700438; c=relaxed/simple;
	bh=KinUYHSj8iRtty8BvctA3Pau56Ewe985sS7UryqBwbY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pntb4LQxmNSC8KoZugxdwZ3/Hsi/qzCkN91pwqWcuGHtOI05DJj2R5B37jCz7e11lvrbhyz/164QJWMi7xxPrhWX7IyaNJi/kAnqfpYdlfN8phSP5x8nWjr8KTpAGL2WD1/WzDDnC8HwCIyLlyt9fRfLlMucT/gJa0lt5wLJKOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LJRkmj6k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=i6VXWqRa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 10:33:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746700434;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uf6YBYh/qEwRkCGGDpBvguQ9CmKJF0YEYqnDyuQ2zn4=;
	b=LJRkmj6kY5+AHVDuV5gP0hDHF7Kueohc5agHscH9I6OXaIFmz5umwaiJl1d4H8bN4mSvDq
	nxXCTg4VBtVGBMDnSx7SJxERAo4KjYGQ3TZmB5mssEyyu6Gn8e1jil1x0/FZ0nLP3r3OxO
	DrZLjOfjbekX0oPK06m5xiSVin6CgVsniUrTY/eBZuSdWjLugN3sUniTnlACd6A8SJNqZX
	djdc5Cetb7RjjG33mBAaCYYY3JkIMoP5kIvhVePvaZh+f6J+K0Hwe5faRymgYWg262dLQB
	h4UNqnLYL5Jq3A38EpxG36vrCbvA3mmhCIje0Mw7gAfSGi869lp3bX6q9bInqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746700434;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Uf6YBYh/qEwRkCGGDpBvguQ9CmKJF0YEYqnDyuQ2zn4=;
	b=i6VXWqRaGjo7eci+9BL9zbhneNbzKKE6u4U7xxReKGuF9YAZkiHp6y049Z4iO97rcBMUg+
	Fyk9L4KqBJeBOVBQ==
From: "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] futex: Introduce futex_q_lockptr_lock()
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250416162921.513656-11-bigeasy@linutronix.de>
References: <20250416162921.513656-11-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174670043400.406.14112925420266840766.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     b04b8f3032aae6121303bfa324c768faba032242
Gitweb:        https://git.kernel.org/tip/b04b8f3032aae6121303bfa324c768faba032242
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 16 Apr 2025 18:29:10 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 03 May 2025 12:02:07 +02:00

futex: Introduce futex_q_lockptr_lock()

futex_lock_pi() and __fixup_pi_state_owner() acquire the
futex_q::lock_ptr without holding a reference assuming the previously
obtained hash bucket and the assigned lock_ptr are still valid. This
isn't the case once the private hash can be resized and becomes invalid
after the reference drop.

Introduce futex_q_lockptr_lock() to lock the hash bucket recorded in
futex_q::lock_ptr. The lock pointer is read in a RCU section to ensure
that it does not go away if the hash bucket has been replaced and the
old pointer has been observed. After locking the pointer needs to be
compared to check if it changed. If so then the hash bucket has been
replaced and the user has been moved to the new one and lock_ptr has
been updated. The lock operation needs to be redone in this case.

The locked hash bucket is not returned.

A special case is an early return in futex_lock_pi() (due to signal or
timeout) and a successful futex_wait_requeue_pi(). In both cases a valid
futex_q::lock_ptr is expected (and its matching hash bucket) but since
the waiter has been removed from the hash this can no longer be
guaranteed. Therefore before the waiter is removed and a reference is
acquired which is later dropped by the waiter to avoid a resize.

Add futex_q_lockptr_lock() and use it.
Acquire an additional reference in requeue_pi_wake_futex() and
futex_unlock_pi() while the futex_q is removed, denote this extra
reference in futex_q::drop_hb_ref and let the waiter drop the reference
in this case.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250416162921.513656-11-bigeasy@linutronix.de
---
 kernel/futex/core.c    | 25 +++++++++++++++++++++++++
 kernel/futex/futex.h   |  3 ++-
 kernel/futex/pi.c      | 15 +++++++++++++--
 kernel/futex/requeue.c | 16 +++++++++++++---
 4 files changed, 53 insertions(+), 6 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 5e70cb8..1443a98 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -134,6 +134,13 @@ struct futex_hash_bucket *futex_hash(union futex_key *key)
 	return &futex_queues[hash & futex_hashmask];
 }
 
+/**
+ * futex_hash_get - Get an additional reference for the local hash.
+ * @hb:                    ptr to the private local hash.
+ *
+ * Obtain an additional reference for the already obtained hash bucket. The
+ * caller must already own an reference.
+ */
 void futex_hash_get(struct futex_hash_bucket *hb) { }
 void futex_hash_put(struct futex_hash_bucket *hb) { }
 
@@ -615,6 +622,24 @@ retry:
 	return ret;
 }
 
+void futex_q_lockptr_lock(struct futex_q *q)
+{
+	spinlock_t *lock_ptr;
+
+	/*
+	 * See futex_unqueue() why lock_ptr can change.
+	 */
+	guard(rcu)();
+retry:
+	lock_ptr = READ_ONCE(q->lock_ptr);
+	spin_lock(lock_ptr);
+
+	if (unlikely(lock_ptr != q->lock_ptr)) {
+		spin_unlock(lock_ptr);
+		goto retry;
+	}
+}
+
 /*
  * PI futexes can not be requeued and must remove themselves from the hash
  * bucket. The hash bucket lock (i.e. lock_ptr) is held.
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index bc76e36..26e6933 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -183,6 +183,7 @@ struct futex_q {
 	union futex_key *requeue_pi_key;
 	u32 bitset;
 	atomic_t requeue_state;
+	bool drop_hb_ref;
 #ifdef CONFIG_PREEMPT_RT
 	struct rcuwait requeue_wait;
 #endif
@@ -197,7 +198,7 @@ enum futex_access {
 
 extern int get_futex_key(u32 __user *uaddr, unsigned int flags, union futex_key *key,
 			 enum futex_access rw);
-
+extern void futex_q_lockptr_lock(struct futex_q *q);
 extern struct hrtimer_sleeper *
 futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
 		  int flags, u64 range_ns);
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index e52f540..dacb233 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -806,7 +806,7 @@ handle_err:
 		break;
 	}
 
-	spin_lock(q->lock_ptr);
+	futex_q_lockptr_lock(q);
 	raw_spin_lock_irq(&pi_state->pi_mutex.wait_lock);
 
 	/*
@@ -1072,7 +1072,7 @@ cleanup:
 		 * spinlock/rtlock (which might enqueue its own rt_waiter) and fix up
 		 * the
 		 */
-		spin_lock(q.lock_ptr);
+		futex_q_lockptr_lock(&q);
 		/*
 		 * Waiter is unqueued.
 		 */
@@ -1092,6 +1092,11 @@ no_block:
 
 		futex_unqueue_pi(&q);
 		spin_unlock(q.lock_ptr);
+		if (q.drop_hb_ref) {
+			CLASS(hb, hb)(&q.key);
+			/* Additional reference from futex_unlock_pi() */
+			futex_hash_put(hb);
+		}
 		goto out;
 
 out_unlock_put_key:
@@ -1200,6 +1205,12 @@ retry_hb:
 		 */
 		rt_waiter = rt_mutex_top_waiter(&pi_state->pi_mutex);
 		if (!rt_waiter) {
+			/*
+			 * Acquire a reference for the leaving waiter to ensure
+			 * valid futex_q::lock_ptr.
+			 */
+			futex_hash_get(hb);
+			top_waiter->drop_hb_ref = true;
 			__futex_unqueue(top_waiter);
 			raw_spin_unlock_irq(&pi_state->pi_mutex.wait_lock);
 			goto retry_hb;
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index 023c028..b0e64fd 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -231,7 +231,12 @@ void requeue_pi_wake_futex(struct futex_q *q, union futex_key *key,
 
 	WARN_ON(!q->rt_waiter);
 	q->rt_waiter = NULL;
-
+	/*
+	 * Acquire a reference for the waiter to ensure valid
+	 * futex_q::lock_ptr.
+	 */
+	futex_hash_get(hb);
+	q->drop_hb_ref = true;
 	q->lock_ptr = &hb->lock;
 
 	/* Signal locked state to the waiter */
@@ -826,7 +831,7 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	case Q_REQUEUE_PI_LOCKED:
 		/* The requeue acquired the lock */
 		if (q.pi_state && (q.pi_state->owner != current)) {
-			spin_lock(q.lock_ptr);
+			futex_q_lockptr_lock(&q);
 			ret = fixup_pi_owner(uaddr2, &q, true);
 			/*
 			 * Drop the reference to the pi state which the
@@ -853,7 +858,7 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 		if (ret && !rt_mutex_cleanup_proxy_lock(pi_mutex, &rt_waiter))
 			ret = 0;
 
-		spin_lock(q.lock_ptr);
+		futex_q_lockptr_lock(&q);
 		debug_rt_mutex_free_waiter(&rt_waiter);
 		/*
 		 * Fixup the pi_state owner and possibly acquire the lock if we
@@ -885,6 +890,11 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	default:
 		BUG();
 	}
+	if (q.drop_hb_ref) {
+		CLASS(hb, hb)(&q.key);
+		/* Additional reference from requeue_pi_wake_futex() */
+		futex_hash_put(hb);
+	}
 
 out:
 	if (to) {

