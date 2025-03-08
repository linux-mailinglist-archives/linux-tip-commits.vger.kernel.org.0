Return-Path: <linux-tip-commits+bounces-4088-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F6E2A57AB4
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 14:46:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CCDEA16D550
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 13:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 684291EB5CD;
	Sat,  8 Mar 2025 13:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dQ9n/Tqt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e0tkNuY2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A8A41DE3B3;
	Sat,  8 Mar 2025 13:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741441508; cv=none; b=ktvrGscnZ182G2X2nX49/0WWYDL2/VBYKTAgchYBQ9B6nAnMcDjSMO3zKGdQ0zAisI3wRK5WmERFoRLy9WHotCE6jp4QeK5HOBO2ynqipb+GklHyJaeZ1TXgVUb5+j7GRU+IDmj2Y8BmdY1QrFzDU8YWflce9j8VBR6dKFjwLNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741441508; c=relaxed/simple;
	bh=QZRRAJSzdr//xe07QaR8DhQB9VQydNc3lNooasOcLUo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Eg83kElxTibiCqAdXwI5HHI6grSNdF3Rn9tN7EIr4DqEdPVDhllkl4oymZA8lIrxJytCQ3WtBC+cFuN0vku2prNPKvui+B55h8LV1LDpz1bM0GB1HofZ5XJXwDiHmDB4qEUFcQ6IynacQ+zLIpCbVfmmBFejh+R45RWfXpvSqHQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dQ9n/Tqt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e0tkNuY2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 08 Mar 2025 13:45:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741441503;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n6yGTps11S7tJ4nQ0DQWRWtZorRxTQ+nu7mzry4JhfI=;
	b=dQ9n/TqtKcMLuRgL7bFMXk6OOrUQrWdRcmcykU9FdWZi1PUis58x62stTV7nENz5VsNIHD
	73TqPY5T3dYuDn0r7ktHyLyLNhaVr+sud2q35MP2fvEUxXmM15O7vmhORjDbWrpnZ/Hqtn
	7ISiWSREbq6olNJQj05W0/FNsiLWBkWaexvaIGUkjv6IhHwdNGAekABSm70Y2NeuiUgyst
	+UD9chA/toWdW66sAAlY57xEFrJXc/ftga0YgH7MCvPw7queVusLjSIaPVCXknQ4D6P7ia
	DwAih4F99ljXfKpj7IDi8SVcSXGjo5fyJ/iQ9CQgdcx6+lZ/vM7NM0dmBwvr5A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741441503;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n6yGTps11S7tJ4nQ0DQWRWtZorRxTQ+nu7mzry4JhfI=;
	b=e0tkNuY2ZEk6908q5LHcqS3Atj5fukPa4jHOuMkGsaXIBcVxIaniZA2xg08V2pTHsIspZ+
	zHx2SJloc9D3gmCQ==
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
In-Reply-To: <20250303-vdso-clock-v1-6-c1b5c69a166f@linutronix.de>
References: <20250303-vdso-clock-v1-6-c1b5c69a166f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174144150327.14745.2931236750582725367.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     cddb82d1c4de5649b6841a1b94a610f934c5dd5f
Gitweb:        https://git.kernel.org/tip/cddb82d1c4de5649b6841a1b94a610f934c=
5dd5f
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 03 Mar 2025 12:11:08 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 08 Mar 2025 14:37:40 +01:00

vdso/gettimeofday: Prepare introduction of struct vdso_clock

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of VDSO clocks. At the moment,
vdso_clock is simply a define which maps vdso_clock to vdso_time_data.

Prepare all functions which need the pointer to the vdso_clock array to
work correctly after introducing the new struct. Where applicable, replace
the struct vdso_time_data pointer by a struct vdso_clock pointer.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250303-vdso-clock-v1-6-c1b5c69a166f@linut=
ronix.de

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

