Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1412F422A4F
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Oct 2021 16:12:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235190AbhJEONt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 5 Oct 2021 10:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235104AbhJEONt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 5 Oct 2021 10:13:49 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84862C061749;
        Tue,  5 Oct 2021 07:11:58 -0700 (PDT)
Date:   Tue, 05 Oct 2021 14:11:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633443117;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BZjhAqQNYlzC+Pghfe02KlFchktVKX1nh12Eow+log4=;
        b=rRG/9uE0bKB8x4bJa34U38aU6rusoBhYa+UisMXEQ8amLv60PqHgwo1uBuvFbVBr3cuqjk
        F1CdT1tdY+Pqns99BPzJNioy8kdRAIHizrr+byxbzX5z29To7xtH3JJU9AvbY0hZ6ZPt2J
        HLx0qH6pWL6uBCe/AP9CY7Xv3E0fuwGDv5eq2+wiN2yzC1RETsk8Hpdknv8mzOevGM5DZp
        /rCHSOuhvdGbBO/dbNxNSTzwr8IJVWRXnhkspJLHyXlW98pechbhS+cda5IxKfrSkk/NCQ
        FbKCKrwIcm2iLvbubetgBJzNoJa9nHGPVm0i6TQruQVgkSI9hAQN9L+SIVEjPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633443117;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BZjhAqQNYlzC+Pghfe02KlFchktVKX1nh12Eow+log4=;
        b=PjULvTn6hFVuqBGKfP5Nl+9O4V+Zc59dRHaYRxQ0pgpZL3w1ItTS8/lyADjLXE78LSz3yg
        uM5Hv6i/W+Ao8rAA==
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
Message-ID: <163344311631.25758.6364458215229206476.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     670721c7bd2a6e16e40db29b2707a27bdecd6928
Gitweb:        https://git.kernel.org/tip/670721c7bd2a6e16e40db29b2707a27bdecd6928
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 28 Sep 2021 14:24:28 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Oct 2021 15:52:14 +02:00

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
index 91a43e5..6385132 100644
--- a/kernel/exit.c
+++ b/kernel/exit.c
@@ -64,6 +64,7 @@
 #include <linux/rcuwait.h>
 #include <linux/compat.h>
 #include <linux/io_uring.h>
+#include <linux/kprobes.h>
 
 #include <linux/uaccess.h>
 #include <asm/unistd.h>
@@ -168,6 +169,7 @@ static void delayed_put_task_struct(struct rcu_head *rhp)
 {
 	struct task_struct *tsk = container_of(rhp, struct task_struct, rcu);
 
+	kprobe_flush_task(tsk);
 	perf_event_delayed_put(tsk);
 	trace_sched_process_free(tsk);
 	put_task_struct(tsk);
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 790a573..9a38e75 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1250,10 +1250,10 @@ void kprobe_busy_end(void)
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
index 749284f..e33b03c 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4846,12 +4846,6 @@ static struct rq *finish_task_switch(struct task_struct *prev)
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
 
