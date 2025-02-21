Return-Path: <linux-tip-commits+bounces-3547-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C04A3EF62
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 10:03:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 391D97A3FEB
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 09:02:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 61E022040A7;
	Fri, 21 Feb 2025 09:03:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mc0hV+y7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aHHjUPym"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E27BF202F65;
	Fri, 21 Feb 2025 09:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740128593; cv=none; b=V6OHqYv9xKdsX7MYfmGxtFo+EIj5QbGBgBEWDR+V716yFWMovb9F8JWO8yLONXYwjF+nyxWDG0vYcPvl0nXMv3je42F0bFiGnq62Ae7JfMFOs6wF256rOAD9GPsubixgOm0gVijTZgI5lACu1f3rbxSiRKpKkAYM6yDMlrRt2Ys=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740128593; c=relaxed/simple;
	bh=VmZRq665tkRRkdaV++kMsTKFDZxixw0XcYv52jxuzNk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OFSLE3oxdd7cxLDSBwyKl1ej66hd3JJ+1mw6TdS4oOkA65e9+8mn/LSJMDJe/xcf1p7sVJ3AfEjkpjkaMqtF3oPwWf/RZELT5n5K3PtigsUNpsNRHYe3xZcKgafFFduwXfF49kPZiaK7VJFJJH02AA6FHFnSZrIy8b/nbdR8NAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mc0hV+y7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aHHjUPym; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 09:03:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740128589;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TWP3vVoHMcUSIb9Y8tGN7QUPItzrMq+QV2o2C536F80=;
	b=mc0hV+y74CwdF2NMiThOo391kaYYE9E5jPdI1RgJksTTcMMS4xr6kcIo+wEOz9vpafIx8m
	gxX4pSX1jucPPG3rr4BPsqZPvH0hJMChuYp/3NqYAHG+aJoypCqZMOSypabyNVUhkBL9qp
	P/Kr3BNrLUAcFyEHs5uBxYeEUTxSo6GPi+rOHycV1QoqYoNfxdi5PyyofWTSBjRupSEA28
	220zY82bdjA8hWTlLhSPqPZ0b8q4jDDl21u5zo2vCvYcqDZyXnv0paBtRPJYt0XPzKv6m5
	ZyVR/tqdR5bVP+IF9vvXxIHTM/gI4pjm2XL3YhMji+DKJzF+VMkrf3W8NdQ3yg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740128589;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TWP3vVoHMcUSIb9Y8tGN7QUPItzrMq+QV2o2C536F80=;
	b=aHHjUPymyA2lMBGxNvOMxO7y7rH+Gd2ByZgUepKJRqUdEmYAgwAuMcX9znNDcz8y+Zpzmu
	4CkgjK5vuiU408Aw==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] powerpc/vdso: Switch to generic storage implementation
Cc: Nam Cao <namcao@linutronix.de>, thomas.weissschuh@linutronix.de,
 Thomas Gleixner <tglx@linutronix.de>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250204-vdso-store-rng-v3-14-13a4669dfc8c@linutronix.de>
References: <20250204-vdso-store-rng-v3-14-13a4669dfc8c@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174012858830.10177.8472179659902672699.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     223970df2bff4caa308246404383baee2b79dba2
Gitweb:        https://git.kernel.org/tip/223970df2bff4caa308246404383baee2b7=
9dba2
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 04 Feb 2025 13:05:46 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 Feb 2025 09:54:02 +01:00

powerpc/vdso: Switch to generic storage implementation

The generic storage implementation provides the same features as the
custom one. However it can be shared between architectures, making
maintenance easier.

Co-developed-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
Link: https://lore.kernel.org/all/20250204-vdso-store-rng-v3-14-13a4669dfc8c@=
linutronix.de

---
 arch/powerpc/Kconfig                         |   2 +-
 arch/powerpc/include/asm/vdso.h              |   1 +-
 arch/powerpc/include/asm/vdso/arch_data.h    |  37 ++++++-
 arch/powerpc/include/asm/vdso/getrandom.h    |  11 +-
 arch/powerpc/include/asm/vdso/gettimeofday.h |  29 +----
 arch/powerpc/include/asm/vdso/vsyscall.h     |  13 +--
 arch/powerpc/include/asm/vdso_datapage.h     |  44 +-------
 arch/powerpc/kernel/asm-offsets.c            |   1 +-
 arch/powerpc/kernel/time.c                   |   2 +-
 arch/powerpc/kernel/vdso.c                   | 115 +-----------------
 arch/powerpc/kernel/vdso/cacheflush.S        |   2 +-
 arch/powerpc/kernel/vdso/datapage.S          |   4 +-
 arch/powerpc/kernel/vdso/gettimeofday.S      |   4 +-
 arch/powerpc/kernel/vdso/vdso32.lds.S        |   4 +-
 arch/powerpc/kernel/vdso/vdso64.lds.S        |   4 +-
 arch/powerpc/kernel/vdso/vgettimeofday.c     |  14 +-
 16 files changed, 89 insertions(+), 198 deletions(-)
 create mode 100644 arch/powerpc/include/asm/vdso/arch_data.h

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 424f188..8a2a6e4 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -159,6 +159,7 @@ config PPC
 	select ARCH_HAS_TICK_BROADCAST		if GENERIC_CLOCKEVENTS_BROADCAST
 	select ARCH_HAS_UACCESS_FLUSHCACHE
 	select ARCH_HAS_UBSAN
+	select ARCH_HAS_VDSO_ARCH_DATA
 	select ARCH_HAVE_NMI_SAFE_CMPXCHG
 	select ARCH_HAVE_EXTRA_ELF_NOTES        if SPU_BASE
 	select ARCH_KEEP_MEMBLOCK
@@ -209,6 +210,7 @@ config PPC
 	select GENERIC_PTDUMP
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
+	select GENERIC_VDSO_DATA_STORE
 	select GENERIC_VDSO_TIME_NS
 	select HAS_IOPORT			if PCI
 	select HAVE_ARCH_AUDITSYSCALL
diff --git a/arch/powerpc/include/asm/vdso.h b/arch/powerpc/include/asm/vdso.h
index 8d972bc..1ca23fb 100644
--- a/arch/powerpc/include/asm/vdso.h
+++ b/arch/powerpc/include/asm/vdso.h
@@ -3,6 +3,7 @@
 #define _ASM_POWERPC_VDSO_H
=20
 #define VDSO_VERSION_STRING	LINUX_2.6.15
+#define __VDSO_PAGES		4
=20
 #ifndef __ASSEMBLY__
=20
diff --git a/arch/powerpc/include/asm/vdso/arch_data.h b/arch/powerpc/include=
/asm/vdso/arch_data.h
new file mode 100644
index 0000000..c240a6b
--- /dev/null
+++ b/arch/powerpc/include/asm/vdso/arch_data.h
@@ -0,0 +1,37 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2002 Peter Bergner <bergner@vnet.ibm.com>, IBM
+ * Copyright (C) 2005 Benjamin Herrenschmidy <benh@kernel.crashing.org>,
+ * 		      IBM Corp.
+ */
+#ifndef _ASM_POWERPC_VDSO_ARCH_DATA_H
+#define _ASM_POWERPC_VDSO_ARCH_DATA_H
+
+#include <linux/unistd.h>
+#include <linux/types.h>
+
+#define SYSCALL_MAP_SIZE      ((NR_syscalls + 31) / 32)
+
+#ifdef CONFIG_PPC64
+
+struct vdso_arch_data {
+	__u64 tb_ticks_per_sec;			/* Timebase tics / sec */
+	__u32 dcache_block_size;		/* L1 d-cache block size     */
+	__u32 icache_block_size;		/* L1 i-cache block size     */
+	__u32 dcache_log_block_size;		/* L1 d-cache log block size */
+	__u32 icache_log_block_size;		/* L1 i-cache log block size */
+	__u32 syscall_map[SYSCALL_MAP_SIZE];	/* Map of syscalls  */
+	__u32 compat_syscall_map[SYSCALL_MAP_SIZE];	/* Map of compat syscalls */
+};
+
+#else /* CONFIG_PPC64 */
+
+struct vdso_arch_data {
+	__u64 tb_ticks_per_sec;		/* Timebase tics / sec */
+	__u32 syscall_map[SYSCALL_MAP_SIZE]; /* Map of syscalls */
+	__u32 compat_syscall_map[0];	/* No compat syscalls on PPC32 */
+};
+
+#endif /* CONFIG_PPC64 */
+
+#endif /* _ASM_POWERPC_VDSO_ARCH_DATA_H */
diff --git a/arch/powerpc/include/asm/vdso/getrandom.h b/arch/powerpc/include=
/asm/vdso/getrandom.h
index 80ce070..067a539 100644
--- a/arch/powerpc/include/asm/vdso/getrandom.h
+++ b/arch/powerpc/include/asm/vdso/getrandom.h
@@ -43,20 +43,21 @@ static __always_inline ssize_t getrandom_syscall(void *bu=
ffer, size_t len, unsig
 			    (unsigned long)len, (unsigned long)flags);
 }
=20
-static __always_inline struct vdso_rng_data *__arch_get_vdso_rng_data(void)
+static __always_inline const struct vdso_rng_data *__arch_get_vdso_u_rng_dat=
a(void)
 {
-	struct vdso_arch_data *data;
+	struct vdso_rng_data *data;
=20
 	asm (
 		"	bcl	20, 31, .+4 ;"
 		"0:	mflr	%0 ;"
-		"	addis	%0, %0, (_vdso_datapage - 0b)@ha ;"
-		"	addi	%0, %0, (_vdso_datapage - 0b)@l  ;"
+		"	addis	%0, %0, (vdso_u_rng_data - 0b)@ha ;"
+		"	addi	%0, %0, (vdso_u_rng_data - 0b)@l  ;"
 		: "=3Dr" (data) : : "lr"
 	);
=20
-	return &data->rng_data;
+	return data;
 }
+#define __arch_get_vdso_u_rng_data __arch_get_vdso_u_rng_data
=20
 ssize_t __c_kernel_getrandom(void *buffer, size_t len, unsigned int flags, v=
oid *opaque_state,
 			     size_t opaque_len);
diff --git a/arch/powerpc/include/asm/vdso/gettimeofday.h b/arch/powerpc/incl=
ude/asm/vdso/gettimeofday.h
index c639089..dc955f2 100644
--- a/arch/powerpc/include/asm/vdso/gettimeofday.h
+++ b/arch/powerpc/include/asm/vdso/gettimeofday.h
@@ -94,22 +94,12 @@ int clock_getres32_fallback(clockid_t _clkid, struct old_=
timespec32 *_ts)
 #endif
=20
 static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
-						 const struct vdso_data *vd)
+						 const struct vdso_time_data *vd)
 {
 	return get_tb();
 }
=20
-const struct vdso_data *__arch_get_vdso_data(void);
-
-#ifdef CONFIG_TIME_NS
-static __always_inline
-const struct vdso_data *__arch_get_timens_vdso_data(const struct vdso_data *=
vd)
-{
-	return (void *)vd + (1U << CONFIG_PAGE_SHIFT);
-}
-#endif
-
-static inline bool vdso_clocksource_ok(const struct vdso_data *vd)
+static inline bool vdso_clocksource_ok(const struct vdso_time_data *vd)
 {
 	return true;
 }
@@ -135,21 +125,22 @@ static __always_inline u64 vdso_shift_ns(u64 ns, unsign=
ed long shift)
=20
 #ifdef __powerpc64__
 int __c_kernel_clock_gettime(clockid_t clock, struct __kernel_timespec *ts,
-			     const struct vdso_data *vd);
+			     const struct vdso_time_data *vd);
 int __c_kernel_clock_getres(clockid_t clock_id, struct __kernel_timespec *re=
s,
-			    const struct vdso_data *vd);
+			    const struct vdso_time_data *vd);
 #else
 int __c_kernel_clock_gettime(clockid_t clock, struct old_timespec32 *ts,
-			     const struct vdso_data *vd);
+			     const struct vdso_time_data *vd);
 int __c_kernel_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts,
-			       const struct vdso_data *vd);
+			       const struct vdso_time_data *vd);
 int __c_kernel_clock_getres(clockid_t clock_id, struct old_timespec32 *res,
-			    const struct vdso_data *vd);
+			    const struct vdso_time_data *vd);
 #endif
 int __c_kernel_gettimeofday(struct __kernel_old_timeval *tv, struct timezone=
 *tz,
-			    const struct vdso_data *vd);
+			    const struct vdso_time_data *vd);
 __kernel_old_time_t __c_kernel_time(__kernel_old_time_t *time,
-				    const struct vdso_data *vd);
+				    const struct vdso_time_data *vd);
+
 #endif /* __ASSEMBLY__ */
=20
 #endif /* _ASM_POWERPC_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/powerpc/include/asm/vdso/vsyscall.h b/arch/powerpc/include/=
asm/vdso/vsyscall.h
index 48560a1..c2c9ae1 100644
--- a/arch/powerpc/include/asm/vdso/vsyscall.h
+++ b/arch/powerpc/include/asm/vdso/vsyscall.h
@@ -6,19 +6,6 @@
=20
 #include <asm/vdso_datapage.h>
=20
-static __always_inline
-struct vdso_data *__arch_get_k_vdso_data(void)
-{
-	return vdso_data->data;
-}
-#define __arch_get_k_vdso_data __arch_get_k_vdso_data
-
-static __always_inline
-struct vdso_rng_data *__arch_get_k_vdso_rng_data(void)
-{
-	return &vdso_data->rng_data;
-}
-
 /* The asm-generic header needs to be included after the definitions above */
 #include <asm-generic/vdso/vsyscall.h>
=20
diff --git a/arch/powerpc/include/asm/vdso_datapage.h b/arch/powerpc/include/=
asm/vdso_datapage.h
index a202f5b..95d45a5 100644
--- a/arch/powerpc/include/asm/vdso_datapage.h
+++ b/arch/powerpc/include/asm/vdso_datapage.h
@@ -11,56 +11,18 @@
=20
 #ifndef __ASSEMBLY__
=20
-#include <linux/unistd.h>
-#include <linux/time.h>
 #include <vdso/datapage.h>
=20
-#define SYSCALL_MAP_SIZE      ((NR_syscalls + 31) / 32)
-
-#ifdef CONFIG_PPC64
-
-struct vdso_arch_data {
-	__u64 tb_ticks_per_sec;			/* Timebase tics / sec */
-	__u32 dcache_block_size;		/* L1 d-cache block size     */
-	__u32 icache_block_size;		/* L1 i-cache block size     */
-	__u32 dcache_log_block_size;		/* L1 d-cache log block size */
-	__u32 icache_log_block_size;		/* L1 i-cache log block size */
-	__u32 syscall_map[SYSCALL_MAP_SIZE];	/* Map of syscalls  */
-	__u32 compat_syscall_map[SYSCALL_MAP_SIZE];	/* Map of compat syscalls */
-
-	struct vdso_rng_data rng_data;
-
-	struct vdso_data data[CS_BASES] __aligned(1 << CONFIG_PAGE_SHIFT);
-};
-
-#else /* CONFIG_PPC64 */
-
-struct vdso_arch_data {
-	__u64 tb_ticks_per_sec;		/* Timebase tics / sec */
-	__u32 syscall_map[SYSCALL_MAP_SIZE]; /* Map of syscalls */
-	__u32 compat_syscall_map[0];	/* No compat syscalls on PPC32 */
-	struct vdso_rng_data rng_data;
-
-	struct vdso_data data[CS_BASES] __aligned(1 << CONFIG_PAGE_SHIFT);
-};
-
-#endif /* CONFIG_PPC64 */
-
-extern struct vdso_arch_data *vdso_data;
-
 #else /* __ASSEMBLY__ */
=20
-.macro get_datapage ptr offset=3D0
+.macro get_datapage ptr symbol
 	bcl	20, 31, .+4
 999:
 	mflr	\ptr
-	addis	\ptr, \ptr, (_vdso_datapage - 999b + \offset)@ha
-	addi	\ptr, \ptr, (_vdso_datapage - 999b + \offset)@l
+	addis	\ptr, \ptr, (\symbol - 999b)@ha
+	addi	\ptr, \ptr, (\symbol - 999b)@l
 .endm
=20
-#include <asm/asm-offsets.h>
-#include <asm/page.h>
-
 #endif /* __ASSEMBLY__ */
=20
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offs=
ets.c
index 7a390bd..b3048f6 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -334,7 +334,6 @@ int main(void)
 #endif /* ! CONFIG_PPC64 */
=20
 	/* datapage offsets for use by vdso */
-	OFFSET(VDSO_DATA_OFFSET, vdso_arch_data, data);
 	OFFSET(CFG_TB_TICKS_PER_SEC, vdso_arch_data, tb_ticks_per_sec);
 #ifdef CONFIG_PPC64
 	OFFSET(CFG_ICACHE_BLOCKSZ, vdso_arch_data, icache_block_size);
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index 0727332..15784c5 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -950,7 +950,7 @@ void __init time_init(void)
 		sys_tz.tz_dsttime =3D 0;
 	}
=20
-	vdso_data->tb_ticks_per_sec =3D tb_ticks_per_sec;
+	vdso_k_arch_data->tb_ticks_per_sec =3D tb_ticks_per_sec;
 #ifdef CONFIG_PPC64_PROC_SYSTEMCFG
 	systemcfg->tb_ticks_per_sec =3D tb_ticks_per_sec;
 #endif
diff --git a/arch/powerpc/kernel/vdso.c b/arch/powerpc/kernel/vdso.c
index 4337936..219d67b 100644
--- a/arch/powerpc/kernel/vdso.c
+++ b/arch/powerpc/kernel/vdso.c
@@ -17,7 +17,7 @@
 #include <linux/elf.h>
 #include <linux/security.h>
 #include <linux/syscalls.h>
-#include <linux/time_namespace.h>
+#include <linux/vdso_datastore.h>
 #include <vdso/datapage.h>
=20
 #include <asm/syscall.h>
@@ -32,6 +32,8 @@
 #include <asm/vdso_datapage.h>
 #include <asm/setup.h>
=20
+static_assert(__VDSO_PAGES =3D=3D VDSO_NR_PAGES);
+
 /* The alignment of the vDSO */
 #define VDSO_ALIGNMENT	(1 << 16)
=20
@@ -40,24 +42,6 @@ extern char vdso64_start, vdso64_end;
=20
 long sys_ni_syscall(void);
=20
-/*
- * The vdso data page (aka. systemcfg for old ppc64 fans) is here.
- * Once the early boot kernel code no longer needs to muck around
- * with it, it will become dynamically allocated
- */
-static union {
-	struct vdso_arch_data	data;
-	u8			page[2 * PAGE_SIZE];
-} vdso_data_store __page_aligned_data;
-struct vdso_arch_data *vdso_data =3D &vdso_data_store.data;
-
-enum vvar_pages {
-	VVAR_BASE_PAGE_OFFSET,
-	VVAR_TIME_PAGE_OFFSET,
-	VVAR_TIMENS_PAGE_OFFSET,
-	VVAR_NR_PAGES,
-};
-
 static int vdso_mremap(const struct vm_special_mapping *sm, struct vm_area_s=
truct *new_vma,
 		       unsigned long text_size)
 {
@@ -96,14 +80,6 @@ static void vdso_close(const struct vm_special_mapping *sm=
, struct vm_area_struc
 	mm->context.vdso =3D NULL;
 }
=20
-static vm_fault_t vvar_fault(const struct vm_special_mapping *sm,
-			     struct vm_area_struct *vma, struct vm_fault *vmf);
-
-static struct vm_special_mapping vvar_spec __ro_after_init =3D {
-	.name =3D "[vvar]",
-	.fault =3D vvar_fault,
-};
-
 static struct vm_special_mapping vdso32_spec __ro_after_init =3D {
 	.name =3D "[vdso]",
 	.mremap =3D vdso32_mremap,
@@ -116,73 +92,6 @@ static struct vm_special_mapping vdso64_spec __ro_after_i=
nit =3D {
 	.close =3D vdso_close,
 };
=20
-#ifdef CONFIG_TIME_NS
-struct vdso_data *arch_get_vdso_data(void *vvar_page)
-{
-	return vvar_page;
-}
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
-	VMA_ITERATOR(vmi, mm, 0);
-	struct vm_area_struct *vma;
-
-	mmap_read_lock(mm);
-	for_each_vma(vmi, vma) {
-		if (vma_is_special_mapping(vma, &vvar_spec))
-			zap_vma_pages(vma);
-	}
-	mmap_read_unlock(mm);
-
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
-	case VVAR_BASE_PAGE_OFFSET:
-		pfn =3D virt_to_pfn(vdso_data);
-		break;
-	case VVAR_TIME_PAGE_OFFSET:
-		if (timens_page)
-			pfn =3D page_to_pfn(timens_page);
-		else
-			pfn =3D virt_to_pfn(vdso_data->data);
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
-		pfn =3D virt_to_pfn(vdso_data->data);
-		break;
-#endif /* CONFIG_TIME_NS */
-	default:
-		return VM_FAULT_SIGBUS;
-	}
-
-	return vmf_insert_pfn(vma, vmf->address, pfn);
-}
-
 /*
  * This is called from binfmt_elf, we create the special vma for the
  * vDSO and insert it into the mm struct tree
@@ -191,7 +100,7 @@ static int __arch_setup_additional_pages(struct linux_bin=
prm *bprm, int uses_int
 {
 	unsigned long vdso_size, vdso_base, mappings_size;
 	struct vm_special_mapping *vdso_spec;
-	unsigned long vvar_size =3D VVAR_NR_PAGES * PAGE_SIZE;
+	unsigned long vvar_size =3D VDSO_NR_PAGES * PAGE_SIZE;
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma;
=20
@@ -217,9 +126,7 @@ static int __arch_setup_additional_pages(struct linux_bin=
prm *bprm, int uses_int
 	/* Add required alignment. */
 	vdso_base =3D ALIGN(vdso_base, VDSO_ALIGNMENT);
=20
-	vma =3D _install_special_mapping(mm, vdso_base, vvar_size,
-				       VM_READ | VM_MAYREAD | VM_IO |
-				       VM_DONTDUMP | VM_PFNMAP, &vvar_spec);
+	vma =3D vdso_install_vvar_mapping(mm, vdso_base);
 	if (IS_ERR(vma))
 		return PTR_ERR(vma);
=20
@@ -299,10 +206,10 @@ static void __init vdso_setup_syscall_map(void)
=20
 	for (i =3D 0; i < NR_syscalls; i++) {
 		if (sys_call_table[i] !=3D (void *)&sys_ni_syscall)
-			vdso_data->syscall_map[i >> 5] |=3D 0x80000000UL >> (i & 0x1f);
+			vdso_k_arch_data->syscall_map[i >> 5] |=3D 0x80000000UL >> (i & 0x1f);
 		if (IS_ENABLED(CONFIG_COMPAT) &&
 		    compat_sys_call_table[i] !=3D (void *)&sys_ni_syscall)
-			vdso_data->compat_syscall_map[i >> 5] |=3D 0x80000000UL >> (i & 0x1f);
+			vdso_k_arch_data->compat_syscall_map[i >> 5] |=3D 0x80000000UL >> (i & 0x=
1f);
 	}
 }
=20
@@ -352,10 +259,10 @@ static struct page ** __init vdso_setup_pages(void *sta=
rt, void *end)
 static int __init vdso_init(void)
 {
 #ifdef CONFIG_PPC64
-	vdso_data->dcache_block_size =3D ppc64_caches.l1d.block_size;
-	vdso_data->icache_block_size =3D ppc64_caches.l1i.block_size;
-	vdso_data->dcache_log_block_size =3D ppc64_caches.l1d.log_block_size;
-	vdso_data->icache_log_block_size =3D ppc64_caches.l1i.log_block_size;
+	vdso_k_arch_data->dcache_block_size =3D ppc64_caches.l1d.block_size;
+	vdso_k_arch_data->icache_block_size =3D ppc64_caches.l1i.block_size;
+	vdso_k_arch_data->dcache_log_block_size =3D ppc64_caches.l1d.log_block_size;
+	vdso_k_arch_data->icache_log_block_size =3D ppc64_caches.l1i.log_block_size;
 #endif /* CONFIG_PPC64 */
=20
 	vdso_setup_syscall_map();
diff --git a/arch/powerpc/kernel/vdso/cacheflush.S b/arch/powerpc/kernel/vdso=
/cacheflush.S
index 0085ae4..488d3ad 100644
--- a/arch/powerpc/kernel/vdso/cacheflush.S
+++ b/arch/powerpc/kernel/vdso/cacheflush.S
@@ -30,7 +30,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 #ifdef CONFIG_PPC64
 	mflr	r12
   .cfi_register lr,r12
-	get_datapage	r10
+	get_datapage	r10 vdso_u_arch_data
 	mtlr	r12
   .cfi_restore	lr
 #endif
diff --git a/arch/powerpc/kernel/vdso/datapage.S b/arch/powerpc/kernel/vdso/d=
atapage.S
index db8e167..d23b2e8 100644
--- a/arch/powerpc/kernel/vdso/datapage.S
+++ b/arch/powerpc/kernel/vdso/datapage.S
@@ -28,7 +28,7 @@ V_FUNCTION_BEGIN(__kernel_get_syscall_map)
 	mflr	r12
   .cfi_register lr,r12
 	mr.	r4,r3
-	get_datapage	r3
+	get_datapage	r3 vdso_u_arch_data
 	mtlr	r12
 #ifdef __powerpc64__
 	addi	r3,r3,CFG_SYSCALL_MAP64
@@ -52,7 +52,7 @@ V_FUNCTION_BEGIN(__kernel_get_tbfreq)
   .cfi_startproc
 	mflr	r12
   .cfi_register lr,r12
-	get_datapage	r3
+	get_datapage	r3 vdso_u_arch_data
 #ifndef __powerpc64__
 	lwz	r4,(CFG_TB_TICKS_PER_SEC + 4)(r3)
 #endif
diff --git a/arch/powerpc/kernel/vdso/gettimeofday.S b/arch/powerpc/kernel/vd=
so/gettimeofday.S
index 5333848..79c9672 100644
--- a/arch/powerpc/kernel/vdso/gettimeofday.S
+++ b/arch/powerpc/kernel/vdso/gettimeofday.S
@@ -33,9 +33,9 @@
   .cfi_rel_offset r2, PPC_MIN_STKFRM + STK_GOT
 #endif
 	.ifeq	\call_time
-		get_datapage	r5 VDSO_DATA_OFFSET
+		get_datapage	r5 vdso_u_time_data
 	.else
-		get_datapage	r4 VDSO_DATA_OFFSET
+		get_datapage	r4 vdso_u_time_data
 	.endif
 	bl		CFUNC(DOTSYM(\funct))
 	PPC_LL		r0, PPC_MIN_STKFRM + PPC_LR_STKOFF(r1)
diff --git a/arch/powerpc/kernel/vdso/vdso32.lds.S b/arch/powerpc/kernel/vdso=
/vdso32.lds.S
index 1a1b0b6..72a1012 100644
--- a/arch/powerpc/kernel/vdso/vdso32.lds.S
+++ b/arch/powerpc/kernel/vdso/vdso32.lds.S
@@ -6,6 +6,7 @@
 #include <asm/vdso.h>
 #include <asm/page.h>
 #include <asm-generic/vmlinux.lds.h>
+#include <vdso/datapage.h>
=20
 #ifdef __LITTLE_ENDIAN__
 OUTPUT_FORMAT("elf32-powerpcle", "elf32-powerpcle", "elf32-powerpcle")
@@ -16,7 +17,8 @@ OUTPUT_ARCH(powerpc:common)
=20
 SECTIONS
 {
-	PROVIDE(_vdso_datapage =3D . - 3 * PAGE_SIZE);
+	VDSO_VVAR_SYMS
+
 	. =3D SIZEOF_HEADERS;
=20
 	.hash          	: { *(.hash) }			:text
diff --git a/arch/powerpc/kernel/vdso/vdso64.lds.S b/arch/powerpc/kernel/vdso=
/vdso64.lds.S
index e21b550..32102a0 100644
--- a/arch/powerpc/kernel/vdso/vdso64.lds.S
+++ b/arch/powerpc/kernel/vdso/vdso64.lds.S
@@ -6,6 +6,7 @@
 #include <asm/vdso.h>
 #include <asm/page.h>
 #include <asm-generic/vmlinux.lds.h>
+#include <vdso/datapage.h>
=20
 #ifdef __LITTLE_ENDIAN__
 OUTPUT_FORMAT("elf64-powerpcle", "elf64-powerpcle", "elf64-powerpcle")
@@ -16,7 +17,8 @@ OUTPUT_ARCH(powerpc:common64)
=20
 SECTIONS
 {
-	PROVIDE(_vdso_datapage =3D . - 3 * PAGE_SIZE);
+	VDSO_VVAR_SYMS
+
 	. =3D SIZEOF_HEADERS;
=20
 	.hash		: { *(.hash) }			:text
diff --git a/arch/powerpc/kernel/vdso/vgettimeofday.c b/arch/powerpc/kernel/v=
dso/vgettimeofday.c
index 55a287c..6f5167d 100644
--- a/arch/powerpc/kernel/vdso/vgettimeofday.c
+++ b/arch/powerpc/kernel/vdso/vgettimeofday.c
@@ -7,43 +7,43 @@
=20
 #ifdef __powerpc64__
 int __c_kernel_clock_gettime(clockid_t clock, struct __kernel_timespec *ts,
-			     const struct vdso_data *vd)
+			     const struct vdso_time_data *vd)
 {
 	return __cvdso_clock_gettime_data(vd, clock, ts);
 }
=20
 int __c_kernel_clock_getres(clockid_t clock_id, struct __kernel_timespec *re=
s,
-			    const struct vdso_data *vd)
+			    const struct vdso_time_data *vd)
 {
 	return __cvdso_clock_getres_data(vd, clock_id, res);
 }
 #else
 int __c_kernel_clock_gettime(clockid_t clock, struct old_timespec32 *ts,
-			     const struct vdso_data *vd)
+			     const struct vdso_time_data *vd)
 {
 	return __cvdso_clock_gettime32_data(vd, clock, ts);
 }
=20
 int __c_kernel_clock_gettime64(clockid_t clock, struct __kernel_timespec *ts,
-			       const struct vdso_data *vd)
+			       const struct vdso_time_data *vd)
 {
 	return __cvdso_clock_gettime_data(vd, clock, ts);
 }
=20
 int __c_kernel_clock_getres(clockid_t clock_id, struct old_timespec32 *res,
-			    const struct vdso_data *vd)
+			    const struct vdso_time_data *vd)
 {
 	return __cvdso_clock_getres_time32_data(vd, clock_id, res);
 }
 #endif
=20
 int __c_kernel_gettimeofday(struct __kernel_old_timeval *tv, struct timezone=
 *tz,
-			    const struct vdso_data *vd)
+			    const struct vdso_time_data *vd)
 {
 	return __cvdso_gettimeofday_data(vd, tv, tz);
 }
=20
-__kernel_old_time_t __c_kernel_time(__kernel_old_time_t *time, const struct =
vdso_data *vd)
+__kernel_old_time_t __c_kernel_time(__kernel_old_time_t *time, const struct =
vdso_time_data *vd)
 {
 	return __cvdso_time_data(vd, time);
 }

