Return-Path: <linux-tip-commits+bounces-3355-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DA2AAA31E05
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Feb 2025 06:37:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7F1A4167008
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Feb 2025 05:37:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0A2D1F3FC6;
	Wed, 12 Feb 2025 05:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="WHhT0h5b"
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F12BB67E;
	Wed, 12 Feb 2025 05:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739338635; cv=none; b=UvnRPA9fpCk0GyaLHeq4SsX1J3aYVeqGhH7UQoKJzdN6f6j/EByjtG3P0BFEPfr/WE3ckU8kDTBgL61/IPNwz4YsLW34RfZnwsunhsqZ6uhG5LAmw/Mq5cbiD3Kme/QpL+uhYR8OFavY3P0QWaWjHLLpqHt0jdvrM40XdjbVDsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739338635; c=relaxed/simple;
	bh=Vq/sQyw4FHu+wn+41JCedKUlbPLVFsN3KR1dIt4xYOQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SkbJZ5gZQKWqQPuuar3JbnL0DZYC0IB/HBskjg4sD3hZCbgayKokm27OVn+a/Og5WAAE/R2cO34o7xJYPCRmfwDanB/Jwy9EFIkNyKzHPfm3PXLXlRATJZ4amfBlvUq+IbchbcO7aNG1Bm/x/GC726b1vIanehJabOQ8ESqFOUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.com; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=WHhT0h5b; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1739338634; x=1770874634;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=N1ldq/teHo/QBZY6cIiNd8wg81nHlAQXLen7eInilfM=;
  b=WHhT0h5b8/HqP3Pib/O2PCe4p4FyZrGxO8Cp2JIYGnRcIeebq5jTDBax
   1X0RNE5u/oNCRMSK2EaAMnwBLuXYSiuWpcsFP35jT3v9XL+CbZxqgKoRp
   FW/4bUQD4TzpuoVwvLMGXQSWj9wyq7t5TJ+WKaVpX4QX6ZAP+tx4MmIOW
   4=;
X-IronPort-AV: E=Sophos;i="6.13,279,1732579200"; 
   d="scan'208";a="168935605"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Feb 2025 05:37:13 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:32783]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.25.59:2525] with esmtp (Farcaster)
 id c69e62f5-4918-4895-af0d-a33eddd4d416; Wed, 12 Feb 2025 05:37:13 +0000 (UTC)
X-Farcaster-Flow-ID: c69e62f5-4918-4895-af0d-a33eddd4d416
Received: from EX19D016UWA004.ant.amazon.com (10.13.139.119) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 12 Feb 2025 05:37:13 +0000
Received: from 88665a51a6b2.amazon.com (10.106.179.55) by
 EX19D016UWA004.ant.amazon.com (10.13.139.119) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Wed, 12 Feb 2025 05:37:10 +0000
From: Cristian Prundeanu <cpru@amazon.com>
To: Peter Zijlstra <peterz@infradead.org>
CC: Cristian Prundeanu <cpru@amazon.com>, K Prateek Nayak
	<kprateek.nayak@amd.com>, Hazem Mohamed Abuelfotoh <abuehaze@amazon.com>,
	"Ali Saidi" <alisaidi@amazon.com>, Benjamin Herrenschmidt
	<benh@kernel.crashing.org>, Geoff Blake <blakgeof@amazon.com>, Csaba Csoma
	<csabac@amazon.com>, Bjoern Doebel <doebel@amazon.com>, Gautham Shenoy
	<gautham.shenoy@amd.com>, Joseph Salisbury <joseph.salisbury@oracle.com>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Ingo Molnar <mingo@redhat.com>,
	Linus Torvalds <torvalds@linux-foundation.org>, Borislav Petkov
	<bp@alien8.de>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-tip-commits@vger.kernel.org>,
	<x86@kernel.org>
Subject: [PATCH v2] [tip: sched/core] sched: Move PLACE_LAG and RUN_TO_PARITY to sysctl
Date: Tue, 11 Feb 2025 23:36:44 -0600
Message-ID: <20250212053644.14787-1-cpru@amazon.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250128230926.11715-1-cpru@amazon.com>
References: <20250119110410.GAZ4zcKkx5sCjD5XvH@fat_crate.local>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D039UWB003.ant.amazon.com (10.13.138.93) To
 EX19D016UWA004.ant.amazon.com (10.13.139.119)

Replacing CFS with the EEVDF scheduler in kernel 6.6 introduced
significant performance degradation in multiple database-oriented
workloads. This degradation manifests in all kernel versions using EEVDF,
across multiple Linux distributions, hardware architectures (x86_64,
aarm64, amd64), and CPU generations.

Testing combinations of available scheduler features showed that the
largest improvement (short of disabling all EEVDF features) came from
disabling both PLACE_LAG and RUN_TO_PARITY.

Moving PLACE_LAG and RUN_TO_PARITY to sysctl will allow users to override
their default values and persist them with established mechanisms.

Link: https://lore.kernel.org/20241017052000.99200-1-cpru@amazon.com
Signed-off-by: Cristian Prundeanu <cpru@amazon.com>
---
v2: use latest sched/core; defer default value change to a follow-up patch

 include/linux/sched/sysctl.h |  8 ++++++++
 kernel/sched/core.c          | 13 +++++++++++++
 kernel/sched/fair.c          |  7 ++++---
 kernel/sched/features.h      | 10 ----------
 kernel/sysctl.c              | 20 ++++++++++++++++++++
 5 files changed, 45 insertions(+), 13 deletions(-)

diff --git a/include/linux/sched/sysctl.h b/include/linux/sched/sysctl.h
index 5a64582b086b..a899398bc1c4 100644
--- a/include/linux/sched/sysctl.h
+++ b/include/linux/sched/sysctl.h
@@ -29,4 +29,12 @@ extern int sysctl_numa_balancing_mode;
 #define sysctl_numa_balancing_mode	0
 #endif
 
+#if defined(CONFIG_SCHED_DEBUG) && defined(CONFIG_SYSCTL)
+extern unsigned int sysctl_sched_place_lag_enabled;
+extern unsigned int sysctl_sched_run_to_parity_enabled;
+#else
+#define sysctl_sched_place_lag_enabled 1
+#define sysctl_sched_run_to_parity_enabled 1
+#endif
+
 #endif /* _LINUX_SCHED_SYSCTL_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9142a0394d46..a379240628ea 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -134,6 +134,19 @@ const_debug unsigned int sysctl_sched_features =
 	0;
 #undef SCHED_FEAT
 
+#ifdef CONFIG_SYSCTL
+/*
+ * Using the avg_vruntime, do the right thing and preserve lag across
+ * sleep+wake cycles. EEVDF placement strategy #1, #2 if disabled.
+ */
+__read_mostly unsigned int sysctl_sched_place_lag_enabled = 1;
+/*
+ * Inhibit (wakeup) preemption until the current task has either matched the
+ * 0-lag point or until it has exhausted its slice.
+ */
+__read_mostly unsigned int sysctl_sched_run_to_parity_enabled = 1;
+#endif
+
 /*
  * Print a warning if need_resched is set for the given duration (if
  * LATENCY_WARN is enabled).
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1e78caa21436..c87fd1accd54 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -923,7 +923,8 @@ static struct sched_entity *pick_eevdf(struct cfs_rq *cfs_rq)
 	 * Once selected, run a task until it either becomes non-eligible or
 	 * until it gets a new slice. See the HACK in set_next_entity().
 	 */
-	if (sched_feat(RUN_TO_PARITY) && curr && curr->vlag == curr->deadline)
+	if (sysctl_sched_run_to_parity_enabled && curr &&
+	    curr->vlag == curr->deadline)
 		return curr;
 
 	/* Pick the leftmost entity if it's eligible */
@@ -5199,7 +5200,7 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	 *
 	 * EEVDF: placement strategy #1 / #2
 	 */
-	if (sched_feat(PLACE_LAG) && cfs_rq->nr_queued && se->vlag) {
+	if (sysctl_sched_place_lag_enabled && cfs_rq->nr_queued && se->vlag) {
 		struct sched_entity *curr = cfs_rq->curr;
 		unsigned long load;
 
@@ -9327,7 +9328,7 @@ static inline int task_is_ineligible_on_dst_cpu(struct task_struct *p, int dest_
 #else
 	dst_cfs_rq = &cpu_rq(dest_cpu)->cfs;
 #endif
-	if (sched_feat(PLACE_LAG) && dst_cfs_rq->nr_queued &&
+	if (sysctl_sched_place_lag_enabled && dst_cfs_rq->nr_queued &&
 	    !entity_eligible(task_cfs_rq(p), &p->se))
 		return 1;
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 3c12d9f93331..b98ec31ef2c4 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -1,10 +1,5 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 
-/*
- * Using the avg_vruntime, do the right thing and preserve lag across
- * sleep+wake cycles. EEVDF placement strategy #1, #2 if disabled.
- */
-SCHED_FEAT(PLACE_LAG, true)
 /*
  * Give new tasks half a slice to ease into the competition.
  */
@@ -13,11 +8,6 @@ SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
  * Preserve relative virtual deadline on 'migration'.
  */
 SCHED_FEAT(PLACE_REL_DEADLINE, true)
-/*
- * Inhibit (wakeup) preemption until the current task has either matched the
- * 0-lag point or until is has exhausted it's slice.
- */
-SCHED_FEAT(RUN_TO_PARITY, true)
 /*
  * Allow wakeup of tasks with a shorter slice to cancel RUN_TO_PARITY for
  * current.
diff --git a/kernel/sysctl.c b/kernel/sysctl.c
index 7ae7a4136855..11651d87f6d4 100644
--- a/kernel/sysctl.c
+++ b/kernel/sysctl.c
@@ -2019,6 +2019,26 @@ static struct ctl_table kern_table[] = {
 		.extra2		= SYSCTL_INT_MAX,
 	},
 #endif
+#ifdef CONFIG_SCHED_DEBUG
+	{
+		.procname	= "sched_place_lag_enabled",
+		.data		= &sysctl_sched_place_lag_enabled,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+	{
+		.procname	= "sched_run_to_parity_enabled",
+		.data		= &sysctl_sched_run_to_parity_enabled,
+		.maxlen		= sizeof(unsigned int),
+		.mode		= 0644,
+		.proc_handler	= proc_dointvec_minmax,
+		.extra1		= SYSCTL_ZERO,
+		.extra2		= SYSCTL_ONE,
+	},
+#endif
 };
 
 static struct ctl_table vm_table[] = {

base-commit: 05dbaf8dd8bf537d4b4eb3115ab42a5fb40ff1f5
-- 
2.48.1


