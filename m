Return-Path: <linux-tip-commits+bounces-3781-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D278DA4BCB3
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 11:45:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 177F67AA720
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 10:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 80B171F463B;
	Mon,  3 Mar 2025 10:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e+Zt0YTp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qrCYdX3J"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 954471F4197;
	Mon,  3 Mar 2025 10:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998588; cv=none; b=PjDhSio+f4yFQsp5FXNn6SwazgEXkADd9BY/1yAtNaK2yE16cCfJYkgzRUOzFdB5up7fKTN9bFdW1/Kp9UNwASheo3SHDa/RslnSD7pG6muo0khNqwakznoKOavh26onlmSnDdKa0KMk59Ve/lsoNZUZhzjldksHWzAeZ/syFow=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998588; c=relaxed/simple;
	bh=FfuMskcfTBXEVSONYvJ4k5q2Td24UkjNjl8GHwUc+u4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=EHKXnCeWU9fKLl319gPFKb/5yqctuKkDtBQ5agpNeZpDQCSah/+g0RJeqvIQePQcoP/zHUq6f2vyRECsd55Mia3K9fKUZRBNVCCLNGsVjwBtzobYe44X9nO4bSLSKC5HwOMHwP4pKHeUAIoEi89DFDEErkjH0BO0y8SAFwmi+qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=e+Zt0YTp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qrCYdX3J; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 10:43:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740998583;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=gil5s0YiRoBfsECe427eHMCbmTueUr4YK7uuEwqS3ZE=;
	b=e+Zt0YTpnPGMBk1rc0GfsOkreSsF6uV3xV/mRA32svfyY8W6EMJ3ahFPMSEeZluoepow+h
	Ewj25Sa+1K18DUtT09ESd8eR0iiQexISFVHxO6a64hwAzdTZJbSoMYSkoJ/2DjkJsTfj5m
	1fV5GX0KE4ww50Po2qR8Ds1JzoYV+j2xBrt70ly4VETXaW1mslz8B+wwRoNaayZU0fOQtQ
	upde4lUI+vp0CjPiVxyNQxnuC315LuaUpxLBjmojQL0TOIu6ZzquxmnvdCv5uXB5LbD4+p
	L153LhrBuB0Q/mp9u94BOmdJCw7JjnHmcW2gdlQR11OI4oPZg05/Rx1RhnZKEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740998583;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=gil5s0YiRoBfsECe427eHMCbmTueUr4YK7uuEwqS3ZE=;
	b=qrCYdX3JnbBpNHKbbVY9CA7AriG+HegMRwt2iNvbi2p3FQ/OlwQTqdAVbb/xrPuC8QWr5L
	2a4nLu6/7FsXc1AQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso/gettimeofday: Prepare do_coarse() for
 introduction of struct vdso_clock
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
Message-ID: <174099858323.10177.17703515474035154151.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     b887aee23b05bece8564bdf3e2cb66d05dd93aca
Gitweb:        https://git.kernel.org/tip/b887aee23b05bece8564bdf3e2cb66d05dd=
93aca
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Tue, 25 Feb 2025 13:36:41 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Mar 2025 10:24:34 +01:00

vdso/gettimeofday: Prepare do_coarse() for introduction of struct vdso_clock

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of it. By now, vdso_clock is
simply a define which maps vdso_clock to vdso_time_data.

Prepare for the rework of these structures by adding struct vdso_clock
pointer argument to do_coarse(), and replace the struct vdso_time_data
pointer with the new pointer arugment whenever applicable.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 lib/vdso/gettimeofday.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index e8d4b02..36ef7de 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -229,10 +229,11 @@ static __always_inline int do_coarse_timens(const struc=
t vdso_time_data *vdns, c
 }
 #endif
=20
-static __always_inline int do_coarse(const struct vdso_time_data *vd, clocki=
d_t clk,
-				     struct __kernel_timespec *ts)
+static __always_inline
+int do_coarse(const struct vdso_time_data *vd, const struct vdso_clock *vc,
+	      clockid_t clk, struct __kernel_timespec *ts)
 {
-	const struct vdso_timestamp *vdso_ts =3D &vd->basetime[clk];
+	const struct vdso_timestamp *vdso_ts =3D &vc->basetime[clk];
 	u32 seq;
=20
 	do {
@@ -240,17 +241,17 @@ static __always_inline int do_coarse(const struct vdso_=
time_data *vd, clockid_t=20
 		 * Open coded function vdso_read_begin() to handle
 		 * VDSO_CLOCK_TIMENS. See comment in do_hres().
 		 */
-		while ((seq =3D READ_ONCE(vd->seq)) & 1) {
+		while ((seq =3D READ_ONCE(vc->seq)) & 1) {
 			if (IS_ENABLED(CONFIG_TIME_NS) &&
-			    vd->clock_mode =3D=3D VDSO_CLOCKMODE_TIMENS)
-				return do_coarse_timens(vd, clk, ts);
+			    vc->clock_mode =3D=3D VDSO_CLOCKMODE_TIMENS)
+				return do_coarse_timens(vc, clk, ts);
 			cpu_relax();
 		}
 		smp_rmb();
=20
 		ts->tv_sec =3D vdso_ts->sec;
 		ts->tv_nsec =3D vdso_ts->nsec;
-	} while (unlikely(vdso_read_retry(vd, seq)));
+	} while (unlikely(vdso_read_retry(vc, seq)));
=20
 	return 0;
 }
@@ -274,7 +275,7 @@ __cvdso_clock_gettime_common(const struct vdso_time_data =
*vd, clockid_t clock,
 	if (likely(msk & VDSO_HRES))
 		vc =3D &vc[CS_HRES_COARSE];
 	else if (msk & VDSO_COARSE)
-		return do_coarse(&vc[CS_HRES_COARSE], clock, ts);
+		return do_coarse(vd, &vc[CS_HRES_COARSE], clock, ts);
 	else if (msk & VDSO_RAW)
 		vc =3D &vc[CS_RAW];
 	else

