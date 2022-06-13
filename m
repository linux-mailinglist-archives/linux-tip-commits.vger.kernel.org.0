Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5314254822A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 13 Jun 2022 10:55:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238301AbiFMIny (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 13 Jun 2022 04:43:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239558AbiFMInb (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 13 Jun 2022 04:43:31 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3BAE82650;
        Mon, 13 Jun 2022 01:43:30 -0700 (PDT)
Date:   Mon, 13 Jun 2022 08:43:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1655109808;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LZLnHH656HevaamI6WyFI3pdjLKOFaaIQj+s9mq47yY=;
        b=KReU+w/w4CzOxqDGRHoJCqySc99ANyMGSOxIM+Yk30VySolhaByWr5TxI7stXtrQmXIe5e
        9oz+fK1G1eSI09khMgQkh5fb/PmXYd94WrwQiZ6IHcXJuH0FbHBPhQVBdk7Wz5R+cfQIlt
        1Z6V8PyfDKbspC2JjYhLX5kvp6UApPXNtC5kTajqx0CYKWEBpbQx9HbF7l7j7/kO27dS+Z
        DV15PYG2u/EXZ80r6Hc878/JKv9S5Fsrmrfv4IRVC+kJ88xeQ2wub/MMMRDZTRFV8EH3I8
        1xpne54ZQWBx8DENpxIdf76F3OxGPiSQGj6GTmbPufhqK7eSxQ1gbJ/bQyhlNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1655109808;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LZLnHH656HevaamI6WyFI3pdjLKOFaaIQj+s9mq47yY=;
        b=LKT1i3dXZhSbxrqTb96ISz2LjWNRP8jlc6+gVVzpOqSRJqqxG/ibqgaoSD2vlKUJXVaghC
        6l0pqlA6VDZxqxDw==
From:   "tip-bot2 for K Prateek Nayak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Consider CPU affinity when allowing
 NUMA imbalance in find_idlest_group()
Cc:     K Prateek Nayak <kprateek.nayak@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Mel Gorman <mgorman@techsingularity.net>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220407111222.22649-1-kprateek.nayak@amd.com>
References: <20220407111222.22649-1-kprateek.nayak@amd.com>
MIME-Version: 1.0
Message-ID: <165510980769.4207.452715905804554806.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f5b2eeb49991047f8f64785e7a7857d6f219d574
Gitweb:        https://git.kernel.org/tip/f5b2eeb49991047f8f64785e7a7857d6f219d574
Author:        K Prateek Nayak <kprateek.nayak@amd.com>
AuthorDate:    Thu, 07 Apr 2022 16:42:22 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 13 Jun 2022 10:30:00 +02:00

sched/fair: Consider CPU affinity when allowing NUMA imbalance in find_idlest_group()

In the case of systems containing multiple LLCs per socket, like
AMD Zen systems, users want to spread bandwidth hungry applications
across multiple LLCs. Stream is one such representative workload where
the best performance is obtained by limiting one stream thread per LLC.
To ensure this, users are known to pin the tasks to a specify a subset
of the CPUs consisting of one CPU per LLC while running such bandwidth
hungry tasks.

Suppose we kickstart a multi-threaded task like stream with 8 threads
using taskset or numactl to run on a subset of CPUs on a 2 socket Zen3
server where each socket contains 128 CPUs
(0-63,128-191 in one socket, 64-127,192-255 in another socket)

Eg: numactl -C 0,16,32,48,64,80,96,112 ./stream8

Here each CPU in the list is from a different LLC and 4 of those LLCs
are on one socket, while the other 4 are on another socket.

Ideally we would prefer that each stream thread runs on a different
CPU from the allowed list of CPUs. However, the current heuristics in
find_idlest_group() do not allow this during the initial placement.

Suppose the first socket (0-63,128-191) is our local group from which
we are kickstarting the stream tasks. The first four stream threads
will be placed in this socket. When it comes to placing the 5th
thread, all the allowed CPUs are from the local group (0,16,32,48)
would have been taken.

However, the current scheduler code simply checks if the number of
tasks in the local group is fewer than the allowed numa-imbalance
threshold. This threshold was previously 25% of the NUMA domain span
(in this case threshold = 32) but after the v6 of Mel's patchset
"Adjust NUMA imbalance for multiple LLCs", got merged in sched-tip,
Commit: e496132ebedd ("sched/fair: Adjust the allowed NUMA imbalance
when SD_NUMA spans multiple LLCs") it is now equal to number of LLCs
in the NUMA domain, for processors with multiple LLCs.
(in this case threshold = 8).

For this example, the number of tasks will always be within threshold
and thus all the 8 stream threads will be woken up on the first socket
thereby resulting in sub-optimal performance.

The following sched_wakeup_new tracepoint output shows the initial
placement of tasks in the current tip/sched/core on the Zen3 machine:

stream-5313    [016] d..2.   627.005036: sched_wakeup_new: comm=stream pid=5315 prio=120 target_cpu=032
stream-5313    [016] d..2.   627.005086: sched_wakeup_new: comm=stream pid=5316 prio=120 target_cpu=048
stream-5313    [016] d..2.   627.005141: sched_wakeup_new: comm=stream pid=5317 prio=120 target_cpu=000
stream-5313    [016] d..2.   627.005183: sched_wakeup_new: comm=stream pid=5318 prio=120 target_cpu=016
stream-5313    [016] d..2.   627.005218: sched_wakeup_new: comm=stream pid=5319 prio=120 target_cpu=016
stream-5313    [016] d..2.   627.005256: sched_wakeup_new: comm=stream pid=5320 prio=120 target_cpu=016
stream-5313    [016] d..2.   627.005295: sched_wakeup_new: comm=stream pid=5321 prio=120 target_cpu=016

Once the first four threads are distributed among the allowed CPUs of
socket one, the rest of the treads start piling on these same CPUs
when clearly there are CPUs on the second socket that can be used.

Following the initial pile up on a small number of CPUs, though the
load-balancer eventually kicks in, it takes a while to get to {4}{4}
and even {4}{4} isn't stable as we observe a bunch of ping ponging
between {4}{4} to {5}{3} and back before a stable state is reached
much later (1 Stream thread per allowed CPU) and no more migration is
required.

We can detect this piling and avoid it by checking if the number of
allowed CPUs in the local group are fewer than the number of tasks
running in the local group and use this information to spread the
5th task out into the next socket (after all, the goal in this
slowpath is to find the idlest group and the idlest CPU during the
initial placement!).

The following sched_wakeup_new tracepoint output shows the initial
placement of tasks after adding this fix on the Zen3 machine:

stream-4485    [016] d..2.   230.784046: sched_wakeup_new: comm=stream pid=4487 prio=120 target_cpu=032
stream-4485    [016] d..2.   230.784123: sched_wakeup_new: comm=stream pid=4488 prio=120 target_cpu=048
stream-4485    [016] d..2.   230.784167: sched_wakeup_new: comm=stream pid=4489 prio=120 target_cpu=000
stream-4485    [016] d..2.   230.784222: sched_wakeup_new: comm=stream pid=4490 prio=120 target_cpu=112
stream-4485    [016] d..2.   230.784271: sched_wakeup_new: comm=stream pid=4491 prio=120 target_cpu=096
stream-4485    [016] d..2.   230.784322: sched_wakeup_new: comm=stream pid=4492 prio=120 target_cpu=080
stream-4485    [016] d..2.   230.784368: sched_wakeup_new: comm=stream pid=4493 prio=120 target_cpu=064

We see that threads are using all of the allowed CPUs and there is
no pileup.

No output is generated for tracepoint sched_migrate_task with this
patch due to a perfect initial placement which removes the need
for balancing later on - both across NUMA boundaries and within
NUMA boundaries for stream.

Following are the results from running 8 Stream threads with and
without pinning on a dual socket Zen3 Machine (2 x 64C/128T):

During the testing of this patch, the tip sched/core was at
commit: 089c02ae2771 "ftrace: Use preemption model accessors for trace
header printout"

Pinning is done using: numactl -C 0,16,32,48,64,80,96,112 ./stream8

	           5.18.0-rc1               5.18.0-rc1                5.18.0-rc1
               tip sched/core           tip sched/core            tip sched/core
                 (no pinning)                + pinning              + this-patch
								       + pinning

 Copy:   109364.74 (0.00 pct)     94220.50 (-13.84 pct)    158301.28 (44.74 pct)
Scale:   109670.26 (0.00 pct)     90210.59 (-17.74 pct)    149525.64 (36.34 pct)
  Add:   129029.01 (0.00 pct)    101906.00 (-21.02 pct)    186658.17 (44.66 pct)
Triad:   127260.05 (0.00 pct)    106051.36 (-16.66 pct)    184327.30 (44.84 pct)

Pinning currently hurts the performance compared to unbound case on
tip/sched/core. With the addition of this patch, we are able to
outperform tip/sched/core by a good margin with pinning.

Following are the results from running 16 Stream threads with and
without pinning on a dual socket IceLake Machine (2 x 32C/64T):

NUMA Topology of Intel Skylake machine:
Node 1: 0,2,4,6 ... 126 (Even numbers)
Node 2: 1,3,5,7 ... 127 (Odd numbers)

Pinning is done using: numactl -C 0-15 ./stream16

	           5.18.0-rc1               5.18.0-rc1                5.18.0-rc1
               tip sched/core           tip sched/core            tip sched/core
                 (no pinning)                 +pinning              + this-patch
								       + pinning

 Copy:    85815.31 (0.00 pct)     149819.21 (74.58 pct)    156807.48 (82.72 pct)
Scale:    64795.60 (0.00 pct)      97595.07 (50.61 pct)     99871.96 (54.13 pct)
  Add:    71340.68 (0.00 pct)     111549.10 (56.36 pct)    114598.33 (60.63 pct)
Triad:    68890.97 (0.00 pct)     111635.16 (62.04 pct)    114589.24 (66.33 pct)

In case of Icelake machine, with single LLC per socket, pinning across
the two sockets reduces cache contention, thus showing great
improvement in pinned case which is further benefited by this patch.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Link: https://lkml.kernel.org/r/20220407111222.22649-1-kprateek.nayak@amd.com
---
 kernel/sched/fair.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 166f5f9..1b2cac7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9210,6 +9210,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 	case group_has_spare:
 #ifdef CONFIG_NUMA
 		if (sd->flags & SD_NUMA) {
+			int imb_numa_nr = sd->imb_numa_nr;
 #ifdef CONFIG_NUMA_BALANCING
 			int idlest_cpu;
 			/*
@@ -9227,13 +9228,22 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 			 * Otherwise, keep the task close to the wakeup source
 			 * and improve locality if the number of running tasks
 			 * would remain below threshold where an imbalance is
-			 * allowed. If there is a real need of migration,
-			 * periodic load balance will take care of it.
+			 * allowed while accounting for the possibility the
+			 * task is pinned to a subset of CPUs. If there is a
+			 * real need of migration, periodic load balance will
+			 * take care of it.
 			 */
+			if (p->nr_cpus_allowed != NR_CPUS) {
+				struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
+
+				cpumask_and(cpus, sched_group_span(local), p->cpus_ptr);
+				imb_numa_nr = min(cpumask_weight(cpus), sd->imb_numa_nr);
+			}
+
 			imbalance = abs(local_sgs.idle_cpus - idlest_sgs.idle_cpus);
 			if (!adjust_numa_imbalance(imbalance,
 						   local_sgs.sum_nr_running + 1,
-						   sd->imb_numa_nr)) {
+						   imb_numa_nr)) {
 				return NULL;
 			}
 		}
