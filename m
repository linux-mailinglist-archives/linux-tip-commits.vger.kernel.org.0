Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F77D41F072
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Oct 2021 17:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354989AbhJAPIF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 1 Oct 2021 11:08:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354930AbhJAPHn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 1 Oct 2021 11:07:43 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0294EC0613EB;
        Fri,  1 Oct 2021 08:05:52 -0700 (PDT)
Date:   Fri, 01 Oct 2021 15:05:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633100750;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ejq7LH+/BbXYM7l44xf3ksOLX3/cmV75exWX5cXN0zM=;
        b=jcfrjwPYZ1FHBXJQyDTaBLCOi/en1RddLOOpkge/u4sNQUBc+A2+W2HuCuWE2W6BVR70KB
        3Ng5w+rJ0jbNfQlGcBj5RVAUeOpRXSUG70i1QI7EKmHXTm7th50lhDpdaFOFezin1Gf8w6
        qDqzn8J7gygM8lLm6B2DJdsO2SBnN9qqVZ1ikLP/v6Yjw9UvzoXUcsX9lfJYa9hxHzmZXt
        g1mGDvgfyChwIdz1SZbEdL8meP3bHwWl94bRCrcyyW/qtBoFH5lBdscylY+sXsvBKrA7lj
        bhVT+P3447oAkC8H9+mqo3BExK0/ZRDjGWLIktjkzlNpaldXlZ7e3a6/KucN1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633100750;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ejq7LH+/BbXYM7l44xf3ksOLX3/cmV75exWX5cXN0zM=;
        b=zNChg8fD0o1knv4Xh7DJqI3DYJFMkblfRmMXNFjNwcTySRzLjV9UiIDk8GYCgMP0L4n/A4
        hrSxN9avcnIUMpBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Move kprobes cleanup out of finish_task_switch()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210928122411.537994026@linutronix.de>
References: <20210928122411.537994026@linutronix.de>
MIME-Version: 1.0
Message-ID: <163310075007.25758.9589191273271590112.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d428aac9dff0a0d217f3449884ac958dbf3f232b
Gitweb:        https://git.kernel.org/tip/d428aac9dff0a0d217f3449884ac958dbf3f232b
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 28 Sep 2021 14:24:28 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 01 Oct 2021 13:58:07 +02:00

sched: Move kprobes cleanup out of finish_task_switch()

Doing cleanups in the tail of schedule() is a latency punishment for the
incoming task. The point of invoking kprobes_task_flush() for a dead task
is that the instances are returned and cannot leak when __schedule() is
kprobed.

Move it into the delayed cleanup.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210928122411.537994026@linutronix.de
---
 kernel/exit.c       | 2 ++
 kernel/kprobes.c    | 8 ++++----
 kernel/sched/core.c | 6 ------
 3 files changed, 6 insertions(+), 10 deletions(-)

diff --git a/kernel/exit.c b/kernel/exit.c
index fd1c041..df281b4 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -64,6 +64,7 @@
 #include <linux/rcuwait.h>
 #include <linux/compat.h>
 #include <linux/io_uring.h>
+#include <linux/kprobes.h>
 
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
@@ -169,6 +170,7 @@ static void delayed_put_task_struct(struct rcu_head *rhp)
 {
 	struct task_struct *tsk = container_of(rhp, struct task_struct, rcu);
 
+	kprobe_flush_task(tsk);
 	perf_event_delayed_put(tsk);
 	trace_sched_process_free(tsk);
 	put_task_struct(tsk);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 745f08f..89194e5 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1256,10 +1256,10 @@ void kprobe_busy_end(void)
 }
 
 /*
- * This function is called from finish_task_switch when task tk becomes dead,
- * so that we can recycle any function-return probe instances associated
- * with this task. These left over instances represent probed functions
- * that have been called but will never return.
+ * This function is called from delayed_put_task_struct() when a task is
+ * dead and cleaned up to recycle any function-return probe instances
+ * associated with this task. These left over instances represent probed
+ * functions that have been called but will never return.
  */
 void kprobe_flush_task(struct task_struct *tk)
 {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8d844d0..8e49b17 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4783,12 +4783,6 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 		if (prev->sched_class->task_dead)
 			prev->sched_class->task_dead(prev);
 
-		/*
-		 * Remove function-return probe instances associated with this
-		 * task and put them back on the free list.
-		 */
-		kprobe_flush_task(prev);
-
 		/* Task is done with its stack. */
 		put_task_stack(prev);
 
