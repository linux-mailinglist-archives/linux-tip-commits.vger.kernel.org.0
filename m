Return-Path: <linux-tip-commits+bounces-1411-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6293390B2BF
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 16:47:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E15681F292E3
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 14:47:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9498A1D3375;
	Mon, 17 Jun 2024 13:51:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aV5E+N3t";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="w/3CwZLM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 282DF1D2152;
	Mon, 17 Jun 2024 13:51:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632277; cv=none; b=UX4uPvpmOlrbBWrTWvGDPLVZKuXnZsrvRUyYs3jxcFoaFp/77q4ADFuRc2qLdTD7x7UMatfieEMQTAdTOLTzcp56PKw3QEMkJa7iB7MHQcnRwCF3ahsjHq6ckTYtn5HIP46haKWsmYe2qbrWaTQR/Ms59OUFMBIiaH2oDaccJoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632277; c=relaxed/simple;
	bh=22MOoLTDD0SY/2ALD5cAZkkr31/3Q1Hs6gfaUARXlZ4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Hkiwp+aQE8t13xsaaotEJl3BZug56kpyHX/QSIO5Dz5I5MZEmlPZVe+bB7oVSadJCojbs5D6RvhpZ4PAYZdTsdHDrvGeHExKe9KJOWzPUTkMxzsJXJMl8xAKC3hDqPS3jgzWuXo2y7jsFXr4+Zv3ZORsNv2LaLMj1GngHygMYEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aV5E+N3t; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=w/3CwZLM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Jun 2024 13:51:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718632270;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3S9ELFub5thPcDooeVLXIKd0nYwaEFK3GDN3sowVCQ0=;
	b=aV5E+N3tICbPhON1WZsd5eB7KX+vb6Qj2WuczRyNa3tGDhDUU4AfRG3t45hR4PX+2Vofph
	wobLA2dMim0etA+ez0yebt9wBJJg3LtU5ghe33Ehxv6NrRVIKMT41NdWKHAzqHxYH8A7cU
	O4UPClOBtc1XIJfb/7F8YH+5M3fgfEJJ/7acU3XIfMDUqi/leuppdI/dZs1178gjYKaUwg
	ORWSChOtCdFAWnBQYYCv1qM9XN/Gq4AtBRIiP65RoHaz+4WDAmFbOLW/k+9mJcSvNQzRGH
	oaV3afC6GwpRlh3Cw/A/j+ic7Ibj/0VUs8julVgUYP2GfwZ7alDKtv7lsU4wdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718632270;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3S9ELFub5thPcDooeVLXIKd0nYwaEFK3GDN3sowVCQ0=;
	b=w/3CwZLM9Or88wnXjvxVQAX/tEvKauf6z0Hkzr7QVNVFpFtOrrBq744bZiQYFzTZazl0kY
	WBsIJnW6XUZWWyBA==
From: "tip-bot2 for Herve Codina" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/generic_chip: Introduce
 irq_domain_{alloc,remove}_generic_chips()
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Herve Codina <herve.codina@bootlin.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240614173232.1184015-14-herve.codina@bootlin.com>
References: <20240614173232.1184015-14-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171863227050.10875.6471791790295093098.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e25f553a92973eaf59ff3a00fe7f61ab01b2877f
Gitweb:        https://git.kernel.org/tip/e25f553a92973eaf59ff3a00fe7f61ab01b2877f
Author:        Herve Codina <herve.codina@bootlin.com>
AuthorDate:    Fri, 14 Jun 2024 19:32:14 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Jun 2024 15:48:14 +02:00

genirq/generic_chip: Introduce irq_domain_{alloc,remove}_generic_chips()

The existing __irq_alloc_domain_generic_chips() uses a bunch of parameters
to describe the generic chips that need to be allocated.

Adding more parameters and wrappers to hide new parameters in the existing
code leads to more and more code without any relevant values and without
any flexibility.

Introduce irq_domain_alloc_generic_chips() where the generic chips
description is done using the irq_domain_chip_generic_info structure
instead of the bunch of parameters to allow flexibility and easy evolution.

Also introduce irq_domain_remove_generic_chips() to revert the operations
done by irq_domain_alloc_generic_chips().

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240614173232.1184015-14-herve.codina@bootlin.com

---
 include/linux/irq.h       | 25 ++++++++++-
 kernel/irq/generic-chip.c | 91 ++++++++++++++++++++++++++++----------
 2 files changed, 93 insertions(+), 23 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index a217e10..58264b2 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1117,6 +1117,27 @@ struct irq_domain_chip_generic {
 	struct irq_chip_generic	*gc[];
 };
 
+/**
+ * struct irq_domain_chip_generic_info - Generic chip information structure
+ * @name:		Name of the generic interrupt chip
+ * @handler:		Interrupt handler used by the generic interrupt chip
+ * @irqs_per_chip:	Number of interrupts each chip handles (max 32)
+ * @num_ct:		Number of irq_chip_type instances associated with each
+ *			chip
+ * @irq_flags_to_clear:	IRQ_* bits to clear in the mapping function
+ * @irq_flags_to_set:	IRQ_* bits to set in the mapping function
+ * @gc_flags:		Generic chip specific setup flags
+ */
+struct irq_domain_chip_generic_info {
+	const char		*name;
+	irq_flow_handler_t	handler;
+	unsigned int		irqs_per_chip;
+	unsigned int		num_ct;
+	unsigned int		irq_flags_to_clear;
+	unsigned int		irq_flags_to_set;
+	enum irq_gc_flags	gc_flags;
+};
+
 /* Generic chip callback functions */
 void irq_gc_noop(struct irq_data *d);
 void irq_gc_mask_disable_reg(struct irq_data *d);
@@ -1153,6 +1174,10 @@ int devm_irq_setup_generic_chip(struct device *dev, struct irq_chip_generic *gc,
 
 struct irq_chip_generic *irq_get_domain_generic_chip(struct irq_domain *d, unsigned int hw_irq);
 
+int irq_domain_alloc_generic_chips(struct irq_domain *d,
+				   const struct irq_domain_chip_generic_info *info);
+void irq_domain_remove_generic_chips(struct irq_domain *d);
+
 int __irq_alloc_domain_generic_chips(struct irq_domain *d, int irqs_per_chip,
 				     int num_ct, const char *name,
 				     irq_flow_handler_t handler,
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index d39a40b..d9696f5 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -276,21 +276,14 @@ irq_gc_init_mask_cache(struct irq_chip_generic *gc, enum irq_gc_flags flags)
 }
 
 /**
- * __irq_alloc_domain_generic_chips - Allocate generic chips for an irq domain
- * @d:			irq domain for which to allocate chips
- * @irqs_per_chip:	Number of interrupts each chip handles (max 32)
- * @num_ct:		Number of irq_chip_type instances associated with this
- * @name:		Name of the irq chip
- * @handler:		Default flow handler associated with these chips
- * @clr:		IRQ_* bits to clear in the mapping function
- * @set:		IRQ_* bits to set in the mapping function
- * @gcflags:		Generic chip specific setup flags
+ * irq_domain_alloc_generic_chips - Allocate generic chips for an irq domain
+ * @d:		irq domain for which to allocate chips
+ * @info:	Generic chip information
+ *
+ * Return: 0 on success, negative error code on failure
  */
-int __irq_alloc_domain_generic_chips(struct irq_domain *d, int irqs_per_chip,
-				     int num_ct, const char *name,
-				     irq_flow_handler_t handler,
-				     unsigned int clr, unsigned int set,
-				     enum irq_gc_flags gcflags)
+int irq_domain_alloc_generic_chips(struct irq_domain *d,
+				   const struct irq_domain_chip_generic_info *info)
 {
 	struct irq_domain_chip_generic *dgc;
 	struct irq_chip_generic *gc;
@@ -304,23 +297,23 @@ int __irq_alloc_domain_generic_chips(struct irq_domain *d, int irqs_per_chip,
 	if (d->gc)
 		return -EBUSY;
 
-	numchips = DIV_ROUND_UP(d->revmap_size, irqs_per_chip);
+	numchips = DIV_ROUND_UP(d->revmap_size, info->irqs_per_chip);
 	if (!numchips)
 		return -EINVAL;
 
 	/* Allocate a pointer, generic chip and chiptypes for each chip */
-	gc_sz = struct_size(gc, chip_types, num_ct);
+	gc_sz = struct_size(gc, chip_types, info->num_ct);
 	dgc_sz = struct_size(dgc, gc, numchips);
 	sz = dgc_sz + numchips * gc_sz;
 
 	tmp = dgc = kzalloc(sz, GFP_KERNEL);
 	if (!dgc)
 		return -ENOMEM;
-	dgc->irqs_per_chip = irqs_per_chip;
+	dgc->irqs_per_chip = info->irqs_per_chip;
 	dgc->num_chips = numchips;
-	dgc->irq_flags_to_set = set;
-	dgc->irq_flags_to_clear = clr;
-	dgc->gc_flags = gcflags;
+	dgc->irq_flags_to_set = info->irq_flags_to_set;
+	dgc->irq_flags_to_clear = info->irq_flags_to_clear;
+	dgc->gc_flags = info->gc_flags;
 	d->gc = dgc;
 
 	/* Calc pointer to the first generic chip */
@@ -328,11 +321,12 @@ int __irq_alloc_domain_generic_chips(struct irq_domain *d, int irqs_per_chip,
 	for (i = 0; i < numchips; i++) {
 		/* Store the pointer to the generic chip */
 		dgc->gc[i] = gc = tmp;
-		irq_init_generic_chip(gc, name, num_ct, i * irqs_per_chip,
-				      NULL, handler);
+		irq_init_generic_chip(gc, info->name, info->num_ct,
+				      i * dgc->irqs_per_chip, NULL,
+				      info->handler);
 
 		gc->domain = d;
-		if (gcflags & IRQ_GC_BE_IO) {
+		if (dgc->gc_flags & IRQ_GC_BE_IO) {
 			gc->reg_readl = &irq_readl_be;
 			gc->reg_writel = &irq_writel_be;
 		}
@@ -345,6 +339,57 @@ int __irq_alloc_domain_generic_chips(struct irq_domain *d, int irqs_per_chip,
 	}
 	return 0;
 }
+EXPORT_SYMBOL_GPL(irq_domain_alloc_generic_chips);
+
+/**
+ * irq_domain_remove_generic_chips - Remove generic chips from an irq domain
+ * @d: irq domain for which generic chips are to be removed
+ */
+void irq_domain_remove_generic_chips(struct irq_domain *d)
+{
+	struct irq_domain_chip_generic *dgc = d->gc;
+	unsigned int i;
+
+	if (!dgc)
+		return;
+
+	for (i = 0; i < dgc->num_chips; i++)
+		irq_remove_generic_chip(dgc->gc[i], ~0U, 0, 0);
+
+	d->gc = NULL;
+	kfree(dgc);
+}
+EXPORT_SYMBOL_GPL(irq_domain_remove_generic_chips);
+
+/**
+ * __irq_alloc_domain_generic_chips - Allocate generic chips for an irq domain
+ * @d:			irq domain for which to allocate chips
+ * @irqs_per_chip:	Number of interrupts each chip handles (max 32)
+ * @num_ct:		Number of irq_chip_type instances associated with this
+ * @name:		Name of the irq chip
+ * @handler:		Default flow handler associated with these chips
+ * @clr:		IRQ_* bits to clear in the mapping function
+ * @set:		IRQ_* bits to set in the mapping function
+ * @gcflags:		Generic chip specific setup flags
+ */
+int __irq_alloc_domain_generic_chips(struct irq_domain *d, int irqs_per_chip,
+				     int num_ct, const char *name,
+				     irq_flow_handler_t handler,
+				     unsigned int clr, unsigned int set,
+				     enum irq_gc_flags gcflags)
+{
+	struct irq_domain_chip_generic_info info = {
+		.irqs_per_chip		= irqs_per_chip,
+		.num_ct			= num_ct,
+		.name			= name,
+		.handler		= handler,
+		.irq_flags_to_clear	= clr,
+		.irq_flags_to_set	= set,
+		.gc_flags		= gcflags,
+	};
+
+	return irq_domain_alloc_generic_chips(d, &info);
+}
 EXPORT_SYMBOL_GPL(__irq_alloc_domain_generic_chips);
 
 static struct irq_chip_generic *

