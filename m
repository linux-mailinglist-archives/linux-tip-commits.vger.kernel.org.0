Return-Path: <linux-tip-commits+bounces-2279-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C00EF972BC7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 10:14:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EC108B259D5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 08:14:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2D1F01940B0;
	Tue, 10 Sep 2024 08:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="z3SwBgpU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Eyd+gExX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFBD2192B8F;
	Tue, 10 Sep 2024 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725955775; cv=none; b=ODnfUk9RjqbCdGltMteQ5pxuPlmWasn8cQgemxJ+uXPo6yxUHobc1JuHWUehtKpPRcSNOJ6VBVuO1NGI5TVoH3QQdah8dhY1zsVteUhS7xmaIdPGe217DBaCFKnWe5T2uRX6JgTrJRFbP5iR/zpLr/3H2EriDQ3zlXze0xUUCK4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725955775; c=relaxed/simple;
	bh=EsFepkyA6C5Y65Cjeh3fNe6IbD6z4p8VBWjVtuIZxZc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tNlZc1RiB8ZUkJALvb6+D4vs5AFYvCtRC1LjlceXy0Bh06hof5xJ9ydQcTU33vyrUYUvf1PVA/mGoipr+g4qQdjDdB2kjumYZkz12PZ2D8Juu46vzF/5HbVmXmyVLzaxx6AAjA+x+CuBhKUHlVjLDHk6BucGvFfOdGgtplcquAA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=z3SwBgpU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Eyd+gExX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Sep 2024 08:09:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725955763;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5eCqaDmGOr/PuG3KbhLihCvjSkEU6SEq/z/RjeZP8ME=;
	b=z3SwBgpUy1r8SaDuUNi/vs8yhebQvoKSZdb5t0QMt13wMCmFQU7hDwQ4jHncddTR7XnN8a
	od7DhtWwURCICI6o0/+nweJIR6bVrH7ozhmOUjteuTe8cv+0FO6P5lAHW8vyo14iCm5UdZ
	Ark3vi3as+RHJOG6rNeZoh3SuX0LjjXqg9LG6zhrYXhhCdtP8KGzoIiOnGRQVH8ztD28ha
	rJaR2XvoZ2Mw44HkO45afVTt5JLSRVEdZLcL5MusFzuLBIvKzSQgMRZ5mNl6EbPG47EuYK
	d626zQ67Tfpg82Bv3jG3W40YahygOsVFXiPjzzZsmKI/ST6brgAgimznxgjAmQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725955763;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5eCqaDmGOr/PuG3KbhLihCvjSkEU6SEq/z/RjeZP8ME=;
	b=Eyd+gExXbvRvPb1xpzkeR3dEEWB4/XIiqHxarHvP1gka5VKwnU/1NW1q86yJI5T7csC0th
	093Hx+gOJ0CqWYAA==
From: "tip-bot2 for Huang Shijie" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/debug: Fix the runnable tasks output
Cc: "Christoph Lameter (Ampere)" <cl@linux.com>,
 Huang Shijie <shijie@os.amperecomputing.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240906053019.7874-1-shijie@os.amperecomputing.com>
References: <20240906053019.7874-1-shijie@os.amperecomputing.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172595576279.2215.9944850942613758587.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2cab4bd024d23f658e40dce209dfd012f4e8b19a
Gitweb:        https://git.kernel.org/tip/2cab4bd024d23f658e40dce209dfd012f4e8b19a
Author:        Huang Shijie <shijie@os.amperecomputing.com>
AuthorDate:    Fri, 06 Sep 2024 13:30:19 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Sep 2024 09:51:15 +02:00

sched/debug: Fix the runnable tasks output

The current runnable tasks output looks like:

  runnable tasks:
   S            task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep
  -------------------------------------------------------------------------------------------------------------
   Ikworker/R-rcu_g     4         0.129049 E         0.620179           0.750000         0.002920         2   100         0.000000         0.002920         0.000000         0.000000 0 0 /
   Ikworker/R-sync_     5         0.125328 E         0.624147           0.750000         0.001840         2   100         0.000000         0.001840         0.000000         0.000000 0 0 /
   Ikworker/R-slub_     6         0.120835 E         0.628680           0.750000         0.001800         2   100         0.000000         0.001800         0.000000         0.000000 0 0 /
   Ikworker/R-netns     7         0.114294 E         0.634701           0.750000         0.002400         2   100         0.000000         0.002400         0.000000         0.000000 0 0 /
   I    kworker/0:1     9       508.781746 E       511.754666           3.000000       151.575240       224   120         0.000000       151.575240         0.000000         0.000000 0 0 /

Which is messy. Remove the duplicate printing of sum_exec_runtime and
tidy up the layout to make it look like:

  runnable tasks:
   S            task   PID       vruntime   eligible    deadline             slice          sum-exec      switches  prio         wait-time        sum-sleep       sum-block  node   group-id  group-path
  -----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
   I     kworker/0:3  1698       295.001459   E         297.977619           3.000000        38.862920         9     120         0.000000         0.000000         0.000000   0      0        /
   I     kworker/0:4  1702       278.026303   E         281.026303           3.000000         9.918760         3     120         0.000000         0.000000         0.000000   0      0        /
   S  NetworkManager  2646         0.377936   E           2.598104           3.000000        98.535880       314     120         0.000000         0.000000         0.000000   0      0        /system.slice/NetworkManager.service
   S       virtqemud  2689         0.541016   E           2.440104           3.000000        50.967960        80     120         0.000000         0.000000         0.000000   0      0        /system.slice/virtqemud.service
   S   gsd-smartcard  3058        73.604144   E          76.475904           3.000000        74.033320        88     120         0.000000         0.000000         0.000000   0      0        /user.slice/user-42.slice/session-c1.scope

Reviewed-by: Christoph Lameter (Ampere) <cl@linux.com>
Signed-off-by: Huang Shijie <shijie@os.amperecomputing.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20240906053019.7874-1-shijie@os.amperecomputing.com
---
 kernel/sched/debug.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 01ce9a7..de1dc52 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -739,7 +739,7 @@ print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
 	else
 		SEQ_printf(m, " %c", task_state_to_char(p));
 
-	SEQ_printf(m, "%15s %5d %9Ld.%06ld %c %9Ld.%06ld %c %9Ld.%06ld %9Ld.%06ld %9Ld %5d ",
+	SEQ_printf(m, " %15s %5d %9Ld.%06ld   %c   %9Ld.%06ld %c %9Ld.%06ld %9Ld.%06ld %9Ld   %5d ",
 		p->comm, task_pid_nr(p),
 		SPLIT_NS(p->se.vruntime),
 		entity_eligible(cfs_rq_of(&p->se), &p->se) ? 'E' : 'N',
@@ -750,17 +750,16 @@ print_task(struct seq_file *m, struct rq *rq, struct task_struct *p)
 		(long long)(p->nvcsw + p->nivcsw),
 		p->prio);
 
-	SEQ_printf(m, "%9lld.%06ld %9lld.%06ld %9lld.%06ld %9lld.%06ld",
+	SEQ_printf(m, "%9lld.%06ld %9lld.%06ld %9lld.%06ld",
 		SPLIT_NS(schedstat_val_or_zero(p->stats.wait_sum)),
-		SPLIT_NS(p->se.sum_exec_runtime),
 		SPLIT_NS(schedstat_val_or_zero(p->stats.sum_sleep_runtime)),
 		SPLIT_NS(schedstat_val_or_zero(p->stats.sum_block_runtime)));
 
 #ifdef CONFIG_NUMA_BALANCING
-	SEQ_printf(m, " %d %d", task_node(p), task_numa_group_id(p));
+	SEQ_printf(m, "   %d      %d", task_node(p), task_numa_group_id(p));
 #endif
 #ifdef CONFIG_CGROUP_SCHED
-	SEQ_printf_task_group_path(m, task_group(p), " %s")
+	SEQ_printf_task_group_path(m, task_group(p), "        %s")
 #endif
 
 	SEQ_printf(m, "\n");
@@ -772,10 +771,26 @@ static void print_rq(struct seq_file *m, struct rq *rq, int rq_cpu)
 
 	SEQ_printf(m, "\n");
 	SEQ_printf(m, "runnable tasks:\n");
-	SEQ_printf(m, " S            task   PID         tree-key  switches  prio"
-		   "     wait-time             sum-exec        sum-sleep\n");
+	SEQ_printf(m, " S            task   PID       vruntime   eligible    "
+		   "deadline             slice          sum-exec      switches  "
+		   "prio         wait-time        sum-sleep       sum-block"
+#ifdef CONFIG_NUMA_BALANCING
+		   "  node   group-id"
+#endif
+#ifdef CONFIG_CGROUP_SCHED
+		   "  group-path"
+#endif
+		   "\n");
 	SEQ_printf(m, "-------------------------------------------------------"
-		   "------------------------------------------------------\n");
+		   "------------------------------------------------------"
+		   "------------------------------------------------------"
+#ifdef CONFIG_NUMA_BALANCING
+		   "--------------"
+#endif
+#ifdef CONFIG_CGROUP_SCHED
+		   "--------------"
+#endif
+		   "\n");
 
 	rcu_read_lock();
 	for_each_process_thread(g, p) {

