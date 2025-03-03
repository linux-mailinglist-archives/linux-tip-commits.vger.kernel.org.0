Return-Path: <linux-tip-commits+bounces-3779-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 05CF5A4BCA8
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 11:44:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F4F16F79F
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 10:43:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCBF81F0E2D;
	Mon,  3 Mar 2025 10:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XKP+nKii";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NmdXOp1H"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 129C51F3D5D;
	Mon,  3 Mar 2025 10:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998586; cv=none; b=VhYmQU9d21WaDyY/cUFE/IR1QU1OV3KCzm5st9tPT3kP4vKWLieuVnr3OC0qIRf9iQoG+oZETNMqnBss0oaLZUHmztuv8uuv3abwkCtQ7CVhTBdQ4qbh7wiD3sSwEGaemfQ2496ddMoAzr9alU3YtF2paAlBWXibNGz2SgbsubI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998586; c=relaxed/simple;
	bh=evGIKXBplhBXuQUZW/9iCjotxyytkfqV9simct+Tx9I=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=LxxCxf2FBNOlfHO62cjzTKf5kTrMAiSqbfttnz5qSLG9lE5Im0m6AbZd8eGmrkQ8Q91cAzazJXY+X2yIP6JR7bZdzIQQYvyQp4afADY8++2r043PjoFF11sxKV3aYCMCpNnqkejdU1+c1omwQwJjkbJky61EM8WPbeZU0XshJoc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XKP+nKii; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NmdXOp1H; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 10:43:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740998583;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=XXboaGh2O3aJZMQ14lMTjZSf+bt0Y43yarIOeKYNnl4=;
	b=XKP+nKiiq+RG7x5znkiVYG8wRMvPaRqAX1RqS7/6IZykCFoJMOX6tY2Z0R0DlQvfx3zgOg
	MOx2FKvWKrNqATp3ZNRHTKeQ1D4KmaLwLmG3zkbREM9UYZ+Zw+CRWFztruZEXcmPhEttgx
	N/40GKSq58xrWjdDoAJe6oQ7hUYqbHdIn0cnKuNJUFUYW4HuNOGDI5mReRtn5Xr0g6ynuT
	ZYelzr7nWZKIoWuo4/gHdXqOnZdMxF61BU4NrwJXnHmQSMCTwblw0zYS5mIq++1vB6BEEM
	axMEN8uii1ya/hZpBq11wP5S4KRBbp6EAQzE86GmZ+6ri1lN9j8BPlkzJiWdoA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740998583;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=XXboaGh2O3aJZMQ14lMTjZSf+bt0Y43yarIOeKYNnl4=;
	b=NmdXOp1HG89AZH1gzteKKdQjviKEvUGKIakZVY60Je7Ve9YxJlF3xFinLMOkqRkjrPh7hE
	SMyeuspqP8d6GTCQ==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso/gettimeofday: Prepare do_coarse_timens() for
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
Message-ID: <174099858278.10177.6142458006481296342.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     631af2c64707236a4e67305e3b25eb59c9be0127
Gitweb:        https://git.kernel.org/tip/631af2c64707236a4e67305e3b25eb59c9b=
e0127
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Tue, 25 Feb 2025 13:36:42 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Mar 2025 10:24:34 +01:00

vdso/gettimeofday: Prepare do_coarse_timens() for introduction of struct vdso=
_clock

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of it. At the moment, vdso_clock
is simply a define which maps vdso_clock to vdso_time_data.

Prepare for the rework of these structures by adding struct vdso_clock
pointer argument to do_coarse_timens(), and replace the struct
vdso_time_data pointer with the new pointer arugment whenever applicable.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 lib/vdso/gettimeofday.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 36ef7de..03fa039 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -193,21 +193,25 @@ int do_hres(const struct vdso_time_data *vd, const stru=
ct vdso_clock *vc,
 }
=20
 #ifdef CONFIG_TIME_NS
-static __always_inline int do_coarse_timens(const struct vdso_time_data *vdn=
s, clockid_t clk,
-					    struct __kernel_timespec *ts)
+static __always_inline
+int do_coarse_timens(const struct vdso_time_data *vdns, const struct vdso_cl=
ock *vcns,
+		     clockid_t clk, struct __kernel_timespec *ts)
 {
 	const struct vdso_time_data *vd =3D __arch_get_vdso_u_timens_data(vdns);
-	const struct vdso_timestamp *vdso_ts =3D &vd->basetime[clk];
-	const struct timens_offset *offs =3D &vdns->offset[clk];
+	const struct timens_offset *offs =3D &vcns->offset[clk];
+	const struct vdso_timestamp *vdso_ts;
+	const struct vdso_clock *vc =3D vd;
 	u64 nsec;
 	s64 sec;
 	s32 seq;
=20
+	vdso_ts =3D &vc->basetime[clk];
+
 	do {
-		seq =3D vdso_read_begin(vd);
+		seq =3D vdso_read_begin(vc);
 		sec =3D vdso_ts->sec;
 		nsec =3D vdso_ts->nsec;
-	} while (unlikely(vdso_read_retry(vd, seq)));
+	} while (unlikely(vdso_read_retry(vc, seq)));
=20
 	/* Add the namespace offset */
 	sec +=3D offs->sec;
@@ -222,8 +226,9 @@ static __always_inline int do_coarse_timens(const struct =
vdso_time_data *vdns, c
 	return 0;
 }
 #else
-static __always_inline int do_coarse_timens(const struct vdso_time_data *vdn=
s, clockid_t clk,
-					    struct __kernel_timespec *ts)
+static __always_inline
+int do_coarse_timens(const struct vdso_time_data *vdns, const struct vdso_cl=
ock *vcns,
+		     clockid_t clk, struct __kernel_timespec *ts)
 {
 	return -1;
 }
@@ -244,7 +249,7 @@ int do_coarse(const struct vdso_time_data *vd, const stru=
ct vdso_clock *vc,
 		while ((seq =3D READ_ONCE(vc->seq)) & 1) {
 			if (IS_ENABLED(CONFIG_TIME_NS) &&
 			    vc->clock_mode =3D=3D VDSO_CLOCKMODE_TIMENS)
-				return do_coarse_timens(vc, clk, ts);
+				return do_coarse_timens(vd, vc, clk, ts);
 			cpu_relax();
 		}
 		smp_rmb();

