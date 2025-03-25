Return-Path: <linux-tip-commits+bounces-4442-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 55499A6EB45
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 09:15:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 927F67A231D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Mar 2025 08:14:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5689A254B05;
	Tue, 25 Mar 2025 08:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="23j3chQG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OcDBMnPL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8393B253B75;
	Tue, 25 Mar 2025 08:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742890501; cv=none; b=JPiB13ZRvlWa4SrTJnkSCZ4hgvlG3wbj2CZOOrEYA9sBJgl0Y2fGNHZBWuChxwqCGVz8WwQ6hQEGz5IrAmbXP3MeG5FCYm0AtzyIHrrJnsi6Aik1FIO5L2/JdWGHX5OZDzQv9/qbMdOpZRPjB0lwxPDw0nYjBssTjggzBEJbLcI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742890501; c=relaxed/simple;
	bh=n3Hkj9GXk8T8JSu7puwp9IEx1qKJwWLOpAcDRXf0pg0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=EVjbjwU/mdErgmX4ZGxwJeP/zYy2+aW1CtXSGXDnAgcwR1/LmTX9157bpMDx+rv8QZPkn54M/uFh53KCssGkywjrqckQARB/s6HpwOEt6YMPZCQ84F9nT6hVHFG1KDm9SnW7RaCOgi86Avhix5GVnu0Qs2PjV1qSgsV1szcPNYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=23j3chQG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OcDBMnPL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Mar 2025 08:14:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742890497;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y8DLTmMbVlrE2q3VTVqRBEQCZOJ1j8JD30B1rwKAwFc=;
	b=23j3chQGRP7iT0DE/QQw3/iMqpIKFwoSYHJ22yhpd0BIuGvR3pwjrlG2nPkaxEpUnpK6m4
	bWDlmYRA7wNJoEO4q0rLXjZa8CnXHL8UXLDCErKDuAPVP1s6DEZ4QcpI0i2G6YzYgmGeXF
	9GYN7mxzfzJeEfFRxtxzXJeKx0qf84MltcncFynWsv78paceuT2zDEaAarJAjTl2m87/Hy
	tcpCOF+OuVUAFeUlPvwCGRh+AqIVSZLLH7TCeJBg+c4H6fL9B74RTUGNRB0OmylHlvz+9r
	nOsII2e9SbyZb2dlvmn6Fbqg1rDgYc8kGKlnLNylgKrcI4bFITcxG1uk4SOPjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742890497;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y8DLTmMbVlrE2q3VTVqRBEQCZOJ1j8JD30B1rwKAwFc=;
	b=OcDBMnPL5hYDUfxTE8Ti4mMGygtz+2HdWmpjPrxYxuoOIUOB7GThDcZtVXk+QGaI74IKZr
	S0MGVmEOsCsF7pCw==
From: "tip-bot2 for Fabrice Gasnier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/clocksource] clocksource/drivers/stm32-lptimer: Add
 support for suspend / resume
Cc: Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250224172101.3448398-1-fabrice.gasnier@foss.st.com>
References: <20250224172101.3448398-1-fabrice.gasnier@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174289049655.14745.14404132618754439342.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/clocksource branch of tip:

Commit-ID:     b5a497a7972a49c31d39b057f86dd6f58b882a72
Gitweb:        https://git.kernel.org/tip/b5a497a7972a49c31d39b057f86dd6f58b882a72
Author:        Fabrice Gasnier <fabrice.gasnier@foss.st.com>
AuthorDate:    Mon, 24 Feb 2025 18:21:01 +01:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 07 Mar 2025 17:55:59 +01:00

clocksource/drivers/stm32-lptimer: Add support for suspend / resume

Add support for power management on STM32 LPTIMER clocksource driver:
- Upon clockevents_suspend(), shutdown the LPTIMER, and balance the
clk_prepare_enable() from the probe routine.
- Upon clockevents_resume(), restore the prescaler that may have been lost
during low power mode, and restore the clock.

Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Link: https://lore.kernel.org/r/20250224172101.3448398-1-fabrice.gasnier@foss.st.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-stm32-lp.c | 32 ++++++++++++++++++++++++---
 1 file changed, 29 insertions(+), 3 deletions(-)

diff --git a/drivers/clocksource/timer-stm32-lp.c b/drivers/clocksource/timer-stm32-lp.c
index a4c9516..9cd487d 100644
--- a/drivers/clocksource/timer-stm32-lp.c
+++ b/drivers/clocksource/timer-stm32-lp.c
@@ -24,7 +24,9 @@ struct stm32_lp_private {
 	struct regmap *reg;
 	struct clock_event_device clkevt;
 	unsigned long period;
+	u32 psc;
 	struct device *dev;
+	struct clk *clk;
 };
 
 static struct stm32_lp_private*
@@ -120,6 +122,27 @@ static void stm32_clkevent_lp_set_prescaler(struct stm32_lp_private *priv,
 	/* Adjust rate and period given the prescaler value */
 	*rate = DIV_ROUND_CLOSEST(*rate, (1 << i));
 	priv->period = DIV_ROUND_UP(*rate, HZ);
+	priv->psc = i;
+}
+
+static void stm32_clkevent_lp_suspend(struct clock_event_device *clkevt)
+{
+	struct stm32_lp_private *priv = to_priv(clkevt);
+
+	stm32_clkevent_lp_shutdown(clkevt);
+
+	/* balance clk_prepare_enable() from the probe */
+	clk_disable_unprepare(priv->clk);
+}
+
+static void stm32_clkevent_lp_resume(struct clock_event_device *clkevt)
+{
+	struct stm32_lp_private *priv = to_priv(clkevt);
+
+	clk_prepare_enable(priv->clk);
+
+	/* restore prescaler */
+	regmap_write(priv->reg, STM32_LPTIM_CFGR, priv->psc << CFGR_PSC_OFFSET);
 }
 
 static void stm32_clkevent_lp_init(struct stm32_lp_private *priv,
@@ -134,6 +157,8 @@ static void stm32_clkevent_lp_init(struct stm32_lp_private *priv,
 	priv->clkevt.set_state_oneshot = stm32_clkevent_lp_set_oneshot;
 	priv->clkevt.set_next_event = stm32_clkevent_lp_set_next_event;
 	priv->clkevt.rating = STM32_LP_RATING;
+	priv->clkevt.suspend = stm32_clkevent_lp_suspend;
+	priv->clkevt.resume = stm32_clkevent_lp_resume;
 
 	clockevents_config_and_register(&priv->clkevt, rate, 0x1,
 					STM32_LPTIM_MAX_ARR);
@@ -151,11 +176,12 @@ static int stm32_clkevent_lp_probe(struct platform_device *pdev)
 		return -ENOMEM;
 
 	priv->reg = ddata->regmap;
-	ret = clk_prepare_enable(ddata->clk);
+	priv->clk = ddata->clk;
+	ret = clk_prepare_enable(priv->clk);
 	if (ret)
 		return -EINVAL;
 
-	rate = clk_get_rate(ddata->clk);
+	rate = clk_get_rate(priv->clk);
 	if (!rate) {
 		ret = -EINVAL;
 		goto out_clk_disable;
@@ -191,7 +217,7 @@ static int stm32_clkevent_lp_probe(struct platform_device *pdev)
 	return 0;
 
 out_clk_disable:
-	clk_disable_unprepare(ddata->clk);
+	clk_disable_unprepare(priv->clk);
 	return ret;
 }
 

