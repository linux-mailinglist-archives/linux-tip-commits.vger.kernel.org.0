Return-Path: <linux-tip-commits+bounces-7698-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id F37DCCBCE66
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 09:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC6EF301394D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 07:59:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48F0E329E6D;
	Mon, 15 Dec 2025 07:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QAICwmfm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+peLXEvd"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8210A2BEFF8;
	Mon, 15 Dec 2025 07:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765785559; cv=none; b=ONlQOudLHQjbmfuYb8dpsgvv7F5KdcvS/XisZZbiLzja3omMjGLomH02qDJVzDGXaRWofhXcg2lH1nAIj2DelznwhpUKSfMiQpDrDfXmIES8SGfZ60QQIIGEFtUBICQ2rZdbSUNGSKwxvSFeFcmUDsaG+XyWTQv4877IIxDhN+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765785559; c=relaxed/simple;
	bh=65OSXuPXoidyZVh4uUXaJDbpXB28mbd86GXCRLD3UuM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OP3gZ4yPbmbFdht9BYEUr3eabepEo9pht2bbTNvksqfzb880oQJqtpRN40FF/xGjtHa/xAui6L0KFBetKgAQbnO/TXb+C8lY5RyGrw3dxL4TXynJpPeOlV0kOdo1k5MvR2nCqpZHEaLhEKKVXXevZ0wSOYM9ubc6Td8FYh+Fg8o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QAICwmfm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+peLXEvd; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Dec 2025 07:59:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765785549;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L544CxgGNLlB339YEBu6UU1ft5glzgZYse3Be71gsWI=;
	b=QAICwmfmoVxsU6TLjMkRrbZtWoX5RxVF+YS4ObLGJ5kqxRNSzepnDW+H1IYTLgL0gXcY97
	HVk/PjkgBLpN7rzcPPpUE9tl1w0OK5JVsAVf5ShaJerEofj0tqsz8JzyO3FZk6hXwRu6A4
	7bzQAU+wA390cye8pzw1iKJita11wzSlliX1PZrjY5BKbXe/G936sf0GbkDLkal4wLLMJg
	6vI1bKRbwLSqoblCgTO4+pN6M1xNVWGEY64UCEJ+ZoOhAfHWZ/RHS+lX7y1JYTLGwaQ+wR
	YBaz5sjFxsH2PwJBedhSVtXqdCEwCKJyo7/wrt6YYgZ/hXWrcZxQtTn6AKOJ/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765785549;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=L544CxgGNLlB339YEBu6UU1ft5glzgZYse3Be71gsWI=;
	b=+peLXEvdsARe8vaqO6p9VcXX2AfUrbSPpmub9r9gDdngMmvnVeY/EwlNo//b1f/EJb6+Du
	RZqh8Tht2D2s3nCQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/fair: Sort out 'blocked_load*' namespace noise
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Frederic Weisbecker <frederic@kernel.org>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <aS6yvxyc3JfMxxQW@gmail.com>
References: <aS6yvxyc3JfMxxQW@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176578554861.498.7120804758413411569.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     527a521029c3edd38fb9fc96cd58e3fd7393d28e
Gitweb:        https://git.kernel.org/tip/527a521029c3edd38fb9fc96cd58e3fd739=
3d28e
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Tue, 02 Dec 2025 10:35:06 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 15 Dec 2025 07:52:45 +01:00

sched/fair: Sort out 'blocked_load*' namespace noise

There's three layers of logic in the scheduler that
deal with 'has_blocked' (load) handling of the NOHZ code:

  (1) nohz.has_blocked,
  (2) rq->has_blocked_load, deal with NOHZ idle balancing,
  (3) and cfs_rq_has_blocked(), which is part of the layer
      that is passing the SMP load-balancing signal to the
      NOHZ layers.

The 'has_blocked' and 'has_blocked_load' names are used
in a mixed fashion, sometimes within the same function.

Standardize on 'has_blocked_load' to make it all easy
to read and easy to grep.

No change in functionality.

Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Link: https://patch.msgid.link/aS6yvxyc3JfMxxQW@gmail.com
---
 kernel/sched/fair.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a8ac68d..d588eb8 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7140,7 +7140,7 @@ static DEFINE_PER_CPU(cpumask_var_t, should_we_balance_=
tmpmask);
 static struct {
 	cpumask_var_t idle_cpus_mask;
 	atomic_t nr_cpus;
-	int has_blocked;		/* Idle CPUS has blocked load */
+	int has_blocked_load;		/* Idle CPUS has blocked load */
 	int needs_update;		/* Newly idle CPUs need their next_balance collated */
 	unsigned long next_balance;     /* in jiffy units */
 	unsigned long next_blocked;	/* Next update of blocked load in jiffies */
@@ -9770,7 +9770,7 @@ static void attach_tasks(struct lb_env *env)
 }
=20
 #ifdef CONFIG_NO_HZ_COMMON
-static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq)
+static inline bool cfs_rq_has_blocked_load(struct cfs_rq *cfs_rq)
 {
 	if (cfs_rq->avg.load_avg)
 		return true;
@@ -9803,16 +9803,16 @@ static inline void update_blocked_load_tick(struct rq=
 *rq)
 	WRITE_ONCE(rq->last_blocked_load_update_tick, jiffies);
 }
=20
-static inline void update_blocked_load_status(struct rq *rq, bool has_blocke=
d)
+static inline void update_has_blocked_load_status(struct rq *rq, bool has_bl=
ocked_load)
 {
-	if (!has_blocked)
+	if (!has_blocked_load)
 		rq->has_blocked_load =3D 0;
 }
 #else /* !CONFIG_NO_HZ_COMMON: */
-static inline bool cfs_rq_has_blocked(struct cfs_rq *cfs_rq) { return false;=
 }
+static inline bool cfs_rq_has_blocked_load(struct cfs_rq *cfs_rq) { return f=
alse; }
 static inline bool others_have_blocked(struct rq *rq) { return false; }
 static inline void update_blocked_load_tick(struct rq *rq) {}
-static inline void update_blocked_load_status(struct rq *rq, bool has_blocke=
d) {}
+static inline void update_has_blocked_load_status(struct rq *rq, bool has_bl=
ocked_load) {}
 #endif /* !CONFIG_NO_HZ_COMMON */
=20
 static bool __update_blocked_others(struct rq *rq, bool *done)
@@ -9869,7 +9869,7 @@ static bool __update_blocked_fair(struct rq *rq, bool *=
done)
 			list_del_leaf_cfs_rq(cfs_rq);
=20
 		/* Don't need periodic decay once load/util_avg are null */
-		if (cfs_rq_has_blocked(cfs_rq))
+		if (cfs_rq_has_blocked_load(cfs_rq))
 			*done =3D false;
 	}
=20
@@ -9929,7 +9929,7 @@ static bool __update_blocked_fair(struct rq *rq, bool *=
done)
 	bool decayed;
=20
 	decayed =3D update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq);
-	if (cfs_rq_has_blocked(cfs_rq))
+	if (cfs_rq_has_blocked_load(cfs_rq))
 		*done =3D false;
=20
 	return decayed;
@@ -9950,7 +9950,7 @@ static void __sched_balance_update_blocked_averages(str=
uct rq *rq)
 	decayed |=3D __update_blocked_others(rq, &done);
 	decayed |=3D __update_blocked_fair(rq, &done);
=20
-	update_blocked_load_status(rq, !done);
+	update_has_blocked_load_status(rq, !done);
 	if (decayed)
 		cpufreq_update_util(rq, 0);
 }
@@ -12446,7 +12446,7 @@ static void nohz_balancer_kick(struct rq *rq)
 	if (likely(!atomic_read(&nohz.nr_cpus)))
 		return;
=20
-	if (READ_ONCE(nohz.has_blocked) &&
+	if (READ_ONCE(nohz.has_blocked_load) &&
 	    time_after(now, READ_ONCE(nohz.next_blocked)))
 		flags =3D NOHZ_STATS_KICK;
=20
@@ -12607,9 +12607,9 @@ void nohz_balance_enter_idle(int cpu)
=20
 	/*
 	 * The tick is still stopped but load could have been added in the
-	 * meantime. We set the nohz.has_blocked flag to trig a check of the
+	 * meantime. We set the nohz.has_blocked_load flag to trig a check of the
 	 * *_avg. The CPU is already part of nohz.idle_cpus_mask so the clear
-	 * of nohz.has_blocked can only happen after checking the new load
+	 * of nohz.has_blocked_load can only happen after checking the new load
 	 */
 	if (rq->nohz_tick_stopped)
 		goto out;
@@ -12625,7 +12625,7 @@ void nohz_balance_enter_idle(int cpu)
=20
 	/*
 	 * Ensures that if nohz_idle_balance() fails to observe our
-	 * @idle_cpus_mask store, it must observe the @has_blocked
+	 * @idle_cpus_mask store, it must observe the @has_blocked_load
 	 * and @needs_update stores.
 	 */
 	smp_mb__after_atomic();
@@ -12638,7 +12638,7 @@ out:
 	 * Each time a cpu enter idle, we assume that it has blocked load and
 	 * enable the periodic update of the load of idle CPUs
 	 */
-	WRITE_ONCE(nohz.has_blocked, 1);
+	WRITE_ONCE(nohz.has_blocked_load, 1);
 }
=20
 static bool update_nohz_stats(struct rq *rq)
@@ -12679,8 +12679,8 @@ static void _nohz_idle_balance(struct rq *this_rq, un=
signed int flags)
=20
 	/*
 	 * We assume there will be no idle load after this update and clear
-	 * the has_blocked flag. If a cpu enters idle in the mean time, it will
-	 * set the has_blocked flag and trigger another update of idle load.
+	 * the has_blocked_load flag. If a cpu enters idle in the mean time, it will
+	 * set the has_blocked_load flag and trigger another update of idle load.
 	 * Because a cpu that becomes idle, is added to idle_cpus_mask before
 	 * setting the flag, we are sure to not clear the state and not
 	 * check the load of an idle cpu.
@@ -12688,12 +12688,12 @@ static void _nohz_idle_balance(struct rq *this_rq, =
unsigned int flags)
 	 * Same applies to idle_cpus_mask vs needs_update.
 	 */
 	if (flags & NOHZ_STATS_KICK)
-		WRITE_ONCE(nohz.has_blocked, 0);
+		WRITE_ONCE(nohz.has_blocked_load, 0);
 	if (flags & NOHZ_NEXT_KICK)
 		WRITE_ONCE(nohz.needs_update, 0);
=20
 	/*
-	 * Ensures that if we miss the CPU, we must see the has_blocked
+	 * Ensures that if we miss the CPU, we must see the has_blocked_load
 	 * store from nohz_balance_enter_idle().
 	 */
 	smp_mb();
@@ -12760,7 +12760,7 @@ static void _nohz_idle_balance(struct rq *this_rq, un=
signed int flags)
 abort:
 	/* There is still blocked load, enable periodic update */
 	if (has_blocked_load)
-		WRITE_ONCE(nohz.has_blocked, 1);
+		WRITE_ONCE(nohz.has_blocked_load, 1);
 }
=20
 /*
@@ -12822,7 +12822,7 @@ static void nohz_newidle_balance(struct rq *this_rq)
 		return;
=20
 	/* Don't need to update blocked load of idle CPUs*/
-	if (!READ_ONCE(nohz.has_blocked) ||
+	if (!READ_ONCE(nohz.has_blocked_load) ||
 	    time_before(jiffies, READ_ONCE(nohz.next_blocked)))
 		return;
=20

