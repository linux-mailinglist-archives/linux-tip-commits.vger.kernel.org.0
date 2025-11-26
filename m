Return-Path: <linux-tip-commits+bounces-7542-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 17F5CC8A631
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Nov 2025 15:41:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 03880357E83
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Nov 2025 14:41:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE759304BA4;
	Wed, 26 Nov 2025 14:40:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xqvR2mvN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q4uJNuMk"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C54DC3043BF;
	Wed, 26 Nov 2025 14:40:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764168042; cv=none; b=tXVT6uDFqXCEk9NK3cPJlz8LCHOlPXgaZUEdz86oe3Bxe6PqC65gto8mX1Otp6HFHG3tI5pDflpWnd0OsmZZ+Idq2pase/ZVsl3Y0r0tT9ObYiaBrrUGJ2vGAUDyXoMFAga09wUzigBf/KO43UfpCZy3+B/OMlKtCjtZO2r8GGw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764168042; c=relaxed/simple;
	bh=FVwvwVE+1p0xQ9xn+BKxF1GiBAIRv0OZo02X7Fng5Pk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nplaTT9OT8YrRqhHZx0lZfND+y4BW+XOn9Au1YZgn9RRlxwV6a+3aXd/FadA9wGrCyuY7jV09n+OTYdJoMLO8keAMFm5zpvYETvtCWfwhHiiqiZapbL83ddp0QOyHeJ3bI+8tY2ECt29C12pvZCcWKaJzTEWBUuRflWG0cFGDEI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xqvR2mvN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q4uJNuMk; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Nov 2025 14:40:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1764168039;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=De5OMkw5fW9lzgoMv4jH7dE6EC6GQ05snWKS+6Sa44g=;
	b=xqvR2mvNVuXhPAtKFdNv9fOY6Ix82SPtzWOmNlFe12eG/hRMS3jV9J5t3nwJeg2GPj56ml
	dgz1PWHPUx3pu2nGuTKQeHz4egV8TrJylN5meHq5V8kAFOmXhKn7lBborbU+wHwUdq2DDQ
	nsCt9hVLZTmcgQ7IDeqJPLebcswrR2ULl2pIYHNRAfhHmuRBgXFOHq0Cz9hBzReh1pPaMJ
	qlU6jJCzxzrW7l+CfHcoU79zQR0WC0BVRCtF+DvBpXkmnmrKkuXkR0ekjcyUYsj78CjK31
	SS0qjSgmtf4LsWVDi3ybsl2SAI0oYTzvHvjyqnBWOr1MkjjM/oxDFCockvLsgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1764168039;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=De5OMkw5fW9lzgoMv4jH7dE6EC6GQ05snWKS+6Sa44g=;
	b=q4uJNuMkpFWojbxmN6qKfAks1Au18b7qN7HK8MVpKUbAkRYfW0JkvClGJf/I6FCpUbCra+
	7IuMOyjU+wQeB4DA==
From: "tip-bot2 for Enlin Mu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/rda: Add
 sched_clock_register for RDA8810PL SoC
Cc: Enlin Mu <enlin.mu@unisoc.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251107063347.3692-1-enlin.mu@linux.dev>
References: <20251107063347.3692-1-enlin.mu@linux.dev>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176416803794.498.5180797545298678811.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     627f3f3716a3591f5e6a6bd124c95eef85444080
Gitweb:        https://git.kernel.org/tip/627f3f3716a3591f5e6a6bd124c95eef854=
44080
Author:        Enlin Mu <enlin.mu@unisoc.com>
AuthorDate:    Fri, 07 Nov 2025 14:33:47 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 26 Nov 2025 11:25:11 +01:00

clocksource/drivers/rda: Add sched_clock_register for RDA8810PL SoC

The current system log timestamp accuracy is tick based, which can not
meet the usage requirements and needs to reach nanoseconds.
Therefore, the sched_clock_register function needs to be added.

[ dlezcano: Fixed typos ]

Signed-off-by: Enlin Mu <enlin.mu@unisoc.com>
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Link: https://patch.msgid.link/20251107063347.3692-1-enlin.mu@linux.dev
---
 drivers/clocksource/timer-rda.c |  9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-rda.c b/drivers/clocksource/timer-rda.c
index fd1199c..0be8e05 100644
--- a/drivers/clocksource/timer-rda.c
+++ b/drivers/clocksource/timer-rda.c
@@ -13,6 +13,7 @@
=20
 #include <linux/init.h>
 #include <linux/interrupt.h>
+#include <linux/sched_clock.h>
=20
 #include "timer-of.h"
=20
@@ -153,7 +154,7 @@ static struct timer_of rda_ostimer_of =3D {
 	},
 };
=20
-static u64 rda_hwtimer_read(struct clocksource *cs)
+static u64 rda_hwtimer_clocksource_read(void)
 {
 	void __iomem *base =3D timer_of_base(&rda_ostimer_of);
 	u32 lo, hi;
@@ -167,6 +168,11 @@ static u64 rda_hwtimer_read(struct clocksource *cs)
 	return ((u64)hi << 32) | lo;
 }
=20
+static u64 rda_hwtimer_read(struct clocksource *cs)
+{
+	return rda_hwtimer_clocksource_read();
+}
+
 static struct clocksource rda_hwtimer_clocksource =3D {
 	.name           =3D "rda-timer",
 	.rating         =3D 400,
@@ -185,6 +191,7 @@ static int __init rda_timer_init(struct device_node *np)
 		return ret;
=20
 	clocksource_register_hz(&rda_hwtimer_clocksource, rate);
+	sched_clock_register(rda_hwtimer_clocksource_read, 64, rate);
=20
 	clockevents_config_and_register(&rda_ostimer_of.clkevt, rate,
 					0x2, UINT_MAX);

