Return-Path: <linux-tip-commits+bounces-7700-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D9B7CBCE72
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 09:03:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5870D3035A73
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 07:59:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C87532A3C0;
	Mon, 15 Dec 2025 07:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rpdrb/lW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fi5+TCmC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1FC329E76;
	Mon, 15 Dec 2025 07:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765785561; cv=none; b=Gun2X4qbNLwFG0kVix2m8ZvKJ5oQbQXxIX9Aysrkrf8hdKU8nkXhlittOSV+hot7GzP21gH47N/GwsuU5DVslHgjHGveIGjVfzoxJjS86QnmG+XwRHkMb20r8OZgOegqLft0XaCs8u/T9p7WvvyTXsQbimWTXca7SbjOxTug9HA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765785561; c=relaxed/simple;
	bh=9xDz7Umxsh+Pp01Ma6pmxFjy+q/YZk/bBrr8aaFpZzA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hBE4L0uOq4CW68SHLIiYlYnAk54ay/2rpdimBQsekIIt/u7YYpVOXBE6smj/i23f1zrb3sVKxEpxhRLCi9YQgUinrYFapAgbhD0SrmSC6KT7JBUiTFLjocJAvatcEqUHzx4ywRopdcZOJBdqmYvAi2rIHL588zjtINXyFfxlNac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rpdrb/lW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fi5+TCmC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Dec 2025 07:59:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765785552;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ly80MoFLLaxpJnOxZw73c5ip7IG6TyvCrjt5T2Otcls=;
	b=rpdrb/lWoCuYAigDxwxoddZo+CIK7VQizorNynq5alvFt3FJ1jfIdUSwhDg0SGnwaidFdH
	QM78255yHeqenFn2xLNni0PlGpOeZrIthTmOY8H8n3D40N2xFEuemaYWdYYRn5Q5LN3mPD
	ilJV17HGcfrKofrs2g4Rv4xOM+j0K4j8sHc9qGi5Qrb6gK5ce1Pc3BPqarGiCAMcJxrC1X
	76h/ZlMah/U7So9A8LCsD7TQ7+DSPZCmU8mnxJJQuB4DgvnHM8axQZgvLXIndTwJChdO3y
	zzQBwOLF43LMaC3rOj/SO6k0ObdqMQfOkAkJS0xJ8kd94JYTS8O8diNPfI+3rA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765785552;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ly80MoFLLaxpJnOxZw73c5ip7IG6TyvCrjt5T2Otcls=;
	b=fi5+TCmCLwpuljJjQTquWioG682P9tgxVOMEJ0ytNePhFh+Pah45k0gPjcXoGZsn4HYkt/
	G4xswtHzwLO+rFAQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Rename cfs_rq::avg_vruntime to
 ::sum_w_vruntime, and helper functions
Cc:
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251201064647.1851919-7-mingo@kernel.org>
References: <20251201064647.1851919-7-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176578555091.498.7452134552387785806.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     dcbc9d3f0e594223275a18f7016001889ad35eff
Gitweb:        https://git.kernel.org/tip/dcbc9d3f0e594223275a18f7016001889ad=
35eff
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Tue, 02 Dec 2025 16:09:23 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 15 Dec 2025 07:52:44 +01:00

sched/fair: Rename cfs_rq::avg_vruntime to ::sum_w_vruntime, and helper funct=
ions

The ::avg_vruntime field is a  misnomer: it says it's an
'average vruntime', but in reality it's the momentary sum
of the weighted vruntimes of all queued tasks, which is
at least a division away from being an average.

This is clear from comments about the math of fair scheduling:

    * \Sum (v_i - v0) * w_i :=3D cfs_rq->avg_vruntime

This confusion is increased by the cfs_avg_vruntime() function,
which does perform the division and returns a true average.

The sum of all weighted vruntimes should be named thusly,
so rename the field to ::sum_w_vruntime. (As arguably
::sum_weighted_vruntime would be a bit of a mouthful.)

Understanding the scheduler is hard enough already, without
extra layers of obfuscated naming. ;-)

Also rename related helper functions:

  sum_vruntime_add()    =3D> sum_w_vruntime_add()
  sum_vruntime_sub()    =3D> sum_w_vruntime_sub()
  sum_vruntime_update() =3D> sum_w_vruntime_update()

With the notable exception of cfs_avg_vruntime(), which
was named accurately.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://patch.msgid.link/20251201064647.1851919-7-mingo@kernel.org
---
 kernel/sched/fair.c  | 26 +++++++++++++-------------
 kernel/sched/sched.h |  2 +-
 2 files changed, 14 insertions(+), 14 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 65b1065..dcbd995 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -607,7 +607,7 @@ static inline s64 entity_key(struct cfs_rq *cfs_rq, struc=
t sched_entity *se)
  * Which we track using:
  *
  *                    v0 :=3D cfs_rq->zero_vruntime
- * \Sum (v_i - v0) * w_i :=3D cfs_rq->avg_vruntime
+ * \Sum (v_i - v0) * w_i :=3D cfs_rq->sum_w_vruntime
  *              \Sum w_i :=3D cfs_rq->sum_weight
  *
  * Since zero_vruntime closely tracks the per-task service, these
@@ -619,32 +619,32 @@ static inline s64 entity_key(struct cfs_rq *cfs_rq, str=
uct sched_entity *se)
  * As measured, the max (key * weight) value was ~44 bits for a kernel build.
  */
 static void
-avg_vruntime_add(struct cfs_rq *cfs_rq, struct sched_entity *se)
+sum_w_vruntime_add(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	unsigned long weight =3D scale_load_down(se->load.weight);
 	s64 key =3D entity_key(cfs_rq, se);
=20
-	cfs_rq->avg_vruntime +=3D key * weight;
+	cfs_rq->sum_w_vruntime +=3D key * weight;
 	cfs_rq->sum_weight +=3D weight;
 }
=20
 static void
-avg_vruntime_sub(struct cfs_rq *cfs_rq, struct sched_entity *se)
+sum_w_vruntime_sub(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
 	unsigned long weight =3D scale_load_down(se->load.weight);
 	s64 key =3D entity_key(cfs_rq, se);
=20
-	cfs_rq->avg_vruntime -=3D key * weight;
+	cfs_rq->sum_w_vruntime -=3D key * weight;
 	cfs_rq->sum_weight -=3D weight;
 }
=20
 static inline
-void avg_vruntime_update(struct cfs_rq *cfs_rq, s64 delta)
+void sum_w_vruntime_update(struct cfs_rq *cfs_rq, s64 delta)
 {
 	/*
-	 * v' =3D v + d =3D=3D> avg_vruntime' =3D avg_runtime - d*sum_weight
+	 * v' =3D v + d =3D=3D> sum_w_vruntime' =3D sum_runtime - d*sum_weight
 	 */
-	cfs_rq->avg_vruntime -=3D cfs_rq->sum_weight * delta;
+	cfs_rq->sum_w_vruntime -=3D cfs_rq->sum_weight * delta;
 }
=20
 /*
@@ -654,7 +654,7 @@ void avg_vruntime_update(struct cfs_rq *cfs_rq, s64 delta)
 u64 avg_vruntime(struct cfs_rq *cfs_rq)
 {
 	struct sched_entity *curr =3D cfs_rq->curr;
-	s64 avg =3D cfs_rq->avg_vruntime;
+	s64 avg =3D cfs_rq->sum_w_vruntime;
 	long load =3D cfs_rq->sum_weight;
=20
 	if (curr && curr->on_rq) {
@@ -722,7 +722,7 @@ static void update_entity_lag(struct cfs_rq *cfs_rq, stru=
ct sched_entity *se)
 static int vruntime_eligible(struct cfs_rq *cfs_rq, u64 vruntime)
 {
 	struct sched_entity *curr =3D cfs_rq->curr;
-	s64 avg =3D cfs_rq->avg_vruntime;
+	s64 avg =3D cfs_rq->sum_w_vruntime;
 	long load =3D cfs_rq->sum_weight;
=20
 	if (curr && curr->on_rq) {
@@ -745,7 +745,7 @@ static void update_zero_vruntime(struct cfs_rq *cfs_rq)
 	u64 vruntime =3D avg_vruntime(cfs_rq);
 	s64 delta =3D (s64)(vruntime - cfs_rq->zero_vruntime);
=20
-	avg_vruntime_update(cfs_rq, delta);
+	sum_w_vruntime_update(cfs_rq, delta);
=20
 	cfs_rq->zero_vruntime =3D vruntime;
 }
@@ -819,7 +819,7 @@ RB_DECLARE_CALLBACKS(static, min_vruntime_cb, struct sche=
d_entity,
  */
 static void __enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	avg_vruntime_add(cfs_rq, se);
+	sum_w_vruntime_add(cfs_rq, se);
 	update_zero_vruntime(cfs_rq);
 	se->min_vruntime =3D se->vruntime;
 	se->min_slice =3D se->slice;
@@ -831,7 +831,7 @@ static void __dequeue_entity(struct cfs_rq *cfs_rq, struc=
t sched_entity *se)
 {
 	rb_erase_augmented_cached(&se->run_node, &cfs_rq->tasks_timeline,
 				  &min_vruntime_cb);
-	avg_vruntime_sub(cfs_rq, se);
+	sum_w_vruntime_sub(cfs_rq, se);
 	update_zero_vruntime(cfs_rq);
 }
=20
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 3334aa5..ab1bfa0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -678,7 +678,7 @@ struct cfs_rq {
 	unsigned int		h_nr_runnable;		/* SCHED_{NORMAL,BATCH,IDLE} */
 	unsigned int		h_nr_idle;		/* SCHED_IDLE */
=20
-	s64			avg_vruntime;
+	s64			sum_w_vruntime;
 	u64			sum_weight;
=20
 	u64			zero_vruntime;

