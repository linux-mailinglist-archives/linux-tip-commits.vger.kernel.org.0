Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 643C831DA1C
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Feb 2021 14:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232533AbhBQNSZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Feb 2021 08:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232813AbhBQNSQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Feb 2021 08:18:16 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0245BC06178A;
        Wed, 17 Feb 2021 05:17:35 -0800 (PST)
Date:   Wed, 17 Feb 2021 13:17:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613567853;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BhrL3muAkfD1OC8usgerNu9bZp7BL+G3tfzCSg2lOdY=;
        b=MnJ52zHxszhLJ/ux0M7QU4YYXdpOcO40aMqvXoZTLHY/yQgF1Rtgu41vYFH4YBD0vEZ0O5
        1+rpdIIB0OnCAaan/xzn8NJLBoKHfrgun9jZF+X9zsJRGgBqQndQsFf57E6TiY0X8YhViU
        uIgJxzgOtgYS/5qTNDl4t9xzA/iyu9l7L7KMzEup76bopa52Hzq9KLVEh5hxJtNHvIp0KL
        2soVSGiq1Oc2vOiLsbi0uTN5qQHM8TaF0LqHQakwmIaiX5YdAefH2IaETgkYU+N8FAY8l2
        s2TI/5KcuKRy5UF1ahlVA0Kkcaik5C7CMdsM6dMl0lo2JTKf6mJZSq3XlJv2/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613567853;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BhrL3muAkfD1OC8usgerNu9bZp7BL+G3tfzCSg2lOdY=;
        b=xPUGjGMr5OAf3f3UWGSJMSLnEBkcnHaEbdAoeMstOlTrIB6DDGb/u9NTOvRpK3Hwyq36SE
        yZ0qrF76nh9jmnDQ==
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Reduce rq lock contention in
 dl_add_task_root_domain()
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210119083542.19856-1-dietmar.eggemann@arm.com>
References: <20210119083542.19856-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Message-ID: <161356785255.20312.13367741328558766056.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     de40f33e788b0c016bfde512ace2f76339ef7ddb
Gitweb:        https://git.kernel.org/tip/de40f33e788b0c016bfde512ace2f76339ef7ddb
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Tue, 19 Jan 2021 09:35:42 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Feb 2021 14:12:42 +01:00

sched/deadline: Reduce rq lock contention in dl_add_task_root_domain()

dl_add_task_root_domain() is called during sched domain rebuild:

  rebuild_sched_domains_locked()
    partition_and_rebuild_sched_domains()
      rebuild_root_domains()
         for all top_cpuset descendants:
           update_tasks_root_domain()
             for all tasks of cpuset:
               dl_add_task_root_domain()

Change it so that only the task pi lock is taken to check if the task
has a SCHED_DEADLINE (DL) policy. In case that p is a DL task take the
rq lock as well to be able to safely de-reference root domain's DL
bandwidth structure.

Most of the tasks will have another policy (namely SCHED_NORMAL) and
can now bail without taking the rq lock.

One thing to note here: Even in case that there aren't any DL user
tasks, a slow frequency switching system with cpufreq gov schedutil has
a DL task (sugov) per frequency domain running which participates in DL
bandwidth management.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Quentin Perret <qperret@google.com>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Link: https://lkml.kernel.org/r/20210119083542.19856-1-dietmar.eggemann@arm.com
---
 kernel/sched/deadline.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 1508d12..6f37796 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2388,9 +2388,13 @@ void dl_add_task_root_domain(struct task_struct *p)
 	struct rq *rq;
 	struct dl_bw *dl_b;
 
-	rq = task_rq_lock(p, &rf);
-	if (!dl_task(p))
-		goto unlock;
+	raw_spin_lock_irqsave(&p->pi_lock, rf.flags);
+	if (!dl_task(p)) {
+		raw_spin_unlock_irqrestore(&p->pi_lock, rf.flags);
+		return;
+	}
+
+	rq = __task_rq_lock(p, &rf);
 
 	dl_b = &rq->rd->dl_bw;
 	raw_spin_lock(&dl_b->lock);
@@ -2399,7 +2403,6 @@ void dl_add_task_root_domain(struct task_struct *p)
 
 	raw_spin_unlock(&dl_b->lock);
 
-unlock:
 	task_rq_unlock(rq, p, &rf);
 }
 
