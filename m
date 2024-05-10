Return-Path: <linux-tip-commits+bounces-1249-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B90ED8C22D5
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 May 2024 13:11:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77AA31F21540
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 May 2024 11:11:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F39316D9B8;
	Fri, 10 May 2024 11:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S3E0zyxh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oOxzZlpS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A0A516D4C5;
	Fri, 10 May 2024 11:10:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715339459; cv=none; b=cT6pV+KilnPNWAq4p4f0SSohLIFAwMCGmZWeqAFspzgnhmX9Y6vocxBAJ3fYwVgc2cRzKSO3mlXmG50rcP/POoCBMWQJHnfQel3rcOOMEJH+sU/jSfiZep4H7Fs0xFqMvxyLG7apMqRtYV1bgfydNEC7qqTghWeg9TNN8cLawLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715339459; c=relaxed/simple;
	bh=/XDWjH9kgA4VRb1TEE3dxeVVmz4NB59IUrOibrKX+c4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qUIlzuvj9qgl4+ppHB/rzldiqUGwFvDn7G0yP5eERX/DfiBQGsJjqm9FkHZ+3mIefHuyogkHEfw+Y/URj87khVvoY3xUjseitqDERGUBHQL2G9KBPAoa7fCraHOhdCvtv9/OgvHU7q/ygi1Ebj27t2bOjTKJaS863Vor7KjagqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S3E0zyxh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oOxzZlpS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 10 May 2024 11:10:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1715339455;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SBOlEp4I6oOUdQxUIN9o1C4froyOEUsOKM+cix8aL+I=;
	b=S3E0zyxhBc6rckDzpxTSDsRhQrv9xk+QNXOPv24M5oah5NkXcX3G2l0xDmsHw4pxZE/nqi
	tgao93rezKv2exFy/3urK1UX3BiY3js25cwT4fkGQv1HDA54Sb0iwPSurPrNzpR7J/cb6+
	O4unMeHspsmKXWJLKKgaibcuKTwXK1pQwMK0MUDm02CcWLULqNYeUyrtSjBwpqGOLNiOqB
	QY5kuvwZuW5MwadinM6pzNc1CflHb6jE40zIrmlgZcQGFoXQS8DhGVK9vCn4ErZj6qrJAY
	gld/DSd39+dA9mR1WdJ6h/7WOw4QPD310sPmFBQzwE1lHXTzkVZii2Cye5ly0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1715339455;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SBOlEp4I6oOUdQxUIN9o1C4froyOEUsOKM+cix8aL+I=;
	b=oOxzZlpSYEfyMGBXrDSYS4C8x4llSyx4m/sWsGy1L2vicSVxsstbG61olhS5L1ZyBXshEL
	JcLcuLT2INS5xeBw==
From: "tip-bot2 for Christophe JAILLET" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/timer-ti-dm: Remove an unused
 field in struct dmtimer
Cc: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cc9f7579922c587fce334a1aa9651f3189de7a00b=2E17145?=
 =?utf-8?q?13336=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
References: =?utf-8?q?=3Cc9f7579922c587fce334a1aa9651f3189de7a00b=2E171451?=
 =?utf-8?q?3336=2Egit=2Echristophe=2Ejaillet=40wanadoo=2Efr=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171533945550.10875.14039249219445613776.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     e6f8bed209d5fa8602cda45930b0a331234d95ed
Gitweb:        https://git.kernel.org/tip/e6f8bed209d5fa8602cda45930b0a331234d95ed
Author:        Christophe JAILLET <christophe.jaillet@wanadoo.fr>
AuthorDate:    Tue, 30 Apr 2024 23:42:39 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 10 May 2024 10:41:52 +02:00

clocksource/drivers/timer-ti-dm: Remove an unused field in struct dmtimer

In "struct dmtimer", the 'rate' field is unused.
Remove it.

Found with cppcheck, unusedStructMember.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://lore.kernel.org/r/c9f7579922c587fce334a1aa9651f3189de7a00b.1714513336.git.christophe.jaillet@wanadoo.fr
---
 drivers/clocksource/timer-ti-dm.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/clocksource/timer-ti-dm.c b/drivers/clocksource/timer-ti-dm.c
index 56acf26..b7a34b1 100644
--- a/drivers/clocksource/timer-ti-dm.c
+++ b/drivers/clocksource/timer-ti-dm.c
@@ -129,7 +129,6 @@ struct dmtimer {
 	void __iomem	*func_base;	/* function register base */
 
 	atomic_t enabled;
-	unsigned long rate;
 	unsigned reserved:1;
 	unsigned posted:1;
 	unsigned omap1:1;

