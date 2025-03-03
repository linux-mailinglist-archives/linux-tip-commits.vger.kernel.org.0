Return-Path: <linux-tip-commits+bounces-3780-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E8096A4BCA9
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 11:44:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E18051889AC4
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 10:44:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7D761F461E;
	Mon,  3 Mar 2025 10:43:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="m+PJZfr6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DVOiTVGh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A830B1F4160;
	Mon,  3 Mar 2025 10:43:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998587; cv=none; b=fv9WZuDUG+YcfDEb6WXu3JINPU5jO3PPYJvXPk6YrW7WJcq8I0yLg2TGMDKNnzrabLh/95pd49HtLw1r6/fSJqlMvoTiv1ADhloPPatTBIxS4eJAZSkPrUlv4mYPPzdvKLDzoRUZ7yH88nW2L55+OWAKupvVACoXp3+wwbf10w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998587; c=relaxed/simple;
	bh=k0OdXl4HQk0w8P5VNwSQBIYmi6N4FqtiCjUSHQ0wnXY=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=dnnlfisu4DEG1HgHBcxhFxBWHPKfBn04qCx0ytL+aqOzEaIarUmE4Rw+YaijEqwvPwlPmCEldEfwnPc6Ws+2/KnsG9E6vm8z2LkKPUdPvVjHCq2tkICAZcK2DoxCC99kP2F968oA6yyyiKnxBfG2dCsrQaCEwtDcrUdPLgRus50=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=m+PJZfr6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DVOiTVGh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 10:43:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740998584;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ckz8AgWoZdoByhAg285OSiAFRKLUT/JkxbsMs1MFNr8=;
	b=m+PJZfr6nKYQ7LUGYFl+akv6F5nLKMe9LH5wSgbP/X5iUw/IMqv365X/v9eherfK/ZmNZL
	kvaOGKa89tLD9zkQLFm5+cEsYIkB7W2N+o+4bTvirhApNHHIO6VILhUDnVshu0j4eSXX9i
	pIHJxZ2QwCXdfcRNQ98SVZusStFz9uchYw7X9F3ttPgpAEf2tMn1L70f1CbNTuSExJjhil
	5394sB0rUNgXLrz+u2C2+fxifi85x+wsqukWt7J+jdA27q5/RT0nIfjmX/5dbLXyK2C2kD
	pQYoW+AJ4F6PlTeOCjjdKydv1YUn8Mst0iVXciVN0smwUNlVxG5hA5XysQAtUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740998584;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ckz8AgWoZdoByhAg285OSiAFRKLUT/JkxbsMs1MFNr8=;
	b=DVOiTVGhlwJWC1SRh0EVVBjdSY8dQVzmKxDlcfuy6G/j3qXyq2GANjUjQ9vRk2hYmXNZA8
	CkABLr4wykzKdsBg==
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
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174099858370.10177.17617144675617119776.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     ad75b1b9dcb534c342e40ab519e8a120248756b3
Gitweb:        https://git.kernel.org/tip/ad75b1b9dcb534c342e40ab519e8a120248=
756b3
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Tue, 25 Feb 2025 13:36:40 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Mar 2025 10:24:34 +01:00

vdso/gettimeofday: Prepare do_hres_timens() for introduction of struct vdso_c=
lock

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of it. By now, vdso_clock is
simply a define which maps vdso_clock to vdso_time_data.

Prepare for the rework of these structures by adding struct vdso_clock
pointer argument to do_hres_timens(), and replace the struct vdso_time_data
pointer with the new pointer arugment whenever applicable.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

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

