Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A9F42422A76
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Oct 2021 16:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235689AbhJEOOl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 5 Oct 2021 10:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235262AbhJEOOI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 5 Oct 2021 10:14:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A03B6C061793;
        Tue,  5 Oct 2021 07:12:14 -0700 (PDT)
Date:   Tue, 05 Oct 2021 14:12:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633443133;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eegi6xyiAqS4LwnOmXB8RuPENGp0CdNAYL/lJ702iEA=;
        b=es2SDFfLZ59tCCtHBJ9HLZwjFHEzFRhpJlpon2km+nQAZYi2bRQvZvQiaxZShxBIjmxMLw
        WZGVx/7jCN+IfMRoIOmEML4mh0wYcABvFKFJlNKPRhZbxyHA7lM0nTYbyFtfIj7AouRExw
        ddQdOLAKaHI677VIqE3vX7h32VsrHbcrM0jc0xAkz6yVAmI4xV2AP3b7F5HB5cfN74Zg5H
        93J34R4Are067EnY30th2KHf1gt1uBs5UgKYns+ZFrvwk4WVwQpKg8fjauhXJF052LbJuN
        1DCpk8bEqrA0qo/4/rDqOJnooSZcTnVIQZdrifP5cQ2FKhvVhcQu1/+ovCMVoQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633443133;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eegi6xyiAqS4LwnOmXB8RuPENGp0CdNAYL/lJ702iEA=;
        b=R6Gjc4CwKNAazQlL4tB/1rO4vtTyWJHpgXhKVvQ3NMpVP7tOrU+OA0MAmfOL08GgJbeeKj
        kctisFdLT5jnS4Aw==
From:   "tip-bot2 for Huaixin Chang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Add cfs bandwidth burst statistics
Cc:     Shanpei Chen <shanpeic@linux.alibaba.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        Huaixin Chang <changhuaixin@linux.alibaba.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Daniel Jordan <daniel.m.jordan@oracle.com>,
        Tejun Heo <tj@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210830032215.16302-2-changhuaixin@linux.alibaba.com>
References: <20210830032215.16302-2-changhuaixin@linux.alibaba.com>
MIME-Version: 1.0
Message-ID: <163344313225.25758.1000121253168096559.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     bcb1704a1ed2de580a46f28922e223a65f16e0f5
Gitweb:        https://git.kernel.org/tip/bcb1704a1ed2de580a46f28922e223a65f16e0f5
Author:        Huaixin Chang <changhuaixin@linux.alibaba.com>
AuthorDate:    Mon, 30 Aug 2021 11:22:14 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Oct 2021 15:51:40 +02:00

sched/fair: Add cfs bandwidth burst statistics

Two new statistics are introduced to show the internal of burst feature
and explain why burst helps or not.

nr_bursts:  number of periods bandwidth burst occurs
burst_time: cumulative wall-time (in nanoseconds) that any cpus has
	    used above quota in respective periods

Co-developed-by: Shanpei Chen <shanpeic@linux.alibaba.com>
Signed-off-by: Shanpei Chen <shanpeic@linux.alibaba.com>
Co-developed-by: Tianchen Ding <dtcccc@linux.alibaba.com>
Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
Signed-off-by: Huaixin Chang <changhuaixin@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Daniel Jordan <daniel.m.jordan@oracle.com>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lore.kernel.org/r/20210830032215.16302-2-changhuaixin@linux.alibaba.com
---
 kernel/sched/core.c  | 13 ++++++++++---
 kernel/sched/fair.c  |  9 +++++++++
 kernel/sched/sched.h |  3 +++
 3 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index f963c81..ccb604a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10406,6 +10406,9 @@ static int cpu_cfs_stat_show(struct seq_file *sf, void *v)
 		seq_printf(sf, "wait_sum %llu\n", ws);
 	}
 
+	seq_printf(sf, "nr_bursts %d\n", cfs_b->nr_burst);
+	seq_printf(sf, "burst_time %llu\n", cfs_b->burst_time);
+
 	return 0;
 }
 #endif /* CONFIG_CFS_BANDWIDTH */
@@ -10521,16 +10524,20 @@ static int cpu_extra_stat_show(struct seq_file *sf,
 	{
 		struct task_group *tg = css_tg(css);
 		struct cfs_bandwidth *cfs_b = &tg->cfs_bandwidth;
-		u64 throttled_usec;
+		u64 throttled_usec, burst_usec;
 
 		throttled_usec = cfs_b->throttled_time;
 		do_div(throttled_usec, NSEC_PER_USEC);
+		burst_usec = cfs_b->burst_time;
+		do_div(burst_usec, NSEC_PER_USEC);
 
 		seq_printf(sf, "nr_periods %d\n"
 			   "nr_throttled %d\n"
-			   "throttled_usec %llu\n",
+			   "throttled_usec %llu\n"
+			   "nr_bursts %d\n"
+			   "burst_usec %llu\n",
 			   cfs_b->nr_periods, cfs_b->nr_throttled,
-			   throttled_usec);
+			   throttled_usec, cfs_b->nr_burst, burst_usec);
 	}
 #endif
 	return 0;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 5457c80..fd41abe 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4715,11 +4715,20 @@ static inline u64 sched_cfs_bandwidth_slice(void)
  */
 void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
 {
+	s64 runtime;
+
 	if (unlikely(cfs_b->quota == RUNTIME_INF))
 		return;
 
 	cfs_b->runtime += cfs_b->quota;
+	runtime = cfs_b->runtime_snap - cfs_b->runtime;
+	if (runtime > 0) {
+		cfs_b->burst_time += runtime;
+		cfs_b->nr_burst++;
+	}
+
 	cfs_b->runtime = min(cfs_b->runtime, cfs_b->quota + cfs_b->burst);
+	cfs_b->runtime_snap = cfs_b->runtime;
 }
 
 static inline struct cfs_bandwidth *tg_cfs_bandwidth(struct task_group *tg)
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 15a8895..8712fc4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -369,6 +369,7 @@ struct cfs_bandwidth {
 	u64			quota;
 	u64			runtime;
 	u64			burst;
+	u64			runtime_snap;
 	s64			hierarchical_quota;
 
 	u8			idle;
@@ -381,7 +382,9 @@ struct cfs_bandwidth {
 	/* Statistics: */
 	int			nr_periods;
 	int			nr_throttled;
+	int			nr_burst;
 	u64			throttled_time;
+	u64			burst_time;
 #endif
 };
 
