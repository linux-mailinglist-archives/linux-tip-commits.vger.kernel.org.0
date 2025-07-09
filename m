Return-Path: <linux-tip-commits+bounces-6041-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 50D1FAFE4BA
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jul 2025 11:58:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3106D1C42792
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jul 2025 09:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0E9F28AAEB;
	Wed,  9 Jul 2025 09:57:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GI+/ditH";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SGs/eVe9"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADECE289E0C;
	Wed,  9 Jul 2025 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055061; cv=none; b=VMhZJtEtXaJyPr2YSHqa3vL08ZGa7+Dp//87lpmlPqMxWiA/ksQokgg3345ExHJFnsuOG5ov6kGWGjQwb4ZWwKdk6LXB7mIThatvZ91q5Lz5G+OAcd5SWABAcZXU3PGRa5oXvT+54hDkgobEL0hvM5R1pfSpfw2uEuNF84DXBkE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055061; c=relaxed/simple;
	bh=KtA77ezeByJlP6bZk01bUfEOleH7lUmvjIuFm35RORk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=u2gmVnbPx5zk3DVVayjdzxENERjR0Yqe2dD8Oe5XsUQ7Yv9i3GHGzHdoec3YJ3YbdKBg0eGaTPV50+Ibx4cN/qXVIbfC4hjTzv6zRNIDGWfv/Pl/H4gzAVS/o8YnZjQKUMSd0LDllg4NEZ5VDJ+UAOU5oMGFKG1R30unGK9Kffg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GI+/ditH; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SGs/eVe9; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Jul 2025 09:57:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752055058;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sk7qjS5fEApz706NO33LcHc3ofUNAMYW+mdJKhvxZrc=;
	b=GI+/ditHTsFjYqdGHUPi/omDQ6asLnj0Kg6iA6MFbWuTxRlrrdMikuIlhZeZFVMm1elKmn
	lC/U++ypSsb3jbqdYr4s5FvNeXTLksNN/eDTo6ofb6WZGqTnZKLT0uCPNIdaIXY900qUG2
	gEcJfGwcUytaAogn303lxUZTHt8UAXe3sZtUawGK8lyQoKJQY0UVvRdU0KRuxZxoegmwOf
	rPMCgcV0haCcxpn5aTKcNSCIbb2A3009IGvslK8HRaE1iILiZsusw53ioX2A202p+0LjSV
	8wAzeHQfePXagXKEayCgw0dO4uGrKtOzirDh58HqYOx52nx8JCHG3lu3Em4JbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752055058;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sk7qjS5fEApz706NO33LcHc3ofUNAMYW+mdJKhvxZrc=;
	b=SGs/eVe9oFkD8nPIr0gvy/tP+2V17ACmxnIkLLGPSfNzoQdvNQQt80HiBH+ji8hlShqF1+
	sN8KmESKLfxxJUBA==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/ptp] vdso/gettimeofday: Return bool from clock_gettime() helpers
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250701-vdso-auxclock-v1-6-df7d9f87b9b8@linutronix.de>
References: <20250701-vdso-auxclock-v1-6-df7d9f87b9b8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175205505704.406.2945498522102106666.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     75540b791bf1d9454dfd2c670943c42901382604
Gitweb:        https://git.kernel.org/tip/75540b791bf1d9454dfd2c670943c429013=
82604
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 01 Jul 2025 10:58:00 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 09 Jul 2025 11:52:34 +02:00

vdso/gettimeofday: Return bool from clock_gettime() helpers

The internal helpers are effectively using boolean results,
while pretending to use error numbers.

Switch the return type to bool for more clarity.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250701-vdso-auxclock-v1-6-df7d9f87b9b8@li=
nutronix.de

---
 lib/vdso/gettimeofday.c | 60 ++++++++++++++++++++--------------------
 1 file changed, 31 insertions(+), 29 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 9b77f23..7e79b02 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -82,8 +82,8 @@ const struct vdso_time_data *__arch_get_vdso_u_timens_data(=
const struct vdso_tim
 #endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
=20
 static __always_inline
-int do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_cloc=
k *vcns,
-		   clockid_t clk, struct __kernel_timespec *ts)
+bool do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_clo=
ck *vcns,
+		    clockid_t clk, struct __kernel_timespec *ts)
 {
 	const struct vdso_time_data *vd =3D __arch_get_vdso_u_timens_data(vdns);
 	const struct timens_offset *offs =3D &vcns->offset[clk];
@@ -103,11 +103,11 @@ int do_hres_timens(const struct vdso_time_data *vdns, c=
onst struct vdso_clock *v
 		seq =3D vdso_read_begin(vc);
=20
 		if (unlikely(!vdso_clocksource_ok(vc)))
-			return -1;
+			return false;
=20
 		cycles =3D __arch_get_hw_counter(vc->clock_mode, vd);
 		if (unlikely(!vdso_cycles_ok(cycles)))
-			return -1;
+			return false;
 		ns =3D vdso_calc_ns(vc, cycles, vdso_ts->nsec);
 		sec =3D vdso_ts->sec;
 	} while (unlikely(vdso_read_retry(vc, seq)));
@@ -123,7 +123,7 @@ int do_hres_timens(const struct vdso_time_data *vdns, con=
st struct vdso_clock *v
 	ts->tv_sec =3D sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
 	ts->tv_nsec =3D ns;
=20
-	return 0;
+	return true;
 }
 #else
 static __always_inline
@@ -133,16 +133,16 @@ const struct vdso_time_data *__arch_get_vdso_u_timens_d=
ata(const struct vdso_tim
 }
=20
 static __always_inline
-int do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_cloc=
k *vcns,
-		   clockid_t clk, struct __kernel_timespec *ts)
+bool do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_clo=
ck *vcns,
+		    clockid_t clk, struct __kernel_timespec *ts)
 {
-	return -EINVAL;
+	return false;
 }
 #endif
=20
 static __always_inline
-int do_hres(const struct vdso_time_data *vd, const struct vdso_clock *vc,
-	    clockid_t clk, struct __kernel_timespec *ts)
+bool do_hres(const struct vdso_time_data *vd, const struct vdso_clock *vc,
+	     clockid_t clk, struct __kernel_timespec *ts)
 {
 	const struct vdso_timestamp *vdso_ts =3D &vc->basetime[clk];
 	u64 cycles, sec, ns;
@@ -150,7 +150,7 @@ int do_hres(const struct vdso_time_data *vd, const struct=
 vdso_clock *vc,
=20
 	/* Allows to compile the high resolution parts out */
 	if (!__arch_vdso_hres_capable())
-		return -1;
+		return false;
=20
 	do {
 		/*
@@ -173,11 +173,11 @@ int do_hres(const struct vdso_time_data *vd, const stru=
ct vdso_clock *vc,
 		smp_rmb();
=20
 		if (unlikely(!vdso_clocksource_ok(vc)))
-			return -1;
+			return false;
=20
 		cycles =3D __arch_get_hw_counter(vc->clock_mode, vd);
 		if (unlikely(!vdso_cycles_ok(cycles)))
-			return -1;
+			return false;
 		ns =3D vdso_calc_ns(vc, cycles, vdso_ts->nsec);
 		sec =3D vdso_ts->sec;
 	} while (unlikely(vdso_read_retry(vc, seq)));
@@ -189,13 +189,13 @@ int do_hres(const struct vdso_time_data *vd, const stru=
ct vdso_clock *vc,
 	ts->tv_sec =3D sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
 	ts->tv_nsec =3D ns;
=20
-	return 0;
+	return true;
 }
=20
 #ifdef CONFIG_TIME_NS
 static __always_inline
-int do_coarse_timens(const struct vdso_time_data *vdns, const struct vdso_cl=
ock *vcns,
-		     clockid_t clk, struct __kernel_timespec *ts)
+bool do_coarse_timens(const struct vdso_time_data *vdns, const struct vdso_c=
lock *vcns,
+		      clockid_t clk, struct __kernel_timespec *ts)
 {
 	const struct vdso_time_data *vd =3D __arch_get_vdso_u_timens_data(vdns);
 	const struct timens_offset *offs =3D &vcns->offset[clk];
@@ -223,20 +223,20 @@ int do_coarse_timens(const struct vdso_time_data *vdns,=
 const struct vdso_clock=20
 	 */
 	ts->tv_sec =3D sec + __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
 	ts->tv_nsec =3D nsec;
-	return 0;
+	return true;
 }
 #else
 static __always_inline
-int do_coarse_timens(const struct vdso_time_data *vdns, const struct vdso_cl=
ock *vcns,
-		     clockid_t clk, struct __kernel_timespec *ts)
+bool do_coarse_timens(const struct vdso_time_data *vdns, const struct vdso_c=
lock *vcns,
+		      clockid_t clk, struct __kernel_timespec *ts)
 {
-	return -1;
+	return false;
 }
 #endif
=20
 static __always_inline
-int do_coarse(const struct vdso_time_data *vd, const struct vdso_clock *vc,
-	      clockid_t clk, struct __kernel_timespec *ts)
+bool do_coarse(const struct vdso_time_data *vd, const struct vdso_clock *vc,
+	       clockid_t clk, struct __kernel_timespec *ts)
 {
 	const struct vdso_timestamp *vdso_ts =3D &vc->basetime[clk];
 	u32 seq;
@@ -258,10 +258,10 @@ int do_coarse(const struct vdso_time_data *vd, const st=
ruct vdso_clock *vc,
 		ts->tv_nsec =3D vdso_ts->nsec;
 	} while (unlikely(vdso_read_retry(vc, seq)));
=20
-	return 0;
+	return true;
 }
=20
-static __always_inline int
+static __always_inline bool
 __cvdso_clock_gettime_common(const struct vdso_time_data *vd, clockid_t cloc=
k,
 			     struct __kernel_timespec *ts)
 {
@@ -270,7 +270,7 @@ __cvdso_clock_gettime_common(const struct vdso_time_data =
*vd, clockid_t clock,
=20
 	/* Check for negative values or invalid clocks */
 	if (unlikely((u32) clock >=3D MAX_CLOCKS))
-		return -1;
+		return false;
=20
 	/*
 	 * Convert the clockid to a bitmask and use it to check which
@@ -284,7 +284,7 @@ __cvdso_clock_gettime_common(const struct vdso_time_data =
*vd, clockid_t clock,
 	else if (msk & VDSO_RAW)
 		vc =3D &vc[CS_RAW];
 	else
-		return -1;
+		return false;
=20
 	return do_hres(vd, vc, clock, ts);
 }
@@ -293,9 +293,11 @@ static __maybe_unused int
 __cvdso_clock_gettime_data(const struct vdso_time_data *vd, clockid_t clock,
 			   struct __kernel_timespec *ts)
 {
-	int ret =3D __cvdso_clock_gettime_common(vd, clock, ts);
+	bool ok;
=20
-	if (unlikely(ret))
+	ok =3D __cvdso_clock_gettime_common(vd, clock, ts);
+
+	if (unlikely(!ok))
 		return clock_gettime_fallback(clock, ts);
 	return 0;
 }
@@ -342,7 +344,7 @@ __cvdso_gettimeofday_data(const struct vdso_time_data *vd,
 	if (likely(tv !=3D NULL)) {
 		struct __kernel_timespec ts;
=20
-		if (do_hres(vd, &vc[CS_HRES_COARSE], CLOCK_REALTIME, &ts))
+		if (!do_hres(vd, &vc[CS_HRES_COARSE], CLOCK_REALTIME, &ts))
 			return gettimeofday_fallback(tv, tz);
=20
 		tv->tv_sec =3D ts.tv_sec;

