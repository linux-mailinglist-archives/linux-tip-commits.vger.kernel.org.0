Return-Path: <linux-tip-commits+bounces-7706-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A40BACBF84C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 20:22:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 1CE4B3001BD2
	for <lists+linux-tip-commits@lfdr.de>; Mon, 15 Dec 2025 19:22:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5AE03101DB;
	Mon, 15 Dec 2025 19:22:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="41JEHAmu";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5pEH7Fcf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17C9430F55F;
	Mon, 15 Dec 2025 19:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765826537; cv=none; b=MPb519kpJKRecG2bQ6oVjHlkLf042tAgiknZK+TP48mxgH5X4mllzgmn4CLWUT8ItmB5AJU6JCqyB/syCGAXscrhOxIv7ASa2fdxQz/kLPcQwEGNOCbyShbaIKxBOglyyLE0xezxblBTYlYn/cyacnxq9S/nUTXaeIrIt1zx78s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765826537; c=relaxed/simple;
	bh=PP9fEE26rw3y9ep1kyPHcvkr85gdO4WhJrtGNuYTE0s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hlUcixSmEY3rvIM/PvrHdVJmwAdNwFjDrCyMQyP5nJ2vGM1DQDS9Lj1V6IjnvUnEmoqbw3opTPIbB+v5gRXOFlnp/r4/mbfyF8uox+tEvdXvVZXZ1g/IxS7F44Pu2lhKTN8ye837/uEizmSs+OPHsaz9cV5/AxxjSKTNdBarnBs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=41JEHAmu; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5pEH7Fcf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 15 Dec 2025 19:22:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1765826534;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n2XQob31Q7E1VorH2v2Tf2XVuukIltM/U3fptjo6QM8=;
	b=41JEHAmuYlc9eTrmd5Jhu03O9kTSQfsa6Lalv8wtMNemzdxytnMZ8VuEzmCSTMXxizSSSM
	t9bK4adLL1yspgyoT1iLwmUntcLQyiVwlaSkY00ABZlHpeGMzp2wHn5Ew1AxwU37BjOi4Z
	PGBHqL6QjcYB89GLNPLnCIK948g3uyQF0Bxh78+37uIigsrd6YGYe+POLuJKA+dXRdfg9j
	sFR9NyD7kR8eDdN9q5Bp0WVFCA+if+K5lC7GRvmpNbJr88jpjDElOdt7DF898kqIa4T6AJ
	MIH7ZpyPKs139FXkJGahVx5kNXItjUn9JuzXtlEjv2EKYT+pRSa3dqOKX23Iow==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1765826534;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n2XQob31Q7E1VorH2v2Tf2XVuukIltM/U3fptjo6QM8=;
	b=5pEH7FcfcW5TLo5ejFVgZ0AorSkSUm3fhEccXTHIS5RlReFBKQOEsbeHTFsim4OubWBs88
	ESBcwY7UV7RLrfBA==
From: "tip-bot2 for Eric Dumazet" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] time/timecounter: Inline timecounter_cyc2time()
Cc: Eric Dumazet <edumazet@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251129095740.3338476-1-edumazet@google.com>
References: <20251129095740.3338476-1-edumazet@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176582653316.510.8825485182018682734.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     4725344462362e2ce2645f354737a8ea4280fa57
Gitweb:        https://git.kernel.org/tip/4725344462362e2ce2645f354737a8ea428=
0fa57
Author:        Eric Dumazet <edumazet@google.com>
AuthorDate:    Sat, 29 Nov 2025 09:57:40=20
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 15 Dec 2025 20:16:49 +01:00

time/timecounter: Inline timecounter_cyc2time()

New network transport protocols want NIC drivers to get hardware timestamps
of all incoming packets, and possibly all outgoing packets.

One example is the upcoming 'Swift congestion control' which is used by TCP
transport and is the primary need for timecounter_cyc2time(). This means
timecounter_cyc2time() can be called more than 100 million times per second
on a busy server.

Inlining timecounter_cyc2time() brings a 12% improvement on a UDP receive
stress test on a 100Gbit NIC.

Note that FDO, LTO, PGO are unable to magically help for this case,
presumably because NIC drivers are almost exclusively shipped as modules.

Add an unlikely() around the cc_cyc2ns_backwards() case, even if FDO (when
used) is able to take care of this optimization.

Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://research.google/pubs/swift-delay-is-simple-and-effective-for-co=
ngestion-control-in-the-datacenter/
Link: https://patch.msgid.link/20251129095740.3338476-1-edumazet@google.com
---
 include/linux/timecounter.h | 31 +++++++++++++++++++++++++++++--
 kernel/time/timecounter.c   | 35 -----------------------------------
 2 files changed, 29 insertions(+), 37 deletions(-)

diff --git a/include/linux/timecounter.h b/include/linux/timecounter.h
index dce03a5..7de6b35 100644
--- a/include/linux/timecounter.h
+++ b/include/linux/timecounter.h
@@ -115,6 +115,15 @@ extern void timecounter_init(struct timecounter *tc,
  */
 extern u64 timecounter_read(struct timecounter *tc);
=20
+/*
+ * This is like cyclecounter_cyc2ns(), but it is used for computing a
+ * time previous to the time stored in the cycle counter.
+ */
+static inline u64 cc_cyc2ns_backwards(const struct cyclecounter *cc, u64 cyc=
les, u64 frac)
+{
+	return ((cycles * cc->mult) - frac) >> cc->shift;
+}
+
 /**
  * timecounter_cyc2time - convert a cycle counter to same
  *                        time base as values returned by
@@ -131,7 +140,25 @@ extern u64 timecounter_read(struct timecounter *tc);
  *
  * Returns: cycle counter converted to nanoseconds since the initial time st=
amp
  */
-extern u64 timecounter_cyc2time(const struct timecounter *tc,
-				u64 cycle_tstamp);
+static inline u64 timecounter_cyc2time(const struct timecounter *tc, u64 cyc=
le_tstamp)
+{
+	const struct cyclecounter *cc =3D tc->cc;
+	u64 delta =3D (cycle_tstamp - tc->cycle_last) & cc->mask;
+	u64 nsec =3D tc->nsec, frac =3D tc->frac;
+
+	/*
+	 * Instead of always treating cycle_tstamp as more recent than
+	 * tc->cycle_last, detect when it is too far in the future and
+	 * treat it as old time stamp instead.
+	 */
+	if (unlikely(delta > cc->mask / 2)) {
+		delta =3D (tc->cycle_last - cycle_tstamp) & cc->mask;
+		nsec -=3D cc_cyc2ns_backwards(cc, delta, frac);
+	} else {
+		nsec +=3D cyclecounter_cyc2ns(cc, delta, tc->mask, &frac);
+	}
+
+	return nsec;
+}
=20
 #endif
diff --git a/kernel/time/timecounter.c b/kernel/time/timecounter.c
index 3d2a354..2e64dbb 100644
--- a/kernel/time/timecounter.c
+++ b/kernel/time/timecounter.c
@@ -62,38 +62,3 @@ u64 timecounter_read(struct timecounter *tc)
 }
 EXPORT_SYMBOL_GPL(timecounter_read);
=20
-/*
- * This is like cyclecounter_cyc2ns(), but it is used for computing a
- * time previous to the time stored in the cycle counter.
- */
-static u64 cc_cyc2ns_backwards(const struct cyclecounter *cc,
-			       u64 cycles, u64 mask, u64 frac)
-{
-	u64 ns =3D (u64) cycles;
-
-	ns =3D ((ns * cc->mult) - frac) >> cc->shift;
-
-	return ns;
-}
-
-u64 timecounter_cyc2time(const struct timecounter *tc,
-			 u64 cycle_tstamp)
-{
-	u64 delta =3D (cycle_tstamp - tc->cycle_last) & tc->cc->mask;
-	u64 nsec =3D tc->nsec, frac =3D tc->frac;
-
-	/*
-	 * Instead of always treating cycle_tstamp as more recent
-	 * than tc->cycle_last, detect when it is too far in the
-	 * future and treat it as old time stamp instead.
-	 */
-	if (delta > tc->cc->mask / 2) {
-		delta =3D (tc->cycle_last - cycle_tstamp) & tc->cc->mask;
-		nsec -=3D cc_cyc2ns_backwards(tc->cc, delta, tc->mask, frac);
-	} else {
-		nsec +=3D cyclecounter_cyc2ns(tc->cc, delta, tc->mask, &frac);
-	}
-
-	return nsec;
-}
-EXPORT_SYMBOL_GPL(timecounter_cyc2time);

