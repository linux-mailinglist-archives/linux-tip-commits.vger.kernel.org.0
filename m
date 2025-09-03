Return-Path: <linux-tip-commits+bounces-6427-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C5C7B417DB
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 10:06:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 82C414E4AA1
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 08:06:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6D842EBB9D;
	Wed,  3 Sep 2025 08:05:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LGxg0p97";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="H0Alduuo"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDDAF2EA468;
	Wed,  3 Sep 2025 08:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886721; cv=none; b=e0QwAvPgNTy0RSGl83cwCEWuwqgKIV0uNSfJ3r0QsqR7fe59QU/E8itaGse717xJ9nHgliF8ZbX3Jcft/lXlTAV+JMRUmvV8VGXufO7G4g3ahfGsF/LNVZqzWHa0D5KTaYt9hir70FH5ocC+bfU1r5J2RqXOMfGEowSZAbb+atY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886721; c=relaxed/simple;
	bh=WPpOnvivfX2k/PvAix92EWryXFSKamRwvRAcpQsReKQ=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=pfREJA/ZZeFvFSpt2+3253e+S81fRVFymRl82asW7W7aa+UcthkjhXMaBEZ8FNyL7QThkuPsb6+OGW5iPg8f1cjMlP1IHmcpmRwuelkvc4GQCvZfKbQNvd62qm6YtpL4V5YgrXxoq1SxIT24mT4mE1HRfF15VAwAjPUrr+MEDWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LGxg0p97; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=H0Alduuo; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Sep 2025 08:05:14 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756886715;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=bjPlNPEM84ha1Y2tGTN1A6SojpH7FRL+KjUd6CKcC4k=;
	b=LGxg0p97Q/JROfCOHHspq0OTf6wHLwID7GOm4CE7yQPtyQh73teVu72Q/nHl679RDAwj/h
	UVclflC0BpI7jF/59diQHpDL3S0myoT8wnOUyYGQvheDuP8cTSjEAFu/Vzo+SOVqQfaB+o
	MQHH8ohzmdWduzg5Es9eRunzFFugnBxRd1ILTanRkKW+VaDl7uEReMl8ypxSttxPJ+Zk5H
	3SONxv565vtSevolKxfRj5O4NXkRRPe3bxYFIiHygOTX3ya/vDtDEvAyoAdPe4NwOY5/xU
	CtYklm+2KWlf2tbSk3xmwK0mKHwgqSalq0UQ+SUDYQMS0Da+uiyCgm6sIIOdlA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756886715;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=bjPlNPEM84ha1Y2tGTN1A6SojpH7FRL+KjUd6CKcC4k=;
	b=H0AlduuoD8YoVNIir1eljDBGLxH6Gm6kq6VppEa0vphi/N+Xgnn5Uz+1Ntm/QG6RSumcDy
	w5LeTdk8NQ9Z2cAw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Get rid of sched_domains_curr_level
 hack for tl->cpumask()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Leon Romanovsky <leon@kernel.org>, K Prateek Nayak <kprateek.nayak@amd.com>,
 Valentin Schneider <vschneid@redhat.com>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175688671425.1920.13690753997160836570.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     661f951e371cc134ea31c84238dbdc9a898b8403
Gitweb:        https://git.kernel.org/tip/661f951e371cc134ea31c84238dbdc9a898=
b8403
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 25 Aug 2025 12:02:44=20
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 03 Sep 2025 10:03:12 +02:00

sched/fair: Get rid of sched_domains_curr_level hack for tl->cpumask()

Leon [1] and Vinicius [2] noted a topology_span_sane() warning during
their testing starting from v6.16-rc1. Debug that followed pointed to
the tl->mask() for the NODE domain being incorrectly resolved to that of
the highest NUMA domain.

tl->mask() for NODE is set to the sd_numa_mask() which depends on the
global "sched_domains_curr_level" hack. "sched_domains_curr_level" is
set to the "tl->numa_level" during tl traversal in build_sched_domains()
calling sd_init() but was not reset before topology_span_sane().

Since "tl->numa_level" still reflected the old value from
build_sched_domains(), topology_span_sane() for the NODE domain trips
when the span of the last NUMA domain overlaps.

Instead of replicating the "sched_domains_curr_level" hack, get rid of
it entirely and instead, pass the entire "sched_domain_topology_level"
object to tl->cpumask() function to prevent such mishap in the future.

sd_numa_mask() now directly references "tl->numa_level" instead of
relying on the global "sched_domains_curr_level" hack to index into
sched_domains_numa_masks[].

The original warning was reproducible on the following NUMA topology
reported by Leon:

    $ sudo numactl -H
    available: 5 nodes (0-4)
    node 0 cpus: 0 1
    node 0 size: 2927 MB
    node 0 free: 1603 MB
    node 1 cpus: 2 3
    node 1 size: 3023 MB
    node 1 free: 3008 MB
    node 2 cpus: 4 5
    node 2 size: 3023 MB
    node 2 free: 3007 MB
    node 3 cpus: 6 7
    node 3 size: 3023 MB
    node 3 free: 3002 MB
    node 4 cpus: 8 9
    node 4 size: 3022 MB
    node 4 free: 2718 MB
    node distances:
    node   0   1   2   3   4
      0:  10  39  38  37  36
      1:  39  10  38  37  36
      2:  38  38  10  37  36
      3:  37  37  37  10  36
      4:  36  36  36  36  10

The above topology can be mimicked using the following QEMU cmd that was
used to reproduce the warning and test the fix:

     sudo qemu-system-x86_64 -enable-kvm -cpu host \
     -m 20G -smp cpus=3D10,sockets=3D10 -machine q35 \
     -object memory-backend-ram,size=3D4G,id=3Dm0 \
     -object memory-backend-ram,size=3D4G,id=3Dm1 \
     -object memory-backend-ram,size=3D4G,id=3Dm2 \
     -object memory-backend-ram,size=3D4G,id=3Dm3 \
     -object memory-backend-ram,size=3D4G,id=3Dm4 \
     -numa node,cpus=3D0-1,memdev=3Dm0,nodeid=3D0 \
     -numa node,cpus=3D2-3,memdev=3Dm1,nodeid=3D1 \
     -numa node,cpus=3D4-5,memdev=3Dm2,nodeid=3D2 \
     -numa node,cpus=3D6-7,memdev=3Dm3,nodeid=3D3 \
     -numa node,cpus=3D8-9,memdev=3Dm4,nodeid=3D4 \
     -numa dist,src=3D0,dst=3D1,val=3D39 \
     -numa dist,src=3D0,dst=3D2,val=3D38 \
     -numa dist,src=3D0,dst=3D3,val=3D37 \
     -numa dist,src=3D0,dst=3D4,val=3D36 \
     -numa dist,src=3D1,dst=3D0,val=3D39 \
     -numa dist,src=3D1,dst=3D2,val=3D38 \
     -numa dist,src=3D1,dst=3D3,val=3D37 \
     -numa dist,src=3D1,dst=3D4,val=3D36 \
     -numa dist,src=3D2,dst=3D0,val=3D38 \
     -numa dist,src=3D2,dst=3D1,val=3D38 \
     -numa dist,src=3D2,dst=3D3,val=3D37 \
     -numa dist,src=3D2,dst=3D4,val=3D36 \
     -numa dist,src=3D3,dst=3D0,val=3D37 \
     -numa dist,src=3D3,dst=3D1,val=3D37 \
     -numa dist,src=3D3,dst=3D2,val=3D37 \
     -numa dist,src=3D3,dst=3D4,val=3D36 \
     -numa dist,src=3D4,dst=3D0,val=3D36 \
     -numa dist,src=3D4,dst=3D1,val=3D36 \
     -numa dist,src=3D4,dst=3D2,val=3D36 \
     -numa dist,src=3D4,dst=3D3,val=3D36 \
     ...

  [ prateek: Moved common functions to include/linux/sched/topology.h,
    reuse the common bits for s390 and ppc, commit message ]

Closes: https://lore.kernel.org/lkml/20250610110701.GA256154@unreal/ [1]
Fixes: ccf74128d66c ("sched/topology: Assert non-NUMA topology masks don't (p=
artially) overlap") # ce29a7da84cd, f55dac1dafb3
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reported-by: Leon Romanovsky <leon@kernel.org>
Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Tested-by: Valentin Schneider <vschneid@redhat.com> # x86
Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com> # powerpc
Link: https://lore.kernel.org/lkml/a3de98387abad28592e6ab591f3ff6107fe01dc1.1=
755893468.git.tim.c.chen@linux.intel.com/ [2]
---
 arch/powerpc/Kconfig                |  4 ++++-
 arch/powerpc/include/asm/topology.h |  2 ++-
 arch/powerpc/kernel/smp.c           | 27 +++++++++++----------------
 arch/s390/kernel/topology.c         | 20 +++++++-------------
 arch/x86/kernel/smpboot.c           |  8 ++++----
 include/linux/sched/topology.h      | 28 +++++++++++++++++++++++++++-
 include/linux/topology.h            |  2 +-
 kernel/sched/topology.c             | 28 ++++++++++------------------
 8 files changed, 66 insertions(+), 53 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 93402a1..e51a595 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -971,6 +971,10 @@ config SCHED_SMT
 	  when dealing with POWER5 cpus at a cost of slightly increased
 	  overhead in some places. If unsure say N here.
=20
+config SCHED_MC
+	def_bool y
+	depends on SMP
+
 config PPC_DENORMALISATION
 	bool "PowerPC denormalisation exception handling"
 	depends on PPC_BOOK3S_64
diff --git a/arch/powerpc/include/asm/topology.h b/arch/powerpc/include/asm/t=
opology.h
index da15b5e..f19ca44 100644
--- a/arch/powerpc/include/asm/topology.h
+++ b/arch/powerpc/include/asm/topology.h
@@ -131,6 +131,8 @@ static inline int cpu_to_coregroup_id(int cpu)
 #ifdef CONFIG_SMP
 #include <asm/cputable.h>
=20
+struct cpumask *cpu_coregroup_mask(int cpu);
+
 #ifdef CONFIG_PPC64
 #include <asm/smp.h>
=20
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index f59e4b9..68edb66 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1028,19 +1028,19 @@ static int powerpc_shared_proc_flags(void)
  * We can't just pass cpu_l2_cache_mask() directly because
  * returns a non-const pointer and the compiler barfs on that.
  */
-static const struct cpumask *shared_cache_mask(int cpu)
+static const struct cpumask *tl_cache_mask(struct sched_domain_topology_leve=
l *tl, int cpu)
 {
 	return per_cpu(cpu_l2_cache_map, cpu);
 }
=20
 #ifdef CONFIG_SCHED_SMT
-static const struct cpumask *smallcore_smt_mask(int cpu)
+static const struct cpumask *tl_smallcore_smt_mask(struct sched_domain_topol=
ogy_level *tl, int cpu)
 {
 	return cpu_smallcore_mask(cpu);
 }
 #endif
=20
-static struct cpumask *cpu_coregroup_mask(int cpu)
+struct cpumask *cpu_coregroup_mask(int cpu)
 {
 	return per_cpu(cpu_coregroup_map, cpu);
 }
@@ -1054,11 +1054,6 @@ static bool has_coregroup_support(void)
 	return coregroup_enabled;
 }
=20
-static const struct cpumask *cpu_mc_mask(int cpu)
-{
-	return cpu_coregroup_mask(cpu);
-}
-
 static int __init init_big_cores(void)
 {
 	int cpu;
@@ -1448,7 +1443,7 @@ static bool update_mask_by_l2(int cpu, cpumask_var_t *m=
ask)
 		return false;
 	}
=20
-	cpumask_and(*mask, cpu_online_mask, cpu_cpu_mask(cpu));
+	cpumask_and(*mask, cpu_online_mask, cpu_node_mask(cpu));
=20
 	/* Update l2-cache mask with all the CPUs that are part of submask */
 	or_cpumasks_related(cpu, cpu, submask_fn, cpu_l2_cache_mask);
@@ -1538,7 +1533,7 @@ static void update_coregroup_mask(int cpu, cpumask_var_=
t *mask)
 		return;
 	}
=20
-	cpumask_and(*mask, cpu_online_mask, cpu_cpu_mask(cpu));
+	cpumask_and(*mask, cpu_online_mask, cpu_node_mask(cpu));
=20
 	/* Update coregroup mask with all the CPUs that are part of submask */
 	or_cpumasks_related(cpu, cpu, submask_fn, cpu_coregroup_mask);
@@ -1601,7 +1596,7 @@ static void add_cpu_to_masks(int cpu)
=20
 	/* If chip_id is -1; limit the cpu_core_mask to within PKG */
 	if (chip_id =3D=3D -1)
-		cpumask_and(mask, mask, cpu_cpu_mask(cpu));
+		cpumask_and(mask, mask, cpu_node_mask(cpu));
=20
 	for_each_cpu(i, mask) {
 		if (chip_id =3D=3D cpu_to_chip_id(i)) {
@@ -1701,22 +1696,22 @@ static void __init build_sched_topology(void)
 	if (has_big_cores) {
 		pr_info("Big cores detected but using small core scheduling\n");
 		powerpc_topology[i++] =3D
-			SDTL_INIT(smallcore_smt_mask, powerpc_smt_flags, SMT);
+			SDTL_INIT(tl_smallcore_smt_mask, powerpc_smt_flags, SMT);
 	} else {
-		powerpc_topology[i++] =3D SDTL_INIT(cpu_smt_mask, powerpc_smt_flags, SMT);
+		powerpc_topology[i++] =3D SDTL_INIT(tl_smt_mask, powerpc_smt_flags, SMT);
 	}
 #endif
 	if (shared_caches) {
 		powerpc_topology[i++] =3D
-			SDTL_INIT(shared_cache_mask, powerpc_shared_cache_flags, CACHE);
+			SDTL_INIT(tl_cache_mask, powerpc_shared_cache_flags, CACHE);
 	}
=20
 	if (has_coregroup_support()) {
 		powerpc_topology[i++] =3D
-			SDTL_INIT(cpu_mc_mask, powerpc_shared_proc_flags, MC);
+			SDTL_INIT(tl_mc_mask, powerpc_shared_proc_flags, MC);
 	}
=20
-	powerpc_topology[i++] =3D SDTL_INIT(cpu_cpu_mask, powerpc_shared_proc_flags=
, PKG);
+	powerpc_topology[i++] =3D SDTL_INIT(tl_pkg_mask, powerpc_shared_proc_flags,=
 PKG);
=20
 	/* There must be one trailing NULL entry left.  */
 	BUG_ON(i >=3D ARRAY_SIZE(powerpc_topology) - 1);
diff --git a/arch/s390/kernel/topology.c b/arch/s390/kernel/topology.c
index 46569b8..1594c80 100644
--- a/arch/s390/kernel/topology.c
+++ b/arch/s390/kernel/topology.c
@@ -509,33 +509,27 @@ int topology_cpu_init(struct cpu *cpu)
 	return rc;
 }
=20
-static const struct cpumask *cpu_thread_mask(int cpu)
-{
-	return &cpu_topology[cpu].thread_mask;
-}
-
-
 const struct cpumask *cpu_coregroup_mask(int cpu)
 {
 	return &cpu_topology[cpu].core_mask;
 }
=20
-static const struct cpumask *cpu_book_mask(int cpu)
+static const struct cpumask *tl_book_mask(struct sched_domain_topology_level=
 *tl, int cpu)
 {
 	return &cpu_topology[cpu].book_mask;
 }
=20
-static const struct cpumask *cpu_drawer_mask(int cpu)
+static const struct cpumask *tl_drawer_mask(struct sched_domain_topology_lev=
el *tl, int cpu)
 {
 	return &cpu_topology[cpu].drawer_mask;
 }
=20
 static struct sched_domain_topology_level s390_topology[] =3D {
-	SDTL_INIT(cpu_thread_mask, cpu_smt_flags, SMT),
-	SDTL_INIT(cpu_coregroup_mask, cpu_core_flags, MC),
-	SDTL_INIT(cpu_book_mask, NULL, BOOK),
-	SDTL_INIT(cpu_drawer_mask, NULL, DRAWER),
-	SDTL_INIT(cpu_cpu_mask, NULL, PKG),
+	SDTL_INIT(tl_smt_mask, cpu_smt_flags, SMT),
+	SDTL_INIT(tl_mc_mask, cpu_core_flags, MC),
+	SDTL_INIT(tl_book_mask, NULL, BOOK),
+	SDTL_INIT(tl_drawer_mask, NULL, DRAWER),
+	SDTL_INIT(tl_pkg_mask, NULL, PKG),
 	{ NULL, },
 };
=20
diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
index 33e166f..eb289ab 100644
--- a/arch/x86/kernel/smpboot.c
+++ b/arch/x86/kernel/smpboot.c
@@ -479,14 +479,14 @@ static int x86_cluster_flags(void)
 static bool x86_has_numa_in_package;
=20
 static struct sched_domain_topology_level x86_topology[] =3D {
-	SDTL_INIT(cpu_smt_mask, cpu_smt_flags, SMT),
+	SDTL_INIT(tl_smt_mask, cpu_smt_flags, SMT),
 #ifdef CONFIG_SCHED_CLUSTER
-	SDTL_INIT(cpu_clustergroup_mask, x86_cluster_flags, CLS),
+	SDTL_INIT(tl_cls_mask, x86_cluster_flags, CLS),
 #endif
 #ifdef CONFIG_SCHED_MC
-	SDTL_INIT(cpu_coregroup_mask, x86_core_flags, MC),
+	SDTL_INIT(tl_mc_mask, x86_core_flags, MC),
 #endif
-	SDTL_INIT(cpu_cpu_mask, x86_sched_itmt_flags, PKG),
+	SDTL_INIT(tl_pkg_mask, x86_sched_itmt_flags, PKG),
 	{ NULL },
 };
=20
diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
index 5263746..a3a24e1 100644
--- a/include/linux/sched/topology.h
+++ b/include/linux/sched/topology.h
@@ -30,11 +30,19 @@ struct sd_flag_debug {
 };
 extern const struct sd_flag_debug sd_flag_debug[];
=20
+struct sched_domain_topology_level;
+
 #ifdef CONFIG_SCHED_SMT
 static inline int cpu_smt_flags(void)
 {
 	return SD_SHARE_CPUCAPACITY | SD_SHARE_LLC;
 }
+
+static inline const
+struct cpumask *tl_smt_mask(struct sched_domain_topology_level *tl, int cpu)
+{
+	return cpu_smt_mask(cpu);
+}
 #endif
=20
 #ifdef CONFIG_SCHED_CLUSTER
@@ -42,6 +50,12 @@ static inline int cpu_cluster_flags(void)
 {
 	return SD_CLUSTER | SD_SHARE_LLC;
 }
+
+static inline const
+struct cpumask *tl_cls_mask(struct sched_domain_topology_level *tl, int cpu)
+{
+	return cpu_clustergroup_mask(cpu);
+}
 #endif
=20
 #ifdef CONFIG_SCHED_MC
@@ -49,8 +63,20 @@ static inline int cpu_core_flags(void)
 {
 	return SD_SHARE_LLC;
 }
+
+static inline const
+struct cpumask *tl_mc_mask(struct sched_domain_topology_level *tl, int cpu)
+{
+	return cpu_coregroup_mask(cpu);
+}
 #endif
=20
+static inline const
+struct cpumask *tl_pkg_mask(struct sched_domain_topology_level *tl, int cpu)
+{
+	return cpu_node_mask(cpu);
+}
+
 #ifdef CONFIG_NUMA
 static inline int cpu_numa_flags(void)
 {
@@ -172,7 +198,7 @@ bool cpus_equal_capacity(int this_cpu, int that_cpu);
 bool cpus_share_cache(int this_cpu, int that_cpu);
 bool cpus_share_resources(int this_cpu, int that_cpu);
=20
-typedef const struct cpumask *(*sched_domain_mask_f)(int cpu);
+typedef const struct cpumask *(*sched_domain_mask_f)(struct sched_domain_top=
ology_level *tl, int cpu);
 typedef int (*sched_domain_flags_f)(void);
=20
 struct sd_data {
diff --git a/include/linux/topology.h b/include/linux/topology.h
index 33b7fda..6575af3 100644
--- a/include/linux/topology.h
+++ b/include/linux/topology.h
@@ -260,7 +260,7 @@ static inline bool topology_is_primary_thread(unsigned in=
t cpu)
=20
 #endif
=20
-static inline const struct cpumask *cpu_cpu_mask(int cpu)
+static inline const struct cpumask *cpu_node_mask(int cpu)
 {
 	return cpumask_of_node(cpu_to_node(cpu));
 }
diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
index 977e133..18889bd 100644
--- a/kernel/sched/topology.c
+++ b/kernel/sched/topology.c
@@ -1591,7 +1591,6 @@ static void claim_allocations(int cpu, struct sched_dom=
ain *sd)
 enum numa_topology_type sched_numa_topology_type;
=20
 static int			sched_domains_numa_levels;
-static int			sched_domains_curr_level;
=20
 int				sched_max_numa_distance;
 static int			*sched_domains_numa_distance;
@@ -1632,14 +1631,7 @@ sd_init(struct sched_domain_topology_level *tl,
 	int sd_id, sd_weight, sd_flags =3D 0;
 	struct cpumask *sd_span;
=20
-#ifdef CONFIG_NUMA
-	/*
-	 * Ugly hack to pass state to sd_numa_mask()...
-	 */
-	sched_domains_curr_level =3D tl->numa_level;
-#endif
-
-	sd_weight =3D cpumask_weight(tl->mask(cpu));
+	sd_weight =3D cpumask_weight(tl->mask(tl, cpu));
=20
 	if (tl->sd_flags)
 		sd_flags =3D (*tl->sd_flags)();
@@ -1677,7 +1669,7 @@ sd_init(struct sched_domain_topology_level *tl,
 	};
=20
 	sd_span =3D sched_domain_span(sd);
-	cpumask_and(sd_span, cpu_map, tl->mask(cpu));
+	cpumask_and(sd_span, cpu_map, tl->mask(tl, cpu));
 	sd_id =3D cpumask_first(sd_span);
=20
 	sd->flags |=3D asym_cpu_capacity_classify(sd_span, cpu_map);
@@ -1737,17 +1729,17 @@ sd_init(struct sched_domain_topology_level *tl,
  */
 static struct sched_domain_topology_level default_topology[] =3D {
 #ifdef CONFIG_SCHED_SMT
-	SDTL_INIT(cpu_smt_mask, cpu_smt_flags, SMT),
+	SDTL_INIT(tl_smt_mask, cpu_smt_flags, SMT),
 #endif
=20
 #ifdef CONFIG_SCHED_CLUSTER
-	SDTL_INIT(cpu_clustergroup_mask, cpu_cluster_flags, CLS),
+	SDTL_INIT(tl_cls_mask, cpu_cluster_flags, CLS),
 #endif
=20
 #ifdef CONFIG_SCHED_MC
-	SDTL_INIT(cpu_coregroup_mask, cpu_core_flags, MC),
+	SDTL_INIT(tl_mc_mask, cpu_core_flags, MC),
 #endif
-	SDTL_INIT(cpu_cpu_mask, NULL, PKG),
+	SDTL_INIT(tl_pkg_mask, NULL, PKG),
 	{ NULL, },
 };
=20
@@ -1769,9 +1761,9 @@ void __init set_sched_topology(struct sched_domain_topo=
logy_level *tl)
=20
 #ifdef CONFIG_NUMA
=20
-static const struct cpumask *sd_numa_mask(int cpu)
+static const struct cpumask *sd_numa_mask(struct sched_domain_topology_level=
 *tl, int cpu)
 {
-	return sched_domains_numa_masks[sched_domains_curr_level][cpu_to_node(cpu)];
+	return sched_domains_numa_masks[tl->numa_level][cpu_to_node(cpu)];
 }
=20
 static void sched_numa_warn(const char *str)
@@ -2411,7 +2403,7 @@ static bool topology_span_sane(const struct cpumask *cp=
u_map)
 		 * breaks the linking done for an earlier span.
 		 */
 		for_each_cpu(cpu, cpu_map) {
-			const struct cpumask *tl_cpu_mask =3D tl->mask(cpu);
+			const struct cpumask *tl_cpu_mask =3D tl->mask(tl, cpu);
 			int id;
=20
 			/* lowest bit set in this mask is used as a unique id */
@@ -2419,7 +2411,7 @@ static bool topology_span_sane(const struct cpumask *cp=
u_map)
=20
 			if (cpumask_test_cpu(id, id_seen)) {
 				/* First CPU has already been seen, ensure identical spans */
-				if (!cpumask_equal(tl->mask(id), tl_cpu_mask))
+				if (!cpumask_equal(tl->mask(tl, id), tl_cpu_mask))
 					return false;
 			} else {
 				/* First CPU hasn't been seen before, ensure it's a completely new span =
*/

