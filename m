Return-Path: <linux-tip-commits+bounces-7662-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 82F6CCBB7B0
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:52:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBAA6304AC82
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 07:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D7892DEA6B;
	Sun, 14 Dec 2025 07:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VYv7rzMh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yzx+RSfy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92EF82D47FE;
	Sun, 14 Dec 2025 07:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765698414; cv=none; b=IOx/phyzV5WZ9VVPtOMtV/EZgDflN9nAOEd10DAuG3PqBcO7esm7w2NVKRAv8DUQWDLTAF7jlvM8pXveZ2aZoplNUzAGw96gLG6XBOdtKsfZQsfoKXbMUGIhl47EvDIG3buXsncdXKVWKkaSXliHfRez5REyModDD5aIVkth0tA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765698414; c=relaxed/simple;
	bh=r0Bu5P3GWFeNRkzYcq6Ed+by3S5b7dOGbdEVe3uzj3g=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=vDzViUwdT9beaesHZNmwNEehNAp+opmZqdO8CBmgoCQo5bLw2d0hS0jmaXsM/ZX++pl7XqLYlc4eBQHz5T+7+GUkr7yIw84u0AbV1oDdTjAQR0eb5rizJ/78gS3M/Vh3gz4becliLNGco2e0j83K6/woAiQ3iaykQeS0OF7Y3QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VYv7rzMh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yzx+RSfy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 07:46:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765698410;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzvRLeFSWjPRKTGlkc4JTT0keOldcXJearmL42Jdbbk=;
	b=VYv7rzMhB4MDTj4tNGQ0b1QD8rnEojQG+176drOVGVuW8VyEwcKdFprktfA6iwGocPFWug
	Z0FX0rmzlmeHC/3BlOPhi64XCV9FWVEUgztIxigxlb49defktjAwpcpJO+Ga012sywesIz
	f6HKr2QkNizT1hYLxnMVqjfR1NG/yKsR78DQ/QaeMnqCDjSsITVOLMlNi7jn61hiB7femS
	WtLLJMyB1SZ3CNxrGdrFRoKVy8rpAZwMFFXuA9v43qKA491EVPc0quLMN79hWHlxw2t1bN
	SWkrPxjTUA09Ej8v1Et1SEmkyln9oR7nlImENfLGplrs3NXhutkG+LUzCIjTeQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765698410;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vzvRLeFSWjPRKTGlkc4JTT0keOldcXJearmL42Jdbbk=;
	b=yzx+RSfyt4lXVlCR1dBfDpQzQN4XKPO5vyxI0McDrgDRfEHNVoUAAC0J61zmG7/VYCZk6I
	/PkgOEZ99gI5CuDw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Fold the sched_avg update
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>, Mel Gorman <mgorman@suse.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251127154725.413564507@infradead.org>
References: <20251127154725.413564507@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176569840895.498.15732045270405223842.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     089d84203ad42bc8fd6dbf41683e162ac6e848cd
Gitweb:        https://git.kernel.org/tip/089d84203ad42bc8fd6dbf41683e162ac6e=
848cd
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 27 Nov 2025 16:39:44 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 08:25:02 +01:00

sched/fair: Fold the sched_avg update

Nine (and a half) instances of the same pattern is just silly, fold the lot.

Notably, the half instance in enqueue_load_avg() is right after setting
cfs_rq->avg.load_sum to cfs_rq->avg.load_avg * get_pelt_divider(&cfs_rq->avg).
Since get_pelt_divisor() >=3D PELT_MIN_DIVIDER, this ends up being a no-op
change.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://patch.msgid.link/20251127154725.413564507@infradead.org
---
 kernel/sched/fair.c | 108 ++++++++++++-------------------------------
 1 file changed, 32 insertions(+), 76 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index da46c31..aa033e4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3693,7 +3693,7 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sc=
hed_entity *se)
  */
 #define add_positive(_ptr, _val) do {                           \
 	typeof(_ptr) ptr =3D (_ptr);                              \
-	typeof(_val) val =3D (_val);                              \
+	__signed_scalar_typeof(*ptr) val =3D (_val);              \
 	typeof(*ptr) res, var =3D READ_ONCE(*ptr);                \
 								\
 	res =3D var + val;                                        \
@@ -3705,23 +3705,6 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct s=
ched_entity *se)
 } while (0)
=20
 /*
- * Unsigned subtract and clamp on underflow.
- *
- * Explicitly do a load-store to ensure the intermediate value never hits
- * memory. This allows lockless observations without ever seeing the negative
- * values.
- */
-#define sub_positive(_ptr, _val) do {				\
-	typeof(_ptr) ptr =3D (_ptr);				\
-	typeof(*ptr) val =3D (_val);				\
-	typeof(*ptr) res, var =3D READ_ONCE(*ptr);		\
-	res =3D var - val;					\
-	if (res > var)						\
-		res =3D 0;					\
-	WRITE_ONCE(*ptr, res);					\
-} while (0)
-
-/*
  * Remove and clamp on negative, from a local variable.
  *
  * A variant of sub_positive(), which does not use explicit load-store
@@ -3732,21 +3715,37 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct =
sched_entity *se)
 	*ptr -=3D min_t(typeof(*ptr), *ptr, _val);		\
 } while (0)
=20
+
+/*
+ * Because of rounding, se->util_sum might ends up being +1 more than
+ * cfs->util_sum. Although this is not a problem by itself, detaching
+ * a lot of tasks with the rounding problem between 2 updates of
+ * util_avg (~1ms) can make cfs->util_sum becoming null whereas
+ * cfs_util_avg is not.
+ *
+ * Check that util_sum is still above its lower bound for the new
+ * util_avg. Given that period_contrib might have moved since the last
+ * sync, we are only sure that util_sum must be above or equal to
+ *    util_avg * minimum possible divider
+ */
+#define __update_sa(sa, name, delta_avg, delta_sum) do {	\
+	add_positive(&(sa)->name##_avg, delta_avg);		\
+	add_positive(&(sa)->name##_sum, delta_sum);		\
+	(sa)->name##_sum =3D max_t(typeof((sa)->name##_sum),	\
+			       (sa)->name##_sum,		\
+			       (sa)->name##_avg * PELT_MIN_DIVIDER); \
+} while (0)
+
 static inline void
 enqueue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	cfs_rq->avg.load_avg +=3D se->avg.load_avg;
-	cfs_rq->avg.load_sum +=3D se_weight(se) * se->avg.load_sum;
+	__update_sa(&cfs_rq->avg, load, se->avg.load_avg, se->avg.load_sum);
 }
=20
 static inline void
 dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	sub_positive(&cfs_rq->avg.load_avg, se->avg.load_avg);
-	sub_positive(&cfs_rq->avg.load_sum, se_weight(se) * se->avg.load_sum);
-	/* See update_cfs_rq_load_avg() */
-	cfs_rq->avg.load_sum =3D max_t(u32, cfs_rq->avg.load_sum,
-					  cfs_rq->avg.load_avg * PELT_MIN_DIVIDER);
+	__update_sa(&cfs_rq->avg, load, -se->avg.load_avg, -se->avg.load_sum);
 }
=20
 static void place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int=
 flags);
@@ -4242,7 +4241,6 @@ update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_=
entity *se, struct cfs_rq
 	 */
 	divider =3D get_pelt_divider(&cfs_rq->avg);
=20
-
 	/* Set new sched_entity's utilization */
 	se->avg.util_avg =3D gcfs_rq->avg.util_avg;
 	new_sum =3D se->avg.util_avg * divider;
@@ -4250,12 +4248,7 @@ update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched=
_entity *se, struct cfs_rq
 	se->avg.util_sum =3D new_sum;
=20
 	/* Update parent cfs_rq utilization */
-	add_positive(&cfs_rq->avg.util_avg, delta_avg);
-	add_positive(&cfs_rq->avg.util_sum, delta_sum);
-
-	/* See update_cfs_rq_load_avg() */
-	cfs_rq->avg.util_sum =3D max_t(u32, cfs_rq->avg.util_sum,
-					  cfs_rq->avg.util_avg * PELT_MIN_DIVIDER);
+	__update_sa(&cfs_rq->avg, util, delta_avg, delta_sum);
 }
=20
 static inline void
@@ -4281,11 +4274,7 @@ update_tg_cfs_runnable(struct cfs_rq *cfs_rq, struct s=
ched_entity *se, struct cf
 	se->avg.runnable_sum =3D new_sum;
=20
 	/* Update parent cfs_rq runnable */
-	add_positive(&cfs_rq->avg.runnable_avg, delta_avg);
-	add_positive(&cfs_rq->avg.runnable_sum, delta_sum);
-	/* See update_cfs_rq_load_avg() */
-	cfs_rq->avg.runnable_sum =3D max_t(u32, cfs_rq->avg.runnable_sum,
-					      cfs_rq->avg.runnable_avg * PELT_MIN_DIVIDER);
+	__update_sa(&cfs_rq->avg, runnable, delta_avg, delta_sum);
 }
=20
 static inline void
@@ -4349,11 +4338,7 @@ update_tg_cfs_load(struct cfs_rq *cfs_rq, struct sched=
_entity *se, struct cfs_rq
=20
 	se->avg.load_sum =3D runnable_sum;
 	se->avg.load_avg =3D load_avg;
-	add_positive(&cfs_rq->avg.load_avg, delta_avg);
-	add_positive(&cfs_rq->avg.load_sum, delta_sum);
-	/* See update_cfs_rq_load_avg() */
-	cfs_rq->avg.load_sum =3D max_t(u32, cfs_rq->avg.load_sum,
-					  cfs_rq->avg.load_avg * PELT_MIN_DIVIDER);
+	__update_sa(&cfs_rq->avg, load, delta_avg, delta_sum);
 }
=20
 static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable=
_sum)
@@ -4552,33 +4537,13 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
 		raw_spin_unlock(&cfs_rq->removed.lock);
=20
 		r =3D removed_load;
-		sub_positive(&sa->load_avg, r);
-		sub_positive(&sa->load_sum, r * divider);
-		/* See sa->util_sum below */
-		sa->load_sum =3D max_t(u32, sa->load_sum, sa->load_avg * PELT_MIN_DIVIDER);
+		__update_sa(sa, load, -r, -r*divider);
=20
 		r =3D removed_util;
-		sub_positive(&sa->util_avg, r);
-		sub_positive(&sa->util_sum, r * divider);
-		/*
-		 * Because of rounding, se->util_sum might ends up being +1 more than
-		 * cfs->util_sum. Although this is not a problem by itself, detaching
-		 * a lot of tasks with the rounding problem between 2 updates of
-		 * util_avg (~1ms) can make cfs->util_sum becoming null whereas
-		 * cfs_util_avg is not.
-		 * Check that util_sum is still above its lower bound for the new
-		 * util_avg. Given that period_contrib might have moved since the last
-		 * sync, we are only sure that util_sum must be above or equal to
-		 *    util_avg * minimum possible divider
-		 */
-		sa->util_sum =3D max_t(u32, sa->util_sum, sa->util_avg * PELT_MIN_DIVIDER);
+		__update_sa(sa, util, -r, -r*divider);
=20
 		r =3D removed_runnable;
-		sub_positive(&sa->runnable_avg, r);
-		sub_positive(&sa->runnable_sum, r * divider);
-		/* See sa->util_sum above */
-		sa->runnable_sum =3D max_t(u32, sa->runnable_sum,
-					      sa->runnable_avg * PELT_MIN_DIVIDER);
+		__update_sa(sa, runnable, -r, -r*divider);
=20
 		/*
 		 * removed_runnable is the unweighted version of removed_load so we
@@ -4663,17 +4628,8 @@ static void attach_entity_load_avg(struct cfs_rq *cfs_=
rq, struct sched_entity *s
 static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entit=
y *se)
 {
 	dequeue_load_avg(cfs_rq, se);
-	sub_positive(&cfs_rq->avg.util_avg, se->avg.util_avg);
-	sub_positive(&cfs_rq->avg.util_sum, se->avg.util_sum);
-	/* See update_cfs_rq_load_avg() */
-	cfs_rq->avg.util_sum =3D max_t(u32, cfs_rq->avg.util_sum,
-					  cfs_rq->avg.util_avg * PELT_MIN_DIVIDER);
-
-	sub_positive(&cfs_rq->avg.runnable_avg, se->avg.runnable_avg);
-	sub_positive(&cfs_rq->avg.runnable_sum, se->avg.runnable_sum);
-	/* See update_cfs_rq_load_avg() */
-	cfs_rq->avg.runnable_sum =3D max_t(u32, cfs_rq->avg.runnable_sum,
-					      cfs_rq->avg.runnable_avg * PELT_MIN_DIVIDER);
+	__update_sa(&cfs_rq->avg, util, -se->avg.util_avg, -se->avg.util_sum);
+	__update_sa(&cfs_rq->avg, runnable, -se->avg.runnable_avg, -se->avg.runnabl=
e_sum);
=20
 	add_tg_cfs_propagate(cfs_rq, -se->avg.load_sum);
=20

