Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0D43D209DC7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Jun 2020 13:53:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404428AbgFYLxn (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 25 Jun 2020 07:53:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404420AbgFYLxl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 25 Jun 2020 07:53:41 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 24A1CC061573;
        Thu, 25 Jun 2020 04:53:41 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1joQRY-0005py-K5; Thu, 25 Jun 2020 13:53:24 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3B2A91C0092;
        Thu, 25 Jun 2020 13:53:24 +0200 (CEST)
Date:   Thu, 25 Jun 2020 11:53:24 -0000
From:   "tip-bot2 for Peng Wang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Optimize dequeue_task_fair()
Cc:     Peng Wang <rocking@linux.alibaba.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3C701eef9a40de93dcf5fe7063fd607bca5db38e05=2E15922?=
 =?utf-8?q?87263=2Egit=2Erocking=40linux=2Ealibaba=2Ecom=3E?=
References: =?utf-8?q?=3C701eef9a40de93dcf5fe7063fd607bca5db38e05=2E159228?=
 =?utf-8?q?7263=2Egit=2Erocking=40linux=2Ealibaba=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <159308600404.16989.11999538573248060370.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     423d02e1463b21109106f52d94f7396b63731f3b
Gitweb:        https://git.kernel.org/tip/423d02e1463b21109106f52d94f7396b63731f3b
Author:        Peng Wang <rocking@linux.alibaba.com>
AuthorDate:    Tue, 16 Jun 2020 14:04:07 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 25 Jun 2020 13:45:44 +02:00

sched/fair: Optimize dequeue_task_fair()

While looking at enqueue_task_fair and dequeue_task_fair, it occurred
to me that dequeue_task_fair can also be optimized as Vincent described
in commit 7d148be69e3a ("sched/fair: Optimize enqueue_task_fair()").

When encountering throttled cfs_rq, dequeue_throttle label can ensure
se not to be NULL, and rq->nr_running remains unchanged, so we can also
skip the early balance check.

Signed-off-by: Peng Wang <rocking@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/701eef9a40de93dcf5fe7063fd607bca5db38e05.1592287263.git.rocking@linux.alibaba.com
---
 kernel/sched/fair.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a63f400..b9b9f19 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5624,14 +5624,14 @@ static void dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 
 	}
 
-dequeue_throttle:
-	if (!se)
-		sub_nr_running(rq, 1);
+	/* At this point se is NULL and we are at root level*/
+	sub_nr_running(rq, 1);
 
 	/* balance early to pull high priority tasks */
 	if (unlikely(!was_sched_idle && sched_idle_rq(rq)))
 		rq->next_balance = jiffies;
 
+dequeue_throttle:
 	util_est_dequeue(&rq->cfs, p, task_sleep);
 	hrtick_update(rq);
 }
