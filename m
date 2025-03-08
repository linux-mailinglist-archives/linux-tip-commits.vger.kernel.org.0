Return-Path: <linux-tip-commits+bounces-4078-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 361C1A57AA4
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 14:45:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AAC647A7CE6
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 13:44:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A22E41B4152;
	Sat,  8 Mar 2025 13:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IhlKT0r2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="X8rk2M0C"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9236C1D61A1;
	Sat,  8 Mar 2025 13:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741441504; cv=none; b=HHnLcEP1uV59MkT2/FiGRCPWhhPjrScHKsclJ2FsNk1QXG7s+M9bQs0tWKrwpr5H+F0gchF24GcenINXzaiTXS2FO+xMfkZoCT9a+Fmv3Irr+FxSu1zI8YcI7Y+BSJ0daebxnWZ6W3WHpQHOV+SXlaSnq4uOD8Sg01dq+2c/EKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741441504; c=relaxed/simple;
	bh=vM7L5fwy4Mtko5ihHZTwCZyhC1gzbooEM/bCUDwqKkk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=k+LSReOBlOLoHMjXdPrKUR5dfk2e33pI6n8EkGJQf+oLKf8dDN76nKYoXmoNertvqGqUxhJHY5LZCFFieF85YtMNKX4PhmSSha9ToBEE9dbOSgRGpkT78+8VvGA6U5EelGTGNgMJnO/kRAVbdj038WvrfTY5XEmOJ7nSKXjNuCA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IhlKT0r2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=X8rk2M0C; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 08 Mar 2025 13:45:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741441500;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e5bf9z0RgbqXonFyUsArwRAoJWwD80YgHESx9kNyK7A=;
	b=IhlKT0r2OOG1y2WSYmj+uY2HK6quMwm0lcqaeToN1EL5Z8Twlj8KFyU5SZ2nDqMfkgLBeS
	+6mKKVtPfMLqdTiHswPm9mJC9pkD0sYi3xIyw8qsVyv9U+5CE0CYBayZR0e6LnCZ1vpifh
	/SN8VWiMykQuxmkApq2BTVoBgACmbKO4sPqPFC+If9EEgQjHazYh8EafBmFaLfr15Ukx17
	4VDtPaQV9ckCa6KdEaFiWbOf+k7oQKe+WLONhtzwyBCEJOyCRK5ZXmaDw6KH0PHaPclUxi
	+Iz+jcM3mJhlYOvEh+XtzPltu7TmqTI7x+Ut4lwsVMGQBJ22GYqgZYKHOtFyOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741441500;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e5bf9z0RgbqXonFyUsArwRAoJWwD80YgHESx9kNyK7A=;
	b=X8rk2M0CQShZjpow/4GUdhrtaoZx2po7Kio1ilJ1QCMr7SDCatGFGPlWNo+2iOJm+uLEEA
	cvWuGb8vTqlioyDQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] vdso/vsyscall: Prepare introduction of struct vdso_clock
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Nam Cao <namcao@linutronix.de>, thomas.weissschuh@linutronix.de,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303-vdso-clock-v1-12-c1b5c69a166f@linutronix.de>
References: <20250303-vdso-clock-v1-12-c1b5c69a166f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174144150019.14745.15771824597626057566.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     b5afbc106d7cbfa1ffbe7c8da2693e5effbba95e
Gitweb:        https://git.kernel.org/tip/b5afbc106d7cbfa1ffbe7c8da2693e5effb=
ba95e
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 03 Mar 2025 12:11:14 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 08 Mar 2025 14:37:41 +01:00

vdso/vsyscall: Prepare introduction of struct vdso_clock

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of VDSO clocks. At the moment,
vdso_clock is simply a define which maps vdso_clock to vdso_time_data.

To prepare for the rework of the data structures, replace the struct
vdso_time_data pointer with a struct vdso_clock pointer where applicable.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250303-vdso-clock-v1-12-c1b5c69a166f@linu=
tronix.de

---
 kernel/time/vsyscall.c | 40 +++++++++++++++++++++-------------------
 1 file changed, 21 insertions(+), 19 deletions(-)

diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index 4181922..dd85b41 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -18,25 +18,26 @@
 static inline void update_vdso_time_data(struct vdso_time_data *vdata, struc=
t timekeeper *tk)
 {
 	struct vdso_timestamp *vdso_ts;
+	struct vdso_clock *vc =3D vdata;
 	u64 nsec, sec;
=20
-	vdata[CS_HRES_COARSE].cycle_last	=3D tk->tkr_mono.cycle_last;
+	vc[CS_HRES_COARSE].cycle_last	=3D tk->tkr_mono.cycle_last;
 #ifdef CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT
-	vdata[CS_HRES_COARSE].max_cycles	=3D tk->tkr_mono.clock->max_cycles;
+	vc[CS_HRES_COARSE].max_cycles	=3D tk->tkr_mono.clock->max_cycles;
 #endif
-	vdata[CS_HRES_COARSE].mask		=3D tk->tkr_mono.mask;
-	vdata[CS_HRES_COARSE].mult		=3D tk->tkr_mono.mult;
-	vdata[CS_HRES_COARSE].shift		=3D tk->tkr_mono.shift;
-	vdata[CS_RAW].cycle_last		=3D tk->tkr_raw.cycle_last;
+	vc[CS_HRES_COARSE].mask		=3D tk->tkr_mono.mask;
+	vc[CS_HRES_COARSE].mult		=3D tk->tkr_mono.mult;
+	vc[CS_HRES_COARSE].shift	=3D tk->tkr_mono.shift;
+	vc[CS_RAW].cycle_last		=3D tk->tkr_raw.cycle_last;
 #ifdef CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT
-	vdata[CS_RAW].max_cycles		=3D tk->tkr_raw.clock->max_cycles;
+	vc[CS_RAW].max_cycles		=3D tk->tkr_raw.clock->max_cycles;
 #endif
-	vdata[CS_RAW].mask			=3D tk->tkr_raw.mask;
-	vdata[CS_RAW].mult			=3D tk->tkr_raw.mult;
-	vdata[CS_RAW].shift			=3D tk->tkr_raw.shift;
+	vc[CS_RAW].mask			=3D tk->tkr_raw.mask;
+	vc[CS_RAW].mult			=3D tk->tkr_raw.mult;
+	vc[CS_RAW].shift		=3D tk->tkr_raw.shift;
=20
 	/* CLOCK_MONOTONIC */
-	vdso_ts		=3D &vdata[CS_HRES_COARSE].basetime[CLOCK_MONOTONIC];
+	vdso_ts		=3D &vc[CS_HRES_COARSE].basetime[CLOCK_MONOTONIC];
 	vdso_ts->sec	=3D tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
=20
 	nsec =3D tk->tkr_mono.xtime_nsec;
@@ -54,7 +55,7 @@ static inline void update_vdso_time_data(struct vdso_time_d=
ata *vdata, struct ti
 	nsec	+=3D (u64)tk->monotonic_to_boot.tv_nsec << tk->tkr_mono.shift;
=20
 	/* CLOCK_BOOTTIME */
-	vdso_ts		=3D &vdata[CS_HRES_COARSE].basetime[CLOCK_BOOTTIME];
+	vdso_ts		=3D &vc[CS_HRES_COARSE].basetime[CLOCK_BOOTTIME];
 	vdso_ts->sec	=3D sec;
=20
 	while (nsec >=3D (((u64)NSEC_PER_SEC) << tk->tkr_mono.shift)) {
@@ -64,12 +65,12 @@ static inline void update_vdso_time_data(struct vdso_time=
_data *vdata, struct ti
 	vdso_ts->nsec	=3D nsec;
=20
 	/* CLOCK_MONOTONIC_RAW */
-	vdso_ts		=3D &vdata[CS_RAW].basetime[CLOCK_MONOTONIC_RAW];
+	vdso_ts		=3D &vc[CS_RAW].basetime[CLOCK_MONOTONIC_RAW];
 	vdso_ts->sec	=3D tk->raw_sec;
 	vdso_ts->nsec	=3D tk->tkr_raw.xtime_nsec;
=20
 	/* CLOCK_TAI */
-	vdso_ts		=3D &vdata[CS_HRES_COARSE].basetime[CLOCK_TAI];
+	vdso_ts		=3D &vc[CS_HRES_COARSE].basetime[CLOCK_TAI];
 	vdso_ts->sec	=3D tk->xtime_sec + (s64)tk->tai_offset;
 	vdso_ts->nsec	=3D tk->tkr_mono.xtime_nsec;
 }
@@ -78,6 +79,7 @@ void update_vsyscall(struct timekeeper *tk)
 {
 	struct vdso_time_data *vdata =3D vdso_k_time_data;
 	struct vdso_timestamp *vdso_ts;
+	struct vdso_clock *vc =3D vdata;
 	s32 clock_mode;
 	u64 nsec;
=20
@@ -85,21 +87,21 @@ void update_vsyscall(struct timekeeper *tk)
 	vdso_write_begin(vdata);
=20
 	clock_mode =3D tk->tkr_mono.clock->vdso_clock_mode;
-	vdata[CS_HRES_COARSE].clock_mode	=3D clock_mode;
-	vdata[CS_RAW].clock_mode		=3D clock_mode;
+	vc[CS_HRES_COARSE].clock_mode	=3D clock_mode;
+	vc[CS_RAW].clock_mode		=3D clock_mode;
=20
 	/* CLOCK_REALTIME also required for time() */
-	vdso_ts		=3D &vdata[CS_HRES_COARSE].basetime[CLOCK_REALTIME];
+	vdso_ts		=3D &vc[CS_HRES_COARSE].basetime[CLOCK_REALTIME];
 	vdso_ts->sec	=3D tk->xtime_sec;
 	vdso_ts->nsec	=3D tk->tkr_mono.xtime_nsec;
=20
 	/* CLOCK_REALTIME_COARSE */
-	vdso_ts		=3D &vdata[CS_HRES_COARSE].basetime[CLOCK_REALTIME_COARSE];
+	vdso_ts		=3D &vc[CS_HRES_COARSE].basetime[CLOCK_REALTIME_COARSE];
 	vdso_ts->sec	=3D tk->xtime_sec;
 	vdso_ts->nsec	=3D tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
=20
 	/* CLOCK_MONOTONIC_COARSE */
-	vdso_ts		=3D &vdata[CS_HRES_COARSE].basetime[CLOCK_MONOTONIC_COARSE];
+	vdso_ts		=3D &vc[CS_HRES_COARSE].basetime[CLOCK_MONOTONIC_COARSE];
 	vdso_ts->sec	=3D tk->xtime_sec + tk->wall_to_monotonic.tv_sec;
 	nsec		=3D tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
 	nsec		=3D nsec + tk->wall_to_monotonic.tv_nsec;

