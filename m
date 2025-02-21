Return-Path: <linux-tip-commits+bounces-3548-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 62274A3EF6A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 10:04:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7B3C73B89F9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 09:03:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81BCD2040B4;
	Fri, 21 Feb 2025 09:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cnnfNLr5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lMjLSqBr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69CB5202F9F;
	Fri, 21 Feb 2025 09:03:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128593; cv=none; b=Gv2aY1uCiVtqX83HLUYpUXPyja9IsEYWAbOcII4KxdUYYU/+1tC/mEBHHPKqQcr/CVp/RHGdV38lR0PVpCGVmHSxOK4BA4n4KmTdjLi4tYG50dhl7KJoFFG5iYLNyLJBIiByfSCK9Y2juUfPUa9itmcRjCn5TMAqAErjXjkUtJ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128593; c=relaxed/simple;
	bh=3JiciMbjD25j0t79Sdt1FIAjnu8YSx7ZSbOT+6L9eVg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QkoAZ2yDWH+tySbfDa5RABfFQV1UZMvJM7eWKtvcmBxxQooTDyQ0+MbxOoNwruQX1yUxK6o/nUsM1OvN7OMP8jM6/u7WYtm+nflBf4p6bi/JefXBi1ol7QpYQ3OPTt84ECishhE1bT0Cn07cYavwcEYlGG9kedZIBBEncoJC/hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cnnfNLr5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lMjLSqBr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 09:03:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740128589;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JyNCzyqIpv+t2FjwSLyE3eAJn9CAeIxfDedP0jtf3EE=;
	b=cnnfNLr5D8hsyIBymkSpFd/De1pkICovBmERQudNgIZURGaJXswOZAQpjPcerF/saJ10K/
	I+nDQ07c/KnCSVgd10eu8XufAUwieR69fAMNyPKeVhDFI0kRpCEJuOzYDC9UaNyXPk3TZB
	Iwj8YX37aBk1FEam2R+1CXh2jfV3TlpaOAbtO+FqXy62im9BpidvWpWXeIzB9kQVdaioNk
	6Wb6Hg+5PoP+0AFM6B4rl3mHg+SeHWGqW4Eb6W3xI2K1GHdyqHDyfazvU4RHoQuRQOyhba
	7ZQUVIOfxIcUW3o9F6llKfRep6UZTUZcpYgk/MGlX+avHu1NZXvlbYhyt8ApqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740128589;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JyNCzyqIpv+t2FjwSLyE3eAJn9CAeIxfDedP0jtf3EE=;
	b=lMjLSqBrIfXM9FvFKGgxvblS3hHokAPZKfr5//FB0INaGDR19IVm33W0De3noKlV76G7aY
	4Gw7lVmzlE4L9XCg==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] MIPS: vdso: Switch to generic storage implementation
Cc: Nam Cao <namcao@linutronix.de>, thomas.weissschuh@linutronix.de,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250204-vdso-store-rng-v3-13-13a4669dfc8c@linutronix.de>
References: <20250204-vdso-store-rng-v3-13-13a4669dfc8c@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174012858917.10177.15885092831873122960.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     69896119dc9d6cdb7db3914a88c4a7b31e342a20
Gitweb:        https://git.kernel.org/tip/69896119dc9d6cdb7db3914a88c4a7b31e3=
42a20
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 04 Feb 2025 13:05:45 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 Feb 2025 09:54:02 +01:00

MIPS: vdso: Switch to generic storage implementation

The generic storage implementation provides the same features as the
custom one. However it can be shared between architectures, making
maintenance easier.

Co-developed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250204-vdso-store-rng-v3-13-13a4669dfc8c@=
linutronix.de

---
 arch/mips/Kconfig                         |  1 +-
 arch/mips/include/asm/vdso/gettimeofday.h |  9 ++--
 arch/mips/include/asm/vdso/vdso.h         | 19 +++------
 arch/mips/include/asm/vdso/vsyscall.h     | 14 +------
 arch/mips/kernel/vdso.c                   | 47 ++++++++--------------
 arch/mips/vdso/vdso.lds.S                 |  5 +-
 6 files changed, 38 insertions(+), 57 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 1924f2d..b51168e 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -51,6 +51,7 @@ config MIPS
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_TIME_VSYSCALL
+	select GENERIC_VDSO_DATA_STORE
 	select GUP_GET_PXX_LOW_HIGH if CPU_MIPS32 && PHYS_ADDR_T_64BIT
 	select HAS_IOPORT if !NO_IOPORT_MAP || ISA
 	select HAVE_ARCH_COMPILER_H
diff --git a/arch/mips/include/asm/vdso/gettimeofday.h b/arch/mips/include/as=
m/vdso/gettimeofday.h
index 44a45f3..fd32baa 100644
--- a/arch/mips/include/asm/vdso/gettimeofday.h
+++ b/arch/mips/include/asm/vdso/gettimeofday.h
@@ -167,7 +167,7 @@ static __always_inline u64 read_r4k_count(void)
=20
 #ifdef CONFIG_CLKSRC_MIPS_GIC
=20
-static __always_inline u64 read_gic_count(const struct vdso_data *data)
+static __always_inline u64 read_gic_count(const struct vdso_time_data *data)
 {
 	void __iomem *gic =3D get_gic(data);
 	u32 hi, hi2, lo;
@@ -184,7 +184,7 @@ static __always_inline u64 read_gic_count(const struct vd=
so_data *data)
 #endif
=20
 static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
-						 const struct vdso_data *vd)
+						 const struct vdso_time_data *vd)
 {
 #ifdef CONFIG_CSRC_R4K
 	if (clock_mode =3D=3D VDSO_CLOCKMODE_R4K)
@@ -209,10 +209,11 @@ static inline bool mips_vdso_hres_capable(void)
 }
 #define __arch_vdso_hres_capable mips_vdso_hres_capable
=20
-static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
+static __always_inline const struct vdso_time_data *__arch_get_vdso_u_time_d=
ata(void)
 {
-	return get_vdso_data();
+	return get_vdso_time_data();
 }
+#define __arch_get_vdso_u_time_data __arch_get_vdso_u_time_data
=20
 #endif /* !__ASSEMBLY__ */
=20
diff --git a/arch/mips/include/asm/vdso/vdso.h b/arch/mips/include/asm/vdso/v=
dso.h
index 6cd8819..acd0efc 100644
--- a/arch/mips/include/asm/vdso/vdso.h
+++ b/arch/mips/include/asm/vdso/vdso.h
@@ -5,16 +5,18 @@
  */
=20
 #include <asm/sgidefs.h>
+#include <vdso/page.h>
+
+#define __VDSO_PAGES 4
=20
 #ifndef __ASSEMBLY__
=20
 #include <asm/asm.h>
-#include <asm/page.h>
 #include <asm/vdso.h>
=20
-static inline unsigned long get_vdso_base(void)
+static inline const struct vdso_time_data *get_vdso_time_data(void)
 {
-	unsigned long addr;
+	const struct vdso_time_data *addr;
=20
 	/*
 	 * We can't use cpu_has_mips_r6 since it needs the cpu_data[]
@@ -27,7 +29,7 @@ static inline unsigned long get_vdso_base(void)
 	 * We can't use addiupc because there is no label-label
 	 * support for the addiupc reloc
 	 */
-	__asm__("lapc	%0, _start			\n"
+	__asm__("lapc	%0, vdso_u_time_data		\n"
 		: "=3Dr" (addr) : :);
 #else
 	/*
@@ -46,7 +48,7 @@ static inline unsigned long get_vdso_base(void)
 	"	.set noreorder				\n"
 	"	bal	1f				\n"
 	"	 nop					\n"
-	"	.word	_start - .			\n"
+	"	.word	vdso_u_time_data - .		\n"
 	"1:	lw	%0, 0($31)			\n"
 	"	" STR(PTR_ADDU) " %0, $31, %0		\n"
 	"	.set pop				\n"
@@ -58,14 +60,9 @@ static inline unsigned long get_vdso_base(void)
 	return addr;
 }
=20
-static inline const struct vdso_data *get_vdso_data(void)
-{
-	return (const struct vdso_data *)(get_vdso_base() - PAGE_SIZE);
-}
-
 #ifdef CONFIG_CLKSRC_MIPS_GIC
=20
-static inline void __iomem *get_gic(const struct vdso_data *data)
+static inline void __iomem *get_gic(const struct vdso_time_data *data)
 {
 	return (void __iomem *)((unsigned long)data & PAGE_MASK) - PAGE_SIZE;
 }
diff --git a/arch/mips/include/asm/vdso/vsyscall.h b/arch/mips/include/asm/vd=
so/vsyscall.h
index a458287..2b1debb 100644
--- a/arch/mips/include/asm/vdso/vsyscall.h
+++ b/arch/mips/include/asm/vdso/vsyscall.h
@@ -2,22 +2,12 @@
 #ifndef __ASM_VDSO_VSYSCALL_H
 #define __ASM_VDSO_VSYSCALL_H
=20
+#include <asm/page.h>
+
 #ifndef __ASSEMBLY__
=20
 #include <vdso/datapage.h>
=20
-extern struct vdso_data *vdso_data;
-
-/*
- * Update the vDSO data page to keep in sync with kernel timekeeping.
- */
-static __always_inline
-struct vdso_data *__mips_get_k_vdso_data(void)
-{
-	return vdso_data;
-}
-#define __arch_get_k_vdso_data __mips_get_k_vdso_data
-
 /* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
=20
diff --git a/arch/mips/kernel/vdso.c b/arch/mips/kernel/vdso.c
index 75c9d36..de09677 100644
--- a/arch/mips/kernel/vdso.c
+++ b/arch/mips/kernel/vdso.c
@@ -15,6 +15,7 @@
 #include <linux/random.h>
 #include <linux/sched.h>
 #include <linux/slab.h>
+#include <linux/vdso_datastore.h>
=20
 #include <asm/abi.h>
 #include <asm/mips-cps.h>
@@ -23,20 +24,7 @@
 #include <vdso/helpers.h>
 #include <vdso/vsyscall.h>
=20
-/* Kernel-provided data used by the VDSO. */
-static union vdso_data_store mips_vdso_data __page_aligned_data;
-struct vdso_data *vdso_data =3D mips_vdso_data.data;
-
-/*
- * Mapping for the VDSO data/GIC pages. The real pages are mapped manually, =
as
- * what we map and where within the area they are mapped is determined at
- * runtime.
- */
-static struct page *no_pages[] =3D { NULL };
-static struct vm_special_mapping vdso_vvar_mapping =3D {
-	.name =3D "[vvar]",
-	.pages =3D no_pages,
-};
+static_assert(VDSO_NR_PAGES =3D=3D __VDSO_PAGES);
=20
 static void __init init_vdso_image(struct mips_vdso_image *image)
 {
@@ -90,7 +78,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm, =
int uses_interp)
 {
 	struct mips_vdso_image *image =3D current->thread.abi->vdso;
 	struct mm_struct *mm =3D current->mm;
-	unsigned long gic_size, vvar_size, size, base, data_addr, vdso_addr, gic_pf=
n, gic_base;
+	unsigned long gic_size, size, base, data_addr, vdso_addr, gic_pfn, gic_base;
 	struct vm_area_struct *vma;
 	int ret;
=20
@@ -119,8 +107,7 @@ int arch_setup_additional_pages(struct linux_binprm *bprm=
, int uses_interp)
 	 * the counter registers at the start.
 	 */
 	gic_size =3D mips_gic_present() ? PAGE_SIZE : 0;
-	vvar_size =3D gic_size + PAGE_SIZE;
-	size =3D vvar_size + image->size;
+	size =3D gic_size + VDSO_NR_PAGES * PAGE_SIZE + image->size;
=20
 	/*
 	 * Find a region that's large enough for us to perform the
@@ -143,15 +130,13 @@ int arch_setup_additional_pages(struct linux_binprm *bp=
rm, int uses_interp)
 	 */
 	if (cpu_has_dc_aliases) {
 		base =3D __ALIGN_MASK(base, shm_align_mask);
-		base +=3D ((unsigned long)vdso_data - gic_size) & shm_align_mask;
+		base +=3D ((unsigned long)vdso_k_time_data - gic_size) & shm_align_mask;
 	}
=20
 	data_addr =3D base + gic_size;
-	vdso_addr =3D data_addr + PAGE_SIZE;
+	vdso_addr =3D data_addr + VDSO_NR_PAGES * PAGE_SIZE;
=20
-	vma =3D _install_special_mapping(mm, base, vvar_size,
-				       VM_READ | VM_MAYREAD,
-				       &vdso_vvar_mapping);
+	vma =3D vdso_install_vvar_mapping(mm, data_addr);
 	if (IS_ERR(vma)) {
 		ret =3D PTR_ERR(vma);
 		goto out;
@@ -161,6 +146,17 @@ int arch_setup_additional_pages(struct linux_binprm *bpr=
m, int uses_interp)
 	if (gic_size) {
 		gic_base =3D (unsigned long)mips_gic_base + MIPS_GIC_USER_OFS;
 		gic_pfn =3D PFN_DOWN(__pa(gic_base));
+		static const struct vm_special_mapping gic_mapping =3D {
+			.name	=3D "[gic]",
+			.pages	=3D (struct page **) { NULL },
+		};
+
+		vma =3D _install_special_mapping(mm, base, gic_size, VM_READ | VM_MAYREAD,
+					       &gic_mapping);
+		if (IS_ERR(vma)) {
+			ret =3D PTR_ERR(vma);
+			goto out;
+		}
=20
 		ret =3D io_remap_pfn_range(vma, base, gic_pfn, gic_size,
 					 pgprot_noncached(vma->vm_page_prot));
@@ -168,13 +164,6 @@ int arch_setup_additional_pages(struct linux_binprm *bpr=
m, int uses_interp)
 			goto out;
 	}
=20
-	/* Map data page. */
-	ret =3D remap_pfn_range(vma, data_addr,
-			      virt_to_phys(vdso_data) >> PAGE_SHIFT,
-			      PAGE_SIZE, vma->vm_page_prot);
-	if (ret)
-		goto out;
-
 	/* Map VDSO image. */
 	vma =3D _install_special_mapping(mm, vdso_addr, image->size,
 				       VM_READ | VM_EXEC |
diff --git a/arch/mips/vdso/vdso.lds.S b/arch/mips/vdso/vdso.lds.S
index 836465e..c8bbe56 100644
--- a/arch/mips/vdso/vdso.lds.S
+++ b/arch/mips/vdso/vdso.lds.S
@@ -5,6 +5,8 @@
  */
=20
 #include <asm/sgidefs.h>
+#include <asm/vdso/vdso.h>
+#include <vdso/datapage.h>
=20
 #if _MIPS_SIM =3D=3D _MIPS_SIM_ABI64
 OUTPUT_FORMAT("elf64-tradlittlemips", "elf64-tradbigmips", "elf64-tradlittle=
mips")
@@ -18,7 +20,8 @@ OUTPUT_ARCH(mips)
=20
 SECTIONS
 {
-	PROVIDE(_start =3D .);
+	VDSO_VVAR_SYMS
+
 	. =3D SIZEOF_HEADERS;
=20
 	/*

