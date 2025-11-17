Return-Path: <linux-tip-commits+bounces-7372-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id AC698C65273
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Nov 2025 17:32:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id EC4A93825B9
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Nov 2025 16:24:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018982D060D;
	Mon, 17 Nov 2025 16:23:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o5t6WEXa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PuQ6B3iD"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DC412877C3;
	Mon, 17 Nov 2025 16:23:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763396616; cv=none; b=UWnj9USXNSdg1WzbYpHZCpeI3l5NutFUKsRrvMN/4yfwob0MKFxVaUkTv3AyLUPhVR/xmPJzW/b5ESdepYg6UksPjsychTuvVjexmXd/Q5qATn1YXP02c4CNZL1mGP1DkV2yaXPjGPy1Tv48C1QhYgxnu8VElzunE+MIhv5X7kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763396616; c=relaxed/simple;
	bh=PQDTH4m4aGJ18hz/QuoRKhi/QK4nxfDHJh/JE9IWmcI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=U6ru1AwtOIz9VOZhbSyOkIqvPHKD+RjlIx7sRZuPINhhgZ6wl6YLABEd0C1Q3C8QetECl4Rqs2d97m5wqlWTSo28pyfrmZWdnOsAcUe5k7/cHjCxwnMo/ofoYeNpQVwhEY9hf+BK3SEDi2aJXUxPiO+IM7zOAHvMPirnNnGbd+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o5t6WEXa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PuQ6B3iD; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Nov 2025 16:23:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763396612;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SjtnopNx/4GYbcbWP2qjcX11lPQSmjt4vXGZGgAnzz8=;
	b=o5t6WEXaZSyBhjG9FW0qr5yKcv9OUP1D09Mzjdjx9qE2FJU9Ut7EYNiOhLi7CvXhFe0wHr
	t74emvTQwbDIkHQRLSJtWppR+39b8ps+0uAVEKafQ05yc9s67pEa8ezXYWdiVODPUK7lgm
	5pcIGJ9rB/535nxGsnv+B7whKiOev5ROWDm2kRqp0kNDPioprzGC0cghSUKNSQYDr44Fe6
	hceEhZ1/xaW9I5VYyX5X6jMnx+omqmzGN99FTBsHnqqXHlNUypZKs9DvwsHbiOEE08mPov
	HGkTs9LR3RP4y1+0CdBUThMEd4xyS7Hw8zq8p53gXp3lqaReEBHDhzLqbqGy+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763396612;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SjtnopNx/4GYbcbWP2qjcX11lPQSmjt4vXGZGgAnzz8=;
	b=PuQ6B3iD57o9GRlGzvEVuHkf2UirsVDZ0uVdzSttQGoMYmt3Zb2WhayghbGHlsDOu+Y+8J
	OPDXDZ9JFNGQHYBA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Proportional newidle balance
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Chris Mason <clm@meta.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251107161739.770122091@infradead.org>
References: <20251107161739.770122091@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176339660779.498.15939066971255345770.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     33cf66d88306663d16e4759e9d24766b0aaa2e17
Gitweb:        https://git.kernel.org/tip/33cf66d88306663d16e4759e9d24766b0aa=
a2e17
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 07 Nov 2025 17:01:31 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Nov 2025 17:13:16 +01:00

sched/fair: Proportional newidle balance

Add a randomized algorithm that runs newidle balancing proportional to
its success rate.

This improves schbench significantly:

 6.18-rc4:			2.22 Mrps/s
 6.18-rc4+revert:		2.04 Mrps/s
 6.18-rc4+revert+random:	2.18 Mrps/S

Conversely, per Adam Li this affects SpecJBB slightly, reducing it by 1%:

 6.17:			-6%
 6.17+revert:		 0%
 6.17+revert+random:	-1%

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Chris Mason <clm@meta.com>
Link: https://lkml.kernel.org/r/6825c50d-7fa7-45d8-9b81-c6e7e25738e2@meta.com
Link: https://patch.msgid.link/20251107161739.770122091@infradead.org
---
 include/linux/sched/topology.h |  3 ++-
 kernel/sched/core.c            |  3 ++-
 kernel/sched/fair.c            | 44 ++++++++++++++++++++++++++++++---
 kernel/sched/features.h        |  5 ++++-
 kernel/sched/sched.h           |  7 +++++-
 kernel/sched/topology.c        |  6 +++++-
 6 files changed, 64 insertions(+), 4 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index bbcfdf1..45c0022 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -92,6 +92,9 @@ struct sched_domain {
 	unsigned int nr_balance_failed; /* initialise to 0 */
=20
 	/* idle_balance() stats */
+	unsigned int newidle_call;
+	unsigned int newidle_success;
+	unsigned int newidle_ratio;
 	u64 max_newidle_lb_cost;
 	unsigned long last_decay_max_lb_cost;
=20
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 699db3f..9f10cfb 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -121,6 +121,7 @@ EXPORT_TRACEPOINT_SYMBOL_GPL(sched_update_nr_running_tp);
 EXPORT_TRACEPOINT_SYMBOL_GPL(sched_compute_energy_tp);
=20
 DEFINE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
+DEFINE_PER_CPU(struct rnd_state, sched_rnd_state);
=20
 #ifdef CONFIG_SCHED_PROXY_EXEC
 DEFINE_STATIC_KEY_TRUE(__sched_proxy_exec);
@@ -8489,6 +8490,8 @@ void __init sched_init_smp(void)
 {
 	sched_init_numa(NUMA_NO_NODE);
=20
+	prandom_init_once(&sched_rnd_state);
+
 	/*
 	 * There's no userspace yet to cause hotplug operations; hence all the
 	 * CPU masks are stable and all blatant races in the below code cannot
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index abcbb67..1855975 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12224,11 +12224,27 @@ void update_max_interval(void)
 	max_load_balance_interval =3D HZ*num_online_cpus()/10;
 }
=20
-static inline bool update_newidle_cost(struct sched_domain *sd, u64 cost)
+static inline void update_newidle_stats(struct sched_domain *sd, unsigned in=
t success)
+{
+	sd->newidle_call++;
+	sd->newidle_success +=3D success;
+
+	if (sd->newidle_call >=3D 1024) {
+		sd->newidle_ratio =3D sd->newidle_success;
+		sd->newidle_call /=3D 2;
+		sd->newidle_success /=3D 2;
+	}
+}
+
+static inline bool
+update_newidle_cost(struct sched_domain *sd, u64 cost, unsigned int success)
 {
 	unsigned long next_decay =3D sd->last_decay_max_lb_cost + HZ;
 	unsigned long now =3D jiffies;
=20
+	if (cost)
+		update_newidle_stats(sd, success);
+
 	if (cost > sd->max_newidle_lb_cost) {
 		/*
 		 * Track max cost of a domain to make sure to not delay the
@@ -12276,7 +12292,7 @@ static void sched_balance_domains(struct rq *rq, enum=
 cpu_idle_type idle)
 		 * Decay the newidle max times here because this is a regular
 		 * visit to all the domains.
 		 */
-		need_decay =3D update_newidle_cost(sd, 0);
+		need_decay =3D update_newidle_cost(sd, 0, 0);
 		max_cost +=3D sd->max_newidle_lb_cost;
=20
 		/*
@@ -12912,6 +12928,22 @@ static int sched_balance_newidle(struct rq *this_rq,=
 struct rq_flags *rf)
 			break;
=20
 		if (sd->flags & SD_BALANCE_NEWIDLE) {
+			unsigned int weight =3D 1;
+
+			if (sched_feat(NI_RANDOM)) {
+				/*
+				 * Throw a 1k sided dice; and only run
+				 * newidle_balance according to the success
+				 * rate.
+				 */
+				u32 d1k =3D sched_rng() % 1024;
+				weight =3D 1 + sd->newidle_ratio;
+				if (d1k > weight) {
+					update_newidle_stats(sd, 0);
+					continue;
+				}
+				weight =3D (1024 + weight/2) / weight;
+			}
=20
 			pulled_task =3D sched_balance_rq(this_cpu, this_rq,
 						   sd, CPU_NEWLY_IDLE,
@@ -12919,10 +12951,14 @@ static int sched_balance_newidle(struct rq *this_rq=
, struct rq_flags *rf)
=20
 			t1 =3D sched_clock_cpu(this_cpu);
 			domain_cost =3D t1 - t0;
-			update_newidle_cost(sd, domain_cost);
-
 			curr_cost +=3D domain_cost;
 			t0 =3D t1;
+
+			/*
+			 * Track max cost of a domain to make sure to not delay the
+			 * next wakeup on the CPU.
+			 */
+			update_newidle_cost(sd, domain_cost, weight * !!pulled_task);
 		}
=20
 		/*
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 0607def..980d92b 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -121,3 +121,8 @@ SCHED_FEAT(WA_BIAS, true)
 SCHED_FEAT(UTIL_EST, true)
=20
 SCHED_FEAT(LATENCY_WARN, false)
+
+/*
+ * Do newidle balancing proportional to its success rate using randomization.
+ */
+SCHED_FEAT(NI_RANDOM, true)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index def9ab7..b419a4d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -5,6 +5,7 @@
 #ifndef _KERNEL_SCHED_SCHED_H
 #define _KERNEL_SCHED_SCHED_H
=20
+#include <linux/prandom.h>
 #include <linux/sched/affinity.h>
 #include <linux/sched/autogroup.h>
 #include <linux/sched/cpufreq.h>
@@ -1348,6 +1349,12 @@ static inline bool is_migration_disabled(struct task_s=
truct *p)
 }
=20
 DECLARE_PER_CPU_SHARED_ALIGNED(struct rq, runqueues);
+DECLARE_PER_CPU(struct rnd_state, sched_rnd_state);
+
+static inline u32 sched_rng(void)
+{
+	return prandom_u32_state(this_cpu_ptr(&sched_rnd_state));
+}
=20
 #define cpu_rq(cpu)		(&per_cpu(runqueues, (cpu)))
 #define this_rq()		this_cpu_ptr(&runqueues)
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 711076a..cf643a5 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1669,6 +1669,12 @@ sd_init(struct sched_domain_topology_level *tl,
=20
 		.last_balance		=3D jiffies,
 		.balance_interval	=3D sd_weight,
+
+		/* 50% success rate */
+		.newidle_call		=3D 512,
+		.newidle_success	=3D 256,
+		.newidle_ratio		=3D 512,
+
 		.max_newidle_lb_cost	=3D 0,
 		.last_decay_max_lb_cost	=3D jiffies,
 		.child			=3D child,

