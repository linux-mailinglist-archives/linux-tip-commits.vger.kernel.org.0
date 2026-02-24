Return-Path: <linux-tip-commits+bounces-8250-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MAPXCe5rnWnhPwQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8250-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 10:14:22 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A06FA184617
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 10:14:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CCE6630B8E31
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 09:13:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EFAAC36C594;
	Tue, 24 Feb 2026 09:13:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DgJUFX02";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lL/VDCA2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16BD736B071;
	Tue, 24 Feb 2026 09:13:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924406; cv=none; b=GkDL6Na1u8WR8gfMf/fBWe5ov1ku3Jer3djr9xAogHqa77GIlWxxMzZBmpopilC6GqLdjoEeI3twXFv2yVk8QgP0kpSp/GvUOC2XJzRrc3w1ZyM1wwsX0V6YXIaTiEOiP2OKFjUDmEJX6bhFwvL9lKfZOPyf5UkjiS5WxNQLENo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924406; c=relaxed/simple;
	bh=jbPLJ683TI5VF3yhw+mhtmir9vGRzIBpfcLvOiw4Umk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Vdq6WsjSRjsF7A7r+249RFNwSGlBts1/2RE2OhJRMbNgY6BISSVyt0zWurN1U5/M8QN0eeOXIdxVUtvxAvsvvEAzzFc547DT5ReUWZeh6AwiuucEOcPz3Az/hbwheAurY0AAvatfDNxyt7GYw2T1A3v9NMICLdrQZlBYAELPlC8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DgJUFX02; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lL/VDCA2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Feb 2026 09:13:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771924402;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=y9aK/WS5gD8xYGDOrUfWOB9XQRCpwvx3Ohafgm+2Dz4=;
	b=DgJUFX02sAx85OIrrIneC1yf61hGAsOMVSYL+/EWoHZi2uzEumaMuHlvHOuqZlD44mSINk
	AogQPYx+BWY1r64rHaaYIIlMycewfbg36EfSznqgQz1NileUYpscN1ddNlK3ybrLS9mw/9
	3gvirxHobc95rsLgOikBphua0F4NQozRIO1RhFwQ2CRhVHtuhbNDYY/L0iLvIwQwgqr4m8
	YyrKh6EoyT996l95ZmtXfQ+3rjsvlMxrcomwU5ZKtjL2RGq/G8CiJmSzs6iC7BAQ7zAU6E
	iXBFY+ldFuSZEHidPO3ahhh3X48lKkuJ0CPm10zyBda0pmvJ+vXVNkkhFkhTwQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771924402;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=y9aK/WS5gD8xYGDOrUfWOB9XQRCpwvx3Ohafgm+2Dz4=;
	b=lL/VDCA2Al2x3t5o/nmZBn4VVQWQ7joOignKeihPHUupnBowgxH4lUGc+Sq05ZCuR3pEfj
	Xdv7TUgL8qCF/MDw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Revert 6d71a9c61604 ("sched/fair: Fix
 EEVDF entity placement bug causing scheduling lag")
Cc: Zicheng Qu <quzicheng@huawei.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Shubhang Kaushik <shubhang@os.amperecomputing.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177192440090.1647592.15432826458514132211.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8250-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-0.999];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[amd.com:email,huawei.com:email,linutronix.de:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,vger.kernel.org:replyto,infradead.org:email,msgid.link:url,linaro.org:email]
X-Rspamd-Queue-Id: A06FA184617
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     101f3498b4bdfef97152a444847948de1543f692
Gitweb:        https://git.kernel.org/tip/101f3498b4bdfef97152a444847948de154=
3f692
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 26 Jan 2026 20:56:23 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 23 Feb 2026 18:04:10 +01:00

sched/fair: Revert 6d71a9c61604 ("sched/fair: Fix EEVDF entity placement bug =
causing scheduling lag")

Zicheng Qu reported that, because avg_vruntime() always includes
cfs_rq->curr, when ->on_rq, place_entity() doesn't work right.

Specifically, the lag scaling in place_entity() relies on
avg_vruntime() being the state *before* placement of the new entity.
However in this case avg_vruntime() will actually already include the
entity, which breaks things.

Also, Zicheng Qu argues that avg_vruntime should be invariant under
reweight. IOW commit 6d71a9c61604 ("sched/fair: Fix EEVDF entity
placement bug causing scheduling lag") was wrong!

The issue reported in 6d71a9c61604 could possibly be explained by
rounding artifacts -- notably the extreme weight '2' is outside of the
range of avg_vruntime/sum_w_vruntime, since that uses
scale_load_down(). By scaling vruntime by the real weight, but
accounting it in vruntime with a factor 1024 more, the average moves
significantly. However, that is now cured.

Tested by reverting 66951e4860d3 ("sched/fair: Fix update_cfs_group()
vs DELAY_DEQUEUE") and tracing vruntime and vlag figures again.

Reported-by: Zicheng Qu <quzicheng@huawei.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Shubhang Kaushik <shubhang@os.amperecomputing.com>
Link: https://patch.msgid.link/20260219080625.066102672%40infradead.org
---
 kernel/sched/fair.c | 148 ++++++++++++++++++++++++++++++++++++-------
 1 file changed, 124 insertions(+), 24 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fdb98d2..2b98054 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -822,17 +822,22 @@ static inline u64 cfs_rq_max_slice(struct cfs_rq *cfs_r=
q);
  *
  *   -r_max < lag < max(r_max, q)
  */
-static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
+static s64 entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se, u64 av=
runtime)
 {
 	u64 max_slice =3D cfs_rq_max_slice(cfs_rq) + TICK_NSEC;
 	s64 vlag, limit;
=20
-	WARN_ON_ONCE(!se->on_rq);
-
-	vlag =3D avg_vruntime(cfs_rq) - se->vruntime;
+	vlag =3D avruntime - se->vruntime;
 	limit =3D calc_delta_fair(max_slice, se);
=20
-	se->vlag =3D clamp(vlag, -limit, limit);
+	return clamp(vlag, -limit, limit);
+}
+
+static void update_entity_lag(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	WARN_ON_ONCE(!se->on_rq);
+
+	se->vlag =3D entity_lag(cfs_rq, se, avg_vruntime(cfs_rq));
 }
=20
 /*
@@ -3898,23 +3903,125 @@ dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched=
_entity *se)
 		    se_weight(se) * -se->avg.load_sum);
 }
=20
-static void place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int=
 flags);
+static void
+rescale_entity(struct sched_entity *se, unsigned long weight, bool rel_vprot)
+{
+	unsigned long old_weight =3D se->load.weight;
+
+	/*
+	 * VRUNTIME
+	 * --------
+	 *
+	 * COROLLARY #1: The virtual runtime of the entity needs to be
+	 * adjusted if re-weight at !0-lag point.
+	 *
+	 * Proof: For contradiction assume this is not true, so we can
+	 * re-weight without changing vruntime at !0-lag point.
+	 *
+	 *             Weight	VRuntime   Avg-VRuntime
+	 *     before    w          v            V
+	 *      after    w'         v'           V'
+	 *
+	 * Since lag needs to be preserved through re-weight:
+	 *
+	 *	lag =3D (V - v)*w =3D (V'- v')*w', where v =3D v'
+	 *	=3D=3D>	V' =3D (V - v)*w/w' + v		(1)
+	 *
+	 * Let W be the total weight of the entities before reweight,
+	 * since V' is the new weighted average of entities:
+	 *
+	 *	V' =3D (WV + w'v - wv) / (W + w' - w)	(2)
+	 *
+	 * by using (1) & (2) we obtain:
+	 *
+	 *	(WV + w'v - wv) / (W + w' - w) =3D (V - v)*w/w' + v
+	 *	=3D=3D> (WV-Wv+Wv+w'v-wv)/(W+w'-w) =3D (V - v)*w/w' + v
+	 *	=3D=3D> (WV - Wv)/(W + w' - w) + v =3D (V - v)*w/w' + v
+	 *	=3D=3D>	(V - v)*W/(W + w' - w) =3D (V - v)*w/w' (3)
+	 *
+	 * Since we are doing at !0-lag point which means V !=3D v, we
+	 * can simplify (3):
+	 *
+	 *	=3D=3D>	W / (W + w' - w) =3D w / w'
+	 *	=3D=3D>	Ww' =3D Ww + ww' - ww
+	 *	=3D=3D>	W * (w' - w) =3D w * (w' - w)
+	 *	=3D=3D>	W =3D w	(re-weight indicates w' !=3D w)
+	 *
+	 * So the cfs_rq contains only one entity, hence vruntime of
+	 * the entity @v should always equal to the cfs_rq's weighted
+	 * average vruntime @V, which means we will always re-weight
+	 * at 0-lag point, thus breach assumption. Proof completed.
+	 *
+	 *
+	 * COROLLARY #2: Re-weight does NOT affect weighted average
+	 * vruntime of all the entities.
+	 *
+	 * Proof: According to corollary #1, Eq. (1) should be:
+	 *
+	 *	(V - v)*w =3D (V' - v')*w'
+	 *	=3D=3D>    v' =3D V' - (V - v)*w/w'		(4)
+	 *
+	 * According to the weighted average formula, we have:
+	 *
+	 *	V' =3D (WV - wv + w'v') / (W - w + w')
+	 *	   =3D (WV - wv + w'(V' - (V - v)w/w')) / (W - w + w')
+	 *	   =3D (WV - wv + w'V' - Vw + wv) / (W - w + w')
+	 *	   =3D (WV + w'V' - Vw) / (W - w + w')
+	 *
+	 *	=3D=3D>  V'*(W - w + w') =3D WV + w'V' - Vw
+	 *	=3D=3D>	V' * (W - w) =3D (W - w) * V	(5)
+	 *
+	 * If the entity is the only one in the cfs_rq, then reweight
+	 * always occurs at 0-lag point, so V won't change. Or else
+	 * there are other entities, hence W !=3D w, then Eq. (5) turns
+	 * into V' =3D V. So V won't change in either case, proof done.
+	 *
+	 *
+	 * So according to corollary #1 & #2, the effect of re-weight
+	 * on vruntime should be:
+	 *
+	 *	v' =3D V' - (V - v) * w / w'		(4)
+	 *	   =3D V  - (V - v) * w / w'
+	 *	   =3D V  - vl * w / w'
+	 *	   =3D V  - vl'
+	 */
+	se->vlag =3D div64_long(se->vlag * old_weight, weight);
+
+	/*
+	 * DEADLINE
+	 * --------
+	 *
+	 * When the weight changes, the virtual time slope changes and
+	 * we should adjust the relative virtual deadline accordingly.
+	 *
+	 *	d' =3D v' + (d - v)*w/w'
+	 *	   =3D V' - (V - v)*w/w' + (d - v)*w/w'
+	 *	   =3D V  - (V - v)*w/w' + (d - v)*w/w'
+	 *	   =3D V  + (d - V)*w/w'
+	 */
+	if (se->rel_deadline)
+		se->deadline =3D div64_long(se->deadline * old_weight, weight);
+
+	if (rel_vprot)
+		se->vprot =3D div64_long(se->vprot * old_weight, weight);
+}
=20
 static void reweight_entity(struct cfs_rq *cfs_rq, struct sched_entity *se,
 			    unsigned long weight)
 {
 	bool curr =3D cfs_rq->curr =3D=3D se;
 	bool rel_vprot =3D false;
-	u64 vprot;
+	u64 avruntime =3D 0;
=20
 	if (se->on_rq) {
 		/* commit outstanding execution time */
 		update_curr(cfs_rq);
-		update_entity_lag(cfs_rq, se);
-		se->deadline -=3D se->vruntime;
+		avruntime =3D avg_vruntime(cfs_rq);
+		se->vlag =3D entity_lag(cfs_rq, se, avruntime);
+		se->deadline -=3D avruntime;
 		se->rel_deadline =3D 1;
 		if (curr && protect_slice(se)) {
-			vprot =3D se->vprot - se->vruntime;
+			se->vprot -=3D avruntime;
 			rel_vprot =3D true;
 		}
=20
@@ -3925,30 +4032,23 @@ static void reweight_entity(struct cfs_rq *cfs_rq, st=
ruct sched_entity *se,
 	}
 	dequeue_load_avg(cfs_rq, se);
=20
-	/*
-	 * Because we keep se->vlag =3D V - v_i, while: lag_i =3D w_i*(V - v_i),
-	 * we need to scale se->vlag when w_i changes.
-	 */
-	se->vlag =3D div64_long(se->vlag * se->load.weight, weight);
-	if (se->rel_deadline)
-		se->deadline =3D div64_long(se->deadline * se->load.weight, weight);
-
-	if (rel_vprot)
-		vprot =3D div64_long(vprot * se->load.weight, weight);
+	rescale_entity(se, weight, rel_vprot);
=20
 	update_load_set(&se->load, weight);
=20
 	do {
 		u32 divider =3D get_pelt_divider(&se->avg);
-
 		se->avg.load_avg =3D div_u64(se_weight(se) * se->avg.load_sum, divider);
 	} while (0);
=20
 	enqueue_load_avg(cfs_rq, se);
 	if (se->on_rq) {
-		place_entity(cfs_rq, se, 0);
 		if (rel_vprot)
-			se->vprot =3D se->vruntime + vprot;
+			se->vprot +=3D avruntime;
+		se->deadline +=3D avruntime;
+		se->rel_deadline =3D 0;
+		se->vruntime =3D avruntime - se->vlag;
+
 		update_load_add(&cfs_rq->load, se->load.weight);
 		if (!curr)
 			__enqueue_entity(cfs_rq, se);
@@ -5306,7 +5406,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity=
 *se, int flags)
=20
 	se->vruntime =3D vruntime - lag;
=20
-	if (se->rel_deadline) {
+	if (sched_feat(PLACE_REL_DEADLINE) && se->rel_deadline) {
 		se->deadline +=3D se->vruntime;
 		se->rel_deadline =3D 0;
 		return;

