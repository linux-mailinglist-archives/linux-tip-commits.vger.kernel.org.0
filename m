Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 53DD337F887
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 May 2021 15:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233945AbhEMNTk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 13 May 2021 09:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233950AbhEMNTF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 13 May 2021 09:19:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06CC0C0613ED;
        Thu, 13 May 2021 06:17:37 -0700 (PDT)
Date:   Thu, 13 May 2021 13:17:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620911850;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RutoUzK4xwcvEKA4oaKgdmga9hHsy5VloH/Y/0vKoPg=;
        b=LSAwjVnrg1sWf5PJwblqkOft8ZhT4tWBy+PYK+NJTdNF7F8QKmG6tJz9Qd8ugFigAtrG9L
        /+9G+7w6H+aprb6JTf40Vwy/pzv2/fLz/A1pgyC5Ou0uUchZFgeUISD0nqySjWqPGl2QVU
        ORrwChQbaTiqJ5f+a3iRCro8cZ0oGO0YWHl7deG8R8F8wCnpL5ZVnmii7ftV0dlowFNgPa
        UFAicPxyzX8mx/FJ4RVwlnwKp2oB9t6VBKJnZUeFMgU9x1LS/NJZby4wHVbPHSHLIZrH9X
        LcMcBgejJ/64Yxc4/tK7PaniAHTaDZoyZwmHfTt5AZZYqnGCuDh43Q+6VuyiiA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620911850;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RutoUzK4xwcvEKA4oaKgdmga9hHsy5VloH/Y/0vKoPg=;
        b=t1LMsOTTcfRbmmObAv5MPcXzVInv5AtSJbvMHD/ISvIfzBJxjZRAo/8+532t02kYcsMxWL
        XXNOqAYYFR5d+cBg==
From:   "tip-bot2 for Yunfeng Ye" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/nohz] tick/nohz: Conditionally restart tick on idle exit
Cc:     Yunfeng Ye <yeyunfeng@huawei.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210512232924.150322-3-frederic@kernel.org>
References: <20210512232924.150322-3-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <162091184942.29796.4815200413212139734.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/nohz branch of tip:

Commit-ID:     a5183862e76fdc25f36b39c2489b816a5c66e2e5
Gitweb:        https://git.kernel.org/tip/a5183862e76fdc25f36b39c2489b816a5c66e2e5
Author:        Yunfeng Ye <yeyunfeng@huawei.com>
AuthorDate:    Thu, 13 May 2021 01:29:16 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 13 May 2021 14:21:21 +02:00

tick/nohz: Conditionally restart tick on idle exit

In nohz_full mode, switching from idle to a task will unconditionally
issue a tick restart. If the task is alone in the runqueue or is the
highest priority, the tick will fire once then eventually stop. But that
alone is still undesired noise.

Therefore, only restart the tick on idle exit when it's strictly
necessary.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210512232924.150322-3-frederic@kernel.org
---
 kernel/time/tick-sched.c | 42 +++++++++++++++++++++++++--------------
 1 file changed, 27 insertions(+), 15 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 828b091..05c1ce1 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -926,22 +926,28 @@ static void tick_nohz_restart_sched_tick(struct tick_sched *ts, ktime_t now)
 	tick_nohz_restart(ts, now);
 }
 
-static void tick_nohz_full_update_tick(struct tick_sched *ts)
+static void __tick_nohz_full_update_tick(struct tick_sched *ts,
+					 ktime_t now)
 {
 #ifdef CONFIG_NO_HZ_FULL
 	int cpu = smp_processor_id();
 
-	if (!tick_nohz_full_cpu(cpu))
+	if (can_stop_full_tick(cpu, ts))
+		tick_nohz_stop_sched_tick(ts, cpu);
+	else if (ts->tick_stopped)
+		tick_nohz_restart_sched_tick(ts, now);
+#endif
+}
+
+static void tick_nohz_full_update_tick(struct tick_sched *ts)
+{
+	if (!tick_nohz_full_cpu(smp_processor_id()))
 		return;
 
 	if (!ts->tick_stopped && ts->nohz_mode == NOHZ_MODE_INACTIVE)
 		return;
 
-	if (can_stop_full_tick(cpu, ts))
-		tick_nohz_stop_sched_tick(ts, cpu);
-	else if (ts->tick_stopped)
-		tick_nohz_restart_sched_tick(ts, ktime_get());
-#endif
+	__tick_nohz_full_update_tick(ts, ktime_get());
 }
 
 static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
@@ -1209,18 +1215,24 @@ static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
 #endif
 }
 
-static void __tick_nohz_idle_restart_tick(struct tick_sched *ts, ktime_t now)
+void tick_nohz_idle_restart_tick(void)
 {
-	tick_nohz_restart_sched_tick(ts, now);
-	tick_nohz_account_idle_ticks(ts);
+	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
+
+	if (ts->tick_stopped) {
+		tick_nohz_restart_sched_tick(ts, ktime_get());
+		tick_nohz_account_idle_ticks(ts);
+	}
 }
 
-void tick_nohz_idle_restart_tick(void)
+static void tick_nohz_idle_update_tick(struct tick_sched *ts, ktime_t now)
 {
-	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
+	if (tick_nohz_full_cpu(smp_processor_id()))
+		__tick_nohz_full_update_tick(ts, now);
+	else
+		tick_nohz_restart_sched_tick(ts, now);
 
-	if (ts->tick_stopped)
-		__tick_nohz_idle_restart_tick(ts, ktime_get());
+	tick_nohz_account_idle_ticks(ts);
 }
 
 /**
@@ -1252,7 +1264,7 @@ void tick_nohz_idle_exit(void)
 		tick_nohz_stop_idle(ts, now);
 
 	if (tick_stopped)
-		__tick_nohz_idle_restart_tick(ts, now);
+		tick_nohz_idle_update_tick(ts, now);
 
 	local_irq_enable();
 }
