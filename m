Return-Path: <linux-tip-commits+bounces-6211-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B71CFB11C89
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 12:35:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 871A21CE555B
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 10:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E912ECD0C;
	Fri, 25 Jul 2025 10:31:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w3LmZQdh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yaNWDGL7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B63CE2EBBB8;
	Fri, 25 Jul 2025 10:31:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753439517; cv=none; b=Wvcuc/AmtQLjxBV8AYOwVR1vt4PH7BF5OLx9BwNMx90i79sxb7Gin0ulGlxdLWXZH0PDRUX+v2LAVri5pAsUee2RvGEYNGGpeMP6ijbXfeoD8V68XI5jtnXDIhvZNWgRmbNPPh6L90e95FClh9S8YmIqt2feAVpXFn9Uvz6WOL8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753439517; c=relaxed/simple;
	bh=c6DXZyvnUHuyx452sWKlUVPkrzVbdd6K4XmlGQ+cYuk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UebpEniMX8sO/v7mScf15kZXmH7hqnrFpFZtMNf3SPC96enp7jIEUQ2MoihjqJ8SaicaftwF6R4FxY8WueWZzva0J7P2fZpKxwRG5KxR9k9zrCkA9TaUSo/wX+fSquvC/1VmmhuH0IkKJUCRQBMTJttTLQ1WWoF0EieaWzITpAw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w3LmZQdh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yaNWDGL7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Jul 2025 10:31:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753439514;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9XRUpkApwfKnCH8K6garaX+h1FTeOFeEOM2L3DF04g8=;
	b=w3LmZQdhuc1lBDXoBVopczl9BGRTKVolzo+03LEgjx36Rmv6dqe/2PdQp3wno7dSL8kO2b
	9rUXNTnYL16GFHcd0yqtuYcAEh67vHy7xEjVm7WBjselfFsdWH4qA6wd4tu3pjZ5rR7RU1
	hUgCSBvD13vCdqFDUjM4fulfz1gcOnXipHCBUQkSX+f1bn9LsNIJRZJS6+my1Id4SdHre7
	g4HrYV2ga2N/0N9EnWC3hP3rIXeCSr8MBqAojevcxEjLJ4hNg0p8D8CkzU/Eg1ug35eGww
	sZ1ksfLpCJWNqYoa82BXFUnpTj18CA2W+bEylVeTU6kKbQZNAT3VznvvneoTFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753439514;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9XRUpkApwfKnCH8K6garaX+h1FTeOFeEOM2L3DF04g8=;
	b=yaNWDGL7v07F/qQ2XmOlknJVtOe+/R4Kd9xXP41BjRoTSq1mWUj6VENU5kSJyWirzKiqqB
	zmv/CulRC5n6EEBQ==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/stm: Add module owner
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@kernel.org>,
 Will McVicker <willmcvicker@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250602151853.1942521-6-daniel.lezcano@linaro.org>
References: <20250602151853.1942521-6-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175343951273.1420.8610641249031154822.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     7a449b9d1dfad2a0163d4d4b0d817e09e564648e
Gitweb:        https://git.kernel.org/tip/7a449b9d1dfad2a0163d4d4b0d817e09e56=
4648e
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 02 Jun 2025 17:18:49 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 25 Jul 2025 11:43:32 +02:00

clocksource/drivers/stm: Add module owner

The conversion to modules requires a correct handling of the module
refcount in order to prevent to unload it if it is in use. That is
especially true with clockevents where there is no function to
unregister them.

The core time framework correctly handles the module refcount with the
different clocksource and clockevents if the module owner is set.

Add the module owner to make sure the core framework will prevent
stupid things happening when the driver will be converted into a
module.

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Will McVicker <willmcvicker@google.com>
Link: https://lore.kernel.org/r/20250602151853.1942521-6-daniel.lezcano@linar=
o.org
---
 drivers/clocksource/timer-nxp-stm.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/clocksource/timer-nxp-stm.c b/drivers/clocksource/timer-=
nxp-stm.c
index d7ccf90..bbc4062 100644
--- a/drivers/clocksource/timer-nxp-stm.c
+++ b/drivers/clocksource/timer-nxp-stm.c
@@ -201,6 +201,7 @@ static int __init nxp_stm_clocksource_init(struct device =
*dev, struct stm_timer=20
 	stm_timer->cs.resume =3D nxp_stm_clocksource_resume;
 	stm_timer->cs.mask =3D CLOCKSOURCE_MASK(32);
 	stm_timer->cs.flags =3D CLOCK_SOURCE_IS_CONTINUOUS;
+	stm_timer->cs.owner =3D THIS_MODULE;
=20
 	ret =3D clocksource_register_hz(&stm_timer->cs, stm_timer->rate);
 	if (ret)
@@ -314,6 +315,7 @@ static int __init nxp_stm_clockevent_per_cpu_init(struct =
device *dev, struct stm
 	stm_timer->ced.cpumask =3D cpumask_of(cpu);
 	stm_timer->ced.rating =3D 460;
 	stm_timer->ced.irq =3D irq;
+	stm_timer->ced.owner =3D THIS_MODULE;
=20
 	per_cpu(stm_timers, cpu) =3D stm_timer;
=20

