Return-Path: <linux-tip-commits+bounces-3552-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BEE77A3EF74
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 10:05:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B871E19C569F
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 09:04:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C73C62046BF;
	Fri, 21 Feb 2025 09:03:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="frwBzZJD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FcPPHPI/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55342204595;
	Fri, 21 Feb 2025 09:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128596; cv=none; b=tBHdbRL2z2c8kF2odAvSF0xWaPwfxbe9oYckaF8yrNJ9I/C6DjE/ydgpSf7DAUcc+uQNBksN+reckl0d582v7Cq3BV75cKDAHhiw90EvUp8MBpFD8sOJiBwuRnDjkXPHUEnqaPu8XJdqIWP70PpCHMAnn50Wfgar5EU5Z48RDIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128596; c=relaxed/simple;
	bh=UHvKiLzPXJIg6Ls+NVcp8f4uY2sH6ypQQpu+w6inNPE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=K0px5u/hvqscN79lRWSrGGGA0pwuc1r9BAMoPM8De5qN0r+kUrNzqdWbbLlkNJuN2D7hlfKjabZ7DL/Ifs9M3Ii3erklWhU54squycZVrastmTg79drfJJY4FKwVKakTJO0LPxdeF+wSCt0r/5/IaagbgvOXztncHSZxpDQD3bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=frwBzZJD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FcPPHPI/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 09:03:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740128592;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RTO53vMncVztHz3nVgvkhWeJZvQ9JPCq5gSHrUqCdW8=;
	b=frwBzZJD+xC0UY+Vmc2K0p9nkMVwcaoAX68IFhLTB30uVqyhMNe4LIjO6FSDfF0OzmGZAd
	3Gmtz9mV2FIz595mKik1jUIykbSbCi+BDQsuMwO8eO1Ad9XzSjoECKaknacAhsFU7SYiS2
	4cCXrliPu4ZXyAsBgjBnuuZWVpbGFjZMX5oFCBSmOvWjRN70APly9m/IZv7+MhX3zhSLHT
	5w4DMJHYkmo7hF7d0wYmL25Emrm+8oUj58lL8Wjpk74990ynxVIGn2j/6xUlSEEh74MYRX
	8suk87lNbbWJE3YsdwG0j6HjjQttBPimiKrjsnKExP3LXvKJsBX31E+uY4BNrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740128592;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RTO53vMncVztHz3nVgvkhWeJZvQ9JPCq5gSHrUqCdW8=;
	b=FcPPHPI/S06CK7JyL1PtAF6mJ5IXJv4faqz5GrhheSGYLQ+RtEvF8Jlfg/vVD9C3a5CreY
	y+IW/wolmyzie6Aw==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] riscv: vdso: Switch to generic storage implementation
Cc: Nam Cao <namcao@linutronix.de>, thomas.weissschuh@linutronix.de,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250204-vdso-store-rng-v3-9-13a4669dfc8c@linutronix.de>
References: <20250204-vdso-store-rng-v3-9-13a4669dfc8c@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174012859198.10177.2179760003717176109.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     46fe55b204bfb007e0f0a5409dcda063ad98b089
Gitweb:        https://git.kernel.org/tip/46fe55b204bfb007e0f0a5409dcda063ad9=
8b089
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 04 Feb 2025 13:05:41 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 Feb 2025 09:54:02 +01:00

riscv: vdso: Switch to generic storage implementation

The generic storage implementation provides the same features as the
custom one. However it can be shared between architectures, making
maintenance easier.

Co-developed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250204-vdso-store-rng-v3-9-13a4669dfc8c@l=
inutronix.de

---
 arch/riscv/Kconfig                         |  3 +-
 arch/riscv/include/asm/vdso.h              |  2 +-
 arch/riscv/include/asm/vdso/arch_data.h    | 17 ++++-
 arch/riscv/include/asm/vdso/gettimeofday.h | 14 +---
 arch/riscv/include/asm/vdso/time_data.h    | 17 +----
 arch/riscv/include/asm/vdso/vsyscall.h     |  9 +--
 arch/riscv/kernel/sys_hwprobe.c            |  3 +-
 arch/riscv/kernel/vdso.c                   | 90 +---------------------
 arch/riscv/kernel/vdso/hwprobe.c           |  6 +-
 arch/riscv/kernel/vdso/vdso.lds.S          |  7 +--
 10 files changed, 31 insertions(+), 137 deletions(-)
 create mode 100644 arch/riscv/include/asm/vdso/arch_data.h
 delete mode 100644 arch/riscv/include/asm/vdso/time_data.h

diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index 7612c52..aa8ea53 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -53,7 +53,7 @@ config RISCV
 	select ARCH_HAS_SYSCALL_WRAPPER
 	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UBSAN
-	select ARCH_HAS_VDSO_TIME_DATA
+	select ARCH_HAS_VDSO_ARCH_DATA if GENERIC_VDSO_DATA_STORE
 	select ARCH_KEEP_MEMBLOCK if ACPI
 	select ARCH_MHP_MEMMAP_ON_MEMORY_ENABLE	if 64BIT && MMU
 	select ARCH_OPTIONAL_KERNEL_RWX if ARCH_HAS_STRICT_KERNEL_RWX
@@ -116,6 +116,7 @@ config RISCV
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL if MMU && 64BIT
+	select GENERIC_VDSO_DATA_STORE if MMU
 	select GENERIC_VDSO_TIME_NS if HAVE_GENERIC_VDSO
 	select HARDIRQS_SW_RESEND
 	select HAS_IOPORT if MMU
diff --git a/arch/riscv/include/asm/vdso.h b/arch/riscv/include/asm/vdso.h
index f891478..c130d81 100644
--- a/arch/riscv/include/asm/vdso.h
+++ b/arch/riscv/include/asm/vdso.h
@@ -14,7 +14,7 @@
  */
 #ifdef CONFIG_MMU
=20
-#define __VVAR_PAGES    2
+#define __VDSO_PAGES    4
=20
 #ifndef __ASSEMBLY__
 #include <generated/vdso-offsets.h>
diff --git a/arch/riscv/include/asm/vdso/arch_data.h b/arch/riscv/include/asm=
/vdso/arch_data.h
new file mode 100644
index 0000000..da57a37
--- /dev/null
+++ b/arch/riscv/include/asm/vdso/arch_data.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __RISCV_ASM_VDSO_ARCH_DATA_H
+#define __RISCV_ASM_VDSO_ARCH_DATA_H
+
+#include <linux/types.h>
+#include <vdso/datapage.h>
+#include <asm/hwprobe.h>
+
+struct vdso_arch_data {
+	/* Stash static answers to the hwprobe queries when all CPUs are selected. =
*/
+	__u64 all_cpu_hwprobe_values[RISCV_HWPROBE_MAX_KEY + 1];
+
+	/* Boolean indicating all CPUs have the same static hwprobe values. */
+	__u8 homogeneous_cpus;
+};
+
+#endif /* __RISCV_ASM_VDSO_ARCH_DATA_H */
diff --git a/arch/riscv/include/asm/vdso/gettimeofday.h b/arch/riscv/include/=
asm/vdso/gettimeofday.h
index ba3283c..29164f8 100644
--- a/arch/riscv/include/asm/vdso/gettimeofday.h
+++ b/arch/riscv/include/asm/vdso/gettimeofday.h
@@ -69,7 +69,7 @@ int clock_getres_fallback(clockid_t _clkid, struct __kernel=
_timespec *_ts)
 #endif /* CONFIG_GENERIC_TIME_VSYSCALL */
=20
 static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
-						 const struct vdso_data *vd)
+						 const struct vdso_time_data *vd)
 {
 	/*
 	 * The purpose of csr_read(CSR_TIME) is to trap the system into
@@ -79,18 +79,6 @@ static __always_inline u64 __arch_get_hw_counter(s32 clock=
_mode,
 	return csr_read(CSR_TIME);
 }
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
diff --git a/arch/riscv/include/asm/vdso/time_data.h b/arch/riscv/include/asm=
/vdso/time_data.h
deleted file mode 100644
index dfa6522..0000000
--- a/arch/riscv/include/asm/vdso/time_data.h
+++ /dev/null
@@ -1,17 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef __RISCV_ASM_VDSO_TIME_DATA_H
-#define __RISCV_ASM_VDSO_TIME_DATA_H
-
-#include <linux/types.h>
-#include <vdso/datapage.h>
-#include <asm/hwprobe.h>
-
-struct arch_vdso_time_data {
-	/* Stash static answers to the hwprobe queries when all CPUs are selected. =
*/
-	__u64 all_cpu_hwprobe_values[RISCV_HWPROBE_MAX_KEY + 1];
-
-	/* Boolean indicating all CPUs have the same static hwprobe values. */
-	__u8 homogeneous_cpus;
-};
-
-#endif /* __RISCV_ASM_VDSO_TIME_DATA_H */
diff --git a/arch/riscv/include/asm/vdso/vsyscall.h b/arch/riscv/include/asm/=
vdso/vsyscall.h
index e8a9c4b..1140b54 100644
--- a/arch/riscv/include/asm/vdso/vsyscall.h
+++ b/arch/riscv/include/asm/vdso/vsyscall.h
@@ -6,15 +6,6 @@
=20
 #include <vdso/datapage.h>
=20
-extern struct vdso_data *vdso_data;
-
-static __always_inline struct vdso_data *__riscv_get_k_vdso_data(void)
-{
-	return vdso_data;
-}
-
-#define __arch_get_k_vdso_data __riscv_get_k_vdso_data
-
 /* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
=20
diff --git a/arch/riscv/kernel/sys_hwprobe.c b/arch/riscv/kernel/sys_hwprobe.c
index bcd3b81..04a4e54 100644
--- a/arch/riscv/kernel/sys_hwprobe.c
+++ b/arch/riscv/kernel/sys_hwprobe.c
@@ -450,8 +450,7 @@ static int do_riscv_hwprobe(struct riscv_hwprobe __user *=
pairs,
=20
 static int __init init_hwprobe_vdso_data(void)
 {
-	struct vdso_data *vd =3D __arch_get_k_vdso_data();
-	struct arch_vdso_time_data *avd =3D &vd->arch_data;
+	struct vdso_arch_data *avd =3D vdso_k_arch_data;
 	u64 id_bitsmash =3D 0;
 	struct riscv_hwprobe pair;
 	int key;
diff --git a/arch/riscv/kernel/vdso.c b/arch/riscv/kernel/vdso.c
index 3ca3ae4..cc2895d 100644
--- a/arch/riscv/kernel/vdso.c
+++ b/arch/riscv/kernel/vdso.c
@@ -13,20 +13,11 @@
 #include <linux/err.h>
 #include <asm/page.h>
 #include <asm/vdso.h>
-#include <linux/time_namespace.h>
+#include <linux/vdso_datastore.h>
 #include <vdso/datapage.h>
 #include <vdso/vsyscall.h>
=20
-enum vvar_pages {
-	VVAR_DATA_PAGE_OFFSET,
-	VVAR_TIMENS_PAGE_OFFSET,
-	VVAR_NR_PAGES,
-};
-
-#define VVAR_SIZE  (VVAR_NR_PAGES << PAGE_SHIFT)
-
-static union vdso_data_store vdso_data_store __page_aligned_data;
-struct vdso_data *vdso_data =3D vdso_data_store.data;
+#define VVAR_SIZE  (VDSO_NR_PAGES << PAGE_SHIFT)
=20
 struct __vdso_info {
 	const char *name;
@@ -79,78 +70,6 @@ static void __init __vdso_init(struct __vdso_info *vdso_in=
fo)
 	vdso_info->cm->pages =3D vdso_pagelist;
 }
=20
-#ifdef CONFIG_TIME_NS
-struct vdso_data *arch_get_vdso_data(void *vvar_page)
-{
-	return (struct vdso_data *)(vvar_page);
-}
-
-static const struct vm_special_mapping rv_vvar_map;
-
-/*
- * The vvar mapping contains data for a specific time namespace, so when a t=
ask
- * changes namespace we must unmap its vvar data for the old namespace.
- * Subsequent faults will map in data for the new namespace.
- *
- * For more details see timens_setup_vdso_data().
- */
-int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
-{
-	struct mm_struct *mm =3D task->mm;
-	struct vm_area_struct *vma;
-	VMA_ITERATOR(vmi, mm, 0);
-
-	mmap_read_lock(mm);
-
-	for_each_vma(vmi, vma) {
-		if (vma_is_special_mapping(vma, &rv_vvar_map))
-			zap_vma_pages(vma);
-	}
-
-	mmap_read_unlock(mm);
-	return 0;
-}
-#endif
-
-static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
-			     struct vm_area_struct *vma, struct vm_fault *vmf)
-{
-	struct page *timens_page =3D find_timens_vvar_page(vma);
-	unsigned long pfn;
-
-	switch (vmf->pgoff) {
-	case VVAR_DATA_PAGE_OFFSET:
-		if (timens_page)
-			pfn =3D page_to_pfn(timens_page);
-		else
-			pfn =3D sym_to_pfn(vdso_data);
-		break;
-#ifdef CONFIG_TIME_NS
-	case VVAR_TIMENS_PAGE_OFFSET:
-		/*
-		 * If a task belongs to a time namespace then a namespace
-		 * specific VVAR is mapped with the VVAR_DATA_PAGE_OFFSET and
-		 * the real VVAR page is mapped with the VVAR_TIMENS_PAGE_OFFSET
-		 * offset.
-		 * See also the comment near timens_setup_vdso_data().
-		 */
-		if (!timens_page)
-			return VM_FAULT_SIGBUS;
-		pfn =3D sym_to_pfn(vdso_data);
-		break;
-#endif /* CONFIG_TIME_NS */
-	default:
-		return VM_FAULT_SIGBUS;
-	}
-
-	return vmf_insert_pfn(vma, vmf->address, pfn);
-}
-
-static const struct vm_special_mapping rv_vvar_map =3D {
-	.name   =3D "[vvar]",
-	.fault =3D vvar_fault,
-};
-
 static struct vm_special_mapping rv_vdso_map __ro_after_init =3D {
 	.name   =3D "[vdso]",
 	.mremap =3D vdso_mremap,
@@ -196,7 +115,7 @@ static int __setup_additional_pages(struct mm_struct *mm,
 	unsigned long vdso_base, vdso_text_len, vdso_mapping_len;
 	void *ret;
=20
-	BUILD_BUG_ON(VVAR_NR_PAGES !=3D __VVAR_PAGES);
+	BUILD_BUG_ON(VDSO_NR_PAGES !=3D __VDSO_PAGES);
=20
 	vdso_text_len =3D vdso_info->vdso_pages << PAGE_SHIFT;
 	/* Be sure to map the data page */
@@ -208,8 +127,7 @@ static int __setup_additional_pages(struct mm_struct *mm,
 		goto up_fail;
 	}
=20
-	ret =3D _install_special_mapping(mm, vdso_base, VVAR_SIZE,
-		(VM_READ | VM_MAYREAD | VM_PFNMAP), &rv_vvar_map);
+	ret =3D vdso_install_vvar_mapping(mm, vdso_base);
 	if (IS_ERR(ret))
 		goto up_fail;
=20
diff --git a/arch/riscv/kernel/vdso/hwprobe.c b/arch/riscv/kernel/vdso/hwprob=
e.c
index a158c02..2ddeba6 100644
--- a/arch/riscv/kernel/vdso/hwprobe.c
+++ b/arch/riscv/kernel/vdso/hwprobe.c
@@ -16,8 +16,7 @@ static int riscv_vdso_get_values(struct riscv_hwprobe *pair=
s, size_t pair_count,
 				 size_t cpusetsize, unsigned long *cpus,
 				 unsigned int flags)
 {
-	const struct vdso_data *vd =3D __arch_get_vdso_data();
-	const struct arch_vdso_time_data *avd =3D &vd->arch_data;
+	const struct vdso_arch_data *avd =3D &vdso_u_arch_data;
 	bool all_cpus =3D !cpusetsize && !cpus;
 	struct riscv_hwprobe *p =3D pairs;
 	struct riscv_hwprobe *end =3D pairs + pair_count;
@@ -51,8 +50,7 @@ static int riscv_vdso_get_cpus(struct riscv_hwprobe *pairs,=
 size_t pair_count,
 			       size_t cpusetsize, unsigned long *cpus,
 			       unsigned int flags)
 {
-	const struct vdso_data *vd =3D __arch_get_vdso_data();
-	const struct arch_vdso_time_data *avd =3D &vd->arch_data;
+	const struct vdso_arch_data *avd =3D &vdso_u_arch_data;
 	struct riscv_hwprobe *p =3D pairs;
 	struct riscv_hwprobe *end =3D pairs + pair_count;
 	unsigned char *c =3D (unsigned char *)cpus;
diff --git a/arch/riscv/kernel/vdso/vdso.lds.S b/arch/riscv/kernel/vdso/vdso.=
lds.S
index cbe2a17..8e86965 100644
--- a/arch/riscv/kernel/vdso/vdso.lds.S
+++ b/arch/riscv/kernel/vdso/vdso.lds.S
@@ -4,15 +4,14 @@
  */
 #include <asm/page.h>
 #include <asm/vdso.h>
+#include <vdso/datapage.h>
=20
 OUTPUT_ARCH(riscv)
=20
 SECTIONS
 {
-	PROVIDE(_vdso_data =3D . - __VVAR_PAGES * PAGE_SIZE);
-#ifdef CONFIG_TIME_NS
-	PROVIDE(_timens_data =3D _vdso_data + PAGE_SIZE);
-#endif
+	VDSO_VVAR_SYMS
+
 	. =3D SIZEOF_HEADERS;
=20
 	.hash		: { *(.hash) }			:text

