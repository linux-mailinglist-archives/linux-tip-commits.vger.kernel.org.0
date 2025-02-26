Return-Path: <linux-tip-commits+bounces-3647-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07080A45C79
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 12:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8CAFD188CB9D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 11:04:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 620C21A3031;
	Wed, 26 Feb 2025 11:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iezxjLgY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Pfnq21UI"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E1DD5383;
	Wed, 26 Feb 2025 11:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567841; cv=none; b=iiK5OaV2SKCZ2YJgdQD9I5SoKL7iacm2SJogKS48br+irNsKW3YOEzg+z5TuD6138stQ2jXqjJ830a3E8wuUGeD0w0INCf9XMMnGnxUBSCsV+PzLXKSAny7jCy0JSxhwUXbHHAEzeG8/Cmvn3ioD/ggLEWZ4wZHejLii7rBgFw0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567841; c=relaxed/simple;
	bh=rvRsrZj7laRqFAqLwBuOqMlc7cOO4+DEFKBthBoCL5o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lFV4YKIyFdXt6A83wmK52kpcFCGYHqlAi8nCqqgusTj1c6iQvSBpnq4f2rJvVjp3q9nvX4qhG0lcvKoH+BKP2+4hoF+AAGx4gXuuGJQVWT/xmWpOkMj22LjX56PlRk6UF5RgpLk5EAitzRCXH/fECxxJxhc5ywpWSNHE9qG6hHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iezxjLgY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Pfnq21UI; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 11:03:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740567837;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JL0cB1sz9gM0thjZB1H3yfZdzF1mkrDveHImVWikt1k=;
	b=iezxjLgYuAlUo/EcGU2LbGxGxUYfmes1bd8YANurKAwhNNBouwneI+tqStSzcTH4B1w6+c
	njGvM0jtdMZvGv0Sv/o4QbkvRZIDXB4yHbjaUuGP3MZb/aTmPX4QdO5VxPC/TUYzmttp8Y
	qVwrkuzdvgFM5qdrA8tQD4tdyc1mcJBKAP9ty5L8JG1rMd5hYJ35SrkmMZdequD7HeyVpK
	qZZOVN6Gkqp3cC/Asr2+M0Q2CUH++mZh78TIIka0M35GlYBYFoD9FvpgekqlOY5fhsRsS1
	2+rCIZPLRHf0GWzctXOZBB+IkU5+MQ08ERk2fJdnX71yttYB/x+1WJRN+oFgPw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740567837;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JL0cB1sz9gM0thjZB1H3yfZdzF1mkrDveHImVWikt1k=;
	b=Pfnq21UIc1PRAiacNrsaZLYJuvCU1Pn/xu5ApUFtJPw9q4eSSNH2+vLjA7K9RZSHEAeElw
	YXnrAs+FC7Sn6FCw==
From: "tip-bot2 for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/renesas-rzv2h: Add RZ/G3E support
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250224131253.134199-13-biju.das.jz@bp.renesas.com>
References: <20250224131253.134199-13-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174056783628.10177.10278333097688054280.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     399b2799985237cf5c3656b7cfc87cdaa489efd1
Gitweb:        https://git.kernel.org/tip/399b2799985237cf5c3656b7cfc87cdaa489efd1
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Mon, 24 Feb 2025 13:11:28 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 26 Feb 2025 11:59:50 +01:00

irqchip/renesas-rzv2h: Add RZ/G3E support

The ICU block on the RZ/G3E SoC is almost identical to the one found on
the RZ/V2H SoC, with the following differences:

 - The TINT register base offset is 0x800 instead of zero.
 - The number of GPIO interrupts for TINT selection is 141 instead of 86.
 - The pin index and TINT selection index are not in the 1:1 map.
 - The number of TSSR registers is 16 instead of 8.
 - Each TSSR register can program 2 TINTs instead of 4 TINTs.

Add support for the RZ/G3E driver by filling the rzv2h_hw_info table and
adding LUT for mapping between pin index and TINT selection index.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/all/20250224131253.134199-13-biju.das.jz@bp.renesas.com
---
 drivers/irqchip/irq-renesas-rzv2h.c | 46 ++++++++++++++++++++++++++++-
 1 file changed, 46 insertions(+)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index 7bc4397..3d5b5fd 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -85,15 +85,19 @@
 
 #define ICU_TINT_EXTRACT_HWIRQ(x)		FIELD_GET(GENMASK(15, 0), (x))
 #define ICU_TINT_EXTRACT_GPIOINT(x)		FIELD_GET(GENMASK(31, 16), (x))
+#define ICU_RZG3E_TINT_OFFSET			0x800
+#define ICU_RZG3E_TSSEL_MAX_VAL			0x8c
 #define ICU_RZV2H_TSSEL_MAX_VAL			0x55
 
 /**
  * struct rzv2h_hw_info - Interrupt Control Unit controller hardware info structure.
+ * @tssel_lut:		TINT lookup table
  * @t_offs:		TINT offset
  * @max_tssel:		TSSEL max value
  * @field_width:	TSSR field width
  */
 struct rzv2h_hw_info {
+	const u8	*tssel_lut;
 	u16		t_offs;
 	u8		max_tssel;
 	u8		field_width;
@@ -317,6 +321,9 @@ static int rzv2h_tint_set_type(struct irq_data *d, unsigned int type)
 	if (tint > priv->info->max_tssel)
 		return -EINVAL;
 
+	if (priv->info->tssel_lut)
+		tint = priv->info->tssel_lut[tint];
+
 	hwirq = irqd_to_hwirq(d);
 	tint_nr = hwirq - ICU_TINT_START;
 
@@ -529,18 +536,57 @@ pm_put:
 	return ret;
 }
 
+/* Mapping based on port index on Table 4.2-6 and TSSEL bits on Table 4.6-4 */
+static const u8 rzg3e_tssel_lut[] = {
+	81, 82, 83, 84, 85, 86, 87, 88,		/* P00-P07 */
+	89, 90, 91, 92, 93, 94, 95, 96,		/* P10-P17 */
+	111, 112,				/* P20-P21 */
+	97, 98, 99, 100, 101, 102, 103, 104,	/* P30-P37 */
+	105, 106, 107, 108, 109, 110,		/* P40-P45 */
+	113, 114, 115, 116, 117, 118, 119,	/* P50-P56 */
+	120, 121, 122, 123, 124, 125, 126,	/* P60-P66 */
+	127, 128, 129, 130, 131, 132, 133, 134,	/* P70-P77 */
+	135, 136, 137, 138, 139, 140,		/* P80-P85 */
+	43, 44, 45, 46, 47, 48, 49, 50,		/* PA0-PA7 */
+	51, 52, 53, 54, 55, 56, 57, 58,		/* PB0-PB7 */
+	59, 60,	61,				/* PC0-PC2 */
+	62, 63, 64, 65, 66, 67, 68, 69,		/* PD0-PD7 */
+	70, 71, 72, 73, 74, 75, 76, 77,		/* PE0-PE7 */
+	78, 79, 80,				/* PF0-PF2 */
+	25, 26, 27, 28, 29, 30, 31, 32,		/* PG0-PG7 */
+	33, 34, 35, 36, 37, 38,			/* PH0-PH5 */
+	4, 5, 6, 7, 8,				/* PJ0-PJ4 */
+	39, 40, 41, 42,				/* PK0-PK3 */
+	9, 10, 11, 12, 21, 22, 23, 24,		/* PL0-PL7 */
+	13, 14, 15, 16, 17, 18, 19, 20,		/* PM0-PM7 */
+	0, 1, 2, 3				/* PS0-PS3 */
+};
+
+static const struct rzv2h_hw_info rzg3e_hw_params = {
+	.tssel_lut	= rzg3e_tssel_lut,
+	.t_offs		= ICU_RZG3E_TINT_OFFSET,
+	.max_tssel	= ICU_RZG3E_TSSEL_MAX_VAL,
+	.field_width	= 16,
+};
+
 static const struct rzv2h_hw_info rzv2h_hw_params = {
 	.t_offs		= 0,
 	.max_tssel	= ICU_RZV2H_TSSEL_MAX_VAL,
 	.field_width	= 8,
 };
 
+static int rzg3e_icu_init(struct device_node *node, struct device_node *parent)
+{
+	return rzv2h_icu_init_common(node, parent, &rzg3e_hw_params);
+}
+
 static int rzv2h_icu_init(struct device_node *node, struct device_node *parent)
 {
 	return rzv2h_icu_init_common(node, parent, &rzv2h_hw_params);
 }
 
 IRQCHIP_PLATFORM_DRIVER_BEGIN(rzv2h_icu)
+IRQCHIP_MATCH("renesas,r9a09g047-icu", rzg3e_icu_init)
 IRQCHIP_MATCH("renesas,r9a09g057-icu", rzv2h_icu_init)
 IRQCHIP_PLATFORM_DRIVER_END(rzv2h_icu)
 MODULE_AUTHOR("Fabrizio Castro <fabrizio.castro.jz@renesas.com>");

