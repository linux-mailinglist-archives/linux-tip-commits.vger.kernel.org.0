Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7E586060
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2019 12:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731054AbfHHKxM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 8 Aug 2019 06:53:12 -0400
Received: from terminus.zytor.com ([198.137.202.136]:48291 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726721AbfHHKxL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 8 Aug 2019 06:53:11 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x78Aqp8R3126753
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 8 Aug 2019 03:52:51 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x78Aqp8R3126753
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565261571;
        bh=4a8c+YhUsYrUJvzUdA0tmb2VO0OfNsXRzfUv0n3jYoc=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=YE5l8N59amlUR4bELb8YRfC/fzoZXAyXID7YtVavar526/Thz2lDr4gljTudxTlXk
         2muS6T2XLqgGhU3TVIQ4BxixJf/g+q/o8qAg39wS8phNqT2aajkCC9ypeGQUaEInQg
         ppnpzb8g0yHY+/Lwxwrdm5mUoSaX514JbU2VjMVoUmY9ddnhC2NUDSuvzp1nmShwuj
         OvHzTC8Zav0HTYybVWc0BuDsr37Dk+GY+atEAsg+i1OkqgJAbyaz5A8T7QYvPI7XLD
         dNWL3ug7Dfqzs7D+XQHNnZjiyH1numjPXe2s60EqQuNSNCygWDCzMIBDS0sDQHH6dZ
         z0A0KfClwg48g==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x78AqokK3126750;
        Thu, 8 Aug 2019 03:52:50 -0700
Date:   Thu, 8 Aug 2019 03:52:50 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-139d025cda1da5484e7287b35c019fe1dcf9b650@git.kernel.org>
Cc:     mathieu.desnoyers@efficios.com, riel@surriel.com, mingo@kernel.org,
        tglx@linutronix.de, hpa@zytor.com, peterz@infradead.org
Reply-To: peterz@infradead.org, linux-kernel@vger.kernel.org,
          mathieu.desnoyers@efficios.com, mingo@kernel.org,
          riel@surriel.com, tglx@linutronix.de, hpa@zytor.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] sched: Clean up active_mm reference counting
Git-Commit-ID: 139d025cda1da5484e7287b35c019fe1dcf9b650
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.3 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Commit-ID:  139d025cda1da5484e7287b35c019fe1dcf9b650
Gitweb:     https://git.kernel.org/tip/139d025cda1da5484e7287b35c019fe1dcf9b650
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Mon, 29 Jul 2019 16:05:15 +0200
Committer:  Peter Zijlstra <peterz@infradead.org>
CommitDate: Thu, 8 Aug 2019 09:09:30 +0200

sched: Clean up active_mm reference counting

The current active_mm reference counting is confusing and sub-optimal.

Rewrite the code to explicitly consider the 4 separate cases:

    user -> user

	When switching between two user tasks, all we need to consider
	is switch_mm().

    user -> kernel

	When switching from a user task to a kernel task (which
	doesn't have an associated mm) we retain the last mm in our
	active_mm. Increment a reference count on active_mm.

  kernel -> kernel

	When switching between kernel threads, all we need to do is
	pass along the active_mm reference.

  kernel -> user

	When switching between a kernel and user task, we must switch
	from the last active_mm to the next mm, hoping of course that
	these are the same. Decrement a reference on the active_mm.

The code keeps a different order, because as you'll note, both 'to
user' cases require switch_mm().

And where the old code would increment/decrement for the 'kernel ->
kernel' case, the new code observes this is a neutral operation and
avoids touching the reference count.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Rik van Riel <riel@surriel.com>
Reviewed-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: luto@kernel.org
---
 kernel/sched/core.c | 49 ++++++++++++++++++++++++++++++-------------------
 1 file changed, 30 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 46f3ca9e392a..b4a44bc84749 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3214,12 +3214,8 @@ static __always_inline struct rq *
 context_switch(struct rq *rq, struct task_struct *prev,
 	       struct task_struct *next, struct rq_flags *rf)
 {
-	struct mm_struct *mm, *oldmm;
-
 	prepare_task_switch(rq, prev, next);
 
-	mm = next->mm;
-	oldmm = prev->active_mm;
 	/*
 	 * For paravirt, this is coupled with an exit in switch_to to
 	 * combine the page table reload and the switch backend into
@@ -3228,22 +3224,37 @@ context_switch(struct rq *rq, struct task_struct *prev,
 	arch_start_context_switch(prev);
 
 	/*
-	 * If mm is non-NULL, we pass through switch_mm(). If mm is
-	 * NULL, we will pass through mmdrop() in finish_task_switch().
-	 * Both of these contain the full memory barrier required by
-	 * membarrier after storing to rq->curr, before returning to
-	 * user-space.
+	 * kernel -> kernel   lazy + transfer active
+	 *   user -> kernel   lazy + mmgrab() active
+	 *
+	 * kernel ->   user   switch + mmdrop() active
+	 *   user ->   user   switch
 	 */
-	if (!mm) {
-		next->active_mm = oldmm;
-		mmgrab(oldmm);
-		enter_lazy_tlb(oldmm, next);
-	} else
-		switch_mm_irqs_off(oldmm, mm, next);
-
-	if (!prev->mm) {
-		prev->active_mm = NULL;
-		rq->prev_mm = oldmm;
+	if (!next->mm) {                                // to kernel
+		enter_lazy_tlb(prev->active_mm, next);
+
+		next->active_mm = prev->active_mm;
+		if (prev->mm)                           // from user
+			mmgrab(prev->active_mm);
+		else
+			prev->active_mm = NULL;
+	} else {                                        // to user
+		/*
+		 * sys_membarrier() requires an smp_mb() between setting
+		 * rq->curr and returning to userspace.
+		 *
+		 * The below provides this either through switch_mm(), or in
+		 * case 'prev->active_mm == next->mm' through
+		 * finish_task_switch()'s mmdrop().
+		 */
+
+		switch_mm_irqs_off(prev->active_mm, next->mm, next);
+
+		if (!prev->mm) {                        // from kernel
+			/* will mmdrop() in finish_task_switch(). */
+			rq->prev_mm = prev->active_mm;
+			prev->active_mm = NULL;
+		}
 	}
 
 	rq->clock_update_flags &= ~(RQCF_ACT_SKIP|RQCF_REQ_SKIP);
