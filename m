Return-Path: <linux-tip-commits+bounces-4773-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 76B69A81582
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 21:10:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 481021BC2657
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 19:09:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDE98257450;
	Tue,  8 Apr 2025 19:05:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cBxsS8Ov";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/ch97Q5S"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEBB52571AB;
	Tue,  8 Apr 2025 19:05:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139143; cv=none; b=XfoT4txhTg3cpInYkqG0s9b8eSFxm4Oac9gdivpDF2qKaS36vVQwuB/e7qn7uXLsGNOV0R00y1Qmto01V3q1FD6g45D4E3mBolrCK4P9U06WAxj1qpI7OmFQBNZRRaafwHhsks6dsKK68ECuqNVjeFqXt5jehDNZTh69SbhND6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139143; c=relaxed/simple;
	bh=Mp8eErg0QdaKf3cfJdb/IhM+Fma+U8PqC3Y7tTRX9mA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qZfW1pdSYtnuzUWjYBU54LzHwS4pm7JKm0Sf7BwwW67SMqhCk6jujaaeVCeQnxc390WzQtLeSd4YX/wSyULrCOlLkAmQ68hy7viDYdJ81tQPqiodKEMkVWG1QC8+xJc4UnryFiyBlIubNMDDSvnd43P56yMQVYwQfg92PF/KiOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cBxsS8Ov; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/ch97Q5S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Apr 2025 19:05:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744139140;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+PKzX+Y3MhwLcY5QGY4lDYq1w3gekKr+ZkjzCNjZj0=;
	b=cBxsS8OvxYSZRoWHaPTX63g9cwt+XGlyFgK/6UAE9FAMaDVqA/v2pe3VHO5q3ymkyz7ZCG
	GnPH3eTjl418Kyc3WeiNdq1cPCEYP44WCxXCy5IhVRI3eQGYzgmU1oMOLymA51ohNr+qpk
	Ily8Uu1xLJxcOg5hq1kBMQ75dycC/ubz9Are9Ttabi5emfDqACJ13qAU25zwMj8IAfnIg9
	YsKzKSet2gOB/HUi34Dolq5CfNL+TCMnPRFTjlkXJzS7kiQK+4qPfyh8cjvzqrgS6wFOsl
	kz6EYyAE9nYPv3jCHQG/AIk3veeFV8xzoBaOBfRhvWglmoi489Ww12T6v6OYZA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744139140;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0+PKzX+Y3MhwLcY5QGY4lDYq1w3gekKr+ZkjzCNjZj0=;
	b=/ch97Q5SQZsBZJ3ORmp/ll2AKJfGLE+0tsl5zzjfdNQomanh7Na7BykbmCVj3G4wmzX8oC
	YxwGq96v7Q369kDA==
From: "tip-bot2 for Steve Wahl" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/topology: Refinement to topology_span_sane speedup
Cc: Steve Wahl <steve.wahl@hpe.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Madadi Vineeth Reddy <vineethr@linux.ibm.com>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250304160844.75373-3-steve.wahl@hpe.com>
References: <20250304160844.75373-3-steve.wahl@hpe.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174413913933.31282.8269331548789868578.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     ce29a7da84cdeafc7c08c32d329037c71ab3f3dd
Gitweb:        https://git.kernel.org/tip/ce29a7da84cdeafc7c08c32d329037c71ab3f3dd
Author:        Steve Wahl <steve.wahl@hpe.com>
AuthorDate:    Tue, 04 Mar 2025 10:08:44 -06:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Apr 2025 20:55:52 +02:00

sched/topology: Refinement to topology_span_sane speedup

Simplify the topology_span_sane code further, removing the need to
allocate an array and gotos used to make sure the array gets freed.

This version is in a separate commit because it could return a
different sanity result than the previous code, but only in odd
circumstances that are not expected to actually occur; for example,
when a CPU is not listed in its own mask.

Signed-off-by: Steve Wahl <steve.wahl@hpe.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Madadi Vineeth Reddy <vineethr@linux.ibm.com>
Link: https://lore.kernel.org/r/20250304160844.75373-3-steve.wahl@hpe.com
---
 kernel/sched/topology.c | 52 ++++++++++++++--------------------------
 1 file changed, 19 insertions(+), 33 deletions(-)

diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 439e6ce..b334f25 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -2352,17 +2352,12 @@ static struct sched_domain *build_sched_domain(struct sched_domain_topology_leve
 static bool topology_span_sane(const struct cpumask *cpu_map)
 {
 	struct sched_domain_topology_level *tl;
-	const struct cpumask **masks;
-	struct cpumask *covered;
-	int cpu, id;
-	bool ret = false;
+	struct cpumask *covered, *id_seen;
+	int cpu;
 
 	lockdep_assert_held(&sched_domains_mutex);
 	covered = sched_domains_tmpmask;
-
-	masks = kmalloc_array(nr_cpu_ids, sizeof(struct cpumask *), GFP_KERNEL);
-	if (!masks)
-		return ret;
+	id_seen = sched_domains_tmpmask2;
 
 	for_each_sd_topology(tl) {
 
@@ -2371,7 +2366,7 @@ static bool topology_span_sane(const struct cpumask *cpu_map)
 			continue;
 
 		cpumask_clear(covered);
-		memset(masks, 0, nr_cpu_ids * sizeof(struct cpumask *));
+		cpumask_clear(id_seen);
 
 		/*
 		 * Non-NUMA levels cannot partially overlap - they must be either
@@ -2380,36 +2375,27 @@ static bool topology_span_sane(const struct cpumask *cpu_map)
 		 * breaks the linking done for an earlier span.
 		 */
 		for_each_cpu(cpu, cpu_map) {
-			/* lowest bit set in this mask is used as a unique id */
-			id = cpumask_first(tl->mask(cpu));
+			const struct cpumask *tl_cpu_mask = tl->mask(cpu);
+			int id;
 
-			/* zeroed masks cannot possibly collide */
-			if (id >= nr_cpu_ids)
-				continue;
+			/* lowest bit set in this mask is used as a unique id */
+			id = cpumask_first(tl_cpu_mask);
 
-			/* if this mask doesn't collide with what we've already seen */
-			if (!cpumask_intersects(tl->mask(cpu), covered)) {
-				/* this failing would be an error in this algorithm */
-				if (WARN_ON(masks[id]))
-					goto notsane;
+			if (cpumask_test_cpu(id, id_seen)) {
+				/* First CPU has already been seen, ensure identical spans */
+				if (!cpumask_equal(tl->mask(id), tl_cpu_mask))
+					return false;
+			} else {
+				/* First CPU hasn't been seen before, ensure it's a completely new span */
+				if (cpumask_intersects(tl_cpu_mask, covered))
+					return false;
 
-				/* record the mask we saw for this id */
-				masks[id] = tl->mask(cpu);
-				cpumask_or(covered, tl->mask(cpu), covered);
-			} else if ((!masks[id]) || !cpumask_equal(masks[id], tl->mask(cpu))) {
-				/*
-				 * a collision with covered should have exactly matched
-				 * a previously seen mask with the same id
-				 */
-				goto notsane;
+				cpumask_or(covered, covered, tl_cpu_mask);
+				cpumask_set_cpu(id, id_seen);
 			}
 		}
 	}
-	ret = true;
-
- notsane:
-	kfree(masks);
-	return ret;
+	return true;
 }
 
 /*

