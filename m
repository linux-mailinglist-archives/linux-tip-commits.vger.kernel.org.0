Return-Path: <linux-tip-commits+bounces-3774-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A2EA4BCA2
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 11:43:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C12237A5A9D
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 10:42:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 60AAB1F3BB4;
	Mon,  3 Mar 2025 10:43:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yaj5pg2T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gRtmheDB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A90AD1F193D;
	Mon,  3 Mar 2025 10:43:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740998584; cv=none; b=rp3oyht9tOb7DeWnt6S8Rt32UY1STCfyMCslYQStOhps/TvAEdOUbn+oYfvKrVM9WvzCIt7Ly0d74G+4mf8wkqyvT0tsQ0uptp0xN7Dnte1dZQWhol31aKSSgQ6i7G9E4bzxPGUIP/bItWrTTTWaY4XU33cAPMFSwQGKiO5ug1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740998584; c=relaxed/simple;
	bh=mxyZVd7nIEijL2eG0FKInZ0P9b7LdOz3OpKaFibeUE4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=el2fv8a8l9z+6mPg7+2BPFmiJCdup80oiMTMPdXrVguadYbDaU2GWIgIU+j58Dh98gZdShw3POEHqIlfUr4cGI77Ty6ly8UxGNbzQ25qraXLCMH7OStAIOOY5yiJ4M2DMEmNm2xG8q+cG0HE5oUBmio1FVejtQ2AI1AFltAtU0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yaj5pg2T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gRtmheDB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 10:43:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740998581;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=KX+QLi6BhwGucTHJFBz56g75yUkwLoz4X2Ka/L1X300=;
	b=yaj5pg2TYmtFToB8fCdZCMrZkKlBB6bhfAIXWeB/G8Fva8ThWow0S2yJ4vCZIhlNZv7hFw
	qasMgEUEfXGS+40n81Ht911FCKz1zSiCveJ8MelK1Fy1xSJkfOttH5ks4PYw46H2IeRAWf
	aEa4tdXEGCZMz/Dxs6e83IBsvCMZFC/3SRlwbcsJcCL7+haBpmSz32ahAxNJ2Tjm62gbrS
	mI2QI/wzBlhDqXALzlu0wRz5MygtXnbYrVN6PDiK8ilqYMcrL1XEUhyMUfLg9Wt6Q4LC/y
	xrfb7mAitoZ6RzWTbHpC9+DmE25s8f7jO1jPgNexhV/9mE0vpM/Ojjqzw+/WNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740998581;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=KX+QLi6BhwGucTHJFBz56g75yUkwLoz4X2Ka/L1X300=;
	b=gRtmheDBWahPS8GGBL7UEXoCy14utsZ3T93Q6WWVEu26h3eN6tm4dJh1oMJpbLhg7bC7Pv
	KrT7/ADM43fxcAAw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/vdso] x86/vdso: Prepare introduction of struct vdso_clock
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
Message-ID: <174099858044.10177.3741699587914529923.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     30379f9af4108d554af5f3c600a2207dfb783e0e
Gitweb:        https://git.kernel.org/tip/30379f9af4108d554af5f3c600a2207dfb7=
83e0e
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Tue, 25 Feb 2025 13:36:47 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Mar 2025 10:24:35 +01:00

x86/vdso: Prepare introduction of struct vdso_clock

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of it. By now, vdso_clock is
simply a define which maps vdso_clock to vdso_time_data.

To prepare for the rework of the data structures, replace the struct
vdso_time_data pointer with struct vdso_clock pointer whenever applicable.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/x86/include/asm/vdso/gettimeofday.h | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/=
vdso/gettimeofday.h
index edec796..9e52cc4 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -261,7 +261,7 @@ static inline u64 __arch_get_hw_counter(s32 clock_mode,
 	return U64_MAX;
 }
=20
-static inline bool arch_vdso_clocksource_ok(const struct vdso_time_data *vd)
+static inline bool arch_vdso_clocksource_ok(const struct vdso_clock *vc)
 {
 	return true;
 }
@@ -300,34 +300,34 @@ static inline bool arch_vdso_cycles_ok(u64 cycles)
  * declares everything with the MSB/Sign-bit set as invalid. Therefore the
  * effective mask is S64_MAX.
  */
-static __always_inline u64 vdso_calc_ns(const struct vdso_time_data *vd, u64=
 cycles, u64 base)
+static __always_inline u64 vdso_calc_ns(const struct vdso_clock *vc, u64 cyc=
les, u64 base)
 {
-	u64 delta =3D cycles - vd->cycle_last;
+	u64 delta =3D cycles - vc->cycle_last;
=20
 	/*
 	 * Negative motion and deltas which can cause multiplication
 	 * overflow require special treatment. This check covers both as
-	 * negative motion is guaranteed to be greater than @vd::max_cycles
+	 * negative motion is guaranteed to be greater than @vc::max_cycles
 	 * due to unsigned comparison.
 	 *
 	 * Due to the MSB/Sign-bit being used as invalid marker (see
 	 * arch_vdso_cycles_ok() above), the effective mask is S64_MAX, but that
 	 * case is also unlikely and will also take the unlikely path here.
 	 */
-	if (unlikely(delta > vd->max_cycles)) {
+	if (unlikely(delta > vc->max_cycles)) {
 		/*
 		 * Due to the above mentioned TSC wobbles, filter out
 		 * negative motion.  Per the above masking, the effective
 		 * sign bit is now bit 62.
 		 */
 		if (delta & (1ULL << 62))
-			return base >> vd->shift;
+			return base >> vc->shift;
=20
 		/* Handle multiplication overflow gracefully */
-		return mul_u64_u32_add_u64_shr(delta & S64_MAX, vd->mult, base, vd->shift);
+		return mul_u64_u32_add_u64_shr(delta & S64_MAX, vc->mult, base, vc->shift);
 	}
=20
-	return ((delta * vd->mult) + base) >> vd->shift;
+	return ((delta * vc->mult) + base) >> vc->shift;
 }
 #define vdso_calc_ns vdso_calc_ns
=20

