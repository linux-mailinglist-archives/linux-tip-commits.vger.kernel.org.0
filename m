Return-Path: <linux-tip-commits+bounces-1689-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 11BBF9304FB
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Jul 2024 12:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B07D91F226FD
	for <lists+linux-tip-commits@lfdr.de>; Sat, 13 Jul 2024 10:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DDBD213248E;
	Sat, 13 Jul 2024 10:17:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y8OgXO4d";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Erv9UrNb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CB6473457;
	Sat, 13 Jul 2024 10:17:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720865825; cv=none; b=l2GVR0ixv0vSTuzn7EMPaOdNC2tfh+Fy1uCWuOZUpBu6JemDPTIBKiNytAUsgS50SHRT6LrXNQekeTXpeC6Dl5PSN2ZQRYNouWDFvGbFExtNLeLOn100ASHo3y9KzfuS0KVel/jiX+iMylj4NH+MU3DqT01ii0VmISAnOoDLWwQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720865825; c=relaxed/simple;
	bh=OcIWn94kj8ep04A+PehFS/3AfXuchelWQ410Wr0BRJw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LXWRAnQcLf8IUJSrMrrfWaIJjvFzOkIS86ZcHj+FP1E49aaB3CiLA6sZ3GPrHIWhRgT5tko/fqOxXXfxVQ+1pdIfxsvKxcOj9Sq2yTPDJm4N5YIlCpSE4lRgv2NRKPokrs2Xm1GEanHyI2ugVg48EbsZriJ/qMk/LsiLIsELgQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y8OgXO4d; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Erv9UrNb; arc=none smtp.client-ip=193.142.43.55
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
	bh=6A3b3nqSqUbLLesjAo28UtYP5tAmOgHJbQQLyaxODBo=;
	b=Y8OgXO4dpdaAEqbvo9MhL9AuwHNTFw2WoblrWASUaq69Jk2HBvqvJTNcFDfExfteY96z0t
	JXRoat9vnr7t5toF18MF9ioEpNyCochtIAWQXuBeRk9yFWM/Er6nfvhgxpbtMOkXXCk4eP
	JWuSM6KjyXxs++y0pm6ioZKN3aOiMIEEhvrKR11db03oTxx39lnQ4SBsJqKFZnKscbYCEK
	40efgDWhfuoEHrVP0XAaL+SuZvNBuxiYj1cuOyuCsEFEBAIAge4WQ7jpnq8hutfA5paF1z
	8+T3W9TidS2+pksLW7Y40nLwWCDTFTkymMI1UCmxiF5JH5MnWViIYZttmdkmMA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720865815;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6A3b3nqSqUbLLesjAo28UtYP5tAmOgHJbQQLyaxODBo=;
	b=Erv9UrNbhuEPMv1CPIsegmTBoVQt+nrl46NEfHgVTkcuSBqOy6js9xuLviWHOiopBWZpXP
	o13gmn3k1lE0DwCw==
From: "tip-bot2 for Jiaxun Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/mips-gic-timer: Correct
 sched_clock width
Cc: philmd@linaro.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240612-mips-clks-v2-7-a57e6f49f3db@flygoat.com>
References: <20240612-mips-clks-v2-7-a57e6f49f3db@flygoat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172086581522.2215.4543941382409253440.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     5e4bfd66eccaaab65b3d565cfe28483afeacaf1d
Gitweb:        https://git.kernel.org/tip/5e4bfd66eccaaab65b3d565cfe28483afea=
caf1d
Author:        Jiaxun Yang <jiaxun.yang@flygoat.com>
AuthorDate:    Wed, 12 Jun 2024 09:54:34 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 12 Jul 2024 16:07:05 +02:00

clocksource/drivers/mips-gic-timer: Correct sched_clock width

Counter width of GIC is configurable and can be read from a
register.

Use width value from the register for sched_clock.

Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
Link: https://lore.kernel.org/r/20240612-mips-clks-v2-7-a57e6f49f3db@flygoat.=
com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/mips-gic-timer.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-=
gic-timer.c
index 7a03d94..1103477 100644
--- a/drivers/clocksource/mips-gic-timer.c
+++ b/drivers/clocksource/mips-gic-timer.c
@@ -19,6 +19,7 @@
 static DEFINE_PER_CPU(struct clock_event_device, gic_clockevent_device);
 static int gic_timer_irq;
 static unsigned int gic_frequency;
+static unsigned int gic_count_width;
 static bool __read_mostly gic_clock_unstable;
=20
 static void gic_clocksource_unstable(char *reason);
@@ -186,15 +187,14 @@ static void gic_clocksource_unstable(char *reason)
=20
 static int __init __gic_clocksource_init(void)
 {
-	unsigned int count_width;
 	int ret;
=20
 	/* Set clocksource mask. */
-	count_width =3D read_gic_config() & GIC_CONFIG_COUNTBITS;
-	count_width >>=3D __ffs(GIC_CONFIG_COUNTBITS);
-	count_width *=3D 4;
-	count_width +=3D 32;
-	gic_clocksource.mask =3D CLOCKSOURCE_MASK(count_width);
+	gic_count_width =3D read_gic_config() & GIC_CONFIG_COUNTBITS;
+	gic_count_width >>=3D __ffs(GIC_CONFIG_COUNTBITS);
+	gic_count_width *=3D 4;
+	gic_count_width +=3D 32;
+	gic_clocksource.mask =3D CLOCKSOURCE_MASK(gic_count_width);
=20
 	/* Calculate a somewhat reasonable rating value. */
 	if (mips_cm_revision() >=3D CM_REV_CM3 || !IS_ENABLED(CONFIG_CPU_FREQ))
@@ -264,7 +264,7 @@ static int __init gic_clocksource_of_init(struct device_n=
ode *node)
 	if (mips_cm_revision() >=3D CM_REV_CM3 || !IS_ENABLED(CONFIG_CPU_FREQ)) {
 		sched_clock_register(mips_cm_is64 ?
 				     gic_read_count_64 : gic_read_count_2x32,
-				     64, gic_frequency);
+				     gic_count_width, gic_frequency);
 	}
=20
 	return 0;

