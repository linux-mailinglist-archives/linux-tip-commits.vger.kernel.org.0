Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4712360471
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Apr 2021 10:37:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231769AbhDOIiH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 15 Apr 2021 04:38:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58310 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231710AbhDOIiB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 15 Apr 2021 04:38:01 -0400
Date:   Thu, 15 Apr 2021 08:37:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618475858;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iflNOAc77w3kq9tozGFhigUvlAM3AiSvPdoqcZsUX9Y=;
        b=WBP/m/MmZfZBwbH1050SFrvS9ECZ4mXRsY2/9KS+1n+WKL+bSqjleDESgbZQmEQp81P/ZN
        c68BvKhMweG/BaOXC38pPoxiBmh5dlFIPOyMjOEdhGV9yltByfaj8yRmb5ByaNrFtT7QW3
        SfUmDjqWkFdFuJ2xhk5JcLU8LY7FLYfRuswzwOKpFkOs/moNEtBYqHeC5V6+g7Ac14sk37
        ufrl1qMP9t4AQlpIVNRlKPdSBVVmyr9RIVOhWTfyNaqvGRZl4IsBrtml0cFTDIMKxEyKcD
        Y+ZsGNBE53aFEnUz3bDjJQiuqVqdUXrXuNMv9Z1xMnDv/x7R8yR9s5G90rkhVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618475858;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iflNOAc77w3kq9tozGFhigUvlAM3AiSvPdoqcZsUX9Y=;
        b=R+9fY/Fwh3X6PkSJfh/cpal6dR4SBGXmt4sQhA35rwvNZHOu/EBRrUQ5wN/lOT/bHMjkmt
        WdZEZ9pRBC9GdqDw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] signal: Hand SIGQUEUE_PREALLOC flag to __sigqueue_alloc()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210322092258.898677147@linutronix.de>
References: <20210322092258.898677147@linutronix.de>
MIME-Version: 1.0
Message-ID: <161847585573.29796.1243362956609044823.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     69995ebbb9d3717306a165db88a1292b63f77a37
Gitweb:        https://git.kernel.org/tip/69995ebbb9d3717306a165db88a1292b63f77a37
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Mon, 22 Mar 2021 10:19:42 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 14 Apr 2021 18:04:08 +02:00

signal: Hand SIGQUEUE_PREALLOC flag to __sigqueue_alloc()

There is no point in having the conditional at the callsite.

Just hand in the allocation mode flag to __sigqueue_alloc() and use it to
initialize sigqueue::flags.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210322092258.898677147@linutronix.de
---
 kernel/signal.c | 17 +++++++----------
 1 file changed, 7 insertions(+), 10 deletions(-)

diff --git a/kernel/signal.c b/kernel/signal.c
index ba4d1ef..568a2e2 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -410,7 +410,8 @@ void task_join_group_stop(struct task_struct *task)
  *   appropriate lock must be held to stop the target task from exiting
  */
 static struct sigqueue *
-__sigqueue_alloc(int sig, struct task_struct *t, gfp_t flags, int override_rlimit)
+__sigqueue_alloc(int sig, struct task_struct *t, gfp_t gfp_flags,
+		 int override_rlimit, const unsigned int sigqueue_flags)
 {
 	struct sigqueue *q = NULL;
 	struct user_struct *user;
@@ -432,7 +433,7 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t flags, int override_rlimi
 	rcu_read_unlock();
 
 	if (override_rlimit || likely(sigpending <= task_rlimit(t, RLIMIT_SIGPENDING))) {
-		q = kmem_cache_alloc(sigqueue_cachep, flags);
+		q = kmem_cache_alloc(sigqueue_cachep, gfp_flags);
 	} else {
 		print_dropped_signal(sig);
 	}
@@ -442,7 +443,7 @@ __sigqueue_alloc(int sig, struct task_struct *t, gfp_t flags, int override_rlimi
 			free_uid(user);
 	} else {
 		INIT_LIST_HEAD(&q->list);
-		q->flags = 0;
+		q->flags = sigqueue_flags;
 		q->user = user;
 	}
 
@@ -1113,7 +1114,8 @@ static int __send_signal(int sig, struct kernel_siginfo *info, struct task_struc
 	else
 		override_rlimit = 0;
 
-	q = __sigqueue_alloc(sig, t, GFP_ATOMIC, override_rlimit);
+	q = __sigqueue_alloc(sig, t, GFP_ATOMIC, override_rlimit, 0);
+
 	if (q) {
 		list_add_tail(&q->list, &pending->list);
 		switch ((unsigned long) info) {
@@ -1807,12 +1809,7 @@ EXPORT_SYMBOL(kill_pid);
  */
 struct sigqueue *sigqueue_alloc(void)
 {
-	struct sigqueue *q = __sigqueue_alloc(-1, current, GFP_KERNEL, 0);
-
-	if (q)
-		q->flags |= SIGQUEUE_PREALLOC;
-
-	return q;
+	return __sigqueue_alloc(-1, current, GFP_KERNEL, 0, SIGQUEUE_PREALLOC);
 }
 
 void sigqueue_free(struct sigqueue *q)
