Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F54E319E8D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:38:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231547AbhBLMik (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:38:40 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45336 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231289AbhBLMhv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:37:51 -0500
Date:   Fri, 12 Feb 2021 12:37:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133428;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/oFT5NzcswmRlh3nxVGC+mxJhqcnpZRMJLrHzdF28ig=;
        b=tT0H67gnE2xXz4NjWU/ZcJ+fs5dl8xgc+EtQN71gQVV5VwB7ReddzlCJDHiRNbJU4L0JDJ
        CR7YL56Hlmc5UZ7zrtEB+4/BPZlAs9XmO36Iv4TGanj+IR8Y3CLIXpPia6ZcaKksFP4zZF
        Ik/cOyKwIESEm5PP06/Q6LpaCInLdyZKTpIIJzZ56W65kraoNteHA0GoTCmq+YgteXrb3R
        chqq5zX0GVKkfWhHvEUX86fsDg4Z+TqhOsZ7Rw70y9aLrNIQnqb1hIIXYEKKOOZPfFBHpn
        Zzk7HwHHdpp+oDr3kuKsJSUKgnd3CnaVI2PMuv1/Q5YMCZI2JPG8kpy9AktFUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133428;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=/oFT5NzcswmRlh3nxVGC+mxJhqcnpZRMJLrHzdF28ig=;
        b=rNNc2bfemDKMk0d+xMUfVLTTyLw4NvemF48zl6RKJBxWGnVKXctjrrhE5To/aaEnlv2Ki0
        G0jmDcABstIAXFCQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Maintain torture-specific set of CPUs-online books
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313342763.23325.3139806965840624960.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     1afb95fee0342b8d9e05b0433e8e44a6dfd7c4a3
Gitweb:        https://git.kernel.org/tip/1afb95fee0342b8d9e05b0433e8e44a6dfd7c4a3
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sat, 19 Dec 2020 07:34:35 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 17:17:22 -08:00

torture: Maintain torture-specific set of CPUs-online books

The TREE01 rcutorture scenario intentionally creates confusion as to the
number of available CPUs by specifying the "maxcpus=8 nr_cpus=43" kernel
boot parameters.  This can disable rcutorture's load shedding, which
currently uses num_online_cpus(), which would count the extra 35 CPUs.
However, the rcutorture guest OS will be provisioned with only 8 CPUs,
which means that rcutorture will present full load even when all but one
of the original 8 CPUs are offline.  This can result in spurious errors
due to extreme overloading of that single remaining CPU.

This commit therefore keeps a separate set of books on the number of
usable online CPUs, so that torture_num_online_cpus() is used for load
shedding instead of num_online_cpus().  Note that initial sizing must
use num_online_cpus() because torture_num_online_cpus() will return
NR_CPUS until shortly after torture_onoff_init() is invoked.

Reported-by: Frederic Weisbecker <frederic@kernel.org>
[ paulmck: Apply feedback from kernel test robot. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/torture.h |  5 +++++
 kernel/rcu/rcutorture.c |  4 ++--
 kernel/torture.c        | 16 ++++++++++++++++
 3 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/include/linux/torture.h b/include/linux/torture.h
index d62d13c..0910c58 100644
--- a/include/linux/torture.h
+++ b/include/linux/torture.h
@@ -48,6 +48,11 @@ do {										\
 void verbose_torout_sleep(void);
 
 /* Definitions for online/offline exerciser. */
+#ifdef CONFIG_HOTPLUG_CPU
+int torture_num_online_cpus(void);
+#else /* #ifdef CONFIG_HOTPLUG_CPU */
+static inline int torture_num_online_cpus(void) { return 1; }
+#endif /* #else #ifdef CONFIG_HOTPLUG_CPU */
 typedef void torture_ofl_func(void);
 bool torture_offline(int cpu, long *n_onl_attempts, long *n_onl_successes,
 		     unsigned long *sum_offl, int *min_onl, int *max_onl);
diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 76c8386..a816df4 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1338,7 +1338,7 @@ static void rcu_torture_reader_do_mbchk(long myid, struct rcu_torture *rtp,
 					struct torture_random_state *trsp)
 {
 	unsigned long loops;
-	int noc = num_online_cpus();
+	int noc = torture_num_online_cpus();
 	int rdrchked;
 	int rdrchker;
 	struct rcu_torture_reader_check *rtrcp; // Me.
@@ -1658,7 +1658,7 @@ rcu_torture_reader(void *arg)
 			torture_hrtimeout_us(500, 1000, &rand);
 			lastsleep = jiffies + 10;
 		}
-		while (num_online_cpus() < mynumonline && !torture_must_stop())
+		while (torture_num_online_cpus() < mynumonline && !torture_must_stop())
 			schedule_timeout_interruptible(HZ / 5);
 		stutter_wait("rcu_torture_reader");
 	} while (!torture_must_stop());
diff --git a/kernel/torture.c b/kernel/torture.c
index 507a20b..01e336f 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -175,6 +175,19 @@ static unsigned long sum_online;
 static int min_online = -1;
 static int max_online;
 
+static int torture_online_cpus = NR_CPUS;
+
+/*
+ * Some torture testing leverages confusion as to the number of online
+ * CPUs.  This function returns the torture-testing view of this number,
+ * which allows torture tests to load-balance appropriately.
+ */
+int torture_num_online_cpus(void)
+{
+	return READ_ONCE(torture_online_cpus);
+}
+EXPORT_SYMBOL_GPL(torture_num_online_cpus);
+
 /*
  * Attempt to take a CPU offline.  Return false if the CPU is already
  * offline or if it is not subject to CPU-hotplug operations.  The
@@ -229,6 +242,8 @@ bool torture_offline(int cpu, long *n_offl_attempts, long *n_offl_successes,
 			*min_offl = delta;
 		if (*max_offl < delta)
 			*max_offl = delta;
+		WRITE_ONCE(torture_online_cpus, torture_online_cpus - 1);
+		WARN_ON_ONCE(torture_online_cpus <= 0);
 	}
 
 	return true;
@@ -285,6 +300,7 @@ bool torture_online(int cpu, long *n_onl_attempts, long *n_onl_successes,
 			*min_onl = delta;
 		if (*max_onl < delta)
 			*max_onl = delta;
+		WRITE_ONCE(torture_online_cpus, torture_online_cpus + 1);
 	}
 
 	return true;
