Return-Path: <linux-tip-commits+bounces-6137-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 826F8B0A3B5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jul 2025 13:58:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 075ABA44975
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jul 2025 11:56:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C0E2DAFC7;
	Fri, 18 Jul 2025 11:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="T9yjM41d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3HR6F910"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89B692DA75A;
	Fri, 18 Jul 2025 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752839792; cv=none; b=I3D087aLFF56XxZKrIGeFhg3POZWiv8TV6WxkSkOcX1X/F+ECjMFqj7KV+bmObZEvUk5UcmtU188CzmsdahbZwYCi8idLD1Eza552Pj3EP6uto4ewoVXenD2CU2Sgw3VUzacoK4ao8GAGYe78Jg7eRYU6zaFaf3xZB3SBP2wQr4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752839792; c=relaxed/simple;
	bh=It1Ki4FObESZFpw9TEgujvAV+nC2iTRe/sFyznnm1IE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=n32AOpU/cGkfPN1fZGKXxbPdpNNVoSV/GLwDQjU2icm3Qc8erBI2xL8Kcm+Z+D9D2BKp+xtxZaGzFJI8kM6s+Ii0zamll357Sbx8tyYtv/0CnDhbGhSvykjcYhFj+Jx5orBdBR+dmvn3l+v5p62AS2QN8+zUS77aVJ7RGTYYv6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=T9yjM41d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3HR6F910; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Jul 2025 11:56:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752839789;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iVUBJkaNUcgifuFyqFH+pro3OeNd3uzWntX2NfcvZmQ=;
	b=T9yjM41dqOKQdVNuxbXIOeHg2Pr87HH95aEx/2fViOo2mylz2oA1qdXvot32ZOKKJg1z8Q
	LRUXoKNzjcC5zUababsnYcprhupaMrtDLW90DWsjSYih/SU4GxNcXUBPRNpHOiDZKoRqR8
	NesewvwZhE83yocpr2mbil3Z0pG7q4fQhut3wXP7GIQrkoXWhHXZHVVkKK988pRqEZTe+Q
	p9yrQZCkYeo0eD/m+C2qUyBOv0I9+Zw4EZbDaygiFlRz2fh69rrlaSNNZFWnjfaIQn5BNN
	ws5Zg/Acg8fgctRvzXUepdCUhTaQmowCiJrEPqFEgVpCvZ2TaenmolXVPhCZwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752839789;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iVUBJkaNUcgifuFyqFH+pro3OeNd3uzWntX2NfcvZmQ=;
	b=3HR6F910MBGBN6QlFY/qdV/M+8noeWt+ohi4a9wlfJQeU1d/jNjm6iImYXKB28h5+AuNqZ
	Ygr34K5UEE9PuNAQ==
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
Message-ID: <175283978816.406.14623316563816036229.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     fb61bdb27fd730c393a8bddbda2401c37a919667
Gitweb:        https://git.kernel.org/tip/fb61bdb27fd730c393a8bddbda2401c37a9=
19667
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 01 Jul 2025 10:58:00 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 18 Jul 2025 13:45:32 +02:00

vdso/gettimeofday: Return bool from clock_gettime() helpers

The internal helpers are effectively using boolean results,
while pretending to use error numbers.

Switch the return type to bool for more clarity.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250701-vdso-auxclock-v1-6-df7d9f87b9b8@li=
nutronix.de

---
 lib/vdso/gettimeofday.c | 70 ++++++++++++++++++++--------------------
 1 file changed, 36 insertions(+), 34 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 9b77f23..32e568d 100644
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
+
+	ok =3D __cvdso_clock_gettime_common(vd, clock, ts);
=20
-	if (unlikely(ret))
+	if (unlikely(!ok))
 		return clock_gettime_fallback(clock, ts);
 	return 0;
 }
@@ -312,18 +314,18 @@ __cvdso_clock_gettime32_data(const struct vdso_time_dat=
a *vd, clockid_t clock,
 			     struct old_timespec32 *res)
 {
 	struct __kernel_timespec ts;
-	int ret;
+	bool ok;
=20
-	ret =3D __cvdso_clock_gettime_common(vd, clock, &ts);
+	ok =3D __cvdso_clock_gettime_common(vd, clock, &ts);
=20
-	if (unlikely(ret))
+	if (unlikely(!ok))
 		return clock_gettime32_fallback(clock, res);
=20
-	/* For ret =3D=3D 0 */
+	/* For ok =3D=3D true */
 	res->tv_sec =3D ts.tv_sec;
 	res->tv_nsec =3D ts.tv_nsec;
=20
-	return ret;
+	return 0;
 }
=20
 static __maybe_unused int
@@ -342,7 +344,7 @@ __cvdso_gettimeofday_data(const struct vdso_time_data *vd,
 	if (likely(tv !=3D NULL)) {
 		struct __kernel_timespec ts;
=20
-		if (do_hres(vd, &vc[CS_HRES_COARSE], CLOCK_REALTIME, &ts))
+		if (!do_hres(vd, &vc[CS_HRES_COARSE], CLOCK_REALTIME, &ts))
 			return gettimeofday_fallback(tv, tz);
=20
 		tv->tv_sec =3D ts.tv_sec;

