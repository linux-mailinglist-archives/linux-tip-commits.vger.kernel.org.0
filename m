Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7226932F9F7
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 12:43:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbhCFLma (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 06:42:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230329AbhCFLmV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 06:42:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7F37C061760;
        Sat,  6 Mar 2021 03:42:20 -0800 (PST)
Date:   Sat, 06 Mar 2021 11:42:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615030939;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OtCP09WvW9qGYlkOGxq/0menNUv0fdvsr1kCKhuJ4eM=;
        b=hl6pBQqU1nr8PeUs0+PVMUlIbDXWWXwSJh1B0TlWxSk6IdolJsF/Qaoj0IOXTe5CAU2dot
        1dQa/SwLozvHh9tX+sFfWYmHCL9XycgNABzM/zhjbeZorA3Z5g218yWQGo22xdAFocu9SD
        /ir/I060puq6UgpRiMUrN3R5aJAZ4ZVqG6jaAb32bTREOvZAk7OFpZ3mvUqb1M1AuaB7+t
        al1dD7/CTsC4lNddiHmZy1fM75r9fx2H1rqj0ZgweqbJPkW5SjicgbnYfpvL1up6+YdXv+
        fyTUPhRMQgVfWl/kocRipVGm3TW+VRAwS8HPhtgLPkTf/loDq/LLDuyR+9y6HA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615030939;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OtCP09WvW9qGYlkOGxq/0menNUv0fdvsr1kCKhuJ4eM=;
        b=TCzQ5uH+tQr83acF6RJfuorALnIOfyxFk9BqfELX2fulysyhgpFfLQpz4F9Tq190k8tb+u
        /qCT2h2B7HjCaaBA==
From:   "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] psi: Optimize task switch inside shared cgroups
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210303034659.91735-5-zhouchengming@bytedance.com>
References: <20210303034659.91735-5-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <161503093807.398.7510792283650382775.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4117cebf1a9fcbf35b9aabf0e37b6c5eea296798
Gitweb:        https://git.kernel.org/tip/4117cebf1a9fcbf35b9aabf0e37b6c5eea296798
Author:        Chengming Zhou <zhouchengming@bytedance.com>
AuthorDate:    Wed, 03 Mar 2021 11:46:59 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:40:23 +01:00

psi: Optimize task switch inside shared cgroups

The commit 36b238d57172 ("psi: Optimize switching tasks inside shared
cgroups") only update cgroups whose state actually changes during a
task switch only in task preempt case, not in task sleep case.

We actually don't need to clear and set TSK_ONCPU state for common cgroups
of next and prev task in sleep case, that can save many psi_group_change
especially when most activity comes from one leaf cgroup.

sleep before:
psi_dequeue()
  while ((group = iterate_groups(prev)))  # all ancestors
    psi_group_change(prev, .clear=TSK_RUNNING|TSK_ONCPU)
psi_task_switch()
  while ((group = iterate_groups(next)))  # all ancestors
    psi_group_change(next, .set=TSK_ONCPU)

sleep after:
psi_dequeue()
  nop
psi_task_switch()
  while ((group = iterate_groups(next)))  # until (prev & next)
    psi_group_change(next, .set=TSK_ONCPU)
  while ((group = iterate_groups(prev)))  # all ancestors
    psi_group_change(prev, .clear=common?TSK_RUNNING:TSK_RUNNING|TSK_ONCPU)

When a voluntary sleep switches to another task, we remove one call of
psi_group_change() for every common cgroup ancestor of the two tasks.

Co-developed-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Link: https://lkml.kernel.org/r/20210303034659.91735-5-zhouchengming@bytedance.com
---
 kernel/sched/psi.c   | 35 +++++++++++++++++++++++++----------
 kernel/sched/stats.h | 28 ++++++++++++----------------
 2 files changed, 37 insertions(+), 26 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 3907a6b..ee3c5b4 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -840,20 +840,35 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		}
 	}
 
-	/*
-	 * If this is a voluntary sleep, dequeue will have taken care
-	 * of the outgoing TSK_ONCPU alongside TSK_RUNNING already. We
-	 * only need to deal with it during preemption.
-	 */
-	if (sleep)
-		return;
-
 	if (prev->pid) {
-		psi_flags_change(prev, TSK_ONCPU, 0);
+		int clear = TSK_ONCPU, set = 0;
+
+		/*
+		 * When we're going to sleep, psi_dequeue() lets us handle
+		 * TSK_RUNNING and TSK_IOWAIT here, where we can combine it
+		 * with TSK_ONCPU and save walking common ancestors twice.
+		 */
+		if (sleep) {
+			clear |= TSK_RUNNING;
+			if (prev->in_iowait)
+				set |= TSK_IOWAIT;
+		}
+
+		psi_flags_change(prev, clear, set);
 
 		iter = NULL;
 		while ((group = iterate_groups(prev, &iter)) && group != common)
-			psi_group_change(group, cpu, TSK_ONCPU, 0, true);
+			psi_group_change(group, cpu, clear, set, true);
+
+		/*
+		 * TSK_ONCPU is handled up to the common ancestor. If we're tasked
+		 * with dequeuing too, finish that for the rest of the hierarchy.
+		 */
+		if (sleep) {
+			clear &= ~TSK_ONCPU;
+			for (; group; group = iterate_groups(prev, &iter))
+				psi_group_change(group, cpu, clear, set, true);
+		}
 	}
 }
 
diff --git a/kernel/sched/stats.h b/kernel/sched/stats.h
index 9e4e67a..dc218e9 100644
--- a/kernel/sched/stats.h
+++ b/kernel/sched/stats.h
@@ -84,28 +84,24 @@ static inline void psi_enqueue(struct task_struct *p, bool wakeup)
 
 static inline void psi_dequeue(struct task_struct *p, bool sleep)
 {
-	int clear = TSK_RUNNING, set = 0;
+	int clear = TSK_RUNNING;
 
 	if (static_branch_likely(&psi_disabled))
 		return;
 
-	if (!sleep) {
-		if (p->in_memstall)
-			clear |= TSK_MEMSTALL;
-	} else {
-		/*
-		 * When a task sleeps, schedule() dequeues it before
-		 * switching to the next one. Merge the clearing of
-		 * TSK_RUNNING and TSK_ONCPU to save an unnecessary
-		 * psi_task_change() call in psi_sched_switch().
-		 */
-		clear |= TSK_ONCPU;
+	/*
+	 * A voluntary sleep is a dequeue followed by a task switch. To
+	 * avoid walking all ancestors twice, psi_task_switch() handles
+	 * TSK_RUNNING and TSK_IOWAIT for us when it moves TSK_ONCPU.
+	 * Do nothing here.
+	 */
+	if (sleep)
+		return;
 
-		if (p->in_iowait)
-			set |= TSK_IOWAIT;
-	}
+	if (p->in_memstall)
+		clear |= TSK_MEMSTALL;
 
-	psi_task_change(p, clear, set);
+	psi_task_change(p, clear, 0);
 }
 
 static inline void psi_ttwu_dequeue(struct task_struct *p)
