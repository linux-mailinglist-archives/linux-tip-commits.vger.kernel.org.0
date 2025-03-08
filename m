Return-Path: <linux-tip-commits+bounces-4083-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8F2FA57AAC
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 14:46:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 019BA16D4A2
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 13:46:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EA191E25F7;
	Sat,  8 Mar 2025 13:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YrKX/W93";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0ImiiuBe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6C76F1DD539;
	Sat,  8 Mar 2025 13:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741441506; cv=none; b=KSi3BwnqGoDTsqZHHcs280Nu+iGb7QAkmsEZ1E7tlLKeqWkpJJ0or0JkkN+h0sW8wA+6dithV4OxwYVaGBDkEEfRaEadZmqkn2WPVg0R57K9rG3079xGUxKsB3Tk2umchXBsEGIzcPl6m/99IkJZIyq2ZfCXQzP/4TcGQbciut4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741441506; c=relaxed/simple;
	bh=aZirEZ6KOxkVHU3cXmlWK43NtpTgOvg7k/xbHVT1amw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aaK/oexygCEzEFdj2YxQswjATmhFhC67tvqTYV4XumJfmb4fQF+Wek0ZxCGa95D20iv1mk+JzPX3HTHxxbSCmq8hax/qrIg0JD97A7h31fakVhKBgGpVD1vJYkDAfRvlss8KXWMHTiza6S7YHlit1M5U/8oDyL7etVISGQXawQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YrKX/W93; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0ImiiuBe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 08 Mar 2025 13:45:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741441501;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+QLnflmcGLgtGNebt9hWg7+14+BcOCeLHKZ1myDEkpU=;
	b=YrKX/W93XUs849T0kfDeoMY6ljXaxE4Vcmp8B7BIcchRPpxAlEh/E7c+fZyPECHNnCztM1
	pfsAxrIgejcDaadMK8Wc91Et8K2gUaZvb1xyNKd9hBRWwBDfDW4YM4FnApjVbbf0rxdECT
	he+GUN5bEQ9wAW/uadTQ3Xu/OkNbV3EuVYK4NMrltUIMN4YAxAIOhkJbV31XV44sVcLVx4
	oDHgM+wevniskKGkc1P0f2TB3xnvpFnrwP1Ts5uzJq4jJHcDLQ4tZljdp78vvuo9if4yA0
	skex0KIhkjeASLd30IBx3Ptw6Mi+uA3oXmCKpYsbqaiphTCG+LnheG5Wjd/o+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741441501;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+QLnflmcGLgtGNebt9hWg7+14+BcOCeLHKZ1myDEkpU=;
	b=0ImiiuBe/TBY1QRQpwUQd9qgvQJVIqwhi9hPF1C91asFqzi7XnPBP73SaaYSSE7JfXp4jW
	hcmI50M/ATuUNiBQ==
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
In-Reply-To: <20250303-vdso-clock-v1-10-c1b5c69a166f@linutronix.de>
References: <20250303-vdso-clock-v1-10-c1b5c69a166f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174144150114.14745.3933094187213972716.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     8c3f5cb3d33bee748b0408418d0d2a627586a2b5
Gitweb:        https://git.kernel.org/tip/8c3f5cb3d33bee748b0408418d0d2a62758=
6a2b5
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 03 Mar 2025 12:11:12 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 08 Mar 2025 14:37:40 +01:00

vdso/gettimeofday: Prepare do_coarse_timens() for introduction of struct vdso=
_clock

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of VDSO clocks. At the moment,
vdso_clock is simply a define which maps vdso_clock to vdso_time_data.

Prepare for the rework of these structures by adding a struct vdso_clock
pointer argument to do_coarse_time_ns(), and replace the struct
vdso_time_data pointer with the new pointer argument where applicable.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250303-vdso-clock-v1-10-c1b5c69a166f@linu=
tronix.de

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

