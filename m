Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 794C441F055
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Oct 2021 17:05:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354706AbhJAPHN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 1 Oct 2021 11:07:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354653AbhJAPHN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 1 Oct 2021 11:07:13 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31B31C061775;
        Fri,  1 Oct 2021 08:05:29 -0700 (PDT)
Date:   Fri, 01 Oct 2021 15:05:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633100727;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8NpU/VH4h8lspXBa8ywWo8ykNqrQYIEuqwvUaw9pqwk=;
        b=RomHeQMMo5kxkEJN+bEJV7GGlLvbDGpjRsUijhYwiN0k5t03qlO+YnSIFhP9hzZlRRithI
        8MfCtTn98LrE8sKRTmrSdL6wTciR8Q7Z/JHVMvKFJ6W2d8qoH4IGtb33tqXBkJNMtQb4L+
        mJHQ9M2/vlsxLI8P5sif2KBqOmDck/17mt1MC4oE/HNKkeroKBnSBfw6SVT6Fq2ul+3ngf
        WcwsFcH6NlIIOrkNNz5e1sOAuqXyiUBPTWpVdE0PIZZGOkSsDuOS32DMWZr6sLvh7vXwTH
        vd/3WRMqvDE1JAcLBbbsN+6wiErPe6v79Aaw+mAXb9VUiyqAQd2HBxXjaa7W6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633100727;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8NpU/VH4h8lspXBa8ywWo8ykNqrQYIEuqwvUaw9pqwk=;
        b=BDJ6lCyb/KqZ0J/0woOFBN2H4cubWx9GKp9B3vSY3kPRDzjEW7xclA80np6S/ayJYUFR3Q
        m9PVzCWh3R2eeiAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] rtmutex: Wake up the waiters lockless while
 dropping the read lock.
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210928150006.597310-3-bigeasy@linutronix.de>
References: <20210928150006.597310-3-bigeasy@linutronix.de>
MIME-Version: 1.0
Message-ID: <163310072658.25758.15391408718641562384.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     9321f8152d9a764208c3f0dad49e0c55f293b7ab
Gitweb:        https://git.kernel.org/tip/9321f8152d9a764208c3f0dad49e0c55f293b7ab
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 28 Sep 2021 17:00:06 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 01 Oct 2021 13:57:52 +02:00

rtmutex: Wake up the waiters lockless while dropping the read lock.

The rw_semaphore and rwlock_t implementation both wake the waiter while
holding the rt_mutex_base::wait_lock acquired.
This can be optimized by waking the waiter lockless outside of the
locked section to avoid a needless contention on the
rt_mutex_base::wait_lock lock.

Extend rt_mutex_wake_q_add() to also accept task and state and use it in
__rwbase_read_unlock().

Suggested-by: Davidlohr Bueso <dave@stgolabs.net>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210928150006.597310-3-bigeasy@linutronix.de
---
 kernel/locking/rtmutex.c   | 19 +++++++++++++------
 kernel/locking/rwbase_rt.c |  6 +++++-
 2 files changed, 18 insertions(+), 7 deletions(-)

diff --git a/kernel/locking/rtmutex.c b/kernel/locking/rtmutex.c
index cafc259..0c6a48d 100644
--- a/kernel/locking/rtmutex.c
+++ b/kernel/locking/rtmutex.c
@@ -446,19 +446,26 @@ static __always_inline void rt_mutex_adjust_prio(struct task_struct *p)
 }
 
 /* RT mutex specific wake_q wrappers */
-static __always_inline void rt_mutex_wake_q_add(struct rt_wake_q_head *wqh,
-						struct rt_mutex_waiter *w)
+static __always_inline void rt_mutex_wake_q_add_task(struct rt_wake_q_head *wqh,
+						     struct task_struct *task,
+						     unsigned int wake_state)
 {
-	if (IS_ENABLED(CONFIG_PREEMPT_RT) && w->wake_state == TASK_RTLOCK_WAIT) {
+	if (IS_ENABLED(CONFIG_PREEMPT_RT) && wake_state == TASK_RTLOCK_WAIT) {
 		if (IS_ENABLED(CONFIG_PROVE_LOCKING))
 			WARN_ON_ONCE(wqh->rtlock_task);
-		get_task_struct(w->task);
-		wqh->rtlock_task = w->task;
+		get_task_struct(task);
+		wqh->rtlock_task = task;
 	} else {
-		wake_q_add(&wqh->head, w->task);
+		wake_q_add(&wqh->head, task);
 	}
 }
 
+static __always_inline void rt_mutex_wake_q_add(struct rt_wake_q_head *wqh,
+						struct rt_mutex_waiter *w)
+{
+	rt_mutex_wake_q_add_task(wqh, w->task, w->wake_state);
+}
+
 static __always_inline void rt_mutex_wake_up_q(struct rt_wake_q_head *wqh)
 {
 	if (IS_ENABLED(CONFIG_PREEMPT_RT) && wqh->rtlock_task) {
diff --git a/kernel/locking/rwbase_rt.c b/kernel/locking/rwbase_rt.c
index 4ba1508..6b143fb 100644
--- a/kernel/locking/rwbase_rt.c
+++ b/kernel/locking/rwbase_rt.c
@@ -141,6 +141,7 @@ static void __sched __rwbase_read_unlock(struct rwbase_rt *rwb,
 {
 	struct rt_mutex_base *rtm = &rwb->rtmutex;
 	struct task_struct *owner;
+	DEFINE_RT_WAKE_Q(wqh);
 
 	raw_spin_lock_irq(&rtm->wait_lock);
 	/*
@@ -151,9 +152,12 @@ static void __sched __rwbase_read_unlock(struct rwbase_rt *rwb,
 	 */
 	owner = rt_mutex_owner(rtm);
 	if (owner)
-		wake_up_state(owner, state);
+		rt_mutex_wake_q_add_task(&wqh, owner, state);
 
+	/* Pairs with the preempt_enable in rt_mutex_wake_up_q() */
+	preempt_disable();
 	raw_spin_unlock_irq(&rtm->wait_lock);
+	rt_mutex_wake_up_q(&wqh);
 }
 
 static __always_inline void rwbase_read_unlock(struct rwbase_rt *rwb,
