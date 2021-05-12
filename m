Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 21BB837BA73
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 12:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230525AbhELK3t (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 06:29:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50450 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230431AbhELK3k (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 06:29:40 -0400
Date:   Wed, 12 May 2021 10:28:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620815311;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JFpxutQ52KhJVif/bjT71h36ld8ZNtFl2uXMahINpmY=;
        b=qcotagwm3ui3Xyfg0dTvbw+cxiRIu4d4tJBqEGxriShNVLipLD+MnWrb2EgJbZEMhwM5uW
        atcHgNLkJi5a0mMDnn6XQzW1/dPgdQ1eD+m+HRBKMZCisYqyanB7AnVFUMq64u50pQ4BqE
        weT33YE+nykhXnbka/Ipa0Qz8rLsxsxOxDroFwZcxKCaqPTjdpeCDH3XuB82VNBLn+WDN0
        lKigGI+BRBANIbGdPKNBCyl6KeAr47jM6iPENM1CvKif5tkpyDzKyt/Cb3zr6NknG72DI7
        LKuXhonK0jSpNFcAUd3x9Mv95ZFMZ5oYRB/3cE6WhUFOEp5+L1qnVvSmxMwpog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620815311;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JFpxutQ52KhJVif/bjT71h36ld8ZNtFl2uXMahINpmY=;
        b=n7pc390Jr2WhHJnaTkfBeSG/sFyOWTQSVV//MjsEiEXzf5kQL5JOpAGdUYO1UoOpApqnp0
        3FzfKVWeQg70p8DQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Rename sched_info_{queued,dequeued}
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Balbir Singh <bsingharora@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210505111525.061402904@infradead.org>
References: <20210505111525.061402904@infradead.org>
MIME-Version: 1.0
Message-ID: <162081531085.29796.9908485098819730495.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4e29fb709885eda5f0d1fa3418e6ead01a64e46d
Gitweb:        https://git.kernel.org/tip/4e29fb709885eda5f0d1fa3418e6ead01a64e46d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 04 May 2021 22:43:45 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 12 May 2021 11:43:24 +02:00

sched: Rename sched_info_{queued,dequeued}

For consistency, rename {queued,dequeued} to {enqueue,dequeue}.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Rik van Riel <riel@surriel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Link: https://lkml.kernel.org/r/20210505111525.061402904@infradead.org
---
 kernel/sched/core.c  |  4 ++--
 kernel/sched/stats.h | 20 ++++++++++----------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 61d1d85..660120d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1595,7 +1595,7 @@ static inline void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 		update_rq_clock(rq);
 
 	if (!(flags & ENQUEUE_RESTORE)) {
-		sched_info_queued(rq, p);
+		sched_info_enqueue(rq, p);
 		psi_enqueue(p, flags & ENQUEUE_WAKEUP);
 	}
 
@@ -1609,7 +1609,7 @@ static inline void dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 		update_rq_clock(rq);
 
 	if (!(flags & DEQUEUE_SAVE)) {
-		sched_info_dequeued(rq, p);
+		sched_info_dequeue(rq, p);
 		psi_dequeue(p, flags & DEQUEUE_SLEEP);
 	}
 
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index dc218e9..ee7da12 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -25,7 +25,7 @@ rq_sched_info_depart(struct rq *rq, unsigned long long delta)
 }
 
 static inline void
-rq_sched_info_dequeued(struct rq *rq, unsigned long long delta)
+rq_sched_info_dequeue(struct rq *rq, unsigned long long delta)
 {
 	if (rq)
 		rq->rq_sched_info.run_delay += delta;
@@ -42,7 +42,7 @@ rq_sched_info_dequeued(struct rq *rq, unsigned long long delta)
 
 #else /* !CONFIG_SCHEDSTATS: */
 static inline void rq_sched_info_arrive  (struct rq *rq, unsigned long long delta) { }
-static inline void rq_sched_info_dequeued(struct rq *rq, unsigned long long delta) { }
+static inline void rq_sched_info_dequeue(struct rq *rq, unsigned long long delta) { }
 static inline void rq_sched_info_depart  (struct rq *rq, unsigned long long delta) { }
 # define   schedstat_enabled()		0
 # define __schedstat_inc(var)		do { } while (0)
@@ -161,7 +161,7 @@ static inline void sched_info_reset_dequeued(struct task_struct *t)
  * from dequeue_task() to account for possible rq->clock skew across CPUs. The
  * delta taken on each CPU would annul the skew.
  */
-static inline void sched_info_dequeued(struct rq *rq, struct task_struct *t)
+static inline void sched_info_dequeue(struct rq *rq, struct task_struct *t)
 {
 	unsigned long long now = rq_clock(rq), delta = 0;
 
@@ -172,7 +172,7 @@ static inline void sched_info_dequeued(struct rq *rq, struct task_struct *t)
 	sched_info_reset_dequeued(t);
 	t->sched_info.run_delay += delta;
 
-	rq_sched_info_dequeued(rq, delta);
+	rq_sched_info_dequeue(rq, delta);
 }
 
 /*
@@ -197,9 +197,9 @@ static void sched_info_arrive(struct rq *rq, struct task_struct *t)
 /*
  * This function is only called from enqueue_task(), but also only updates
  * the timestamp if it is already not set.  It's assumed that
- * sched_info_dequeued() will clear that stamp when appropriate.
+ * sched_info_dequeue() will clear that stamp when appropriate.
  */
-static inline void sched_info_queued(struct rq *rq, struct task_struct *t)
+static inline void sched_info_enqueue(struct rq *rq, struct task_struct *t)
 {
 	if (sched_info_on()) {
 		if (!t->sched_info.last_queued)
@@ -212,7 +212,7 @@ static inline void sched_info_queued(struct rq *rq, struct task_struct *t)
  * due, typically, to expiring its time slice (this may also be called when
  * switching to the idle task).  Now we can calculate how long we ran.
  * Also, if the process is still in the TASK_RUNNING state, call
- * sched_info_queued() to mark that it has now again started waiting on
+ * sched_info_enqueue() to mark that it has now again started waiting on
  * the runqueue.
  */
 static inline void sched_info_depart(struct rq *rq, struct task_struct *t)
@@ -222,7 +222,7 @@ static inline void sched_info_depart(struct rq *rq, struct task_struct *t)
 	rq_sched_info_depart(rq, delta);
 
 	if (t->state == TASK_RUNNING)
-		sched_info_queued(rq, t);
+		sched_info_enqueue(rq, t);
 }
 
 /*
@@ -253,9 +253,9 @@ sched_info_switch(struct rq *rq, struct task_struct *prev, struct task_struct *n
 }
 
 #else /* !CONFIG_SCHED_INFO: */
-# define sched_info_queued(rq, t)	do { } while (0)
+# define sched_info_enqueue(rq, t)	do { } while (0)
 # define sched_info_reset_dequeued(t)	do { } while (0)
-# define sched_info_dequeued(rq, t)	do { } while (0)
+# define sched_info_dequeue(rq, t)	do { } while (0)
 # define sched_info_depart(rq, t)	do { } while (0)
 # define sched_info_arrive(rq, next)	do { } while (0)
 # define sched_info_switch(rq, t, next)	do { } while (0)
