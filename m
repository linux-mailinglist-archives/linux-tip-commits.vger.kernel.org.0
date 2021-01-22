Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCECF300A3E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Jan 2021 18:51:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728588AbhAVRuU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 22 Jan 2021 12:50:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55734 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729256AbhAVRm1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 22 Jan 2021 12:42:27 -0500
Date:   Fri, 22 Jan 2021 17:41:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611337295;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xj5yIEToTTUM3yyS/nSdRck0bMBvS6yERkbm99B6JaA=;
        b=TDouF4XisZ6N5jREwZngeHr5qEILw4V5DBRoEQNTQahkDkwVycINCTAkcLHGmLRD8t/uDN
        IDf8buMh2M/7k2rQPmZvuAbh2cuH7UCFfLDuqeKm2NwyNQJXoMibqCJnaesmMVPhF94Z2Z
        U9Tw+dk2MOnsKi2QAZsbKx0pNz5G23ISSguhGVlOudYdykwnz5i9IYqdaAbk3F+8uK7ewa
        CjikA8A3Jcbi9X1yTl/VoSq37i8LOWIDqolreQMkolDLJwFIsvVwcUyeDtp3WAQIfR3dlq
        FD12aXxwP0AWmCKL1azH85M5Lnj/kbbSV6cHb/KeZE4Vg0vR/Hed9uPLS/cYXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611337295;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Xj5yIEToTTUM3yyS/nSdRck0bMBvS6yERkbm99B6JaA=;
        b=nf2bA/+XiF4TDVEmsPgCMHBs4koamZdjlQzA2WE8rZQiCMRVFTkLdXNOGkyuSXQKyHQMEW
        FSN1ox8JGqW49aBA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] workqueue: Tag bound workers with KTHREAD_IS_PER_CPU
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210121103506.693465814@infradead.org>
References: <20210121103506.693465814@infradead.org>
MIME-Version: 1.0
Message-ID: <161133729540.414.15092664862520486982.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     5c25b5ff89f004c30b04759dc34ace8585a4085f
Gitweb:        https://git.kernel.org/tip/5c25b5ff89f004c30b04759dc34ace8585a4085f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 12 Jan 2021 11:26:49 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Jan 2021 15:09:42 +01:00

workqueue: Tag bound workers with KTHREAD_IS_PER_CPU

Mark the per-cpu workqueue workers as KTHREAD_IS_PER_CPU.

Workqueues have unfortunate semantics in that per-cpu workers are not
default flushed and parked during hotplug, however a subset does
manual flush on hotplug and hard relies on them for correctness.

Therefore play silly games..

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210121103506.693465814@infradead.org
---
 kernel/workqueue.c | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index 1646331..cce3433 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -1861,6 +1861,8 @@ static void worker_attach_to_pool(struct worker *worker,
 	 */
 	if (pool->flags & POOL_DISASSOCIATED)
 		worker->flags |= WORKER_UNBOUND;
+	else
+		kthread_set_per_cpu(worker->task, pool->cpu);
 
 	list_add_tail(&worker->node, &pool->workers);
 	worker->pool = pool;
@@ -1883,6 +1885,7 @@ static void worker_detach_from_pool(struct worker *worker)
 
 	mutex_lock(&wq_pool_attach_mutex);
 
+	kthread_set_per_cpu(worker->task, -1);
 	list_del(&worker->node);
 	worker->pool = NULL;
 
@@ -4919,8 +4922,10 @@ static void unbind_workers(int cpu)
 
 		raw_spin_unlock_irq(&pool->lock);
 
-		for_each_pool_worker(worker, pool)
+		for_each_pool_worker(worker, pool) {
+			kthread_set_per_cpu(worker->task, -1);
 			WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task, cpu_possible_mask) < 0);
+		}
 
 		mutex_unlock(&wq_pool_attach_mutex);
 
@@ -4972,9 +4977,11 @@ static void rebind_workers(struct worker_pool *pool)
 	 * of all workers first and then clear UNBOUND.  As we're called
 	 * from CPU_ONLINE, the following shouldn't fail.
 	 */
-	for_each_pool_worker(worker, pool)
+	for_each_pool_worker(worker, pool) {
+		kthread_set_per_cpu(worker->task, pool->cpu);
 		WARN_ON_ONCE(set_cpus_allowed_ptr(worker->task,
 						  pool->attrs->cpumask) < 0);
+	}
 
 	raw_spin_lock_irq(&pool->lock);
 
