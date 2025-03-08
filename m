Return-Path: <linux-tip-commits+bounces-4082-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBA6AA57AAA
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 14:46:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E01518903A1
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 13:46:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 23AC11DE3DC;
	Sat,  8 Mar 2025 13:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NcY07k/j";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nlLpt3+N"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C570E1DA116;
	Sat,  8 Mar 2025 13:45:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741441506; cv=none; b=LJQELUKUPhbPIuSAqL9Bevl2Vev221uiJhV0RLA+Njdl3kd6jTPBFzBJKN0P1b62WyUawkWQWKRq2Y2Lhmxq9GHliZXT8FvJxNF1RrLuqe4q9pzDqKg2rbV0nd0npjkpbKXCdJv/zowLpzcmfPWRiErkPpkEKUh7PLkJUPykN4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741441506; c=relaxed/simple;
	bh=ZgjuSqNO98eLHZ/qvPqO06zkeYI7t6DFW2Y9lYbujsI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=e27htjvDt49Ckd5+PzAwcE/bSq6d5MWyU0LvZVxsvMw38TDgW6mHY0Vof4yBRqsy4x60ELx65vk6Y+zpGdrP0Q3avgm2Tk4H6fOzO8tK5DC6s3s/1C5JPANGkC19XQUJIWWlyexZdmqRj63KiC912CFdL9KA3XFifLY7ayqPbeg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NcY07k/j; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nlLpt3+N; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 08 Mar 2025 13:45:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741441501;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dIFo7NJjK96L05j69E9kqhqrjcJuqLR18UMJNSpRwcY=;
	b=NcY07k/j5eaignjVnWpMAC6T5zml5LC4fkn46pejntaC7Cfuys8812aDocOL7tbxqWjKik
	Pc/FzroCwVjfrGszxKYiIyfkxKkPDEbDuYrk83AjnsztulRJxjzGe6bqvKuDd6XiytwY5h
	QffsJVEz10ORip0Ro2neIhCFFHQSRbUx4/GedLfRL9DSbrFamc+NopE0E5nd73qm6IiiCt
	tFmQKjhi9ouwN3ZW2nw4sRgqZezdBPA/k018vwgBOeCH2lX56+f0G4/cgkHUMW7CoLQ6dA
	D1LkCkUDPZ/TehTwQTNvoXcqRLBVNNik5zl0VqhN0o4wtq588Pjyo9y4CEv2Ag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741441501;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dIFo7NJjK96L05j69E9kqhqrjcJuqLR18UMJNSpRwcY=;
	b=nlLpt3+Nct8C740gZQoj0uwrY8MLBID8C+IoFnavHp6F43vTOeXS0eQYEbaEEGbKoy6K2V
	mCpaQxeDqsMljAAQ==
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
In-Reply-To: <20250303-vdso-clock-v1-11-c1b5c69a166f@linutronix.de>
References: <20250303-vdso-clock-v1-11-c1b5c69a166f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174144150071.14745.15574150625285232601.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     80801972a11b4c8610cd403e1f235e98cd799350
Gitweb:        https://git.kernel.org/tip/80801972a11b4c8610cd403e1f235e98cd7=
99350
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 03 Mar 2025 12:11:13 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 08 Mar 2025 14:37:40 +01:00

vdso/gettimeofday: Prepare helper functions for introduction of struct vdso_c=
lock

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of VDSO clocks. At the moment,
vdso_clock is simply a define which maps vdso_clock to vdso_time_data.

To prepare for the rework of the data structures, replace the struct
vdso_time_data pointer argument of the helper functions with struct
vdso_clock pointer where applicable.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250303-vdso-clock-v1-11-c1b5c69a166f@linu=
tronix.de

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

