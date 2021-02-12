Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 02C7E319EBC
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231718AbhBLMki (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:40:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45384 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231586AbhBLMjF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:39:05 -0500
Date:   Fri, 12 Feb 2021 12:37:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133437;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=uZbkbpZtjmaGkbvZbmA1NQWzdEoznFZ2rS2sePYK0jE=;
        b=M8r/l//MD5jOwCVZEiCRH4kcbjkSCzoJFZN7cphC4Oq2U3ao/wRXIkTk179RfTIGBk63W/
        08+/7G63eVKRi2K+p7yiXEVYYWloFekMmVQfW8muD63daT4ExbrDo8YNNaKFxMZkjMj4Go
        K/oAVVF3Aqcsomvcu2WCbOFYkdUJoIRk48dQs9f37PRZ7rbowvL4tmTh8Gdj+PWnh6tjLo
        Bj6xQdmq/P+cQJXbLeztCmmu95UdtsBWWXXI7VhEpLOottlYL9+29O3vBNuOMJLPpNUhM7
        NxdPSKDaR0QxsQpR4LZRUj/odBU6rtsXBkeQVMZmTpsyNedlaidp9XSRAHKztQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133437;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=uZbkbpZtjmaGkbvZbmA1NQWzdEoznFZ2rS2sePYK0jE=;
        b=s4cGNj33CopKBVwBl085y75gTCbEohSUWI+hHxODUd0GFROcK26syOiOc9Jdj6TXvTfX+r
        yDVkIcJdqKMPX4Dw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Test runtime toggling of CPUs' callback
 offloading
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313343687.23325.10166072164350145406.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     2c4319bd1d14d01f5b6654a90c2b6362f3a407d8
Gitweb:        https://git.kernel.org/tip/2c4319bd1d14d01f5b6654a90c2b6362f3a407d8
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Wed, 23 Sep 2020 17:39:46 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 16:24:59 -08:00

rcutorture: Test runtime toggling of CPUs' callback offloading

Frederic Weisbecker is adding the ability to change the rcu_nocbs state
of CPUs at runtime, that is, to offload and deoffload their RCU callback
processing without the need to reboot.  As the old saying goes, "if it
ain't tested, it don't work", so this commit therefore adds prototype
rcutorture testing for this capability.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Frederic Weisbecker <frederic@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  8 +-
 kernel/rcu/rcutorture.c                         | 90 +++++++++++++++-
 2 files changed, 95 insertions(+), 3 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c722ec1..9f8ac77 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4338,6 +4338,14 @@
 			stress RCU, they don't participate in the actual
 			test, hence the "fake".
 
+	rcutorture.nocbs_nthreads= [KNL]
+			Set number of RCU callback-offload togglers.
+			Zero (the default) disables toggling.
+
+	rcutorture.nocbs_toggle= [KNL]
+			Set the delay in milliseconds between successive
+			callback-offload toggling attempts.
+
 	rcutorture.nreaders= [KNL]
 			Set number of RCU readers.  The value -1 selects
 			N-1, where N is the number of CPUs.  A value
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 528ed10..22735bc 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -97,6 +97,8 @@ torture_param(int, object_debug, 0,
 torture_param(int, onoff_holdoff, 0, "Time after boot before CPU hotplugs (s)");
 torture_param(int, onoff_interval, 0,
 	     "Time between CPU hotplugs (jiffies), 0=disable");
+torture_param(int, nocbs_nthreads, 0, "Number of NOCB toggle threads, 0 to disable");
+torture_param(int, nocbs_toggle, 1000, "Time between toggling nocb state (ms)");
 torture_param(int, read_exit_delay, 13,
 	      "Delay between read-then-exit episodes (s)");
 torture_param(int, read_exit_burst, 16,
@@ -127,10 +129,12 @@ static char *torture_type = "rcu";
 module_param(torture_type, charp, 0444);
 MODULE_PARM_DESC(torture_type, "Type of RCU to torture (rcu, srcu, ...)");
 
+static int nrealnocbers;
 static int nrealreaders;
 static struct task_struct *writer_task;
 static struct task_struct **fakewriter_tasks;
 static struct task_struct **reader_tasks;
+static struct task_struct **nocb_tasks;
 static struct task_struct *stats_task;
 static struct task_struct *fqs_task;
 static struct task_struct *boost_tasks[NR_CPUS];
@@ -174,6 +178,8 @@ static unsigned long n_read_exits;
 static struct list_head rcu_torture_removed;
 static unsigned long shutdown_jiffies;
 static unsigned long start_gp_seq;
+static atomic_long_t n_nocb_offload;
+static atomic_long_t n_nocb_deoffload;
 
 static int rcu_torture_writer_state;
 #define RTWS_FIXED_DELAY	0
@@ -1499,6 +1505,53 @@ rcu_torture_reader(void *arg)
 }
 
 /*
+ * Randomly Toggle CPUs' callback-offload state.  This uses hrtimers to
+ * increase race probabilities and fuzzes the interval between toggling.
+ */
+static int rcu_nocb_toggle(void *arg)
+{
+	int cpu;
+	int maxcpu = -1;
+	int oldnice = task_nice(current);
+	long r;
+	DEFINE_TORTURE_RANDOM(rand);
+	ktime_t toggle_delay;
+	unsigned long toggle_fuzz;
+	ktime_t toggle_interval = ms_to_ktime(nocbs_toggle);
+
+	VERBOSE_TOROUT_STRING("rcu_nocb_toggle task started");
+	while (!rcu_inkernel_boot_has_ended())
+		schedule_timeout_interruptible(HZ / 10);
+	for_each_online_cpu(cpu)
+		maxcpu = cpu;
+	WARN_ON(maxcpu < 0);
+	if (toggle_interval > ULONG_MAX)
+		toggle_fuzz = ULONG_MAX >> 3;
+	else
+		toggle_fuzz = toggle_interval >> 3;
+	if (toggle_fuzz <= 0)
+		toggle_fuzz = NSEC_PER_USEC;
+	do {
+		r = torture_random(&rand);
+		cpu = (r >> 4) % (maxcpu + 1);
+		if (r & 0x1) {
+			rcu_nocb_cpu_offload(cpu);
+			atomic_long_inc(&n_nocb_offload);
+		} else {
+			rcu_nocb_cpu_deoffload(cpu);
+			atomic_long_inc(&n_nocb_deoffload);
+		}
+		toggle_delay = torture_random(&rand) % toggle_fuzz + toggle_interval;
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_hrtimeout(&toggle_delay, HRTIMER_MODE_REL);
+		if (stutter_wait("rcu_nocb_toggle"))
+			sched_set_normal(current, oldnice);
+	} while (!torture_must_stop());
+	torture_kthread_stopping("rcu_nocb_toggle");
+	return 0;
+}
+
+/*
  * Print torture statistics.  Caller must ensure that there is only
  * one call to this function at a given time!!!  This is normally
  * accomplished by relying on the module system to only have one copy
@@ -1553,7 +1606,9 @@ rcu_torture_stats_print(void)
 		data_race(n_barrier_successes),
 		data_race(n_barrier_attempts),
 		data_race(n_rcu_torture_barrier_error));
-	pr_cont("read-exits: %ld\n", data_race(n_read_exits));
+	pr_cont("read-exits: %ld ", data_race(n_read_exits));
+	pr_cont("nocb-toggles: %ld:%ld\n",
+		atomic_long_read(&n_nocb_offload), atomic_long_read(&n_nocb_deoffload));
 
 	pr_alert("%s%s ", torture_type, TORTURE_FLAG);
 	if (atomic_read(&n_rcu_torture_mberror) ||
@@ -1647,7 +1702,8 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 "stall_cpu_block=%d "
 		 "n_barrier_cbs=%d "
 		 "onoff_interval=%d onoff_holdoff=%d "
-		 "read_exit_delay=%d read_exit_burst=%d\n",
+		 "read_exit_delay=%d read_exit_burst=%d "
+		 "nocbs_nthreads=%d nocbs_toggle=%d\n",
 		 torture_type, tag, nrealreaders, nfakewriters,
 		 stat_interval, verbose, test_no_idle_hz, shuffle_interval,
 		 stutter, irqreader, fqs_duration, fqs_holdoff, fqs_stutter,
@@ -1657,7 +1713,8 @@ rcu_torture_print_module_parms(struct rcu_torture_ops *cur_ops, const char *tag)
 		 stall_cpu_block,
 		 n_barrier_cbs,
 		 onoff_interval, onoff_holdoff,
-		 read_exit_delay, read_exit_burst);
+		 read_exit_delay, read_exit_burst,
+		 nocbs_nthreads, nocbs_toggle);
 }
 
 static int rcutorture_booster_cleanup(unsigned int cpu)
@@ -2500,6 +2557,13 @@ rcu_torture_cleanup(void)
 	torture_stop_kthread(rcu_torture_stall, stall_task);
 	torture_stop_kthread(rcu_torture_writer, writer_task);
 
+	if (nocb_tasks) {
+		for (i = 0; i < nrealnocbers; i++)
+			torture_stop_kthread(rcu_nocb_toggle, nocb_tasks[i]);
+		kfree(nocb_tasks);
+		nocb_tasks = NULL;
+	}
+
 	if (reader_tasks) {
 		for (i = 0; i < nrealreaders; i++)
 			torture_stop_kthread(rcu_torture_reader,
@@ -2762,6 +2826,26 @@ rcu_torture_init(void)
 		if (firsterr)
 			goto unwind;
 	}
+	nrealnocbers = nocbs_nthreads;
+	if (WARN_ON(nrealnocbers < 0))
+		nrealnocbers = 1;
+	if (WARN_ON(nocbs_toggle < 0))
+		nocbs_toggle = HZ;
+	if (nrealnocbers > 0) {
+		nocb_tasks = kcalloc(nrealnocbers, sizeof(nocb_tasks[0]), GFP_KERNEL);
+		if (nocb_tasks == NULL) {
+			VERBOSE_TOROUT_ERRSTRING("out of memory");
+			firsterr = -ENOMEM;
+			goto unwind;
+		}
+	} else {
+		nocb_tasks = NULL;
+	}
+	for (i = 0; i < nrealnocbers; i++) {
+		firsterr = torture_create_kthread(rcu_nocb_toggle, NULL, nocb_tasks[i]);
+		if (firsterr)
+			goto unwind;
+	}
 	if (stat_interval > 0) {
 		firsterr = torture_create_kthread(rcu_torture_stats, NULL,
 						  stats_task);
