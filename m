Return-Path: <linux-tip-commits+bounces-1416-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FD9890B2C5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 16:48:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF3AD1F29731
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Jun 2024 14:48:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 273C21D540C;
	Mon, 17 Jun 2024 13:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ntNvRGQI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/cRkXyrb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549D51D2A2D;
	Mon, 17 Jun 2024 13:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718632279; cv=none; b=mtqkBRDDjwAenmXSjyHCEOHf58+XqseBiO6ZS+aHybJRQxG7yqSx3ea92sM+H12tCHUW3DxQfe/32w+0OGQn5uakktj0v29H2omW7SelZAWrL5iGkC3mmpBMVdnfpMirNTXH2Sgk/sbEFx5w6OXK/78acc9QRkruV6sBvP/nNPM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718632279; c=relaxed/simple;
	bh=A+i7Cj3fkbebNzqGx8BGnvzLixx5JCp3k/iXfLKJ6mA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iRemnmBqgbpAdwJszi9R4F//Frg7/NuBFY+bFBJh6WHrX1vIAT6lhPIQh3oQnUWkVZxh9BkqcX+wCk6i2ReSdRHAqt6uishB1Un6wIeUC+LOFax6nDk7nTN4FMvWljSOgvRbuwf7PRo0vDBpP8D6eySlQrHCL4s5HdRsHIPeJjw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ntNvRGQI; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/cRkXyrb; arc=none smtp.client-ip=193.142.43.55
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
	bh=T2V7yNhLGlioi/4gC2B/oT0LjH8pGAeojy4BVHLfosU=;
	b=ntNvRGQI/r3WkFvbiZdF2pFYu5sv1KzWRCA7AauLsftX0JFGR0ZQTJgOfqAhisfy4264Cq
	+Q3XuYK45z3J2xbBNjrfwGmeX7DQ9UC/bLX4ImawabNgXaMYRfsYeE2Xf1xya9YKVmToU4
	efy0I60UBGs3ehkSvWPrdXMq2bHjXKEHNhRjA3MA3fdPJ8+MdzKAErDNEA4Hsnys9pb9Lk
	gpL0cO6S1y4H1EoYWjDp0iTANxoiUbFfz4EhqkQD1ZA754Ekw7xCv19Mesyc+GvUp5oMIU
	aAMqd3XDQBzhupq2YM/frPTYqRYEvBr0/n5QKswR+nGDYXRl7z/WcyAtXiiqDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718632270;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=T2V7yNhLGlioi/4gC2B/oT0LjH8pGAeojy4BVHLfosU=;
	b=/cRkXyrbRAiKjPvVLHLvZ5YQ3bWyVs2TvGvYYZq/tfJAbuM+rIyJLygdfUanIG6wOoEGJa
	IRGbbAbvLe7gGWCQ==
From: "tip-bot2 for Herve Codina" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] genirq/generic_chip: Introduce init() and exit() hooks
Cc: Thomas Gleixner <tglx@linutronix.de>,
 Herve Codina <herve.codina@bootlin.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240614173232.1184015-15-herve.codina@bootlin.com>
References: <20240614173232.1184015-15-herve.codina@bootlin.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171863227017.10875.10234086137407282582.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     fea922ee9f8ffd3c2a8e8dfbc68de42905a3982a
Gitweb:        https://git.kernel.org/tip/fea922ee9f8ffd3c2a8e8dfbc68de42905a3982a
Author:        Herve Codina <herve.codina@bootlin.com>
AuthorDate:    Fri, 14 Jun 2024 19:32:15 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 17 Jun 2024 15:48:14 +02:00

genirq/generic_chip: Introduce init() and exit() hooks

Most of generic chip drivers need to perform some more additional
initializations on the generic chips allocated before they can be fully
ready.

These additional initializations need to be performed before the IRQ
domain is published to avoid a race condition between IRQ consumers and
suppliers.

Introduce the init() hook to perform these initializations at the right
place just after the generic chip creation. Also introduce the exit() hook
to allow reverting operations done by the init() hook just before the
generic chip is destroyed.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Herve Codina <herve.codina@bootlin.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240614173232.1184015-15-herve.codina@bootlin.com

---
 include/linux/irq.h       |  8 ++++++++
 kernel/irq/generic-chip.c | 24 ++++++++++++++++++++++--
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 58264b2..712bcee 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -1106,6 +1106,7 @@ enum irq_gc_flags {
  * @irq_flags_to_set:	IRQ* flags to set on irq setup
  * @irq_flags_to_clear:	IRQ* flags to clear on irq setup
  * @gc_flags:		Generic chip specific setup flags
+ * @exit:		Function called on each chip when they are destroyed.
  * @gc:			Array of pointers to generic interrupt chips
  */
 struct irq_domain_chip_generic {
@@ -1114,6 +1115,7 @@ struct irq_domain_chip_generic {
 	unsigned int		irq_flags_to_clear;
 	unsigned int		irq_flags_to_set;
 	enum irq_gc_flags	gc_flags;
+	void			(*exit)(struct irq_chip_generic *gc);
 	struct irq_chip_generic	*gc[];
 };
 
@@ -1127,6 +1129,10 @@ struct irq_domain_chip_generic {
  * @irq_flags_to_clear:	IRQ_* bits to clear in the mapping function
  * @irq_flags_to_set:	IRQ_* bits to set in the mapping function
  * @gc_flags:		Generic chip specific setup flags
+ * @init:		Function called on each chip when they are created.
+ *			Allow to do some additional chip initialisation.
+ * @exit:		Function called on each chip when they are destroyed.
+ *			Allow to do some chip cleanup operation.
  */
 struct irq_domain_chip_generic_info {
 	const char		*name;
@@ -1136,6 +1142,8 @@ struct irq_domain_chip_generic_info {
 	unsigned int		irq_flags_to_clear;
 	unsigned int		irq_flags_to_set;
 	enum irq_gc_flags	gc_flags;
+	int			(*init)(struct irq_chip_generic *gc);
+	void			(*exit)(struct irq_chip_generic *gc);
 };
 
 /* Generic chip callback functions */
diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index d9696f5..32ffcbb 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -293,6 +293,7 @@ int irq_domain_alloc_generic_chips(struct irq_domain *d,
 	size_t gc_sz;
 	size_t sz;
 	void *tmp;
+	int ret;
 
 	if (d->gc)
 		return -EBUSY;
@@ -314,6 +315,7 @@ int irq_domain_alloc_generic_chips(struct irq_domain *d,
 	dgc->irq_flags_to_set = info->irq_flags_to_set;
 	dgc->irq_flags_to_clear = info->irq_flags_to_clear;
 	dgc->gc_flags = info->gc_flags;
+	dgc->exit = info->exit;
 	d->gc = dgc;
 
 	/* Calc pointer to the first generic chip */
@@ -331,6 +333,12 @@ int irq_domain_alloc_generic_chips(struct irq_domain *d,
 			gc->reg_writel = &irq_writel_be;
 		}
 
+		if (info->init) {
+			ret = info->init(gc);
+			if (ret)
+				goto err;
+		}
+
 		raw_spin_lock_irqsave(&gc_lock, flags);
 		list_add_tail(&gc->list, &gc_list);
 		raw_spin_unlock_irqrestore(&gc_lock, flags);
@@ -338,6 +346,16 @@ int irq_domain_alloc_generic_chips(struct irq_domain *d,
 		tmp += gc_sz;
 	}
 	return 0;
+
+err:
+	while (i--) {
+		if (dgc->exit)
+			dgc->exit(dgc->gc[i]);
+		irq_remove_generic_chip(dgc->gc[i], ~0U, 0, 0);
+	}
+	d->gc = NULL;
+	kfree(dgc);
+	return ret;
 }
 EXPORT_SYMBOL_GPL(irq_domain_alloc_generic_chips);
 
@@ -353,9 +371,11 @@ void irq_domain_remove_generic_chips(struct irq_domain *d)
 	if (!dgc)
 		return;
 
-	for (i = 0; i < dgc->num_chips; i++)
+	for (i = 0; i < dgc->num_chips; i++) {
+		if (dgc->exit)
+			dgc->exit(dgc->gc[i]);
 		irq_remove_generic_chip(dgc->gc[i], ~0U, 0, 0);
-
+	}
 	d->gc = NULL;
 	kfree(dgc);
 }

