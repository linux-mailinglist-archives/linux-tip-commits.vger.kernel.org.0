Return-Path: <linux-tip-commits+bounces-7137-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CF424C286F8
	for <lists+linux-tip-commits@lfdr.de>; Sat, 01 Nov 2025 20:50:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D2E4F3AF010
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Nov 2025 19:48:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5977630505B;
	Sat,  1 Nov 2025 19:47:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MGuNdzqK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fs3ww1dW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C140B303CBD;
	Sat,  1 Nov 2025 19:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762026463; cv=none; b=hA8afPJqMndj/LHOohlc/If/VtuncL6kwnLpZbD26rUVDDmNxBBxds4fBK5JN+yEDusLj5iQwcaaj2OaegBky4ujic3YvAmgc5UTrQad2x29zhNExrq7s6JobXro8DJr9cfLAYuIpUeMawRMmnyMmcKOTrb7gZWExHCTAwHhGzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762026463; c=relaxed/simple;
	bh=DL6SnKWGWj6qsIeJO43ZerGWLjhsOpXfps0Jrd7txB0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kh20XlMwcSO2R/lnWrloo1g/QMltCJLlPyPW/Q3BEB+ZeWkhp1Lz8yAuNMadF2imtwHck6mf0DHnrtZ7F0mfyphNMIFzcT4NIbZFc17chRMO43veAe9ByxBNRA4pYqZj8+CKF05RmFuAHiPvjsD5ngdguu74oIaWF7YwUPrGzLo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MGuNdzqK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Fs3ww1dW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Nov 2025 19:47:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1762026458;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NDhNwuLLFCEwAQGmKrbn3L3YHMy5DD1uvPprLiFH8Yk=;
	b=MGuNdzqKWrnvKiNR54R5zwVRMpkqBycLeGzF/Ttz+Fho65TyaE0vtZ1NUmp8Dl3sW5jDop
	BwD7K6YmHBaXgMRjC0nIRZ3gN1Uo58uF249PQxldxbwn7Ymeg9Y+37aGwSjnKprwOYnr0u
	qhhlf2Q7Zc023Tcnv9hJ70PQiZBc4uJ62BNnbio39NJcHlb/rSym0KAJUeankL++jmTQ03
	tbnCJ4d/CAxPWsVSQP7tzFJiq24C38UopfvobrbnDSbTkSjhK/3x0mgBKyz2S7BvWywaj3
	QEy1k04XJbs6aYTea6bE/kzDMioM0Q5KAsuELTcPecJqeLe5+dAZCIpUfTTVYg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1762026458;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NDhNwuLLFCEwAQGmKrbn3L3YHMy5DD1uvPprLiFH8Yk=;
	b=Fs3ww1dWcl1s7GwogpTrxIS5uaa2+j1a46Q8XL7McDVB7m/X3UwyGpM/s4t+uZAi2AUMsh
	XH+/1qGe2Bt23sAg==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] sparc64: vdso: Move syscall fallbacks into header
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Andreas Larsson <andreas@gaisler.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To:
 <20251014-vdso-sparc64-generic-2-v4-29-e0607bf49dea@linutronix.de>
References: <20251014-vdso-sparc64-generic-2-v4-29-e0607bf49dea@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176202645691.2601451.4404624440140261574.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     260e6fef4e71ad13c4fb958a9563cb81b3293aff
Gitweb:        https://git.kernel.org/tip/260e6fef4e71ad13c4fb958a9563cb81b32=
93aff
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 14 Oct 2025 08:49:15 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 01 Nov 2025 20:44:07 +01:00

sparc64: vdso: Move syscall fallbacks into header

The generic vDSO libraries expected the syscall fallbacks in
asm/vdso/gettimeofday.h. To prepare the adoption of the generic library,
move the existing functions there.

While at it, rename them so they match what the generic library expects.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Andreas Larsson <andreas@gaisler.com>
Reviewed-by: Andreas Larsson <andreas@gaisler.com>
Acked-by: Andreas Larsson <andreas@gaisler.com>
Link: https://patch.msgid.link/20251014-vdso-sparc64-generic-2-v4-29-e0607bf4=
9dea@linutronix.de
---
 arch/sparc/include/asm/vdso/gettimeofday.h | 50 +++++++++++++++++++++-
 arch/sparc/vdso/vclock_gettime.c           | 51 +---------------------
 2 files changed, 52 insertions(+), 49 deletions(-)

diff --git a/arch/sparc/include/asm/vdso/gettimeofday.h b/arch/sparc/include/=
asm/vdso/gettimeofday.h
index 31f6505..429dc08 100644
--- a/arch/sparc/include/asm/vdso/gettimeofday.h
+++ b/arch/sparc/include/asm/vdso/gettimeofday.h
@@ -6,6 +6,9 @@
 #ifndef _ASM_SPARC_VDSO_GETTIMEOFDAY_H
 #define _ASM_SPARC_VDSO_GETTIMEOFDAY_H
=20
+#include <uapi/linux/time.h>
+#include <uapi/linux/unistd.h>
+
 #include <linux/types.h>
 #include <asm/vvar.h>
=20
@@ -75,4 +78,51 @@ static __always_inline u64 __arch_get_hw_counter(struct vv=
ar_data *vvar)
 		return vread_tick();
 }
=20
+#ifdef	CONFIG_SPARC64
+#define SYSCALL_STRING							\
+	"ta	0x6d;"							\
+	"bcs,a	1f;"							\
+	" sub	%%g0, %%o0, %%o0;"					\
+	"1:"
+#else
+#define SYSCALL_STRING							\
+	"ta	0x10;"							\
+	"bcs,a	1f;"							\
+	" sub	%%g0, %%o0, %%o0;"					\
+	"1:"
+#endif
+
+#define SYSCALL_CLOBBERS						\
+	"f0", "f1", "f2", "f3", "f4", "f5", "f6", "f7",			\
+	"f8", "f9", "f10", "f11", "f12", "f13", "f14", "f15",		\
+	"f16", "f17", "f18", "f19", "f20", "f21", "f22", "f23",		\
+	"f24", "f25", "f26", "f27", "f28", "f29", "f30", "f31",		\
+	"f32", "f34", "f36", "f38", "f40", "f42", "f44", "f46",		\
+	"f48", "f50", "f52", "f54", "f56", "f58", "f60", "f62",		\
+	"cc", "memory"
+
+static __always_inline
+long clock_gettime_fallback(clockid_t clock, struct __kernel_old_timespec *t=
s)
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
+static __always_inline
+long gettimeofday_fallback(struct __kernel_old_timeval *tv, struct timezone =
*tz)
+{
+	register long num __asm__("g1") =3D __NR_gettimeofday;
+	register long o0 __asm__("o0") =3D (long) tv;
+	register long o1 __asm__("o1") =3D (long) tz;
+
+	__asm__ __volatile__(SYSCALL_STRING : "=3Dr" (o0) : "r" (num),
+			     "0" (o0), "r" (o1) : SYSCALL_CLOBBERS);
+	return o0;
+}
+
 #endif /* _ASM_SPARC_VDSO_GETTIMEOFDAY_H */
diff --git a/arch/sparc/vdso/vclock_gettime.c b/arch/sparc/vdso/vclock_gettim=
e.c
index 16ac809..e768c0b 100644
--- a/arch/sparc/vdso/vclock_gettime.c
+++ b/arch/sparc/vdso/vclock_gettime.c
@@ -13,38 +13,13 @@
  */
=20
 #include <linux/kernel.h>
-#include <linux/time.h>
 #include <linux/string.h>
 #include <asm/io.h>
-#include <asm/unistd.h>
 #include <asm/timex.h>
 #include <asm/clocksource.h>
 #include <asm/vdso/gettimeofday.h>
 #include <asm/vvar.h>
=20
-#ifdef	CONFIG_SPARC64
-#define SYSCALL_STRING							\
-	"ta	0x6d;"							\
-	"bcs,a	1f;"							\
-	" sub	%%g0, %%o0, %%o0;"					\
-	"1:"
-#else
-#define SYSCALL_STRING							\
-	"ta	0x10;"							\
-	"bcs,a	1f;"							\
-	" sub	%%g0, %%o0, %%o0;"					\
-	"1:"
-#endif
-
-#define SYSCALL_CLOBBERS						\
-	"f0", "f1", "f2", "f3", "f4", "f5", "f6", "f7",			\
-	"f8", "f9", "f10", "f11", "f12", "f13", "f14", "f15",		\
-	"f16", "f17", "f18", "f19", "f20", "f21", "f22", "f23",		\
-	"f24", "f25", "f26", "f27", "f28", "f29", "f30", "f31",		\
-	"f32", "f34", "f36", "f38", "f40", "f42", "f44", "f46",		\
-	"f48", "f50", "f52", "f54", "f56", "f58", "f60", "f62",		\
-	"cc", "memory"
-
 /*
  * Compute the vvar page's address in the process address space, and return =
it
  * as a pointer to the vvar_data.
@@ -64,28 +39,6 @@ notrace static __always_inline struct vvar_data *get_vvar_=
data(void)
 	return (struct vvar_data *) ret;
 }
=20
-notrace static long vdso_fallback_gettime(long clock, struct __kernel_old_ti=
mespec *ts)
-{
-	register long num __asm__("g1") =3D __NR_clock_gettime;
-	register long o0 __asm__("o0") =3D clock;
-	register long o1 __asm__("o1") =3D (long) ts;
-
-	__asm__ __volatile__(SYSCALL_STRING : "=3Dr" (o0) : "r" (num),
-			     "0" (o0), "r" (o1) : SYSCALL_CLOBBERS);
-	return o0;
-}
-
-notrace static long vdso_fallback_gettimeofday(struct __kernel_old_timeval *=
tv, struct timezone *tz)
-{
-	register long num __asm__("g1") =3D __NR_gettimeofday;
-	register long o0 __asm__("o0") =3D (long) tv;
-	register long o1 __asm__("o1") =3D (long) tz;
-
-	__asm__ __volatile__(SYSCALL_STRING : "=3Dr" (o0) : "r" (num),
-			     "0" (o0), "r" (o1) : SYSCALL_CLOBBERS);
-	return o0;
-}
-
 notrace static __always_inline u64 vgetsns(struct vvar_data *vvar)
 {
 	u64 v;
@@ -184,7 +137,7 @@ __vdso_clock_gettime(clockid_t clock, struct __kernel_old=
_timespec *ts)
 	/*
 	 * Unknown clock ID ? Fall back to the syscall.
 	 */
-	return vdso_fallback_gettime(clock, ts);
+	return clock_gettime_fallback(clock, ts);
 }
 int
 clock_gettime(clockid_t, struct __kernel_old_timespec *)
@@ -220,7 +173,7 @@ __vdso_gettimeofday(struct __kernel_old_timeval *tv, stru=
ct timezone *tz)
 		}
 		return 0;
 	}
-	return vdso_fallback_gettimeofday(tv, tz);
+	return gettimeofday_fallback(tv, tz);
 }
 int
 gettimeofday(struct __kernel_old_timeval *, struct timezone *)

