Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B27C34626A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 23 Mar 2021 16:09:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232471AbhCWPJ0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 23 Mar 2021 11:09:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232710AbhCWPJF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 23 Mar 2021 11:09:05 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CB5CC061574;
        Tue, 23 Mar 2021 08:09:04 -0700 (PDT)
Date:   Tue, 23 Mar 2021 15:08:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1616512138;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VWya+oRmkQeCEUG9aB4YZDUlYh8Osk7vXfGzNe1bvNU=;
        b=EwyIY3G9BNHmtnyDmxKuMnS35INLY2hDPQYX+Ibu79n/UHI3jl6JAlkSJ4QDYmGmwMFc7c
        aCgVVIGNj5wOwhICcBU6rsJDdWigwM3zyQkjpOT1RtotL0jc8Yr7em9KCi0iuGnjmGNQlj
        EO6zp1MvfxXCrda+i1EtT6IuXdiVrNpEnttw3HXBI4yLPOWZPbhuKLO4pnli+uZSYUQjtr
        G6rTUwm+GOPQ9iTlA8z4/pvJ7kIbp7M+ZPjGnUusPn87mR0ijyS37M+6gXEM5VCGxzN9uT
        C/VeK+wY0E9iFpPPdToEWk4eYxKGap69jO20iufqkX0gxsxwpr3Fac//dIGA6g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1616512138;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=VWya+oRmkQeCEUG9aB4YZDUlYh8Osk7vXfGzNe1bvNU=;
        b=LQOJL/crHNxAzsw4IGsYu9cgxRfHRwnQ+RLAARCxocs1Md1cYRFyZ2zewqPoS3TP4rhCWL
        JcuKFfia+nzyIrDQ==
From:   "tip-bot2 for Shakeel Butt" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] psi: Reduce calls to sched_clock() in psi
Cc:     Shakeel Butt <shakeelb@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Johannes Weiner <hannes@cmpxchg.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210321205156.4186483-1-shakeelb@google.com>
References: <20210321205156.4186483-1-shakeelb@google.com>
MIME-Version: 1.0
Message-ID: <161651213738.398.10634964583212923406.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     df77430639c9cf73559bac0f25084518bf9a812d
Gitweb:        https://git.kernel.org/tip/df77430639c9cf73559bac0f25084518bf9a812d
Author:        Shakeel Butt <shakeelb@google.com>
AuthorDate:    Sun, 21 Mar 2021 13:51:56 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 23 Mar 2021 16:01:58 +01:00

psi: Reduce calls to sched_clock() in psi

We noticed that the cost of psi increases with the increase in the
levels of the cgroups. Particularly the cost of cpu_clock() sticks out
as the kernel calls it multiple times as it traverses up the cgroup
tree. This patch reduces the calls to cpu_clock().

Performed perf bench on Intel Broadwell with 3 levels of cgroup.

Before the patch:

$ perf bench sched all
 # Running sched/messaging benchmark...
 # 20 sender and receiver processes per group
 # 10 groups == 400 processes run

     Total time: 0.747 [sec]

 # Running sched/pipe benchmark...
 # Executed 1000000 pipe operations between two processes

     Total time: 3.516 [sec]

       3.516689 usecs/op
         284358 ops/sec

After the patch:

$ perf bench sched all
 # Running sched/messaging benchmark...
 # 20 sender and receiver processes per group
 # 10 groups == 400 processes run

     Total time: 0.640 [sec]

 # Running sched/pipe benchmark...
 # Executed 1000000 pipe operations between two processes

     Total time: 3.329 [sec]

       3.329820 usecs/op
         300316 ops/sec

Signed-off-by: Shakeel Butt <shakeelb@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Link: https://lkml.kernel.org/r/20210321205156.4186483-1-shakeelb@google.com
---
 kernel/sched/psi.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index c8480d7..b1b00e9 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -644,12 +644,10 @@ static void poll_timer_fn(struct timer_list *t)
 	wake_up_interruptible(&group->poll_wait);
 }
 
-static void record_times(struct psi_group_cpu *groupc, int cpu)
+static void record_times(struct psi_group_cpu *groupc, u64 now)
 {
 	u32 delta;
-	u64 now;
 
-	now = cpu_clock(cpu);
 	delta = now - groupc->state_start;
 	groupc->state_start = now;
 
@@ -676,7 +674,7 @@ static void record_times(struct psi_group_cpu *groupc, int cpu)
 }
 
 static void psi_group_change(struct psi_group *group, int cpu,
-			     unsigned int clear, unsigned int set,
+			     unsigned int clear, unsigned int set, u64 now,
 			     bool wake_clock)
 {
 	struct psi_group_cpu *groupc;
@@ -696,7 +694,7 @@ static void psi_group_change(struct psi_group *group, int cpu,
 	 */
 	write_seqcount_begin(&groupc->seq);
 
-	record_times(groupc, cpu);
+	record_times(groupc, now);
 
 	for (t = 0, m = clear; m; m &= ~(1 << t), t++) {
 		if (!(m & (1 << t)))
@@ -788,12 +786,14 @@ void psi_task_change(struct task_struct *task, int clear, int set)
 	struct psi_group *group;
 	bool wake_clock = true;
 	void *iter = NULL;
+	u64 now;
 
 	if (!task->pid)
 		return;
 
 	psi_flags_change(task, clear, set);
 
+	now = cpu_clock(cpu);
 	/*
 	 * Periodic aggregation shuts off if there is a period of no
 	 * task changes, so we wake it back up if necessary. However,
@@ -806,7 +806,7 @@ void psi_task_change(struct task_struct *task, int clear, int set)
 		wake_clock = false;
 
 	while ((group = iterate_groups(task, &iter)))
-		psi_group_change(group, cpu, clear, set, wake_clock);
+		psi_group_change(group, cpu, clear, set, now, wake_clock);
 }
 
 void psi_task_switch(struct task_struct *prev, struct task_struct *next,
@@ -815,6 +815,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 	struct psi_group *group, *common = NULL;
 	int cpu = task_cpu(prev);
 	void *iter;
+	u64 now = cpu_clock(cpu);
 
 	if (next->pid) {
 		bool identical_state;
@@ -836,7 +837,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 				break;
 			}
 
-			psi_group_change(group, cpu, 0, TSK_ONCPU, true);
+			psi_group_change(group, cpu, 0, TSK_ONCPU, now, true);
 		}
 	}
 
@@ -858,7 +859,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 
 		iter = NULL;
 		while ((group = iterate_groups(prev, &iter)) && group != common)
-			psi_group_change(group, cpu, clear, set, true);
+			psi_group_change(group, cpu, clear, set, now, true);
 
 		/*
 		 * TSK_ONCPU is handled up to the common ancestor. If we're tasked
@@ -867,7 +868,7 @@ void psi_task_switch(struct task_struct *prev, struct task_struct *next,
 		if (sleep) {
 			clear &= ~TSK_ONCPU;
 			for (; group; group = iterate_groups(prev, &iter))
-				psi_group_change(group, cpu, clear, set, true);
+				psi_group_change(group, cpu, clear, set, now, true);
 		}
 	}
 }
