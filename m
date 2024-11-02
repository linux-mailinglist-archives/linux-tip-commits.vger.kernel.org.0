Return-Path: <linux-tip-commits+bounces-2749-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B7249B9FC5
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 12:56:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A3B0CB21D86
	for <lists+linux-tip-commits@lfdr.de>; Sat,  2 Nov 2024 11:55:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC7351B6CE0;
	Sat,  2 Nov 2024 11:50:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GUDAiSzS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nXPO1M4j"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80D841B3724;
	Sat,  2 Nov 2024 11:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730548235; cv=none; b=cb3/xT0ML6kXXv8+Uf9JHBEeCBdmb66STnP64SDKptK1yBNI4A5krPJfUNI8I2D3S4V9p8FK3laqxGWgBTn5x9uFKPurbMOUOvC5lM3aAhE0rPL77d8ISBEnkbq9Ve9LQPypUt2ohJB3caAKtMrXoxBVAD6Yo3oFlgnqyF8CbUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730548235; c=relaxed/simple;
	bh=7xM/ajRuB2VemMwhXAIugV3hYIZ+vSOW4eKYNZP7Wz8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=A0t/OJRPUi1/WHnewt39D/aWzY3GsRLU/eXKcvtNduaGrM5gzPgicZqaV3YpqOHalfibwcdtcvGl0JDEv4AoWcqe9NaztVSaAeSkIrEnH1nNUT5zx4cSsUKQsm5mwLPXIwhkthheAaH8J9VDroa7TRo/o7/tIaUl8iL8K9Fkxfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GUDAiSzS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nXPO1M4j; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 02 Nov 2024 11:50:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730548232;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ch42RWBlNB+7sLkGmKAWDnIoGdxUGC2TYmv5uQZzSLc=;
	b=GUDAiSzSK0b7rTaorhbuRb02gyhczk9eH4xaHMuI7paeNtzsVbu1CZ7ufhzsB3wt+QUG3q
	buktkLJF9KrZf0+c7+Tht557pXsoaqi8arROVezt4RsKAmI8ROgSK6kMY3vc0JnOEgOed/
	76cnjBq1CeN2FuNvgL2ZIc3u80Xn9r8wuQtbBDOTvJzDjZ6mvbStgLzmpUmER3iar2m1lv
	7KQYRwKnhPvCrimOb4ZmCwTcyRx01G8y8VAcrc/lhwdLnhcF0Dswm7T0Cx2KTrm4Xpc09+
	lQ+A1Uqxmm5wktdcvul4TryPIDrAP373YUpnJ9qcYxlISZfeYjyTpzV+AOLB9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730548232;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ch42RWBlNB+7sLkGmKAWDnIoGdxUGC2TYmv5uQZzSLc=;
	b=nXPO1M4jYGxrqhE/thJmPzeYY17j+EzFxQIDmYEK9690zHQOYSp1p3H5O/2pBcC3A8Sd1n
	LvzWtMvK7NRNQWAA==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] csky/vdso: Remove gettimeofday() and friends from VDSO
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241010-vdso-generic-base-v1-1-b64f0842d512@linutronix.de>
References: <20241010-vdso-generic-base-v1-1-b64f0842d512@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173054823106.3137.16163008849422923012.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     cf12469600fe50aa4ce720645fd31e97a5d2e87b
Gitweb:        https://git.kernel.org/tip/cf12469600fe50aa4ce720645fd31e97a5d=
2e87b
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Thu, 10 Oct 2024 09:01:03 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 02 Nov 2024 12:37:32 +01:00

csky/vdso: Remove gettimeofday() and friends from VDSO

The time-related VDSO functionality was introduced in 2021 in
commit 87f3248cdb9a ("csky: Reconstruct VDSO framework") and
commit 0d3b051adbb7 ("csky: Add VDSO with GENERIC_GETTIMEOFDAY, GENERIC_TIME_=
VSYSCALL, HAVE_GENERIC_VDSO").

However the corresponding aux-vector entry AT_SYSINFO_EHDR was never
wired up, making these functions impossible to test or use.

The VDSO itself is kept as it also provides rt_sigreturn which is
exposed differently to userspace.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20241010-vdso-generic-base-v1-1-b64f0842d51=
2@linutronix.de

---
 arch/csky/Kconfig                         |   4 +-
 arch/csky/include/asm/vdso/clocksource.h  |   9 +--
 arch/csky/include/asm/vdso/gettimeofday.h | 114 +---------------------
 arch/csky/include/asm/vdso/processor.h    |  12 +--
 arch/csky/include/asm/vdso/vsyscall.h     |  22 +----
 arch/csky/kernel/vdso.c                   |  24 +----
 arch/csky/kernel/vdso/Makefile            |   1 +-
 arch/csky/kernel/vdso/vdso.lds.S          |   4 +-
 arch/csky/kernel/vdso/vgettimeofday.c     |  30 +------
 9 files changed, 2 insertions(+), 218 deletions(-)
 delete mode 100644 arch/csky/include/asm/vdso/clocksource.h
 delete mode 100644 arch/csky/include/asm/vdso/gettimeofday.h
 delete mode 100644 arch/csky/include/asm/vdso/processor.h
 delete mode 100644 arch/csky/include/asm/vdso/vsyscall.h
 delete mode 100644 arch/csky/kernel/vdso/vgettimeofday.c

diff --git a/arch/csky/Kconfig b/arch/csky/Kconfig
index 5479707..acc431c 100644
--- a/arch/csky/Kconfig
+++ b/arch/csky/Kconfig
@@ -64,9 +64,6 @@ config CSKY
 	select GENERIC_IRQ_MULTI_HANDLER
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
-	select GENERIC_TIME_VSYSCALL
-	select GENERIC_VDSO_32
-	select GENERIC_GETTIMEOFDAY
 	select GX6605S_TIMER if CPU_CK610
 	select HAVE_ARCH_TRACEHOOK
 	select HAVE_ARCH_AUDITSYSCALL
@@ -80,7 +77,6 @@ config CSKY
 	select HAVE_DEBUG_KMEMLEAK
 	select HAVE_DYNAMIC_FTRACE
 	select HAVE_DYNAMIC_FTRACE_WITH_REGS
-	select HAVE_GENERIC_VDSO
 	select HAVE_FUNCTION_TRACER
 	select HAVE_FUNCTION_GRAPH_TRACER
 	select HAVE_FUNCTION_ERROR_INJECTION
diff --git a/arch/csky/include/asm/vdso/clocksource.h b/arch/csky/include/asm=
/vdso/clocksource.h
deleted file mode 100644
index dfca7b4..0000000
--- a/arch/csky/include/asm/vdso/clocksource.h
+++ /dev/null
@@ -1,9 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef __ASM_VDSO_CSKY_CLOCKSOURCE_H
-#define __ASM_VDSO_CSKY_CLOCKSOURCE_H
-
-#define VDSO_ARCH_CLOCKMODES	\
-	VDSO_CLOCKMODE_ARCHTIMER
-
-#endif /* __ASM_VDSO_CSKY_CLOCKSOURCE_H */
diff --git a/arch/csky/include/asm/vdso/gettimeofday.h b/arch/csky/include/as=
m/vdso/gettimeofday.h
deleted file mode 100644
index 6c4f144..0000000
--- a/arch/csky/include/asm/vdso/gettimeofday.h
+++ /dev/null
@@ -1,114 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef __ASM_VDSO_CSKY_GETTIMEOFDAY_H
-#define __ASM_VDSO_CSKY_GETTIMEOFDAY_H
-
-#ifndef __ASSEMBLY__
-
-#include <asm/barrier.h>
-#include <asm/unistd.h>
-#include <abi/regdef.h>
-#include <uapi/linux/time.h>
-
-#define VDSO_HAS_CLOCK_GETRES	1
-
-static __always_inline
-int gettimeofday_fallback(struct __kernel_old_timeval *_tv,
-			  struct timezone *_tz)
-{
-	register struct __kernel_old_timeval *tv asm("a0") =3D _tv;
-	register struct timezone *tz asm("a1") =3D _tz;
-	register long ret asm("a0");
-	register long nr asm(syscallid) =3D __NR_gettimeofday;
-
-	asm volatile ("trap 0\n"
-		      : "=3Dr" (ret)
-		      : "r"(tv), "r"(tz), "r"(nr)
-		      : "memory");
-
-	return ret;
-}
-
-static __always_inline
-long clock_gettime_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
-{
-	register clockid_t clkid asm("a0") =3D _clkid;
-	register struct __kernel_timespec *ts asm("a1") =3D _ts;
-	register long ret asm("a0");
-	register long nr asm(syscallid) =3D __NR_clock_gettime64;
-
-	asm volatile ("trap 0\n"
-		      : "=3Dr" (ret)
-		      : "r"(clkid), "r"(ts), "r"(nr)
-		      : "memory");
-
-	return ret;
-}
-
-static __always_inline
-long clock_gettime32_fallback(clockid_t _clkid, struct old_timespec32 *_ts)
-{
-	register clockid_t clkid asm("a0") =3D _clkid;
-	register struct old_timespec32 *ts asm("a1") =3D _ts;
-	register long ret asm("a0");
-	register long nr asm(syscallid) =3D __NR_clock_gettime;
-
-	asm volatile ("trap 0\n"
-		      : "=3Dr" (ret)
-		      : "r"(clkid), "r"(ts), "r"(nr)
-		      : "memory");
-
-	return ret;
-}
-
-static __always_inline
-int clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
-{
-	register clockid_t clkid asm("a0") =3D _clkid;
-	register struct __kernel_timespec *ts asm("a1") =3D _ts;
-	register long ret asm("a0");
-	register long nr asm(syscallid) =3D __NR_clock_getres_time64;
-
-	asm volatile ("trap 0\n"
-		      : "=3Dr" (ret)
-		      : "r"(clkid), "r"(ts), "r"(nr)
-		      : "memory");
-
-	return ret;
-}
-
-static __always_inline
-int clock_getres32_fallback(clockid_t _clkid, struct old_timespec32 *_ts)
-{
-	register clockid_t clkid asm("a0") =3D _clkid;
-	register struct old_timespec32 *ts asm("a1") =3D _ts;
-	register long ret asm("a0");
-	register long nr asm(syscallid) =3D __NR_clock_getres;
-
-	asm volatile ("trap 0\n"
-		      : "=3Dr" (ret)
-		      : "r"(clkid), "r"(ts), "r"(nr)
-		      : "memory");
-
-	return ret;
-}
-
-uint64_t csky_pmu_read_cc(void);
-static __always_inline u64 __arch_get_hw_counter(s32 clock_mode,
-						 const struct vdso_data *vd)
-{
-#ifdef CONFIG_CSKY_PMU_V1
-	return csky_pmu_read_cc();
-#else
-	return 0;
-#endif
-}
-
-static __always_inline const struct vdso_data *__arch_get_vdso_data(void)
-{
-	return _vdso_data;
-}
-
-#endif /* !__ASSEMBLY__ */
-
-#endif /* __ASM_VDSO_CSKY_GETTIMEOFDAY_H */
diff --git a/arch/csky/include/asm/vdso/processor.h b/arch/csky/include/asm/v=
dso/processor.h
deleted file mode 100644
index 39a6b56..0000000
--- a/arch/csky/include/asm/vdso/processor.h
+++ /dev/null
@@ -1,12 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-
-#ifndef __ASM_VDSO_CSKY_PROCESSOR_H
-#define __ASM_VDSO_CSKY_PROCESSOR_H
-
-#ifndef __ASSEMBLY__
-
-#define cpu_relax()	barrier()
-
-#endif /* __ASSEMBLY__ */
-
-#endif /* __ASM_VDSO_CSKY_PROCESSOR_H */
diff --git a/arch/csky/include/asm/vdso/vsyscall.h b/arch/csky/include/asm/vd=
so/vsyscall.h
deleted file mode 100644
index c276211..0000000
--- a/arch/csky/include/asm/vdso/vsyscall.h
+++ /dev/null
@@ -1,22 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-
-#ifndef __ASM_VDSO_CSKY_VSYSCALL_H
-#define __ASM_VDSO_CSKY_VSYSCALL_H
-
-#ifndef __ASSEMBLY__
-
-#include <vdso/datapage.h>
-
-extern struct vdso_data *vdso_data;
-
-static __always_inline struct vdso_data *__csky_get_k_vdso_data(void)
-{
-	return vdso_data;
-}
-#define __arch_get_k_vdso_data __csky_get_k_vdso_data
-
-#include <asm-generic/vdso/vsyscall.h>
-
-#endif /* !__ASSEMBLY__ */
-
-#endif /* __ASM_VDSO_CSKY_VSYSCALL_H */
diff --git a/arch/csky/kernel/vdso.c b/arch/csky/kernel/vdso.c
index 5c9ef63..92ab8ac 100644
--- a/arch/csky/kernel/vdso.c
+++ b/arch/csky/kernel/vdso.c
@@ -8,23 +8,19 @@
 #include <linux/slab.h>
=20
 #include <asm/page.h>
-#include <vdso/datapage.h>
=20
 extern char vdso_start[], vdso_end[];
=20
 static unsigned int vdso_pages;
 static struct page **vdso_pagelist;
=20
-static union vdso_data_store vdso_data_store __page_aligned_data;
-struct vdso_data *vdso_data =3D vdso_data_store.data;
-
 static int __init vdso_init(void)
 {
 	unsigned int i;
=20
 	vdso_pages =3D (vdso_end - vdso_start) >> PAGE_SHIFT;
 	vdso_pagelist =3D
-		kcalloc(vdso_pages + 1, sizeof(struct page *), GFP_KERNEL);
+		kcalloc(vdso_pages, sizeof(struct page *), GFP_KERNEL);
 	if (unlikely(vdso_pagelist =3D=3D NULL)) {
 		pr_err("vdso: pagelist allocation failed\n");
 		return -ENOMEM;
@@ -36,7 +32,6 @@ static int __init vdso_init(void)
 		pg =3D virt_to_page(vdso_start + (i << PAGE_SHIFT));
 		vdso_pagelist[i] =3D pg;
 	}
-	vdso_pagelist[i] =3D virt_to_page(vdso_data);
=20
 	return 0;
 }
@@ -52,11 +47,8 @@ int arch_setup_additional_pages(struct linux_binprm *bprm,
 	static struct vm_special_mapping vdso_mapping =3D {
 		.name =3D "[vdso]",
 	};
-	static struct vm_special_mapping vvar_mapping =3D {
-		.name =3D "[vvar]",
-	};
=20
-	vdso_len =3D (vdso_pages + 1) << PAGE_SHIFT;
+	vdso_len =3D vdso_pages << PAGE_SHIFT;
=20
 	mmap_write_lock(mm);
 	vdso_base =3D get_unmapped_area(NULL, 0, vdso_len, 0, 0);
@@ -85,15 +77,6 @@ int arch_setup_additional_pages(struct linux_binprm *bprm,
 	}
=20
 	vdso_base +=3D (vdso_pages << PAGE_SHIFT);
-	vvar_mapping.pages =3D &vdso_pagelist[vdso_pages];
-	vma =3D _install_special_mapping(mm, vdso_base, PAGE_SIZE,
-		(VM_READ | VM_MAYREAD), &vvar_mapping);
-
-	if (IS_ERR(vma)) {
-		ret =3D PTR_ERR(vma);
-		mm->context.vdso =3D NULL;
-		goto end;
-	}
 	ret =3D 0;
 end:
 	mmap_write_unlock(mm);
@@ -104,8 +87,5 @@ const char *arch_vma_name(struct vm_area_struct *vma)
 {
 	if (vma->vm_mm && (vma->vm_start =3D=3D (long)vma->vm_mm->context.vdso))
 		return "[vdso]";
-	if (vma->vm_mm && (vma->vm_start =3D=3D
-			   (long)vma->vm_mm->context.vdso + PAGE_SIZE))
-		return "[vdso_data]";
 	return NULL;
 }
diff --git a/arch/csky/kernel/vdso/Makefile b/arch/csky/kernel/vdso/Makefile
index bc2261f..069ef0b 100644
--- a/arch/csky/kernel/vdso/Makefile
+++ b/arch/csky/kernel/vdso/Makefile
@@ -5,7 +5,6 @@ include $(srctree)/lib/vdso/Makefile
=20
 # Symbols present in the vdso
 vdso-syms  +=3D rt_sigreturn
-vdso-syms  +=3D vgettimeofday
=20
 # Files to link into the vdso
 obj-vdso =3D $(patsubst %, %.o, $(vdso-syms)) note.o
diff --git a/arch/csky/kernel/vdso/vdso.lds.S b/arch/csky/kernel/vdso/vdso.ld=
s.S
index 590a6c7..8d22625 100644
--- a/arch/csky/kernel/vdso/vdso.lds.S
+++ b/arch/csky/kernel/vdso/vdso.lds.S
@@ -49,10 +49,6 @@ VERSION
 	LINUX_5.10 {
 	global:
 		__vdso_rt_sigreturn;
-		__vdso_clock_gettime;
-		__vdso_clock_gettime64;
-		__vdso_gettimeofday;
-		__vdso_clock_getres;
 	local: *;
 	};
 }
diff --git a/arch/csky/kernel/vdso/vgettimeofday.c b/arch/csky/kernel/vdso/vg=
ettimeofday.c
deleted file mode 100644
index 55af30e..0000000
--- a/arch/csky/kernel/vdso/vgettimeofday.c
+++ /dev/null
@@ -1,30 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-
-#include <linux/time.h>
-#include <linux/types.h>
-#include <vdso/gettime.h>
-
-extern
-int __vdso_clock_gettime(clockid_t clock,
-			 struct old_timespec32 *ts)
-{
-	return __cvdso_clock_gettime32(clock, ts);
-}
-
-int __vdso_clock_gettime64(clockid_t clock,
-			   struct __kernel_timespec *ts)
-{
-	return __cvdso_clock_gettime(clock, ts);
-}
-
-int __vdso_gettimeofday(struct __kernel_old_timeval *tv,
-			struct timezone *tz)
-{
-	return __cvdso_gettimeofday(tv, tz);
-}
-
-int __vdso_clock_getres(clockid_t clock_id,
-			struct old_timespec32 *res)
-{
-	return __cvdso_clock_getres_time32(clock_id, res);
-}

