Return-Path: <linux-tip-commits+bounces-1722-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4395D9351C0
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Jul 2024 20:41:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D492EB22B1E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Jul 2024 18:41:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 488741474A3;
	Thu, 18 Jul 2024 18:39:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4ISVnlG+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ESZm8eCE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D1331465AC;
	Thu, 18 Jul 2024 18:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721327948; cv=none; b=gLys3jpns9j50an04E8wPPRiBjG7t30TG7BH9NhQtXM8ctSmdDGsnQMvX+rvWEVw1aPhW3t0kt8EIaPCL9fjQCrkorzAR298pgCXqkXDfSWxFTnNio6Cj9lgFq+h3I2aHkqHP+gquvHGTZMjcBj82Hl9a5m97g1u2e82ZzT2XKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721327948; c=relaxed/simple;
	bh=xyB4Lyx87u5+5KJWtjs2sA0KIszTTDH3MKMTg4/G6qU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ovhHsKDc8mw639V0rgpAX6WsPJfE8l+o7XCiKPQbOpugmyYgIACXj92f4j9gkg1hGbW6y5yIOkvpVvSGOcBeqogKRuYZiLOI+vFYbl3VFWBEybFWo+YOjnJ2ZGVaE3sOhTYDiPHauR2TKlG90n48J1WlTI/e+O2j8hGZze9p8AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4ISVnlG+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ESZm8eCE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Jul 2024 18:39:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721327941;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mhTWVQNg5Yv0TbY2g+CaivyexmuP29wKjVMI3uxw9is=;
	b=4ISVnlG+1CktOcXZbN2XuHdfa7ZiF6Tr/jyt/ROm/EZMGz/ibTNnvwfNb89223+70k6ARf
	BBPev+qLinaOD/UWUPOr5VzjL1c5MSSfM8WrmWRLY5TW3SO6dMe4+xIvnqnLnvOuU0oSZO
	wbV/vzCMIMVdg2LFY53Qtmk9vnuJhhVkEWgotugzXIsYud9oXRxCcRFA+UWd6+jEbFwGgB
	0bA470TmFjWvBSM0AWZv12IdtSzj1Oif3e0I2EYwFbxPhric+3BE16c9bfBykJvZJsYSaw
	h3WVClKJ+ZHFF1OHxSorRMclBbxM51US7cmLGVBTRA9Nq0ymAzh+ZzKdK9Eg1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721327941;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mhTWVQNg5Yv0TbY2g+CaivyexmuP29wKjVMI3uxw9is=;
	b=ESZm8eCE6Eno+7vFA+TvBKhF5Kw2aPPSAXiwbgSE88z0CHtAQG7YWevNs/HPfmC7yAHN0z
	we4bWFN5UWc2nxAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] irqchip/irq-msi-lib: Prepare for DEVICE MSI to replace
 platform MSI
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240623142235.085171290@linutronix.de>
References: <20240623142235.085171290@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172132794126.2215.15035687382150914255.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     496436f4a514a3fb4bc7aecd41f0dd4b38e39b1f
Gitweb:        https://git.kernel.org/tip/496436f4a514a3fb4bc7aecd41f0dd4b38e39b1f
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 23 Jun 2024 17:18:41 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 18 Jul 2024 20:31:20 +02:00

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
 

