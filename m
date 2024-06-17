Return-Path: <linux-tip-commits+bounces-1418-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 40E1790B538
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 17:51:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 845BEB28E90
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 14:48:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B6831D541C;
	Mon, 17 Jun 2024 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ym1v2Duy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v2Jy1zve"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C498D1D2A0E;
	Mon, 17 Jun 2024 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632279; cv=none; b=pg3g0rYdLEpnVhZjuixD3aeWc4juwA8OeaDPupOT50ok2nfo9hK8VUkrrNJDZ1i+nxNohOvKWOxnuJiN19z+jAyo/jJt+i3Ivpa9RqCEYbtlsCtXcXzyldz0NEo3vg9oNElJxxpCXK4dxCOJm2PZEn4256TQu6Ny7yAbKqWtDWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632279; c=relaxed/simple;
	bh=j+t677zUV4HRQFlt4klS1cop/Q1jwOBeg5HUPERFUPM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gCii4XtTLUcJoC7f9AGSlM/iH0UqXGgO1KCZAqQQQZfMJLr1xHdQ93afzNAkX5nhv6Gkh6GGsWzDJsG4dSOtxbobCq5Ce0+KwGhE/cCEMvvV2wIZ594G2xEGiPl7yFvEsIxeWxQvP9kHhftCmnz8QyvN2GGtjH1EZdc/lv5ImJc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ym1v2Duy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v2Jy1zve; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Jun 2024 13:51:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718632269;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EF36Rz+1P8Rd3H11UEZFZei/2GVx4kH5roHto/S4vt8=;
	b=Ym1v2DuyiJEAFPYL90QKa205OxUSCDimfkdC5Nn8oEt+eqt0JKRaVyF0V4C1i2OpgeMW8f
	/riXSkkWpn2uEOBscIPZK3uBPN004+g3wbw/8B5v4CWA7rUfFc1GMERjrV2Wy9Z2cuPxxI
	ydvvklg/N6Ra1gCOStyFfwqOG+9UJm+Q4LpWyYkrbimafB413CYBcrEXGnl6ey34ly9pqg
	h7DAF4nwP2Sht6IIgCONsQ7o0R+z4aw7P/4JCYd466FuN7Jia83Bh4O3Cq8Cxf4k8aO6WX
	yTPBUYrGMtIsZlpAF9pgUSxAc3rAdOZSVCePt37hsyApVySPJGgRgWK6jOPKgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718632269;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EF36Rz+1P8Rd3H11UEZFZei/2GVx4kH5roHto/S4vt8=;
	b=v2Jy1zveY5qNMz0QUCwtRWjdSWNv/d/HTlX7kWQz6c27EG7VVr4M85LCAWHLYf6PJOHh3Q
	h4ZUyqazwqb+UjDA==
From: "tip-bot2 for Herve Codina" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqdomain: Add a resource managed version of
 irq_domain_instantiate()
Cc: Herve Codina <herve.codina@bootlin.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240614173232.1184015-17-herve.codina@bootlin.com>
References: <20240614173232.1184015-17-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171863226962.10875.635902420067890660.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     0c5b29a6dc7b463b6072da8cef43800008728ff3
Gitweb:        https://git.kernel.org/tip/0c5b29a6dc7b463b6072da8cef43800008728ff3
Author:        Herve Codina <herve.codina@bootlin.com>
AuthorDate:    Fri, 14 Jun 2024 19:32:17 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Jun 2024 15:48:14 +02:00

irqdomain: Add a resource managed version of irq_domain_instantiate()

Add a devres version of irq_domain_instantiate().

Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240614173232.1184015-17-herve.codina@bootlin.com

---
 include/linux/irqdomain.h |  2 ++-
 kernel/irq/devres.c       | 41 ++++++++++++++++++++++++++++++++++++++-
 2 files changed, 43 insertions(+)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index 5540b22..8820317 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -304,6 +304,8 @@ struct irq_domain_info {
 };
 
 struct irq_domain *irq_domain_instantiate(const struct irq_domain_info *info);
+struct irq_domain *devm_irq_domain_instantiate(struct device *dev,
+					       const struct irq_domain_info *info);
 
 struct irq_domain *__irq_domain_add(struct fwnode_handle *fwnode, unsigned int size,
 				    irq_hw_number_t hwirq_max, int direct_max,
diff --git a/kernel/irq/devres.c b/kernel/irq/devres.c
index f6e5515..b3e9866 100644
--- a/kernel/irq/devres.c
+++ b/kernel/irq/devres.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/irqdomain.h>
 #include <linux/device.h>
 #include <linux/gfp.h>
 #include <linux/irq.h>
@@ -282,3 +283,43 @@ int devm_irq_setup_generic_chip(struct device *dev, struct irq_chip_generic *gc,
 }
 EXPORT_SYMBOL_GPL(devm_irq_setup_generic_chip);
 #endif /* CONFIG_GENERIC_IRQ_CHIP */
+
+#ifdef CONFIG_IRQ_DOMAIN
+static void devm_irq_domain_remove(struct device *dev, void *res)
+{
+	struct irq_domain **domain = res;
+
+	irq_domain_remove(*domain);
+}
+
+/**
+ * devm_irq_domain_instantiate() - Instantiate a new irq domain data for a
+ *                                 managed device.
+ * @dev:	Device to instantiate the domain for
+ * @info:	Domain information pointer pointing to the information for this
+ *		domain
+ *
+ * Return: A pointer to the instantiated irq domain or an ERR_PTR value.
+ */
+struct irq_domain *devm_irq_domain_instantiate(struct device *dev,
+					       const struct irq_domain_info *info)
+{
+	struct irq_domain *domain;
+	struct irq_domain **dr;
+
+	dr = devres_alloc(devm_irq_domain_remove, sizeof(*dr), GFP_KERNEL);
+	if (!dr)
+		return ERR_PTR(-ENOMEM);
+
+	domain = irq_domain_instantiate(info);
+	if (!IS_ERR(domain)) {
+		*dr = domain;
+		devres_add(dev, dr);
+	} else {
+		devres_free(dr);
+	}
+
+	return domain;
+}
+EXPORT_SYMBOL_GPL(devm_irq_domain_instantiate);
+#endif /* CONFIG_IRQ_DOMAIN */

