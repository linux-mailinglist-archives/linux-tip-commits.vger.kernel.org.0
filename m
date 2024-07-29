Return-Path: <linux-tip-commits+bounces-1780-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A88B93F1BD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 11:52:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4498F283BE1
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 09:52:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6458E146A89;
	Mon, 29 Jul 2024 09:49:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PGP1cen2";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="v8uua7t1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82761145A00;
	Mon, 29 Jul 2024 09:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722246593; cv=none; b=KQkg6i3cmAL41T3Yc6vEO8mSi/OW6z0k5KUprv+Pzr97OdrMYSKOOfTxonrkjR3DHE0TUfjX+bJ7XAHrucL/xH1z3Xt1lK0A1fC4ZXxKnTzBv3zCDXPVXVBB/RZoh/v+PUp2RTkcNbf+mYgcKrFNZZdFdfOkIj43p0mqPG4FwfQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722246593; c=relaxed/simple;
	bh=8N9u9+joIVuoU1zoWlroPV5t5LAMG7a91C8peolP/aU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rrfDDvRaXh3CqHHfOZ7g5sUpT1gX23A4kBqIcgGh5gAPYvksfwmB0SSsORcwedEaUvdoPqf6tZ3sr5qHsrGAiaVzWw3FGcveTSTaaYTedyv3Jpwo24GB2cUmdkd9Vg/mxqFSERGKrl9oj2mdOj6Vzt1fjB8sBEiqZ5vecAPhG7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PGP1cen2; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=v8uua7t1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 09:49:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722246587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uDbKhuygMY3pKYh+8yNLe/xbAaZQlYGRt5l9/82HhfQ=;
	b=PGP1cen2p/jyjZCEIQABV+SFQhHViYry50rqWMpM/aaj1KsFh1TUN5g1pA7b16W/KwxIbr
	WKOQsbPJU1xVvyyR8JHUVb2OI9ELhNGgL5ZjwurborBXVy4mGzckg0zNzYfX8CykPBk0ww
	d5s9CJp1PsIpKwCTv2AmbpYfzyLphbL+BfhIpYlWqTIxH427bpdODzr1rZ44xHFQD42Rj7
	sz8jgOs2psEYLpLnDvY8gB247K+kU23Dcj2S94GoYoKtc+uMwRQ0BlPFcl+oWnFl2Rkj37
	uQWiXJoTzQdMw88bYHPtbw+lmsG8ac02i96x1TMDFL3EyN7qh+y8MGepQ2wY+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722246587;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uDbKhuygMY3pKYh+8yNLe/xbAaZQlYGRt5l9/82HhfQ=;
	b=v8uua7t1Whm6mvv9HNN+HUjLlS9pz7Cbj2dcjyYaABClU3IXD8K/Yarqlfd0hnxud2sVbz
	pbn/XMT4IqyZbaDQ==
From: tip-bot2 for Marek =?utf-8?q?Beh=C3=BAn?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/armada-370-xp: Change register constant
 suffix from _MSK to _MASK
Cc: kabel@kernel.org, Thomas Gleixner <tglx@linutronix.de>,
 Andrew Lunn <andrew@lunn.ch>, ilpo.jarvinen@linux.intel.com, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240708151801.11592-3-kabel@kernel.org>
References: <20240708151801.11592-3-kabel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224658754.2215.14635140072686491770.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     fff29b2c21e9a4e64527ad598445512459dcf74f
Gitweb:        https://git.kernel.org/tip/fff29b2c21e9a4e64527ad598445512459d=
cf74f
Author:        Marek Beh=C3=BAn <kabel@kernel.org>
AuthorDate:    Mon, 08 Jul 2024 17:17:53 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 29 Jul 2024 10:57:21 +02:00

irqchip/armada-370-xp: Change register constant suffix from _MSK to _MASK

There is one occurrence of suffix _MSK in register constants, others
have _MASK instead. Change the one to _MASK for consistency.

Signed-off-by: Marek Beh=C3=BAn <kabel@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andrew Lunn <andrew@lunn.ch>
Reviewed-by: Ilpo J=C3=A4rvinen <ilpo.jarvinen@linux.intel.com>
Link: https://lore.kernel.org/all/20240708151801.11592-3-kabel@kernel.org

---
 drivers/irqchip/irq-armada-370-xp.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/irqchip/irq-armada-370-xp.c b/drivers/irqchip/irq-armada=
-370-xp.c
index 66d6a2e..588a9e2 100644
--- a/drivers/irqchip/irq-armada-370-xp.c
+++ b/drivers/irqchip/irq-armada-370-xp.c
@@ -126,7 +126,7 @@
=20
 /* Registers relative to per_cpu_int_base */
 #define ARMADA_370_XP_IN_DRBEL_CAUSE		(0x08)
-#define ARMADA_370_XP_IN_DRBEL_MSK		(0x0c)
+#define ARMADA_370_XP_IN_DRBEL_MASK		(0x0c)
 #define ARMADA_375_PPI_CAUSE			(0x10)
 #define ARMADA_370_XP_CPU_INTACK		(0x44)
 #define ARMADA_370_XP_INT_SET_MASK		(0x48)
@@ -324,9 +324,9 @@ static void armada_370_xp_msi_reenable_percpu(void)
 	u32 reg;
=20
 	/* Enable MSI doorbell mask and combined cpu local interrupt */
-	reg =3D readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK);
+	reg =3D readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MASK);
 	reg |=3D msi_doorbell_mask();
-	writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK);
+	writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MASK);
=20
 	/* Unmask local doorbell interrupt */
 	writel(1, per_cpu_int_base + ARMADA_370_XP_INT_CLEAR_MASK);
@@ -394,17 +394,17 @@ static struct irq_domain *ipi_domain;
 static void armada_370_xp_ipi_mask(struct irq_data *d)
 {
 	u32 reg;
-	reg =3D readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK);
+	reg =3D readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MASK);
 	reg &=3D ~BIT(d->hwirq);
-	writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK);
+	writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MASK);
 }
=20
 static void armada_370_xp_ipi_unmask(struct irq_data *d)
 {
 	u32 reg;
-	reg =3D readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK);
+	reg =3D readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MASK);
 	reg |=3D BIT(d->hwirq);
-	writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK);
+	writel(reg, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MASK);
 }
=20
 static void armada_370_xp_ipi_send_mask(struct irq_data *d,
@@ -539,7 +539,7 @@ static void armada_xp_mpic_smp_cpu_init(void)
 		return;
=20
 	/* Disable all IPIs */
-	writel(0, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK);
+	writel(0, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MASK);
=20
 	/* Clear pending IPIs */
 	writel(0, per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_CAUSE);
@@ -740,7 +740,7 @@ armada_370_xp_handle_irq(struct pt_regs *regs)
=20
 static int armada_370_xp_mpic_suspend(void)
 {
-	doorbell_mask_reg =3D readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK);
+	doorbell_mask_reg =3D readl(per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MASK);
 	return 0;
 }
=20
@@ -785,7 +785,7 @@ static void armada_370_xp_mpic_resume(void)
=20
 	/* Reconfigure doorbells for IPIs and MSIs */
 	writel(doorbell_mask_reg,
-	       per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MSK);
+	       per_cpu_int_base + ARMADA_370_XP_IN_DRBEL_MASK);
=20
 	if (is_ipi_available()) {
 		src0 =3D doorbell_mask_reg & IPI_DOORBELL_MASK;

