Return-Path: <linux-tip-commits+bounces-7659-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 227C8CBB774
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 08:47:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 3E55E3001635
	for <lists+linux-tip-commits@lfdr.de>; Sun, 14 Dec 2025 07:47:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79E432D3EF5;
	Sun, 14 Dec 2025 07:46:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KgDAUSU6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZIq10KbK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D712C11C9;
	Sun, 14 Dec 2025 07:46:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765698411; cv=none; b=JTvZVn+Ykj1D1DOQ5Cbe0xXsG5lmBJmD/oEtZmFXhle0B1bjprXA+mSXyLziNmVUkhMSP6BUGqSQu1Lma5ZMhiGAmo3VtyPfLNh4PyTN1yI8HqOdlEIdt1zIUdY06ntJi9d4/NiOSeMe8A9DjaGRAgUTnYUke0LrlgEU8TT2sac=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765698411; c=relaxed/simple;
	bh=BH+p9Fgj+ndbqOfuJg8SVHwyUWtzlF+QQ4Slr26wVqI=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=XhwsGj1cQ3pDydaEvpmj0XmNOcnyrZjDBZj+PAnj12qY2iv61r6lR7/o114S5T8J2PJ6yocQXPWy5EJOZhnQC8vuDurWXgu7C3M3GnbyBnnocAXfawU62T6vz1cUQxaEhExADS6TMfPX2yu9fwFEJYtCmnVHbdgiByc7gGEzUqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KgDAUSU6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZIq10KbK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 14 Dec 2025 07:46:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765698406;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=jqXMaI9MYS6wyUYJ+1rE3/dKK0ouFpwnm/yvRM2RAYo=;
	b=KgDAUSU6PFRE4bO7T/nE/FM/g0F6jDCqrUe21ePv9+tpstq1od4Hf5FqnJMVJr5j8j3Aca
	v4EIHSoXYIoUZhXYQbvKuQOxHA+QlEMk0yfgQFMekdrcatrWPKToNAYv+gzytnW7ipjGzw
	kz6/VbmDFO9aLaCqD1OFUDRBf+LOhsGBDqtI4bu6DsXrTbjYeuOsNJkZH80371ELPrwCRo
	4esouwrxIyMTW+ZzD49ZXRL26ABU5X6TTE0ji3+53lhuhakdEEnyYjb0L+JcFAxKG2tE8J
	uTo6RXRb4+RSs9h/4cuWaht81aavn1IrLwYdDLer/AKWBz4HSmhZKaXWR23xrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765698406;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=jqXMaI9MYS6wyUYJ+1rE3/dKK0ouFpwnm/yvRM2RAYo=;
	b=ZIq10KbKdXIehFq+wcDM9uWAFBp54u72ddTWH5n48Nmc/wmUwY9UVGQJCiklLeO1Zr1tep
	4RWJ/w4PWf7G4RAg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Switch to rcu_dereference_all()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176569840557.498.8233784383843712447.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     71fedc41c23b0010c578e6e224694ca15c19cf7d
Gitweb:        https://git.kernel.org/tip/71fedc41c23b0010c578e6e224694ca15c1=
9cf7d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 28 Nov 2025 13:32:21 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 14 Dec 2025 08:25:02 +01:00

sched/fair: Switch to rcu_dereference_all()

With the {rcu,sched,bh} RCU flavours being unified, it doesn't really
make sense to check for just the rcu one. Switch to the _all family of
verification which includes all 3 of the listed flavours.

Notably, this will enable us to remove some superfluous
rcu_read_lock() regions when we know they are inside preempt/IRQ
disabled regions.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 kernel/sched/fair.c  | 48 +++++++++++++++++++++----------------------
 kernel/sched/sched.h |  2 +-
 2 files changed, 25 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 74a0550..44a359d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1513,7 +1513,7 @@ static unsigned int task_scan_start(struct task_struct =
*p)
=20
 	/* Scale the maximum scan period with the amount of shared memory. */
 	rcu_read_lock();
-	ng =3D rcu_dereference(p->numa_group);
+	ng =3D rcu_dereference_all(p->numa_group);
 	if (ng) {
 		unsigned long shared =3D group_faults_shared(ng);
 		unsigned long private =3D group_faults_priv(ng);
@@ -1580,7 +1580,7 @@ pid_t task_numa_group_id(struct task_struct *p)
 	pid_t gid =3D 0;
=20
 	rcu_read_lock();
-	ng =3D rcu_dereference(p->numa_group);
+	ng =3D rcu_dereference_all(p->numa_group);
 	if (ng)
 		gid =3D ng->gid;
 	rcu_read_unlock();
@@ -2239,7 +2239,7 @@ static bool task_numa_compare(struct task_numa_env *env,
 		return false;
=20
 	rcu_read_lock();
-	cur =3D rcu_dereference(dst_rq->curr);
+	cur =3D rcu_dereference_all(dst_rq->curr);
 	if (cur && ((cur->flags & (PF_EXITING | PF_KTHREAD)) ||
 		    !cur->mm))
 		cur =3D NULL;
@@ -2284,7 +2284,7 @@ static bool task_numa_compare(struct task_numa_env *env,
 	 * If dst and source tasks are in the same NUMA group, or not
 	 * in any group then look only at task weights.
 	 */
-	cur_ng =3D rcu_dereference(cur->numa_group);
+	cur_ng =3D rcu_dereference_all(cur->numa_group);
 	if (cur_ng =3D=3D p_ng) {
 		/*
 		 * Do not swap within a group or between tasks that have
@@ -2499,7 +2499,7 @@ static int task_numa_migrate(struct task_struct *p)
 	 * to satisfy here.
 	 */
 	rcu_read_lock();
-	sd =3D rcu_dereference(per_cpu(sd_numa, env.src_cpu));
+	sd =3D rcu_dereference_all(per_cpu(sd_numa, env.src_cpu));
 	if (sd) {
 		env.imbalance_pct =3D 100 + (sd->imbalance_pct - 100) / 2;
 		env.imb_numa_nr =3D sd->imb_numa_nr;
@@ -3022,7 +3022,7 @@ static void task_numa_group(struct task_struct *p, int =
cpupid, int flags,
 	if (!cpupid_match_pid(tsk, cpupid))
 		goto no_join;
=20
-	grp =3D rcu_dereference(tsk->numa_group);
+	grp =3D rcu_dereference_all(tsk->numa_group);
 	if (!grp)
 		goto no_join;
=20
@@ -4435,7 +4435,7 @@ static inline void migrate_se_pelt_lag(struct sched_ent=
ity *se)
 	rq =3D rq_of(cfs_rq);
=20
 	rcu_read_lock();
-	is_idle =3D is_idle_task(rcu_dereference(rq->curr));
+	is_idle =3D is_idle_task(rcu_dereference_all(rq->curr));
 	rcu_read_unlock();
=20
 	/*
@@ -7462,7 +7462,7 @@ static inline void set_idle_cores(int cpu, int val)
 {
 	struct sched_domain_shared *sds;
=20
-	sds =3D rcu_dereference(per_cpu(sd_llc_shared, cpu));
+	sds =3D rcu_dereference_all(per_cpu(sd_llc_shared, cpu));
 	if (sds)
 		WRITE_ONCE(sds->has_idle_cores, val);
 }
@@ -7471,7 +7471,7 @@ static inline bool test_idle_cores(int cpu)
 {
 	struct sched_domain_shared *sds;
=20
-	sds =3D rcu_dereference(per_cpu(sd_llc_shared, cpu));
+	sds =3D rcu_dereference_all(per_cpu(sd_llc_shared, cpu));
 	if (sds)
 		return READ_ONCE(sds->has_idle_cores);
=20
@@ -7600,7 +7600,7 @@ static int select_idle_cpu(struct task_struct *p, struc=
t sched_domain *sd, bool=20
 	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
=20
 	if (sched_feat(SIS_UTIL)) {
-		sd_share =3D rcu_dereference(per_cpu(sd_llc_shared, target));
+		sd_share =3D rcu_dereference_all(per_cpu(sd_llc_shared, target));
 		if (sd_share) {
 			/* because !--nr is the condition to stop scan */
 			nr =3D READ_ONCE(sd_share->nr_idle_scan) + 1;
@@ -7806,7 +7806,7 @@ static int select_idle_sibling(struct task_struct *p, i=
nt prev, int target)
 	 * sd_asym_cpucapacity rather than sd_llc.
 	 */
 	if (sched_asym_cpucap_active()) {
-		sd =3D rcu_dereference(per_cpu(sd_asym_cpucapacity, target));
+		sd =3D rcu_dereference_all(per_cpu(sd_asym_cpucapacity, target));
 		/*
 		 * On an asymmetric CPU capacity system where an exclusive
 		 * cpuset defines a symmetric island (i.e. one unique
@@ -7821,7 +7821,7 @@ static int select_idle_sibling(struct task_struct *p, i=
nt prev, int target)
 		}
 	}
=20
-	sd =3D rcu_dereference(per_cpu(sd_llc, target));
+	sd =3D rcu_dereference_all(per_cpu(sd_llc, target));
 	if (!sd)
 		return target;
=20
@@ -8290,7 +8290,7 @@ static int find_energy_efficient_cpu(struct task_struct=
 *p, int prev_cpu)
 	struct energy_env eenv;
=20
 	rcu_read_lock();
-	pd =3D rcu_dereference(rd->pd);
+	pd =3D rcu_dereference_all(rd->pd);
 	if (!pd)
 		goto unlock;
=20
@@ -8298,7 +8298,7 @@ static int find_energy_efficient_cpu(struct task_struct=
 *p, int prev_cpu)
 	 * Energy-aware wake-up happens on the lowest sched_domain starting
 	 * from sd_asym_cpucapacity spanning over this_cpu and prev_cpu.
 	 */
-	sd =3D rcu_dereference(*this_cpu_ptr(&sd_asym_cpucapacity));
+	sd =3D rcu_dereference_all(*this_cpu_ptr(&sd_asym_cpucapacity));
 	while (sd && !cpumask_test_cpu(prev_cpu, sched_domain_span(sd)))
 		sd =3D sd->parent;
 	if (!sd)
@@ -9305,7 +9305,7 @@ static int task_hot(struct task_struct *p, struct lb_en=
v *env)
  */
 static long migrate_degrades_locality(struct task_struct *p, struct lb_env *=
env)
 {
-	struct numa_group *numa_group =3D rcu_dereference(p->numa_group);
+	struct numa_group *numa_group =3D rcu_dereference_all(p->numa_group);
 	unsigned long src_weight, dst_weight;
 	int src_nid, dst_nid, dist;
=20
@@ -10985,7 +10985,7 @@ static void update_idle_cpu_scan(struct lb_env *env,
 	if (env->sd->span_weight !=3D llc_weight)
 		return;
=20
-	sd_share =3D rcu_dereference(per_cpu(sd_llc_shared, env->dst_cpu));
+	sd_share =3D rcu_dereference_all(per_cpu(sd_llc_shared, env->dst_cpu));
 	if (!sd_share)
 		return;
=20
@@ -11335,7 +11335,7 @@ static struct sched_group *sched_balance_find_src_gro=
up(struct lb_env *env)
 		goto force_balance;
=20
 	if (!is_rd_overutilized(env->dst_rq->rd) &&
-	    rcu_dereference(env->dst_rq->rd->pd))
+	    rcu_dereference_all(env->dst_rq->rd->pd))
 		goto out_balanced;
=20
 	/* ASYM feature bypasses nice load balance check */
@@ -12424,7 +12424,7 @@ static void nohz_balancer_kick(struct rq *rq)
=20
 	rcu_read_lock();
=20
-	sd =3D rcu_dereference(rq->sd);
+	sd =3D rcu_dereference_all(rq->sd);
 	if (sd) {
 		/*
 		 * If there's a runnable CFS task and the current CPU has reduced
@@ -12436,7 +12436,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		}
 	}
=20
-	sd =3D rcu_dereference(per_cpu(sd_asym_packing, cpu));
+	sd =3D rcu_dereference_all(per_cpu(sd_asym_packing, cpu));
 	if (sd) {
 		/*
 		 * When ASYM_PACKING; see if there's a more preferred CPU
@@ -12454,7 +12454,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		}
 	}
=20
-	sd =3D rcu_dereference(per_cpu(sd_asym_cpucapacity, cpu));
+	sd =3D rcu_dereference_all(per_cpu(sd_asym_cpucapacity, cpu));
 	if (sd) {
 		/*
 		 * When ASYM_CPUCAPACITY; see if there's a higher capacity CPU
@@ -12475,7 +12475,7 @@ static void nohz_balancer_kick(struct rq *rq)
 		goto unlock;
 	}
=20
-	sds =3D rcu_dereference(per_cpu(sd_llc_shared, cpu));
+	sds =3D rcu_dereference_all(per_cpu(sd_llc_shared, cpu));
 	if (sds) {
 		/*
 		 * If there is an imbalance between LLC domains (IOW we could
@@ -12507,7 +12507,7 @@ static void set_cpu_sd_state_busy(int cpu)
 	struct sched_domain *sd;
=20
 	rcu_read_lock();
-	sd =3D rcu_dereference(per_cpu(sd_llc, cpu));
+	sd =3D rcu_dereference_all(per_cpu(sd_llc, cpu));
=20
 	if (!sd || !sd->nohz_idle)
 		goto unlock;
@@ -12537,7 +12537,7 @@ static void set_cpu_sd_state_idle(int cpu)
 	struct sched_domain *sd;
=20
 	rcu_read_lock();
-	sd =3D rcu_dereference(per_cpu(sd_llc, cpu));
+	sd =3D rcu_dereference_all(per_cpu(sd_llc, cpu));
=20
 	if (!sd || sd->nohz_idle)
 		goto unlock;
@@ -13915,7 +13915,7 @@ void show_numa_stats(struct task_struct *p, struct se=
q_file *m)
 	struct numa_group *ng;
=20
 	rcu_read_lock();
-	ng =3D rcu_dereference(p->numa_group);
+	ng =3D rcu_dereference_all(p->numa_group);
 	for_each_online_node(node) {
 		if (p->numa_faults) {
 			tsf =3D p->numa_faults[task_faults_idx(NUMA_MEM, node, 0)];
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 2c0a4ea..67cff7d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2011,7 +2011,7 @@ queue_balance_callback(struct rq *rq,
 }
=20
 #define rcu_dereference_sched_domain(p) \
-	rcu_dereference_check((p), lockdep_is_held(&sched_domains_mutex))
+	rcu_dereference_all_check((p), lockdep_is_held(&sched_domains_mutex))
=20
 /*
  * The domain tree (rq->sd) is protected by RCU's quiescent state transition.

