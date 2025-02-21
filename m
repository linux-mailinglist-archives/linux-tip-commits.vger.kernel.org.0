Return-Path: <linux-tip-commits+bounces-3551-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 191E5A3EF71
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 10:05:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 355EB1883987
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 09:04:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 375F72046A9;
	Fri, 21 Feb 2025 09:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dvdsHdD1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s7/2Mr4o"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B4492040BC;
	Fri, 21 Feb 2025 09:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128596; cv=none; b=rcaTqj695q11ljEu6Lj6apDy76Z1ZrZ2zLsuTL1+O/M5g08tzsdKSXLPG/805WTaZBYo3j7eS61PMMALk2EEtsuP5mvIlh5LSXUkcNV5TNrJB+FhAyVCZ1mwxd+cIudfrCXoCce4sEbVR8aMjgV7X+7z2xYDyj28Gy8k0OPLn3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128596; c=relaxed/simple;
	bh=SVNAs9T1bQX+qlBFTBeKAAk3k2mC6KmXAJI2J7W2siQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ArL/s1KIDbMFWSwKlj8J61fTJ5gfoSPQi6ew/oU/8WixknyjGOAaG5eBFORMCuuLibib8zeArjfN5CgJAAkez+Tps9R92pIqxULZlbDrhuj+mZOW3To8tqlzfLtsefQ9xwD+T/4KUcZvj2Y9LIneY//VlRosE8HKu43AGhf5l2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dvdsHdD1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s7/2Mr4o; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 09:03:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740128591;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wanQQ9/n5qr3ghlWjGP/MKUD375+k9UcAL+kFTuYEu4=;
	b=dvdsHdD1Ohu0b2qEBz492mWBzwJIsShi80RivVLjgvGxnWfbn68+Iat6z0UY5cWQZG4Dcp
	YXZjB8Xj63tqCGCXNtxYO6/rypsoiZxJpdTqyJfJrb8csv/VbCS3kR7N1xaepNLjC0Efr3
	EXyDvRun1GEEU8bfJqWTAnEuE/qHeRkuO+VrJQAcHjEgsqh+RJfl6cx9YFPUaASkYuAiZB
	EowXw6HOV7Zmz7xFNm2cM/FUN1IlADH2hyU4qQHLSpYriVf/JB2QZZ5/UmfAg0Cnh+69ZZ
	fTfJ8S+MYxVspUB7cmBo6XjqIreSPK9bxrTR0CHoTcG001uh7Oq7IQcSNx5dRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740128591;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wanQQ9/n5qr3ghlWjGP/MKUD375+k9UcAL+kFTuYEu4=;
	b=s7/2Mr4ouKRfVF3hCHKx6u7fHAWmBnm8axTO2xAsBAIyqxJgGdNWU9IRkmECE9KH1rHtDY
	R7mUvUJ1TTrOURBg==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] LoongArch: vDSO: Switch to generic storage implementation
Cc: Nam Cao <namcao@linutronix.de>, thomas.weissschuh@linutronix.de,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250204-vdso-store-rng-v3-10-13a4669dfc8c@linutronix.de>
References: <20250204-vdso-store-rng-v3-10-13a4669dfc8c@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174012859128.10177.17613476625756195603.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     d2862bb9d9ca58f41319a55db0ca275774ae0c6a
Gitweb:        https://git.kernel.org/tip/d2862bb9d9ca58f41319a55db0ca275774a=
e0c6a
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 04 Feb 2025 13:05:42 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 Feb 2025 09:54:02 +01:00

LoongArch: vDSO: Switch to generic storage implementation

The generic storage implementation provides the same features as the
custom one. However it can be shared between architectures, making
maintenance easier.

Co-developed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250204-vdso-store-rng-v3-10-13a4669dfc8c@=
linutronix.de

---
 arch/loongarch/Kconfig                         |  2 +-
 arch/loongarch/include/asm/vdso.h              |  1 +-
 arch/loongarch/include/asm/vdso/arch_data.h    | 25 +++++-
 arch/loongarch/include/asm/vdso/getrandom.h    |  5 +-
 arch/loongarch/include/asm/vdso/gettimeofday.h | 14 +---
 arch/loongarch/include/asm/vdso/vdso.h         | 38 +-------
 arch/loongarch/include/asm/vdso/vsyscall.h     | 17 +---
 arch/loongarch/kernel/asm-offsets.c            |  2 +-
 arch/loongarch/kernel/vdso.c                   | 92 +-----------------
 arch/loongarch/vdso/vdso.lds.S                 |  8 +-
 arch/loongarch/vdso/vgetcpu.c                  | 12 +--
 11 files changed, 39 insertions(+), 177 deletions(-)
 create mode 100644 arch/loongarch/include/asm/vdso/arch_data.h

diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index 2b8bd27..d7ddf2a 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -30,6 +30,7 @@ config LOONGARCH
 	select ARCH_HAS_SET_MEMORY
 	select ARCH_HAS_SET_DIRECT_MAP
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
+	select ARCH_HAS_VDSO_ARCH_DATA
 	select ARCH_INLINE_READ_LOCK if !PREEMPTION
 	select ARCH_INLINE_READ_LOCK_BH if !PREEMPTION
 	select ARCH_INLINE_READ_LOCK_IRQ if !PREEMPTION
@@ -106,6 +107,7 @@ config LOONGARCH
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
+	select GENERIC_VDSO_DATA_STORE
 	select GENERIC_VDSO_TIME_NS
 	select GPIOLIB
 	select HAS_IOPORT
diff --git a/arch/loongarch/include/asm/vdso.h b/arch/loongarch/include/asm/v=
dso.h
index d3ba35e..f72ec79 100644
--- a/arch/loongarch/include/asm/vdso.h
+++ b/arch/loongarch/include/asm/vdso.h
@@ -31,7 +31,6 @@ struct loongarch_vdso_info {
 	unsigned long size;
 	unsigned long offset_sigreturn;
 	struct vm_special_mapping code_mapping;
-	struct vm_special_mapping data_mapping;
 };
=20
 extern struct loongarch_vdso_info vdso_info;
diff --git a/arch/loongarch/include/asm/vdso/arch_data.h b/arch/loongarch/inc=
lude/asm/vdso/arch_data.h
new file mode 100644
index 0000000..322d0a5
--- /dev/null
+++ b/arch/loongarch/include/asm/vdso/arch_data.h
@@ -0,0 +1,25 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Author: Huacai Chen <chenhuacai@loongson.cn>
+ * Copyright (C) 2020-2022 Loongson Technology Corporation Limited
+ */
+
+#ifndef _VDSO_ARCH_DATA_H
+#define _VDSO_ARCH_DATA_H
+
+#ifndef __ASSEMBLY__
+
+#include <asm/asm.h>
+#include <asm/vdso.h>
+
+struct vdso_pcpu_data {
+	u32 node;
+} ____cacheline_aligned_in_smp;
+
+struct vdso_arch_data {
+	struct vdso_pcpu_data pdata[NR_CPUS];
+};
+
+#endif /* __ASSEMBLY__ */
+
+#endif
diff --git a/arch/loongarch/include/asm/vdso/getrandom.h b/arch/loongarch/inc=
lude/asm/vdso/getrandom.h
index e80f3c4..48c43f5 100644
--- a/arch/loongarch/include/asm/vdso/getrandom.h
+++ b/arch/loongarch/include/asm/vdso/getrandom.h
@@ -28,11 +28,6 @@ static __always_inline ssize_t getrandom_syscall(void *_bu=
ffer, size_t _len, uns
 	return ret;
 }
=20
-static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(=
void)
-{
-	return &_loongarch_data.rng_data;
-}
-
 #endif /* !__ASSEMBLY__ */
=20
 #endif /* __ASM_VDSO_GETRANDOM_H */
diff --git a/arch/loongarch/include/asm/vdso/gettimeofday.h b/arch/loongarch/=
include/asm/vdso/gettimeofday.h
index 7eb3f04..88cfcf1 100644
--- a/arch/loongarch/include/asm/vdso/gettimeofday.h
+++ b/arch/loongarch/include/asm/vdso/gettimeofday.h
@@ -72,7 +72,7 @@ static __always_inline int clock_getres_fallback(
 }
=20
 static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
-						 const struct vdso_data *vd)
+						 const struct vdso_time_data *vd)
 {
 	uint64_t count;
=20
@@ -89,18 +89,6 @@ static inline bool loongarch_vdso_hres_capable(void)
 }
 #define __arch_vdso_hres_capable loongarch_vdso_hres_capable
=20
-static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
-{
-	return _vdso_data;
-}
-
-#ifdef CONFIG_TIME_NS
-static __always_inline
-const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *=
vd)
-{
-	return _timens_data;
-}
-#endif
 #endif /* !__ASSEMBLY__ */
=20
 #endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/loongarch/include/asm/vdso/vdso.h b/arch/loongarch/include/=
asm/vdso/vdso.h
index 1c183a9..50c65fb 100644
--- a/arch/loongarch/include/asm/vdso/vdso.h
+++ b/arch/loongarch/include/asm/vdso/vdso.h
@@ -12,43 +12,9 @@
 #include <asm/asm.h>
 #include <asm/page.h>
 #include <asm/vdso.h>
+#include <vdso/datapage.h>
=20
-struct vdso_pcpu_data {
-	u32 node;
-} ____cacheline_aligned_in_smp;
-
-struct loongarch_vdso_data {
-	struct vdso_pcpu_data pdata[NR_CPUS];
-	struct vdso_rng_data rng_data;
-};
-
-/*
- * The layout of vvar:
- *
- *                      high
- * +---------------------+--------------------------+
- * | loongarch vdso data | LOONGARCH_VDSO_DATA_SIZE |
- * +---------------------+--------------------------+
- * |  time-ns vdso data  |        PAGE_SIZE         |
- * +---------------------+--------------------------+
- * |  generic vdso data  |        PAGE_SIZE         |
- * +---------------------+--------------------------+
- *                      low
- */
-#define LOONGARCH_VDSO_DATA_SIZE PAGE_ALIGN(sizeof(struct loongarch_vdso_dat=
a))
-#define LOONGARCH_VDSO_DATA_PAGES (LOONGARCH_VDSO_DATA_SIZE >> PAGE_SHIFT)
-
-enum vvar_pages {
-	VVAR_GENERIC_PAGE_OFFSET,
-	VVAR_TIMENS_PAGE_OFFSET,
-	VVAR_LOONGARCH_PAGES_START,
-	VVAR_LOONGARCH_PAGES_END =3D VVAR_LOONGARCH_PAGES_START + LOONGARCH_VDSO_DA=
TA_PAGES - 1,
-	VVAR_NR_PAGES,
-};
-
-#define VVAR_SIZE (VVAR_NR_PAGES << PAGE_SHIFT)
-
-extern struct loongarch_vdso_data _loongarch_data __attribute__((visibility(=
"hidden")));
+#define VVAR_SIZE (VDSO_NR_PAGES << PAGE_SHIFT)
=20
 #endif /* __ASSEMBLY__ */
=20
diff --git a/arch/loongarch/include/asm/vdso/vsyscall.h b/arch/loongarch/incl=
ude/asm/vdso/vsyscall.h
index 8987e95..1140b54 100644
--- a/arch/loongarch/include/asm/vdso/vsyscall.h
+++ b/arch/loongarch/include/asm/vdso/vsyscall.h
@@ -6,23 +6,6 @@
=20
 #include <vdso/datapage.h>
=20
-extern struct vdso_data *vdso_data;
-extern struct vdso_rng_data *vdso_rng_data;
-
-static __always_inline
-struct vdso_data *__loongarch_get_k_vdso_data(void)
-{
-	return vdso_data;
-}
-#define __arch_get_k_vdso_data __loongarch_get_k_vdso_data
-
-static __always_inline
-struct vdso_rng_data *__loongarch_get_k_vdso_rng_data(void)
-{
-	return vdso_rng_data;
-}
-#define __arch_get_k_vdso_rng_data __loongarch_get_k_vdso_rng_data
-
 /* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
=20
diff --git a/arch/loongarch/kernel/asm-offsets.c b/arch/loongarch/kernel/asm-=
offsets.c
index 8be1c38..6f1524b 100644
--- a/arch/loongarch/kernel/asm-offsets.c
+++ b/arch/loongarch/kernel/asm-offsets.c
@@ -315,6 +315,6 @@ static void __used output_vdso_defines(void)
 {
 	COMMENT("LoongArch vDSO offsets.");
=20
-	DEFINE(__VVAR_PAGES, VVAR_NR_PAGES);
+	DEFINE(__VDSO_PAGES, VDSO_NR_PAGES);
 	BLANK();
 }
diff --git a/arch/loongarch/kernel/vdso.c b/arch/loongarch/kernel/vdso.c
index 05e5fba..10cf160 100644
--- a/arch/loongarch/kernel/vdso.c
+++ b/arch/loongarch/kernel/vdso.c
@@ -14,7 +14,7 @@
 #include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
-#include <linux/time_namespace.h>
+#include <linux/vdso_datastore.h>
=20
 #include <asm/page.h>
 #include <asm/vdso.h>
@@ -25,18 +25,6 @@
=20
 extern char vdso_start[], vdso_end[];
=20
-/* Kernel-provided data used by the VDSO. */
-static union vdso_data_store generic_vdso_data __page_aligned_data;
-
-static union {
-	u8 page[LOONGARCH_VDSO_DATA_SIZE];
-	struct loongarch_vdso_data vdata;
-} loongarch_vdso_data __page_aligned_data;
-
-struct vdso_data *vdso_data =3D generic_vdso_data.data;
-struct vdso_pcpu_data *vdso_pdata =3D loongarch_vdso_data.vdata.pdata;
-struct vdso_rng_data *vdso_rng_data =3D &loongarch_vdso_data.vdata.rng_data;
-
 static int vdso_mremap(const struct vm_special_mapping *sm, struct vm_area_s=
truct *new_vma)
 {
 	current->mm->context.vdso =3D (void *)(new_vma->vm_start);
@@ -44,53 +32,12 @@ static int vdso_mremap(const struct vm_special_mapping *s=
m, struct vm_area_struc
 	return 0;
 }
=20
-static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
-			     struct vm_area_struct *vma, struct vm_fault *vmf)
-{
-	unsigned long pfn;
-	struct page *timens_page =3D find_timens_vvar_page(vma);
-
-	switch (vmf->pgoff) {
-	case VVAR_GENERIC_PAGE_OFFSET:
-		if (!timens_page)
-			pfn =3D sym_to_pfn(vdso_data);
-		else
-			pfn =3D page_to_pfn(timens_page);
-		break;
-#ifdef CONFIG_TIME_NS
-	case VVAR_TIMENS_PAGE_OFFSET:
-		/*
-		 * If a task belongs to a time namespace then a namespace specific
-		 * VVAR is mapped with the VVAR_GENERIC_PAGE_OFFSET and the real
-		 * VVAR page is mapped with the VVAR_TIMENS_PAGE_OFFSET offset.
-		 * See also the comment near timens_setup_vdso_data().
-		 */
-		if (!timens_page)
-			return VM_FAULT_SIGBUS;
-		else
-			pfn =3D sym_to_pfn(vdso_data);
-		break;
-#endif /* CONFIG_TIME_NS */
-	case VVAR_LOONGARCH_PAGES_START ... VVAR_LOONGARCH_PAGES_END:
-		pfn =3D sym_to_pfn(&loongarch_vdso_data) + vmf->pgoff - VVAR_LOONGARCH_PAG=
ES_START;
-		break;
-	default:
-		return VM_FAULT_SIGBUS;
-	}
-
-	return vmf_insert_pfn(vma, vmf->address, pfn);
-}
-
 struct loongarch_vdso_info vdso_info =3D {
 	.vdso =3D vdso_start,
 	.code_mapping =3D {
 		.name =3D "[vdso]",
 		.mremap =3D vdso_mremap,
 	},
-	.data_mapping =3D {
-		.name =3D "[vvar]",
-		.fault =3D vvar_fault,
-	},
 	.offset_sigreturn =3D vdso_offset_sigreturn,
 };
=20
@@ -101,7 +48,7 @@ static int __init init_vdso(void)
 	BUG_ON(!PAGE_ALIGNED(vdso_info.vdso));
=20
 	for_each_possible_cpu(cpu)
-		vdso_pdata[cpu].node =3D cpu_to_node(cpu);
+		vdso_k_arch_data->pdata[cpu].node =3D cpu_to_node(cpu);
=20
 	vdso_info.size =3D PAGE_ALIGN(vdso_end - vdso_start);
 	vdso_info.code_mapping.pages =3D
@@ -115,37 +62,6 @@ static int __init init_vdso(void)
 }
 subsys_initcall(init_vdso);
=20
-#ifdef CONFIG_TIME_NS
-struct vdso_data *arch_get_vdso_data(void *vvar_page)
-{
-	return (struct vdso_data *)(vvar_page);
-}
-
-/*
- * The vvar mapping contains data for a specific time namespace, so when a
- * task changes namespace we must unmap its vvar data for the old namespace.
- * Subsequent faults will map in data for the new namespace.
- *
- * For more details see timens_setup_vdso_data().
- */
-int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
-{
-	struct mm_struct *mm =3D task->mm;
-	struct vm_area_struct *vma;
-
-	VMA_ITERATOR(vmi, mm, 0);
-
-	mmap_read_lock(mm);
-	for_each_vma(vmi, vma) {
-		if (vma_is_special_mapping(vma, &vdso_info.data_mapping))
-			zap_vma_pages(vma);
-	}
-	mmap_read_unlock(mm);
-
-	return 0;
-}
-#endif
-
 static unsigned long vdso_base(void)
 {
 	unsigned long base =3D STACK_TOP;
@@ -181,9 +97,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm,=
 int uses_interp)
 		goto out;
 	}
=20
-	vma =3D _install_special_mapping(mm, data_addr, VVAR_SIZE,
-				       VM_READ | VM_MAYREAD | VM_PFNMAP,
-				       &info->data_mapping);
+	vma =3D vdso_install_vvar_mapping(mm, data_addr);
 	if (IS_ERR(vma)) {
 		ret =3D PTR_ERR(vma);
 		goto out;
diff --git a/arch/loongarch/vdso/vdso.lds.S b/arch/loongarch/vdso/vdso.lds.S
index 160cfae..8ff9864 100644
--- a/arch/loongarch/vdso/vdso.lds.S
+++ b/arch/loongarch/vdso/vdso.lds.S
@@ -5,6 +5,7 @@
  */
 #include <asm/page.h>
 #include <generated/asm-offsets.h>
+#include <vdso/datapage.h>
=20
 OUTPUT_FORMAT("elf64-loongarch", "elf64-loongarch", "elf64-loongarch")
=20
@@ -12,11 +13,8 @@ OUTPUT_ARCH(loongarch)
=20
 SECTIONS
 {
-	PROVIDE(_vdso_data =3D . - __VVAR_PAGES * PAGE_SIZE);
-#ifdef CONFIG_TIME_NS
-	PROVIDE(_timens_data =3D _vdso_data + PAGE_SIZE);
-#endif
-	PROVIDE(_loongarch_data =3D _vdso_data + 2 * PAGE_SIZE);
+	VDSO_VVAR_SYMS
+
 	. =3D SIZEOF_HEADERS;
=20
 	.hash		: { *(.hash) }			:text
diff --git a/arch/loongarch/vdso/vgetcpu.c b/arch/loongarch/vdso/vgetcpu.c
index 0db5125..5301cd9 100644
--- a/arch/loongarch/vdso/vgetcpu.c
+++ b/arch/loongarch/vdso/vgetcpu.c
@@ -19,27 +19,19 @@ static __always_inline int read_cpu_id(void)
 	return cpu_id;
 }
=20
-static __always_inline const struct vdso_pcpu_data *get_pcpu_data(void)
-{
-	return _loongarch_data.pdata;
-}
-
 extern
 int __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache=
 *unused);
 int __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache=
 *unused)
 {
 	int cpu_id;
-	const struct vdso_pcpu_data *data;
=20
 	cpu_id =3D read_cpu_id();
=20
 	if (cpu)
 		*cpu =3D cpu_id;
=20
-	if (node) {
-		data =3D get_pcpu_data();
-		*node =3D data[cpu_id].node;
-	}
+	if (node)
+		*node =3D vdso_u_arch_data.pdata[cpu_id].node;
=20
 	return 0;
 }

