Return-Path: <linux-tip-commits+bounces-7303-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 501E8C4D72D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 12:42:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A3D0189AA80
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 11:40:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19E3E35A945;
	Tue, 11 Nov 2025 11:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AER+VIbK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LN0gWQoo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBB6735A148;
	Tue, 11 Nov 2025 11:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861045; cv=none; b=VdW/7itATWDNAzXci9pnlqfmcwm5T+FIGNafnqEc5CSWh4PIFLnrwOataUyhhiHp9FugsNLUY1volQ5JeNjXvHvuywoO/wZ7BEKBwgPbpoiFJabUrRQmIR2UGw6G+7GYwb33FgGQHTOA8dkJiEV+Dj6QvdxncgG56pJVV8+umkA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861045; c=relaxed/simple;
	bh=XQFKDHy59O6bEE1IeHhXoAW69drdAgefdfZ80dWY6ag=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rhGvcg4R5MG3Ot/g8eR+1GsYBVsQTkB9LPXJ60ze7uhgjnWegz9rRhNyY8CTQdEiRua+K7dmT4v0a3JASO2RwGBwCWp6+9lmHJWK8E8JnMqX+hOxT5KPldgi6cwGg1U6J+rx4sxiElye3h2i94zy7bo1RaFQcPcFe4mFDsCMM2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AER+VIbK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LN0gWQoo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 11:37:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762861041;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Pijp7WiI4wxxiTwlXMUifmU3zXyfJNCFta2ldMxMVU=;
	b=AER+VIbKsXzwgbR8Firz0MnozrO8WXo/aC35ujllqFHeSIvuIJJLASP506OFjjq72fOyXV
	r7oSvAusHr3zhmerB8bhpC7dxMV/1aJQSFeUNMQVWAml4MJkWFYwXJBdgiWpvhLLdsSUip
	RNu5C8FAWLTpO+HYy4yj8wzo4EKvkKF91TPi6aJguOh/Pc6nrGSD0FJGYTD8S4//I3pgEI
	rI0IBEfjnoVfglxFnCuQTDNnYQA/jGtYx3LodYUiIff3IoBP4G/DTkS1oiW2APeS8Pu7ky
	uG54WDYeKv+mSp05FQewYIwS59UnAAWZi5ebWWX73It/xeAPeUjUc/B972c68A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762861041;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7Pijp7WiI4wxxiTwlXMUifmU3zXyfJNCFta2ldMxMVU=;
	b=LN0gWQooFeqd8FHqDrRN/bG7p7HOkxFOkG6wS1/Ox/v/iB1Z2zcR0CSWUxF7MJOBrNVu61
	3SvcCMymdDL9UBCQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Add comment explaining force-idle
 vruntime snapshots
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251106111603.GB4068168@noisy.programming.kicks-ass.net>
References: <20251106111603.GB4068168@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176286104030.498.2731665810575423837.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9359d9785d85bb53f1ff1738a59aeeec4b878906
Gitweb:        https://git.kernel.org/tip/9359d9785d85bb53f1ff1738a59aeeec4b8=
78906
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 06 Nov 2025 10:50:49 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 11 Nov 2025 12:33:37 +01:00

sched/core: Add comment explaining force-idle vruntime snapshots

I always end up having to re-read these emails every time I look at
this code. And a future patch is going to change this story a little.
This means it is past time to stick them in a comment so it can be
modified and stay current.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200506143506.GH5298@hirez.programming.kicks=
-ass.net
Link: https://lkml.kernel.org/r/20200515103844.GG2978@hirez.programming.kicks=
-ass.net
Link: https://patch.msgid.link/20251106111603.GB4068168@noisy.programming.kic=
ks-ass.net
---
 kernel/sched/fair.c | 181 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 181 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f1d8eb3..4a11a83 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -13015,6 +13015,187 @@ static inline void task_tick_core(struct rq *rq, st=
ruct task_struct *curr)
 }
=20
 /*
+ * Consider any infeasible weight scenario. Take for instance two tasks,
+ * each bound to their respective sibling, one with weight 1 and one with
+ * weight 2. Then the lower weight task will run ahead of the higher weight
+ * task without bound.
+ *
+ * This utterly destroys the concept of a shared time base.
+ *
+ * Remember; all this is about a proportionally fair scheduling, where each
+ * tasks receives:
+ *
+ *              w_i
+ *   dt_i =3D ---------- dt                                     (1)
+ *          \Sum_j w_j
+ *
+ * which we do by tracking a virtual time, s_i:
+ *
+ *          1
+ *   s_i =3D --- d[t]_i                                         (2)
+ *         w_i
+ *
+ * Where d[t] is a delta of discrete time, while dt is an infinitesimal.
+ * The immediate corollary is that the ideal schedule S, where (2) to use
+ * an infinitesimal delta, is:
+ *
+ *           1
+ *   S =3D ---------- dt                                        (3)
+ *       \Sum_i w_i
+ *
+ * From which we can define the lag, or deviation from the ideal, as:
+ *
+ *   lag(i) =3D S - s_i                                         (4)
+ *
+ * And since the one and only purpose is to approximate S, we get that:
+ *
+ *   \Sum_i w_i lag(i) :=3D 0                                   (5)
+ *
+ * If this were not so, we no longer converge to S, and we can no longer
+ * claim our scheduler has any of the properties we derive from S. This is
+ * exactly what you did above, you broke it!
+ *
+ *
+ * Let's continue for a while though; to see if there is anything useful to
+ * be learned. We can combine (1)-(3) or (4)-(5) and express S in s_i:
+ *
+ *       \Sum_i w_i s_i
+ *   S =3D --------------                                       (6)
+ *         \Sum_i w_i
+ *
+ * Which gives us a way to compute S, given our s_i. Now, if you've read
+ * our code, you know that we do not in fact do this, the reason for this
+ * is two-fold. Firstly, computing S in that way requires a 64bit division
+ * for every time we'd use it (see 12), and secondly, this only describes
+ * the steady-state, it doesn't handle dynamics.
+ *
+ * Anyway, in (6):  s_i -> x + (s_i - x), to get:
+ *
+ *           \Sum_i w_i (s_i - x)
+ *   S - x =3D --------------------                             (7)
+ *              \Sum_i w_i
+ *
+ * Which shows that S and s_i transform alike (which makes perfect sense
+ * given that S is basically the (weighted) average of s_i).
+ *
+ * Then:
+ *
+ *   x -> s_min :=3D min{s_i}                                   (8)
+ *
+ * to obtain:
+ *
+ *               \Sum_i w_i (s_i - s_min)
+ *   S =3D s_min + ------------------------                     (9)
+ *                     \Sum_i w_i
+ *
+ * Which already looks familiar, and is the basis for our current
+ * approximation:
+ *
+ *   S ~=3D s_min                                              (10)
+ *
+ * Now, obviously, (10) is absolute crap :-), but it sorta works.
+ *
+ * So the thing to remember is that the above is strictly UP. It is
+ * possible to generalize to multiple runqueues -- however it gets really
+ * yuck when you have to add affinity support, as illustrated by our very
+ * first counter-example.
+ *
+ * Luckily I think we can avoid needing a full multi-queue variant for
+ * core-scheduling (or load-balancing). The crucial observation is that we
+ * only actually need this comparison in the presence of forced-idle; only
+ * then do we need to tell if the stalled rq has higher priority over the
+ * other.
+ *
+ * [XXX assumes SMT2; better consider the more general case, I suspect
+ * it'll work out because our comparison is always between 2 rqs and the
+ * answer is only interesting if one of them is forced-idle]
+ *
+ * And (under assumption of SMT2) when there is forced-idle, there is only
+ * a single queue, so everything works like normal.
+ *
+ * Let, for our runqueue 'k':
+ *
+ *   T_k =3D \Sum_i w_i s_i
+ *   W_k =3D \Sum_i w_i      ; for all i of k                  (11)
+ *
+ * Then we can write (6) like:
+ *
+ *         T_k
+ *   S_k =3D ---                                               (12)
+ *         W_k
+ *
+ * From which immediately follows that:
+ *
+ *           T_k + T_l
+ *   S_k+l =3D ---------                                       (13)
+ *           W_k + W_l
+ *
+ * On which we can define a combined lag:
+ *
+ *   lag_k+l(i) :=3D S_k+l - s_i                               (14)
+ *
+ * And that gives us the tools to compare tasks across a combined runqueue.
+ *
+ *
+ * Combined this gives the following:
+ *
+ *  a) when a runqueue enters force-idle, sync it against it's sibling rq(s)
+ *     using (7); this only requires storing single 'time'-stamps.
+ *
+ *  b) when comparing tasks between 2 runqueues of which one is forced-idle,
+ *     compare the combined lag, per (14).
+ *
+ * Now, of course cgroups (I so hate them) make this more interesting in
+ * that a) seems to suggest we need to iterate all cgroup on a CPU at such
+ * boundaries, but I think we can avoid that. The force-idle is for the
+ * whole CPU, all it's rqs. So we can mark it in the root and lazily
+ * propagate downward on demand.
+ */
+
+/*
+ * So this sync is basically a relative reset of S to 0.
+ *
+ * So with 2 queues, when one goes idle, we drop them both to 0 and one
+ * then increases due to not being idle, and the idle one builds up lag to
+ * get re-elected. So far so simple, right?
+ *
+ * When there's 3, we can have the situation where 2 run and one is idle,
+ * we sync to 0 and let the idle one build up lag to get re-election. Now
+ * suppose another one also drops idle. At this point dropping all to 0
+ * again would destroy the built-up lag from the queue that was already
+ * idle, not good.
+ *
+ * So instead of syncing everything, we can:
+ *
+ *   less :=3D !((s64)(s_a - s_b) <=3D 0)
+ *
+ *   (v_a - S_a) - (v_b - S_b) =3D=3D v_a - v_b - S_a + S_b
+ *                             =3D=3D v_a - (v_b - S_a + S_b)
+ *
+ * IOW, we can recast the (lag) comparison to a one-sided difference.
+ * So if then, instead of syncing the whole queue, sync the idle queue
+ * against the active queue with S_a + S_b at the point where we sync.
+ *
+ * (XXX consider the implication of living in a cyclic group: N / 2^n N)
+ *
+ * This gives us means of syncing single queues against the active queue,
+ * and for already idle queues to preserve their build-up lag.
+ *
+ * Of course, then we get the situation where there's 2 active and one
+ * going idle, who do we pick to sync against? Theory would have us sync
+ * against the combined S, but as we've already demonstrated, there is no
+ * such thing in infeasible weight scenarios.
+ *
+ * One thing I've considered; and this is where that core_active rudiment
+ * came from, is having active queues sync up between themselves after
+ * every tick. This limits the observed divergence due to the work
+ * conservancy.
+ *
+ * On top of that, we can improve upon things by moving away from our
+ * horrible (10) hack and moving to (9) and employing (13) here.
+ */
+
+/*
  * se_fi_update - Update the cfs_rq->min_vruntime_fi in a CFS hierarchy if n=
eeded.
  */
 static void se_fi_update(const struct sched_entity *se, unsigned int fi_seq,

