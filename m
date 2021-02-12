Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BABB2319EEF
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:47:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231814AbhBLMnj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:43:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45850 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbhBLMln (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:41:43 -0500
Date:   Fri, 12 Feb 2021 12:37:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133445;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0oiB1UmxtAr9Qrus5yDC0domQdQhNW0pSSEXH6qpj5Q=;
        b=m3SsgLuZUGJTsy+VSLfuRP2GxlfJJHg4y3JEFzelvlFrdWozX45XOExAeLuWAh8ns3l+bb
        HkU+9Teq+Rxo6yGHTtDLWXNK4P+pYuv+O+MlBcCmy1xNJ/yj2DKcHutzSMS2DOuI7vSG3w
        QOInoZnfnLjHe+TFPJmnVXKxjXzOn0qq5TizDi56PIDeXE0a0Z+r7VU2UK/kQZkYJUPbhm
        pNkO78aTjsd5weH0R7qEkMKfDKOPnbCE4nZdqkpExpzl44dMLU3ugdyz+gxUDRw3kti6oz
        GfVshUtsfJBgqRy5987WY1zftfb9IOehR6LlWfBmV88oDaKGGkdMwTGO15ZqTw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133445;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=0oiB1UmxtAr9Qrus5yDC0domQdQhNW0pSSEXH6qpj5Q=;
        b=eT9ocLNZO0W6Md/Fm3Sqbvn44dthyUxsjmoNNeTC0mXcXp86tDI4jsP+p8FXU+vDbI6BXx
        zpl05PfrY5a5lYCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] sched/core: Allow try_invoke_on_locked_down_task()
 with irqs disabled
Cc:     syzbot+cb3b69ae80afd6535b0e@syzkaller.appspotmail.com,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313344449.23325.1624790552720937291.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     1b7af295541d75535374325fd617944534853919
Gitweb:        https://git.kernel.org/tip/1b7af295541d75535374325fd617944534853919
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sat, 29 Aug 2020 10:22:24 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 04 Jan 2021 15:49:52 -08:00

sched/core: Allow try_invoke_on_locked_down_task() with irqs disabled

The try_invoke_on_locked_down_task() function currently requires
that interrupts be enabled, but it is called with interrupts
disabled from rcu_print_task_stall(), resulting in an "IRQs not
enabled as expected" diagnostic.  This commit therefore updates
try_invoke_on_locked_down_task() to use raw_spin_lock_irqsave() instead
of raw_spin_lock_irq(), thus allowing use from either context.

Link: https://lore.kernel.org/lkml/000000000000903d5805ab908fc4@google.com/
Link: https://lore.kernel.org/lkml/20200928075729.GC2611@hirez.programming.kicks-ass.net/
Reported-by: syzbot+cb3b69ae80afd6535b0e@syzkaller.appspotmail.com
Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/sched/core.c |  9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index e7e4534..f768bb0 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2989,7 +2989,7 @@ out:
 
 /**
  * try_invoke_on_locked_down_task - Invoke a function on task in fixed state
- * @p: Process for which the function is to be invoked.
+ * @p: Process for which the function is to be invoked, can be @current.
  * @func: Function to invoke.
  * @arg: Argument to function.
  *
@@ -3007,12 +3007,11 @@ out:
  */
 bool try_invoke_on_locked_down_task(struct task_struct *p, bool (*func)(struct task_struct *t, void *arg), void *arg)
 {
-	bool ret = false;
 	struct rq_flags rf;
+	bool ret = false;
 	struct rq *rq;
 
-	lockdep_assert_irqs_enabled();
-	raw_spin_lock_irq(&p->pi_lock);
+	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
 	if (p->on_rq) {
 		rq = __task_rq_lock(p, &rf);
 		if (task_rq(p) == rq)
@@ -3029,7 +3028,7 @@ bool try_invoke_on_locked_down_task(struct task_struct *p, bool (*func)(struct t
 				ret = func(p, arg);
 		}
 	}
-	raw_spin_unlock_irq(&p->pi_lock);
+	raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
 	return ret;
 }
 
