Return-Path: <linux-tip-commits+bounces-5291-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E52CAAC5E6
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 15:26:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8255C17BFBC
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 13:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF847286426;
	Tue,  6 May 2025 13:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Dot9lQgD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tls2X1bB"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B8E72853E5;
	Tue,  6 May 2025 13:20:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746537633; cv=none; b=qmWORDAGsMaE1Bb0buUQyRaEL6JcaxbG2NJLURyUo0xCFeGST2u87uDqWaY72KRbJOLoU9E/AJ2MZgR6d5upFV5NPbrqmXWIovFqsw9imrvVdvNSPZBUPIPR0+X34YrbbVUI2sjAxqHfTGTUr+a/asaBxq28QABKCugjVrUpUGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746537633; c=relaxed/simple;
	bh=zHQccy8K0H39gbNf+QKOfgpx0HCVZEWs196kRhwvvt0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YQF0efSGM9FAV0Uf4Dax5jdVFzT/tZDMPkLfh4ZU9ZoUZUGFTVQuEFOnxnklhGvzKmhe5ZbaRHCEQhONPDm1igSdEdYRwWwwp2p5NVJuql3z+/O9QM9hFODjr00s+0+mdnZ7z1nNi+wa/kXTxRIxb76RBpzSzw7qcL3IZjEhvaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Dot9lQgD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tls2X1bB; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 13:20:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746537628;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0FR4uuv1HnRToR7R+VI6hwkfPd9sVxNRpl0W8M6GZDc=;
	b=Dot9lQgDWEov/217Q7T6IOspYlXVtPJn95BFAmA91FUgq3oZFSpGIgTaoZ70awgfmIRGAd
	+vT7/fhKoBQWpGehtFuhUOnJF7xitRG2aBSGHrKheob+o4sYvlun3joWF55wcd73znqY5C
	x4juY+ARMYYDZu8jm+PBXab99fSUFlh0yAg9gHtBvOF015B1Ai3165qb4HM1Ic05ASKeIM
	s5d0kR/l/DgEr2Zh+FE/W91e57U1AvR192ah1E32lTUI49uY5O3SjG5ql1kgqEEElUp1Iz
	3hpJ3Qc8F120uaK2F4KLqAvuUQDUEpR7UCv+mU5w5X6m6k8Dpp93CprfBEWRKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746537628;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0FR4uuv1HnRToR7R+VI6hwkfPd9sVxNRpl0W8M6GZDc=;
	b=tls2X1bBCQGKlqSOI3tthUX/rTNcx7QiXUe1xukLvwlXUd14L3IrWCjsjQG4dacPRgM0oN
	UinItnrtGfhIWVAA==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] pinctrl: Switch to irq_domain_create_*()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Linus Walleij <linus.walleij@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-31-jirislaby@kernel.org>
References: <20250319092951.37667-31-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174653762746.406.13838760570127669529.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     bd7d1603347f36c16ca7f6df42cdb0f95c45ce02
Gitweb:        https://git.kernel.org/tip/bd7d1603347f36c16ca7f6df42cdb0f95c45ce02
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:23 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 May 2025 14:59:06 +02:00

pinctrl: Switch to irq_domain_create_*()

irq_domain_add_*() interfaces are going away as being obsolete now.
Switch to the preferred irq_domain_create_*() ones. Those differ in the
node parameter: They take more generic struct fwnode_handle instead of
struct device_node. Therefore, of_fwnode_handle() is added around the
original parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/all/20250319092951.37667-31-jirislaby@kernel.org

---
 drivers/pinctrl/mediatek/mtk-eint.c   |  5 ++---
 drivers/pinctrl/pinctrl-at91-pio4.c   |  2 +-
 drivers/pinctrl/pinctrl-single.c      |  9 +++++----
 drivers/pinctrl/sunxi/pinctrl-sunxi.c |  7 +++----
 4 files changed, 11 insertions(+), 12 deletions(-)

diff --git a/drivers/pinctrl/mediatek/mtk-eint.c b/drivers/pinctrl/mediatek/mtk-eint.c
index ced4ee5..8bbe2aa 100644
--- a/drivers/pinctrl/mediatek/mtk-eint.c
+++ b/drivers/pinctrl/mediatek/mtk-eint.c
@@ -565,9 +565,8 @@ int mtk_eint_do_init(struct mtk_eint *eint)
 			goto err_eint;
 	}
 
-	eint->domain = irq_domain_add_linear(eint->dev->of_node,
-					     eint->hw->ap_num,
-					     &irq_domain_simple_ops, NULL);
+	eint->domain = irq_domain_create_linear(of_fwnode_handle(eint->dev->of_node),
+						eint->hw->ap_num, &irq_domain_simple_ops, NULL);
 	if (!eint->domain)
 		goto err_eint;
 
diff --git a/drivers/pinctrl/pinctrl-at91-pio4.c b/drivers/pinctrl/pinctrl-at91-pio4.c
index 8b01d31..e57ac4e 100644
--- a/drivers/pinctrl/pinctrl-at91-pio4.c
+++ b/drivers/pinctrl/pinctrl-at91-pio4.c
@@ -1206,7 +1206,7 @@ static int atmel_pinctrl_probe(struct platform_device *pdev)
 		dev_dbg(dev, "bank %i: irq=%d\n", i, ret);
 	}
 
-	atmel_pioctrl->irq_domain = irq_domain_add_linear(dev->of_node,
+	atmel_pioctrl->irq_domain = irq_domain_create_linear(of_fwnode_handle(dev->of_node),
 			atmel_pioctrl->gpio_chip->ngpio,
 			&irq_domain_simple_ops, NULL);
 	if (!atmel_pioctrl->irq_domain)
diff --git a/drivers/pinctrl/pinctrl-single.c b/drivers/pinctrl/pinctrl-single.c
index 5be14dc..5cda620 100644
--- a/drivers/pinctrl/pinctrl-single.c
+++ b/drivers/pinctrl/pinctrl-single.c
@@ -1611,15 +1611,16 @@ static int pcs_irq_init_chained_handler(struct pcs_device *pcs,
 
 	/*
 	 * We can use the register offset as the hardirq
-	 * number as irq_domain_add_simple maps them lazily.
+	 * number as irq_domain_create_simple maps them lazily.
 	 * This way we can easily support more than one
 	 * interrupt per function if needed.
 	 */
 	num_irqs = pcs->size;
 
-	pcs->domain = irq_domain_add_simple(np, num_irqs, 0,
-					    &pcs_irqdomain_ops,
-					    pcs_soc);
+	pcs->domain = irq_domain_create_simple(of_fwnode_handle(np),
+					       num_irqs, 0,
+					       &pcs_irqdomain_ops,
+					       pcs_soc);
 	if (!pcs->domain) {
 		irq_set_chained_handler(pcs_soc->irq, NULL);
 		return -EINVAL;
diff --git a/drivers/pinctrl/sunxi/pinctrl-sunxi.c b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
index f1c5a99..bf8612d 100644
--- a/drivers/pinctrl/sunxi/pinctrl-sunxi.c
+++ b/drivers/pinctrl/sunxi/pinctrl-sunxi.c
@@ -1646,10 +1646,9 @@ int sunxi_pinctrl_init_with_flags(struct platform_device *pdev,
 		}
 	}
 
-	pctl->domain = irq_domain_add_linear(node,
-					     pctl->desc->irq_banks * IRQ_PER_BANK,
-					     &sunxi_pinctrl_irq_domain_ops,
-					     pctl);
+	pctl->domain = irq_domain_create_linear(of_fwnode_handle(node),
+						pctl->desc->irq_banks * IRQ_PER_BANK,
+						&sunxi_pinctrl_irq_domain_ops, pctl);
 	if (!pctl->domain) {
 		dev_err(&pdev->dev, "Couldn't register IRQ domain\n");
 		ret = -ENOMEM;

