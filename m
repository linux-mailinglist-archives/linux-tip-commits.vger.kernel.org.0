Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91A5437EDCD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 May 2021 00:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241085AbhELUzB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 16:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355851AbhELS3Y (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 14:29:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79B25C06175F;
        Wed, 12 May 2021 11:26:13 -0700 (PDT)
Date:   Wed, 12 May 2021 18:26:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620843971;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vnknK0e2ctg3Igh6TENhlQiR9U2Bi8K2EhFM1rWDC+U=;
        b=rJDrrC1pb0RMNXsAjTpExFBbGGiKtd17ZkoLTIFTzw9Mey40jPjKICrObO5jvi8a8lyCjN
        3n7OvvlZnxY4Y0wq048wyjYHrmNeBAGUg1iK+oeRjuZvu98Fl6F9WWE+nzjKnNi/8iy5Tl
        BDfho/9uLcELJQu9ObxQj8j++Y52tygEdpD/j5aSvTPjWXn0tge9nkmTjcy1p6lsbfztQk
        M9ywwhPKklwGXSjxcZp0/FpNGZ5YSp+PP3Hi1NeRp5HSS5cfjVky+FfxJtsN3Bbo2opIRn
        tfYUlSpWvw2PKvZKbdxsWj+lVmWiScF+67oDvtUmCsutH449sH2FVk25HlaK6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620843971;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=vnknK0e2ctg3Igh6TENhlQiR9U2Bi8K2EhFM1rWDC+U=;
        b=heWvYQ93xzJRRZSIKtKDgvxmosU3+kIiI9WtIVK8Y4dUKwHMD9ibr1/gOoLK3D4QUB96w/
        OMOf0CxzYyToQmAQ==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Fix leftover comment typos
Cc:     Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162084397038.29796.1281052106617710639.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     cc00c1988801dc71f63bb7bad019e85046865095
Gitweb:        https://git.kernel.org/tip/cc00c1988801dc71f63bb7bad019e85046865095
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 12 May 2021 19:51:31 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 19:54:49 +02:00

sched: Fix leftover comment typos

A few more snuck in. Also capitalize 'CPU' while at it.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/sched_clock.h | 2 +-
 kernel/sched/core.c         | 4 ++--
 kernel/sched/fair.c         | 6 +++---
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched_clock.h b/include/linux/sched_clock.h
index 528718e..835ee87 100644
--- a/include/linux/sched_clock.h
+++ b/include/linux/sched_clock.h
@@ -14,7 +14,7 @@
  * @sched_clock_mask:   Bitmask for two's complement subtraction of non 64bit
  *			clocks.
  * @read_sched_clock:	Current clock source (or dummy source when suspended).
- * @mult:		Multipler for scaled math conversion.
+ * @mult:		Multiplier for scaled math conversion.
  * @shift:		Shift value for scaled math conversion.
  *
  * Care must be taken when updating this structure; it is read by
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9d00f49..ac8882d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5506,7 +5506,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	}
 
 	/*
-	 * Try and select tasks for each sibling in decending sched_class
+	 * Try and select tasks for each sibling in descending sched_class
 	 * order.
 	 */
 	for_each_class(class) {
@@ -5520,7 +5520,7 @@ again:
 
 			/*
 			 * If this sibling doesn't yet have a suitable task to
-			 * run; ask for the most elegible task, given the
+			 * run; ask for the most eligible task, given the
 			 * highest priority task already selected for this
 			 * core.
 			 */
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2635e10..161b92a 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10808,11 +10808,11 @@ static inline void task_tick_core(struct rq *rq, struct task_struct *curr)
 	 * sched_slice() considers only this active rq and it gets the
 	 * whole slice. But during force idle, we have siblings acting
 	 * like a single runqueue and hence we need to consider runnable
-	 * tasks on this cpu and the forced idle cpu. Ideally, we should
+	 * tasks on this CPU and the forced idle CPU. Ideally, we should
 	 * go through the forced idle rq, but that would be a perf hit.
-	 * We can assume that the forced idle cpu has atleast
+	 * We can assume that the forced idle CPU has at least
 	 * MIN_NR_TASKS_DURING_FORCEIDLE - 1 tasks and use that to check
-	 * if we need to give up the cpu.
+	 * if we need to give up the CPU.
 	 */
 	if (rq->core->core_forceidle && rq->cfs.nr_running == 1 &&
 	    __entity_slice_used(&curr->se, MIN_NR_TASKS_DURING_FORCEIDLE))
