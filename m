Return-Path: <linux-tip-commits+bounces-3783-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DFB0A4BCB0
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 11:44:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA9C170DD4
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 10:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2F571F4739;
	Mon,  3 Mar 2025 10:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="J9ApFLcw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YiBT29Ix"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4F9F1F4264;
	Mon,  3 Mar 2025 10:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998588; cv=none; b=UpExr3PxTAqOYMxFJcMjT6/qFEADXeFrIQkOpBvdmu4g+Wm8+ASG1Wmajy0socLQ0qdNoTfreVXXgxqaIlMM7mIy1cAn74RPe2rJ4pKP944Tejg+SU7MeYBONjHtKT6AJ2JDwVVF1blnZxy6teh3IyEBqn6AcxlKlRhOlf/TvUg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998588; c=relaxed/simple;
	bh=Brmesdp1JcXzT/zKILE7AQTtRkqqEJwB8gd2NFzlDRg=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=BFvUosyIvt1PlzSTjaxNPsLd1OI0OiAhUfvgwRz6aPGIvi+tWxxqostAHwARNX3laZENlTiMzhQ8y91gRgPtKfoZxlr1oEqQfR+RZ+c7pgWfOQXbmUKne3fvjaUd4IUbte+WsADBguYqXqjG9JfoBa9R9Mj04/LsZO9nPLtGaZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=J9ApFLcw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YiBT29Ix; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 10:43:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740998585;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=BLQB319dNGv+EvnMZKjTMkdO18suZgbN1cdq6nxXESY=;
	b=J9ApFLcw9RkJUUw6K0JTQZlk72b87Qv+daSmjNIwrb0Mn5tZJlxTK7PS1EbCsXYOS15raX
	yLkIoRlRrSpoMkiX9MUhgJGUwMTN9xQkoPulazBzw6xovGXWqTgTGP1b5istMEIVFxEJlT
	yyJrGa8McjugAJFNI/KYeQk0GqcAJEjmQiynxRl0fFpCP9k9sEsfTuN3GZGMxR7BXjdqEn
	F+FELfRE8T98aEIaPa+o88CHdALv4RJgq9LpRZUL59+8y8xCQ06Rw5CIsSJ5opnZzXIuj/
	/zpdom0aR/cokmZAFLis3fq6pSkwylc6E5IPPjljB6qpGPYYpaPLxIKNm3aEyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740998585;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=BLQB319dNGv+EvnMZKjTMkdO18suZgbN1cdq6nxXESY=;
	b=YiBT29Ixjn4F2gBhq1XYqhNM9mXhsnaPCa7twQPvlC7lCQ/cluIfY4L2EcWQbRsDALwy4x
	iXsA6la2qWkm/sCw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso/gettimeofday: Prepare introduction of struct
 vdso_clock
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Nam Cao <namcao@linutronix.de>, thomas.weissschuh@linutronix.de,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174099858479.10177.10417809084450070892.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     765afc515c2bf298226b5ef5b7a231b077091050
Gitweb:        https://git.kernel.org/tip/765afc515c2bf298226b5ef5b7a231b0770=
91050
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Tue, 25 Feb 2025 13:36:38 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Mar 2025 10:24:34 +01:00

vdso/gettimeofday: Prepare introduction of struct vdso_clock

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of it. At the moment, vdso_clock
is simply a define which maps vdso_clock to vdso_time_data.

Prepare all functions which need the pointer to the vdso_clock array to
work well after introducing the new struct. Whenever applicable, struct
vdso_time_data pointer is replaced by struct vdso_clock pointer.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 lib/vdso/gettimeofday.c | 24 +++++++++++++++---------
 1 file changed, 15 insertions(+), 9 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 299f027..59369a4 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -257,6 +257,7 @@ static __always_inline int
 __cvdso_clock_gettime_common(const struct vdso_time_data *vd, clockid_t cloc=
k,
 			     struct __kernel_timespec *ts)
 {
+	const struct vdso_clock *vc =3D vd;
 	u32 msk;
=20
 	/* Check for negative values or invalid clocks */
@@ -269,15 +270,15 @@ __cvdso_clock_gettime_common(const struct vdso_time_dat=
a *vd, clockid_t clock,
 	 */
 	msk =3D 1U << clock;
 	if (likely(msk & VDSO_HRES))
-		vd =3D &vd[CS_HRES_COARSE];
+		vc =3D &vc[CS_HRES_COARSE];
 	else if (msk & VDSO_COARSE)
-		return do_coarse(&vd[CS_HRES_COARSE], clock, ts);
+		return do_coarse(&vc[CS_HRES_COARSE], clock, ts);
 	else if (msk & VDSO_RAW)
-		vd =3D &vd[CS_RAW];
+		vc =3D &vc[CS_RAW];
 	else
 		return -1;
=20
-	return do_hres(vd, clock, ts);
+	return do_hres(vc, clock, ts);
 }
=20
 static __maybe_unused int
@@ -328,11 +329,12 @@ static __maybe_unused int
 __cvdso_gettimeofday_data(const struct vdso_time_data *vd,
 			  struct __kernel_old_timeval *tv, struct timezone *tz)
 {
+	const struct vdso_clock *vc =3D vd;
=20
 	if (likely(tv !=3D NULL)) {
 		struct __kernel_timespec ts;
=20
-		if (do_hres(&vd[CS_HRES_COARSE], CLOCK_REALTIME, &ts))
+		if (do_hres(&vc[CS_HRES_COARSE], CLOCK_REALTIME, &ts))
 			return gettimeofday_fallback(tv, tz);
=20
 		tv->tv_sec =3D ts.tv_sec;
@@ -341,7 +343,7 @@ __cvdso_gettimeofday_data(const struct vdso_time_data *vd,
=20
 	if (unlikely(tz !=3D NULL)) {
 		if (IS_ENABLED(CONFIG_TIME_NS) &&
-		    vd->clock_mode =3D=3D VDSO_CLOCKMODE_TIMENS)
+		    vc->clock_mode =3D=3D VDSO_CLOCKMODE_TIMENS)
 			vd =3D __arch_get_vdso_u_timens_data(vd);
=20
 		tz->tz_minuteswest =3D vd[CS_HRES_COARSE].tz_minuteswest;
@@ -361,13 +363,16 @@ __cvdso_gettimeofday(struct __kernel_old_timeval *tv, s=
truct timezone *tz)
 static __maybe_unused __kernel_old_time_t
 __cvdso_time_data(const struct vdso_time_data *vd, __kernel_old_time_t *time)
 {
+	const struct vdso_clock *vc =3D vd;
 	__kernel_old_time_t t;
=20
 	if (IS_ENABLED(CONFIG_TIME_NS) &&
-	    vd->clock_mode =3D=3D VDSO_CLOCKMODE_TIMENS)
+	    vc->clock_mode =3D=3D VDSO_CLOCKMODE_TIMENS) {
 		vd =3D __arch_get_vdso_u_timens_data(vd);
+		vc =3D vd;
+	}
=20
-	t =3D READ_ONCE(vd[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);
+	t =3D READ_ONCE(vc[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);
=20
 	if (time)
 		*time =3D t;
@@ -386,6 +391,7 @@ static __maybe_unused
 int __cvdso_clock_getres_common(const struct vdso_time_data *vd, clockid_t c=
lock,
 				struct __kernel_timespec *res)
 {
+	const struct vdso_clock *vc =3D vd;
 	u32 msk;
 	u64 ns;
=20
@@ -394,7 +400,7 @@ int __cvdso_clock_getres_common(const struct vdso_time_da=
ta *vd, clockid_t clock
 		return -1;
=20
 	if (IS_ENABLED(CONFIG_TIME_NS) &&
-	    vd->clock_mode =3D=3D VDSO_CLOCKMODE_TIMENS)
+	    vc->clock_mode =3D=3D VDSO_CLOCKMODE_TIMENS)
 		vd =3D __arch_get_vdso_u_timens_data(vd);
=20
 	/*

