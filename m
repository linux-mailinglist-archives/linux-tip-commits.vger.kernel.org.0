Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E9020404919
	for <lists+linux-tip-commits@lfdr.de>; Thu,  9 Sep 2021 13:18:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235594AbhIILTo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 9 Sep 2021 07:19:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235425AbhIILTk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 9 Sep 2021 07:19:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8B0C061575;
        Thu,  9 Sep 2021 04:18:30 -0700 (PDT)
Date:   Thu, 09 Sep 2021 11:18:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1631186309;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hf4mMvd9FegeJ8remBz35d0VI1pEGLp1H5yw4ufSxGQ=;
        b=lR/DN83YMlpH0RUKMlJS+cPsgcUxgV8P/FtOv4ZtrUUL/a92KrXqEoySyyxNBLU1r5a+yo
        FASRW+uMJsGMTFgy/1HJ5V01Lo3qdG32Yahh8WI0vf2RXGhk7Ns0hfmdRIrwpFG71BK0np
        9535GmCCXbbQG4VQDvuGU4NHNVshImRmpiLCfRuarCdz9TLMDobBVXEW22QQcyWEfBpn1D
        UFXpT9sz4zXu0JPZAgpGO6tgxbajDa4DVNNNVxPauehgC+Bp9DH8IEgHqwIeTiAZMDd6TP
        uF975WBWa7d5Lcjg2Rr3LKCi0fuQNJX5C9yKkvW9pJCD6r+V078BwINVMdCnvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1631186309;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hf4mMvd9FegeJ8remBz35d0VI1pEGLp1H5yw4ufSxGQ=;
        b=CfMs+9TyjsUWaNaKna7Qj8snq6a9+/ie2LQglYkGAVXjpTMYNaS1CjRpk2mW9HddYBlKRS
        vVm2+qA+69f/1EAA==
From:   "tip-bot2 for Josh Don" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Account number of SCHED_IDLE entities on each cfs_rq
Cc:     Josh Don <joshdon@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210820010403.946838-3-joshdon@google.com>
References: <20210820010403.946838-3-joshdon@google.com>
MIME-Version: 1.0
Message-ID: <163118630837.25758.14254030506906428313.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4b1e9afe8af5becd9b33640a7c996ccfce4ea310
Gitweb:        https://git.kernel.org/tip/4b1e9afe8af5becd9b33640a7c996ccfce4ea310
Author:        Josh Don <joshdon@google.com>
AuthorDate:    Thu, 19 Aug 2021 18:04:01 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 09 Sep 2021 11:27:31 +02:00

sched: Account number of SCHED_IDLE entities on each cfs_rq

Adds cfs_rq->idle_nr_running, which accounts the number of idle entities
directly enqueued on the cfs_rq.

Signed-off-by: Josh Don <joshdon@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20210820010403.946838-3-joshdon@google.com
---
 kernel/sched/debug.c |  2 ++
 kernel/sched/fair.c  | 25 ++++++++++++++++++++++++-
 kernel/sched/sched.h |  1 +
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 4971622..3353857 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -608,6 +608,8 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 			cfs_rq->nr_spread_over);
 	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_running", cfs_rq->h_nr_running);
+	SEQ_printf(m, "  .%-30s: %d\n", "idle_nr_running",
+			cfs_rq->idle_nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "idle_h_nr_running",
 			cfs_rq->idle_h_nr_running);
 	SEQ_printf(m, "  .%-30s: %ld\n", "load", cfs_rq->load.weight);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2a5efde..d7c0b9d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2995,6 +2995,8 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	}
 #endif
 	cfs_rq->nr_running++;
+	if (se_is_idle(se))
+		cfs_rq->idle_nr_running++;
 }
 
 static void
@@ -3008,6 +3010,8 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	}
 #endif
 	cfs_rq->nr_running--;
+	if (se_is_idle(se))
+		cfs_rq->idle_nr_running--;
 }
 
 /*
@@ -5544,6 +5548,17 @@ static int sched_idle_rq(struct rq *rq)
 			rq->nr_running);
 }
 
+/*
+ * Returns true if cfs_rq only has SCHED_IDLE entities enqueued. Note the use
+ * of idle_nr_running, which does not consider idle descendants of normal
+ * entities.
+ */
+static bool sched_idle_cfs_rq(struct cfs_rq *cfs_rq)
+{
+	return cfs_rq->nr_running &&
+		cfs_rq->nr_running == cfs_rq->idle_nr_running;
+}
+
 #ifdef CONFIG_SMP
 static int sched_idle_cpu(int cpu)
 {
@@ -11542,7 +11557,7 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 	for_each_possible_cpu(i) {
 		struct rq *rq = cpu_rq(i);
 		struct sched_entity *se = tg->se[i];
-		struct cfs_rq *grp_cfs_rq = tg->cfs_rq[i];
+		struct cfs_rq *parent_cfs_rq, *grp_cfs_rq = tg->cfs_rq[i];
 		bool was_idle = cfs_rq_is_idle(grp_cfs_rq);
 		long idle_task_delta;
 		struct rq_flags rf;
@@ -11553,6 +11568,14 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 		if (WARN_ON_ONCE(was_idle == cfs_rq_is_idle(grp_cfs_rq)))
 			goto next_cpu;
 
+		if (se->on_rq) {
+			parent_cfs_rq = cfs_rq_of(se);
+			if (cfs_rq_is_idle(grp_cfs_rq))
+				parent_cfs_rq->idle_nr_running++;
+			else
+				parent_cfs_rq->idle_nr_running--;
+		}
+
 		idle_task_delta = grp_cfs_rq->h_nr_running -
 				  grp_cfs_rq->idle_h_nr_running;
 		if (!cfs_rq_is_idle(grp_cfs_rq))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 30b7bd2..413298d 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -530,6 +530,7 @@ struct cfs_rq {
 	struct load_weight	load;
 	unsigned int		nr_running;
 	unsigned int		h_nr_running;      /* SCHED_{NORMAL,BATCH,IDLE} */
+	unsigned int		idle_nr_running;   /* SCHED_IDLE */
 	unsigned int		idle_h_nr_running; /* SCHED_IDLE */
 
 	u64			exec_clock;
