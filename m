Return-Path: <linux-tip-commits+bounces-5318-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F3BB9AAC762
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 16:05:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F08363BC51C
	for <lists+linux-tip-commits@lfdr.de>; Tue,  6 May 2025 14:04:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB1DF2820C1;
	Tue,  6 May 2025 14:04:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3ej3j+T8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MyCcBXqb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 158BA281507;
	Tue,  6 May 2025 14:04:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746540271; cv=none; b=UUKEJfMTe9OHRJeQe+rvWVvVgYuNaU6Q7PzwktACfaoc/rQ7jPJOgSvqvG8kZ9x8arKa4g166zih7rcfnU7++ndgvAeuYkzIkH81jqMRS/Hg48O6hQAD/KxCeC7ebqEqFiCHNn2dZHz6EE7pG8EfC6bXVev5ms0N1+NunR/Q5f4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746540271; c=relaxed/simple;
	bh=ENaQ2PzWS92JBF+yspYIqHukFHUz0pz3xHNNgbHYsFo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=sJDXOCijmCaWq6NNHbD8mFvNclEftDWezCAaosVuvtlhuJic9Nms2UCVHlIrvz2wqzpzIJ9KpYleIXcZo7o7bTcGCkcIMjI9fQozd+tuczg4oKmB5KGbSNWuoPtVfWOb8q3rI7/dy/E1dO/s3450/f6AJMk8+H/wfGRsNGUGwg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3ej3j+T8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MyCcBXqb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 06 May 2025 14:04:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746540268;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zHR08mLvZHM3AQBeFMF29tWfvyZEiFphtvn8oLR6464=;
	b=3ej3j+T8TCCa6vHIiefb37ZQ47fuQCdhVxbKJYLFukgwqZqUzrLFFkVEtuPBgktDi3Sv95
	ultonKPzlvHX+mY2HPJbla+AejYE+io9WysOg/m4qmqvbCGPxHkKYD0p5jfpq6Wa7mdmHv
	qeeiiGJzHwth3oSjDHH1txQuGcxmDGfcHWTxFrWgbLPbb/lalUsStkTq07rQIAaH7w/4L7
	mp3H9/ekX4s4A4FtpNkgQP9q4h/OX8Qsr8FlxASs1C0OFlsmVgZIMq8BXxXUGvTSzK8ss6
	NHNa0Er/zyZusgivaxCbpRAa19wta24RIpLxLjDsfK+z/Uk3vL3MmCioarhmDg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746540268;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zHR08mLvZHM3AQBeFMF29tWfvyZEiFphtvn8oLR6464=;
	b=MyCcBXqbwxS8uBkkgbYBULHKy7ahyITXO4jhk41svJAn9dY1yUdrbQ//ufADlvF7QG0PvN
	E3QJoYKX5wj4oHAQ==
From: "tip-bot2 for Alexey Charkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/irq-vt8500: Split up ack/mask functions
Cc: Alexey Charkov <alchark@gmail.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250506-vt8500-intc-updates-v2-1-a3a0606cf92d@gmail.com>
References: <20250506-vt8500-intc-updates-v2-1-a3a0606cf92d@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174654026763.406.1381391833665407399.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     22111fdf11666e4ff2bb80481a874a6b958323f2
Gitweb:        https://git.kernel.org/tip/22111fdf11666e4ff2bb80481a874a6b958323f2
Author:        Alexey Charkov <alchark@gmail.com>
AuthorDate:    Tue, 06 May 2025 16:46:14 +04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 06 May 2025 15:58:26 +02:00

irqchip/irq-vt8500: Split up ack/mask functions

vt8500_irq_mask() really does the ACK for edge triggered interrupts and the
MASK for level triggered interrupts.  Edge triggered interrupts never
really are masked as a result, and there is unnecessary reading of the
status register before the ACK even though it's write-one-to-clear.

Split it up into a proper standalone vt8500_irq_ack() and an unconditional
vt8500_irq_mask().

No Fixes tag added, as it has survived this way for 15 years and nobody
complained, so apparently nothing really used edge triggered interrupts
anyway.

[ tglx: Tabularize the irqchip struct initializer ]

Signed-off-by: Alexey Charkov <alchark@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250506-vt8500-intc-updates-v2-1-a3a0606cf92d@gmail.com
---
 drivers/irqchip/irq-vt8500.c | 40 +++++++++++++++++------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/drivers/irqchip/irq-vt8500.c b/drivers/irqchip/irq-vt8500.c
index e17dd3a..9fb9d37 100644
--- a/drivers/irqchip/irq-vt8500.c
+++ b/drivers/irqchip/irq-vt8500.c
@@ -67,25 +67,25 @@ struct vt8500_irq_data {
 static struct vt8500_irq_data intc[VT8500_INTC_MAX];
 static u32 active_cnt = 0;
 
-static void vt8500_irq_mask(struct irq_data *d)
+static void vt8500_irq_ack(struct irq_data *d)
 {
 	struct vt8500_irq_data *priv = d->domain->host_data;
 	void __iomem *base = priv->base;
 	void __iomem *stat_reg = base + VT8500_ICIS + (d->hwirq < 32 ? 0 : 4);
-	u8 edge, dctr;
-	u32 status;
-
-	edge = readb(base + VT8500_ICDC + d->hwirq) & VT8500_EDGE;
-	if (edge) {
-		status = readl(stat_reg);
-
-		status |= (1 << (d->hwirq & 0x1f));
-		writel(status, stat_reg);
-	} else {
-		dctr = readb(base + VT8500_ICDC + d->hwirq);
-		dctr &= ~VT8500_INT_ENABLE;
-		writeb(dctr, base + VT8500_ICDC + d->hwirq);
-	}
+	u32 status = (1 << (d->hwirq & 0x1f));
+
+	writel(status, stat_reg);
+}
+
+static void vt8500_irq_mask(struct irq_data *d)
+{
+	struct vt8500_irq_data *priv = d->domain->host_data;
+	void __iomem *base = priv->base;
+	u8 dctr;
+
+	dctr = readb(base + VT8500_ICDC + d->hwirq);
+	dctr &= ~VT8500_INT_ENABLE;
+	writeb(dctr, base + VT8500_ICDC + d->hwirq);
 }
 
 static void vt8500_irq_unmask(struct irq_data *d)
@@ -130,11 +130,11 @@ static int vt8500_irq_set_type(struct irq_data *d, unsigned int flow_type)
 }
 
 static struct irq_chip vt8500_irq_chip = {
-	.name = "vt8500",
-	.irq_ack = vt8500_irq_mask,
-	.irq_mask = vt8500_irq_mask,
-	.irq_unmask = vt8500_irq_unmask,
-	.irq_set_type = vt8500_irq_set_type,
+	.name		= "vt8500",
+	.irq_ack	= vt8500_irq_ack,
+	.irq_mask	= vt8500_irq_mask,
+	.irq_unmask	= vt8500_irq_unmask,
+	.irq_set_type	= vt8500_irq_set_type,
 };
 
 static void __init vt8500_init_irq_hw(void __iomem *base)

