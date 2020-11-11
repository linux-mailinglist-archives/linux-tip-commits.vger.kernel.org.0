Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 52C682AEB21
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Nov 2020 09:24:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgKKIXX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Nov 2020 03:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726273AbgKKIXR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Nov 2020 03:23:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07F7DC0613D6;
        Wed, 11 Nov 2020 00:23:17 -0800 (PST)
Date:   Wed, 11 Nov 2020 08:23:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605082995;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z4FxAd9VLU7a/bf3RPm0XshCyuSUetQ5DHRkl9b4VO0=;
        b=fIrXrpEHrf0P5fqP1HdjKZ4pmcCQJ/7cXCfEOCGU7QZbmsuaiir3h9IIE39nkoCdhmMewr
        JH8Wn785MoZpgSCNnFTggwRBYew5Ir31eUsFsqRDqW+NVrU4Az/t/2QzXNwqrWgrfQ5K38
        WWEIMCK0faoufNzOf8CCag/+gH5M4ZTGit0+v8F/sTzDhGNLrCWH7wf4vu5cmlqiJ8IzPA
        7xR9pMSE9PVSzl+P4Nr5KVPbMqPQFNU9gM86Y2UbgwVbPSOhzWNlqEb+uhi2zlkR36miRN
        IoL5wIqfFBenuAMccdzdSpA231kNmhXGuXRG7ZF5+6IUNbZzz2CIZFk1GzR7UQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605082995;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z4FxAd9VLU7a/bf3RPm0XshCyuSUetQ5DHRkl9b4VO0=;
        b=NRGqoH/njiiRh+YaDkNWpxU0yBihH/PrBo3FvKbuwulBcEq2hc4SnpYKQiFmWdVe8fuvqg
        py/SicFd80Eg3UDQ==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Comment affine_move_task()
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201013140116.26651-2-valentin.schneider@arm.com>
References: <20201013140116.26651-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <160508299477.11244.9464017467265290417.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c777d847107e80df24dae87fc9cf4b4c0bf4dfed
Gitweb:        https://git.kernel.org/tip/c777d847107e80df24dae87fc9cf4b4c0bf4dfed
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Tue, 13 Oct 2020 15:01:16 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Nov 2020 18:39:02 +01:00

sched: Comment affine_move_task()

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201013140116.26651-2-valentin.schneider@arm.com
---
 kernel/sched/core.c | 81 ++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 79 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 88c6fcb..c6409f3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2076,7 +2076,75 @@ void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
 }
 
 /*
- * This function is wildly self concurrent, consider at least 3 times.
+ * This function is wildly self concurrent; here be dragons.
+ *
+ *
+ * When given a valid mask, __set_cpus_allowed_ptr() must block until the
+ * designated task is enqueued on an allowed CPU. If that task is currently
+ * running, we have to kick it out using the CPU stopper.
+ *
+ * Migrate-Disable comes along and tramples all over our nice sandcastle.
+ * Consider:
+ *
+ *     Initial conditions: P0->cpus_mask = [0, 1]
+ *
+ *     P0@CPU0                  P1
+ *
+ *     migrate_disable();
+ *     <preempted>
+ *                              set_cpus_allowed_ptr(P0, [1]);
+ *
+ * P1 *cannot* return from this set_cpus_allowed_ptr() call until P0 executes
+ * its outermost migrate_enable() (i.e. it exits its Migrate-Disable region).
+ * This means we need the following scheme:
+ *
+ *     P0@CPU0                  P1
+ *
+ *     migrate_disable();
+ *     <preempted>
+ *                              set_cpus_allowed_ptr(P0, [1]);
+ *                                <blocks>
+ *     <resumes>
+ *     migrate_enable();
+ *       __set_cpus_allowed_ptr();
+ *       <wakes local stopper>
+ *                         `--> <woken on migration completion>
+ *
+ * Now the fun stuff: there may be several P1-like tasks, i.e. multiple
+ * concurrent set_cpus_allowed_ptr(P0, [*]) calls. CPU affinity changes of any
+ * task p are serialized by p->pi_lock, which we can leverage: the one that
+ * should come into effect at the end of the Migrate-Disable region is the last
+ * one. This means we only need to track a single cpumask (i.e. p->cpus_mask),
+ * but we still need to properly signal those waiting tasks at the appropriate
+ * moment.
+ *
+ * This is implemented using struct set_affinity_pending. The first
+ * __set_cpus_allowed_ptr() caller within a given Migrate-Disable region will
+ * setup an instance of that struct and install it on the targeted task_struct.
+ * Any and all further callers will reuse that instance. Those then wait for
+ * a completion signaled at the tail of the CPU stopper callback (1), triggered
+ * on the end of the Migrate-Disable region (i.e. outermost migrate_enable()).
+ *
+ *
+ * (1) In the cases covered above. There is one more where the completion is
+ * signaled within affine_move_task() itself: when a subsequent affinity request
+ * cancels the need for an active migration. Consider:
+ *
+ *     Initial conditions: P0->cpus_mask = [0, 1]
+ *
+ *     P0@CPU0            P1                             P2
+ *
+ *     migrate_disable();
+ *     <preempted>
+ *                        set_cpus_allowed_ptr(P0, [1]);
+ *                          <blocks>
+ *                                                       set_cpus_allowed_ptr(P0, [0, 1]);
+ *                                                         <signal completion>
+ *                          <awakes>
+ *
+ * Note that the above is safe vs a concurrent migrate_enable(), as any
+ * pending affinity completion is preceded by an uninstallation of
+ * p->migration_pending done with p->pi_lock held.
  */
 static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flags *rf,
 			    int dest_cpu, unsigned int flags)
@@ -2120,6 +2188,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 	if (!(flags & SCA_MIGRATE_ENABLE)) {
 		/* serialized by p->pi_lock */
 		if (!p->migration_pending) {
+			/* Install the request */
 			refcount_set(&my_pending.refs, 1);
 			init_completion(&my_pending.done);
 			p->migration_pending = &my_pending;
@@ -2165,7 +2234,11 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 	}
 
 	if (task_running(rq, p) || p->state == TASK_WAKING) {
-
+		/*
+		 * Lessen races (and headaches) by delegating
+		 * is_migration_disabled(p) checks to the stopper, which will
+		 * run on the same CPU as said p.
+		 */
 		task_rq_unlock(rq, p, rf);
 		stop_one_cpu(cpu_of(rq), migration_cpu_stop, &arg);
 
@@ -2190,6 +2263,10 @@ do_complete:
 	if (refcount_dec_and_test(&pending->refs))
 		wake_up_var(&pending->refs);
 
+	/*
+	 * Block the original owner of &pending until all subsequent callers
+	 * have seen the completion and decremented the refcount
+	 */
 	wait_var_event(&my_pending.refs, !refcount_read(&my_pending.refs));
 
 	return 0;
