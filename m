Return-Path: <linux-tip-commits+bounces-1-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A50380AEB1
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Dec 2023 22:14:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 118A6B20C8A
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Dec 2023 21:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37AE9584EA;
	Fri,  8 Dec 2023 21:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="r4FSgYnO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nNV3ZB9R"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAEC11987;
	Fri,  8 Dec 2023 13:14:44 -0800 (PST)
Date: Fri, 08 Dec 2023 21:14:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702070082;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1gSKYTErsZLP4N632RCFVD1tDI+fX4Wvt9FsdBYZNDI=;
	b=r4FSgYnOh+b2ChBeH35iwDkcbElsHJ6BhIKgjPjQN7hpAF2mxsjg11MFaJT+KzJ1uFhZvG
	NFgOEzsyH1B626tgDABMp/VRpv5X5grgn8JuqWYiCJ0LRUtDjjSdJGTQXc81dtSICRSYej
	BuDBAKHfq21iucC59ih34eM+YztldArCRfkBFt0sJIfYvW7+jzJ63EhucZ7l8UfJESMTsW
	d2rqPNhP1ymOanV8P3P8B2zyanHvcRZz2I4sIv5yegnVYMUCY/Bc7KScuSfuLXR+jfrdNG
	5mBEl8Hni4hnQWmEZH7S/DaeIhnNO2knN6rukr9grx71o+9ZimOo/QHEhEFW2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702070082;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1gSKYTErsZLP4N632RCFVD1tDI+fX4Wvt9FsdBYZNDI=;
	b=nNV3ZB9RkHctXkf1DgVC3hab3WjZYla1UcosCdu9f2uElztxtjfgNbBTuSKet11UR00Oyu
	DdhAscFEZFwKK3DA==
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
Message-ID: <170207008170.398.9595361567170757306.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     0b57d3bb1cc5da335fd4c7a4b1996e7015f4b5d5
Gitweb:        https://git.kernel.org/tip/0b57d3bb1cc5da335fd4c7a4b1996e7015f4b5d5
Author:        Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
AuthorDate:    Mon, 20 Nov 2023 13:18:16 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 08 Dec 2023 22:06:35 +01:00

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

