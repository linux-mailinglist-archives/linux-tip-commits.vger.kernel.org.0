Return-Path: <linux-tip-commits+bounces-5350-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id A96DCAAD9D8
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 10:14:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B724AB22AF5
	for <lists+linux-tip-commits@lfdr.de>; Wed,  7 May 2025 08:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EEF122FDE6;
	Wed,  7 May 2025 07:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vwE65Bp6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="quq1n93O"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 715EA22F166;
	Wed,  7 May 2025 07:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746604690; cv=none; b=uz2D4jN4gSg0UjR1Y2h3Kf0KfheRuK+zktvNHcP14rhURPlU9cU5yH2jV67EN6l5/LD9WEp7i0w/mnE6YgzNWrV6vq3xOAVcuDdGPrO9ZHqL1mfQtd2bJXJyOGN/X8oGAQ17L8RlI5yYDP51025LF+nXtCRN3vUbSME/gYIhWQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746604690; c=relaxed/simple;
	bh=UaDfrWu+p9VROmkdlv5xIf3A8jzIuwrnsawCUY6myyk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=h9n2j2byzG9UJ3aG19N82vaPt7cU52Cc+bznou2JzVP7acScgaRut+Jp3HoEo16bAxKe+VNFCWrvfY/pkoik1pVRC0DitdDZZgOABQ5dmcGNq80Te/yiqi1V74i4L055dcd8mkJ7mCH4KIKI8ZnEDyZReB/e5e8JYxNAZPghis0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vwE65Bp6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=quq1n93O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 07 May 2025 07:58:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746604686;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LJyTyxbrU5J0gUgX9FTYnXCUVgWUsNZuX/4z9gVHg0s=;
	b=vwE65Bp6liqaJI/F1mOW4kWNLMomhdTC3ZsiWU6BYTM6V5AjhT3A8CC/okv45QRStU22/k
	AqvseRZCfFCY1L24nMhASQr3Jn4CfaDD5aClHyBAuYjKLrCBSmuYY8b5qUzGi3oH9+c22+
	PBHxwdNvyb+YdxdKtD6BFE3IIfeEUz7ed7YMCB9T1JtNCrx44shOTDF3zkuchrE4iSX2ZB
	NRDpQu5o4tWSGK+rC0CEeZmq48VGX+K0AvGv1jHZG0D0IwIbDZaUA4UylQugkpe5Dqc8+V
	Adge2XVF1j1r2R8UH85R8RprKbczi4qCX0bn4luBnRip9zbcGu5Tpq5QhYBvog==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746604686;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LJyTyxbrU5J0gUgX9FTYnXCUVgWUsNZuX/4z9gVHg0s=;
	b=quq1n93OoTvyKNkCdzNr2sAm68QJuwTmdbyb73nkalqgG4EdHQA5rgYq4bePsv1TIR4tKQ
	iFA4VLhXcMNGFnDw==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] MIPS: Switch to irq_domain_create_*()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-26-jirislaby@kernel.org>
References: <20250319092951.37667-26-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174660468538.406.17057627927395425820.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     95c332368f12914d5c1ae7439decd8741c33a84d
Gitweb:        https://git.kernel.org/tip/95c332368f12914d5c1ae7439decd8741c33a84d
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:18 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 07 May 2025 09:53:23 +02:00

MIPS: Switch to irq_domain_create_*()

irq_domain_add_*() interfaces are going away as being obsolete now.
Switch to the preferred irq_domain_create_*() ones. Those differ in the
node parameter: They take more generic struct fwnode_handle instead of
struct device_node. Therefore, of_fwnode_handle() is added around the
original parameter.

Note some of the users can likely use dev->fwnode directly instead of
indirect of_fwnode_handle(dev->of_node). But dev->fwnode is not
guaranteed to be set for all, so this has to be investigated on case to
case basis (by people who can actually test with the HW).

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250319092951.37667-26-jirislaby@kernel.org

---
 arch/mips/ath25/ar2315.c             |  4 ++--
 arch/mips/ath25/ar5312.c             |  4 ++--
 arch/mips/cavium-octeon/octeon-irq.c | 25 +++++++++++++------------
 arch/mips/lantiq/irq.c               |  2 +-
 arch/mips/pci/pci-ar2315.c           |  4 ++--
 arch/mips/pci/pci-rt3883.c           |  7 ++++---
 arch/mips/ralink/irq.c               |  2 +-
 7 files changed, 25 insertions(+), 23 deletions(-)

diff --git a/arch/mips/ath25/ar2315.c b/arch/mips/ath25/ar2315.c
index 8ccf167..e8c38aa 100644
--- a/arch/mips/ath25/ar2315.c
+++ b/arch/mips/ath25/ar2315.c
@@ -149,8 +149,8 @@ void __init ar2315_arch_init_irq(void)
 
 	ath25_irq_dispatch = ar2315_irq_dispatch;
 
-	domain = irq_domain_add_linear(NULL, AR2315_MISC_IRQ_COUNT,
-				       &ar2315_misc_irq_domain_ops, NULL);
+	domain = irq_domain_create_linear(NULL, AR2315_MISC_IRQ_COUNT,
+					  &ar2315_misc_irq_domain_ops, NULL);
 	if (!domain)
 		panic("Failed to add IRQ domain");
 
diff --git a/arch/mips/ath25/ar5312.c b/arch/mips/ath25/ar5312.c
index cfa1035..4a1d874 100644
--- a/arch/mips/ath25/ar5312.c
+++ b/arch/mips/ath25/ar5312.c
@@ -143,8 +143,8 @@ void __init ar5312_arch_init_irq(void)
 
 	ath25_irq_dispatch = ar5312_irq_dispatch;
 
-	domain = irq_domain_add_linear(NULL, AR5312_MISC_IRQ_COUNT,
-				       &ar5312_misc_irq_domain_ops, NULL);
+	domain = irq_domain_create_linear(NULL, AR5312_MISC_IRQ_COUNT,
+					  &ar5312_misc_irq_domain_ops, NULL);
 	if (!domain)
 		panic("Failed to add IRQ domain");
 
diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
index e6b4d9c..5c3de17 100644
--- a/arch/mips/cavium-octeon/octeon-irq.c
+++ b/arch/mips/cavium-octeon/octeon-irq.c
@@ -1503,8 +1503,8 @@ static int __init octeon_irq_init_ciu(
 	/* Mips internal */
 	octeon_irq_init_core();
 
-	ciu_domain = irq_domain_add_tree(
-		ciu_node, &octeon_irq_domain_ciu_ops, dd);
+	ciu_domain = irq_domain_create_tree(of_fwnode_handle(ciu_node), &octeon_irq_domain_ciu_ops,
+					    dd);
 	irq_set_default_domain(ciu_domain);
 
 	/* CIU_0 */
@@ -1637,8 +1637,8 @@ static int __init octeon_irq_init_gpio(
 	if (gpiod) {
 		/* gpio domain host_data is the base hwirq number. */
 		gpiod->base_hwirq = base_hwirq;
-		irq_domain_add_linear(
-			gpio_node, 16, &octeon_irq_domain_gpio_ops, gpiod);
+		irq_domain_create_linear(of_fwnode_handle(gpio_node), 16,
+					 &octeon_irq_domain_gpio_ops, gpiod);
 	} else {
 		pr_warn("Cannot allocate memory for GPIO irq_domain.\n");
 		return -ENOMEM;
@@ -2074,8 +2074,8 @@ static int __init octeon_irq_init_ciu2(
 	/* Mips internal */
 	octeon_irq_init_core();
 
-	ciu_domain = irq_domain_add_tree(
-		ciu_node, &octeon_irq_domain_ciu2_ops, NULL);
+	ciu_domain = irq_domain_create_tree(of_fwnode_handle(ciu_node), &octeon_irq_domain_ciu2_ops,
+					    NULL);
 	irq_set_default_domain(ciu_domain);
 
 	/* CUI2 */
@@ -2331,11 +2331,12 @@ static int __init octeon_irq_init_cib(struct device_node *ciu_node,
 	}
 	host_data->max_bits = val;
 
-	cib_domain = irq_domain_add_linear(ciu_node, host_data->max_bits,
-					   &octeon_irq_domain_cib_ops,
-					   host_data);
+	cib_domain = irq_domain_create_linear(of_fwnode_handle(ciu_node),
+					      host_data->max_bits,
+					      &octeon_irq_domain_cib_ops,
+					      host_data);
 	if (!cib_domain) {
-		pr_err("ERROR: Couldn't irq_domain_add_linear()\n");
+		pr_err("ERROR: Couldn't irq_domain_create_linear()\n");
 		return -ENOMEM;
 	}
 
@@ -2918,8 +2919,8 @@ static int __init octeon_irq_init_ciu3(struct device_node *ciu_node,
 	 * Initialize all domains to use the default domain. Specific major
 	 * blocks will overwrite the default domain as needed.
 	 */
-	domain = irq_domain_add_tree(ciu_node, &octeon_dflt_domain_ciu3_ops,
-				     ciu3_info);
+	domain = irq_domain_create_tree(of_fwnode_handle(ciu_node), &octeon_dflt_domain_ciu3_ops,
+					ciu3_info);
 	for (i = 0; i < MAX_CIU3_DOMAINS; i++)
 		ciu3_info->domain[i] = domain;
 
diff --git a/arch/mips/lantiq/irq.c b/arch/mips/lantiq/irq.c
index 8f20800..a112573 100644
--- a/arch/mips/lantiq/irq.c
+++ b/arch/mips/lantiq/irq.c
@@ -377,7 +377,7 @@ int __init icu_of_init(struct device_node *node, struct device_node *parent)
 	for (i = 0; i < MAX_IM; i++)
 		irq_set_chained_handler(i + 2, ltq_hw_irq_handler);
 
-	ltq_domain = irq_domain_add_linear(node,
+	ltq_domain = irq_domain_create_linear(of_fwnode_handle(node),
 		(MAX_IM * INT_NUM_IM_OFFSET) + MIPS_CPU_IRQ_CASCADE,
 		&irq_domain_ops, 0);
 
diff --git a/arch/mips/pci/pci-ar2315.c b/arch/mips/pci/pci-ar2315.c
index a925842..17fa97e 100644
--- a/arch/mips/pci/pci-ar2315.c
+++ b/arch/mips/pci/pci-ar2315.c
@@ -469,8 +469,8 @@ static int ar2315_pci_probe(struct platform_device *pdev)
 	if (err)
 		return err;
 
-	apc->domain = irq_domain_add_linear(NULL, AR2315_PCI_IRQ_COUNT,
-					    &ar2315_pci_irq_domain_ops, apc);
+	apc->domain = irq_domain_create_linear(NULL, AR2315_PCI_IRQ_COUNT,
+					       &ar2315_pci_irq_domain_ops, apc);
 	if (!apc->domain) {
 		dev_err(dev, "failed to add IRQ domain\n");
 		return -ENOMEM;
diff --git a/arch/mips/pci/pci-rt3883.c b/arch/mips/pci/pci-rt3883.c
index 4ac68a5..14454ec 100644
--- a/arch/mips/pci/pci-rt3883.c
+++ b/arch/mips/pci/pci-rt3883.c
@@ -208,9 +208,10 @@ static int rt3883_pci_irq_init(struct device *dev,
 	rt3883_pci_w32(rpc, 0, RT3883_PCI_REG_PCIENA);
 
 	rpc->irq_domain =
-		irq_domain_add_linear(rpc->intc_of_node, RT3883_PCI_IRQ_COUNT,
-				      &rt3883_pci_irq_domain_ops,
-				      rpc);
+		irq_domain_create_linear(of_fwnode_handle(rpc->intc_of_node),
+					 RT3883_PCI_IRQ_COUNT,
+					 &rt3883_pci_irq_domain_ops,
+					 rpc);
 	if (!rpc->irq_domain) {
 		dev_err(dev, "unable to add IRQ domain\n");
 		return -ENODEV;
diff --git a/arch/mips/ralink/irq.c b/arch/mips/ralink/irq.c
index 46aef0a..af5bbbe 100644
--- a/arch/mips/ralink/irq.c
+++ b/arch/mips/ralink/irq.c
@@ -176,7 +176,7 @@ static int __init intc_of_init(struct device_node *node,
 	/* route all INTC interrupts to MIPS HW0 interrupt */
 	rt_intc_w32(0, INTC_REG_TYPE);
 
-	domain = irq_domain_add_legacy(node, RALINK_INTC_IRQ_COUNT,
+	domain = irq_domain_create_legacy(of_fwnode_handle(node), RALINK_INTC_IRQ_COUNT,
 			RALINK_INTC_IRQ_BASE, 0, &irq_domain_ops, NULL);
 	if (!domain)
 		panic("Failed to add irqdomain");

