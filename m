Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8802A35B504
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Apr 2021 15:49:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236008AbhDKNoq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Apr 2021 09:44:46 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33306 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235837AbhDKNoO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Apr 2021 09:44:14 -0400
Date:   Sun, 11 Apr 2021 13:43:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618148619;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RSqSvyHSmt++IXf6kHQzNuOmEAqLrDDJUARveE+pJ3E=;
        b=Z4UoLDjtjgbCkOxlix8/7OjMJdocwNOUeiehtM2eMC4rzatlXoPiZBA2W+7lonfp5B5jPb
        BFlmALOeIud/GqDINsCgnZc3GP0rCpVdafdfYTqetHCXqUAEqz03eyfEuZqkL1gQZwTr2C
        BqfLkYgwK6G9DTb/AbeemI0iSUwAMWFSBCMsuinzgalYhDyTOy5hA+FpbstU+NY0Qe5Zd3
        PGE0bGQY+HxoZSLn72CkD1VmsLWzyAtynGv17ZAiB9C1KUrJQV5Bcx/1c3Pg7IrkKR9i+V
        wVfKQ7jAPHt9oEIsWV4yR2QsCNl5OUv82T3NcI6TgoSscEUMQjLhzZmFG8mmIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618148619;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=RSqSvyHSmt++IXf6kHQzNuOmEAqLrDDJUARveE+pJ3E=;
        b=I8nGy5/OfW7Q37MEBJr3Y2UVBjz3y51Ddj7PLS6gCstclFmZvxnvfplJlEROciOEcWIjq9
        qUxICfrwrum0bOAA==
From:   "tip-bot2 for Uladzislau Rezki (Sony)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcuscale: Add kfree_rcu() single-argument scale test
Cc:     "Paul E. McKenney" <paulmck@kernel.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161814861933.29796.6664980753277444177.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     686fe1bf6bcce3ce9fc03c9d9035c643c320ca46
Gitweb:        https://git.kernel.org/tip/686fe1bf6bcce3ce9fc03c9d9035c643c320ca46
Author:        Uladzislau Rezki (Sony) <urezki@gmail.com>
AuthorDate:    Wed, 17 Feb 2021 19:51:10 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 08 Mar 2021 14:18:07 -08:00

rcuscale: Add kfree_rcu() single-argument scale test

The single-argument variant of kfree_rcu() is currently not
tested by any member of the rcutoture test suite.  This
commit therefore adds rcuscale code to test it.  This
testing is controlled by two new boolean module parameters,
kfree_rcu_test_single and kfree_rcu_test_double.  If one
is set and the other not, only the corresponding variant
is tested, otherwise both are tested, with the variant to
be tested determined randomly on each invocation.

Both of these module parameters are initialized to false,
so setting either to true will test only that variant.

Suggested-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/admin-guide/kernel-parameters.txt | 12 ++++++++++++
 kernel/rcu/rcuscale.c                           | 15 ++++++++++++++-
 2 files changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0454572..84fce41 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -4259,6 +4259,18 @@
 	rcuscale.kfree_rcu_test= [KNL]
 			Set to measure performance of kfree_rcu() flooding.
 
+	rcuscale.kfree_rcu_test_double= [KNL]
+			Test the double-argument variant of kfree_rcu().
+			If this parameter has the same value as
+			rcuscale.kfree_rcu_test_single, both the single-
+			and double-argument variants are tested.
+
+	rcuscale.kfree_rcu_test_single= [KNL]
+			Test the single-argument variant of kfree_rcu().
+			If this parameter has the same value as
+			rcuscale.kfree_rcu_test_double, both the single-
+			and double-argument variants are tested.
+
 	rcuscale.kfree_nthreads= [KNL]
 			The number of threads running loops of kfree_rcu().
 
diff --git a/kernel/rcu/rcuscale.c b/kernel/rcu/rcuscale.c
index 06491d5..dca51fe 100644
--- a/kernel/rcu/rcuscale.c
+++ b/kernel/rcu/rcuscale.c
@@ -625,6 +625,8 @@ rcu_scale_shutdown(void *arg)
 torture_param(int, kfree_nthreads, -1, "Number of threads running loops of kfree_rcu().");
 torture_param(int, kfree_alloc_num, 8000, "Number of allocations and frees done in an iteration.");
 torture_param(int, kfree_loops, 10, "Number of loops doing kfree_alloc_num allocations and frees.");
+torture_param(bool, kfree_rcu_test_double, false, "Do we run a kfree_rcu() double-argument scale test?");
+torture_param(bool, kfree_rcu_test_single, false, "Do we run a kfree_rcu() single-argument scale test?");
 
 static struct task_struct **kfree_reader_tasks;
 static int kfree_nrealthreads;
@@ -644,10 +646,13 @@ kfree_scale_thread(void *arg)
 	struct kfree_obj *alloc_ptr;
 	u64 start_time, end_time;
 	long long mem_begin, mem_during = 0;
+	bool kfree_rcu_test_both;
+	DEFINE_TORTURE_RANDOM(tr);
 
 	VERBOSE_SCALEOUT_STRING("kfree_scale_thread task started");
 	set_cpus_allowed_ptr(current, cpumask_of(me % nr_cpu_ids));
 	set_user_nice(current, MAX_NICE);
+	kfree_rcu_test_both = (kfree_rcu_test_single == kfree_rcu_test_double);
 
 	start_time = ktime_get_mono_fast_ns();
 
@@ -670,7 +675,15 @@ kfree_scale_thread(void *arg)
 			if (!alloc_ptr)
 				return -ENOMEM;
 
-			kfree_rcu(alloc_ptr, rh);
+			// By default kfree_rcu_test_single and kfree_rcu_test_double are
+			// initialized to false. If both have the same value (false or true)
+			// both are randomly tested, otherwise only the one with value true
+			// is tested.
+			if ((kfree_rcu_test_single && !kfree_rcu_test_double) ||
+					(kfree_rcu_test_both && torture_random(&tr) & 0x800))
+				kfree_rcu(alloc_ptr);
+			else
+				kfree_rcu(alloc_ptr, rh);
 		}
 
 		cond_resched();
