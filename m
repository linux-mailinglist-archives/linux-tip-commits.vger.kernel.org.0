Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDBD319E8F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:38:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231555AbhBLMin (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:38:43 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45334 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231290AbhBLMhv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:37:51 -0500
Date:   Fri, 12 Feb 2021 12:37:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133428;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=D3ZzONO2aw4aZbEbaANW8R5qrK+5uOhtldsfvw7IOhQ=;
        b=KJZTEiCLLH1/jbAtT5bP2j+ecNYo0xYlJqxfWTaou0HCUD4ZPlIDGQYvdFCUVt1e7L8F7N
        iEWjlKavIG8RuGS9VNtvnAvbmMEWTCzmeZ/lqPItRkhM03V1WwmBjgRAjK9/6ZTZU5keOM
        tQkpVuWzYxzzs81rXdifvGgdXHZ+luboTFwLanDciR+MuDkXAFvIg0v/hWcjupcN0btVKx
        pjcWwyvpZnmxhl5IGrJUFoqFgt3Ohefz8lP98f8Ng3OGESjGlSnmp0WR4hbi+SuyhHUWo7
        ZWe+YaSr2684CFEYvtdI2w0dQqbhYg7zQSlIJSBZMSfyhB8NHhU1k97hCDWf/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133428;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=D3ZzONO2aw4aZbEbaANW8R5qrK+5uOhtldsfvw7IOhQ=;
        b=0KW3b4ZQ2b6G5C0+guqqSLlUwpzkRhyzVzL1Ryy1/tT8/MeQbUTnymc5zidNv39LccT2e1
        ccKXL7vXezB5hBDA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] torture: Clean up after torture-test CPU hotplugging
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313342790.23325.16646815628221607098.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     0b962c8fe0e5c72a252b236814a6b6e9df799061
Gitweb:        https://git.kernel.org/tip/0b962c8fe0e5c72a252b236814a6b6e9df799061
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Sat, 19 Dec 2020 07:05:58 -08:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Wed, 06 Jan 2021 17:17:22 -08:00

torture: Clean up after torture-test CPU hotplugging

This commit puts all CPUs back online at the end of a torture test,
and also unconditionally puts them online at the beginning of the test,
rather than just in the case of built-in tests.  This allows torture tests
to behave in a predictable manner, whether built-in or based on modules.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/torture.c | 36 ++++++++++++++++++++++--------------
 1 file changed, 22 insertions(+), 14 deletions(-)

diff --git a/kernel/torture.c b/kernel/torture.c
index 93eeeb2..507a20b 100644
--- a/kernel/torture.c
+++ b/kernel/torture.c
@@ -292,6 +292,26 @@ bool torture_online(int cpu, long *n_onl_attempts, long *n_onl_successes,
 EXPORT_SYMBOL_GPL(torture_online);
 
 /*
+ * Get everything online at the beginning and ends of tests.
+ */
+static void torture_online_all(char *phase)
+{
+	int cpu;
+	int ret;
+
+	for_each_possible_cpu(cpu) {
+		if (cpu_online(cpu))
+			continue;
+		ret = add_cpu(cpu);
+		if (ret && verbose) {
+			pr_alert("%s" TORTURE_FLAG
+				 "%s: %s online %d: errno %d\n",
+				 __func__, phase, torture_type, cpu, ret);
+		}
+	}
+}
+
+/*
  * Execute random CPU-hotplug operations at the interval specified
  * by the onoff_interval.
  */
@@ -301,25 +321,12 @@ torture_onoff(void *arg)
 	int cpu;
 	int maxcpu = -1;
 	DEFINE_TORTURE_RANDOM(rand);
-	int ret;
 
 	VERBOSE_TOROUT_STRING("torture_onoff task started");
 	for_each_online_cpu(cpu)
 		maxcpu = cpu;
 	WARN_ON(maxcpu < 0);
-	if (!IS_MODULE(CONFIG_TORTURE_TEST)) {
-		for_each_possible_cpu(cpu) {
-			if (cpu_online(cpu))
-				continue;
-			ret = add_cpu(cpu);
-			if (ret && verbose) {
-				pr_alert("%s" TORTURE_FLAG
-					 "%s: Initial online %d: errno %d\n",
-					 __func__, torture_type, cpu, ret);
-			}
-		}
-	}
-
+	torture_online_all("Initial");
 	if (maxcpu == 0) {
 		VERBOSE_TOROUT_STRING("Only one CPU, so CPU-hotplug testing is disabled");
 		goto stop;
@@ -347,6 +354,7 @@ torture_onoff(void *arg)
 
 stop:
 	torture_kthread_stopping("torture_onoff");
+	torture_online_all("Final");
 	return 0;
 }
 
