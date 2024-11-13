Return-Path: <linux-tip-commits+bounces-2849-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6016F9C7CC4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Nov 2024 21:21:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF97E284195
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Nov 2024 20:20:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA89420515C;
	Wed, 13 Nov 2024 20:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R5F2DTRT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YHO0x4xL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 431BF189F45;
	Wed, 13 Nov 2024 20:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731529251; cv=none; b=Qtlkp6TFQLkIyb1yWmkWl48vN55myaVX2vvhHL2f17xIqgc/EYdaBBYbLmjt+Ab33uuomlTrFRET/y7r1qpE00chnWPBAOwr3tHHdDGPKwA7Ff8ecsEMNLgQ4w03YPcxKDKjdmxouLg7/z1s0bRLSns0f5VKzk47T2cTX8f3Bzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731529251; c=relaxed/simple;
	bh=p1H96Bhplds83omDT/YPji/mHXjMTksUho2z+q99F7E=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eMy9JsYQzExIq2XAL/nJzRJ/r+LiLXl6o4A/mq/dpVGmzz42sv5xdarL/rq7vmmIXpEQ8J7gOkxqM460Q1/xKg/lCatgPSNC4sj69YV6JK8TsMMICHcqlkV4AIhh5dNJOr1zjecYc2uP6ZzmMMonh6wafKPNfxziATxfcm1+WhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R5F2DTRT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YHO0x4xL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Nov 2024 20:20:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731529248;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I78lINxnzLCP9XiVOme2tqAnH5mS9KUoARrcuXn9e4k=;
	b=R5F2DTRT531+kllEIQF/Eoaeah8cyPAQeUtOkRW96HFQ1KRLSoW+fccm3x6ovoQpN+Cw7z
	qjum8j6j8BM0nIUmmWs5psgcUMXxQHQNP2TIoDNWQ5VdzDIh5pvCz5+yRYvgUvkPeAAy7k
	DPrkYwYWqLL7MB4mQzW1qNguImVp6VFWOMC47wBAYLb0OlrA5nO3X6DY5lLuy1fXDoV/yc
	rYtTqsnP5lS4be+/mjqIo3woqB0vQRyzZo0pWVkN+c8AyAg0u2Y21WBpNomEx+G3oHtJqo
	5rz+5jmtQUpBV6/LF06YkMikgL8z92GPrsir/NS7aWDhEYMzwjOHJaapVufkMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731529248;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=I78lINxnzLCP9XiVOme2tqAnH5mS9KUoARrcuXn9e4k=;
	b=YHO0x4xLdaCEkuAL4RrA2JZS6nATcPsZPpDiMw5HHlxYONgKaEtnjcA+lZPPhye/KMbFam
	QvQ/IYJwvZm5AZDA==
From: "tip-bot2 for Tang Bin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] clocksource/drivers/gpx: Remove redundant casts
Cc: Tang Bin <tangbin@cmss.chinamobile.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241107074619.2714-1-tangbin@cmss.chinamobile.com>
References: <20241107074619.2714-1-tangbin@cmss.chinamobile.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173152924737.32228.7761447888077239146.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     5569d7348b4a927eb5a2449ddc175ec7c3930c4d
Gitweb:        https://git.kernel.org/tip/5569d7348b4a927eb5a2449ddc175ec7c3930c4d
Author:        Tang Bin <tangbin@cmss.chinamobile.com>
AuthorDate:    Thu, 07 Nov 2024 15:46:19 +08:00
Committer:     Daniel Lezcano <daniel.lezcano@linaro.org>
CommitterDate: Wed, 13 Nov 2024 13:49:33 +01:00

clocksource/drivers/gpx: Remove redundant casts

In the function gxp_timer_init, the 'int' type cast in front of the
PTR_ERR() macro is redundant, thus remove it.

Signed-off-by: Tang Bin <tangbin@cmss.chinamobile.com>
Link: https://lore.kernel.org/r/20241107074619.2714-1-tangbin@cmss.chinamobile.com
Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/clocksource/timer-gxp.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/clocksource/timer-gxp.c b/drivers/clocksource/timer-gxp.c
index 57aa2e2..48a73c1 100644
--- a/drivers/clocksource/timer-gxp.c
+++ b/drivers/clocksource/timer-gxp.c
@@ -85,7 +85,7 @@ static int __init gxp_timer_init(struct device_node *node)
 
 	clk = of_clk_get(node, 0);
 	if (IS_ERR(clk)) {
-		ret = (int)PTR_ERR(clk);
+		ret = PTR_ERR(clk);
 		pr_err("%pOFn clock not found: %d\n", node, ret);
 		goto err_free;
 	}

