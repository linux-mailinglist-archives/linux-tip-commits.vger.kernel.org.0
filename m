Return-Path: <linux-tip-commits+bounces-3654-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 729B4A45C85
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 12:04:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2ADA0188D8A8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 11:05:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28C182153F0;
	Wed, 26 Feb 2025 11:04:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SiRNR6lv";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9BT8GozI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 424952144AE;
	Wed, 26 Feb 2025 11:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567845; cv=none; b=k/mf+csLDY8qU79rXOjJDNtREyEuYfxpTQbxA3CKTy5Xqjuj5zU0ldYM1yofFje7GjTSRaQeabs+2Yuqja80SD4j13TtYfsDHBNjzT+HfEaWwV5Vuu4NN/hUOpNIE4GroYzWVpY1554FEh8cCYERU3B8Rg7fPvjlGG1MDR3F9Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567845; c=relaxed/simple;
	bh=i0JbDEhKUuwcsCS8apFYA7pqOXTE/MLxPFgwO3tCncY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XX7poi0e/KaulU1defmnpJX9zBCsw+K1eAZkZ+xkJeFxIQ0C4UgCWvx7ZlCMt0aw2IYtfyvsaTnknpueMbkg81j3YRQ6WS5lpaW2N556axejBV0myeE25HLI8HNiukm0W2J+OScZv/6SA318d2W+EiqewAgpadgNdCcY39glER4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SiRNR6lv; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9BT8GozI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 11:04:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740567841;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6y52O6JIXZb1KRaGSBSfg8olnNEM+PQeId7emdr1qh4=;
	b=SiRNR6lvcia4yO0zszK3fk5Ft388yBnt8Juq/FxjH54iDB7y9u4lgNbt74i1/PEx5OBM5d
	80kWWYuWWWztVkK5gtufpeAdDHWoBcvXMB2aN72x3iIKfDK6Fi6Ux9E8ao8XC54d0X40HF
	vYtea0+KFiKhr0GTUv73VOU7q3eD6/RN6exzBVr9PSPoNVnbdWrwpvTAbBQjCB4yaJoJIV
	ccVh6nVVCwK9go3AKC7lyKq/juaVCAgI4HnhlXfTTDprrS/mHkHfHL7d24SsMv5NAG65vV
	lY/ruWDB07ZLzNXCq+DhDcqXnrixDDFPfaTBpvYzUsGn8MURhZ4QJVix8Jz95Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740567841;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6y52O6JIXZb1KRaGSBSfg8olnNEM+PQeId7emdr1qh4=;
	b=9BT8GozI0U5AW9e2f6ckmLsQJzWlkDMyzcrkRJAmi/WIWU3Oz7jp/c2u8jRmj8RHWANcFh
	kk/H9LhC050O4rDA==
From: "tip-bot2 for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/renesas-rzv2h: Simplify rzv2h_icu_init()
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Philipp Zabel <p.zabel@pengutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250224131253.134199-5-biju.das.jz@bp.renesas.com>
References: <20250224131253.134199-5-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174056784138.10177.1970739751899434367.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     f5de95438834a3bc3ad747f67c9da93cd08e5008
Gitweb:        https://git.kernel.org/tip/f5de95438834a3bc3ad747f67c9da93cd08e5008
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Mon, 24 Feb 2025 13:11:20 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 26 Feb 2025 11:59:49 +01:00

irqchip/renesas-rzv2h: Simplify rzv2h_icu_init()

Use devm_add_action_or_reset() for calling put_device in error path of
rzv2h_icu_init() to simplify the code by using the recently added devm_*
helpers.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Link: https://lore.kernel.org/all/20250224131253.134199-5-biju.das.jz@bp.renesas.com

---
 drivers/irqchip/irq-renesas-rzv2h.c | 37 ++++++++++++++--------------
 1 file changed, 19 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index 0573062..d724f32 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -419,6 +419,11 @@ static int rzv2h_icu_parse_interrupts(struct rzv2h_icu_priv *priv, struct device
 	return 0;
 }
 
+static void rzv2h_icu_put_device(void *data)
+{
+	put_device(data);
+}
+
 static int rzv2h_icu_init(struct device_node *node, struct device_node *parent)
 {
 	struct irq_domain *irq_domain, *parent_domain;
@@ -431,41 +436,39 @@ static int rzv2h_icu_init(struct device_node *node, struct device_node *parent)
 	if (!pdev)
 		return -ENODEV;
 
+	ret = devm_add_action_or_reset(&pdev->dev, rzv2h_icu_put_device,
+				       &pdev->dev);
+	if (ret < 0)
+		return ret;
+
 	parent_domain = irq_find_host(parent);
 	if (!parent_domain) {
 		dev_err(&pdev->dev, "cannot find parent domain\n");
-		ret = -ENODEV;
-		goto put_dev;
+		return -ENODEV;
 	}
 
 	rzv2h_icu_data = devm_kzalloc(&pdev->dev, sizeof(*rzv2h_icu_data), GFP_KERNEL);
-	if (!rzv2h_icu_data) {
-		ret = -ENOMEM;
-		goto put_dev;
-	}
+	if (!rzv2h_icu_data)
+		return -ENOMEM;
 
 	rzv2h_icu_data->base = devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, NULL);
-	if (IS_ERR(rzv2h_icu_data->base)) {
-		ret = PTR_ERR(rzv2h_icu_data->base);
-		goto put_dev;
-	}
+	if (IS_ERR(rzv2h_icu_data->base))
+		return PTR_ERR(rzv2h_icu_data->base);
 
 	ret = rzv2h_icu_parse_interrupts(rzv2h_icu_data, node);
 	if (ret) {
 		dev_err(&pdev->dev, "cannot parse interrupts: %d\n", ret);
-		goto put_dev;
+		return ret;
 	}
 
 	resetn = devm_reset_control_get_exclusive(&pdev->dev, NULL);
-	if (IS_ERR(resetn)) {
-		ret = PTR_ERR(resetn);
-		goto put_dev;
-	}
+	if (IS_ERR(resetn))
+		return PTR_ERR(resetn);
 
 	ret = reset_control_deassert(resetn);
 	if (ret) {
 		dev_err(&pdev->dev, "failed to deassert resetn pin, %d\n", ret);
-		goto put_dev;
+		return ret;
 	}
 
 	pm_runtime_enable(&pdev->dev);
@@ -496,8 +499,6 @@ pm_put:
 pm_disable:
 	pm_runtime_disable(&pdev->dev);
 	reset_control_assert(resetn);
-put_dev:
-	put_device(&pdev->dev);
 
 	return ret;
 }

