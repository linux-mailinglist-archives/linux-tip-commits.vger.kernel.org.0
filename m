Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98294316868
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 14:55:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229862AbhBJNyi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 08:54:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:60046 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbhBJNyS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 08:54:18 -0500
Date:   Wed, 10 Feb 2021 13:53:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612965214;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cg4/5xXxjSHz0LoxcroQPzq3ZOq6K504umU746+xNlQ=;
        b=xASIKKsR7I906Cpt63JFcHVoV8c0YDqDlrWMzx3SknIeJGg8dgH4cXlAPVbrYAqYr45aTB
        Qh/JDCCMHilxklMi6o6UBOAFwZo2d07e3JZm+W35MTRtB1vuIr8Zky/xB/qP7BvKkoyrnE
        hp+WCZWqHaMmM/YHHFRESWTTgnnQ8Z/yC3C99G4LOUDP2B8ngQh6dfqL8PJXsOaui9VhFd
        2u/PWeFDkrJLzCW8LEkNOSSgLXZi8e/wKiDKiwrlgWhQlwd29p5Mbl43iEaGkyX2cg63oZ
        1yp77CxQA6jfK0RRVoa7ARc8Rcx+nho6wnFaPdpoXFWJhxNBVPSQkDI8WisksQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612965214;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cg4/5xXxjSHz0LoxcroQPzq3ZOq6K504umU746+xNlQ=;
        b=KXwQBZ+zdcOarZ1WahM+/nl2cLszr0ACkFWsPTssWNwf/3YrKqQ+PdPPKHpXnHGi2sMoUo
        mNAOQz6FOMRpYpBA==
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Reduce rq lock contention in
 dl_add_task_root_domain()
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Quentin Perret <qperret@google.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210119083542.19856-1-dietmar.eggemann@arm.com>
References: <20210119083542.19856-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Message-ID: <161296521364.23325.3769071094517881031.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     3096b6fe494b7b4e45d20cb77aa6b715a3efe344
Gitweb:        https://git.kernel.org/tip/3096b6fe494b7b4e45d20cb77aa6b715a3efe344
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Tue, 19 Jan 2021 09:35:42 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 10 Feb 2021 14:44:48 +01:00

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
 
