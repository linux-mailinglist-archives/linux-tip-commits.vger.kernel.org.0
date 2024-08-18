Return-Path: <linux-tip-commits+bounces-2068-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E3E59955B33
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 08:24:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1239C1C20E90
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 06:24:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BD30C1B977;
	Sun, 18 Aug 2024 06:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rPGpVaif";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VTx5YaLd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F1191759F;
	Sun, 18 Aug 2024 06:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723962194; cv=none; b=U2Os8KVqd1apSxV7Erf5xQyAyx2S0WS4fdGobmkZ4JK5megn531iqPkt9656EwLhd/gvnDOutW56qAZrR09KStm4G6N3GIHF7RwzudaAt24cpcmKWAkwmYfFT87EYT0q6Js6ZOJ0adek+jPJUp6JVLNWJCyMvasU4z55GdmtZGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723962194; c=relaxed/simple;
	bh=5b1ZijSXrOxdpKT5XveGQ7mqbb2WyvZS7B2BP20jhps=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Zdnxf7WfxTJmTZGMlidpB0rjZpA7d6U0aAL48T7YVNOhStJwHbYxQuj+hoZ5KmUC/kytAY6SfOY1gc6rlu60CRnsmgQQ1OYXZssz8X3QtNf/PpIdQSrpOdCt5xJjnLqIaD758pPNPjn1SVyP//k5hbrXMFGGZ6G1cgq8sdlqKg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rPGpVaif; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VTx5YaLd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Aug 2024 06:23:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723962189;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kOossh0DybaTFevpJaaPpDf06LwX+CBjmA37wQU7BVE=;
	b=rPGpVaifs4y+oIfo+VGd6YEYK2WguUEiukhaxKYqSoP0IeubIZUHpVPkJFzVufW45OADDa
	wP5P4A5Ry75Q656yKg/5R213HPrhCT6UrrUNLTOZ37roJzHAoOD3Njmc6IE3flTVWrcArf
	yIiSFRViz8bbgmjdvc/2zq6bY7LW982q+TkPncLyYNzUNWsgEvr5ppKAmi/s2vuRQtY4Yx
	vG/zWcAbqmLFsy7qItHnaQPOXIwyeIPemBpcZa2WGaRuNOaywg/BmG++Cm40fN6xS+D2ZP
	Ze2CIgyRPUOFG2m7pcVaKd+S7f1kulYoxFwHc6RuiF1NWXYCj344wE7dUZPFHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723962189;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kOossh0DybaTFevpJaaPpDf06LwX+CBjmA37wQU7BVE=;
	b=VTx5YaLdd5steH2tzfBT+9cl+Hf+HB+qL37qcAWq9dryMWksZVz2eFpyI6J5dryuljoiFg
	Lfa7yYH0UIShy+Ag==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/fair: Prepare exit/cleanup paths for delayed_dequeue
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240727105029.631948434@infradead.org>
References: <20240727105029.631948434@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172396218914.2215.13392579962139774480.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2e0199df252a536a03f4cb0810324dff523d1e79
Gitweb:        https://git.kernel.org/tip/2e0199df252a536a03f4cb0810324dff523d1e79
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 23 May 2024 11:03:42 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 17 Aug 2024 11:06:43 +02:00

sched/fair: Prepare exit/cleanup paths for delayed_dequeue

When dequeue_task() is delayed it becomes possible to exit a task (or
cgroup) that is still enqueued. Ensure things are dequeued before
freeing.

Thanks to Valentin for asking the obvious questions and making
switched_from_fair() less weird.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lkml.kernel.org/r/20240727105029.631948434@infradead.org
---
 kernel/sched/fair.c | 59 ++++++++++++++++++++++++++++++++++----------
 1 file changed, 46 insertions(+), 13 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 37acd53..9a84903 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8342,7 +8342,21 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
 
 static void task_dead_fair(struct task_struct *p)
 {
-	remove_entity_load_avg(&p->se);
+	struct sched_entity *se = &p->se;
+
+	if (se->sched_delayed) {
+		struct rq_flags rf;
+		struct rq *rq;
+
+		rq = task_rq_lock(p, &rf);
+		if (se->sched_delayed) {
+			update_rq_clock(rq);
+			dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
+		}
+		task_rq_unlock(rq, p, &rf);
+	}
+
+	remove_entity_load_avg(se);
 }
 
 /*
@@ -12854,10 +12868,22 @@ static void attach_task_cfs_rq(struct task_struct *p)
 static void switched_from_fair(struct rq *rq, struct task_struct *p)
 {
 	detach_task_cfs_rq(p);
+	/*
+	 * Since this is called after changing class, this is a little weird
+	 * and we cannot use DEQUEUE_DELAYED.
+	 */
+	if (p->se.sched_delayed) {
+		dequeue_task(rq, p, DEQUEUE_NOCLOCK | DEQUEUE_SLEEP);
+		p->se.sched_delayed = 0;
+		if (sched_feat(DELAY_ZERO) && p->se.vlag > 0)
+			p->se.vlag = 0;
+	}
 }
 
 static void switched_to_fair(struct rq *rq, struct task_struct *p)
 {
+	SCHED_WARN_ON(p->se.sched_delayed);
+
 	attach_task_cfs_rq(p);
 
 	set_task_max_allowed_capacity(p);
@@ -13008,28 +13034,35 @@ void online_fair_sched_group(struct task_group *tg)
 
 void unregister_fair_sched_group(struct task_group *tg)
 {
-	unsigned long flags;
-	struct rq *rq;
 	int cpu;
 
 	destroy_cfs_bandwidth(tg_cfs_bandwidth(tg));
 
 	for_each_possible_cpu(cpu) {
-		if (tg->se[cpu])
-			remove_entity_load_avg(tg->se[cpu]);
+		struct cfs_rq *cfs_rq = tg->cfs_rq[cpu];
+		struct sched_entity *se = tg->se[cpu];
+		struct rq *rq = cpu_rq(cpu);
+
+		if (se) {
+			if (se->sched_delayed) {
+				guard(rq_lock_irqsave)(rq);
+				if (se->sched_delayed) {
+					update_rq_clock(rq);
+					dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
+				}
+				list_del_leaf_cfs_rq(cfs_rq);
+			}
+			remove_entity_load_avg(se);
+		}
 
 		/*
 		 * Only empty task groups can be destroyed; so we can speculatively
 		 * check on_list without danger of it being re-added.
 		 */
-		if (!tg->cfs_rq[cpu]->on_list)
-			continue;
-
-		rq = cpu_rq(cpu);
-
-		raw_spin_rq_lock_irqsave(rq, flags);
-		list_del_leaf_cfs_rq(tg->cfs_rq[cpu]);
-		raw_spin_rq_unlock_irqrestore(rq, flags);
+		if (cfs_rq->on_list) {
+			guard(rq_lock_irqsave)(rq);
+			list_del_leaf_cfs_rq(cfs_rq);
+		}
 	}
 }
 

