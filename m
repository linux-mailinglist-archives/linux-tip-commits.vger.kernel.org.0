Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3CA840F8FA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Sep 2021 15:18:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235661AbhIQNTF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Sep 2021 09:19:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54710 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241351AbhIQNS5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Sep 2021 09:18:57 -0400
Date:   Fri, 17 Sep 2021 13:17:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631884654;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9GpPcpO3H/f2tk60mVuVgdD0CNEjJXdSctWiUki9ggU=;
        b=wXYCpWx/PxXw9p0xp1UzqbaC07x/s8EuqifKncN6bobx7dx5yvKnXS90TawWryl7a1+W5v
        TOGeXh099q0dzJttg3cQLX3xFItSPtUBr7o2FHHSyok0l8lH392v37NPE15q99RFV6/UkV
        gm0QCHti0yrAlunpFwh63Qisdr4rcfHOYDbCsfijeQAmXPNtw3wqAVxlwvtffV3jXpVn1I
        SJKoK2rmcuX3y+K/l1EufAcb3ecdD/xJt3Ln478DIhJoWukU4mnNqTXtR/xa3XCCrF56od
        AL6FjC+GLdlKfPqM3tB7O4gWm1KlPKdxM3znMtoLUy6/FIWZtpMdNwkMe9G8uA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631884654;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9GpPcpO3H/f2tk60mVuVgdD0CNEjJXdSctWiUki9ggU=;
        b=C2ttMD32zh8XPg+0dkvmT/rI5GPyNn5gFmwct2GJp/ZYLAcmqXZoqnoWp+0wovOWBp17J1
        ar2airZJ/IpdZIBw==
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
Message-ID: <163188465388.25758.13569856472159323193.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2b214a488b2c83d63c99c71d054273c1c2c07027
Gitweb:        https://git.kernel.org/tip/2b214a488b2c83d63c99c71d054273c1c2c07027
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 10 Nov 2020 12:38:47 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Sep 2021 15:08:18 +02:00

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
index 7bbfeeb..6f59e34 100644
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
