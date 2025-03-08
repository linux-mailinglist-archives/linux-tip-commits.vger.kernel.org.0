Return-Path: <linux-tip-commits+bounces-4081-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D0862A57AA8
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 14:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51EE61890052
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 13:46:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B00DC1B3952;
	Sat,  8 Mar 2025 13:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BlvMtebb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Orf2WRws"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D344C1DDC29;
	Sat,  8 Mar 2025 13:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741441505; cv=none; b=pbytng618kNlgnRw2D602aPocM+lB2Iwcs0/JE6D8k75WCxM7+xX0lBRL9xcZO4B8iShgP085k+EiC50Jor3m7s7VVyYx3/Vg1m1hKIziE6U3kySLmkZpPUwT0VaQTtiHL+y3v4xrvf/CqV8q5ebsKN78AY2Fjs/5mu7kVe4b2I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741441505; c=relaxed/simple;
	bh=rCdJ3PwQfYVkOChN7C8AWLB+3Qm+UFN0N8f25qz2VLQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GBDZRBYruXIE3vZVaHtAUDmEvhK3BRLMTlwFymOmdX5lgofWH1ywpNB7Uf1LtuuaYIhzrsOT+Nkadqpj2gpOeAquDopLeOxl1QiHstTYjUWPUNqABiniAYqopOOXwnsYHBmVhO9JKfFHTIcYMWYOb2wxnDew2mGmI60nLbFwgyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BlvMtebb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Orf2WRws; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 08 Mar 2025 13:45:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741441502;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ktqI9YHvugNdcu/6CBOXAE8yQqhTj6XQqDqXdZxqq8=;
	b=BlvMtebb8Z7zx8HAbhRluVi6qnG6Rz/MQa6sTLhEFTZRdExfg96sUOpPfwW37oWKtdIlz7
	rUakw9mYwMYfvfHG2mtXEhxZjfqWnl/3ut3UC4wTtrEDsaL/GIcF0eSWegyuZ60+MziorS
	diOtB/nTYVpguygA2UTfhYtnADGcH5B7SQ4D/lYUsG7FkacLvBGi9nj+Xbq9OG8hE1BzDo
	a91qxmQ5TfHoZuwUBUQXBj0DxO4gVsxoMtHQE29FLNKOudJI8QjU2pKR+4d7QmuyI6A2w4
	eYawGhh6vulrnO2aMFBd8HvVX8p5hsROOwr4eO0NwIJoWlDqA2FGz/5y7Hqh+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741441502;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8ktqI9YHvugNdcu/6CBOXAE8yQqhTj6XQqDqXdZxqq8=;
	b=Orf2WRws6OBzow81QWf23IE6BcbcCua7pf9puEDKxFRowfZm+J18QA7uYp320CYKo++3yP
	83caAsTQip8/CdDQ==
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
In-Reply-To: <20250303-vdso-clock-v1-9-c1b5c69a166f@linutronix.de>
References: <20250303-vdso-clock-v1-9-c1b5c69a166f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174144150162.14745.18433519801705418476.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     70067ae181f302990002aa9f54e2b8503cde7160
Gitweb:        https://git.kernel.org/tip/70067ae181f302990002aa9f54e2b8503cd=
e7160
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 03 Mar 2025 12:11:11 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 08 Mar 2025 14:37:40 +01:00

vdso/gettimeofday: Prepare do_coarse() for introduction of struct vdso_clock

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of VDSO clocks. At the moment,
vdso_clock is simply a define which maps vdso_clock to vdso_time_data.

Prepare for the rework of these structures by adding a struct vdso_clock
pointer argument to do_coarse(), and replace the struct vdso_time_data
pointer with the new pointer argument where applicable.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250303-vdso-clock-v1-9-c1b5c69a166f@linut=
ronix.de

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

