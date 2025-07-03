Return-Path: <linux-tip-commits+bounces-5986-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C21D2AF7671
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 16:01:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 71F8F7B0A85
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 13:59:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 741042E716C;
	Thu,  3 Jul 2025 14:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eExhMuQd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JZpka05h"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FF1714A4CC;
	Thu,  3 Jul 2025 14:00:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551233; cv=none; b=X3y4XxX19m6BDcQQWGvgS2PjlwJpsC9X3mUhTExIBHVJMLaFlX7WmeNAslocU5Ghg4x4Nb6RgyQV92OcNcMg7NVMdNmMDRFk8P/xL58pXlro5NBuGT2XpKmtpytbuMNQeUdBaaP41hPe8+VUOxG7ujOI0C2LpSKmkl5cuiycXfk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551233; c=relaxed/simple;
	bh=Xu2kPgbADWKRUUddT8qtGwUu7VP2WGQ59kWWDwxWPn0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qzkJ/3HR7Vpvp7LxcmHU5eWQxJNxYt7xIzei3bhjMUtnc9UxClTTt5s9vPLsuv+LHCFINmUevFDtrWLJD9qp8hekUXDrS8FiIdYGR1bjk3iCNYVzfQ6nMYZ+V+tR7IAwhkPXqLz+a5OuYYlOHGO8fCJZC7Rs/1i5Tpu4r2/l+98=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eExhMuQd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JZpka05h; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Jul 2025 14:00:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751551229;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2y0W4FZFl00XltEheG0m/AyIxX9p7dMukFQXWxkv6O0=;
	b=eExhMuQd5X72gUe6tHo00Lg+XgmqSS3aQolp8W9XpXtFWBSCx24PKhl2w5IKzOEZtjDRzo
	Hj3J1/AEnOXU3RnPWLQztPFCvDiYVZnkrT/8fwFxIj293A/8Z1397/EtLsCIbABS/cED4r
	N4KyBcJOrTtdSt/mWwvCkBnnHAP13CLhFF47EZ0LdafunqN/iPI5g7EGC2Um09ykk4tW12
	ZXwh1y4lmPPUSxM7Azb2UR9GocNmUAz0PbbMA3NYBYZznTAXlhL8FRaSPoXiXUDQSvL2bl
	cotDMxt2Cn9wW8FDzDhIuKQJsHtt/KwPNkULw5J5WJOLldZSPmG9/nFKfEuztA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751551229;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2y0W4FZFl00XltEheG0m/AyIxX9p7dMukFQXWxkv6O0=;
	b=JZpka05h9u7DSxtGpdMF95PCSCPrH9DPBUx8Y1KnBbeMHmHu3KVhbzoYO1VU4ZiAPfrq2g
	FEhJJAgELNnXuwBA==
From: "tip-bot2 for Nam Cao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/armada-370-xp: Switch to
 msi_create_parent_irq_domain()
Cc: Nam Cao <namcao@linutronix.de>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C976892e3ce64fcf52387833abee08ddfa47d2a82=2E17508?=
 =?utf-8?q?60131=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C976892e3ce64fcf52387833abee08ddfa47d2a82=2E175086?=
 =?utf-8?q?0131=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175155122834.406.8362122390930313714.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     bafb2901317ff53c0add8b40e96267ad2d2e8ffb
Gitweb:        https://git.kernel.org/tip/bafb2901317ff53c0add8b40e96267ad2d2e8ffb
Author:        Nam Cao <namcao@linutronix.de>
AuthorDate:    Thu, 26 Jun 2025 16:49:08 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 03 Jul 2025 15:49:25 +02:00

irqchip/armada-370-xp: Switch to msi_create_parent_irq_domain()

Move away from the legacy MSI domain setup, switch to use
msi_create_parent_irq_domain().

Signed-off-by: Nam Cao <namcao@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/976892e3ce64fcf52387833abee08ddfa47d2a82.1750860131.git.namcao@linutronix.de

---
 drivers/irqchip/Kconfig             |  1 +-
 drivers/irqchip/irq-armada-370-xp.c | 48 ++++++++++++++--------------
 2 files changed, 26 insertions(+), 23 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index d596155..0f195ad 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -79,6 +79,7 @@ config ARMADA_370_XP_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
 	select PCI_MSI if PCI
+	select IRQ_MSI_LIB if PCI
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 
 config ALPINE_MSI
diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada-370-xp.c
index 67b672a..a44c49e 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -20,6 +20,7 @@
 #include <linux/interrupt.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
+#include <linux/irqchip/irq-msi-lib.h>
 #include <linux/cpu.h>
 #include <linux/io.h>
 #include <linux/of_address.h>
@@ -156,7 +157,6 @@
  * @parent_irq:		parent IRQ if MPIC is not top-level interrupt controller
  * @domain:		MPIC main interrupt domain
  * @ipi_domain:		IPI domain
- * @msi_domain:		MSI domain
  * @msi_inner_domain:	MSI inner domain
  * @msi_used:		bitmap of used MSI numbers
  * @msi_lock:		mutex serializing access to @msi_used
@@ -176,7 +176,6 @@ struct mpic {
 	struct irq_domain *ipi_domain;
 #endif
 #ifdef CONFIG_PCI_MSI
-	struct irq_domain *msi_domain;
 	struct irq_domain *msi_inner_domain;
 	DECLARE_BITMAP(msi_used, PCI_MSI_FULL_DOORBELL_NR);
 	struct mutex msi_lock;
@@ -234,18 +233,6 @@ static void mpic_irq_unmask(struct irq_data *d)
 
 #ifdef CONFIG_PCI_MSI
 
-static struct irq_chip mpic_msi_irq_chip = {
-	.name		= "MPIC MSI",
-	.irq_mask	= pci_msi_mask_irq,
-	.irq_unmask	= pci_msi_unmask_irq,
-};
-
-static struct msi_domain_info mpic_msi_domain_info = {
-	.flags	= (MSI_FLAG_USE_DEF_DOM_OPS | MSI_FLAG_USE_DEF_CHIP_OPS |
-		   MSI_FLAG_MULTI_PCI_MSI | MSI_FLAG_PCI_MSIX),
-	.chip	= &mpic_msi_irq_chip,
-};
-
 static void mpic_compose_msi_msg(struct irq_data *d, struct msi_msg *msg)
 {
 	unsigned int cpu = cpumask_first(irq_data_get_effective_affinity_mask(d));
@@ -314,6 +301,7 @@ static void mpic_msi_free(struct irq_domain *domain, unsigned int virq, unsigned
 }
 
 static const struct irq_domain_ops mpic_msi_domain_ops = {
+	.select	= msi_lib_irq_domain_select,
 	.alloc	= mpic_msi_alloc,
 	.free	= mpic_msi_free,
 };
@@ -331,6 +319,21 @@ static void mpic_msi_reenable_percpu(struct mpic *mpic)
 	writel(1, mpic->per_cpu + MPIC_INT_CLEAR_MASK);
 }
 
+#define MPIC_MSI_FLAGS_REQUIRED (MSI_FLAG_USE_DEF_DOM_OPS | \
+				 MSI_FLAG_USE_DEF_CHIP_OPS)
+#define MPIC_MSI_FLAGS_SUPPORTED (MSI_FLAG_MULTI_PCI_MSI  | \
+				  MSI_FLAG_PCI_MSIX       | \
+				  MSI_GENERIC_FLAGS_MASK)
+
+static const struct msi_parent_ops mpic_msi_parent_ops = {
+	.required_flags		= MPIC_MSI_FLAGS_REQUIRED,
+	.supported_flags	= MPIC_MSI_FLAGS_SUPPORTED,
+	.bus_select_token	= DOMAIN_BUS_NEXUS,
+	.bus_select_mask	= MATCH_PCI_MSI,
+	.prefix			= "MPIC-",
+	.init_dev_msi_info	= msi_lib_init_dev_msi_info,
+};
+
 static int __init mpic_msi_init(struct mpic *mpic, struct device_node *node,
 				phys_addr_t main_int_phys_base)
 {
@@ -348,17 +351,16 @@ static int __init mpic_msi_init(struct mpic *mpic, struct device_node *node,
 		mpic->msi_doorbell_mask = PCI_MSI_FULL_DOORBELL_MASK;
 	}
 
-	mpic->msi_inner_domain = irq_domain_create_linear(NULL, mpic->msi_doorbell_size,
-						       &mpic_msi_domain_ops, mpic);
-	if (!mpic->msi_inner_domain)
-		return -ENOMEM;
+	struct irq_domain_info info = {
+		.fwnode		= of_fwnode_handle(node),
+		.ops		= &mpic_msi_domain_ops,
+		.host_data	= mpic,
+		.size		= mpic->msi_doorbell_size,
+	};
 
-	mpic->msi_domain = pci_msi_create_irq_domain(of_fwnode_handle(node), &mpic_msi_domain_info,
-						     mpic->msi_inner_domain);
-	if (!mpic->msi_domain) {
-		irq_domain_remove(mpic->msi_inner_domain);
+	mpic->msi_inner_domain = msi_create_parent_irq_domain(&info, &mpic_msi_parent_ops);
+	if (!mpic->msi_inner_domain)
 		return -ENOMEM;
-	}
 
 	mpic_msi_reenable_percpu(mpic);
 

