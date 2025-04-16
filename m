Return-Path: <linux-tip-commits+bounces-5019-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B0B3DA90C1E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Apr 2025 21:17:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CEE915A37B2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Apr 2025 19:16:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54553225401;
	Wed, 16 Apr 2025 19:16:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t+qw0X5v";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="70fpECIW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68A84224AED;
	Wed, 16 Apr 2025 19:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744831002; cv=none; b=GIimWa8Xl+GB0LIWfBO6ZwxOLCLtn5pMaKr7o+rUdWp0U/4PCAfTPe4IBzVzgPqXYrxAHe273o2tMYOW77mxZvroZDCfB9Xc218fHOI4KZ0PucwODfAuunbN81uqJ0/ON/LFHFke3qtXXwM2m2HNxdZoZoEjA17kSB+vbMTJ0Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744831002; c=relaxed/simple;
	bh=//OcZ6aMZ1tXeBxd+UuUIev/NxDmRpUrbqEEMsupXPY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VdeITWJc5PiTrLQ0tG5SgX5U9q2qWDwXBjw2ybFGdQh23Mek+iUgHX6Itee7LILB5XIBL8yPt0PhQX5NUYJNB/1V3Ca6M3deNeBN3PCmvsj1G7kQ8lQem25+BfmENt/lBIQ6EzOQ2nv9slDg3B8GHEtacL/nZfug58p7nxHKkHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t+qw0X5v; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=70fpECIW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 16 Apr 2025 19:16:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744830998;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yzoNNlv6mpva2iFWKv0naYmo1ydHVNgDC5x3ZGf8pXY=;
	b=t+qw0X5voyngr1/UdeNfY4krBUrNl9Afn6a1k0OY5u1h5mIOuY3ZmZBMSp6cuZFNOLPoad
	NGM9QD5J7AeWkfXspxYly3kkxNPM2U/n5W3WCrRVQERKQJNz9Q5f+NMoQREYQD6D/TaDnk
	ZNzIep/VVx2HfmdnaUky8OI9Ml4Yi1QcJ8yvmBRHuzPXeG//ae4HT0ecz/TS4ZaNj/bFhM
	BzVjwTvzR+EE2NT3bTgcFuta+BdXw8+ao/n6It/12eEkHuKywFjz7pXIkA7g7bS3UoT1TC
	66CsciG9gi8/CmakVK2Xjw8pulxuWO9Byv4cZJS1jxa8oyPOse3GgHoo6775vA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744830998;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yzoNNlv6mpva2iFWKv0naYmo1ydHVNgDC5x3ZGf8pXY=;
	b=70fpECIWSh+8qwwAnoeaEEIlmudszaHrm5DkDfDZpdacgZtyt+VfTbri943ymhUiwz6uAs
	LP9wEagOoskI3/AQ==
From: "tip-bot2 for K Prateek Nayak" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/topology: Introduce sched_update_asym_prefer_cpu()
Cc: K Prateek Nayak <kprateek.nayak@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250409053446.23367-3-kprateek.nayak@amd.com>
References: <20250409053446.23367-3-kprateek.nayak@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174483099730.31282.4498493935507707550.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0e3f6c3696424fa90d6f512779d617a05a1cf031
Gitweb:        https://git.kernel.org/tip/0e3f6c3696424fa90d6f512779d617a05a1cf031
Author:        K Prateek Nayak <kprateek.nayak@amd.com>
AuthorDate:    Wed, 09 Apr 2025 05:34:44 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 16 Apr 2025 21:09:11 +02:00

sched/topology: Introduce sched_update_asym_prefer_cpu()

A subset of AMD Processors supporting Preferred Core Rankings also
feature the ability to dynamically switch these rankings at runtime to
bias load balancing towards or away from the LLC domain with larger
cache.

To support dynamically updating "sg->asym_prefer_cpu" without needing to
rebuild the sched domain, introduce sched_update_asym_prefer_cpu() which
recomutes the "asym_prefer_cpu" when the core-ranking of a CPU changes.

sched_update_asym_prefer_cpu() swaps the "sg->asym_prefer_cpu" with the
CPU whose ranking has changed if the new ranking is greater than that of
the "asym_prefer_cpu". If CPU whose ranking has changed is the current
"asym_prefer_cpu", it scans the CPUs of the sched groups to find the new
"asym_prefer_cpu" and sets it accordingly.

get_group() for non-overlapping sched domains returns the sched group
for the first CPU in the sched_group_span() which ensures all CPUs in
the group see the updated value of "asym_prefer_cpu".

Overlapping groups are allocated differently and will require moving the
"asym_prefer_cpu" to "sg->sgc" but since the current implementations do
not set "SD_ASYM_PACKING" at NUMA domains, skip additional
indirection and place a SCHED_WARN_ON() to alert any future users.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250409053446.23367-3-kprateek.nayak@amd.com
---
 include/linux/sched/topology.h |  6 +++-
 kernel/sched/topology.c        | 58 +++++++++++++++++++++++++++++++++-
 2 files changed, 64 insertions(+)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 7b4301b..198bb5c 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -195,6 +195,8 @@ struct sched_domain_topology_level {
 };
 
 extern void __init set_sched_topology(struct sched_domain_topology_level *tl);
+extern void sched_update_asym_prefer_cpu(int cpu, int old_prio, int new_prio);
+
 
 # define SD_INIT_NAME(type)		.name = #type
 
@@ -223,6 +225,10 @@ static inline bool cpus_share_resources(int this_cpu, int that_cpu)
 	return true;
 }
 
+static inline void sched_update_asym_prefer_cpu(int cpu, int old_prio, int new_prio)
+{
+}
+
 #endif	/* !CONFIG_SMP */
 
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index bbc2fc2..a2a38e1 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1333,6 +1333,64 @@ next:
 	update_group_capacity(sd, cpu);
 }
 
+#ifdef CONFIG_SMP
+
+/* Update the "asym_prefer_cpu" when arch_asym_cpu_priority() changes. */
+void sched_update_asym_prefer_cpu(int cpu, int old_prio, int new_prio)
+{
+	int asym_prefer_cpu = cpu;
+	struct sched_domain *sd;
+
+	guard(rcu)();
+
+	for_each_domain(cpu, sd) {
+		struct sched_group *sg;
+		int group_cpu;
+
+		if (!(sd->flags & SD_ASYM_PACKING))
+			continue;
+
+		/*
+		 * Groups of overlapping domain are replicated per NUMA
+		 * node and will require updating "asym_prefer_cpu" on
+		 * each local copy.
+		 *
+		 * If you are hitting this warning, consider moving
+		 * "sg->asym_prefer_cpu" to "sg->sgc->asym_prefer_cpu"
+		 * which is shared by all the overlapping groups.
+		 */
+		WARN_ON_ONCE(sd->flags & SD_OVERLAP);
+
+		sg = sd->groups;
+		if (cpu != sg->asym_prefer_cpu) {
+			/*
+			 * Since the parent is a superset of the current group,
+			 * if the cpu is not the "asym_prefer_cpu" at the
+			 * current level, it cannot be the preferred CPU at a
+			 * higher levels either.
+			 */
+			if (!sched_asym_prefer(cpu, sg->asym_prefer_cpu))
+				return;
+
+			WRITE_ONCE(sg->asym_prefer_cpu, cpu);
+			continue;
+		}
+
+		/* Ranking has improved; CPU is still the preferred one. */
+		if (new_prio >= old_prio)
+			continue;
+
+		for_each_cpu(group_cpu, sched_group_span(sg)) {
+			if (sched_asym_prefer(group_cpu, asym_prefer_cpu))
+				asym_prefer_cpu = group_cpu;
+		}
+
+		WRITE_ONCE(sg->asym_prefer_cpu, asym_prefer_cpu);
+	}
+}
+
+#endif /* CONFIG_SMP */
+
 /*
  * Set of available CPUs grouped by their corresponding capacities
  * Each list entry contains a CPU mask reflecting CPUs that share the same

