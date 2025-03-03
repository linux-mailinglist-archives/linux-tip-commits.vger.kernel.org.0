Return-Path: <linux-tip-commits+bounces-3942-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD70FA4E58E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 17:21:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4D7277A4453
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 16:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 492D72673BA;
	Tue,  4 Mar 2025 16:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tjIZJjcJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0rLHsxSx"
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76762291FB8
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 16:02:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741104164; cv=pass; b=WWwG1JKEOPdlXp2ZJuCekPZxXqRPQaevwhnMz7szwP7Dtsp+2wkYRtM3Ww6d63NtWattVsCAwfs9/kOdwVx7yRK3oVFhn5scV39a5PMEcHfU8JhDIpJt54PTycu221druA8C1HLdXfzJc0PoJgXQLoB0a4vYO03BP/bMW2/nwl0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741104164; c=relaxed/simple;
	bh=JurDxTEUvAXeGf95mxVBEOOVUDSsDo87xxNi9YffqiU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=QU42DXwQLWMAqw4I0AiH1Pq3VAGCNsNfI2rg3GZ8k6RVXiSd/xiRUFeKKFyu6zJfuNX9Cb75KPVSQJEDC3SYkS6sdtSqjvJR9svuUcW+o6H3aGrHOut4tv4qRW7SEvIQhLAa6KEqHDmKmIJLl2bQYEoHYkwA/2bp2R8ux0X8OVY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tjIZJjcJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0rLHsxSx; arc=none smtp.client-ip=193.142.43.55; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 9B68840D975C
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 19:02:40 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=tjIZJjcJ;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=0rLHsxSx
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6gQS41glzG29J
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 19:01:04 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 37E8E4273F; Tue,  4 Mar 2025 19:00:37 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tjIZJjcJ;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0rLHsxSx
X-Envelope-From: <linux-kernel+bounces-541416-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tjIZJjcJ;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0rLHsxSx
Received: from fgw1.itu.edu.tr (fgw1.itu.edu.tr [160.75.25.103])
	by le2 (Postfix) with ESMTP id A89A242C0C
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:46:43 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw1.itu.edu.tr (Postfix) with SMTP id 5A539305F789
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:46:43 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E95B6169296
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:46:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 79D2D1F4197;
	Mon,  3 Mar 2025 10:43:12 +0000 (UTC)
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
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6gQS41glzG29J
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741708895.19275@Ny1cqa0sTPkanIAjg++dtQ
X-ITU-MailScanner-SpamCheck: not spam

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


