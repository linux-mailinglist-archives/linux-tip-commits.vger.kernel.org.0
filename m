Return-Path: <linux-tip-commits+bounces-7702-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 36CAFCBCE7E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 09:03:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 0FAC73009A95
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 07:59:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AD2F32AABF;
	Mon, 15 Dec 2025 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KSaUOqJJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yTzcnlrD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FB5332A3C5;
	Mon, 15 Dec 2025 07:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765785562; cv=none; b=V79UjL98ia9PM7OIaeMX3RMdf0uDDfGx8+FKTpkpQkYpYpM0EbV2eCCPqqT3Auy6ZTsyic4XRaGXxJXScOgygllLwo43n203S5tCzAbSbDgYnYVmPlzUNtrRFz07LxaX953272bnJJI0p0s5PcPhtMXJvcuF8g8s76fRijsBtk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765785562; c=relaxed/simple;
	bh=l67O3mNGI0VO3FGSl2LpBPNFWJgOFy51h1ADOoMdbG0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fEphOrI4O73AA6wLZYXYAaRRSRbgAm94GQ1smPQfJGK8dJFTFzf04/U5ni/ghv4Ecdpec0tIrkTV98Kg3XlJgL0ZgolfTtK1L9Fe3Ru0GcpfsxZLEP7gTJXDgPIGF6NjWUWje0rKvXMoTgN9zvaJ95Mec4I+7W4DnN5jXkCzYF8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KSaUOqJJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yTzcnlrD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Dec 2025 07:59:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765785553;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9bCWYwRjdIx77K6OB9gDg2fGic44NqHkWN11g5K+hk=;
	b=KSaUOqJJJMs01wO/TjJFKDmlDCAXTyZHK4aXMwlsfdaOKpJJB359Qgtpji3ipoHceFLA/N
	ux8krk4NiQ7qGa/lNV4jbKpF/dZ5DpPt5wZ7W5NsNLXC7xLpJ9oiSpHvXeBSlzrKmXxaA/
	dpD7x3Q4s6MnLSaYeGCQgNrEcYTpvMRiRF5HxMEHz5bFkOO+F5N6hTb/QzC+CyG5TR3CH8
	3UJFvUv7PvWxQHyPEZJkKMumnobjIBHFDFZotj2UZd88t0QFrjzTc706x8qJ9ai4H/v1Nk
	nyr19Y9qHP+QmpBCYAJxKSPkdG6L5eGXi+Kbtdqz3ggvX+52raw/eh32mX0OXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765785553;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y9bCWYwRjdIx77K6OB9gDg2fGic44NqHkWN11g5K+hk=;
	b=yTzcnlrD52jR9cuwKDrv0skyaWeIZAitLT5KEi/LGsn4CiqTQKImcC3VHFtopA+mRngTv9
	dev2BUwBQlniYYBQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/fair: Rename cfs_rq::avg_load to cfs_rq::sum_weight
Cc:
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251201064647.1851919-6-mingo@kernel.org>
References: <20251201064647.1851919-6-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176578555194.498.15125313159198443861.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4ff674fa986c27ec8a0542479258c92d361a2566
Gitweb:        https://git.kernel.org/tip/4ff674fa986c27ec8a0542479258c92d361=
a2566
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 26 Nov 2025 12:09:16 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 15 Dec 2025 07:52:44 +01:00

sched/fair: Rename cfs_rq::avg_load to cfs_rq::sum_weight

The ::avg_load field is a long-standing misnomer: it says it's an
'average load', but in reality it's the momentary sum of the load
of all currently runnable tasks. We'd have to also perform a
division by nr_running (or use time-decay) to arrive at any sort
of average value.

This is clear from comments about the math of fair scheduling:

    *              \Sum w_i :=3D cfs_rq->avg_load

The sum of all weights is ... the sum of all weights, not
the average of all weights.

To make it doubly confusing, there's also an ::avg_load
in the load-balancing struct sg_lb_stats, which *is* a
true average.

The second part of the field's name is a minor misnomer
as well: it says 'load', and it is indeed a load_weight
structure as it shares code with the load-balancer - but
it's only in an SMP load-balancing context where
load =3D weight, in the fair scheduling context the primary
purpose is the weighting of different nice levels.

So rename the field to ::sum_weight instead, which makes
the terminology of the EEVDF math match up with our
implementation of it:

    *              \Sum w_i :=3D cfs_rq->sum_weight

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://patch.msgid.link/20251201064647.1851919-6-mingo@kernel.org
---
 kernel/sched/fair.c  | 16 ++++++++--------
 kernel/sched/sched.h |  2 +-
 2 files changed, 9 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index f79951f..65b1065 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -608,7 +608,7 @@ static inline s64 entity_key(struct cfs_rq *cfs_rq, struc=
t sched_entity *se)
  *
  *                    v0 :=3D cfs_rq->zero_vruntime
  * \Sum (v_i - v0) * w_i :=3D cfs_rq->avg_vruntime
- *              \Sum w_i :=3D cfs_rq->avg_load
+ *              \Sum w_i :=3D cfs_rq->sum_weight
  *
  * Since zero_vruntime closely tracks the per-task service, these
  * deltas: (v_i - v), will be in the order of the maximal (virtual) lag
@@ -625,7 +625,7 @@ avg_vruntime_add(struct cfs_rq *cfs_rq, struct sched_enti=
ty *se)
 	s64 key =3D entity_key(cfs_rq, se);
=20
 	cfs_rq->avg_vruntime +=3D key * weight;
-	cfs_rq->avg_load +=3D weight;
+	cfs_rq->sum_weight +=3D weight;
 }
=20
 static void
@@ -635,16 +635,16 @@ avg_vruntime_sub(struct cfs_rq *cfs_rq, struct sched_en=
tity *se)
 	s64 key =3D entity_key(cfs_rq, se);
=20
 	cfs_rq->avg_vruntime -=3D key * weight;
-	cfs_rq->avg_load -=3D weight;
+	cfs_rq->sum_weight -=3D weight;
 }
=20
 static inline
 void avg_vruntime_update(struct cfs_rq *cfs_rq, s64 delta)
 {
 	/*
-	 * v' =3D v + d =3D=3D> avg_vruntime' =3D avg_runtime - d*avg_load
+	 * v' =3D v + d =3D=3D> avg_vruntime' =3D avg_runtime - d*sum_weight
 	 */
-	cfs_rq->avg_vruntime -=3D cfs_rq->avg_load * delta;
+	cfs_rq->avg_vruntime -=3D cfs_rq->sum_weight * delta;
 }
=20
 /*
@@ -655,7 +655,7 @@ u64 avg_vruntime(struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *curr =3D cfs_rq->curr;
 	s64 avg =3D cfs_rq->avg_vruntime;
-	long load =3D cfs_rq->avg_load;
+	long load =3D cfs_rq->sum_weight;
=20
 	if (curr && curr->on_rq) {
 		unsigned long weight =3D scale_load_down(curr->load.weight);
@@ -723,7 +723,7 @@ static int vruntime_eligible(struct cfs_rq *cfs_rq, u64 v=
runtime)
 {
 	struct sched_entity *curr =3D cfs_rq->curr;
 	s64 avg =3D cfs_rq->avg_vruntime;
-	long load =3D cfs_rq->avg_load;
+	long load =3D cfs_rq->sum_weight;
=20
 	if (curr && curr->on_rq) {
 		unsigned long weight =3D scale_load_down(curr->load.weight);
@@ -5131,7 +5131,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity=
 *se, int flags)
 		 *
 		 *   vl_i =3D (W + w_i)*vl'_i / W
 		 */
-		load =3D cfs_rq->avg_load;
+		load =3D cfs_rq->sum_weight;
 		if (curr && curr->on_rq)
 			load +=3D scale_load_down(curr->load.weight);
=20
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 82522c9..3334aa5 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -679,7 +679,7 @@ struct cfs_rq {
 	unsigned int		h_nr_idle;		/* SCHED_IDLE */
=20
 	s64			avg_vruntime;
-	u64			avg_load;
+	u64			sum_weight;
=20
 	u64			zero_vruntime;
 #ifdef CONFIG_SCHED_CORE

