Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E49F037F885
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 May 2021 15:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbhEMNTi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 13 May 2021 09:19:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58540 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbhEMNSp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 13 May 2021 09:18:45 -0400
Date:   Thu, 13 May 2021 13:17:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620911849;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pdD2atJNz5M3Siye5fiRZ6HI0NEll37Xqb7g5LAdj10=;
        b=B5z+HKteye5Gh09MP/9zhHWPrxocm3q5rdfhRpKoFKI9cVz0kOpvT9OhKNKx/tyPiG9Fbt
        5tAm1HW/zdzb4ZBtI5xHDUs1fgoa9tZ22coQz0BBJbximwmkYDPfR0TyUhMDJag2U9NMrh
        rRsa2p9nMEC+lMOosfG6s6XzZzedmKxHn8T+D8UVWcBMjlavgu4LX7IvXUKqyef3i710RH
        b6Un+OyjTpYE86qU3w/x1+MNRkW6TxhPGMTdmpJ8nAxkMMcyv104/zXcTUcOUsBx+1Zhzy
        b7OitqNrHudw4kTSkkDAuZ+ZNL3HSxK8DknZzwXcfyvOWyHVbYaFBl+Fjn3zBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620911849;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pdD2atJNz5M3Siye5fiRZ6HI0NEll37Xqb7g5LAdj10=;
        b=kMtg9dv0OmYLNVbewgpziGi+ohqwchrUTx8OX73qobWUQy6AYwtITnJdVTxIttUAdBs6vm
        RfFg3ptwB1e3dIAg==
From:   "tip-bot2 for Yunfeng Ye" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/nohz] tick/nohz: Update idle_exittime on actual idle exit
Cc:     Yunfeng Ye <yeyunfeng@huawei.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210512232924.150322-5-frederic@kernel.org>
References: <20210512232924.150322-5-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <162091184863.29796.6829372078329871845.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/nohz branch of tip:

Commit-ID:     96c9b90396f9ab6caf13b4ebf00095818ac53b7f
Gitweb:        https://git.kernel.org/tip/96c9b90396f9ab6caf13b4ebf00095818ac53b7f
Author:        Yunfeng Ye <yeyunfeng@huawei.com>
AuthorDate:    Thu, 13 May 2021 01:29:18 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 13 May 2021 14:21:21 +02:00

tick/nohz: Update idle_exittime on actual idle exit

The idle_exittime field of tick_sched is used to record the time when
the idle state was left. but currently the idle_exittime is updated in
the function tick_nohz_restart_sched_tick(), which is not always in idle
state when nohz_full is configured:

  tick_irq_exit
    tick_nohz_irq_exit
      tick_nohz_full_update_tick
        tick_nohz_restart_sched_tick
          ts->idle_exittime = now;

It's thus overwritten by mistake on nohz_full tick restart. Move the
update to the appropriate idle exit path instead.

Signed-off-by: Yunfeng Ye <yeyunfeng@huawei.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210512232924.150322-5-frederic@kernel.org
---
 kernel/time/tick-sched.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index 1afa759..89ec0ab 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -921,8 +921,6 @@ static void tick_nohz_restart_sched_tick(struct tick_sched *ts, ktime_t now)
 	 * Cancel the scheduled timer and restore the tick
 	 */
 	ts->tick_stopped  = 0;
-	ts->idle_exittime = now;
-
 	tick_nohz_restart(ts, now);
 }
 
@@ -1194,10 +1192,13 @@ unsigned long tick_nohz_get_idle_calls(void)
 	return ts->idle_calls;
 }
 
-static void tick_nohz_account_idle_ticks(struct tick_sched *ts)
+static void tick_nohz_account_idle_time(struct tick_sched *ts,
+					ktime_t now)
 {
 	unsigned long ticks;
 
+	ts->idle_exittime = now;
+
 	if (vtime_accounting_enabled_this_cpu())
 		return;
 	/*
@@ -1218,8 +1219,9 @@ void tick_nohz_idle_restart_tick(void)
 	struct tick_sched *ts = this_cpu_ptr(&tick_cpu_sched);
 
 	if (ts->tick_stopped) {
-		tick_nohz_restart_sched_tick(ts, ktime_get());
-		tick_nohz_account_idle_ticks(ts);
+		ktime_t now = ktime_get();
+		tick_nohz_restart_sched_tick(ts, now);
+		tick_nohz_account_idle_time(ts, now);
 	}
 }
 
@@ -1230,7 +1232,7 @@ static void tick_nohz_idle_update_tick(struct tick_sched *ts, ktime_t now)
 	else
 		tick_nohz_restart_sched_tick(ts, now);
 
-	tick_nohz_account_idle_ticks(ts);
+	tick_nohz_account_idle_time(ts, now);
 }
 
 /**
