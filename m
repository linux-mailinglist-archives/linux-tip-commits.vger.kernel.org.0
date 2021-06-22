Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE41A3B0453
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Jun 2021 14:27:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231404AbhFVM31 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 22 Jun 2021 08:29:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbhFVM3Y (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 22 Jun 2021 08:29:24 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C257C061574;
        Tue, 22 Jun 2021 05:27:09 -0700 (PDT)
Date:   Tue, 22 Jun 2021 12:27:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624364827;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xmz7W3Dq/LHDUZVEcrLlEE86oqgcmEHLeB5q4ysiw/8=;
        b=KcEkwpoWVi5Rt35RD0NaXhQyy/ejLu/abykfOZYlEZRLYqWsdvINWQm6gXNXB/xoA+UrWy
        PqJVhH5XRzqwXvIc6/XmpT003TAbcW6b4AMlknA9XTNzf05HGLHq+SX7tP6IjX1e+RhCn1
        3pcsaYkmJtGsvPPH3kwjwe+F+r4BSjwKYGm/ixn28Lo3i7poVv3Sh6QjwiTWn1yCC+H5/X
        VpGZU1F7ucFTNW6yli4xSy5vbLJCpo5jcvuQ4RQ0kccltvHgyfgzMh4YuEytN+rUF6e9dr
        uveuTgkGA18WlH7yZRqh6Nf53ybs59hArKFzipUeVhnegXx0lwZHpGjDKwzXKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624364827;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xmz7W3Dq/LHDUZVEcrLlEE86oqgcmEHLeB5q4ysiw/8=;
        b=vsAU2wBPU5w/w1N5mx5RxZ1CEwfI2Dkb74WxMYsMYb/qd9Hr+HP4IVQ2SEairrOi6zuW3X
        Y3XwTtXXmflo1LBg==
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
Message-ID: <162436482704.395.4620107137029173552.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     fdaba61ef8a268d4136d0a113d153f7a89eb9984
Gitweb:        https://git.kernel.org/tip/fdaba61ef8a268d4136d0a113d153f7a89eb9984
Author:        Rik van Riel <riel@surriel.com>
AuthorDate:    Mon, 21 Jun 2021 19:43:30 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 22 Jun 2021 14:06:57 +02:00

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
index bfaa6e1..2366331 100644
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
@@ -3313,6 +3338,9 @@ static inline bool cfs_rq_is_decayed(struct cfs_rq *cfs_rq)
 	if (cfs_rq->avg.runnable_sum)
 		return false;
 
+	if (child_cfs_rq_on_list(cfs_rq))
+		return false;
+
 	return true;
 }
 
