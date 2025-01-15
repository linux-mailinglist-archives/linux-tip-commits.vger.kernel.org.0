Return-Path: <linux-tip-commits+bounces-3213-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1F5EA11D25
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 10:16:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB39B3A43F9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 15 Jan 2025 09:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6DFE206F35;
	Wed, 15 Jan 2025 09:16:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ua0bBQrK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ozz9r8Bn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD2761EE7AC;
	Wed, 15 Jan 2025 09:16:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736932586; cv=none; b=D3WXL4AHP+dkroN8RJ3S1E3OFYrTadUhS/8X9raK26dQU4pk8aK/dnT9UJxp22BrkrkfGrsbl4LnD25Pmqn1V2vbZOke7D9ckSFeEC7nyQByKb/0OACwmqEiwZowk2XK7x5I3JpO+uG0UBHVXYyP7/BcJPmn7+G7QacWvLHSIyM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736932586; c=relaxed/simple;
	bh=UXNG7H18ajjRbC6pRLyOYdV2t3Bvj0LG46PShfuDLKI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RT3wE4YrFk5xET6iNpj80HCc/bfzaecZUNC5nvBN+QWzLRDC5+qbRWa4VKSznOSonK5jrJEw4zKcVxXSQGcSy+UkRbyC3AoNDLB+thdnHjvltruPZbpRDrYW4pbqjq3nlHrZYpgQLTpdYVRQYNswP42OqYKH8zpPYgk1MjD9Qto=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ua0bBQrK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Ozz9r8Bn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 15 Jan 2025 09:16:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1736932576;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+wB6XhRMe8lF6KfQoSzbjO+Nirj2gq3CMh3GzPo1H3Y=;
	b=Ua0bBQrKiWt0kswdOcHOn8Z2VhL+aW78mK3JRJBLAIdwRl7WqQEKUUTJBIZUilID0F+rR+
	sOAryNhsSUyHd6VaZ9NoH9WuEXtYXrQLsvS9kghmt0BOqnxjEZ6EB3Fl5ecSTBL7tnmNFG
	vargmqerGZBjkMBXxFs92Qy7jOWSDCMsEnhSrXTc63j0gMszEJ03/v5Hx8cxw70CYvRYih
	UwDFS2fGBNG0W+lYC5ZkqCs0XJsR17ppMaNPX34IhqsjW1NQGpO77c29iQVUBIrO08hx7C
	fIpEOPb+YvdTmLwaxT0wHTB2QNmShT2z67xxHM8pN4q6A8N81tOdOcm/K6CGtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1736932576;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+wB6XhRMe8lF6KfQoSzbjO+Nirj2gq3CMh3GzPo1H3Y=;
	b=Ozz9r8Bn/5GFg/OIc4/UFgaAJRJIdfB5HPM/K//H2djS7fAE7F3/fx57TSiLwjSy1D377u
	1FdYBnAHfOqeNyDw==
From: "tip-bot2 for Dr. David Alan Gilbert" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/irq-brcmstb-l2: Replace
 brcmstb_l2_mask_and_ack() by generic function
Cc: "Dr. David Alan Gilbert" <linux@treblig.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Florian Fainelli <florian.fainelli@broadcom.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20241224001727.149337-1-linux@treblig.org>
References: <20241224001727.149337-1-linux@treblig.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173693257552.31546.6986076583074119681.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     dd1f17a9faf5359d76644236cde4cc1720f1184d
Gitweb:        https://git.kernel.org/tip/dd1f17a9faf5359d76644236cde4cc1720f1184d
Author:        Dr. David Alan Gilbert <linux@treblig.org>
AuthorDate:    Tue, 24 Dec 2024 00:17:27 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 15 Jan 2025 09:47:46 +01:00

irqchip/irq-brcmstb-l2: Replace brcmstb_l2_mask_and_ack() by generic function

Replace brcmstb_l2_mask_and_ack() by the generic
irq_gc_mask_disable_and_ack_set().

brcmstb_l2_mask_and_ack() was added in commit 49aa6ef0b439
("irqchip/brcmstb-l2: Remove some processing from the handler") in
September 2017 with a comment saying it was actually generic and someone
should add it to the generic code.

commit 20608924cc2e ("genirq: generic chip: Add
irq_gc_mask_disable_and_ack_set()") did that a few weeks later, however no
one went back and took the brcmstb variant out.

Signed-off-by: Dr. David Alan Gilbert <linux@treblig.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Florian Fainelli <florian.fainelli@broadcom.com>
Link: https://lore.kernel.org/all/20241224001727.149337-1-linux@treblig.org

---
 drivers/irqchip/irq-brcmstb-l2.c | 28 +---------------------------
 1 file changed, 1 insertion(+), 27 deletions(-)

diff --git a/drivers/irqchip/irq-brcmstb-l2.c b/drivers/irqchip/irq-brcmstb-l2.c
index c988886..db4c972 100644
--- a/drivers/irqchip/irq-brcmstb-l2.c
+++ b/drivers/irqchip/irq-brcmstb-l2.c
@@ -61,32 +61,6 @@ struct brcmstb_l2_intc_data {
 	u32 saved_mask; /* for suspend/resume */
 };
 
-/**
- * brcmstb_l2_mask_and_ack - Mask and ack pending interrupt
- * @d: irq_data
- *
- * Chip has separate enable/disable registers instead of a single mask
- * register and pending interrupt is acknowledged by setting a bit.
- *
- * Note: This function is generic and could easily be added to the
- * generic irqchip implementation if there ever becomes a will to do so.
- * Perhaps with a name like irq_gc_mask_disable_and_ack_set().
- *
- * e.g.: https://patchwork.kernel.org/patch/9831047/
- */
-static void brcmstb_l2_mask_and_ack(struct irq_data *d)
-{
-	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
-	struct irq_chip_type *ct = irq_data_get_chip_type(d);
-	u32 mask = d->mask;
-
-	irq_gc_lock(gc);
-	irq_reg_writel(gc, mask, ct->regs.disable);
-	*ct->mask_cache &= ~mask;
-	irq_reg_writel(gc, mask, ct->regs.ack);
-	irq_gc_unlock(gc);
-}
-
 static void brcmstb_l2_intc_irq_handle(struct irq_desc *desc)
 {
 	struct brcmstb_l2_intc_data *b = irq_desc_get_handler_data(desc);
@@ -248,7 +222,7 @@ static int __init brcmstb_l2_intc_of_init(struct device_node *np,
 	if (init_params->cpu_clear >= 0) {
 		ct->regs.ack = init_params->cpu_clear;
 		ct->chip.irq_ack = irq_gc_ack_set_bit;
-		ct->chip.irq_mask_ack = brcmstb_l2_mask_and_ack;
+		ct->chip.irq_mask_ack = irq_gc_mask_disable_and_ack_set;
 	} else {
 		/* No Ack - but still slightly more efficient to define this */
 		ct->chip.irq_mask_ack = irq_gc_mask_disable_reg;

