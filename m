Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB07739B9F9
	for <lists+linux-tip-commits@lfdr.de>; Fri,  4 Jun 2021 15:38:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhFDNkh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 4 Jun 2021 09:40:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:53474 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230284AbhFDNkh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 4 Jun 2021 09:40:37 -0400
Date:   Fri, 04 Jun 2021 13:38:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622813930;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WyczKmVahFC47ZS/saZxFVYFQaqkx7u6zwKUlvUxo7o=;
        b=eGaZM4ZQI8L+ZiouJOiBHN2fVqiZmqGJoum0aeUv+QootDmJFSVXKQuwgKRXaWOblQ6sSu
        F0SdlFCU1O70VayWKWtb55KvkPxJLxVgVSJSwEOtLZd3+DDqGvlTX1CeqnNVwS6LC7iUH8
        KU24wPOM0V7mEFJAelOl4w38/9h5d2fquT1bRZ3gPw3QuSQ8lyWtYMku/x6r8VYeZGdK+s
        cuZrcC4K8pOD3AkT9L3UawoMydTtt0H8gzB1RcsWwI5wEBXXAjqDGLxbxmA1Vq23ofEmZJ
        LZe6i12sr3NO/Tl1gpl0PVb0CaJxVtsdSS7icJqmaisgBGPE1Eq3NiI6lwZZdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622813930;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WyczKmVahFC47ZS/saZxFVYFQaqkx7u6zwKUlvUxo7o=;
        b=p4YvCWfZ41uiWgi19amVpMEGO7ZB2fY2UB5TYbbCMxmB+ZaRcNpbyZeqwoB1sK7ZKit2rG
        UTOmBBXN7on8WKAQ==
From:   "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Fix util_est UTIL_AVG_UNCHANGED handling
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Xuewen Yan <xuewen.yan@unisoc.com>,
        Vincent Donnefort <vincent.donnefort@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210602145808.1562603-1-dietmar.eggemann@arm.com>
References: <20210602145808.1562603-1-dietmar.eggemann@arm.com>
MIME-Version: 1.0
Message-ID: <162281392953.29796.486453710675011021.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     68d7a190682aa4eb02db477328088ebad15acc83
Gitweb:        https://git.kernel.org/tip/68d7a190682aa4eb02db477328088ebad15acc83
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Wed, 02 Jun 2021 16:58:08 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 03 Jun 2021 15:47:23 +02:00

sched/fair: Fix util_est UTIL_AVG_UNCHANGED handling

The util_est internal UTIL_AVG_UNCHANGED flag which is used to prevent
unnecessary util_est updates uses the LSB of util_est.enqueued. It is
exposed via _task_util_est() (and task_util_est()).

Commit 92a801e5d5b7 ("sched/fair: Mask UTIL_AVG_UNCHANGED usages")
mentions that the LSB is lost for util_est resolution but
find_energy_efficient_cpu() checks if task_util_est() returns 0 to
return prev_cpu early.

_task_util_est() returns the max value of util_est.ewma and
util_est.enqueued or'ed w/ UTIL_AVG_UNCHANGED.
So task_util_est() returning the max of task_util() and
_task_util_est() will never return 0 under the default
SCHED_FEAT(UTIL_EST, true).

To fix this use the MSB of util_est.enqueued instead and keep the flag
util_est internal, i.e. don't export it via _task_util_est().

The maximal possible util_avg value for a task is 1024 so the MSB of
'unsigned int util_est.enqueued' isn't used to store a util value.

As a caveat the code behind the util_est_se trace point has to filter
UTIL_AVG_UNCHANGED to see the real util_est.enqueued value which should
be easy to do.

This also fixes an issue report by Xuewen Yan that util_est_update()
only used UTIL_AVG_UNCHANGED for the subtrahend of the equation:

  last_enqueued_diff = ue.enqueued - (task_util() | UTIL_AVG_UNCHANGED)

Fixes: b89997aa88f0b sched/pelt: Fix task util_est update filtering
Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Xuewen Yan <xuewen.yan@unisoc.com>
Reviewed-by: Vincent Donnefort <vincent.donnefort@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20210602145808.1562603-1-dietmar.eggemann@arm.com
---
 include/linux/sched.h |  8 ++++++++
 kernel/sched/debug.c  |  3 ++-
 kernel/sched/fair.c   |  5 +++--
 kernel/sched/pelt.h   | 11 +----------
 4 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d2c8813..28a98fc 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -350,11 +350,19 @@ struct load_weight {
  * Only for tasks we track a moving average of the past instantaneous
  * estimated utilization. This allows to absorb sporadic drops in utilization
  * of an otherwise almost periodic task.
+ *
+ * The UTIL_AVG_UNCHANGED flag is used to synchronize util_est with util_avg
+ * updates. When a task is dequeued, its util_est should not be updated if its
+ * util_avg has not been updated in the meantime.
+ * This information is mapped into the MSB bit of util_est.enqueued at dequeue
+ * time. Since max value of util_est.enqueued for a task is 1024 (PELT util_avg
+ * for a task) it is safe to use MSB.
  */
 struct util_est {
 	unsigned int			enqueued;
 	unsigned int			ewma;
 #define UTIL_EST_WEIGHT_SHIFT		2
+#define UTIL_AVG_UNCHANGED		0x80000000
 } __attribute__((__aligned__(sizeof(u64))));
 
 /*
diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index 9c882f2..c5aacbd 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -885,6 +885,7 @@ static const struct seq_operations sched_debug_sops = {
 #define __PS(S, F) SEQ_printf(m, "%-45s:%21Ld\n", S, (long long)(F))
 #define __P(F) __PS(#F, F)
 #define   P(F) __PS(#F, p->F)
+#define   PM(F, M) __PS(#F, p->F & (M))
 #define __PSN(S, F) SEQ_printf(m, "%-45s:%14Ld.%06ld\n", S, SPLIT_NS((long long)(F)))
 #define __PN(F) __PSN(#F, F)
 #define   PN(F) __PSN(#F, p->F)
@@ -1011,7 +1012,7 @@ void proc_sched_show_task(struct task_struct *p, struct pid_namespace *ns,
 	P(se.avg.util_avg);
 	P(se.avg.last_update_time);
 	P(se.avg.util_est.ewma);
-	P(se.avg.util_est.enqueued);
+	PM(se.avg.util_est.enqueued, ~UTIL_AVG_UNCHANGED);
 #endif
 #ifdef CONFIG_UCLAMP_TASK
 	__PS("uclamp.min", p->uclamp_req[UCLAMP_MIN].value);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 7b98fb3..2c8a935 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3907,7 +3907,7 @@ static inline unsigned long _task_util_est(struct task_struct *p)
 {
 	struct util_est ue = READ_ONCE(p->se.avg.util_est);
 
-	return (max(ue.ewma, ue.enqueued) | UTIL_AVG_UNCHANGED);
+	return max(ue.ewma, (ue.enqueued & ~UTIL_AVG_UNCHANGED));
 }
 
 static inline unsigned long task_util_est(struct task_struct *p)
@@ -4007,7 +4007,7 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	 * Reset EWMA on utilization increases, the moving average is used only
 	 * to smooth utilization decreases.
 	 */
-	ue.enqueued = (task_util(p) | UTIL_AVG_UNCHANGED);
+	ue.enqueued = task_util(p);
 	if (sched_feat(UTIL_EST_FASTUP)) {
 		if (ue.ewma < ue.enqueued) {
 			ue.ewma = ue.enqueued;
@@ -4056,6 +4056,7 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
 	ue.ewma  += last_ewma_diff;
 	ue.ewma >>= UTIL_EST_WEIGHT_SHIFT;
 done:
+	ue.enqueued |= UTIL_AVG_UNCHANGED;
 	WRITE_ONCE(p->se.avg.util_est, ue);
 
 	trace_sched_util_est_se_tp(&p->se);
diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
index 1462846..cfe94ff 100644
--- a/kernel/sched/pelt.h
+++ b/kernel/sched/pelt.h
@@ -42,15 +42,6 @@ static inline u32 get_pelt_divider(struct sched_avg *avg)
 	return LOAD_AVG_MAX - 1024 + avg->period_contrib;
 }
 
-/*
- * When a task is dequeued, its estimated utilization should not be update if
- * its util_avg has not been updated at least once.
- * This flag is used to synchronize util_avg updates with util_est updates.
- * We map this information into the LSB bit of the utilization saved at
- * dequeue time (i.e. util_est.dequeued).
- */
-#define UTIL_AVG_UNCHANGED 0x1
-
 static inline void cfs_se_util_change(struct sched_avg *avg)
 {
 	unsigned int enqueued;
@@ -58,7 +49,7 @@ static inline void cfs_se_util_change(struct sched_avg *avg)
 	if (!sched_feat(UTIL_EST))
 		return;
 
-	/* Avoid store if the flag has been already set */
+	/* Avoid store if the flag has been already reset */
 	enqueued = avg->util_est.enqueued;
 	if (!(enqueued & UTIL_AVG_UNCHANGED))
 		return;
