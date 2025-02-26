Return-Path: <linux-tip-commits+bounces-3650-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B37A45C7F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 12:04:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C36E1188D8A8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 26 Feb 2025 11:04:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2749213E77;
	Wed, 26 Feb 2025 11:04:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mYR/J9Kl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UG/N5yGE"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AD118CC10;
	Wed, 26 Feb 2025 11:04:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740567842; cv=none; b=p0M3N6PT9rzQjhiJ6H87U8xXueja/h8KzQHSDD5JhaYpF7ms25MVZE31P3rRMcH7cJcJ0IDtF1bmnX6jjo1Q1dQV2eNoCpEbB269q4OVrkrksil7uoOcDfFmdiiXmYd48ukx5NoVvSkUut1YD8fDBbgwuaPQFOwDS8qpdGu70LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740567842; c=relaxed/simple;
	bh=+l9zLHAz1K4aU7r3YkmGYUxOBt+Kgvz2adPhFd1fbxs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kRD9lhct9p/ctCUPdUp4/fh0tRKD2zslyg7EV1Rzpyo1kvvscbRUgDHmfntd8Ar0hE1tEwQhchHiNyYwtfMvBzose6InIGvqH+yO7awDEprwapHhunqypYCjxCAM/a7pCKLL4uT3H6aUSB0NSDi8XyzE8EFYBRnFQiTntuvLLdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mYR/J9Kl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UG/N5yGE; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 26 Feb 2025 11:03:59 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740567839;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r9WjhKxj2GDFtCC99wWbPKeI6sVIyZCwX+Je+WraXto=;
	b=mYR/J9Klxia9/3kcihBrpneHHkKg8m4A5dkuW5t4ditI8bTbYnJtA0xu1o5WpRFE75HfQF
	XLGEfvSoNnDhvDNDb8MEYue/3ooqfznZRXlsvv4X0szPOplGiP+jWrmWYvRzyizX/SPJLd
	INNOnSwOkuI78cbstrkf25evLYO8XCyLjjV/xBo7isdgAysnnTBXgN9sZkVS7+ZMLt0iAH
	17v5BSWW+YCkjc4CIouxrU8DHCG/wsSElrmr/y3GnWn4g5jqbrfnC3sNYYhaKbY6xWtfB3
	JyNItpQsYfG1E/0uzVFL6T+aLMJiU/Yh4b8LDTPgxAsD5LoiRBPfcX3TIFvEHQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740567839;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r9WjhKxj2GDFtCC99wWbPKeI6sVIyZCwX+Je+WraXto=;
	b=UG/N5yGEUa41OT8i7XzMYVP3NMX904xVrQzR8uE1aHxvoYQGH1iugxqmNamh6jUXDAawjO
	k7C0DYqvUmnoSbDg==
From: "tip-bot2 for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/renesas-rzv2h: Add max_tssel to struct
 rzv2h_hw_info
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 Geert Uytterhoeven <geert+renesas@glider.be>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250224131253.134199-9-biju.das.jz@bp.renesas.com>
References: <20250224131253.134199-9-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174056783904.10177.12923814398050084958.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     eb23d23d082d097e2a8154a57da72061cb7e33b3
Gitweb:        https://git.kernel.org/tip/eb23d23d082d097e2a8154a57da72061cb7e33b3
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Mon, 24 Feb 2025 13:11:24 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 26 Feb 2025 11:59:50 +01:00

irqchip/renesas-rzv2h: Add max_tssel to struct rzv2h_hw_info

The number of GPIO interrupts on RZ/G3E for TINT selection is 141 compared
to 86 on RZ/V2H. Rename the macro ICU_PB5_TINT->ICU_RZV2H_TSSEL_MAX_VAL to
hold this difference for RZ/V2H.

Add max_tssel to struct rzv2h_hw_info and replace the hardcoded constants
in the code.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Fabrizio Castro <fabrizio.castro.jz@renesas.com>
Reviewed-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Link: https://lore.kernel.org/all/20250224131253.134199-9-biju.das.jz@bp.renesas.com

---
 drivers/irqchip/irq-renesas-rzv2h.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesas-rzv2h.c
index 43b805b..2fae327 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -78,14 +78,16 @@
 
 #define ICU_TINT_EXTRACT_HWIRQ(x)		FIELD_GET(GENMASK(15, 0), (x))
 #define ICU_TINT_EXTRACT_GPIOINT(x)		FIELD_GET(GENMASK(31, 16), (x))
-#define ICU_PB5_TINT				0x55
+#define ICU_RZV2H_TSSEL_MAX_VAL			0x55
 
 /**
  * struct rzv2h_hw_info - Interrupt Control Unit controller hardware info structure.
  * @t_offs:		TINT offset
+ * @max_tssel:		TSSEL max value
  */
 struct rzv2h_hw_info {
 	u16		t_offs;
+	u8		max_tssel;
 };
 
 /**
@@ -298,13 +300,12 @@ static int rzv2h_tint_set_type(struct irq_data *d, unsigned int type)
 		return -EINVAL;
 	}
 
+	priv = irq_data_to_priv(d);
 	tint = (u32)(uintptr_t)irq_data_get_irq_chip_data(d);
-	if (tint > ICU_PB5_TINT)
+	if (tint > priv->info->max_tssel)
 		return -EINVAL;
 
-	priv = irq_data_to_priv(d);
 	hwirq = irqd_to_hwirq(d);
-
 	tint_nr = hwirq - ICU_TINT_START;
 
 	tssr_k = ICU_TSSR_K(tint_nr);
@@ -517,6 +518,7 @@ pm_put:
 
 static const struct rzv2h_hw_info rzv2h_hw_params = {
 	.t_offs		= 0,
+	.max_tssel	= ICU_RZV2H_TSSEL_MAX_VAL,
 };
 
 static int rzv2h_icu_init(struct device_node *node, struct device_node *parent)

