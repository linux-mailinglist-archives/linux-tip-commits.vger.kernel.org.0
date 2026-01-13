Return-Path: <linux-tip-commits+bounces-7898-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id ECF92D17E15
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 11:10:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BEF153045F5D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 10:06:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA87738A2B0;
	Tue, 13 Jan 2026 10:06:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="squlDdGg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3Gj2qRVZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B2F0389DFA;
	Tue, 13 Jan 2026 10:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768298817; cv=none; b=bF8DI0g7n1tv290UjZjnSgPNCJezNmzn/ZQxTxmueleOaEieCrVHUz7O9ZgQre43YLIRd3ApCs/FBmy3wABtwGiAVr4zYrpRy2XqA43H8WwcNvOS2zHtlt5uIs3iT8RIke09AAe8wbhJeXLiKIF4cU+PQJQkeBEfPm/ALPyyrCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768298817; c=relaxed/simple;
	bh=LYHGZcEMd/sl1h/AovlIQOLncO7GhgJRekFbUOld+rQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iFNPm/9RYVagTzWDhW/F1O3pQ3rW1pKvIZQvyKvtOLwQJrqXU/PiEoNNx2LCOtf0goj0Cs7AumNSMhIbnhfLH2gtG7cvqF3pZscbsso0KC6+pFO1qUeo18UZdFXQKUNTit92Zc8fbJ+RzF+8Ux3IfU9qyP+UFYQjnKb7xUNjMXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=squlDdGg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3Gj2qRVZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 10:06:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768298810;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vdjh8FwsPrL+fzhjYPySvbeK1rgX2gVFBeibMM/Fr4w=;
	b=squlDdGgmcCoylL1dISliIvMCxzoJoYI3mgvxmK8ygfbp7ITPY+kgmu0J0XUPLT2tYOzaE
	DwuLzvcjnUXJP4YOTglG3ZazKuXL2TE+Q1ecjY0a7t1W8ET9WtKYhpxwD6q1aytjB/FZpG
	NwjBOYebw6/LImKLmsKT2qcjH8L0l/fMnOB2BOliCguv5C8up+8LvCBbLe5wrfmJdqFqnr
	ZfJx++uROzmkoAe9oDA56oCsL9QzZu0zqSg9LfbtK7ftRFww0G3NcKdkOgFbQGjRMhXHC+
	jym6k/ZAF69UJ4+gFQpPtimbSWrmsDCy5SaXd26MKbWeJTqq4M/Qbptyb8L1ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768298810;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Vdjh8FwsPrL+fzhjYPySvbeK1rgX2gVFBeibMM/Fr4w=;
	b=3Gj2qRVZ2QuYALt1Xgzmk2iYjKiZTPHs/tYl7cL/kT6ksM27WlrI01ERSisX/+x5S/WQVd
	xiSedANwADgBLHDg==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] hrtimer: Drop _tv64() helpers
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260107-hrtimer-header-cleanup-v1-3-1a698ef0ddae@linutronix.de>
References: <20260107-hrtimer-header-cleanup-v1-3-1a698ef0ddae@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176829880858.510.14481916878054766385.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     ae4535b0d9372ca90a24f2d9970310ee48eb3cc2
Gitweb:        https://git.kernel.org/tip/ae4535b0d9372ca90a24f2d9970310ee48e=
b3cc2
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Wed, 07 Jan 2026 11:36:58 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 13 Jan 2026 11:05:49 +01:00

hrtimer: Drop _tv64() helpers

Since ktime_t has become an alias to s64, these helpers are unnecessary.

Migrate the few remaining users to the regular helpers and remove the
now dead code.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260107-hrtimer-header-cleanup-v1-3-1a698ef0d=
dae@linutronix.de
---
 include/linux/hrtimer.h | 15 ---------------
 kernel/time/hrtimer.c   |  6 +++---
 2 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/include/linux/hrtimer.h b/include/linux/hrtimer.h
index 2cf1bf6..eb2d3d9 100644
--- a/include/linux/hrtimer.h
+++ b/include/linux/hrtimer.h
@@ -112,12 +112,6 @@ static inline void hrtimer_set_expires_range_ns(struct h=
rtimer *timer, ktime_t t
 	timer->node.expires =3D ktime_add_safe(time, ns_to_ktime(delta));
 }
=20
-static inline void hrtimer_set_expires_tv64(struct hrtimer *timer, s64 tv64)
-{
-	timer->node.expires =3D tv64;
-	timer->_softexpires =3D tv64;
-}
-
 static inline void hrtimer_add_expires(struct hrtimer *timer, ktime_t time)
 {
 	timer->node.expires =3D ktime_add_safe(timer->node.expires, time);
@@ -140,15 +134,6 @@ static inline ktime_t hrtimer_get_softexpires(const stru=
ct hrtimer *timer)
 	return timer->_softexpires;
 }
=20
-static inline s64 hrtimer_get_expires_tv64(const struct hrtimer *timer)
-{
-	return timer->node.expires;
-}
-static inline s64 hrtimer_get_softexpires_tv64(const struct hrtimer *timer)
-{
-	return timer->_softexpires;
-}
-
 static inline s64 hrtimer_get_expires_ns(const struct hrtimer *timer)
 {
 	return ktime_to_ns(timer->node.expires);
diff --git a/kernel/time/hrtimer.c b/kernel/time/hrtimer.c
index 2d319f8..d0ab2e9 100644
--- a/kernel/time/hrtimer.c
+++ b/kernel/time/hrtimer.c
@@ -814,7 +814,7 @@ static void hrtimer_reprogram(struct hrtimer *timer, bool=
 reprogram)
 	struct hrtimer_clock_base *base =3D timer->base;
 	ktime_t expires =3D ktime_sub(hrtimer_get_expires(timer), base->offset);
=20
-	WARN_ON_ONCE(hrtimer_get_expires_tv64(timer) < 0);
+	WARN_ON_ONCE(hrtimer_get_expires(timer) < 0);
=20
 	/*
 	 * CLOCK_REALTIME timer might be requested with an absolute
@@ -1061,7 +1061,7 @@ u64 hrtimer_forward(struct hrtimer *timer, ktime_t now,=
 ktime_t interval)
=20
 		orun =3D ktime_divns(delta, incr);
 		hrtimer_add_expires_ns(timer, incr * orun);
-		if (hrtimer_get_expires_tv64(timer) > now)
+		if (hrtimer_get_expires(timer) > now)
 			return orun;
 		/*
 		 * This (and the ktime_add() below) is the
@@ -1843,7 +1843,7 @@ static void __hrtimer_run_queues(struct hrtimer_cpu_bas=
e *cpu_base, ktime_t now,
 			 * are right-of a not yet expired timer, because that
 			 * timer will have to trigger a wakeup anyway.
 			 */
-			if (basenow < hrtimer_get_softexpires_tv64(timer))
+			if (basenow < hrtimer_get_softexpires(timer))
 				break;
=20
 			__run_hrtimer(cpu_base, base, timer, &basenow, flags);

