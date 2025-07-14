Return-Path: <linux-tip-commits+bounces-6106-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4833EB03A6B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Jul 2025 11:11:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A1A517A881
	for <lists+linux-tip-commits@lfdr.de>; Mon, 14 Jul 2025 09:11:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC01A2417FB;
	Mon, 14 Jul 2025 09:10:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HesnJiWy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o1Lbdvgp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CB223ED56;
	Mon, 14 Jul 2025 09:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752484243; cv=none; b=X1YCReey2WRcB0YKpNv71DpbJHZP5e3ZCYg12on4XA4EOQoBtr653fGVxlRtjOyAdARf3oINd7W6i+WiAtwMBjuOWhy2nlL7BcO7b9GjityfZxSUCWFaVrjVxZ7YYhzfIDeTVYEDbdBS3O3VV6eKfTltr+eOTrTVBQWi6iPBvVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752484243; c=relaxed/simple;
	bh=HTkIMRuzDlg+r3In8mM20aOZtJw8WmQibBVjE6mvJYs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ci/C/8cEygJNh2eQoFi1eP6qJfY1ABDijwFcLN+9LSUNPB7oTHEgT8oY4eecaA5tMCv3eTFcMdQXtV/5nwQ/wju9bVhr8AQmazCGtCN16JZa09ZO3EqkOE62VBUxWJsoMM4WwwTtINI/zk9UZiuXgZGihjNesfJmKFEPGf/IkuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HesnJiWy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o1Lbdvgp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 14 Jul 2025 09:10:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752484239;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AVfapIxhmSQoTH55dPybsl9qFiCLG21sq+6VfAByfhM=;
	b=HesnJiWyiDWssLmBEfscytN82whXiWR148o5Wkku4SvOQBoRfYgYitRaKzU5Hr8iYlATS5
	86mYrAp3wtX9qKGaEVMbOK8/P0FvA+iIjz40vja+02lvIiHMIAapluPbETeEPQc0Q4r8lX
	HpthRnUWpPqPtoKa1RQlhNvJijBALCXY2VzwPM4RYRyKbYJBs1U6Ou9mhyzFwp2He6ZPCu
	DWWszlidBafYBKBBnNzSjcfxaM+Rp+B2Nb61gInYKIauPM6JCX7lyIEWBbW9eplK21Zaqv
	Xnk39pmNZwxw+u8ueGu8iBF4lipibjw2i2Zj1c8jmj390yNOxMe9omW6rktI7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752484239;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AVfapIxhmSQoTH55dPybsl9qFiCLG21sq+6VfAByfhM=;
	b=o1Lbdvgp9EAH2+wJIuGPegr9sab/WNU4RyUbHvBgPibxN2cuI39i5dovJTXO1wHzPDUXZB
	ZEal8ZLvhnOcgRDA==
From: "tip-bot2 for Li Chen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] smpboot: introduce SDTL_INIT() helper to tidy sched
 topology setup
Cc: Thomas Gleixner <tglx@linutronix.de>, Li Chen <chenl311@chinatelecom.cn>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 K Prateek Nayak <kprateek.nayak@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250710105715.66594-2-me@linux.beauty>
References: <20250710105715.66594-2-me@linux.beauty>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175248423817.406.17248869851939778845.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e075f4360931263f5ec006ea5dadc065e5e98eb8
Gitweb:        https://git.kernel.org/tip/e075f4360931263f5ec006ea5dadc065e5e98eb8
Author:        Li Chen <chenl311@chinatelecom.cn>
AuthorDate:    Thu, 10 Jul 2025 18:57:07 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 14 Jul 2025 10:59:34 +02:00

smpboot: introduce SDTL_INIT() helper to tidy sched topology setup

Define a small SDTL_INIT(maskfn, flagsfn, name) macro and use it to build the
sched_domain_topology_level array. Purely a cleanup; behaviour is unchanged.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Li Chen <chenl311@chinatelecom.cn>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Tested-by: K Prateek Nayak <kprateek.nayak@amd.com>
Link: https://lore.kernel.org/r/20250710105715.66594-2-me@linux.beauty
---
 arch/powerpc/kernel/smp.c      | 25 ++++++++++---------------
 arch/s390/kernel/topology.c    | 10 +++++-----
 arch/x86/kernel/smpboot.c      | 21 ++++++---------------
 include/linux/sched/topology.h |  4 ++--
 kernel/sched/topology.c        | 24 ++++++++----------------
 5 files changed, 31 insertions(+), 53 deletions(-)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 5ac7084..f59e4b9 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1700,28 +1700,23 @@ static void __init build_sched_topology(void)
 #ifdef CONFIG_SCHED_SMT
 	if (has_big_cores) {
 		pr_info("Big cores detected but using small core scheduling\n");
-		powerpc_topology[i++] = (struct sched_domain_topology_level){
-			smallcore_smt_mask, powerpc_smt_flags, SD_INIT_NAME(SMT)
-		};
+		powerpc_topology[i++] =
+			SDTL_INIT(smallcore_smt_mask, powerpc_smt_flags, SMT);
 	} else {
-		powerpc_topology[i++] = (struct sched_domain_topology_level){
-			cpu_smt_mask, powerpc_smt_flags, SD_INIT_NAME(SMT)
-		};
+		powerpc_topology[i++] = SDTL_INIT(cpu_smt_mask, powerpc_smt_flags, SMT);
 	}
 #endif
 	if (shared_caches) {
-		powerpc_topology[i++] = (struct sched_domain_topology_level){
-			shared_cache_mask, powerpc_shared_cache_flags, SD_INIT_NAME(CACHE)
-		};
+		powerpc_topology[i++] =
+			SDTL_INIT(shared_cache_mask, powerpc_shared_cache_flags, CACHE);
 	}
+
 	if (has_coregroup_support()) {
-		powerpc_topology[i++] = (struct sched_domain_topology_level){
-			cpu_mc_mask, powerpc_shared_proc_flags, SD_INIT_NAME(MC)
-		};
+		powerpc_topology[i++] =
+			SDTL_INIT(cpu_mc_mask, powerpc_shared_proc_flags, MC);
 	}
-	powerpc_topology[i++] = (struct sched_domain_topology_level){
-		cpu_cpu_mask, powerpc_shared_proc_flags, SD_INIT_NAME(PKG)
-	};
+
+	powerpc_topology[i++] = SDTL_INIT(cpu_cpu_mask, powerpc_shared_proc_flags, PKG);
 
 	/* There must be one trailing NULL entry left.  */
 	BUG_ON(i >= ARRAY_SIZE(powerpc_topology) - 1);
diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index 3df048e..46569b8 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -531,11 +531,11 @@ static const struct cpumask *cpu_drawer_mask(int cpu)
 }
 
 static struct sched_domain_topology_level s390_topology[] = {
-	{ cpu_thread_mask, cpu_smt_flags, SD_INIT_NAME(SMT) },
-	{ cpu_coregroup_mask, cpu_core_flags, SD_INIT_NAME(MC) },
-	{ cpu_book_mask, SD_INIT_NAME(BOOK) },
-	{ cpu_drawer_mask, SD_INIT_NAME(DRAWER) },
-	{ cpu_cpu_mask, SD_INIT_NAME(PKG) },
+	SDTL_INIT(cpu_thread_mask, cpu_smt_flags, SMT),
+	SDTL_INIT(cpu_coregroup_mask, cpu_core_flags, MC),
+	SDTL_INIT(cpu_book_mask, NULL, BOOK),
+	SDTL_INIT(cpu_drawer_mask, NULL, DRAWER),
+	SDTL_INIT(cpu_cpu_mask, NULL, PKG),
 	{ NULL, },
 };
 
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index fc78c23..e0adf75 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -485,35 +485,26 @@ static void __init build_sched_topology(void)
 	int i = 0;
 
 #ifdef CONFIG_SCHED_SMT
-	x86_topology[i++] = (struct sched_domain_topology_level){
-		cpu_smt_mask, cpu_smt_flags, SD_INIT_NAME(SMT)
-	};
+	x86_topology[i++] = SDTL_INIT(cpu_smt_mask, cpu_smt_flags, SMT);
 #endif
 #ifdef CONFIG_SCHED_CLUSTER
-	x86_topology[i++] = (struct sched_domain_topology_level){
-		cpu_clustergroup_mask, x86_cluster_flags, SD_INIT_NAME(CLS)
-	};
+	x86_topology[i++] = SDTL_INIT(cpu_clustergroup_mask, x86_cluster_flags, CLS);
 #endif
 #ifdef CONFIG_SCHED_MC
-	x86_topology[i++] = (struct sched_domain_topology_level){
-		cpu_coregroup_mask, x86_core_flags, SD_INIT_NAME(MC)
-	};
+	x86_topology[i++] = SDTL_INIT(cpu_coregroup_mask, x86_core_flags, MC);
 #endif
 	/*
 	 * When there is NUMA topology inside the package skip the PKG domain
 	 * since the NUMA domains will auto-magically create the right spanning
 	 * domains based on the SLIT.
 	 */
-	if (!x86_has_numa_in_package) {
-		x86_topology[i++] = (struct sched_domain_topology_level){
-			cpu_cpu_mask, x86_sched_itmt_flags, SD_INIT_NAME(PKG)
-		};
-	}
+	if (!x86_has_numa_in_package)
+		x86_topology[i++] = SDTL_INIT(cpu_cpu_mask, x86_sched_itmt_flags, PKG);
 
 	/*
 	 * There must be one trailing NULL entry left.
 	 */
-	BUG_ON(i >= ARRAY_SIZE(x86_topology)-1);
+	BUG_ON(i >= ARRAY_SIZE(x86_topology) - 1);
 
 	set_sched_topology(x86_topology);
 }
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index e54e7fa..0d5daaa 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -196,8 +196,8 @@ struct sched_domain_topology_level {
 extern void __init set_sched_topology(struct sched_domain_topology_level *tl);
 extern void sched_update_asym_prefer_cpu(int cpu, int old_prio, int new_prio);
 
-
-# define SD_INIT_NAME(type)		.name = #type
+#define SDTL_INIT(maskfn, flagsfn, dname) ((struct sched_domain_topology_level) \
+	    { .mask = maskfn, .sd_flags = flagsfn, .name = #dname })
 
 #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
 extern void rebuild_sched_domains_energy(void);
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 8e06b1d..d01f5a4 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1737,17 +1737,17 @@ sd_init(struct sched_domain_topology_level *tl,
  */
 static struct sched_domain_topology_level default_topology[] = {
 #ifdef CONFIG_SCHED_SMT
-	{ cpu_smt_mask, cpu_smt_flags, SD_INIT_NAME(SMT) },
+	SDTL_INIT(cpu_smt_mask, cpu_smt_flags, SMT),
 #endif
 
 #ifdef CONFIG_SCHED_CLUSTER
-	{ cpu_clustergroup_mask, cpu_cluster_flags, SD_INIT_NAME(CLS) },
+	SDTL_INIT(cpu_clustergroup_mask, cpu_cluster_flags, CLS),
 #endif
 
 #ifdef CONFIG_SCHED_MC
-	{ cpu_coregroup_mask, cpu_core_flags, SD_INIT_NAME(MC) },
+	SDTL_INIT(cpu_coregroup_mask, cpu_core_flags, MC),
 #endif
-	{ cpu_cpu_mask, SD_INIT_NAME(PKG) },
+	SDTL_INIT(cpu_cpu_mask, NULL, PKG),
 	{ NULL, },
 };
 
@@ -2008,23 +2008,15 @@ void sched_init_numa(int offline_node)
 	/*
 	 * Add the NUMA identity distance, aka single NODE.
 	 */
-	tl[i++] = (struct sched_domain_topology_level){
-		.mask = sd_numa_mask,
-		.numa_level = 0,
-		SD_INIT_NAME(NODE)
-	};
+	tl[i++] = SDTL_INIT(sd_numa_mask, NULL, NODE);
 
 	/*
 	 * .. and append 'j' levels of NUMA goodness.
 	 */
 	for (j = 1; j < nr_levels; i++, j++) {
-		tl[i] = (struct sched_domain_topology_level){
-			.mask = sd_numa_mask,
-			.sd_flags = cpu_numa_flags,
-			.flags = SDTL_OVERLAP,
-			.numa_level = j,
-			SD_INIT_NAME(NUMA)
-		};
+		tl[i] = SDTL_INIT(sd_numa_mask, cpu_numa_flags, NUMA);
+		tl[i].numa_level = j;
+		tl[i].flags = SDTL_OVERLAP;
 	}
 
 	sched_domain_topology_saved = sched_domain_topology;

