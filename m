Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB7C03B83A8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbhF3Nu2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235497AbhF3NuF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B71C06124C;
        Wed, 30 Jun 2021 06:47:35 -0700 (PDT)
Date:   Wed, 30 Jun 2021 13:47:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060854;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Fc+IK9aSdZmE3eD+1az5ivtI40sGa+/BzSoAUk3+eBw=;
        b=jDFIncR93Hu8Q1sayDIof9skh/2ZPR0INZRyhZCEHrC4XVNeZpJjM+cDn6oKnWFFC9J04r
        OM5yhSDTSwa9oJZDoVtsEsa3/o1Vf5J3ZxvwS+EvX5sxre360lvYP790jjkN2gr/RqfPPQ
        YsmUdzy6APH/DmTPq9mbvPF65kgR9mdRs6pq8aByB9JYPV3eUfuwasoGh+QDKu36AmwnRa
        +Ea+SnGsRH7PuIVvdDkX+Vrq5TOuWWLyRfAmonTWQUXN88UKcxUTFrVs2bkqfPW4U67gt/
        8x/6aEWaMAnyTap0yuXyDcBzxk9Lf4no6VpPh2GLO+Kzxi1SGFEocYscrrfYVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060854;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Fc+IK9aSdZmE3eD+1az5ivtI40sGa+/BzSoAUk3+eBw=;
        b=FtClR+1JA9GKCtEGkuIbH6YJbH9HHJMa/ZHD9scet9Wu5+I1YwQShPzbLxhPYTRDXvEdML
        hkZtDImBi/QkkeCg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Make RCU priority boosting work on single-CPU
 rcu_node structures
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Scott Wood <swood@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506085383.395.9442745506355183408.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     3ef5a1c3821ab61da3e9fe0f4561be903ae2bc84
Gitweb:        https://git.kernel.org/tip/3ef5a1c3821ab61da3e9fe0f4561be903ae2bc84
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 05 Apr 2021 20:42:09 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:22:54 -07:00

rcu: Make RCU priority boosting work on single-CPU rcu_node structures

When any CPU comes online, it checks to see if an RCU-boost kthread has
already been created for that CPU's leaf rcu_node structure, and if
not, it creates one.  Unfortunately, it also verifies that this leaf
rcu_node structure actually has at least one online CPU, and if not,
it declines to create the kthread.  Although this behavior makes sense
during early boot, especially on systems that claim far more CPUs than
they actually have, it makes no sense for the first CPU to come online
for a given rcu_node structure.  There is no point in checking because
we know there is a CPU on its way in.

The problem is that timing differences can cause this incoming CPU to not
yet be reflected in the various bit masks even at rcutree_online_cpu()
time, and there is no chance at rcutree_prepare_cpu() time.  Plus it
would be better to create the RCU-boost kthread at rcutree_prepare_cpu()
to handle the case where the CPU is involved in an RCU priority inversion
very shortly after it comes online.

This commit therefore moves the checking to rcu_prepare_kthreads(), which
is called only at early boot, when the check is appropriate.  In addition,
it makes rcutree_prepare_cpu() invoke rcu_spawn_one_boost_kthread(), which
no longer does any checking for online CPUs.

With this change, RCU priority boosting tests now pass for short rcutorture
runs, even with single-CPU leaf rcu_node structures.

Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Scott Wood <swood@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c        |  2 +-
 kernel/rcu/tree.h        |  2 +-
 kernel/rcu/tree_plugin.h | 29 +++++++----------------------
 3 files changed, 9 insertions(+), 24 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 2532e58..00a3ebc 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -4166,7 +4166,7 @@ int rcutree_prepare_cpu(unsigned int cpu)
 	rdp->rcu_iw_gp_seq = rdp->gp_seq - 1;
 	trace_rcu_grace_period(rcu_state.name, rdp->gp_seq, TPS("cpuonl"));
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
-	rcu_prepare_kthreads(cpu);
+	rcu_spawn_one_boost_kthread(rnp);
 	rcu_spawn_cpu_nocb_kthread(cpu);
 	WRITE_ONCE(rcu_state.n_online_cpus, rcu_state.n_online_cpus + 1);
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 5fd0c44..b5508f4 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -418,8 +418,8 @@ static void rcu_initiate_boost(struct rcu_node *rnp, unsigned long flags);
 static void rcu_preempt_boost_start_gp(struct rcu_node *rnp);
 static bool rcu_is_callbacks_kthread(void);
 static void rcu_cpu_kthread_setup(unsigned int cpu);
+static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp);
 static void __init rcu_spawn_boost_kthreads(void);
-static void rcu_prepare_kthreads(int cpu);
 static void rcu_cleanup_after_idle(void);
 static void rcu_prepare_for_idle(void);
 static bool rcu_preempt_has_tasks(struct rcu_node *rnp);
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index ef004cc..3c90dad 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1198,22 +1198,16 @@ static void rcu_preempt_boost_start_gp(struct rcu_node *rnp)
  */
 static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 {
-	int rnp_index = rnp - rcu_get_root();
 	unsigned long flags;
+	int rnp_index = rnp - rcu_get_root();
 	struct sched_param sp;
 	struct task_struct *t;
 
-	if (!IS_ENABLED(CONFIG_PREEMPT_RCU))
-		return;
-
-	if (!rcu_scheduler_fully_active || rcu_rnp_online_cpus(rnp) == 0)
+	if (rnp->boost_kthread_task || !rcu_scheduler_fully_active)
 		return;
 
 	rcu_state.boost = 1;
 
-	if (rnp->boost_kthread_task != NULL)
-		return;
-
 	t = kthread_create(rcu_boost_kthread, (void *)rnp,
 			   "rcub/%d", rnp_index);
 	if (WARN_ON_ONCE(IS_ERR(t)))
@@ -1265,17 +1259,8 @@ static void __init rcu_spawn_boost_kthreads(void)
 	struct rcu_node *rnp;
 
 	rcu_for_each_leaf_node(rnp)
-		rcu_spawn_one_boost_kthread(rnp);
-}
-
-static void rcu_prepare_kthreads(int cpu)
-{
-	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
-	struct rcu_node *rnp = rdp->mynode;
-
-	/* Fire up the incoming CPU's kthread and leaf rcu_node kthread. */
-	if (rcu_scheduler_fully_active)
-		rcu_spawn_one_boost_kthread(rnp);
+		if (rcu_rnp_online_cpus(rnp))
+			rcu_spawn_one_boost_kthread(rnp);
 }
 
 #else /* #ifdef CONFIG_RCU_BOOST */
@@ -1295,15 +1280,15 @@ static void rcu_preempt_boost_start_gp(struct rcu_node *rnp)
 {
 }
 
-static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
+static void rcu_spawn_one_boost_kthread(struct rcu_node *rnp)
 {
 }
 
-static void __init rcu_spawn_boost_kthreads(void)
+static void rcu_boost_kthread_setaffinity(struct rcu_node *rnp, int outgoingcpu)
 {
 }
 
-static void rcu_prepare_kthreads(int cpu)
+static void __init rcu_spawn_boost_kthreads(void)
 {
 }
 
