Return-Path: <linux-tip-commits+bounces-6429-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 55D20B41AE7
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 11:59:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 518FD7A6494
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Sep 2025 09:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20FF626B95B;
	Wed,  3 Sep 2025 09:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wqrhYnMW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hM7Zv5F5"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D23F1B3935;
	Wed,  3 Sep 2025 09:58:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756893540; cv=none; b=a6O2oWCGLYzKI4MKCxRJ5xkRTtffCULvNGxY1PBzFS/aQyJy04mO3ytMi+ZDRJoh7ieEcoi3eGMHTCwIv9/xTDpHAyNSKL1dsPlRe9NNaD43SILrfTlrK7WQjfGJa7nSPKIQa40ZbXh3XCTtrQMQLO+gAlokcVddlWqmGw5u2uM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756893540; c=relaxed/simple;
	bh=3UiHMYeM4GHtOQtohxHdrM63uaJ52zzDf0Ia/szXyvE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iQ8GfBUAfW5sanO3Jkkvbv+YqHTDyQyGChlBCfCSx/CRamBcz9JDKQ62SkaiyKGsCzWia9ik+gdtpL/4mEi7evuO1bthITAwjZBQO2ISVE4q9sG0vRWSGvmxOCFpx1Cu541TNfYg/FRh9DiwXUwDRDKgHnaS5ITl4vMMsz36N0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wqrhYnMW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hM7Zv5F5; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 03 Sep 2025 09:58:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756893534;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YMY5Rw67Zd5ivqpebc2I+pt11+SaGI/36GCSjD2kg3s=;
	b=wqrhYnMWSTn2UFyb8ex5iqCoh4YYel4wCa+EoVRgWD2S3Ar3fBbZAh1ko8+F7iB76dJcuQ
	gt4zNJDWcioR7v6w7u3w0ulM1W0tZEgKQ4AQK/O4olljmnswEmuvGWxPsOcVhfTxhzV1Hs
	RevF8PPONdKyGlkHeK/h0Xs6vpcT8H61qj9DxHqWSFyZlXy4NZi2vEMcSI7qg/DiY+SFyf
	08/QGrqXrCYZkeDENwwJ8UIwh0iWeTL7ELR9zZioYRMxVAfeufvQOtM9yHSAxuB1y8z/ko
	4WY8eENo6dq3clSGvsQLCCW55h+xZucTwC4CATUVpIcxpLp9EQjHLzDwX5SNdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756893534;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YMY5Rw67Zd5ivqpebc2I+pt11+SaGI/36GCSjD2kg3s=;
	b=hM7Zv5F5+KlCE5hu0ud4zVwbcvacr58qNTy1gvlyXkfcp3RiWIGJcdk+dFJfl6cpNop54Q
	VMYbD4vkyIKi6NCQ==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] vdso/vsyscall: Avoid slow division loop in
 auxiliary clock update
Cc: Miroslav Lichvar <mlichvar@redhat.com>, thomas.weissschuh@linutronix.de,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250825-vdso-auxclock-division-v1-1-a1d32a16a313@linutronix.de>
References: <20250825-vdso-auxclock-division-v1-1-a1d32a16a313@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175689353303.1920.4835241898909824126.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     762af5a2aa0ad18da1316666dae30d369268d44c
Gitweb:        https://git.kernel.org/tip/762af5a2aa0ad18da1316666dae30d36926=
8d44c
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Mon, 25 Aug 2025 15:26:35 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 03 Sep 2025 11:55:11 +02:00

vdso/vsyscall: Avoid slow division loop in auxiliary clock update

The call to __iter_div_u64_rem() in vdso_time_update_aux() is a wrapper
around subtraction. It cannot be used to divide large numbers, as that
introduces long, computationally expensive delays.  A regular u64 division
is also not possible in the timekeeper update path as it can be too slow.

Instead of splitting the ktime_t offset into into second and subsecond
components during the timekeeper update fast-path, do it together with the
adjustment of tk->offs_aux in the slow-path. Equivalent to the handling of
offs_boot and monotonic_to_boot.

Reuse the storage of monotonic_to_boot for the new field, as it is not used
by auxiliary timekeepers.

Fixes: 380b84e168e5 ("vdso/vsyscall: Update auxiliary clock data in the datap=
age")
Reported-by: Miroslav Lichvar <mlichvar@redhat.com>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250825-vdso-auxclock-division-v1-1-a1d32a=
16a313@linutronix.de
Closes: https://lore.kernel.org/lkml/aKwsNNWsHJg8IKzj@localhost/
---
 include/linux/timekeeper_internal.h |  9 ++++++++-
 kernel/time/timekeeping.c           | 10 ++++++++--
 kernel/time/vsyscall.c              |  4 ++--
 3 files changed, 18 insertions(+), 5 deletions(-)

diff --git a/include/linux/timekeeper_internal.h b/include/linux/timekeeper_i=
nternal.h
index c27aac6..b8ae89e 100644
--- a/include/linux/timekeeper_internal.h
+++ b/include/linux/timekeeper_internal.h
@@ -76,6 +76,7 @@ struct tk_read_base {
  * @cs_was_changed_seq:		The sequence number of clocksource change events
  * @clock_valid:		Indicator for valid clock
  * @monotonic_to_boot:		CLOCK_MONOTONIC to CLOCK_BOOTTIME offset
+ * @monotonic_to_aux:		CLOCK_MONOTONIC to CLOCK_AUX offset
  * @cycle_interval:		Number of clock cycles in one NTP interval
  * @xtime_interval:		Number of clock shifted nano seconds in one NTP
  *				interval.
@@ -117,6 +118,9 @@ struct tk_read_base {
  * @offs_aux is used by the auxiliary timekeepers which do not utilize any
  * of the regular timekeeper offset fields.
  *
+ * @monotonic_to_aux is a timespec64 representation of @offs_aux to
+ * accelerate the VDSO update for CLOCK_AUX.
+ *
  * The cacheline ordering of the structure is optimized for in kernel usage =
of
  * the ktime_get() and ktime_get_ts64() family of time accessors. Struct
  * timekeeper is prepended in the core timekeeping code with a sequence coun=
t,
@@ -159,7 +163,10 @@ struct timekeeper {
 	u8			cs_was_changed_seq;
 	u8			clock_valid;
=20
-	struct timespec64	monotonic_to_boot;
+	union {
+		struct timespec64	monotonic_to_boot;
+		struct timespec64	monotonic_to_aux;
+	};
=20
 	u64			cycle_interval;
 	u64			xtime_interval;
diff --git a/kernel/time/timekeeping.c b/kernel/time/timekeeping.c
index 059fa8b..b6974fc 100644
--- a/kernel/time/timekeeping.c
+++ b/kernel/time/timekeeping.c
@@ -83,6 +83,12 @@ static inline bool tk_is_aux(const struct timekeeper *tk)
 }
 #endif
=20
+static inline void tk_update_aux_offs(struct timekeeper *tk, ktime_t offs)
+{
+	tk->offs_aux =3D offs;
+	tk->monotonic_to_aux =3D ktime_to_timespec64(offs);
+}
+
 /* flag for if timekeeping is suspended */
 int __read_mostly timekeeping_suspended;
=20
@@ -1506,7 +1512,7 @@ static int __timekeeping_inject_offset(struct tk_data *=
tkd, const struct timespe
 			timekeeping_restore_shadow(tkd);
 			return -EINVAL;
 		}
-		tks->offs_aux =3D offs;
+		tk_update_aux_offs(tks, offs);
 	}
=20
 	timekeeping_update_from_shadow(tkd, TK_UPDATE_ALL);
@@ -2937,7 +2943,7 @@ static int aux_clock_set(const clockid_t id, const stru=
ct timespec64 *tnew)
 	 * xtime ("realtime") is not applicable for auxiliary clocks and
 	 * kept in sync with "monotonic".
 	 */
-	aux_tks->offs_aux =3D ktime_sub(timespec64_to_ktime(*tnew), tnow);
+	tk_update_aux_offs(aux_tks, ktime_sub(timespec64_to_ktime(*tnew), tnow));
=20
 	timekeeping_update_from_shadow(aux_tkd, TK_UPDATE_ALL);
 	return 0;
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index 8ba8b0d..aa59919 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -159,10 +159,10 @@ void vdso_time_update_aux(struct timekeeper *tk)
 	if (clock_mode !=3D VDSO_CLOCKMODE_NONE) {
 		fill_clock_configuration(vc, &tk->tkr_mono);
=20
-		vdso_ts->sec	=3D tk->xtime_sec;
+		vdso_ts->sec =3D tk->xtime_sec + tk->monotonic_to_aux.tv_sec;
=20
 		nsec =3D tk->tkr_mono.xtime_nsec >> tk->tkr_mono.shift;
-		nsec +=3D tk->offs_aux;
+		nsec +=3D tk->monotonic_to_aux.tv_nsec;
 		vdso_ts->sec +=3D __iter_div_u64_rem(nsec, NSEC_PER_SEC, &nsec);
 		nsec =3D nsec << tk->tkr_mono.shift;
 		vdso_ts->nsec =3D nsec;

