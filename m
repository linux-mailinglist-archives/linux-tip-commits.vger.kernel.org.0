Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DDF2319EE8
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:47:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbhBLMnO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:43:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45414 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbhBLMkm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:40:42 -0500
Date:   Fri, 12 Feb 2021 12:37:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133444;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2pa/tvKC8kX87YpN0GJLxqnBZJ43AuDqAJGMs4EEDnw=;
        b=DjL6Ar24YHs+cF/EjXnK/eAgKifjNpt36QjvPcG741Nxg1VC0EQnJWEUr5fL2hDiIMc1Bh
        DZSKGku1SKhKGe4XPHkNwKYCvwyc5t0wC19pHcHDz24fiTjK5igRlL/998tRkuq7Xi3U6d
        0pE8mOS1gl3/vQDsj9GW5pwi66AWhs3q39QlAKn1RKhylUd9v67e0hg31tk+vwY5owIMsP
        DQsCwCr7DwnIqQeoZag5VNWBv5SoWsuPACbgS64irmGTZ6NVCdrl7hjlNeL1N8e7K+dWrQ
        0eBbsUHIWBAaUBAZMKsegbSuMkIPsvf5qYHrV5CAwi/NGXnOOclyyJueY9U81Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133444;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=2pa/tvKC8kX87YpN0GJLxqnBZJ43AuDqAJGMs4EEDnw=;
        b=G3PGzo+wovI+FwUFMVAG9Tjhfhzh1UASizoEUaYz1dsepGgGWYYGIM8aKd355nCOvsz32P
        aTZLUSp653fyu/Aw==
From:   "tip-bot2 for Uladzislau Rezki (Sony)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu-tasks: Add RCU-tasks self tests
Cc:     "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313344357.23325.6360256353255340492.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     bfba7ed084f8ab0269a5a1d2f51b07865456c334
Gitweb:        https://git.kernel.org/tip/bfba7ed084f8ab0269a5a1d2f51b07865456c334
Author:        Uladzislau Rezki (Sony) <urezki@gmail.com>
AuthorDate:    Wed, 09 Dec 2020 21:27:32 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 15:54:49 -08:00

rcu-tasks: Add RCU-tasks self tests

This commit adds self tests for early-boot use of RCU-tasks grace periods.
It tests all three variants (Rude, Tasks, and Tasks Trace) and covers
both synchronous (e.g., synchronize_rcu_tasks()) and asynchronous (e.g.,
call_rcu_tasks()) grace-period APIs.

Self-tests are run only in kernels built with CONFIG_PROVE_RCU=y.

Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
[ paulmck: Handle CONFIG_PROVE_RCU=n and identify test cases' callbacks. ]
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 79 +++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 79 insertions(+)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 73bbe79..74767d3 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -1231,6 +1231,82 @@ void show_rcu_tasks_gp_kthreads(void)
 }
 #endif /* #ifndef CONFIG_TINY_RCU */
 
+#ifdef CONFIG_PROVE_RCU
+struct rcu_tasks_test_desc {
+	struct rcu_head rh;
+	const char *name;
+	bool notrun;
+};
+
+static struct rcu_tasks_test_desc tests[] = {
+	{
+		.name = "call_rcu_tasks()",
+		/* If not defined, the test is skipped. */
+		.notrun = !IS_ENABLED(CONFIG_TASKS_RCU),
+	},
+	{
+		.name = "call_rcu_tasks_rude()",
+		/* If not defined, the test is skipped. */
+		.notrun = !IS_ENABLED(CONFIG_TASKS_RUDE_RCU),
+	},
+	{
+		.name = "call_rcu_tasks_trace()",
+		/* If not defined, the test is skipped. */
+		.notrun = !IS_ENABLED(CONFIG_TASKS_TRACE_RCU)
+	}
+};
+
+static void test_rcu_tasks_callback(struct rcu_head *rhp)
+{
+	struct rcu_tasks_test_desc *rttd =
+		container_of(rhp, struct rcu_tasks_test_desc, rh);
+
+	pr_info("Callback from %s invoked.\n", rttd->name);
+
+	rttd->notrun = true;
+}
+
+static void rcu_tasks_initiate_self_tests(void)
+{
+	pr_info("Running RCU-tasks wait API self tests\n");
+#ifdef CONFIG_TASKS_RCU
+	synchronize_rcu_tasks();
+	call_rcu_tasks(&tests[0].rh, test_rcu_tasks_callback);
+#endif
+
+#ifdef CONFIG_TASKS_RUDE_RCU
+	synchronize_rcu_tasks_rude();
+	call_rcu_tasks_rude(&tests[1].rh, test_rcu_tasks_callback);
+#endif
+
+#ifdef CONFIG_TASKS_TRACE_RCU
+	synchronize_rcu_tasks_trace();
+	call_rcu_tasks_trace(&tests[2].rh, test_rcu_tasks_callback);
+#endif
+}
+
+static int rcu_tasks_verify_self_tests(void)
+{
+	int ret = 0;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(tests); i++) {
+		if (!tests[i].notrun) {		// still hanging.
+			pr_err("%s has been failed.\n", tests[i].name);
+			ret = -1;
+		}
+	}
+
+	if (ret)
+		WARN_ON(1);
+
+	return ret;
+}
+late_initcall(rcu_tasks_verify_self_tests);
+#else /* #ifdef CONFIG_PROVE_RCU */
+static void rcu_tasks_initiate_self_tests(void) { }
+#endif /* #else #ifdef CONFIG_PROVE_RCU */
+
 void __init rcu_init_tasks_generic(void)
 {
 #ifdef CONFIG_TASKS_RCU
@@ -1244,6 +1320,9 @@ void __init rcu_init_tasks_generic(void)
 #ifdef CONFIG_TASKS_TRACE_RCU
 	rcu_spawn_tasks_trace_kthread();
 #endif
+
+	// Run the self-tests.
+	rcu_tasks_initiate_self_tests();
 }
 
 #else /* #ifdef CONFIG_TASKS_RCU_GENERIC */
