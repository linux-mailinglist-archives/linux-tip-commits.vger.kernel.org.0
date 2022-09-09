Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831A55B328F
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Sep 2022 11:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231489AbiIIJBI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Sep 2022 05:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231575AbiIIJAm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Sep 2022 05:00:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 170C63C16A
        for <linux-tip-commits@vger.kernel.org>; Fri,  9 Sep 2022 02:00:29 -0700 (PDT)
Date:   Fri, 09 Sep 2022 09:00:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1662714022;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gTMISxk2xAKyiBwFCU5IWW/3LoyKsnHKLFZfG7qF9iw=;
        b=GwlV3z64Df3NGjaPSL7uL+h8mQ+aAIKTnOhSOviFrjDcbD6jM4xIquNmp19fiGJcHi/SbN
        vnFYg/UulQnNODaSsTxIZSnuFtQS2NQLtCvO7CBAc5Tu2G9WRt0UVulX9cgEep4Vww+eBZ
        XDHniQ9QChaFyuNam5LiqzjPU9BHszD5GAEcl2AdD9hTbGiFl3iAwvuCno9IfA/CU1kDeh
        5lQXiS6r1m/nOxqXDM9XagWLWg3i0HLYz7tr3byjMk6nfBsIWJUXTAwgluMFXgRCYY/v8v
        CqSuDdGzarYsKkFDNCsW+ZjZBsCVzLQvjcj3eJZgxIbwM62Ago8BguGy3GuXGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1662714022;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gTMISxk2xAKyiBwFCU5IWW/3LoyKsnHKLFZfG7qF9iw=;
        b=VM0ydQd4gB1cY3paA0IKCQ17fZRj1eiAO62LaTgeMszqqrfTLtJLHcKBLDtMh51KnMxgn5
        k3UkYDbb7T618YCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Add TASK_ANY for wait_task_inactive()
Cc:     Ingo@tip-bot2.tec.linutronix.de, Molnar@tip-bot2.tec.linutronix.de,
        mingo@kernel.org, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <YxhkzfuFTvRnpUaH@hirez.programming.kicks-ass.net>
References: <YxhkzfuFTvRnpUaH@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <166271402154.401.13467217119404706076.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f9fc8cad9728124cefe8844fb53d1814c92c6bfc
Gitweb:        https://git.kernel.org/tip/f9fc8cad9728124cefe8844fb53d1814c92c6bfc
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 06 Sep 2022 12:39:55 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 07 Sep 2022 21:53:49 +02:00

sched: Add TASK_ANY for wait_task_inactive()

Now that wait_task_inactive()'s @match_state argument is a mask (like
ttwu()) it is possible to replace the special !match_state case with
an 'all-states' value such that any blocked state will match.

Suggested-by: Ingo Molnar (mingo@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/YxhkzfuFTvRnpUaH@hirez.programming.kicks-ass.net
---
 drivers/powercap/idle_inject.c |  2 +-
 fs/coredump.c                  |  2 +-
 include/linux/sched.h          |  2 ++
 kernel/sched/core.c            | 16 ++++++++--------
 4 files changed, 12 insertions(+), 10 deletions(-)

diff --git a/drivers/powercap/idle_inject.c b/drivers/powercap/idle_inject.c
index a20bf12..999e218 100644
--- a/drivers/powercap/idle_inject.c
+++ b/drivers/powercap/idle_inject.c
@@ -254,7 +254,7 @@ void idle_inject_stop(struct idle_inject_device *ii_dev)
 		iit = per_cpu_ptr(&idle_inject_thread, cpu);
 		iit->should_run = 0;
 
-		wait_task_inactive(iit->tsk, 0);
+		wait_task_inactive(iit->tsk, TASK_ANY);
 	}
 
 	cpu_hotplug_enable();
diff --git a/fs/coredump.c b/fs/coredump.c
index 9f4aae2..3d9054c 100644
--- a/fs/coredump.c
+++ b/fs/coredump.c
@@ -412,7 +412,7 @@ static int coredump_wait(int exit_code, struct core_state *core_state)
 		 */
 		ptr = core_state->dumper.next;
 		while (ptr != NULL) {
-			wait_task_inactive(ptr->task, 0);
+			wait_task_inactive(ptr->task, TASK_ANY);
 			ptr = ptr->next;
 		}
 	}
diff --git a/include/linux/sched.h b/include/linux/sched.h
index e7b2f8a..0facaad 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -101,6 +101,8 @@ struct task_group;
 #define TASK_RTLOCK_WAIT		0x1000
 #define TASK_STATE_MAX			0x2000
 
+#define TASK_ANY			(TASK_STATE_MAX-1)
+
 /* Convenience macros for the sake of set_current_state: */
 #define TASK_KILLABLE			(TASK_WAKEKILL | TASK_UNINTERRUPTIBLE)
 #define TASK_STOPPED			(TASK_WAKEKILL | __TASK_STOPPED)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 43d71c6..ea26526 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3253,12 +3253,12 @@ out:
 /*
  * wait_task_inactive - wait for a thread to unschedule.
  *
- * If @match_state is nonzero, it's the @p->state value just checked and
- * not expected to change.  If it changes, i.e. @p might have woken up,
- * then return zero.  When we succeed in waiting for @p to be off its CPU,
- * we return a positive number (its total switch count).  If a second call
- * a short while later returns the same number, the caller can be sure that
- * @p has remained unscheduled the whole time.
+ * Wait for the thread to block in any of the states set in @match_state.
+ * If it changes, i.e. @p might have woken up, then return zero.  When we
+ * succeed in waiting for @p to be off its CPU, we return a positive number
+ * (its total switch count).  If a second call a short while later returns the
+ * same number, the caller can be sure that @p has remained unscheduled the
+ * whole time.
  *
  * The caller must ensure that the task *will* unschedule sometime soon,
  * else this function might spin for a *long* time. This function can't
@@ -3294,7 +3294,7 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 		 * is actually now running somewhere else!
 		 */
 		while (task_on_cpu(rq, p)) {
-			if (match_state && !(READ_ONCE(p->__state) & match_state))
+			if (!(READ_ONCE(p->__state) & match_state))
 				return 0;
 			cpu_relax();
 		}
@@ -3309,7 +3309,7 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
 		running = task_on_cpu(rq, p);
 		queued = task_on_rq_queued(p);
 		ncsw = 0;
-		if (!match_state || (READ_ONCE(p->__state) & match_state))
+		if (READ_ONCE(p->__state) & match_state)
 			ncsw = p->nvcsw | LONG_MIN; /* sets MSB */
 		task_rq_unlock(rq, p, &rf);
 
