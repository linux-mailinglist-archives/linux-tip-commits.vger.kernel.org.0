Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDE3231DA30
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Feb 2021 14:20:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232800AbhBQNTV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Feb 2021 08:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232892AbhBQNSz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Feb 2021 08:18:55 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B254C061793;
        Wed, 17 Feb 2021 05:17:36 -0800 (PST)
Date:   Wed, 17 Feb 2021 13:17:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613567854;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iDPBjeZIMGxM1a0tOcBGdpQki+xs6xNy1iGeFMzgdTU=;
        b=mPdeCLEM5ne2KViEAiBy0cS46gA8MxpmcVhuPJuH6wTBHd0RiEdQqU3afV94b37YlGTmJW
        B7Wzo1hEWL25RQFH/S+OLampbjLuVTqtCDoWevu340x8aEbxzSDgRZg1LiGfncdBDpUftl
        vMF0RTkkxta82PvOmDJnc4SkIY6W8HrgyJq4JgzoioAFvCywJmmI/jbs5yqPllzVqz0GVi
        tEL3kkfpBejcJmuXjO7595zXoXsu/TdGsrCLvGaTCVnIwq3S2UI7x3hovHNlehg6Q1turm
        g66fsdH8+fNfuLjnA10tPZijFVxdVsyGUc65E1nUAxK+QtvTGzmqo1pFZC4wWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613567854;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iDPBjeZIMGxM1a0tOcBGdpQki+xs6xNy1iGeFMzgdTU=;
        b=HKEwQik+Nb/WmGCbUQZts09W4J0IgzcvPQmxJzUjqMH5d980EJZZZgvsXK+B6/IJgAfTy4
        SZuKgzUUu4cr7yAA==
From:   "tip-bot2 for Peter Zijlstra (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] preempt/dynamic: Support dynamic preempt with
 preempt= boot option
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210118141223.123667-9-frederic@kernel.org>
References: <20210118141223.123667-9-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <161356785408.20312.1381424388757634553.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     826bfeb37bb4302ee6042f330c4c0c757152bdb8
Gitweb:        https://git.kernel.org/tip/826bfeb37bb4302ee6042f330c4c0c757152bdb8
Author:        Peter Zijlstra (Intel) <peterz@infradead.org>
AuthorDate:    Mon, 18 Jan 2021 15:12:23 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Feb 2021 14:12:42 +01:00

preempt/dynamic: Support dynamic preempt with preempt= boot option

Support the preempt= boot option and patch the static call sites
accordingly.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20210118141223.123667-9-frederic@kernel.org
---
 kernel/sched/core.c | 68 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 880611c..0c06717 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5328,9 +5328,75 @@ DEFINE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func);
 EXPORT_STATIC_CALL(preempt_schedule_notrace);
 #endif
 
-
 #endif /* CONFIG_PREEMPTION */
 
+#ifdef CONFIG_PREEMPT_DYNAMIC
+
+#include <linux/entry-common.h>
+
+/*
+ * SC:cond_resched
+ * SC:might_resched
+ * SC:preempt_schedule
+ * SC:preempt_schedule_notrace
+ * SC:irqentry_exit_cond_resched
+ *
+ *
+ * NONE:
+ *   cond_resched               <- __cond_resched
+ *   might_resched              <- RET0
+ *   preempt_schedule           <- NOP
+ *   preempt_schedule_notrace   <- NOP
+ *   irqentry_exit_cond_resched <- NOP
+ *
+ * VOLUNTARY:
+ *   cond_resched               <- __cond_resched
+ *   might_resched              <- __cond_resched
+ *   preempt_schedule           <- NOP
+ *   preempt_schedule_notrace   <- NOP
+ *   irqentry_exit_cond_resched <- NOP
+ *
+ * FULL:
+ *   cond_resched               <- RET0
+ *   might_resched              <- RET0
+ *   preempt_schedule           <- preempt_schedule
+ *   preempt_schedule_notrace   <- preempt_schedule_notrace
+ *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
+ */
+static int __init setup_preempt_mode(char *str)
+{
+	if (!strcmp(str, "none")) {
+		static_call_update(cond_resched, __cond_resched);
+		static_call_update(might_resched, (typeof(&__cond_resched)) __static_call_return0);
+		static_call_update(preempt_schedule, (typeof(&preempt_schedule)) NULL);
+		static_call_update(preempt_schedule_notrace, (typeof(&preempt_schedule_notrace)) NULL);
+		static_call_update(irqentry_exit_cond_resched, (typeof(&irqentry_exit_cond_resched)) NULL);
+		pr_info("Dynamic Preempt: %s\n", str);
+	} else if (!strcmp(str, "voluntary")) {
+		static_call_update(cond_resched, __cond_resched);
+		static_call_update(might_resched, __cond_resched);
+		static_call_update(preempt_schedule, (typeof(&preempt_schedule)) NULL);
+		static_call_update(preempt_schedule_notrace, (typeof(&preempt_schedule_notrace)) NULL);
+		static_call_update(irqentry_exit_cond_resched, (typeof(&irqentry_exit_cond_resched)) NULL);
+		pr_info("Dynamic Preempt: %s\n", str);
+	} else if (!strcmp(str, "full")) {
+		static_call_update(cond_resched, (typeof(&__cond_resched)) __static_call_return0);
+		static_call_update(might_resched, (typeof(&__cond_resched)) __static_call_return0);
+		static_call_update(preempt_schedule, __preempt_schedule_func);
+		static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
+		static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+		pr_info("Dynamic Preempt: %s\n", str);
+	} else {
+		pr_warn("Dynamic Preempt: Unsupported preempt mode %s, default to full\n", str);
+		return 1;
+	}
+	return 0;
+}
+__setup("preempt=", setup_preempt_mode);
+
+#endif /* CONFIG_PREEMPT_DYNAMIC */
+
+
 /*
  * This is the entry point to schedule() from kernel preemption
  * off of irq context.
