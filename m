Return-Path: <linux-tip-commits+bounces-15-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C941380EF1A
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 Dec 2023 15:44:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E27071C20B6F
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 Dec 2023 14:44:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B17C745DE;
	Tue, 12 Dec 2023 14:44:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aX6B9r0Q";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wi1j/Kpz"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92CA2F7;
	Tue, 12 Dec 2023 06:44:25 -0800 (PST)
Date: Tue, 12 Dec 2023 14:44:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702392264;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EBj7xDJIEq6D0WsMhoB3LPit7gFoN547baL40Uvxv0U=;
	b=aX6B9r0QNHPLjCa5ALDjUKdfxb0iWi8YrfmcS1o9/TVzAjI5AHs0RzW+npfdo4w2Kt+skW
	3QEl6g+mg7xSkL6R4nh5i5oOyMKU8SKMKNghvk5kNHIh7MUX78LEs4Pf/0IF4tRBu1eiRV
	qNXx9fFcGuqKRra9eG+7VfjqfBsWyVVHyFYcKnveDiF/u3CAkbL4LB5Re3PHC4Eim9lkXv
	AmTjDo1hJm+0DHXE8g1aj/Tar5GLkPqkAb+hyJLkhd7L8HHWQoECZmbSs7Nns0jMe0vJCR
	cgvIxPLxRztIp8gEnGPKcnh9RzLN1t/sOOMeAjFpM44BYNmphVZyaAkKPsPK3w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702392264;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EBj7xDJIEq6D0WsMhoB3LPit7gFoN547baL40Uvxv0U=;
	b=wi1j/KpziizDDNrVB3LwU5p06OmyQYPsJRsiAZSYCdgAB9a5h+jQboiZLPHxbAnqs6GxDg
	MurvbeKGocmrUoBw==
From: "tip-bot2 for Claudiu Beznea" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/renesas-rzg2l: Implement restriction when
 writing ISCR register
Cc: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20231120111820.87398-6-claudiu.beznea.uj@bp.renesas.com>
References: <20231120111820.87398-6-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170239226360.398.4471792176265602283.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     ef88eefb1a81a8701eabb7d5ced761a66a465a49
Gitweb:        https://git.kernel.org/tip/ef88eefb1a81a8701eabb7d5ced761a66a465a49
Author:        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
AuthorDate:    Mon, 20 Nov 2023 13:18:16 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 12 Dec 2023 15:40:41 +01:00

irqchip/renesas-rzg2l: Implement restriction when writing ISCR register

The RZ/G2L manual (chapter "IRQ Status Control Register (ISCR)") describes
the operation to clear interrupts through the ISCR register as follows:

[Write operation]

  When "Falling-edge detection", "Rising-edge detection" or
  "Falling/Rising-edge detection" is set in IITSR:

    - In case ISTAT is 1
	0: IRQn interrupt detection status is cleared.
	1: Invalid to write.
    - In case ISTAT is 0
	Invalid to write.

  When "Low-level detection" is set in IITSR.:
        Invalid to write.

Take the interrupt type into account when clearing interrupts through the
ISCR register to avoid writing the ISCR when the interrupt type is level.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/r/20231120111820.87398-6-claudiu.beznea.uj@bp.renesas.com

---
 drivers/irqchip/irq-renesas-rzg2l.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzg2l.c b/drivers/irqchip/irq-renesas-rzg2l.c
index 0a77927..d450417 100644
--- a/drivers/irqchip/irq-renesas-rzg2l.c
+++ b/drivers/irqchip/irq-renesas-rzg2l.c
@@ -78,11 +78,17 @@ static void rzg2l_irq_eoi(struct irq_data *d)
 	unsigned int hw_irq = irqd_to_hwirq(d) - IRQC_IRQ_START;
 	struct rzg2l_irqc_priv *priv = irq_data_to_priv(d);
 	u32 bit = BIT(hw_irq);
-	u32 reg;
+	u32 iitsr, iscr;
 
-	reg = readl_relaxed(priv->base + ISCR);
-	if (reg & bit)
-		writel_relaxed(reg & ~bit, priv->base + ISCR);
+	iscr = readl_relaxed(priv->base + ISCR);
+	iitsr = readl_relaxed(priv->base + IITSR);
+
+	/*
+	 * ISCR can only be cleared if the type is falling-edge, rising-edge or
+	 * falling/rising-edge.
+	 */
+	if ((iscr & bit) && (iitsr & IITSR_IITSEL_MASK(hw_irq)))
+		writel_relaxed(iscr & ~bit, priv->base + ISCR);
 }
 
 static void rzg2l_tint_eoi(struct irq_data *d)

