Return-Path: <linux-tip-commits+bounces-1667-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 734DF92D676
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jul 2024 18:30:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F3ADB29967
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jul 2024 16:30:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C4201993B6;
	Wed, 10 Jul 2024 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QmKVa53l";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AlPMoT7X"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D2361990BA;
	Wed, 10 Jul 2024 16:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628759; cv=none; b=qQzyL2ooD5O83JrU4SjV30hdfIWb7g3TdI++cfRMHcbW/46KcIVhlJklGF+aU5m8ysA8n544+lx9UQXjCicyUExpb4hKpj8qu4K4vVoTV8k9wIz2mbfNqlM4C5/ADDcFYeiTASRlwoD3IMNRqZALMqqu/RcdyEY9XMUqbDSJjCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628759; c=relaxed/simple;
	bh=bDnrv7lBYzdpAjJHa7KmOBUbjD5MBzIuKmWQUOqbM5M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=riKladJojHYiKNJlSzl3VtzJeh2BiHflxwS82RrfCvvYk0G5IHdNkxGSypDREumakvrJK+fH0oZgkbE9RMHZ1kYrJ6+4Hm1fWnGl9pdcgRB9svpgbscKD7bthWox7KYh6oWT3bwoD4tyddvThf4HoIsZha2QvIHqINtgAuSJNk4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QmKVa53l; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AlPMoT7X; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Jul 2024 16:25:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720628754;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KstIZOoXeHpQJvuy/YhBF7VpDSk0uTOG/pq4o2gu3rA=;
	b=QmKVa53leuf5Ud3/4XNIuE2ewj1tdNnsOtme+GDfm1Mc4g+C3+YPiERpjWghf2aFJmVPFZ
	annLAl/2o7L3S+YHo7HP3Plmsxiya56pGCYIWUS4mq+lqjxBoNnxM6QTjoUlb0skWNgeoj
	eHUry8u+yA+/GqXiS4bUkpXwmNSUgaIi9v8ASjTgAtbjOmzzlD08hrtiTUb4zU0Bo/KXdB
	02hHV7qbnvyYJ7ajEIwk7CbdDGU/mPiih6VIpLeV1OpIZfglHIgHts4cKQjrQlwowhosfC
	hS1YO7EaFrlAGiFY02ENAqeNlEnG4NszWiEr/Aj2D/62RXpKd7bI9EW0b1ymIw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720628754;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KstIZOoXeHpQJvuy/YhBF7VpDSk0uTOG/pq4o2gu3rA=;
	b=AlPMoT7XwXHljmVk9UlOEl/bR2X+lJaY/WrGyDQcTisFMh3uLJXWAG2Lu1rBM/Klsj8Bkp
	vNuMumboHX331HBw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/irq-msi-lib: Prepare for PCI MSI/MSIX
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240623142234.964056815@linutronix.de>
References: <20240623142234.964056815@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172062875432.2215.13956754928746026683.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     3ed8ef2eb156f93c32e935f0f668902923f9a02c
Gitweb:        https://git.kernel.org/tip/3ed8ef2eb156f93c32e935f0f668902923f9a02c
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 23 Jun 2024 17:18:38 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Jul 2024 18:19:23 +02:00

irqchip/irq-msi-lib: Prepare for PCI MSI/MSIX

Add the bus tokens for DOMAIN_BUS_PCI_DEVICE_MSI and
DOMAIN_BUS_PCI_DEVICE_MSIX to the common child init
function.

Provide the match mask which can be used by parent domain
implementation so the bitmask based child bus token match
works.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240623142234.964056815@linutronix.de



---
 drivers/irqchip/irq-msi-lib.c | 11 ++++++++++-
 drivers/irqchip/irq-msi-lib.h |  6 ++++++
 2 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index ec1a10f..ef26962 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -28,6 +28,7 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 			       struct msi_domain_info *info)
 {
 	const struct msi_parent_ops *pops = real_parent->msi_parent_ops;
+	u32 required_flags;
 
 	/* Parent ops available? */
 	if (WARN_ON_ONCE(!pops))
@@ -46,8 +47,16 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 		return false;
 	}
 
+	required_flags = pops->required_flags;
+
 	/* Is the target domain bus token supported? */
 	switch(info->bus_token) {
+	case DOMAIN_BUS_PCI_DEVICE_MSI:
+	case DOMAIN_BUS_PCI_DEVICE_MSIX:
+		if (WARN_ON_ONCE(!IS_ENABLED(CONFIG_PCI_MSI)))
+			return false;
+
+		break;
 	default:
 		/*
 		 * This should never be reached. See
@@ -63,7 +72,7 @@ bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
 	 */
 	info->flags			&= pops->supported_flags;
 	/* Enforce the required flags */
-	info->flags			|= pops->required_flags;
+	info->flags			|= required_flags;
 
 	/* Chip updates for all child bus types */
 	if (!info->chip->irq_eoi)
diff --git a/drivers/irqchip/irq-msi-lib.h b/drivers/irqchip/irq-msi-lib.h
index f0706cc..525aa52 100644
--- a/drivers/irqchip/irq-msi-lib.h
+++ b/drivers/irqchip/irq-msi-lib.h
@@ -9,6 +9,12 @@
 #include <linux/irqdomain.h>
 #include <linux/msi.h>
 
+#ifdef CONFIG_PCI_MSI
+#define MATCH_PCI_MSI		BIT(DOMAIN_BUS_PCI_MSI)
+#else
+#define MATCH_PCI_MSI		(0)
+#endif
+
 int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
 			      enum irq_domain_bus_token bus_token);
 

