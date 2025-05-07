Return-Path: <linux-tip-commits+bounces-5355-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 43634AAD977
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 10:04:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 693C21C06F0F
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 08:04:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C757123182E;
	Wed,  7 May 2025 07:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FNZWKka2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BIfmYGk1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8885E230269;
	Wed,  7 May 2025 07:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604693; cv=none; b=gvsoje6wjiShudBGjF+FGyygRd2UtxVeFK486eAFQY7+ZsErjuhBqMIrIIYBQBOlessjBbo2gFfw0Wx/vpXlyptwhy+5j25Fp66EMDZXuNy0YEmL2SqRFotRUPy0VujmilYmyyDKvexotf0+USjqCar6FnlrkK84U3uzaFyCK0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604693; c=relaxed/simple;
	bh=McqVjUEAt75cNzCBrZdb1HD2x3PQxSZ+r8cgMoeNvHo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=FUQfSF43v/WkP3YsNSgGnIwrxUyk9WQzJ2OvrFYLu1mhOFnxRe1zjyPk1SMDBM6deEY5rcT5VsTQNs2NicwlNs4EJx5fcK1Pk7m0FMcZFaw3jIwA7osqqpocxBwxwLuAP9HxHwZZPglNFWYq/PqZyWP83SBjKjagv8YI6CZKl2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FNZWKka2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BIfmYGk1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 07:58:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746604690;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=apBuV6aOwxgnPRtd3f+NNzbLG1S9nRuT0y6GXx7BOWw=;
	b=FNZWKka2JzHaJLANeA5P+CcGuWvLzFix9B+UDqvV9mA1YO4r4wZD284i6epNNiv0upFmHK
	zJOOxRDpbzIXF8xtSLMz+TNn97yrV43+nPST4y5IIm3eSA1Z7mJlu58DhsPmxPJtRIv2JT
	M6qC+40hTehOm43w93eh3m848nVHk6/+bFa+NiFDs8MQ5cgLlrLnWeou8Srooq3JUfZBUH
	lhKYbG3oApM8pzZMOZhqavAXlCxv7tk+X1saaVGDM/rXJjTsxQ8EAuLO5Fe1GkzB2+jP82
	F+CakdMHkrSoFU9AgLfJ1SVHpqWMND2esg15kyeWn051Hw/ic1i6X6O8k5X6hQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746604690;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=apBuV6aOwxgnPRtd3f+NNzbLG1S9nRuT0y6GXx7BOWw=;
	b=BIfmYGk1sFhNyIhc97smacqrI7Tsr1vfse/lAh2EphGPZlsJQwd+s3TgplPCJUciQ8CuVF
	4WBjXUbWH1DlzLBg==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] iio: Switch to irq_domain_create_simple()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-21-jirislaby@kernel.org>
References: <20250319092951.37667-21-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660468927.406.10315530656961679996.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     b05c04edb4f82fbb3a031d65e39c148d80cb2db0
Gitweb:        https://git.kernel.org/tip/b05c04edb4f82fbb3a031d65e39c148d80cb2db0
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:13 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:53:22 +02:00

iio: Switch to irq_domain_create_simple()

irq_domain_add_simple() is going away as being obsolete now. Switch to
the preferred irq_domain_create_simple(). That differs in the first
parameter: It takes more generic struct fwnode_handle instead of struct
device_node. Therefore, of_fwnode_handle() is added around the
parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

[ tglx: Fix up subject prefix ]

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-21-jirislaby@kernel.org

---
 drivers/iio/adc/stm32-adc-core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/adc/stm32-adc-core.c b/drivers/iio/adc/stm32-adc-core.c
index 0914148..bd34589 100644
--- a/drivers/iio/adc/stm32-adc-core.c
+++ b/drivers/iio/adc/stm32-adc-core.c
@@ -421,9 +421,10 @@ static int stm32_adc_irq_probe(struct platform_device *pdev,
 			return priv->irq[i];
 	}
 
-	priv->domain = irq_domain_add_simple(np, STM32_ADC_MAX_ADCS, 0,
-					     &stm32_adc_domain_ops,
-					     priv);
+	priv->domain = irq_domain_create_simple(of_fwnode_handle(np),
+						STM32_ADC_MAX_ADCS, 0,
+						&stm32_adc_domain_ops,
+						priv);
 	if (!priv->domain) {
 		dev_err(&pdev->dev, "Failed to add irq domain\n");
 		return -ENOMEM;

