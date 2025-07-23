Return-Path: <linux-tip-commits+bounces-6186-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 593D6B0EBCB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 09:22:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C0DA858215F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 23 Jul 2025 07:21:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED9B427380E;
	Wed, 23 Jul 2025 07:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FOCJE/yt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LDz1YCvz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7461278E79;
	Wed, 23 Jul 2025 07:17:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753255067; cv=none; b=M3wBOjmzc9b/c5Fva9qvVyYg/Bi3F2zrhrWe3wYfReCcHEkLP/4Vep6kvS7XAZVNyw7OScdzdYwhtRk8pZUQXAOOq3+Au0VVAGQXUF0VPGxXss3UMBQj4IhiMz/81kKbRorlIpNFWBgXmjoPWHvFeMwhxU4Qv3J8wjD1dWi11lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753255067; c=relaxed/simple;
	bh=mzug451MBLZ5+3xuXl4XTHOGDdxwLxBu2OHbkaMWrGU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=KwuTN+lrjqwrTFMD/CpGVfWtcjniwb2uxtshn7yfiTwWxaET0pr/mb8I8kbDN+izX7dAL7Sr0fgl146ss+Y8sp2roaMcr3oPmcuWXn+SbTgU2VFfxD4kuw7kaYyxdnwnLktWgYRlSB4+rmW4AQLr7umgUeIy2ZlsmZHG27v+V4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FOCJE/yt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LDz1YCvz; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 23 Jul 2025 07:17:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753255063;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cun61dPKFZQ2jMSHadeCmHKuqS4II+ZH7MMj6Dy8CwU=;
	b=FOCJE/yt+bN19hKRnzSbsqUFyKoeuhPf0mld1TlVRi4Pcn/Nlg5NjJUhd+RyrCD4Wy3lzg
	zM7MZ4jC5CZueuB83ihaFIR6YufIuSVrBjzupJmUNxBzZnmP4zmb+IgHTdO9DlVJMq0TSS
	+0P7dSVgAgUSenPdJALNC/GMbmZizTh5xrZ1cfRnd9BD/GYVZ4ybLZRxQBlyhfbCIp+tsN
	6dugTBxN6D2yp3pEqUutG3HA1VyRV5vQ7ijxbjb9vAlAd65Ht4cVw3+7Q0/sLTAMlTt30z
	ut1li/B9KoNe1Lm75uHqwSMI37fLx1Iheiq/tk6FG5BRstzoby8qhy+VB8Q6qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753255063;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cun61dPKFZQ2jMSHadeCmHKuqS4II+ZH7MMj6Dy8CwU=;
	b=LDz1YCvz1F2ZS5+cYyzeN3gGisSvRWf03MP8JDGCS0JXVLVbvfIdvVKJyHdBX8RxTpjxus
	uXwBsN4T7Pt47KAQ==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/clocksource] clocksource/drivers/stm32-lp: Add module owner
Cc: Will McVicker <willmcvicker@google.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250602151853.1942521-3-daniel.lezcano@linaro.org>
References: <20250602151853.1942521-3-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175325506177.1420.16804740606393769065.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     0625a7e5e34e952352bc81a305e5308c0a9cafcd
Gitweb:        https://git.kernel.org/tip/0625a7e5e34e952352bc81a305e5308c0a9=
cafcd
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 02 Jun 2025 17:18:46 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Thu, 10 Jul 2025 11:28:29 +02:00

clocksource/drivers/stm32-lp: Add module owner

The conversion to modules requires a correct handling of the module
refcount in order to prevent to unload it if it is in use. That is
especially true with the clockevents where there is no function to
unregister them.

The core time framework correctly handles the module refcount with the
different clocksource and clockevents if the module owner is set.

Add the module owner to make sure the core framework will prevent
stupid things happening when the driver will be converted into a
module.

Reviewed-by: Will McVicker <willmcvicker@google.com>
Link: https://lore.kernel.org/r/20250602151853.1942521-3-daniel.lezcano@linar=
o.org
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-stm32-lp.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clocksource/timer-stm32-lp.c b/drivers/clocksource/timer=
-stm32-lp.c
index 6e7944f..c2a699f 100644
--- a/drivers/clocksource/timer-stm32-lp.c
+++ b/drivers/clocksource/timer-stm32-lp.c
@@ -211,6 +211,7 @@ static void stm32_clkevent_lp_init(struct stm32_lp_privat=
e *priv,
 	priv->clkevt.rating =3D STM32_LP_RATING;
 	priv->clkevt.suspend =3D stm32_clkevent_lp_suspend;
 	priv->clkevt.resume =3D stm32_clkevent_lp_resume;
+	priv->clkevt.owner =3D THIS_MODULE;
=20
 	clockevents_config_and_register(&priv->clkevt, rate, 0x1,
 					STM32_LPTIM_MAX_ARR);

