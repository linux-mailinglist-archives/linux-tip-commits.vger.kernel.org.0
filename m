Return-Path: <linux-tip-commits+bounces-3546-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F9DEA3EF63
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 10:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19BEA16C8EE
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 09:03:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC8CC203704;
	Fri, 21 Feb 2025 09:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OHRJLl2I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="swj7Rp2k"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBACA1FFC68;
	Fri, 21 Feb 2025 09:03:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128591; cv=none; b=GwwmZUk44yeIsMpqCe2isu625qHxsbpHqxBDW0DdZc2tMBLdecZMKCbrFaKVW1NAVr1b3nS9q8J+lYCf3rLbz1oL9D0uOMy70gCigjsu7UsVs9ZZRdT+dCezEx6m7FDhm+GrOV0abQiWjaaf9TzwjDd6pUd6p9fLDQu5phzt+zI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128591; c=relaxed/simple;
	bh=G3rYhftoy5elgAFLb4H36/NZFdGTwQqXvo6DE3eKXUo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FOjPKrOEpWFyLOkLtrOhykjPaQroOkoesqHy/EPZjLym5y3YhRGxkWEHAQ6t/IYMgfMrbQEUbN05wTFtxnPvyLn/4ALRowXwRsUxBmUeJhZ7JhPNSy2Vz2r4ghCy87UUNoJeX+FFeT/0YKek44aTlISUfhTzaryNbFrr+/69zqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OHRJLl2I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=swj7Rp2k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 09:03:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740128588;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a7RX/cUCYMoUqsxfgDG6QPSn5CctAmA/WYiJSZ+efqY=;
	b=OHRJLl2IDuBTjLz+9VyahSm5q4ciJ1/kRq40ZsI+LT5iTL0dS5CpCqAH3P6pSVHZaeRO7f
	TrrBoSYqEjt4ydDUHXcS7TqO4mYwWrsbkuWRZvNYsWSOkMY79WTNCmoh00jVe9xNU0ucBn
	ZREKq2xBPcyMgb2W3Wh1X/0hfpbxNZ9af2gyrP+lpQo+4WuxLLLW/KKAzlcMxAcjrE7BH7
	1bQrWsHhZStXq5MY7/MjxP37lArtDaFHEpfmN35UpvTMogpVDzltYGkirnFYgIlpxiBv35
	jAHyIm92vU/TaNrp4lIXDJ0Sa6ODao+PXWRdw7Ua/bjOY7Juci2Ykn1wDGOvKQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740128588;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a7RX/cUCYMoUqsxfgDG6QPSn5CctAmA/WYiJSZ+efqY=;
	b=swj7Rp2kVhCT0aWX64R2xW7+0XKfCVHlCk7MAi6x4fDqcHIMme9fvEQTY7bd0U08kdQMgU
	117W9FbisM9QgKBg==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] x86/vdso: Switch to generic storage implementation
Cc: Nam Cao <namcao@linutronix.de>, thomas.weissschuh@linutronix.de,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250204-vdso-store-rng-v3-15-13a4669dfc8c@linutronix.de>
References: <20250204-vdso-store-rng-v3-15-13a4669dfc8c@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174012858752.10177.9443419827746772026.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     dafde29605ebf214747e7602f4f22d3f617373a5
Gitweb:        https://git.kernel.org/tip/dafde29605ebf214747e7602f4f22d3f617=
373a5
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 04 Feb 2025 13:05:47 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 Feb 2025 09:54:02 +01:00

x86/vdso: Switch to generic storage implementation

The generic storage implementation provides the same features as the
custom one. However it can be shared between architectures, making
maintenance easier.

This switch also moves the random state data out of the time data page.
The currently used hardcoded __VDSO_RND_DATA_OFFSET does not take into
account changes to the time data page layout.

Co-developed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250204-vdso-store-rng-v3-15-13a4669dfc8c@=
linutronix.de

---
 arch/x86/Kconfig                         |   1 +-
 arch/x86/entry/vdso/vdso-layout.lds.S    |  14 +--
 arch/x86/entry/vdso/vma.c                | 123 +---------------------
 arch/x86/include/asm/vdso/getrandom.h    |  10 +--
 arch/x86/include/asm/vdso/gettimeofday.h |  25 +----
 arch/x86/include/asm/vdso/vsyscall.h     |  24 +----
 6 files changed, 19 insertions(+), 178 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 87198d9..e66ffd9 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -178,6 +178,7 @@ config X86
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
+	select GENERIC_VDSO_DATA_STORE
 	select GENERIC_VDSO_TIME_NS
 	select GENERIC_VDSO_OVERFLOW_PROTECT
 	select GUP_GET_PXX_LOW_HIGH		if X86_PAE
diff --git a/arch/x86/entry/vdso/vdso-layout.lds.S b/arch/x86/entry/vdso/vdso=
-layout.lds.S
index 918606f..e5cecdb 100644
--- a/arch/x86/entry/vdso/vdso-layout.lds.S
+++ b/arch/x86/entry/vdso/vdso-layout.lds.S
@@ -1,6 +1,7 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #include <asm/vdso.h>
 #include <asm/vdso/vsyscall.h>
+#include <vdso/datapage.h>
=20
 /*
  * Linker script for vDSO.  This is an ELF shared object prelinked to
@@ -17,17 +18,16 @@ SECTIONS
 	 * segment.
 	 */
=20
-	vvar_start =3D . - __VVAR_PAGES * PAGE_SIZE;
-	vvar_page  =3D vvar_start;
+	VDSO_VVAR_SYMS
=20
-	vdso_rng_data =3D vvar_page + __VDSO_RND_DATA_OFFSET;
-
-	timens_page  =3D vvar_start + PAGE_SIZE;
-
-	vclock_pages =3D VDSO_VCLOCK_PAGES_START(vvar_start);
+	vclock_pages =3D VDSO_VCLOCK_PAGES_START(vdso_u_data);
 	pvclock_page =3D vclock_pages + VDSO_PAGE_PVCLOCK_OFFSET * PAGE_SIZE;
 	hvclock_page =3D vclock_pages + VDSO_PAGE_HVCLOCK_OFFSET * PAGE_SIZE;
=20
+	/* For compatibility with vdso2c */
+	vvar_page =3D vdso_u_data;
+	vvar_start =3D vdso_u_data;
+
 	. =3D SIZEOF_HEADERS;
=20
 	.hash		: { *(.hash) }			:text
diff --git a/arch/x86/entry/vdso/vma.c b/arch/x86/entry/vdso/vma.c
index aa62949..7245e95 100644
--- a/arch/x86/entry/vdso/vma.c
+++ b/arch/x86/entry/vdso/vma.c
@@ -14,7 +14,7 @@
 #include <linux/elf.h>
 #include <linux/cpu.h>
 #include <linux/ptrace.h>
-#include <linux/time_namespace.h>
+#include <linux/vdso_datastore.h>
=20
 #include <asm/pvclock.h>
 #include <asm/vgtod.h>
@@ -27,13 +27,7 @@
 #include <asm/vdso/vsyscall.h>
 #include <clocksource/hyperv_timer.h>
=20
-struct vdso_data *arch_get_vdso_data(void *vvar_page)
-{
-	return (struct vdso_data *)vvar_page;
-}
-
-static union vdso_data_store vdso_data_store __page_aligned_data;
-struct vdso_data *vdso_data =3D vdso_data_store.data;
+static_assert(VDSO_NR_PAGES + VDSO_NR_VCLOCK_PAGES =3D=3D __VDSO_PAGES);
=20
 unsigned int vclocks_used __read_mostly;
=20
@@ -54,7 +48,6 @@ int __init init_vdso_image(const struct vdso_image *image)
 	return 0;
 }
=20
-static const struct vm_special_mapping vvar_mapping;
 struct linux_binprm;
=20
 static vm_fault_t vdso_fault(const struct vm_special_mapping *sm,
@@ -98,99 +91,6 @@ static int vdso_mremap(const struct vm_special_mapping *sm,
 	return 0;
 }
=20
-#ifdef CONFIG_TIME_NS
-/*
- * The vvar page layout depends on whether a task belongs to the root or
- * non-root time namespace. Whenever a task changes its namespace, the VVAR
- * page tables are cleared and then they will re-faulted with a
- * corresponding layout.
- * See also the comment near timens_setup_vdso_data() for details.
- */
-int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
-{
-	struct mm_struct *mm =3D task->mm;
-	struct vm_area_struct *vma;
-	VMA_ITERATOR(vmi, mm, 0);
-
-	mmap_read_lock(mm);
-	for_each_vma(vmi, vma) {
-		if (vma_is_special_mapping(vma, &vvar_mapping))
-			zap_vma_pages(vma);
-	}
-	mmap_read_unlock(mm);
-
-	return 0;
-}
-#endif
-
-static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
-		      struct vm_area_struct *vma, struct vm_fault *vmf)
-{
-	const struct vdso_image *image =3D vma->vm_mm->context.vdso_image;
-	unsigned long pfn;
-	long sym_offset;
-
-	if (!image)
-		return VM_FAULT_SIGBUS;
-
-	sym_offset =3D (long)(vmf->pgoff << PAGE_SHIFT) +
-		image->sym_vvar_start;
-
-	/*
-	 * Sanity check: a symbol offset of zero means that the page
-	 * does not exist for this vdso image, not that the page is at
-	 * offset zero relative to the text mapping.  This should be
-	 * impossible here, because sym_offset should only be zero for
-	 * the page past the end of the vvar mapping.
-	 */
-	if (sym_offset =3D=3D 0)
-		return VM_FAULT_SIGBUS;
-
-	if (sym_offset =3D=3D image->sym_vvar_page) {
-		struct page *timens_page =3D find_timens_vvar_page(vma);
-
-		pfn =3D __pa_symbol(vdso_data) >> PAGE_SHIFT;
-
-		/*
-		 * If a task belongs to a time namespace then a namespace
-		 * specific VVAR is mapped with the sym_vvar_page offset and
-		 * the real VVAR page is mapped with the sym_timens_page
-		 * offset.
-		 * See also the comment near timens_setup_vdso_data().
-		 */
-		if (timens_page) {
-			unsigned long addr;
-			vm_fault_t err;
-
-			/*
-			 * Optimization: inside time namespace pre-fault
-			 * VVAR page too. As on timens page there are only
-			 * offsets for clocks on VVAR, it'll be faulted
-			 * shortly by VDSO code.
-			 */
-			addr =3D vmf->address + (image->sym_timens_page - sym_offset);
-			err =3D vmf_insert_pfn(vma, addr, pfn);
-			if (unlikely(err & VM_FAULT_ERROR))
-				return err;
-
-			pfn =3D page_to_pfn(timens_page);
-		}
-
-		return vmf_insert_pfn(vma, vmf->address, pfn);
-
-	} else if (sym_offset =3D=3D image->sym_timens_page) {
-		struct page *timens_page =3D find_timens_vvar_page(vma);
-
-		if (!timens_page)
-			return VM_FAULT_SIGBUS;
-
-		pfn =3D __pa_symbol(vdso_data) >> PAGE_SHIFT;
-		return vmf_insert_pfn(vma, vmf->address, pfn);
-	}
-
-	return VM_FAULT_SIGBUS;
-}
-
 static vm_fault_t vvar_vclock_fault(const struct vm_special_mapping *sm,
 				    struct vm_area_struct *vma, struct vm_fault *vmf)
 {
@@ -212,7 +112,6 @@ static vm_fault_t vvar_vclock_fault(const struct vm_speci=
al_mapping *sm,
 	case VDSO_PAGE_HVCLOCK_OFFSET:
 	{
 		unsigned long pfn =3D hv_get_tsc_pfn();
-
 		if (pfn && vclock_was_used(VDSO_CLOCKMODE_HVCLOCK))
 			return vmf_insert_pfn(vma, vmf->address, pfn);
 		break;
@@ -228,10 +127,6 @@ static const struct vm_special_mapping vdso_mapping =3D {
 	.fault =3D vdso_fault,
 	.mremap =3D vdso_mremap,
 };
-static const struct vm_special_mapping vvar_mapping =3D {
-	.name =3D "[vvar]",
-	.fault =3D vvar_fault,
-};
 static const struct vm_special_mapping vvar_vclock_mapping =3D {
 	.name =3D "[vvar_vclock]",
 	.fault =3D vvar_vclock_fault,
@@ -253,13 +148,13 @@ static int map_vdso(const struct vdso_image *image, uns=
igned long addr)
 		return -EINTR;
=20
 	addr =3D get_unmapped_area(NULL, addr,
-				 image->size - image->sym_vvar_start, 0, 0);
+				 image->size + __VDSO_PAGES * PAGE_SIZE, 0, 0);
 	if (IS_ERR_VALUE(addr)) {
 		ret =3D addr;
 		goto up_fail;
 	}
=20
-	text_start =3D addr - image->sym_vvar_start;
+	text_start =3D addr + __VDSO_PAGES * PAGE_SIZE;
=20
 	/*
 	 * MAYWRITE to allow gdb to COW and set breakpoints
@@ -276,13 +171,7 @@ static int map_vdso(const struct vdso_image *image, unsi=
gned long addr)
 		goto up_fail;
 	}
=20
-	vma =3D _install_special_mapping(mm,
-				       addr,
-				       (__VVAR_PAGES - VDSO_NR_VCLOCK_PAGES) * PAGE_SIZE,
-				       VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|
-				       VM_PFNMAP,
-				       &vvar_mapping);
-
+	vma =3D vdso_install_vvar_mapping(mm, addr);
 	if (IS_ERR(vma)) {
 		ret =3D PTR_ERR(vma);
 		do_munmap(mm, text_start, image->size, NULL);
@@ -327,7 +216,7 @@ int map_vdso_once(const struct vdso_image *image, unsigne=
d long addr)
 	 */
 	for_each_vma(vmi, vma) {
 		if (vma_is_special_mapping(vma, &vdso_mapping) ||
-				vma_is_special_mapping(vma, &vvar_mapping) ||
+				vma_is_special_mapping(vma, &vdso_vvar_mapping) ||
 				vma_is_special_mapping(vma, &vvar_vclock_mapping)) {
 			mmap_write_unlock(mm);
 			return -EEXIST;
diff --git a/arch/x86/include/asm/vdso/getrandom.h b/arch/x86/include/asm/vds=
o/getrandom.h
index 2bf9c0e..af85539 100644
--- a/arch/x86/include/asm/vdso/getrandom.h
+++ b/arch/x86/include/asm/vdso/getrandom.h
@@ -27,16 +27,6 @@ static __always_inline ssize_t getrandom_syscall(void *buf=
fer, size_t len, unsig
 	return ret;
 }
=20
-extern struct vdso_rng_data vdso_rng_data
-	__attribute__((visibility("hidden")));
-
-static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(=
void)
-{
-	if (IS_ENABLED(CONFIG_TIME_NS) && __arch_get_vdso_data()->clock_mode =3D=3D=
 VDSO_CLOCKMODE_TIMENS)
-		return (void *)&vdso_rng_data + ((void *)&timens_page - (void *)__arch_get=
_vdso_data());
-	return &vdso_rng_data;
-}
-
 #endif /* !__ASSEMBLY__ */
=20
 #endif /* __ASM_VDSO_GETRANDOM_H */
diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/=
vdso/gettimeofday.h
index 375a34b..edec796 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -19,12 +19,6 @@
 #include <asm/pvclock.h>
 #include <clocksource/hyperv_timer.h>
=20
-extern struct vdso_data vvar_page
-	__attribute__((visibility("hidden")));
-
-extern struct vdso_data timens_page
-	__attribute__((visibility("hidden")));
-
 #define VDSO_HAS_TIME 1
=20
 #define VDSO_HAS_CLOCK_GETRES 1
@@ -59,14 +53,6 @@ extern struct ms_hyperv_tsc_page hvclock_page
 	__attribute__((visibility("hidden")));
 #endif
=20
-#ifdef CONFIG_TIME_NS
-static __always_inline
-const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *=
vd)
-{
-	return &timens_page;
-}
-#endif
-
 #ifndef BUILD_VDSO32
=20
 static __always_inline
@@ -250,7 +236,7 @@ static u64 vread_hvclock(void)
 #endif
=20
 static inline u64 __arch_get_hw_counter(s32 clock_mode,
-					const struct vdso_data *vd)
+					const struct vdso_time_data *vd)
 {
 	if (likely(clock_mode =3D=3D VDSO_CLOCKMODE_TSC))
 		return (u64)rdtsc_ordered() & S64_MAX;
@@ -275,12 +261,7 @@ static inline u64 __arch_get_hw_counter(s32 clock_mode,
 	return U64_MAX;
 }
=20
-static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
-{
-	return &vvar_page;
-}
-
-static inline bool arch_vdso_clocksource_ok(const struct vdso_data *vd)
+static inline bool arch_vdso_clocksource_ok(const struct vdso_time_data *vd)
 {
 	return true;
 }
@@ -319,7 +300,7 @@ static inline bool arch_vdso_cycles_ok(u64 cycles)
  * declares everything with the MSB/Sign-bit set as invalid. Therefore the
  * effective mask is S64_MAX.
  */
-static __always_inline u64 vdso_calc_ns(const struct vdso_data *vd, u64 cycl=
es, u64 base)
+static __always_inline u64 vdso_calc_ns(const struct vdso_time_data *vd, u64=
 cycles, u64 base)
 {
 	u64 delta =3D cycles - vd->cycle_last;
=20
diff --git a/arch/x86/include/asm/vdso/vsyscall.h b/arch/x86/include/asm/vdso=
/vsyscall.h
index 88b31d4..ebbf634 100644
--- a/arch/x86/include/asm/vdso/vsyscall.h
+++ b/arch/x86/include/asm/vdso/vsyscall.h
@@ -2,11 +2,10 @@
 #ifndef __ASM_VDSO_VSYSCALL_H
 #define __ASM_VDSO_VSYSCALL_H
=20
-#define __VDSO_RND_DATA_OFFSET  640
-#define __VVAR_PAGES	4
+#define __VDSO_PAGES	6
=20
 #define VDSO_NR_VCLOCK_PAGES	2
-#define VDSO_VCLOCK_PAGES_START(_b)	((_b) + (__VVAR_PAGES - VDSO_NR_VCLOCK_P=
AGES) * PAGE_SIZE)
+#define VDSO_VCLOCK_PAGES_START(_b)	((_b) + (__VDSO_PAGES - VDSO_NR_VCLOCK_P=
AGES) * PAGE_SIZE)
 #define VDSO_PAGE_PVCLOCK_OFFSET	0
 #define VDSO_PAGE_HVCLOCK_OFFSET	1
=20
@@ -15,25 +14,6 @@
 #include <vdso/datapage.h>
 #include <asm/vgtod.h>
=20
-extern struct vdso_data *vdso_data;
-
-/*
- * Update the vDSO data page to keep in sync with kernel timekeeping.
- */
-static __always_inline
-struct vdso_data *__x86_get_k_vdso_data(void)
-{
-	return vdso_data;
-}
-#define __arch_get_k_vdso_data __x86_get_k_vdso_data
-
-static __always_inline
-struct vdso_rng_data *__x86_get_k_vdso_rng_data(void)
-{
-	return (void *)vdso_data + __VDSO_RND_DATA_OFFSET;
-}
-#define __arch_get_k_vdso_rng_data __x86_get_k_vdso_rng_data
-
 /* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
=20

