Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DE813B15B2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jun 2021 10:19:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbhFWIV6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 23 Jun 2021 04:21:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbhFWIVk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 23 Jun 2021 04:21:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60D96C061766;
        Wed, 23 Jun 2021 01:19:23 -0700 (PDT)
Date:   Wed, 23 Jun 2021 08:19:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624436361;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B517Cxk53bPhx0ZH7YJQ/2Tbc2ga10Zno7Gp1uYPWkM=;
        b=q8R84NQzYMyuSk4Mwyuh6iwA281OO1V/xJLg2oaq8kywIDwK8RWSV/LbT6m+hrFzJIJPZe
        PXFEEPIUQJ3izLxsfoYAhrwH0FYMskRx1FFde9Wpg4FZ/NkyYtlCIwm9to3/8dzGO2oPbh
        53eJ3jUuzvBNJHTYdi3wyvPIuhvgG69xinb5kTmlZtA9LM0/khXNzyioiIN7HEb9Z5vzaV
        5X1j7comimUqonFohnkJYiZmx1Q1dkAUj4DOPMKSFsDwfp7ML+N480j7gSwWiJy5l+0nvN
        RdrbzlDtja27V+w4BJAwyMUzu0tuo951nJMeUGF8X5ZMDV4X8568gwvL4OFV1A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624436361;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=B517Cxk53bPhx0ZH7YJQ/2Tbc2ga10Zno7Gp1uYPWkM=;
        b=SF/uHc4H2he/fgczUn9BPewgbY2awZrbTrYHet39eRijc2juRfpRXJzwGlwF3XSl4nSAbo
        CAgn7qHSfYLN6aCQ==
From:   "tip-bot2 for Vincent Donnefort" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/rt: Fix RT utilization tracking during policy change
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1624271872-211872-2-git-send-email-vincent.donnefort@arm.com>
References: <1624271872-211872-2-git-send-email-vincent.donnefort@arm.com>
MIME-Version: 1.0
Message-ID: <162443636097.395.8556355025777632399.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fecfcbc288e9f4923f40fd23ca78a6acdc7fdf6c
Gitweb:        https://git.kernel.org/tip/fecfcbc288e9f4923f40fd23ca78a6acdc7fdf6c
Author:        Vincent Donnefort <vincent.donnefort@arm.com>
AuthorDate:    Mon, 21 Jun 2021 11:37:51 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 22 Jun 2021 16:41:59 +02:00

sched/rt: Fix RT utilization tracking during policy change

RT keeps track of the utilization on a per-rq basis with the structure
avg_rt. This utilization is updated during task_tick_rt(),
put_prev_task_rt() and set_next_task_rt(). However, when the current
running task changes its policy, set_next_task_rt() which would usually
take care of updating the utilization when the rq starts running RT tasks,
will not see a such change, leaving the avg_rt structure outdated. When
that very same task will be dequeued later, put_prev_task_rt() will then
update the utilization, based on a wrong last_update_time, leading to a
huge spike in the RT utilization signal.

The signal would eventually recover from this issue after few ms. Even if
no RT tasks are run, avg_rt is also updated in __update_blocked_others().
But as the CPU capacity depends partly on the avg_rt, this issue has
nonetheless a significant impact on the scheduler.

Fix this issue by ensuring a load update when a running task changes
its policy to RT.

Fixes: 371bf427 ("sched/rt: Add rt_rq utilization tracking")
Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/1624271872-211872-2-git-send-email-vincent.donnefort@arm.com
---
 kernel/sched/rt.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index a525447..3daf42a 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2341,13 +2341,20 @@ void __init init_sched_rt_class(void)
 static void switched_to_rt(struct rq *rq, struct task_struct *p)
 {
 	/*
-	 * If we are already running, then there's nothing
-	 * that needs to be done. But if we are not running
-	 * we may need to preempt the current running task.
-	 * If that current running task is also an RT task
+	 * If we are running, update the avg_rt tracking, as the running time
+	 * will now on be accounted into the latter.
+	 */
+	if (task_current(rq, p)) {
+		update_rt_rq_load_avg(rq_clock_pelt(rq), rq, 0);
+		return;
+	}
+
+	/*
+	 * If we are not running we may need to preempt the current
+	 * running task. If that current running task is also an RT task
 	 * then see if we can move to another run queue.
 	 */
-	if (task_on_rq_queued(p) && rq->curr != p) {
+	if (task_on_rq_queued(p)) {
 #ifdef CONFIG_SMP
 		if (p->nr_cpus_allowed > 1 && rq->rt.overloaded)
 			rt_queue_push_tasks(rq);
