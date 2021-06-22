Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 832303B0390
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Jun 2021 14:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230402AbhFVMFy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 22 Jun 2021 08:05:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56742 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230136AbhFVMFx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 22 Jun 2021 08:05:53 -0400
Date:   Tue, 22 Jun 2021 12:03:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624363416;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ybv9HrR8t4cVeDrUvO6k44DDQMd9IS0nzLsaT0bIEaU=;
        b=W2Am6KzcWkJAf3PDTlAWv8B5LJ2jPpjTfGrLYZjINzQieeHamBYVCq7CZt5ALQ6lFpDi2N
        Tw2mDkfBAN8iqqyeM0oVEU5zAFzvUZrpqnhrq5JhQy+kdzJRumKopjYZRBn+KQsNm8P2nL
        G8d2O58UF7wCxM9o1MmsyJskQTuarGSrgSTzYzYlBfNLICoIi88VndgJi5WAJdbdOU+JKj
        G+vR9X5ViFCTBgxY3VQmxBLn2yMitk5vdAmlzq8VHUEl8htEvV5bLSuvpPKR81zM7YD6gg
        5037AI16WxBSrZOK+Sd0rtfmJ1//PWO4bvQHXoCOgVVD8u090SOihO4S4/2jbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624363416;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ybv9HrR8t4cVeDrUvO6k44DDQMd9IS0nzLsaT0bIEaU=;
        b=tmcQGi95XVD9TYx/Wj6/TjBQJBM6irhuw7aUOk2GnuPv1CU94A+13S1bif6K71AOAZbPtH
        gSdtRPohKB4YP7Cg==
From:   "tip-bot2 for Rik van Riel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Ensure that the CFS parent is added
 after unthrottling
Cc:     Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Rik van Riel <riel@surriel.com>,
        Ingo Molnar <mingo@kernel.org>, Odin Ugedal <odin@uged.al>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210621174330.11258-1-vincent.guittot@linaro.org>
References: <20210621174330.11258-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <162436341605.395.5765576899693923114.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     30ca4b4598a9d680917fe24df5451afecc028b5b
Gitweb:        https://git.kernel.org/tip/30ca4b4598a9d680917fe24df5451afecc028b5b
Author:        Rik van Riel <riel@surriel.com>
AuthorDate:    Mon, 21 Jun 2021 19:43:30 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 22 Jun 2021 14:00:53 +02:00

sched/fair: Ensure that the CFS parent is added after unthrottling

Ensure that a CFS parent will be in the list whenever one of its children is also
in the list.

A warning on rq->tmp_alone_branch != &rq->leaf_cfs_rq_list has been
reported while running LTP test cfs_bandwidth01.

Odin Ugedal found the root cause:

	$ tree /sys/fs/cgroup/ltp/ -d --charset=ascii
	/sys/fs/cgroup/ltp/
	|-- drain
	`-- test-6851
	    `-- level2
		|-- level3a
		|   |-- worker1
		|   `-- worker2
		`-- level3b
		    `-- worker3

Timeline (ish):
- worker3 gets throttled
- level3b is decayed, since it has no more load
- level2 get throttled
- worker3 get unthrottled
- level2 get unthrottled
  - worker3 is added to list
  - level3b is not added to list, since nr_running==0 and is decayed

 [ Vincent Guittot: Rebased and updated to fix for the reported warning. ]

Fixes: a7b359fc6a37 ("sched/fair: Correctly insert cfs_rq's to list on unthrottle")
Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
Suggested-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
Acked-by: Odin Ugedal <odin@uged.al>
Link: https://lore.kernel.org/r/20210621174330.11258-1-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index bfaa6e1..a56f646 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3298,6 +3298,31 @@ static inline void cfs_rq_util_change(struct cfs_rq *cfs_rq, int flags)
 
 #ifdef CONFIG_SMP
 #ifdef CONFIG_FAIR_GROUP_SCHED
+/*
+ * Because list_add_leaf_cfs_rq always places a child cfs_rq on the list
+ * immediately before a parent cfs_rq, and cfs_rqs are removed from the list
+ * bottom-up, we only have to test whether the cfs_rq before us on the list
+ * is our child.
+ * If cfs_rq is not on the list, test whether a child needs its to be added to
+ * connect a branch to the tree  * (see list_add_leaf_cfs_rq() for details).
+ */
+static inline bool child_cfs_rq_on_list(struct cfs_rq *cfs_rq)
+{
+	struct cfs_rq *prev_cfs_rq;
+	struct list_head *prev;
+
+	if (cfs_rq->on_list) {
+		prev = cfs_rq->leaf_cfs_rq_list.prev;
+	} else {
+		struct rq *rq = rq_of(cfs_rq);
+
+		prev = rq->tmp_alone_branch;
+	}
+
+	prev_cfs_rq = container_of(prev, struct cfs_rq, leaf_cfs_rq_list);
+
+	return (prev_cfs_rq->tg->parent == cfs_rq->tg);
+}
 
 static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 {
@@ -3334,6 +3359,9 @@ static inline void update_tg_load_avg(struct cfs_rq *cfs_rq)
 {
 	long delta = cfs_rq->avg.load_avg - cfs_rq->tg_load_avg_contrib;
 
+	if (child_cfs_rq_on_list(cfs_rq))
+		return false;
+
 	/*
 	 * No need to update load_avg for root_task_group as it is not used.
 	 */
