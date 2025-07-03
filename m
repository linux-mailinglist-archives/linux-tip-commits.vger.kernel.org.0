Return-Path: <linux-tip-commits+bounces-5995-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B2AAAF7681
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 16:02:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9BF077BA69A
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 14:01:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 987522EBB8F;
	Thu,  3 Jul 2025 14:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oKSGwawQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vc344FFl"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD592EAB91;
	Thu,  3 Jul 2025 14:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551241; cv=none; b=Mwqx7xi3hYJmeI6Up7Kot/jLfXtbMXmz919Kld279lDGk3pQ7Xam4P1ErTo5sJpk//vT/rqXu3uQaq3OLI+lthtcB1C7U2DjxAh9CG0J6wXxxVgdq5qYDzc5avBNcfoJc1xAXWmsRRwK8T5CnyPoKzmDfxhQrs3Tcm7fdoG2QBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551241; c=relaxed/simple;
	bh=va0piC2o+tQjkYUtfY7vIvYsltSGPGBrEuziHVSHwTA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gGE4EWYKmMsfM23ixDKkT42tdZJRoKhvuwSBgxjQLtKE/np/90jD64DnbX3fz3lv9/u0lzuKjar1F0lMtQ9FManurGQuhqSXCMlZOgrLxOs93843pGoUlbluL23EwHnjyd1XlWZNcnN7SMELKWr7HzlLgDsht7rrZbQhZcI8IDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oKSGwawQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vc344FFl; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Jul 2025 14:00:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751551238;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Evwti5f+205/n5qjF6/ptZOXuA6Fs27mujbUWRmqBeI=;
	b=oKSGwawQtm+I6vHHDNbNXarBsz1B3O6tpZIw/cwSJTvNUWJEufU++o2le+EoZ1t8Z0dlLw
	m2Fw+9Cc2vyuk8NlERHPHizw479zxdHd6+uWNFvPljgYbt1gkUH5D9PTahWaWGADHVGUDP
	+llnDpQQF7rzonsRONanxVa2rI/aB3aA0kZDXh7i2kBjpi0mz2Fg9P0A7pOjusYgojS4cF
	6aI5g4W1yTCOIJngzTjRsmFORS2Spj3fBfKB5EF+LBn2iQlHcJVAR5lvknpgZ1eWm2G8F9
	b9XuNMOucBC9+nDVnEP0MUDazkwdm56ynViQYiC23XGLMyxqhi65jSpLcfbXXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751551238;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Evwti5f+205/n5qjF6/ptZOXuA6Fs27mujbUWRmqBeI=;
	b=vc344FFlKGo9UC57RUiHW58jdJpZq8tXu0WImQJ+QqpcG2Ce0uN4GX2EC0MYZOG/d7lVD+
	/En70cX/xwNsugCQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/bcm2712-mip: Switch to
 msi_create_parent_irq_domain()
Cc: Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C92a6d68db014e945337c10649a41605da05783da=2E17508?=
 =?utf-8?q?60131=2Egit=2Enamcao=40linutronix=2Ede=3E?=
References: =?utf-8?q?=3C92a6d68db014e945337c10649a41605da05783da=2E175086?=
 =?utf-8?q?0131=2Egit=2Enamcao=40linutronix=2Ede=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175155123728.406.14896394479022566827.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     91650ca5efcf4be00eae5620ad571ce4cdf66ab5
Gitweb:        https://git.kernel.org/tip/91650ca5efcf4be00eae5620ad571ce4cdf66ab5
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 26 Jun 2025 16:48:59 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 03 Jul 2025 15:49:24 +02:00

irqchip/bcm2712-mip: Switch to msi_create_parent_irq_domain()

Switch to use the concise helper to create an MSI parent domain.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Nam Cao <tglx@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/92a6d68db014e945337c10649a41605da05783da.1750860131.git.namcao@linutronix.de

---
 drivers/irqchip/irq-bcm2712-mip.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-bcm2712-mip.c b/drivers/irqchip/irq-bcm2712-mip.c
index 63de5ef..9bd7bc0 100644
--- a/drivers/irqchip/irq-bcm2712-mip.c
+++ b/drivers/irqchip/irq-bcm2712-mip.c
@@ -172,18 +172,18 @@ static const struct msi_parent_ops mip_msi_parent_ops = {
 
 static int mip_init_domains(struct mip_priv *mip, struct device_node *np)
 {
-	struct irq_domain *middle;
-
-	middle = irq_domain_create_hierarchy(mip->parent, 0, mip->num_msis, of_fwnode_handle(np),
-					     &mip_middle_domain_ops, mip);
-	if (!middle)
+	struct irq_domain_info info = {
+		.fwnode		= of_fwnode_handle(np),
+		.ops		= &mip_middle_domain_ops,
+		.host_data	= mip,
+		.size		= mip->num_msis,
+		.parent		= mip->parent,
+		.dev		= mip->dev,
+	};
+
+	if (!msi_create_parent_irq_domain(&info, &mip_msi_parent_ops))
 		return -ENOMEM;
 
-	irq_domain_update_bus_token(middle, DOMAIN_BUS_GENERIC_MSI);
-	middle->dev = mip->dev;
-	middle->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
-	middle->msi_parent_ops = &mip_msi_parent_ops;
-
 	/*
 	 * All MSI-X unmasked for the host, masked for the VPU, and edge-triggered.
 	 */

