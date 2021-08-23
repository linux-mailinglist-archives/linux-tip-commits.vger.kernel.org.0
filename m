Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D04703F4777
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Aug 2021 11:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236011AbhHWJ1O (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 23 Aug 2021 05:27:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39046 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235991AbhHWJ1L (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 23 Aug 2021 05:27:11 -0400
Date:   Mon, 23 Aug 2021 09:26:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629710788;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pfNvv/FSwhy2fEtI7oMQOcQbhjR/vrfjkmR6WQL0RIk=;
        b=l4f2V0I+b06xsXp99QEhUOxOIGXx4lIDGyj2Ymw8A3COfx7lb9iJvEwKK7CFfefJfjTPAW
        Vf4DvFxxckHKyK82w66fHAjFsqHh/YUbJnTmNkTHJqiiVc/qq88nCUNtFIB0vVrg99B5eJ
        QjtXmSLNV5eDxxovvThV/CaMMnYIL5VL3z2k5N0GvLTZdFrg9Q0FZXx8ppgP2rvoueGaN6
        3z5+sIhpWKJ3CSAuD84XDiwyP56MCAGVVIj35W4/jldwS12kcexHJsY7k5BXIwx/wPIQ26
        EmOR7TRi4byTykvv9ITkZvIsZ/AdNzDle7x9LcKUpuL2nf9v3s4NmM4s5fBw0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629710788;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pfNvv/FSwhy2fEtI7oMQOcQbhjR/vrfjkmR6WQL0RIk=;
        b=HCQWvDLrZOSqSldrigjipyeAH5Srws7kzApQMKdNPDISXQyPKCzD++En56+4wQFIgBCtb1
        fiOzxC1pUGFzrxAg==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Skip updating masks for non-online nodes
Cc:     Geetika Moolchandani <Geetika.Moolchandani1@ibm.com>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210818074333.48645-1-srikar@linux.vnet.ibm.com>
References: <20210818074333.48645-1-srikar@linux.vnet.ibm.com>
MIME-Version: 1.0
Message-ID: <162971078760.25758.2264364831988841488.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0083242c93759dde353a963a90cb351c5c283379
Gitweb:        https://git.kernel.org/tip/0083242c93759dde353a963a90cb351c5c283379
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Wed, 18 Aug 2021 13:13:33 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Aug 2021 12:32:57 +02:00

sched/topology: Skip updating masks for non-online nodes

The scheduler currently expects NUMA node distances to be stable from
init onwards, and as a consequence builds the related data structures
once-and-for-all at init (see sched_init_numa()).

Unfortunately, on some architectures node distance is unreliable for
offline nodes and may very well change upon onlining.

Skip over offline nodes during sched_init_numa(). Track nodes that have
been onlined at least once, and trigger a build of a node's NUMA masks
when it is first onlined post-init.

Reported-by: Geetika Moolchandani <Geetika.Moolchandani1@ibm.com>
Signed-off-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210818074333.48645-1-srikar@linux.vnet.ibm.com
---
 kernel/sched/topology.c | 65 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 65 insertions(+)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index b77ad49..4e8698e 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1482,6 +1482,8 @@ int				sched_max_numa_distance;
 static int			*sched_domains_numa_distance;
 static struct cpumask		***sched_domains_numa_masks;
 int __read_mostly		node_reclaim_distance = RECLAIM_DISTANCE;
+
+static unsigned long __read_mostly *sched_numa_onlined_nodes;
 #endif
 
 /*
@@ -1833,6 +1835,16 @@ void sched_init_numa(void)
 			sched_domains_numa_masks[i][j] = mask;
 
 			for_each_node(k) {
+				/*
+				 * Distance information can be unreliable for
+				 * offline nodes, defer building the node
+				 * masks to its bringup.
+				 * This relies on all unique distance values
+				 * still being visible at init time.
+				 */
+				if (!node_online(j))
+					continue;
+
 				if (sched_debug() && (node_distance(j, k) != node_distance(k, j)))
 					sched_numa_warn("Node-distance not symmetric");
 
@@ -1886,6 +1898,53 @@ void sched_init_numa(void)
 	sched_max_numa_distance = sched_domains_numa_distance[nr_levels - 1];
 
 	init_numa_topology_type();
+
+	sched_numa_onlined_nodes = bitmap_alloc(nr_node_ids, GFP_KERNEL);
+	if (!sched_numa_onlined_nodes)
+		return;
+
+	bitmap_zero(sched_numa_onlined_nodes, nr_node_ids);
+	for_each_online_node(i)
+		bitmap_set(sched_numa_onlined_nodes, i, 1);
+}
+
+static void __sched_domains_numa_masks_set(unsigned int node)
+{
+	int i, j;
+
+	/*
+	 * NUMA masks are not built for offline nodes in sched_init_numa().
+	 * Thus, when a CPU of a never-onlined-before node gets plugged in,
+	 * adding that new CPU to the right NUMA masks is not sufficient: the
+	 * masks of that CPU's node must also be updated.
+	 */
+	if (test_bit(node, sched_numa_onlined_nodes))
+		return;
+
+	bitmap_set(sched_numa_onlined_nodes, node, 1);
+
+	for (i = 0; i < sched_domains_numa_levels; i++) {
+		for (j = 0; j < nr_node_ids; j++) {
+			if (!node_online(j) || node == j)
+				continue;
+
+			if (node_distance(j, node) > sched_domains_numa_distance[i])
+				continue;
+
+			/* Add remote nodes in our masks */
+			cpumask_or(sched_domains_numa_masks[i][node],
+				   sched_domains_numa_masks[i][node],
+				   sched_domains_numa_masks[0][j]);
+		}
+	}
+
+	/*
+	 * A new node has been brought up, potentially changing the topology
+	 * classification.
+	 *
+	 * Note that this is racy vs any use of sched_numa_topology_type :/
+	 */
+	init_numa_topology_type();
 }
 
 void sched_domains_numa_masks_set(unsigned int cpu)
@@ -1893,8 +1952,14 @@ void sched_domains_numa_masks_set(unsigned int cpu)
 	int node = cpu_to_node(cpu);
 	int i, j;
 
+	__sched_domains_numa_masks_set(node);
+
 	for (i = 0; i < sched_domains_numa_levels; i++) {
 		for (j = 0; j < nr_node_ids; j++) {
+			if (!node_online(j))
+				continue;
+
+			/* Set ourselves in the remote node's masks */
 			if (node_distance(j, node) <= sched_domains_numa_distance[i])
 				cpumask_set_cpu(cpu, sched_domains_numa_masks[i][j]);
 		}
