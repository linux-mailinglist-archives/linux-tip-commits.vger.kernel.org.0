Return-Path: <linux-tip-commits+bounces-6010-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA2D2AFACC3
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Jul 2025 09:12:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C68CA3AD589
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Jul 2025 07:11:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFEAA28688D;
	Mon,  7 Jul 2025 07:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XdQXk2cd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/G6czWOk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CF59285C8B;
	Mon,  7 Jul 2025 07:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751872308; cv=none; b=V5BeyzPPtIEtRRBDWZJEn2DFyoxSFyX6tj5nXVIy++ugIvEmAM5BSGtW+OShE6CUIOHkmk5luwePQnceK3moiyjEBIKLUC1i5BuZePFIkBdEK/AWGrD2xaw7IWsMVs2M1RtSRClhqKZRkaKqou57aVkKAOK0x8oVOcorV0gXce8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751872308; c=relaxed/simple;
	bh=0ZjqVaohRemydvEt1Os+q3q5Ai4LwHTqtt9/oamX2Tc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=clWAM3YcnBDA0T7MPs6c2ixcfbvCgYbTAbLu97Opys466uSVvd7SPoUf+h//TpMR+LQgNLl61Wndhjk9L9Jo2X4+7CcYx9rtIGBNXM3cwe2cuIk1dP0v4nTIxZwfvtzpdBxaORwDrq7hmFxncHg1piCB2nvrSMbjYssx9oXCiPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XdQXk2cd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/G6czWOk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Jul 2025 07:11:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751872305;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+XGnfLmY/sNZny+C+We8hnUgVmmyLtoW0b3+4hZ6rJ4=;
	b=XdQXk2cdkfh9365EzLZtbH7Cz68DzFyosnjN+4DI63bjk1lRJ0HkKYaniYkPXlDHvGDLsE
	cxOUN8KVj0lXJrELfV9sJgSxpXDMFl0uXKPna03HS3Gn2sq1wJJ2xSt3s1zvK9pEA09zo9
	vavd7aBOjpOJqEAXII61d+SSVyGXNqEmgRu6LwU6/jtHljM5iaBgjB0LE6yc0MDgburqsI
	oU7PY1MEKVXVb44Ovea+RJL5wX9MhG5HzOKjaj1XKakYsukxJMfd+HO8e0YOqpmKymM3jG
	FVrlXRVnz5EfISD1Hc/aMQDxt+7LaxUDlncjPtNkKUjqADxK9r4UmB6nUKGGWQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751872305;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+XGnfLmY/sNZny+C+We8hnUgVmmyLtoW0b3+4hZ6rJ4=;
	b=/G6czWOkJHd/cqSbQT+gYBkbEwE5fxeiE6D7m0J3e1zUVt/mYrbv6YYYHUJIRBriMHLZCX
	TwGtnORvaBAGWxBw==
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
Message-ID: <175187230436.406.11047812773609695761.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     6e14fcf095e99d1ed882e8ecfb668dc6d7f5e720
Gitweb:        https://git.kernel.org/tip/6e14fcf095e99d1ed882e8ecfb668dc6d7f=
5e720
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 01 Jul 2025 10:58:03 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 07 Jul 2025 08:58:53 +02:00

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
index 50611ba..c383878 100644
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

