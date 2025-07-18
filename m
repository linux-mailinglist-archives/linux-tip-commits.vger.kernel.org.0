Return-Path: <linux-tip-commits+bounces-6135-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 85577B0A3B0
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jul 2025 13:57:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 000DC189B616
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jul 2025 11:57:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0F162DA767;
	Fri, 18 Jul 2025 11:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r+0/QfU0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v39wDmmJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AD7A2D9ED4;
	Fri, 18 Jul 2025 11:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752839790; cv=none; b=FexVbTSg/OwfceO/v7Cj4K2Ai9TcyqHuni7UT+wccOBiPJFTmsCi1g71OJCsRea79D+m3UHFdvTPuqJl+C9Hl+Aa6Gn6DePxQvsFPPWaWOoJD0eycFmZvYS9E38LKLL4/tANomkPPow+8aqUwOIhjVYcXkEkI2U0gSsH9TtHBxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752839790; c=relaxed/simple;
	bh=mkOcNI6YCwiB8aTIBTasaBdNq5V0kKkyrhN3VIZZo1w=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QP5njD8Dyzke93JsR8R/Y4c3APpf23wtBQpSIK11qX+tlhCN8yeIkJaQFM0k+9MBkBzlzDVce9BgQqQ5A9kD96X2xT7HVAfZgL0dGhte6lZXB2uWh5MsFODc2OFmxPZA8akWH/WTVBMu4hEYWbcURmDioVyY6OHIzJ53iez6Fag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=r+0/QfU0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v39wDmmJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Jul 2025 11:56:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752839787;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8D31mFiT+a1sPbwStA+KxqFSHVFa+d+e8D+K/iZkmGs=;
	b=r+0/QfU0sJpY6oOXeAWMLyvCH1xrNUdfM3291WraR5UoCSLWFRS62O/HhoR2/jDY6QD+rh
	GZYPoYrCQEjZnzozkwJ9Io8kV3/gTHPz7/Cwm5M20TQIUt9KLSygzzlP9lk6h3cV00VXpy
	XQ0JcSliZhJ1cPR02OAIpwhLgz4iFLwb+0DJCtzPtJENXFmFkuAA1yGVD57f/HFthzNe8j
	Spy2hGDx9ZBRgfKeBsQdmaoaH2W2oD1tAs89KVHSQmgJKpMeiMv/sO+asihnkUNiW+Ormn
	YzFhp3EZgFNa7B4yZI/sw9H4HaispOBGDKlOuk9HtPmdRzSyP+9GhnsZe25tqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752839787;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8D31mFiT+a1sPbwStA+KxqFSHVFa+d+e8D+K/iZkmGs=;
	b=v39wDmmJgdOs1HmbfnKVvXV2rSBzmZRtNGPh8tronOyVC2NwpeDFskEcv0FbToXB7CoPzu
	HEjo4ks6hoLUm6Ag==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/ptp] vdso/gettimeofday: Introduce vdso_set_timespec()
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250701-vdso-auxclock-v1-8-df7d9f87b9b8@linutronix.de>
References: <20250701-vdso-auxclock-v1-8-df7d9f87b9b8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175283978630.406.6702897007353209536.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     381d96ccc1a52237e03ac97b4d2945997c9356e6
Gitweb:        https://git.kernel.org/tip/381d96ccc1a52237e03ac97b4d2945997c9=
356e6
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 01 Jul 2025 10:58:02 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 18 Jul 2025 13:45:32 +02:00

vdso/gettimeofday: Introduce vdso_set_timespec()

This code is duplicated and with the introduction of auxiliary clocks will
be duplicated even more.

Introduce a helper.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250701-vdso-auxclock-v1-8-df7d9f87b9b8@li=
nutronix.de

---
 lib/vdso/gettimeofday.c | 32 ++++++++++++++------------------
 1 file changed, 14 insertions(+), 18 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 0271226..9d7ac98 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -77,6 +77,16 @@ static __always_inline bool vdso_clockid_valid(clockid_t c=
lock)
 	return likely((u32) clock < MAX_CLOCKS);
 }
=20
+/*
+ * Must not be invoked within the sequence read section as a race inside
+ * that loop could result in __iter_div_u64_rem() being extremely slow.
+ */
+static __always_inline void vdso_set_timespec(struct __kernel_timespec *ts, =
u64 sec, u64 ns)
+{
+	ts->tv_sec =3D sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
+	ts->tv_nsec =3D ns;
+}
+
 #ifdef CONFIG_TIME_NS
=20
 #ifdef CONFIG_GENERIC_VDSO_DATA_STORE
@@ -122,12 +132,7 @@ bool do_hres_timens(const struct vdso_time_data *vdns, c=
onst struct vdso_clock *
 	sec +=3D offs->sec;
 	ns +=3D offs->nsec;
=20
-	/*
-	 * Do this outside the loop: a race inside the loop could result
-	 * in __iter_div_u64_rem() being extremely slow.
-	 */
-	ts->tv_sec =3D sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
-	ts->tv_nsec =3D ns;
+	vdso_set_timespec(ts, sec, ns);
=20
 	return true;
 }
@@ -188,12 +193,7 @@ bool do_hres(const struct vdso_time_data *vd, const stru=
ct vdso_clock *vc,
 		sec =3D vdso_ts->sec;
 	} while (unlikely(vdso_read_retry(vc, seq)));
=20
-	/*
-	 * Do this outside the loop: a race inside the loop could result
-	 * in __iter_div_u64_rem() being extremely slow.
-	 */
-	ts->tv_sec =3D sec + __iter_div_u64_rem(ns, NSEC_PER_SEC, &ns);
-	ts->tv_nsec =3D ns;
+	vdso_set_timespec(ts, sec, ns);
=20
 	return true;
 }
@@ -223,12 +223,8 @@ bool do_coarse_timens(const struct vdso_time_data *vdns,=
 const struct vdso_clock
 	sec +=3D offs->sec;
 	nsec +=3D offs->nsec;
=20
-	/*
-	 * Do this outside the loop: a race inside the loop could result
-	 * in __iter_div_u64_rem() being extremely slow.
-	 */
-	ts->tv_sec =3D sec + __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
-	ts->tv_nsec =3D nsec;
+	vdso_set_timespec(ts, sec, nsec);
+
 	return true;
 }
 #else

