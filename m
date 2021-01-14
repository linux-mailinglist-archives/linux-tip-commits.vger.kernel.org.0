Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C7DAE2F5FF7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Jan 2021 12:31:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728199AbhANL3t (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 14 Jan 2021 06:29:49 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58904 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728055AbhANL3s (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 14 Jan 2021 06:29:48 -0500
Date:   Thu, 14 Jan 2021 11:29:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610623745;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sn9wm9AmwvZJdzJF1wjtaq0gmxKSO8U0ba6MoztGgcM=;
        b=ochAxpRG+bZLN+i/lOOAJLlGkC3dtBZhXBTzRcCvEvi128wOwUC1raUWCyWEzDn5Rv30Yf
        b37SYy5CeGZ9hCDGgnpbUqaSFhTdFajsNyrR5EsuWapB5L+9RoSp6JfJI0NfPQabbAJqiE
        Z3eQly+RENbL3TBxScDESL4Bann8LdJ0ylnG/D1KriaYB6vnsFEX4U2xn1WQLu5PQnoeTS
        tiIGBZzf/iuKO9LB4bYM78+nQRgG+m+sFepKp1VeRBx5EfenrdT0uTF4PiahvS/ex8THpQ
        FoZDHC55WqAwWwylk03kYn6IdFFq3R6/VlLIPtvAy9vHE4KUbYmjN227VQXOEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610623745;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Sn9wm9AmwvZJdzJF1wjtaq0gmxKSO8U0ba6MoztGgcM=;
        b=xAEKSYpaIRDuFtmZoMxhL6CpdoqPkutiKhaB+b5tVkKEVqOrNABJ23ENWHQ5DWdBlYH26b
        GvZFSlQckzIiiJCw==
From:   "tip-bot2 for Hui Su" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Use task_current() instead of 'rq->curr == p'
Cc:     Hui Su <sh_def@163.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201030173223.GA52339@rlk>
References: <20201030173223.GA52339@rlk>
MIME-Version: 1.0
Message-ID: <161062374538.414.11462783395036200170.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     65bcf072e20ed7597caa902f170f293662b0af3c
Gitweb:        https://git.kernel.org/tip/65bcf072e20ed7597caa902f170f293662b0af3c
Author:        Hui Su <sh_def@163.com>
AuthorDate:    Sat, 31 Oct 2020 01:32:23 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 14 Jan 2021 11:20:11 +01:00

sched: Use task_current() instead of 'rq->curr == p'

Use the task_current() function where appropriate.

No functional change.

Signed-off-by: Hui Su <sh_def@163.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
Link: https://lkml.kernel.org/r/20201030173223.GA52339@rlk
---
 kernel/sched/deadline.c | 2 +-
 kernel/sched/debug.c    | 2 +-
 kernel/sched/fair.c     | 6 +++---
 kernel/sched/rt.c       | 2 +-
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 75686c6..5421782 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2514,7 +2514,7 @@ static void switched_to_dl(struct rq *rq, struct task_struct *p)
 static void prio_changed_dl(struct rq *rq, struct task_struct *p,
 			    int oldprio)
 {
-	if (task_on_rq_queued(p) || rq->curr == p) {
+	if (task_on_rq_queued(p) || task_current(rq, p)) {
 #ifdef CONFIG_SMP
 		/*
 		 * This might be too much, but unfortunately
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 2357921..486f403 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -486,7 +486,7 @@ static char *task_group_path(struct task_group *tg)
 static void
 print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
 {
-	if (rq->curr == p)
+	if (task_current(rq, p))
 		SEQ_printf(m, ">R");
 	else
 		SEQ_printf(m, " %c", task_state_to_char(p));
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 53802b7..197a514 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5430,7 +5430,7 @@ static void hrtick_start_fair(struct rq *rq, struct task_struct *p)
 		s64 delta = slice - ran;
 
 		if (delta < 0) {
-			if (rq->curr == p)
+			if (task_current(rq, p))
 				resched_curr(rq);
 			return;
 		}
@@ -10829,7 +10829,7 @@ prio_changed_fair(struct rq *rq, struct task_struct *p, int oldprio)
 	 * our priority decreased, or if we are not currently running on
 	 * this runqueue and our priority is higher than the current's
 	 */
-	if (rq->curr == p) {
+	if (task_current(rq, p)) {
 		if (p->prio > oldprio)
 			resched_curr(rq);
 	} else
@@ -10962,7 +10962,7 @@ static void switched_to_fair(struct rq *rq, struct task_struct *p)
 		 * kick off the schedule if running, otherwise just see
 		 * if we can still preempt the current task.
 		 */
-		if (rq->curr == p)
+		if (task_current(rq, p))
 			resched_curr(rq);
 		else
 			check_preempt_curr(rq, p, 0);
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index dbe4629..8f720b7 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2357,7 +2357,7 @@ prio_changed_rt(struct rq *rq, struct task_struct *p, int oldprio)
 	if (!task_on_rq_queued(p))
 		return;
 
-	if (rq->curr == p) {
+	if (task_current(rq, p)) {
 #ifdef CONFIG_SMP
 		/*
 		 * If our priority decreases while running, we
