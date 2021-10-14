Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B6ED42D7F6
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Oct 2021 13:16:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbhJNLS1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 14 Oct 2021 07:18:27 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41842 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230350AbhJNLS1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 14 Oct 2021 07:18:27 -0400
Date:   Thu, 14 Oct 2021 11:16:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634210181;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tV0S+iMu3e7otg3X9y5CjaEdcxwr6KiTQ2ly6Mu10f4=;
        b=NqsWUjIas97fzb8EV0CDOFt4F++exSG/hTo2aQ7VliRdqrVVkrsjxRYcTOCGkx2KiTvR/S
        BSGb5S5gnsSWvj7Z2bOe4t8RZQT1YguTvN1qIwKzog7wYI1F9fSD7lQS/nZumd/UE5UEhz
        QVjWWf6GR3468Cmaeyf4wfSHkLL4BzgEGrcB+YvginUSQ/5GMNIqmUNRZC1cWpy83U5zET
        5qACFCO+0tlSsJhx2escKmsfQRwUYj8f8VYq+OdK8hrbD6HcopX4GYYq/K61u5OKtK0grF
        PcpdGrjl6W5m74iCarcNJiei6TeQi64k2HbUczqbcnlhtKbiHIGdn/niQy59hQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634210181;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tV0S+iMu3e7otg3X9y5CjaEdcxwr6KiTQ2ly6Mu10f4=;
        b=SE/kau0oAyECNndP+0FtQfCfD84yBn8KNrbI4IkJpIe+ypEBrqB5FchaxW/2iK1mOKA2vp
        VwB52JtmuUG/H3Bw==
From:   "tip-bot2 for Bharata B Rao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/numa: Remove the redundant member
 numa_group::fault_cpus
Cc:     Bharata B Rao <bharata@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211004105706.3669-3-bharata@amd.com>
References: <20211004105706.3669-3-bharata@amd.com>
MIME-Version: 1.0
Message-ID: <163421018079.25758.5274889423663563272.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5b763a14a5164e4c442e99d186fb39dac489e49b
Gitweb:        https://git.kernel.org/tip/5b763a14a5164e4c442e99d186fb39dac489e49b
Author:        Bharata B Rao <bharata@amd.com>
AuthorDate:    Mon, 04 Oct 2021 16:27:04 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 14 Oct 2021 13:09:58 +02:00

sched/numa: Remove the redundant member numa_group::fault_cpus

numa_group::fault_cpus is actually a pointer to the region
in numa_group::faults[] where NUMA_CPU stats are located.

Remove this redundant member and use numa_group::faults[NUMA_CPU]
directly like it is done for similar per-process numa fault stats.

There is no functionality change due to this commit.

Signed-off-by: Bharata B Rao <bharata@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mel Gorman <mgorman@suse.de>
Link: https://lkml.kernel.org/r/20211004105706.3669-3-bharata@amd.com
---
 kernel/sched/fair.c | 12 +++++-------
 1 file changed, 5 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fc0a0ed..cfbd5ef 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1038,11 +1038,12 @@ struct numa_group {
 	unsigned long total_faults;
 	unsigned long max_faults_cpu;
 	/*
+	 * faults[] array is split into two regions: faults_mem and faults_cpu.
+	 *
 	 * Faults_cpu is used to decide whether memory should move
 	 * towards the CPU. As a consequence, these stats are weighted
 	 * more by CPU use than by memory faults.
 	 */
-	unsigned long *faults_cpu;
 	unsigned long faults[];
 };
 
@@ -1216,8 +1217,8 @@ static inline unsigned long group_faults(struct task_struct *p, int nid)
 
 static inline unsigned long group_faults_cpu(struct numa_group *group, int nid)
 {
-	return group->faults_cpu[task_faults_idx(NUMA_MEM, nid, 0)] +
-		group->faults_cpu[task_faults_idx(NUMA_MEM, nid, 1)];
+	return group->faults[task_faults_idx(NUMA_CPU, nid, 0)] +
+		group->faults[task_faults_idx(NUMA_CPU, nid, 1)];
 }
 
 static inline unsigned long group_faults_priv(struct numa_group *ng)
@@ -2384,7 +2385,7 @@ static void task_numa_placement(struct task_struct *p)
 				 * is at the beginning of the numa_faults array.
 				 */
 				ng->faults[mem_idx] += diff;
-				ng->faults_cpu[mem_idx] += f_diff;
+				ng->faults[cpu_idx] += f_diff;
 				ng->total_faults += diff;
 				group_faults += ng->faults[mem_idx];
 			}
@@ -2450,9 +2451,6 @@ static void task_numa_group(struct task_struct *p, int cpupid, int flags,
 		grp->max_faults_cpu = 0;
 		spin_lock_init(&grp->lock);
 		grp->gid = p->pid;
-		/* Second half of the array tracks nids where faults happen */
-		grp->faults_cpu = grp->faults + NR_NUMA_HINT_FAULT_TYPES *
-						nr_node_ids;
 
 		for (i = 0; i < NR_NUMA_HINT_FAULT_STATS * nr_node_ids; i++)
 			grp->faults[i] = p->numa_faults[i];
