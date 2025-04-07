Return-Path: <linux-tip-commits+bounces-4721-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E4232A7D6DD
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 09:54:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 945727A3D69
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 07:53:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F9E5226D19;
	Mon,  7 Apr 2025 07:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s0P6w2ta";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="5VACVvij"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8E6C224B1B;
	Mon,  7 Apr 2025 07:53:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744012435; cv=none; b=e9dP0nhh3wj/RtcHRB1ggIJfFFjKZv2GSZsyrYdadW8eCjJmr2tbRGglwrQkeboL8NsWRqrGKBhSW091gBaWo8JqWOvB344JiUaycEVUoong7yzavO3RAGw1Ri8IsoQ2LPtUHmU7UGtlESQHpCN+0qnml1ojxREDDRTJ4jCUkwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744012435; c=relaxed/simple;
	bh=WLwPdHgGl4FyXW9Gt++8KpkpCvVd3h8BdNTWGx33eDE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hx4pKIsgcK4tqPanm0c1K7Lw/PVqzQDFbbfQDHCBNJHHIanXLmffpIpL3sQJPXw9u5CWt/pyEdOIV56n1wAYOFuQn/HXae6XZGVRrAOiLEodHyc4Rct7CgW9sUcwdzKCgqJIepriy0FXWDxtQjUCUfZ0Mmiu5Ydkki2bcLBj6Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s0P6w2ta; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=5VACVvij; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Apr 2025 07:53:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744012430;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zSg0P6MgBkIGFvhhSH1gq59NvLUnDaMjX0gLdL2Y3UQ=;
	b=s0P6w2tasjV4ysMalIvWtiyuguC5sfpzLc6SF/WVjPbi5pVRWKjWYSEkPVibuBx4CVnZlk
	g77sHWYYPaz/Dhpt8H+pYflOYiiiSvlwGokBzq1MwT2LF0yjKCD2ymOPbOcP3gIe1k9iNN
	JBaG6Aws0VCquSwP8n8ZtyknPxZdru52NuA/DI2wdFNqdTp2NEyKoaGuj4gqmA5Zdxhg8h
	LO0alTdYw2K6kkTYBXHtoMDnzYL+muG3M7fpUyqi1CPLtNqIHuI5nCHsrJ0FfBEyZlIReB
	WxDjUKNN3N61rJZ4/3UGiH4N8jFv+FOMCuM8+yRpuqh4K/ZkheBgDkJWgOsO6Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744012430;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zSg0P6MgBkIGFvhhSH1gq59NvLUnDaMjX0gLdL2Y3UQ=;
	b=5VACVvijju88Ygg4E2l22bfHHb8v8B74Kf/t5Ga5thCWZC4GnKNkJKXSJubF9oX8sVdQhG
	n6C9NiKLGteSEyAg==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip: Convert generic irqchip locking to guards
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Linus Walleij <linus.walleij@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250313142524.325627746@linutronix.de>
References: <20250313142524.325627746@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174401242986.31282.14463568640389385402.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     b00bee8afaca47fd4f716488eb3663ac1f0abc31
Gitweb:        https://git.kernel.org/tip/b00bee8afaca47fd4f716488eb3663ac1f0abc31
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 13 Mar 2025 15:31:27 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 07 Apr 2025 09:43:20 +02:00

irqchip: Convert generic irqchip locking to guards

Conversion was done with Coccinelle and a few manual fixups.

In a few interrupt chip callbacks this changes replaces
raw_spin_lock_irqsave() with a guard(raw_spinlock). That's intended and
correct because those interrupt chip callbacks are invoked with the
interrupt descriptor lock held and interrupts disabled. No point in using
the irqsave variant.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/all/20250313142524.325627746@linutronix.de

---
 drivers/irqchip/irq-al-fic.c           | 18 ++++------------
 drivers/irqchip/irq-atmel-aic.c        | 19 +++++------------
 drivers/irqchip/irq-atmel-aic5.c       | 28 +++++++------------------
 drivers/irqchip/irq-bcm7120-l2.c       | 22 ++++++++------------
 drivers/irqchip/irq-brcmstb-l2.c       |  8 +------
 drivers/irqchip/irq-csky-apb-intc.c    |  3 +--
 drivers/irqchip/irq-dw-apb-ictl.c      |  3 +--
 drivers/irqchip/irq-ingenic-tcu.c      |  9 ++------
 drivers/irqchip/irq-lan966x-oic.c      | 18 ++++++----------
 drivers/irqchip/irq-loongson-liointc.c |  9 +-------
 drivers/irqchip/irq-mscc-ocelot.c      |  3 +--
 drivers/irqchip/irq-stm32-exti.c       | 21 +++++--------------
 drivers/irqchip/irq-sunxi-nmi.c        |  9 +-------
 drivers/irqchip/irq-tb10x.c            | 13 ++----------
 14 files changed, 56 insertions(+), 127 deletions(-)

diff --git a/drivers/irqchip/irq-al-fic.c b/drivers/irqchip/irq-al-fic.c
index dfb761e..7308b8d 100644
--- a/drivers/irqchip/irq-al-fic.c
+++ b/drivers/irqchip/irq-al-fic.c
@@ -65,15 +65,13 @@ static int al_fic_irq_set_type(struct irq_data *data, unsigned int flow_type)
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
 	struct al_fic *fic = gc->private;
 	enum al_fic_state new_state;
-	int ret = 0;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 
 	if (((flow_type & IRQ_TYPE_SENSE_MASK) != IRQ_TYPE_LEVEL_HIGH) &&
 	    ((flow_type & IRQ_TYPE_SENSE_MASK) != IRQ_TYPE_EDGE_RISING)) {
 		pr_debug("fic doesn't support flow type %d\n", flow_type);
-		ret = -EINVAL;
-		goto err;
+		return -EINVAL;
 	}
 
 	new_state = (flow_type & IRQ_TYPE_LEVEL_HIGH) ?
@@ -91,16 +89,10 @@ static int al_fic_irq_set_type(struct irq_data *data, unsigned int flow_type)
 	if (fic->state == AL_FIC_UNCONFIGURED) {
 		al_fic_set_trigger(fic, gc, new_state);
 	} else if (fic->state != new_state) {
-		pr_debug("fic %s state already configured to %d\n",
-			 fic->name, fic->state);
-		ret = -EINVAL;
-		goto err;
+		pr_debug("fic %s state already configured to %d\n", fic->name, fic->state);
+		return -EINVAL;
 	}
-
-err:
-	irq_gc_unlock(gc);
-
-	return ret;
+	return 0;
 }
 
 static void al_fic_irq_handler(struct irq_desc *desc)
diff --git a/drivers/irqchip/irq-atmel-aic.c b/drivers/irqchip/irq-atmel-aic.c
index 3839ad7..03aeed3 100644
--- a/drivers/irqchip/irq-atmel-aic.c
+++ b/drivers/irqchip/irq-atmel-aic.c
@@ -78,9 +78,8 @@ static int aic_retrigger(struct irq_data *d)
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 
 	/* Enable interrupt on AIC5 */
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	irq_reg_writel(gc, d->mask, AT91_AIC_ISCR);
-	irq_gc_unlock(gc);
 
 	return 1;
 }
@@ -106,30 +105,27 @@ static void aic_suspend(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	irq_reg_writel(gc, gc->mask_cache, AT91_AIC_IDCR);
 	irq_reg_writel(gc, gc->wake_active, AT91_AIC_IECR);
-	irq_gc_unlock(gc);
 }
 
 static void aic_resume(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	irq_reg_writel(gc, gc->wake_active, AT91_AIC_IDCR);
 	irq_reg_writel(gc, gc->mask_cache, AT91_AIC_IECR);
-	irq_gc_unlock(gc);
 }
 
 static void aic_pm_shutdown(struct irq_data *d)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	irq_reg_writel(gc, 0xffffffff, AT91_AIC_IDCR);
 	irq_reg_writel(gc, 0xffffffff, AT91_AIC_ICCR);
-	irq_gc_unlock(gc);
 }
 #else
 #define aic_suspend		NULL
@@ -175,10 +171,8 @@ static int aic_irq_domain_xlate(struct irq_domain *d,
 {
 	struct irq_domain_chip_generic *dgc = d->gc;
 	struct irq_chip_generic *gc;
-	unsigned long flags;
 	unsigned smr;
-	int idx;
-	int ret;
+	int idx, ret;
 
 	if (!dgc)
 		return -EINVAL;
@@ -194,11 +188,10 @@ static int aic_irq_domain_xlate(struct irq_domain *d,
 
 	gc = dgc->gc[idx];
 
-	irq_gc_lock_irqsave(gc, flags);
+	guard(raw_spinlock_irq)(&gc->lock);
 	smr = irq_reg_readl(gc, AT91_AIC_SMR(*out_hwirq));
 	aic_common_set_priority(intspec[2], &smr);
 	irq_reg_writel(gc, smr, AT91_AIC_SMR(*out_hwirq));
-	irq_gc_unlock_irqrestore(gc, flags);
 
 	return ret;
 }
diff --git a/drivers/irqchip/irq-atmel-aic5.c b/drivers/irqchip/irq-atmel-aic5.c
index e98c287..60b00d2 100644
--- a/drivers/irqchip/irq-atmel-aic5.c
+++ b/drivers/irqchip/irq-atmel-aic5.c
@@ -92,11 +92,10 @@ static void aic5_mask(struct irq_data *d)
 	 * Disable interrupt on AIC5. We always take the lock of the
 	 * first irq chip as all chips share the same registers.
 	 */
-	irq_gc_lock(bgc);
+	guard(raw_spinlock)(&bgc->lock);
 	irq_reg_writel(gc, d->hwirq, AT91_AIC5_SSR);
 	irq_reg_writel(gc, 1, AT91_AIC5_IDCR);
 	gc->mask_cache &= ~d->mask;
-	irq_gc_unlock(bgc);
 }
 
 static void aic5_unmask(struct irq_data *d)
@@ -109,11 +108,10 @@ static void aic5_unmask(struct irq_data *d)
 	 * Enable interrupt on AIC5. We always take the lock of the
 	 * first irq chip as all chips share the same registers.
 	 */
-	irq_gc_lock(bgc);
+	guard(raw_spinlock)(&bgc->lock);
 	irq_reg_writel(gc, d->hwirq, AT91_AIC5_SSR);
 	irq_reg_writel(gc, 1, AT91_AIC5_IECR);
 	gc->mask_cache |= d->mask;
-	irq_gc_unlock(bgc);
 }
 
 static int aic5_retrigger(struct irq_data *d)
@@ -122,11 +120,9 @@ static int aic5_retrigger(struct irq_data *d)
 	struct irq_chip_generic *bgc = irq_get_domain_generic_chip(domain, 0);
 
 	/* Enable interrupt on AIC5 */
-	irq_gc_lock(bgc);
+	guard(raw_spinlock)(&bgc->lock);
 	irq_reg_writel(bgc, d->hwirq, AT91_AIC5_SSR);
 	irq_reg_writel(bgc, 1, AT91_AIC5_ISCR);
-	irq_gc_unlock(bgc);
-
 	return 1;
 }
 
@@ -137,14 +133,12 @@ static int aic5_set_type(struct irq_data *d, unsigned type)
 	unsigned int smr;
 	int ret;
 
-	irq_gc_lock(bgc);
+	guard(raw_spinlock)(&bgc->lock);
 	irq_reg_writel(bgc, d->hwirq, AT91_AIC5_SSR);
 	smr = irq_reg_readl(bgc, AT91_AIC5_SMR);
 	ret = aic_common_set_type(d, type, &smr);
 	if (!ret)
 		irq_reg_writel(bgc, smr, AT91_AIC5_SMR);
-	irq_gc_unlock(bgc);
-
 	return ret;
 }
 
@@ -166,7 +160,7 @@ static void aic5_suspend(struct irq_data *d)
 			smr_cache[i] = irq_reg_readl(bgc, AT91_AIC5_SMR);
 		}
 
-	irq_gc_lock(bgc);
+	guard(raw_spinlock)(&bgc->lock);
 	for (i = 0; i < dgc->irqs_per_chip; i++) {
 		mask = 1 << i;
 		if ((mask & gc->mask_cache) == (mask & gc->wake_active))
@@ -178,7 +172,6 @@ static void aic5_suspend(struct irq_data *d)
 		else
 			irq_reg_writel(bgc, 1, AT91_AIC5_IDCR);
 	}
-	irq_gc_unlock(bgc);
 }
 
 static void aic5_resume(struct irq_data *d)
@@ -190,7 +183,7 @@ static void aic5_resume(struct irq_data *d)
 	int i;
 	u32 mask;
 
-	irq_gc_lock(bgc);
+	guard(raw_spinlock)(&bgc->lock);
 
 	if (smr_cache) {
 		irq_reg_writel(bgc, 0xffffffff, AT91_AIC5_SPU);
@@ -214,7 +207,6 @@ static void aic5_resume(struct irq_data *d)
 		else
 			irq_reg_writel(bgc, 1, AT91_AIC5_IDCR);
 	}
-	irq_gc_unlock(bgc);
 }
 
 static void aic5_pm_shutdown(struct irq_data *d)
@@ -225,13 +217,12 @@ static void aic5_pm_shutdown(struct irq_data *d)
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	int i;
 
-	irq_gc_lock(bgc);
+	guard(raw_spinlock)(&bgc->lock);
 	for (i = 0; i < dgc->irqs_per_chip; i++) {
 		irq_reg_writel(bgc, i + gc->irq_base, AT91_AIC5_SSR);
 		irq_reg_writel(bgc, 1, AT91_AIC5_IDCR);
 		irq_reg_writel(bgc, 1, AT91_AIC5_ICCR);
 	}
-	irq_gc_unlock(bgc);
 }
 #else
 #define aic5_suspend		NULL
@@ -277,7 +268,6 @@ static int aic5_irq_domain_xlate(struct irq_domain *d,
 				 unsigned int *out_type)
 {
 	struct irq_chip_generic *bgc = irq_get_domain_generic_chip(d, 0);
-	unsigned long flags;
 	unsigned smr;
 	int ret;
 
@@ -289,13 +279,11 @@ static int aic5_irq_domain_xlate(struct irq_domain *d,
 	if (ret)
 		return ret;
 
-	irq_gc_lock_irqsave(bgc, flags);
+	guard(raw_spinlock_irq)(&bgc->lock);
 	irq_reg_writel(bgc, *out_hwirq, AT91_AIC5_SSR);
 	smr = irq_reg_readl(bgc, AT91_AIC5_SMR);
 	aic_common_set_priority(intspec[2], &smr);
 	irq_reg_writel(bgc, smr, AT91_AIC5_SMR);
-	irq_gc_unlock_irqrestore(bgc, flags);
-
 	return ret;
 }
 
diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index 1e9dab6..90909f8 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -63,16 +63,15 @@ static void bcm7120_l2_intc_irq_handle(struct irq_desc *desc)
 
 	for (idx = 0; idx < b->n_words; idx++) {
 		int base = idx * IRQS_PER_WORD;
-		struct irq_chip_generic *gc =
-			irq_get_domain_generic_chip(b->domain, base);
+		struct irq_chip_generic *gc;
 		unsigned long pending;
 		int hwirq;
 
-		irq_gc_lock(gc);
-		pending = irq_reg_readl(gc, b->stat_offset[idx]) &
-					    gc->mask_cache &
-					    data->irq_map_mask[idx];
-		irq_gc_unlock(gc);
+		gc = irq_get_domain_generic_chip(b->domain, base);
+		scoped_guard (raw_spinlock, &gc->lock) {
+			pending = irq_reg_readl(gc, b->stat_offset[idx]) & gc->mask_cache &
+				data->irq_map_mask[idx];
+		}
 
 		for_each_set_bit(hwirq, &pending, IRQS_PER_WORD)
 			generic_handle_domain_irq(b->domain, base + hwirq);
@@ -86,11 +85,9 @@ static void bcm7120_l2_intc_suspend(struct irq_chip_generic *gc)
 	struct bcm7120_l2_intc_data *b = gc->private;
 	struct irq_chip_type *ct = gc->chip_types;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	if (b->can_wake)
-		irq_reg_writel(gc, gc->mask_cache | gc->wake_active,
-			       ct->regs.mask);
-	irq_gc_unlock(gc);
+		irq_reg_writel(gc, gc->mask_cache | gc->wake_active, ct->regs.mask);
 }
 
 static void bcm7120_l2_intc_resume(struct irq_chip_generic *gc)
@@ -98,9 +95,8 @@ static void bcm7120_l2_intc_resume(struct irq_chip_generic *gc)
 	struct irq_chip_type *ct = gc->chip_types;
 
 	/* Restore the saved mask */
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	irq_reg_writel(gc, gc->mask_cache, ct->regs.mask);
-	irq_gc_unlock(gc);
 }
 
 static int bcm7120_l2_intc_init_one(struct device_node *dn,
diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index db4c972..aa4e123 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -97,9 +97,8 @@ static void __brcmstb_l2_intc_suspend(struct irq_data *d, bool save)
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	struct brcmstb_l2_intc_data *b = gc->private;
-	unsigned long flags;
 
-	irq_gc_lock_irqsave(gc, flags);
+	guard(raw_spinlock_irqsave)(&gc->lock);
 	/* Save the current mask */
 	if (save)
 		b->saved_mask = irq_reg_readl(gc, ct->regs.mask);
@@ -109,7 +108,6 @@ static void __brcmstb_l2_intc_suspend(struct irq_data *d, bool save)
 		irq_reg_writel(gc, ~gc->wake_active, ct->regs.disable);
 		irq_reg_writel(gc, gc->wake_active, ct->regs.enable);
 	}
-	irq_gc_unlock_irqrestore(gc, flags);
 }
 
 static void brcmstb_l2_intc_shutdown(struct irq_data *d)
@@ -127,9 +125,8 @@ static void brcmstb_l2_intc_resume(struct irq_data *d)
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	struct brcmstb_l2_intc_data *b = gc->private;
-	unsigned long flags;
 
-	irq_gc_lock_irqsave(gc, flags);
+	guard(raw_spinlock_irqsave)(&gc->lock);
 	if (ct->chip.irq_ack) {
 		/* Clear unmasked non-wakeup interrupts */
 		irq_reg_writel(gc, ~b->saved_mask & ~gc->wake_active,
@@ -139,7 +136,6 @@ static void brcmstb_l2_intc_resume(struct irq_data *d)
 	/* Restore the saved mask */
 	irq_reg_writel(gc, b->saved_mask, ct->regs.disable);
 	irq_reg_writel(gc, ~b->saved_mask, ct->regs.enable);
-	irq_gc_unlock_irqrestore(gc, flags);
 }
 
 static int __init brcmstb_l2_intc_of_init(struct device_node *np,
diff --git a/drivers/irqchip/irq-csky-apb-intc.c b/drivers/irqchip/irq-csky-apb-intc.c
index 6710691..6e17186 100644
--- a/drivers/irqchip/irq-csky-apb-intc.c
+++ b/drivers/irqchip/irq-csky-apb-intc.c
@@ -50,11 +50,10 @@ static void irq_ck_mask_set_bit(struct irq_data *d)
 	unsigned long ifr = ct->regs.mask - 8;
 	u32 mask = d->mask;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	*ct->mask_cache |= mask;
 	irq_reg_writel(gc, *ct->mask_cache, ct->regs.mask);
 	irq_reg_writel(gc, irq_reg_readl(gc, ifr) & ~mask, ifr);
-	irq_gc_unlock(gc);
 }
 
 static void __init ck_set_gc(struct device_node *node, void __iomem *reg_base,
diff --git a/drivers/irqchip/irq-dw-apb-ictl.c b/drivers/irqchip/irq-dw-apb-ictl.c
index d5c1c75..6874ec8 100644
--- a/drivers/irqchip/irq-dw-apb-ictl.c
+++ b/drivers/irqchip/irq-dw-apb-ictl.c
@@ -101,10 +101,9 @@ static void dw_apb_ictl_resume(struct irq_data *d)
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	writel_relaxed(~0, gc->reg_base + ct->regs.enable);
 	writel_relaxed(*ct->mask_cache, gc->reg_base + ct->regs.mask);
-	irq_gc_unlock(gc);
 }
 #else
 #define dw_apb_ictl_resume	NULL
diff --git a/drivers/irqchip/irq-ingenic-tcu.c b/drivers/irqchip/irq-ingenic-tcu.c
index 3363f83..945fd57 100644
--- a/drivers/irqchip/irq-ingenic-tcu.c
+++ b/drivers/irqchip/irq-ingenic-tcu.c
@@ -52,11 +52,10 @@ static void ingenic_tcu_gc_unmask_enable_reg(struct irq_data *d)
 	struct regmap *map = gc->private;
 	u32 mask = d->mask;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	regmap_write(map, ct->regs.ack, mask);
 	regmap_write(map, ct->regs.enable, mask);
 	*ct->mask_cache |= mask;
-	irq_gc_unlock(gc);
 }
 
 static void ingenic_tcu_gc_mask_disable_reg(struct irq_data *d)
@@ -66,10 +65,9 @@ static void ingenic_tcu_gc_mask_disable_reg(struct irq_data *d)
 	struct regmap *map = gc->private;
 	u32 mask = d->mask;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	regmap_write(map, ct->regs.disable, mask);
 	*ct->mask_cache &= ~mask;
-	irq_gc_unlock(gc);
 }
 
 static void ingenic_tcu_gc_mask_disable_reg_and_ack(struct irq_data *d)
@@ -79,10 +77,9 @@ static void ingenic_tcu_gc_mask_disable_reg_and_ack(struct irq_data *d)
 	struct regmap *map = gc->private;
 	u32 mask = d->mask;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	regmap_write(map, ct->regs.ack, mask);
 	regmap_write(map, ct->regs.disable, mask);
-	irq_gc_unlock(gc);
 }
 
 static int __init ingenic_tcu_irq_init(struct device_node *np,
diff --git a/drivers/irqchip/irq-lan966x-oic.c b/drivers/irqchip/irq-lan966x-oic.c
index 41ac880..f77bd2a 100644
--- a/drivers/irqchip/irq-lan966x-oic.c
+++ b/drivers/irqchip/irq-lan966x-oic.c
@@ -71,14 +71,12 @@ static unsigned int lan966x_oic_irq_startup(struct irq_data *data)
 	struct lan966x_oic_chip_regs *chip_regs = gc->private;
 	u32 map;
 
-	irq_gc_lock(gc);
-
-	/* Map the source interrupt to the destination */
-	map = irq_reg_readl(gc, chip_regs->reg_off_map);
-	map |= data->mask;
-	irq_reg_writel(gc, map, chip_regs->reg_off_map);
-
-	irq_gc_unlock(gc);
+	scoped_guard (raw_spinlock, &gc->lock) {
+		/* Map the source interrupt to the destination */
+		map = irq_reg_readl(gc, chip_regs->reg_off_map);
+		map |= data->mask;
+		irq_reg_writel(gc, map, chip_regs->reg_off_map);
+	}
 
 	ct->chip.irq_ack(data);
 	ct->chip.irq_unmask(data);
@@ -95,14 +93,12 @@ static void lan966x_oic_irq_shutdown(struct irq_data *data)
 
 	ct->chip.irq_mask(data);
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 
 	/* Unmap the interrupt */
 	map = irq_reg_readl(gc, chip_regs->reg_off_map);
 	map &= ~data->mask;
 	irq_reg_writel(gc, map, chip_regs->reg_off_map);
-
-	irq_gc_unlock(gc);
 }
 
 static int lan966x_oic_irq_set_type(struct irq_data *data,
diff --git a/drivers/irqchip/irq-loongson-liointc.c b/drivers/irqchip/irq-loongson-liointc.c
index 2b1bd4a..61c0b47 100644
--- a/drivers/irqchip/irq-loongson-liointc.c
+++ b/drivers/irqchip/irq-loongson-liointc.c
@@ -116,9 +116,8 @@ static int liointc_set_type(struct irq_data *data, unsigned int type)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
 	u32 mask = data->mask;
-	unsigned long flags;
 
-	irq_gc_lock_irqsave(gc, flags);
+	guard(raw_spinlock)(&gc->lock);
 	switch (type) {
 	case IRQ_TYPE_LEVEL_HIGH:
 		liointc_set_bit(gc, LIOINTC_REG_INTC_EDGE, mask, false);
@@ -137,10 +136,8 @@ static int liointc_set_type(struct irq_data *data, unsigned int type)
 		liointc_set_bit(gc, LIOINTC_REG_INTC_POL, mask, true);
 		break;
 	default:
-		irq_gc_unlock_irqrestore(gc, flags);
 		return -EINVAL;
 	}
-	irq_gc_unlock_irqrestore(gc, flags);
 
 	irqd_set_trigger_type(data, type);
 	return 0;
@@ -157,10 +154,9 @@ static void liointc_suspend(struct irq_chip_generic *gc)
 static void liointc_resume(struct irq_chip_generic *gc)
 {
 	struct liointc_priv *priv = gc->private;
-	unsigned long flags;
 	int i;
 
-	irq_gc_lock_irqsave(gc, flags);
+	guard(raw_spinlock_irqsave)(&gc->lock);
 	/* Disable all at first */
 	writel(0xffffffff, gc->reg_base + LIOINTC_REG_INTC_DISABLE);
 	/* Restore map cache */
@@ -170,7 +166,6 @@ static void liointc_resume(struct irq_chip_generic *gc)
 	writel(priv->int_edge, gc->reg_base + LIOINTC_REG_INTC_EDGE);
 	/* Restore mask cache */
 	writel(gc->mask_cache, gc->reg_base + LIOINTC_REG_INTC_ENABLE);
-	irq_gc_unlock_irqrestore(gc, flags);
 }
 
 static int parent_irq[LIOINTC_NUM_PARENT];
diff --git a/drivers/irqchip/irq-mscc-ocelot.c b/drivers/irqchip/irq-mscc-ocelot.c
index 3dc745b..d69c5f1 100644
--- a/drivers/irqchip/irq-mscc-ocelot.c
+++ b/drivers/irqchip/irq-mscc-ocelot.c
@@ -83,7 +83,7 @@ static void ocelot_irq_unmask(struct irq_data *data)
 	unsigned int mask = data->mask;
 	u32 val;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	/*
 	 * Clear sticky bits for edge mode interrupts.
 	 * Serval has only one trigger register replication, but the adjacent
@@ -97,7 +97,6 @@ static void ocelot_irq_unmask(struct irq_data *data)
 
 	*ct->mask_cache &= ~mask;
 	irq_reg_writel(gc, mask, p->reg_off_ena_set);
-	irq_gc_unlock(gc);
 }
 
 static void ocelot_irq_handler(struct irq_desc *desc)
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 7c6a008..477046d 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -169,22 +169,18 @@ static int stm32_irq_set_type(struct irq_data *d, unsigned int type)
 	u32 rtsr, ftsr;
 	int err;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 
 	rtsr = irq_reg_readl(gc, stm32_bank->rtsr_ofst);
 	ftsr = irq_reg_readl(gc, stm32_bank->ftsr_ofst);
 
 	err = stm32_exti_set_type(d, type, &rtsr, &ftsr);
 	if (err)
-		goto unlock;
+		return err;
 
 	irq_reg_writel(gc, rtsr, stm32_bank->rtsr_ofst);
 	irq_reg_writel(gc, ftsr, stm32_bank->ftsr_ofst);
-
-unlock:
-	irq_gc_unlock(gc);
-
-	return err;
+	return 0;
 }
 
 static void stm32_chip_suspend(struct stm32_exti_chip_data *chip_data,
@@ -217,18 +213,16 @@ static void stm32_irq_suspend(struct irq_chip_generic *gc)
 {
 	struct stm32_exti_chip_data *chip_data = gc->private;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	stm32_chip_suspend(chip_data, gc->wake_active);
-	irq_gc_unlock(gc);
 }
 
 static void stm32_irq_resume(struct irq_chip_generic *gc)
 {
 	struct stm32_exti_chip_data *chip_data = gc->private;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	stm32_chip_resume(chip_data, gc->mask_cache);
-	irq_gc_unlock(gc);
 }
 
 static int stm32_exti_alloc(struct irq_domain *d, unsigned int virq,
@@ -265,11 +259,8 @@ static void stm32_irq_ack(struct irq_data *d)
 	struct stm32_exti_chip_data *chip_data = gc->private;
 	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
 
-	irq_gc_lock(gc);
-
+	guard(raw_spinlock)(&gc->lock);
 	irq_reg_writel(gc, d->mask, stm32_bank->rpr_ofst);
-
-	irq_gc_unlock(gc);
 }
 
 static struct
diff --git a/drivers/irqchip/irq-sunxi-nmi.c b/drivers/irqchip/irq-sunxi-nmi.c
index 01b0d83..4c977ac 100644
--- a/drivers/irqchip/irq-sunxi-nmi.c
+++ b/drivers/irqchip/irq-sunxi-nmi.c
@@ -111,7 +111,7 @@ static int sunxi_sc_nmi_set_type(struct irq_data *data, unsigned int flow_type)
 	unsigned int src_type;
 	unsigned int i;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 
 	switch (flow_type & IRQF_TRIGGER_MASK) {
 	case IRQ_TYPE_EDGE_FALLING:
@@ -128,9 +128,7 @@ static int sunxi_sc_nmi_set_type(struct irq_data *data, unsigned int flow_type)
 		src_type = SUNXI_SRC_TYPE_LEVEL_LOW;
 		break;
 	default:
-		irq_gc_unlock(gc);
-		pr_err("Cannot assign multiple trigger modes to IRQ %d.\n",
-			data->irq);
+		pr_err("Cannot assign multiple trigger modes to IRQ %d.\n", data->irq);
 		return -EBADR;
 	}
 
@@ -145,9 +143,6 @@ static int sunxi_sc_nmi_set_type(struct irq_data *data, unsigned int flow_type)
 	src_type_reg &= ~SUNXI_NMI_SRC_TYPE_MASK;
 	src_type_reg |= src_type;
 	sunxi_sc_nmi_write(gc, ctrl_off, src_type_reg);
-
-	irq_gc_unlock(gc);
-
 	return IRQ_SET_MASK_OK;
 }
 
diff --git a/drivers/irqchip/irq-tb10x.c b/drivers/irqchip/irq-tb10x.c
index d59bfbe..aa80944 100644
--- a/drivers/irqchip/irq-tb10x.c
+++ b/drivers/irqchip/irq-tb10x.c
@@ -41,11 +41,9 @@ static inline u32 ab_irqctl_readreg(struct irq_chip_generic *gc, u32 reg)
 static int tb10x_irq_set_type(struct irq_data *data, unsigned int flow_type)
 {
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(data);
-	uint32_t im, mod, pol;
+	uint32_t mod, pol, im = data->mask;
 
-	im = data->mask;
-
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 
 	mod = ab_irqctl_readreg(gc, AB_IRQCTL_SRC_MODE) | im;
 	pol = ab_irqctl_readreg(gc, AB_IRQCTL_SRC_POLARITY) | im;
@@ -67,9 +65,7 @@ static int tb10x_irq_set_type(struct irq_data *data, unsigned int flow_type)
 	case IRQ_TYPE_EDGE_RISING:
 		break;
 	default:
-		irq_gc_unlock(gc);
-		pr_err("%s: Cannot assign multiple trigger modes to IRQ %d.\n",
-			__func__, data->irq);
+		pr_err("%s: Cannot assign multiple trigger modes to IRQ %d.\n",	__func__, data->irq);
 		return -EBADR;
 	}
 
@@ -79,9 +75,6 @@ static int tb10x_irq_set_type(struct irq_data *data, unsigned int flow_type)
 	ab_irqctl_writereg(gc, AB_IRQCTL_SRC_MODE, mod);
 	ab_irqctl_writereg(gc, AB_IRQCTL_SRC_POLARITY, pol);
 	ab_irqctl_writereg(gc, AB_IRQCTL_INT_STATUS, im);
-
-	irq_gc_unlock(gc);
-
 	return IRQ_SET_MASK_OK;
 }
 

