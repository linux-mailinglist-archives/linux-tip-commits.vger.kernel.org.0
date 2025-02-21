Return-Path: <linux-tip-commits+bounces-3553-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7ED72A3EF72
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 10:05:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0252717EFC3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 09:04:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0CEC202C2E;
	Fri, 21 Feb 2025 09:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tXYBzf23";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wvoIEjDR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC0CD2045AE;
	Fri, 21 Feb 2025 09:03:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128597; cv=none; b=KGk2XSz5vuIxP3lS7q3lJPl6z1cI0X5MZvkA6phx9x/PbEVkM/356uvfSf06t7KoyiVXh1ojPrZWPTeqHzu3GYmx1fLNZjw4+H/safRM71Uo5+DJDvrf1qIhYpCa5N6TuVdEkckcByxzV0P9kirtppn3A3tZpaGvPO3v/wU5sIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128597; c=relaxed/simple;
	bh=cbBw+CH6mN5jwznSsL99VYKXjkSmlo3daHSEM560mbY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=d3Ew7neinIBY8bT9VbJH5S4PZ2ZamAQntbcjDj4gA5KjnZ73pRLLuh5HE6o0ftom5g0nlhJDhKBJYY+Jq4i0+dnTas9muVb+w3p731E/aXRiOmtnp517KK2NASnwpT3CsXrKttzy55+DDMEcRpxmG6AXRV7Cv9OVqfAmF33EbF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tXYBzf23; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wvoIEjDR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 09:03:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740128593;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4EU230fug3fbK7diZLd56Juv3Co1DQhLypgsg7ILK+s=;
	b=tXYBzf23HqBrpsIKPs+AihvsVTjM4EnENBQLM2D3Gx1j9C5G3lFeKz9jrTy1oILEflkEU3
	lQoGjDCp1co37pQGkWJdIwE7pcWBeYNvGs3fTf5a9EB0xfC758qABuSplpoHjva6U8iuQ5
	Fa4TICXhppGhIbMNN3BSomNDKbx6cPFCU9uxOpWTHAPNg7TSJQrsDCNBjmNsxFpxxKdeSP
	DUn4UETl7ZrZnOo0/bSWtAc+ZVoCsoNOrvKTXDYbR8kKq+MoihxCRxBsaeBd/XPu1j2ZHu
	yfNmD+rOjL3+52RmzO/f+hUzdj60cEyYY2rzHscJWq7Z8MJJlcpzagnN+zuESw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740128593;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4EU230fug3fbK7diZLd56Juv3Co1DQhLypgsg7ILK+s=;
	b=wvoIEjDRbI1idViR5oAD7YReJQ3JHHjF/to2yQW6j47ASIWqptG+X3GSU5AQYu47RYsZ8q
	2DKzTUhmXYDh5LDQ==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] arm64: vdso: Switch to generic storage implementation
Cc: Nam Cao <namcao@linutronix.de>, thomas.weissschuh@linutronix.de,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250204-vdso-store-rng-v3-8-13a4669dfc8c@linutronix.de>
References: <20250204-vdso-store-rng-v3-8-13a4669dfc8c@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174012859269.10177.1811677236640207659.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     0b3bc3354eb9ad36719a044726092750a2ba01ff
Gitweb:        https://git.kernel.org/tip/0b3bc3354eb9ad36719a044726092750a2b=
a01ff
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 04 Feb 2025 13:05:40 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 Feb 2025 09:54:01 +01:00

arm64: vdso: Switch to generic storage implementation

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
Link: https://lore.kernel.org/all/20250204-vdso-store-rng-v3-8-13a4669dfc8c@l=
inutronix.de

---
 arch/arm64/Kconfig                                |  1 +-
 arch/arm64/include/asm/vdso.h                     |  2 +-
 arch/arm64/include/asm/vdso/compat_gettimeofday.h | 36 ++----
 arch/arm64/include/asm/vdso/getrandom.h           | 12 +--
 arch/arm64/include/asm/vdso/gettimeofday.h        | 16 +--
 arch/arm64/include/asm/vdso/vsyscall.h            | 25 +----
 arch/arm64/kernel/vdso.c                          | 90 +--------------
 arch/arm64/kernel/vdso/vdso.lds.S                 |  7 +-
 arch/arm64/kernel/vdso32/vdso.lds.S               |  7 +-
 9 files changed, 26 insertions(+), 170 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index fcdd0ed..3770b73 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -162,6 +162,7 @@ config ARM64
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
+	select GENERIC_VDSO_DATA_STORE
 	select GENERIC_VDSO_TIME_NS
 	select HARDIRQS_SW_RESEND
 	select HAS_IOPORT
diff --git a/arch/arm64/include/asm/vdso.h b/arch/arm64/include/asm/vdso.h
index 3e3c3fd..6167907 100644
--- a/arch/arm64/include/asm/vdso.h
+++ b/arch/arm64/include/asm/vdso.h
@@ -5,7 +5,7 @@
 #ifndef __ASM_VDSO_H
 #define __ASM_VDSO_H
=20
-#define __VVAR_PAGES    2
+#define __VDSO_PAGES    4
=20
 #ifndef __ASSEMBLY__
=20
diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/i=
nclude/asm/vdso/compat_gettimeofday.h
index 778c120..957ee12 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -104,7 +104,7 @@ int clock_getres32_fallback(clockid_t _clkid, struct old_=
timespec32 *_ts)
 }
=20
 static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
-						 const struct vdso_data *vd)
+						 const struct vdso_time_data *vd)
 {
 	u64 res;
=20
@@ -131,43 +131,31 @@ static __always_inline u64 __arch_get_hw_counter(s32 cl=
ock_mode,
 	return res;
 }
=20
-static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
+static __always_inline const struct vdso_time_data *__arch_get_vdso_u_time_d=
ata(void)
 {
-	const struct vdso_data *ret;
+	const struct vdso_time_data *ret;
=20
 	/*
-	 * This simply puts &_vdso_data into ret. The reason why we don't use
-	 * `ret =3D _vdso_data` is that the compiler tends to optimise this in a
-	 * very suboptimal way: instead of keeping &_vdso_data in a register,
-	 * it goes through a relocation almost every time _vdso_data must be
+	 * This simply puts &_vdso_time_data into ret. The reason why we don't use
+	 * `ret =3D _vdso_time_data` is that the compiler tends to optimise this in=
 a
+	 * very suboptimal way: instead of keeping &_vdso_time_data in a register,
+	 * it goes through a relocation almost every time _vdso_time_data must be
 	 * accessed (even in subfunctions). This is both time and space
 	 * consuming: each relocation uses a word in the code section, and it
 	 * has to be loaded at runtime.
 	 *
 	 * This trick hides the assignment from the compiler. Since it cannot
 	 * track where the pointer comes from, it will only use one relocation
-	 * where __arch_get_vdso_data() is called, and then keep the result in
-	 * a register.
+	 * where __aarch64_get_vdso_u_time_data() is called, and then keep the
+	 * result in a register.
 	 */
-	asm volatile("mov %0, %1" : "=3Dr"(ret) : "r"(_vdso_data));
+	asm volatile("mov %0, %1" : "=3Dr"(ret) : "r"(vdso_u_time_data));
=20
 	return ret;
 }
+#define __arch_get_vdso_u_time_data __arch_get_vdso_u_time_data
=20
-#ifdef CONFIG_TIME_NS
-static __always_inline
-const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *=
vd)
-{
-	const struct vdso_data *ret;
-
-	/* See __arch_get_vdso_data(). */
-	asm volatile("mov %0, %1" : "=3Dr"(ret) : "r"(_timens_data));
-
-	return ret;
-}
-#endif
-
-static inline bool vdso_clocksource_ok(const struct vdso_data *vd)
+static inline bool vdso_clocksource_ok(const struct vdso_time_data *vd)
 {
 	return vd->clock_mode =3D=3D VDSO_CLOCKMODE_ARCHTIMER;
 }
diff --git a/arch/arm64/include/asm/vdso/getrandom.h b/arch/arm64/include/asm=
/vdso/getrandom.h
index 342f807..a2197da 100644
--- a/arch/arm64/include/asm/vdso/getrandom.h
+++ b/arch/arm64/include/asm/vdso/getrandom.h
@@ -33,18 +33,6 @@ static __always_inline ssize_t getrandom_syscall(void *_bu=
ffer, size_t _len, uns
 	return ret;
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
-		return (void *)&_vdso_rng_data + VVAR_TIMENS_PAGE_OFFSET * (1UL << CONFIG_=
PAGE_SHIFT);
-	return &_vdso_rng_data;
-}
-
 #endif /* !__ASSEMBLY__ */
=20
 #endif /* __ASM_VDSO_GETRANDOM_H */
diff --git a/arch/arm64/include/asm/vdso/gettimeofday.h b/arch/arm64/include/=
asm/vdso/gettimeofday.h
index 764d13e..92a2b59 100644
--- a/arch/arm64/include/asm/vdso/gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/gettimeofday.h
@@ -67,7 +67,7 @@ int clock_getres_fallback(clockid_t _clkid, struct __kernel=
_timespec *_ts)
 }
=20
 static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
-						 const struct vdso_data *vd)
+						 const struct vdso_time_data *vd)
 {
 	u64 res;
=20
@@ -99,20 +99,6 @@ static __always_inline u64 __arch_get_hw_counter(s32 clock=
_mode,
 	return res;
 }
=20
-static __always_inline
-const struct vdso_data *__arch_get_vdso_data(void)
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
-
 #endif /* !__ASSEMBLY__ */
=20
 #endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/arm64/include/asm/vdso/vsyscall.h b/arch/arm64/include/asm/=
vdso/vsyscall.h
index eea5194..3f65cbd 100644
--- a/arch/arm64/include/asm/vdso/vsyscall.h
+++ b/arch/arm64/include/asm/vdso/vsyscall.h
@@ -2,41 +2,18 @@
 #ifndef __ASM_VDSO_VSYSCALL_H
 #define __ASM_VDSO_VSYSCALL_H
=20
-#define __VDSO_RND_DATA_OFFSET  480
-
 #ifndef __ASSEMBLY__
=20
 #include <vdso/datapage.h>
=20
-enum vvar_pages {
-	VVAR_DATA_PAGE_OFFSET,
-	VVAR_TIMENS_PAGE_OFFSET,
-	VVAR_NR_PAGES,
-};
-
 #define VDSO_PRECISION_MASK	~(0xFF00ULL<<48)
=20
-extern struct vdso_data *vdso_data;
=20
 /*
  * Update the vDSO data page to keep in sync with kernel timekeeping.
  */
 static __always_inline
-struct vdso_data *__arm64_get_k_vdso_data(void)
-{
-	return vdso_data;
-}
-#define __arch_get_k_vdso_data __arm64_get_k_vdso_data
-
-static __always_inline
-struct vdso_rng_data *__arm64_get_k_vdso_rnd_data(void)
-{
-	return (void *)vdso_data + __VDSO_RND_DATA_OFFSET;
-}
-#define __arch_get_k_vdso_rng_data __arm64_get_k_vdso_rnd_data
-
-static __always_inline
-void __arm64_update_vsyscall(struct vdso_data *vdata)
+void __arm64_update_vsyscall(struct vdso_time_data *vdata)
 {
 	vdata[CS_HRES_COARSE].mask	=3D VDSO_PRECISION_MASK;
 	vdata[CS_RAW].mask		=3D VDSO_PRECISION_MASK;
diff --git a/arch/arm64/kernel/vdso.c b/arch/arm64/kernel/vdso.c
index e8ed8e5..887ac0b 100644
--- a/arch/arm64/kernel/vdso.c
+++ b/arch/arm64/kernel/vdso.c
@@ -18,7 +18,7 @@
 #include <linux/sched.h>
 #include <linux/signal.h>
 #include <linux/slab.h>
-#include <linux/time_namespace.h>
+#include <linux/vdso_datastore.h>
 #include <linux/vmalloc.h>
 #include <vdso/datapage.h>
 #include <vdso/helpers.h>
@@ -57,12 +57,6 @@ static struct vdso_abi_info vdso_info[] __ro_after_init =
=3D {
 #endif /* CONFIG_COMPAT_VDSO */
 };
=20
-/*
- * The vDSO data page.
- */
-static union vdso_data_store vdso_data_store __page_aligned_data;
-struct vdso_data *vdso_data =3D vdso_data_store.data;
-
 static int vdso_mremap(const struct vm_special_mapping *sm,
 		struct vm_area_struct *new_vma)
 {
@@ -104,78 +98,6 @@ static int __init __vdso_init(enum vdso_abi abi)
 	return 0;
 }
=20
-#ifdef CONFIG_TIME_NS
-struct vdso_data *arch_get_vdso_data(void *vvar_page)
-{
-	return (struct vdso_data *)(vvar_page);
-}
-
-static const struct vm_special_mapping vvar_map;
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
-		if (vma_is_special_mapping(vma, &vvar_map))
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
-static const struct vm_special_mapping vvar_map =3D {
-	.name   =3D "[vvar]",
-	.fault =3D vvar_fault,
-};
-
 static int __setup_additional_pages(enum vdso_abi abi,
 				    struct mm_struct *mm,
 				    struct linux_binprm *bprm,
@@ -185,11 +107,11 @@ static int __setup_additional_pages(enum vdso_abi abi,
 	unsigned long gp_flags =3D 0;
 	void *ret;
=20
-	BUILD_BUG_ON(VVAR_NR_PAGES !=3D __VVAR_PAGES);
+	BUILD_BUG_ON(VDSO_NR_PAGES !=3D __VDSO_PAGES);
=20
 	vdso_text_len =3D vdso_info[abi].vdso_pages << PAGE_SHIFT;
 	/* Be sure to map the data page */
-	vdso_mapping_len =3D vdso_text_len + VVAR_NR_PAGES * PAGE_SIZE;
+	vdso_mapping_len =3D vdso_text_len + VDSO_NR_PAGES * PAGE_SIZE;
=20
 	vdso_base =3D get_unmapped_area(NULL, 0, vdso_mapping_len, 0, 0);
 	if (IS_ERR_VALUE(vdso_base)) {
@@ -197,16 +119,14 @@ static int __setup_additional_pages(enum vdso_abi abi,
 		goto up_fail;
 	}
=20
-	ret =3D _install_special_mapping(mm, vdso_base, VVAR_NR_PAGES * PAGE_SIZE,
-				       VM_READ|VM_MAYREAD|VM_PFNMAP,
-				       &vvar_map);
+	ret =3D vdso_install_vvar_mapping(mm, vdso_base);
 	if (IS_ERR(ret))
 		goto up_fail;
=20
 	if (system_supports_bti_kernel())
 		gp_flags =3D VM_ARM64_BTI;
=20
-	vdso_base +=3D VVAR_NR_PAGES * PAGE_SIZE;
+	vdso_base +=3D VDSO_NR_PAGES * PAGE_SIZE;
 	mm->context.vdso =3D (void *)vdso_base;
 	ret =3D _install_special_mapping(mm, vdso_base, vdso_text_len,
 				       VM_READ|VM_EXEC|gp_flags|
diff --git a/arch/arm64/kernel/vdso/vdso.lds.S b/arch/arm64/kernel/vdso/vdso.=
lds.S
index 4ec32e8..2e20d05 100644
--- a/arch/arm64/kernel/vdso/vdso.lds.S
+++ b/arch/arm64/kernel/vdso/vdso.lds.S
@@ -20,11 +20,8 @@ OUTPUT_ARCH(aarch64)
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
diff --git a/arch/arm64/kernel/vdso32/vdso.lds.S b/arch/arm64/kernel/vdso32/v=
dso.lds.S
index 732702a..e02b274 100644
--- a/arch/arm64/kernel/vdso32/vdso.lds.S
+++ b/arch/arm64/kernel/vdso32/vdso.lds.S
@@ -12,16 +12,15 @@
 #include <asm/page.h>
 #include <asm/vdso.h>
 #include <asm-generic/vmlinux.lds.h>
+#include <vdso/datapage.h>
=20
 OUTPUT_FORMAT("elf32-littlearm", "elf32-bigarm", "elf32-littlearm")
 OUTPUT_ARCH(arm)
=20
 SECTIONS
 {
-	PROVIDE_HIDDEN(_vdso_data =3D . - __VVAR_PAGES * PAGE_SIZE);
-#ifdef CONFIG_TIME_NS
-	PROVIDE_HIDDEN(_timens_data =3D _vdso_data + PAGE_SIZE);
-#endif
+	VDSO_VVAR_SYMS
+
 	. =3D SIZEOF_HEADERS;
=20
 	.hash		: { *(.hash) }			:text

