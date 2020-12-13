Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DDB72D8FA9
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:04:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392923AbgLMTDS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:03:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392576AbgLMTDL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:03:11 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A643EC0619DA;
        Sun, 13 Dec 2020 11:01:12 -0800 (PST)
Date:   Sun, 13 Dec 2020 19:01:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886071;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=uOirk58nAnBS9UX7B3m3VLVEu04b3qkgY9n3Q9Q5Trc=;
        b=24CTKkBuu7c5L4fm6Eq29rnPKhGTGHqmr93WJdKUWADRbtz75eCBZpTg9K7YzHemFxDrbU
        ux7hfOF0bW+FauLFXw4PKRO8Z4oz3SgOqAoG0TbVQkREatGPQN0U8cKZ/UOK8ned6rlzP+
        eqFfUCXKZtfLF0dwMw4Jq3HTpIwxhjBqfhuryigAWgibMipJiPRfoCQK6fKXQvOK1RkPG6
        ZsGnB1pSUtM0U6RRufDmS9jbKL4am54UxTEzNX7iiIJ5gT8H1UhhR9iRfdxic3iJbcWeh+
        6x77xF8vIB7FeTMi87NOL6xSi+ezSdJYrD6+LdNepBkQMqcoOS2vqtG3CzuPIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886071;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=uOirk58nAnBS9UX7B3m3VLVEu04b3qkgY9n3Q9Q5Trc=;
        b=LVIq+iyRhr17qc9YJvVHfoFDHb9fOF8DX+7qDY0fNqPfrLDt2tDlhRogDznZP/iXYHXXUX
        usCFgVGB+M8adwBg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] scftorture: Add an alternative IPI vector
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788607050.3364.18260435161958207630.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     1ac78b49d61d4a095ef8b861542549eef1823f36
Gitweb:        https://git.kernel.org/tip/1ac78b49d61d4a095ef8b861542549eef1823f36
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 03 Sep 2020 13:09:47 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 17:13:49 -08:00

scftorture: Add an alternative IPI vector

The scftorture tests currently use only smp_call_function() and
friends, which means that these tests cannot locate bugs caused by
interactions between different IPI vectors.  This commit therefore adds
the rescheduling IPI to the mix.

Note that this commit permits resched_cpus() only when scftorture is
built in.  This is a workaround.  Longer term, this will use real wakeups
rather than resched_cpu().

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/scftorture.c | 41 ++++++++++++++++++++++++++++++++---------
 1 file changed, 32 insertions(+), 9 deletions(-)

diff --git a/kernel/scftorture.c b/kernel/scftorture.c
index 554a521..3fbb7a7 100644
--- a/kernel/scftorture.c
+++ b/kernel/scftorture.c
@@ -62,6 +62,7 @@ torture_param(int, stat_interval, 60, "Number of seconds between stats printk()s
 torture_param(int, stutter_cpus, 5, "Number of jiffies to change CPUs under test, 0=disable");
 torture_param(bool, use_cpus_read_lock, 0, "Use cpus_read_lock() to exclude CPU hotplug.");
 torture_param(int, verbose, 0, "Enable verbose debugging printk()s");
+torture_param(int, weight_resched, -1, "Testing weight for resched_cpu() operations.");
 torture_param(int, weight_single, -1, "Testing weight for single-CPU no-wait operations.");
 torture_param(int, weight_single_wait, -1, "Testing weight for single-CPU operations.");
 torture_param(int, weight_many, -1, "Testing weight for multi-CPU no-wait operations.");
@@ -82,6 +83,7 @@ torture_param(bool, shutdown, SCFTORT_SHUTDOWN, "Shutdown at end of torture test
 struct scf_statistics {
 	struct task_struct *task;
 	int cpu;
+	long long n_resched;
 	long long n_single;
 	long long n_single_ofl;
 	long long n_single_wait;
@@ -97,12 +99,15 @@ static struct task_struct *scf_torture_stats_task;
 static DEFINE_PER_CPU(long long, scf_invoked_count);
 
 // Data for random primitive selection
-#define SCF_PRIM_SINGLE		0
-#define SCF_PRIM_MANY		1
-#define SCF_PRIM_ALL		2
-#define SCF_NPRIMS		(2 * 3) // Need wait and no-wait versions of each.
+#define SCF_PRIM_RESCHED	0
+#define SCF_PRIM_SINGLE		1
+#define SCF_PRIM_MANY		2
+#define SCF_PRIM_ALL		3
+#define SCF_NPRIMS		7 // Need wait and no-wait versions of each,
+				  //  except for SCF_PRIM_RESCHED.
 
 static char *scf_prim_name[] = {
+	"resched_cpu",
 	"smp_call_function_single",
 	"smp_call_function_many",
 	"smp_call_function",
@@ -136,6 +141,8 @@ static char *bangstr = "";
 
 static DEFINE_TORTURE_RANDOM_PERCPU(scf_torture_rand);
 
+extern void resched_cpu(int cpu); // An alternative IPI vector.
+
 // Print torture statistics.  Caller must ensure serialization.
 static void scf_torture_stats_print(void)
 {
@@ -148,6 +155,7 @@ static void scf_torture_stats_print(void)
 	for_each_possible_cpu(cpu)
 		invoked_count += data_race(per_cpu(scf_invoked_count, cpu));
 	for (i = 0; i < nthreads; i++) {
+		scfs.n_resched += scf_stats_p[i].n_resched;
 		scfs.n_single += scf_stats_p[i].n_single;
 		scfs.n_single_ofl += scf_stats_p[i].n_single_ofl;
 		scfs.n_single_wait += scf_stats_p[i].n_single_wait;
@@ -160,8 +168,8 @@ static void scf_torture_stats_print(void)
 	if (atomic_read(&n_errs) || atomic_read(&n_mb_in_errs) ||
 	    atomic_read(&n_mb_out_errs) || atomic_read(&n_alloc_errs))
 		bangstr = "!!! ";
-	pr_alert("%s %sscf_invoked_count %s: %lld single: %lld/%lld single_ofl: %lld/%lld many: %lld/%lld all: %lld/%lld ",
-		 SCFTORT_FLAG, bangstr, isdone ? "VER" : "ver", invoked_count,
+	pr_alert("%s %sscf_invoked_count %s: %lld resched: %lld single: %lld/%lld single_ofl: %lld/%lld many: %lld/%lld all: %lld/%lld ",
+		 SCFTORT_FLAG, bangstr, isdone ? "VER" : "ver", invoked_count, scfs.n_resched,
 		 scfs.n_single, scfs.n_single_wait, scfs.n_single_ofl, scfs.n_single_wait_ofl,
 		 scfs.n_many, scfs.n_many_wait, scfs.n_all, scfs.n_all_wait);
 	torture_onoff_stats();
@@ -314,6 +322,13 @@ static void scftorture_invoke_one(struct scf_statistics *scfp, struct torture_ra
 		}
 	}
 	switch (scfsp->scfs_prim) {
+	case SCF_PRIM_RESCHED:
+		if (IS_BUILTIN(CONFIG_SCF_TORTURE_TEST)) {
+			cpu = torture_random(trsp) % nr_cpu_ids;
+			scfp->n_resched++;
+			resched_cpu(cpu);
+		}
+		break;
 	case SCF_PRIM_SINGLE:
 		cpu = torture_random(trsp) % nr_cpu_ids;
 		if (scfsp->scfs_wait)
@@ -433,8 +448,8 @@ static void
 scftorture_print_module_parms(const char *tag)
 {
 	pr_alert(SCFTORT_FLAG
-		 "--- %s:  verbose=%d holdoff=%d longwait=%d nthreads=%d onoff_holdoff=%d onoff_interval=%d shutdown_secs=%d stat_interval=%d stutter_cpus=%d use_cpus_read_lock=%d, weight_single=%d, weight_single_wait=%d, weight_many=%d, weight_many_wait=%d, weight_all=%d, weight_all_wait=%d\n", tag,
-		 verbose, holdoff, longwait, nthreads, onoff_holdoff, onoff_interval, shutdown, stat_interval, stutter_cpus, use_cpus_read_lock, weight_single, weight_single_wait, weight_many, weight_many_wait, weight_all, weight_all_wait);
+		 "--- %s:  verbose=%d holdoff=%d longwait=%d nthreads=%d onoff_holdoff=%d onoff_interval=%d shutdown_secs=%d stat_interval=%d stutter_cpus=%d use_cpus_read_lock=%d, weight_resched=%d, weight_single=%d, weight_single_wait=%d, weight_many=%d, weight_many_wait=%d, weight_all=%d, weight_all_wait=%d\n", tag,
+		 verbose, holdoff, longwait, nthreads, onoff_holdoff, onoff_interval, shutdown, stat_interval, stutter_cpus, use_cpus_read_lock, weight_resched, weight_single, weight_single_wait, weight_many, weight_many_wait, weight_all, weight_all_wait);
 }
 
 static void scf_cleanup_handler(void *unused)
@@ -475,6 +490,7 @@ static int __init scf_torture_init(void)
 {
 	long i;
 	int firsterr = 0;
+	unsigned long weight_resched1 = weight_resched;
 	unsigned long weight_single1 = weight_single;
 	unsigned long weight_single_wait1 = weight_single_wait;
 	unsigned long weight_many1 = weight_many;
@@ -487,9 +503,10 @@ static int __init scf_torture_init(void)
 
 	scftorture_print_module_parms("Start of test");
 
-	if (weight_single == -1 && weight_single_wait == -1 &&
+	if (weight_resched == -1 && weight_single == -1 && weight_single_wait == -1 &&
 	    weight_many == -1 && weight_many_wait == -1 &&
 	    weight_all == -1 && weight_all_wait == -1) {
+		weight_resched1 = 2 * nr_cpu_ids;
 		weight_single1 = 2 * nr_cpu_ids;
 		weight_single_wait1 = 2 * nr_cpu_ids;
 		weight_many1 = 2;
@@ -497,6 +514,8 @@ static int __init scf_torture_init(void)
 		weight_all1 = 1;
 		weight_all_wait1 = 1;
 	} else {
+		if (weight_resched == -1)
+			weight_resched1 = 0;
 		if (weight_single == -1)
 			weight_single1 = 0;
 		if (weight_single_wait == -1)
@@ -517,6 +536,10 @@ static int __init scf_torture_init(void)
 		firsterr = -EINVAL;
 		goto unwind;
 	}
+	if (IS_BUILTIN(CONFIG_SCF_TORTURE_TEST))
+		scf_sel_add(weight_resched1, SCF_PRIM_RESCHED, false);
+	else if (weight_resched1)
+		VERBOSE_SCFTORTOUT_ERRSTRING("built as module, weight_resched ignored");
 	scf_sel_add(weight_single1, SCF_PRIM_SINGLE, false);
 	scf_sel_add(weight_single_wait1, SCF_PRIM_SINGLE, true);
 	scf_sel_add(weight_many1, SCF_PRIM_MANY, false);
