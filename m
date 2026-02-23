Return-Path: <linux-tip-commits+bounces-8228-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KLw7JuUsnGmcAQQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8228-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 11:33:09 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7961174F0F
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 11:33:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B366D30B65A6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Feb 2026 10:26:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BCFEF362139;
	Mon, 23 Feb 2026 10:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jJE08f+/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ai7F8mA2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34F46361DCA;
	Mon, 23 Feb 2026 10:25:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771842328; cv=none; b=W1dmfdjJz1w0imM35/M2NMF6EHToQZ9wN6nzhQqIRkxXJeBiHqIi2CyXtDeq8NYRvvMWiv8DQJZ2kVF7bwpWaATl4TP9mETezo/DuU7XFOAe8T97hw4t8nrnpIK8PplQWN+qJ8YsdGXLoeLQrYQhySJkJN0l/4GhsJcs85Wf3hI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771842328; c=relaxed/simple;
	bh=iA2stz/A/IOJb5b7BJwAFPjppNrND4F0DCCfzkkQqws=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Z57l0zlsh0HdvDMT9A+0ZcBYuY/uh6wjmdrwE7zaMquFT3z9wS9DPUOmpyQfE998Tt6f/iy/xbbK69y52W2ybWCmPrG3tw4LfaSTiitbXRtAeCbXpES4XQdoD667XC+0Dw4xT6jQDShw2Izjat9AbL9aJdl5iBOldnZQEPXCuus=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jJE08f+/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ai7F8mA2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 23 Feb 2026 10:25:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771842325;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=WNoAPzvRadgJM9zzs18E3d8CMDR9c4OTCS0N+RhU67w=;
	b=jJE08f+/ODeNpe4/fsDLmK6fWjGphIbv3OuVOX3eaIfl0qpPmkuc4u2eOkWb7uXydy2gGC
	KJVp7byWMbAZOP2idTNVEAT7XMpUvL9qD2dl35iWx6CX/pf2Uldye4Q8+yDinIqMO52lXD
	8qKxK258oUkKmJ3rHBWngZrLZqF8gjNb6wDrtb8M+6KKgl7ZV6z+3rnQsYMiZdPfwNrucY
	u9VETOD2D0cldLOptgkUaiPjwMCC4dI3mZqT15YpXrRUESMNNa2RJbMomZycPUahbOWv3S
	8BzhXTuDi8T3262aIsR6Fia2g5NHqptgj31oVkAOc1iBRGTtGpRHLrb2wWiLsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771842325;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=WNoAPzvRadgJM9zzs18E3d8CMDR9c4OTCS0N+RhU67w=;
	b=Ai7F8mA2KaIo1d3NZwKId8yJwGjlpiMwQ9lBnnYfGHLs+P/69RgIgb9/Dcb/HsqMXJa14Y
	9SoBj3b7OZk6l4Bg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Fix zero_vruntime tracking
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Shubhang Kaushik <shubhang@os.amperecomputing.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177184232472.1647592.11362297419769330533.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8228-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[infradead.org:email,amd.com:email,linutronix.de:dkim,amperecomputing.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,msgid.link:url,vger.kernel.org:replyto];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-0.999];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: C7961174F0F
X-Rspamd-Action: no action

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     b3d99f43c72b56cf7a104a364e7fb34b0702828b
Gitweb:        https://git.kernel.org/tip/b3d99f43c72b56cf7a104a364e7fb34b070=
2828b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 09 Feb 2026 15:28:16 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 23 Feb 2026 11:19:17 +01:00

sched/fair: Fix zero_vruntime tracking

It turns out that zero_vruntime tracking is broken when there is but a single
task running. Current update paths are through __{en,de}queue_entity(), and
when there is but a single task, pick_next_task() will always return that one
task, and put_prev_set_next_task() will end up in neither function.

This can cause entity_key() to grow indefinitely large and cause overflows,
leading to much pain and suffering.

Furtermore, doing update_zero_vruntime() from __{de,en}queue_entity(), which
are called from {set_next,put_prev}_entity() has problems because:

 - set_next_entity() calls __dequeue_entity() before it does cfs_rq->curr =3D=
 se.
   This means the avg_vruntime() will see the removal but not current, missing
   the entity for accounting.

 - put_prev_entity() calls __enqueue_entity() before it does cfs_rq->curr =3D
   NULL. This means the avg_vruntime() will see the addition *and* current,
   leading to double accounting.

Both cases are incorrect/inconsistent.

Noting that avg_vruntime is already called on each {en,de}queue, remove the
explicit avg_vruntime() calls (which removes an extra 64bit division for each
{en,de}queue) and have avg_vruntime() update zero_vruntime itself.

Additionally, have the tick call avg_vruntime() -- discarding the result, but
for the side-effect of updating zero_vruntime.

While there, optimize avg_vruntime() by noting that the average of one value =
is
rather trivial to compute.

Test case:
  # taskset -c -p 1 $$
  # taskset -c 2 bash -c 'while :; do :; done&'
  # cat /sys/kernel/debug/sched/debug | awk '/^cpu#/ {P=3D0} /^cpu#2,/ {P=3D1=
} {if (P) print $0}' | grep -e zero_vruntime -e "^>"

PRE:
    .zero_vruntime                 : 31316.407903
  >R            bash   487     50787.345112   E       50789.145972           =
2.800000     50780.298364        16     120         0.000000         0.000000=
         0.000000        /
    .zero_vruntime                 : 382548.253179
  >R            bash   487    427275.204288   E      427276.003584           =
2.800000    427268.157540        23     120         0.000000         0.000000=
         0.000000        /

POST:
    .zero_vruntime                 : 17259.709467
  >R            bash   526     17259.709467   E       17262.509467           =
2.800000     16915.031624         9     120         0.000000         0.000000=
         0.000000        /
    .zero_vruntime                 : 18702.723356
  >R            bash   526     18702.723356   E       18705.523356           =
2.800000     18358.045513         9     120         0.000000         0.000000=
         0.000000        /

Fixes: 79f3f9bedd14 ("sched/eevdf: Fix min_vruntime vs avg_vruntime")
Reported-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Shubhang Kaushik <shubhang@os.amperecomputing.com>
Link: https://patch.msgid.link/20260219080624.438854780%40infradead.org
---
 kernel/sched/fair.c | 84 +++++++++++++++++++++++++++++---------------
 1 file changed, 57 insertions(+), 27 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index eea99ec..56dddd4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -589,6 +589,21 @@ static inline bool entity_before(const struct sched_enti=
ty *a,
 	return vruntime_cmp(a->deadline, "<", b->deadline);
 }
=20
+/*
+ * Per avg_vruntime() below, cfs_rq::zero_vruntime is only slightly stale
+ * and this value should be no more than two lag bounds. Which puts it in the
+ * general order of:
+ *
+ *	(slice + TICK_NSEC) << NICE_0_LOAD_SHIFT
+ *
+ * which is around 44 bits in size (on 64bit); that is 20 for
+ * NICE_0_LOAD_SHIFT, another 20 for NSEC_PER_MSEC and then a handful for
+ * however many msec the actual slice+tick ends up begin.
+ *
+ * (disregarding the actual divide-by-weight part makes for the worst case
+ * weight of 2, which nicely cancels vs the fuzz in zero_vruntime not actual=
ly
+ * being the zero-lag point).
+ */
 static inline s64 entity_key(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	return vruntime_op(se->vruntime, "-", cfs_rq->zero_vruntime);
@@ -676,39 +691,61 @@ sum_w_vruntime_sub(struct cfs_rq *cfs_rq, struct sched_=
entity *se)
 }
=20
 static inline
-void sum_w_vruntime_update(struct cfs_rq *cfs_rq, s64 delta)
+void update_zero_vruntime(struct cfs_rq *cfs_rq, s64 delta)
 {
 	/*
-	 * v' =3D v + d =3D=3D> sum_w_vruntime' =3D sum_runtime - d*sum_weight
+	 * v' =3D v + d =3D=3D> sum_w_vruntime' =3D sum_w_vruntime - d*sum_weight
 	 */
 	cfs_rq->sum_w_vruntime -=3D cfs_rq->sum_weight * delta;
+	cfs_rq->zero_vruntime +=3D delta;
 }
=20
 /*
- * Specifically: avg_runtime() + 0 must result in entity_eligible() :=3D true
+ * Specifically: avg_vruntime() + 0 must result in entity_eligible() :=3D tr=
ue
  * For this to be so, the result of this function must have a left bias.
+ *
+ * Called in:
+ *  - place_entity()      -- before enqueue
+ *  - update_entity_lag() -- before dequeue
+ *  - entity_tick()
+ *
+ * This means it is one entry 'behind' but that puts it close enough to where
+ * the bound on entity_key() is at most two lag bounds.
  */
 u64 avg_vruntime(struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *curr =3D cfs_rq->curr;
-	s64 avg =3D cfs_rq->sum_w_vruntime;
-	long load =3D cfs_rq->sum_weight;
+	long weight =3D cfs_rq->sum_weight;
+	s64 delta =3D 0;
=20
-	if (curr && curr->on_rq) {
-		unsigned long weight =3D scale_load_down(curr->load.weight);
+	if (curr && !curr->on_rq)
+		curr =3D NULL;
=20
-		avg +=3D entity_key(cfs_rq, curr) * weight;
-		load +=3D weight;
-	}
+	if (weight) {
+		s64 runtime =3D cfs_rq->sum_w_vruntime;
+
+		if (curr) {
+			unsigned long w =3D scale_load_down(curr->load.weight);
+
+			runtime +=3D entity_key(cfs_rq, curr) * w;
+			weight +=3D w;
+		}
=20
-	if (load) {
 		/* sign flips effective floor / ceiling */
-		if (avg < 0)
-			avg -=3D (load - 1);
-		avg =3D div_s64(avg, load);
+		if (runtime < 0)
+			runtime -=3D (weight - 1);
+
+		delta =3D div_s64(runtime, weight);
+	} else if (curr) {
+		/*
+		 * When there is but one element, it is the average.
+		 */
+		delta =3D curr->vruntime - cfs_rq->zero_vruntime;
 	}
=20
-	return cfs_rq->zero_vruntime + avg;
+	update_zero_vruntime(cfs_rq, delta);
+
+	return cfs_rq->zero_vruntime;
 }
=20
 /*
@@ -777,16 +814,6 @@ int entity_eligible(struct cfs_rq *cfs_rq, struct sched_=
entity *se)
 	return vruntime_eligible(cfs_rq, se->vruntime);
 }
=20
-static void update_zero_vruntime(struct cfs_rq *cfs_rq)
-{
-	u64 vruntime =3D avg_vruntime(cfs_rq);
-	s64 delta =3D vruntime_op(vruntime, "-", cfs_rq->zero_vruntime);
-
-	sum_w_vruntime_update(cfs_rq, delta);
-
-	cfs_rq->zero_vruntime =3D vruntime;
-}
-
 static inline u64 cfs_rq_min_slice(struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *root =3D __pick_root_entity(cfs_rq);
@@ -856,7 +883,6 @@ RB_DECLARE_CALLBACKS(static, min_vruntime_cb, struct sche=
d_entity,
 static void __enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	sum_w_vruntime_add(cfs_rq, se);
-	update_zero_vruntime(cfs_rq);
 	se->min_vruntime =3D se->vruntime;
 	se->min_slice =3D se->slice;
 	rb_add_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
@@ -868,7 +894,6 @@ static void __dequeue_entity(struct cfs_rq *cfs_rq, struc=
t sched_entity *se)
 	rb_erase_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
 				  &min_vruntime_cb);
 	sum_w_vruntime_sub(cfs_rq, se);
-	update_zero_vruntime(cfs_rq);
 }
=20
 struct sched_entity *__pick_root_entity(struct cfs_rq *cfs_rq)
@@ -5524,6 +5549,11 @@ entity_tick(struct cfs_rq *cfs_rq, struct sched_entity=
 *curr, int queued)
 	update_load_avg(cfs_rq, curr, UPDATE_TG);
 	update_cfs_group(curr);
=20
+	/*
+	 * Pulls along cfs_rq::zero_vruntime.
+	 */
+	avg_vruntime(cfs_rq);
+
 #ifdef CONFIG_SCHED_HRTICK
 	/*
 	 * queued ticks are scheduled to match the slice, so don't bother

