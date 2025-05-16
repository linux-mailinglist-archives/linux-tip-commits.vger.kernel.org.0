Return-Path: <linux-tip-commits+bounces-5614-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E65D8ABA418
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:42:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1FB1D1BC393C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:42:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBDC2288CAE;
	Fri, 16 May 2025 19:37:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cnCGf7DP";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jvidNjZP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BB4288C03;
	Fri, 16 May 2025 19:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424264; cv=none; b=gnolZ0BD0p/d90zPwgp6sReSr7XxmX0E96fg3GTu65YPnZLl7JmXiTcd7iGKax7HjLrVeHxSOILNLMYb2E5pXiSqi9zKlDFZ6a8y1S5kS5FTsldk2taoVVU2drO+AozEr0+P7XUlgaC7332Tp8gDIArBw66bNKgUn+rkSCPVj40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424264; c=relaxed/simple;
	bh=21ze8ElKQmyqxNwGB+/JZTfoE1SA7LxotoupZSKutcs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Uuqbv/efZld74mzeaIm3pj0N8PTdTy2RqRi7DJDhxRCqnIWqKn8+6LAsdDra7HVXlI4bEliCyh5THnirrMTFe+5QoPjJxI1B7R4A2MxopKdKAYHS/bqNwUF76b/VqbinlZgNAwVpfq9xXByDmIZ5mVJr58a0Prh7tBACLMq536A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=cnCGf7DP; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jvidNjZP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:37:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424261;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7EoDk6iPodbSjrZHTo5eMhHIEipeOK1vqpOhnjLiQiI=;
	b=cnCGf7DPYFHxK78TxLSoirOpu+JC2O9YqSWQ7Zs9TpVT1qQTkByDmhHZ38ARmIZ/FFa46I
	I6Ox7GEXVkSygsvMQHxWf1fykv60Y3ItsZDSjKL88guxBGwF469cJxCoDXyk5vObVYr8B4
	fLTbw4/6fjyikE5BJ4XNdBxXwly5FR+bz4Sb9JjcGLDyFKxYI/T0VR3LN41ZEphZ1bZR02
	05ef+uewRM3aTzNsBCTx9fcLQ1UmzFdOhVCes2VIBZktkEWMqQ6Q0U+ij8AjDN81ES5G2u
	ZAiMkh2jIGlHdN+gIeRATL+4IUeD+S9jZ3mmvDq1rbQDtLSqzrJ9gN3ce+SMYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424261;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7EoDk6iPodbSjrZHTo5eMhHIEipeOK1vqpOhnjLiQiI=;
	b=jvidNjZPs40gX93hBAbAB+RRtOvsjYjME8nRxv4iE46ZbYpvle3HRLxf1jyS0jBOCOHAXQ
	N33jtw5Xqq2GJ4DA==
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
Message-ID: <174742426036.406.14034286665879958417.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     7f68126a8766773a403ff754bd2cbce0df2306f6
Gitweb:        https://git.kernel.org/tip/7f68126a8766773a403ff754bd2cbce0df2306f6
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:13 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:06:09 +02:00

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

