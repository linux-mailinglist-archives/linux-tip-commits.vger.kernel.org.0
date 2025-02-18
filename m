Return-Path: <linux-tip-commits+bounces-3391-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E860A394CC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 09:15:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EDC707A1434
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Feb 2025 08:14:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D34822D4FE;
	Tue, 18 Feb 2025 08:13:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LL/6esbm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O8tfACOg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A0DD22CBC4;
	Tue, 18 Feb 2025 08:13:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739866431; cv=none; b=mQJBbakU2f726m5pJgtQ/qr/uya7YuQPNGRIpQbH999HtEl5zKwgTZwNgkQKw4bLNBTdkGKojENl8VYjKQ9f/tAGkJpmLUnPXklKEm9KftgMctBIBlJiIm3MIuR8iKorl5k1x5NHOSILOzPt10E4Xa60JYYa8R6TJMSElm/7hhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739866431; c=relaxed/simple;
	bh=sgEegrbQf/CBHE4IwX9MdWf9d+svlyypkB81b5XV78c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=SBiIoEBbsSv79F38AsofB+hzCtGB+C2g0AoH30wYyswab2QCxEyGbQbfcDL9c86jYMjLWp0D9voSLStys63RH8+gDNfb8kBwQJz6pz2clriSZNiNyRVYAr6SFXNaPq7h+Y9dnqMq2xRTlvX7BziPsZBLyCvFTgmIeMFcslEKW+g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LL/6esbm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O8tfACOg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 18 Feb 2025 08:13:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739866427;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zf6uLIgDl5RWDC+L93h12b9VqTONU8ASXKjx+MpGE3I=;
	b=LL/6esbm5xwjTlyfu6mjP19Q2FdmjjfZ4Npof7lTAJ/iHX3YvgfraYQtDntOs0IhQ/BCF5
	jntuzh45WYXBJgghr2mOqfhdXDskKhbGPhuqUjqi4qs2Elhv/Y2CfWxVHYYuxUMnwh2qTQ
	xOfCzRvaY8tB5WP/y37sDs0AjYBzTiCDjrGeifkR7s4P2yFxyFGk93erJ13b2Pod0JOO0P
	5X8hZKk1DeTD0y4Eq8sdUotlekMHVQYtaMQSppXd+hpxY8F+CdvS43AbaFzejrujK1fwrF
	PP1mTQCKUhkILcXr8EaSS+WsHkhKqRcDhWyptvJW/5Tr8Jj/Qa7zaT8KSkIc+Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739866427;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Zf6uLIgDl5RWDC+L93h12b9VqTONU8ASXKjx+MpGE3I=;
	b=O8tfACOgxiy+etAS/Thnzyv3G6fNOD2hC85aytaa46VFYNakE/ezjne7uNmq9X8CRs6kDK
	TEUIVFKv/Hgz+1AQ==
From: "tip-bot2 for Fabrizio Castro" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/renesas-rzg2l: Use local dev pointer in
 rzg2l_irqc_common_init()
Cc: Geert Uytterhoeven <geert+renesas@glider.be>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250212182034.366167-2-fabrizio.castro.jz@renesas.com>
References: <20250212182034.366167-2-fabrizio.castro.jz@renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173986642660.10177.10289558755083978145.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     dd4e17c309445eeecb8e0252ef9a519505035c27
Gitweb:        https://git.kernel.org/tip/dd4e17c309445eeecb8e0252ef9a519505035c27
Author:        Fabrizio Castro <fabrizio.castro.jz@renesas.com>
AuthorDate:    Wed, 12 Feb 2025 18:20:29 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 18 Feb 2025 09:03:51 +01:00

irqchip/renesas-rzg2l: Use local dev pointer in rzg2l_irqc_common_init()

Replace direct references to `&pdev->dev` with the local `dev` pointer
in rzg2l_irqc_common_init() to avoid redundant dereferencing.

Suggested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Link: https://lore.kernel.org/all/20250212182034.366167-2-fabrizio.castro.jz@renesas.com

---
 drivers/irqchip/irq-renesas-rzg2l.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 99e27e0..a7c3a3c 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -542,40 +542,40 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 
 	parent_domain = irq_find_host(parent);
 	if (!parent_domain) {
-		dev_err(&pdev->dev, "cannot find parent domain\n");
+		dev_err(dev, "cannot find parent domain\n");
 		return -ENODEV;
 	}
 
-	rzg2l_irqc_data = devm_kzalloc(&pdev->dev, sizeof(*rzg2l_irqc_data), GFP_KERNEL);
+	rzg2l_irqc_data = devm_kzalloc(dev, sizeof(*rzg2l_irqc_data), GFP_KERNEL);
 	if (!rzg2l_irqc_data)
 		return -ENOMEM;
 
 	rzg2l_irqc_data->irqchip = irq_chip;
 
-	rzg2l_irqc_data->base = devm_of_iomap(&pdev->dev, pdev->dev.of_node, 0, NULL);
+	rzg2l_irqc_data->base = devm_of_iomap(dev, dev->of_node, 0, NULL);
 	if (IS_ERR(rzg2l_irqc_data->base))
 		return PTR_ERR(rzg2l_irqc_data->base);
 
 	ret = rzg2l_irqc_parse_interrupts(rzg2l_irqc_data, node);
 	if (ret) {
-		dev_err(&pdev->dev, "cannot parse interrupts: %d\n", ret);
+		dev_err(dev, "cannot parse interrupts: %d\n", ret);
 		return ret;
 	}
 
-	resetn = devm_reset_control_get_exclusive(&pdev->dev, NULL);
+	resetn = devm_reset_control_get_exclusive(dev, NULL);
 	if (IS_ERR(resetn))
 		return PTR_ERR(resetn);
 
 	ret = reset_control_deassert(resetn);
 	if (ret) {
-		dev_err(&pdev->dev, "failed to deassert resetn pin, %d\n", ret);
+		dev_err(dev, "failed to deassert resetn pin, %d\n", ret);
 		return ret;
 	}
 
-	pm_runtime_enable(&pdev->dev);
-	ret = pm_runtime_resume_and_get(&pdev->dev);
+	pm_runtime_enable(dev);
+	ret = pm_runtime_resume_and_get(dev);
 	if (ret < 0) {
-		dev_err(&pdev->dev, "pm_runtime_resume_and_get failed: %d\n", ret);
+		dev_err(dev, "pm_runtime_resume_and_get failed: %d\n", ret);
 		goto pm_disable;
 	}
 
@@ -585,7 +585,7 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 					      node, &rzg2l_irqc_domain_ops,
 					      rzg2l_irqc_data);
 	if (!irq_domain) {
-		dev_err(&pdev->dev, "failed to add irq domain\n");
+		dev_err(dev, "failed to add irq domain\n");
 		ret = -ENOMEM;
 		goto pm_put;
 	}
@@ -606,9 +606,9 @@ static int rzg2l_irqc_common_init(struct device_node *node, struct device_node *
 	return 0;
 
 pm_put:
-	pm_runtime_put(&pdev->dev);
+	pm_runtime_put(dev);
 pm_disable:
-	pm_runtime_disable(&pdev->dev);
+	pm_runtime_disable(dev);
 	reset_control_assert(resetn);
 	return ret;
 }

