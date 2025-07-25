Return-Path: <linux-tip-commits+bounces-6213-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9B9D9B11C8A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 12:36:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 25C5A545D07
	for <lists+linux-tip-commits@lfdr.de>; Fri, 25 Jul 2025 10:35:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 775392ED857;
	Fri, 25 Jul 2025 10:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xKBJ0GkQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mckTdkQy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E338B2ED15C;
	Fri, 25 Jul 2025 10:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753439520; cv=none; b=OsOEu4ttITHtWVvl2GYSFAQ9guFV7ewPpHNq52RU9lm9j2PscPqpxyHvfh8m/i6TiCR7/G98mzsX3GlMF74yLu822pnEnU4Pu7T3xItMHlq/3p2ZJu3XtnVv6mLry2VPG4vr+ekm9lEKlChL9jrQx1OSpaHj7fyFrhIZyRcJhRU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753439520; c=relaxed/simple;
	bh=QUVE7vxNVLNLe0XJuE0Vir3pAFGu0G+O9UYmbQSLVd0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gwkr6aNiVIZsixdqiy1tqgF2RPCZCVsqOisjsViEoQ0f/CDrr+XDGKGtW7czilFNIabBs4FjrgmNrxE+L2MlNiO9bGAu2EknMnV0TIMEp0vv8oaTjM1C9iRmzzszf/5NxDBaysa+ZHhDRvpYMhTWyV9uc/EF3dLeeIWLCfUJjzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xKBJ0GkQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mckTdkQy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 25 Jul 2025 10:31:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1753439517;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lIm00jC5L0fCycLsLAeEQ2870mrLEGzlgjWTakXOOJY=;
	b=xKBJ0GkQG8uso3qI8MUvL9cA14i48mLcg4pADClw+3xKqRUom7P44uCgeqng7NDAOq9wBS
	kXTWN1kH+SeIaYpt+4c/GiDLBq3fLIYDLQ1tXiVqvi0OHc4Flm6VJBSQ/IHS/augGmGdlf
	sKi8iX45zPjPyTZctvLhBYnIV5F/r8rwlbPZcW3hcmlVFTPpCdWs5L+PW7dnGgBQO4qN4M
	hKgAdS9GLTe+oXThhGsDcJLxWXC2cUaoR1HMtfxIZHDw67sNwpfq8Z4Q7GdSIoYJiLZNFr
	hLz4zaxRYkZCkm2BL+3HQVRX0ysZBnGOdei5pIIBK2FQBZlGh80csRFdydKzBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1753439517;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lIm00jC5L0fCycLsLAeEQ2870mrLEGzlgjWTakXOOJY=;
	b=mckTdkQyTnY1YvZL/rR6Oa5zBoIi9qOpi+oiZTlztSBcvb3zS2vOe7QXhly2icagtyhPsr
	FSPY6nmTUlGZo8CA==
From: "tip-bot2 for Daniel Lezcano" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: timers/clocksource] clocksource/drivers/stm32-lp: Add module owner
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>, Ingo Molnar <mingo@kernel.org>,
 Will McVicker <willmcvicker@google.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250602151853.1942521-3-daniel.lezcano@linaro.org>
References: <20250602151853.1942521-3-daniel.lezcano@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175343951618.1420.13227464757830035916.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/clocksource branch of ti=
p:

Commit-ID:     d3362af84d0c3aa02d3ebd0600c3a2640b2bd06a
Gitweb:        https://git.kernel.org/tip/d3362af84d0c3aa02d3ebd0600c3a2640b2=
bd06a
Author:        Daniel Lezcano <daniel.lezcano@linaro.org>
AuthorDate:    Mon, 02 Jun 2025 17:18:46 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 25 Jul 2025 11:43:10 +02:00

clocksource/drivers/stm32-lp: Add module owner

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

