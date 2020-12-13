Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEE092D8FD4
	for <lists+linux-tip-commits@lfdr.de>; Sun, 13 Dec 2020 20:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393181AbgLMTDx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 13 Dec 2020 14:03:53 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46580 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727617AbgLMTBs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 13 Dec 2020 14:01:48 -0500
Date:   Sun, 13 Dec 2020 19:01:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607886066;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=kOGcz7pprpHlXyNUhrjS6mK+wGYnNchqzW5XTBPzgQk=;
        b=xNdCcaJ3xVOmseUz+MUChAK3SNRwufY6lmmQaV2ZAl8Zvk+AlAmX7jmZFhckYteOGK04A8
        K1ykF36TBOTdSExt8zQFSYLO5Vwucd75S69Z564+3WJvfjW7IA7MDP/BeuePEFzyKvD2/d
        5xuuHlfNaG4uUNwp8AnC+BsJkPEYj+McbDtEe6gFH0NMhb+pJk2b4g9iJWIfK5xxH+CcKV
        m8ohqk5ru1MlLKZUaSY9MTDO/k9FmWJM6dv8fEy0dMMfIuNm8UKtuFxPTs9MI20Zvo7Fmf
        ApCFxjscGiL2EBcs4Q24uAyz0vIPgW3d8lIMVlcBpbVeB4PWN8ZqtmI+gDyXhg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607886066;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=kOGcz7pprpHlXyNUhrjS6mK+wGYnNchqzW5XTBPzgQk=;
        b=qOAGmJ3sSgtFE0m+k5sfuVUsDTJetuvvF5kQIBI93parPqXpsP8VB4+jOdjQnc32P116bC
        v71vbpHKy9nTzyDA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu-tasks: Make the units of ->init_fract be jiffies
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <160788606634.3364.2265028186602312293.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     75dc2da5ecd65bdcbfc4d59b9d9b7342c61fe374
Gitweb:        https://git.kernel.org/tip/75dc2da5ecd65bdcbfc4d59b9d9b7342c61fe374
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 17 Sep 2020 16:17:17 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Fri, 06 Nov 2020 17:17:59 -08:00

rcu-tasks: Make the units of ->init_fract be jiffies

Currently, the units of ->init_fract are milliseconds while those of
->gp_sleep are jiffies.  For consistency with each other and with the
argument of schedule_timeout_idle(), this commit changes the units of
->init_fract to jiffies.

This change does affect the backoff algorithm, but only on systems where
HZ is not 1000, and even there the change makes more sense, given that the
current setup would "back off" to the same number of jiffies repeatedly.
In contrast, with this change, the number of jiffies waited increases
on each pass through the loop in the rcu_tasks_wait_gp() function.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tasks.h | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tasks.h b/kernel/rcu/tasks.h
index 0b45989..35bdcfd 100644
--- a/kernel/rcu/tasks.h
+++ b/kernel/rcu/tasks.h
@@ -335,8 +335,6 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 
 	// Start off with initial wait and slowly back off to 1 HZ wait.
 	fract = rtp->init_fract;
-	if (fract > HZ)
-		fract = HZ;
 
 	while (!list_empty(&holdouts)) {
 		bool firstreport;
@@ -345,10 +343,10 @@ static void rcu_tasks_wait_gp(struct rcu_tasks *rtp)
 
 		/* Slowly back off waiting for holdouts */
 		set_tasks_gp_state(rtp, RTGS_WAIT_SCAN_HOLDOUTS);
-		schedule_timeout_idle(HZ/fract);
+		schedule_timeout_idle(fract);
 
-		if (fract > 1)
-			fract--;
+		if (fract < HZ)
+			fract++;
 
 		rtst = READ_ONCE(rcu_task_stall_timeout);
 		needreport = rtst > 0 && time_after(jiffies, lastreport + rtst);
@@ -557,7 +555,7 @@ EXPORT_SYMBOL_GPL(rcu_barrier_tasks);
 static int __init rcu_spawn_tasks_kthread(void)
 {
 	rcu_tasks.gp_sleep = HZ / 10;
-	rcu_tasks.init_fract = 10;
+	rcu_tasks.init_fract = HZ / 10;
 	rcu_tasks.pregp_func = rcu_tasks_pregp_step;
 	rcu_tasks.pertask_func = rcu_tasks_pertask;
 	rcu_tasks.postscan_func = rcu_tasks_postscan;
@@ -1178,12 +1176,12 @@ static int __init rcu_spawn_tasks_trace_kthread(void)
 {
 	if (IS_ENABLED(CONFIG_TASKS_TRACE_RCU_READ_MB)) {
 		rcu_tasks_trace.gp_sleep = HZ / 10;
-		rcu_tasks_trace.init_fract = 10;
+		rcu_tasks_trace.init_fract = HZ / 10;
 	} else {
 		rcu_tasks_trace.gp_sleep = HZ / 200;
 		if (rcu_tasks_trace.gp_sleep <= 0)
 			rcu_tasks_trace.gp_sleep = 1;
-		rcu_tasks_trace.init_fract = HZ / 5;
+		rcu_tasks_trace.init_fract = HZ / 200;
 		if (rcu_tasks_trace.init_fract <= 0)
 			rcu_tasks_trace.init_fract = 1;
 	}
