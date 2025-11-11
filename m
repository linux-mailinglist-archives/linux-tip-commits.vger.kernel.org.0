Return-Path: <linux-tip-commits+bounces-7287-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE95C4D71E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 12:41:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 96D2B4F6D2C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Nov 2025 11:37:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34B06358D00;
	Tue, 11 Nov 2025 11:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="poHyL2X+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cDnNfW4X"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E2503587B1;
	Tue, 11 Nov 2025 11:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762861029; cv=none; b=OGj4Ar0AF9nnA1ULLGp6vU5dTOT+MRdJDCyceHqLCetwXGf+JKRSHPqauo+GAjYqv1GXkOpqAJ5KiD5RIUQvp0fVePz05YG41iK/oDiBCSV7KFftpwC3x50tgD4vNeyZA16p1/v9wQUW6BdX3x4jv874ormZXBsTZwnVsIOBYTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762861029; c=relaxed/simple;
	bh=Ps2/XP22Xw1qcoUirFC7ZqZFxaUPiCyzMZWxzmjZuqM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=mr4K5nzP38h9YWDt8QFYNjXYUjUdCq0tZMIveSrjTQyMGh27A7uPUJzm7CaFScNXA0Hcq5GGEVgtaqV3QlmiBDsvO/RG9jcc5u/YGDs2H6NBftdDLEnWkj8BMyDMi2ZHNaxQ0/B/D5yIHIjQMbMh197l3PpD1aBXy513uOG9MPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=poHyL2X+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cDnNfW4X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Nov 2025 11:37:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762861024;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4wJJro1uEE74vFDbgA5mHeb5bgjk15bqCRT1eG+0aWc=;
	b=poHyL2X+skF1frWhy37+bEp9Z/Ot0MYe0iYgDPkrVNUnHomdY+Z9UJYrT5JcfnP/RSR7cw
	lto5hvYDdIw/03uvAb0s5VHocT8QPkEXi+Er1RVva84rMc78EOEw5Vzjdl7NJMt7ZBNOvx
	zpshE8oeWb1Q/6Lp5M0syJvA8c/GRq0Fs5OsYH/ngZTzGCZJRsn+LL9F6A24lyHyd2JF+X
	TeEj+7yB30RZ/OBtoTvCf374ZQhcnDG6DbXNeKv4aBnduLSkuABcaEKc+knqn4e3LSs23P
	EUa3IyvTdSUNJlxrkGS3gsuj4e7O1cV8hjBH5nZQLLyJRRo1CJenE4mtbOpJQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762861024;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4wJJro1uEE74vFDbgA5mHeb5bgjk15bqCRT1eG+0aWc=;
	b=cDnNfW4XJ8RgmLjSfBoMkVsxTamnLYduIXUxDHDTOGy+PMWvRXLsDI0qyZrBckU6sZ90AJ
	6U6nk9xp2UMYB/AQ==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Allocate arch-PEBS buffer and
 initialize PEBS_BASE MSR
Cc: Kan Liang <kan.liang@linux.intel.com>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251029102136.61364-10-dapeng1.mi@linux.intel.com>
References: <20251029102136.61364-10-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176286102319.498.6733163094005217001.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2721e8da2de7271533ac36285332219f700d16ca
Gitweb:        https://git.kernel.org/tip/2721e8da2de7271533ac36285332219f700=
d16ca
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Wed, 29 Oct 2025 18:21:33 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 07 Nov 2025 15:08:22 +01:00

perf/x86/intel: Allocate arch-PEBS buffer and initialize PEBS_BASE MSR

Arch-PEBS introduces a new MSR IA32_PEBS_BASE to store the arch-PEBS
buffer physical address. This patch allocates arch-PEBS buffer and then
initialize IA32_PEBS_BASE MSR with the buffer physical address.

Co-developed-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://patch.msgid.link/20251029102136.61364-10-dapeng1.mi@linux.intel=
.com
---
 arch/x86/events/intel/core.c    | 11 +++-
 arch/x86/events/intel/ds.c      | 82 +++++++++++++++++++++++++++-----
 arch/x86/events/perf_event.h    | 11 +++-
 arch/x86/include/asm/intel_ds.h |  3 +-
 4 files changed, 92 insertions(+), 15 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index de4dbde..6e04d73 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5227,7 +5227,13 @@ err:
=20
 static int intel_pmu_cpu_prepare(int cpu)
 {
-	return intel_cpuc_prepare(&per_cpu(cpu_hw_events, cpu), cpu);
+	int ret;
+
+	ret =3D intel_cpuc_prepare(&per_cpu(cpu_hw_events, cpu), cpu);
+	if (ret)
+		return ret;
+
+	return alloc_arch_pebs_buf_on_cpu(cpu);
 }
=20
 static void flip_smm_bit(void *data)
@@ -5458,6 +5464,7 @@ static void intel_pmu_cpu_starting(int cpu)
 		return;
=20
 	init_debug_store_on_cpu(cpu);
+	init_arch_pebs_on_cpu(cpu);
 	/*
 	 * Deal with CPUs that don't clear their LBRs on power-up, and that may
 	 * even boot with LBRs enabled.
@@ -5555,6 +5562,7 @@ static void free_excl_cntrs(struct cpu_hw_events *cpuc)
 static void intel_pmu_cpu_dying(int cpu)
 {
 	fini_debug_store_on_cpu(cpu);
+	fini_arch_pebs_on_cpu(cpu);
 }
=20
 void intel_cpuc_finish(struct cpu_hw_events *cpuc)
@@ -5575,6 +5583,7 @@ static void intel_pmu_cpu_dead(int cpu)
 {
 	struct cpu_hw_events *cpuc =3D &per_cpu(cpu_hw_events, cpu);
=20
+	release_arch_pebs_buf_on_cpu(cpu);
 	intel_cpuc_finish(cpuc);
=20
 	if (is_hybrid() && cpuc->pmu)
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index fe1bf37..5c26a52 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -625,13 +625,18 @@ static int alloc_pebs_buffer(int cpu)
 	int max, node =3D cpu_to_node(cpu);
 	void *buffer, *insn_buff, *cea;
=20
-	if (!x86_pmu.ds_pebs)
+	if (!intel_pmu_has_pebs())
 		return 0;
=20
 	buffer =3D dsalloc_pages(bsiz, GFP_KERNEL, cpu);
 	if (unlikely(!buffer))
 		return -ENOMEM;
=20
+	if (x86_pmu.arch_pebs) {
+		hwev->pebs_vaddr =3D buffer;
+		return 0;
+	}
+
 	/*
 	 * HSW+ already provides us the eventing ip; no need to allocate this
 	 * buffer then.
@@ -644,7 +649,7 @@ static int alloc_pebs_buffer(int cpu)
 		}
 		per_cpu(insn_buffer, cpu) =3D insn_buff;
 	}
-	hwev->ds_pebs_vaddr =3D buffer;
+	hwev->pebs_vaddr =3D buffer;
 	/* Update the cpu entry area mapping */
 	cea =3D &get_cpu_entry_area(cpu)->cpu_debug_buffers.pebs_buffer;
 	ds->pebs_buffer_base =3D (unsigned long) cea;
@@ -660,17 +665,20 @@ static void release_pebs_buffer(int cpu)
 	struct cpu_hw_events *hwev =3D per_cpu_ptr(&cpu_hw_events, cpu);
 	void *cea;
=20
-	if (!x86_pmu.ds_pebs)
+	if (!intel_pmu_has_pebs())
 		return;
=20
-	kfree(per_cpu(insn_buffer, cpu));
-	per_cpu(insn_buffer, cpu) =3D NULL;
+	if (x86_pmu.ds_pebs) {
+		kfree(per_cpu(insn_buffer, cpu));
+		per_cpu(insn_buffer, cpu) =3D NULL;
=20
-	/* Clear the fixmap */
-	cea =3D &get_cpu_entry_area(cpu)->cpu_debug_buffers.pebs_buffer;
-	ds_clear_cea(cea, x86_pmu.pebs_buffer_size);
-	dsfree_pages(hwev->ds_pebs_vaddr, x86_pmu.pebs_buffer_size);
-	hwev->ds_pebs_vaddr =3D NULL;
+		/* Clear the fixmap */
+		cea =3D &get_cpu_entry_area(cpu)->cpu_debug_buffers.pebs_buffer;
+		ds_clear_cea(cea, x86_pmu.pebs_buffer_size);
+	}
+
+	dsfree_pages(hwev->pebs_vaddr, x86_pmu.pebs_buffer_size);
+	hwev->pebs_vaddr =3D NULL;
 }
=20
 static int alloc_bts_buffer(int cpu)
@@ -823,6 +831,56 @@ void reserve_ds_buffers(void)
 	}
 }
=20
+inline int alloc_arch_pebs_buf_on_cpu(int cpu)
+{
+	if (!x86_pmu.arch_pebs)
+		return 0;
+
+	return alloc_pebs_buffer(cpu);
+}
+
+inline void release_arch_pebs_buf_on_cpu(int cpu)
+{
+	if (!x86_pmu.arch_pebs)
+		return;
+
+	release_pebs_buffer(cpu);
+}
+
+void init_arch_pebs_on_cpu(int cpu)
+{
+	struct cpu_hw_events *cpuc =3D per_cpu_ptr(&cpu_hw_events, cpu);
+	u64 arch_pebs_base;
+
+	if (!x86_pmu.arch_pebs)
+		return;
+
+	if (!cpuc->pebs_vaddr) {
+		WARN(1, "Fail to allocate PEBS buffer on CPU %d\n", cpu);
+		x86_pmu.pebs_active =3D 0;
+		return;
+	}
+
+	/*
+	 * 4KB-aligned pointer of the output buffer
+	 * (__alloc_pages_node() return page aligned address)
+	 * Buffer Size =3D 4KB * 2^SIZE
+	 * contiguous physical buffer (__alloc_pages_node() with order)
+	 */
+	arch_pebs_base =3D virt_to_phys(cpuc->pebs_vaddr) | PEBS_BUFFER_SHIFT;
+	wrmsr_on_cpu(cpu, MSR_IA32_PEBS_BASE, (u32)arch_pebs_base,
+		     (u32)(arch_pebs_base >> 32));
+	x86_pmu.pebs_active =3D 1;
+}
+
+inline void fini_arch_pebs_on_cpu(int cpu)
+{
+	if (!x86_pmu.arch_pebs)
+		return;
+
+	wrmsr_on_cpu(cpu, MSR_IA32_PEBS_BASE, 0, 0);
+}
+
 /*
  * BTS
  */
@@ -2883,8 +2941,8 @@ static void intel_pmu_drain_arch_pebs(struct pt_regs *i=
regs,
 		return;
 	}
=20
-	base =3D cpuc->ds_pebs_vaddr;
-	top =3D (void *)((u64)cpuc->ds_pebs_vaddr +
+	base =3D cpuc->pebs_vaddr;
+	top =3D (void *)((u64)cpuc->pebs_vaddr +
 		       (index.wr << ARCH_PEBS_INDEX_WR_SHIFT));
=20
 	index.wr =3D 0;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index ca52899..13f411b 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -283,8 +283,9 @@ struct cpu_hw_events {
 	 * Intel DebugStore bits
 	 */
 	struct debug_store	*ds;
-	void			*ds_pebs_vaddr;
 	void			*ds_bts_vaddr;
+	/* DS based PEBS or arch-PEBS buffer address */
+	void			*pebs_vaddr;
 	u64			pebs_enabled;
 	int			n_pebs;
 	int			n_large_pebs;
@@ -1617,6 +1618,14 @@ extern void intel_cpuc_finish(struct cpu_hw_events *cp=
uc);
=20
 int intel_pmu_init(void);
=20
+int alloc_arch_pebs_buf_on_cpu(int cpu);
+
+void release_arch_pebs_buf_on_cpu(int cpu);
+
+void init_arch_pebs_on_cpu(int cpu);
+
+void fini_arch_pebs_on_cpu(int cpu);
+
 void init_debug_store_on_cpu(int cpu);
=20
 void fini_debug_store_on_cpu(int cpu);
diff --git a/arch/x86/include/asm/intel_ds.h b/arch/x86/include/asm/intel_ds.h
index 5dbeac4..023c288 100644
--- a/arch/x86/include/asm/intel_ds.h
+++ b/arch/x86/include/asm/intel_ds.h
@@ -4,7 +4,8 @@
 #include <linux/percpu-defs.h>
=20
 #define BTS_BUFFER_SIZE		(PAGE_SIZE << 4)
-#define PEBS_BUFFER_SIZE	(PAGE_SIZE << 4)
+#define PEBS_BUFFER_SHIFT	4
+#define PEBS_BUFFER_SIZE	(PAGE_SIZE << PEBS_BUFFER_SHIFT)
=20
 /* The maximal number of PEBS events: */
 #define MAX_PEBS_EVENTS_FMT4	8

