Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3E4F664BEB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Jan 2023 20:04:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239578AbjAJTEk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Jan 2023 14:04:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239688AbjAJS6J (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Jan 2023 13:58:09 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0995532A5;
        Tue, 10 Jan 2023 10:56:42 -0800 (PST)
Date:   Tue, 10 Jan 2023 18:56:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1673377001;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/L4DwXMWgDWmNSzdNDeoSpHKvUZyzRWaGNLUdb3sukE=;
        b=jb7ZHHsGCZEh5FRUXYvm2PJVcQgQIGVPAs778bkFqgo+5zH5qGtk+FuxMN2Mm9JB3rTyF0
        9YsWcerNQCMoxbko2xpDto9GkdQCb8bvhl9B8rGX0L/qnFZpiJn3wa/7D+t7wtL65MGTPs
        QHsCZe8s1Tm4NRxxhBvtS/tCIZ3BSnRnyZffCDmkWBlKmgREe2B969XtpX6txNcd2S5OmF
        6wKuWdsleaILw1oGt1IRdbd6OkR+vIiA1UtjHcZIt8BjPJX5wM5LVePcbw6DJYKnPx5BK4
        2nt9KIUTbjf74PDfVjQjxWCCZ8eWNeACmhpTTTuTvfHkusgkIBQxndpCIf/PWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1673377001;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/L4DwXMWgDWmNSzdNDeoSpHKvUZyzRWaGNLUdb3sukE=;
        b=3MAeEoWlzVwVe4bnCPK3ZHwXAexa1EGVrqKTPQ7Lr5DAMKkCgBuBMZrwfm80iZsMlrSk5S
        le9KqhNU6+4Wo7BA==
From:   "tip-bot2 for Peter Newman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/urgent] x86/resctrl: Fix task CLOSID/RMID update race
Cc:     Peter Newman <peternewman@google.com>,
        "Borislav Petkov (AMD)" <bp@alien8.de>,
        Reinette Chatre <reinette.chatre@intel.com>,
        Babu Moger <babu.moger@amd.com>, <stable@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20221220161123.432120-1-peternewman@google.com>
References: <20221220161123.432120-1-peternewman@google.com>
MIME-Version: 1.0
Message-ID: <167337700055.4906.13745071797567132460.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/urgent branch of tip:

Commit-ID:     fe1f0714385fbcf76b0cbceb02b7277d842014fc
Gitweb:        https://git.kernel.org/tip/fe1f0714385fbcf76b0cbceb02b7277d842014fc
Author:        Peter Newman <peternewman@google.com>
AuthorDate:    Tue, 20 Dec 2022 17:11:23 +01:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Tue, 10 Jan 2023 19:47:30 +01:00

x86/resctrl: Fix task CLOSID/RMID update race

When the user moves a running task to a new rdtgroup using the task's
file interface or by deleting its rdtgroup, the resulting change in
CLOSID/RMID must be immediately propagated to the PQR_ASSOC MSR on the
task(s) CPUs.

x86 allows reordering loads with prior stores, so if the task starts
running between a task_curr() check that the CPU hoisted before the
stores in the CLOSID/RMID update then it can start running with the old
CLOSID/RMID until it is switched again because __rdtgroup_move_task()
failed to determine that it needs to be interrupted to obtain the new
CLOSID/RMID.

Refer to the diagram below:

CPU 0                                   CPU 1
-----                                   -----
__rdtgroup_move_task():
  curr <- t1->cpu->rq->curr
                                        __schedule():
                                          rq->curr <- t1
                                        resctrl_sched_in():
                                          t1->{closid,rmid} -> {1,1}
  t1->{closid,rmid} <- {2,2}
  if (curr == t1) // false
   IPI(t1->cpu)

A similar race impacts rdt_move_group_tasks(), which updates tasks in a
deleted rdtgroup.

In both cases, use smp_mb() to order the task_struct::{closid,rmid}
stores before the loads in task_curr().  In particular, in the
rdt_move_group_tasks() case, simply execute an smp_mb() on every
iteration with a matching task.

It is possible to use a single smp_mb() in rdt_move_group_tasks(), but
this would require two passes and a means of remembering which
task_structs were updated in the first loop. However, benchmarking
results below showed too little performance impact in the simple
approach to justify implementing the two-pass approach.

Times below were collected using `perf stat` to measure the time to
remove a group containing a 1600-task, parallel workload.

CPU: Intel(R) Xeon(R) Platinum P-8136 CPU @ 2.00GHz (112 threads)

  # mkdir /sys/fs/resctrl/test
  # echo $$ > /sys/fs/resctrl/test/tasks
  # perf bench sched messaging -g 40 -l 100000

task-clock time ranges collected using:

  # perf stat rmdir /sys/fs/resctrl/test

Baseline:                     1.54 - 1.60 ms
smp_mb() every matching task: 1.57 - 1.67 ms

  [ bp: Massage commit message. ]

Fixes: ae28d1aae48a ("x86/resctrl: Use an IPI instead of task_work_add() to update PQR_ASSOC MSR")
Fixes: 0efc89be9471 ("x86/intel_rdt: Update task closid immediately on CPU in rmdir and unmount")
Signed-off-by: Peter Newman <peternewman@google.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Reviewed-by: Reinette Chatre <reinette.chatre@intel.com>
Reviewed-by: Babu Moger <babu.moger@amd.com>
Cc: <stable@kernel.org>
Link: https://lore.kernel.org/r/20221220161123.432120-1-peternewman@google.com
---
 arch/x86/kernel/cpu/resctrl/rdtgroup.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kernel/cpu/resctrl/rdtgroup.c b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
index e5a48f0..5993da2 100644
--- a/arch/x86/kernel/cpu/resctrl/rdtgroup.c
+++ b/arch/x86/kernel/cpu/resctrl/rdtgroup.c
@@ -580,8 +580,10 @@ static int __rdtgroup_move_task(struct task_struct *tsk,
 	/*
 	 * Ensure the task's closid and rmid are written before determining if
 	 * the task is current that will decide if it will be interrupted.
+	 * This pairs with the full barrier between the rq->curr update and
+	 * resctrl_sched_in() during context switch.
 	 */
-	barrier();
+	smp_mb();
 
 	/*
 	 * By now, the task's closid and rmid are set. If the task is current
@@ -2402,6 +2404,14 @@ static void rdt_move_group_tasks(struct rdtgroup *from, struct rdtgroup *to,
 			WRITE_ONCE(t->rmid, to->mon.rmid);
 
 			/*
+			 * Order the closid/rmid stores above before the loads
+			 * in task_curr(). This pairs with the full barrier
+			 * between the rq->curr update and resctrl_sched_in()
+			 * during context switch.
+			 */
+			smp_mb();
+
+			/*
 			 * If the task is on a CPU, set the CPU in the mask.
 			 * The detection is inaccurate as tasks might move or
 			 * schedule before the smp function call takes place.
