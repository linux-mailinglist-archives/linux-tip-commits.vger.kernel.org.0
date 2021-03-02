Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CE82F32B046
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Mar 2021 04:43:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350253AbhCCDf6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 2 Mar 2021 22:35:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:35770 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378838AbhCBJD0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 2 Mar 2021 04:03:26 -0500
Date:   Tue, 02 Mar 2021 09:01:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614675717;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=YXny8m16onebBca7MJcoTKbcwRi1HbBvixTzf1b98cA=;
        b=ABPGF3vJVT8emsHE+E69qYH78CSLqUZlnbjjAoM8OmAMAUdEC9tVIIV4C0Y+46qm7QEXlq
        gela/S0W3JDgMMB2jvrxYfX+lKmkeOV61/NnAJbUp3COyeWaaE7/2EGDpj7GFBSThP8bXd
        XodQu2ZdzRbbm1eiZZQYX0NO0SwkBV8ppvCFFujrCPPLGTWJyy1aGTQ5fMJfJMzSoWao3B
        VlIEbSJHGZRX609DqnEN1cnACf62U9/GDBzh0bv836XODTCFim72A3YLKACpZNK8k/mzMS
        4geYBFYS2caHKt1Ln/304d3r4FlQTNbY/SV9+ecUIjn1Zc0xyBMjKpGkudbn7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614675717;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=YXny8m16onebBca7MJcoTKbcwRi1HbBvixTzf1b98cA=;
        b=0qVovKNir8ap5gNr+JbvO0lpauJ/g3Brei0Pl5Zps2+PA2udA2zI2M4Bj/WWhq7+Shgm82
        jvZEutvZcGtpumBg==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Simplify migration_cpu_stop()
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161467571651.20312.8520180930890736591.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     560c86ed4c1ca92592c04a8b2032fb29f8556a90
Gitweb:        https://git.kernel.org/tip/560c86ed4c1ca92592c04a8b2032fb29f8556a90
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Thu, 25 Feb 2021 10:22:30 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 01 Mar 2021 18:17:22 +01:00

sched: Simplify migration_cpu_stop()

Since, when ->stop_pending, only the stopper can uninstall
p->migration_pending. This could simplify a few ifs, because:

  (pending != NULL) => (pending == p->migration_pending)

Also, the fatty comment above affine_move_task() probably needs a bit
of gardening.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9819121..f9dfb34 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1927,6 +1927,12 @@ static int migration_cpu_stop(void *data)
 	rq_lock(rq, &rf);
 
 	/*
+	 * If we were passed a pending, then ->stop_pending was set, thus
+	 * p->migration_pending must have remained stable.
+	 */
+	WARN_ON_ONCE(pending && pending != p->migration_pending);
+
+	/*
 	 * If task_rq(p) != rq, it cannot be migrated here, because we're
 	 * holding rq->lock, if p->on_rq == 0 it cannot get enqueued because
 	 * we're holding p->pi_lock.
@@ -1936,8 +1942,7 @@ static int migration_cpu_stop(void *data)
 			goto out;
 
 		if (pending) {
-			if (p->migration_pending == pending)
-				p->migration_pending = NULL;
+			p->migration_pending = NULL;
 			complete = true;
 		}
 
@@ -1976,8 +1981,7 @@ static int migration_cpu_stop(void *data)
 		 * somewhere allowed, we're done.
 		 */
 		if (cpumask_test_cpu(task_cpu(p), p->cpus_ptr)) {
-			if (p->migration_pending == pending)
-				p->migration_pending = NULL;
+			p->migration_pending = NULL;
 			complete = true;
 			goto out;
 		}
@@ -2165,16 +2169,21 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
  *
  * (1) In the cases covered above. There is one more where the completion is
  * signaled within affine_move_task() itself: when a subsequent affinity request
- * cancels the need for an active migration. Consider:
+ * occurs after the stopper bailed out due to the targeted task still being
+ * Migrate-Disable. Consider:
  *
  *     Initial conditions: P0->cpus_mask = [0, 1]
  *
- *     P0@CPU0            P1                             P2
- *
- *     migrate_disable();
- *     <preempted>
+ *     CPU0		  P1				P2
+ *     <P0>
+ *       migrate_disable();
+ *       <preempted>
  *                        set_cpus_allowed_ptr(P0, [1]);
  *                          <blocks>
+ *     <migration/0>
+ *       migration_cpu_stop()
+ *         is_migration_disabled()
+ *           <bails>
  *                                                       set_cpus_allowed_ptr(P0, [0, 1]);
  *                                                         <signal completion>
  *                          <awakes>
