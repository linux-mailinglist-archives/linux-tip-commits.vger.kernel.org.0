Return-Path: <linux-tip-commits+bounces-3946-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F970A4E914
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 18:35:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4497E7A5F56
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 17:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BE66D2E336D;
	Tue,  4 Mar 2025 17:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yaj5pg2T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gRtmheDB"
Received: from beeline2.cc.itu.edu.tr (beeline2.cc.itu.edu.tr [160.75.25.116])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 297672E337C
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 17:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=160.75.25.116
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741107970; cv=pass; b=oCCLhIIEYgxNx8iwo5DSuzlqV+SPATg4ERZGeJc5C1BGKsW0ziwCf3iO2F2zH/HKdxpJFA7oFT2hUNLZ2EsWH6YEQRhH2/2TFE8FYliWGS2PBkhFBGgTxdTzl1ely3CrFwj0tyuZLBJ3YjAO1fPY5yUdUpqsNBvB4/WB+UVhF64=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741107970; c=relaxed/simple;
	bh=mxyZVd7nIEijL2eG0FKInZ0P9b7LdOz3OpKaFibeUE4=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=NMpkqyXO4OPsVYQpg+2B7UYZlymnXaw9J4a+CeJLfpWaktkrOgh2LpVx22XkQZ4Fdro4ih8srV2z7YUhcaV2ACnyNXgMytDZaru9XAvX2b8DMl+IC6UF/vxbpIVFEnT8FUc59TzlL3gLCTaMCGCKCkXLAaEQuhd40yXuSdLx3JE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=none smtp.mailfrom=cc.itu.edu.tr; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yaj5pg2T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gRtmheDB; arc=none smtp.client-ip=193.142.43.55; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; arc=pass smtp.client-ip=160.75.25.116
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=cc.itu.edu.tr
Received: from lesvatest1.cc.itu.edu.tr (lesvatest1.cc.itu.edu.tr [10.146.128.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits))
	(No client certificate requested)
	by beeline2.cc.itu.edu.tr (Postfix) with ESMTPS id 5C055408B640
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 20:06:07 +0300 (+03)
X-Envelope-From: <root@cc.itu.edu.tr>
Authentication-Results: lesvatest1.cc.itu.edu.tr;
	dkim=pass (2048-bit key, unprotected) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=yaj5pg2T;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=gRtmheDB
Received: from lesva1.cc.itu.edu.tr (unknown [160.75.70.79])
	by lesvatest1.cc.itu.edu.tr (Postfix) with ESMTP id 4Z6fqN5rPjzG0QT
	for <linux-tip-commits@vger.kernel.org>; Tue,  4 Mar 2025 18:34:08 +0300 (+03)
Received: by le1 (Postfix, from userid 0)
	id 5E55E4271F; Tue,  4 Mar 2025 18:34:08 +0300 (+03)
Authentication-Results: lesva1.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yaj5pg2T;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gRtmheDB
X-Envelope-From: <linux-kernel+bounces-541408-bozkiru=itu.edu.tr@vger.kernel.org>
Authentication-Results: lesva2.cc.itu.edu.tr;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yaj5pg2T;
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gRtmheDB
Received: from fgw2.itu.edu.tr (fgw2.itu.edu.tr [160.75.25.104])
	by le2 (Postfix) with ESMTP id 7DBB44231A
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:44:25 +0300 (+03)
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by fgw2.itu.edu.tr (Postfix) with SMTP id 316F42DCE1
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 13:44:25 +0300 (+03)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF66F170AAB
	for <bozkiru@itu.edu.tr>; Mon,  3 Mar 2025 10:44:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94E181F1531;
	Mon,  3 Mar 2025 10:43:07 +0000 (UTC)
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
X-ITU-Libra-ESVA-Information: Please contact Istanbul Teknik Universitesi for more information
X-ITU-Libra-ESVA-ID: 4Z6fqN5rPjzG0QT
X-ITU-Libra-ESVA: No virus found
X-ITU-Libra-ESVA-From: root@cc.itu.edu.tr
X-ITU-Libra-ESVA-Watermark: 1741712645.79453@OOcWZJ2yZPzPLiGDUCFXIA
X-ITU-MailScanner-SpamCheck: not spam

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


