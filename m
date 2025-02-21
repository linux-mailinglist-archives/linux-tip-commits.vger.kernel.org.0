Return-Path: <linux-tip-commits+bounces-3550-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DD50A3EF64
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 10:04:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BA497A388C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 09:03:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 134462045B9;
	Fri, 21 Feb 2025 09:03:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gRsmQlcS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aNtoB6oT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D62D1204090;
	Fri, 21 Feb 2025 09:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128595; cv=none; b=rHOyZQ3z6FS2pqj5Xe5oyUb1sav/k3uc2n8+CAYEbfHdRhMgE4vBIqYBrUCpbqFVLg7ZavCxZMNind82Y66SlrGjy7tBpwlrdbKnJxX/PF8Z4EaFRyuxko79t82zo82oYjdPkRh5ObLRFm4QHvCaUPWDiBZPlaM8gfgIGzPrjhc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128595; c=relaxed/simple;
	bh=KZXslv6QM2O0skboP7O4KfhpFBuZlTNMlxpJFdZ4O8A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QfkmR6zgJAQBAvMYi4VFV++69X7Ll3HrKVYLrTZ4keGZdoy36sBwqhSWSDAntCqrIhQciVMGW8qpeu2vg7NKkV+HnmkNhwzA8brAIPsBP6u9xnhNSGIWdKy11cLsCkCNFoM2wGf4DeYvFfVr2Jx3eTura598oFspZfbu9ZI6JMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gRsmQlcS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aNtoB6oT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 09:03:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740128591;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GOTljGYAa0+mJiHa3iHhF/1+C/jYPzu7zi2hhjGe9jA=;
	b=gRsmQlcS27r7WEIjqU4pzziDvS0BJ/q7jpbWcllhmD6CoGaGLcMay4UZNL0/A+fsl2+uWp
	6j0wxYpXL+4qrT1/+pwilyQWYBRWcMgTvk/IkB70NPvXu6iWD/TmyuHRrkKKHhcDQEKBGH
	O7EcOipxmlXB9PeyRsGaR+uLQY/TfCtuglxLEO3TDgt24/rqf7d02qeT0QjVeOepViyQLf
	BVRouSDmNrrgLEeuf6Tif7hpd/p8QziHEjYcvspFNLUeDaH0/YmnpZSr8VTgN0jqaWOGsm
	BpsVcGGFRtF5QnltuOCHPQVChl22ImfLnuU+5RXLuBIf1WbRbZnpaCv0iXEH9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740128591;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GOTljGYAa0+mJiHa3iHhF/1+C/jYPzu7zi2hhjGe9jA=;
	b=aNtoB6oTewRFpYZkFKHETzbJ3MOSFq7qT4xzV4+CaejieN8EcXnuKxVaRkTHNJwkIzmQnU
	gLy4M7IbXmD9CYBg==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] arm: vdso: Switch to generic storage implementation
Cc: Nam Cao <namcao@linutronix.de>, thomas.weissschuh@linutronix.de,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250204-vdso-store-rng-v3-11-13a4669dfc8c@linutronix.de>
References: <20250204-vdso-store-rng-v3-11-13a4669dfc8c@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174012859063.10177.14791855344500711132.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     31e9fa2ba9ad64ef09eb4a8326e5cc8af3f6fa1d
Gitweb:        https://git.kernel.org/tip/31e9fa2ba9ad64ef09eb4a8326e5cc8af3f=
6fa1d
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 04 Feb 2025 13:05:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 Feb 2025 09:54:02 +01:00

arm: vdso: Switch to generic storage implementation

The generic storage implementation provides the same features as the
custom one. However it can be shared between architectures, making
maintenance easier.

Co-developed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250204-vdso-store-rng-v3-11-13a4669dfc8c@=
linutronix.de

---
 arch/arm/include/asm/vdso.h              |  2 +-
 arch/arm/include/asm/vdso/gettimeofday.h |  7 +-----
 arch/arm/include/asm/vdso/vsyscall.h     | 12 +-------
 arch/arm/kernel/asm-offsets.c            |  4 +---
 arch/arm/kernel/vdso.c                   | 34 ++++-------------------
 arch/arm/mm/Kconfig                      |  1 +-
 arch/arm/vdso/vdso.lds.S                 |  4 +--
 7 files changed, 15 insertions(+), 49 deletions(-)

diff --git a/arch/arm/include/asm/vdso.h b/arch/arm/include/asm/vdso.h
index 5b85889..88364a6 100644
--- a/arch/arm/include/asm/vdso.h
+++ b/arch/arm/include/asm/vdso.h
@@ -4,6 +4,8 @@
=20
 #ifdef __KERNEL__
=20
+#define __VDSO_PAGES	4
+
 #ifndef __ASSEMBLY__
=20
 struct mm_struct;
diff --git a/arch/arm/include/asm/vdso/gettimeofday.h b/arch/arm/include/asm/=
vdso/gettimeofday.h
index 592d3d0..1e9f816 100644
--- a/arch/arm/include/asm/vdso/gettimeofday.h
+++ b/arch/arm/include/asm/vdso/gettimeofday.h
@@ -112,7 +112,7 @@ static inline bool arm_vdso_hres_capable(void)
 #define __arch_vdso_hres_capable arm_vdso_hres_capable
=20
 static __always_inline u64 __arch_get_hw_counter(int clock_mode,
-						 const struct vdso_data *vd)
+						 const struct vdso_time_data *vd)
 {
 #ifdef CONFIG_ARM_ARCH_TIMER
 	u64 cycle_now;
@@ -135,11 +135,6 @@ static __always_inline u64 __arch_get_hw_counter(int clo=
ck_mode,
 #endif
 }
=20
-static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
-{
-	return _vdso_data;
-}
-
 #endif /* !__ASSEMBLY__ */
=20
 #endif /* __ASM_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/arm/include/asm/vdso/vsyscall.h b/arch/arm/include/asm/vdso=
/vsyscall.h
index 7054147..4e7226a 100644
--- a/arch/arm/include/asm/vdso/vsyscall.h
+++ b/arch/arm/include/asm/vdso/vsyscall.h
@@ -7,22 +7,14 @@
 #include <vdso/datapage.h>
 #include <asm/cacheflush.h>
=20
-extern struct vdso_data *vdso_data;
 extern bool cntvct_ok;
=20
 static __always_inline
-struct vdso_data *__arm_get_k_vdso_data(void)
-{
-	return vdso_data;
-}
-#define __arch_get_k_vdso_data __arm_get_k_vdso_data
-
-static __always_inline
-void __arm_sync_vdso_data(struct vdso_data *vdata)
+void __arch_sync_vdso_time_data(struct vdso_time_data *vdata)
 {
 	flush_dcache_page(virt_to_page(vdata));
 }
-#define __arch_sync_vdso_data __arm_sync_vdso_data
+#define __arch_sync_vdso_time_data __arch_sync_vdso_time_data
=20
 /* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
diff --git a/arch/arm/kernel/asm-offsets.c b/arch/arm/kernel/asm-offsets.c
index 4853875..123f4a8 100644
--- a/arch/arm/kernel/asm-offsets.c
+++ b/arch/arm/kernel/asm-offsets.c
@@ -153,10 +153,6 @@ int main(void)
   DEFINE(CACHE_WRITEBACK_ORDER, __CACHE_WRITEBACK_ORDER);
   DEFINE(CACHE_WRITEBACK_GRANULE, __CACHE_WRITEBACK_GRANULE);
   BLANK();
-#ifdef CONFIG_VDSO
-  DEFINE(VDSO_DATA_SIZE,	sizeof(union vdso_data_store));
-#endif
-  BLANK();
 #ifdef CONFIG_ARM_MPU
   DEFINE(MPU_RNG_INFO_RNGS,	offsetof(struct mpu_rgn_info, rgns));
   DEFINE(MPU_RNG_INFO_USED,	offsetof(struct mpu_rgn_info, used));
diff --git a/arch/arm/kernel/vdso.c b/arch/arm/kernel/vdso.c
index 29dd2f3..325448f 100644
--- a/arch/arm/kernel/vdso.c
+++ b/arch/arm/kernel/vdso.c
@@ -7,6 +7,7 @@
  */
=20
 #include <linux/cache.h>
+#include <linux/vdso_datastore.h>
 #include <linux/elf.h>
 #include <linux/err.h>
 #include <linux/kernel.h>
@@ -33,15 +34,6 @@ extern char vdso_start[], vdso_end[];
 /* Total number of pages needed for the data and text portions of the VDSO. =
*/
 unsigned int vdso_total_pages __ro_after_init;
=20
-static union vdso_data_store vdso_data_store __page_aligned_data;
-struct vdso_data *vdso_data =3D vdso_data_store.data;
-
-static struct page *vdso_data_page __ro_after_init;
-static const struct vm_special_mapping vdso_data_mapping =3D {
-	.name =3D "[vvar]",
-	.pages =3D &vdso_data_page,
-};
-
 static int vdso_mremap(const struct vm_special_mapping *sm,
 		struct vm_area_struct *new_vma)
 {
@@ -192,9 +184,6 @@ static int __init vdso_init(void)
 	if (vdso_text_pagelist =3D=3D NULL)
 		return -ENOMEM;
=20
-	/* Grab the VDSO data page. */
-	vdso_data_page =3D virt_to_page(vdso_data);
-
 	/* Grab the VDSO text pages. */
 	for (i =3D 0; i < text_pages; i++) {
 		struct page *page;
@@ -205,7 +194,7 @@ static int __init vdso_init(void)
=20
 	vdso_text_mapping.pages =3D vdso_text_pagelist;
=20
-	vdso_total_pages =3D 1; /* for the data/vvar page */
+	vdso_total_pages =3D VDSO_NR_PAGES; /* for the data/vvar pages */
 	vdso_total_pages +=3D text_pages;
=20
 	cntvct_ok =3D cntvct_functional();
@@ -216,16 +205,7 @@ static int __init vdso_init(void)
 }
 arch_initcall(vdso_init);
=20
-static int install_vvar(struct mm_struct *mm, unsigned long addr)
-{
-	struct vm_area_struct *vma;
-
-	vma =3D _install_special_mapping(mm, addr, PAGE_SIZE,
-				       VM_READ | VM_MAYREAD,
-				       &vdso_data_mapping);
-
-	return PTR_ERR_OR_ZERO(vma);
-}
+static_assert(__VDSO_PAGES =3D=3D VDSO_NR_PAGES);
=20
 /* assumes mmap_lock is write-locked */
 void arm_install_vdso(struct mm_struct *mm, unsigned long addr)
@@ -238,12 +218,12 @@ void arm_install_vdso(struct mm_struct *mm, unsigned lo=
ng addr)
 	if (vdso_text_pagelist =3D=3D NULL)
 		return;
=20
-	if (install_vvar(mm, addr))
+	if (IS_ERR(vdso_install_vvar_mapping(mm, addr)))
 		return;
=20
-	/* Account for vvar page. */
-	addr +=3D PAGE_SIZE;
-	len =3D (vdso_total_pages - 1) << PAGE_SHIFT;
+	/* Account for vvar pages. */
+	addr +=3D VDSO_NR_PAGES * PAGE_SIZE;
+	len =3D (vdso_total_pages - VDSO_NR_PAGES) << PAGE_SHIFT;
=20
 	vma =3D _install_special_mapping(mm, addr, len,
 		VM_READ | VM_EXEC | VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC,
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 2b6f50d..5c1023a 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -928,6 +928,7 @@ config VDSO
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_VDSO_32
 	select GENERIC_GETTIMEOFDAY
+	select GENERIC_VDSO_DATA_STORE
 	help
 	  Place in the process address space an ELF shared object
 	  providing fast implementations of gettimeofday and
diff --git a/arch/arm/vdso/vdso.lds.S b/arch/arm/vdso/vdso.lds.S
index 9bfa0f5..7c08371 100644
--- a/arch/arm/vdso/vdso.lds.S
+++ b/arch/arm/vdso/vdso.lds.S
@@ -11,16 +11,16 @@
  */
=20
 #include <linux/const.h>
-#include <asm/asm-offsets.h>
 #include <asm/page.h>
 #include <asm/vdso.h>
+#include <vdso/datapage.h>
=20
 OUTPUT_FORMAT("elf32-littlearm", "elf32-bigarm", "elf32-littlearm")
 OUTPUT_ARCH(arm)
=20
 SECTIONS
 {
-	PROVIDE(_vdso_data =3D . - VDSO_DATA_SIZE);
+	VDSO_VVAR_SYMS
=20
 	. =3D SIZEOF_HEADERS;
=20

