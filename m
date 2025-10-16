Return-Path: <linux-tip-commits+bounces-6837-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EC12BE26C5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F6771A6269E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:35:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7B67531DDB7;
	Thu, 16 Oct 2025 09:33:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NYhen8xb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9gG9o22f"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46B4F31D731;
	Thu, 16 Oct 2025 09:33:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607217; cv=none; b=KogMD01VcD/Ws4aqp0fIXGo/5a1XhmoDCdZXtOgwaUbXm8VaRCSxL5BybNqOTadWteIagOAq7C9pA+r9XuT1TVmPXQtn33X7/w6OfienR/ZvQZEA8ykMb3xmMvNa2p/STX3dwiw1IZnklG+rUDpzleylc99in1vagTMap9MfBk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607217; c=relaxed/simple;
	bh=5UvBXLVywz+n+FbQMQd/K8pJvPPAMIukw8FIfJoQ9S0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=X61J9RisoIgP2O5OssQt/+zXUE4ypntKrvyEZ5uBX4gfOujkRRWR+O8x8cSAUJ3cmAzkJ7Wqqojb+awFvk2mslmZYe9geokXbbEhYXysYl2iWSwVSheU3WiyHXuYuWGdTnrb7+T60nz05+H274Nc3WMXVzNryd/QEF2T0FZWqhc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NYhen8xb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9gG9o22f; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:33:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760607213;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cQwHUYHsJ+DKszNFVnU25hjHEe4e+bZ6swEiThCyI0E=;
	b=NYhen8xbBsV06L/+oFI/HGwyFQ5eEztIVzfiGQ9+52OIUBsQwL6sfc6d1n93kpzBFCMomb
	73eL7zLasnUvEvSb2ZtQ8EX/7l9QJeTobKmTlXwByhkGDeGEiw3Ko62kppZ9XAdvElWj3q
	z58NHtobx/6Ks3l+uIpTFnJ89JMk9hL6GhtimDo065gkl7GgXN3ouGbR0WkHHNJkqCRMR5
	RBDF0l0FYrxKhl1+pWYIcH3PPfSclbpaxq/Lf3L/PgskkJPBNOH4iP97YQLR3PluDOsvH6
	r/iJ4NF6PZeBR0QyZJ97cx0Of3Zzu8Bywu8uZz9UVG21BJETskD12tFUhLjPQw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760607213;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cQwHUYHsJ+DKszNFVnU25hjHEe4e+bZ6swEiThCyI0E=;
	b=9gG9o22f+m714tQxOEbnW+e2z12RABBogAtrNQOY5w70iqCe48ulmnw5fQ37F1kdRirVDJ
	zn2Oe4NfLIb0FuDQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Fix migrate_disable_switch() locking
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>, Tejun Heo <tj@kernel.org>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251006104527.202601024@infradead.org>
References: <20251006104527.202601024@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060721251.709179.5437409564280407669.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     942b8db965006cf655d356162f7091a9238da94e
Gitweb:        https://git.kernel.org/tip/942b8db965006cf655d356162f7091a9238=
da94e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 10 Sep 2025 09:46:44 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 16 Oct 2025 11:13:52 +02:00

sched: Fix migrate_disable_switch() locking

For some reason migrate_disable_switch() was more complicated than it
needs to be, resulting in mind bending locking of dubious quality.

Recognise that migrate_disable_switch() must be called before a
context switch, but any place before that switch is equally good.
Since the current place results in troubled locking, simply move the
thing before taking rq->lock.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Acked-by: Tejun Heo <tj@kernel.org>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
---
 kernel/sched/core.c | 27 ++++++---------------------
 1 file changed, 6 insertions(+), 21 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4a4dbce..f2d16d1 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2346,10 +2346,10 @@ static void migrate_disable_switch(struct rq *rq, str=
uct task_struct *p)
 	if (p->cpus_ptr !=3D &p->cpus_mask)
 		return;
=20
-	/*
-	 * Violates locking rules! See comment in __do_set_cpus_allowed().
-	 */
-	__do_set_cpus_allowed(p, &ac);
+	scoped_guard (task_rq_lock, p) {
+		update_rq_clock(scope.rq);
+		__do_set_cpus_allowed(p, &ac);
+	}
 }
=20
 void ___migrate_enable(void)
@@ -2667,22 +2667,7 @@ __do_set_cpus_allowed(struct task_struct *p, struct af=
finity_context *ctx)
 	struct rq *rq =3D task_rq(p);
 	bool queued, running;
=20
-	/*
-	 * This here violates the locking rules for affinity, since we're only
-	 * supposed to change these variables while holding both rq->lock and
-	 * p->pi_lock.
-	 *
-	 * HOWEVER, it magically works, because ttwu() is the only code that
-	 * accesses these variables under p->pi_lock and only does so after
-	 * smp_cond_load_acquire(&p->on_cpu, !VAL), and we're in __schedule()
-	 * before finish_task().
-	 *
-	 * XXX do further audits, this smells like something putrid.
-	 */
-	if (ctx->flags & SCA_MIGRATE_DISABLE)
-		WARN_ON_ONCE(!p->on_cpu);
-	else
-		lockdep_assert_held(&p->pi_lock);
+	lockdep_assert_held(&p->pi_lock);
=20
 	queued =3D task_on_rq_queued(p);
 	running =3D task_current_donor(rq, p);
@@ -6781,6 +6766,7 @@ static void __sched notrace __schedule(int sched_mode)
=20
 	local_irq_disable();
 	rcu_note_context_switch(preempt);
+	migrate_disable_switch(rq, prev);
=20
 	/*
 	 * Make sure that signal_pending_state()->signal_pending() below
@@ -6887,7 +6873,6 @@ keep_resched:
 		 */
 		++*switch_count;
=20
-		migrate_disable_switch(rq, prev);
 		psi_account_irqtime(rq, prev, next);
 		psi_sched_switch(prev, next, !task_on_rq_queued(prev) ||
 					     prev->se.sched_delayed);

