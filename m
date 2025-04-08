Return-Path: <linux-tip-commits+bounces-4774-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BC4FA8157F
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 21:10:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF5614E124C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 19:09:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D93EF257AED;
	Tue,  8 Apr 2025 19:05:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3ZgmN9v1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8TSrqak9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C14A62571D8;
	Tue,  8 Apr 2025 19:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139144; cv=none; b=eXiEJ/rsTiXFTOlDnd2ekzUvISYiGukTVlKgXFWVP1dRE220xlDSXm1bqeR3hNwP8Ol+VsZSpJnHXeS2pHHPgvtOApt2y0i3WbVSHJUBw3ETlNcZlcTsqjUeOTBhVt2y0AERqblKh2FwtxgrRlui6Rv59Fq3czEBpGZWzdQLe0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139144; c=relaxed/simple;
	bh=DNw42TihKKSxr+yTBu/pWcfhDnVTcRt79pwRYqG6pDU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=j8MGDtkT7Q26eSymbzkrJ7bEI+k8DWAJmFwt73o2n+CCRdrwGGa+rKbecC8cj9j3v2XOw5nhIZly71NLTd/X2ej9SFQlphSSXFRQGS3tPe87v6DzQ8BOqnR609pOuOr574NS5tWZvlzcPSX6kMUgi8IMbWMQbX9omyZXf0RDxKo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3ZgmN9v1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8TSrqak9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Apr 2025 19:05:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744139141;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4BdmEWrBfc0gbOSE/k+RMls5Zn0jsjHOo1HVeIX6FYA=;
	b=3ZgmN9v1bGZo4VWDyHptmclZ+xBo74do2p0FVWkoWH2S1nTc2qDW8L1bu9h7LxzPF0cU3q
	T2+2l+ydq3Lck2NCVVgA8hXKg8bmyONkp7lIB3FUUP+kARWWpSAw7IDU3vR88FDJg+dPIu
	+I5WAM95V2LjMb/MoWPcvkU1oPLDMjC4Ve6pHvpWX+Bw3jNvICwwBt/h1FDohww1F6ZDGK
	uMLL4niVSlvssYvb8p9bfHXjoeUOME6zGUgm72j4R16pZZ8bzY85u5es9FEBi5ZVtb7I9z
	B1rAfoi75NrTnx6obrEOGMXjfZi3l2Ztmws/Tl8s0Ea9XC4whkm5QRouyFP86Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744139141;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4BdmEWrBfc0gbOSE/k+RMls5Zn0jsjHOo1HVeIX6FYA=;
	b=8TSrqak9Swp2ACKvP119Fcfl6C2Kc78IC+Yw/nGMcNcwQxIUZeSOlySGkfWtZqniy6Dc1e
	KOldYdxboRFHWGDg==
From: "tip-bot2 for Steve Wahl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/topology: improve topology_span_sane speed
Cc: Steve Wahl <steve.wahl@hpe.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250304160844.75373-2-steve.wahl@hpe.com>
References: <20250304160844.75373-2-steve.wahl@hpe.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174413914000.31282.17041434426497465022.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f55dac1dafb3334be1d5b54bf385e8cfaa0ab3b3
Gitweb:        https://git.kernel.org/tip/f55dac1dafb3334be1d5b54bf385e8cfaa0ab3b3
Author:        Steve Wahl <steve.wahl@hpe.com>
AuthorDate:    Tue, 04 Mar 2025 10:08:43 -06:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Apr 2025 20:55:51 +02:00

sched/topology: improve topology_span_sane speed

Use a different approach to topology_span_sane(), that checks for the
same constraint of no partial overlaps for any two CPU sets for
non-NUMA topology levels, but does so in a way that is O(N) rather
than O(N^2).

Instead of comparing with all other masks to detect collisions, keep
one mask that includes all CPUs seen so far and detect collisions with
a single cpumask_intersects test.

If the current mask has no collisions with previously seen masks, it
should be a new mask, which can be uniquely identified by the lowest
bit set in this mask.  Keep a pointer to this mask for future
reference (in an array indexed by the lowest bit set), and add the
CPUs in this mask to the list of those seen.

If the current mask does collide with previously seen masks, it should
be exactly equal to a mask seen before, looked up in the same array
indexed by the lowest bit set in the mask, a single comparison.

Move the topology_span_sane() check out of the existing topology level
loop, let it use its own loop so that the array allocation can be done
only once, shared across levels.

On a system with 1920 processors (16 sockets, 60 cores, 2 threads),
the average time to take one processor offline is reduced from 2.18
seconds to 1.01 seconds.  (Off-lining 959 of 1920 processors took
34m49.765s without this change, 16m10.038s with this change in place.)

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Link: https://lore.kernel.org/r/20250304160844.75373-2-steve.wahl@hpe.com
---
 kernel/sched/topology.c | 83 +++++++++++++++++++++++++++-------------
 1 file changed, 58 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index f1ebc60..439e6ce 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2347,36 +2347,69 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
 
 /*
  * Ensure topology masks are sane, i.e. there are no conflicts (overlaps) for
- * any two given CPUs at this (non-NUMA) topology level.
+ * any two given CPUs on non-NUMA topology levels.
  */
-static bool topology_span_sane(struct sched_domain_topology_level *tl,
-			      const struct cpumask *cpu_map, int cpu)
+static bool topology_span_sane(const struct cpumask *cpu_map)
 {
-	int i = cpu + 1;
+	struct sched_domain_topology_level *tl;
+	const struct cpumask **masks;
+	struct cpumask *covered;
+	int cpu, id;
+	bool ret = false;
 
-	/* NUMA levels are allowed to overlap */
-	if (tl->flags & SDTL_OVERLAP)
-		return true;
+	lockdep_assert_held(&sched_domains_mutex);
+	covered = sched_domains_tmpmask;
+
+	masks = kmalloc_array(nr_cpu_ids, sizeof(struct cpumask *), GFP_KERNEL);
+	if (!masks)
+		return ret;
+
+	for_each_sd_topology(tl) {
+
+		/* NUMA levels are allowed to overlap */
+		if (tl->flags & SDTL_OVERLAP)
+			continue;
+
+		cpumask_clear(covered);
+		memset(masks, 0, nr_cpu_ids * sizeof(struct cpumask *));
 
-	/*
-	 * Non-NUMA levels cannot partially overlap - they must be either
-	 * completely equal or completely disjoint. Otherwise we can end up
-	 * breaking the sched_group lists - i.e. a later get_group() pass
-	 * breaks the linking done for an earlier span.
-	 */
-	for_each_cpu_from(i, cpu_map) {
 		/*
-		 * We should 'and' all those masks with 'cpu_map' to exactly
-		 * match the topology we're about to build, but that can only
-		 * remove CPUs, which only lessens our ability to detect
-		 * overlaps
+		 * Non-NUMA levels cannot partially overlap - they must be either
+		 * completely equal or completely disjoint. Otherwise we can end up
+		 * breaking the sched_group lists - i.e. a later get_group() pass
+		 * breaks the linking done for an earlier span.
 		 */
-		if (!cpumask_equal(tl->mask(cpu), tl->mask(i)) &&
-		    cpumask_intersects(tl->mask(cpu), tl->mask(i)))
-			return false;
+		for_each_cpu(cpu, cpu_map) {
+			/* lowest bit set in this mask is used as a unique id */
+			id = cpumask_first(tl->mask(cpu));
+
+			/* zeroed masks cannot possibly collide */
+			if (id >= nr_cpu_ids)
+				continue;
+
+			/* if this mask doesn't collide with what we've already seen */
+			if (!cpumask_intersects(tl->mask(cpu), covered)) {
+				/* this failing would be an error in this algorithm */
+				if (WARN_ON(masks[id]))
+					goto notsane;
+
+				/* record the mask we saw for this id */
+				masks[id] = tl->mask(cpu);
+				cpumask_or(covered, tl->mask(cpu), covered);
+			} else if ((!masks[id]) || !cpumask_equal(masks[id], tl->mask(cpu))) {
+				/*
+				 * a collision with covered should have exactly matched
+				 * a previously seen mask with the same id
+				 */
+				goto notsane;
+			}
+		}
 	}
+	ret = true;
 
-	return true;
+ notsane:
+	kfree(masks);
+	return ret;
 }
 
 /*
@@ -2408,9 +2441,6 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 		sd = NULL;
 		for_each_sd_topology(tl) {
 
-			if (WARN_ON(!topology_span_sane(tl, cpu_map, i)))
-				goto error;
-
 			sd = build_sched_domain(tl, cpu_map, attr, sd, i);
 
 			has_asym |= sd->flags & SD_ASYM_CPUCAPACITY;
@@ -2424,6 +2454,9 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
 		}
 	}
 
+	if (WARN_ON(!topology_span_sane(cpu_map)))
+		goto error;
+
 	/* Build the groups for the domains */
 	for_each_cpu(i, cpu_map) {
 		for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {

