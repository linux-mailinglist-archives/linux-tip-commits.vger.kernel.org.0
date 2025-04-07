Return-Path: <linux-tip-commits+bounces-4723-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 31409A7D6DF
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 09:54:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id EE3D17A64C3
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Apr 2025 07:53:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A4B5225761;
	Mon,  7 Apr 2025 07:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KtoQItP+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HgQrKR60"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 064322288D6;
	Mon,  7 Apr 2025 07:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744012438; cv=none; b=AJC7T6RR0sVVna6HPbUsy3wzyrfAwJAXggO0NXEVQmuSt4QLC1KsjcNFZIwAVqKwnDA66fK02NNnNdlCn4Sg1PPFetjEv867tNdLVddHTHdwfVWDE1CgALEZv3abAW+ljnljGPxhQ/eYhKr6Vg8aRlAGeWwdWDyrdCw9GtNqu3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744012438; c=relaxed/simple;
	bh=gGkswHNzINNdFsP9SJpDktLBPqmUX6Lt0KysiFkjMtc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Is/YTUd2+gric9b2FAYToIN/RpvK6SxfEOTIqRGdlILRI0KuXH0JUpByxRdreMzDFWDEbF5fGO56wz/ZZURBdGhqoshTrjlVQLZZDutorLnCEcw8BHHqbfRCIWNQ+fxVKBwAEDo2Vhmp9en7eOtT4XvgjxSzTBd8p3bd9TjCT6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KtoQItP+; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HgQrKR60; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 07 Apr 2025 07:53:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744012434;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/qV8uZ/hPAUNlkC+aLTxBf0CBmHJ/mJOCdsA25+iUaw=;
	b=KtoQItP+dBqUbPDKfZYCrKCTxvnHr2UlBkCS7B7dVct/dqotaTiQxQ1Opaalb9+dGCMH85
	nyVIO5hXP4DWAnVy+5rsDe1BFd0v/XMC3YASgvbDmAJgMslbOWYOvRxmKiTOZaoNtMicsl
	eM/VZRwTwPTF3fKzShK1i8AgcpfDD1DRTscFxm3eA6EKTuFGddCqcmvEF0fiyXpAckCsRq
	FhuD1g7LTIqIUeJAenw1plmuFgjjdGCNXyTasQGDXihsGXZfKC+434/SqqyF4od0wU9gqV
	guWL36Pm6VP9O9ZAaDRBPDN2kc56ZRmUTQxYBmz9Ba3OS+HdO7LIXjhwmmvG3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744012434;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/qV8uZ/hPAUNlkC+aLTxBf0CBmHJ/mJOCdsA25+iUaw=;
	b=HgQrKR60YmupwUm2WFqoa4VLrsr8iQFxXF5diHu8Tqr/doGeDFBZ2O0O7N1AuFi5BSfntm
	yxK8tz7clW1k1HAQ==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/drivers] genirq/generic-chip: Convert core code to lock guards
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Linus Walleij <linus.walleij@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250313142524.073826193@linutronix.de>
References: <20250313142524.073826193@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174401243327.31282.1077969855884256359.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     195298c3b11628a6c52c515c31470e673cf259a9
Gitweb:        https://git.kernel.org/tip/195298c3b11628a6c52c515c31470e673cf259a9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 13 Mar 2025 15:31:17 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 07 Apr 2025 09:43:19 +02:00

genirq/generic-chip: Convert core code to lock guards

Replace the irq_gc_lock/unlock() pairs with guards. There is no point to
implement a guard wrapper for them as they just wrap around raw_spin_lock*().

Switch the other lock instances in the core code to guards as well.

Conversion was done with Coccinelle plus manual fixups.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
Link: https://lore.kernel.org/all/20250313142524.073826193@linutronix.de

---
 kernel/irq/generic-chip.c | 47 ++++++++++++--------------------------
 1 file changed, 16 insertions(+), 31 deletions(-)

diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index c4a8bca..8014bfe 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -40,10 +40,9 @@ void irq_gc_mask_disable_reg(struct irq_data *d)
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	u32 mask = d->mask;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	irq_reg_writel(gc, mask, ct->regs.disable);
 	*ct->mask_cache &= ~mask;
-	irq_gc_unlock(gc);
 }
 EXPORT_SYMBOL_GPL(irq_gc_mask_disable_reg);
 
@@ -60,10 +59,9 @@ void irq_gc_mask_set_bit(struct irq_data *d)
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	u32 mask = d->mask;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	*ct->mask_cache |= mask;
 	irq_reg_writel(gc, *ct->mask_cache, ct->regs.mask);
-	irq_gc_unlock(gc);
 }
 EXPORT_SYMBOL_GPL(irq_gc_mask_set_bit);
 
@@ -80,10 +78,9 @@ void irq_gc_mask_clr_bit(struct irq_data *d)
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	u32 mask = d->mask;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	*ct->mask_cache &= ~mask;
 	irq_reg_writel(gc, *ct->mask_cache, ct->regs.mask);
-	irq_gc_unlock(gc);
 }
 EXPORT_SYMBOL_GPL(irq_gc_mask_clr_bit);
 
@@ -100,10 +97,9 @@ void irq_gc_unmask_enable_reg(struct irq_data *d)
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	u32 mask = d->mask;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	irq_reg_writel(gc, mask, ct->regs.enable);
 	*ct->mask_cache |= mask;
-	irq_gc_unlock(gc);
 }
 EXPORT_SYMBOL_GPL(irq_gc_unmask_enable_reg);
 
@@ -117,9 +113,8 @@ void irq_gc_ack_set_bit(struct irq_data *d)
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	u32 mask = d->mask;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	irq_reg_writel(gc, mask, ct->regs.ack);
-	irq_gc_unlock(gc);
 }
 EXPORT_SYMBOL_GPL(irq_gc_ack_set_bit);
 
@@ -133,9 +128,8 @@ void irq_gc_ack_clr_bit(struct irq_data *d)
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	u32 mask = ~d->mask;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	irq_reg_writel(gc, mask, ct->regs.ack);
-	irq_gc_unlock(gc);
 }
 
 /**
@@ -156,11 +150,10 @@ void irq_gc_mask_disable_and_ack_set(struct irq_data *d)
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	u32 mask = d->mask;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	irq_reg_writel(gc, mask, ct->regs.disable);
 	*ct->mask_cache &= ~mask;
 	irq_reg_writel(gc, mask, ct->regs.ack);
-	irq_gc_unlock(gc);
 }
 EXPORT_SYMBOL_GPL(irq_gc_mask_disable_and_ack_set);
 
@@ -174,9 +167,8 @@ void irq_gc_eoi(struct irq_data *d)
 	struct irq_chip_type *ct = irq_data_get_chip_type(d);
 	u32 mask = d->mask;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	irq_reg_writel(gc, mask, ct->regs.eoi);
-	irq_gc_unlock(gc);
 }
 
 /**
@@ -196,12 +188,11 @@ int irq_gc_set_wake(struct irq_data *d, unsigned int on)
 	if (!(mask & gc->wake_enabled))
 		return -EINVAL;
 
-	irq_gc_lock(gc);
+	guard(raw_spinlock)(&gc->lock);
 	if (on)
 		gc->wake_active |= mask;
 	else
 		gc->wake_active &= ~mask;
-	irq_gc_unlock(gc);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(irq_gc_set_wake);
@@ -288,7 +279,6 @@ int irq_domain_alloc_generic_chips(struct irq_domain *d,
 {
 	struct irq_domain_chip_generic *dgc;
 	struct irq_chip_generic *gc;
-	unsigned long flags;
 	int numchips, i;
 	size_t dgc_sz;
 	size_t gc_sz;
@@ -340,9 +330,8 @@ int irq_domain_alloc_generic_chips(struct irq_domain *d,
 				goto err;
 		}
 
-		raw_spin_lock_irqsave(&gc_lock, flags);
-		list_add_tail(&gc->list, &gc_list);
-		raw_spin_unlock_irqrestore(&gc_lock, flags);
+		scoped_guard (raw_spinlock, &gc_lock)
+			list_add_tail(&gc->list, &gc_list);
 		/* Calc pointer to the next generic chip */
 		tmp += gc_sz;
 	}
@@ -459,7 +448,6 @@ int irq_map_generic_chip(struct irq_domain *d, unsigned int virq,
 	struct irq_chip_generic *gc;
 	struct irq_chip_type *ct;
 	struct irq_chip *chip;
-	unsigned long flags;
 	int idx;
 
 	gc = __irq_get_domain_generic_chip(d, hw_irq);
@@ -479,9 +467,8 @@ int irq_map_generic_chip(struct irq_domain *d, unsigned int virq,
 
 	/* We only init the cache for the first mapping of a generic chip */
 	if (!gc->installed) {
-		raw_spin_lock_irqsave(&gc->lock, flags);
+		guard(raw_spinlock_irq)(&gc->lock);
 		irq_gc_init_mask_cache(gc, dgc->gc_flags);
-		raw_spin_unlock_irqrestore(&gc->lock, flags);
 	}
 
 	/* Mark the interrupt as installed */
@@ -548,9 +535,8 @@ void irq_setup_generic_chip(struct irq_chip_generic *gc, u32 msk,
 	struct irq_chip *chip = &ct->chip;
 	unsigned int i;
 
-	raw_spin_lock(&gc_lock);
-	list_add_tail(&gc->list, &gc_list);
-	raw_spin_unlock(&gc_lock);
+	scoped_guard (raw_spinlock, &gc_lock)
+		list_add_tail(&gc->list, &gc_list);
 
 	irq_gc_init_mask_cache(gc, flags);
 
@@ -616,9 +602,8 @@ void irq_remove_generic_chip(struct irq_chip_generic *gc, u32 msk,
 {
 	unsigned int i, virq;
 
-	raw_spin_lock(&gc_lock);
-	list_del(&gc->list);
-	raw_spin_unlock(&gc_lock);
+	scoped_guard (raw_spinlock, &gc_lock)
+		list_del(&gc->list);
 
 	for (i = 0; msk; msk >>= 1, i++) {
 		if (!(msk & 0x01))

