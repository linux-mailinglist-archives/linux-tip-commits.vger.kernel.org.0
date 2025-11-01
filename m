Return-Path: <linux-tip-commits+bounces-7136-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 758CEC286E3
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:49:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 09077189F42E
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:48:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 39F3B304BD4;
	Sat,  1 Nov 2025 19:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IW5HDMzO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8VzZpjR4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D55A4303A28;
	Sat,  1 Nov 2025 19:47:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026463; cv=none; b=OA6T0Z8rMIl+RVPhIrxR0UL4KExmFTpop+8pL7+es3xV60q96Htrnj/wx6+AB3Da20dzWaDQ19A1N/mprKAUIWF/NNQEmXp8xR6KQGf6VLMTXlj++Jenl+FIlfjPnJv48RS98W8J1Fg3VLnfW776dxycDGNhfGb0xY3E9bv5MLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026463; c=relaxed/simple;
	bh=wDnYsFKN45Y643IpHRCFhkMMTfT7Bh5QuhdLkratKQk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ierqFqdEOtIX5FHKjW49bwKPTQ5DEQHNUQJ7324wiwho6zPBJnI0d+RmTuD/toaPlRvsGpjX29IX6P/p9N2LXwFHJ6u9Yz8wjWHTrRRAqvn755Re0X1OG7UYeDJu8b3nPt0WxK1RHP0sFY/xapHj5PnXTDk8nvLxnOrbJEtVaMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IW5HDMzO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8VzZpjR4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:47:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026455;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BSUFCkUFHW9an5czACRBB8YnYVAmmRfDsjNyIHRYHC0=;
	b=IW5HDMzOoyUBeXKz1NCUuiSYzaQfuvPmVM6XjoyzASQ9La6iH6E0a02oWs9+wv+JPYqvia
	ShlJ3Jvyi13kNOKJDq0sRaCQJkvMl0r3sPnS7XPmn0sMW2OGj8SkfHy0LnpAZSIeClO8Iv
	iiXFV0yw4m0UgMKYgaL6Gi/DzrIdfEcR3BaMX0mxlg0ztKHHqxngdbKnsaz2mJ3J8EFjJP
	Mq/EFKx3E/py03crXiVt1TRc3d1C+E81g4Ww1Gt3zILjKDEfahuPZJQz1e89H32Jmy+TMu
	cpccNSezyWzB6v6KdcMxZq8Bbs55sr6ybwk1lTVe932JHCb8hRn6wzAzfNBHHw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026455;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BSUFCkUFHW9an5czACRBB8YnYVAmmRfDsjNyIHRYHC0=;
	b=8VzZpjR4c2DJ54Pp7K1W4MjrxoZ6qhWen0DNW4DXoVg5RlnDLnvSfqS+cY1RDZH49Q3ozZ
	oGxiNlfmXBwBJtDA==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] sparc64: vdso: Switch to the generic vDSO library
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Andreas Larsson <andreas@gaisler.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20251014-vdso-sparc64-generic-2-v4-31-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-31-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202645455.2601451.6374272870166001956.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     4148173832b63f939080b00b3793045b4a7f2a50
Gitweb:        https://git.kernel.org/tip/4148173832b63f939080b00b3793045b4a7=
f2a50
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 14 Oct 2025 08:49:17 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:44:08 +01:00

sparc64: vdso: Switch to the generic vDSO library

The generic vDSO provides a lot common functionality shared between
different architectures. SPARC is the last architecture not using it,
preventing some necessary code cleanup.

Make use of the generic infrastructure.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Acked-by: Andreas Larsson <andreas@gaisler.com>
Link: https://patch.msgid.link/20251014-vdso-sparc64-generic-2-v4-31-e0607bf4=
9dea@linutronix.de
---
 arch/sparc/Kconfig                         |   3 +-
 arch/sparc/include/asm/clocksource.h       |   9 +-
 arch/sparc/include/asm/vdso/clocksource.h  |  10 +-
 arch/sparc/include/asm/vdso/gettimeofday.h |  58 +++++--
 arch/sparc/include/asm/vdso/vsyscall.h     |  10 +-
 arch/sparc/include/asm/vvar.h              |  75 +---------
 arch/sparc/kernel/Makefile                 |   1 +-
 arch/sparc/kernel/time_64.c                |   6 +-
 arch/sparc/kernel/vdso.c                   |  69 +--------
 arch/sparc/vdso/Makefile                   |   6 +-
 arch/sparc/vdso/vclock_gettime.c           | 169 ++------------------
 arch/sparc/vdso/vdso-layout.lds.S          |   7 +-
 arch/sparc/vdso/vma.c                      |  70 +-------
 13 files changed, 118 insertions(+), 375 deletions(-)
 create mode 100644 arch/sparc/include/asm/vdso/clocksource.h
 create mode 100644 arch/sparc/include/asm/vdso/vsyscall.h
 delete mode 100644 arch/sparc/include/asm/vvar.h
 delete mode 100644 arch/sparc/kernel/vdso.c

diff --git a/arch/sparc/Kconfig b/arch/sparc/Kconfig
index a630d37..404b4c7 100644
--- a/arch/sparc/Kconfig
+++ b/arch/sparc/Kconfig
@@ -102,7 +102,6 @@ config SPARC64
 	select ARCH_USE_QUEUED_RWLOCKS
 	select ARCH_USE_QUEUED_SPINLOCKS
 	select GENERIC_TIME_VSYSCALL
-	select ARCH_CLOCKSOURCE_DATA
 	select ARCH_HAS_PTE_SPECIAL
 	select PCI_DOMAINS if PCI
 	select ARCH_HAS_GIGANTIC_PAGE
@@ -112,6 +111,8 @@ config SPARC64
 	select NEED_PER_CPU_PAGE_FIRST_CHUNK
 	select ARCH_SUPPORTS_SCHED_SMT if SMP
 	select ARCH_SUPPORTS_SCHED_MC  if SMP
+	select HAVE_GENERIC_VDSO
+	select GENERIC_GETTIMEOFDAY
=20
 config ARCH_PROC_KCORE_TEXT
 	def_bool y
diff --git a/arch/sparc/include/asm/clocksource.h b/arch/sparc/include/asm/cl=
ocksource.h
index d63ef22..68303ad 100644
--- a/arch/sparc/include/asm/clocksource.h
+++ b/arch/sparc/include/asm/clocksource.h
@@ -5,13 +5,4 @@
 #ifndef _ASM_SPARC_CLOCKSOURCE_H
 #define _ASM_SPARC_CLOCKSOURCE_H
=20
-/* VDSO clocksources */
-#define VCLOCK_NONE   0  /* Nothing userspace can do. */
-#define VCLOCK_TICK   1  /* Use %tick.  */
-#define VCLOCK_STICK  2  /* Use %stick. */
-
-struct arch_clocksource_data {
-	int vclock_mode;
-};
-
 #endif /* _ASM_SPARC_CLOCKSOURCE_H */
diff --git a/arch/sparc/include/asm/vdso/clocksource.h b/arch/sparc/include/a=
sm/vdso/clocksource.h
new file mode 100644
index 0000000..007aa8c
--- /dev/null
+++ b/arch/sparc/include/asm/vdso/clocksource.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef __ASM_VDSO_CLOCKSOURCE_H
+#define __ASM_VDSO_CLOCKSOURCE_H
+
+/* VDSO clocksources */
+#define VDSO_ARCH_CLOCKMODES	\
+	VDSO_CLOCKMODE_TICK,	\
+	VDSO_CLOCKMODE_STICK
+
+#endif /* __ASM_VDSO_CLOCKSOURCE_H */
diff --git a/arch/sparc/include/asm/vdso/gettimeofday.h b/arch/sparc/include/=
asm/vdso/gettimeofday.h
index 429dc08..a35875f 100644
--- a/arch/sparc/include/asm/vdso/gettimeofday.h
+++ b/arch/sparc/include/asm/vdso/gettimeofday.h
@@ -9,15 +9,14 @@
 #include <uapi/linux/time.h>
 #include <uapi/linux/unistd.h>
=20
+#include <vdso/align.h>
+#include <vdso/clocksource.h>
+#include <vdso/datapage.h>
+#include <vdso/page.h>
+
 #include <linux/types.h>
-#include <asm/vvar.h>
=20
 #ifdef	CONFIG_SPARC64
-static __always_inline u64 vdso_shift_ns(u64 val, u32 amt)
-{
-	return val >> amt;
-}
-
 static __always_inline u64 vread_tick(void)
 {
 	u64	ret;
@@ -48,6 +47,7 @@ static __always_inline u64 vdso_shift_ns(u64 val, u32 amt)
 			     : "g1");
 	return ret;
 }
+#define vdso_shift_ns vdso_shift_ns
=20
 static __always_inline u64 vread_tick(void)
 {
@@ -70,9 +70,9 @@ static __always_inline u64 vread_tick_stick(void)
 }
 #endif
=20
-static __always_inline u64 __arch_get_hw_counter(struct vvar_data *vvar)
+static __always_inline u64 __arch_get_hw_counter(s32 clock_mode, const struc=
t vdso_time_data *vd)
 {
-	if (likely(vvar->vclock_mode =3D=3D VCLOCK_STICK))
+	if (likely(clock_mode =3D=3D VDSO_CLOCKMODE_STICK))
 		return vread_tick_stick();
 	else
 		return vread_tick();
@@ -102,7 +102,20 @@ static __always_inline u64 __arch_get_hw_counter(struct =
vvar_data *vvar)
 	"cc", "memory"
=20
 static __always_inline
-long clock_gettime_fallback(clockid_t clock, struct __kernel_old_timespec *t=
s)
+long clock_gettime_fallback(clockid_t clock, struct __kernel_timespec *ts)
+{
+	register long num __asm__("g1") =3D __NR_clock_gettime;
+	register long o0 __asm__("o0") =3D clock;
+	register long o1 __asm__("o1") =3D (long) ts;
+
+	__asm__ __volatile__(SYSCALL_STRING : "=3Dr" (o0) : "r" (num),
+			     "0" (o0), "r" (o1) : SYSCALL_CLOBBERS);
+	return o0;
+}
+
+#ifndef CONFIG_SPARC64
+static __always_inline
+long clock_gettime32_fallback(clockid_t clock, struct old_timespec32 *ts)
 {
 	register long num __asm__("g1") =3D __NR_clock_gettime;
 	register long o0 __asm__("o0") =3D clock;
@@ -112,6 +125,7 @@ long clock_gettime_fallback(clockid_t clock, struct __ker=
nel_old_timespec *ts)
 			     "0" (o0), "r" (o1) : SYSCALL_CLOBBERS);
 	return o0;
 }
+#endif
=20
 static __always_inline
 long gettimeofday_fallback(struct __kernel_old_timeval *tv, struct timezone =
*tz)
@@ -125,4 +139,30 @@ long gettimeofday_fallback(struct __kernel_old_timeval *=
tv, struct timezone *tz)
 	return o0;
 }
=20
+static __always_inline const struct vdso_time_data *__arch_get_vdso_u_time_d=
ata(void)
+{
+	unsigned long ret;
+
+	/*
+	 * SPARC does not support native PC-relative code relocations.
+	 * Calculate the address manually, works for 32 and 64 bit code.
+	 */
+	__asm__ __volatile__(
+		"1:\n"
+		"call 3f\n"                     // Jump over the embedded data and set up =
%o7
+		"nop\n"                         // Delay slot
+		"2:\n"
+		".word vdso_u_time_data - .\n"  // Embedded offset to external symbol
+		"3:\n"
+		"add %%o7, 2b - 1b, %%o7\n"     // Point %o7 to the embedded offset
+		"ldsw [%%o7], %0\n"             // Load the offset
+		"add %0, %%o7, %0\n"            // Calculate the absolute address
+		: "=3Dr" (ret)
+		:
+		: "o7");
+
+	return (const struct vdso_time_data *)ret;
+}
+#define __arch_get_vdso_u_time_data __arch_get_vdso_u_time_data
+
 #endif /* _ASM_SPARC_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/sparc/include/asm/vdso/vsyscall.h b/arch/sparc/include/asm/=
vdso/vsyscall.h
new file mode 100644
index 0000000..8bfe703
--- /dev/null
+++ b/arch/sparc/include/asm/vdso/vsyscall.h
@@ -0,0 +1,10 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _ASM_SPARC_VDSO_VSYSCALL_H
+#define _ASM_SPARC_VDSO_VSYSCALL_H
+
+#define __VDSO_PAGES 4
+
+#include <asm-generic/vdso/vsyscall.h>
+
+#endif /* _ASM_SPARC_VDSO_VSYSCALL_H */
diff --git a/arch/sparc/include/asm/vvar.h b/arch/sparc/include/asm/vvar.h
deleted file mode 100644
index 6eaf5cf..0000000
--- a/arch/sparc/include/asm/vvar.h
+++ /dev/null
@@ -1,75 +0,0 @@
-/*
- * Copyright (c) 2017 Oracle and/or its affiliates. All rights reserved.
- */
-
-#ifndef _ASM_SPARC_VVAR_DATA_H
-#define _ASM_SPARC_VVAR_DATA_H
-
-#include <asm/clocksource.h>
-#include <asm/processor.h>
-#include <asm/barrier.h>
-#include <linux/time.h>
-#include <linux/types.h>
-
-struct vvar_data {
-	unsigned int seq;
-
-	int vclock_mode;
-	struct { /* extract of a clocksource struct */
-		u64	cycle_last;
-		u64	mask;
-		int	mult;
-		int	shift;
-	} clock;
-	/* open coded 'struct timespec' */
-	u64		wall_time_sec;
-	u64		wall_time_snsec;
-	u64		monotonic_time_snsec;
-	u64		monotonic_time_sec;
-	u64		monotonic_time_coarse_sec;
-	u64		monotonic_time_coarse_nsec;
-	u64		wall_time_coarse_sec;
-	u64		wall_time_coarse_nsec;
-
-	int		tz_minuteswest;
-	int		tz_dsttime;
-};
-
-extern struct vvar_data *vvar_data;
-extern int vdso_fix_stick;
-
-static inline unsigned int vvar_read_begin(const struct vvar_data *s)
-{
-	unsigned int ret;
-
-repeat:
-	ret =3D READ_ONCE(s->seq);
-	if (unlikely(ret & 1)) {
-		cpu_relax();
-		goto repeat;
-	}
-	smp_rmb(); /* Finish all reads before we return seq */
-	return ret;
-}
-
-static inline int vvar_read_retry(const struct vvar_data *s,
-					unsigned int start)
-{
-	smp_rmb(); /* Finish all reads before checking the value of seq */
-	return unlikely(s->seq !=3D start);
-}
-
-static inline void vvar_write_begin(struct vvar_data *s)
-{
-	++s->seq;
-	smp_wmb(); /* Makes sure that increment of seq is reflected */
-}
-
-static inline void vvar_write_end(struct vvar_data *s)
-{
-	smp_wmb(); /* Makes the value of seq current before we increment */
-	++s->seq;
-}
-
-
-#endif /* _ASM_SPARC_VVAR_DATA_H */
diff --git a/arch/sparc/kernel/Makefile b/arch/sparc/kernel/Makefile
index 22170d4..497b571 100644
--- a/arch/sparc/kernel/Makefile
+++ b/arch/sparc/kernel/Makefile
@@ -41,7 +41,6 @@ obj-$(CONFIG_SPARC32)   +=3D systbls_32.o
 obj-y                   +=3D time_$(BITS).o
 obj-$(CONFIG_SPARC32)   +=3D windows.o
 obj-y                   +=3D cpu.o
-obj-$(CONFIG_SPARC64)	+=3D vdso.o
 obj-$(CONFIG_SPARC32)   +=3D devices.o
 obj-y                   +=3D ptrace_$(BITS).o
 obj-y                   +=3D unaligned_$(BITS).o
diff --git a/arch/sparc/kernel/time_64.c b/arch/sparc/kernel/time_64.c
index b32f27f..87b2670 100644
--- a/arch/sparc/kernel/time_64.c
+++ b/arch/sparc/kernel/time_64.c
@@ -838,14 +838,14 @@ void __init time_init_early(void)
 	if (tlb_type =3D=3D spitfire) {
 		if (is_hummingbird()) {
 			init_tick_ops(&hbtick_operations);
-			clocksource_tick.archdata.vclock_mode =3D VCLOCK_NONE;
+			clocksource_tick.vdso_clock_mode =3D VDSO_CLOCKMODE_NONE;
 		} else {
 			init_tick_ops(&tick_operations);
-			clocksource_tick.archdata.vclock_mode =3D VCLOCK_TICK;
+			clocksource_tick.vdso_clock_mode =3D VDSO_CLOCKMODE_TICK;
 		}
 	} else {
 		init_tick_ops(&stick_operations);
-		clocksource_tick.archdata.vclock_mode =3D VCLOCK_STICK;
+		clocksource_tick.vdso_clock_mode =3D VDSO_CLOCKMODE_STICK;
 	}
 }
=20
diff --git a/arch/sparc/kernel/vdso.c b/arch/sparc/kernel/vdso.c
deleted file mode 100644
index 0e27437..0000000
--- a/arch/sparc/kernel/vdso.c
+++ /dev/null
@@ -1,69 +0,0 @@
-/*
- *  Copyright (C) 2001 Andrea Arcangeli <andrea@suse.de> SuSE
- *  Copyright 2003 Andi Kleen, SuSE Labs.
- *
- *  Thanks to hpa@transmeta.com for some useful hint.
- *  Special thanks to Ingo Molnar for his early experience with
- *  a different vsyscall implementation for Linux/IA32 and for the name.
- */
-
-#include <linux/time.h>
-#include <linux/timekeeper_internal.h>
-
-#include <asm/vvar.h>
-
-void update_vsyscall_tz(void)
-{
-	if (unlikely(vvar_data =3D=3D NULL))
-		return;
-
-	vvar_data->tz_minuteswest =3D sys_tz.tz_minuteswest;
-	vvar_data->tz_dsttime =3D sys_tz.tz_dsttime;
-}
-
-void update_vsyscall(struct timekeeper *tk)
-{
-	struct vvar_data *vdata =3D vvar_data;
-
-	if (unlikely(vdata =3D=3D NULL))
-		return;
-
-	vvar_write_begin(vdata);
-	vdata->vclock_mode =3D tk->tkr_mono.clock->archdata.vclock_mode;
-	vdata->clock.cycle_last =3D tk->tkr_mono.cycle_last;
-	vdata->clock.mask =3D tk->tkr_mono.mask;
-	vdata->clock.mult =3D tk->tkr_mono.mult;
-	vdata->clock.shift =3D tk->tkr_mono.shift;
-
-	vdata->wall_time_sec =3D tk->xtime_sec;
-	vdata->wall_time_snsec =3D tk->tkr_mono.xtime_nsec;
-
-	vdata->monotonic_time_sec =3D tk->xtime_sec +
-				    tk->wall_to_monotonic.tv_sec;
-	vdata->monotonic_time_snsec =3D tk->tkr_mono.xtime_nsec +
-				      (tk->wall_to_monotonic.tv_nsec <<
-				       tk->tkr_mono.shift);
-
-	while (vdata->monotonic_time_snsec >=3D
-	       (((u64)NSEC_PER_SEC) << tk->tkr_mono.shift)) {
-		vdata->monotonic_time_snsec -=3D
-				((u64)NSEC_PER_SEC) << tk->tkr_mono.shift;
-		vdata->monotonic_time_sec++;
-	}
-
-	vdata->wall_time_coarse_sec =3D tk->xtime_sec;
-	vdata->wall_time_coarse_nsec =3D
-			(long)(tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift);
-
-	vdata->monotonic_time_coarse_sec =3D
-		vdata->wall_time_coarse_sec + tk->wall_to_monotonic.tv_sec;
-	vdata->monotonic_time_coarse_nsec =3D
-		vdata->wall_time_coarse_nsec + tk->wall_to_monotonic.tv_nsec;
-
-	while (vdata->monotonic_time_coarse_nsec >=3D NSEC_PER_SEC) {
-		vdata->monotonic_time_coarse_nsec -=3D NSEC_PER_SEC;
-		vdata->monotonic_time_coarse_sec++;
-	}
-
-	vvar_write_end(vdata);
-}
diff --git a/arch/sparc/vdso/Makefile b/arch/sparc/vdso/Makefile
index 400529a..38c5b45 100644
--- a/arch/sparc/vdso/Makefile
+++ b/arch/sparc/vdso/Makefile
@@ -3,6 +3,9 @@
 # Building vDSO images for sparc.
 #
=20
+# Include the generic Makefile to check the built vDSO:
+include $(srctree)/lib/vdso/Makefile.include
+
 # files to link into the vdso
 vobjs-y :=3D vdso-note.o vclock_gettime.o
=20
@@ -102,6 +105,7 @@ $(obj)/vdso32.so.dbg: FORCE \
 quiet_cmd_vdso =3D VDSO    $@
       cmd_vdso =3D $(LD) -nostdlib -o $@ \
 		       $(VDSO_LDFLAGS) $(VDSO_LDFLAGS_$(filter %.lds,$(^F))) \
-		       -T $(filter %.lds,$^) $(filter %.o,$^)
+		       -T $(filter %.lds,$^) $(filter %.o,$^); \
+		       $(cmd_vdso_check)
=20
 VDSO_LDFLAGS =3D -shared --hash-style=3Dboth --build-id=3Dsha1 -Bsymbolic --=
no-undefined -z noexecstack
diff --git a/arch/sparc/vdso/vclock_gettime.c b/arch/sparc/vdso/vclock_gettim=
e.c
index e768c0b..093a7ff 100644
--- a/arch/sparc/vdso/vclock_gettime.c
+++ b/arch/sparc/vdso/vclock_gettime.c
@@ -12,169 +12,40 @@
  * Copyright (c) 2017 Oracle and/or its affiliates. All rights reserved.
  */
=20
-#include <linux/kernel.h>
-#include <linux/string.h>
-#include <asm/io.h>
-#include <asm/timex.h>
-#include <asm/clocksource.h>
-#include <asm/vdso/gettimeofday.h>
-#include <asm/vvar.h>
+#include <linux/compiler.h>
+#include <linux/types.h>
=20
-/*
- * Compute the vvar page's address in the process address space, and return =
it
- * as a pointer to the vvar_data.
- */
-notrace static __always_inline struct vvar_data *get_vvar_data(void)
-{
-	unsigned long ret;
+#include <vdso/gettime.h>
=20
-	/*
-	 * vdso data page is the first vDSO page so grab the PC
-	 * and move up a page to get to the data page.
-	 */
-	__asm__("rd %%pc, %0" : "=3Dr" (ret));
-	ret &=3D ~(8192 - 1);
-	ret -=3D 8192;
+#include <asm/vdso/gettimeofday.h>
=20
-	return (struct vvar_data *) ret;
-}
+#include "../../../../lib/vdso/gettimeofday.c"
=20
-notrace static __always_inline u64 vgetsns(struct vvar_data *vvar)
+int __vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
 {
-	u64 v;
-	u64 cycles =3D __arch_get_hw_counter(vvar);
-
-	v =3D (cycles - vvar->clock.cycle_last) & vvar->clock.mask;
-	return v * vvar->clock.mult;
+	return __cvdso_gettimeofday(tv, tz);
 }
=20
-notrace static __always_inline int do_realtime(struct vvar_data *vvar,
-					       struct __kernel_old_timespec *ts)
-{
-	unsigned long seq;
-	u64 ns;
-
-	do {
-		seq =3D vvar_read_begin(vvar);
-		ts->tv_sec =3D vvar->wall_time_sec;
-		ns =3D vvar->wall_time_snsec;
-		ns +=3D vgetsns(vvar);
-		ns =3D vdso_shift_ns(ns, vvar->clock.shift);
-	} while (unlikely(vvar_read_retry(vvar, seq)));
-
-	ts->tv_sec +=3D __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
-	ts->tv_nsec =3D ns;
+int gettimeofday(struct __kernel_old_timeval *, struct timezone *)
+	__weak __alias(__vdso_gettimeofday);
=20
-	return 0;
-}
-
-notrace static __always_inline int do_monotonic(struct vvar_data *vvar,
-						struct __kernel_old_timespec *ts)
+#if defined(CONFIG_SPARC64)
+int __vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts)
 {
-	unsigned long seq;
-	u64 ns;
-
-	do {
-		seq =3D vvar_read_begin(vvar);
-		ts->tv_sec =3D vvar->monotonic_time_sec;
-		ns =3D vvar->monotonic_time_snsec;
-		ns +=3D vgetsns(vvar);
-		ns =3D vdso_shift_ns(ns, vvar->clock.shift);
-	} while (unlikely(vvar_read_retry(vvar, seq)));
-
-	ts->tv_sec +=3D __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
-	ts->tv_nsec =3D ns;
-
-	return 0;
-}
-
-notrace static int do_realtime_coarse(struct vvar_data *vvar,
-				      struct __kernel_old_timespec *ts)
-{
-	unsigned long seq;
-
-	do {
-		seq =3D vvar_read_begin(vvar);
-		ts->tv_sec =3D vvar->wall_time_coarse_sec;
-		ts->tv_nsec =3D vvar->wall_time_coarse_nsec;
-	} while (unlikely(vvar_read_retry(vvar, seq)));
-	return 0;
+	return __cvdso_clock_gettime(clock, ts);
 }
=20
-notrace static int do_monotonic_coarse(struct vvar_data *vvar,
-				       struct __kernel_old_timespec *ts)
-{
-	unsigned long seq;
-
-	do {
-		seq =3D vvar_read_begin(vvar);
-		ts->tv_sec =3D vvar->monotonic_time_coarse_sec;
-		ts->tv_nsec =3D vvar->monotonic_time_coarse_nsec;
-	} while (unlikely(vvar_read_retry(vvar, seq)));
+int clock_gettime(clockid_t, struct __kernel_timespec *)
+	__weak __alias(__vdso_clock_gettime);
=20
-	return 0;
-}
+#else
=20
-notrace int
-__vdso_clock_gettime(clockid_t clock, struct __kernel_old_timespec *ts)
+int __vdso_clock_gettime(clockid_t clock, struct old_timespec32 *ts)
 {
-	struct vvar_data *vvd =3D get_vvar_data();
-
-	switch (clock) {
-	case CLOCK_REALTIME:
-		if (unlikely(vvd->vclock_mode =3D=3D VCLOCK_NONE))
-			break;
-		return do_realtime(vvd, ts);
-	case CLOCK_MONOTONIC:
-		if (unlikely(vvd->vclock_mode =3D=3D VCLOCK_NONE))
-			break;
-		return do_monotonic(vvd, ts);
-	case CLOCK_REALTIME_COARSE:
-		return do_realtime_coarse(vvd, ts);
-	case CLOCK_MONOTONIC_COARSE:
-		return do_monotonic_coarse(vvd, ts);
-	}
-	/*
-	 * Unknown clock ID ? Fall back to the syscall.
-	 */
-	return clock_gettime_fallback(clock, ts);
+	return __cvdso_clock_gettime32(clock, ts);
 }
-int
-clock_gettime(clockid_t, struct __kernel_old_timespec *)
-	__attribute__((weak, alias("__vdso_clock_gettime")));
=20
-notrace int
-__vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezone *tz)
-{
-	struct vvar_data *vvd =3D get_vvar_data();
+int clock_gettime(clockid_t, struct old_timespec32 *)
+	__weak __alias(__vdso_clock_gettime);
=20
-	if (likely(vvd->vclock_mode !=3D VCLOCK_NONE)) {
-		if (likely(tv !=3D NULL)) {
-			union tstv_t {
-				struct __kernel_old_timespec ts;
-				struct __kernel_old_timeval tv;
-			} *tstv =3D (union tstv_t *) tv;
-			do_realtime(vvd, &tstv->ts);
-			/*
-			 * Assign before dividing to ensure that the division is
-			 * done in the type of tv_usec, not tv_nsec.
-			 *
-			 * There cannot be > 1 billion usec in a second:
-			 * do_realtime() has already distributed such overflow
-			 * into tv_sec.  So we can assign it to an int safely.
-			 */
-			tstv->tv.tv_usec =3D tstv->ts.tv_nsec;
-			tstv->tv.tv_usec /=3D 1000;
-		}
-		if (unlikely(tz !=3D NULL)) {
-			/* Avoid memcpy. Some old compilers fail to inline it */
-			tz->tz_minuteswest =3D vvd->tz_minuteswest;
-			tz->tz_dsttime =3D vvd->tz_dsttime;
-		}
-		return 0;
-	}
-	return gettimeofday_fallback(tv, tz);
-}
-int
-gettimeofday(struct __kernel_old_timeval *, struct timezone *)
-	__attribute__((weak, alias("__vdso_gettimeofday")));
+#endif
diff --git a/arch/sparc/vdso/vdso-layout.lds.S b/arch/sparc/vdso/vdso-layout.=
lds.S
index 9e08047..180e5d0 100644
--- a/arch/sparc/vdso/vdso-layout.lds.S
+++ b/arch/sparc/vdso/vdso-layout.lds.S
@@ -4,6 +4,10 @@
  * This script controls its layout.
  */
=20
+#include <vdso/datapage.h>
+#include <vdso/page.h>
+#include <asm/vdso/vsyscall.h>
+
 SECTIONS
 {
 	/*
@@ -13,8 +17,7 @@ SECTIONS
 	 * segment. Page size is 8192 for both 64-bit and 32-bit vdso binaries
 	 */
=20
-	vvar_start =3D . -8192;
-	vvar_data =3D vvar_start;
+	VDSO_VVAR_SYMS
=20
 	. =3D SIZEOF_HEADERS;
=20
diff --git a/arch/sparc/vdso/vma.c b/arch/sparc/vdso/vma.c
index 582d84e..38a664d 100644
--- a/arch/sparc/vdso/vma.c
+++ b/arch/sparc/vdso/vma.c
@@ -16,17 +16,16 @@
 #include <linux/linkage.h>
 #include <linux/random.h>
 #include <linux/elf.h>
+#include <linux/vdso_datastore.h>
 #include <asm/cacheflush.h>
 #include <asm/spitfire.h>
 #include <asm/vdso.h>
-#include <asm/vvar.h>
 #include <asm/page.h>
=20
-unsigned int __read_mostly vdso_enabled =3D 1;
+#include <vdso/datapage.h>
+#include <asm/vdso/vsyscall.h>
=20
-static struct vm_special_mapping vvar_mapping =3D {
-	.name =3D "[vvar]"
-};
+unsigned int __read_mostly vdso_enabled =3D 1;
=20
 #ifdef	CONFIG_SPARC64
 static struct vm_special_mapping vdso_mapping64 =3D {
@@ -40,10 +39,8 @@ static struct vm_special_mapping vdso_mapping32 =3D {
 };
 #endif
=20
-struct vvar_data *vvar_data;
-
 /*
- * Allocate pages for the vdso and vvar, and copy in the vdso text from the
+ * Allocate pages for the vdso and copy in the vdso text from the
  * kernel image.
  */
 static int __init init_vdso_image(const struct vdso_image *image,
@@ -51,9 +48,8 @@ static int __init init_vdso_image(const struct vdso_image *=
image,
 				  bool elf64)
 {
 	int cnpages =3D (image->size) / PAGE_SIZE;
-	struct page *dp, **dpp =3D NULL;
 	struct page *cp, **cpp =3D NULL;
-	int i, dnpages =3D 0;
+	int i;
=20
 	/*
 	 * First, the vdso text.  This is initialied data, an integral number of
@@ -76,31 +72,6 @@ static int __init init_vdso_image(const struct vdso_image =
*image,
 		copy_page(page_address(cp), image->data + i * PAGE_SIZE);
 	}
=20
-	/*
-	 * Now the vvar page.  This is uninitialized data.
-	 */
-
-	if (vvar_data =3D=3D NULL) {
-		dnpages =3D (sizeof(struct vvar_data) / PAGE_SIZE) + 1;
-		if (WARN_ON(dnpages !=3D 1))
-			goto oom;
-		dpp =3D kcalloc(dnpages, sizeof(struct page *), GFP_KERNEL);
-		vvar_mapping.pages =3D dpp;
-
-		if (!dpp)
-			goto oom;
-
-		dp =3D alloc_page(GFP_KERNEL);
-		if (!dp)
-			goto oom;
-
-		dpp[0] =3D dp;
-		vvar_data =3D page_address(dp);
-		memset(vvar_data, 0, PAGE_SIZE);
-
-		vvar_data->seq =3D 0;
-	}
-
 	return 0;
  oom:
 	if (cpp !=3D NULL) {
@@ -112,15 +83,6 @@ static int __init init_vdso_image(const struct vdso_image=
 *image,
 		vdso_mapping->pages =3D NULL;
 	}
=20
-	if (dpp !=3D NULL) {
-		for (i =3D 0; i < dnpages; i++) {
-			if (dpp[i] !=3D NULL)
-				__free_page(dpp[i]);
-		}
-		kfree(dpp);
-		vvar_mapping.pages =3D NULL;
-	}
-
 	pr_warn("Cannot allocate vdso\n");
 	vdso_enabled =3D 0;
 	return -ENOMEM;
@@ -155,9 +117,12 @@ static unsigned long vdso_addr(unsigned long start, unsi=
gned int len)
 	return start + (offset << PAGE_SHIFT);
 }
=20
+static_assert(VDSO_NR_PAGES =3D=3D __VDSO_PAGES);
+
 static int map_vdso(const struct vdso_image *image,
 		struct vm_special_mapping *vdso_mapping)
 {
+	const size_t area_size =3D image->size + VDSO_NR_PAGES * PAGE_SIZE;
 	struct mm_struct *mm =3D current->mm;
 	struct vm_area_struct *vma;
 	unsigned long text_start, addr =3D 0;
@@ -170,23 +135,20 @@ static int map_vdso(const struct vdso_image *image,
 	 * region is free.
 	 */
 	if (current->flags & PF_RANDOMIZE) {
-		addr =3D get_unmapped_area(NULL, 0,
-					 image->size - image->sym_vvar_start,
-					 0, 0);
+		addr =3D get_unmapped_area(NULL, 0, area_size, 0, 0);
 		if (IS_ERR_VALUE(addr)) {
 			ret =3D addr;
 			goto up_fail;
 		}
-		addr =3D vdso_addr(addr, image->size - image->sym_vvar_start);
+		addr =3D vdso_addr(addr, area_size);
 	}
-	addr =3D get_unmapped_area(NULL, addr,
-				 image->size - image->sym_vvar_start, 0, 0);
+	addr =3D get_unmapped_area(NULL, addr, area_size, 0, 0);
 	if (IS_ERR_VALUE(addr)) {
 		ret =3D addr;
 		goto up_fail;
 	}
=20
-	text_start =3D addr - image->sym_vvar_start;
+	text_start =3D addr + VDSO_NR_PAGES * PAGE_SIZE;
 	current->mm->context.vdso =3D (void __user *)text_start;
=20
 	/*
@@ -204,11 +166,7 @@ static int map_vdso(const struct vdso_image *image,
 		goto up_fail;
 	}
=20
-	vma =3D _install_special_mapping(mm,
-				       addr,
-				       -image->sym_vvar_start,
-				       VM_READ|VM_MAYREAD,
-				       &vvar_mapping);
+	vma =3D vdso_install_vvar_mapping(mm, addr);
=20
 	if (IS_ERR(vma)) {
 		ret =3D PTR_ERR(vma);

