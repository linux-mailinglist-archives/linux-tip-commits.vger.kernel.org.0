Return-Path: <linux-tip-commits+bounces-3653-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1169AA45C84
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 12:04:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 116B93A54DB
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 11:04:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7CBC2153C5;
	Wed, 26 Feb 2025 11:04:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kaBbF9RY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1lJMS5nH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB8722135BE;
	Wed, 26 Feb 2025 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567844; cv=none; b=R+88e/WyYVafeBl0VBrGZWjf+9sTaP1pxjmT8NgaoTTH4DTdbhOoc3Z/9iDZEOyDoxIWck3lSo8xr0rhIo7/aJcXeIR5B0rhAHRn8n8QUrxPreJPZhztewRP5EdqRLEy1ipfI/pHJJIl8MCf/apFtKZ2Hm/6zbzQc1op50YpoxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567844; c=relaxed/simple;
	bh=ey66VjZYVSBi2+QAirqHgAiUPRIyvlhutRjao2Efkuo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XJFei4skNOawcQyOToVG51kdfjjl7MDQkACyNlfi9o6orq/MQU5/cjk8hwyeh8669HSiUC/PqopiOKyHTDOxlPhP/HZAoeYPGq5R0DDPGRk0Akuy/wFwPb73AM9GynrdgvzLrB1uK3U79KxMHGAu58MKauazBnLBcm6QLYoZ7dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kaBbF9RY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1lJMS5nH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 11:03:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740567840;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mlt++sA5JhGbJGm4neQxLYDyqD4WD2eib3gM6mVw0pI=;
	b=kaBbF9RYYSMLyRF11BL5dUuXDH8d0sCqyvVlbbLIcZRoxZA/bk9/xR4hf7u0wJQtyc3oQe
	gjE9Zw+OJen9aOVIwt+eQnKBHADHd1BeRIUhymGtMLysOAjN4rlWoZsjTM7CnavVvC5CHV
	VxK7WNhISxO/bfwhZ6y9K0PS9iXURwD8IpLbBnCdaOmEnXz6FryiFvfdkcMW4XMGSGy73z
	PvluJ4L8IFWYhHpzhO3lx9VxJESn3GE29MGeroG5DWdAzjgdfnWduWiBq0iJGLCDW4FQXK
	MzKOhAQF2KGOUxjOUw2mplFOtwgd0tFXBTwx/rJsHkZC9hOfdawUkhH/8dwtFQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740567840;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mlt++sA5JhGbJGm4neQxLYDyqD4WD2eib3gM6mVw0pI=;
	b=1lJMS5nHCbVp/WLoPzCICUhCt7n7FrPgXdqvIUpyZJTsxkXbWWar24+84fFSR9BBmyazZN
	l0TFdBrHYajOIwDQ==
From: "tip-bot2 for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/renesas-rzv2h: Add struct rzv2h_hw_info
 with t_offs variable
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250224131253.134199-8-biju.das.jz@bp.renesas.com>
References: <20250224131253.134199-8-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174056783948.10177.14936069073288004007.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     0a9d6ef64e5e917f93db98935cd09bac38507ebf
Gitweb:        https://git.kernel.org/tip/0a9d6ef64e5e917f93db98935cd09bac38507ebf
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Mon, 24 Feb 2025 13:11:23 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 26 Feb 2025 11:59:50 +01:00

irqchip/renesas-rzv2h: Add struct rzv2h_hw_info with t_offs variable

The ICU block on the RZ/G3E SoC is almost identical to the one found on
the RZ/V2H SoC, with the following differences:

 - The TINT register base offset is 0x800 instead of zero.
 - The number of GPIO interrupts for TINT selection is 141 instead of 86.
 - The pin index and TINT selection index are not in the 1:1 map
 - The number of TSSR registers is 16 instead of 8
 - Each TSSR register can program 2 TINTs instead of 4 TINTs

Introduce struct rzv2h_hw_info to describe the SoC properties and refactor
the code by moving rzv2h_icu_init() into rzv2h_icu_init_common() and pass
the variable containing hw difference to support both these SoCs.

As a first step add t_offs to the new struct and replace the hardcoded
constants in the code.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/all/20250224131253.134199-8-biju.das.jz@bp.renesas.com

---
 drivers/irqchip/irq-renesas-rzv2h.c | 46 ++++++++++++++++++++--------
 1 file changed, 34 insertions(+), 12 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index 10b9b63..43b805b 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -81,15 +81,25 @@
 #define ICU_PB5_TINT				0x55
 
 /**
+ * struct rzv2h_hw_info - Interrupt Control Unit controller hardware info structure.
+ * @t_offs:		TINT offset
+ */
+struct rzv2h_hw_info {
+	u16		t_offs;
+};
+
+/**
  * struct rzv2h_icu_priv - Interrupt Control Unit controller private data structure.
  * @base:	Controller's base address
  * @fwspec:	IRQ firmware specific data
  * @lock:	Lock to serialize access to hardware registers
+ * @info:	Pointer to struct rzv2h_hw_info
  */
 struct rzv2h_icu_priv {
 	void __iomem			*base;
 	struct irq_fwspec		fwspec[ICU_NUM_IRQ];
 	raw_spinlock_t			lock;
+	const struct rzv2h_hw_info	*info;
 };
 
 static inline struct rzv2h_icu_priv *irq_data_to_priv(struct irq_data *data)
@@ -109,7 +119,7 @@ static void rzv2h_icu_eoi(struct irq_data *d)
 			tintirq_nr = hw_irq - ICU_TINT_START;
 			bit = BIT(tintirq_nr);
 			if (!irqd_is_level_type(d))
-				writel_relaxed(bit, priv->base + ICU_TSCLR);
+				writel_relaxed(bit, priv->base + priv->info->t_offs + ICU_TSCLR);
 		} else if (hw_irq >= ICU_IRQ_START) {
 			tintirq_nr = hw_irq - ICU_IRQ_START;
 			bit = BIT(tintirq_nr);
@@ -137,12 +147,12 @@ static void rzv2h_tint_irq_endisable(struct irq_data *d, bool enable)
 	tssel_n = ICU_TSSR_TSSEL_N(tint_nr);
 
 	guard(raw_spinlock)(&priv->lock);
-	tssr = readl_relaxed(priv->base + ICU_TSSR(k));
+	tssr = readl_relaxed(priv->base + priv->info->t_offs + ICU_TSSR(k));
 	if (enable)
 		tssr |= ICU_TSSR_TIEN(tssel_n);
 	else
 		tssr &= ~ICU_TSSR_TIEN(tssel_n);
-	writel_relaxed(tssr, priv->base + ICU_TSSR(k));
+	writel_relaxed(tssr, priv->base + priv->info->t_offs + ICU_TSSR(k));
 }
 
 static void rzv2h_icu_irq_disable(struct irq_data *d)
@@ -245,8 +255,8 @@ static void rzv2h_clear_tint_int(struct rzv2h_icu_priv *priv, unsigned int hwirq
 	u32 bit = BIT(tint_nr);
 	int k = tint_nr / 16;
 
-	tsctr = readl_relaxed(priv->base + ICU_TSCTR);
-	titsr = readl_relaxed(priv->base + ICU_TITSR(k));
+	tsctr = readl_relaxed(priv->base + priv->info->t_offs + ICU_TSCTR);
+	titsr = readl_relaxed(priv->base + priv->info->t_offs + ICU_TITSR(k));
 	titsel = ICU_TITSR_TITSEL_GET(titsr, titsel_n);
 
 	/*
@@ -255,7 +265,7 @@ static void rzv2h_clear_tint_int(struct rzv2h_icu_priv *priv, unsigned int hwirq
 	 */
 	if ((tsctr & bit) && ((titsel == ICU_TINT_EDGE_RISING) ||
 			      (titsel == ICU_TINT_EDGE_FALLING)))
-		writel_relaxed(bit, priv->base + ICU_TSCLR);
+		writel_relaxed(bit, priv->base + priv->info->t_offs + ICU_TSCLR);
 }
 
 static int rzv2h_tint_set_type(struct irq_data *d, unsigned int type)
@@ -306,21 +316,21 @@ static int rzv2h_tint_set_type(struct irq_data *d, unsigned int type)
 
 	guard(raw_spinlock)(&priv->lock);
 
-	tssr = readl_relaxed(priv->base + ICU_TSSR(tssr_k));
+	tssr = readl_relaxed(priv->base + priv->info->t_offs + ICU_TSSR(tssr_k));
 	tssr &= ~(ICU_TSSR_TSSEL_MASK(tssel_n) | tien);
 	tssr |= ICU_TSSR_TSSEL_PREP(tint, tssel_n);
 
-	writel_relaxed(tssr, priv->base + ICU_TSSR(tssr_k));
+	writel_relaxed(tssr, priv->base + priv->info->t_offs + ICU_TSSR(tssr_k));
 
-	titsr = readl_relaxed(priv->base + ICU_TITSR(titsr_k));
+	titsr = readl_relaxed(priv->base + priv->info->t_offs + ICU_TITSR(titsr_k));
 	titsr &= ~ICU_TITSR_TITSEL_MASK(titsel_n);
 	titsr |= ICU_TITSR_TITSEL_PREP(sense, titsel_n);
 
-	writel_relaxed(titsr, priv->base + ICU_TITSR(titsr_k));
+	writel_relaxed(titsr, priv->base + priv->info->t_offs + ICU_TITSR(titsr_k));
 
 	rzv2h_clear_tint_int(priv, hwirq);
 
-	writel_relaxed(tssr | tien, priv->base + ICU_TSSR(tssr_k));
+	writel_relaxed(tssr | tien, priv->base + priv->info->t_offs + ICU_TSSR(tssr_k));
 
 	return 0;
 }
@@ -424,7 +434,8 @@ static void rzv2h_icu_put_device(void *data)
 	put_device(data);
 }
 
-static int rzv2h_icu_init(struct device_node *node, struct device_node *parent)
+static int rzv2h_icu_init_common(struct device_node *node, struct device_node *parent,
+				 const struct rzv2h_hw_info *hw_info)
 {
 	struct irq_domain *irq_domain, *parent_domain;
 	struct rzv2h_icu_priv *rzv2h_icu_data;
@@ -490,6 +501,8 @@ static int rzv2h_icu_init(struct device_node *node, struct device_node *parent)
 		goto pm_put;
 	}
 
+	rzv2h_icu_data->info = hw_info;
+
 	/*
 	 * coccicheck complains about a missing put_device call before returning, but it's a false
 	 * positive. We still need &pdev->dev after successfully returning from this function.
@@ -502,6 +515,15 @@ pm_put:
 	return ret;
 }
 
+static const struct rzv2h_hw_info rzv2h_hw_params = {
+	.t_offs		= 0,
+};
+
+static int rzv2h_icu_init(struct device_node *node, struct device_node *parent)
+{
+	return rzv2h_icu_init_common(node, parent, &rzv2h_hw_params);
+}
+
 IRQCHIP_PLATFORM_DRIVER_BEGIN(rzv2h_icu)
 IRQCHIP_MATCH("renesas,r9a09g057-icu", rzv2h_icu_init)
 IRQCHIP_PLATFORM_DRIVER_END(rzv2h_icu)

