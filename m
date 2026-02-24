Return-Path: <linux-tip-commits+bounces-8251-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 4B/mI/1snWkkQAQAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8251-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 10:18:53 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CBC5E1846FF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 10:18:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B404331AF019
	for <lists+linux-tip-commits@lfdr.de>; Tue, 24 Feb 2026 09:13:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E93436C5A6;
	Tue, 24 Feb 2026 09:13:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eo6IUdqE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ULFdemjP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50B0936AB55;
	Tue, 24 Feb 2026 09:13:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771924407; cv=none; b=Yl+jSGaAbhfxQCH/faoMFVE+2kPgEQr3GfQBSWl57PZBI4vXSdlEnMarZjLSib5o8pb/utOrpPCRCu8mDszBVEqgApbgVReMEsE90dYFVCCHqE1TJltOjBXTeisFNkLuRQZE8TLJf7e3NNhA+Z99kfLfkyeED5ogXVgQVEX4G58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771924407; c=relaxed/simple;
	bh=ydrixhVT2h5v98ZGY+Me17CuIHU5yLUuuC2AZxRtC2Y=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=AnZAQm6Q6NNu+nUS7shIdtJhUgFZCQNqwZnUtS/PFVWESiWXuvbaNBmnhFxdSiAmwHT9z+vTsIAvYw/Ws1Kk3JDpJ7mV2bmhS6YO5NSx9vvUd21VI6V9y9Y5KDngDm8447biI5l2mvhK/c3a5EwqUFiM6dxIsRiPsutUkQyY20Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eo6IUdqE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ULFdemjP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 24 Feb 2026 09:13:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1771924403;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=/WIXFdWHtaXVyIA+WR1czzF81uKj2SiMhMuzF6pFdnM=;
	b=eo6IUdqEheg5BHX1khGAcn1HpgFZBCpeCoGDDn5ljvciTaQsATJ4V55E75aiILILVlMjfo
	LF2upagCoJZxEifuWVlJ8KxyyznACfqsAzQclPE3TkDs5dBlhzUVb+/2nYXQTgc58o5WqK
	z6GrMJSsCl9Y0OpCseJMN+FN0eCRt2ggj2muTDTEc5lCJYzcgWe6qpfG6lw1Zvk8djgOvc
	pi3SW6xOMugm4RlGg8imCe39GfwK1jMUQJEnJFrDZF1VukHVQ+xVR26HjV2Eov/HLTeYUE
	ito3BaMhZOFJGF9Bb+oPWZaVjLkss2N61DMpTJuXh3HculdafL4vzV4Ofbpx5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1771924403;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=/WIXFdWHtaXVyIA+WR1czzF81uKj2SiMhMuzF6pFdnM=;
	b=ULFdemjPEFj9NvYsU3Xgb3pWT5rOxwL3+Pr07TdwStsTD8F/nrCuymJ+sUIlqyss66aGxm
	j26NDX4gJYN288DQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Increase weight bits for avg_vruntime
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Shubhang Kaushik <shubhang@os.amperecomputing.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177192440208.1647592.1294571197544047329.tip-bot2@tip-bot2>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8251-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,infradead.org:email,vger.kernel.org:replyto,msgid.link:url,amd.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,amperecomputing.com:email];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: CBC5E1846FF
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4823725d9d1d9cc5b36647e0cb8ff616cad6536f
Gitweb:        https://git.kernel.org/tip/4823725d9d1d9cc5b36647e0cb8ff616cad=
6536f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 26 Sep 2025 21:43:56 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 23 Feb 2026 18:04:10 +01:00

sched/fair: Increase weight bits for avg_vruntime

Due to the zero_vruntime patch, the deltas are now a lot smaller and
measurement with kernel-build and hackbench runs show about 45 bits
used.

This ensures avg_vruntime() tracks the full weight range, reducing
numerical artifacts in reweight and the like.

Also, lets keep the paranoid debug code around fow now.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Shubhang Kaushik <shubhang@os.amperecomputing.com>
Link: https://patch.msgid.link/20260219080624.942813440%40infradead.org
---
 kernel/sched/debug.c    | 14 +++++-
 kernel/sched/fair.c     | 96 ++++++++++++++++++++++++++++++++--------
 kernel/sched/features.h |  2 +-
 kernel/sched/sched.h    |  3 +-
 4 files changed, 94 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index b24f40f..6246008 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -8,6 +8,7 @@
  */
 #include <linux/debugfs.h>
 #include <linux/nmi.h>
+#include <linux/log2.h>
 #include "sched.h"
=20
 /*
@@ -901,10 +902,13 @@ static void print_rq(struct seq_file *m, struct rq *rq,=
 int rq_cpu)
=20
 void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 {
-	s64 left_vruntime =3D -1, zero_vruntime, right_vruntime =3D -1, left_deadli=
ne =3D -1, spread;
+	s64 left_vruntime =3D -1, right_vruntime =3D -1, left_deadline =3D -1, spre=
ad;
+	s64 zero_vruntime =3D -1, sum_w_vruntime =3D -1;
 	struct sched_entity *last, *first, *root;
 	struct rq *rq =3D cpu_rq(cpu);
+	unsigned int sum_shift;
 	unsigned long flags;
+	u64 sum_weight;
=20
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	SEQ_printf(m, "\n");
@@ -925,6 +929,9 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs=
_rq *cfs_rq)
 	if (last)
 		right_vruntime =3D last->vruntime;
 	zero_vruntime =3D cfs_rq->zero_vruntime;
+	sum_w_vruntime =3D cfs_rq->sum_w_vruntime;
+	sum_weight =3D cfs_rq->sum_weight;
+	sum_shift =3D cfs_rq->sum_shift;
 	raw_spin_rq_unlock_irqrestore(rq, flags);
=20
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "left_deadline",
@@ -933,6 +940,11 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cf=
s_rq *cfs_rq)
 			SPLIT_NS(left_vruntime));
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "zero_vruntime",
 			SPLIT_NS(zero_vruntime));
+	SEQ_printf(m, "  .%-30s: %Ld (%d bits)\n", "sum_w_vruntime",
+		   sum_w_vruntime, ilog2(abs(sum_w_vruntime)));
+	SEQ_printf(m, "  .%-30s: %Lu\n", "sum_weight",
+		   sum_weight);
+	SEQ_printf(m, "  .%-30s: %u\n", "sum_shift", sum_shift);
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "avg_vruntime",
 			SPLIT_NS(avg_vruntime(cfs_rq)));
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "right_vruntime",
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 66afa0a..fdb98d2 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -665,25 +665,83 @@ static inline s64 entity_key(struct cfs_rq *cfs_rq, str=
uct sched_entity *se)
  * Since zero_vruntime closely tracks the per-task service, these
  * deltas: (v_i - v0), will be in the order of the maximal (virtual) lag
  * induced in the system due to quantisation.
- *
- * Also, we use scale_load_down() to reduce the size.
- *
- * As measured, the max (key * weight) value was ~44 bits for a kernel build.
  */
+static inline unsigned long avg_vruntime_weight(struct cfs_rq *cfs_rq, unsig=
ned long w)
+{
+#ifdef CONFIG_64BIT
+	if (cfs_rq->sum_shift)
+		w =3D max(2UL, w >> cfs_rq->sum_shift);
+#endif
+	return w;
+}
+
+static inline void
+__sum_w_vruntime_add(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	unsigned long weight =3D avg_vruntime_weight(cfs_rq, se->load.weight);
+	s64 w_vruntime, key =3D entity_key(cfs_rq, se);
+
+	w_vruntime =3D key * weight;
+	WARN_ON_ONCE((w_vruntime >> 63) !=3D (w_vruntime >> 62));
+
+	cfs_rq->sum_w_vruntime +=3D w_vruntime;
+	cfs_rq->sum_weight +=3D weight;
+}
+
 static void
-sum_w_vruntime_add(struct cfs_rq *cfs_rq, struct sched_entity *se)
+sum_w_vruntime_add_paranoid(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	unsigned long weight =3D scale_load_down(se->load.weight);
-	s64 key =3D entity_key(cfs_rq, se);
+	unsigned long weight;
+	s64 key, tmp;
+
+again:
+	weight =3D avg_vruntime_weight(cfs_rq, se->load.weight);
+	key =3D entity_key(cfs_rq, se);
=20
-	cfs_rq->sum_w_vruntime +=3D key * weight;
+	if (check_mul_overflow(key, weight, &key))
+		goto overflow;
+
+	if (check_add_overflow(cfs_rq->sum_w_vruntime, key, &tmp))
+		goto overflow;
+
+	cfs_rq->sum_w_vruntime =3D tmp;
 	cfs_rq->sum_weight +=3D weight;
+	return;
+
+overflow:
+	/*
+	 * There's gotta be a limit -- if we're still failing at this point
+	 * there's really nothing much to be done about things.
+	 */
+	BUG_ON(cfs_rq->sum_shift >=3D 10);
+	cfs_rq->sum_shift++;
+
+	/*
+	 * Note: \Sum (k_i * (w_i >> 1)) !=3D (\Sum (k_i * w_i)) >> 1
+	 */
+	cfs_rq->sum_w_vruntime =3D 0;
+	cfs_rq->sum_weight =3D 0;
+
+	for (struct rb_node *node =3D cfs_rq->tasks_timeline.rb_leftmost;
+	     node; node =3D rb_next(node))
+		__sum_w_vruntime_add(cfs_rq, __node_2_se(node));
+
+	goto again;
+}
+
+static void
+sum_w_vruntime_add(struct cfs_rq *cfs_rq, struct sched_entity *se)
+{
+	if (sched_feat(PARANOID_AVG))
+		return sum_w_vruntime_add_paranoid(cfs_rq, se);
+
+	__sum_w_vruntime_add(cfs_rq, se);
 }
=20
 static void
 sum_w_vruntime_sub(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	unsigned long weight =3D scale_load_down(se->load.weight);
+	unsigned long weight =3D avg_vruntime_weight(cfs_rq, se->load.weight);
 	s64 key =3D entity_key(cfs_rq, se);
=20
 	cfs_rq->sum_w_vruntime -=3D key * weight;
@@ -725,7 +783,7 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
 		s64 runtime =3D cfs_rq->sum_w_vruntime;
=20
 		if (curr) {
-			unsigned long w =3D scale_load_down(curr->load.weight);
+			unsigned long w =3D avg_vruntime_weight(cfs_rq, curr->load.weight);
=20
 			runtime +=3D entity_key(cfs_rq, curr) * w;
 			weight +=3D w;
@@ -735,7 +793,7 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
 		if (runtime < 0)
 			runtime -=3D (weight - 1);
=20
-		delta =3D div_s64(runtime, weight);
+		delta =3D div64_long(runtime, weight);
 	} else if (curr) {
 		/*
 		 * When there is but one element, it is the average.
@@ -801,7 +859,7 @@ static int vruntime_eligible(struct cfs_rq *cfs_rq, u64 v=
runtime)
 	long load =3D cfs_rq->sum_weight;
=20
 	if (curr && curr->on_rq) {
-		unsigned long weight =3D scale_load_down(curr->load.weight);
+		unsigned long weight =3D avg_vruntime_weight(cfs_rq, curr->load.weight);
=20
 		avg +=3D entity_key(cfs_rq, curr) * weight;
 		load +=3D weight;
@@ -3871,12 +3929,12 @@ static void reweight_entity(struct cfs_rq *cfs_rq, st=
ruct sched_entity *se,
 	 * Because we keep se->vlag =3D V - v_i, while: lag_i =3D w_i*(V - v_i),
 	 * we need to scale se->vlag when w_i changes.
 	 */
-	se->vlag =3D div_s64(se->vlag * se->load.weight, weight);
+	se->vlag =3D div64_long(se->vlag * se->load.weight, weight);
 	if (se->rel_deadline)
-		se->deadline =3D div_s64(se->deadline * se->load.weight, weight);
+		se->deadline =3D div64_long(se->deadline * se->load.weight, weight);
=20
 	if (rel_vprot)
-		vprot =3D div_s64(vprot * se->load.weight, weight);
+		vprot =3D div64_long(vprot * se->load.weight, weight);
=20
 	update_load_set(&se->load, weight);
=20
@@ -5180,7 +5238,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity=
 *se, int flags)
 	 */
 	if (sched_feat(PLACE_LAG) && cfs_rq->nr_queued && se->vlag) {
 		struct sched_entity *curr =3D cfs_rq->curr;
-		unsigned long load;
+		long load;
=20
 		lag =3D se->vlag;
=20
@@ -5238,12 +5296,12 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_enti=
ty *se, int flags)
 		 */
 		load =3D cfs_rq->sum_weight;
 		if (curr && curr->on_rq)
-			load +=3D scale_load_down(curr->load.weight);
+			load +=3D avg_vruntime_weight(cfs_rq, curr->load.weight);
=20
-		lag *=3D load + scale_load_down(se->load.weight);
+		lag *=3D load + avg_vruntime_weight(cfs_rq, se->load.weight);
 		if (WARN_ON_ONCE(!load))
 			load =3D 1;
-		lag =3D div_s64(lag, load);
+		lag =3D div64_long(lag, load);
 	}
=20
 	se->vruntime =3D vruntime - lag;
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 37d5928..a25f972 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -58,6 +58,8 @@ SCHED_FEAT(CACHE_HOT_BUDDY, true)
 SCHED_FEAT(DELAY_DEQUEUE, true)
 SCHED_FEAT(DELAY_ZERO, true)
=20
+SCHED_FEAT(PARANOID_AVG, false)
+
 /*
  * Allow wakeup-time preemption of the current task:
  */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 43bbf06..8bf2f7d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -684,8 +684,9 @@ struct cfs_rq {
=20
 	s64			sum_w_vruntime;
 	u64			sum_weight;
-
 	u64			zero_vruntime;
+	unsigned int		sum_shift;
+
 #ifdef CONFIG_SCHED_CORE
 	unsigned int		forceidle_seq;
 	u64			zero_vruntime_fi;

