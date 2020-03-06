Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C866517C070
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Mar 2020 15:42:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726490AbgCFOmO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 6 Mar 2020 09:42:14 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53785 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727066AbgCFOmO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 6 Mar 2020 09:42:14 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jAEAy-0006Ir-MR; Fri, 06 Mar 2020 15:42:08 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 324841C21D8;
        Fri,  6 Mar 2020 15:42:06 +0100 (CET)
Date:   Fri, 06 Mar 2020 14:42:05 -0000
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Fix runnable_avg for throttled cfs
Cc:     Ben Segall <bsegall@google.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200227154115.8332-1-vincent.guittot@linaro.org>
References: <20200227154115.8332-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <158350572588.28353.11229882686518065235.tip-bot2@tip-bot2>
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

Commit-ID:     6212437f0f6043e825e021e4afc5cd63e248a2b4
Gitweb:        https://git.kernel.org/tip/6212437f0f6043e825e021e4afc5cd63e248a2b4
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Thu, 27 Feb 2020 16:41:15 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Mar 2020 12:57:25 +01:00

sched/fair: Fix runnable_avg for throttled cfs

When a cfs_rq is throttled, its group entity is dequeued and its running
tasks are removed. We must update runnable_avg with the old h_nr_running
and update group_se->runnable_weight with the new h_nr_running at each
level of the hierarchy.

Reviewed-by: Ben Segall <bsegall@google.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Fixes: 9f68395333ad ("sched/pelt: Add a new runnable average signal")
Link: https://lkml.kernel.org/r/20200227154115.8332-1-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3887b73..54bd628 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4720,8 +4720,13 @@ static void throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		if (!se->on_rq)
 			break;
 
-		if (dequeue)
+		if (dequeue) {
 			dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
+		} else {
+			update_load_avg(qcfs_rq, se, 0);
+			se_update_runnable(se);
+		}
+
 		qcfs_rq->h_nr_running -= task_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
 
@@ -4789,8 +4794,13 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 			enqueue = 0;
 
 		cfs_rq = cfs_rq_of(se);
-		if (enqueue)
+		if (enqueue) {
 			enqueue_entity(cfs_rq, se, ENQUEUE_WAKEUP);
+		} else {
+			update_load_avg(cfs_rq, se, 0);
+			se_update_runnable(se);
+		}
+
 		cfs_rq->h_nr_running += task_delta;
 		cfs_rq->idle_h_nr_running += idle_task_delta;
 
