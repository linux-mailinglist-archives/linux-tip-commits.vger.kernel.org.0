Return-Path: <linux-tip-commits+bounces-7138-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E6CF9C28701
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 76B093B1BCE
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:48:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC0023054F5;
	Sat,  1 Nov 2025 19:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WfbVd9AK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GGYBuzm/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8299E3019D6;
	Sat,  1 Nov 2025 19:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026466; cv=none; b=WwlpSzt/jRw0RVwwg5vBecdHuujlEopWAZ/Kyv4FOT9lYBcvbqA/vi8deKTsZ44pDUOq/d8Xs9++nENM7dDHfMA3Z7e5w3NqrW7e6jgOzGC4dMXNHjZTAH/rGe5KI6c++OWTMlFW6jfSG5tI170ZnxfOOA9db2dcXYVJl05QSYg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026466; c=relaxed/simple;
	bh=tjcbiFZYJ+zi9bcj6JCbtw4+huz1EXpPn1lBf+U6/oI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=m7H2TOM3gNCd8zdTw8jvt+01WRVonUh7U6N7XYhPQ2OvBBUjQqbMWyW5S2b4clHAABQwY/Gga0KyaOLLNp/Rm9ghZgd27Pf/q+V6IL02a7mpGzgz0x5lexgk16v+q340IBJWvKspZBjPmWHgPL8VeOVga7lNvMtXNYPXBcQ1z4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WfbVd9AK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GGYBuzm/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:47:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026459;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rrtPN4ioG+dMDQU1kUWKFgg4NKFWvwSlBRlaQEorY8M=;
	b=WfbVd9AKmRKWL0HqWeB1vnCUks0+0ILb1BGo2ud5VMudmgNRp9FllttRB/5E1GNwej4iJ4
	XKvDyA3rP82CxIetOnu8x+Xl0UWyFRohtm91f2ZEPGynx8qRsZR0X+7Y5mWgD8ymtiIB4Y
	fHy5EN4gtzjCDq48eqUuccqjpIvX2ShC2XBxQiQ/H7hmMaLoz6ojP7fdPKybpRnX9vjhjc
	DHKPz4eHJ3whSRqYqMObuvVkC+1JBCuJsy+0dlCd9DttqVEsRzJlheabPUa+d2UVIWwGWQ
	PdbgN73C5zwjLCda/ZqKP2YQJuAKiwZXIg/bEjCN6i2rJeRix5z4tC2gjjJo8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026459;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rrtPN4ioG+dMDQU1kUWKFgg4NKFWvwSlBRlaQEorY8M=;
	b=GGYBuzm/RMbMzg+ahTy8ijz2KG+2MGJlIiBfyTqRLKIGGoSQVN1igE19ZQX4LcMcIMojVX
	LaYhQzXw67u8Q6CA==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] sparc64: vdso: Move hardware counter read into header
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Andreas Larsson <andreas@gaisler.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20251014-vdso-sparc64-generic-2-v4-28-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-28-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202645808.2601451.1204320128665001561.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     df9d70c2e702c8287ee22c44536e60b5f289943c
Gitweb:        https://git.kernel.org/tip/df9d70c2e702c8287ee22c44536e60b5f28=
9943c
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 14 Oct 2025 08:49:14 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:44:07 +01:00

sparc64: vdso: Move hardware counter read into header

The generic vDSO libraries expected the architecture glue around hardware
counter reading in asm/vdso/gettimeofday.h. To prepare the adoption of the
generic library, move the existing functions there.

While at it, perform some trivial alignment with the generic vDSO library:

  * Drop 'notrace', as the functions are __always_inline anyways
  * Use the same parameter types
  * Use the same function names

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Acked-by: Andreas Larsson <andreas@gaisler.com>
Link: https://patch.msgid.link/20251014-vdso-sparc64-generic-2-v4-28-e0607bf4=
9dea@linutronix.de
---
 arch/sparc/include/asm/vdso/gettimeofday.h | 78 +++++++++++++++++++++-
 arch/sparc/vdso/vclock_gettime.c           | 70 +------------------
 2 files changed, 82 insertions(+), 66 deletions(-)
 create mode 100644 arch/sparc/include/asm/vdso/gettimeofday.h

diff --git a/arch/sparc/include/asm/vdso/gettimeofday.h b/arch/sparc/include/=
asm/vdso/gettimeofday.h
new file mode 100644
index 0000000..31f6505
--- /dev/null
+++ b/arch/sparc/include/asm/vdso/gettimeofday.h
@@ -0,0 +1,78 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright 2006 Andi Kleen, SUSE Labs.
+ */
+
+#ifndef _ASM_SPARC_VDSO_GETTIMEOFDAY_H
+#define _ASM_SPARC_VDSO_GETTIMEOFDAY_H
+
+#include <linux/types.h>
+#include <asm/vvar.h>
+
+#ifdef	CONFIG_SPARC64
+static __always_inline u64 vdso_shift_ns(u64 val, u32 amt)
+{
+	return val >> amt;
+}
+
+static __always_inline u64 vread_tick(void)
+{
+	u64	ret;
+
+	__asm__ __volatile__("rd %%tick, %0" : "=3Dr" (ret));
+	return ret;
+}
+
+static __always_inline u64 vread_tick_stick(void)
+{
+	u64	ret;
+
+	__asm__ __volatile__("rd %%asr24, %0" : "=3Dr" (ret));
+	return ret;
+}
+#else
+static __always_inline u64 vdso_shift_ns(u64 val, u32 amt)
+{
+	u64 ret;
+
+	__asm__ __volatile__("sllx %H1, 32, %%g1\n\t"
+			     "srl %L1, 0, %L1\n\t"
+			     "or %%g1, %L1, %%g1\n\t"
+			     "srlx %%g1, %2, %L0\n\t"
+			     "srlx %L0, 32, %H0"
+			     : "=3Dr" (ret)
+			     : "r" (val), "r" (amt)
+			     : "g1");
+	return ret;
+}
+
+static __always_inline u64 vread_tick(void)
+{
+	register unsigned long long ret asm("o4");
+
+	__asm__ __volatile__("rd %%tick, %L0\n\t"
+			     "srlx %L0, 32, %H0"
+			     : "=3Dr" (ret));
+	return ret;
+}
+
+static __always_inline u64 vread_tick_stick(void)
+{
+	register unsigned long long ret asm("o4");
+
+	__asm__ __volatile__("rd %%asr24, %L0\n\t"
+			     "srlx %L0, 32, %H0"
+			     : "=3Dr" (ret));
+	return ret;
+}
+#endif
+
+static __always_inline u64 __arch_get_hw_counter(struct vvar_data *vvar)
+{
+	if (likely(vvar->vclock_mode =3D=3D VCLOCK_STICK))
+		return vread_tick_stick();
+	else
+		return vread_tick();
+}
+
+#endif /* _ASM_SPARC_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/sparc/vdso/vclock_gettime.c b/arch/sparc/vdso/vclock_gettim=
e.c
index 643608b..16ac809 100644
--- a/arch/sparc/vdso/vclock_gettime.c
+++ b/arch/sparc/vdso/vclock_gettime.c
@@ -19,6 +19,7 @@
 #include <asm/unistd.h>
 #include <asm/timex.h>
 #include <asm/clocksource.h>
+#include <asm/vdso/gettimeofday.h>
 #include <asm/vvar.h>
=20
 #ifdef	CONFIG_SPARC64
@@ -85,73 +86,10 @@ notrace static long vdso_fallback_gettimeofday(struct __k=
ernel_old_timeval *tv,=20
 	return o0;
 }
=20
-#ifdef	CONFIG_SPARC64
-notrace static __always_inline u64 __shr64(u64 val, int amt)
-{
-	return val >> amt;
-}
-
-notrace static __always_inline u64 vread_tick(void)
-{
-	u64	ret;
-
-	__asm__ __volatile__("rd %%tick, %0" : "=3Dr" (ret));
-	return ret;
-}
-
-notrace static __always_inline u64 vread_tick_stick(void)
-{
-	u64	ret;
-
-	__asm__ __volatile__("rd %%asr24, %0" : "=3Dr" (ret));
-	return ret;
-}
-#else
-notrace static __always_inline u64 __shr64(u64 val, int amt)
-{
-	u64 ret;
-
-	__asm__ __volatile__("sllx %H1, 32, %%g1\n\t"
-			     "srl %L1, 0, %L1\n\t"
-			     "or %%g1, %L1, %%g1\n\t"
-			     "srlx %%g1, %2, %L0\n\t"
-			     "srlx %L0, 32, %H0"
-			     : "=3Dr" (ret)
-			     : "r" (val), "r" (amt)
-			     : "g1");
-	return ret;
-}
-
-notrace static __always_inline u64 vread_tick(void)
-{
-	register unsigned long long ret asm("o4");
-
-	__asm__ __volatile__("rd %%tick, %L0\n\t"
-			     "srlx %L0, 32, %H0"
-			     : "=3Dr" (ret));
-	return ret;
-}
-
-notrace static __always_inline u64 vread_tick_stick(void)
-{
-	register unsigned long long ret asm("o4");
-
-	__asm__ __volatile__("rd %%asr24, %L0\n\t"
-			     "srlx %L0, 32, %H0"
-			     : "=3Dr" (ret));
-	return ret;
-}
-#endif
-
 notrace static __always_inline u64 vgetsns(struct vvar_data *vvar)
 {
 	u64 v;
-	u64 cycles;
-
-	if (likely(vvar->vclock_mode =3D=3D VCLOCK_STICK))
-		cycles =3D vread_tick_stick();
-	else
-		cycles =3D vread_tick();
+	u64 cycles =3D __arch_get_hw_counter(vvar);
=20
 	v =3D (cycles - vvar->clock.cycle_last) & vvar->clock.mask;
 	return v * vvar->clock.mult;
@@ -168,7 +106,7 @@ notrace static __always_inline int do_realtime(struct vva=
r_data *vvar,
 		ts->tv_sec =3D vvar->wall_time_sec;
 		ns =3D vvar->wall_time_snsec;
 		ns +=3D vgetsns(vvar);
-		ns =3D __shr64(ns, vvar->clock.shift);
+		ns =3D vdso_shift_ns(ns, vvar->clock.shift);
 	} while (unlikely(vvar_read_retry(vvar, seq)));
=20
 	ts->tv_sec +=3D __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
@@ -188,7 +126,7 @@ notrace static __always_inline int do_monotonic(struct vv=
ar_data *vvar,
 		ts->tv_sec =3D vvar->monotonic_time_sec;
 		ns =3D vvar->monotonic_time_snsec;
 		ns +=3D vgetsns(vvar);
-		ns =3D __shr64(ns, vvar->clock.shift);
+		ns =3D vdso_shift_ns(ns, vvar->clock.shift);
 	} while (unlikely(vvar_read_retry(vvar, seq)));
=20
 	ts->tv_sec +=3D __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);

