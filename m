Return-Path: <linux-tip-commits+bounces-6136-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D61CB0A3B3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jul 2025 13:57:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2F6A83A2CD7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Jul 2025 11:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75CA12DAFA5;
	Fri, 18 Jul 2025 11:56:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2FxQPv9/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9zWIL7AK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0E772D9EED;
	Fri, 18 Jul 2025 11:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752839791; cv=none; b=IAM/ODxqC65IDAkGuVrMjIXTWwcQRf8j3o4kU4NQPWxUMP84XjLlQ9frHMjtRGdX1xR0d6ug3O6qhRQMoKgqJA5uaklJSP5i5hH4Z+pVw1RZ8pKLLNEiZIXfZRtrh0xeWETXH+KUC9lkIdt9KIqdKyRr0yCJIkAhUheWFVorVsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752839791; c=relaxed/simple;
	bh=kVFOrI0FDinMT0n3xaI8cZlfprdzcgGS1it1h1frVLQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MK12xWMWRzhAG6zuM6XpcS49uV4ouHJTSNyTBilnygGbXtCTnwiE3T8WdUI/mkpLutpurwdSUfDnS+RyfhvtQ53AfYrdQN5vKeZNCh1TlZknHr/AmQZna5fxoIdj/JOizAjy2u6GKeJS38oD+R0zSCsdHh0DVlvmm0f2mVf7gKM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2FxQPv9/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9zWIL7AK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Jul 2025 11:56:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752839788;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iFmWfUUO4eRJX9JZq6NDwgHSVOg25N4WDaG5ZjQZNbw=;
	b=2FxQPv9/nfGtEWabjev4sbIOy3MB1oY2GuTSrHNtAJQENCiqHPLC+KmBlLq352C9rTSvHr
	iEOqmTULCksTvQpPCQT/cVIZGHBZQW48XMDyHS0zXhIbZizBfsDF7IkyirTs5MIroUYIeB
	AQxSWckt3FJxAfxN5tSem7+GIze5YC04IqQdP3etCzQR2Q2MpahusL5OCcQm1J4i1VXP1h
	tVfu2PuNq8sZVaa2zncNgvNirHzp1j5k6PKK8BH39FB2XXBh6lyeYyxiA0n0XLrAgYDIT1
	g3NhmH+sMEdignfMjZfofcwEGKecsQTAQxdFSMWzfCnfMZVrkoIqYu6w3NSpyg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752839788;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iFmWfUUO4eRJX9JZq6NDwgHSVOg25N4WDaG5ZjQZNbw=;
	b=9zWIL7AKIpF6GyCt/Unx5Chn20JQv9XIR3zzaXes9H79lzy9Gxw/EL4Zr5Dg9/OaMkkDfJ
	Xb67FgBEbGr9cdDw==
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
Message-ID: <175283978729.406.12904983631339859534.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     1a1cd5fe881fdf7b0391e5426f6bfcb663c90dde
Gitweb:        https://git.kernel.org/tip/1a1cd5fe881fdf7b0391e5426f6bfcb663c=
90dde
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 01 Jul 2025 10:58:01 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 18 Jul 2025 13:45:32 +02:00

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
index 32e568d..0271226 100644
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

