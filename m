Return-Path: <linux-tip-commits+bounces-1665-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5225992D670
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jul 2024 18:29:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D54D01F21564
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jul 2024 16:29:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17D2D19923F;
	Wed, 10 Jul 2024 16:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j5/Xc/73";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="F6S2zISe"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBBA01990B7;
	Wed, 10 Jul 2024 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628758; cv=none; b=V2zxCTXNzJjT263lgS1ZnBNmLeuHumB4euT+oLvBfhhCbFWBcvBxgDBC6QMtG7vMisgy4nUn16X1nQ6maJG0ttp4JlEJBuDJZTntP5hEbPtH3OC3AspZV0KJNNCx7CSMcb4Emudcjp6TpOQAeON8JPx5UqY5gKzdWJ0rDSDRrt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628758; c=relaxed/simple;
	bh=KGfSrij0J8c6KvW/Z0m18C0B8DF7dqti8mlZZ8/uPl0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M3uve6668peWyZYtxVfNiOO7yjWnl2gFAMeuKo323QpfGnKN5K+cXy9kx5UBU2kemhVsb6hTer4B/qrVzkkvu47wDgN2NY5f6NOqEkLDMDoavbMr2y+cEqrHEDK8YRbMQO8KwoZQujG8aCS7sKTsGCqNWK9x9DuLHBiiLW08Rbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j5/Xc/73; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=F6S2zISe; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Jul 2024 16:25:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720628753;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1V50jklSgQuRy89OKn134lYjPYoQDNZayVNAiwtj/Wk=;
	b=j5/Xc/733LlW6Z0TCra8qNNTM6Ol7Hc/WGqpnArLQF4k9KyGSHU0KF00GM0niVV5dY3qbg
	JoZNLCnPfTZIFW2jwyTGTG2di/T5NWhblV/9h8TxyZFcupDaUIqrozrEIkCdLk+8rukx2t
	S3qYrr2X8CObozxwvoQMCqDlJaP6NQTGpfZNIaPI+0CIPkiQb0B/6d913onGB1wZHe3cJN
	rjTfH3eSY5ysK2jai6gixg1dU3Fup44569yRLkikVIJDX+T6WwETlO59mMnkdLN61EgwZx
	uZtYhtiot9Inyv2jJNoO+LiN2sRK25mOcEFYUlMpykdxTdY/sWhkRDRfh5BJdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720628753;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1V50jklSgQuRy89OKn134lYjPYoQDNZayVNAiwtj/Wk=;
	b=F6S2zISe+Sum0Ttc7zW+HEgVdehjHnMw9/OAgM38VZORHeQ89dvSNivu74/sCBU6WcYCOC
	0i7+P8HKdZoEg3BA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/irq-msi-lib: Prepare for DEVICE MSI to
 replace platform MSI
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240623142235.085171290@linutronix.de>
References: <20240623142235.085171290@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172062875354.2215.9090620309809826229.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e12eba0f080304db4aae02f51e4b6ff873ea13c5
Gitweb:        https://git.kernel.org/tip/e12eba0f080304db4aae02f51e4b6ff873ea13c5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 23 Jun 2024 17:18:41 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Jul 2024 18:19:23 +02:00

irqchip/irq-msi-lib: Prepare for DEVICE MSI to replace platform MSI

Add the prerequisites for DEVICE MSI into the shared select() and child
domain init function. These domains are really trivial and just provide a
custom irq chip callback to write the MSI message.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240623142235.085171290@linutronix.de



---
 drivers/irqchip/irq-msi-lib.c | 15 +++++++++++++++
 drivers/irqchip/irq-msi-lib.h |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index ef26962..b98a219 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -57,6 +57,21 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 			return false;
 
 		break;
+	case DOMAIN_BUS_DEVICE_MSI:
+		/*
+		 * Per device MSI should never have any MSI feature bits
+		 * set. It's sole purpose is to create a dumb interrupt
+		 * chip which has a device specific irq_write_msi_msg()
+		 * callback.
+		 */
+		if (WARN_ON_ONCE(info->flags))
+			return false;
+
+		/* Core managed MSI descriptors */
+		info->flags = MSI_FLAG_ALLOC_SIMPLE_MSI_DESCS | MSI_FLAG_FREE_MSI_DESCS;
+		/* Remove PCI specific flags */
+		required_flags &= ~MSI_FLAG_PCI_MSI_MASK_PARENT;
+		break;
 	default:
 		/*
 		 * This should never be reached. See
diff --git a/drivers/irqchip/irq-msi-lib.h b/drivers/irqchip/irq-msi-lib.h
index 525aa52..681ceab 100644
--- a/drivers/irqchip/irq-msi-lib.h
+++ b/drivers/irqchip/irq-msi-lib.h
@@ -15,6 +15,8 @@
 #define MATCH_PCI_MSI		(0)
 #endif
 
+#define MATCH_PLATFORM_MSI	BIT(DOMAIN_BUS_PLATFORM_MSI)
+
 int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
 			      enum irq_domain_bus_token bus_token);
 

