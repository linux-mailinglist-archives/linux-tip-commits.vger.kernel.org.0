Return-Path: <linux-tip-commits+bounces-3649-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88DF0A45C7D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 12:04:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8A72516EF5F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 11:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50D4820D4FC;
	Wed, 26 Feb 2025 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UVac7n5o";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E4O4MZ05"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAF7216F282;
	Wed, 26 Feb 2025 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567842; cv=none; b=g9ohtbzhRBS9JHdaJyn0FJEqTwa+HEKTC7ujHSh8YNxEVoNG2GQ1vJtR10mRAoK+WLTDwSkuYyRtRTyVYD2U+W67QTcN9sxPR/CUTIm15Dma8KsXkHXCl5J1+QlcVmqPHug+LuFTsR9pbi3ELVskVqEI8KeW7nYnjt535UnGkiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567842; c=relaxed/simple;
	bh=UEiS5hYP/HrJTSQWa8e72jhwIpsJX3OAMa8auG2HeJg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=BWtf8sKrZT/mt+QrseVNeYI0S+yKs9zLpnhdRLzTq4Ky048TbO0LF6mrOdBw6jHT1n01aZg7l0GZjrtMzayg3xjfauqAs11fui5uV2bGw8qeCCs4+SsgsrZcBHfVs9NjG4HD3UZfBY5WzCNI1GlUPB7K6qLRK0ll9Sztjk1hNdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UVac7n5o; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E4O4MZ05; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 11:03:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740567839;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zFwdFQ9RXaWSvtNX2ijlFzaom3AQS1YdkK/FfaW5eLY=;
	b=UVac7n5oSUZZ8KkBHwSdpXKMKCmbrMLOz0rxoIbzHKHcE0poCj3abcX/ReyMixyFtpIvPs
	RO2Z1uFhkvxAogXGUzISR8uWi7QOGKorYHW1AoZtQfXUXHTqIJvXcpkiTRZfANyCfkir9n
	Lh2X+Tl5ThxAagRnfov0399nnz/KgQ+Lasm9HX6Yi0tpF+oxxxHGtk1BZazTge9Y4m8CEP
	V0gYKfUIvoUAb5+RyJ89iWHc1skJ5wPR3/1m5pIK6L0lVw3Rm1lZUlU//l69Rgj1xhs822
	OFPGvXE6X1SCOuvV9xsXuV3lWTVUkZQqRpgkn+mdmzOZ58GhPpd5MUi+uYZxGw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740567839;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zFwdFQ9RXaWSvtNX2ijlFzaom3AQS1YdkK/FfaW5eLY=;
	b=E4O4MZ05ha1Evs22KR5LXdw/lHuf9wcQqkLu68jNLHoQeoGHXZvifbNLi64YuXtIon9YWx
	PJ8a+khm0gPpt7Ag==
From: "tip-bot2 for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/renesas-rzv2h: Add field_width to struct
 rzv2h_hw_info
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250224131253.134199-10-biju.das.jz@bp.renesas.com>
References: <20250224131253.134199-10-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174056783856.10177.9397714286817041051.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     1a6ebcc10b138a6c55f8df2cf6cc630ddabe3cab
Gitweb:        https://git.kernel.org/tip/1a6ebcc10b138a6c55f8df2cf6cc630ddabe3cab
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Mon, 24 Feb 2025 13:11:25 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 26 Feb 2025 11:59:50 +01:00

irqchip/renesas-rzv2h: Add field_width to struct rzv2h_hw_info

On RZ/G3E the field width for TSSR register for a TINT is 16 compared to 8
on the RZ/V2H.

Add field_width to struct rzv2h_hw_info and replace the macros ICU_TSSR_K
and ICU_TSSR_TSSEL_N by a runtime evaluation:

    (32 / field_width) provides the number of tints in the TSSR register.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/all/20250224131253.134199-10-biju.das.jz@bp.renesas.com

---
 drivers/irqchip/irq-renesas-rzv2h.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index 2fae327..98a6a7c 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -64,8 +64,6 @@
 #define ICU_TINT_LEVEL_HIGH			2
 #define ICU_TINT_LEVEL_LOW			3
 
-#define ICU_TSSR_K(tint_nr)			((tint_nr) / 4)
-#define ICU_TSSR_TSSEL_N(tint_nr)		((tint_nr) % 4)
 #define ICU_TSSR_TSSEL_PREP(tssel, n)		((tssel) << ((n) * 8))
 #define ICU_TSSR_TSSEL_MASK(n)			ICU_TSSR_TSSEL_PREP(0x7F, n)
 #define ICU_TSSR_TIEN(n)			(BIT(7) << ((n) * 8))
@@ -84,10 +82,12 @@
  * struct rzv2h_hw_info - Interrupt Control Unit controller hardware info structure.
  * @t_offs:		TINT offset
  * @max_tssel:		TSSEL max value
+ * @field_width:	TSSR field width
  */
 struct rzv2h_hw_info {
 	u16		t_offs;
 	u8		max_tssel;
+	u8		field_width;
 };
 
 /**
@@ -140,13 +140,15 @@ static void rzv2h_tint_irq_endisable(struct irq_data *d, bool enable)
 	struct rzv2h_icu_priv *priv = irq_data_to_priv(d);
 	unsigned int hw_irq = irqd_to_hwirq(d);
 	u32 tint_nr, tssel_n, k, tssr;
+	u8 nr_tint;
 
 	if (hw_irq < ICU_TINT_START)
 		return;
 
 	tint_nr = hw_irq - ICU_TINT_START;
-	k = ICU_TSSR_K(tint_nr);
-	tssel_n = ICU_TSSR_TSSEL_N(tint_nr);
+	nr_tint = 32 / priv->info->field_width;
+	k = tint_nr / nr_tint;
+	tssel_n = tint_nr % nr_tint;
 
 	guard(raw_spinlock)(&priv->lock);
 	tssr = readl_relaxed(priv->base + priv->info->t_offs + ICU_TSSR(k));
@@ -278,6 +280,7 @@ static int rzv2h_tint_set_type(struct irq_data *d, unsigned int type)
 	unsigned int hwirq;
 	u32 tint, sense;
 	int tint_nr;
+	u8 nr_tint;
 
 	switch (type & IRQ_TYPE_SENSE_MASK) {
 	case IRQ_TYPE_LEVEL_LOW:
@@ -308,8 +311,9 @@ static int rzv2h_tint_set_type(struct irq_data *d, unsigned int type)
 	hwirq = irqd_to_hwirq(d);
 	tint_nr = hwirq - ICU_TINT_START;
 
-	tssr_k = ICU_TSSR_K(tint_nr);
-	tssel_n = ICU_TSSR_TSSEL_N(tint_nr);
+	nr_tint = 32 / priv->info->field_width;
+	tssr_k = tint_nr / nr_tint;
+	tssel_n = tint_nr % nr_tint;
 	tien = ICU_TSSR_TIEN(tssel_n);
 
 	titsr_k = ICU_TITSR_K(tint_nr);
@@ -519,6 +523,7 @@ pm_put:
 static const struct rzv2h_hw_info rzv2h_hw_params = {
 	.t_offs		= 0,
 	.max_tssel	= ICU_RZV2H_TSSEL_MAX_VAL,
+	.field_width	= 8,
 };
 
 static int rzv2h_icu_init(struct device_node *node, struct device_node *parent)

