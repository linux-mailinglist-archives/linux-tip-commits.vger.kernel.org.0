Return-Path: <linux-tip-commits+bounces-5993-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B7436AF7686
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 16:03:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 445313B931E
	for <lists+linux-tip-commits@lfdr.de>; Thu,  3 Jul 2025 14:01:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 285422EAB9E;
	Thu,  3 Jul 2025 14:00:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PeFxhxuE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dooKbvXJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 668812EA756;
	Thu,  3 Jul 2025 14:00:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751551240; cv=none; b=vAWjbDD/Qou4fUUq1xc4TjpegflIERhCge6SpHphY/xv+ZPEHQ0VZrNKhMgzbiD+WfDgu09nzePu8RmVQUtKTljdXh7x5s9RG8hmDZNA3Ji9pw5NTcymSEGBNsIVC22921G33C3/UD4n9uvRIEMpDwzOktZVmt+ByMSm3w21uzw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751551240; c=relaxed/simple;
	bh=NleJJRganPFOEwWfwwRPGjEwWt4mHTAHW1jYqmIsXRk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M+R8UDAKVICYDab4zwjZTRfUSDs5bGtY++Jaxuaq3F6iBf2vWS9KKQ5wU+L5uIL2a6hZt4GPxPmZ7Io2DG5FxM5Y6jF7axchRxZ3NPVvwBVXwLa7ET1/wcJXHcJZdp136fZNRpDuKS66oQURTOK2RznUuLteQ5IUuNjPirKCPbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PeFxhxuE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dooKbvXJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 03 Jul 2025 14:00:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751551236;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MUOW3E8+31t2uueSjsjk9g8bV9j0XXqqlY1058ZkL3E=;
	b=PeFxhxuEo5oRNsH1VxXM+JNKbE4y3+wAE4ZXlwuHPEnOXxSfo5SkuXfd8oOSu0B1zhkhTg
	epP4/w4AKY0+IDJoVTvdCUSwsPZPJl7YVwJOuwtOZmRelW2Qwp9H72QwsKgP/JEy+7kch4
	KlUKAkJUn1rJ13+MSdvW8+OMKc3tMvyKpXPAGBjEv9WKIv+mwu8NCXVV680dSPUkY64XIu
	pVT5KVie7y7JEYuOTEDGSINc0gQf5gpqm2+4zyrkpDH+hkhF6G8WJQ7HxR0UCMO7ze857x
	LRUugoLBgnLR+U7OfXchnIAdBsB8pViMhT9w2ZLscrzFbfNmNr7VCjIuVJhK8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751551236;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MUOW3E8+31t2uueSjsjk9g8bV9j0XXqqlY1058ZkL3E=;
	b=dooKbvXJLiNTuTJ9t+JqYLpcM2wAWyFLBS54G5lHNiUSVyRtOaGSNLAVrXEvZepkFUUufp
	ymOjE3gYdNWFxvDg==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/imx-mu-msi: Convert to
 msi_create_parent_irq_domain() helper
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Frank Li <Frank.Li@nxp.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241204124549.607054-7-maz@kernel.org>
References: <20241204124549.607054-7-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175155123559.406.7389650211204464397.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     c7cc7b122a4cf1235b53e5bb5f441ce95d8b0cd2
Gitweb:        https://git.kernel.org/tip/c7cc7b122a4cf1235b53e5bb5f441ce95d8b0cd2
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Thu, 26 Jun 2025 16:49:01 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 03 Jul 2025 15:49:24 +02:00

irqchip/imx-mu-msi: Convert to msi_create_parent_irq_domain() helper

Now that we have a concise helper to create an MSI parent domain,
switch the IMX letter soup over to that.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Nam Cao <tglx@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Link: https://lore.kernel.org/all/4f05fff99b6cc5875d2f4dadd31707e2dedaafc8.1750860131.git.namcao@linutronix.de
Link: https://lore.kernel.org/all/20241204124549.607054-7-maz@kernel.org

---
 drivers/irqchip/irq-imx-mu-msi.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/irqchip/irq-imx-mu-msi.c b/drivers/irqchip/irq-imx-mu-msi.c
index 137da19..d2a4e8a 100644
--- a/drivers/irqchip/irq-imx-mu-msi.c
+++ b/drivers/irqchip/irq-imx-mu-msi.c
@@ -223,21 +223,21 @@ static const struct msi_parent_ops imx_mu_msi_parent_ops = {
 
 static int imx_mu_msi_domains_init(struct imx_mu_msi *msi_data, struct device *dev)
 {
-	struct fwnode_handle *fwnodes = dev_fwnode(dev);
+	struct irq_domain_info info = {
+		.ops		= &imx_mu_msi_domain_ops,
+		.fwnode		= dev_fwnode(dev),
+		.size		= IMX_MU_CHANS,
+		.host_data	= msi_data,
+	};
 	struct irq_domain *parent;
 
 	/* Initialize MSI domain parent */
-	parent = irq_domain_create_linear(fwnodes, IMX_MU_CHANS,
-					  &imx_mu_msi_domain_ops, msi_data);
+	parent = msi_create_parent_irq_domain(&info, &imx_mu_msi_parent_ops);
 	if (!parent) {
 		dev_err(dev, "failed to create IRQ domain\n");
 		return -ENOMEM;
 	}
-
-	irq_domain_update_bus_token(parent, DOMAIN_BUS_NEXUS);
 	parent->dev = parent->pm_dev = dev;
-	parent->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
-	parent->msi_parent_ops = &imx_mu_msi_parent_ops;
 	return 0;
 }
 

