Return-Path: <linux-tip-commits+bounces-8024-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DE7DD28D11
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 22:46:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 91D843015F7F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Jan 2026 21:44:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D30D4322B67;
	Thu, 15 Jan 2026 21:44:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R5PUSrBv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Uw04PxNX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C96133120B;
	Thu, 15 Jan 2026 21:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768513459; cv=none; b=bajqPuJGfkQ/X7avwayj+uucJKGXHMFr7RNzbeoqU+TFi7BeHdQyUGGYkZgt67sj4a8hvfVImnD5Bbo3ySTThKfOwEelQr5WtTeaqX9Joy0e+wbKRr9dXGk7WXY4KtRFq5hx9sOgkIX9d1IHCOcQpYIYdpMOipuVk0dUtKcINqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768513459; c=relaxed/simple;
	bh=Z/kILH6+RZbzB3l69ewFKiq8veijwuAzw7LPezXQP8I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=K56CRQop3MugIziAYi8cbbFEEQjHM0g+3W/pQSacGMlE8b864GK2jK3QnU4/e1W6kgZ8X60Y6bg7IrtryoWZ+ci5fkXkC8kKNBa41hzaMxCOA5pwvrjPRqXPQIlTRZm1RZLmV1TTwVZdq9BiTpQ8Qg9SxMpgkiLv/1KrpKrBebI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R5PUSrBv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Uw04PxNX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 15 Jan 2026 21:44:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768513456;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6/dHB4vYldC29L/FDUXkxxzYRIRIkMY4KnghFfC/LRU=;
	b=R5PUSrBviPBe1sDTX9juX8AmOxexQl7/T9pE4VhDV4YAV1IuCOm3JZziy4bYIJxsN6WP+i
	dTfx3x/n5kFNzvmNTy6EIZ39+ftw3rjD6Lute/cUZw/r5cF8Ad1Pn3/b5TELVLHAEHdhr7
	LyFTLYHKl8ZdB1QJ+A8KlCZaa8SaCVN3m2dSA0QbOsJGPgG1PrXSVXGo26SNvgHMoCRH64
	aVxoJoLUZYgXJoIosi3bC543qF/9SCMw/QklZjGXimuI3d9jLPpzFLPm4w2/yQTihkfYOR
	ren4jZ3WnfB0JBdwvs9gS1oFfvx8U6+sLOfXQmAEbVC8cwpDHpLR9w3NA1p2vA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768513456;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6/dHB4vYldC29L/FDUXkxxzYRIRIkMY4KnghFfC/LRU=;
	b=Uw04PxNXBrMmwNJEw3mPGETmNuwRtBlLA2tEb/JS4OdOlCCYi8u5BpwIR7JSc9n/bCrIXC
	ZM/1LeC3yDvsyQCw==
From: "tip-bot2 for Shrikanth Hegde" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Remove nohz.nr_cpus and use weight of
 cpumask instead
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260115073524.376643-4-sshegde@linux.ibm.com>
References: <20260115073524.376643-4-sshegde@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176851345552.510.10783205014451960980.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5d86d542f68fda7ef6d543ac631b741db734101a
Gitweb:        https://git.kernel.org/tip/5d86d542f68fda7ef6d543ac631b741db73=
4101a
Author:        Shrikanth Hegde <sshegde@linux.ibm.com>
AuthorDate:    Thu, 15 Jan 2026 13:05:24 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 15 Jan 2026 22:41:27 +01:00

sched/fair: Remove nohz.nr_cpus and use weight of cpumask instead

nohz.nr_cpus was observed as contended cacheline when running
enterprise workload on large systems.

Fundamental scalability challenge with nohz.idle_cpus_mask
and nohz.nr_cpus is the following:

 (1) nohz_balancer_kick() observes (reads) nohz.nr_cpus
     (or nohz.idle_cpu_mask) and nohz.has_blocked to  see whether there's
     any nohz balancing work to do, in every scheduler tick.

 (2) nohz_balance_enter_idle() and nohz_balance_exit_idle()
     (through nohz_balancer_kick() via sched_tick()) modify (write)
     nohz.nr_cpus (and/or nohz.idle_cpu_mask) and nohz.has_blocked.

The characteristic frequencies are the following:

 (1) nohz_balancer_kick() happens at scheduler (busy)tick frequency
     on CPU(which has not gone idle). This is a relatively constant
     frequency  in the ~1 kHz range or lower.

 (2) happens at idle enter/exit frequency on every CPU that goes to idle.
     This is workload dependent, but can easily be hundreds of kHz for
     IO-bound loads and high CPU counts. Ie. can be orders of magnitude
     higher than (1), in which case a cachemiss at every invocation of (1)
     is almost inevitable. idle exit will trigger (1) on the CPU
     which is coming out of idle.

There's two types of costs from these functions:

 (A) scheduler tick cost via (1): this happens on busy CPUs too, and is
     thus a primary scalability cost. But the rate here is constant and
     typically much lower than (B), hence the absolute benefit to workload
     scalability will be lower as well.

 (B) idle cost via (2): going-to-idle and coming-from-idle costs are
     secondary concerns, because they impact power efficiency more than
     they impact scalability. But in terms of absolute cost this scales
     up with nr_cpus as well, and a much faster rate, and thus may also
     approach and negatively impact system limits like
     memory bus/fabric bandwidth.

Note that nohz.idle_cpus_mask and nohz.nr_cpus may appear to reside in the
same cacheline, however under CONFIG_CPUMASK_OFFSTACK=3Dy the backing storage
for nohz.idle_cpus_mask will be elsewhere. With CPUMASK_OFFSTACK=3Dn,
the nohz.idle_cpus_mask and rest of nohz fields are in different cachelines
under typical NR_CPUS=3D512/2048. This implies two separate cachelines
being dirtied upon idle entry / exit.

nohz.nr_cpus can be derived from the mask itself. Its usage doesn't warrant
a functionally correct value. This means one less cacheline being dirtied in
idle entry/exit path which helps to save some bus bandwidth w.r.t to those
nohz functions(approx 50%). This in turn helps to improve enterprise
workload throughput.

On system with 480 CPUs, running "hackbench 40 process 10000 loops"
(Avg of 3 runs)
baseline:
     0.81%  hackbench          [k] nohz_balance_exit_idle
     0.21%  hackbench          [k] nohz_balancer_kick
     0.09%  swapper            [k] nohz_run_idle_balance

With patch:
     0.35%  hackbench          [k] nohz_balance_exit_idle
     0.09%  hackbench          [k] nohz_balancer_kick
     0.07%  swapper            [k] nohz_run_idle_balance

[Ingo Molnar: scalability analysis changlog]

Reviewed-and-tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://patch.msgid.link/20260115073524.376643-4-sshegde@linux.ibm.com
---
 kernel/sched/fair.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 4ae06ce..04993c7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7138,7 +7138,6 @@ static DEFINE_PER_CPU(cpumask_var_t, should_we_balance_=
tmpmask);
=20
 static struct {
 	cpumask_var_t idle_cpus_mask;
-	atomic_t nr_cpus;
 	int has_blocked_load;		/* Idle CPUS has blocked load */
 	int needs_update;		/* Newly idle CPUs need their next_balance collated */
 	unsigned long next_balance;     /* in jiffy units */
@@ -12461,7 +12460,7 @@ static void nohz_balancer_kick(struct rq *rq)
 	 * None are in tickless mode and hence no need for NOHZ idle load
 	 * balancing
 	 */
-	if (unlikely(!atomic_read(&nohz.nr_cpus)))
+	if (unlikely(cpumask_empty(nohz.idle_cpus_mask)))
 		return;
=20
 	if (rq->nr_running >=3D 2) {
@@ -12574,7 +12573,6 @@ void nohz_balance_exit_idle(struct rq *rq)
=20
 	rq->nohz_tick_stopped =3D 0;
 	cpumask_clear_cpu(rq->cpu, nohz.idle_cpus_mask);
-	atomic_dec(&nohz.nr_cpus);
=20
 	set_cpu_sd_state_busy(rq->cpu);
 }
@@ -12632,7 +12630,6 @@ void nohz_balance_enter_idle(int cpu)
 	rq->nohz_tick_stopped =3D 1;
=20
 	cpumask_set_cpu(cpu, nohz.idle_cpus_mask);
-	atomic_inc(&nohz.nr_cpus);
=20
 	/*
 	 * Ensures that if nohz_idle_balance() fails to observe our

