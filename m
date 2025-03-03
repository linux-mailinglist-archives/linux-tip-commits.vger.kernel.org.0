Return-Path: <linux-tip-commits+bounces-3782-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F234A4BCB6
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 11:45:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9CF8F3AFD12
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 10:44:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C0D891F4723;
	Mon,  3 Mar 2025 10:43:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tjIZJjcJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0rLHsxSx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935971F4196;
	Mon,  3 Mar 2025 10:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998588; cv=none; b=ULLYcv+FH8TcSKL6J5c9wZGXvdxp43U1s1fTShvGy5xunst+GnIb6DmfKAIBL2AlOD3FmzZfcpaAsVivZj01KUJOlfRcLhPDsCNLfv1E4KvQRfoFjrClloOUNCkngpXf8AoZgsMm1VZCtjmCrTfIYrmHYOTtdimdc+atHHXrRsY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998588; c=relaxed/simple;
	bh=JurDxTEUvAXeGf95mxVBEOOVUDSsDo87xxNi9YffqiU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=f+rp5lTZudSZu29iWB6CejOjHImOfj7d7ZOPiiWs07bfiAbt1RtKNK9jAfZ9zFiozd+KXzFd0ru8PGLBooMRFBVJz+KoksKjiuSwtWVk94q6tMTVOVkymFgp8f5Vl6qRaNxK9N+FkO8i7eyNGqLEjpT+mnaFh9UOqb6xD+7Li0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tjIZJjcJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0rLHsxSx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 10:43:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740998584;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ohp2f7lO8JogFX5JTIdPGTyHHBYPc/YJJo3X1O3wd80=;
	b=tjIZJjcJO686TWE9OIeKy4j8Akwl5J34lUqyQVJ9cKUrlLoxVjg4oayUPUEbfnGXt6Dv7e
	/zdAoFhfYdyZG4CJWPiDux1hRzcYHtf+kgrrXlJ/92p/IpwxNesGWkYg5NdhMJvzPyDHWJ
	FD4CWH8kweyijTSYwCvMvVCix5SVB8cK+/ezgkgo4ZXA+MNGcMwPTVnFgBcgYNtnbXb4AR
	xguvzqC0Xn+xsi1AwSKQtn2ZD+lTlPhorprxuCcE7QRbFUlSyv55rpL2XETYvHcSxH6025
	kR/Js7mhQqApGjhgJ9OD1I926ArQam0MqmboFo2+oE+HOjTRJEpSLRbS+rqQfg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740998584;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ohp2f7lO8JogFX5JTIdPGTyHHBYPc/YJJo3X1O3wd80=;
	b=0rLHsxSxjho/WRjOTby8CWefulPCO/vcFEPdE9gMS1z5/90wdYnuVq3BgSAanXZDBUUpAC
	i8LkhqRAHKAvkfDg==
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
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174099858416.10177.9256402844995291380.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     73153eb2ce038f91e458b5640e7a94dc64fa0718
Gitweb:        https://git.kernel.org/tip/73153eb2ce038f91e458b5640e7a94dc64f=
a0718
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Tue, 25 Feb 2025 13:36:39 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Mar 2025 10:24:34 +01:00

vdso/gettimeofday: Prepare do_hres() for introduction of struct vdso_clock

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of it. By now, vdso_clock is
simply a define which maps vdso_clock to vdso_time_data.

Prepare for the rework of these structures by adding struct vdso_clock
pointer argument to do_hres(), and replace the struct vdso_time_data
pointer with the new pointer arugment whenever applicable.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

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

