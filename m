Return-Path: <linux-tip-commits+bounces-1691-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F6599304FD
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Jul 2024 12:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0AA3928282A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Jul 2024 10:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18808134409;
	Sat, 13 Jul 2024 10:17:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="K3OYDUmo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VxlJd6N3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EF09770F8;
	Sat, 13 Jul 2024 10:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720865826; cv=none; b=EWmuLFIaP0L/6GrdqwDjSaT6xD1oudAbmHC/TSCPArBmo/TTNUrd0HeDPwdyCz5Yrzs42DO319UiMpIwcg7U6R4hoAA1mfVDqCzjSyI7UDU0nrWjv/r434eVoUDnZuaYNPhzb1aP0EdtWyyjU+ea7s8i4PKGugJVDq8ZQZrGpq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720865826; c=relaxed/simple;
	bh=WbkcAqLQA9GsnAicd0GitlAecgPMErnnXqAWz+5skKo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uGAkR3anuAOnGxhiwEEWQvTnXaRJCOR2lZNQiPwTPn8ZxfiYVkWMQu9MNRrr0r87ewLgKQpkqpm1OOOte+4cUUxmFQcqN1+9x8p3BiGRLPCbDxsS4EOYKrsMm2yLtrKLSNgW2Ao0hEZCLu+d8DpGOkI1/8Xl4Teqf5wAXc4QT0Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=K3OYDUmo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VxlJd6N3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 13 Jul 2024 10:16:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720865815;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P/yUSHVHYHM4AEyDVgbZ5V00+w/2vV5I5Dj8e0eU3DU=;
	b=K3OYDUmolHBXWGoS/J5rQSQn9P17FPBL1nkrL7aq2EkE0eNhNcXt+y0NgopRyP4udUuXLc
	9Af6KqfOTDnAD6JLhdRHR2yq8ua6ctHyfZqIViss30t29TdC/KbXaBKoLW31Qcs3MTi6HT
	pVhx0pxiOKTkfznh7NCnBIoBmUdu9Hz87C2dc1lF5vatzAXLlMhwk+5/agpsRAqP8jp/SQ
	DnWodyJO1NrmDSw0bDmlY3WXJO81KcBugL1V+SMTJSLgriQxLA06n9fBe2E3K9gqaxgpBE
	A4gWwr6Z/tas+nM9smAmZmTTdhW7+d/RP/U3Kq22LwNwIGfbaT3R/nerLj6d/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720865815;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=P/yUSHVHYHM4AEyDVgbZ5V00+w/2vV5I5Dj8e0eU3DU=;
	b=VxlJd6N3M6A2BEWj4qUMZYwLDxIofOhRr47oMFjheSPGNNcZgjEeKvVBlDHuKMP3kaji2M
	MAtXjMQuEWD91fAw==
From: "tip-bot2 for Jiaxun Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/mips-gic-timer: Refine rating
 computation
Cc: Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240612-mips-clks-v2-6-a57e6f49f3db@flygoat.com>
References: <20240612-mips-clks-v2-6-a57e6f49f3db@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172086581542.2215.1800394668023850103.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     cc9b2c590ebacf656bb2063c2f6cbfb7ad7081f3
Gitweb:        https://git.kernel.org/tip/cc9b2c590ebacf656bb2063c2f6cbfb7ad7081f3
Author:        Jiaxun Yang <jiaxun.yang@flygoat.com>
AuthorDate:    Wed, 12 Jun 2024 09:54:33 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 12 Jul 2024 16:07:05 +02:00

clocksource/drivers/mips-gic-timer: Refine rating computation

It is a good clocksource which usually go as fast as CPU core
and have a low access latency, so raise the base of rating
from Good to desired when we know that it has a stable frequency.

Increase frequency addend dividend to 10000000 (10MHz) to
reasonably accommodate multi GHz level clock, also cap rating
within current level.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Link: https://lore.kernel.org/r/20240612-mips-clks-v2-6-a57e6f49f3db@flygoat.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/mips-gic-timer.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
index b3ae38f..7a03d94 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -197,7 +197,11 @@ static int __init __gic_clocksource_init(void)
 	gic_clocksource.mask = CLOCKSOURCE_MASK(count_width);
 
 	/* Calculate a somewhat reasonable rating value. */
-	gic_clocksource.rating = 200 + gic_frequency / 10000000;
+	if (mips_cm_revision() >= CM_REV_CM3 || !IS_ENABLED(CONFIG_CPU_FREQ))
+		gic_clocksource.rating = 300; /* Good when frequecy is stable */
+	else
+		gic_clocksource.rating = 200;
+	gic_clocksource.rating += clamp(gic_frequency / 10000000, 0, 99);
 
 	ret = clocksource_register_hz(&gic_clocksource, gic_frequency);
 	if (ret < 0)

