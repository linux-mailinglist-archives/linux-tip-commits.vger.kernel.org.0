Return-Path: <linux-tip-commits+bounces-4077-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31E2EA57AA1
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 14:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 84D003B3410
	for <lists+linux-tip-commits@lfdr.de>; Sat,  8 Mar 2025 13:45:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 586831DD0D5;
	Sat,  8 Mar 2025 13:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="blVmt2lR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OpQzsEid"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 056721C7004;
	Sat,  8 Mar 2025 13:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741441503; cv=none; b=pqbuj9tmaN8AWVsDZ7RzuQxv4N463s1Op2q4NQGFjARZvN9rv5fzhh1sDrskWtjTXu23+td1paTKkzWsETcVBd9epHmsc1W5ISuayofwLjeKh7yOrjNRWaS2qpurWukNslDIPAxFUsvwRTjRKp6dISOKjV1ouWhhhIz+UxQcjTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741441503; c=relaxed/simple;
	bh=X4xNJX5f5HCfn7iz7wmNFORVJmfBpCc32BkWX2fYIj0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DVhDP6N4QPQAAz2Ivnx762lOuN0nYvTpyzv0cilmmshgPEdP6SJsVeFdMyFIq3mwRdXXVXwgt6S1nnutlPUJn+rAZFLfW7ETaigmdHP7+nRulw9kyiNvHtDecCfYHTKVB2eJN9A310kk22z8zz1mpzx/Whj19p8NordSolmo0oo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=blVmt2lR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OpQzsEid; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 08 Mar 2025 13:44:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741441499;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mlZPe19weDyyXJ8L00nvQMEC+ltYwuU7kdC63x6xsbo=;
	b=blVmt2lRzlfC7XFxnipBzqLJwXxu/4q2Z37JIJ0UkmMEoXwVVIVdt+nRj9jGVkA1ZmoCuI
	fFEDjKbReiuZ12cxKeWuXcwEo9KIUhzk/wK2QunyKPqR3alPugY7sVw1V9lLZqyuYWz9mD
	cF7gG89N18npQw5MqYnDDp4EyngiufnvZP5pgz5+1ROhjmt0RzLugg0HBtpxgxHMhrkz2n
	a4E2k5uMolUoiOnwgwyA5TuY0yCFhoPjGoEOmHkg70r2EEXIUF5AlMkeeg/9EoQNkaSDyZ
	+gGAN6q7adARRbaULSWfQPa5xCdPCQgRpcvFVVW3Cp/vquEQoY9f6Jc9ARWJeA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741441499;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mlZPe19weDyyXJ8L00nvQMEC+ltYwuU7kdC63x6xsbo=;
	b=OpQzsEidS6G32xk0lk0st0Xe/r3GdV8iXsADxpcFwBkYCchXU8ri2v9QqLMDY3/aHr2ixZ
	7epEMCJGVhkd05Cw==
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
In-Reply-To: <20250303-vdso-clock-v1-15-c1b5c69a166f@linutronix.de>
References: <20250303-vdso-clock-v1-15-c1b5c69a166f@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174144149867.14745.14169155050003508900.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     bf0eff816e467f8decb9b3ac0218cc26060e359f
Gitweb:        https://git.kernel.org/tip/bf0eff816e467f8decb9b3ac0218cc26060=
e359f
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Mon, 03 Mar 2025 12:11:17 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 08 Mar 2025 14:37:41 +01:00

x86/vdso: Prepare introduction of struct vdso_clock

To support multiple PTP clocks, the VDSO data structure needs to be
reworked. All clock specific data will end up in struct vdso_clock and in
struct vdso_time_data there will be array of VDSO clocks. At the moment,
vdso_clock is simply a define which maps vdso_clock to vdso_time_data.

To prepare for the rework of the data structures, replace the struct
vdso_time_data pointer with a struct vdso_clock pointer where applicable.

No functional change.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250303-vdso-clock-v1-15-c1b5c69a166f@linu=
tronix.de

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

