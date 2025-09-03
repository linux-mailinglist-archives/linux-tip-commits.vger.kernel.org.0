Return-Path: <linux-tip-commits+bounces-6419-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 720D4B417D4
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 10:05:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4A98B189CE95
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 08:05:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8C932E54A0;
	Wed,  3 Sep 2025 08:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UctTafT2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qpo4PvUU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB5AF2DAFAF;
	Wed,  3 Sep 2025 08:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886715; cv=none; b=b+365eAxhy8Vs0+7huhG48c8VsIAFWYXHDriFPPs2V/xzqNmLpmJRc/I3gRf7jZixUAfun9U4oHr3zZdVv0eIlrBbM1uMrHo0a72G5Ywfsrp8as1xj2vi47kLpFIRDjqajJkU9oCulDyPkQG3K1CbsRz4NgtlCW3kjT/UXzSQCY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886715; c=relaxed/simple;
	bh=z9Ybw6/OZqqzLimUrhVTuSl3dpkfLhAbuC4BSzVN4/0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=X+6VPPiXhfUdrzEr5FPLb6/w7CT+f1UuZEp3vumisOU4rHfxCGgpBvgqWf/M9k67g+mV2HqIIgGKKKPWshuaSo7zkakPo6DcUo+iIYhTWLmxxgtf8TgFzoz/BLntZM8Jd9Yvpxg84ukEhAkXoCX5mpfubdwh8jncwhJDxqEkjcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UctTafT2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qpo4PvUU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Sep 2025 08:05:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756886708;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qCLhSUlGI029fD9boC8VJGSbauc30F0+FNGgD1x5TN8=;
	b=UctTafT2Nzf9V7A4kMnt/9s3P7ceomhp+gm5AFlB3qARl4zXyv9AxWbKNQ+ZVawyF53izh
	0mVvJFzRnCefa3iWwVh1bGv4H5tB6BDh5G2prfSOSdG499C0hk+lU2w12wsswak6dDpc7S
	wD5S3XSK1a9zTmNxIa1SJzSq3ZY79NtRsfWOl29vtPXpQGeOTREUfomLpsGY+iKTZEhAOy
	/9ZYIqfaFts8UAN89GvUlvriNk3GPBtjTTFKF4daDGBAeODcJV1zVLkwz1ukHglw/KM5SX
	M5gIZIbaBtyh0WJ8EqLvj/jcJgCQ9fk6a6KSmu9uvpD+HNDmwVkKtNoQ4qAX3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756886708;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qCLhSUlGI029fD9boC8VJGSbauc30F0+FNGgD1x5TN8=;
	b=qpo4PvUUvPiZPbXDz1Z3K6xtQMH25ePWN943TGTIfv0K0HzfA8zQTrUq2aq4o0fG7jsbRA
	l6US/v3vUmR2sfAA==
From: "tip-bot2 for Aaron Lu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Task based throttle time accounting
Cc: Chengming Zhou <chengming.zhou@linux.dev>,
 K Prateek Nayak <kprateek.nayak@amd.com>, Aaron Lu <ziqianlu@bytedance.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Matteo Martelli <matteo.martelli@codethink.co.uk>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250829081120.806-5-ziqianlu@bytedance.com>
References: <20250829081120.806-5-ziqianlu@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175688670720.1920.7895505954812533682.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     eb962f251fbba251a0d34897d6170f7616d70c52
Gitweb:        https://git.kernel.org/tip/eb962f251fbba251a0d34897d6170f7616d=
70c52
Author:        Aaron Lu <ziqianlu@bytedance.com>
AuthorDate:    Fri, 29 Aug 2025 16:11:19 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 03 Sep 2025 10:03:14 +02:00

sched/fair: Task based throttle time accounting

With task based throttle model, the previous way to check cfs_rq's
nr_queued to decide if throttled time should be accounted doesn't work
as expected, e.g. when a cfs_rq which has a single task is throttled,
that task could later block in kernel mode instead of being dequeued on
limbo list and accounting this as throttled time is not accurate.

Rework throttle time accounting for a cfs_rq as follows:
- start accounting when the first task gets throttled in its hierarchy;
- stop accounting on unthrottle.

Note that there will be a time gap between when a cfs_rq is throttled
and when a task in its hierarchy is actually throttled. This accounting
mechanism only starts accounting in the latter case.

Suggested-by: Chengming Zhou <chengming.zhou@linux.dev> # accounting mechanism
Co-developed-by: K Prateek Nayak <kprateek.nayak@amd.com> # simplify implemen=
tation
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Aaron Lu <ziqianlu@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Matteo Martelli <matteo.martelli@codethink.co.uk>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/r/20250829081120.806-5-ziqianlu@bytedance.com
---
 kernel/sched/fair.c  | 56 +++++++++++++++++++++++--------------------
 kernel/sched/sched.h |  1 +-
 2 files changed, 32 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 25b1014..bdc9bfa 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5293,19 +5293,12 @@ enqueue_entity(struct cfs_rq *cfs_rq, struct sched_en=
tity *se, int flags)
 		check_enqueue_throttle(cfs_rq);
 		list_add_leaf_cfs_rq(cfs_rq);
 #ifdef CONFIG_CFS_BANDWIDTH
-		if (throttled_hierarchy(cfs_rq)) {
+		if (cfs_rq->pelt_clock_throttled) {
 			struct rq *rq =3D rq_of(cfs_rq);
=20
-			if (cfs_rq_throttled(cfs_rq) && !cfs_rq->throttled_clock)
-				cfs_rq->throttled_clock =3D rq_clock(rq);
-			if (!cfs_rq->throttled_clock_self)
-				cfs_rq->throttled_clock_self =3D rq_clock(rq);
-
-			if (cfs_rq->pelt_clock_throttled) {
-				cfs_rq->throttled_clock_pelt_time +=3D rq_clock_pelt(rq) -
-					cfs_rq->throttled_clock_pelt;
-				cfs_rq->pelt_clock_throttled =3D 0;
-			}
+			cfs_rq->throttled_clock_pelt_time +=3D rq_clock_pelt(rq) -
+				cfs_rq->throttled_clock_pelt;
+			cfs_rq->pelt_clock_throttled =3D 0;
 		}
 #endif
 	}
@@ -5393,7 +5386,7 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_enti=
ty *se, int flags)
 		 * DELAY_DEQUEUE relies on spurious wakeups, special task
 		 * states must not suffer spurious wakeups, excempt them.
 		 */
-		if (flags & DEQUEUE_SPECIAL)
+		if (flags & (DEQUEUE_SPECIAL | DEQUEUE_THROTTLE))
 			delay =3D false;
=20
 		WARN_ON_ONCE(delay && se->sched_delayed);
@@ -5799,7 +5792,7 @@ static void throttle_cfs_rq_work(struct callback_head *=
work)
 		rq =3D scope.rq;
 		update_rq_clock(rq);
 		WARN_ON_ONCE(p->throttled || !list_empty(&p->throttle_node));
-		dequeue_task_fair(rq, p, DEQUEUE_SLEEP | DEQUEUE_SPECIAL);
+		dequeue_task_fair(rq, p, DEQUEUE_SLEEP | DEQUEUE_THROTTLE);
 		list_add(&p->throttle_node, &cfs_rq->throttled_limbo_list);
 		/*
 		 * Must not set throttled before dequeue or dequeue will
@@ -5959,6 +5952,17 @@ static inline void task_throttle_setup_work(struct tas=
k_struct *p)
 	task_work_add(p, &p->sched_throttle_work, TWA_RESUME);
 }
=20
+static void record_throttle_clock(struct cfs_rq *cfs_rq)
+{
+	struct rq *rq =3D rq_of(cfs_rq);
+
+	if (cfs_rq_throttled(cfs_rq) && !cfs_rq->throttled_clock)
+		cfs_rq->throttled_clock =3D rq_clock(rq);
+
+	if (!cfs_rq->throttled_clock_self)
+		cfs_rq->throttled_clock_self =3D rq_clock(rq);
+}
+
 static int tg_throttle_down(struct task_group *tg, void *data)
 {
 	struct rq *rq =3D data;
@@ -5967,21 +5971,17 @@ static int tg_throttle_down(struct task_group *tg, vo=
id *data)
 	if (cfs_rq->throttle_count++)
 		return 0;
=20
-
-	/* group is entering throttled state, stop time */
-	WARN_ON_ONCE(cfs_rq->throttled_clock_self);
-	if (cfs_rq->nr_queued)
-		cfs_rq->throttled_clock_self =3D rq_clock(rq);
-	else {
-		/*
-		 * For cfs_rqs that still have entities enqueued, PELT clock
-		 * stop happens at dequeue time when all entities are dequeued.
-		 */
+	/*
+	 * For cfs_rqs that still have entities enqueued, PELT clock
+	 * stop happens at dequeue time when all entities are dequeued.
+	 */
+	if (!cfs_rq->nr_queued) {
 		list_del_leaf_cfs_rq(cfs_rq);
 		cfs_rq->throttled_clock_pelt =3D rq_clock_pelt(rq);
 		cfs_rq->pelt_clock_throttled =3D 1;
 	}
=20
+	WARN_ON_ONCE(cfs_rq->throttled_clock_self);
 	WARN_ON_ONCE(!list_empty(&cfs_rq->throttled_limbo_list));
 	return 0;
 }
@@ -6024,8 +6024,6 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 	 */
 	cfs_rq->throttled =3D 1;
 	WARN_ON_ONCE(cfs_rq->throttled_clock);
-	if (cfs_rq->nr_queued)
-		cfs_rq->throttled_clock =3D rq_clock(rq);
 	return true;
 }
=20
@@ -6733,6 +6731,7 @@ static void task_throttle_setup_work(struct task_struct=
 *p) {}
 static bool task_is_throttled(struct task_struct *p) { return false; }
 static void dequeue_throttled_task(struct task_struct *p, int flags) {}
 static bool enqueue_throttled_task(struct task_struct *p) { return false; }
+static void record_throttle_clock(struct cfs_rq *cfs_rq) {}
=20
 static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq)
 {
@@ -7051,6 +7050,7 @@ static int dequeue_entities(struct rq *rq, struct sched=
_entity *se, int flags)
 	bool was_sched_idle =3D sched_idle_rq(rq);
 	bool task_sleep =3D flags & DEQUEUE_SLEEP;
 	bool task_delayed =3D flags & DEQUEUE_DELAYED;
+	bool task_throttled =3D flags & DEQUEUE_THROTTLE;
 	struct task_struct *p =3D NULL;
 	int h_nr_idle =3D 0;
 	int h_nr_queued =3D 0;
@@ -7084,6 +7084,9 @@ static int dequeue_entities(struct rq *rq, struct sched=
_entity *se, int flags)
 		if (cfs_rq_is_idle(cfs_rq))
 			h_nr_idle =3D h_nr_queued;
=20
+		if (throttled_hierarchy(cfs_rq) && task_throttled)
+			record_throttle_clock(cfs_rq);
+
 		/* Don't dequeue parent if it has other entities besides us */
 		if (cfs_rq->load.weight) {
 			slice =3D cfs_rq_min_slice(cfs_rq);
@@ -7120,6 +7123,9 @@ static int dequeue_entities(struct rq *rq, struct sched=
_entity *se, int flags)
=20
 		if (cfs_rq_is_idle(cfs_rq))
 			h_nr_idle =3D h_nr_queued;
+
+		if (throttled_hierarchy(cfs_rq) && task_throttled)
+			record_throttle_clock(cfs_rq);
 	}
=20
 	sub_nr_running(rq, h_nr_queued);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6e1b37b..b5367c5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2344,6 +2344,7 @@ extern const u32		sched_prio_to_wmult[40];
 #define DEQUEUE_SPECIAL		0x10
 #define DEQUEUE_MIGRATING	0x100 /* Matches ENQUEUE_MIGRATING */
 #define DEQUEUE_DELAYED		0x200 /* Matches ENQUEUE_DELAYED */
+#define DEQUEUE_THROTTLE	0x800
=20
 #define ENQUEUE_WAKEUP		0x01
 #define ENQUEUE_RESTORE		0x02

