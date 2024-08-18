Return-Path: <linux-tip-commits+bounces-2061-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C94C955B2B
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 08:23:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B22871C210B0
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 06:23:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05D3B168BE;
	Sun, 18 Aug 2024 06:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="P3RpXN2O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dGIrbldl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 875A3D53F;
	Sun, 18 Aug 2024 06:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723962191; cv=none; b=RBU/51zWHXpSsAftW4E1P1JL9gYVothhnbLSEhA4PeCjBWMaha8bDGbOkG7PR9ETuP2x/GH4JB88DdVxaNf6SlhFqNb8j3WCZfqAEOCGx4wpF7I0laJDy8k9bp1wxFaTrAJaeX5EElugLUsg6BW1FQRXSSCp5u59IbrlXGNdHwY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723962191; c=relaxed/simple;
	bh=R3bjurKZ4ITGHegARw9ORkfCSeI1ocKclJGMM5U1dbE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CKbKE8ItUPyVJo26p7z3d2L0qVlqBujDtBjNci2TlIL/cDq+hRyuLmARySq/mEhLSUi5mlChP7m/M9XGWwcuo4DgvmR7QiGK+kyMY0eggSDSP0h+jTIf96128nGPnKY0jho12xNqnjF3uzHlwko0V0IQ3mmIK9AH0sCB3raC9BU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=P3RpXN2O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dGIrbldl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Aug 2024 06:23:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723962186;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g1gi4jnljTlb20x3aco/XdKt2ALccn0ZuYi9ZaA1lek=;
	b=P3RpXN2OoDDMrLtvQqacTbmnZ5H8w0oT9yNJF88f4AR1B2wg/PrwoLuqCm/p0wWI3WvnpM
	OytWAgO8V/Vu3o5e+czLqcMeinsbzniIEK08ZNhnSmvLU2Vo2wXeSGkiPR1xSJFT46Tyi2
	gGOosElYuEZuMDheXw6l0Zox3XU4cSg8AUqiGOS0ZZZAGPZvO9BbzGbthLbtXvnypOy/LE
	kHVC3NkcnaZBcZWly7QUWJNjUp6IQl7aXNm/hDeA4E8JEKEF12V24shAXU0CODdRTMsw16
	8xFi9PubAzanYuYfBobP78vDX6xSnA4amCVVv2aRpXlCf6iV8iU6Ro1b+NhyCw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723962186;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=g1gi4jnljTlb20x3aco/XdKt2ALccn0ZuYi9ZaA1lek=;
	b=dGIrbldlLHYD3ymgalblvTk0yrqtGgUkiRWCF4pv6i4YYKiCh+dNy+wryIBFf3yjIYhgww
	DS93ODMpFJhVt0Dw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/eevdf: Use sched_attr::sched_runtime to set
 request/slice suggestion
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240727105030.842834421@infradead.org>
References: <20240727105030.842834421@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172396218624.2215.12107224485579021657.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     857b158dc5e81c6de795ef6be006eed146098fc6
Gitweb:        https://git.kernel.org/tip/857b158dc5e81c6de795ef6be006eed146098fc6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 22 May 2023 13:46:30 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 17 Aug 2024 11:06:45 +02:00

sched/eevdf: Use sched_attr::sched_runtime to set request/slice suggestion

Allow applications to directly set a suggested request/slice length using
sched_attr::sched_runtime.

The implementation clamps the value to: 0.1[ms] <= slice <= 100[ms]
which is 1/10 the size of HZ=1000 and 10 times the size of HZ=100.

Applications should strive to use their periodic runtime at a high
confidence interval (95%+) as the target slice. Using a smaller slice
will introduce undue preemptions, while using a larger value will
increase latency.

For all the following examples assume a scheduling quantum of 8, and for
consistency all examples have W=4:

  {A,B,C,D}(w=1,r=8):

  ABCD...
  +---+---+---+---

  t=0, V=1.5				t=1, V=3.5
  A  |------<				A          |------<
  B   |------<				B   |------<
  C    |------<				C    |------<
  D     |------<			D     |------<
  ---+*------+-------+---		---+--*----+-------+---

  t=2, V=5.5				t=3, V=7.5
  A          |------<			A          |------<
  B           |------<			B           |------<
  C    |------<				C            |------<
  D     |------<			D     |------<
  ---+----*--+-------+---		---+------*+-------+---

Note: 4 identical tasks in FIFO order

~~~

  {A,B}(w=1,r=16) C(w=2,r=16)

  AACCBBCC...
  +---+---+---+---

  t=0, V=1.25				t=2, V=5.25
  A  |--------------<                   A                  |--------------<
  B   |--------------<                  B   |--------------<
  C    |------<                         C    |------<
  ---+*------+-------+---               ---+----*--+-------+---

  t=4, V=8.25				t=6, V=12.25
  A                  |--------------<   A                  |--------------<
  B   |--------------<                  B                   |--------------<
  C            |------<                 C            |------<
  ---+-------*-------+---               ---+-------+---*---+---

Note: 1 heavy task -- because q=8, double r such that the deadline of the w=2
      task doesn't go below q.

Note: observe the full schedule becomes: W*max(r_i/w_i) = 4*2q = 8q in length.

Note: the period of the heavy task is half the full period at:
      W*(r_i/w_i) = 4*(2q/2) = 4q

~~~

  {A,C,D}(w=1,r=16) B(w=1,r=8):

  BAACCBDD...
  +---+---+---+---

  t=0, V=1.5				t=1, V=3.5
  A  |--------------<			A  |---------------<
  B   |------<				B           |------<
  C    |--------------<			C    |--------------<
  D     |--------------<		D     |--------------<
  ---+*------+-------+---		---+--*----+-------+---

  t=3, V=7.5				t=5, V=11.5
  A                  |---------------<  A                  |---------------<
  B           |------<                  B           |------<
  C    |--------------<                 C                    |--------------<
  D     |--------------<                D     |--------------<
  ---+------*+-------+---               ---+-------+--*----+---

  t=6, V=13.5
  A                  |---------------<
  B                   |------<
  C                    |--------------<
  D     |--------------<
  ---+-------+----*--+---

Note: 1 short task -- again double r so that the deadline of the short task
      won't be below q. Made B short because its not the leftmost task, but is
      eligible with the 0,1,2,3 spread.

Note: like with the heavy task, the period of the short task observes:
      W*(r_i/w_i) = 4*(1q/1) = 4q

~~~

  A(w=1,r=16) B(w=1,r=8) C(w=2,r=16)

  BCCAABCC...
  +---+---+---+---

  t=0, V=1.25				t=1, V=3.25
  A  |--------------<                   A  |--------------<
  B   |------<                          B           |------<
  C    |------<                         C    |------<
  ---+*------+-------+---               ---+--*----+-------+---

  t=3, V=7.25				t=5, V=11.25
  A  |--------------<                   A                  |--------------<
  B           |------<                  B           |------<
  C            |------<                 C            |------<
  ---+------*+-------+---               ---+-------+--*----+---

  t=6, V=13.25
  A                  |--------------<
  B                   |------<
  C            |------<
  ---+-------+----*--+---

Note: 1 heavy and 1 short task -- combine them all.

Note: both the short and heavy task end up with a period of 4q

~~~

  A(w=1,r=16) B(w=2,r=16) C(w=1,r=8)

  BBCAABBC...
  +---+---+---+---

  t=0, V=1				t=2, V=5
  A  |--------------<                   A  |--------------<
  B   |------<                          B           |------<
  C    |------<                         C    |------<
  ---+*------+-------+---               ---+----*--+-------+---

  t=3, V=7				t=5, V=11
  A  |--------------<                   A                  |--------------<
  B           |------<                  B           |------<
  C            |------<                 C            |------<
  ---+------*+-------+---               ---+-------+--*----+---

  t=7, V=15
  A                  |--------------<
  B                   |------<
  C            |------<
  ---+-------+------*+---

Note: as before but permuted

~~~

>From all this it can be deduced that, for the steady state:

 - the total period (P) of a schedule is:	W*max(r_i/w_i)
 - the average period of a task is:		W*(r_i/w_i)
 - each task obtains the fair share:		w_i/W of each full period P

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lkml.kernel.org/r/20240727105030.842834421@infradead.org
---
 include/linux/sched.h   |  1 +
 kernel/sched/core.c     |  4 +++-
 kernel/sched/debug.c    |  3 ++-
 kernel/sched/fair.c     |  6 ++++--
 kernel/sched/syscalls.c | 29 +++++++++++++++++++++++------
 5 files changed, 33 insertions(+), 10 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d25e1cf..89a3d8d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -547,6 +547,7 @@ struct sched_entity {
 	unsigned char			on_rq;
 	unsigned char			sched_delayed;
 	unsigned char			rel_deadline;
+	unsigned char			custom_slice;
 					/* hole */
 
 	u64				exec_start;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 868b71b..0165811 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4390,7 +4390,6 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->se.nr_migrations		= 0;
 	p->se.vruntime			= 0;
 	p->se.vlag			= 0;
-	p->se.slice			= sysctl_sched_base_slice;
 	INIT_LIST_HEAD(&p->se.group_node);
 
 	/* A delayed task cannot be in clone(). */
@@ -4643,6 +4642,8 @@ int sched_fork(unsigned long clone_flags, struct task_struct *p)
 
 		p->prio = p->normal_prio = p->static_prio;
 		set_load_weight(p, false);
+		p->se.custom_slice = 0;
+		p->se.slice = sysctl_sched_base_slice;
 
 		/*
 		 * We don't need the reset flag anymore after the fork. It has
@@ -8412,6 +8413,7 @@ void __init sched_init(void)
 	}
 
 	set_load_weight(&init_task, false);
+	init_task.se.slice = sysctl_sched_base_slice,
 
 	/*
 	 * The boot idle thread does lazy MMU switching as well:
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 831a77a..01ce9a7 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -739,11 +739,12 @@ print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
 	else
 		SEQ_printf(m, " %c", task_state_to_char(p));
 
-	SEQ_printf(m, "%15s %5d %9Ld.%06ld %c %9Ld.%06ld %9Ld.%06ld %9Ld.%06ld %9Ld %5d ",
+	SEQ_printf(m, "%15s %5d %9Ld.%06ld %c %9Ld.%06ld %c %9Ld.%06ld %9Ld.%06ld %9Ld %5d ",
 		p->comm, task_pid_nr(p),
 		SPLIT_NS(p->se.vruntime),
 		entity_eligible(cfs_rq_of(&p->se), &p->se) ? 'E' : 'N',
 		SPLIT_NS(p->se.deadline),
+		p->se.custom_slice ? 'S' : ' ',
 		SPLIT_NS(p->se.slice),
 		SPLIT_NS(p->se.sum_exec_runtime),
 		(long long)(p->nvcsw + p->nivcsw),
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index cc30ea3..3284d3c 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -983,7 +983,8 @@ static bool update_deadline(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	 * nice) while the request time r_i is determined by
 	 * sysctl_sched_base_slice.
 	 */
-	se->slice = sysctl_sched_base_slice;
+	if (!se->custom_slice)
+		se->slice = sysctl_sched_base_slice;
 
 	/*
 	 * EEVDF: vd_i = ve_i + r_i / w_i
@@ -5227,7 +5228,8 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	u64 vslice, vruntime = avg_vruntime(cfs_rq);
 	s64 lag = 0;
 
-	se->slice = sysctl_sched_base_slice;
+	if (!se->custom_slice)
+		se->slice = sysctl_sched_base_slice;
 	vslice = calc_delta_fair(se->slice, se);
 
 	/*
diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 60e70c8..4fae3cf 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -401,10 +401,20 @@ static void __setscheduler_params(struct task_struct *p,
 
 	p->policy = policy;
 
-	if (dl_policy(policy))
+	if (dl_policy(policy)) {
 		__setparam_dl(p, attr);
-	else if (fair_policy(policy))
+	} else if (fair_policy(policy)) {
 		p->static_prio = NICE_TO_PRIO(attr->sched_nice);
+		if (attr->sched_runtime) {
+			p->se.custom_slice = 1;
+			p->se.slice = clamp_t(u64, attr->sched_runtime,
+					      NSEC_PER_MSEC/10,   /* HZ=1000 * 10 */
+					      NSEC_PER_MSEC*100); /* HZ=100  / 10 */
+		} else {
+			p->se.custom_slice = 0;
+			p->se.slice = sysctl_sched_base_slice;
+		}
+	}
 
 	/*
 	 * __sched_setscheduler() ensures attr->sched_priority == 0 when
@@ -700,7 +710,9 @@ recheck:
 	 * but store a possible modification of reset_on_fork.
 	 */
 	if (unlikely(policy == p->policy)) {
-		if (fair_policy(policy) && attr->sched_nice != task_nice(p))
+		if (fair_policy(policy) &&
+		    (attr->sched_nice != task_nice(p) ||
+		     (attr->sched_runtime != p->se.slice)))
 			goto change;
 		if (rt_policy(policy) && attr->sched_priority != p->rt_priority)
 			goto change;
@@ -846,6 +858,9 @@ static int _sched_setscheduler(struct task_struct *p, int policy,
 		.sched_nice	= PRIO_TO_NICE(p->static_prio),
 	};
 
+	if (p->se.custom_slice)
+		attr.sched_runtime = p->se.slice;
+
 	/* Fixup the legacy SCHED_RESET_ON_FORK hack. */
 	if ((policy != SETPARAM_POLICY) && (policy & SCHED_RESET_ON_FORK)) {
 		attr.sched_flags |= SCHED_FLAG_RESET_ON_FORK;
@@ -1012,12 +1027,14 @@ err_size:
 
 static void get_params(struct task_struct *p, struct sched_attr *attr)
 {
-	if (task_has_dl_policy(p))
+	if (task_has_dl_policy(p)) {
 		__getparam_dl(p, attr);
-	else if (task_has_rt_policy(p))
+	} else if (task_has_rt_policy(p)) {
 		attr->sched_priority = p->rt_priority;
-	else
+	} else {
 		attr->sched_nice = task_nice(p);
+		attr->sched_runtime = p->se.slice;
+	}
 }
 
 /**

