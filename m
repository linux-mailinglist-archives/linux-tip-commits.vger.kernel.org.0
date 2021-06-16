Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18AEB3A9C8F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Jun 2021 15:49:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233604AbhFPNvn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Jun 2021 09:51:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233588AbhFPNvj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Jun 2021 09:51:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 153B5C061574;
        Wed, 16 Jun 2021 06:49:33 -0700 (PDT)
Date:   Wed, 16 Jun 2021 13:49:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1623851369;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n8t2JpNLtq5R99LO3K+YqiXcS0A0ViYYvl+wnmbtVHU=;
        b=TjXTI83HJH9Ag56v/Ui/fz/Ai/JUAX5znQ26FvCF68g2F2xQGHr3YpXwMAHAs8UVIOumG+
        qDXJKx+3uhsvlIYSdQH5NxECm+2CBEpG+XJaDlRedRKAjK3iinPjSM9TgUVvLjynayrzcO
        KKEGdxKMFfbDrDtdGwCEJLZLtdblOX8apqYfrSqqE94vdR9Ob81IgfhI2xnaV/UX6JRDfM
        mW9EaGluc/ulQQkN8ctlQyyVgmb1BiCpuzRqaFFSpF4BmdiAsTZHYPSNSE8WoufPZpZP6g
        OGGzXoXXSUpwn5AVJXGuAFodG1kMjMrlw9Y3zGlk3GY9jydyiAekWc7IJL3pJg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1623851369;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=n8t2JpNLtq5R99LO3K+YqiXcS0A0ViYYvl+wnmbtVHU=;
        b=4i/WoOFgX5ITLpEhjFU3nznQ1qBmXtJyPshKY51m+SDwWsaD4QrB+2SYFtNUpHqvpyuKDR
        FpENqRc27WFF1UDQ==
From:   "tip-bot2 for Odin Ugedal" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Correctly insert cfs_rq's to list on
 unthrottle
Cc:     Odin Ugedal <odin@uged.al>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210612112815.61678-1-odin@uged.al>
References: <20210612112815.61678-1-odin@uged.al>
MIME-Version: 1.0
Message-ID: <162385136856.19906.12464199120393641026.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     a7b359fc6a37faaf472125867c8dc5a068c90982
Gitweb:        https://git.kernel.org/tip/a7b359fc6a37faaf472125867c8dc5a068c90982
Author:        Odin Ugedal <odin@uged.al>
AuthorDate:    Sat, 12 Jun 2021 13:28:15 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Jun 2021 22:58:47 +02:00

sched/fair: Correctly insert cfs_rq's to list on unthrottle

Fix an issue where fairness is decreased since cfs_rq's can end up not
being decayed properly. For two sibling control groups with the same
priority, this can often lead to a load ratio of 99/1 (!!).

This happens because when a cfs_rq is throttled, all the descendant
cfs_rq's will be removed from the leaf list. When they initial cfs_rq
is unthrottled, it will currently only re add descendant cfs_rq's if
they have one or more entities enqueued. This is not a perfect
heuristic.

Instead, we insert all cfs_rq's that contain one or more enqueued
entities, or it its load is not completely decayed.

Can often lead to situations like this for equally weighted control
groups:

  $ ps u -C stress
  USER         PID %CPU %MEM    VSZ   RSS TTY      STAT START   TIME COMMAND
  root       10009 88.8  0.0   3676   100 pts/1    R+   11:04   0:13 stress --cpu 1
  root       10023  3.0  0.0   3676   104 pts/1    R+   11:04   0:00 stress --cpu 1

Fixes: 31bc6aeaab1d ("sched/fair: Optimize update_blocked_averages()")
[vingo: !SMP build fix]
Signed-off-by: Odin Ugedal <odin@uged.al>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20210612112815.61678-1-odin@uged.al
---
 kernel/sched/fair.c | 44 +++++++++++++++++++++++++-------------------
 1 file changed, 25 insertions(+), 19 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2c8a935..bfaa6e1 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3298,6 +3298,24 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
 
 #ifdef CONFIG_SMP
 #ifdef CONFIG_FAIR_GROUP_SCHED
+
+static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
+{
+	if (cfs_rq->load.weight)
+		return false;
+
+	if (cfs_rq->avg.load_sum)
+		return false;
+
+	if (cfs_rq->avg.util_sum)
+		return false;
+
+	if (cfs_rq->avg.runnable_sum)
+		return false;
+
+	return true;
+}
+
 /**
  * update_tg_load_avg - update the tg's load avg
  * @cfs_rq: the cfs_rq whose avg changed
@@ -4091,6 +4109,11 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
 
 #else /* CONFIG_SMP */
 
+static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
+{
+	return true;
+}
+
 #define UPDATE_TG	0x0
 #define SKIP_AGE_LOAD	0x0
 #define DO_ATTACH	0x0
@@ -4749,8 +4772,8 @@ static int tg_unthrottle_up(struct task_group *tg, void *data)
 		cfs_rq->throttled_clock_task_time += rq_clock_task(rq) -
 					     cfs_rq->throttled_clock_task;
 
-		/* Add cfs_rq with already running entity in the list */
-		if (cfs_rq->nr_running >= 1)
+		/* Add cfs_rq with load or one or more already running entities to the list */
+		if (!cfs_rq_is_decayed(cfs_rq) || cfs_rq->nr_running)
 			list_add_leaf_cfs_rq(cfs_rq);
 	}
 
@@ -7996,23 +8019,6 @@ static bool __update_blocked_others(struct rq *rq, bool *done)
 
 #ifdef CONFIG_FAIR_GROUP_SCHED
 
-static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
-{
-	if (cfs_rq->load.weight)
-		return false;
-
-	if (cfs_rq->avg.load_sum)
-		return false;
-
-	if (cfs_rq->avg.util_sum)
-		return false;
-
-	if (cfs_rq->avg.runnable_sum)
-		return false;
-
-	return true;
-}
-
 static bool __update_blocked_fair(struct rq *rq, bool *done)
 {
 	struct cfs_rq *cfs_rq, *pos;
