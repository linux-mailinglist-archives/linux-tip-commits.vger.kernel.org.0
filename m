Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB4E12D9009
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388168AbgLMTCV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:02:21 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46810 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730406AbgLMTCA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:02:00 -0500
Date:   Sun, 13 Dec 2020 19:01:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886073;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SpGOCqPELEMSZZUrTom+A0jDOUdevQy5xnd6ISi5q0I=;
        b=TBYtGrfYQ9QNmffya7dTSVhDQy/fjTEEpnqCxzjuhyXV4qgAkdYVB7G8mOjY9xQIS3+evn
        Z0Ch1mvu7Jnv70eo4EbWB0nnXtqEgZTUAijytus1MVYmGqs8aCEuOdVCCqj06ZTHmtagjA
        6AIjPOqmwQUWMxwzlYrudZvfGbm03HmQ788Vjs/gYF19AY0aQ5M4XN7HQx5ZUFrE33zDlW
        HT3OqBR3yV+6o5RHmllvJQK2D370ccfuJ44qtQevjdiQyT/NYhguBM+gu9egGMnUm3MoMD
        Oub6C0edYE0ZQ2809XsjR8OrqpqJwOBcd3e33FRHYSYcNokIitXZOTFIysdzbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886073;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SpGOCqPELEMSZZUrTom+A0jDOUdevQy5xnd6ISi5q0I=;
        b=ztg0EiZGJZsukv5mmJ90bwF4Zd4PKTNWuq4w4HdbHkVYnfyqfyEMI5U+y0HLU2ESW4otcy
        GvjzESQ/BsU8tKBw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Make grace-period kthread report match
 RCU flavor being tested
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788607282.3364.4256453402331544702.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     27c0f1448389baf7f309b69e62d4b531c9395e88
Gitweb:        https://git.kernel.org/tip/27c0f1448389baf7f309b69e62d4b531c9395e88
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 15 Sep 2020 17:08:03 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 02 Nov 2020 17:12:43 -08:00

rcutorture: Make grace-period kthread report match RCU flavor being tested

At the end of the test and after rcu_torture_writer() stalls, rcutorture
invokes show_rcu_gp_kthreads() in order to dump out information on the
RCU grace-period kthread.  This makes a lot of sense when testing vanilla
RCU, but not so much for the other flavors.  This commit therefore allows
per-flavor kthread-dump functions to be specified.

[ paulmck: Apply feedback from kernel test robot <lkp@intel.com>. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcu.h        | 16 ++++++++++++++++
 kernel/rcu/rcutorture.c | 11 +++++++++--
 kernel/rcu/tasks.h      | 30 ++++++++++++++----------------
 3 files changed, 39 insertions(+), 18 deletions(-)

diff --git a/kernel/rcu/rcu.h b/kernel/rcu/rcu.h
index e01cba5..59ef1ae 100644
--- a/kernel/rcu/rcu.h
+++ b/kernel/rcu/rcu.h
@@ -533,4 +533,20 @@ static inline bool rcu_is_nocb_cpu(int cpu) { return false; }
 static inline void rcu_bind_current_to_nocb(void) { }
 #endif
 
+#if !defined(CONFIG_TINY_RCU) && defined(CONFIG_TASKS_RCU)
+void show_rcu_tasks_classic_gp_kthread(void);
+#else
+static inline void show_rcu_tasks_classic_gp_kthread(void) {}
+#endif
+#if !defined(CONFIG_TINY_RCU) && defined(CONFIG_TASKS_RUDE_RCU)
+void show_rcu_tasks_rude_gp_kthread(void);
+#else
+static inline void show_rcu_tasks_rude_gp_kthread(void) {}
+#endif
+#if !defined(CONFIG_TINY_RCU) && defined(CONFIG_TASKS_TRACE_RCU)
+void show_rcu_tasks_trace_gp_kthread(void);
+#else
+static inline void show_rcu_tasks_trace_gp_kthread(void) {}
+#endif
+
 #endif /* __LINUX_RCU_H */
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 916ea4f..c811f23 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -317,6 +317,7 @@ struct rcu_torture_ops {
 	void (*cb_barrier)(void);
 	void (*fqs)(void);
 	void (*stats)(void);
+	void (*gp_kthread_dbg)(void);
 	int (*stall_dur)(void);
 	int irq_capable;
 	int can_boost;
@@ -466,6 +467,7 @@ static struct rcu_torture_ops rcu_ops = {
 	.cb_barrier	= rcu_barrier,
 	.fqs		= rcu_force_quiescent_state,
 	.stats		= NULL,
+	.gp_kthread_dbg	= show_rcu_gp_kthreads,
 	.stall_dur	= rcu_jiffies_till_stall_check,
 	.irq_capable	= 1,
 	.can_boost	= rcu_can_boost(),
@@ -693,6 +695,7 @@ static struct rcu_torture_ops tasks_ops = {
 	.exp_sync	= synchronize_rcu_mult_test,
 	.call		= call_rcu_tasks,
 	.cb_barrier	= rcu_barrier_tasks,
+	.gp_kthread_dbg	= show_rcu_tasks_classic_gp_kthread,
 	.fqs		= NULL,
 	.stats		= NULL,
 	.irq_capable	= 1,
@@ -762,6 +765,7 @@ static struct rcu_torture_ops tasks_rude_ops = {
 	.exp_sync	= synchronize_rcu_tasks_rude,
 	.call		= call_rcu_tasks_rude,
 	.cb_barrier	= rcu_barrier_tasks_rude,
+	.gp_kthread_dbg	= show_rcu_tasks_rude_gp_kthread,
 	.fqs		= NULL,
 	.stats		= NULL,
 	.irq_capable	= 1,
@@ -800,6 +804,7 @@ static struct rcu_torture_ops tasks_tracing_ops = {
 	.exp_sync	= synchronize_rcu_tasks_trace,
 	.call		= call_rcu_tasks_trace,
 	.cb_barrier	= rcu_barrier_tasks_trace,
+	.gp_kthread_dbg	= show_rcu_tasks_trace_gp_kthread,
 	.fqs		= NULL,
 	.stats		= NULL,
 	.irq_capable	= 1,
@@ -1594,7 +1599,8 @@ rcu_torture_stats_print(void)
 			sched_show_task(wtp);
 			splatted = true;
 		}
-		show_rcu_gp_kthreads();
+		if (cur_ops->gp_kthread_dbg)
+			cur_ops->gp_kthread_dbg();
 		rcu_ftrace_dump(DUMP_ALL);
 	}
 	rtcv_snap = rcu_torture_current_version;
@@ -2472,7 +2478,8 @@ rcu_torture_cleanup(void)
 		return;
 	}
 
-	show_rcu_gp_kthreads();
+	if (cur_ops->gp_kthread_dbg)
+		cur_ops->gp_kthread_dbg();
 	rcu_torture_read_exit_cleanup();
 	rcu_torture_barrier_cleanup();
 	rcu_torture_fwd_prog_cleanup();
diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index a93271f..0b45989 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -290,7 +290,7 @@ static void show_rcu_tasks_generic_gp_kthread(struct rcu_tasks *rtp, char *s)
 		".C"[!!data_race(rtp->cbs_head)],
 		s);
 }
-#endif /* #ifndef CONFIG_TINY_RCU */
+#endif // #ifndef CONFIG_TINY_RCU
 
 static void exit_tasks_rcu_finish_trace(struct task_struct *t);
 
@@ -568,12 +568,13 @@ static int __init rcu_spawn_tasks_kthread(void)
 }
 core_initcall(rcu_spawn_tasks_kthread);
 
-#ifndef CONFIG_TINY_RCU
-static void show_rcu_tasks_classic_gp_kthread(void)
+#if !defined(CONFIG_TINY_RCU)
+void show_rcu_tasks_classic_gp_kthread(void)
 {
 	show_rcu_tasks_generic_gp_kthread(&rcu_tasks, "");
 }
-#endif /* #ifndef CONFIG_TINY_RCU */
+EXPORT_SYMBOL_GPL(show_rcu_tasks_classic_gp_kthread);
+#endif // !defined(CONFIG_TINY_RCU)
 
 /* Do the srcu_read_lock() for the above synchronize_srcu().  */
 void exit_tasks_rcu_start(void) __acquires(&tasks_rcu_exit_srcu)
@@ -595,7 +596,6 @@ void exit_tasks_rcu_finish(void) __releases(&tasks_rcu_exit_srcu)
 }
 
 #else /* #ifdef CONFIG_TASKS_RCU */
-static inline void show_rcu_tasks_classic_gp_kthread(void) { }
 void exit_tasks_rcu_start(void) { }
 void exit_tasks_rcu_finish(void) { exit_tasks_rcu_finish_trace(current); }
 #endif /* #else #ifdef CONFIG_TASKS_RCU */
@@ -696,16 +696,14 @@ static int __init rcu_spawn_tasks_rude_kthread(void)
 }
 core_initcall(rcu_spawn_tasks_rude_kthread);
 
-#ifndef CONFIG_TINY_RCU
-static void show_rcu_tasks_rude_gp_kthread(void)
+#if !defined(CONFIG_TINY_RCU)
+void show_rcu_tasks_rude_gp_kthread(void)
 {
 	show_rcu_tasks_generic_gp_kthread(&rcu_tasks_rude, "");
 }
-#endif /* #ifndef CONFIG_TINY_RCU */
-
-#else /* #ifdef CONFIG_TASKS_RUDE_RCU */
-static void show_rcu_tasks_rude_gp_kthread(void) {}
-#endif /* #else #ifdef CONFIG_TASKS_RUDE_RCU */
+EXPORT_SYMBOL_GPL(show_rcu_tasks_rude_gp_kthread);
+#endif // !defined(CONFIG_TINY_RCU)
+#endif /* #ifdef CONFIG_TASKS_RUDE_RCU */
 
 ////////////////////////////////////////////////////////////////////////
 //
@@ -1199,8 +1197,8 @@ static int __init rcu_spawn_tasks_trace_kthread(void)
 }
 core_initcall(rcu_spawn_tasks_trace_kthread);
 
-#ifndef CONFIG_TINY_RCU
-static void show_rcu_tasks_trace_gp_kthread(void)
+#if !defined(CONFIG_TINY_RCU)
+void show_rcu_tasks_trace_gp_kthread(void)
 {
 	char buf[64];
 
@@ -1210,11 +1208,11 @@ static void show_rcu_tasks_trace_gp_kthread(void)
 		data_race(n_heavy_reader_attempts));
 	show_rcu_tasks_generic_gp_kthread(&rcu_tasks_trace, buf);
 }
-#endif /* #ifndef CONFIG_TINY_RCU */
+EXPORT_SYMBOL_GPL(show_rcu_tasks_trace_gp_kthread);
+#endif // !defined(CONFIG_TINY_RCU)
 
 #else /* #ifdef CONFIG_TASKS_TRACE_RCU */
 static void exit_tasks_rcu_finish_trace(struct task_struct *t) { }
-static inline void show_rcu_tasks_trace_gp_kthread(void) {}
 #endif /* #else #ifdef CONFIG_TASKS_TRACE_RCU */
 
 #ifndef CONFIG_TINY_RCU
