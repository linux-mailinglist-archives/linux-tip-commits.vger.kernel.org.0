Return-Path: <linux-tip-commits+bounces-2196-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F348A96FB99
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Sep 2024 20:57:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AA4E1C21007
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Sep 2024 18:57:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 15B3E1D79AE;
	Fri,  6 Sep 2024 18:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xotSF+5r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Sz3I+WOt"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EA611D31B7;
	Fri,  6 Sep 2024 18:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725649020; cv=none; b=eQ0E7VpFDV786drZxRCevEL3pekmwpxI5qxpCDe4Ce2GwPXxgu5dBFVF9MykbAWC7RwK9F5ut+6WzmwDr1dH+4VrdaPSLMzw74xIbaP1BbSlYB/5UGxceZ3+tLOVtcSr9lS/j3mWqdurA7vETDdYjNs0PHhHzvJCWSr4DpAu+TQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725649020; c=relaxed/simple;
	bh=1HDH7R6c6qmE9Fgu4KPVV3P4i3oo9Sa6UGFJGXXX3TI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=b0FahmHDaNXHpoeSyZJS50eKDiHoFoLqX5slh91AbMqKtK2+MCDKOJT3tgciYojBVd6lrQlTXXX1sMoYbavw10JLSvJvrUHxOlUjq5O0e2VoYqRHF/TKRkzGoMVDDHSIPybaT9/jz/3/8/GZ2CC2GvcWbGh8NUGJQ44RBXdqlDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xotSF+5r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Sz3I+WOt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Sep 2024 18:56:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725649016;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Z9xRBRU3V3BRIEAn5EJgfQ8ANFG4hKyqRQ0VjN2FNE=;
	b=xotSF+5rzZ68VXvibvrh3LONUpIZ0g7yln4RSkh4BJ0QNBetURBQeFA0DIWaITDHaOj/jl
	DokXtPMKh13b9VqhSQjclo40TwOUe6W1aX+Fn5AadNg3ohAw9CTOPGJsJR1AgOJKFNBtJ9
	10DSyQoE/cwR4CurB6iN12nKI1NG/iZ12C3R4/5/XNF3pU+t8idpZzyv7dtZCvF3q/8Ygt
	W6GAhx8du45j221JllSm0+MTxrTXQSfYshfpdi4TeQo2Khcdtr0evSEwjk+XFybH6bFqNg
	7+DspuDWqOtjmcVbZzdUKmrxlMZutFvyux8C0v2pZi2rbs3TWB5uGypENjj9pQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725649016;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0Z9xRBRU3V3BRIEAn5EJgfQ8ANFG4hKyqRQ0VjN2FNE=;
	b=Sz3I+WOt0W3JoLg4xk4h0zgFZN4ieiAeg7IElUkMW6qeV0A8By6QuKhtpFIiFZUCqTY4vG
	jIMt54DIp91i/sBg==
From: "tip-bot2 for Huan Yang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/ingenic: Use
 devm_clk_get_enabled() helpers
Cc: Huan Yang <link@vivo.com>, Daniel Lezcano <daniel.lezcano@linaro.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240820094603.103598-1-link@vivo.com>
References: <20240820094603.103598-1-link@vivo.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172564901581.2215.8921551160088262226.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     414b2fb4bb5aa09f39262c24ed90b831d18ff984
Gitweb:        https://git.kernel.org/tip/414b2fb4bb5aa09f39262c24ed90b831d18ff984
Author:        Huan Yang <link@vivo.com>
AuthorDate:    Tue, 20 Aug 2024 17:46:03 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Fri, 06 Sep 2024 14:49:20 +02:00

clocksource/drivers/ingenic: Use devm_clk_get_enabled() helpers

The devm_clk_get_enabled() helpers:
    - call devm_clk_get()
    - call clk_prepare_enable() and register what is needed in order to
     call clk_disable_unprepare() when needed, as a managed resource.

This simplifies the code and avoids the calls to clk_disable_unprepare().

Signed-off-by: Huan Yang <link@vivo.com>
Link: https://lore.kernel.org/r/20240820094603.103598-1-link@vivo.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/ingenic-ost.c | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/drivers/clocksource/ingenic-ost.c b/drivers/clocksource/ingenic-ost.c
index 9f7c280..e0ec333 100644
--- a/drivers/clocksource/ingenic-ost.c
+++ b/drivers/clocksource/ingenic-ost.c
@@ -93,14 +93,10 @@ static int __init ingenic_ost_probe(struct platform_device *pdev)
 		return PTR_ERR(map);
 	}
 
-	ost->clk = devm_clk_get(dev, "ost");
+	ost->clk = devm_clk_get_enabled(dev, "ost");
 	if (IS_ERR(ost->clk))
 		return PTR_ERR(ost->clk);
 
-	err = clk_prepare_enable(ost->clk);
-	if (err)
-		return err;
-
 	/* Clear counter high/low registers */
 	if (soc_info->is64bit)
 		regmap_write(map, TCU_REG_OST_CNTL, 0);
@@ -129,7 +125,6 @@ static int __init ingenic_ost_probe(struct platform_device *pdev)
 	err = clocksource_register_hz(cs, rate);
 	if (err) {
 		dev_err(dev, "clocksource registration failed");
-		clk_disable_unprepare(ost->clk);
 		return err;
 	}
 

