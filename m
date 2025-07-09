Return-Path: <linux-tip-commits+bounces-6040-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B84BAFE4BB
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jul 2025 11:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 432B34E7030
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Jul 2025 09:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C893028A3EF;
	Wed,  9 Jul 2025 09:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IXAaUm6B";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lV5cQI5r"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24C73288C22;
	Wed,  9 Jul 2025 09:57:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752055060; cv=none; b=s/x5kB+Ezab+vYYYrkgSP+EBMSc5PCQESQSUYA7oHXusupWBfm3MWDFXiYuxJ9q9WhyktB9Tfx3/Ke5jSzGYWuvIjVyzv/+3MH8atG2XX8OxJf5m4kV9ayoN44+BnnCXEix9K8dZtX+SdkaRfUs7GeengyWFSatQa4pg2zfAFao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752055060; c=relaxed/simple;
	bh=hthWt25sJRyTud0NT/Xd+VffVfTmm25ER8VuwzFma5Q=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=l1xB7t7PyE71xCBpoXBPR55oaWNn1yvIk7p2xsVTprNUAtrA5HQOzCmGsVBdizXtFNyem/zI2lY/JpN4xoQL5yt91ETY1kF/C09pPj2Hwo254PdQJc8JPc/6FGDRgHjQ3HMcuE7Phu6XrpEx87z4U8nwh9wPaxN8wT7wNLb5gng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IXAaUm6B; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lV5cQI5r; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Jul 2025 09:57:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1752055057;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qvwWmq7surfYvHRsI/otZ9yVPpDg93+sqyDrv/vKMSs=;
	b=IXAaUm6B/3b+zKTOnPVs6ys68O79MVjF3Usb3a1d37NbZ/+8PYYqghCKbKcDbk/JSEwM7d
	vwuldgoL8oXOqFvX7bYGirYy1/AAEg/5XkIKKvnxcHAULLCUpR2N56JSiTe4s+PuNWCrnX
	3ipVbGTFvupx911+SjGjyecjQDyJTMr3MCDX1OCto2Zki6acedg5m6sjHdCXSkq/AiT772
	A3+jxsslLgjtXKAtwuoWZiNzS9cxE7D5UDBI6j1SxcrxBc9KEi1C6WITYAgurcdLrJLaxz
	laE8ZGwQyWQczfBvoICZwS2VkPbDmmMMjByiv0rP3vmEj59rqwQnaHthA1q+7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1752055057;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qvwWmq7surfYvHRsI/otZ9yVPpDg93+sqyDrv/vKMSs=;
	b=lV5cQI5rSRPfAG8+x4X2RnBRnSlqyZXaLdGQzqzFsXjXV0jbawxmhPvJPhAZoucNBuD7XD
	hfzeYNjUcjqHQRDA==
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
Message-ID: <175205505591.406.9674153187149360854.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/ptp branch of tip:

Commit-ID:     a2a9c3129dd8495e48a54f19193adbac1efe673b
Gitweb:        https://git.kernel.org/tip/a2a9c3129dd8495e48a54f19193adbac1ef=
e673b
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 01 Jul 2025 10:58:01 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 09 Jul 2025 11:52:34 +02:00

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
index 7e79b02..87e7aae 100644
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

