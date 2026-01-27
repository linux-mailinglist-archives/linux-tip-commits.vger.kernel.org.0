Return-Path: <linux-tip-commits+bounces-8120-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0ImtJVDdeGnbtgEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8120-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Jan 2026 16:44:16 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 06D6896F7F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Jan 2026 16:44:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AC49A3046BA6
	for <lists+linux-tip-commits@lfdr.de>; Tue, 27 Jan 2026 15:39:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAAFE3033DD;
	Tue, 27 Jan 2026 15:39:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b7Tlt2SD";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WWgX1Zup"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF7E73033C0;
	Tue, 27 Jan 2026 15:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769528392; cv=none; b=kvmgfxaVMLLApI6phYi7gu8KVxqYS0AvWR8sYK6rIcT6JWqHKWiDOmXXQ2GY+BuO5kjpTmLTk0QiKB/esbgtKiGHx1/cMRSKQJX2ZnY5WAM+Nd0oYf/VTqMOWsmOQwsFVef2fOZfysHzJKtYA+LakISO4HjHxS+sgDCQC9zUyCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769528392; c=relaxed/simple;
	bh=PfNtpSDPtU7Og3TxCaXukTJKzbBP6Jk4NgB8YX11uwk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kD9hTiUgY25ipqTMhSQjaQoKajr4Y+cXjm8qaVaRX8tDs9vdnrXc/dNN6BmFOkgdAih7kVk2x+WSvxIQm+hEzHVMl9hxRfdgBlkD5mIiqzr6GPLM4Nuf6I4S/WNmR6y4pWTcQ/fss+Sh+mN9lDIXwLAN1doPsqDRXPbXODXK1iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b7Tlt2SD; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WWgX1Zup; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 27 Jan 2026 15:39:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769528389;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AQRAlZa2dWZLs7igMmESgzp0Wi3nTQbOLhCnvlZFiB4=;
	b=b7Tlt2SDrahnr6LSzLwKY/AnInHoz/T+d2fxt32RuINrWTZ+wTClE+AOMBJjpv36aMNeCf
	gCTfq7GLPoSJEBcMLo8uPZpAiZE//0wnFifhe5Y7X6Ag6+u6HrH3M1dnDc8dDJWdYfozpi
	8DCdcyF29+etp4JqSCJEogIBYQ4Nz5tsqRolxW7SvFWI48OFhP0R60x03RgRI8Ze1KiRpf
	te6uez9zPl5wTD2fag+FiNnrhVSVpTbTSmU1uRG1wHKiiRx8rVBEZ+RNhI2tOAjhu4n15G
	kYaeuYkw8ADq7oyzejwMQO9CJTgulHbSzu69tfSidk/1NyPoGDcA5ffvY10I3Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769528389;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=AQRAlZa2dWZLs7igMmESgzp0Wi3nTQbOLhCnvlZFiB4=;
	b=WWgX1ZupNxlnANUd3YTW6uKq0eNk5KSfFjY8L8QeDyBaavIcwxP9Hq63F1ETwZuRnKXLwF
	QnrXJJtoicIr3EAg==
From: "tip-bot2 for Ioana Ciornei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/ls-extirq: Convert to a platform driver to
 make it work again
Cc: Alexander Stein <alexander.stein@ew.tq-group.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20260122134034.3274053-2-ioana.ciornei@nxp.com>
References: <20260122134034.3274053-2-ioana.ciornei@nxp.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176952838820.510.829679536252331173.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8120-lists,linux-tip-commits=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	DKIM_TRACE(0.00)[linutronix.de:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,msgid.link:url,nxp.com:email,vger.kernel.org:replyto,tq-group.com:email,0.0.0.14:email]
X-Rspamd-Queue-Id: 06D6896F7F
X-Rspamd-Action: no action

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     05cd654829dd2717e86a5a3f9ff301447fc28c93
Gitweb:        https://git.kernel.org/tip/05cd654829dd2717e86a5a3f9ff301447fc=
28c93
Author:        Ioana Ciornei <ioana.ciornei@nxp.com>
AuthorDate:    Thu, 22 Jan 2026 15:40:33 +02:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 27 Jan 2026 16:33:32 +01:00

irqchip/ls-extirq: Convert to a platform driver to make it work again

Starting with the blamed commit, the ls-extirq driver stopped working. This
is because ls-extirq, being one of the interrupt-map property abusers, does
not pass the DT checks added by the referenced commit, making it unable to
determine its interrupt parent:

  irq-ls-extirq: Cannot find parent domain
  OF: of_irq_init: Failed to init /soc/syscon@1f70000/interrupt-controller@14
      		   ((____ptrval____)), parent 0000000000000000

Instead of reverting the referenced commit, convert the ls-extirq to a
platform driver to avoid the irqchip_init() -> of_irq_init() code path
completely.

As part of the conversion, use the managed resources APIs and
dev_err_probe() so that there is no need for a .remove() callback or for
complicated error handling.

Fixes: 1b1f04d8271e ("of/irq: Ignore interrupt parent for nodes without inter=
rupts")
Co-developed-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Alexander Stein <alexander.stein@ew.tq-group.com>
Signed-off-by: Ioana Ciornei <ioana.ciornei@nxp.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260122134034.3274053-2-ioana.ciornei@nxp.com
---
 drivers/irqchip/irq-ls-extirq.c | 75 +++++++++++++++-----------------
 1 file changed, 36 insertions(+), 39 deletions(-)

diff --git a/drivers/irqchip/irq-ls-extirq.c b/drivers/irqchip/irq-ls-extirq.c
index 50a7b38..96f9c20 100644
--- a/drivers/irqchip/irq-ls-extirq.c
+++ b/drivers/irqchip/irq-ls-extirq.c
@@ -168,40 +168,34 @@ ls_extirq_parse_map(struct ls_extirq_data *priv, struct=
 device_node *node)
 	return 0;
 }
=20
-static int __init
-ls_extirq_of_init(struct device_node *node, struct device_node *parent)
+static int ls_extirq_probe(struct platform_device *pdev)
 {
 	struct irq_domain *domain, *parent_domain;
+	struct device_node *node, *parent;
+	struct device *dev =3D &pdev->dev;
 	struct ls_extirq_data *priv;
 	int ret;
=20
+	node =3D dev->of_node;
+	parent =3D of_irq_find_parent(node);
+	if (!parent)
+		return dev_err_probe(dev, -ENODEV, "Failed to get IRQ parent node\n");
+
 	parent_domain =3D irq_find_host(parent);
-	if (!parent_domain) {
-		pr_err("Cannot find parent domain\n");
-		ret =3D -ENODEV;
-		goto err_irq_find_host;
-	}
+	if (!parent_domain)
+		return dev_err_probe(dev, -EPROBE_DEFER, "Cannot find parent domain\n");
=20
-	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
-	if (!priv) {
-		ret =3D -ENOMEM;
-		goto err_alloc_priv;
-	}
+	priv =3D devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return dev_err_probe(dev, -ENOMEM, "Failed to allocate memory\n");
=20
-	/*
-	 * All extirq OF nodes are under a scfg/syscon node with
-	 * the 'ranges' property
-	 */
-	priv->intpcr =3D of_iomap(node, 0);
-	if (!priv->intpcr) {
-		pr_err("Cannot ioremap OF node %pOF\n", node);
-		ret =3D -ENOMEM;
-		goto err_iomap;
-	}
+	priv->intpcr =3D devm_of_iomap(dev, node, 0, NULL);
+	if (!priv->intpcr)
+		return dev_err_probe(dev, -ENOMEM, "Cannot ioremap OF node %pOF\n", node);
=20
 	ret =3D ls_extirq_parse_map(priv, node);
 	if (ret)
-		goto err_parse_map;
+		return dev_err_probe(dev, ret, "Failed to parse IRQ map\n");
=20
 	priv->big_endian =3D of_device_is_big_endian(node->parent);
 	priv->is_ls1021a_or_ls1043a =3D of_device_is_compatible(node, "fsl,ls1021a-=
extirq") ||
@@ -210,23 +204,26 @@ ls_extirq_of_init(struct device_node *node, struct devi=
ce_node *parent)
=20
 	domain =3D irq_domain_create_hierarchy(parent_domain, 0, priv->nirq, of_fwn=
ode_handle(node),
 					     &extirq_domain_ops, priv);
-	if (!domain) {
-		ret =3D -ENOMEM;
-		goto err_add_hierarchy;
-	}
+	if (!domain)
+		return dev_err_probe(dev, -ENOMEM, "Failed to add IRQ domain\n");
=20
 	return 0;
-
-err_add_hierarchy:
-err_parse_map:
-	iounmap(priv->intpcr);
-err_iomap:
-	kfree(priv);
-err_alloc_priv:
-err_irq_find_host:
-	return ret;
 }
=20
-IRQCHIP_DECLARE(ls1021a_extirq, "fsl,ls1021a-extirq", ls_extirq_of_init);
-IRQCHIP_DECLARE(ls1043a_extirq, "fsl,ls1043a-extirq", ls_extirq_of_init);
-IRQCHIP_DECLARE(ls1088a_extirq, "fsl,ls1088a-extirq", ls_extirq_of_init);
+static const struct of_device_id ls_extirq_dt_ids[] =3D {
+	{ .compatible =3D "fsl,ls1021a-extirq" },
+	{ .compatible =3D "fsl,ls1043a-extirq" },
+	{ .compatible =3D "fsl,ls1088a-extirq" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, ls_extirq_dt_ids);
+
+static struct platform_driver ls_extirq_driver =3D {
+	.probe =3D ls_extirq_probe,
+	.driver =3D {
+		.name =3D "ls-extirq",
+		.of_match_table =3D ls_extirq_dt_ids,
+	}
+};
+
+builtin_platform_driver(ls_extirq_driver);

