Return-Path: <linux-tip-commits+bounces-3197-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4427DA07581
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 13:18:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E505B188B189
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Jan 2025 12:18:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 889322165FB;
	Thu,  9 Jan 2025 12:18:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tj6R/hFF";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VOlpv+k3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 832F420551B;
	Thu,  9 Jan 2025 12:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736425090; cv=none; b=JhMsh04CF6rhEpnN+FIAdTvs6I89j3KaP+m7iLzMoZC6tlM82YIUAGDmWAOQqOXkxwTIXWWyaiAuM5Ytgfff3DnBDkN3F1BzLLtepEOX4NVsRy6DZX6QCLODBIg4ZP01/11uXJwHS+1cMmLFVTgM42gT1hxwJ25nSY1qCevU8AQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736425090; c=relaxed/simple;
	bh=6RbDoRyvR2eB+hDbpqUxpfkM9+EYalNBQDtcJBsFYpI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ab2z/aIXPnm3Bb9qU+k4Pln6MAfUolO9L8LQTQGnc1YQd7aKPC5v0Hc3gCXNqXGf6b7o1bw2wQLO6T2LO8xzmOJS7vcbAPX/muMJ/9grmEmpVVdGQtDLgM/1o5Z3itUMnwWnqhObBC4Cj+5tJHCSKdTRzclDrlL+m2oKV6jlfpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tj6R/hFF; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VOlpv+k3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 09 Jan 2025 12:18:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736425085;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vstGHaCuyQ9he5C1Ei65VYWzd0YjfspoV2trC2ESDHU=;
	b=tj6R/hFFi3Nv7C5P/1LyiwBfd7bFjUOdtDuvnf3xudHDrBW2Lh6T3BUvV/mMJCjiPZ+iYw
	QKyGjqr4h404SFcP4fEE+V8jUaCuIQMNjuV73PyZPeATJQoq/jzlhrhMfK7GMBak2pDr1t
	V1mDgxckV75ap76wTRETv6VQkWk2EKhDyLG6z9qPoEA4m+LoER+TeZkjj3fN4ubPaZgbp2
	T1M4Yypz9BHIEXxDx28QO/56I7ZuQpZUV6H5U25pFowCxzcueS5Ir1HeUHOycfjRnPNiS9
	y2h6rZKaufhkDML/yKmCMNReKxp+6YK883raAL4acdomEG35/+J86LT2Bnmrtg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736425085;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vstGHaCuyQ9he5C1Ei65VYWzd0YjfspoV2trC2ESDHU=;
	b=VOlpv+k3Fvv9+U0dIY6GC12RR5X05gcy8jyPtNOMZqa8L30S/ORoMxAp1543c2vD2WbCDo
	aGk2PU4jaSCySaBg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Fix EEVDF entity placement bug
 causing scheduling lag
Cc: Doug Smythies <dsmythies@telus.net>, Ingo Molnar <mingo@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250109105959.GA2981@noisy.programming.kicks-ass.net>
References: <20250109105959.GA2981@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173642508376.399.1685643315759195867.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     6d71a9c6160479899ee744d2c6d6602a191deb1f
Gitweb:        https://git.kernel.org/tip/6d71a9c6160479899ee744d2c6d6602a191deb1f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 09 Jan 2025 11:59:59 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 09 Jan 2025 12:55:27 +01:00

sched/fair: Fix EEVDF entity placement bug causing scheduling lag

I noticed this in my traces today:

       turbostat-1222    [006] d..2.   311.935649: reweight_entity: (ffff888108f13e00-ffff88885ef38440-6)
                               { weight: 1048576 avg_vruntime: 3184159639071 vruntime: 3184159640194 (-1123) deadline: 3184162621107 } ->
                               { weight: 2 avg_vruntime: 3184177463330 vruntime: 3184748414495 (-570951165) deadline: 4747605329439 }
       turbostat-1222    [006] d..2.   311.935651: reweight_entity: (ffff888108f13e00-ffff88885ef38440-6)
                               { weight: 2 avg_vruntime: 3184177463330 vruntime: 3184748414495 (-570951165) deadline: 4747605329439 } ->
                               { weight: 1048576 avg_vruntime: 3184176414812 vruntime: 3184177464419 (-1049607) deadline: 3184180445332 }

Which is a weight transition: 1048576 -> 2 -> 1048576.

One would expect the lag to shoot out *AND* come back, notably:

  -1123*1048576/2 = -588775424
  -588775424*2/1048576 = -1123

Except the trace shows it is all off. Worse, subsequent cycles shoot it
out further and further.

This made me have a very hard look at reweight_entity(), and
specifically the ->on_rq case, which is more prominent with
DELAY_DEQUEUE.

And indeed, it is all sorts of broken. While the computation of the new
lag is correct, the computation for the new vruntime, using the new lag
is broken for it does not consider the logic set out in place_entity().

With the below patch, I now see things like:

    migration/12-55      [012] d..3.   309.006650: reweight_entity: (ffff8881e0e6f600-ffff88885f235f40-12)
                               { weight: 977582 avg_vruntime: 4860513347366 vruntime: 4860513347908 (-542) deadline: 4860516552475 } ->
                               { weight: 2 avg_vruntime: 4860528915984 vruntime: 4860793840706 (-264924722) deadline: 6427157349203 }
    migration/14-62      [014] d..3.   309.006698: reweight_entity: (ffff8881e0e6cc00-ffff88885f3b5f40-15)
                               { weight: 2 avg_vruntime: 4874472992283 vruntime: 4939833828823 (-65360836540) deadline: 6316614641111 } ->
                               { weight: 967149 avg_vruntime: 4874217684324 vruntime: 4874217688559 (-4235) deadline: 4874220535650 }

Which isn't perfect yet, but much closer.

Reported-by: Doug Smythies <dsmythies@telus.net>
Reported-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Fixes: eab03c23c2a1 ("sched/eevdf: Fix vruntime adjustment on reweight")
Link: https://lore.kernel.org/r/20250109105959.GA2981@noisy.programming.kicks-ass.net
---
 kernel/sched/fair.c | 145 +++++--------------------------------------
 1 file changed, 18 insertions(+), 127 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3e9ca38..eeed8e3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -689,21 +689,16 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
  *
  * XXX could add max_slice to the augmented data to track this.
  */
-static s64 entity_lag(u64 avruntime, struct sched_entity *se)
+static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	s64 vlag, limit;
 
-	vlag = avruntime - se->vruntime;
-	limit = calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
-
-	return clamp(vlag, -limit, limit);
-}
-
-static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
-{
 	SCHED_WARN_ON(!se->on_rq);
 
-	se->vlag = entity_lag(avg_vruntime(cfs_rq), se);
+	vlag = avg_vruntime(cfs_rq) - se->vruntime;
+	limit = calc_delta_fair(max_t(u64, 2*se->slice, TICK_NSEC), se);
+
+	se->vlag = clamp(vlag, -limit, limit);
 }
 
 /*
@@ -3774,137 +3769,32 @@ static inline void
 dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se) { }
 #endif
 
-static void reweight_eevdf(struct sched_entity *se, u64 avruntime,
-			   unsigned long weight)
-{
-	unsigned long old_weight = se->load.weight;
-	s64 vlag, vslice;
-
-	/*
-	 * VRUNTIME
-	 * --------
-	 *
-	 * COROLLARY #1: The virtual runtime of the entity needs to be
-	 * adjusted if re-weight at !0-lag point.
-	 *
-	 * Proof: For contradiction assume this is not true, so we can
-	 * re-weight without changing vruntime at !0-lag point.
-	 *
-	 *             Weight	VRuntime   Avg-VRuntime
-	 *     before    w          v            V
-	 *      after    w'         v'           V'
-	 *
-	 * Since lag needs to be preserved through re-weight:
-	 *
-	 *	lag = (V - v)*w = (V'- v')*w', where v = v'
-	 *	==>	V' = (V - v)*w/w' + v		(1)
-	 *
-	 * Let W be the total weight of the entities before reweight,
-	 * since V' is the new weighted average of entities:
-	 *
-	 *	V' = (WV + w'v - wv) / (W + w' - w)	(2)
-	 *
-	 * by using (1) & (2) we obtain:
-	 *
-	 *	(WV + w'v - wv) / (W + w' - w) = (V - v)*w/w' + v
-	 *	==> (WV-Wv+Wv+w'v-wv)/(W+w'-w) = (V - v)*w/w' + v
-	 *	==> (WV - Wv)/(W + w' - w) + v = (V - v)*w/w' + v
-	 *	==>	(V - v)*W/(W + w' - w) = (V - v)*w/w' (3)
-	 *
-	 * Since we are doing at !0-lag point which means V != v, we
-	 * can simplify (3):
-	 *
-	 *	==>	W / (W + w' - w) = w / w'
-	 *	==>	Ww' = Ww + ww' - ww
-	 *	==>	W * (w' - w) = w * (w' - w)
-	 *	==>	W = w	(re-weight indicates w' != w)
-	 *
-	 * So the cfs_rq contains only one entity, hence vruntime of
-	 * the entity @v should always equal to the cfs_rq's weighted
-	 * average vruntime @V, which means we will always re-weight
-	 * at 0-lag point, thus breach assumption. Proof completed.
-	 *
-	 *
-	 * COROLLARY #2: Re-weight does NOT affect weighted average
-	 * vruntime of all the entities.
-	 *
-	 * Proof: According to corollary #1, Eq. (1) should be:
-	 *
-	 *	(V - v)*w = (V' - v')*w'
-	 *	==>    v' = V' - (V - v)*w/w'		(4)
-	 *
-	 * According to the weighted average formula, we have:
-	 *
-	 *	V' = (WV - wv + w'v') / (W - w + w')
-	 *	   = (WV - wv + w'(V' - (V - v)w/w')) / (W - w + w')
-	 *	   = (WV - wv + w'V' - Vw + wv) / (W - w + w')
-	 *	   = (WV + w'V' - Vw) / (W - w + w')
-	 *
-	 *	==>  V'*(W - w + w') = WV + w'V' - Vw
-	 *	==>	V' * (W - w) = (W - w) * V	(5)
-	 *
-	 * If the entity is the only one in the cfs_rq, then reweight
-	 * always occurs at 0-lag point, so V won't change. Or else
-	 * there are other entities, hence W != w, then Eq. (5) turns
-	 * into V' = V. So V won't change in either case, proof done.
-	 *
-	 *
-	 * So according to corollary #1 & #2, the effect of re-weight
-	 * on vruntime should be:
-	 *
-	 *	v' = V' - (V - v) * w / w'		(4)
-	 *	   = V  - (V - v) * w / w'
-	 *	   = V  - vl * w / w'
-	 *	   = V  - vl'
-	 */
-	if (avruntime != se->vruntime) {
-		vlag = entity_lag(avruntime, se);
-		vlag = div_s64(vlag * old_weight, weight);
-		se->vruntime = avruntime - vlag;
-	}
-
-	/*
-	 * DEADLINE
-	 * --------
-	 *
-	 * When the weight changes, the virtual time slope changes and
-	 * we should adjust the relative virtual deadline accordingly.
-	 *
-	 *	d' = v' + (d - v)*w/w'
-	 *	   = V' - (V - v)*w/w' + (d - v)*w/w'
-	 *	   = V  - (V - v)*w/w' + (d - v)*w/w'
-	 *	   = V  + (d - V)*w/w'
-	 */
-	vslice = (s64)(se->deadline - avruntime);
-	vslice = div_s64(vslice * old_weight, weight);
-	se->deadline = avruntime + vslice;
-}
+static void place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags);
 
 static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 			    unsigned long weight)
 {
 	bool curr = cfs_rq->curr == se;
-	u64 avruntime;
 
 	if (se->on_rq) {
 		/* commit outstanding execution time */
 		update_curr(cfs_rq);
-		avruntime = avg_vruntime(cfs_rq);
+		update_entity_lag(cfs_rq, se);
+		se->deadline -= se->vruntime;
+		se->rel_deadline = 1;
 		if (!curr)
 			__dequeue_entity(cfs_rq, se);
 		update_load_sub(&cfs_rq->load, se->load.weight);
 	}
 	dequeue_load_avg(cfs_rq, se);
 
-	if (se->on_rq) {
-		reweight_eevdf(se, avruntime, weight);
-	} else {
-		/*
-		 * Because we keep se->vlag = V - v_i, while: lag_i = w_i*(V - v_i),
-		 * we need to scale se->vlag when w_i changes.
-		 */
-		se->vlag = div_s64(se->vlag * se->load.weight, weight);
-	}
+	/*
+	 * Because we keep se->vlag = V - v_i, while: lag_i = w_i*(V - v_i),
+	 * we need to scale se->vlag when w_i changes.
+	 */
+	se->vlag = div_s64(se->vlag * se->load.weight, weight);
+	if (se->rel_deadline)
+		se->deadline = div_s64(se->deadline * se->load.weight, weight);
 
 	update_load_set(&se->load, weight);
 
@@ -3919,6 +3809,7 @@ static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 	enqueue_load_avg(cfs_rq, se);
 	if (se->on_rq) {
 		update_load_add(&cfs_rq->load, se->load.weight);
+		place_entity(cfs_rq, se, 0);
 		if (!curr)
 			__enqueue_entity(cfs_rq, se);
 
@@ -5359,7 +5250,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	se->vruntime = vruntime - lag;
 
-	if (sched_feat(PLACE_REL_DEADLINE) && se->rel_deadline) {
+	if (se->rel_deadline) {
 		se->deadline += se->vruntime;
 		se->rel_deadline = 0;
 		return;

