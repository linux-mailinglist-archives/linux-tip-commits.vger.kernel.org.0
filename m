Return-Path: <linux-tip-commits+bounces-3549-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 96FEDA3EF6C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 10:04:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE6BA19C1F4A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 09:04:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B58DE2045A6;
	Fri, 21 Feb 2025 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L6rMXisy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0ES11IQJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549C5204081;
	Fri, 21 Feb 2025 09:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128594; cv=none; b=GutVE96Q9No5Jr7elxADLPJIoLeVyURWRzNOF2lZxtTCTahs61CD/eYuvQyvPGp1sxEb+HrIHT0Dlk0j2Ble5Q8nhb8ELBC/pws6uHFzk2bvtQLcSGjTkg+ZllVKeKgpRKKrZqfoBGSPLcKZStzKdHmAlEMial1qfgDVuB/J19k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128594; c=relaxed/simple;
	bh=bD7HiUv3O1IKWcAlGneBoJ9yl1MpG5JNX9Gc9F+WXsM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VZpY4eyDYb2qMEk17dHlR1Bz3QvQ5MHKWia+WR0Kuc11BIqL+1tWee4oumPM2t+u1xAKeDFcfgW2vO0H6+SrZe/4I37SHmfsAoJecKBy6yMdoaukvDg4HUMHZ/WrxBxmXSEI2QIlvVc6NQF1NiUNjZsPfuw6AFATEbuaSvaj5xs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L6rMXisy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0ES11IQJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 09:03:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740128590;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oAJNzBSTF9R7ZZmMbhKDgU78YljXAsj5aKMihuUrWro=;
	b=L6rMXisyKeAunl8EWJkNxwlNOBADvKtnSfgd63CoZHZBXimLLwudS4+ZD01uRVlaqHe038
	yD7jpVbTYhxKvVMMrgAeXP34Vb9QiITQGLKJFhS1x6h7KfstAwCzUKUiJYIKRwMnJv8J1w
	tPHGNLL47Lyhu3sHVj/Qf2ZMZ5AMwMCuA8lmbO50fDp2anEjbcVGntF7GeIRHtKhJdeGYP
	gOkyCgJvsAbMqc05NdYfOvKPJ8c3Q2LEPxsK0A2pka2z7isqy4rI9yoZ5Q35XxcI+89q9o
	lhB24Czfdo2nTeiwx3yLU7uhY/LquR8KwdHJY5H7YAexsHper0mxqzQCEhMtPQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740128590;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oAJNzBSTF9R7ZZmMbhKDgU78YljXAsj5aKMihuUrWro=;
	b=0ES11IQJS2PrcQU4fyGgT/Qv4gzrIQPHdKfAn2WfDRlQF2TI+w1f9rbSAMViM1ADIEtdYW
	xCj/eCuGMsanT+AQ==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] s390/vdso: Switch to generic storage implementation
Cc: Nam Cao <namcao@linutronix.de>, thomas.weissschuh@linutronix.de,
 Thomas Gleixner <tglx@linutronix.de>, Heiko Carstens <hca@linux.ibm.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250204-vdso-store-rng-v3-12-13a4669dfc8c@linutronix.de>
References: <20250204-vdso-store-rng-v3-12-13a4669dfc8c@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174012858991.10177.13406625608634104710.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     9bf39a65b20cd03b10c618b1b1c4703538a5b564
Gitweb:        https://git.kernel.org/tip/9bf39a65b20cd03b10c618b1b1c4703538a=
5b564
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 04 Feb 2025 13:05:44 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 Feb 2025 09:54:02 +01:00

s390/vdso: Switch to generic storage implementation

The generic storage implementation provides the same features as the
custom one. However it can be shared between architectures, making
maintenance easier.

Co-developed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Link: https://lore.kernel.org/all/20250204-vdso-store-rng-v3-12-13a4669dfc8c@=
linutronix.de

---
 arch/s390/Kconfig                         |  1 +-
 arch/s390/include/asm/vdso.h              |  4 +-
 arch/s390/include/asm/vdso/getrandom.h    | 12 +---
 arch/s390/include/asm/vdso/gettimeofday.h | 15 +---
 arch/s390/include/asm/vdso/vsyscall.h     | 20 +-----
 arch/s390/kernel/time.c                   |  6 +-
 arch/s390/kernel/vdso.c                   | 97 +---------------------
 arch/s390/kernel/vdso32/vdso32.lds.S      |  7 +--
 arch/s390/kernel/vdso64/vdso64.lds.S      |  8 +--
 9 files changed, 17 insertions(+), 153 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 9c9ec08..7ed6f22 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -166,6 +166,7 @@ config S390
 	select GENERIC_PTDUMP
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
+	select GENERIC_VDSO_DATA_STORE
 	select GENERIC_VDSO_TIME_NS
 	select GENERIC_IOREMAP if PCI
 	select HAVE_ALIGNED_STRUCT_PAGE
diff --git a/arch/s390/include/asm/vdso.h b/arch/s390/include/asm/vdso.h
index 92c73e4..420a073 100644
--- a/arch/s390/include/asm/vdso.h
+++ b/arch/s390/include/asm/vdso.h
@@ -6,13 +6,11 @@
=20
 #ifndef __ASSEMBLY__
=20
-extern struct vdso_data *vdso_data;
-
 int vdso_getcpu_init(void);
=20
 #endif /* __ASSEMBLY__ */
=20
-#define __VVAR_PAGES	2
+#define __VDSO_PAGES	4
=20
 #define VDSO_VERSION_STRING	LINUX_2.6.29
=20
diff --git a/arch/s390/include/asm/vdso/getrandom.h b/arch/s390/include/asm/v=
dso/getrandom.h
index 36355af..f8713ce 100644
--- a/arch/s390/include/asm/vdso/getrandom.h
+++ b/arch/s390/include/asm/vdso/getrandom.h
@@ -23,18 +23,6 @@ static __always_inline ssize_t getrandom_syscall(void *buf=
fer, size_t len, unsig
 	return syscall3(__NR_getrandom, (long)buffer, (long)len, (long)flags);
 }
=20
-static __always_inline const struct vdso_rng_data *__arch_get_vdso_rng_data(=
void)
-{
-	/*
-	 * The RNG data is in the real VVAR data page, but if a task belongs to a t=
ime namespace
-	 * then VVAR_DATA_PAGE_OFFSET points to the namespace-specific VVAR page an=
d VVAR_TIMENS_
-	 * PAGE_OFFSET points to the real VVAR page.
-	 */
-	if (IS_ENABLED(CONFIG_TIME_NS) && _vdso_data->clock_mode =3D=3D VDSO_CLOCKM=
ODE_TIMENS)
-		return (void *)&_vdso_rng_data + VVAR_TIMENS_PAGE_OFFSET * PAGE_SIZE;
-	return &_vdso_rng_data;
-}
-
 #endif /* !__ASSEMBLY__ */
=20
 #endif /* __ASM_VDSO_GETRANDOM_H */
diff --git a/arch/s390/include/asm/vdso/gettimeofday.h b/arch/s390/include/as=
m/vdso/gettimeofday.h
index 7937765..fb45643 100644
--- a/arch/s390/include/asm/vdso/gettimeofday.h
+++ b/arch/s390/include/asm/vdso/gettimeofday.h
@@ -14,12 +14,7 @@
 #include <linux/compiler.h>
=20
=20
-static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
-{
-	return _vdso_data;
-}
-
-static inline u64 __arch_get_hw_counter(s32 clock_mode, const struct vdso_da=
ta *vd)
+static inline u64 __arch_get_hw_counter(s32 clock_mode, const struct vdso_ti=
me_data *vd)
 {
 	u64 adj, now;
=20
@@ -49,12 +44,4 @@ long clock_getres_fallback(clockid_t clkid, struct __kerne=
l_timespec *ts)
 	return syscall2(__NR_clock_getres, (long)clkid, (long)ts);
 }
=20
-#ifdef CONFIG_TIME_NS
-static __always_inline
-const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *=
vd)
-{
-	return _timens_data;
-}
-#endif
-
 #endif
diff --git a/arch/s390/include/asm/vdso/vsyscall.h b/arch/s390/include/asm/vd=
so/vsyscall.h
index 3eb576e..d346ebe 100644
--- a/arch/s390/include/asm/vdso/vsyscall.h
+++ b/arch/s390/include/asm/vdso/vsyscall.h
@@ -2,32 +2,12 @@
 #ifndef __ASM_VDSO_VSYSCALL_H
 #define __ASM_VDSO_VSYSCALL_H
=20
-#define __VDSO_RND_DATA_OFFSET	768
-
 #ifndef __ASSEMBLY__
=20
 #include <linux/hrtimer.h>
 #include <vdso/datapage.h>
 #include <asm/vdso.h>
=20
-enum vvar_pages {
-	VVAR_DATA_PAGE_OFFSET,
-	VVAR_TIMENS_PAGE_OFFSET,
-	VVAR_NR_PAGES
-};
-
-static __always_inline struct vdso_data *__s390_get_k_vdso_data(void)
-{
-	return vdso_data;
-}
-#define __arch_get_k_vdso_data __s390_get_k_vdso_data
-
-static __always_inline struct vdso_rng_data *__s390_get_k_vdso_rnd_data(void)
-{
-	return (void *)vdso_data + __VDSO_RND_DATA_OFFSET;
-}
-#define __arch_get_k_vdso_rng_data __s390_get_k_vdso_rnd_data
-
 /* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
=20
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index e9f47c3..41ca358 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -84,7 +84,7 @@ void __init time_early_init(void)
 	/* Initialize TOD steering parameters */
 	tod_steering_end =3D tod_clock_base.tod;
 	for (cs =3D 0; cs < CS_BASES; cs++)
-		vdso_data[cs].arch_data.tod_steering_end =3D tod_steering_end;
+		vdso_k_time_data[cs].arch_data.tod_steering_end =3D tod_steering_end;
=20
 	if (!test_facility(28))
 		return;
@@ -390,8 +390,8 @@ static void clock_sync_global(long delta)
 		      tod_steering_delta);
 	tod_steering_end =3D now + (abs(tod_steering_delta) << 15);
 	for (cs =3D 0; cs < CS_BASES; cs++) {
-		vdso_data[cs].arch_data.tod_steering_end =3D tod_steering_end;
-		vdso_data[cs].arch_data.tod_steering_delta =3D tod_steering_delta;
+		vdso_k_time_data[cs].arch_data.tod_steering_end =3D tod_steering_end;
+		vdso_k_time_data[cs].arch_data.tod_steering_delta =3D tod_steering_delta;
 	}
=20
 	/* Update LPAR offset. */
diff --git a/arch/s390/kernel/vdso.c b/arch/s390/kernel/vdso.c
index 598b512..70c8f9a 100644
--- a/arch/s390/kernel/vdso.c
+++ b/arch/s390/kernel/vdso.c
@@ -16,8 +16,8 @@
 #include <linux/mm.h>
 #include <linux/slab.h>
 #include <linux/smp.h>
-#include <linux/time_namespace.h>
 #include <linux/random.h>
+#include <linux/vdso_datastore.h>
 #include <vdso/datapage.h>
 #include <asm/vdso/vsyscall.h>
 #include <asm/alternative.h>
@@ -26,85 +26,6 @@
 extern char vdso64_start[], vdso64_end[];
 extern char vdso32_start[], vdso32_end[];
=20
-static struct vm_special_mapping vvar_mapping;
-
-static union vdso_data_store vdso_data_store __page_aligned_data;
-
-struct vdso_data *vdso_data =3D vdso_data_store.data;
-
-#ifdef CONFIG_TIME_NS
-struct vdso_data *arch_get_vdso_data(void *vvar_page)
-{
-	return (struct vdso_data *)(vvar_page);
-}
-
-/*
- * The VVAR page layout depends on whether a task belongs to the root or
- * non-root time namespace. Whenever a task changes its namespace, the VVAR
- * page tables are cleared and then they will be re-faulted with a
- * corresponding layout.
- * See also the comment near timens_setup_vdso_data() for details.
- */
-int vdso_join_timens(struct task_struct *task, struct time_namespace *ns)
-{
-	struct mm_struct *mm =3D task->mm;
-	VMA_ITERATOR(vmi, mm, 0);
-	struct vm_area_struct *vma;
-
-	mmap_read_lock(mm);
-	for_each_vma(vmi, vma) {
-		if (!vma_is_special_mapping(vma, &vvar_mapping))
-			continue;
-		zap_vma_pages(vma);
-		break;
-	}
-	mmap_read_unlock(mm);
-	return 0;
-}
-#endif
-
-static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
-			     struct vm_area_struct *vma, struct vm_fault *vmf)
-{
-	struct page *timens_page =3D find_timens_vvar_page(vma);
-	unsigned long addr, pfn;
-	vm_fault_t err;
-
-	switch (vmf->pgoff) {
-	case VVAR_DATA_PAGE_OFFSET:
-		pfn =3D virt_to_pfn(vdso_data);
-		if (timens_page) {
-			/*
-			 * Fault in VVAR page too, since it will be accessed
-			 * to get clock data anyway.
-			 */
-			addr =3D vmf->address + VVAR_TIMENS_PAGE_OFFSET * PAGE_SIZE;
-			err =3D vmf_insert_pfn(vma, addr, pfn);
-			if (unlikely(err & VM_FAULT_ERROR))
-				return err;
-			pfn =3D page_to_pfn(timens_page);
-		}
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
-		pfn =3D virt_to_pfn(vdso_data);
-		break;
-#endif /* CONFIG_TIME_NS */
-	default:
-		return VM_FAULT_SIGBUS;
-	}
-	return vmf_insert_pfn(vma, vmf->address, pfn);
-}
-
 static int vdso_mremap(const struct vm_special_mapping *sm,
 		       struct vm_area_struct *vma)
 {
@@ -112,11 +33,6 @@ static int vdso_mremap(const struct vm_special_mapping *s=
m,
 	return 0;
 }
=20
-static struct vm_special_mapping vvar_mapping =3D {
-	.name =3D "[vvar]",
-	.fault =3D vvar_fault,
-};
-
 static struct vm_special_mapping vdso64_mapping =3D {
 	.name =3D "[vdso]",
 	.mremap =3D vdso_mremap,
@@ -142,7 +58,7 @@ static int map_vdso(unsigned long addr, unsigned long vdso=
_mapping_len)
 	struct vm_area_struct *vma;
 	int rc;
=20
-	BUILD_BUG_ON(VVAR_NR_PAGES !=3D __VVAR_PAGES);
+	BUILD_BUG_ON(VDSO_NR_PAGES !=3D __VDSO_PAGES);
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
=20
@@ -157,14 +73,11 @@ static int map_vdso(unsigned long addr, unsigned long vd=
so_mapping_len)
 	rc =3D vvar_start;
 	if (IS_ERR_VALUE(vvar_start))
 		goto out;
-	vma =3D _install_special_mapping(mm, vvar_start, VVAR_NR_PAGES*PAGE_SIZE,
-				       VM_READ|VM_MAYREAD|VM_IO|VM_DONTDUMP|
-				       VM_PFNMAP,
-				       &vvar_mapping);
+	vma =3D vdso_install_vvar_mapping(mm, vvar_start);
 	rc =3D PTR_ERR(vma);
 	if (IS_ERR(vma))
 		goto out;
-	vdso_text_start =3D vvar_start + VVAR_NR_PAGES * PAGE_SIZE;
+	vdso_text_start =3D vvar_start + VDSO_NR_PAGES * PAGE_SIZE;
 	/* VM_MAYWRITE for COW so gdb can set breakpoints */
 	vma =3D _install_special_mapping(mm, vdso_text_start, vdso_text_len,
 				       VM_READ|VM_EXEC|
@@ -220,7 +133,7 @@ unsigned long vdso_text_size(void)
=20
 unsigned long vdso_size(void)
 {
-	return vdso_text_size() + VVAR_NR_PAGES * PAGE_SIZE;
+	return vdso_text_size() + VDSO_NR_PAGES * PAGE_SIZE;
 }
=20
 int arch_setup_additional_pages(struct linux_binprm *bprm, int uses_interp)
diff --git a/arch/s390/kernel/vdso32/vdso32.lds.S b/arch/s390/kernel/vdso32/v=
dso32.lds.S
index c916c4f..9630d58 100644
--- a/arch/s390/kernel/vdso32/vdso32.lds.S
+++ b/arch/s390/kernel/vdso32/vdso32.lds.S
@@ -6,16 +6,15 @@
=20
 #include <asm/page.h>
 #include <asm/vdso.h>
+#include <vdso/datapage.h>
=20
 OUTPUT_FORMAT("elf32-s390", "elf32-s390", "elf32-s390")
 OUTPUT_ARCH(s390:31-bit)
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
diff --git a/arch/s390/kernel/vdso64/vdso64.lds.S b/arch/s390/kernel/vdso64/v=
dso64.lds.S
index ec42b7d..e4f6551 100644
--- a/arch/s390/kernel/vdso64/vdso64.lds.S
+++ b/arch/s390/kernel/vdso64/vdso64.lds.S
@@ -7,17 +7,15 @@
 #include <asm/vdso/vsyscall.h>
 #include <asm/page.h>
 #include <asm/vdso.h>
+#include <vdso/datapage.h>
=20
 OUTPUT_FORMAT("elf64-s390", "elf64-s390", "elf64-s390")
 OUTPUT_ARCH(s390:64-bit)
=20
 SECTIONS
 {
-	PROVIDE(_vdso_data =3D . - __VVAR_PAGES * PAGE_SIZE);
-	PROVIDE(_vdso_rng_data =3D _vdso_data + __VDSO_RND_DATA_OFFSET);
-#ifdef CONFIG_TIME_NS
-	PROVIDE(_timens_data =3D _vdso_data + PAGE_SIZE);
-#endif
+	VDSO_VVAR_SYMS
+
 	. =3D SIZEOF_HEADERS;
=20
 	.hash		: { *(.hash) }			:text

