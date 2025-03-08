Return-Path: <linux-tip-commits+bounces-4085-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DD452A57AB0
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 14:46:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0C97216D23E
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 13:46:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 19F201EB1A0;
	Sat,  8 Mar 2025 13:45:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Jgaz+1s8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c/SReQf7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B1331DE3C9;
	Sat,  8 Mar 2025 13:45:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741441508; cv=none; b=T3GY6iN3HLNsjXIQlT16P0j4dhqll0cCG6wTyHH9xETod1EdXzOpQczi1asbeJ5mVEGuao0CrupuOpFyZh2fvFiwuPFVbANw/rvRnmzhRu1fIZ59EY+KG5RVrCCT1gEUXZ0ZaRp6b2MTZmvWqQp5gmALDvtel6OieuV4+XeluVo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741441508; c=relaxed/simple;
	bh=8I2y1YKXk10tpCySY4EhuySn8Xys7VDGCUZdIf2S2m8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rkz1JLIs0aqy6aXwVJ1BFTsYOqxRv84ai19Gr3Hg3dslRxrVp8e3zpgpBwvEOvmFXwmssGonHbb7ZZp2eflK83/TcZ8SOaH8l0lROYFWjpWiTaPuFgg+LAqS9ixoA4nraofE2KopaT+8MKbmbO8BFtTNKJ+trkl8g+PHyV1gYF4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Jgaz+1s8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=c/SReQf7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 08 Mar 2025 13:45:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741441502;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R59X3y31PVFFXxb8SvBzh8p6hrDSW3yrs+hqdcc1vE4=;
	b=Jgaz+1s8SxOjTAIoSGPkvOUKDwc7erqMe46ZZ6Qor8yLhkgK7NfmCPLTWfKQgGXl65SwbQ
	BScVprsJTdtYsPzAm+zmqhkgDuli/ga9JS1yBsCz8PZ0qyzqmX/v3cSHtt/MEx1ZPaNAdu
	q74wOUyXp7aW3/LFdxh7UG6aVDHMcqnyOp5P5CR8O+6Au1bDDtMgzT3pM+M+K/23h4EqFh
	6792nhR6hGz5Z6dN/19PBgnO3IJhCv2VPlu0AH+Fr2+Mwrd45kEvIM6ZASLiGOjQw4mcN2
	CF4aVDIJLN8jsA6tdQLy98PF6fdhu/JURaRE27hD4qywcwbLsrQqBWFTaCMH5g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741441502;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R59X3y31PVFFXxb8SvBzh8p6hrDSW3yrs+hqdcc1vE4=;
	b=c/SReQf7XqLUmTZDEM5xy6U2beB5i6E0eWld38tYd+XO9GOQsyGAk/V944d+o7Rnio8RTX
	v8C4T2AIGe0Y2SCw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso/gettimeofday: Prepare do_hres_timens() for
 introduction of struct vdso_clock
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Nam Cao <namcao@linutronix.de>, thomas.weissschuh@linutronix.de,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250303-vdso-clock-v1-8-c1b5c69a166f@linutronix.de>
References: <20250303-vdso-clock-v1-8-c1b5c69a166f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174144150210.14745.8489927078881700741.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     83a2a6b8cfc574dae4e3c65018392dcedc59079a
Gitweb:        https://git.kernel.org/tip/83a2a6b8cfc574dae4e3c65018392dcedc5=
9079a
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 03 Mar 2025 12:11:10 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 08 Mar 2025 14:37:40 +01:00

vdso/gettimeofday: Prepare do_hres_timens() for introduction of struct vdso_c=
lock

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of VDSO clocks. At the moment,
vdso_clock is simply a define which maps vdso_clock to vdso_time_data.

Prepare for the rework of these structures by adding a struct vdso_clock
pointer argument to do_hres_timens(), and replace the struct vdso_time_data
pointer with the new pointer argument where applicable.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250303-vdso-clock-v1-8-c1b5c69a166f@linut=
ronix.de

---
 lib/vdso/gettimeofday.c | 35 ++++++++++++++++++-----------------
 1 file changed, 18 insertions(+), 17 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 15611ab..e8d4b02 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -81,36 +81,36 @@ const struct vdso_time_data *__arch_get_vdso_u_timens_dat=
a(const struct vdso_tim
 }
 #endif /* CONFIG_GENERIC_VDSO_DATA_STORE */
=20
-static __always_inline int do_hres_timens(const struct vdso_time_data *vdns,=
 clockid_t clk,
-					  struct __kernel_timespec *ts)
+static __always_inline
+int do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_cloc=
k *vcns,
+		   clockid_t clk, struct __kernel_timespec *ts)
 {
-	const struct timens_offset *offs =3D &vdns->offset[clk];
+	const struct vdso_time_data *vd =3D __arch_get_vdso_u_timens_data(vdns);
+	const struct timens_offset *offs =3D &vcns->offset[clk];
 	const struct vdso_timestamp *vdso_ts;
-	const struct vdso_time_data *vd;
+	const struct vdso_clock *vc =3D vd;
 	u64 cycles, ns;
 	u32 seq;
 	s64 sec;
=20
-	vd =3D vdns - (clk =3D=3D CLOCK_MONOTONIC_RAW ? CS_RAW : CS_HRES_COARSE);
-	vd =3D __arch_get_vdso_u_timens_data(vd);
 	if (clk !=3D CLOCK_MONOTONIC_RAW)
-		vd =3D &vd[CS_HRES_COARSE];
+		vc =3D &vc[CS_HRES_COARSE];
 	else
-		vd =3D &vd[CS_RAW];
-	vdso_ts =3D &vd->basetime[clk];
+		vc =3D &vc[CS_RAW];
+	vdso_ts =3D &vc->basetime[clk];
=20
 	do {
-		seq =3D vdso_read_begin(vd);
+		seq =3D vdso_read_begin(vc);
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
 	/* Add the namespace offset */
 	sec +=3D offs->sec;
@@ -132,8 +132,9 @@ const struct vdso_time_data *__arch_get_vdso_u_timens_dat=
a(const struct vdso_tim
 	return NULL;
 }
=20
-static __always_inline int do_hres_timens(const struct vdso_time_data *vdns,=
 clockid_t clk,
-					  struct __kernel_timespec *ts)
+static __always_inline
+int do_hres_timens(const struct vdso_time_data *vdns, const struct vdso_cloc=
k *vcns,
+		   clockid_t clk, struct __kernel_timespec *ts)
 {
 	return -EINVAL;
 }
@@ -166,7 +167,7 @@ int do_hres(const struct vdso_time_data *vd, const struct=
 vdso_clock *vc,
 		while (unlikely((seq =3D READ_ONCE(vc->seq)) & 1)) {
 			if (IS_ENABLED(CONFIG_TIME_NS) &&
 			    vc->clock_mode =3D=3D VDSO_CLOCKMODE_TIMENS)
-				return do_hres_timens(vd, clk, ts);
+				return do_hres_timens(vd, vc, clk, ts);
 			cpu_relax();
 		}
 		smp_rmb();

