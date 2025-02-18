Return-Path: <linux-tip-commits+bounces-3387-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD8AA394D0
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:15:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 835D317314E
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 08:14:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2C2522B8BE;
	Tue, 18 Feb 2025 08:13:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ehW2l9uZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6MpFzPDg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4B41722B8A4;
	Tue, 18 Feb 2025 08:13:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866427; cv=none; b=F4PX/kyXJnwaJ/+gki/b5q6vkVHNJrM0pYzuVKOgWFI/aMEcu57UHKpQTX3PzgvIvXwRsGAO3/cg21z2rZaquBgWlrzAoa+YLZC4lT5SXu6wP8i+l2wdmEf090SVBMEc1WwQ62ToXR5aGbSR8cV0C3Dtt1PIUooawaqaP0r16PU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866427; c=relaxed/simple;
	bh=zNgU5Rs3ezAgSvPl9kxUFmMf4vUPD7cZTtOcoZb6Mfo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=jZJquvpkSj1IZvM1Q8H8wGQdI+XXOdPyvfuBsKyrcqf1JlkWnKduPMHAMhtTK3a4s2/ns0iscB5rrJ+//GjhDWK2TcQ8fBN02NLBUwUBw+oK1otWtCtNlrAb1yndrSBX+pztZ95S1ziWUWwvXdLBt4ONAd2DiZjhK7K1cVlIn0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ehW2l9uZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6MpFzPDg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 08:13:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739866424;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QlJ/OtH9+NkNJOrJkszRc+SOqFaeDdryTs8ytaah3kY=;
	b=ehW2l9uZ/Q3tBWf4yt0nHysqO9V/XRviu9lnO6uw7+ytIsTbVlibRxSM3WeyfUTOHyZqAN
	SZ4eC3AEqWcrFR8fI2Z2t7HPfLrVacdaTKYgeRO0QyOctD7a2F8P8J3mDA8I8TkUs9JSN4
	SFdZqykQi3d8XxfbwHFxhIBPPm4F3B4j+Xi6/wpeSSahV5+1KoYkhXr3IPBnK1XLC7RMGb
	b/lubx/p9/Yijhwt30EbDbCry8Cfqk8h87cTYJxsm992ltkh4VoCQaHgtUW5TZsWkyl04m
	LgtJFQ0opika+86bVHJwS3ggAWu2psho3wmm4tQQPrd05qbsB2k1Pz66Ui3DOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739866424;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QlJ/OtH9+NkNJOrJkszRc+SOqFaeDdryTs8ytaah3kY=;
	b=6MpFzPDgA/ohOgTk0Xx2R5nE2E/Ow+eRcS6PewgeeNEpzjkohMBeeS5M8egGDX8GfmwOc1
	5JFXreoQPfzkTGAA==
From: "tip-bot2 for Fabrizio Castro" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/drivers] irqchip/renesas-rzg2l: Switch to using dev_err_probe()
Cc: Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250212182034.366167-6-fabrizio.castro.jz@renesas.com>
References: <20250212182034.366167-6-fabrizio.castro.jz@renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173986642395.10177.17925006245224192403.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     4bd0317ce63c26c8a1b6e96c9be0badac749c6f7
Gitweb:        https://git.kernel.org/tip/4bd0317ce63c26c8a1b6e96c9be0badac749c6f7
Author:        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
AuthorDate:    Wed, 12 Feb 2025 18:20:33 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 09:03:52 +01:00

irqchip/renesas-rzg2l: Switch to using dev_err_probe()

Make use of dev_err_probe() to simplify rzg2l_irqc_common_init().

Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/all/20250212182034.366167-6-fabrizio.castro.jz@renesas.com

---
 drivers/irqchip/irq-renesas-rzg2l.c | 31 +++++++++-------------------
 1 file changed, 11 insertions(+), 20 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 0f325ce..8714e7f 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -541,10 +541,8 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 		return -ENODEV;
 
 	parent_domain = irq_find_host(parent);
-	if (!parent_domain) {
-		dev_err(dev, "cannot find parent domain\n");
-		return -ENODEV;
-	}
+	if (!parent_domain)
+		return dev_err_probe(dev, -ENODEV, "cannot find parent domain\n");
 
 	rzg2l_irqc_data = devm_kzalloc(dev, sizeof(*rzg2l_irqc_data), GFP_KERNEL);
 	if (!rzg2l_irqc_data)
@@ -557,28 +555,22 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 		return PTR_ERR(rzg2l_irqc_data->base);
 
 	ret = rzg2l_irqc_parse_interrupts(rzg2l_irqc_data, node);
-	if (ret) {
-		dev_err(dev, "cannot parse interrupts: %d\n", ret);
-		return ret;
-	}
+	if (ret)
+		return dev_err_probe(dev, ret, "cannot parse interrupts: %d\n", ret);
 
 	resetn = devm_reset_control_get_exclusive_deasserted(dev, NULL);
 	if (IS_ERR(resetn)) {
-		dev_err(dev, "failed to acquire deasserted reset: %d\n", ret);
-		return PTR_ERR(resetn);
+		return dev_err_probe(dev, PTR_ERR(resetn),
+				     "failed to acquire deasserted reset: %d\n", ret);
 	}
 
 	ret = devm_pm_runtime_enable(dev);
-	if (ret < 0) {
-		dev_err(dev, "devm_pm_runtime_enable failed: %d\n", ret);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "devm_pm_runtime_enable failed: %d\n", ret);
 
 	ret = pm_runtime_resume_and_get(dev);
-	if (ret < 0) {
-		dev_err(dev, "pm_runtime_resume_and_get failed: %d\n", ret);
-		return ret;
-	}
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "pm_runtime_resume_and_get failed: %d\n", ret);
 
 	raw_spin_lock_init(&rzg2l_irqc_data->lock);
 
@@ -587,8 +579,7 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 					      rzg2l_irqc_data);
 	if (!irq_domain) {
 		pm_runtime_put(dev);
-		dev_err(dev, "failed to add irq domain\n");
-		return -ENOMEM;
+		return dev_err_probe(dev, -ENOMEM, "failed to add irq domain\n");
 	}
 
 	register_syscore_ops(&rzg2l_irqc_syscore_ops);

