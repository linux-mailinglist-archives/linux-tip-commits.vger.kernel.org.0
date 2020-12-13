Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8F42D8FA2
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:03:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391111AbgLMTDB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:03:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390947AbgLMTCp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:02:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424E6C0611BB;
        Sun, 13 Dec 2020 11:01:10 -0800 (PST)
Date:   Sun, 13 Dec 2020 19:01:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886068;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xcovC6rgTeDyvnnSfWFH9sQFXU697I7wgAN5WjW5C0U=;
        b=1mPWQCbJN/UQvDRODgtQgTF2mT66jKreGSQFIdAYmtnXpeMG+D4ZQFrZg4fMoYh5h4gnbq
        ORJmm07rgTle1+SGM/MvorBxtP86depx643QJ3xNkf7X7zdatW6YZ1+UcGfTu8xsLuL/ac
        L7Wy53urdwkeFHMHcdt4yWwNQSNfPJrFK5DpTyuqgOroheS0lvDNCv0YOjl96mxfwjziGY
        +4KSkSpPZiS9P7krbihEOEbhCiGOhDzmQV+nptHoxkyWE2tWpTdf5PGGnrKPHVE/Bm2YPM
        F5gGfrTqGezAvZIKm9VBk5voL88+i3hbTvk4mXmyEalFCIdoqtV9F4XU6oMpPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886068;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xcovC6rgTeDyvnnSfWFH9sQFXU697I7wgAN5WjW5C0U=;
        b=i03n8MnWEepv1Qseme9wPjL9tnBMJ7Do4+pirwtUURB+TTLuRt/esJraL8qBu+ElWLxW/4
        3JP1xl+HXu5mGNAQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Make stutter_wait() caller restore priority
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788606829.3364.11384941875285717217.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     ab1b7880dec86bbdacd31a4c5cf104de4cf903f2
Gitweb:        https://git.kernel.org/tip/ab1b7880dec86bbdacd31a4c5cf104de4cf903f2
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 22 Sep 2020 16:42:42 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 17:13:54 -08:00

rcutorture:  Make stutter_wait() caller restore priority

Currently, stutter_wait() will happily spin waiting for the stutter
interval to end even if the caller is running at a real-time priority
level.  This could starve normal-priority tasks for no good reason.  This
commit therefore drops the calling task's priority to SCHED_OTHER MAX_NICE
if stutter_wait() needs to wait.  But when it waits, stutter_wait()
returns true, which allows the caller to restore the priority if needed.
Callers that were already running at SCHED_OTHER MAX_NICE obviously
do not need any changes, but this commit also restores priority for
higher-priority callers.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 24 ++++++++++++++++++------
 kernel/torture.c        |  9 ++++-----
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index db37671..4391d2f 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -912,7 +912,8 @@ static int rcu_torture_boost(void *arg)
 		oldstarttime = boost_starttime;
 		while (time_before(jiffies, oldstarttime)) {
 			schedule_timeout_interruptible(oldstarttime - jiffies);
-			stutter_wait("rcu_torture_boost");
+			if (stutter_wait("rcu_torture_boost"))
+				sched_set_fifo_low(current);
 			if (torture_must_stop())
 				goto checkwait;
 		}
@@ -932,7 +933,8 @@ static int rcu_torture_boost(void *arg)
 								 jiffies);
 				call_rcu_time = jiffies;
 			}
-			stutter_wait("rcu_torture_boost");
+			if (stutter_wait("rcu_torture_boost"))
+				sched_set_fifo_low(current);
 			if (torture_must_stop())
 				goto checkwait;
 		}
@@ -964,7 +966,8 @@ static int rcu_torture_boost(void *arg)
 		}
 
 		/* Go do the stutter. */
-checkwait:	stutter_wait("rcu_torture_boost");
+checkwait:	if (stutter_wait("rcu_torture_boost"))
+			sched_set_fifo_low(current);
 	} while (!torture_must_stop());
 
 	/* Clean up and exit. */
@@ -987,6 +990,7 @@ rcu_torture_fqs(void *arg)
 {
 	unsigned long fqs_resume_time;
 	int fqs_burst_remaining;
+	int oldnice = task_nice(current);
 
 	VERBOSE_TOROUT_STRING("rcu_torture_fqs task started");
 	do {
@@ -1002,7 +1006,8 @@ rcu_torture_fqs(void *arg)
 			udelay(fqs_holdoff);
 			fqs_burst_remaining -= fqs_holdoff;
 		}
-		stutter_wait("rcu_torture_fqs");
+		if (stutter_wait("rcu_torture_fqs"))
+			sched_set_normal(current, oldnice);
 	} while (!torture_must_stop());
 	torture_kthread_stopping("rcu_torture_fqs");
 	return 0;
@@ -1022,9 +1027,11 @@ rcu_torture_writer(void *arg)
 	bool gp_cond1 = gp_cond, gp_exp1 = gp_exp, gp_normal1 = gp_normal;
 	bool gp_sync1 = gp_sync;
 	int i;
+	int oldnice = task_nice(current);
 	struct rcu_torture *rp;
 	struct rcu_torture *old_rp;
 	static DEFINE_TORTURE_RANDOM(rand);
+	bool stutter_waited;
 	int synctype[] = { RTWS_DEF_FREE, RTWS_EXP_SYNC,
 			   RTWS_COND_GET, RTWS_SYNC };
 	int nsynctypes = 0;
@@ -1143,7 +1150,8 @@ rcu_torture_writer(void *arg)
 				       !rcu_gp_is_normal();
 		}
 		rcu_torture_writer_state = RTWS_STUTTER;
-		if (stutter_wait("rcu_torture_writer") &&
+		stutter_waited = stutter_wait("rcu_torture_writer");
+		if (stutter_waited &&
 		    !READ_ONCE(rcu_fwd_cb_nodelay) &&
 		    !cur_ops->slow_gps &&
 		    !torture_must_stop() &&
@@ -1155,6 +1163,8 @@ rcu_torture_writer(void *arg)
 					rcu_ftrace_dump(DUMP_ALL);
 					WARN(1, "%s: rtort_pipe_count: %d\n", __func__, rcu_tortures[i].rtort_pipe_count);
 				}
+		if (stutter_waited)
+			sched_set_normal(current, oldnice);
 	} while (!torture_must_stop());
 	rcu_torture_current = NULL;  // Let stats task know that we are done.
 	/* Reset expediting back to unexpedited. */
@@ -2103,6 +2113,7 @@ static struct notifier_block rcutorture_oom_nb = {
 /* Carry out grace-period forward-progress testing. */
 static int rcu_torture_fwd_prog(void *args)
 {
+	int oldnice = task_nice(current);
 	struct rcu_fwd *rfp = args;
 	int tested = 0;
 	int tested_tries = 0;
@@ -2121,7 +2132,8 @@ static int rcu_torture_fwd_prog(void *args)
 			rcu_torture_fwd_prog_cr(rfp);
 
 		/* Avoid slow periods, better to test when busy. */
-		stutter_wait("rcu_torture_fwd_prog");
+		if (stutter_wait("rcu_torture_fwd_prog"))
+			sched_set_normal(current, oldnice);
 	} while (!torture_must_stop());
 	/* Short runs might not contain a valid forward-progress attempt. */
 	WARN_ON(!tested && tested_tries >= 5);
diff --git a/kernel/torture.c b/kernel/torture.c
index 56ff02b..8562ac1 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -604,19 +604,19 @@ bool stutter_wait(const char *title)
 {
 	ktime_t delay;
 	unsigned int i = 0;
-	int oldnice;
 	bool ret = false;
 	int spt;
 
 	cond_resched_tasks_rcu_qs();
 	spt = READ_ONCE(stutter_pause_test);
 	for (; spt; spt = READ_ONCE(stutter_pause_test)) {
-		ret = true;
+		if (!ret) {
+			sched_set_normal(current, MAX_NICE);
+			ret = true;
+		}
 		if (spt == 1) {
 			schedule_timeout_interruptible(1);
 		} else if (spt == 2) {
-			oldnice = task_nice(current);
-			set_user_nice(current, MAX_NICE);
 			while (READ_ONCE(stutter_pause_test)) {
 				if (!(i++ & 0xffff)) {
 					set_current_state(TASK_INTERRUPTIBLE);
@@ -625,7 +625,6 @@ bool stutter_wait(const char *title)
 				}
 				cond_resched();
 			}
-			set_user_nice(current, oldnice);
 		} else {
 			schedule_timeout_interruptible(round_jiffies_relative(HZ));
 		}
