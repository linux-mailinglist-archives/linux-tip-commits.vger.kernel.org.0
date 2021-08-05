Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F17673E115E
	for <lists+linux-tip-commits@lfdr.de>; Thu,  5 Aug 2021 11:34:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239208AbhHEJev (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 5 Aug 2021 05:34:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41652 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239169AbhHEJeu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 5 Aug 2021 05:34:50 -0400
Date:   Thu, 05 Aug 2021 09:34:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628156075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eYYM1z1ICfBEi6NkEzMl2UVVSnIo7UBb39eFZVqR1AY=;
        b=RpfqmnjSEyfbVadTdVpqD0yeEVeJR4RVLfDbBw7hyM2Z7rYWhmfMhfrwfqjQuZTrtHj8Y1
        qBZpTTROGdSt3y1GpL7oYhjEm2EWLDq+f0sfZQjzCSCpc6/le5GsKBKaseX4wfWncQU1yU
        YlDTlN1HUz+1JGH8AZlPcxY3CQuL+djRAgBOAk8rWYsiK+yuZKrv7MroQQ7frLJrXygeAU
        CDtkr7lPDLy9HDhec3e+WfHEWufUQnq0I03Ii4tYbKk4UKAvqwaIN1yh74zw7eoWNWKbS3
        Y8qxUE4zF5i5TASUaLNUuMbhBe7VLpk9s2p/HVmB+5cRJ9iYrcXWaWx5i7rPWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628156075;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eYYM1z1ICfBEi6NkEzMl2UVVSnIo7UBb39eFZVqR1AY=;
        b=dTW3yHALQhOrYl1bvp6oj6jE4PzclUt1IGhd47qdTWhtG+hBX8vkus7DAE5vdiN2m5sPTM
        2RYqz37E6KTRTgCg==
From:   "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Use prev instead of new target as
 recent_used_cpu
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210804115857.6253-2-mgorman@techsingularity.net>
References: <20210804115857.6253-2-mgorman@techsingularity.net>
MIME-Version: 1.0
Message-ID: <162815607443.395.9073618977839470202.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     89aafd67f28c9e3b725aa30b44b7f61ad3e348ce
Gitweb:        https://git.kernel.org/tip/89aafd67f28c9e3b725aa30b44b7f61ad3e348ce
Author:        Mel Gorman <mgorman@techsingularity.net>
AuthorDate:    Wed, 04 Aug 2021 12:58:56 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 04 Aug 2021 15:16:44 +02:00

sched/fair: Use prev instead of new target as recent_used_cpu

After select_idle_sibling, p->recent_used_cpu is set to the
new target. However on the next wakeup, prev will be the same as
recent_used_cpu unless the load balancer has moved the task since the
last wakeup. It still works, but is less efficient than it could be.
This patch preserves recent_used_cpu for longer.

The impact on SIS efficiency is tiny so the SIS statistic patches were
used to track the hit rate for using recent_used_cpu. With perf bench
pipe on a 2-socket Cascadelake machine, the hit rate went from 57.14%
to 85.32%. For more intensive wakeup loads like hackbench, the hit rate
is almost negligible but rose from 0.21% to 6.64%. For scaling loads
like tbench, the hit rate goes from almost 0% to 25.42% overall. Broadly
speaking, on tbench, the success rate is much higher for lower thread
counts and drops to almost 0 as the workload scales to towards saturation.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210804115857.6253-2-mgorman@techsingularity.net
---
 kernel/sched/fair.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 13c3fd4..7ee394b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6347,6 +6347,7 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 
 	/* Check a recently used CPU as a potential idle candidate: */
 	recent_used_cpu = p->recent_used_cpu;
+	p->recent_used_cpu = prev;
 	if (recent_used_cpu != prev &&
 	    recent_used_cpu != target &&
 	    cpus_share_cache(recent_used_cpu, target) &&
@@ -6873,9 +6874,6 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
 	} else if (wake_flags & WF_TTWU) { /* XXX always ? */
 		/* Fast path */
 		new_cpu = select_idle_sibling(p, prev_cpu, new_cpu);
-
-		if (want_affine)
-			current->recent_used_cpu = cpu;
 	}
 	rcu_read_unlock();
 
