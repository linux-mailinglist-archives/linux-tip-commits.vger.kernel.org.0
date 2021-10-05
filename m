Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE7EA422A62
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Oct 2021 16:12:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235884AbhJEOOI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 5 Oct 2021 10:14:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51268 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235381AbhJEON4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 5 Oct 2021 10:13:56 -0400
Date:   Tue, 05 Oct 2021 14:12:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633443124;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2g+YWsoX4gSlJTCtfLRdDdYRrDA+MXdHiZNRQhuWFlg=;
        b=O6tHBqdyLiI+bJ+aZ20fB/dWMVigRHg8XEOG7yXpuz4Mi7Kty8km5k/zX5/MddtlwG4OZk
        y2K5q+AE2+L5RAeRDBPG+06ASQgRvgk+lbH/FkXxY5Rwdu5dj/mdzICflvrojMEBX73LBg
        EsEmBqfd9yCHMaK57/6yQF6MH1+BPGEcby7lO9Z87tBnBG4e6SlWNtMAg/ZF/DNbUvPPrz
        PDegXZ1qjrW5UvOz0Lf73vJadFU/i2E7xDAiqyR3Jg2PDaCtk0cByQB9aFoMNuL7ZIft4O
        dqo/oy1oau7QQEzNlzOj6I58nMwZpdup5iq1BZQUmpBxPWLPjpZ9WPTFyQ18kw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633443124;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2g+YWsoX4gSlJTCtfLRdDdYRrDA+MXdHiZNRQhuWFlg=;
        b=HYsQwiJaJ/OIZEkTym3WJy4sxgKA2CjlULnFJnGzmAcl8iKFBMaVq/T/rrkhqQ/qiip3FN
        qVvdQYS41WyeB3Bg==
From:   "tip-bot2 for Sebastian Andrzej Siewior" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] kthread: Move prio/affinite change into the newly
 created thread
Cc:     Mike Galbraith <efault@gmx.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <a23a826af7c108ea5651e73b8fbae5e653f16e86.camel@gmx.de>
References: <a23a826af7c108ea5651e73b8fbae5e653f16e86.camel@gmx.de>
MIME-Version: 1.0
Message-ID: <163344312383.25758.1066352412988968295.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1a7243ca4074beed97b68d7235a6e34862fc2cd6
Gitweb:        https://git.kernel.org/tip/1a7243ca4074beed97b68d7235a6e34862fc2cd6
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 10 Nov 2020 12:38:47 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Oct 2021 15:51:58 +02:00

kthread: Move prio/affinite change into the newly created thread

With enabled threaded interrupts the nouveau driver reported the
following:

| Chain exists of:
|   &mm->mmap_lock#2 --> &device->mutex --> &cpuset_rwsem
|
|  Possible unsafe locking scenario:
|
|        CPU0                    CPU1
|        ----                    ----
|   lock(&cpuset_rwsem);
|                                lock(&device->mutex);
|                                lock(&cpuset_rwsem);
|   lock(&mm->mmap_lock#2);

The device->mutex is nvkm_device::mutex.

Unblocking the lockchain at `cpuset_rwsem' is probably the easiest
thing to do.  Move the priority reset to the start of the newly
created thread.

Fixes: 710da3c8ea7df ("sched/core: Prevent race condition between cpuset and __sched_setscheduler()")
Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/a23a826af7c108ea5651e73b8fbae5e653f16e86.camel@gmx.de
---
 kernel/kthread.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/kernel/kthread.c b/kernel/kthread.c
index 5b37a85..4a4d709 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -270,6 +270,7 @@ EXPORT_SYMBOL_GPL(kthread_parkme);
 
 static int kthread(void *_create)
 {
+	static const struct sched_param param = { .sched_priority = 0 };
 	/* Copy data: it's on kthread's stack */
 	struct kthread_create_info *create = _create;
 	int (*threadfn)(void *data) = create->threadfn;
@@ -300,6 +301,13 @@ static int kthread(void *_create)
 	init_completion(&self->parked);
 	current->vfork_done = &self->exited;
 
+	/*
+	 * The new thread inherited kthreadd's priority and CPU mask. Reset
+	 * back to default in case they have been changed.
+	 */
+	sched_setscheduler_nocheck(current, SCHED_NORMAL, &param);
+	set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_FLAG_KTHREAD));
+
 	/* OK, tell user we're spawned, wait for stop or wakeup */
 	__set_current_state(TASK_UNINTERRUPTIBLE);
 	create->result = current;
@@ -397,7 +405,6 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
 	}
 	task = create->result;
 	if (!IS_ERR(task)) {
-		static const struct sched_param param = { .sched_priority = 0 };
 		char name[TASK_COMM_LEN];
 
 		/*
@@ -406,13 +413,6 @@ struct task_struct *__kthread_create_on_node(int (*threadfn)(void *data),
 		 */
 		vsnprintf(name, sizeof(name), namefmt, args);
 		set_task_comm(task, name);
-		/*
-		 * root may have changed our (kthreadd's) priority or CPU mask.
-		 * The kernel thread should not inherit these properties.
-		 */
-		sched_setscheduler_nocheck(task, SCHED_NORMAL, &param);
-		set_cpus_allowed_ptr(task,
-				     housekeeping_cpumask(HK_FLAG_KTHREAD));
 	}
 	kfree(create);
 	return task;
