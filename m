Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C30842EDF2
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Oct 2021 11:45:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237627AbhJOJrC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Oct 2021 05:47:02 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48858 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237633AbhJOJrC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Oct 2021 05:47:02 -0400
Date:   Fri, 15 Oct 2021 09:44:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634291095;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oN6nRiS11eEBGxmyF+O4CRrePqYJgkPxbDWKEj4itSs=;
        b=LOgZV349HB5ogW6itBNlXQbPu1JY7urZWDtjSDDeRaTj2fHSo+neIjrWf1xXTh9w37HrFZ
        B6HtDdhOWe/SkRCBSX01o5OLg62JSID/4Hp8UYYtYPhjk9XX222cRKaPEjxFZNmjLXccV6
        Ml6UF6H9i/ULfm9mPrJdTRhU2lS2GQDbqHJGqevRk5VHxDKgDAoVZCPCPXyaGAOhqrvENG
        qJONjK/HbwEsVHm0nF6lzbenHK5XFQ1m4Poa6ovuZJNQ9GdxzfMbN+xAQ5XH+zLjFcIxfj
        qWGrsOD21S0xzr4n3j/+U1/27cFz/0ma1+rKT04i7YuCS2z3PpN3+K3M8Aen3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634291095;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oN6nRiS11eEBGxmyF+O4CRrePqYJgkPxbDWKEj4itSs=;
        b=L1hAg7mdQGip3pIbqCFUS7xjHeFXCn4XCT2PSWE3l1ek/pzdGNgZYqPMLpd8KGwhfQ1Rk2
        4jfejftz6Gfbc+Bw==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] irq_work: Also rcuwait for !IRQ_WORK_HARD_IRQ on PREEMPT_RT
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211006111852.1514359-5-bigeasy@linutronix.de>
References: <20211006111852.1514359-5-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <163429109409.25758.10980405022488264190.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     09089db79859cbccccd8df95b034f36f7027efa6
Gitweb:        https://git.kernel.org/tip/09089db79859cbccccd8df95b034f36f7027efa6
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 06 Oct 2021 13:18:52 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 15 Oct 2021 11:25:18 +02:00

irq_work: Also rcuwait for !IRQ_WORK_HARD_IRQ on PREEMPT_RT

On PREEMPT_RT most items are processed as LAZY via softirq context.
Avoid to spin-wait for them because irq_work_sync() could have higher
priority and not allow the irq-work to be completed.

Wait additionally for !IRQ_WORK_HARD_IRQ irq_work items on PREEMPT_RT.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211006111852.1514359-5-bigeasy@linutronix.de
---
 include/linux/irq_work.h | 5 +++++
 kernel/irq_work.c        | 6 ++++--
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index b48955e..8cd11a2 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -49,6 +49,11 @@ static inline bool irq_work_is_busy(struct irq_work *work)
 	return atomic_read(&work->node.a_flags) & IRQ_WORK_BUSY;
 }
 
+static inline bool irq_work_is_hard(struct irq_work *work)
+{
+	return atomic_read(&work->node.a_flags) & IRQ_WORK_HARD_IRQ;
+}
+
 bool irq_work_queue(struct irq_work *work);
 bool irq_work_queue_on(struct irq_work *work, int cpu);
 
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index 90b6b56..f7df715 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -217,7 +217,8 @@ void irq_work_single(void *arg)
 	 */
 	(void)atomic_cmpxchg(&work->node.a_flags, flags, flags & ~IRQ_WORK_BUSY);
 
-	if (!arch_irq_work_has_interrupt())
+	if ((IS_ENABLED(CONFIG_PREEMPT_RT) && !irq_work_is_hard(work)) ||
+	    !arch_irq_work_has_interrupt())
 		rcuwait_wake_up(&work->irqwait);
 }
 
@@ -277,7 +278,8 @@ void irq_work_sync(struct irq_work *work)
 	lockdep_assert_irqs_enabled();
 	might_sleep();
 
-	if (!arch_irq_work_has_interrupt()) {
+	if ((IS_ENABLED(CONFIG_PREEMPT_RT) && !irq_work_is_hard(work)) ||
+	    !arch_irq_work_has_interrupt()) {
 		rcuwait_wait_event(&work->irqwait, !irq_work_is_busy(work),
 				   TASK_UNINTERRUPTIBLE);
 		return;
