Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E5C840FF78
	for <lists+linux-tip-commits@lfdr.de>; Fri, 17 Sep 2021 20:37:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239130AbhIQSiZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 17 Sep 2021 14:38:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238995AbhIQSiY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 17 Sep 2021 14:38:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D956C061574;
        Fri, 17 Sep 2021 11:37:02 -0700 (PDT)
Date:   Fri, 17 Sep 2021 18:36:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631903820;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RpPH+Qsx2YORx1Co/TELFpdH2amUJb4SrHiH3YSN8Uk=;
        b=YdaHO+MrOKosxXx8SCOfHfiuVcLtR0HSxEpok3LIkjVlKkxDvwx+jFwS3xFYGh6YNiNiYf
        N2LT63q9SHxl1SEiiJuhj2uAkD+merhjG9SOiXawgLJieXCXqTXSCr4C+WFKJnuIpBDiw9
        hFULwuM+VYlvuUURPPGHZud3LSJMVOmco4fDsXMSf+RdtBi+c5rI2RbPeGSfi7RBFyLXXQ
        mpFlkyzHOoopx8+7V29fUCjBSjcz1ybx7TEysiUwZ+HuAlvfdXNDvr+mifhfdSd6bklWgz
        vBunhNaf26XcPk3xoUmC5bRoQ8pZsrqxHHwW+FYpdH7C1XtSLrlhtTM9/rCyOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631903820;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=RpPH+Qsx2YORx1Co/TELFpdH2amUJb4SrHiH3YSN8Uk=;
        b=UV4NNAz9boAFIAHCeo2+EBqwh4tqrBx6taHDFhugMItL+XG7N8AgMEehwL6nQEkzvAb2XS
        UezB7Dx/OEhm9TBg==
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
Message-ID: <163190381894.25758.13534855734243016944.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4212bade2e86198ec84f1d65cbfb9023460f01bb
Gitweb:        https://git.kernel.org/tip/4212bade2e86198ec84f1d65cbfb9023460f01bb
Author:        Sebastian Andrzej Siewior <bigeasy@linutronix.de>
AuthorDate:    Tue, 10 Nov 2020 12:38:47 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 17 Sep 2021 20:32:27 +02:00

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
