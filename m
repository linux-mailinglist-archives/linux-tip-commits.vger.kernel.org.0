Return-Path: <linux-tip-commits+bounces-5988-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A3CEAF7674
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 16:01:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 144137B9EA0
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 13:59:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E05CA2E8E0A;
	Thu,  3 Jul 2025 14:00:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="a3B2YVbw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/v1eXhoe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 287FA2E6D1C;
	Thu,  3 Jul 2025 14:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551234; cv=none; b=ckonvkDSWrb5zNjs0HBCIy365YZuxgAKkLPkMfrBS73AJ+MmJBBSKrJkUQy5YGClBy7z0CA1dQ0+tQTOcCGPjMNBoDnER/UaaB3wwQeNTjF+Q82m8vBjw3LLKh3RVVf5MPqz7E2VvbPrGDYDV76NlMw+qqaM7PBV5KL2DMAS8vs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551234; c=relaxed/simple;
	bh=w3J6y9KZTGPzlzgwilJvrbqpePDmNrqLWAqJzM94VE8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cJazcnE1h2ORXJAa4GhSA3Ef9NfIOz/nGNCvYVjN/NYGpEj5Lxv9KSRWWU0XsRLgQfriPrQe9LxUBxnKYO9ZgzZ7MwRT5vk0jbkkKwjHqHq/7lyadbxzCUk9r5wSfILXYezVOfizrdslCCYGYeDZWxyntXe4o914ZaJnCTTCTQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=a3B2YVbw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/v1eXhoe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Jul 2025 14:00:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751551231;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hx+rHtCsFQB+clyGWDIV1ASOnLiLATVgamexByxtQNc=;
	b=a3B2YVbwheb7nEMC1GE3XyG5bf4FpqfBmjGOFdGQjIRcrklWmr+v6pY7zqbGKOZ6dsLZiB
	qXBWl5GNP37VaqkSWgZMQRLUCjBBlTbQDNUmFiqOb0sSAnH5JOJXLUnsXtUQST3ESroN4B
	Pr8AoEeOGpHI3t+JQSjtYB4mB6TGCEKJnuTrdvnXnzvoGKjxegSP+43ws8EyrEaxOUmi4H
	XmxR7YmeF+2w+8WPmRoaUkzMQeZbrwjKNCGCpoNtRqIxD9OU2bl4rRgLHKTbNxyxSKIaqO
	LDY/g9KC46DnUuul2ZP8JDtTXBadV/DMf00gG/a2DmTa3gHju9yU2gSsElbjwg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751551231;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Hx+rHtCsFQB+clyGWDIV1ASOnLiLATVgamexByxtQNc=;
	b=/v1eXhoemQEDu4JRVjQHf6fI6jyyFmBzUjQvAvqJD7QAx2z1sLcuSngeeVlROoLEL9t+bV
	JCg01ewWYEIhfdDA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/alpine-msi: Convert to __free
Cc: Thomas Gleixner <tglx@linutronix.de>, Nam Cao <namcao@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cff2c9460d03e44cb2946521dbae5ce800d34523e=2E17508?=
 =?utf-8?q?60131=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3Cff2c9460d03e44cb2946521dbae5ce800d34523e=2E175086?=
 =?utf-8?q?0131=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175155123024.406.1516024696226222530.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     f7c2dd9f4c2d93b8dfb30dcc91b7e241fc1f5811
Gitweb:        https://git.kernel.org/tip/f7c2dd9f4c2d93b8dfb30dcc91b7e241fc1f5811
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 26 Jun 2025 16:49:06 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 03 Jul 2025 15:49:25 +02:00

irqchip/alpine-msi: Convert to __free

Tidy up the code with __free. No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/ff2c9460d03e44cb2946521dbae5ce800d34523e.1750860131.git.namcao@linutronix.de

---
 drivers/irqchip/irq-alpine-msi.c | 31 ++++++++++++-------------------
 1 file changed, 12 insertions(+), 19 deletions(-)

diff --git a/drivers/irqchip/irq-alpine-msi.c b/drivers/irqchip/irq-alpine-msi.c
index cf188e5..43d6db2 100644
--- a/drivers/irqchip/irq-alpine-msi.c
+++ b/drivers/irqchip/irq-alpine-msi.c
@@ -207,11 +207,10 @@ static int alpine_msix_init_domains(struct alpine_msix_data *priv, struct device
 
 static int alpine_msix_init(struct device_node *node, struct device_node *parent)
 {
-	struct alpine_msix_data *priv;
+	struct alpine_msix_data *priv __free(kfree) = kzalloc(sizeof(*priv), GFP_KERNEL);
 	struct resource res;
 	int ret;
 
-	priv = kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
@@ -220,7 +219,7 @@ static int alpine_msix_init(struct device_node *node, struct device_node *parent
 	ret = of_address_to_resource(node, 0, &res);
 	if (ret) {
 		pr_err("Failed to allocate resource\n");
-		goto err_priv;
+		return ret;
 	}
 
 	/*
@@ -235,34 +234,28 @@ static int alpine_msix_init(struct device_node *node, struct device_node *parent
 
 	if (of_property_read_u32(node, "al,msi-base-spi", &priv->spi_first)) {
 		pr_err("Unable to parse MSI base\n");
-		ret = -EINVAL;
-		goto err_priv;
+		return -EINVAL;
 	}
 
 	if (of_property_read_u32(node, "al,msi-num-spis", &priv->num_spis)) {
 		pr_err("Unable to parse MSI numbers\n");
-		ret = -EINVAL;
-		goto err_priv;
+		return -EINVAL;
 	}
 
-	priv->msi_map = bitmap_zalloc(priv->num_spis, GFP_KERNEL);
-	if (!priv->msi_map) {
-		ret = -ENOMEM;
-		goto err_priv;
-	}
+	unsigned long *msi_map __free(kfree) = bitmap_zalloc(priv->num_spis, GFP_KERNEL);
+
+	if (!msi_map)
+		return -ENOMEM;
+	priv->msi_map = msi_map;
 
 	pr_debug("Registering %d msixs, starting at %d\n", priv->num_spis, priv->spi_first);
 
 	ret = alpine_msix_init_domains(priv, node);
 	if (ret)
-		goto err_map;
+		return ret;
 
+	retain_and_null_ptr(priv);
+	retain_and_null_ptr(msi_map);
 	return 0;
-
-err_map:
-	bitmap_free(priv->msi_map);
-err_priv:
-	kfree(priv);
-	return ret;
 }
 IRQCHIP_DECLARE(alpine_msix, "al,alpine-msix", alpine_msix_init);

