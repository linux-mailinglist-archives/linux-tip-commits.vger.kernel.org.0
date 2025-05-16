Return-Path: <linux-tip-commits+bounces-5604-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 699C6ABA402
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:40:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AB757A8011
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:39:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 019002853FA;
	Fri, 16 May 2025 19:37:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R4bx9aCj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dFTXxWba"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 903AD283FF9;
	Fri, 16 May 2025 19:37:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424256; cv=none; b=Gu2ToY4uACckDMsBpOpHMTOdTh3VCR4v4eVtCquGBpkDuoTVDYN+hyE9zIDNO8HTMtrWlvR7im9pl6C037c9UqRJSx7/1mHBeNYneVAeS+Dkwj5rry9yUzZmsRwOPekEQffawpLAZvpiRAK0wBS1RPN2n4xYqdYvbtS7R3xgDH8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424256; c=relaxed/simple;
	bh=NXDvaRcOdxkCpmrhfRRGFeSHYcyYSx4k78PM/5E0srY=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Rfrz4ONYAKYycisFVq6f6MOL856E2EpMZPMT7vA09F2N1220LXjxUtn8t1s0x4Dh3sUop6cNPADPg2LY214P2BWyRAWXByU6tumI1TVlBMIdVm9gItSXj2oCB3Pjai2hvHAySqYZtDdiCTXBfaThcH3k5otZO71mVPDgMdoStF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R4bx9aCj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dFTXxWba; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:37:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424252;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUd2VF6P6Ndqtl5q3ph8tvgFz/vdPHK9jfv3hEVNB2g=;
	b=R4bx9aCjsSWFlxq3cYGE85x+6V4TkcXmuj7R4irvntSWS+35x5S3lSJmi8Syw/ZF4anxYo
	IdaAADg0qQ9hROO47wARhpwJ1qYv8UgCcCigc7Kfm9kPyrEFzPHjrEskZW1kkjWCLT4XG4
	72AGe017AYtgrsEolI/WoAYIhtCk1k4J0jTiUe/QvFjOYYPSy8Bfv6ICA1Gxj5cEC2ENR2
	UDhe5AbfmMCZrwKfIOLocdxnA8jq2a3aj7Z/zRrYNS09K9rGhOikkblPpHjsembyNk1SGD
	enAfXcfsP1ExUzHMgWD5m/63qsDq9oU5QIQJo7UhNyBjsyjTrzkhpMhcZARYGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424252;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZUd2VF6P6Ndqtl5q3ph8tvgFz/vdPHK9jfv3hEVNB2g=;
	b=dFTXxWbaFODcG7hgdeIg3uf3lAzRiw4ITuQ+WWodmVm8BZOZ/j4ayWET9UU2g/RYdCMpnn
	EhpxKuxu/d1Lr9Bg==
From: "tip-bot2 for Jiri Slaby (SUSE)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/cleanups] powerpc: Switch to irq_domain_create_*()
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250319092951.37667-33-jirislaby@kernel.org>
References: <20250319092951.37667-33-jirislaby@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174742425203.406.11535190687794566044.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/cleanups branch of tip:

Commit-ID:     bf9935e479399b6f261e0f592e85d17a5486192f
Gitweb:        https://git.kernel.org/tip/bf9935e479399b6f261e0f592e85d17a5486192f
Author:        Jiri Slaby (SUSE) <jirislaby@kernel.org>
AuthorDate:    Wed, 19 Mar 2025 10:29:25 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:06:11 +02:00

powerpc: Switch to irq_domain_create_*()

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
Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu> # For 8xx
Link: https://lore.kernel.org/all/20250319092951.37667-33-jirislaby@kernel.org



---
 arch/powerpc/platforms/44x/uic.c                 | 5 +++--
 arch/powerpc/platforms/512x/mpc5121_ads_cpld.c   | 3 ++-
 arch/powerpc/platforms/52xx/media5200.c          | 2 +-
 arch/powerpc/platforms/52xx/mpc52xx_gpt.c        | 4 ++--
 arch/powerpc/platforms/52xx/mpc52xx_pic.c        | 2 +-
 arch/powerpc/platforms/85xx/socrates_fpga_pic.c  | 2 +-
 arch/powerpc/platforms/8xx/cpm1-ic.c             | 3 ++-
 arch/powerpc/platforms/8xx/pic.c                 | 3 ++-
 arch/powerpc/platforms/embedded6xx/flipper-pic.c | 5 +++--
 arch/powerpc/platforms/embedded6xx/hlwd-pic.c    | 5 +++--
 arch/powerpc/platforms/powermac/pic.c            | 5 +++--
 arch/powerpc/platforms/powernv/opal-irqchip.c    | 3 ++-
 arch/powerpc/sysdev/cpm2_pic.c                   | 3 ++-
 arch/powerpc/sysdev/ehv_pic.c                    | 5 +++--
 arch/powerpc/sysdev/fsl_msi.c                    | 2 +-
 arch/powerpc/sysdev/ge/ge_pic.c                  | 5 +++--
 arch/powerpc/sysdev/i8259.c                      | 4 ++--
 arch/powerpc/sysdev/ipic.c                       | 5 +++--
 arch/powerpc/sysdev/mpic.c                       | 6 +++---
 arch/powerpc/sysdev/tsi108_pci.c                 | 4 ++--
 arch/powerpc/sysdev/xive/common.c                | 2 +-
 21 files changed, 45 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/platforms/44x/uic.c b/arch/powerpc/platforms/44x/uic.c
index 31f760c..481ec25 100644
--- a/arch/powerpc/platforms/44x/uic.c
+++ b/arch/powerpc/platforms/44x/uic.c
@@ -254,8 +254,9 @@ static struct uic * __init uic_init_one(struct device_node *node)
 	}
 	uic->dcrbase = *dcrreg;
 
-	uic->irqhost = irq_domain_add_linear(node, NR_UIC_INTS, &uic_host_ops,
-					     uic);
+	uic->irqhost = irq_domain_create_linear(of_fwnode_handle(node),
+						NR_UIC_INTS, &uic_host_ops,
+						uic);
 	if (! uic->irqhost)
 		return NULL; /* FIXME: panic? */
 
diff --git a/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c b/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
index e995eb3..2cf3c62 100644
--- a/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
+++ b/arch/powerpc/platforms/512x/mpc5121_ads_cpld.c
@@ -188,7 +188,8 @@ mpc5121_ads_cpld_pic_init(void)
 
 	cpld_pic_node = of_node_get(np);
 
-	cpld_pic_host = irq_domain_add_linear(np, 16, &cpld_pic_host_ops, NULL);
+	cpld_pic_host = irq_domain_create_linear(of_fwnode_handle(np), 16,
+						 &cpld_pic_host_ops, NULL);
 	if (!cpld_pic_host) {
 		printk(KERN_ERR "CPLD PIC: failed to allocate irq host!\n");
 		goto end;
diff --git a/arch/powerpc/platforms/52xx/media5200.c b/arch/powerpc/platforms/52xx/media5200.c
index 19626cd..bc7f83c 100644
--- a/arch/powerpc/platforms/52xx/media5200.c
+++ b/arch/powerpc/platforms/52xx/media5200.c
@@ -168,7 +168,7 @@ static void __init media5200_init_irq(void)
 
 	spin_lock_init(&media5200_irq.lock);
 
-	media5200_irq.irqhost = irq_domain_add_linear(fpga_np,
+	media5200_irq.irqhost = irq_domain_create_linear(of_fwnode_handle(fpga_np),
 			MEDIA5200_NUM_IRQS, &media5200_irq_ops, &media5200_irq);
 	if (!media5200_irq.irqhost)
 		goto out;
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
index 1ea591e..f042b21 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_gpt.c
@@ -247,9 +247,9 @@ mpc52xx_gpt_irq_setup(struct mpc52xx_gpt_priv *gpt, struct device_node *node)
 	if (!cascade_virq)
 		return;
 
-	gpt->irqhost = irq_domain_add_linear(node, 1, &mpc52xx_gpt_irq_ops, gpt);
+	gpt->irqhost = irq_domain_create_linear(of_fwnode_handle(node), 1, &mpc52xx_gpt_irq_ops, gpt);
 	if (!gpt->irqhost) {
-		dev_err(gpt->dev, "irq_domain_add_linear() failed\n");
+		dev_err(gpt->dev, "irq_domain_create_linear() failed\n");
 		return;
 	}
 
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pic.c b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
index 43c881d..7ec56d3 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pic.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pic.c
@@ -446,7 +446,7 @@ void __init mpc52xx_init_irq(void)
 	 * As last step, add an irq host to translate the real
 	 * hw irq information provided by the ofw to linux virq
 	 */
-	mpc52xx_irqhost = irq_domain_add_linear(picnode,
+	mpc52xx_irqhost = irq_domain_create_linear(of_fwnode_handle(picnode),
 	                                 MPC52xx_IRQ_HIGHTESTHWIRQ,
 	                                 &mpc52xx_irqhost_ops, NULL);
 
diff --git a/arch/powerpc/platforms/85xx/socrates_fpga_pic.c b/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
index 60e0b89..b4f6360 100644
--- a/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
+++ b/arch/powerpc/platforms/85xx/socrates_fpga_pic.c
@@ -278,7 +278,7 @@ void __init socrates_fpga_pic_init(struct device_node *pic)
 	int i;
 
 	/* Setup an irq_domain structure */
-	socrates_fpga_pic_irq_host = irq_domain_add_linear(pic,
+	socrates_fpga_pic_irq_host = irq_domain_create_linear(of_fwnode_handle(pic),
 		    SOCRATES_FPGA_NUM_IRQS, &socrates_fpga_pic_host_ops, NULL);
 	if (socrates_fpga_pic_irq_host == NULL) {
 		pr_err("FPGA PIC: Unable to allocate host\n");
diff --git a/arch/powerpc/platforms/8xx/cpm1-ic.c b/arch/powerpc/platforms/8xx/cpm1-ic.c
index a18fc7c..1549f6c 100644
--- a/arch/powerpc/platforms/8xx/cpm1-ic.c
+++ b/arch/powerpc/platforms/8xx/cpm1-ic.c
@@ -110,7 +110,8 @@ static int cpm_pic_probe(struct platform_device *pdev)
 
 	out_be32(&data->reg->cpic_cimr, 0);
 
-	data->host = irq_domain_add_linear(dev->of_node, 64, &cpm_pic_host_ops, data);
+	data->host = irq_domain_create_linear(of_fwnode_handle(dev->of_node),
+					      64, &cpm_pic_host_ops, data);
 	if (!data->host)
 		return -ENODEV;
 
diff --git a/arch/powerpc/platforms/8xx/pic.c b/arch/powerpc/platforms/8xx/pic.c
index ea6b0e5..7639f28 100644
--- a/arch/powerpc/platforms/8xx/pic.c
+++ b/arch/powerpc/platforms/8xx/pic.c
@@ -146,7 +146,8 @@ void __init mpc8xx_pic_init(void)
 	if (!siu_reg)
 		goto out;
 
-	mpc8xx_pic_host = irq_domain_add_linear(np, 64, &mpc8xx_pic_host_ops, NULL);
+	mpc8xx_pic_host = irq_domain_create_linear(of_fwnode_handle(np), 64,
+						   &mpc8xx_pic_host_ops, NULL);
 	if (!mpc8xx_pic_host)
 		printk(KERN_ERR "MPC8xx PIC: failed to allocate irq host!\n");
 
diff --git a/arch/powerpc/platforms/embedded6xx/flipper-pic.c b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
index 013d663..a41649b 100644
--- a/arch/powerpc/platforms/embedded6xx/flipper-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/flipper-pic.c
@@ -149,8 +149,9 @@ static struct irq_domain * __init flipper_pic_init(struct device_node *np)
 
 	__flipper_quiesce(io_base);
 
-	irq_domain = irq_domain_add_linear(np, FLIPPER_NR_IRQS,
-				  &flipper_irq_domain_ops, io_base);
+	irq_domain = irq_domain_create_linear(of_fwnode_handle(np),
+					      FLIPPER_NR_IRQS,
+					      &flipper_irq_domain_ops, io_base);
 	if (!irq_domain) {
 		pr_err("failed to allocate irq_domain\n");
 		return NULL;
diff --git a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
index 4d2d92d..9abb3da 100644
--- a/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
+++ b/arch/powerpc/platforms/embedded6xx/hlwd-pic.c
@@ -175,8 +175,9 @@ static struct irq_domain *__init hlwd_pic_init(struct device_node *np)
 
 	__hlwd_quiesce(io_base);
 
-	irq_domain = irq_domain_add_linear(np, HLWD_NR_IRQS,
-					   &hlwd_irq_domain_ops, io_base);
+	irq_domain = irq_domain_create_linear(of_fwnode_handle(np),
+					      HLWD_NR_IRQS,
+					      &hlwd_irq_domain_ops, io_base);
 	if (!irq_domain) {
 		pr_err("failed to allocate irq_domain\n");
 		iounmap(io_base);
diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
index 03a7c51..2eddc8b 100644
--- a/arch/powerpc/platforms/powermac/pic.c
+++ b/arch/powerpc/platforms/powermac/pic.c
@@ -327,8 +327,9 @@ static void __init pmac_pic_probe_oldstyle(void)
 	/*
 	 * Allocate an irq host
 	 */
-	pmac_pic_host = irq_domain_add_linear(master, max_irqs,
-					      &pmac_pic_host_ops, NULL);
+	pmac_pic_host = irq_domain_create_linear(of_fwnode_handle(master),
+						 max_irqs,
+						 &pmac_pic_host_ops, NULL);
 	BUG_ON(pmac_pic_host == NULL);
 	irq_set_default_domain(pmac_pic_host);
 
diff --git a/arch/powerpc/platforms/powernv/opal-irqchip.c b/arch/powerpc/platforms/powernv/opal-irqchip.c
index d92759c..e180bd8 100644
--- a/arch/powerpc/platforms/powernv/opal-irqchip.c
+++ b/arch/powerpc/platforms/powernv/opal-irqchip.c
@@ -191,7 +191,8 @@ int __init opal_event_init(void)
 	 * fall back to the legacy method (opal_event_request(...))
 	 * anyway. */
 	dn = of_find_compatible_node(NULL, NULL, "ibm,opal-event");
-	opal_event_irqchip.domain = irq_domain_add_linear(dn, MAX_NUM_EVENTS,
+	opal_event_irqchip.domain = irq_domain_create_linear(of_fwnode_handle(dn),
+				MAX_NUM_EVENTS,
 				&opal_event_domain_ops, &opal_event_irqchip);
 	of_node_put(dn);
 	if (!opal_event_irqchip.domain) {
diff --git a/arch/powerpc/sysdev/cpm2_pic.c b/arch/powerpc/sysdev/cpm2_pic.c
index e144936..c63d72f 100644
--- a/arch/powerpc/sysdev/cpm2_pic.c
+++ b/arch/powerpc/sysdev/cpm2_pic.c
@@ -259,7 +259,8 @@ void cpm2_pic_init(struct device_node *node)
 	out_be32(&cpm2_intctl->ic_scprrl, 0x05309770);
 
 	/* create a legacy host */
-	cpm2_pic_host = irq_domain_add_linear(node, 64, &cpm2_pic_host_ops, NULL);
+	cpm2_pic_host = irq_domain_create_linear(of_fwnode_handle(node), 64,
+						 &cpm2_pic_host_ops, NULL);
 	if (cpm2_pic_host == NULL) {
 		printk(KERN_ERR "CPM2 PIC: failed to allocate irq host!\n");
 		return;
diff --git a/arch/powerpc/sysdev/ehv_pic.c b/arch/powerpc/sysdev/ehv_pic.c
index fb502b7..4ee8d36 100644
--- a/arch/powerpc/sysdev/ehv_pic.c
+++ b/arch/powerpc/sysdev/ehv_pic.c
@@ -269,8 +269,9 @@ void __init ehv_pic_init(void)
 		return;
 	}
 
-	ehv_pic->irqhost = irq_domain_add_linear(np, NR_EHV_PIC_INTS,
-						 &ehv_pic_host_ops, ehv_pic);
+	ehv_pic->irqhost = irq_domain_create_linear(of_fwnode_handle(np),
+						    NR_EHV_PIC_INTS,
+						    &ehv_pic_host_ops, ehv_pic);
 	if (!ehv_pic->irqhost) {
 		of_node_put(np);
 		kfree(ehv_pic);
diff --git a/arch/powerpc/sysdev/fsl_msi.c b/arch/powerpc/sysdev/fsl_msi.c
index 7b9a5ea..4fe8a7b 100644
--- a/arch/powerpc/sysdev/fsl_msi.c
+++ b/arch/powerpc/sysdev/fsl_msi.c
@@ -412,7 +412,7 @@ static int fsl_of_msi_probe(struct platform_device *dev)
 	}
 	platform_set_drvdata(dev, msi);
 
-	msi->irqhost = irq_domain_add_linear(dev->dev.of_node,
+	msi->irqhost = irq_domain_create_linear(of_fwnode_handle(dev->dev.of_node),
 				      NR_MSI_IRQS_MAX, &fsl_msi_host_ops, msi);
 
 	if (msi->irqhost == NULL) {
diff --git a/arch/powerpc/sysdev/ge/ge_pic.c b/arch/powerpc/sysdev/ge/ge_pic.c
index a6c4246..5b1f8dc 100644
--- a/arch/powerpc/sysdev/ge/ge_pic.c
+++ b/arch/powerpc/sysdev/ge/ge_pic.c
@@ -214,8 +214,9 @@ void __init gef_pic_init(struct device_node *np)
 	}
 
 	/* Setup an irq_domain structure */
-	gef_pic_irq_host = irq_domain_add_linear(np, GEF_PIC_NUM_IRQS,
-					  &gef_pic_host_ops, NULL);
+	gef_pic_irq_host = irq_domain_create_linear(of_fwnode_handle(np),
+						    GEF_PIC_NUM_IRQS,
+						    &gef_pic_host_ops, NULL);
 	if (gef_pic_irq_host == NULL)
 		return;
 
diff --git a/arch/powerpc/sysdev/i8259.c b/arch/powerpc/sysdev/i8259.c
index 06e3914..99bb2b9 100644
--- a/arch/powerpc/sysdev/i8259.c
+++ b/arch/powerpc/sysdev/i8259.c
@@ -260,8 +260,8 @@ void i8259_init(struct device_node *node, unsigned long intack_addr)
 	raw_spin_unlock_irqrestore(&i8259_lock, flags);
 
 	/* create a legacy host */
-	i8259_host = irq_domain_add_legacy(node, NR_IRQS_LEGACY, 0, 0,
-					   &i8259_host_ops, NULL);
+	i8259_host = irq_domain_create_legacy(of_fwnode_handle(node), NR_IRQS_LEGACY, 0, 0,
+					      &i8259_host_ops, NULL);
 	if (i8259_host == NULL) {
 		printk(KERN_ERR "i8259: failed to allocate irq host !\n");
 		return;
diff --git a/arch/powerpc/sysdev/ipic.c b/arch/powerpc/sysdev/ipic.c
index a35be02..f7b415e 100644
--- a/arch/powerpc/sysdev/ipic.c
+++ b/arch/powerpc/sysdev/ipic.c
@@ -711,8 +711,9 @@ struct ipic * __init ipic_init(struct device_node *node, unsigned int flags)
 	if (ipic == NULL)
 		return NULL;
 
-	ipic->irqhost = irq_domain_add_linear(node, NR_IPIC_INTS,
-					      &ipic_host_ops, ipic);
+	ipic->irqhost = irq_domain_create_linear(of_fwnode_handle(node),
+						 NR_IPIC_INTS,
+						 &ipic_host_ops, ipic);
 	if (ipic->irqhost == NULL) {
 		kfree(ipic);
 		return NULL;
diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
index 4afbab8..3de0901 100644
--- a/arch/powerpc/sysdev/mpic.c
+++ b/arch/powerpc/sysdev/mpic.c
@@ -1483,9 +1483,9 @@ struct mpic * __init mpic_alloc(struct device_node *node,
 	mpic->isu_shift = 1 + __ilog2(mpic->isu_size - 1);
 	mpic->isu_mask = (1 << mpic->isu_shift) - 1;
 
-	mpic->irqhost = irq_domain_add_linear(mpic->node,
-				       intvec_top,
-				       &mpic_host_ops, mpic);
+	mpic->irqhost = irq_domain_create_linear(of_fwnode_handle(mpic->node),
+						 intvec_top,
+						 &mpic_host_ops, mpic);
 
 	/*
 	 * FIXME: The code leaks the MPIC object and mappings here; this
diff --git a/arch/powerpc/sysdev/tsi108_pci.c b/arch/powerpc/sysdev/tsi108_pci.c
index 0e42f7b..07d0f6a 100644
--- a/arch/powerpc/sysdev/tsi108_pci.c
+++ b/arch/powerpc/sysdev/tsi108_pci.c
@@ -404,8 +404,8 @@ void __init tsi108_pci_int_init(struct device_node *node)
 {
 	DBG("Tsi108_pci_int_init: initializing PCI interrupts\n");
 
-	pci_irq_host = irq_domain_add_legacy(node, NR_IRQS_LEGACY, 0, 0,
-					     &pci_irq_domain_ops, NULL);
+	pci_irq_host = irq_domain_create_legacy(of_fwnode_handle(node), NR_IRQS_LEGACY, 0, 0,
+						&pci_irq_domain_ops, NULL);
 	if (pci_irq_host == NULL) {
 		printk(KERN_ERR "pci_irq_host: failed to allocate irq domain!\n");
 		return;
diff --git a/arch/powerpc/sysdev/xive/common.c b/arch/powerpc/sysdev/xive/common.c
index dc2e618..f105924 100644
--- a/arch/powerpc/sysdev/xive/common.c
+++ b/arch/powerpc/sysdev/xive/common.c
@@ -1464,7 +1464,7 @@ static const struct irq_domain_ops xive_irq_domain_ops = {
 
 static void __init xive_init_host(struct device_node *np)
 {
-	xive_irq_domain = irq_domain_add_tree(np, &xive_irq_domain_ops, NULL);
+	xive_irq_domain = irq_domain_create_tree(of_fwnode_handle(np), &xive_irq_domain_ops, NULL);
 	if (WARN_ON(xive_irq_domain == NULL))
 		return;
 	irq_set_default_domain(xive_irq_domain);

