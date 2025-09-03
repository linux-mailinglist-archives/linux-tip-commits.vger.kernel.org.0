Return-Path: <linux-tip-commits+bounces-6425-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88C0EB417D9
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 10:06:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4681117C6D7
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 08:06:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 049242EAD05;
	Wed,  3 Sep 2025 08:05:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sz/otMrA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fyq41gMX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 554222E8E07;
	Wed,  3 Sep 2025 08:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756886719; cv=none; b=O7FRbjkKlUYSLirVP88ZuGoP+3FpMu/BzSttRZqicGVUoqAAZ/yt4zaFuuS7XemV9SVdjWlqhXldjobfEg2RciDXjfcVbVHLJvqt7XSl3or5ytwN3qgq2UTEvi9Kj+CID4ZHAAgO+2fJwUOwIsZVbNb7TtyAsncPUX1CqZQM9BQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756886719; c=relaxed/simple;
	bh=4YhC8zIt8CcgU1tfnLK0dalfMfV/h4S7Th0zLFF8/Yg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hvhufsvN4doyqVzBDxaVTHL3POrRT8mWuLwlWNjJG8v3NL3zL768jmFrBC/SyzWikbXcV70QA9PEgcBfj7p0OmyLfQABOyKy+CvTw98bhK3PwsTRkvaB141VKXdRr0QIIveDp46vW+0nirwAt7D/gY4jKZy+sw/lwtsyOI/gP4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sz/otMrA; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fyq41gMX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Sep 2025 08:05:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756886713;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hLohwcuC0CvIfNBBxPVH50xEQGWeoBXKhqOsjpK8PXc=;
	b=sz/otMrAAT6P/vD3vgKPsvd4vW0Je5t7zuKCLUll9soWUkQ2iMT+3NwoIVfA2RTgAgNRyw
	6HNrxj09MBw9Wwkhw9LJYsEn9u53koU4hfXMOkf6QbGRZSIHBXn39sNXHV/WV2XC791kcj
	w5kV2mdEgFRhs+HdAKLqA7xH6m1348TTkDIQrqh4ZxSSGVB6xMa8ugXDDjhNrBbuGEO1uI
	kJZWnPlNdj8i0hjkhr7/h9e563cSXTv4pCImyP6JZIXXy4bgvErAZD5TqoYGdmotJT0O/o
	X/3+PsTnE43Eqik6/yJbhN940OrWUID8+HV+RBAeJ9LlVx5q4rUV25Gi96xV8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756886713;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hLohwcuC0CvIfNBBxPVH50xEQGWeoBXKhqOsjpK8PXc=;
	b=Fyq41gMXqgsT9a+RWkWoOgwRwyO/4j1QU2r44FcKFRyeEiWzsaeG5jD5ijKZUjsgIu8KD/
	nmhmzi3rAc+iIfCQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Unify the SCHED_{SMT,CLUSTER,MC} Kconfig
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250826094358.GG3245006@noisy.programming.kicks-ass.net>
References: <20250826094358.GG3245006@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175688671194.1920.16730244977769185370.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     7bd291abe2da09f59dca81f35a4ec220e5e138a2
Gitweb:        https://git.kernel.org/tip/7bd291abe2da09f59dca81f35a4ec220e5e=
138a2
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 26 Aug 2025 11:08:57 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 03 Sep 2025 10:03:13 +02:00

sched: Unify the SCHED_{SMT,CLUSTER,MC} Kconfig

Like many Kconfig symbols, SCHED_{SMT,CLUSTER,MC} are duplicated
across arch/*/Kconfig. Try and clean up a little.

Suggested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Shrikanth Hegde <sshegde@linux.ibm.com>
Tested-by: Shrikanth Hegde <sshegde@linux.ibm.com> # powerpc
Link: https://lkml.kernel.org/r/20250826094358.GG3245006@noisy.programming.ki=
cks-ass.net
---
 arch/Kconfig           | 38 ++++++++++++++++++++++++++++++++++++++
 arch/arm/Kconfig       | 18 ++----------------
 arch/arm64/Kconfig     | 26 +++-----------------------
 arch/loongarch/Kconfig | 19 ++-----------------
 arch/mips/Kconfig      | 16 ++--------------
 arch/parisc/Kconfig    |  9 +--------
 arch/powerpc/Kconfig   | 15 +++------------
 arch/riscv/Kconfig     |  9 +--------
 arch/s390/Kconfig      |  8 ++------
 arch/sparc/Kconfig     | 20 ++------------------
 arch/x86/Kconfig       | 27 ++++-----------------------
 11 files changed, 60 insertions(+), 145 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index d1b4ffd..4466af4 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -41,6 +41,44 @@ config HOTPLUG_SMT
 config SMT_NUM_THREADS_DYNAMIC
 	bool
=20
+config ARCH_SUPPORTS_SCHED_SMT
+	bool
+
+config ARCH_SUPPORTS_SCHED_CLUSTER
+	bool
+
+config ARCH_SUPPORTS_SCHED_MC
+	bool
+
+config SCHED_SMT
+	bool "SMT (Hyperthreading) scheduler support"
+	depends on ARCH_SUPPORTS_SCHED_SMT
+	default y
+	help
+	  Improves the CPU scheduler's decision making when dealing with
+	  MultiThreading at a cost of slightly increased overhead in some
+	  places. If unsure say N here.
+
+config SCHED_CLUSTER
+	bool "Cluster scheduler support"
+	depends on ARCH_SUPPORTS_SCHED_CLUSTER
+	default y
+	help
+	  Cluster scheduler support improves the CPU scheduler's decision
+	  making when dealing with machines that have clusters of CPUs.
+	  Cluster usually means a couple of CPUs which are placed closely
+	  by sharing mid-level caches, last-level cache tags or internal
+	  busses.
+
+config SCHED_MC
+	bool "Multi-Core Cache (MC) scheduler support"
+	depends on ARCH_SUPPORTS_SCHED_MC
+	default y
+	help
+	  Multi-core scheduler support improves the CPU scheduler's decision
+	  making when dealing with multi-core CPU chips at a cost of slightly
+	  increased overhead in some places. If unsure say N here.
+
 # Selected by HOTPLUG_CORE_SYNC_DEAD or HOTPLUG_CORE_SYNC_FULL
 config HOTPLUG_CORE_SYNC
 	bool
diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index b1f3df3..d13422f 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -941,28 +941,14 @@ config IRQSTACKS
 config ARM_CPU_TOPOLOGY
 	bool "Support cpu topology definition"
 	depends on SMP && CPU_V7
+	select ARCH_SUPPORTS_SCHED_MC
+	select ARCH_SUPPORTS_SCHED_SMT
 	default y
 	help
 	  Support ARM cpu topology definition. The MPIDR register defines
 	  affinity between processors which is then used to describe the cpu
 	  topology of an ARM System.
=20
-config SCHED_MC
-	bool "Multi-core scheduler support"
-	depends on ARM_CPU_TOPOLOGY
-	help
-	  Multi-core scheduler support improves the CPU scheduler's decision
-	  making when dealing with multi-core CPU chips at a cost of slightly
-	  increased overhead in some places. If unsure say N here.
-
-config SCHED_SMT
-	bool "SMT scheduler support"
-	depends on ARM_CPU_TOPOLOGY
-	help
-	  Improves the CPU scheduler's decision making when dealing with
-	  MultiThreading at a cost of slightly increased overhead in some
-	  places. If unsure say N here.
-
 config HAVE_ARM_SCU
 	bool
 	help
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index e9bbfac..30733e0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -108,6 +108,9 @@ config ARM64
 	select ARCH_SUPPORTS_PER_VMA_LOCK
 	select ARCH_SUPPORTS_HUGE_PFNMAP if TRANSPARENT_HUGEPAGE
 	select ARCH_SUPPORTS_RT
+	select ARCH_SUPPORTS_SCHED_SMT
+	select ARCH_SUPPORTS_SCHED_CLUSTER
+	select ARCH_SUPPORTS_SCHED_MC
 	select ARCH_WANT_BATCHED_UNMAP_TLB_FLUSH
 	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
 	select ARCH_WANT_DEFAULT_BPF_JIT
@@ -1505,29 +1508,6 @@ config CPU_LITTLE_ENDIAN
=20
 endchoice
=20
-config SCHED_MC
-	bool "Multi-core scheduler support"
-	help
-	  Multi-core scheduler support improves the CPU scheduler's decision
-	  making when dealing with multi-core CPU chips at a cost of slightly
-	  increased overhead in some places. If unsure say N here.
-
-config SCHED_CLUSTER
-	bool "Cluster scheduler support"
-	help
-	  Cluster scheduler support improves the CPU scheduler's decision
-	  making when dealing with machines that have clusters of CPUs.
-	  Cluster usually means a couple of CPUs which are placed closely
-	  by sharing mid-level caches, last-level cache tags or internal
-	  busses.
-
-config SCHED_SMT
-	bool "SMT scheduler support"
-	help
-	  Improves the CPU scheduler's decision making when dealing with
-	  MultiThreading at a cost of slightly increased overhead in some
-	  places. If unsure say N here.
-
 config NR_CPUS
 	int "Maximum number of CPUs (2-4096)"
 	range 2 4096
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index f0abc38..d1c8cb3 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -70,6 +70,8 @@ config LOONGARCH
 	select ARCH_SUPPORTS_MSEAL_SYSTEM_MAPPINGS
 	select ARCH_SUPPORTS_NUMA_BALANCING
 	select ARCH_SUPPORTS_RT
+	select ARCH_SUPPORTS_SCHED_SMT if SMP
+	select ARCH_SUPPORTS_SCHED_MC  if SMP
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF
 	select ARCH_USE_MEMTEST
@@ -448,23 +450,6 @@ config EFI_STUB
 	  This kernel feature allows the kernel to be loaded directly by
 	  EFI firmware without the use of a bootloader.
=20
-config SCHED_SMT
-	bool "SMT scheduler support"
-	depends on SMP
-	default y
-	help
-	  Improves scheduler's performance when there are multiple
-	  threads in one physical core.
-
-config SCHED_MC
-	bool "Multi-core scheduler support"
-	depends on SMP
-	default y
-	help
-	  Multi-core scheduler support improves the CPU scheduler's decision
-	  making when dealing with multi-core CPU chips at a cost of slightly
-	  increased overhead in some places.
-
 config SMP
 	bool "Multi-Processing support"
 	help
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index caf508f..447b2fc 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2223,7 +2223,7 @@ config MIPS_MT_SMP
 	select SMP
 	select SMP_UP
 	select SYS_SUPPORTS_SMP
-	select SYS_SUPPORTS_SCHED_SMT
+	select ARCH_SUPPORTS_SCHED_SMT
 	select MIPS_PERF_SHARED_TC_COUNTERS
 	help
 	  This is a kernel model which is known as SMVP. This is supported
@@ -2235,18 +2235,6 @@ config MIPS_MT_SMP
 config MIPS_MT
 	bool
=20
-config SCHED_SMT
-	bool "SMT (multithreading) scheduler support"
-	depends on SYS_SUPPORTS_SCHED_SMT
-	default n
-	help
-	  SMT scheduler support improves the CPU scheduler's decision making
-	  when dealing with MIPS MT enabled cores at a cost of slightly
-	  increased overhead in some places. If unsure say N here.
-
-config SYS_SUPPORTS_SCHED_SMT
-	bool
-
 config SYS_SUPPORTS_MULTITHREADING
 	bool
=20
@@ -2318,7 +2306,7 @@ config MIPS_CPS
 	select HOTPLUG_CORE_SYNC_DEAD if HOTPLUG_CPU
 	select SYNC_R4K if (CEVT_R4K || CSRC_R4K)
 	select SYS_SUPPORTS_HOTPLUG_CPU
-	select SYS_SUPPORTS_SCHED_SMT if CPU_MIPSR6
+	select ARCH_SUPPORTS_SCHED_SMT if CPU_MIPSR6
 	select SYS_SUPPORTS_SMP
 	select WEAK_ORDERING
 	select GENERIC_IRQ_MIGRATION if HOTPLUG_CPU
diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
index 2efa4b0..0940c16 100644
--- a/arch/parisc/Kconfig
+++ b/arch/parisc/Kconfig
@@ -44,6 +44,7 @@ config PARISC
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_ARCH_TOPOLOGY if SMP
+	select ARCH_SUPPORTS_SCHED_MC if SMP && PA8X00
 	select GENERIC_CPU_DEVICES if !SMP
 	select GENERIC_LIB_DEVMEM_IS_ALLOWED
 	select SYSCTL_ARCH_UNALIGN_ALLOW
@@ -319,14 +320,6 @@ config SMP
=20
 	  If you don't know what to do here, say N.
=20
-config SCHED_MC
-	bool "Multi-core scheduler support"
-	depends on GENERIC_ARCH_TOPOLOGY && PA8X00
-	help
-	  Multi-core scheduler support improves the CPU scheduler's decision
-	  making when dealing with multi-core CPU chips at a cost of slightly
-	  increased overhead in some places. If unsure say N here.
-
 config IRQSTACKS
 	bool "Use separate kernel stacks when processing interrupts"
 	default y
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e51a595..f87d169 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -170,6 +170,9 @@ config PPC
 	select ARCH_STACKWALK
 	select ARCH_SUPPORTS_ATOMIC_RMW
 	select ARCH_SUPPORTS_DEBUG_PAGEALLOC	if PPC_BOOK3S || PPC_8xx
+	select ARCH_SUPPORTS_SCHED_MC		if SMP
+	select ARCH_SUPPORTS_SCHED_SMT		if PPC64 && SMP
+	select SCHED_MC				if ARCH_SUPPORTS_SCHED_MC
 	select ARCH_USE_BUILTIN_BSWAP
 	select ARCH_USE_CMPXCHG_LOCKREF		if PPC64
 	select ARCH_USE_MEMTEST
@@ -963,18 +966,6 @@ config PPC_PROT_SAO_LPAR
 config PPC_COPRO_BASE
 	bool
=20
-config SCHED_SMT
-	bool "SMT (Hyperthreading) scheduler support"
-	depends on PPC64 && SMP
-	help
-	  SMT scheduler support improves the CPU scheduler's decision making
-	  when dealing with POWER5 cpus at a cost of slightly increased
-	  overhead in some places. If unsure say N here.
-
-config SCHED_MC
-	def_bool y
-	depends on SMP
-
 config PPC_DENORMALISATION
 	bool "PowerPC denormalisation exception handling"
 	depends on PPC_BOOK3S_64
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index a4b233a..2a08e06 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -72,6 +72,7 @@ config RISCV
 	select ARCH_SUPPORTS_PER_VMA_LOCK if MMU
 	select ARCH_SUPPORTS_RT
 	select ARCH_SUPPORTS_SHADOW_CALL_STACK if HAVE_SHADOW_CALL_STACK
+	select ARCH_SUPPORTS_SCHED_MC if SMP
 	select ARCH_USE_CMPXCHG_LOCKREF if 64BIT
 	select ARCH_USE_MEMTEST
 	select ARCH_USE_QUEUED_RWLOCKS
@@ -453,14 +454,6 @@ config SMP
=20
 	  If you don't know what to do here, say N.
=20
-config SCHED_MC
-	bool "Multi-core scheduler support"
-	depends on SMP
-	help
-	  Multi-core scheduler support improves the CPU scheduler's decision
-	  making when dealing with multi-core CPU chips at a cost of slightly
-	  increased overhead in some places. If unsure say N here.
-
 config NR_CPUS
 	int "Maximum number of CPUs (2-512)"
 	depends on SMP
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index bf680c2..87ddd49 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -547,15 +547,11 @@ config NODES_SHIFT
 	depends on NUMA
 	default "1"
=20
-config SCHED_SMT
-	def_bool n
-
-config SCHED_MC
-	def_bool n
-
 config SCHED_TOPOLOGY
 	def_bool y
 	prompt "Topology scheduler support"
+	select ARCH_SUPPORTS_SCHED_SMT
+	select ARCH_SUPPORTS_SCHED_MC
 	select SCHED_SMT
 	select SCHED_MC
 	help
diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index 7b59509..a630d37 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -110,6 +110,8 @@ config SPARC64
 	select HAVE_SETUP_PER_CPU_AREA
 	select NEED_PER_CPU_EMBED_FIRST_CHUNK
 	select NEED_PER_CPU_PAGE_FIRST_CHUNK
+	select ARCH_SUPPORTS_SCHED_SMT if SMP
+	select ARCH_SUPPORTS_SCHED_MC  if SMP
=20
 config ARCH_PROC_KCORE_TEXT
 	def_bool y
@@ -288,24 +290,6 @@ if SPARC64 || COMPILE_TEST
 source "kernel/power/Kconfig"
 endif
=20
-config SCHED_SMT
-	bool "SMT (Hyperthreading) scheduler support"
-	depends on SPARC64 && SMP
-	default y
-	help
-	  SMT scheduler support improves the CPU scheduler's decision making
-	  when dealing with SPARC cpus at a cost of slightly increased overhead
-	  in some places. If unsure say N here.
-
-config SCHED_MC
-	bool "Multi-core scheduler support"
-	depends on SPARC64 && SMP
-	default y
-	help
-	  Multi-core scheduler support improves the CPU scheduler's decision
-	  making when dealing with multi-core CPU chips at a cost of slightly
-	  increased overhead in some places. If unsure say N here.
-
 config CMDLINE_BOOL
 	bool "Default bootloader kernel arguments"
 	depends on SPARC64
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 58d890f..c8df032 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -330,6 +330,10 @@ config X86
 	imply IMA_SECURE_AND_OR_TRUSTED_BOOT    if EFI
 	select HAVE_DYNAMIC_FTRACE_NO_PATCHABLE
 	select ARCH_SUPPORTS_PT_RECLAIM		if X86_64
+	select ARCH_SUPPORTS_SCHED_SMT		if SMP
+	select SCHED_SMT			if SMP
+	select ARCH_SUPPORTS_SCHED_CLUSTER	if SMP
+	select ARCH_SUPPORTS_SCHED_MC		if SMP
=20
 config INSTRUCTION_DECODER
 	def_bool y
@@ -1031,29 +1035,6 @@ config NR_CPUS
 	  This is purely to save memory: each supported CPU adds about 8KB
 	  to the kernel image.
=20
-config SCHED_CLUSTER
-	bool "Cluster scheduler support"
-	depends on SMP
-	default y
-	help
-	  Cluster scheduler support improves the CPU scheduler's decision
-	  making when dealing with machines that have clusters of CPUs.
-	  Cluster usually means a couple of CPUs which are placed closely
-	  by sharing mid-level caches, last-level cache tags or internal
-	  busses.
-
-config SCHED_SMT
-	def_bool y if SMP
-
-config SCHED_MC
-	def_bool y
-	prompt "Multi-core scheduler support"
-	depends on SMP
-	help
-	  Multi-core scheduler support improves the CPU scheduler's decision
-	  making when dealing with multi-core CPU chips at a cost of slightly
-	  increased overhead in some places. If unsure say N here.
-
 config SCHED_MC_PRIO
 	bool "CPU core priorities scheduler support"
 	depends on SCHED_MC

