Return-Path: <linux-tip-commits+bounces-6134-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 7EB9AB0A3AF
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jul 2025 13:56:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC0D7189E194
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jul 2025 11:57:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 491812DA744;
	Fri, 18 Jul 2025 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NhbfRXIs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6Bgw3tPp"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF792D9EC2;
	Fri, 18 Jul 2025 11:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752839790; cv=none; b=EgsHRHcsL9Hegbm+bxGHLsvOAS1eSu3AtwkpSv04pik5WBUwkiPD8DhmnBYq6bqgIM5RcfehhZZf2AuTJ5JJsJcs5qJGGppQa+7OEPj+Y7BNgmFOhs39NvulkuZf46hoJh1ieZTDHO8QCpOb15JCTsrF9VRPJKZYImsm7OrGQlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752839790; c=relaxed/simple;
	bh=ff9+jgE61+r5pVOo5F55FKMVX3bTdJMijlHzUoXlBPA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kviHPrlZ+2UXfnknYKKNjBV5ymxsbcdSW3FT1zRnuMFHIILjdC2+IIw0i4oGnr7oEWGu0MQk2KEJB0J1H6nLIrrFDz4KQBWWFzDdrpvQMw9CsEN2/Ucv9zEdatAwnx6Plx0/E9fO2efrCryUrIobzTaMCiGyycdABHdnLYRGBhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NhbfRXIs; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6Bgw3tPp; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Jul 2025 11:56:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752839786;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GZYQ585ZRAPCLPYsWvl+kWEv07V4gU/3cE14k6m6KWg=;
	b=NhbfRXIsyNz3joNJbSsQHcERAhlzpZKfAdAClx2S9MGWWPTYO7x48W08X5kBBqz6h5Wnah
	IX4lGpv4N9XNr7wWNqGV5AVQuljc5U7f8Tbu4Q9dBukxUsHqpil9LsCjHAkD4gd1Tw79eM
	hxTQFR4/Q7Cw1UWFXlIbAUXKuGy17ZT7LnHGRyj/bQlhB7kyVfAlFm5gaHUfE5lVAzuJCK
	msKvAVSmhmyU1Lr/G2q9TXmPbDQbDMWxdGIWPPkw2h4uCcBLxG3aFhPIbYf+DDfKK2hRcv
	dEMS1uTuAP75F3zsM/wo6NUpiiKYQQ/CVPWO0mtiMXwHOy5BoR+LYrs1IBvLVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752839786;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GZYQ585ZRAPCLPYsWvl+kWEv07V4gU/3cE14k6m6KWg=;
	b=6Bgw3tPpUN8MwKxshZCHgp2zLWoInXQVt8STZ0RdRbniGN1rIhq9O6FWqdZ1ZLQxM5i2Ok
	iB2iGrtCm03L7fAg==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/ptp] vdso/gettimeofday: Introduce vdso_get_timestamp()
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250701-vdso-auxclock-v1-9-df7d9f87b9b8@linutronix.de>
References: <20250701-vdso-auxclock-v1-9-df7d9f87b9b8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175283978527.406.8897307184298161338.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     562f03ed967dc65e513a3e2e9821f656d5333b8e
Gitweb:        https://git.kernel.org/tip/562f03ed967dc65e513a3e2e9821f656d53=
33b8e
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 01 Jul 2025 10:58:03 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 18 Jul 2025 13:45:32 +02:00

vdso/gettimeofday: Introduce vdso_get_timestamp()

This code is duplicated and with the introduction of auxiliary clocks will
be duplicated even more.

Introduce a helper.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250701-vdso-auxclock-v1-9-df7d9f87b9b8@li=
nutronix.de

---
 lib/vdso/gettimeofday.c | 43 ++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 9d7ac98..fc0038e 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -87,6 +87,26 @@ static __always_inline void vdso_set_timespec(struct __ker=
nel_timespec *ts, u64=20
 	ts->tv_nsec =3D ns;
 }
=20
+static __always_inline
+bool vdso_get_timestamp(const struct vdso_time_data *vd, const struct vdso_c=
lock *vc,
+			unsigned int clkidx, u64 *sec, u64 *ns)
+{
+	const struct vdso_timestamp *vdso_ts =3D &vc->basetime[clkidx];
+	u64 cycles;
+
+	if (unlikely(!vdso_clocksource_ok(vc)))
+		return false;
+
+	cycles =3D __arch_get_hw_counter(vc->clock_mode, vd);
+	if (unlikely(!vdso_cycles_ok(cycles)))
+		return false;
+
+	*ns =3D vdso_calc_ns(vc, cycles, vdso_ts->nsec);
+	*sec =3D vdso_ts->sec;
+
+	return true;
+}
+
 #ifdef CONFIG_TIME_NS
=20
 #ifdef CONFIG_GENERIC_VDSO_DATA_STORE
@@ -104,28 +124,20 @@ bool do_hres_timens(const struct vdso_time_data *vdns, =
const struct vdso_clock *
 	const struct vdso_time_data *vd =3D __arch_get_vdso_u_timens_data(vdns);
 	const struct timens_offset *offs =3D &vcns->offset[clk];
 	const struct vdso_clock *vc =3D vd->clock_data;
-	const struct vdso_timestamp *vdso_ts;
-	u64 cycles, ns;
 	u32 seq;
 	s64 sec;
+	u64 ns;
=20
 	if (clk !=3D CLOCK_MONOTONIC_RAW)
 		vc =3D &vc[CS_HRES_COARSE];
 	else
 		vc =3D &vc[CS_RAW];
-	vdso_ts =3D &vc->basetime[clk];
=20
 	do {
 		seq =3D vdso_read_begin(vc);
=20
-		if (unlikely(!vdso_clocksource_ok(vc)))
-			return false;
-
-		cycles =3D __arch_get_hw_counter(vc->clock_mode, vd);
-		if (unlikely(!vdso_cycles_ok(cycles)))
+		if (!vdso_get_timestamp(vd, vc, clk, &sec, &ns))
 			return false;
-		ns =3D vdso_calc_ns(vc, cycles, vdso_ts->nsec);
-		sec =3D vdso_ts->sec;
 	} while (unlikely(vdso_read_retry(vc, seq)));
=20
 	/* Add the namespace offset */
@@ -155,8 +167,7 @@ static __always_inline
 bool do_hres(const struct vdso_time_data *vd, const struct vdso_clock *vc,
 	     clockid_t clk, struct __kernel_timespec *ts)
 {
-	const struct vdso_timestamp *vdso_ts =3D &vc->basetime[clk];
-	u64 cycles, sec, ns;
+	u64 sec, ns;
 	u32 seq;
=20
 	/* Allows to compile the high resolution parts out */
@@ -183,14 +194,8 @@ bool do_hres(const struct vdso_time_data *vd, const stru=
ct vdso_clock *vc,
 		}
 		smp_rmb();
=20
-		if (unlikely(!vdso_clocksource_ok(vc)))
+		if (!vdso_get_timestamp(vd, vc, clk, &sec, &ns))
 			return false;
-
-		cycles =3D __arch_get_hw_counter(vc->clock_mode, vd);
-		if (unlikely(!vdso_cycles_ok(cycles)))
-			return false;
-		ns =3D vdso_calc_ns(vc, cycles, vdso_ts->nsec);
-		sec =3D vdso_ts->sec;
 	} while (unlikely(vdso_read_retry(vc, seq)));
=20
 	vdso_set_timespec(ts, sec, ns);

