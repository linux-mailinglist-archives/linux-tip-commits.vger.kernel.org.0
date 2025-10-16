Return-Path: <linux-tip-commits+bounces-6827-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B14ECBE268C
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:34:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4873C1A62391
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:34:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 137B631A07B;
	Thu, 16 Oct 2025 09:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bEh4TSIj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KNM/34u8"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2338A31A052;
	Thu, 16 Oct 2025 09:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607204; cv=none; b=dSsx+oHQ6yY2zSlf1KFaza+mwPDi+HZvawRwNfohjdd/Ra5l+4JgI99TnsJT6jaeKjmP1ct4a6/zpq5hxTcLyPFH2chacfr6YDtMpCjfX44YagCZkI17xUVo1yTruEndnYypRdnWrzLFV2Mi2POkZtemV/7zywBn46QQCDcRmyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607204; c=relaxed/simple;
	bh=/8PK8zAdDsQhDODSdcn4rRu6CnDFmmZAd9Rv5LbOU9M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=io3MT+2Iy8a0fkjUuI9cdexrySEsZdtX59NXk6ZPX0lMMKHLS6gqVV9ozi+/GmFIFWkopG9vzfY+Xv2Oh/Ch7EUrgM/kySRKmC85TxuRE+IaUP9jfMOTOx8C0+5SWacXyJIhV27oLzTrHPhX4bb/ZvHVImOg/wuV/mQssy1GUSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bEh4TSIj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KNM/34u8; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:33:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760607200;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6nrst6Z2nShJ9HzChKwWjTvR0p5U1ei/FhzHpuJI7TM=;
	b=bEh4TSIjgkf4A2SfDKMkZJeEPRsCxmyjOyY49681WOnZ/HTJdFp3kK+kYwkNdXpJ8cgnJ4
	LEVRTLWQIBHh3fL9ezCVkNWC+a3lZzetOHFakfDgEWGi6hmFhHZnJgKDAGW8ulPEiyrytX
	VDH6/tA8LOUXWq9yuvXVY+roUnwkxcivOtN8shYAh/ccegNc5mPgny1CVP6CHIZU1lCi+Z
	8WZRDFH/U3EWmxV4ru6N9rmT+DH4jCoMkOiGQnM8FQvCbkh/DJGiK3Dmu/ub05RzzfYg16
	xHMHJyP/pByoDCKgyLH0qtijnL2LMZI/2XrmGyZTEoxaFGoiljb0wbazCo3XyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760607200;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6nrst6Z2nShJ9HzChKwWjTvR0p5U1ei/FhzHpuJI7TM=;
	b=KNM/34u8cFB8BkVEHT0hfH2fZYieqz0+MDr5Wx0RgOAygokx+Ry45QnsOZd3TiMeOo9jD5
	WwFoKIUP+BekhyAA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/ext: Fold balance_scx() into pick_task_scx()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, Tejun Heo <tj@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251006105453.769281377@infradead.org>
References: <20251006105453.769281377@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060719918.709179.4331838766243561085.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4c95380701f58b8112f0b891de8d160e4199e19d
Gitweb:        https://git.kernel.org/tip/4c95380701f58b8112f0b891de8d160e419=
9e19d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 01 Oct 2025 20:41:36 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 16 Oct 2025 11:13:55 +02:00

sched/ext: Fold balance_scx() into pick_task_scx()

With pick_task() having an rf argument, it is possible to do the
lock-break there, get rid of the weird balance/pick_task hack.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Tejun Heo <tj@kernel.org>
---
 kernel/sched/core.c  | 13 +-------
 kernel/sched/ext.c   | 78 ++++++-------------------------------------
 kernel/sched/sched.h |  1 +-
 3 files changed, 12 insertions(+), 80 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a75d456..096e8d0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5845,19 +5845,6 @@ static void prev_balance(struct rq *rq, struct task_st=
ruct *prev,
 	const struct sched_class *start_class =3D prev->sched_class;
 	const struct sched_class *class;
=20
-#ifdef CONFIG_SCHED_CLASS_EXT
-	/*
-	 * SCX requires a balance() call before every pick_task() including when
-	 * waking up from SCHED_IDLE. If @start_class is below SCX, start from
-	 * SCX instead. Also, set a flag to detect missing balance() call.
-	 */
-	if (scx_enabled()) {
-		rq->scx.flags |=3D SCX_RQ_BAL_PENDING;
-		if (sched_class_above(&ext_sched_class, start_class))
-			start_class =3D &ext_sched_class;
-	}
-#endif
-
 	/*
 	 * We must do the balancing pass before put_prev_task(), such
 	 * that when we release the rq->lock the task is in the same
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index dc743ca..49f4a9e 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -2013,7 +2013,7 @@ static int balance_one(struct rq *rq, struct task_struc=
t *prev)
=20
 	lockdep_assert_rq_held(rq);
 	rq->scx.flags |=3D SCX_RQ_IN_BALANCE;
-	rq->scx.flags &=3D ~(SCX_RQ_BAL_PENDING | SCX_RQ_BAL_KEEP);
+	rq->scx.flags &=3D ~SCX_RQ_BAL_KEEP;
=20
 	if ((sch->ops.flags & SCX_OPS_HAS_CPU_PREEMPT) &&
 	    unlikely(rq->scx.cpu_released)) {
@@ -2119,40 +2119,6 @@ has_tasks:
 	return true;
 }
=20
-static int balance_scx(struct rq *rq, struct task_struct *prev,
-		       struct rq_flags *rf)
-{
-	int ret;
-
-	rq_unpin_lock(rq, rf);
-
-	ret =3D balance_one(rq, prev);
-
-#ifdef CONFIG_SCHED_SMT
-	/*
-	 * When core-sched is enabled, this ops.balance() call will be followed
-	 * by pick_task_scx() on this CPU and the SMT siblings. Balance the
-	 * siblings too.
-	 */
-	if (sched_core_enabled(rq)) {
-		const struct cpumask *smt_mask =3D cpu_smt_mask(cpu_of(rq));
-		int scpu;
-
-		for_each_cpu_andnot(scpu, smt_mask, cpumask_of(cpu_of(rq))) {
-			struct rq *srq =3D cpu_rq(scpu);
-			struct task_struct *sprev =3D srq->curr;
-
-			WARN_ON_ONCE(__rq_lockp(rq) !=3D __rq_lockp(srq));
-			update_rq_clock(srq);
-			balance_one(srq, sprev);
-		}
-	}
-#endif
-	rq_repin_lock(rq, rf);
-
-	return ret;
-}
-
 static void process_ddsp_deferred_locals(struct rq *rq)
 {
 	struct task_struct *p;
@@ -2335,38 +2301,19 @@ static struct task_struct *first_local_task(struct rq=
 *rq)
 static struct task_struct *pick_task_scx(struct rq *rq, struct rq_flags *rf)
 {
 	struct task_struct *prev =3D rq->curr;
+	bool keep_prev, kick_idle =3D false;
 	struct task_struct *p;
-	bool keep_prev =3D rq->scx.flags & SCX_RQ_BAL_KEEP;
-	bool kick_idle =3D false;
=20
-	/*
-	 * WORKAROUND:
-	 *
-	 * %SCX_RQ_BAL_KEEP should be set iff $prev is on SCX as it must just
-	 * have gone through balance_scx(). Unfortunately, there currently is a
-	 * bug where fair could say yes on balance() but no on pick_task(),
-	 * which then ends up calling pick_task_scx() without preceding
-	 * balance_scx().
-	 *
-	 * Keep running @prev if possible and avoid stalling from entering idle
-	 * without balancing.
-	 *
-	 * Once fair is fixed, remove the workaround and trigger WARN_ON_ONCE()
-	 * if pick_task_scx() is called without preceding balance_scx().
-	 */
-	if (unlikely(rq->scx.flags & SCX_RQ_BAL_PENDING)) {
-		if (prev->scx.flags & SCX_TASK_QUEUED) {
-			keep_prev =3D true;
-		} else {
-			keep_prev =3D false;
-			kick_idle =3D true;
-		}
-	} else if (unlikely(keep_prev &&
-			    prev->sched_class !=3D &ext_sched_class)) {
-		/*
-		 * Can happen while enabling as SCX_RQ_BAL_PENDING assertion is
-		 * conditional on scx_enabled() and may have been skipped.
-		 */
+	rq_modified_clear(rq);
+	rq_unpin_lock(rq, rf);
+	balance_one(rq, prev);
+	rq_repin_lock(rq, rf);
+	if (rq_modified_above(rq, &ext_sched_class))
+		return RETRY_TASK;
+
+	keep_prev =3D rq->scx.flags & SCX_RQ_BAL_KEEP;
+	if (unlikely(keep_prev &&
+		     prev->sched_class !=3D &ext_sched_class)) {
 		WARN_ON_ONCE(scx_enable_state() =3D=3D SCX_ENABLED);
 		keep_prev =3D false;
 	}
@@ -3243,7 +3190,6 @@ DEFINE_SCHED_CLASS(ext) =3D {
=20
 	.wakeup_preempt		=3D wakeup_preempt_scx,
=20
-	.balance		=3D balance_scx,
 	.pick_task		=3D pick_task_scx,
=20
 	.put_prev_task		=3D put_prev_task_scx,
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 8946294..e7718f1 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -779,7 +779,6 @@ enum scx_rq_flags {
 	 */
 	SCX_RQ_ONLINE		=3D 1 << 0,
 	SCX_RQ_CAN_STOP_TICK	=3D 1 << 1,
-	SCX_RQ_BAL_PENDING	=3D 1 << 2, /* balance hasn't run yet */
 	SCX_RQ_BAL_KEEP		=3D 1 << 3, /* balance decided to keep current */
 	SCX_RQ_BYPASSING	=3D 1 << 4,
 	SCX_RQ_CLK_VALID	=3D 1 << 5, /* RQ clock is fresh and valid */

