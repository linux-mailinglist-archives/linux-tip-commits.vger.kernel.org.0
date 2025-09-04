Return-Path: <linux-tip-commits+bounces-6444-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1067B43731
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 11:32:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 83E4C5A244E
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Sep 2025 09:32:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF1232F8BD2;
	Thu,  4 Sep 2025 09:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sppJk1OG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2uoDSlSG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AB12F7467;
	Thu,  4 Sep 2025 09:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756978340; cv=none; b=I1GMjddsLnrCC0EeCMEO0o4AsIi0L71jJ4qYUULYKzysOFYhyKDqbHnaNrbUhVLoPgiAekcmfvO/htnclZH1uQEmBPFLA31gU8R3b2ISDClFdycBU2bIULSYxegniZtM2Rqcz1Rg0gVCumib0B7OcgzDb6COSKmchHxU+jD/ihM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756978340; c=relaxed/simple;
	bh=SUUppwxtpKt9xgeJ9HpLkpUBT3J26cf/AGoRC2MnLHA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cvkxrxWDQEFcS9UUaE8fwLeCSKD2J7tniktPY8xZ1btI7GeuEGoF0ndqxlkElkCjVJKjf3p8K+iQSKQYG6prF6Ez1LnAkNY5QsfMeS+fAGeVzTPE5m0QLA7fMsizN9O7C4SEkNILZA0i1gj1C+XAk4PM1LFikM+V8foppxT2YME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sppJk1OG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2uoDSlSG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 04 Sep 2025 09:32:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756978337;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aL3+Pt2e07s8ZTJfpw7vOI0eU6FqnCcK4ykUakfN4aM=;
	b=sppJk1OG3Tg1wr24AHKPC/7oy6ihqCPcRqxt/HspuNmsccKJMowqrEGzvHv2lWLv9jUCjz
	9vh9BBhViJzyqOKL8HqdB2QfFVxgqO1ffOchV/8GV4Ns4qPfLpU696YIAK1FzlFzXDLajV
	kWEWPBsSAQEmrzQUqempLxpCOLKwjdUnC5QakLU7+Wl2qVz0ri3zqJut00P4qVnYJ5mi9I
	bndv2LXyYzU84Xo2c3jtK4l1M2Xj19Ht3L7j+F5pW3kBL6mNrfTL8o6fQoha6Ox4t6d8bT
	aHqLpBrPIN9aNO3+WCClasJWordL01/dxfbzwePyVDghmLVfTf65CNWe014waw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756978337;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aL3+Pt2e07s8ZTJfpw7vOI0eU6FqnCcK4ykUakfN4aM=;
	b=2uoDSlSGWjflBm3NCLi5gIaeyBDNn81jivBRyH/f/1JEU7gW8KZWOfAZTYk6AJPUQWlUwb
	QLHpI79qFzqQIKAw==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso: Drop Kconfig GENERIC_VDSO_DATA_STORE
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250826-vdso-cleanups-v1-9-d9b65750e49f@linutronix.de>
References: <20250826-vdso-cleanups-v1-9-d9b65750e49f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175697833589.1920.6937485730529086728.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     7b338f6d4e3d6baa057e3505592a86f6410d68ed
Gitweb:        https://git.kernel.org/tip/7b338f6d4e3d6baa057e3505592a86f6410=
d68ed
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 26 Aug 2025 08:17:12 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 04 Sep 2025 11:23:50 +02:00

vdso: Drop Kconfig GENERIC_VDSO_DATA_STORE

All users of the generic vDSO library also use the generic vDSO datastore.

Remove the now unnecessary Kconfig symbol.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/all/20250826-vdso-cleanups-v1-9-d9b65750e49f@li=
nutronix.de

---
 arch/Kconfig                        | 2 +-
 arch/arm/mm/Kconfig                 | 1 -
 arch/arm64/Kconfig                  | 1 -
 arch/loongarch/Kconfig              | 1 -
 arch/mips/Kconfig                   | 1 -
 arch/powerpc/Kconfig                | 1 -
 arch/riscv/Kconfig                  | 1 -
 arch/s390/Kconfig                   | 1 -
 arch/x86/Kconfig                    | 1 -
 include/asm-generic/vdso/vsyscall.h | 4 ----
 include/vdso/datapage.h             | 5 +----
 lib/vdso/Kconfig                    | 5 -----
 lib/vdso/Makefile                   | 2 +-
 lib/vdso/gettimeofday.c             | 2 --
 14 files changed, 3 insertions(+), 25 deletions(-)

diff --git a/arch/Kconfig b/arch/Kconfig
index d1b4ffd..f6ca7f3 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -1609,7 +1609,7 @@ config HAVE_SPARSE_SYSCALL_NR
 	  related optimizations for a given architecture.
=20
 config ARCH_HAS_VDSO_ARCH_DATA
-	depends on GENERIC_VDSO_DATA_STORE
+	depends on HAVE_GENERIC_VDSO
 	bool
=20
 config ARCH_HAS_VDSO_TIME_DATA
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index 2347988..7b27ee9 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -927,7 +927,6 @@ config VDSO
 	select HAVE_GENERIC_VDSO
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
-	select GENERIC_VDSO_DATA_STORE
 	help
 	  Place in the process address space an ELF shared object
 	  providing fast implementations of gettimeofday and
diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 5c61b19..b0f007b 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -162,7 +162,6 @@ config ARM64
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
-	select GENERIC_VDSO_DATA_STORE
 	select GENERIC_VDSO_TIME_NS
 	select HARDIRQS_SW_RESEND
 	select HAS_IOPORT
diff --git a/arch/loongarch/Kconfig b/arch/loongarch/Kconfig
index f0abc38..d15b201 100644
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@ -108,7 +108,6 @@ config LOONGARCH
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
-	select GENERIC_VDSO_DATA_STORE
 	select GENERIC_VDSO_TIME_NS
 	select GPIOLIB
 	select HAS_IOPORT
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index caf508f..f7e6bbd 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -51,7 +51,6 @@ config MIPS
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_IDLE_POLL_SETUP
 	select GENERIC_TIME_VSYSCALL
-	select GENERIC_VDSO_DATA_STORE
 	select GUP_GET_PXX_LOW_HIGH if CPU_MIPS32 && PHYS_ADDR_T_64BIT
 	select HAS_IOPORT if !NO_IOPORT_MAP || ISA
 	select HAVE_ARCH_COMPILER_H
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 93402a1..78c82af 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -207,7 +207,6 @@ config PPC
 	select GENERIC_PCI_IOMAP		if PCI
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
-	select GENERIC_VDSO_DATA_STORE
 	select GENERIC_VDSO_TIME_NS
 	select HAS_IOPORT			if PCI
 	select HAVE_ARCH_AUDITSYSCALL
diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
index e4ac0e8..f6cf918 100644
--- a/arch/riscv/Kconfig
+++ b/arch/riscv/Kconfig
@@ -121,7 +121,6 @@ config RISCV
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL if GENERIC_GETTIMEOFDAY
-	select GENERIC_VDSO_DATA_STORE if HAVE_GENERIC_VDSO
 	select GENERIC_VDSO_TIME_NS if GENERIC_GETTIMEOFDAY
 	select HARDIRQS_SW_RESEND
 	select HAS_IOPORT if MMU
diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index bf680c2..696d224 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -167,7 +167,6 @@ config S390
 	select GENERIC_GETTIMEOFDAY
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
-	select GENERIC_VDSO_DATA_STORE
 	select GENERIC_VDSO_TIME_NS
 	select GENERIC_IOREMAP if PCI
 	select HAVE_ALIGNED_STRUCT_PAGE
diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index 4f12007..1e74b2a 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -181,7 +181,6 @@ config X86
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_GETTIMEOFDAY
-	select GENERIC_VDSO_DATA_STORE
 	select GENERIC_VDSO_TIME_NS
 	select GENERIC_VDSO_OVERFLOW_PROTECT
 	select GUP_GET_PXX_LOW_HIGH		if X86_PAE
diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/v=
syscall.h
index 7fc0b56..5c6d979 100644
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -4,8 +4,6 @@
=20
 #ifndef __ASSEMBLY__
=20
-#ifdef CONFIG_GENERIC_VDSO_DATA_STORE
-
 #ifndef __arch_get_vdso_u_time_data
 static __always_inline const struct vdso_time_data *__arch_get_vdso_u_time_d=
ata(void)
 {
@@ -20,8 +18,6 @@ static __always_inline const struct vdso_rng_data *__arch_g=
et_vdso_u_rng_data(vo
 }
 #endif
=20
-#endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
-
 #ifndef __arch_update_vdso_clock
 static __always_inline void __arch_update_vdso_clock(struct vdso_clock *vc)
 {
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index 0b1982f..23c39b9 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -31,7 +31,7 @@ struct arch_vdso_time_data {};
=20
 #if defined(CONFIG_ARCH_HAS_VDSO_ARCH_DATA)
 #include <asm/vdso/arch_data.h>
-#elif defined(CONFIG_GENERIC_VDSO_DATA_STORE)
+#else
 struct vdso_arch_data {
 	/* Needed for the generic code, never actually used at runtime */
 	char __unused;
@@ -164,7 +164,6 @@ struct vdso_rng_data {
  * With the hidden visibility, the compiler simply generates a PC-relative
  * relocation, and this is what we need.
  */
-#ifdef CONFIG_GENERIC_VDSO_DATA_STORE
 extern struct vdso_time_data vdso_u_time_data __attribute__((visibility("hid=
den")));
 extern struct vdso_rng_data vdso_u_rng_data __attribute__((visibility("hidde=
n")));
 extern struct vdso_arch_data vdso_u_arch_data __attribute__((visibility("hid=
den")));
@@ -185,8 +184,6 @@ enum vdso_pages {
 	VDSO_NR_PAGES
 };
=20
-#endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
-
 /*
  * The generic vDSO implementation requires that gettimeofday.h
  * provides:
diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
index 2594dd7..48ffb0f 100644
--- a/lib/vdso/Kconfig
+++ b/lib/vdso/Kconfig
@@ -31,8 +31,3 @@ config VDSO_GETRANDOM
 	bool
 	help
 	  Selected by architectures that support vDSO getrandom().
-
-config GENERIC_VDSO_DATA_STORE
-	bool
-	help
-	  Selected by architectures that use the generic vDSO data store.
diff --git a/lib/vdso/Makefile b/lib/vdso/Makefile
index aedd40a..405f743 100644
--- a/lib/vdso/Makefile
+++ b/lib/vdso/Makefile
@@ -1,3 +1,3 @@
 # SPDX-License-Identifier: GPL-2.0-only
=20
-obj-$(CONFIG_GENERIC_VDSO_DATA_STORE) +=3D datastore.o
+obj-$(CONFIG_HAVE_GENERIC_VDSO) +=3D datastore.o
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 1e2a40b..95df015 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -108,13 +108,11 @@ bool vdso_get_timestamp(const struct vdso_time_data *vd=
, const struct vdso_clock
 	return true;
 }
=20
-#ifdef CONFIG_GENERIC_VDSO_DATA_STORE
 static __always_inline
 const struct vdso_time_data *__arch_get_vdso_u_timens_data(const struct vdso=
_time_data *vd)
 {
 	return (void *)vd + PAGE_SIZE;
 }
-#endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
=20
 static __always_inline
 bool do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_clo=
ck *vcns,

