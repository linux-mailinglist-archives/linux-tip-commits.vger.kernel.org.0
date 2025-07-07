Return-Path: <linux-tip-commits+bounces-6012-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 593C9AFACC8
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Jul 2025 09:12:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 580FC3BD4F4
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Jul 2025 07:12:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 20084287278;
	Mon,  7 Jul 2025 07:11:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HHPI+sNo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="310XP92a"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49FC62868BE;
	Mon,  7 Jul 2025 07:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751872311; cv=none; b=oeKpDSZFd+lQHicJSrOA6f0li/QdNIP23xLyGyM2p1AjFIkA/LMVSkX3A6/B+kZwDsVkoX1/Fy6Zwk+5Uh805RPP06gy/3izOJpEggXcUOdgMXM3uOsB/H/kgJnPsjHBkAQUiGFTsoYVODwet0mzL25TEiNAshq4AWGhCK8z3I8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751872311; c=relaxed/simple;
	bh=iKqfJ373C7SZ2iMT9dCEB1yaCpkXmSoVjdfz6EeHmYA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TNnnCxw+VZYz9DhxCo0mWaKWEAkZg8o8cc5s2XNxY1Qa36DGJwO7RGouRSJyqWKXHbSF714NIlAprBhn74Tll/6+DpTXwS24AtWdNyzJE2NZ2Y4nZ+xaR8s2/YQmvTdjQfhYSEvjHyaqFC1wRbrSc61rn11eYlLzyws/l5bHlgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HHPI+sNo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=310XP92a; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Jul 2025 07:11:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751872307;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rVORhgKLO1kByK+hwEL9SfGjlVTEsO8pyJIDsXmjPf4=;
	b=HHPI+sNojmaIWf7A6ZFZidr7EhFj4HuEyMMgk6U6ocUm9lwnphHnK+14mB5Dfwykwl5YVB
	N96OZ43LtRZZldIDtLGn+8XHRqsqKV4Bn0WQ94AkTxBtrLm73ApCl67RjrH/PY1XCxQC6P
	L8HpV88AiYli5B37MzhKwUB6Wge0pdDJ753GhbrHuTVnqTuhJR+qdlirncUbthLrX8dL6q
	FlEsBOFNVYzFKZ0359PondevweHug9lcnJ58EQl/rq8f9sCscHh4JdLCEHqHVz/33e/C1c
	5GRt9oXxvgy0wwqYXqmMbufZGX6onxJiKl0xYbGnc/TLuEFSpvse4bGBZqABjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751872307;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rVORhgKLO1kByK+hwEL9SfGjlVTEsO8pyJIDsXmjPf4=;
	b=310XP92ap2Nkmw2AQ8UaWqr9BvIySMOmWadVS4YDUKrnor8c9Yo1Fhg86lLPYHJHAl3ypT
	QyT+d+tdaIbszqDA==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/ptp] vdso/gettimeofday: Introduce vdso_clockid_valid()
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250701-vdso-auxclock-v1-7-df7d9f87b9b8@linutronix.de>
References: <20250701-vdso-auxclock-v1-7-df7d9f87b9b8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175187230640.406.7033820241156783189.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     b5df72706b044b30b17f5d623fe040b83e98be36
Gitweb:        https://git.kernel.org/tip/b5df72706b044b30b17f5d623fe040b83e9=
8be36
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 01 Jul 2025 10:58:01 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 07 Jul 2025 08:58:52 +02:00

vdso/gettimeofday: Introduce vdso_clockid_valid()

Move the clock ID validation check into a common helper.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250701-vdso-auxclock-v1-7-df7d9f87b9b8@li=
nutronix.de

---
 lib/vdso/gettimeofday.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/lib/vdso/gettimeofday.c b/lib/vdso/gettimeofday.c
index c526653..215151b 100644
--- a/lib/vdso/gettimeofday.c
+++ b/lib/vdso/gettimeofday.c
@@ -71,6 +71,12 @@ static inline bool vdso_cycles_ok(u64 cycles)
 }
 #endif
=20
+static __always_inline bool vdso_clockid_valid(clockid_t clock)
+{
+	/* Check for negative values or invalid clocks */
+	return likely((u32) clock < MAX_CLOCKS);
+}
+
 #ifdef CONFIG_TIME_NS
=20
 #ifdef CONFIG_GENERIC_VDSO_DATA_STORE
@@ -268,8 +274,7 @@ __cvdso_clock_gettime_common(const struct vdso_time_data =
*vd, clockid_t clock,
 	const struct vdso_clock *vc =3D vd->clock_data;
 	u32 msk;
=20
-	/* Check for negative values or invalid clocks */
-	if (unlikely((u32) clock >=3D MAX_CLOCKS))
+	if (!vdso_clockid_valid(clock))
 		return false;
=20
 	/*
@@ -405,8 +410,7 @@ bool __cvdso_clock_getres_common(const struct vdso_time_d=
ata *vd, clockid_t cloc
 	u32 msk;
 	u64 ns;
=20
-	/* Check for negative values or invalid clocks */
-	if (unlikely((u32) clock >=3D MAX_CLOCKS))
+	if (!vdso_clockid_valid(clock))
 		return false;
=20
 	if (IS_ENABLED(CONFIG_TIME_NS) &&

