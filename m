Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6BB3BB86C
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Jul 2021 09:54:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230372AbhGEH4m (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Jul 2021 03:56:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59270 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230289AbhGEH4h (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Jul 2021 03:56:37 -0400
Date:   Mon, 05 Jul 2021 07:53:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625471639;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jmYCA8yxy3plEyKxyWNZ3JbM5R5kD92qMeMTKCWrnOc=;
        b=rwtnH5yZvbDhul97o2KYgI3C+L+ZxyqFeCwJ1dDxuBGN7wQ1nSKUQG7QqPR0MTD3Nr3ZG6
        PDwtXK48w4sHJ98wviNJIa4MkyAft1W+jqR6r0+4kicIDf3/wTNcvmPWKgIL7yzcLNTN+K
        BVUmHIVzeDlSw/bNmDzhqnnz1AazCyCTZbxFbx5BPvaKRY6dtGWrxwxhHQLtE6FNFPNppB
        UjZ8R4b2J/xT29rFcVShxEprrpXN/fsoNXhQO3DpftaoYA/v0/c02fgerRU/tMC+KfrTcd
        ciZIPnpyhykPsEGpia7Y2CnbqLkeh52IFF65A1LePbZ7ryOYtPx2kEqsxECjCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625471639;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jmYCA8yxy3plEyKxyWNZ3JbM5R5kD92qMeMTKCWrnOc=;
        b=D4i9P07Cc2T0UwwKdW9b5FGg4Gp0WqJlZiJkgpazK2Q17ycE88KUxZ1GP6BrMujI/2di45
        1h7VY4/ppb8GV3BA==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Sync load_sum with load_avg after dequeue
Cc:     Sachin Sant <sachinp@linux.vnet.ibm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Odin Ugedal <odin@uged.al>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210701171837.32156-1-vincent.guittot@linaro.org>
References: <20210701171837.32156-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <162547163867.395.4833924212740469681.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     ceb6ba45dc8074d2a1ec1117463dc94a20d4203d
Gitweb:        https://git.kernel.org/tip/ceb6ba45dc8074d2a1ec1117463dc94a20d4203d
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Thu, 01 Jul 2021 19:18:37 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 02 Jul 2021 15:58:23 +02:00

sched/fair: Sync load_sum with load_avg after dequeue

commit 9e077b52d86a ("sched/pelt: Check that *_avg are null when *_sum are")
reported some inconsitencies between *_avg and *_sum.

commit 1c35b07e6d39 ("sched/fair: Ensure _sum and _avg values stay consistent")
fixed some but one remains when dequeuing load.

sync the cfs's load_sum with its load_avg after dequeuing the load of a
sched_entity.

Fixes: 9e077b52d86a ("sched/pelt: Check that *_avg are null when *_sum are")
Reported-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Odin Ugedal <odin@uged.al>
Tested-by: Sachin Sant <sachinp@linux.vnet.ibm.com>
Link: https://lore.kernel.org/r/20210701171837.32156-1-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 45edf61..1e263c9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3037,8 +3037,9 @@ enqueue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 static inline void
 dequeue_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
+	u32 divider = get_pelt_divider(&se->avg);
 	sub_positive(&cfs_rq->avg.load_avg, se->avg.load_avg);
-	sub_positive(&cfs_rq->avg.load_sum, se_weight(se) * se->avg.load_sum);
+	cfs_rq->avg.load_sum = cfs_rq->avg.load_avg * divider;
 }
 #else
 static inline void
