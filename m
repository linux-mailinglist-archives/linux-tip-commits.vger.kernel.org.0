Return-Path: <linux-tip-commits+bounces-6846-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3D56EBE2747
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 11:41:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9ACE93E1DD5
	for <lists+linux-tip-commits@lfdr.de>; Thu, 16 Oct 2025 09:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6F73322DC0;
	Thu, 16 Oct 2025 09:33:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aTA7U1E1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J0qjMh2/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 332EF32144A;
	Thu, 16 Oct 2025 09:33:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760607229; cv=none; b=RUgSuuTmZdUZGgnfQL242dJJTCmekaxyKMhgwxbmftGpViXaeB54xT8pXAJq8wU9y5AU2JuxVk3JhjyqEknddNxG/tZKmATaH+K+kW/cU+kYHKJFDRXkgtSRpFXaIvhBw0Z97alWo7wyW5nQO8nDweihQ7gUfPxToO4qzowvZMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760607229; c=relaxed/simple;
	bh=gQBz/bytyvZLH5deektfejdp2SfzjW71RV7vszQTXEY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=bqZL5yuXr86/j/9shKM61eyGOezOkZdhY2ETF9BzYhK4AI0tLxeurbruQawIEC0nkUrcYBrsZrilUFYcYI1zZt1VlagI/PaT9pXwYZ5USrtVxGh2nbB5eal2oGec37zG8PBUq/AVPfimJNUFfEfTa2annT9KhX4p8k6qwSpam48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aTA7U1E1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J0qjMh2/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 16 Oct 2025 09:33:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1760607226;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w8h17K6lyU4KF17r2vTQJs/R79dIP4/mkLAQnnSc0VI=;
	b=aTA7U1E1guiBIWI8NrD8z39EM3qqZhE0TBdWdQeBgFcc3LRTkqSIC/Kri6/M6SCagYJ/cA
	MeNzd/WNNzq4zIOkLIRhzaEWJLjHwrTvj3YRhaPz5h8+xF+eSEnmJhyAoFlR62vci+eopQ
	EDILafW17NqbouCzArdtphgIglZU+iVsh49yJXyZdLWDVSsUxk/mgI+9tabAUeyzyyG/Qe
	DIgS6jEKDasKN68YOmIVjNnFk57X04ec+Y46doDcIPag4s+7CtfiTIceI1bv2EOasu9TKf
	1BLJu2eBZ3F+ZviqrIWZAkpI14H3m7jrAyC9D9xTjXJNrsWxu43PLLG0xcF6ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1760607226;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w8h17K6lyU4KF17r2vTQJs/R79dIP4/mkLAQnnSc0VI=;
	b=J0qjMh2/r6cHT5570zEOAjqP16RQpeB2bhjFI5difOywl9LvwKoqwtHGE9Is+ucMgotMPA
	ahOaZDmk7bD+FaAA==
From: "tip-bot2 for Tim Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched: Create architecture specific sched domain distances
Cc: Vinicius Costa Gomes <vinicius.gomes@intel.com>,
 Tim Chen <tim.c.chen@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Chen Yu <yu.c.chen@intel.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C411c685b1dcb7ed47e5268bb89f9ce7b277bf219=2E1759515?=
 =?utf-8?q?405=2Egit=2Etim=2Ec=2Echen=40linux=2Eintel=2Ecom=3E?=
References: =?utf-8?q?=3C411c685b1dcb7ed47e5268bb89f9ce7b277bf219=2E17595154?=
 =?utf-8?q?05=2Egit=2Etim=2Ec=2Echen=40linux=2Eintel=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176060722455.709179.7175779057195139752.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     06f2c90885e92992d1ce55d3f35b65b44d5ecc25
Gitweb:        https://git.kernel.org/tip/06f2c90885e92992d1ce55d3f35b65b44d5=
ecc25
Author:        Tim Chen <tim.c.chen@linux.intel.com>
AuthorDate:    Fri, 03 Oct 2025 12:31:27 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 16 Oct 2025 11:13:49 +02:00

sched: Create architecture specific sched domain distances

Allow architecture specific sched domain NUMA distances that are
modified from actual NUMA node distances for the purpose of building
NUMA sched domains.

Keep actual NUMA distances separately if modified distances
are used for building sched domains. Such distances
are still needed as NUMA balancing benefits from finding the
NUMA nodes that are actually closer to a task numa_group.

Consolidate the recording of unique NUMA distances in an array to
sched_record_numa_dist() so the function can be reused to record NUMA
distances when the NUMA distance metric is changed.

No functional change and additional distance array
allocated if there're no arch specific NUMA distances
being defined.

Co-developed-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Vinicius Costa Gomes <vinicius.gomes@intel.com>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Chen Yu <yu.c.chen@intel.com>
---
 kernel/sched/topology.c | 108 +++++++++++++++++++++++++++++++--------
 1 file changed, 86 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 444bdfd..711076a 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1590,10 +1590,17 @@ static void claim_allocations(int cpu, struct sched_d=
omain *sd)
 #ifdef CONFIG_NUMA
 enum numa_topology_type sched_numa_topology_type;
=20
+/*
+ * sched_domains_numa_distance is derived from sched_numa_node_distance
+ * and provides a simplified view of NUMA distances used specifically
+ * for building NUMA scheduling domains.
+ */
 static int			sched_domains_numa_levels;
+static int			sched_numa_node_levels;
=20
 int				sched_max_numa_distance;
 static int			*sched_domains_numa_distance;
+static int			*sched_numa_node_distance;
 static struct cpumask		***sched_domains_numa_masks;
 #endif /* CONFIG_NUMA */
=20
@@ -1845,10 +1852,10 @@ bool find_numa_distance(int distance)
 		return true;
=20
 	rcu_read_lock();
-	distances =3D rcu_dereference(sched_domains_numa_distance);
+	distances =3D rcu_dereference(sched_numa_node_distance);
 	if (!distances)
 		goto unlock;
-	for (i =3D 0; i < sched_domains_numa_levels; i++) {
+	for (i =3D 0; i < sched_numa_node_levels; i++) {
 		if (distances[i] =3D=3D distance) {
 			found =3D true;
 			break;
@@ -1924,14 +1931,34 @@ static void init_numa_topology_type(int offline_node)
=20
 #define NR_DISTANCE_VALUES (1 << DISTANCE_BITS)
=20
-void sched_init_numa(int offline_node)
+/*
+ * An architecture could modify its NUMA distance, to change
+ * grouping of NUMA nodes and number of NUMA levels when creating
+ * NUMA level sched domains.
+ *
+ * A NUMA level is created for each unique
+ * arch_sched_node_distance.
+ */
+static int numa_node_dist(int i, int j)
 {
-	struct sched_domain_topology_level *tl;
-	unsigned long *distance_map;
+	return node_distance(i, j);
+}
+
+int arch_sched_node_distance(int from, int to)
+			     __weak __alias(numa_node_dist);
+
+static bool modified_sched_node_distance(void)
+{
+	return numa_node_dist !=3D arch_sched_node_distance;
+}
+
+static int sched_record_numa_dist(int offline_node, int (*n_dist)(int, int),
+				  int **dist, int *levels)
+{
+	unsigned long *distance_map __free(bitmap) =3D NULL;
 	int nr_levels =3D 0;
 	int i, j;
 	int *distances;
-	struct cpumask ***masks;
=20
 	/*
 	 * O(nr_nodes^2) de-duplicating selection sort -- in order to find the
@@ -1939,17 +1966,16 @@ void sched_init_numa(int offline_node)
 	 */
 	distance_map =3D bitmap_alloc(NR_DISTANCE_VALUES, GFP_KERNEL);
 	if (!distance_map)
-		return;
+		return -ENOMEM;
=20
 	bitmap_zero(distance_map, NR_DISTANCE_VALUES);
 	for_each_cpu_node_but(i, offline_node) {
 		for_each_cpu_node_but(j, offline_node) {
-			int distance =3D node_distance(i, j);
+			int distance =3D n_dist(i, j);
=20
 			if (distance < LOCAL_DISTANCE || distance >=3D NR_DISTANCE_VALUES) {
 				sched_numa_warn("Invalid distance value range");
-				bitmap_free(distance_map);
-				return;
+				return -EINVAL;
 			}
=20
 			bitmap_set(distance_map, distance, 1);
@@ -1962,18 +1988,46 @@ void sched_init_numa(int offline_node)
 	nr_levels =3D bitmap_weight(distance_map, NR_DISTANCE_VALUES);
=20
 	distances =3D kcalloc(nr_levels, sizeof(int), GFP_KERNEL);
-	if (!distances) {
-		bitmap_free(distance_map);
-		return;
-	}
+	if (!distances)
+		return -ENOMEM;
=20
 	for (i =3D 0, j =3D 0; i < nr_levels; i++, j++) {
 		j =3D find_next_bit(distance_map, NR_DISTANCE_VALUES, j);
 		distances[i] =3D j;
 	}
-	rcu_assign_pointer(sched_domains_numa_distance, distances);
+	*dist =3D distances;
+	*levels =3D nr_levels;
+
+	return 0;
+}
+
+void sched_init_numa(int offline_node)
+{
+	struct sched_domain_topology_level *tl;
+	int nr_levels, nr_node_levels;
+	int i, j;
+	int *distances, *domain_distances;
+	struct cpumask ***masks;
=20
-	bitmap_free(distance_map);
+	/* Record the NUMA distances from SLIT table */
+	if (sched_record_numa_dist(offline_node, numa_node_dist, &distances,
+				   &nr_node_levels))
+		return;
+
+	/* Record modified NUMA distances for building sched domains */
+	if (modified_sched_node_distance()) {
+		if (sched_record_numa_dist(offline_node, arch_sched_node_distance,
+					   &domain_distances, &nr_levels)) {
+			kfree(distances);
+			return;
+		}
+	} else {
+		domain_distances =3D distances;
+		nr_levels =3D nr_node_levels;
+	}
+	rcu_assign_pointer(sched_numa_node_distance, distances);
+	WRITE_ONCE(sched_max_numa_distance, distances[nr_node_levels - 1]);
+	WRITE_ONCE(sched_numa_node_levels, nr_node_levels);
=20
 	/*
 	 * 'nr_levels' contains the number of unique distances
@@ -1991,6 +2045,8 @@ void sched_init_numa(int offline_node)
 	 *
 	 * We reset it to 'nr_levels' at the end of this function.
 	 */
+	rcu_assign_pointer(sched_domains_numa_distance, domain_distances);
+
 	sched_domains_numa_levels =3D 0;
=20
 	masks =3D kzalloc(sizeof(void *) * nr_levels, GFP_KERNEL);
@@ -2016,10 +2072,13 @@ void sched_init_numa(int offline_node)
 			masks[i][j] =3D mask;
=20
 			for_each_cpu_node_but(k, offline_node) {
-				if (sched_debug() && (node_distance(j, k) !=3D node_distance(k, j)))
+				if (sched_debug() &&
+				    (arch_sched_node_distance(j, k) !=3D
+				     arch_sched_node_distance(k, j)))
 					sched_numa_warn("Node-distance not symmetric");
=20
-				if (node_distance(j, k) > sched_domains_numa_distance[i])
+				if (arch_sched_node_distance(j, k) >
+				    sched_domains_numa_distance[i])
 					continue;
=20
 				cpumask_or(mask, mask, cpumask_of_node(k));
@@ -2059,7 +2118,6 @@ void sched_init_numa(int offline_node)
 	sched_domain_topology =3D tl;
=20
 	sched_domains_numa_levels =3D nr_levels;
-	WRITE_ONCE(sched_max_numa_distance, sched_domains_numa_distance[nr_levels -=
 1]);
=20
 	init_numa_topology_type(offline_node);
 }
@@ -2067,14 +2125,18 @@ void sched_init_numa(int offline_node)
=20
 static void sched_reset_numa(void)
 {
-	int nr_levels, *distances;
+	int nr_levels, *distances, *dom_distances =3D NULL;
 	struct cpumask ***masks;
=20
 	nr_levels =3D sched_domains_numa_levels;
+	sched_numa_node_levels =3D 0;
 	sched_domains_numa_levels =3D 0;
 	sched_max_numa_distance =3D 0;
 	sched_numa_topology_type =3D NUMA_DIRECT;
-	distances =3D sched_domains_numa_distance;
+	distances =3D sched_numa_node_distance;
+	if (sched_numa_node_distance !=3D sched_domains_numa_distance)
+		dom_distances =3D sched_domains_numa_distance;
+	rcu_assign_pointer(sched_numa_node_distance, NULL);
 	rcu_assign_pointer(sched_domains_numa_distance, NULL);
 	masks =3D sched_domains_numa_masks;
 	rcu_assign_pointer(sched_domains_numa_masks, NULL);
@@ -2083,6 +2145,7 @@ static void sched_reset_numa(void)
=20
 		synchronize_rcu();
 		kfree(distances);
+		kfree(dom_distances);
 		for (i =3D 0; i < nr_levels && masks; i++) {
 			if (!masks[i])
 				continue;
@@ -2129,7 +2192,8 @@ void sched_domains_numa_masks_set(unsigned int cpu)
 				continue;
=20
 			/* Set ourselves in the remote node's masks */
-			if (node_distance(j, node) <=3D sched_domains_numa_distance[i])
+			if (arch_sched_node_distance(j, node) <=3D
+			    sched_domains_numa_distance[i])
 				cpumask_set_cpu(cpu, sched_domains_numa_masks[i][j]);
 		}
 	}

