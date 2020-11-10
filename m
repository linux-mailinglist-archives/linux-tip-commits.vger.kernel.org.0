Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D3B1B2AD4CF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Nov 2020 12:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgKJLVy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Nov 2020 06:21:54 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:57688 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726706AbgKJLVy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Nov 2020 06:21:54 -0500
Date:   Tue, 10 Nov 2020 11:21:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605007311;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6WS3gMqsYdRBr/rqnwp3cWwPN8TN6b++cO3+unqgljI=;
        b=Sl0plRqCQtJ91OnCUqtv7cT0NBCBayZjJvtnzkFiON2dTnfi7FJ/aBVs1EnxSzbEUqVQRa
        a2cTq21f+m9LnI4aHU4/entU9+THQl+Lzx7fsc7f+v6qyWfGMxPIlWooUrVI86o+0xhVwn
        o+GDXG7dzTivTjqbEmxufohrr1l0Y4FPYp+9fY2vMcFXIk8PIAc19YFGehytvIjS8bM/cB
        x5wHfd1149aJzT5O+8DyE3ZB5Yl7a8nBdjdKRApvwLUa+ow70dNAUtPjPMCB2EaNQkV0A5
        +kAaNH+L3eXdtMNPmWbfE84Hba7StDHRHiWmIp1kMHWrNNAQkYHJMwZFcfB+Fw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605007311;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6WS3gMqsYdRBr/rqnwp3cWwPN8TN6b++cO3+unqgljI=;
        b=ZYkAFblHOOVy6Ck011Rty7u5KYYzAGOMiAyCr69qHe7UrTQMcLJ+G6Vn/G0Db9iBKBt6Jn
        kOBt+eeK4300jyDA==
From:   "tip-bot2 for Peng Wang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Reorder throttle_cfs_rq() path
Cc:     Peng Wang <rocking@linux.alibaba.com>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>, Ben Segall <bsegall@google.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cf11dd2e3ab35cc538e2eb57bf0c99b6eaffce127=2E16049?=
 =?utf-8?q?73978=2Egit=2Erocking=40linux=2Ealibaba=2Ecom=3E?=
References: =?utf-8?q?=3Cf11dd2e3ab35cc538e2eb57bf0c99b6eaffce127=2E160497?=
 =?utf-8?q?3978=2Egit=2Erocking=40linux=2Ealibaba=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <160500731014.11244.11693121696022661111.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b6d37a764a5b852db63101b3f2db0e699574b903
Gitweb:        https://git.kernel.org/tip/b6d37a764a5b852db63101b3f2db0e699574b903
Author:        Peng Wang <rocking@linux.alibaba.com>
AuthorDate:    Tue, 10 Nov 2020 10:11:59 +08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 10 Nov 2020 12:20:12 +01:00

sched/fair: Reorder throttle_cfs_rq() path

As commit:

  39f23ce07b93 ("sched/fair: Fix unthrottle_cfs_rq() for leaf_cfs_rq list")

does in unthrottle_cfs_rq(), throttle_cfs_rq() can also use the same
pattern as dequeue_task_fair().

No functional changes.

Signed-off-by: Peng Wang <rocking@linux.alibaba.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Cc: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Phil Auld <pauld@redhat.com>
Cc: Ben Segall <bsegall@google.com>
Link: https://lore.kernel.org/r/f11dd2e3ab35cc538e2eb57bf0c99b6eaffce127.1604973978.git.rocking@linux.alibaba.com
---
 kernel/sched/fair.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 52cacfc..2755a7e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4788,25 +4788,37 @@ static bool throttle_cfs_rq(struct cfs_rq *cfs_rq)
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 		/* throttled entity or throttle-on-deactivate */
 		if (!se->on_rq)
-			break;
+			goto done;
 
-		if (dequeue) {
-			dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
-		} else {
-			update_load_avg(qcfs_rq, se, 0);
-			se_update_runnable(se);
-		}
+		dequeue_entity(qcfs_rq, se, DEQUEUE_SLEEP);
 
 		qcfs_rq->h_nr_running -= task_delta;
 		qcfs_rq->idle_h_nr_running -= idle_task_delta;
 
-		if (qcfs_rq->load.weight)
-			dequeue = 0;
+		if (qcfs_rq->load.weight) {
+			/* Avoid re-evaluating load for this entity: */
+			se = parent_entity(se);
+			break;
+		}
 	}
 
-	if (!se)
-		sub_nr_running(rq, task_delta);
+	for_each_sched_entity(se) {
+		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
+		/* throttled entity or throttle-on-deactivate */
+		if (!se->on_rq)
+			goto done;
+
+		update_load_avg(qcfs_rq, se, 0);
+		se_update_runnable(se);
 
+		qcfs_rq->h_nr_running -= task_delta;
+		qcfs_rq->idle_h_nr_running -= idle_task_delta;
+	}
+
+	/* At this point se is NULL and we are at root level*/
+	sub_nr_running(rq, task_delta);
+
+done:
 	/*
 	 * Note: distribution will already see us throttled via the
 	 * throttled-list.  rq->lock protects completion.
