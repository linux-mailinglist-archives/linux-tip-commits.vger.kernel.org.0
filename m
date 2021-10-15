Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4C042EDF5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 15 Oct 2021 11:45:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237656AbhJOJrF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 15 Oct 2021 05:47:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48878 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbhJOJrE (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 15 Oct 2021 05:47:04 -0400
Date:   Fri, 15 Oct 2021 09:44:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634291096;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XGvmaEWC0vrBD3Er+GWJD1AraesOqVPuhnFh5z116Po=;
        b=sRnaZMW83areevSy9cO6UsfBgMmajQiw3El5ui8cIF63NPot8ZZ0zE3DJAgkU1rgzVtAXi
        9xdwqTrBioQtA9kp26obU9Qumv6reUyAsYz+dIABSSZWVXZqhao7lre5n9h+OvJLWYKPlK
        cIOUVwRY/uGALVlf/11I2ZZnuCQISOtZaZoF/+6W3CcVmKnJ8vsxOBd4hyic0WSVN+biFP
        ldlgfKUfWi8Q9pUxk2s39N5LXp6Y9eRrfEwZ8SPq5xl95sa5fB3UG+FHtejcIitntfn0DG
        /L1Z8aaYo0UO2+9q1M0QirQyw2M5UcUG/Hemou2AR0P5noyaUpTHeoMkVZiYPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634291096;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XGvmaEWC0vrBD3Er+GWJD1AraesOqVPuhnFh5z116Po=;
        b=zW7e3WfrL+jt41WB3j0sVuey5fF1V7tvdGqunXNOhuIBNlVq4AMK1DdA5NKRdu1APRJrfd
        4kexI3JkniTToQBQ==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] irq_work: Allow irq_work_sync() to sleep if
 irq_work() no IRQ support.
Cc:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211006111852.1514359-3-bigeasy@linutronix.de>
References: <20211006111852.1514359-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <163429109604.25758.7589260727160739202.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     810979682ccc98dbd83f341c18a2e556c30a7164
Gitweb:        https://git.kernel.org/tip/810979682ccc98dbd83f341c18a2e556c30a7164
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Wed, 06 Oct 2021 13:18:50 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 15 Oct 2021 11:25:17 +02:00

irq_work: Allow irq_work_sync() to sleep if irq_work() no IRQ support.

irq_work() triggers instantly an interrupt if supported by the
architecture. Otherwise the work will be processed on the next timer
tick. In worst case irq_work_sync() could spin up to a jiffy.

irq_work_sync() is usually used in tear down context which is fully
preemptible. Based on review irq_work_sync() is invoked from preemptible
context and there is one waiter at a time. This qualifies it to use
rcuwait for synchronisation.

Let irq_work_sync() synchronize with rcuwait if the architecture
processes irqwork via the timer tick.

Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20211006111852.1514359-3-bigeasy@linutronix.de
---
 include/linux/irq_work.h |  3 +++
 kernel/irq_work.c        | 10 ++++++++++
 2 files changed, 13 insertions(+)

diff --git a/include/linux/irq_work.h b/include/linux/irq_work.h
index ec2a47a..b48955e 100644
--- a/include/linux/irq_work.h
+++ b/include/linux/irq_work.h
@@ -3,6 +3,7 @@
 #define _LINUX_IRQ_WORK_H
 
 #include <linux/smp_types.h>
+#include <linux/rcuwait.h>
 
 /*
  * An entry can be in one of four states:
@@ -16,11 +17,13 @@
 struct irq_work {
 	struct __call_single_node node;
 	void (*func)(struct irq_work *);
+	struct rcuwait irqwait;
 };
 
 #define __IRQ_WORK_INIT(_func, _flags) (struct irq_work){	\
 	.node = { .u_flags = (_flags), },			\
 	.func = (_func),					\
+	.irqwait = __RCUWAIT_INITIALIZER(irqwait),		\
 }
 
 #define IRQ_WORK_INIT(_func) __IRQ_WORK_INIT(_func, 0)
diff --git a/kernel/irq_work.c b/kernel/irq_work.c
index db8c248..e789bed 100644
--- a/kernel/irq_work.c
+++ b/kernel/irq_work.c
@@ -160,6 +160,9 @@ void irq_work_single(void *arg)
 	 * else claimed it meanwhile.
 	 */
 	(void)atomic_cmpxchg(&work->node.a_flags, flags, flags & ~IRQ_WORK_BUSY);
+
+	if (!arch_irq_work_has_interrupt())
+		rcuwait_wake_up(&work->irqwait);
 }
 
 static void irq_work_run_list(struct llist_head *list)
@@ -204,6 +207,13 @@ void irq_work_tick(void)
 void irq_work_sync(struct irq_work *work)
 {
 	lockdep_assert_irqs_enabled();
+	might_sleep();
+
+	if (!arch_irq_work_has_interrupt()) {
+		rcuwait_wait_event(&work->irqwait, !irq_work_is_busy(work),
+				   TASK_UNINTERRUPTIBLE);
+		return;
+	}
 
 	while (irq_work_is_busy(work))
 		cpu_relax();
