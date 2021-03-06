Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0991732F9FC
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 12:43:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230452AbhCFLm3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 06:42:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34236 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230311AbhCFLmV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 06:42:21 -0500
Date:   Sat, 06 Mar 2021 11:42:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615030939;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iaE5oVBmZanUmKjnQQsBxR0KacnrhRhf3jBFrAmWb0s=;
        b=z+rEXmPjGpYOry06R9d5FYW85vcPBCWzrJeiisiF9rk0PegCAblsa13IFXZrzLzNUJ8RAO
        u/C443EnQ33wzdgi9nmf2vrT+s68UoI0TqZoNXFNY2hfR//CWyzfQ4jiwMxB7GUxzMrSRz
        r5M6wpo8bQQeNy+nIAHaWh1jMskCZQt2FC1YAHXy+GnqlrzCQsgQtSiuOVvQOr7MtyIcoD
        xW2ZjWyGllT/tdZCNTQ4DaZBArgiThwBTW6y9Tnhjutf3qeaKWH5LGi75pRe7SV5n6oNxV
        0X6qWqWDxvaXduF+yN5QJ+JzuvZV4EY8sVc88cQfUMKMJGsO6Ay6CThdMsGZ3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615030939;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iaE5oVBmZanUmKjnQQsBxR0KacnrhRhf3jBFrAmWb0s=;
        b=VmroKfbA/W+9QLaxnbHM+fNEadKmTms/iRWNNX1oe46MTkd2jRkkqvjkG9onhn3CGcFj5m
        VtL5/Oo4IkMU7aCQ==
From:   "tip-bot2 for Chengming Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] psi: Add PSI_CPU_FULL state
Cc:     Muchun Song <songmuchun@bytedance.com>,
        Chengming Zhou <zhouchengming@bytedance.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210303034659.91735-2-zhouchengming@bytedance.com>
References: <20210303034659.91735-2-zhouchengming@bytedance.com>
MIME-Version: 1.0
Message-ID: <161503093913.398.12324666117151503303.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e7fcd762282332f765af2035a9568fb126fa3c01
Gitweb:        https://git.kernel.org/tip/e7fcd762282332f765af2035a9568fb126fa3c01
Author:        Chengming Zhou <zhouchengming@bytedance.com>
AuthorDate:    Wed, 03 Mar 2021 11:46:56 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:40:22 +01:00

psi: Add PSI_CPU_FULL state

The FULL state doesn't exist for the CPU resource at the system level,
but exist at the cgroup level, means all non-idle tasks in a cgroup are
delayed on the CPU resource which used by others outside of the cgroup
or throttled by the cgroup cpu.max configuration.

Co-developed-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Muchun Song <songmuchun@bytedance.com>
Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Link: https://lkml.kernel.org/r/20210303034659.91735-2-zhouchengming@bytedance.com
---
 include/linux/psi_types.h |  3 ++-
 kernel/sched/psi.c        | 14 +++++++++++---
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/include/linux/psi_types.h b/include/linux/psi_types.h
index b95f321..0a23300 100644
--- a/include/linux/psi_types.h
+++ b/include/linux/psi_types.h
@@ -50,9 +50,10 @@ enum psi_states {
 	PSI_MEM_SOME,
 	PSI_MEM_FULL,
 	PSI_CPU_SOME,
+	PSI_CPU_FULL,
 	/* Only per-CPU, to weigh the CPU in the global average: */
 	PSI_NONIDLE,
-	NR_PSI_STATES = 6,
+	NR_PSI_STATES = 7,
 };
 
 enum psi_aggregators {
diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index 967732c..2293c45 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -34,7 +34,10 @@
  * delayed on that resource such that nobody is advancing and the CPU
  * goes idle. This leaves both workload and CPU unproductive.
  *
- * (Naturally, the FULL state doesn't exist for the CPU resource.)
+ * Naturally, the FULL state doesn't exist for the CPU resource at the
+ * system level, but exist at the cgroup level, means all non-idle tasks
+ * in a cgroup are delayed on the CPU resource which used by others outside
+ * of the cgroup or throttled by the cgroup cpu.max configuration.
  *
  *	SOME = nr_delayed_tasks != 0
  *	FULL = nr_delayed_tasks != 0 && nr_running_tasks == 0
@@ -225,6 +228,8 @@ static bool test_state(unsigned int *tasks, enum psi_states state)
 		return tasks[NR_MEMSTALL] && !tasks[NR_RUNNING];
 	case PSI_CPU_SOME:
 		return tasks[NR_RUNNING] > tasks[NR_ONCPU];
+	case PSI_CPU_FULL:
+		return tasks[NR_RUNNING] && !tasks[NR_ONCPU];
 	case PSI_NONIDLE:
 		return tasks[NR_IOWAIT] || tasks[NR_MEMSTALL] ||
 			tasks[NR_RUNNING];
@@ -678,8 +683,11 @@ static void record_times(struct psi_group_cpu *groupc, int cpu,
 		}
 	}
 
-	if (groupc->state_mask & (1 << PSI_CPU_SOME))
+	if (groupc->state_mask & (1 << PSI_CPU_SOME)) {
 		groupc->times[PSI_CPU_SOME] += delta;
+		if (groupc->state_mask & (1 << PSI_CPU_FULL))
+			groupc->times[PSI_CPU_FULL] += delta;
+	}
 
 	if (groupc->state_mask & (1 << PSI_NONIDLE))
 		groupc->times[PSI_NONIDLE] += delta;
@@ -1018,7 +1026,7 @@ int psi_show(struct seq_file *m, struct psi_group *group, enum psi_res res)
 		group->avg_next_update = update_averages(group, now);
 	mutex_unlock(&group->avgs_lock);
 
-	for (full = 0; full < 2 - (res == PSI_CPU); full++) {
+	for (full = 0; full < 2; full++) {
 		unsigned long avg[3];
 		u64 total;
 		int w;
