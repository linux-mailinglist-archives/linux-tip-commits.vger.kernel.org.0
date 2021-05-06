Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83A63375513
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 May 2021 15:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234235AbhEFNt1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 6 May 2021 09:49:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40476 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234443AbhEFNtZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 6 May 2021 09:49:25 -0400
Date:   Thu, 06 May 2021 13:48:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620308906;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=02vWQ9gOfYYl0+Iu02w//G5cjdHa6zKG4kvO0ezJKts=;
        b=yWT+fsCNQqqPfzVjhomlrnB1tkySwgvFTC5K6peI1cphQ0KWD1Q7u7KZX8otmoVHpLeaVo
        70tx+GCBFECovfycGRharr3VQhRyUEuxwHE2YKEer+M2dSuh9GTPCPwJkPeq1KvYv7dOOa
        b+gfN6TUnOjCYCUlJTP7Bk/2L8a8BXEFg6EgVWSpGSEgeHnvfgWdfY7szUyX52vzKcKXev
        IK94cH12oT+bVyo2sLz/h14luyYONuuqYzWloBvl00IBWPy8OkLlp1Qi9g3ShoM7E4+jPe
        hB2jfO0LBVYyOCH39222SIpGqTrRZmhS2gGrhTeTOsjdfaIVGUy6f2rHJhYfqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620308906;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=02vWQ9gOfYYl0+Iu02w//G5cjdHa6zKG4kvO0ezJKts=;
        b=1EzjPjHLnLITbYBFn/AzAMwo4ADpiKoo+1EQsuKevB8aweKTRnF36wQMUUC2f/Wy3g8CaH
        8WgvKwGW69VOzyAw==
From:   "tip-bot2 for Odin Ugedal" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Fix unfairness caused by missing load decay
Cc:     Odin Ugedal <odin@uged.al>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210501141950.23622-2-odin@uged.al>
References: <20210501141950.23622-2-odin@uged.al>
MIME-Version: 1.0
Message-ID: <162030890606.29796.7614015886343679813.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     0258bdfaff5bd13c4d2383150b7097aecd6b6d82
Gitweb:        https://git.kernel.org/tip/0258bdfaff5bd13c4d2383150b7097aecd6b6d82
Author:        Odin Ugedal <odin@uged.al>
AuthorDate:    Sat, 01 May 2021 16:19:50 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 06 May 2021 15:33:27 +02:00

sched/fair: Fix unfairness caused by missing load decay

This fixes an issue where old load on a cfs_rq is not properly decayed,
resulting in strange behavior where fairness can decrease drastically.
Real workloads with equally weighted control groups have ended up
getting a respective 99% and 1%(!!) of cpu time.

When an idle task is attached to a cfs_rq by attaching a pid to a cgroup,
the old load of the task is attached to the new cfs_rq and sched_entity by
attach_entity_cfs_rq. If the task is then moved to another cpu (and
therefore cfs_rq) before being enqueued/woken up, the load will be moved
to cfs_rq->removed from the sched_entity. Such a move will happen when
enforcing a cpuset on the task (eg. via a cgroup) that force it to move.

The load will however not be removed from the task_group itself, making
it look like there is a constant load on that cfs_rq. This causes the
vruntime of tasks on other sibling cfs_rq's to increase faster than they
are supposed to; causing severe fairness issues. If no other task is
started on the given cfs_rq, and due to the cpuset it would not happen,
this load would never be properly unloaded. With this patch the load
will be properly removed inside update_blocked_averages. This also
applies to tasks moved to the fair scheduling class and moved to another
cpu, and this path will also fix that. For fork, the entity is queued
right away, so this problem does not affect that.

This applies to cases where the new process is the first in the cfs_rq,
issue introduced 3d30544f0212 ("sched/fair: Apply more PELT fixes"), and
when there has previously been load on the cgroup but the cgroup was
removed from the leaflist due to having null PELT load, indroduced
in 039ae8bcf7a5 ("sched/fair: Fix O(nr_cgroups) in the load balancing
path").

For a simple cgroup hierarchy (as seen below) with two equally weighted
groups, that in theory should get 50/50 of cpu time each, it often leads
to a load of 60/40 or 70/30.

parent/
  cg-1/
    cpu.weight: 100
    cpuset.cpus: 1
  cg-2/
    cpu.weight: 100
    cpuset.cpus: 1

If the hierarchy is deeper (as seen below), while keeping cg-1 and cg-2
equally weighted, they should still get a 50/50 balance of cpu time.
This however sometimes results in a balance of 10/90 or 1/99(!!) between
the task groups.

$ ps u -C stress
USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
root       18568  1.1  0.0   3684   100 pts/12   R+   13:36   0:00 stress --cpu 1
root       18580 99.3  0.0   3684   100 pts/12   R+   13:36   0:09 stress --cpu 1

parent/
  cg-1/
    cpu.weight: 100
    sub-group/
      cpu.weight: 1
      cpuset.cpus: 1
  cg-2/
    cpu.weight: 100
    sub-group/
      cpu.weight: 10000
      cpuset.cpus: 1

This can be reproduced by attaching an idle process to a cgroup and
moving it to a given cpuset before it wakes up. The issue is evident in
many (if not most) container runtimes, and has been reproduced
with both crun and runc (and therefore docker and all its "derivatives"),
and with both cgroup v1 and v2.

Fixes: 3d30544f0212 ("sched/fair: Apply more PELT fixes")
Fixes: 039ae8bcf7a5 ("sched/fair: Fix O(nr_cgroups) in the load balancing path")
Signed-off-by: Odin Ugedal <odin@uged.al>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20210501141950.23622-2-odin@uged.al
---
 kernel/sched/fair.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1d75af1..20aa234 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10878,16 +10878,22 @@ static void propagate_entity_cfs_rq(struct sched_entity *se)
 {
 	struct cfs_rq *cfs_rq;
 
+	list_add_leaf_cfs_rq(cfs_rq_of(se));
+
 	/* Start to propagate at parent */
 	se = se->parent;
 
 	for_each_sched_entity(se) {
 		cfs_rq = cfs_rq_of(se);
 
-		if (cfs_rq_throttled(cfs_rq))
-			break;
+		if (!cfs_rq_throttled(cfs_rq)){
+			update_load_avg(cfs_rq, se, UPDATE_TG);
+			list_add_leaf_cfs_rq(cfs_rq);
+			continue;
+		}
 
-		update_load_avg(cfs_rq, se, UPDATE_TG);
+		if (list_add_leaf_cfs_rq(cfs_rq))
+			break;
 	}
 }
 #else
