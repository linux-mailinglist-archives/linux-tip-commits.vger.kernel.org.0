Return-Path: <linux-tip-commits+bounces-2695-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E90A99B9E8E
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:10:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3D500B21187
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 10:10:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1698170A03;
	Sat,  2 Nov 2024 10:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mE4oEjZX";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wAL+HfK+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61DB116E89B;
	Sat,  2 Nov 2024 10:10:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730542213; cv=none; b=Im3bWMOjij1+CePBG5z/WSRE93lAvGoppngrvW+RmBIhHwnhPVks1nKtesAfs94dTptjboT2jFAOfAESAakI7MK2pLdLwkNDaTwsYRrolgFZZxPkCfnnoOJa348f2qvgb3zMhurdjYN6m3DSjIbazAcy73G4Z0ovQwrZwf62jo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730542213; c=relaxed/simple;
	bh=VhLEXpXlx7RNvUqrcncrXz4PO0RgeCDzMGW8d9Qel08=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UyUtsUEI+v9FDol5ZWFuqzw9hMZqfd1z8eTQkRenc2BwJRIVpA4GEI2wq+hAX9gccF9EyS8AkabAYzL+RfA2R7ht5o7sNAeDYVeHiUwnWDdYWc/gkRLQJevBfosSOajY3WoDWJACmePQ+0L0lGLsdyPs2zGXs0r8gQdiFJbxDU0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mE4oEjZX; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wAL+HfK+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 10:10:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730542204;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0D9Xu8HxTAGhjo4UonbSmZ8fzojFddUzpjJM+W4UBw=;
	b=mE4oEjZXxETcvdK2O5QZYqHRhXW2lHwR0KpFm7MzFtrPdLJBkyzPSoBxNR/vkIsECoOxA3
	juCGwr+lhFoA9BPWnR3u6dPCMNK+24lU2FnbDOsZlVFC76EQWd3J5u6X3J2lCy/pjXkW+E
	hyyNCPkxAroLOZ9Y8TUjlQzr+qX17rw2eNq7QoIupW0XKv9T3R6wdAM45HSyknrsVsOomF
	n84ve6sgsQBY+tV72elyMgQEgvZrGv/k1PbDP2f6gPqsTnews/8aEljAktYDLs062uwnOi
	mkrvQe2wnkmpomLHRjFU2Cfd4Q5QSFQ/gaHgEJRXcHFieam/9+/oEIjtuGCXjg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730542204;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=G0D9Xu8HxTAGhjo4UonbSmZ8fzojFddUzpjJM+W4UBw=;
	b=wAL+HfK+hRx1vGzKgiHk85OFADfxUsffeoo0CYIf78i3s+k/yckwld3WfGvbPTKmfySXUx
	aODIuoV/8IcBOoDA==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] powerpc: Split systemcfg data out of vdso data page
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010-vdso-generic-base-v1-26-b64f0842d512@linutronix.de>
References: <20241010-vdso-generic-base-v1-26-b64f0842d512@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173054220369.3137.18078314914581799902.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     b596dafe4a53068a95c8cd6436c27220ac33f2d4
Gitweb:        https://git.kernel.org/tip/b596dafe4a53068a95c8cd6436c27220ac3=
3f2d4
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:28 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 11:05:16 +01:00

powerpc: Split systemcfg data out of vdso data page

The systemcfg data only has minimal overlap with the vdso data.
Splitting the two avoids mapping the implementation-defined vdso data
into /proc/ppc64/systemcfg.
It is also a preparation for the standardization of vdso data storage.

The only field actually used by both systemcfg and vdso is
tb_ticks_per_sec and it is only changed once during time_init().
Initialize it in both structures there.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241010-vdso-generic-base-v1-26-b64f0842d5=
12@linutronix.de

---
 arch/powerpc/include/asm/vdso_datapage.h     | 32 +++----------------
 arch/powerpc/kernel/proc_powerpc.c           | 25 ++++++++++++++-
 arch/powerpc/kernel/setup-common.c           |  4 +-
 arch/powerpc/kernel/smp.c                    | 10 +++---
 arch/powerpc/kernel/time.c                   |  3 ++-
 arch/powerpc/kernel/vdso.c                   | 20 +------------
 arch/powerpc/platforms/powernv/smp.c         |  4 +-
 arch/powerpc/platforms/pseries/hotplug-cpu.c |  4 +-
 8 files changed, 48 insertions(+), 54 deletions(-)

diff --git a/arch/powerpc/include/asm/vdso_datapage.h b/arch/powerpc/include/=
asm/vdso_datapage.h
index 3d5862d..8b91b1d 100644
--- a/arch/powerpc/include/asm/vdso_datapage.h
+++ b/arch/powerpc/include/asm/vdso_datapage.h
@@ -11,21 +11,6 @@
=20
=20
 /*
- * Note about this structure:
- *
- * This structure was historically called systemcfg and exposed to
- * userland via /proc/ppc64/systemcfg. Unfortunately, this became an
- * ABI issue as some proprietary software started relying on being able
- * to mmap() it, thus we have to keep the base layout at least for a
- * few kernel versions.
- *
- * However, since ppc32 doesn't suffer from this backward handicap,
- * a simpler version of the data structure is used there with only the
- * fields actually used by the vDSO.
- *
- */
-
-/*
  * If the major version changes we are incompatible.
  * Minor version changes are a hint.
  */
@@ -40,13 +25,9 @@
=20
 #define SYSCALL_MAP_SIZE      ((NR_syscalls + 31) / 32)
=20
-/*
- * So here is the ppc64 backward compatible version
- */
-
 #ifdef CONFIG_PPC64
=20
-struct vdso_arch_data {
+struct systemcfg {
 	__u8  eye_catcher[16];		/* Eyecatcher: SYSTEMCFG:PPC64	0x00 */
 	struct {			/* Systemcfg version numbers	     */
 		__u32 major;		/* Major number			0x10 */
@@ -71,10 +52,12 @@ struct vdso_arch_data {
 	__u32 dcache_line_size;		/* L1 d-cache line size		0x64 */
 	__u32 icache_size;		/* L1 i-cache size		0x68 */
 	__u32 icache_line_size;		/* L1 i-cache line size		0x6C */
+};
=20
-	/* those additional ones don't have to be located anywhere
-	 * special as they were not part of the original systemcfg
-	 */
+extern struct systemcfg *systemcfg;
+
+struct vdso_arch_data {
+	__u64 tb_ticks_per_sec;			/* Timebase tics / sec */
 	__u32 dcache_block_size;		/* L1 d-cache block size     */
 	__u32 icache_block_size;		/* L1 i-cache block size     */
 	__u32 dcache_log_block_size;		/* L1 d-cache log block size */
@@ -88,9 +71,6 @@ struct vdso_arch_data {
=20
 #else /* CONFIG_PPC64 */
=20
-/*
- * And here is the simpler 32 bits version
- */
 struct vdso_arch_data {
 	__u64 tb_ticks_per_sec;		/* Timebase tics / sec */
 	__u32 syscall_map[SYSCALL_MAP_SIZE]; /* Map of syscalls */
diff --git a/arch/powerpc/kernel/proc_powerpc.c b/arch/powerpc/kernel/proc_po=
werpc.c
index 3bda365..e8083e0 100644
--- a/arch/powerpc/kernel/proc_powerpc.c
+++ b/arch/powerpc/kernel/proc_powerpc.c
@@ -4,6 +4,7 @@
  */
=20
 #include <linux/init.h>
+#include <linux/memblock.h>
 #include <linux/mm.h>
 #include <linux/proc_fs.h>
 #include <linux/kernel.h>
@@ -44,13 +45,35 @@ static const struct proc_ops page_map_proc_ops =3D {
 	.proc_mmap	=3D page_map_mmap,
 };
=20
+static union {
+	struct systemcfg	data;
+	u8			page[PAGE_SIZE];
+} systemcfg_data_store __page_aligned_data;
+struct systemcfg *systemcfg =3D &systemcfg_data_store.data;
=20
 static int __init proc_ppc64_init(void)
 {
 	struct proc_dir_entry *pde;
=20
+	strcpy((char *)systemcfg->eye_catcher, "SYSTEMCFG:PPC64");
+	systemcfg->version.major =3D SYSTEMCFG_MAJOR;
+	systemcfg->version.minor =3D SYSTEMCFG_MINOR;
+	systemcfg->processor =3D mfspr(SPRN_PVR);
+	/*
+	 * Fake the old platform number for pSeries and add
+	 * in LPAR bit if necessary
+	 */
+	systemcfg->platform =3D 0x100;
+	if (firmware_has_feature(FW_FEATURE_LPAR))
+		systemcfg->platform |=3D 1;
+	systemcfg->physicalMemorySize =3D memblock_phys_mem_size();
+	systemcfg->dcache_size =3D ppc64_caches.l1d.size;
+	systemcfg->dcache_line_size =3D ppc64_caches.l1d.line_size;
+	systemcfg->icache_size =3D ppc64_caches.l1i.size;
+	systemcfg->icache_line_size =3D ppc64_caches.l1i.line_size;
+
 	pde =3D proc_create_data("powerpc/systemcfg", S_IFREG | 0444, NULL,
-			       &page_map_proc_ops, vdso_data);
+			       &page_map_proc_ops, systemcfg);
 	if (!pde)
 		return 1;
 	proc_set_size(pde, PAGE_SIZE);
diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-c=
ommon.c
index 9434300..d0b32ff 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -560,7 +560,9 @@ void __init smp_setup_cpu_maps(void)
 	out:
 		of_node_put(dn);
 	}
-	vdso_data->processorCount =3D num_present_cpus();
+#endif
+#ifdef CONFIG_PPC64_PROC_SYSTEMCFG
+	systemcfg->processorCount =3D num_present_cpus();
 #endif /* CONFIG_PPC64 */
=20
         /* Initialize CPU <=3D> thread mapping/
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 4ab9b8c..87ae45b 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -1186,8 +1186,8 @@ int generic_cpu_disable(void)
 		return -EBUSY;
=20
 	set_cpu_online(cpu, false);
-#ifdef CONFIG_PPC64
-	vdso_data->processorCount--;
+#ifdef CONFIG_PPC64_PROC_SYSTEMCFG
+	systemcfg->processorCount--;
 #endif
 	/* Update affinity of all IRQs previously aimed at this CPU */
 	irq_migrate_all_off_this_cpu();
@@ -1642,10 +1642,12 @@ void start_secondary(void *unused)
=20
 	secondary_cpu_time_init();
=20
-#ifdef CONFIG_PPC64
+#ifdef CONFIG_PPC64_PROC_SYSTEMCFG
 	if (system_state =3D=3D SYSTEM_RUNNING)
-		vdso_data->processorCount++;
+		systemcfg->processorCount++;
+#endif
=20
+#ifdef CONFIG_PPC64
 	vdso_getcpu_init();
 #endif
 	set_numa_node(numa_cpu_lookup_table[cpu]);
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 4a95654..7d18eb8 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -950,6 +950,9 @@ void __init time_init(void)
 	}
=20
 	vdso_data->tb_ticks_per_sec =3D tb_ticks_per_sec;
+#ifdef CONFIG_PPC64_PROC_SYSTEMCFG
+	systemcfg->tb_ticks_per_sec =3D tb_ticks_per_sec;
+#endif
=20
 	/* initialise and enable the large decrementer (if we have one) */
 	set_decrementer_max();
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index ee4b9d6..924f7f4 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -16,7 +16,6 @@
 #include <linux/user.h>
 #include <linux/elf.h>
 #include <linux/security.h>
-#include <linux/memblock.h>
 #include <linux/syscalls.h>
 #include <linux/time_namespace.h>
 #include <vdso/datapage.h>
@@ -349,25 +348,6 @@ static struct page ** __init vdso_setup_pages(void *star=
t, void *end)
 static int __init vdso_init(void)
 {
 #ifdef CONFIG_PPC64
-	/*
-	 * Fill up the "systemcfg" stuff for backward compatibility
-	 */
-	strcpy((char *)vdso_data->eye_catcher, "SYSTEMCFG:PPC64");
-	vdso_data->version.major =3D SYSTEMCFG_MAJOR;
-	vdso_data->version.minor =3D SYSTEMCFG_MINOR;
-	vdso_data->processor =3D mfspr(SPRN_PVR);
-	/*
-	 * Fake the old platform number for pSeries and add
-	 * in LPAR bit if necessary
-	 */
-	vdso_data->platform =3D 0x100;
-	if (firmware_has_feature(FW_FEATURE_LPAR))
-		vdso_data->platform |=3D 1;
-	vdso_data->physicalMemorySize =3D memblock_phys_mem_size();
-	vdso_data->dcache_size =3D ppc64_caches.l1d.size;
-	vdso_data->dcache_line_size =3D ppc64_caches.l1d.line_size;
-	vdso_data->icache_size =3D ppc64_caches.l1i.size;
-	vdso_data->icache_line_size =3D ppc64_caches.l1i.line_size;
 	vdso_data->dcache_block_size =3D ppc64_caches.l1d.block_size;
 	vdso_data->icache_block_size =3D ppc64_caches.l1i.block_size;
 	vdso_data->dcache_log_block_size =3D ppc64_caches.l1d.log_block_size;
diff --git a/arch/powerpc/platforms/powernv/smp.c b/arch/powerpc/platforms/po=
wernv/smp.c
index 8f14f05..6722094 100644
--- a/arch/powerpc/platforms/powernv/smp.c
+++ b/arch/powerpc/platforms/powernv/smp.c
@@ -136,7 +136,9 @@ static int pnv_smp_cpu_disable(void)
 	 * the generic fixup_irqs. --BenH.
 	 */
 	set_cpu_online(cpu, false);
-	vdso_data->processorCount--;
+#ifdef CONFIG_PPC64_PROC_SYSTEMCFG
+	systemcfg->processorCount--;
+#endif
 	if (cpu =3D=3D boot_cpuid)
 		boot_cpuid =3D cpumask_any(cpu_online_mask);
 	if (xive_enabled())
diff --git a/arch/powerpc/platforms/pseries/hotplug-cpu.c b/arch/powerpc/plat=
forms/pseries/hotplug-cpu.c
index 6838a0f..7b80d35 100644
--- a/arch/powerpc/platforms/pseries/hotplug-cpu.c
+++ b/arch/powerpc/platforms/pseries/hotplug-cpu.c
@@ -83,7 +83,9 @@ static int pseries_cpu_disable(void)
 	int cpu =3D smp_processor_id();
=20
 	set_cpu_online(cpu, false);
-	vdso_data->processorCount--;
+#ifdef CONFIG_PPC64_PROC_SYSTEMCFG
+	systemcfg->processorCount--;
+#endif
=20
 	/*fix boot_cpuid here*/
 	if (cpu =3D=3D boot_cpuid)

