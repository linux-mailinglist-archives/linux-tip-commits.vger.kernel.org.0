Return-Path: <linux-tip-commits+bounces-4084-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A931A57AAE
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 14:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3802C16D583
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 13:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BA01E833B;
	Sat,  8 Mar 2025 13:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kttmxj/9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ok1j9+ef"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E2701DF240;
	Sat,  8 Mar 2025 13:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741441507; cv=none; b=jYXtlIv03km0do+pz5jPqjjACmsE19Us54Ckm/dDGCKgFAt0NTPQVYWOc+lWZBvkrY1YfekQXbPS7UJGBzkKqoSLLd1h4ATJ8a6bUge5D/0Ir5xC5zcFqaW+Ix92Jbe5nN18yHfY99pQIKSbdu3877UbJ7OD5fxp5ce9xI9xYC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741441507; c=relaxed/simple;
	bh=obSznbHUzoVImUcBfWD1D8JuqUgSrmWaHMS8Zc2zdu8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qlMJ3Iy9+SZeYf1ayn3eGcDOVYXndKw4LEkuzO3cGK1WhTFL9oubqbHxXRZ4q+365TzWpi6V3B96aC1jVQCz9zmlBitC3mbqkDDjcv9TenJiTnqXTTPONDS/03g7V+XAO4XFSN8jfoBEVSon1mVhxpTtuGRJW8LBqD8c8L6pFI4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kttmxj/9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ok1j9+ef; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 08 Mar 2025 13:45:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741441503;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LOq9ir1lzxr/1d4nn/NURp4fl4VXnQwmoaCLZ4PwSzU=;
	b=Kttmxj/9XVkMMyZ+xEyx/9gwhhq3NfqKhsR1RBVgaa4e6LcpvhUQbdJjdrCI0j4XE4X7Mr
	FZk1cVYYuKELpX+opkfLQbaslTfGa9sGAHlfznjl2DC8cX0JaF96K5zspKykGcPldi/7Tb
	aj+r0ulSOAedaut3wYRItGhml1UR6B8AGMg1cG5aCtWBL5WETKIAxn7ERTjA7PRYYHaa/v
	K9SgNF9hQT2wXbEl738k+Lr/PvBipcYLhAziyRq5nm+AXTsSTS4UVFUFHs5Uk5OuehH4Iv
	/pc/0ab40ezh6mEEd2vutIx1XaEeePvEm3HPauczznL8KkQ7CQUZp2CNqe6ZSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741441503;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LOq9ir1lzxr/1d4nn/NURp4fl4VXnQwmoaCLZ4PwSzU=;
	b=Ok1j9+efD2z0e6V1iT0a0ZmY8vmH1qGtokk0Z7V4nXgFOuHATp9H9PXRtMbofnyC5+cicF
	5XcEB51JxD6bAKBw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso/gettimeofday: Prepare do_hres() for
 introduction of struct vdso_clock
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Nam Cao <namcao@linutronix.de>, thomas.weissschuh@linutronix.de,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303-vdso-clock-v1-7-c1b5c69a166f@linutronix.de>
References: <20250303-vdso-clock-v1-7-c1b5c69a166f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174144150269.14745.8629385858322927227.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     64c3613ce31a1a58e43c2d86eafbb03364986450
Gitweb:        https://git.kernel.org/tip/64c3613ce31a1a58e43c2d86eafbb033649=
86450
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 03 Mar 2025 12:11:09 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 08 Mar 2025 14:37:40 +01:00

vdso/gettimeofday: Prepare do_hres() for introduction of struct vdso_clock

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of VDSO clocks. At the moment,
vdso_clock is simply a define which maps vdso_clock to vdso_time_data.

Prepare for the rework of these structures by adding a struct vdso_clock
pointer argument to do_hres(), and replace the struct vdso_time_data
pointer with the new pointer argument where applicable.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250303-vdso-clock-v1-7-c1b5c69a166f@linut=
ronix.de

---
 lib/vdso/gettimeofday.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 59369a4..15611ab 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -139,10 +139,11 @@ static __always_inline int do_hres_timens(const struct =
vdso_time_data *vdns, clo
 }
 #endif
=20
-static __always_inline int do_hres(const struct vdso_time_data *vd, clockid_=
t clk,
-				   struct __kernel_timespec *ts)
+static __always_inline
+int do_hres(const struct vdso_time_data *vd, const struct vdso_clock *vc,
+	    clockid_t clk, struct __kernel_timespec *ts)
 {
-	const struct vdso_timestamp *vdso_ts =3D &vd->basetime[clk];
+	const struct vdso_timestamp *vdso_ts =3D &vc->basetime[clk];
 	u64 cycles, sec, ns;
 	u32 seq;
=20
@@ -154,31 +155,31 @@ static __always_inline int do_hres(const struct vdso_ti=
me_data *vd, clockid_t cl
 		/*
 		 * Open coded function vdso_read_begin() to handle
 		 * VDSO_CLOCKMODE_TIMENS. Time namespace enabled tasks have a
-		 * special VVAR page installed which has vd->seq set to 1 and
-		 * vd->clock_mode set to VDSO_CLOCKMODE_TIMENS. For non time
+		 * special VVAR page installed which has vc->seq set to 1 and
+		 * vc->clock_mode set to VDSO_CLOCKMODE_TIMENS. For non time
 		 * namespace affected tasks this does not affect performance
-		 * because if vd->seq is odd, i.e. a concurrent update is in
-		 * progress the extra check for vd->clock_mode is just a few
-		 * extra instructions while spin waiting for vd->seq to become
+		 * because if vc->seq is odd, i.e. a concurrent update is in
+		 * progress the extra check for vc->clock_mode is just a few
+		 * extra instructions while spin waiting for vc->seq to become
 		 * even again.
 		 */
-		while (unlikely((seq =3D READ_ONCE(vd->seq)) & 1)) {
+		while (unlikely((seq =3D READ_ONCE(vc->seq)) & 1)) {
 			if (IS_ENABLED(CONFIG_TIME_NS) &&
-			    vd->clock_mode =3D=3D VDSO_CLOCKMODE_TIMENS)
+			    vc->clock_mode =3D=3D VDSO_CLOCKMODE_TIMENS)
 				return do_hres_timens(vd, clk, ts);
 			cpu_relax();
 		}
 		smp_rmb();
=20
-		if (unlikely(!vdso_clocksource_ok(vd)))
+		if (unlikely(!vdso_clocksource_ok(vc)))
 			return -1;
=20
-		cycles =3D __arch_get_hw_counter(vd->clock_mode, vd);
+		cycles =3D __arch_get_hw_counter(vc->clock_mode, vd);
 		if (unlikely(!vdso_cycles_ok(cycles)))
 			return -1;
-		ns =3D vdso_calc_ns(vd, cycles, vdso_ts->nsec);
+		ns =3D vdso_calc_ns(vc, cycles, vdso_ts->nsec);
 		sec =3D vdso_ts->sec;
-	} while (unlikely(vdso_read_retry(vd, seq)));
+	} while (unlikely(vdso_read_retry(vc, seq)));
=20
 	/*
 	 * Do this outside the loop: a race inside the loop could result
@@ -278,7 +279,7 @@ __cvdso_clock_gettime_common(const struct vdso_time_data =
*vd, clockid_t clock,
 	else
 		return -1;
=20
-	return do_hres(vc, clock, ts);
+	return do_hres(vd, vc, clock, ts);
 }
=20
 static __maybe_unused int
@@ -334,7 +335,7 @@ __cvdso_gettimeofday_data(const struct vdso_time_data *vd,
 	if (likely(tv !=3D NULL)) {
 		struct __kernel_timespec ts;
=20
-		if (do_hres(&vc[CS_HRES_COARSE], CLOCK_REALTIME, &ts))
+		if (do_hres(vd, &vc[CS_HRES_COARSE], CLOCK_REALTIME, &ts))
 			return gettimeofday_fallback(tv, tz);
=20
 		tv->tv_sec =3D ts.tv_sec;

