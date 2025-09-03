Return-Path: <linux-tip-commits+bounces-6423-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 50F98B417F3
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 10:07:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1B5374841B1
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 08:05:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECCF52EA499;
	Wed,  3 Sep 2025 08:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jqEiXZev";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jHnEHgjX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7A4B2E7BA3;
	Wed,  3 Sep 2025 08:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886718; cv=none; b=GHOFvAnlOVSs+tPNil/1DLxZo2Eks1qyZyJIFO8XjIzy3fZ2auB+LrtbxMVaZDHWR0JYM2x7RLAYvMgMfsgkMlpk6KYDWkiEMLxoo0O6QyI6/gPQ8j5bZYqi771Qym2w21ZRdBG9zZCDkp+PnPz2l/sZ4Axsi6oF02a9hxiq25o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886718; c=relaxed/simple;
	bh=9Et8SmKw6V8gyKv2iBr4JRilKGfrNMYykTTOwKIvj5o=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=dUei5DSe3pcCqiOSpBRq5uW5GJep2NFwFmKJ9aQXn1GBGM2f/z7BbI2MYrQHtF8NFYdG6Ai1PnfWfmYK+3BFC9xeiBd/pqJOgY5pBYoafhgy7/RvILzGF1xR39HOQ/ssu31sLkdf12PX58yDsLvhYIdQB1PQ6/0zexvNQT5pj48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jqEiXZev; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jHnEHgjX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Sep 2025 08:05:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756886714;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=RPfHmXeEJrQVQYdHwYAUkGCDrPFpSv7iHcIDspwWGO0=;
	b=jqEiXZevktpNFgX5XZeIUV3r+TLEXHY9sExI/FTrKOHu0nZax7jBQ3IqnL35Z5u7ONOoeh
	NUdsn9gunqGtXT1RGjChT4i7hZ0X1bBjDNPAzRbztievjAWRWj3puGMBBRUp1W4mxqXhSU
	WwYUpuMMeY9wMFztZbmivEscX55wXdQBzTetYI/+7zoXrg58iiPy3ZqSCDwxyEi38L3DCd
	xtGtw3pn+ookB4tAG9iXrt8P8azaZnUkApEghH/M43idVvFO/Budb+d+XJ1q3JACh41p1V
	aW1OT+LqXkSpnkrGNN9BcOpAAfKokIs2NP7hOb6pX4XPe0ggX/t3tdDzLENhXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756886714;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=RPfHmXeEJrQVQYdHwYAUkGCDrPFpSv7iHcIDspwWGO0=;
	b=jHnEHgjXy+x0OxF9QWVl6A/vwpoCE+G7FTEEVbT2x6xV5Lu5v6EcCDReISuBBrLkYMCd6v
	QMMg45RualEyVSDA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Move STDL_INIT() functions out-of-line
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175688671310.1920.15951303795128804682.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     91c614f09abf1d45aac6b475d82a36c704b527ee
Gitweb:        https://git.kernel.org/tip/91c614f09abf1d45aac6b475d82a36c704b=
527ee
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 26 Aug 2025 10:55:55 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 03 Sep 2025 10:03:13 +02:00

sched: Move STDL_INIT() functions out-of-line

Since all these functions are address-taken in SDTL_INIT() and called
indirectly, it doesn't really make sense for them to be inline.

Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 include/linux/sched/topology.h | 49 ++++-----------------------------
 kernel/sched/topology.c        | 45 ++++++++++++++++++++++++++++++-
 2 files changed, 52 insertions(+), 42 deletions(-)

diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index a3a24e1..bbcfdf1 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -33,56 +33,21 @@ extern const struct sd_flag_debug sd_flag_debug[];
 struct sched_domain_topology_level;
=20
 #ifdef CONFIG_SCHED_SMT
-static inline int cpu_smt_flags(void)
-{
-	return SD_SHARE_CPUCAPACITY | SD_SHARE_LLC;
-}
-
-static inline const
-struct cpumask *tl_smt_mask(struct sched_domain_topology_level *tl, int cpu)
-{
-	return cpu_smt_mask(cpu);
-}
+extern int cpu_smt_flags(void);
+extern const struct cpumask *tl_smt_mask(struct sched_domain_topology_level =
*tl, int cpu);
 #endif
=20
 #ifdef CONFIG_SCHED_CLUSTER
-static inline int cpu_cluster_flags(void)
-{
-	return SD_CLUSTER | SD_SHARE_LLC;
-}
-
-static inline const
-struct cpumask *tl_cls_mask(struct sched_domain_topology_level *tl, int cpu)
-{
-	return cpu_clustergroup_mask(cpu);
-}
+extern int cpu_cluster_flags(void);
+extern const struct cpumask *tl_cls_mask(struct sched_domain_topology_level =
*tl, int cpu);
 #endif
=20
 #ifdef CONFIG_SCHED_MC
-static inline int cpu_core_flags(void)
-{
-	return SD_SHARE_LLC;
-}
-
-static inline const
-struct cpumask *tl_mc_mask(struct sched_domain_topology_level *tl, int cpu)
-{
-	return cpu_coregroup_mask(cpu);
-}
+extern int cpu_core_flags(void);
+extern const struct cpumask *tl_mc_mask(struct sched_domain_topology_level *=
tl, int cpu);
 #endif
=20
-static inline const
-struct cpumask *tl_pkg_mask(struct sched_domain_topology_level *tl, int cpu)
-{
-	return cpu_node_mask(cpu);
-}
-
-#ifdef CONFIG_NUMA
-static inline int cpu_numa_flags(void)
-{
-	return SD_NUMA;
-}
-#endif
+extern const struct cpumask *tl_pkg_mask(struct sched_domain_topology_level =
*tl, int cpu);
=20
 extern int arch_asym_cpu_priority(int cpu);
=20
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 18889bd..1104d93 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1724,6 +1724,47 @@ sd_init(struct sched_domain_topology_level *tl,
 	return sd;
 }
=20
+#ifdef CONFIG_SCHED_SMT
+int cpu_smt_flags(void)
+{
+	return SD_SHARE_CPUCAPACITY | SD_SHARE_LLC;
+}
+
+const struct cpumask *tl_smt_mask(struct sched_domain_topology_level *tl, in=
t cpu)
+{
+	return cpu_smt_mask(cpu);
+}
+#endif
+
+#ifdef CONFIG_SCHED_CLUSTER
+int cpu_cluster_flags(void)
+{
+	return SD_CLUSTER | SD_SHARE_LLC;
+}
+
+const struct cpumask *tl_cls_mask(struct sched_domain_topology_level *tl, in=
t cpu)
+{
+	return cpu_clustergroup_mask(cpu);
+}
+#endif
+
+#ifdef CONFIG_SCHED_MC
+int cpu_core_flags(void)
+{
+	return SD_SHARE_LLC;
+}
+
+const struct cpumask *tl_mc_mask(struct sched_domain_topology_level *tl, int=
 cpu)
+{
+	return cpu_coregroup_mask(cpu);
+}
+#endif
+
+const struct cpumask *tl_pkg_mask(struct sched_domain_topology_level *tl, in=
t cpu)
+{
+	return cpu_node_mask(cpu);
+}
+
 /*
  * Topology list, bottom-up.
  */
@@ -1760,6 +1801,10 @@ void __init set_sched_topology(struct sched_domain_top=
ology_level *tl)
 }
=20
 #ifdef CONFIG_NUMA
+static int cpu_numa_flags(void)
+{
+	return SD_NUMA;
+}
=20
 static const struct cpumask *sd_numa_mask(struct sched_domain_topology_level=
 *tl, int cpu)
 {

