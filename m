Return-Path: <linux-tip-commits+bounces-3778-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 656F4A4BCA6
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 11:44:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 63D5D1709F7
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 10:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775AD1F1506;
	Mon,  3 Mar 2025 10:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TP6Quvpw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KSuzR6wk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74ED81F3BBB;
	Mon,  3 Mar 2025 10:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998586; cv=none; b=Ep75j+jWRG0Ds2N50ctxN15rSbPssKrmei8nx63iMKmf/5cck2JW7ZUqzEsb9QOYsyjZgAqo7IjzKUpwTchszLZCGoJrxs4Hmh1hXpIz4m5VTy/TsClzGqlUvYh+zrUTLj4AYURPx0IBhDCM+7Pg3Ar1KnQfeK72saAz1iHoGvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998586; c=relaxed/simple;
	bh=4U1e1hydLMD3otcr2vYHmEN9c5Q9SXUzwUNJo1CEemE=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=rB5U9qILlMlMiGJz0MozxPOcKB9FLh7dIRBIHRPbkPLKjJbeXN2/wmo4BSmD1Wou9ZtxO+fHTtqicgyZgltbRs7x4pnR3hJ/p+7OtXbnrd0yOckCuSHD63Rd55/pD7vnuybe9oMRqdUgDRe23/uC/Cs5mi5WPjXjDO87K6CDkEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TP6Quvpw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KSuzR6wk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 10:43:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740998582;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=0ekJF2fVhkHdo33E+TtCnPtFFKjNCa8zblcEFEmeBsk=;
	b=TP6QuvpwALVtW1IAH7bg/WFlSxoOMtguqPAjh7Q8CbziIF1emA7+a7gOVAGZroMELv1uNf
	s6kTkuJ43L3bHqDq3G2loRb0x9zTzB/gesquGJKHHpPQBx87TFeRQezuesZ9CS7GXFTVLl
	QuVzkPECCnznaw2sHlWrefL/YvOCqP3R7ohF3Z5Tfbe0TJKOfGHaUXwa/YuyvXVvDSyiMv
	/MtCuCZmz6Ukt+tPGS/TV9Kt3LdcQL3PSDOIdM2QZcCW7B2wn4Co6Vv4PrQOYAm6ERSb5+
	M5eHHQF111bzMKWUc0X7ei+PLdU1nLVPzPE3vddvImq2dvUnr5kU5hAkymKFgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740998582;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=0ekJF2fVhkHdo33E+TtCnPtFFKjNCa8zblcEFEmeBsk=;
	b=KSuzR6wkNng2c3cJ37l67AzLjQ6w6dGW8TPfdN+rEbb1EYaWUEzR7qrPz/pHzj4CcYgz2S
	HeDyx899HUOOIeCw==
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
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174099858180.10177.11555173983043051412.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     7c40a0bd76db740eff76039a7cf43d90a633697e
Gitweb:        https://git.kernel.org/tip/7c40a0bd76db740eff76039a7cf43d90a63=
3697e
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Tue, 25 Feb 2025 13:36:44 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Mar 2025 10:24:35 +01:00

vdso/vsyscall: Prepare introduction of struct vdso_clock

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of it. By now, vdso_clock is
simply a define which maps vdso_clock to vdso_time_data.

To prepare for the rework of the data structures, replace the struct
vdso_time_data pointer with struct vdso_clock pointer whenever applicable.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

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

