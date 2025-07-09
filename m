Return-Path: <linux-tip-commits+bounces-6039-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F520AFE4B9
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jul 2025 11:58:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4138F4E7E2B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jul 2025 09:57:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42AC8289835;
	Wed,  9 Jul 2025 09:57:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WRVos7Wx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MdjAxvq/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F1CC2882D4;
	Wed,  9 Jul 2025 09:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055059; cv=none; b=eP518DHkAqLVI1he0msMK9537ALCz/LmXdbET44pkHAR8Ep9guU9MphenO3kbzgN9IWpcF1Z0SScWlDfXTHLonm5dva2iEno2Ex/O1+4Ne3/PFQK3tYyv6tf1zg7Jqo9cwvD9JSXk7umR7624fsV79mu46gxGLUfsXSDsCG9O9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055059; c=relaxed/simple;
	bh=SMwLi8HGYi8fExJn573PJOpcfbuXlNZaF08QLQnbleI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KDNO4qCO1VVBWUgk8w3kbJfo4QXb0UjQD5uXLxCEBUPFgndF+8+0eNN7ng2lNglO75VKYPdD57tXDJFRkzNjXvN0FFF9rF5tEzHqJJVwMVq2riv5hqpkWMhrnFtf8MN/BfcDwrlaXl3NZvtWO3MAy7O2ITJRBJjOjmCOxxG57Ts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WRVos7Wx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MdjAxvq/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Jul 2025 09:57:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752055055;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pts0yDQNayYP5ik+t7tEYp2V8mLnEVm3K8b1Focg6CI=;
	b=WRVos7WxuC4gLRch/f8vzidJU/OtbLA3F00fHt57KUpdOxrJYMjnm3zowrTktHLiduVRpx
	RQNlznTr31S0JVtJ7E13JggzcKiS3yt9aihISnwqHiO7xnQVE1S2OSGn6HZTX1faL0pHgq
	xtA2nMEI1mkIqDKdmPtx+UB45Up613jZXWyuzwKuIlLz4hMtFZttnFGOIReCTUD1EtgROv
	f6PkeH5SJQUGGLbeeF/tM9+jpxql3rYjglz9gnFUi5A87BFGxrHKZHXurUzfXXOFDvwriy
	ld62L/6R3TDi64mpgEljPhSwRZiTTfd/3LDukKf5GFu04bpyecx4TXTD6C4/og==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752055055;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pts0yDQNayYP5ik+t7tEYp2V8mLnEVm3K8b1Focg6CI=;
	b=MdjAxvq/otFASuOpg3IHkA4TghtiqgcqTGDciybfYCmsokCOo3C8xL3PKnjh0a9n3Iverq
	ggJBGZ24bnMG+dDA==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/ptp] vdso/gettimeofday: Introduce vdso_get_timestamp()
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250701-vdso-auxclock-v1-9-df7d9f87b9b8@linutronix.de>
References: <20250701-vdso-auxclock-v1-9-df7d9f87b9b8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175205505398.406.1532044896178418072.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     1e851f508087a90ca0b5e7e6026a150144514df7
Gitweb:        https://git.kernel.org/tip/1e851f508087a90ca0b5e7e6026a1501445=
14df7
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 01 Jul 2025 10:58:03 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 09 Jul 2025 11:52:35 +02:00

vdso/gettimeofday: Introduce vdso_get_timestamp()

This code is duplicated and with the introduction of auxiliary clocks will
be duplicated even more.

Introduce a helper.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250701-vdso-auxclock-v1-9-df7d9f87b9b8@li=
nutronix.de

---
 lib/vdso/gettimeofday.c | 43 ++++++++++++++++++++++------------------
 1 file changed, 24 insertions(+), 19 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 296709b..d9cb1d9 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -87,6 +87,26 @@ static __always_inline void vdso_set_timespec(struct __ker=
nel_timespec *ts, u64=20
 	ts->tv_nsec =3D ns;
 }
=20
+static __always_inline
+bool vdso_get_timestamp(const struct vdso_time_data *vd, const struct vdso_c=
lock *vc,
+			unsigned int clkidx, u64 *sec, u64 *ns)
+{
+	const struct vdso_timestamp *vdso_ts =3D &vc->basetime[clkidx];
+	u64 cycles;
+
+	if (unlikely(!vdso_clocksource_ok(vc)))
+		return false;
+
+	cycles =3D __arch_get_hw_counter(vc->clock_mode, vd);
+	if (unlikely(!vdso_cycles_ok(cycles)))
+		return false;
+
+	*ns =3D vdso_calc_ns(vc, cycles, vdso_ts->nsec);
+	*sec =3D vdso_ts->sec;
+
+	return true;
+}
+
 #ifdef CONFIG_TIME_NS
=20
 #ifdef CONFIG_GENERIC_VDSO_DATA_STORE
@@ -104,28 +124,20 @@ bool do_hres_timens(const struct vdso_time_data *vdns, =
const struct vdso_clock *
 	const struct vdso_time_data *vd =3D __arch_get_vdso_u_timens_data(vdns);
 	const struct timens_offset *offs =3D &vcns->offset[clk];
 	const struct vdso_clock *vc =3D vd->clock_data;
-	const struct vdso_timestamp *vdso_ts;
-	u64 cycles, ns;
 	u32 seq;
 	s64 sec;
+	u64 ns;
=20
 	if (clk !=3D CLOCK_MONOTONIC_RAW)
 		vc =3D &vc[CS_HRES_COARSE];
 	else
 		vc =3D &vc[CS_RAW];
-	vdso_ts =3D &vc->basetime[clk];
=20
 	do {
 		seq =3D vdso_read_begin(vc);
=20
-		if (unlikely(!vdso_clocksource_ok(vc)))
-			return false;
-
-		cycles =3D __arch_get_hw_counter(vc->clock_mode, vd);
-		if (unlikely(!vdso_cycles_ok(cycles)))
+		if (!vdso_get_timestamp(vd, vc, clk, &sec, &ns))
 			return false;
-		ns =3D vdso_calc_ns(vc, cycles, vdso_ts->nsec);
-		sec =3D vdso_ts->sec;
 	} while (unlikely(vdso_read_retry(vc, seq)));
=20
 	/* Add the namespace offset */
@@ -155,8 +167,7 @@ static __always_inline
 bool do_hres(const struct vdso_time_data *vd, const struct vdso_clock *vc,
 	     clockid_t clk, struct __kernel_timespec *ts)
 {
-	const struct vdso_timestamp *vdso_ts =3D &vc->basetime[clk];
-	u64 cycles, sec, ns;
+	u64 sec, ns;
 	u32 seq;
=20
 	/* Allows to compile the high resolution parts out */
@@ -183,14 +194,8 @@ bool do_hres(const struct vdso_time_data *vd, const stru=
ct vdso_clock *vc,
 		}
 		smp_rmb();
=20
-		if (unlikely(!vdso_clocksource_ok(vc)))
+		if (!vdso_get_timestamp(vd, vc, clk, &sec, &ns))
 			return false;
-
-		cycles =3D __arch_get_hw_counter(vc->clock_mode, vd);
-		if (unlikely(!vdso_cycles_ok(cycles)))
-			return false;
-		ns =3D vdso_calc_ns(vc, cycles, vdso_ts->nsec);
-		sec =3D vdso_ts->sec;
 	} while (unlikely(vdso_read_retry(vc, seq)));
=20
 	vdso_set_timespec(ts, sec, ns);

