Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E88203B5F75
	for <lists+linux-tip-commits@lfdr.de>; Mon, 28 Jun 2021 15:58:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbhF1OAb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 28 Jun 2021 10:00:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48016 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232057AbhF1OAb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 28 Jun 2021 10:00:31 -0400
Date:   Mon, 28 Jun 2021 13:58:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624888684;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AeRvvRXVkt0mphY2rDJkxwi/afbuo/0j/1ySOqexDs0=;
        b=WHRTRZQhQYZkhYtnLQw+jvEdMQs9Qfi2SCAcimNHYBt1L+1ujhzWlYGe1Gov49CHVWJMhq
        RH+JNeTt9tqd6h9hhSBlpTPRCK1IQQwsnlx+u0qd12Se4TKTvBC/w4RHRbT9D0ry0nWYzg
        AyIue5SPgfe2av9A11EbwqgXCl4zHpgvXtvyULxHybxPwjbThG6e3m3zjGvj4maP+Jq2La
        L7DdqwumuqnxzwRXeZt+64OFg0tYeC17Jm82kNtPM+zJ39x7klZfuZLB//nxZa3w9j0Y9N
        ToUEShmMUp9c+Cq9/yJ5HyLD341t0QrPFrmfn5mq75d5ZktFKxU7qDIy0VYonA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624888684;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AeRvvRXVkt0mphY2rDJkxwi/afbuo/0j/1ySOqexDs0=;
        b=Ar5rAg3NiNW+PJGlwznO5XaC3m6EqQJGbtmXqBCogzsow/J2DAIgWcwst3wzpLSmrwFPYl
        u0ab0tYjK4DMyHAg==
From:   "tip-bot2 for Hailong Liu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/sysctl: Move extern sysctl declarations to sched.h
Cc:     Hailong Liu <liu.hailong6@zte.com.cn>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210606115451.26745-1-liuhailongg6@163.com>
References: <20210606115451.26745-1-liuhailongg6@163.com>
MIME-Version: 1.0
Message-ID: <162488868357.395.16779027373045775244.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     18765447c3b7867b3f8cccde52dc9d822852e71b
Gitweb:        https://git.kernel.org/tip/18765447c3b7867b3f8cccde52dc9d822852e71b
Author:        Hailong Liu <liu.hailong6@zte.com.cn>
AuthorDate:    Sun, 06 Jun 2021 19:54:51 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 28 Jun 2021 15:42:25 +02:00

sched/sysctl: Move extern sysctl declarations to sched.h

Since commit '8a99b6833c88(sched: Move SCHED_DEBUG sysctl to debugfs)',
SCHED_DEBUG sysctls are moved to debugfs, so these extern sysctls in
include/linux/sched/sysctl.h are no longer needed for sysctl.c, even
some are no longer needed.

So move those extern sysctls that needed by kernel/sched/debug.c to
kernel/sched/sched.h, and remove others that are no longer needed.

Signed-off-by: Hailong Liu <liu.hailong6@zte.com.cn>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210606115451.26745-1-liuhailongg6@163.com
---
 include/linux/sched/sysctl.h | 18 ------------------
 kernel/sched/sched.h         | 15 +++++++++++++++
 2 files changed, 15 insertions(+), 18 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index db2c0f3..304f431 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -28,30 +28,12 @@ enum { sysctl_hung_task_timeout_secs = 0 };
 
 extern unsigned int sysctl_sched_child_runs_first;
 
-extern unsigned int sysctl_sched_latency;
-extern unsigned int sysctl_sched_min_granularity;
-extern unsigned int sysctl_sched_wakeup_granularity;
-
 enum sched_tunable_scaling {
 	SCHED_TUNABLESCALING_NONE,
 	SCHED_TUNABLESCALING_LOG,
 	SCHED_TUNABLESCALING_LINEAR,
 	SCHED_TUNABLESCALING_END,
 };
-extern unsigned int sysctl_sched_tunable_scaling;
-
-extern unsigned int sysctl_numa_balancing_scan_delay;
-extern unsigned int sysctl_numa_balancing_scan_period_min;
-extern unsigned int sysctl_numa_balancing_scan_period_max;
-extern unsigned int sysctl_numa_balancing_scan_size;
-
-#ifdef CONFIG_SCHED_DEBUG
-extern __read_mostly unsigned int sysctl_sched_migration_cost;
-extern __read_mostly unsigned int sysctl_sched_nr_migrate;
-
-extern int sysctl_resched_latency_warn_ms;
-extern int sysctl_resched_latency_warn_once;
-#endif
 
 /*
  *  control realtime throttling:
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index c80d42e..9a1c6ae 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2385,6 +2385,21 @@ extern void check_preempt_curr(struct rq *rq, struct task_struct *p, int flags);
 extern const_debug unsigned int sysctl_sched_nr_migrate;
 extern const_debug unsigned int sysctl_sched_migration_cost;
 
+#ifdef CONFIG_SCHED_DEBUG
+extern unsigned int sysctl_sched_latency;
+extern unsigned int sysctl_sched_min_granularity;
+extern unsigned int sysctl_sched_wakeup_granularity;
+extern int sysctl_resched_latency_warn_ms;
+extern int sysctl_resched_latency_warn_once;
+
+extern unsigned int sysctl_sched_tunable_scaling;
+
+extern unsigned int sysctl_numa_balancing_scan_delay;
+extern unsigned int sysctl_numa_balancing_scan_period_min;
+extern unsigned int sysctl_numa_balancing_scan_period_max;
+extern unsigned int sysctl_numa_balancing_scan_size;
+#endif
+
 #ifdef CONFIG_SCHED_HRTICK
 
 /*
