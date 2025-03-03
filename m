Return-Path: <linux-tip-commits+bounces-3932-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF248A4E229
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 16:03:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8A0873B24F2
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 14:48:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AFF22253F2A;
	Tue,  4 Mar 2025 14:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dRdy2M1X";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ATeWWOye"
Received: from beeline1.cc.itu.edu.tr (beeline1.cc.itu.edu.tr [160.75.25.115])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB5782063E1
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 14:47:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.115
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741099641; cv=pass; b=PAv3auB2qdVQadba90bBk1LONkY3YClic3gtYGbZ+REnpG9gYYpE90wYqdzRbIQzYYCITA+JSNbDJVNsG4+n8oPvk2kFKvETuHn/ClREUjL/l6W2YcQbPH3p/Zm5UrwT1u4ZDHBCbi/OxHJcczACZF1WRbuS9jHRR9pY8imMokY=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741099641; c=relaxed/simple;
	bh=SPDJiRpOX/jkkeykXAH5DN/eAeSeiz9V5gueUMDzbfU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=ICs8/dtwp3mCFG9wHIwS/WLYqTPAkEcMfPXTPxAU1ZwA6L5oVuEW+MfbMdhhGon8MFBO0fV1pT60aJgOk8ht6L0hovg0/3Oivx1YMfV2hdbhMfE1SAf3gQmi0EydpQdHTkCGia1UvQTCqQOrCQyp7orIdGA3zNrzaM3v6I5Dl4A=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dRdy2M1X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ATeWWOye; arc=none smtp.client-ip=193.142.43.55; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; arc=pass smtp.client-ip=160.75.25.115
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline1.cc.itu.edu.tr (Postfix) with ESMTPS id 5C35440D205F
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 17:47:17 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=dRdy2M1X;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=ATeWWOye
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6dl0011QzFxXT
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 17:45:16 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 3AA804273A; Tue,  4 Mar 2025 17:45:08 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dRdy2M1X;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ATeWWOye
X-Envelope-From: <linux-kernel+bounces-541404-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dRdy2M1X;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ATeWWOye
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 2FC74428D8
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:44:31 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw2.itu.edu.tr (Postfix) with SMTP id BAB0D2DCDE
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:44:30 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0595F16F2B2
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:44:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CD21C1F4623;
	Mon,  3 Mar 2025 10:43:07 +0000 (UTC)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21AB64A05;
	Mon,  3 Mar 2025 10:42:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998582; cv=none; b=GVQlnMds3663VYRfOzorqImWBsR1hHoJA7NenmQBCXF6cOXXdDDH30MoNa76g61mGEg0vmxfIuhS2cq/RStkpdKasQq37in35K6N68gMHNYtdCCdfErLugz+AiGA7iLyp0FvNmuAZI9x2xgYcqcBObSCjgSU/mc/6a7KRWoRFos=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998582; c=relaxed/simple;
	bh=SPDJiRpOX/jkkeykXAH5DN/eAeSeiz9V5gueUMDzbfU=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=QghvDaWVf0/H8xUg7yTeaCkVx4T+XT5LjegKjvmK2Xo0rUfZxQGs4Xo0xcdXOVUGMgb8cxydLAZQrxEkT+8oj3MpZCGWOlUuXoqYRTN+lXqlu2BSjSu6UdtMQRWlEtB/+Uz7wBrf0tCByPnRjjW2FTnT1ihTbVfjCVlSXrUtB54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dRdy2M1X; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ATeWWOye; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 10:42:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740998578;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=HWcBsem/FRvXzEKF+Erf6sHWpt7WRbx6/B7rFamrD64=;
	b=dRdy2M1XbASYLTNiCKozsLtpl1h2FTxnFEaBHupp6RcVPt90rqE9Qofq6lflORNbT5N4AM
	4fDxSOoNUKQFYl3y/YPS8n9n+eGcVDiJyaf7BI8xYTNsFOHl1P8gGsreE/ycg3HHbs9EN6
	2KOAzdN9pzayrnV24lm1swWgLx7qVIpNdSbJNklU1kHJY3gCbjpR8PnLPru2ZvnJzJLkwp
	EOeStLwB/8L7mDs5jWWN1ngbr7hYsvwgBcn3yiDHVIqzrHvlYSr0RXAJTNsNl0CHeYBGMu
	fSvj5+/oDGjK+vlqMoUZ6dBkeAYCdFOfDhSDrs3EXGrR4GwRdsXwndaz9nac+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740998578;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=HWcBsem/FRvXzEKF+Erf6sHWpt7WRbx6/B7rFamrD64=;
	b=ATeWWOyenV6O1bRr2cWHp5Al4GZCvcreMZaOwda/mprmc/MLSI/95JiZ9lYeXRVx4IdX3w
	OQMgqvPeyBq7TeCg==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso: Rework struct vdso_time_data and introduce
 struct vdso_clock
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
Message-ID: <174099857739.10177.17940196485204054084.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6dl0011QzFxXT
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741704326.48395@Kg68cbD1dCFFhT0J+JWctQ
X-ITU-MailScanner-SpamCheck: not spam

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     9882ccb7c589303083111669cda1957b186e056e
Gitweb:        https://git.kernel.org/tip/9882ccb7c589303083111669cda1957b186=
e056e
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Tue, 25 Feb 2025 13:36:51 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Mar 2025 10:24:35 +01:00

vdso: Rework struct vdso_time_data and introduce struct vdso_clock

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be an array of it.

Now all preparation is in place: Split the clock related struct members
into a separate struct vdso_clock. Make sure all users are aware, that
vdso_time_data is no longer initialized as an array and vdso_clock is now
the array inside vdso_data. Remove also the define of vdso_clock which made
preparation possible in smaller steps.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/arm64/include/asm/vdso/compat_gettimeofday.h |  2 +-
 arch/arm64/include/asm/vdso/vsyscall.h            |  4 +-
 arch/s390/kernel/time.c                           | 11 +---
 include/asm-generic/vdso/vsyscall.h               |  2 +-
 include/vdso/datapage.h                           | 47 ++++++++------
 include/vdso/helpers.h                            |  4 +-
 kernel/time/namespace.c                           |  2 +-
 kernel/time/vsyscall.c                            | 11 +--
 lib/vdso/datastore.c                              |  4 +-
 lib/vdso/gettimeofday.c                           | 16 ++---
 10 files changed, 53 insertions(+), 50 deletions(-)

diff --git a/arch/arm64/include/asm/vdso/compat_gettimeofday.h b/arch/arm64/i=
nclude/asm/vdso/compat_gettimeofday.h
index 2c6b90d..d60ea7a 100644
--- a/arch/arm64/include/asm/vdso/compat_gettimeofday.h
+++ b/arch/arm64/include/asm/vdso/compat_gettimeofday.h
@@ -149,7 +149,7 @@ static __always_inline const struct vdso_time_data *__arc=
h_get_vdso_u_time_data(
 	 * where __aarch64_get_vdso_u_time_data() is called, and then keep the
 	 * result in a register.
 	 */
-	asm volatile("mov %0, %1" : "=3Dr"(ret) : "r"(vdso_u_time_data));
+	asm volatile("mov %0, %1" : "=3Dr"(ret) : "r"(&vdso_u_time_data));
=20
 	return ret;
 }
diff --git a/arch/arm64/include/asm/vdso/vsyscall.h b/arch/arm64/include/asm/=
vdso/vsyscall.h
index 3f65cbd..de58951 100644
--- a/arch/arm64/include/asm/vdso/vsyscall.h
+++ b/arch/arm64/include/asm/vdso/vsyscall.h
@@ -15,8 +15,8 @@
 static __always_inline
 void __arm64_update_vsyscall(struct vdso_time_data *vdata)
 {
-	vdata[CS_HRES_COARSE].mask	=3D VDSO_PRECISION_MASK;
-	vdata[CS_RAW].mask		=3D VDSO_PRECISION_MASK;
+	vdata->clock_data[CS_HRES_COARSE].mask	=3D VDSO_PRECISION_MASK;
+	vdata->clock_data[CS_RAW].mask		=3D VDSO_PRECISION_MASK;
 }
 #define __arch_update_vsyscall __arm64_update_vsyscall
=20
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index 41ca358..699a18f 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -79,12 +79,10 @@ void __init time_early_init(void)
 {
 	struct ptff_qto qto;
 	struct ptff_qui qui;
-	int cs;
=20
 	/* Initialize TOD steering parameters */
 	tod_steering_end =3D tod_clock_base.tod;
-	for (cs =3D 0; cs < CS_BASES; cs++)
-		vdso_k_time_data[cs].arch_data.tod_steering_end =3D tod_steering_end;
+	vdso_k_time_data->arch_data.tod_steering_end =3D tod_steering_end;
=20
 	if (!test_facility(28))
 		return;
@@ -373,7 +371,6 @@ static void clock_sync_global(long delta)
 {
 	unsigned long now, adj;
 	struct ptff_qto qto;
-	int cs;
=20
 	/* Fixup the monotonic sched clock. */
 	tod_clock_base.eitod +=3D delta;
@@ -389,10 +386,8 @@ static void clock_sync_global(long delta)
 		panic("TOD clock sync offset %li is too large to drift\n",
 		      tod_steering_delta);
 	tod_steering_end =3D now + (abs(tod_steering_delta) << 15);
-	for (cs =3D 0; cs < CS_BASES; cs++) {
-		vdso_k_time_data[cs].arch_data.tod_steering_end =3D tod_steering_end;
-		vdso_k_time_data[cs].arch_data.tod_steering_delta =3D tod_steering_delta;
-	}
+	vdso_k_time_data->arch_data.tod_steering_end =3D tod_steering_end;
+	vdso_k_time_data->arch_data.tod_steering_delta =3D tod_steering_delta;
=20
 	/* Update LPAR offset. */
 	if (ptff_query(PTFF_QTO) && ptff(&qto, sizeof(qto), PTFF_QTO) =3D=3D 0)
diff --git a/include/asm-generic/vdso/vsyscall.h b/include/asm-generic/vdso/v=
syscall.h
index 1fb3000..b550afa 100644
--- a/include/asm-generic/vdso/vsyscall.h
+++ b/include/asm-generic/vdso/vsyscall.h
@@ -9,7 +9,7 @@
 #ifndef __arch_get_vdso_u_time_data
 static __always_inline const struct vdso_time_data *__arch_get_vdso_u_time_d=
ata(void)
 {
-	return vdso_u_time_data;
+	return &vdso_u_time_data;
 }
 #endif
=20
diff --git a/include/vdso/datapage.h b/include/vdso/datapage.h
index bcd19c2..9e41939 100644
--- a/include/vdso/datapage.h
+++ b/include/vdso/datapage.h
@@ -69,9 +69,7 @@ struct vdso_timestamp {
 };
=20
 /**
- * struct vdso_time_data - vdso datapage representation
- * @arch_data:		architecture specific data (optional, defaults
- *			to an empty struct)
+ * struct vdso_clock - vdso per clocksource datapage representation
  * @seq:		timebase sequence counter
  * @clock_mode:		clock mode
  * @cycle_last:		timebase at clocksource init
@@ -81,17 +79,9 @@ struct vdso_timestamp {
  * @shift:		clocksource shift
  * @basetime[clock_id]:	basetime per clock_id
  * @offset[clock_id]:	time namespace offset per clock_id
- * @tz_minuteswest:	minutes west of Greenwich
- * @tz_dsttime:		type of DST correction
- * @hrtimer_res:	hrtimer resolution
- * @__unused:		unused
- *
- * vdso_time_data will be accessed by 64 bit and compat code at the same time
- * so we should be careful before modifying this structure.
  *
- * The ordering of the struct members is optimized to have fast access to the
- * often required struct members which are related to CLOCK_REALTIME and
- * CLOCK_MONOTONIC. This information is stored in the first cache lines.
+ * See also struct vdso_time_data for basic access and ordering information =
as
+ * struct vdso_clock is used there.
  *
  * @basetime is used to store the base time for the system wide time getter
  * VVAR page.
@@ -104,9 +94,7 @@ struct vdso_timestamp {
  * For clocks which are not affected by time namespace adjustment the
  * offset must be zero.
  */
-struct vdso_time_data {
-	struct arch_vdso_time_data arch_data;
-
+struct vdso_clock {
 	u32			seq;
=20
 	s32			clock_mode;
@@ -122,6 +110,29 @@ struct vdso_time_data {
 		struct vdso_timestamp	basetime[VDSO_BASES];
 		struct timens_offset	offset[VDSO_BASES];
 	};
+};
+
+/**
+ * struct vdso_time_data - vdso datapage representation
+ * @arch_data:		architecture specific data (optional, defaults
+ *			to an empty struct)
+ * @clock_data:		clocksource related data (array)
+ * @tz_minuteswest:	minutes west of Greenwich
+ * @tz_dsttime:		type of DST correction
+ * @hrtimer_res:	hrtimer resolution
+ * @__unused:		unused
+ *
+ * vdso_time_data will be accessed by 64 bit and compat code at the same time
+ * so we should be careful before modifying this structure.
+ *
+ * The ordering of the struct members is optimized to have fast acces to the
+ * often required struct members which are related to CLOCK_REALTIME and
+ * CLOCK_MONOTONIC. This information is stored in the first cache lines.
+ */
+struct vdso_time_data {
+	struct arch_vdso_time_data arch_data;
+
+	struct vdso_clock	clock_data[CS_BASES];
=20
 	s32			tz_minuteswest;
 	s32			tz_dsttime;
@@ -129,8 +140,6 @@ struct vdso_time_data {
 	u32			__unused;
 } ____cacheline_aligned;
=20
-#define vdso_clock vdso_time_data
-
 /**
  * struct vdso_rng_data - vdso RNG state information
  * @generation:	counter representing the number of RNG reseeds
@@ -151,7 +160,7 @@ struct vdso_rng_data {
  * relocation, and this is what we need.
  */
 #ifdef CONFIG_GENERIC_VDSO_DATA_STORE
-extern struct vdso_time_data vdso_u_time_data[CS_BASES] __attribute__((visib=
ility("hidden")));
+extern struct vdso_time_data vdso_u_time_data __attribute__((visibility("hid=
den")));
 extern struct vdso_rng_data vdso_u_rng_data __attribute__((visibility("hidde=
n")));
 extern struct vdso_arch_data vdso_u_arch_data __attribute__((visibility("hid=
den")));
=20
diff --git a/include/vdso/helpers.h b/include/vdso/helpers.h
index 28f0707..0a98fed 100644
--- a/include/vdso/helpers.h
+++ b/include/vdso/helpers.h
@@ -30,7 +30,7 @@ static __always_inline u32 vdso_read_retry(const struct vds=
o_clock *vc,
=20
 static __always_inline void vdso_write_begin(struct vdso_time_data *vd)
 {
-	struct vdso_clock *vc =3D vd;
+	struct vdso_clock *vc =3D vd->clock_data;
=20
 	/*
 	 * WRITE_ONCE() is required otherwise the compiler can validly tear
@@ -44,7 +44,7 @@ static __always_inline void vdso_write_begin(struct vdso_ti=
me_data *vd)
=20
 static __always_inline void vdso_write_end(struct vdso_time_data *vd)
 {
-	struct vdso_clock *vc =3D vd;
+	struct vdso_clock *vc =3D vd->clock_data;
=20
 	smp_wmb();
 	/*
diff --git a/kernel/time/namespace.c b/kernel/time/namespace.c
index 09bc4fb..e364227 100644
--- a/kernel/time/namespace.c
+++ b/kernel/time/namespace.c
@@ -237,7 +237,7 @@ static void timens_set_vvar_page(struct task_struct *task,
=20
 	ns->frozen_offsets =3D true;
 	vdata =3D page_address(ns->vvar_page);
-	vc =3D vdata;
+	vc =3D vdata->clock_data;
=20
 	for (i =3D 0; i < CS_BASES; i++)
 		timens_setup_vdso_clock_data(&vc[i], ns);
diff --git a/kernel/time/vsyscall.c b/kernel/time/vsyscall.c
index dd85b41..01c2ab1 100644
--- a/kernel/time/vsyscall.c
+++ b/kernel/time/vsyscall.c
@@ -17,8 +17,8 @@
=20
 static inline void update_vdso_time_data(struct vdso_time_data *vdata, struc=
t timekeeper *tk)
 {
+	struct vdso_clock *vc =3D vdata->clock_data;
 	struct vdso_timestamp *vdso_ts;
-	struct vdso_clock *vc =3D vdata;
 	u64 nsec, sec;
=20
 	vc[CS_HRES_COARSE].cycle_last	=3D tk->tkr_mono.cycle_last;
@@ -78,8 +78,8 @@ static inline void update_vdso_time_data(struct vdso_time_d=
ata *vdata, struct ti
 void update_vsyscall(struct timekeeper *tk)
 {
 	struct vdso_time_data *vdata =3D vdso_k_time_data;
+	struct vdso_clock *vc =3D vdata->clock_data;
 	struct vdso_timestamp *vdso_ts;
-	struct vdso_clock *vc =3D vdata;
 	s32 clock_mode;
 	u64 nsec;
=20
@@ -109,9 +109,8 @@ void update_vsyscall(struct timekeeper *tk)
=20
 	/*
 	 * Read without the seqlock held by clock_getres().
-	 * Note: No need to have a second copy.
 	 */
-	WRITE_ONCE(vdata[CS_HRES_COARSE].hrtimer_res, hrtimer_resolution);
+	WRITE_ONCE(vdata->hrtimer_res, hrtimer_resolution);
=20
 	/*
 	 * If the current clocksource is not VDSO capable, then spare the
@@ -131,8 +130,8 @@ void update_vsyscall_tz(void)
 {
 	struct vdso_time_data *vdata =3D vdso_k_time_data;
=20
-	vdata[CS_HRES_COARSE].tz_minuteswest =3D sys_tz.tz_minuteswest;
-	vdata[CS_HRES_COARSE].tz_dsttime =3D sys_tz.tz_dsttime;
+	vdata->tz_minuteswest =3D sys_tz.tz_minuteswest;
+	vdata->tz_dsttime =3D sys_tz.tz_dsttime;
=20
 	__arch_sync_vdso_time_data(vdata);
 }
diff --git a/lib/vdso/datastore.c b/lib/vdso/datastore.c
index 4e350f5..c715e21 100644
--- a/lib/vdso/datastore.c
+++ b/lib/vdso/datastore.c
@@ -13,10 +13,10 @@
  */
 #ifdef CONFIG_HAVE_GENERIC_VDSO
 static union {
-	struct vdso_time_data	data[CS_BASES];
+	struct vdso_time_data	data;
 	u8			page[PAGE_SIZE];
 } vdso_time_data_store __page_aligned_data;
-struct vdso_time_data *vdso_k_time_data =3D vdso_time_data_store.data;
+struct vdso_time_data *vdso_k_time_data =3D &vdso_time_data_store.data;
 static_assert(sizeof(vdso_time_data_store) =3D=3D PAGE_SIZE);
 #endif /* CONFIG_HAVE_GENERIC_VDSO */
=20
diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index c6ff693..93ef801 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -87,8 +87,8 @@ int do_hres_timens(const struct vdso_time_data *vdns, const=
 struct vdso_clock *v
 {
 	const struct vdso_time_data *vd =3D __arch_get_vdso_u_timens_data(vdns);
 	const struct timens_offset *offs =3D &vcns->offset[clk];
+	const struct vdso_clock *vc =3D vd->clock_data;
 	const struct vdso_timestamp *vdso_ts;
-	const struct vdso_clock *vc =3D vd;
 	u64 cycles, ns;
 	u32 seq;
 	s64 sec;
@@ -199,8 +199,8 @@ int do_coarse_timens(const struct vdso_time_data *vdns, c=
onst struct vdso_clock=20
 {
 	const struct vdso_time_data *vd =3D __arch_get_vdso_u_timens_data(vdns);
 	const struct timens_offset *offs =3D &vcns->offset[clk];
+	const struct vdso_clock *vc =3D vd->clock_data;
 	const struct vdso_timestamp *vdso_ts;
-	const struct vdso_clock *vc =3D vd;
 	u64 nsec;
 	s64 sec;
 	s32 seq;
@@ -265,7 +265,7 @@ static __always_inline int
 __cvdso_clock_gettime_common(const struct vdso_time_data *vd, clockid_t cloc=
k,
 			     struct __kernel_timespec *ts)
 {
-	const struct vdso_clock *vc =3D vd;
+	const struct vdso_clock *vc =3D vd->clock_data;
 	u32 msk;
=20
 	/* Check for negative values or invalid clocks */
@@ -337,7 +337,7 @@ static __maybe_unused int
 __cvdso_gettimeofday_data(const struct vdso_time_data *vd,
 			  struct __kernel_old_timeval *tv, struct timezone *tz)
 {
-	const struct vdso_clock *vc =3D vd;
+	const struct vdso_clock *vc =3D vd->clock_data;
=20
 	if (likely(tv !=3D NULL)) {
 		struct __kernel_timespec ts;
@@ -371,13 +371,13 @@ __cvdso_gettimeofday(struct __kernel_old_timeval *tv, s=
truct timezone *tz)
 static __maybe_unused __kernel_old_time_t
 __cvdso_time_data(const struct vdso_time_data *vd, __kernel_old_time_t *time)
 {
-	const struct vdso_clock *vc =3D vd;
+	const struct vdso_clock *vc =3D vd->clock_data;
 	__kernel_old_time_t t;
=20
 	if (IS_ENABLED(CONFIG_TIME_NS) &&
 	    vc->clock_mode =3D=3D VDSO_CLOCKMODE_TIMENS) {
 		vd =3D __arch_get_vdso_u_timens_data(vd);
-		vc =3D vd;
+		vc =3D vd->clock_data;
 	}
=20
 	t =3D READ_ONCE(vc[CS_HRES_COARSE].basetime[CLOCK_REALTIME].sec);
@@ -399,7 +399,7 @@ static __maybe_unused
 int __cvdso_clock_getres_common(const struct vdso_time_data *vd, clockid_t c=
lock,
 				struct __kernel_timespec *res)
 {
-	const struct vdso_clock *vc =3D vd;
+	const struct vdso_clock *vc =3D vd->clock_data;
 	u32 msk;
 	u64 ns;
=20
@@ -420,7 +420,7 @@ int __cvdso_clock_getres_common(const struct vdso_time_da=
ta *vd, clockid_t clock
 		/*
 		 * Preserves the behaviour of posix_get_hrtimer_res().
 		 */
-		ns =3D READ_ONCE(vd[CS_HRES_COARSE].hrtimer_res);
+		ns =3D READ_ONCE(vd->hrtimer_res);
 	} else if (msk & VDSO_COARSE) {
 		/*
 		 * Preserves the behaviour of posix_get_coarse_res().


