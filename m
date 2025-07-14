Return-Path: <linux-tip-commits+bounces-6104-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E1EAB03A65
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Jul 2025 11:10:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27C8D7ACE04
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Jul 2025 09:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DBC8D23D280;
	Mon, 14 Jul 2025 09:10:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VoMHp/s1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5lN/C35/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D52323816E;
	Mon, 14 Jul 2025 09:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752484240; cv=none; b=QDycaSI0D5osmZ0jieGlWitkL1jj5SW97gexFpeUfI4CgjzBGUVu/+8yqRmm2Slb6i9efgKeJoNDUgqjjXzaj6fZf3+j+d66N9wmZo14S5Hw6Qy7DsvaySxuCvThypYE9csHHmvI/JemzeV+rwuGK7meuXlgl5/mPpUddgsKbsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752484240; c=relaxed/simple;
	bh=gSsdlRibZCGhbPmTQrdbRRDnsyWY84K/lEcNOcam0Fw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CxduVX+JdwsQSUUjxGosEPHnWE1O6pudISpsblsp8Rz7wPk85J42uSe0sAUi0+wB490iw98K1iyCZzNuTZsZQVXZxKp21ZQ+uMHpfa+ZSu+rBzQ3MmscE+QK4E1JVsHE+/a2rCSXmFgA9B1sOmdsxYGy3ZPhI/Y8pZ/ogtkSaQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VoMHp/s1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5lN/C35/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Jul 2025 09:10:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752484235;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=na+ptTTflenhb7jBh3O/ahV70evTEEusOVEGO9jRj4c=;
	b=VoMHp/s1QLNhvLnm4aFzGX89wCUTKuriOBPjh2ciiUpX6ZhIp02GEdeX/whsgBD+8HU7Di
	FLlh4qyILyRYOzVKEGL8QF9snmD0w9V3PYSQZ6X89rSorg5UIzSY1XLGT8mCh9HhnyHicY
	Xm22EI9n4YEa7oBtCpXwo9Zpxgqfi6Q3eGIYZVqYwL0KIGPfFGYo6o51FMUxG391QgPJIP
	vthr0eGtQFcVAJF09TqTBcsvHRDESpad1hgX16t819DjCICdY0wSf4sS6yjFC5pGlib4Yx
	JIio6ZPV/z3w5eIEeyY3xxLmaXlKCb+TYDIZu8Q2zlZBrToJiGBxRne/xNNTIg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752484235;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=na+ptTTflenhb7jBh3O/ahV70evTEEusOVEGO9jRj4c=;
	b=5lN/C35/RbulREUmKCwHjSpCXGpM46ys3X7yrtDbuoV2BwMfEsjGECWQoRJzWIy7Ieq0oI
	HfODBbOQcUwGo9AQ==
From: "tip-bot2 for K Prateek Nayak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/topology: Remove sched_domain_topology_level::flags
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <ba4dbdf8-bc37-493d-b2e0-2efb00ea3e19@amd.com>
References: <ba4dbdf8-bc37-493d-b2e0-2efb00ea3e19@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175248423411.406.13014862740644090792.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1eec89a671413ce38df9fe9e70f5130a9eb79a59
Gitweb:        https://git.kernel.org/tip/1eec89a671413ce38df9fe9e70f5130a9eb79a59
Author:        K Prateek Nayak <kprateek.nayak@amd.com>
AuthorDate:    Fri, 11 Jul 2025 11:20:30 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Jul 2025 10:59:35 +02:00

sched/topology: Remove sched_domain_topology_level::flags

Support for overlapping domains added in commit e3589f6c81e4 ("sched:
Allow for overlapping sched_domain spans") also allowed forcefully
setting SD_OVERLAP for !NUMA domains via FORCE_SD_OVERLAP sched_feat().

Since NUMA domains had to be presumed overlapping to ensure correct
behavior, "sched_domain_topology_level::flags" was introduced. NUMA
domains added the SDTL_OVERLAP flag would ensure SD_OVERLAP was always
added during build_sched_domains() for these domains, even when
FORCE_SD_OVERLAP was off.

Condition for adding the SD_OVERLAP flag at the aforementioned commit
was as follows:

    if (tl->flags & SDTL_OVERLAP || sched_feat(FORCE_SD_OVERLAP))
            sd->flags |= SD_OVERLAP;

The FORCE_SD_OVERLAP debug feature was removed in commit af85596c74de
("sched/topology: Remove FORCE_SD_OVERLAP") which left the NUMA domains
as the exclusive users of SDTL_OVERLAP, SD_OVERLAP, and SD_NUMA flags.

Get rid of SDTL_OVERLAP and SD_OVERLAP as they have become redundant
and instead rely on SD_NUMA to detect the only overlapping domain
currently supported. Since SDTL_OVERLAP was the only user of
"tl->flags", get rid of "sched_domain_topology_level::flags" too.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/ba4dbdf8-bc37-493d-b2e0-2efb00ea3e19@amd.com
---
 include/linux/sched/sd_flags.h |  8 --------
 include/linux/sched/topology.h |  3 ---
 kernel/sched/fair.c            |  6 +++---
 kernel/sched/topology.c        | 19 ++++++++++---------
 4 files changed, 13 insertions(+), 23 deletions(-)

diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
index b04a5d0..42839cf 100644
--- a/include/linux/sched/sd_flags.h
+++ b/include/linux/sched/sd_flags.h
@@ -154,14 +154,6 @@ SD_FLAG(SD_ASYM_PACKING, SDF_NEEDS_GROUPS)
 SD_FLAG(SD_PREFER_SIBLING, SDF_NEEDS_GROUPS)
 
 /*
- * sched_groups of this level overlap
- *
- * SHARED_PARENT: Set for all NUMA levels above NODE.
- * NEEDS_GROUPS: Overlaps can only exist with more than one group.
- */
-SD_FLAG(SD_OVERLAP, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
-
-/*
  * Cross-node balancing
  *
  * SHARED_PARENT: Set for all NUMA levels above NODE.
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 0d5daaa..5263746 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -175,8 +175,6 @@ bool cpus_share_resources(int this_cpu, int that_cpu);
 typedef const struct cpumask *(*sched_domain_mask_f)(int cpu);
 typedef int (*sched_domain_flags_f)(void);
 
-#define SDTL_OVERLAP	0x01
-
 struct sd_data {
 	struct sched_domain *__percpu *sd;
 	struct sched_domain_shared *__percpu *sds;
@@ -187,7 +185,6 @@ struct sd_data {
 struct sched_domain_topology_level {
 	sched_domain_mask_f mask;
 	sched_domain_flags_f sd_flags;
-	int		    flags;
 	int		    numa_level;
 	struct sd_data      data;
 	char                *name;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 20a8456..b9b4bbb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9926,9 +9926,9 @@ void update_group_capacity(struct sched_domain *sd, int cpu)
 	min_capacity = ULONG_MAX;
 	max_capacity = 0;
 
-	if (child->flags & SD_OVERLAP) {
+	if (child->flags & SD_NUMA) {
 		/*
-		 * SD_OVERLAP domains cannot assume that child groups
+		 * SD_NUMA domains cannot assume that child groups
 		 * span the current group.
 		 */
 
@@ -9941,7 +9941,7 @@ void update_group_capacity(struct sched_domain *sd, int cpu)
 		}
 	} else  {
 		/*
-		 * !SD_OVERLAP domains can assume that child groups
+		 * !SD_NUMA domains can assume that child groups
 		 * span the current group.
 		 */
 
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index d01f5a4..977e133 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -89,7 +89,7 @@ static int sched_domain_debug_one(struct sched_domain *sd, int cpu, int level,
 			break;
 		}
 
-		if (!(sd->flags & SD_OVERLAP) &&
+		if (!(sd->flags & SD_NUMA) &&
 		    cpumask_intersects(groupmask, sched_group_span(group))) {
 			printk(KERN_CONT "\n");
 			printk(KERN_ERR "ERROR: repeated CPUs\n");
@@ -102,7 +102,7 @@ static int sched_domain_debug_one(struct sched_domain *sd, int cpu, int level,
 				group->sgc->id,
 				cpumask_pr_args(sched_group_span(group)));
 
-		if ((sd->flags & SD_OVERLAP) &&
+		if ((sd->flags & SD_NUMA) &&
 		    !cpumask_equal(group_balance_mask(group), sched_group_span(group))) {
 			printk(KERN_CONT " mask=%*pbl",
 				cpumask_pr_args(group_balance_mask(group)));
@@ -1344,7 +1344,7 @@ void sched_update_asym_prefer_cpu(int cpu, int old_prio, int new_prio)
 		 * "sg->asym_prefer_cpu" to "sg->sgc->asym_prefer_cpu"
 		 * which is shared by all the overlapping groups.
 		 */
-		WARN_ON_ONCE(sd->flags & SD_OVERLAP);
+		WARN_ON_ONCE(sd->flags & SD_NUMA);
 
 		sg = sd->groups;
 		if (cpu != sg->asym_prefer_cpu) {
@@ -2016,7 +2016,6 @@ void sched_init_numa(int offline_node)
 	for (j = 1; j < nr_levels; i++, j++) {
 		tl[i] = SDTL_INIT(sd_numa_mask, cpu_numa_flags, NUMA);
 		tl[i].numa_level = j;
-		tl[i].flags = SDTL_OVERLAP;
 	}
 
 	sched_domain_topology_saved = sched_domain_topology;
@@ -2327,7 +2326,7 @@ static void __sdt_free(const struct cpumask *cpu_map)
 
 			if (sdd->sd) {
 				sd = *per_cpu_ptr(sdd->sd, j);
-				if (sd && (sd->flags & SD_OVERLAP))
+				if (sd && (sd->flags & SD_NUMA))
 					free_sched_groups(sd->groups, 0);
 				kfree(*per_cpu_ptr(sdd->sd, j));
 			}
@@ -2393,9 +2392,13 @@ static bool topology_span_sane(const struct cpumask *cpu_map)
 	id_seen = sched_domains_tmpmask2;
 
 	for_each_sd_topology(tl) {
+		int tl_common_flags = 0;
+
+		if (tl->sd_flags)
+			tl_common_flags = (*tl->sd_flags)();
 
 		/* NUMA levels are allowed to overlap */
-		if (tl->flags & SDTL_OVERLAP)
+		if (tl_common_flags & SD_NUMA)
 			continue;
 
 		cpumask_clear(covered);
@@ -2466,8 +2469,6 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 
 			if (tl == sched_domain_topology)
 				*per_cpu_ptr(d.sd, i) = sd;
-			if (tl->flags & SDTL_OVERLAP)
-				sd->flags |= SD_OVERLAP;
 			if (cpumask_equal(cpu_map, sched_domain_span(sd)))
 				break;
 		}
@@ -2480,7 +2481,7 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 	for_each_cpu(i, cpu_map) {
 		for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
 			sd->span_weight = cpumask_weight(sched_domain_span(sd));
-			if (sd->flags & SD_OVERLAP) {
+			if (sd->flags & SD_NUMA) {
 				if (build_overlap_sched_groups(sd, i))
 					goto error;
 			} else {

