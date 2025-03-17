Return-Path: <linux-tip-commits+bounces-4258-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A8312A64A74
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A121C3B9C58
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:36:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F46423C368;
	Mon, 17 Mar 2025 10:34:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="084Yy5gJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cNV6O1mm"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76B472356BB;
	Mon, 17 Mar 2025 10:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207684; cv=none; b=Y7lz1dtT4fyCtc9Qc0Hy1/Gmq1w1rqZBn3rLHtidnsMk0JHrjZQiaU7YlCLCCJBggtH0yFSFPD0P3LBHBYO2c4oY5Gey8vXHolOm3Y6q9kRCoqo4spCxsW9PSSjXRgxXFxdW0HuBWoDf8dM20HOdvs0xIkdf7AS9sKakhJlezYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207684; c=relaxed/simple;
	bh=Cev9OfzUAj6cmrkDr2Q1RGIg+oj96Xq4IattTQLzzlA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=fTKQKGQ/QreD0ukKyK6yjSO0tLm7B/QJCz+MUQ1Ka9j/LCqiTjMhln07qLs5DhIPYq96k5fBup//CITPVd0xKoyOMyGpcFl0Vhw/+85JznbscMY2r0dQiyuJ87fZTQal2XrfIMxX/mF7JIMKOr8jxQ8gdvzHV8G1wvCEwC9zd3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=084Yy5gJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cNV6O1mm; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:34:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742207681;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y/hWvNk8crhhIMMqS4ludsJRZZ1/Y1Pk15zNHaB/PAY=;
	b=084Yy5gJ1Ur6OFRY/OlZzX2Dqd5dy2tIvwGne4AY+ITe1seCk/1Rdhrx7mPfZpAwe9iedS
	siGoOOQOaqAIOINuEJWXdHdwYayNWWWcYTwf//JK1kbSOu4SaIz0Nwdw8tbgVRAfja7QsL
	yYGMjtme0uVVQw+d8XTVM7Rvby2DGwj5dt4hjtr8a1fWJZmQX7B+mCr4fKOAlQUK3hNOB+
	W8WlKUd4uLKSU3uYW34Pg0stoR/Zn/Jso9ha79vL/ISeF7NOUjQWXORhOZCsGnMPZIo93K
	C808N8DEvqlnU+ProFtYo8CeTePLlRMMmu6bnZm2gdd4Z4zUEt8cUBboJuX+1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742207681;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y/hWvNk8crhhIMMqS4ludsJRZZ1/Y1Pk15zNHaB/PAY=;
	b=cNV6O1mmOXOtTIycOuZsw8N7itpE/VO66pKiGjNIgQEkRBPsG5g4sK1BcSsGRgHHSV1uri
	B1c/YaCI6WbggDCg==
From: "tip-bot2 for Juri Lelli" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Rebuild root domain accounting
 after every update
Cc: Jon Hunter <jonathanh@nvidia.com>, Waiman Long <llong@redhat.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <Z9MRfeJKJUOyUSto@jlelli-thinkpadt14gen4.remote.csb>
References: <Z9MRfeJKJUOyUSto@jlelli-thinkpadt14gen4.remote.csb>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220768045.14745.13357785767528597536.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2ff899e3516437354204423ef0a94994717b8e6a
Gitweb:        https://git.kernel.org/tip/2ff899e3516437354204423ef0a94994717b8e6a
Author:        Juri Lelli <juri.lelli@redhat.com>
AuthorDate:    Thu, 13 Mar 2025 18:10:21 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:23:42 +01:00

sched/deadline: Rebuild root domain accounting after every update

Rebuilding of root domains accounting information (total_bw) is
currently broken on some cases, e.g. suspend/resume on aarch64. Problem
is that the way we keep track of domain changes and try to add bandwidth
back is convoluted and fragile.

Fix it by simplify things by making sure bandwidth accounting is cleared
and completely restored after root domains changes (after root domains
are again stable).

To be sure we always call dl_rebuild_rd_accounting while holding
cpuset_mutex we also add cpuset_reset_sched_domains() wrapper.

Fixes: 53916d5fd3c0 ("sched/deadline: Check bandwidth overflow earlier for hotplug")
Reported-by: Jon Hunter <jonathanh@nvidia.com>
Co-developed-by: Waiman Long <llong@redhat.com>
Signed-off-by: Waiman Long <llong@redhat.com>
Signed-off-by: Juri Lelli <juri.lelli@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lore.kernel.org/r/Z9MRfeJKJUOyUSto@jlelli-thinkpadt14gen4.remote.csb
---
 include/linux/cpuset.h         |  6 ++++++
 include/linux/sched/deadline.h |  1 +
 include/linux/sched/topology.h |  2 ++
 kernel/cgroup/cpuset.c         | 23 ++++++++++++++++-------
 kernel/sched/core.c            |  4 ++--
 kernel/sched/deadline.c        | 16 ++++++++++------
 kernel/sched/topology.c        |  1 +
 7 files changed, 38 insertions(+), 15 deletions(-)

diff --git a/include/linux/cpuset.h b/include/linux/cpuset.h
index 835e7b7..17cc90d 100644
--- a/include/linux/cpuset.h
+++ b/include/linux/cpuset.h
@@ -128,6 +128,7 @@ extern bool current_cpuset_is_being_rebound(void);
 extern void rebuild_sched_domains(void);
 
 extern void cpuset_print_current_mems_allowed(void);
+extern void cpuset_reset_sched_domains(void);
 
 /*
  * read_mems_allowed_begin is required when making decisions involving
@@ -264,6 +265,11 @@ static inline void rebuild_sched_domains(void)
 	partition_sched_domains(1, NULL, NULL);
 }
 
+static inline void cpuset_reset_sched_domains(void)
+{
+	partition_sched_domains(1, NULL, NULL);
+}
+
 static inline void cpuset_print_current_mems_allowed(void)
 {
 }
diff --git a/include/linux/sched/deadline.h b/include/linux/sched/deadline.h
index 6ec5786..f9aabbc 100644
--- a/include/linux/sched/deadline.h
+++ b/include/linux/sched/deadline.h
@@ -34,6 +34,7 @@ static inline bool dl_time_before(u64 a, u64 b)
 struct root_domain;
 extern void dl_add_task_root_domain(struct task_struct *p);
 extern void dl_clear_root_domain(struct root_domain *rd);
+extern void dl_clear_root_domain_cpu(int cpu);
 
 #endif /* CONFIG_SMP */
 
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 7f3dbaf..1622232 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -166,6 +166,8 @@ static inline struct cpumask *sched_domain_span(struct sched_domain *sd)
 	return to_cpumask(sd->span);
 }
 
+extern void dl_rebuild_rd_accounting(void);
+
 extern void partition_sched_domains_locked(int ndoms_new,
 					   cpumask_var_t doms_new[],
 					   struct sched_domain_attr *dattr_new);
diff --git a/kernel/cgroup/cpuset.c b/kernel/cgroup/cpuset.c
index f87526e..1892dc8 100644
--- a/kernel/cgroup/cpuset.c
+++ b/kernel/cgroup/cpuset.c
@@ -954,10 +954,12 @@ static void dl_update_tasks_root_domain(struct cpuset *cs)
 	css_task_iter_end(&it);
 }
 
-static void dl_rebuild_rd_accounting(void)
+void dl_rebuild_rd_accounting(void)
 {
 	struct cpuset *cs = NULL;
 	struct cgroup_subsys_state *pos_css;
+	int cpu;
+	u64 cookie = ++dl_cookie;
 
 	lockdep_assert_held(&cpuset_mutex);
 	lockdep_assert_cpus_held();
@@ -965,11 +967,12 @@ static void dl_rebuild_rd_accounting(void)
 
 	rcu_read_lock();
 
-	/*
-	 * Clear default root domain DL accounting, it will be computed again
-	 * if a task belongs to it.
-	 */
-	dl_clear_root_domain(&def_root_domain);
+	for_each_possible_cpu(cpu) {
+		if (dl_bw_visited(cpu, cookie))
+			continue;
+
+		dl_clear_root_domain_cpu(cpu);
+	}
 
 	cpuset_for_each_descendant_pre(cs, pos_css, &top_cpuset) {
 
@@ -996,7 +999,6 @@ partition_and_rebuild_sched_domains(int ndoms_new, cpumask_var_t doms_new[],
 {
 	sched_domains_mutex_lock();
 	partition_sched_domains_locked(ndoms_new, doms_new, dattr_new);
-	dl_rebuild_rd_accounting();
 	sched_domains_mutex_unlock();
 }
 
@@ -1083,6 +1085,13 @@ void rebuild_sched_domains(void)
 	cpus_read_unlock();
 }
 
+void cpuset_reset_sched_domains(void)
+{
+	mutex_lock(&cpuset_mutex);
+	partition_sched_domains(1, NULL, NULL);
+	mutex_unlock(&cpuset_mutex);
+}
+
 /**
  * cpuset_update_tasks_cpumask - Update the cpumasks of tasks in the cpuset.
  * @cs: the cpuset in which each task's cpus_allowed mask needs to be changed
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 84f6800..affa99f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8229,7 +8229,7 @@ static void cpuset_cpu_active(void)
 		 * operation in the resume sequence, just build a single sched
 		 * domain, ignoring cpusets.
 		 */
-		partition_sched_domains(1, NULL, NULL);
+		cpuset_reset_sched_domains();
 		if (--num_cpus_frozen)
 			return;
 		/*
@@ -8248,7 +8248,7 @@ static void cpuset_cpu_inactive(unsigned int cpu)
 		cpuset_update_active_cpus();
 	} else {
 		num_cpus_frozen++;
-		partition_sched_domains(1, NULL, NULL);
+		cpuset_reset_sched_domains();
 	}
 }
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 3e05032..5dca336 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -166,7 +166,7 @@ static inline unsigned long dl_bw_capacity(int i)
 	}
 }
 
-static inline bool dl_bw_visited(int cpu, u64 cookie)
+bool dl_bw_visited(int cpu, u64 cookie)
 {
 	struct root_domain *rd = cpu_rq(cpu)->rd;
 
@@ -207,7 +207,7 @@ static inline unsigned long dl_bw_capacity(int i)
 	return SCHED_CAPACITY_SCALE;
 }
 
-static inline bool dl_bw_visited(int cpu, u64 cookie)
+bool dl_bw_visited(int cpu, u64 cookie)
 {
 	return false;
 }
@@ -2981,18 +2981,22 @@ void dl_clear_root_domain(struct root_domain *rd)
 	rd->dl_bw.total_bw = 0;
 
 	/*
-	 * dl_server bandwidth is only restored when CPUs are attached to root
-	 * domains (after domains are created or CPUs moved back to the
-	 * default root doamin).
+	 * dl_servers are not tasks. Since dl_add_task_root_domain ignores
+	 * them, we need to account for them here explicitly.
 	 */
 	for_each_cpu(i, rd->span) {
 		struct sched_dl_entity *dl_se = &cpu_rq(i)->fair_server;
 
 		if (dl_server(dl_se) && cpu_active(i))
-			rd->dl_bw.total_bw += dl_se->dl_bw;
+			__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(i));
 	}
 }
 
+void dl_clear_root_domain_cpu(int cpu)
+{
+	dl_clear_root_domain(cpu_rq(cpu)->rd);
+}
+
 #endif /* CONFIG_SMP */
 
 static void switched_from_dl(struct rq *rq, struct task_struct *p)
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 4409333..363ad26 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2791,6 +2791,7 @@ match3:
 	ndoms_cur = ndoms_new;
 
 	update_sched_domain_debugfs();
+	dl_rebuild_rd_accounting();
 }
 
 /*

