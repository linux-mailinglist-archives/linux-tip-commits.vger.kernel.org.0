Return-Path: <linux-tip-commits+bounces-1485-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B2C48913AC9
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jun 2024 15:17:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40D48280613
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jun 2024 13:17:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E5F12E1D3;
	Sun, 23 Jun 2024 13:17:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SidFOBpL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7aqPHZF3"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CE282C76;
	Sun, 23 Jun 2024 13:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719148633; cv=none; b=WlbX0+RF/3kvtI2HZ1k+DMzwwBtyuCwbUxoEF4BHqydxdUel2/gVB97sKe9oST0vvQu1wXuafO9ZNblmphEX2RWdZtSVV36opuh/SvQrHIDhvb1J97ycAERPfkyrmWsgLToxkLUJEIO5UbDjxQ7U0SguuG6QQhmopJwx2l8vlDM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719148633; c=relaxed/simple;
	bh=jRxaH7gNHLSd0Im+gSSA2ue9ok1jSALwzBTK079Gn+Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Nst0FmiKyssUgMuBY6cuWVdOWXE5tRpUT/R0o2MnftZCO27G5tArUU8UoNC0LSu1drB2+rvUM3nfbF3FBAr70plqxuKiDNn3x2oJNODkWp1xr3p8JSEi0aq2N8YXg+F2TGFg4Ga2bgLpjO4Og7nV8GlxPE0IaUBDuE1PytnjdHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SidFOBpL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7aqPHZF3; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 23 Jun 2024 13:17:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719148629;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9JVkdWGEsbjGw42mspGzrWKTG95fvkmjYwv+QVV71mA=;
	b=SidFOBpLm/aebzWFHxfLDXfKiDVprefbNsFbFsb3GR6GD8EyZcZqju6hYDI7CdAQ3RUijC
	D9PAZnRHkLuzYwOPtvM/BB/+AlGfEF7buSEZK6M+xSl7r3auSzOcBfhG4QD4wYwp45BwTQ
	K5ndlychursZ5t5UQUKqP7Kl2e4taaq5a4zjdV471wJbHI25vx7NxIiopqSKeNGqObzP9T
	j0+JKfgfPPwYnxVPxVJGn/p6T60hx32dTgZJ3UylE6Iqoj/K66c3Z9+k5PAzS00vPKJQow
	wcSt0WL1rJcN0aEF05uBdFXtjaH7jZtItnx64nU5sWcT7SnIHzSnZeXwXvRgYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719148629;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9JVkdWGEsbjGw42mspGzrWKTG95fvkmjYwv+QVV71mA=;
	b=7aqPHZF3SMzjrAnLc3oGS13WVL3Wp7Kw67uZ/XkpclDO8KL4Ll8gYMspEuGvrN8j84M8PO
	c/EWnX3apLE6rnAw==
From: "tip-bot2 for Anna-Maria Behnsen" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] irqchip/imx-mu-msi: Fix codingstyle in
 imx_mu_msi_domains_init()
Cc: "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240614102403.13610-3-shivamurthy.shastri@linutronix.de>
References: <20240614102403.13610-3-shivamurthy.shastri@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171914862956.10875.17366434196355189525.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     12c94f694e53b1bf105c56af4b800a32f1b0b10a
Gitweb:        https://git.kernel.org/tip/12c94f694e53b1bf105c56af4b800a32f1b0b10a
Author:        Anna-Maria Behnsen <anna-maria@linutronix.de>
AuthorDate:    Fri, 14 Jun 2024 12:23:41 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 23 Jun 2024 15:07:57 +02:00

irqchip/imx-mu-msi: Fix codingstyle in imx_mu_msi_domains_init()

Fixes the coding style of irq_domain_create_linear() call within
imx_mu_msi_domains_init() for better code readability.

Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240614102403.13610-3-shivamurthy.shastri@linutronix.de

---
 drivers/irqchip/irq-imx-mu-msi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-imx-mu-msi.c b/drivers/irqchip/irq-imx-mu-msi.c
index 90d41c1..1dceda0 100644
--- a/drivers/irqchip/irq-imx-mu-msi.c
+++ b/drivers/irqchip/irq-imx-mu-msi.c
@@ -222,10 +222,8 @@ static int imx_mu_msi_domains_init(struct imx_mu_msi *msi_data, struct device *d
 	struct irq_domain *parent;
 
 	/* Initialize MSI domain parent */
-	parent = irq_domain_create_linear(fwnodes,
-					    IMX_MU_CHANS,
-					    &imx_mu_msi_domain_ops,
-					    msi_data);
+	parent = irq_domain_create_linear(fwnodes, IMX_MU_CHANS,
+					  &imx_mu_msi_domain_ops, msi_data);
 	if (!parent) {
 		dev_err(dev, "failed to create IRQ domain\n");
 		return -ENOMEM;

