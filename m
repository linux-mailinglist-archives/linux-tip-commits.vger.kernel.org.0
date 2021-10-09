Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3364278ED
	for <lists+linux-tip-commits@lfdr.de>; Sat,  9 Oct 2021 12:09:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244777AbhJIKL3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 9 Oct 2021 06:11:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244876AbhJIKLM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 9 Oct 2021 06:11:12 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93EFDC061767;
        Sat,  9 Oct 2021 03:08:05 -0700 (PDT)
Date:   Sat, 09 Oct 2021 10:07:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633774060;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DCN2c5tSYLujs8RPCm9jF0Clx6vPi7dL1QiKiXoFsdk=;
        b=DlsEikWBnLj+t9iV1cimJXNjmpPBHC7zam5CiVKX/BBwUGYs9wfZapiEbEUCpI+imifzdn
        QNIaeJAXrz0GZChc0FPXH7N7Ueyz8IlIHsarvH+54mEEds3BJkCJQa3rYICD6DFsF2ETva
        IArUs25CD0aLthefwSeGxbwPpKhiNj+wG0A7vZOICNSnizYG1DtKZgRgh+o6aGj0hmOiy8
        0nKidnpc7FU2gGITsd9BCSRGX4wkZuak3lpMmJ5EMQvWyP8ypWGN2i9yFJr7l9BE1Y+y2v
        PGXPyYOxngD/dVBf50ZTmobsZhDmQ0I8Tigg5nIdlKRvP3bknE3YAf1HClQ2aQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633774060;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DCN2c5tSYLujs8RPCm9jF0Clx6vPi7dL1QiKiXoFsdk=;
        b=F8W3pfUNbRbm4EmT/q0vo6rJUZd/5FOGOpImB9BzGyYyehPnzlFEi+Mayw2Rh3Y9D86/wx
        R5PnyIenDioRXPDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched,livepatch: Use task_call_func()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Vasily Gorbik <gor@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210929152428.709906138@infradead.org>
References: <20210929152428.709906138@infradead.org>
MIME-Version: 1.0
Message-ID: <163377405983.25758.10879410245969993432.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     00619f7c650e4e46c650cb2e2fd5f438b32dc64b
Gitweb:        https://git.kernel.org/tip/00619f7c650e4e46c650cb2e2fd5f438b32dc64b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 21 Sep 2021 21:54:32 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 07 Oct 2021 13:51:15 +02:00

sched,livepatch: Use task_call_func()

Instead of frobbing around with scheduler internals, use the shiny new
task_call_func() interface.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Acked-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Vasily Gorbik <gor@linux.ibm.com>
Tested-by: Petr Mladek <pmladek@suse.com>
Tested-by: Vasily Gorbik <gor@linux.ibm.com> # on s390
Link: https://lkml.kernel.org/r/20210929152428.709906138@infradead.org
---
 kernel/livepatch/transition.c | 90 ++++++++++++++++------------------
 1 file changed, 44 insertions(+), 46 deletions(-)

diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 291b857..75251e9 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -13,7 +13,6 @@
 #include "core.h"
 #include "patch.h"
 #include "transition.h"
-#include "../sched/sched.h"
 
 #define MAX_STACK_ENTRIES  100
 #define STACK_ERR_BUF_SIZE 128
@@ -240,7 +239,7 @@ static int klp_check_stack_func(struct klp_func *func, unsigned long *entries,
  * Determine whether it's safe to transition the task to the target patch state
  * by looking for any to-be-patched or to-be-unpatched functions on its stack.
  */
-static int klp_check_stack(struct task_struct *task, char *err_buf)
+static int klp_check_stack(struct task_struct *task, const char **oldname)
 {
 	static unsigned long entries[MAX_STACK_ENTRIES];
 	struct klp_object *obj;
@@ -248,12 +247,8 @@ static int klp_check_stack(struct task_struct *task, char *err_buf)
 	int ret, nr_entries;
 
 	ret = stack_trace_save_tsk_reliable(task, entries, ARRAY_SIZE(entries));
-	if (ret < 0) {
-		snprintf(err_buf, STACK_ERR_BUF_SIZE,
-			 "%s: %s:%d has an unreliable stack\n",
-			 __func__, task->comm, task->pid);
-		return ret;
-	}
+	if (ret < 0)
+		return -EINVAL;
 	nr_entries = ret;
 
 	klp_for_each_object(klp_transition_patch, obj) {
@@ -262,11 +257,8 @@ static int klp_check_stack(struct task_struct *task, char *err_buf)
 		klp_for_each_func(obj, func) {
 			ret = klp_check_stack_func(func, entries, nr_entries);
 			if (ret) {
-				snprintf(err_buf, STACK_ERR_BUF_SIZE,
-					 "%s: %s:%d is sleeping on function %s\n",
-					 __func__, task->comm, task->pid,
-					 func->old_name);
-				return ret;
+				*oldname = func->old_name;
+				return -EADDRINUSE;
 			}
 		}
 	}
@@ -274,6 +266,22 @@ static int klp_check_stack(struct task_struct *task, char *err_buf)
 	return 0;
 }
 
+static int klp_check_and_switch_task(struct task_struct *task, void *arg)
+{
+	int ret;
+
+	if (task_curr(task) && task != current)
+		return -EBUSY;
+
+	ret = klp_check_stack(task, arg);
+	if (ret)
+		return ret;
+
+	clear_tsk_thread_flag(task, TIF_PATCH_PENDING);
+	task->patch_state = klp_target_state;
+	return 0;
+}
+
 /*
  * Try to safely switch a task to the target patch state.  If it's currently
  * running, or it's sleeping on a to-be-patched or to-be-unpatched function, or
@@ -281,13 +289,8 @@ static int klp_check_stack(struct task_struct *task, char *err_buf)
  */
 static bool klp_try_switch_task(struct task_struct *task)
 {
-	static char err_buf[STACK_ERR_BUF_SIZE];
-	struct rq *rq;
-	struct rq_flags flags;
+	const char *old_name;
 	int ret;
-	bool success = false;
-
-	err_buf[0] = '\0';
 
 	/* check if this task has already switched over */
 	if (task->patch_state == klp_target_state)
@@ -305,36 +308,31 @@ static bool klp_try_switch_task(struct task_struct *task)
 	 * functions.  If all goes well, switch the task to the target patch
 	 * state.
 	 */
-	rq = task_rq_lock(task, &flags);
+	ret = task_call_func(task, klp_check_and_switch_task, &old_name);
+	switch (ret) {
+	case 0:		/* success */
+		break;
 
-	if (task_running(rq, task) && task != current) {
-		snprintf(err_buf, STACK_ERR_BUF_SIZE,
-			 "%s: %s:%d is running\n", __func__, task->comm,
-			 task->pid);
-		goto done;
+	case -EBUSY:	/* klp_check_and_switch_task() */
+		pr_debug("%s: %s:%d is running\n",
+			 __func__, task->comm, task->pid);
+		break;
+	case -EINVAL:	/* klp_check_and_switch_task() */
+		pr_debug("%s: %s:%d has an unreliable stack\n",
+			 __func__, task->comm, task->pid);
+		break;
+	case -EADDRINUSE: /* klp_check_and_switch_task() */
+		pr_debug("%s: %s:%d is sleeping on function %s\n",
+			 __func__, task->comm, task->pid, old_name);
+		break;
+
+	default:
+		pr_debug("%s: Unknown error code (%d) when trying to switch %s:%d\n",
+			 __func__, ret, task->comm, task->pid);
+		break;
 	}
 
-	ret = klp_check_stack(task, err_buf);
-	if (ret)
-		goto done;
-
-	success = true;
-
-	clear_tsk_thread_flag(task, TIF_PATCH_PENDING);
-	task->patch_state = klp_target_state;
-
-done:
-	task_rq_unlock(rq, task, &flags);
-
-	/*
-	 * Due to console deadlock issues, pr_debug() can't be used while
-	 * holding the task rq lock.  Instead we have to use a temporary buffer
-	 * and print the debug message after releasing the lock.
-	 */
-	if (err_buf[0] != '\0')
-		pr_debug("%s", err_buf);
-
-	return success;
+	return !ret;
 }
 
 /*
