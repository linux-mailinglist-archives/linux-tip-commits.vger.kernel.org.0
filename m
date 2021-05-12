Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C923637BA69
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 12:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbhELK3o (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 06:29:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50518 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbhELK3h (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 06:29:37 -0400
Date:   Wed, 12 May 2021 10:28:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620815308;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MnZGo0xdy0sCWmf4nljpjIsemqruH0si20tY2TeLtiI=;
        b=Mt73lxkvwAnZbD/wIS4anPbUpMztW7bVQOtsU/Uan5aP5Xk/ZxJ4jl+tGY2OG7QwQ7UkmY
        NUFyOzz6m45u1JPUwXBFawNOlojrGGo8LV83FAx5Z/QUdTpFxX3O3nIVCG6FW5hWPXJvNU
        YXzrJfDBbIBAK+1ALVSXwKTDqrZ3bHBZIy3JXpNlhZ1lUeu6ESPiezS9wfA58A7NMWu6vI
        X20JoWJgc6dmNWS/mZBPmkyzxSb4dKzm+wEJp3sTlFkFQK2qpcikMvee2PT3yDzjkRNmS5
        ExmT4q6+6Kl8V37YG3iC5ziOSIkeEyoP/zFERVjkuxxa2awc9aRWViWVGmg7yw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620815308;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MnZGo0xdy0sCWmf4nljpjIsemqruH0si20tY2TeLtiI=;
        b=5meqwhBtk2yLml3/lLJPKog+IAtgT3ToJNPExEYeg5iTFGhy4b0+MHA6PKkYjX0NoDdQFY
        //cALuPrJBHxAqDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Provide raw_spin_rq_*lock*() helpers
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Don Hiatt <dhiatt@digitalocean.com>,
        Hongyu Ning <hongyu.ning@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210422123308.075967879@infradead.org>
References: <20210422123308.075967879@infradead.org>
MIME-Version: 1.0
Message-ID: <162081530784.29796.6289037347348480162.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     39d371b7c0c299d489041884d005aacc4bba8c15
Gitweb:        https://git.kernel.org/tip/39d371b7c0c299d489041884d005aacc4bba8c15
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 02 Mar 2021 12:13:13 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 12 May 2021 11:43:26 +02:00

sched: Provide raw_spin_rq_*lock*() helpers

In prepration for playing games with rq->lock, add some rq_lock
wrappers.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Don Hiatt <dhiatt@digitalocean.com>
Tested-by: Hongyu Ning <hongyu.ning@linux.intel.com>
Tested-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20210422123308.075967879@infradead.org
---
 kernel/sched/core.c  | 15 +++++++++++++-
 kernel/sched/sched.h | 50 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 65 insertions(+)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 660120d..5568018 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -184,6 +184,21 @@ int sysctl_sched_rt_runtime = 950000;
  *
  */
 
+void raw_spin_rq_lock_nested(struct rq *rq, int subclass)
+{
+	raw_spin_lock_nested(rq_lockp(rq), subclass);
+}
+
+bool raw_spin_rq_trylock(struct rq *rq)
+{
+	return raw_spin_trylock(rq_lockp(rq));
+}
+
+void raw_spin_rq_unlock(struct rq *rq)
+{
+	raw_spin_unlock(rq_lockp(rq));
+}
+
 /*
  * __task_rq_lock - lock the rq @p resides on.
  */
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a189bec..f654587 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1113,6 +1113,56 @@ static inline bool is_migration_disabled(struct task_struct *p)
 #endif
 }
 
+static inline raw_spinlock_t *rq_lockp(struct rq *rq)
+{
+	return &rq->lock;
+}
+
+static inline void lockdep_assert_rq_held(struct rq *rq)
+{
+	lockdep_assert_held(rq_lockp(rq));
+}
+
+extern void raw_spin_rq_lock_nested(struct rq *rq, int subclass);
+extern bool raw_spin_rq_trylock(struct rq *rq);
+extern void raw_spin_rq_unlock(struct rq *rq);
+
+static inline void raw_spin_rq_lock(struct rq *rq)
+{
+	raw_spin_rq_lock_nested(rq, 0);
+}
+
+static inline void raw_spin_rq_lock_irq(struct rq *rq)
+{
+	local_irq_disable();
+	raw_spin_rq_lock(rq);
+}
+
+static inline void raw_spin_rq_unlock_irq(struct rq *rq)
+{
+	raw_spin_rq_unlock(rq);
+	local_irq_enable();
+}
+
+static inline unsigned long _raw_spin_rq_lock_irqsave(struct rq *rq)
+{
+	unsigned long flags;
+	local_irq_save(flags);
+	raw_spin_rq_lock(rq);
+	return flags;
+}
+
+static inline void raw_spin_rq_unlock_irqrestore(struct rq *rq, unsigned long flags)
+{
+	raw_spin_rq_unlock(rq);
+	local_irq_restore(flags);
+}
+
+#define raw_spin_rq_lock_irqsave(rq, flags)	\
+do {						\
+	flags = _raw_spin_rq_lock_irqsave(rq);	\
+} while (0)
+
 #ifdef CONFIG_SCHED_SMT
 extern void __update_idle_core(struct rq *rq);
 
