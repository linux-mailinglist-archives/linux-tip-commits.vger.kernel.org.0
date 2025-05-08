Return-Path: <linux-tip-commits+bounces-5479-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D66AAAF807
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 12:37:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6006A167912
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 May 2025 10:37:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C48B722D793;
	Thu,  8 May 2025 10:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Q2APzils";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J/ZgdIWA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD4922B581;
	Thu,  8 May 2025 10:33:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746700441; cv=none; b=TP+8IAKpskmpaB54Cxay1KuNIAwnf9Omk6zob67B0i5fad6dEBm0iz/VIKSTIXmCSIGy2hYp+oiglZMUvqH6cU5e1MT7mV8dsL1M0tWVZTsJuiEypZUeayCd5y/mjPr8U6OJ2uFbcfuO6whdyyYbzcRWb8FyShorEKg+J9r5JhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746700441; c=relaxed/simple;
	bh=uug6YibHPnddICp2w95P8O6Eup8gvSDn/5kLo/prxKg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=AdxgA4iOyWyLlTGiTqNk0ar/RfecnwvSzYhSkdbvSiDaeROgzDEDhx6RgPgWkpXUtZei9+CkVZ4cLT5UIdVVSHBIhzcbsnEH/hYlQaU4/nzBC8nRfPo3bhLjcoXETr/MgpdhXSwjz6DULzeYObgQWcyzSWtdNBCjxnSl6KCc9xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Q2APzils; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J/ZgdIWA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 08 May 2025 10:33:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746700438;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/vBlTQyw9629Dpc9q+aEG6jInKHk47GuWVGoJI9bq5g=;
	b=Q2APzilsHgKU0yKxyDKPTzgQcGCa0YspPdGPryzjsCCouUoyT2UX2x6n5EsF26jL4ccB88
	RwP7U+Pn7+eI/USJm+ZO/9lclRIV1KPTJwASfHykvXgvN02CFcgHlveEY96HAWynMxAEoo
	Px/Ct0jbnRHob5Z/EQRbEtyxFEXxEEZIpzjzBz7JjV6Xx9zr4hgS454z1yWpGs/DRSRuQb
	QwGyfsa9/cX54Wec7xBFOG1Oid5xrskAv9E61taKqegxBUfUjDKvWZswVa2+GfHhvwD1/Y
	1Cy45zVGB1ae8oRRzEhm9DHK8lbSU5uPBr7s3gr8HIUaLBXW6L1Q1bWC6k/mkg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746700438;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/vBlTQyw9629Dpc9q+aEG6jInKHk47GuWVGoJI9bq5g=;
	b=J/ZgdIWAobFlAzPRB1iTjzfMOBdYrHJXPYwaK8B3zd13g7QLlS7X5NjuZWWCAyUz650CuB
	e3VbCy/tvCQT4fBQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] futex: Create futex_hash() get/put class
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250416162921.513656-7-bigeasy@linutronix.de>
References: <20250416162921.513656-7-bigeasy@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174670043699.406.6341213088234094404.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     6c67f8d880c0950215b8e6f8539562ad1971a05a
Gitweb:        https://git.kernel.org/tip/6c67f8d880c0950215b8e6f8539562ad1971a05a
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 16 Apr 2025 18:29:06 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 03 May 2025 12:02:06 +02:00

futex: Create futex_hash() get/put class

This gets us:

  hb = futex_hash(key) /* gets hb and inc users */
  futex_hash_get(hb)   /* inc users */
  futex_hash_put(hb)   /* dec users */

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250416162921.513656-7-bigeasy@linutronix.de
---
 kernel/futex/core.c     |  6 +++---
 kernel/futex/futex.h    |  7 +++++++
 kernel/futex/pi.c       | 16 ++++++++++++----
 kernel/futex/requeue.c  | 10 +++-------
 kernel/futex/waitwake.c | 15 +++++----------
 5 files changed, 30 insertions(+), 24 deletions(-)

diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index e4cb5ce..56a5653 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -122,6 +122,8 @@ struct futex_hash_bucket *futex_hash(union futex_key *key)
 	return &futex_queues[hash & futex_hashmask];
 }
 
+void futex_hash_get(struct futex_hash_bucket *hb) { }
+void futex_hash_put(struct futex_hash_bucket *hb) { }
 
 /**
  * futex_setup_timer - set up the sleeping hrtimer.
@@ -957,9 +959,7 @@ static void exit_pi_state_list(struct task_struct *curr)
 		pi_state = list_entry(next, struct futex_pi_state, list);
 		key = pi_state->key;
 		if (1) {
-			struct futex_hash_bucket *hb;
-
-			hb = futex_hash(&key);
+			CLASS(hb, hb)(&key);
 
 			/*
 			 * We can race against put_pi_state() removing itself from the
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index a219903..77d9b35 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -7,6 +7,7 @@
 #include <linux/sched/wake_q.h>
 #include <linux/compat.h>
 #include <linux/uaccess.h>
+#include <linux/cleanup.h>
 
 #ifdef CONFIG_PREEMPT_RT
 #include <linux/rcuwait.h>
@@ -202,6 +203,12 @@ futex_setup_timer(ktime_t *time, struct hrtimer_sleeper *timeout,
 		  int flags, u64 range_ns);
 
 extern struct futex_hash_bucket *futex_hash(union futex_key *key);
+extern void futex_hash_get(struct futex_hash_bucket *hb);
+extern void futex_hash_put(struct futex_hash_bucket *hb);
+
+DEFINE_CLASS(hb, struct futex_hash_bucket *,
+	     if (_T) futex_hash_put(_T),
+	     futex_hash(key), union futex_key *key);
 
 /**
  * futex_match - Check whether two futex keys are equal
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index a56f28f..e52f540 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -939,9 +939,8 @@ retry:
 
 retry_private:
 	if (1) {
-		struct futex_hash_bucket *hb;
+		CLASS(hb, hb)(&q.key);
 
-		hb = futex_hash(&q.key);
 		futex_q_lock(&q, hb);
 
 		ret = futex_lock_pi_atomic(uaddr, hb, &q.key, &q.pi_state, current,
@@ -995,6 +994,16 @@ retry_private:
 		}
 
 		/*
+		 * Caution; releasing @hb in-scope. The hb->lock is still locked
+		 * while the reference is dropped. The reference can not be dropped
+		 * after the unlock because if a user initiated resize is in progress
+		 * then we might need to wake him. This can not be done after the
+		 * rt_mutex_pre_schedule() invocation. The hb will remain valid because
+		 * the thread, performing resize, will block on hb->lock during
+		 * the requeue.
+		 */
+		futex_hash_put(no_free_ptr(hb));
+		/*
 		 * Must be done before we enqueue the waiter, here is unfortunately
 		 * under the hb lock, but that *should* work because it does nothing.
 		 */
@@ -1119,7 +1128,6 @@ int futex_unlock_pi(u32 __user *uaddr, unsigned int flags)
 {
 	u32 curval, uval, vpid = task_pid_vnr(current);
 	union futex_key key = FUTEX_KEY_INIT;
-	struct futex_hash_bucket *hb;
 	struct futex_q *top_waiter;
 	int ret;
 
@@ -1139,7 +1147,7 @@ retry:
 	if (ret)
 		return ret;
 
-	hb = futex_hash(&key);
+	CLASS(hb, hb)(&key);
 	spin_lock(&hb->lock);
 retry_hb:
 
diff --git a/kernel/futex/requeue.c b/kernel/futex/requeue.c
index 209794c..992e3ce 100644
--- a/kernel/futex/requeue.c
+++ b/kernel/futex/requeue.c
@@ -444,10 +444,8 @@ retry:
 
 retry_private:
 	if (1) {
-		struct futex_hash_bucket *hb1, *hb2;
-
-		hb1 = futex_hash(&key1);
-		hb2 = futex_hash(&key2);
+		CLASS(hb, hb1)(&key1);
+		CLASS(hb, hb2)(&key2);
 
 		futex_hb_waiters_inc(hb2);
 		double_lock_hb(hb1, hb2);
@@ -817,9 +815,7 @@ int futex_wait_requeue_pi(u32 __user *uaddr, unsigned int flags,
 	switch (futex_requeue_pi_wakeup_sync(&q)) {
 	case Q_REQUEUE_PI_IGNORE:
 		{
-			struct futex_hash_bucket *hb;
-
-			hb = futex_hash(&q.key);
+			CLASS(hb, hb)(&q.key);
 			/* The waiter is still on uaddr1 */
 			spin_lock(&hb->lock);
 			ret = handle_early_requeue_pi_wakeup(hb, &q, to);
diff --git a/kernel/futex/waitwake.c b/kernel/futex/waitwake.c
index 7dc35be..d52541b 100644
--- a/kernel/futex/waitwake.c
+++ b/kernel/futex/waitwake.c
@@ -154,7 +154,6 @@ void futex_wake_mark(struct wake_q_head *wake_q, struct futex_q *q)
  */
 int futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
 {
-	struct futex_hash_bucket *hb;
 	struct futex_q *this, *next;
 	union futex_key key = FUTEX_KEY_INIT;
 	DEFINE_WAKE_Q(wake_q);
@@ -170,7 +169,7 @@ int futex_wake(u32 __user *uaddr, unsigned int flags, int nr_wake, u32 bitset)
 	if ((flags & FLAGS_STRICT) && !nr_wake)
 		return 0;
 
-	hb = futex_hash(&key);
+	CLASS(hb, hb)(&key);
 
 	/* Make sure we really have tasks to wakeup */
 	if (!futex_hb_waiters_pending(hb))
@@ -267,10 +266,8 @@ retry:
 
 retry_private:
 	if (1) {
-		struct futex_hash_bucket *hb1, *hb2;
-
-		hb1 = futex_hash(&key1);
-		hb2 = futex_hash(&key2);
+		CLASS(hb, hb1)(&key1);
+		CLASS(hb, hb2)(&key2);
 
 		double_lock_hb(hb1, hb2);
 		op_ret = futex_atomic_op_inuser(op, uaddr2);
@@ -444,9 +441,8 @@ retry:
 		u32 val = vs[i].w.val;
 
 		if (1) {
-			struct futex_hash_bucket *hb;
+			CLASS(hb, hb)(&q->key);
 
-			hb = futex_hash(&q->key);
 			futex_q_lock(q, hb);
 			ret = futex_get_value_locked(&uval, uaddr);
 
@@ -618,9 +614,8 @@ retry:
 
 retry_private:
 	if (1) {
-		struct futex_hash_bucket *hb;
+		CLASS(hb, hb)(&q->key);
 
-		hb = futex_hash(&q->key);
 		futex_q_lock(q, hb);
 
 		ret = futex_get_value_locked(&uval, uaddr);

