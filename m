Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC423B297F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 09:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231671AbhFXHlt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 24 Jun 2021 03:41:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42778 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231582AbhFXHlp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 24 Jun 2021 03:41:45 -0400
Date:   Thu, 24 Jun 2021 07:39:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624520365;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d5VYhx0dl2O9EKxbWf2smUgrfZW9nljWMopo3V0xLlI=;
        b=mr9Mb0ymHIE318kAtOqGNaRuygOMtI89nnRIhl6TWtcJ9fb6Wprm4Qn6hqqvOjdBlOEajk
        o/73MWv4U0ZTvU+EBf9R1Gp8NZPwa+zoFKneeNfhnA8MG7XwDlfr0zkue/1q0Uq49IDDtv
        ktgNIuGsQYbLd7O4PtUENsPXHPJz4eIGOKVXXkWzOF9Dv8vawheaQ1hw2UWLjYDjADlPw3
        WNFQ+vVW/lXB+d0VDpjSgsSnzuqLZwQXAvNb2XGL219McpCtmwPdhRb7vJGiQAruBSWigF
        q8suaL/th1DxIzpIodVYuEPUVLZIUtuyu8q/qaR0vj3wMyUmVx6u4zaYo9Fq0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624520365;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=d5VYhx0dl2O9EKxbWf2smUgrfZW9nljWMopo3V0xLlI=;
        b=r29R8W6iBktrudNecfE9HVvK2ry4i4Awghf1c6AQJI3WvFmsnRHopenK7kiKGmsCmn94qg
        B7BVIvxTzdIPXqCw==
From:   "tip-bot2 for Beata Michalska" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: Rework CPU capacity asymmetry detection
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Beata Michalska <beata.michalska@arm.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210603140627.8409-3-beata.michalska@arm.com>
References: <20210603140627.8409-3-beata.michalska@arm.com>
MIME-Version: 1.0
Message-ID: <162452036505.395.15357669848517120397.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c744dc4ab58d1c09624ca3397cf15b142a0e0cb7
Gitweb:        https://git.kernel.org/tip/c744dc4ab58d1c09624ca3397cf15b142a0e0cb7
Author:        Beata Michalska <beata.michalska@arm.com>
AuthorDate:    Thu, 03 Jun 2021 15:06:26 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 24 Jun 2021 09:07:51 +02:00

sched/topology: Rework CPU capacity asymmetry detection

Currently the CPU capacity asymmetry detection, performed through
asym_cpu_capacity_level, tries to identify the lowest topology level
at which the highest CPU capacity is being observed, not necessarily
finding the level at which all possible capacity values are visible
to all CPUs, which might be bit problematic for some possible/valid
asymmetric topologies i.e.:

DIE      [                                ]
MC       [                       ][       ]

CPU       [0] [1] [2] [3] [4] [5]  [6] [7]
Capacity  |.....| |.....| |.....|  |.....|
	     L	     M       B        B

Where:
 arch_scale_cpu_capacity(L) = 512
 arch_scale_cpu_capacity(M) = 871
 arch_scale_cpu_capacity(B) = 1024

In this particular case, the asymmetric topology level will point
at MC, as all possible CPU masks for that level do cover the CPU
with the highest capacity. It will work just fine for the first
cluster, not so much for the second one though (consider the
find_energy_efficient_cpu which might end up attempting the energy
aware wake-up for a domain that does not see any asymmetry at all)

Rework the way the capacity asymmetry levels are being detected,
allowing to point to the lowest topology level (for a given CPU), where
full set of available CPU capacities is visible to all CPUs within given
domain. As a result, the per-cpu sd_asym_cpucapacity might differ across
the domains. This will have an impact on EAS wake-up placement in a way
that it might see different range of CPUs to be considered, depending on
the given current and target CPUs.

Additionally, those levels, where any range of asymmetry (not
necessarily full) is being detected will get identified as well.
The selected asymmetric topology level will be denoted by
SD_ASYM_CPUCAPACITY_FULL sched domain flag whereas the 'sub-levels'
would receive the already used SD_ASYM_CPUCAPACITY flag. This allows
maintaining the current behaviour for asymmetric topologies, with
misfit migration operating correctly on lower levels, if applicable,
as any asymmetry is enough to trigger the misfit migration.
The logic there relies on the SD_ASYM_CPUCAPACITY flag and does not
relate to the full asymmetry level denoted by the sd_asym_cpucapacity
pointer.

Detecting the CPU capacity asymmetry is being based on a set of
available CPU capacities for all possible CPUs. This data is being
generated upon init and updated once CPU topology changes are being
detected (through arch_update_cpu_topology). As such, any changes
to identified CPU capacities (like initializing cpufreq) need to be
explicitly advertised by corresponding archs to trigger rebuilding
the data.

Additional -dflags- parameter, used when building sched domains, has
been removed as well, as the asymmetry flags are now being set directly
in sd_init.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Suggested-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Beata Michalska <beata.michalska@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lore.kernel.org/r/20210603140627.8409-3-beata.michalska@arm.com
---
 kernel/sched/topology.c | 209 ++++++++++++++++++++++++---------------
 1 file changed, 131 insertions(+), 78 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 053115b..b77ad49 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -675,7 +675,7 @@ static void update_top_cache_domain(int cpu)
 	sd = highest_flag_domain(cpu, SD_ASYM_PACKING);
 	rcu_assign_pointer(per_cpu(sd_asym_packing, cpu), sd);
 
-	sd = lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY);
+	sd = lowest_flag_domain(cpu, SD_ASYM_CPUCAPACITY_FULL);
 	rcu_assign_pointer(per_cpu(sd_asym_cpucapacity, cpu), sd);
 }
 
@@ -1267,6 +1267,116 @@ next:
 }
 
 /*
+ * Asymmetric CPU capacity bits
+ */
+struct asym_cap_data {
+	struct list_head link;
+	unsigned long capacity;
+	unsigned long cpus[];
+};
+
+/*
+ * Set of available CPUs grouped by their corresponding capacities
+ * Each list entry contains a CPU mask reflecting CPUs that share the same
+ * capacity.
+ * The lifespan of data is unlimited.
+ */
+static LIST_HEAD(asym_cap_list);
+
+#define cpu_capacity_span(asym_data) to_cpumask((asym_data)->cpus)
+
+/*
+ * Verify whether there is any CPU capacity asymmetry in a given sched domain.
+ * Provides sd_flags reflecting the asymmetry scope.
+ */
+static inline int
+asym_cpu_capacity_classify(const struct cpumask *sd_span,
+			   const struct cpumask *cpu_map)
+{
+	struct asym_cap_data *entry;
+	int count = 0, miss = 0;
+
+	/*
+	 * Count how many unique CPU capacities this domain spans across
+	 * (compare sched_domain CPUs mask with ones representing  available
+	 * CPUs capacities). Take into account CPUs that might be offline:
+	 * skip those.
+	 */
+	list_for_each_entry(entry, &asym_cap_list, link) {
+		if (cpumask_intersects(sd_span, cpu_capacity_span(entry)))
+			++count;
+		else if (cpumask_intersects(cpu_map, cpu_capacity_span(entry)))
+			++miss;
+	}
+
+	WARN_ON_ONCE(!count && !list_empty(&asym_cap_list));
+
+	/* No asymmetry detected */
+	if (count < 2)
+		return 0;
+	/* Some of the available CPU capacity values have not been detected */
+	if (miss)
+		return SD_ASYM_CPUCAPACITY;
+
+	/* Full asymmetry */
+	return SD_ASYM_CPUCAPACITY | SD_ASYM_CPUCAPACITY_FULL;
+
+}
+
+static inline void asym_cpu_capacity_update_data(int cpu)
+{
+	unsigned long capacity = arch_scale_cpu_capacity(cpu);
+	struct asym_cap_data *entry = NULL;
+
+	list_for_each_entry(entry, &asym_cap_list, link) {
+		if (capacity == entry->capacity)
+			goto done;
+	}
+
+	entry = kzalloc(sizeof(*entry) + cpumask_size(), GFP_KERNEL);
+	if (WARN_ONCE(!entry, "Failed to allocate memory for asymmetry data\n"))
+		return;
+	entry->capacity = capacity;
+	list_add(&entry->link, &asym_cap_list);
+done:
+	__cpumask_set_cpu(cpu, cpu_capacity_span(entry));
+}
+
+/*
+ * Build-up/update list of CPUs grouped by their capacities
+ * An update requires explicit request to rebuild sched domains
+ * with state indicating CPU topology changes.
+ */
+static void asym_cpu_capacity_scan(void)
+{
+	struct asym_cap_data *entry, *next;
+	int cpu;
+
+	list_for_each_entry(entry, &asym_cap_list, link)
+		cpumask_clear(cpu_capacity_span(entry));
+
+	for_each_cpu_and(cpu, cpu_possible_mask, housekeeping_cpumask(HK_FLAG_DOMAIN))
+		asym_cpu_capacity_update_data(cpu);
+
+	list_for_each_entry_safe(entry, next, &asym_cap_list, link) {
+		if (cpumask_empty(cpu_capacity_span(entry))) {
+			list_del(&entry->link);
+			kfree(entry);
+		}
+	}
+
+	/*
+	 * Only one capacity value has been detected i.e. this system is symmetric.
+	 * No need to keep this data around.
+	 */
+	if (list_is_singular(&asym_cap_list)) {
+		entry = list_first_entry(&asym_cap_list, typeof(*entry), link);
+		list_del(&entry->link);
+		kfree(entry);
+	}
+}
+
+/*
  * Initializers for schedule domains
  * Non-inlined to reduce accumulated stack pressure in build_sched_domains()
  */
@@ -1399,11 +1509,12 @@ int __read_mostly		node_reclaim_distance = RECLAIM_DISTANCE;
 static struct sched_domain *
 sd_init(struct sched_domain_topology_level *tl,
 	const struct cpumask *cpu_map,
-	struct sched_domain *child, int dflags, int cpu)
+	struct sched_domain *child, int cpu)
 {
 	struct sd_data *sdd = &tl->data;
 	struct sched_domain *sd = *per_cpu_ptr(sdd->sd, cpu);
 	int sd_id, sd_weight, sd_flags = 0;
+	struct cpumask *sd_span;
 
 #ifdef CONFIG_NUMA
 	/*
@@ -1420,9 +1531,6 @@ sd_init(struct sched_domain_topology_level *tl,
 			"wrong sd_flags in topology description\n"))
 		sd_flags &= TOPOLOGY_SD_FLAGS;
 
-	/* Apply detected topology flags */
-	sd_flags |= dflags;
-
 	*sd = (struct sched_domain){
 		.min_interval		= sd_weight,
 		.max_interval		= 2*sd_weight,
@@ -1454,13 +1562,19 @@ sd_init(struct sched_domain_topology_level *tl,
 #endif
 	};
 
-	cpumask_and(sched_domain_span(sd), cpu_map, tl->mask(cpu));
-	sd_id = cpumask_first(sched_domain_span(sd));
+	sd_span = sched_domain_span(sd);
+	cpumask_and(sd_span, cpu_map, tl->mask(cpu));
+	sd_id = cpumask_first(sd_span);
+
+	sd->flags |= asym_cpu_capacity_classify(sd_span, cpu_map);
+
+	WARN_ONCE((sd->flags & (SD_SHARE_CPUCAPACITY | SD_ASYM_CPUCAPACITY)) ==
+		  (SD_SHARE_CPUCAPACITY | SD_ASYM_CPUCAPACITY),
+		  "CPU capacity asymmetry not supported on SMT\n");
 
 	/*
 	 * Convert topological properties into behaviour.
 	 */
-
 	/* Don't attempt to spread across CPUs of different capacities. */
 	if ((sd->flags & SD_ASYM_CPUCAPACITY) && sd->child)
 		sd->child->flags &= ~SD_PREFER_SIBLING;
@@ -1926,9 +2040,9 @@ static void __sdt_free(const struct cpumask *cpu_map)
 
 static struct sched_domain *build_sched_domain(struct sched_domain_topology_level *tl,
 		const struct cpumask *cpu_map, struct sched_domain_attr *attr,
-		struct sched_domain *child, int dflags, int cpu)
+		struct sched_domain *child, int cpu)
 {
-	struct sched_domain *sd = sd_init(tl, cpu_map, child, dflags, cpu);
+	struct sched_domain *sd = sd_init(tl, cpu_map, child, cpu);
 
 	if (child) {
 		sd->level = child->level + 1;
@@ -1991,65 +2105,6 @@ static bool topology_span_sane(struct sched_domain_topology_level *tl,
 }
 
 /*
- * Find the sched_domain_topology_level where all CPU capacities are visible
- * for all CPUs.
- */
-static struct sched_domain_topology_level
-*asym_cpu_capacity_level(const struct cpumask *cpu_map)
-{
-	int i, j, asym_level = 0;
-	bool asym = false;
-	struct sched_domain_topology_level *tl, *asym_tl = NULL;
-	unsigned long cap;
-
-	/* Is there any asymmetry? */
-	cap = arch_scale_cpu_capacity(cpumask_first(cpu_map));
-
-	for_each_cpu(i, cpu_map) {
-		if (arch_scale_cpu_capacity(i) != cap) {
-			asym = true;
-			break;
-		}
-	}
-
-	if (!asym)
-		return NULL;
-
-	/*
-	 * Examine topology from all CPU's point of views to detect the lowest
-	 * sched_domain_topology_level where a highest capacity CPU is visible
-	 * to everyone.
-	 */
-	for_each_cpu(i, cpu_map) {
-		unsigned long max_capacity = arch_scale_cpu_capacity(i);
-		int tl_id = 0;
-
-		for_each_sd_topology(tl) {
-			if (tl_id < asym_level)
-				goto next_level;
-
-			for_each_cpu_and(j, tl->mask(i), cpu_map) {
-				unsigned long capacity;
-
-				capacity = arch_scale_cpu_capacity(j);
-
-				if (capacity <= max_capacity)
-					continue;
-
-				max_capacity = capacity;
-				asym_level = tl_id;
-				asym_tl = tl;
-			}
-next_level:
-			tl_id++;
-		}
-	}
-
-	return asym_tl;
-}
-
-
-/*
  * Build sched domains for a given set of CPUs and attach the sched domains
  * to the individual CPUs
  */
@@ -2061,7 +2116,6 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	struct s_data d;
 	struct rq *rq = NULL;
 	int i, ret = -ENOMEM;
-	struct sched_domain_topology_level *tl_asym;
 	bool has_asym = false;
 
 	if (WARN_ON(cpumask_empty(cpu_map)))
@@ -2071,24 +2125,19 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	if (alloc_state != sa_rootdomain)
 		goto error;
 
-	tl_asym = asym_cpu_capacity_level(cpu_map);
-
 	/* Set up domains for CPUs specified by the cpu_map: */
 	for_each_cpu(i, cpu_map) {
 		struct sched_domain_topology_level *tl;
-		int dflags = 0;
 
 		sd = NULL;
 		for_each_sd_topology(tl) {
-			if (tl == tl_asym) {
-				dflags |= SD_ASYM_CPUCAPACITY;
-				has_asym = true;
-			}
 
 			if (WARN_ON(!topology_span_sane(tl, cpu_map, i)))
 				goto error;
 
-			sd = build_sched_domain(tl, cpu_map, attr, sd, dflags, i);
+			sd = build_sched_domain(tl, cpu_map, attr, sd, i);
+
+			has_asym |= sd->flags & SD_ASYM_CPUCAPACITY;
 
 			if (tl == sched_domain_topology)
 				*per_cpu_ptr(d.sd, i) = sd;
@@ -2217,6 +2266,7 @@ int sched_init_domains(const struct cpumask *cpu_map)
 	zalloc_cpumask_var(&fallback_doms, GFP_KERNEL);
 
 	arch_update_cpu_topology();
+	asym_cpu_capacity_scan();
 	ndoms_cur = 1;
 	doms_cur = alloc_sched_domains(ndoms_cur);
 	if (!doms_cur)
@@ -2299,6 +2349,9 @@ void partition_sched_domains_locked(int ndoms_new, cpumask_var_t doms_new[],
 
 	/* Let the architecture update CPU core mappings: */
 	new_topology = arch_update_cpu_topology();
+	/* Trigger rebuilding CPU capacity asymmetry data */
+	if (new_topology)
+		asym_cpu_capacity_scan();
 
 	if (!doms_new) {
 		WARN_ON_ONCE(dattr_new);
