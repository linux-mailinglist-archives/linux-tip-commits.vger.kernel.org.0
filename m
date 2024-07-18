Return-Path: <linux-tip-commits+bounces-1720-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AF9AD9351BB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Jul 2024 20:40:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92B061C211C2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Jul 2024 18:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2245D1465B4;
	Thu, 18 Jul 2024 18:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OCabCZ7H";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DYBLyHwX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5D14145B2E;
	Thu, 18 Jul 2024 18:39:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721327946; cv=none; b=nW4+mWM0ZDaQxcCAxkZnF/g2IqoCKnSfMoPwXJO8rUsHud4AQUDHLxFwDqgNtI/rqa6/GWkYPm7h3CBRJG39AEaMIioxMFIhqHl9gwDYhHwuBi/Q2j9Di/oQN/SnmupLQm346hxeyGmnsppoEYgpmNzHRGQ+BNDDShzIxvLyREE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721327946; c=relaxed/simple;
	bh=ACN+c+OUSS88q5YfwTB3fUaoX6Vg2tC9+WAXZw5zYNM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WyE9NcXQh0KJXDqkoMSFz16PjGQyaP7rmJv8N/Mk+8ErIadjjU+bcbB11u6ZBYt1WnZ8FsDdngIjUmwjobK9TcoKw3Vs6gC7cfgAUz90LE9dud0waLDrL47mfWbAol2NYw66TB88ETxu22Kf+jP9tZpYDkKomJvQ3VTJbeFRQ5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OCabCZ7H; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DYBLyHwX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Jul 2024 18:39:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721327940;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3IQds72TBJ8V5I3uXRGzRxWjK68D5TF+2wXwKIkTw2U=;
	b=OCabCZ7H4UiMSx/A2QJSH0RrgkaZZmul0ASFMP4ilgPKpevdFrSYu4ZTO2IAUk2mbur04G
	yNLLDo22WTgWmmJC4fLal9lx9yNfw0P2Eiu9MaQhqp4rqlYULN81iAMsZ7I1NqavedsvZD
	frMWhBOg/fl7rhitFSu5FoTA75fgliSlOOsjg4wA29H1T8fS22ypvywh9SRK3cu+7ER+1J
	RSzjUdu3gujSENEWumbw49FbdxVEEAZ8P1w9VR0WkyzhVUY+fpP1M/i06FWT9wOquQ7i26
	7hTeBMmoI8RYv023IffELdSYNWygVmwnwda5basDjaCSxyLugUeRMyRmApfVBA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721327940;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3IQds72TBJ8V5I3uXRGzRxWjK68D5TF+2wXwKIkTw2U=;
	b=DYBLyHwXkigw8eRikHOErwSjqvFnMe96ZeRxNqNOfNrmPkr6FzxAxvQcxopkaWXnocWWt2
	fRCfgKaomogV9yBQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] irqchip/mbigen: Remove
 platform_msi_create_device_domain() fallback
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240623142235.333333826@linutronix.de>
References: <20240623142235.333333826@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172132794032.2215.2090194082423724020.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     752e021f5b9be0ad42752deaa241ae631f293f9f
Gitweb:        https://git.kernel.org/tip/752e021f5b9be0ad42752deaa241ae631f293f9f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 23 Jun 2024 17:18:48 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 18 Jul 2024 20:31:20 +02:00

irqchip/mbigen: Remove platform_msi_create_device_domain() fallback

Now that ITS provides the MSI parent domain, remove the unused fallback
code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240623142235.333333826@linutronix.de



---
 drivers/irqchip/irq-mbigen.c | 74 +----------------------------------
 1 file changed, 4 insertions(+), 70 deletions(-)

diff --git a/drivers/irqchip/irq-mbigen.c b/drivers/irqchip/irq-mbigen.c
index db0fa80..093fd42 100644
--- a/drivers/irqchip/irq-mbigen.c
+++ b/drivers/irqchip/irq-mbigen.c
@@ -180,64 +180,6 @@ static int mbigen_domain_translate(struct irq_domain *d, struct irq_fwspec *fwsp
 	return -EINVAL;
 }
 
-/* The following section will go away once ITS provides a MSI parent */
-
-static struct irq_chip mbigen_irq_chip = {
-	.name =			"mbigen-v2",
-	.irq_mask =		irq_chip_mask_parent,
-	.irq_unmask =		irq_chip_unmask_parent,
-	.irq_eoi =		mbigen_eoi_irq,
-	.irq_set_type =		mbigen_set_type,
-	.irq_set_affinity =	irq_chip_set_affinity_parent,
-};
-
-static int mbigen_irq_domain_alloc(struct irq_domain *domain,
-					unsigned int virq,
-					unsigned int nr_irqs,
-					void *args)
-{
-	struct irq_fwspec *fwspec = args;
-	irq_hw_number_t hwirq;
-	unsigned int type;
-	struct mbigen_device *mgn_chip;
-	int i, err;
-
-	err = mbigen_domain_translate(domain, fwspec, &hwirq, &type);
-	if (err)
-		return err;
-
-	err = platform_msi_device_domain_alloc(domain, virq, nr_irqs);
-	if (err)
-		return err;
-
-	mgn_chip = platform_msi_get_host_data(domain);
-
-	for (i = 0; i < nr_irqs; i++)
-		irq_domain_set_hwirq_and_chip(domain, virq + i, hwirq + i,
-				      &mbigen_irq_chip, mgn_chip->base);
-
-	return 0;
-}
-
-static void mbigen_irq_domain_free(struct irq_domain *domain, unsigned int virq,
-				   unsigned int nr_irqs)
-{
-	platform_msi_device_domain_free(domain, virq, nr_irqs);
-}
-
-static const struct irq_domain_ops mbigen_domain_ops = {
-	.translate	= mbigen_domain_translate,
-	.alloc		= mbigen_irq_domain_alloc,
-	.free		= mbigen_irq_domain_free,
-};
-
-static void mbigen_write_msg(struct msi_desc *desc, struct msi_msg *msg)
-{
-	mbigen_write_msi_msg(irq_get_irq_data(desc->irq), msg);
-}
-
-/* End of to be removed section */
-
 static void mbigen_domain_set_desc(msi_alloc_info_t *arg, struct msi_desc *desc)
 {
 	arg->desc = desc;
@@ -268,20 +210,12 @@ static const struct msi_domain_template mbigen_msi_template = {
 static bool mbigen_create_device_domain(struct device *dev, unsigned int size,
 					struct mbigen_device *mgn_chip)
 {
-	struct irq_domain *domain = dev->msi.domain;
-
-	if (WARN_ON_ONCE(!domain))
+	if (WARN_ON_ONCE(!dev->msi.domain))
 		return false;
 
-	if (irq_domain_is_msi_parent(domain)) {
-		return msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN,
-						    &mbigen_msi_template, size,
-						    NULL, mgn_chip->base);
-	}
-
-	/* Remove once ITS provides MSI parent */
-	return !!platform_msi_create_device_domain(dev, size, mbigen_write_msg,
-						   &mbigen_domain_ops, mgn_chip);
+	return msi_create_device_irq_domain(dev, MSI_DEFAULT_DOMAIN,
+					    &mbigen_msi_template, size,
+					    NULL, mgn_chip->base);
 }
 
 static int mbigen_of_create_domain(struct platform_device *pdev,

