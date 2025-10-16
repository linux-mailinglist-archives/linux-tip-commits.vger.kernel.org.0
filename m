Return-Path: <linux-tip-commits+bounces-6847-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 580A8BE2716
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:40:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1E3CE3E2261
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:36:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BD23323417;
	Thu, 16 Oct 2025 09:33:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m/GypFc2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SAhHxqBt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A9FD31A046;
	Thu, 16 Oct 2025 09:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607230; cv=none; b=CjLsHt2ZDJQOhbYUq2fnkue4weT705GUvLUVCUpnGEvEMwS279RpwyqUKGp1jCzXIy0mRFK7HVwKImlZUR8qXeGlgEogdOpZaI9udHBgM3WBlEgB+ZNX0Ma6rWNF1/W6Afhv5N7aPPdj/RjzxaGPvhvkSt2kzp5PqkFJuBQh3FY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607230; c=relaxed/simple;
	bh=RRasjwLFBUj83MX96nymx91YlkNRKmzQTP+iv56OJX8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Z2RHvT0ZCL9ATEZ7TArBgyx1AKM55Zj63zwE0gYggSj/P2Wfo14jTIetO59Vzq4YU/f6EqXO9kpxbNegDp/ErRoXeKX111odB4QCJuPFx3SMPW5Yv5TmRHHZCiyTfpFkzaXInDUyP2lSjQM45vsOM61IREF36CrecKYXGc5c95M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m/GypFc2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SAhHxqBt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:33:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760607227;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E8R0luGVEbWQ5MerGOXY9BLBqVO99/2Nrg3PPLHwJd8=;
	b=m/GypFc2lFDyPz8aH3zH0NnaCcQmCQSa9UY39IEj3TnACR0mnaA38VySQ7zLipI0YAuP2j
	bZ7UFg7Dvjb0kxAMh0srPlHB/91g++MSz7WNuuyyv74VAzzw23xpqm0kVGkxjtM5610g9P
	KLJZwTAeaKIe+vo/1hNOzlGPravFrktEoiV+vvFGMnOzyEf5SuyK0yOAEzcoBXgdo7FgDF
	CmFjAnR6aKrzdLDioe/hGCMcb3WtB8w2EOaCvk0FtR+yg6uwbNlZ8VU3oHE1gq/5Qwlt1I
	CkUdJwAouKwajAySWHbeR5+RmotSVF0bVg4KC49hzv1yECoyWrFbd61e+HiqiQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760607227;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E8R0luGVEbWQ5MerGOXY9BLBqVO99/2Nrg3PPLHwJd8=;
	b=SAhHxqBtycT4uvDN9dFBBkoFh5zEhJZwCT+sONEp/eJWKbUlx6XEp6Xoh5lS30yB1AFzLb
	OXptbPnl/IZ5dwBA==
From: "tip-bot2 for Doug Berger" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/deadline: only set free_cpus for online runqueues
Cc: Doug Berger <opendmb@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250815012236.4053467-1-opendmb@gmail.com>
References: <20250815012236.4053467-1-opendmb@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060722582.709179.1540483623189425427.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     382748c05e58a9f1935f5a653c352422375566ea
Gitweb:        https://git.kernel.org/tip/382748c05e58a9f1935f5a653c352422375=
566ea
Author:        Doug Berger <opendmb@gmail.com>
AuthorDate:    Thu, 14 Aug 2025 18:22:36 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 16 Oct 2025 11:13:49 +02:00

sched/deadline: only set free_cpus for online runqueues

Commit 16b269436b72 ("sched/deadline: Modify cpudl::free_cpus
to reflect rd->online") introduced the cpudl_set/clear_freecpu
functions to allow the cpu_dl::free_cpus mask to be manipulated
by the deadline scheduler class rq_on/offline callbacks so the
mask would also reflect this state.

Commit 9659e1eeee28 ("sched/deadline: Remove cpu_active_mask
from cpudl_find()") removed the check of the cpu_active_mask to
save some processing on the premise that the cpudl::free_cpus
mask already reflected the runqueue online state.

Unfortunately, there are cases where it is possible for the
cpudl_clear function to set the free_cpus bit for a CPU when the
deadline runqueue is offline. When this occurs while a CPU is
connected to the default root domain the flag may retain the bad
state after the CPU has been unplugged. Later, a different CPU
that is transitioning through the default root domain may push a
deadline task to the powered down CPU when cpudl_find sees its
free_cpus bit is set. If this happens the task will not have the
opportunity to run.

One example is outlined here:
https://lore.kernel.org/lkml/20250110233010.2339521-1-opendmb@gmail.com

Another occurs when the last deadline task is migrated from a
CPU that has an offlined runqueue. The dequeue_task member of
the deadline scheduler class will eventually call cpudl_clear
and set the free_cpus bit for the CPU.

This commit modifies the cpudl_clear function to be aware of the
online state of the deadline runqueue so that the free_cpus mask
can be updated appropriately.

It is no longer necessary to manage the mask outside of the
cpudl_set/clear functions so the cpudl_set/clear_freecpu
functions are removed. In addition, since the free_cpus mask is
now only updated under the cpudl lock the code was changed to
use the non-atomic __cpumask functions.

Signed-off-by: Doug Berger <opendmb@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/cpudeadline.c | 34 +++++++++-------------------------
 kernel/sched/cpudeadline.h |  4 +---
 kernel/sched/deadline.c    |  8 ++++----
 3 files changed, 14 insertions(+), 32 deletions(-)

diff --git a/kernel/sched/cpudeadline.c b/kernel/sched/cpudeadline.c
index cdd740b..37b572c 100644
--- a/kernel/sched/cpudeadline.c
+++ b/kernel/sched/cpudeadline.c
@@ -166,12 +166,13 @@ int cpudl_find(struct cpudl *cp, struct task_struct *p,
  * cpudl_clear - remove a CPU from the cpudl max-heap
  * @cp: the cpudl max-heap context
  * @cpu: the target CPU
+ * @online: the online state of the deadline runqueue
  *
  * Notes: assumes cpu_rq(cpu)->lock is locked
  *
  * Returns: (void)
  */
-void cpudl_clear(struct cpudl *cp, int cpu)
+void cpudl_clear(struct cpudl *cp, int cpu, bool online)
 {
 	int old_idx, new_cpu;
 	unsigned long flags;
@@ -184,7 +185,7 @@ void cpudl_clear(struct cpudl *cp, int cpu)
 	if (old_idx =3D=3D IDX_INVALID) {
 		/*
 		 * Nothing to remove if old_idx was invalid.
-		 * This could happen if a rq_offline_dl is
+		 * This could happen if rq_online_dl or rq_offline_dl is
 		 * called for a CPU without -dl tasks running.
 		 */
 	} else {
@@ -195,9 +196,12 @@ void cpudl_clear(struct cpudl *cp, int cpu)
 		cp->elements[new_cpu].idx =3D old_idx;
 		cp->elements[cpu].idx =3D IDX_INVALID;
 		cpudl_heapify(cp, old_idx);
-
-		cpumask_set_cpu(cpu, cp->free_cpus);
 	}
+	if (likely(online))
+		__cpumask_set_cpu(cpu, cp->free_cpus);
+	else
+		__cpumask_clear_cpu(cpu, cp->free_cpus);
+
 	raw_spin_unlock_irqrestore(&cp->lock, flags);
 }
=20
@@ -228,7 +232,7 @@ void cpudl_set(struct cpudl *cp, int cpu, u64 dl)
 		cp->elements[new_idx].cpu =3D cpu;
 		cp->elements[cpu].idx =3D new_idx;
 		cpudl_heapify_up(cp, new_idx);
-		cpumask_clear_cpu(cpu, cp->free_cpus);
+		__cpumask_clear_cpu(cpu, cp->free_cpus);
 	} else {
 		cp->elements[old_idx].dl =3D dl;
 		cpudl_heapify(cp, old_idx);
@@ -238,26 +242,6 @@ void cpudl_set(struct cpudl *cp, int cpu, u64 dl)
 }
=20
 /*
- * cpudl_set_freecpu - Set the cpudl.free_cpus
- * @cp: the cpudl max-heap context
- * @cpu: rd attached CPU
- */
-void cpudl_set_freecpu(struct cpudl *cp, int cpu)
-{
-	cpumask_set_cpu(cpu, cp->free_cpus);
-}
-
-/*
- * cpudl_clear_freecpu - Clear the cpudl.free_cpus
- * @cp: the cpudl max-heap context
- * @cpu: rd attached CPU
- */
-void cpudl_clear_freecpu(struct cpudl *cp, int cpu)
-{
-	cpumask_clear_cpu(cpu, cp->free_cpus);
-}
-
-/*
  * cpudl_init - initialize the cpudl structure
  * @cp: the cpudl max-heap context
  */
diff --git a/kernel/sched/cpudeadline.h b/kernel/sched/cpudeadline.h
index 11c0f1f..d769946 100644
--- a/kernel/sched/cpudeadline.h
+++ b/kernel/sched/cpudeadline.h
@@ -19,8 +19,6 @@ struct cpudl {
=20
 int  cpudl_find(struct cpudl *cp, struct task_struct *p, struct cpumask *lat=
er_mask);
 void cpudl_set(struct cpudl *cp, int cpu, u64 dl);
-void cpudl_clear(struct cpudl *cp, int cpu);
+void cpudl_clear(struct cpudl *cp, int cpu, bool online);
 int  cpudl_init(struct cpudl *cp);
-void cpudl_set_freecpu(struct cpudl *cp, int cpu);
-void cpudl_clear_freecpu(struct cpudl *cp, int cpu);
 void cpudl_cleanup(struct cpudl *cp);
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 615411a..933bd1f 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1808,7 +1808,7 @@ static void dec_dl_deadline(struct dl_rq *dl_rq, u64 de=
adline)
 	if (!dl_rq->dl_nr_running) {
 		dl_rq->earliest_dl.curr =3D 0;
 		dl_rq->earliest_dl.next =3D 0;
-		cpudl_clear(&rq->rd->cpudl, rq->cpu);
+		cpudl_clear(&rq->rd->cpudl, rq->cpu, rq->online);
 		cpupri_set(&rq->rd->cpupri, rq->cpu, rq->rt.highest_prio.curr);
 	} else {
 		struct rb_node *leftmost =3D rb_first_cached(&dl_rq->root);
@@ -2880,9 +2880,10 @@ static void rq_online_dl(struct rq *rq)
 	if (rq->dl.overloaded)
 		dl_set_overload(rq);
=20
-	cpudl_set_freecpu(&rq->rd->cpudl, rq->cpu);
 	if (rq->dl.dl_nr_running > 0)
 		cpudl_set(&rq->rd->cpudl, rq->cpu, rq->dl.earliest_dl.curr);
+	else
+		cpudl_clear(&rq->rd->cpudl, rq->cpu, true);
 }
=20
 /* Assumes rq->lock is held */
@@ -2891,8 +2892,7 @@ static void rq_offline_dl(struct rq *rq)
 	if (rq->dl.overloaded)
 		dl_clear_overload(rq);
=20
-	cpudl_clear(&rq->rd->cpudl, rq->cpu);
-	cpudl_clear_freecpu(&rq->rd->cpudl, rq->cpu);
+	cpudl_clear(&rq->rd->cpudl, rq->cpu, false);
 }
=20
 void __init init_sched_dl_class(void)

