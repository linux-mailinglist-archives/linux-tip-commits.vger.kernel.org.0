Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 068733EF35C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Aug 2021 22:15:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235345AbhHQUPU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Aug 2021 16:15:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34752 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234526AbhHQUOx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Aug 2021 16:14:53 -0400
Date:   Tue, 17 Aug 2021 20:14:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629231259;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uwWnW4svONw2tyd4RPaVfJuMdc2arqgZ6QYFQakZySU=;
        b=jd1Q1HbF2b9JWahum9XcZjkYeUnwCe2/6Xug0qf/Ya2BqoojE4H2lgMJfFxjiDa2nCCmzg
        WnvCQTD3ymVu3Plv7d53raLNAuKXS+9Q4u8f+jBdoFugMbz1mcvQrOYYSZU7/fGPI1qyvQ
        JhuiIkHaPkqBXZ+vAMENjMYvJSN/WN7pafuRTQtGduD504zeGQzSl3Q9n6t6nSqzMYdMy6
        fx87tc/XDU+e4j5v3WiF+b6I5aOCebRwMY2Tr4FAdD7MAypFTmsz4q8O/2vfNq2ynRacqc
        oQMQZiVuvR+Jx9r5kxAGKdEd3I374zYHT5uiu+iBbaNTARUPfwbu11aJ89Wfsw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629231259;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=uwWnW4svONw2tyd4RPaVfJuMdc2arqgZ6QYFQakZySU=;
        b=kVXflVFUV9yUQOoyhPFNjuVyS2WKjphT9dTBZRiqNkWFp3QiITDVM7f+13JoNYaQXtJCJb
        hssnOWA2/VHL5fCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] locking/rtmutex: Squash !RT tasks to DEFAULT_PRIO
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210815211303.938676930@linutronix.de>
References: <20210815211303.938676930@linutronix.de>
MIME-Version: 1.0
Message-ID: <162923125846.25758.3743395437613314698.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     715f7f9ece4685157bb59560f6c612340d730ab4
Gitweb:        https://git.kernel.org/tip/715f7f9ece4685157bb59560f6c612340d730ab4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sun, 15 Aug 2021 23:28:30 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 17 Aug 2021 17:51:02 +02:00

locking/rtmutex: Squash !RT tasks to DEFAULT_PRIO

Ensure all !RT tasks have the same prio such that they end up in FIFO
order and aren't split up according to nice level.

The reason why nice levels were taken into account so far is historical. In
the early days of the rtmutex code it was done to give the PI boosting and
deboosting a larger coverage.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210815211303.938676930@linutronix.de
---
 kernel/locking/rtmutex.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index 951bef0..ac8fb2f 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -244,11 +244,28 @@ static __always_inline bool unlock_rt_mutex_safe(struct rt_mutex_base *lock,
 }
 #endif
 
+static __always_inline int __waiter_prio(struct task_struct *task)
+{
+	int prio = task->prio;
+
+	if (!rt_prio(prio))
+		return DEFAULT_PRIO;
+
+	return prio;
+}
+
+static __always_inline void
+waiter_update_prio(struct rt_mutex_waiter *waiter, struct task_struct *task)
+{
+	waiter->prio = __waiter_prio(task);
+	waiter->deadline = task->dl.deadline;
+}
+
 /*
  * Only use with rt_mutex_waiter_{less,equal}()
  */
 #define task_to_waiter(p)	\
-	&(struct rt_mutex_waiter){ .prio = (p)->prio, .deadline = (p)->dl.deadline }
+	&(struct rt_mutex_waiter){ .prio = __waiter_prio(p), .deadline = (p)->dl.deadline }
 
 static __always_inline int rt_mutex_waiter_less(struct rt_mutex_waiter *left,
 						struct rt_mutex_waiter *right)
@@ -698,8 +715,7 @@ static int __sched rt_mutex_adjust_prio_chain(struct task_struct *task,
 	 * serializes all pi_waiters access and rb_erase() does not care about
 	 * the values of the node being removed.
 	 */
-	waiter->prio = task->prio;
-	waiter->deadline = task->dl.deadline;
+	waiter_update_prio(waiter, task);
 
 	rt_mutex_enqueue(lock, waiter);
 
@@ -969,8 +985,7 @@ static int __sched task_blocks_on_rt_mutex(struct rt_mutex_base *lock,
 	raw_spin_lock(&task->pi_lock);
 	waiter->task = task;
 	waiter->lock = lock;
-	waiter->prio = task->prio;
-	waiter->deadline = task->dl.deadline;
+	waiter_update_prio(waiter, task);
 
 	/* Get the top priority waiter on the lock */
 	if (rt_mutex_has_waiters(lock))
