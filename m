Return-Path: <linux-tip-commits+bounces-8195-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cJGWMNHagWlBLQMAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8195-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 03 Feb 2026 12:24:01 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 61776D8416
	for <lists+linux-tip-commits@lfdr.de>; Tue, 03 Feb 2026 12:24:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 51A6E313779C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Feb 2026 11:18:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B2F23376B8;
	Tue,  3 Feb 2026 11:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pSI6ULhz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="d5JfpvCo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 784F1333759;
	Tue,  3 Feb 2026 11:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770117529; cv=none; b=LkUh82c/YGq9BIkmp2xFuoqDfxooNyVizVkkDSkQ0j1qFfj/thgTT3OyeJnQNXfMucwkqTQ/B84w+OrW1JjVIgMO0crS2SUhyZFoQ0g+E3lXHfE6S3vlfjJbnhxT0FLkatkuJzwZa5Tl47p0j+Qlnipsn6H56i4AN9sw3QoJc/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770117529; c=relaxed/simple;
	bh=YRhc5XnEbXfZwpxKX22WXQrEFvqbcZXHCA7TeztGrIQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KMS4pJ0vlWURwgbDE9qKEiNQVz9+nwl/p/GsEBvH6A1clRl3xWVfzNs9XLpdipomP5HHpRL2SgGRWYwUZ8zfQPULEdbXfovneKk0VRbEubWs9Sd4cAYHvwLvQLDpkdvc+whse94NGtNvNyP4fjz/5enQul7PomgUvbyU8CqMyQU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=pSI6ULhz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=d5JfpvCo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Feb 2026 11:18:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770117522;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oISc+VaSK76tv3iIKU3X+LcCu0n0L5+v3e606Z0YX4Y=;
	b=pSI6ULhzd71mvbAH17wnuNRZA2KRTIZ7qTuaxMDJvn+fKc2K8ynzq/GpKSsNkUDpG+pVVm
	hcB/slSNrs9YwOZNS8Lc4RPQLBVSYwLxajuaFekt84deyYghCzl7nV2iAlDyT4qrh5UCD5
	DbWTXW+w5F8AqH5eEzIVDOkrY97bLfP4zVZsd05Z+F8H3pXqyJmVO3sg1OwCaVtRmPkNWe
	7WoPf/Gr2wGITreAynFoVtw82Orb+TyMeQhGWCmIPPNXc8/7boZ2f4iXueTRBzZrvgJ0i8
	7qR93IN41x7AksLYqJtg5UmcBILvQOq2ZGjN3e08oYL4CvHaShLrYWuPAOgy/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770117522;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oISc+VaSK76tv3iIKU3X+LcCu0n0L5+v3e606Z0YX4Y=;
	b=d5JfpvCoO84DR/5kAxCyvUPDnL3pMF4tJjQkSbF7zgZH2MV1hUO+wETJ/99fGz1oWk4P7p
	hWJ8/6vu8DAvkEAQ==
From: "tip-bot2 for Andrea Righi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched_ext: Add a DL server for sched_ext tasks
Cc: Joel Fernandes <joelagnelf@nvidia.com>, Andrea Righi <arighi@nvidia.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Juri Lelli <juri.lelli@redhat.com>,
 Christian Loehle <christian.loehle@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260126100050.3854740-5-arighi@nvidia.com>
References: <20260126100050.3854740-5-arighi@nvidia.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177011752163.2495410.10956925624042345468.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8195-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[arm.com:email,msgid.link:url,infradead.org:email,nvidia.com:email,linutronix.de:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:replyto]
X-Rspamd-Queue-Id: 61776D8416
X-Rspamd-Action: no action

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     cd959a3562050d1c676be37f1d256a96cb067868
Gitweb:        https://git.kernel.org/tip/cd959a3562050d1c676be37f1d256a96cb0=
67868
Author:        Andrea Righi <arighi@nvidia.com>
AuthorDate:    Mon, 26 Jan 2026 10:59:02 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 03 Feb 2026 12:04:17 +01:00

sched_ext: Add a DL server for sched_ext tasks

sched_ext currently suffers starvation due to RT. The same workload when
converted to EXT can get zero runtime if RT is 100% running, causing EXT
processes to stall. Fix it by adding a DL server for EXT.

A kselftest is also included later to confirm that both DL servers are
functioning correctly:

 # ./runner -t rt_stall
 =3D=3D=3D=3D=3D START =3D=3D=3D=3D=3D
 TEST: rt_stall
 DESCRIPTION: Verify that RT tasks cannot stall SCHED_EXT tasks
 OUTPUT:
 TAP version 13
 1..1
 # Runtime of FAIR task (PID 1511) is 0.250000 seconds
 # Runtime of RT task (PID 1512) is 4.750000 seconds
 # FAIR task got 5.00% of total runtime
 ok 1 PASS: FAIR task got more than 4.00% of runtime
 TAP version 13
 1..1
 # Runtime of EXT task (PID 1514) is 0.250000 seconds
 # Runtime of RT task (PID 1515) is 4.750000 seconds
 # EXT task got 5.00% of total runtime
 ok 2 PASS: EXT task got more than 4.00% of runtime
 TAP version 13
 1..1
 # Runtime of FAIR task (PID 1517) is 0.250000 seconds
 # Runtime of RT task (PID 1518) is 4.750000 seconds
 # FAIR task got 5.00% of total runtime
 ok 3 PASS: FAIR task got more than 4.00% of runtime
 TAP version 13
 1..1
 # Runtime of EXT task (PID 1521) is 0.250000 seconds
 # Runtime of RT task (PID 1522) is 4.750000 seconds
 # EXT task got 5.00% of total runtime
 ok 4 PASS: EXT task got more than 4.00% of runtime
 ok 1 rt_stall #
 =3D=3D=3D=3D=3D  END  =3D=3D=3D=3D=3D

Co-developed-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Joel Fernandes <joelagnelf@nvidia.com>
Signed-off-by: Andrea Righi <arighi@nvidia.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Tested-by: Christian Loehle <christian.loehle@arm.com>
Link: https://patch.msgid.link/20260126100050.3854740-5-arighi@nvidia.com
---
 kernel/sched/core.c     |  6 +++-
 kernel/sched/deadline.c | 83 ++++++++++++++++++++++++++++------------
 kernel/sched/ext.c      | 33 ++++++++++++++++-
 kernel/sched/idle.c     |  3 +-
 kernel/sched/sched.h    |  2 +-
 kernel/sched/topology.c |  5 ++-
 6 files changed, 109 insertions(+), 23 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 260633e..8f2dc0a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8484,6 +8484,9 @@ int sched_cpu_dying(unsigned int cpu)
 		dump_rq_tasks(rq, KERN_WARNING);
 	}
 	dl_server_stop(&rq->fair_server);
+#ifdef CONFIG_SCHED_CLASS_EXT
+	dl_server_stop(&rq->ext_server);
+#endif
 	rq_unlock_irqrestore(rq, &rf);
=20
 	calc_load_migrate(rq);
@@ -8689,6 +8692,9 @@ void __init sched_init(void)
 		hrtick_rq_init(rq);
 		atomic_set(&rq->nr_iowait, 0);
 		fair_server_init(rq);
+#ifdef CONFIG_SCHED_CLASS_EXT
+		ext_server_init(rq);
+#endif
=20
 #ifdef CONFIG_SCHED_CORE
 		rq->core =3D rq;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 7e181ec..eae14e5 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1449,8 +1449,8 @@ static void update_curr_dl_se(struct rq *rq, struct sch=
ed_dl_entity *dl_se, s64=20
 		dl_se->dl_defer_idle =3D 0;
=20
 	/*
-	 * The fair server can consume its runtime while throttled (not queued/
-	 * running as regular CFS).
+	 * The DL server can consume its runtime while throttled (not
+	 * queued / running as regular CFS).
 	 *
 	 * If the server consumes its entire runtime in this state. The server
 	 * is not required for the current period. Thus, reset the server by
@@ -1535,10 +1535,10 @@ throttle:
 	}
=20
 	/*
-	 * The fair server (sole dl_server) does not account for real-time
-	 * workload because it is running fair work.
+	 * The dl_server does not account for real-time workload because it
+	 * is running fair work.
 	 */
-	if (dl_se =3D=3D &rq->fair_server)
+	if (dl_se->dl_server)
 		return;
=20
 #ifdef CONFIG_RT_GROUP_SCHED
@@ -1573,9 +1573,9 @@ throttle:
  * In the non-defer mode, the idle time is not accounted, as the
  * server provides a guarantee.
  *
- * If the dl_server is in defer mode, the idle time is also considered
- * as time available for the fair server, avoiding a penalty for the
- * rt scheduler that did not consumed that time.
+ * If the dl_server is in defer mode, the idle time is also considered as
+ * time available for the dl_server, avoiding a penalty for the rt
+ * scheduler that did not consumed that time.
  */
 void dl_server_update_idle(struct sched_dl_entity *dl_se, s64 delta_exec)
 {
@@ -1860,6 +1860,18 @@ void sched_init_dl_servers(void)
 		dl_se->dl_server =3D 1;
 		dl_se->dl_defer =3D 1;
 		setup_new_dl_entity(dl_se);
+
+#ifdef CONFIG_SCHED_CLASS_EXT
+		dl_se =3D &rq->ext_server;
+
+		WARN_ON(dl_server(dl_se));
+
+		dl_server_apply_params(dl_se, runtime, period, 1);
+
+		dl_se->dl_server =3D 1;
+		dl_se->dl_defer =3D 1;
+		setup_new_dl_entity(dl_se);
+#endif
 	}
 }
=20
@@ -3198,6 +3210,36 @@ void dl_add_task_root_domain(struct task_struct *p)
 	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
 }
=20
+static void dl_server_add_bw(struct root_domain *rd, int cpu)
+{
+	struct sched_dl_entity *dl_se;
+
+	dl_se =3D &cpu_rq(cpu)->fair_server;
+	if (dl_server(dl_se) && cpu_active(cpu))
+		__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(cpu));
+
+#ifdef CONFIG_SCHED_CLASS_EXT
+	dl_se =3D &cpu_rq(cpu)->ext_server;
+	if (dl_server(dl_se) && cpu_active(cpu))
+		__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(cpu));
+#endif
+}
+
+static u64 dl_server_read_bw(int cpu)
+{
+	u64 dl_bw =3D 0;
+
+	if (cpu_rq(cpu)->fair_server.dl_server)
+		dl_bw +=3D cpu_rq(cpu)->fair_server.dl_bw;
+
+#ifdef CONFIG_SCHED_CLASS_EXT
+	if (cpu_rq(cpu)->ext_server.dl_server)
+		dl_bw +=3D cpu_rq(cpu)->ext_server.dl_bw;
+#endif
+
+	return dl_bw;
+}
+
 void dl_clear_root_domain(struct root_domain *rd)
 {
 	int i;
@@ -3216,12 +3258,8 @@ void dl_clear_root_domain(struct root_domain *rd)
 	 * dl_servers are not tasks. Since dl_add_task_root_domain ignores
 	 * them, we need to account for them here explicitly.
 	 */
-	for_each_cpu(i, rd->span) {
-		struct sched_dl_entity *dl_se =3D &cpu_rq(i)->fair_server;
-
-		if (dl_server(dl_se) && cpu_active(i))
-			__dl_add(&rd->dl_bw, dl_se->dl_bw, dl_bw_cpus(i));
-	}
+	for_each_cpu(i, rd->span)
+		dl_server_add_bw(rd, i);
 }
=20
 void dl_clear_root_domain_cpu(int cpu)
@@ -3720,7 +3758,7 @@ static int dl_bw_manage(enum dl_bw_request req, int cpu=
, u64 dl_bw)
 	unsigned long flags, cap;
 	struct dl_bw *dl_b;
 	bool overflow =3D 0;
-	u64 fair_server_bw =3D 0;
+	u64 dl_server_bw =3D 0;
=20
 	rcu_read_lock_sched();
 	dl_b =3D dl_bw_of(cpu);
@@ -3753,27 +3791,26 @@ static int dl_bw_manage(enum dl_bw_request req, int c=
pu, u64 dl_bw)
 		cap -=3D arch_scale_cpu_capacity(cpu);
=20
 		/*
-		 * cpu is going offline and NORMAL tasks will be moved away
-		 * from it. We can thus discount dl_server bandwidth
-		 * contribution as it won't need to be servicing tasks after
-		 * the cpu is off.
+		 * cpu is going offline and NORMAL and EXT tasks will be
+		 * moved away from it. We can thus discount dl_server
+		 * bandwidth contribution as it won't need to be servicing
+		 * tasks after the cpu is off.
 		 */
-		if (cpu_rq(cpu)->fair_server.dl_server)
-			fair_server_bw =3D cpu_rq(cpu)->fair_server.dl_bw;
+		dl_server_bw =3D dl_server_read_bw(cpu);
=20
 		/*
 		 * Not much to check if no DEADLINE bandwidth is present.
 		 * dl_servers we can discount, as tasks will be moved out the
 		 * offlined CPUs anyway.
 		 */
-		if (dl_b->total_bw - fair_server_bw > 0) {
+		if (dl_b->total_bw - dl_server_bw > 0) {
 			/*
 			 * Leaving at least one CPU for DEADLINE tasks seems a
 			 * wise thing to do. As said above, cpu is not offline
 			 * yet, so account for that.
 			 */
 			if (dl_bw_cpus(cpu) - 1)
-				overflow =3D __dl_overflow(dl_b, cap, fair_server_bw, 0);
+				overflow =3D __dl_overflow(dl_b, cap, dl_server_bw, 0);
 			else
 				overflow =3D 1;
 		}
diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index ce5e64b..3bc49dc 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -958,6 +958,8 @@ static void update_curr_scx(struct rq *rq)
 		if (!curr->scx.slice)
 			touch_core_sched(rq, curr);
 	}
+
+	dl_server_update(&rq->ext_server, delta_exec);
 }
=20
 static bool scx_dsq_priq_less(struct rb_node *node_a,
@@ -1501,6 +1503,10 @@ static void enqueue_task_scx(struct rq *rq, struct tas=
k_struct *p, int enq_flags
 	if (enq_flags & SCX_ENQ_WAKEUP)
 		touch_core_sched(rq, p);
=20
+	/* Start dl_server if this is the first task being enqueued */
+	if (rq->scx.nr_running =3D=3D 1)
+		dl_server_start(&rq->ext_server);
+
 	do_enqueue_task(rq, p, enq_flags, sticky_cpu);
 out:
 	rq->scx.flags &=3D ~SCX_RQ_IN_WAKEUP;
@@ -2512,6 +2518,33 @@ static struct task_struct *pick_task_scx(struct rq *rq=
, struct rq_flags *rf)
 	return do_pick_task_scx(rq, rf, false);
 }
=20
+/*
+ * Select the next task to run from the ext scheduling class.
+ *
+ * Use do_pick_task_scx() directly with @force_scx enabled, since the
+ * dl_server must always select a sched_ext task.
+ */
+static struct task_struct *
+ext_server_pick_task(struct sched_dl_entity *dl_se, struct rq_flags *rf)
+{
+	if (!scx_enabled())
+		return NULL;
+
+	return do_pick_task_scx(dl_se->rq, rf, true);
+}
+
+/*
+ * Initialize the ext server deadline entity.
+ */
+void ext_server_init(struct rq *rq)
+{
+	struct sched_dl_entity *dl_se =3D &rq->ext_server;
+
+	init_dl_entity(dl_se);
+
+	dl_server_init(dl_se, rq, ext_server_pick_task);
+}
+
 #ifdef CONFIG_SCHED_CORE
 /**
  * scx_prio_less - Task ordering for core-sched
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 46a9845..3681b6a 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -537,6 +537,9 @@ static void update_curr_idle(struct rq *rq)
 	se->exec_start =3D now;
=20
 	dl_server_update_idle(&rq->fair_server, delta_exec);
+#ifdef CONFIG_SCHED_CLASS_EXT
+	dl_server_update_idle(&rq->ext_server, delta_exec);
+#endif
 }
=20
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 309101c..2aa4251 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -414,6 +414,7 @@ extern void dl_server_init(struct sched_dl_entity *dl_se,=
 struct rq *rq,
 extern void sched_init_dl_servers(void);
=20
 extern void fair_server_init(struct rq *rq);
+extern void ext_server_init(struct rq *rq);
 extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq=
 *rq);
 extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
 		    u64 runtime, u64 period, bool init);
@@ -1171,6 +1172,7 @@ struct rq {
 	struct dl_rq		dl;
 #ifdef CONFIG_SCHED_CLASS_EXT
 	struct scx_rq		scx;
+	struct sched_dl_entity	ext_server;
 #endif
=20
 	struct sched_dl_entity	fair_server;
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index cf643a5..ac268da 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -508,6 +508,11 @@ void rq_attach_root(struct rq *rq, struct root_domain *r=
d)
 	if (rq->fair_server.dl_server)
 		__dl_server_attach_root(&rq->fair_server, rq);
=20
+#ifdef CONFIG_SCHED_CLASS_EXT
+	if (rq->ext_server.dl_server)
+		__dl_server_attach_root(&rq->ext_server, rq);
+#endif
+
 	rq_unlock_irqrestore(rq, &rf);
=20
 	if (old_rd)

