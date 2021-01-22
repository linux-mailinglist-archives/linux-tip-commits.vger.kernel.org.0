Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83132300A5C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Jan 2021 18:59:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728684AbhAVRu3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 22 Jan 2021 12:50:29 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55776 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729269AbhAVRm1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 22 Jan 2021 12:42:27 -0500
Date:   Fri, 22 Jan 2021 17:41:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611337297;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iX8RuBOriMNO1CC2C8Ss7ijZIg7L9CBWeoSJcvLXGz8=;
        b=AwqdFMoq73jD4hAiAelH5rtjp0KSJ6+ck9lBSpsJH4TIn6oM3Q44RnR7XHg43VmjaATnk2
        OdOnm0EnU2et5vIZ3vj66EXQaahwwPYw8CHKJekawyYJ6yrnYKBIpsgjZmqU60J5eFREn/
        auAcnFHO0I3m6iKiw/s58UDrJcNWZs3z0KztAxmhUqFeBX36WSkpqPEyiOx+af+ocMU7wk
        eXQz3VkZyl58nHC0AYteeLArQcsCArQKzxdw7IxZejpgsqi2coc8x+G+pF9iaYHGy/12gY
        gXyavE3herlYgH2wx+w4mKtk5lJy6Fb2rFmPeq+5bmhSC4R+TyD0soCxW27pwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611337297;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iX8RuBOriMNO1CC2C8Ss7ijZIg7L9CBWeoSJcvLXGz8=;
        b=mmXS1LeHHOwKHbZ2jI9zouMzsS8PTIY+Kz3xLMtudIbdyrh4eJaavOiPjLbnS3kAoM4SX0
        +MNkZLjYpoCHVgAw==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/core: Print out straggler tasks in
 sched_cpu_dying()
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210113183141.11974-1-valentin.schneider@arm.com>
References: <20210113183141.11974-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <161133729681.414.5269247466626769329.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     36c6e17bf16922935a5a0dd073d5b032d34aa73d
Gitweb:        https://git.kernel.org/tip/36c6e17bf16922935a5a0dd073d5b032d34aa73d
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Wed, 13 Jan 2021 18:31:41 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Jan 2021 15:09:41 +01:00

sched/core: Print out straggler tasks in sched_cpu_dying()

Since commit

  1cf12e08bc4d ("sched/hotplug: Consolidate task migration on CPU unplug")

tasks are expected to move themselves out of a out-going CPU. For most
tasks this will be done automagically via BALANCE_PUSH, but percpu kthreads
will have to cooperate and move themselves away one way or another.

Currently, some percpu kthreads (workqueues being a notable exemple) do not
cooperate nicely and can end up on an out-going CPU at the time
sched_cpu_dying() is invoked.

Print the dying rq's tasks to shed some light on the stragglers.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210113183141.11974-1-valentin.schneider@arm.com
---
 kernel/sched/core.c | 24 +++++++++++++++++++++++-
 1 file changed, 23 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 15d2562..627534f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7574,6 +7574,25 @@ static void calc_load_migrate(struct rq *rq)
 		atomic_long_add(delta, &calc_load_tasks);
 }
 
+static void dump_rq_tasks(struct rq *rq, const char *loglvl)
+{
+	struct task_struct *g, *p;
+	int cpu = cpu_of(rq);
+
+	lockdep_assert_held(&rq->lock);
+
+	printk("%sCPU%d enqueued tasks (%u total):\n", loglvl, cpu, rq->nr_running);
+	for_each_process_thread(g, p) {
+		if (task_cpu(p) != cpu)
+			continue;
+
+		if (!task_on_rq_queued(p))
+			continue;
+
+		printk("%s\tpid: %d, name: %s\n", loglvl, p->pid, p->comm);
+	}
+}
+
 int sched_cpu_dying(unsigned int cpu)
 {
 	struct rq *rq = cpu_rq(cpu);
@@ -7583,7 +7602,10 @@ int sched_cpu_dying(unsigned int cpu)
 	sched_tick_stop(cpu);
 
 	rq_lock_irqsave(rq, &rf);
-	BUG_ON(rq->nr_running != 1 || rq_has_pinned_tasks(rq));
+	if (rq->nr_running != 1 || rq_has_pinned_tasks(rq)) {
+		WARN(true, "Dying CPU not properly vacated!");
+		dump_rq_tasks(rq, KERN_WARNING);
+	}
 	rq_unlock_irqrestore(rq, &rf);
 
 	calc_load_migrate(rq);
