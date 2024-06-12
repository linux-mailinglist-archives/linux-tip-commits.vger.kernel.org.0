Return-Path: <linux-tip-commits+bounces-1379-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 99955905CB9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Jun 2024 22:24:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3655E1F250FC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 Jun 2024 20:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D57EC84A5F;
	Wed, 12 Jun 2024 20:24:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FS8dVrjC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w41sGYvB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E8884A3F;
	Wed, 12 Jun 2024 20:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718223866; cv=none; b=L/Aru0U+JJApeJdIBSYtmfb2lrIroElL/s2ym862fAbtHEAGlDyQ6R/819901irQWoclhq0u4p4ZANNiTC9gXzLYB7IG07jpbC4lerjCCj9KlPnry7JHU8Rs9MGdou6zlsZNhevasXrLNuWvYJDF0DhoK4WZYJMkPysqZZGvV9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718223866; c=relaxed/simple;
	bh=f3YVlAbG/gr0/3IicxHUxaBgsAbpua9uiVBKwnQJtE8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=MHSOabGZ3veRbx4m/E+QCRW0uGrvczB3EmimBhR8jS92E6HTn2I1229KiH2iCJf+zyme2BsHAwWwayBBdr0JyMxCwTpWjIpOGG4ks2kidEwXmRswugFfsuN48soxptr64nsoFAOBgSWHgThZ4K4o+TvmOKBdrq8OVqEKnV+VLmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FS8dVrjC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w41sGYvB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 12 Jun 2024 20:24:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718223863;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nW2yfzAq7hujWLwBAiewiWaNuh+lQE+TLxNe8o9eSEY=;
	b=FS8dVrjCE00vWI8G5btLG5cbvM1wQ7Sd1nnS/6JZXoxY/mY+/SgBKFH0f3lcj2+5iXA/gx
	inK8D0IRJVYL+8Xn4Bz5JrO+9h6pTpZY7cy/qydtKFcG6PBjGOBeJeh471XiHDYm6p9TH4
	11NHwEfgWo2mwIdlt8Fcyejv6uZGt//DbfOvwWhJby+CbHBOl0VXcuGpGszeXODNTzSM83
	9g3btpOYphvkPIP2mOYyLdAq3U2elpbaqwaAs4rk5/GTWE51I1x3RXo9kdEogiaLWLLgwV
	IK+GiKaparrY+xhrnCroXgYlSS2NFVyb5yhTD7mjAOKk1Yt+J66Xd2CqVGH4/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718223863;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nW2yfzAq7hujWLwBAiewiWaNuh+lQE+TLxNe8o9eSEY=;
	b=w41sGYvB5unwZ7RHzHa2cpudXUIdKsIMG/nBe4D3jEpXXmq6SPzhpdtwWEPOC7ewjwgIq/
	jwox4miv5/qB/DCw==
From: "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/misc] hwmon: (k10temp) Remove unused HAVE_TDIE() macro
Cc: Yazen Ghannam <yazen.ghannam@amd.com>,
 "Borislav Petkov (AMD)" <bp@alien8.de>, Guenter Roeck <linux@roeck-us.net>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240606-fix-smn-bad-read-v4-7-ffde21931c3f@amd.com>
References: <20240606-fix-smn-bad-read-v4-7-ffde21931c3f@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171822386330.10875.16252992043193047565.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/misc branch of tip:

Commit-ID:     0e097f2b5928651de3b4f0100401c9e71fa73dba
Gitweb:        https://git.kernel.org/tip/0e097f2b5928651de3b4f0100401c9e71fa73dba
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Thu, 06 Jun 2024 11:13:00 -05:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Wed, 12 Jun 2024 11:40:17 +02:00

hwmon: (k10temp) Remove unused HAVE_TDIE() macro

...to address the following warning:

  drivers/hwmon/k10temp.c:104:9:
  warning: macro is not used [-Wunused-macros]

No functional change is intended.

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Acked-by: Guenter Roeck <linux@roeck-us.net>
Link: https://lore.kernel.org/r/20240606-fix-smn-bad-read-v4-7-ffde21931c3f@amd.com
---
 drivers/hwmon/k10temp.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/hwmon/k10temp.c b/drivers/hwmon/k10temp.c
index 6deb272..a2d2033 100644
--- a/drivers/hwmon/k10temp.c
+++ b/drivers/hwmon/k10temp.c
@@ -101,7 +101,6 @@ struct k10temp_data {
 #define TCCD_BIT(x)	((x) + 2)
 
 #define HAVE_TEMP(d, channel)	((d)->show_temp & BIT(channel))
-#define HAVE_TDIE(d)		HAVE_TEMP(d, TDIE_BIT)
 
 struct tctl_offset {
 	u8 model;

