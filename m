Return-Path: <linux-tip-commits+bounces-6014-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BD258AFACCB
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Jul 2025 09:13:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F201F173DB0
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Jul 2025 07:12:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCBC32877C1;
	Mon,  7 Jul 2025 07:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RpfCoFW9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/D8bVtp+"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20C5528727A;
	Mon,  7 Jul 2025 07:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751872312; cv=none; b=Vet6A8Vqf0x6tVau1TJqDZbUQ0ptl+uCApyVX2HWaVoi40AQEWbgjYHbCW3PehedPnh+drre9DNQaDeNrtnOHNEKcv3Q7dXccERs5JSFWhpPziV4rNAwLAg00PF0Dj1QLeTKFuG4w+B5NwyYc88BPC+NIUL6eWnG+nJV/ZYkijI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751872312; c=relaxed/simple;
	bh=55QMz/v82tx/c2sX426gfjgozX1yQxu2hJ142p4MplE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aBThxcSerkJk7zjYp+5ubWVohrquX9ckcQ/rwIWrm5oy10YmovZK/8FKDgOG4rCquZ92DpU+/K0fG7w1LYNillvgn2caeklZNE4s8Gusg/Cp0kgeQxy3JcVwcsEAqgTm9LrBJTr1hBSAB8jA+IOTw4cOQ4fXXXiAmT5J1Ms3wYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RpfCoFW9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/D8bVtp+; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Jul 2025 07:11:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751872309;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=inxcUApOWieSrYus17BWF2y5IUwG9JHYJq+COP/TEnY=;
	b=RpfCoFW9MwrAxNczbzX2aFtDpk+ENPDJRkGF7BqDbFki6V2bH6St16d93J2UJeAO7J7PV+
	rowMMZ6sKg6KHC3pueikREkSZu9wysLAcGxtVQQyVcMW7le+PfumsfVr/D3YkshNGe9fVJ
	kDIZL7FqWO+57V9sXJmnLtU0OScPZ+K4qp63K096wNTZaxYuhWVVWhrsPunSE8yZzKXnPp
	4Mhd9BlSgQ2mqWIUz3ridGCTjKx1VHdGw6h8sorysWjm9hQDjyRlJ9Hu8UXsK7laA1gVvF
	VYrdz/4tAweWIyFFgR5kWD1HrzTPEsGuQe55VzBQ03+0eRXcGfEl7sAqIt42ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751872309;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=inxcUApOWieSrYus17BWF2y5IUwG9JHYJq+COP/TEnY=;
	b=/D8bVtp+b7gCfwjDH8HguE0yvVfpN9lNcvFBzJhTu1cf57ggkQJHtMscE/2ZHrRLsKLcf2
	CDVPuSxTaUmEryBg==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/ptp] vdso/gettimeofday: Return bool from clock_getres() helpers
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250701-vdso-auxclock-v1-5-df7d9f87b9b8@linutronix.de>
References: <20250701-vdso-auxclock-v1-5-df7d9f87b9b8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175187230835.406.16017608963899965333.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     7413d7c640aa1d9620aa467922cfe3b8df51272e
Gitweb:        https://git.kernel.org/tip/7413d7c640aa1d9620aa467922cfe3b8df5=
1272e
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 01 Jul 2025 10:57:59 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 07 Jul 2025 08:58:51 +02:00

vdso/gettimeofday: Return bool from clock_getres() helpers

The internal helpers are effectively using boolean results,
while pretending to use error numbers.

Switch the return type to bool for more clarity.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250701-vdso-auxclock-v1-5-df7d9f87b9b8@li=
nutronix.de

---
 lib/vdso/gettimeofday.c | 24 +++++++++++++-----------
 1 file changed, 13 insertions(+), 11 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 93ef801..9b77f23 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -396,8 +396,8 @@ static __maybe_unused __kernel_old_time_t __cvdso_time(__=
kernel_old_time_t *time
=20
 #ifdef VDSO_HAS_CLOCK_GETRES
 static __maybe_unused
-int __cvdso_clock_getres_common(const struct vdso_time_data *vd, clockid_t c=
lock,
-				struct __kernel_timespec *res)
+bool __cvdso_clock_getres_common(const struct vdso_time_data *vd, clockid_t =
clock,
+				 struct __kernel_timespec *res)
 {
 	const struct vdso_clock *vc =3D vd->clock_data;
 	u32 msk;
@@ -405,7 +405,7 @@ int __cvdso_clock_getres_common(const struct vdso_time_da=
ta *vd, clockid_t clock
=20
 	/* Check for negative values or invalid clocks */
 	if (unlikely((u32) clock >=3D MAX_CLOCKS))
-		return -1;
+		return false;
=20
 	if (IS_ENABLED(CONFIG_TIME_NS) &&
 	    vc->clock_mode =3D=3D VDSO_CLOCKMODE_TIMENS)
@@ -427,23 +427,25 @@ int __cvdso_clock_getres_common(const struct vdso_time_=
data *vd, clockid_t clock
 		 */
 		ns =3D LOW_RES_NSEC;
 	} else {
-		return -1;
+		return false;
 	}
=20
 	if (likely(res)) {
 		res->tv_sec =3D 0;
 		res->tv_nsec =3D ns;
 	}
-	return 0;
+	return true;
 }
=20
 static __maybe_unused
 int __cvdso_clock_getres_data(const struct vdso_time_data *vd, clockid_t clo=
ck,
 			      struct __kernel_timespec *res)
 {
-	int ret =3D __cvdso_clock_getres_common(vd, clock, res);
+	bool ok;
=20
-	if (unlikely(ret))
+	ok =3D  __cvdso_clock_getres_common(vd, clock, res);
+
+	if (unlikely(!ok))
 		return clock_getres_fallback(clock, res);
 	return 0;
 }
@@ -460,18 +462,18 @@ __cvdso_clock_getres_time32_data(const struct vdso_time=
_data *vd, clockid_t cloc
 				 struct old_timespec32 *res)
 {
 	struct __kernel_timespec ts;
-	int ret;
+	bool ok;
=20
-	ret =3D __cvdso_clock_getres_common(vd, clock, &ts);
+	ok =3D __cvdso_clock_getres_common(vd, clock, &ts);
=20
-	if (unlikely(ret))
+	if (unlikely(!ok))
 		return clock_getres32_fallback(clock, res);
=20
 	if (likely(res)) {
 		res->tv_sec =3D ts.tv_sec;
 		res->tv_nsec =3D ts.tv_nsec;
 	}
-	return ret;
+	return 0;
 }
=20
 static __maybe_unused int

