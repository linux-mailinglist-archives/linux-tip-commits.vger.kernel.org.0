Return-Path: <linux-tip-commits+bounces-6773-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DD98BA19F3
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 23:42:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3EC2F179C58
	for <lists+linux-tip-commits@lfdr.de>; Thu, 25 Sep 2025 21:42:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECA893314B0;
	Thu, 25 Sep 2025 21:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zV0c6Yms";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="El6kdvzt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E52E330D25;
	Thu, 25 Sep 2025 21:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758836042; cv=none; b=TJRgf54RYGE50Pw4exByLoxNhzZJ24OGXLqnF1E0NiKHRtO1vRHYznJzzNSSwRH1jFxUBmtknVD6Cti2NLmeYrUsySVk+P8seNAHTsZgJdmWG3fMC3o3rBkPCdyTzmRvH85BbuWDg1A6otOm1j5SQtIys5h/EMTh4XqoNavcTzo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758836042; c=relaxed/simple;
	bh=K6ZeBETpN6r9GB5d8iad0NJBPhsWo2vRo1MEFh1qMxI=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=LvtwKvF3n9pESc7pOga7CDIKrHRXOE6op7VvrMrtkAXP+I/r0N6e7feBGNMLAAf1djwy4wCtp4whMpXoT3/LvnKMh76sR9ZLeExbiRMkl+6W5sS7DcUG/GvAR3k6pk08QNRGbZNHiNJtmgCUjokp7CDrZ60k2u8LuGgV3Fx4mno=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zV0c6Yms; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=El6kdvzt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 25 Sep 2025 21:33:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758836039;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=bwgr/POSn8nSbDmqpS4qSRXJ8wYgFB0elTPl4ItMNBg=;
	b=zV0c6YmsXKQWW9tOfV8E/rjjHLm2+IQL5eq63MwrN36+gXghYw/ILaJU1+3qElWsCKCm9G
	QWGMrLhWfc6FyhGXWBGgxicS+73MMI3RxO8m0cHhgJPf5SHG7ZK27HBjArJxLUqEsQivJd
	2RkBaNog+wqIgx+4v7aQN4JRZO9XLoDna8vLAjfcyxboQ6OgO9575G0W26Reu0KItdkiId
	aS7NIRTj1w/cF96DXkwZDNINC56SLY/e90aPBqEl/B/WlTWRR0ZUdJuGH6KI3YvAbSksN4
	tsDp727NmFemDE3bB5fV9kOLe9dNWKbbpyYg5KuuwC3Q43b/omeu/PVkZdRzqQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758836039;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=bwgr/POSn8nSbDmqpS4qSRXJ8wYgFB0elTPl4ItMNBg=;
	b=El6kdvztPcpYsGYdFG1SuJFVtcCqx+Wkk9SzA5cpsqcvKF2ErHxHkjRxSEM3EOGjZfvUpm
	z+MlZG4eEaUL3DDg==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/clocksource] clocksource/drivers/stm32-lp: Add module owner
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>,
 Will McVicker <willmcvicker@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175883603847.709179.15375957761146408354.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     2cf51ab7f5c52f11dc12a11055f4b628121802d9
Gitweb:        https://git.kernel.org/tip/2cf51ab7f5c52f11dc12a11055f4b628121=
802d9
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 02 Jun 2025 17:18:46 +02:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Tue, 23 Sep 2025 10:51:21 +02:00

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

Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Reviewed-by: Will McVicker <willmcvicker@google.com>
Link: https://lore.kernel.org/r/20250602151853.1942521-3-daniel.lezcano@linar=
o.org
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

