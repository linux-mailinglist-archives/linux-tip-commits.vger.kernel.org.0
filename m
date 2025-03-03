Return-Path: <linux-tip-commits+bounces-3777-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1CF5A4BCA4
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 11:43:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C1051170087
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 10:43:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 173D81F4178;
	Mon,  3 Mar 2025 10:43:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lJN1DKRQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0TSR6rLS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55CA91F3BB0;
	Mon,  3 Mar 2025 10:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998585; cv=none; b=B+9RYvecGwNOPqgvHucT0YKOg6EU9Y5HUXGHq/wE50uMvEhmNjmzCvbTwAE43IWqlAqoXP+j1g18QoMXoASvOPw0jO5QCj07Ebq6M4De7wergqodz9b699n7b8mox6xzq4B+ekQH2NVz6go5NVyY/EvR4a7P0c2LxdY6Y5KCTDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998585; c=relaxed/simple;
	bh=0iXcj3w7kuOfPBrDXCuIj03rW4UMIz6PqoWqBsdMcZs=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=UvYqBOO8XFLdADvi+MtG3IKl5QdHlue/OrBRd9v1cg7UxRUv9B9DFzizCDc1JLaOjnOBGIBe0dng8S0au1CRcyGh8XZ8Ic0PaO4IRERAfJaqLoxAN1k/ERu5lJ6kWHY2k+Q2HapXaoA+f1LKaBD1Y9aKk1lzBAOetelsyNw/L3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lJN1DKRQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0TSR6rLS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 10:43:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740998583;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=65GNV2vslYJGY5z6SYgig+/L0fS8pCjoNpr5VrnwIm8=;
	b=lJN1DKRQqLudbTP+8DlCjH0pOR44sLynzPbinCXVPWAPWfZ0tWj803LzgGRiaPaZo3uf19
	VMFO8EXYKOvTHnsvy5Cb0NG2ZAhxj1VXdE2hQpXqvALWHMWlSET7EUPt1Y6A0AtXEw45rq
	LhtdDXjJRL8rnkDlh4OVYyVzfLT8bAkLuLrI8shwz5Ibt50YkuYFirb1qWXE91QvZFIhm+
	r93Op1oIX5qN7tqj8ObNeUm3kRDRvU6H0nzXq70ZPPdLVOYq3MfNM/v4EX/909g3beOs2P
	gdpv7tl6rYc5pGuzf4NV+IiXXuGyYHTZVNtuc91hwvicpb8VHdSmUFRxTNZ19g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740998583;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=65GNV2vslYJGY5z6SYgig+/L0fS8pCjoNpr5VrnwIm8=;
	b=0TSR6rLS1N3JsT6hDI9ePv3LRfNCQzBf8faUpRRBw4vX/3c5gZtIst1OveeFMDzhiJ7Enp
	YbbB8OGWDi57TkCg==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso/gettimeofday: Prepare helper functions for
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
Message-ID: <174099858229.10177.3892068567359933887.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     2c6ebcd38275db332298c87ef19359ea7c51e71e
Gitweb:        https://git.kernel.org/tip/2c6ebcd38275db332298c87ef19359ea7c5=
1e71e
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Tue, 25 Feb 2025 13:36:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Mar 2025 10:24:34 +01:00

vdso/gettimeofday: Prepare helper functions for introduction of struct vdso_c=
lock

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of it. By now, vdso_clock is
simply a define which maps vdso_clock to vdso_time_data.

To prepare for the rework of the data structures, replace the struct
vdso_time_data pointer argument of the helper functions with struct
vdso_clock pointer if applicable.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 lib/vdso/gettimeofday.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index 03fa039..c6ff693 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -17,12 +17,12 @@
 #endif
=20
 #ifdef CONFIG_GENERIC_VDSO_OVERFLOW_PROTECT
-static __always_inline bool vdso_delta_ok(const struct vdso_time_data *vd, u=
64 delta)
+static __always_inline bool vdso_delta_ok(const struct vdso_clock *vc, u64 d=
elta)
 {
-	return delta < vd->max_cycles;
+	return delta < vc->max_cycles;
 }
 #else
-static __always_inline bool vdso_delta_ok(const struct vdso_time_data *vd, u=
64 delta)
+static __always_inline bool vdso_delta_ok(const struct vdso_clock *vc, u64 d=
elta)
 {
 	return true;
 }
@@ -39,14 +39,14 @@ static __always_inline u64 vdso_shift_ns(u64 ns, u32 shif=
t)
  * Default implementation which works for all sane clocksources. That
  * obviously excludes x86/TSC.
  */
-static __always_inline u64 vdso_calc_ns(const struct vdso_time_data *vd, u64=
 cycles, u64 base)
+static __always_inline u64 vdso_calc_ns(const struct vdso_clock *vc, u64 cyc=
les, u64 base)
 {
-	u64 delta =3D (cycles - vd->cycle_last) & VDSO_DELTA_MASK(vd);
+	u64 delta =3D (cycles - vc->cycle_last) & VDSO_DELTA_MASK(vc);
=20
-	if (likely(vdso_delta_ok(vd, delta)))
-		return vdso_shift_ns((delta * vd->mult) + base, vd->shift);
+	if (likely(vdso_delta_ok(vc, delta)))
+		return vdso_shift_ns((delta * vc->mult) + base, vc->shift);
=20
-	return mul_u64_u32_add_u64_shr(delta, vd->mult, base, vd->shift);
+	return mul_u64_u32_add_u64_shr(delta, vc->mult, base, vc->shift);
 }
 #endif /* vdso_calc_ns */
=20
@@ -58,9 +58,9 @@ static inline bool __arch_vdso_hres_capable(void)
 #endif
=20
 #ifndef vdso_clocksource_ok
-static inline bool vdso_clocksource_ok(const struct vdso_time_data *vd)
+static inline bool vdso_clocksource_ok(const struct vdso_clock *vc)
 {
-	return vd->clock_mode !=3D VDSO_CLOCKMODE_NONE;
+	return vc->clock_mode !=3D VDSO_CLOCKMODE_NONE;
 }
 #endif
=20

