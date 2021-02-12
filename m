Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BBC3B319EC5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231755AbhBLMku (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:40:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231642AbhBLMjp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:39:45 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8AB8C06121D;
        Fri, 12 Feb 2021 04:37:13 -0800 (PST)
Date:   Fri, 12 Feb 2021 12:37:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133431;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0SpSh9EdHetUogoUxY/5H64mYen0SqhMaF8diX0nssc=;
        b=IfsSKu3GFu8OpxbgAIk9WMh+8cJvAO6bUIEYPDVAoV2qbUtEWjkqVnJR5ScavvzPrVUG7W
        RZeEuhnzWfO6t8OfhcGD1Jsi5BdY+lohd8FDKep/wZqu6J+tbg4KTlrXvpoKkxFNFRKVX0
        COiW/CQ/NkYPvRHFsqk+LAe4DmUBqVap7FJzT4TnzHH7sgBawsV4kpCDSKTNGICzLY4bZR
        H22/xdT09d6yeMJqY7l9JQjMiAqJpLVUrgvJegIq7MPJbiiIoGUWiPDIbPAcNq+bNl+AQ7
        L7vIok1JeD6Nh8SQUWotC2f0l1yE64zRYTxiE+mdllyiWSebBojE3oBSWw059Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133431;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0SpSh9EdHetUogoUxY/5H64mYen0SqhMaF8diX0nssc=;
        b=22STa9KDxxt52REYfjRZqY63LPfz5I8O6Izj3bVgljqk5KDc8ahf6ypFzJgZi5DgBqGpqa
        V1LGl3z9gRoBWeCw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] refscale: Allow summarization of verbose output
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313343081.23325.9379063539232872619.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     e76506f0e85129d726c487c873a2245c92446515
Gitweb:        https://git.kernel.org/tip/e76506f0e85129d726c487c873a2245c92446515
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sun, 15 Nov 2020 10:24:52 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 17:08:09 -08:00

refscale: Allow summarization of verbose output

The refscale test prints enough per-kthread console output to provoke RCU
CPU stall warnings on large systems.  This commit therefore allows this
output to be summarized.  For example, the refscale.verbose_batched=32
boot parameter would causes only every 32nd line of output to be logged.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt |  6 +++++-
 kernel/rcu/refscale.c                           | 21 ++++++++++++----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c722ec1..3244f9e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4557,6 +4557,12 @@
 	refscale.verbose= [KNL]
 			Enable additional printk() statements.
 
+	refscale.verbose_batched= [KNL]
+			Batch the additional printk() statements.  If zero
+			(the default) or negative, print everything.  Otherwise,
+			print every Nth verbose statement, where N is the value
+			specified.
+
 	relax_domain_level=
 			[KNL, SMP] Set scheduler's default relax_domain_level.
 			See Documentation/admin-guide/cgroup-v1/cpusets.rst.
diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 23ff36a..3da246f 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -46,6 +46,16 @@
 #define VERBOSE_SCALEOUT(s, x...) \
 	do { if (verbose) pr_alert("%s" SCALE_FLAG s, scale_type, ## x); } while (0)
 
+static atomic_t verbose_batch_ctr;
+
+#define VERBOSE_SCALEOUT_BATCH(s, x...)							\
+do {											\
+	if (verbose &&									\
+	    (verbose_batched <= 0 ||							\
+	     !(atomic_inc_return(&verbose_batch_ctr) % verbose_batched)))		\
+		pr_alert("%s" SCALE_FLAG s, scale_type, ## x);				\
+} while (0)
+
 #define VERBOSE_SCALEOUT_ERRSTRING(s, x...) \
 	do { if (verbose) pr_alert("%s" SCALE_FLAG "!!! " s, scale_type, ## x); } while (0)
 
@@ -57,6 +67,7 @@ module_param(scale_type, charp, 0444);
 MODULE_PARM_DESC(scale_type, "Type of test (rcu, srcu, refcnt, rwsem, rwlock.");
 
 torture_param(int, verbose, 0, "Enable verbose debugging printk()s");
+torture_param(int, verbose_batched, 0, "Batch verbose debugging printk()s");
 
 // Wait until there are multiple CPUs before starting test.
 torture_param(int, holdoff, IS_BUILTIN(CONFIG_RCU_REF_SCALE_TEST) ? 10 : 0,
@@ -368,14 +379,14 @@ ref_scale_reader(void *arg)
 	u64 start;
 	s64 duration;
 
-	VERBOSE_SCALEOUT("ref_scale_reader %ld: task started", me);
+	VERBOSE_SCALEOUT_BATCH("ref_scale_reader %ld: task started", me);
 	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
 	set_user_nice(current, MAX_NICE);
 	atomic_inc(&n_init);
 	if (holdoff)
 		schedule_timeout_interruptible(holdoff * HZ);
 repeat:
-	VERBOSE_SCALEOUT("ref_scale_reader %ld: waiting to start next experiment on cpu %d", me, smp_processor_id());
+	VERBOSE_SCALEOUT_BATCH("ref_scale_reader %ld: waiting to start next experiment on cpu %d", me, smp_processor_id());
 
 	// Wait for signal that this reader can start.
 	wait_event(rt->wq, (atomic_read(&nreaders_exp) && smp_load_acquire(&rt->start_reader)) ||
@@ -392,7 +403,7 @@ repeat:
 		while (atomic_read_acquire(&n_started))
 			cpu_relax();
 
-	VERBOSE_SCALEOUT("ref_scale_reader %ld: experiment %d started", me, exp_idx);
+	VERBOSE_SCALEOUT_BATCH("ref_scale_reader %ld: experiment %d started", me, exp_idx);
 
 
 	// To reduce noise, do an initial cache-warming invocation, check
@@ -421,8 +432,8 @@ repeat:
 	if (atomic_dec_and_test(&nreaders_exp))
 		wake_up(&main_wq);
 
-	VERBOSE_SCALEOUT("ref_scale_reader %ld: experiment %d ended, (readers remaining=%d)",
-			me, exp_idx, atomic_read(&nreaders_exp));
+	VERBOSE_SCALEOUT_BATCH("ref_scale_reader %ld: experiment %d ended, (readers remaining=%d)",
+				me, exp_idx, atomic_read(&nreaders_exp));
 
 	if (!torture_must_stop())
 		goto repeat;
