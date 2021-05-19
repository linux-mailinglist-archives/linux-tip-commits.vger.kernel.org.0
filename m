Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 904FA388913
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 May 2021 10:09:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243851AbhESIKW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 19 May 2021 04:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240902AbhESIKW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 19 May 2021 04:10:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCD90C06175F;
        Wed, 19 May 2021 01:09:02 -0700 (PDT)
Date:   Wed, 19 May 2021 08:08:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621411740;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dUCERU9g9rZFhynKVWNlHl2jaYGMVAcJmlgr8bUKKsg=;
        b=ntYJwSciLL0hLHHOq8j+0tDVUrb0uRaaY/GEpp4CdDpp/Mmm8s3ocnic9Sf9sxtvxFiM2e
        JLFaY1/2kdDr4M1L7ybiXHo93tOlEzEuvx6goBnv5wQNUyCV+sR/jrJLoYIW0vzLWx46tx
        ymT5vnnSQWjWV1VrXwkrYBH9JB6Y0Y+7Jb/DgSqmfWjEd9Z+CBj6HueWlAXSDiuxBYhcMm
        HlUW5QWwkGxVrEw7xCRRTlCYvu+wLkPOInhDJFkr6hbXhYFRGkgWNZsvM3UYEHb1m8DXt2
        8mEeN+rHZ4uEwTyuLbixBRMCxzPqMlUDIEYjx65haUdjYiOVRk1voPCVcBiNDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621411740;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dUCERU9g9rZFhynKVWNlHl2jaYGMVAcJmlgr8bUKKsg=;
        b=vv+8vIJGbw2RcYmp8zxTpvHh77rNTbc1+L2GcYNCUMbeaG+amtVJikQFR9UcdKI1X0Nj0e
        h8eiAph+N7QwG6AQ==
From:   "tip-bot2 for Zqiang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/urgent] locking/mutex: clear MUTEX_FLAGS if wait_list
 is empty due to signal
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Zqiang <qiang.zhang@windriver.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210517034005.30828-1-qiang.zhang@windriver.com>
References: <20210517034005.30828-1-qiang.zhang@windriver.com>
MIME-Version: 1.0
Message-ID: <162141173966.29796.5194146484813242607.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/urgent branch of tip:

Commit-ID:     3a010c493271f04578b133de977e0e5dd2848cea
Gitweb:        https://git.kernel.org/tip/3a010c493271f04578b133de977e0e5dd2848cea
Author:        Zqiang <qiang.zhang@windriver.com>
AuthorDate:    Mon, 17 May 2021 11:40:05 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 May 2021 12:53:51 +02:00

locking/mutex: clear MUTEX_FLAGS if wait_list is empty due to signal

When a interruptible mutex locker is interrupted by a signal
without acquiring this lock and removed from the wait queue.
if the mutex isn't contended enough to have a waiter
put into the wait queue again, the setting of the WAITER
bit will force mutex locker to go into the slowpath to
acquire the lock every time, so if the wait queue is empty,
the WAITER bit need to be clear.

Fixes: 040a0a371005 ("mutex: Add support for wound/wait style locks")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Zqiang <qiang.zhang@windriver.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210517034005.30828-1-qiang.zhang@windriver.com
---
 kernel/locking/mutex-debug.c |  4 ++--
 kernel/locking/mutex-debug.h |  2 +-
 kernel/locking/mutex.c       | 18 +++++++++++++-----
 kernel/locking/mutex.h       |  4 +---
 4 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/kernel/locking/mutex-debug.c b/kernel/locking/mutex-debug.c
index a7276aa..db93015 100644
--- a/kernel/locking/mutex-debug.c
+++ b/kernel/locking/mutex-debug.c
@@ -57,7 +57,7 @@ void debug_mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 	task->blocked_on = waiter;
 }
 
-void mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
+void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 			 struct task_struct *task)
 {
 	DEBUG_LOCKS_WARN_ON(list_empty(&waiter->list));
@@ -65,7 +65,7 @@ void mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 	DEBUG_LOCKS_WARN_ON(task->blocked_on != waiter);
 	task->blocked_on = NULL;
 
-	list_del_init(&waiter->list);
+	INIT_LIST_HEAD(&waiter->list);
 	waiter->task = NULL;
 }
 
diff --git a/kernel/locking/mutex-debug.h b/kernel/locking/mutex-debug.h
index 1edd3f4..53e631e 100644
--- a/kernel/locking/mutex-debug.h
+++ b/kernel/locking/mutex-debug.h
@@ -22,7 +22,7 @@ extern void debug_mutex_free_waiter(struct mutex_waiter *waiter);
 extern void debug_mutex_add_waiter(struct mutex *lock,
 				   struct mutex_waiter *waiter,
 				   struct task_struct *task);
-extern void mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
+extern void debug_mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 				struct task_struct *task);
 extern void debug_mutex_unlock(struct mutex *lock);
 extern void debug_mutex_init(struct mutex *lock, const char *name,
diff --git a/kernel/locking/mutex.c b/kernel/locking/mutex.c
index cb6b112..013e1b0 100644
--- a/kernel/locking/mutex.c
+++ b/kernel/locking/mutex.c
@@ -194,7 +194,7 @@ static inline bool __mutex_waiter_is_first(struct mutex *lock, struct mutex_wait
  * Add @waiter to a given location in the lock wait_list and set the
  * FLAG_WAITERS flag if it's the first waiter.
  */
-static void __sched
+static void
 __mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 		   struct list_head *list)
 {
@@ -205,6 +205,16 @@ __mutex_add_waiter(struct mutex *lock, struct mutex_waiter *waiter,
 		__mutex_set_flag(lock, MUTEX_FLAG_WAITERS);
 }
 
+static void
+__mutex_remove_waiter(struct mutex *lock, struct mutex_waiter *waiter)
+{
+	list_del(&waiter->list);
+	if (likely(list_empty(&lock->wait_list)))
+		__mutex_clear_flag(lock, MUTEX_FLAGS);
+
+	debug_mutex_remove_waiter(lock, waiter, current);
+}
+
 /*
  * Give up ownership to a specific task, when @task = NULL, this is equivalent
  * to a regular unlock. Sets PICKUP on a handoff, clears HANDOFF, preserves
@@ -1061,9 +1071,7 @@ acquired:
 			__ww_mutex_check_waiters(lock, ww_ctx);
 	}
 
-	mutex_remove_waiter(lock, &waiter, current);
-	if (likely(list_empty(&lock->wait_list)))
-		__mutex_clear_flag(lock, MUTEX_FLAGS);
+	__mutex_remove_waiter(lock, &waiter);
 
 	debug_mutex_free_waiter(&waiter);
 
@@ -1080,7 +1088,7 @@ skip_wait:
 
 err:
 	__set_current_state(TASK_RUNNING);
-	mutex_remove_waiter(lock, &waiter, current);
+	__mutex_remove_waiter(lock, &waiter);
 err_early_kill:
 	spin_unlock(&lock->wait_lock);
 	debug_mutex_free_waiter(&waiter);
diff --git a/kernel/locking/mutex.h b/kernel/locking/mutex.h
index 1c2287d..f0c710b 100644
--- a/kernel/locking/mutex.h
+++ b/kernel/locking/mutex.h
@@ -10,12 +10,10 @@
  * !CONFIG_DEBUG_MUTEXES case. Most of them are NOPs:
  */
 
-#define mutex_remove_waiter(lock, waiter, task) \
-		__list_del((waiter)->list.prev, (waiter)->list.next)
-
 #define debug_mutex_wake_waiter(lock, waiter)		do { } while (0)
 #define debug_mutex_free_waiter(waiter)			do { } while (0)
 #define debug_mutex_add_waiter(lock, waiter, ti)	do { } while (0)
+#define debug_mutex_remove_waiter(lock, waiter, ti)     do { } while (0)
 #define debug_mutex_unlock(lock)			do { } while (0)
 #define debug_mutex_init(lock, name, key)		do { } while (0)
 
