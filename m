Return-Path: <linux-tip-commits+bounces-6750-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5ED84BA195A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:37:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 221493255AE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:37:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7279532BF22;
	Thu, 25 Sep 2025 21:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DnZ0WwnI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yRWlfJ9T"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A07732BBE9;
	Thu, 25 Sep 2025 21:33:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836016; cv=none; b=baGyIEAs6Q83/1Yn4He/ZnsNtOOU7bA0TEboVML/sCJTqrpgbmoGr9qmbXeUM+Y/+NchosW3k82phtWGNUe96ZLi/z1+UY/gWxl5CzUAcRqs1yjD8hvSHDfmAy5tzzxzB2A9apTN+0E7VzORHNJLOBSFWbS7HGOa3R2lHFH7gkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836016; c=relaxed/simple;
	bh=VvLi2gQfGEUwhuasTYGQTI3v06/3pR7+Wv9Vl0Pw3W0=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=JEFqNeySbCydYYwNkrOOtP5qLlNnZuYkLqXJjJXY9a5vB9JyFgyulphLNd49cHeriO21vvezdQytTG4H1Tl2pY5Dgx+IQfvn1H8ESwGNoxBOTrNNsMztK1H9lUq+2jVRFom+YuwFHy19PeLG9/ARG8yKy0VrEKiyKg+2NY4efNY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DnZ0WwnI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yRWlfJ9T; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758836012;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=euhobZhp/dbCvuDuCY4cR2iIELY0OY1A0NZk1i+hoQI=;
	b=DnZ0WwnIxvwDVPLMkEPgvW7tk9/6fOxz2F54sO2JG3ImUMNqbI072/EzejWiTNmFwnau56
	B3xzFx3UpGPtJ9E6Gz994sENVMyi76CNosPTCaIAZjupTt5/+ZlBBZ1vZtgFXCGCb10Io8
	GQUncvUs0cjWSm5UD+SRWionZCJ8lU8BlkgItXnHzvb/66jAIqjLF7jLdB6aUcfZrGluGp
	PsF/EmnNiWj4tA18MphxHrizlIZJq4+UOntchyRaaAzN2cTtDSFxLw/CMNl6RM4QIgbwOs
	AUTbpE54+eKwC8Gw2+yqOZE/w8zEecc3z/0U9IYF5e0g/EwGzBSujvSFfoZIBQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758836012;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=euhobZhp/dbCvuDuCY4cR2iIELY0OY1A0NZk1i+hoQI=;
	b=yRWlfJ9TK6F684rjL7hlXWPyxMB9VBo8IrybB2anhOQ8puXYHhAo6Uj5CMiJcJ6C7iTW89
	iGLOBd3UTXeJ+ACA==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/vf-pit: Convert raw
 values to BIT macros
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883601067.709179.7564163339115673056.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     0c063c9afc1b5243adde544637e273c1ac0a31d9
Gitweb:        https://git.kernel.org/tip/0c063c9afc1b5243adde544637e273c1ac0=
a31d9
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 04 Aug 2025 17:23:26 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 12:29:09 +02:00

clocksource/drivers/vf-pit: Convert raw values to BIT macros

Use the BIT macros instead of the shifting syntax.

No functional change intended.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/20250804152344.1109310-9-daniel.lezcano@linar=
o.org
---
 drivers/clocksource/timer-vf-pit.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/clocksource/timer-vf-pit.c b/drivers/clocksource/timer-v=
f-pit.c
index d408dcd..d1aec6a 100644
--- a/drivers/clocksource/timer-vf-pit.c
+++ b/drivers/clocksource/timer-vf-pit.c
@@ -21,11 +21,11 @@
 #define PITTCTRL	0x08
 #define PITTFLG		0x0c
=20
-#define PITMCR_MDIS	(0x1 << 1)
+#define PITMCR_MDIS	BIT(1)
=20
-#define PITTCTRL_TEN	(0x1 << 0)
-#define PITTCTRL_TIE	(0x1 << 1)
-#define PITCTRL_CHN	(0x1 << 2)
+#define PITTCTRL_TEN	BIT(0)
+#define PITTCTRL_TIE	BIT(1)
+#define PITCTRL_CHN	BIT(2)
=20
 #define PITTFLG_TIF	0x1
=20

