Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B171F3EF36D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234474AbhHQUPe (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:15:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34948 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235074AbhHQUPJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:15:09 -0400
Date:   Tue, 17 Aug 2021 20:14:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231274;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=85jCURS+uUIpDeyi2xBgDFqpqVeNqobXzUvp0z9xz28=;
        b=lsE6TAqAp3dSNLOr1lBq/PmuBrSYkuRRl9ppa3MjkuniWUWrho/sIk0hbdb/nmYMZaKgme
        PUaYEkGtct7rPBiA1WHWkJzJQ8lPGtlP1JAbjhzf0N865dQCxmX9VkATgM8rcylaz4V7bX
        AP5HyGYv/iI6K/0KA8sUU/Eun3HZHJnNOQxJSRvRS8PRpwju8KQtZWerxEdVvZyhteTsML
        Db27LbRjY1nBAP4kkj4qmrp0J4J5Y/UVJ+7ucUmQbh3C4HkpMKduOj3LH9g2JACwmPRkNs
        LByXovsx7cJN4/Ry7fInkXk7tpq6HhZMQ3IM7ID1cXsfTvfGCOVVJqaSPvt1eg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231274;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=85jCURS+uUIpDeyi2xBgDFqpqVeNqobXzUvp0z9xz28=;
        b=MxHYUOfA9F7KBvllDwyV6NwJb5mzqa6BJi5UFt8r5Wm2QK8GIJtTbv9aWzFoEdPpw9qYpz
        H1XSUinSClXUscAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] sched/core: Provide a scheduling point for RT locks
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211302.372319055@linutronix.de>
References: <20210815211302.372319055@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923127400.25758.17723198410739193727.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     6991436c2b5d91d5358d9914ae2df22b9a1d1dc9
Gitweb:        https://git.kernel.org/tip/6991436c2b5d91d5358d9914ae2df22b9a1d1dc9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 15 Aug 2021 23:27:48 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 16:57:17 +02:00

sched/core: Provide a scheduling point for RT locks

RT enabled kernels substitute spin/rwlocks with 'sleeping' variants based
on rtmutexes. Blocking on such a lock is similar to preemption versus:

 - I/O scheduling and worker handling, because these functions might block
   on another substituted lock, or come from a lock contention within these
   functions.

 - RCU considers this like a preemption, because the task might be in a read
   side critical section.

Add a separate scheduling point for this, and hand a new scheduling mode
argument to __schedule() which allows, along with separate mode masks, to
handle this gracefully from within the scheduler, without proliferating that
to other subsystems like RCU.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211302.372319055@linutronix.de
---
 include/linux/sched.h |  3 +++
 kernel/sched/core.c   | 20 +++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 02714b9..746dfc0 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -288,6 +288,9 @@ extern long schedule_timeout_idle(long timeout);
 asmlinkage void schedule(void);
 extern void schedule_preempt_disabled(void);
 asmlinkage void preempt_schedule_irq(void);
+#ifdef CONFIG_PREEMPT_RT
+ extern void schedule_rtlock(void);
+#endif
 
 extern int __must_check io_schedule_prepare(void);
 extern void io_schedule_finish(int token);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ebc24e1..c89c1d4 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5829,7 +5829,13 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
  */
 #define SM_NONE			0x0
 #define SM_PREEMPT		0x1
-#define SM_MASK_PREEMPT		(~0U)
+#define SM_RTLOCK_WAIT		0x2
+
+#ifndef CONFIG_PREEMPT_RT
+# define SM_MASK_PREEMPT	(~0U)
+#else
+# define SM_MASK_PREEMPT	SM_PREEMPT
+#endif
 
 /*
  * __schedule() is the main scheduler function.
@@ -6134,6 +6140,18 @@ void __sched schedule_preempt_disabled(void)
 	preempt_disable();
 }
 
+#ifdef CONFIG_PREEMPT_RT
+void __sched notrace schedule_rtlock(void)
+{
+	do {
+		preempt_disable();
+		__schedule(SM_RTLOCK_WAIT);
+		sched_preempt_enable_no_resched();
+	} while (need_resched());
+}
+NOKPROBE_SYMBOL(schedule_rtlock);
+#endif
+
 static void __sched notrace preempt_schedule_common(void)
 {
 	do {
