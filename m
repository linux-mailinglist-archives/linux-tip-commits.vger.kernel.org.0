Return-Path: <linux-tip-commits+bounces-6991-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 06194C07EE3
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Oct 2025 21:39:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 820D11AA3F91
	for <lists+linux-tip-commits@lfdr.de>; Fri, 24 Oct 2025 19:40:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E70A22BEFF2;
	Fri, 24 Oct 2025 19:39:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uRWlFtsL";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/xEq0etS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE7752C0269;
	Fri, 24 Oct 2025 19:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761334772; cv=none; b=JBJV10Yxhw2DjA1zO7dfHEqWmciVStWF90nd7epNDxUJs6geryS4guyhb6qkmFzteSNntLp5ifaFNPg5rOJTB2LN7wCDVOKTF+v+Jkvq7ldkyFmGiHGTyJePoccn5MFgFyAIV98uOh5ZOmRiF6N4C3YTWPBe6eEsWJYiqr1ut6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761334772; c=relaxed/simple;
	bh=xpsl5fvFNv4yaXLBYmxZEqC/pKw0Sv6ESjw9IqNHUjk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gDjsZLCO9BHiLm+QMGOXrsG+S0f90QfM2fmKTEiWBSQB8YBinIVvrRuptUCy6BSNQLn/pIVk7odQBV1784Q+V9J4Vkq4t78cnPFV2bslESyCZiV3tHK0dEjjG9cFneozr8EdRPHxnTthoSe2DuKNQpegdIacGTjxWHq3U0FO0II=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uRWlFtsL; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/xEq0etS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 24 Oct 2025 19:39:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761334769;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jwTyu5UjOLrxhvo9xHfeVdvrwZBfhHTqCj9H929P9Oo=;
	b=uRWlFtsLkALi+2wheqs8ij/l3GbNT0ofvBstbv1fxtVHltZH+teHhqAwZs64vuJa/tKry6
	x76qfJYtf6KMS6oZVDZeJVePe/UCv7lq73qOq/TWRcCT02AZvzDplL0jIrtfsR4epAOxgG
	d+DGM7tLdLuXxocVa7PRvk7ZCPydAiNJ8F7apidHn72evDdevvzjrLe0cl4uN4Bem7pJk1
	m4fBF5S/8bjGyJfdTJEaW1oBUGLLQbYxBNh3NXkanmkaZp8y4doHhu4+kZOjTxs5JB0Uhs
	avoJ3l5DfYnAnvat4LNA9sdMg1uGyE+TaYxytyCWDEIZeKkCYOSyQthlN+coGQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761334769;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jwTyu5UjOLrxhvo9xHfeVdvrwZBfhHTqCj9H929P9Oo=;
	b=/xEq0etSBP4KjONrNWA8EBz44c08ixn8zFK45C9kVy9fjg4+lxupKpXELwO5Hj8FSWfMP+
	5dsjCLPilJL1R3Ag==
From: "tip-bot2 for Charles Mirabile" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/drivers] irqchip/sifive-plic: Add support for UltraRISC DP1000 PLIC
Cc: Zhang Xincheng <zhangxincheng@ultrarisc.com>,
 Charles Mirabile <cmirabil@redhat.com>, Lucas Zampieri <lzampier@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>,
 Samuel Holland <samuel.holland@sifive.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251024083647.475239-5-lzampier@redhat.com>
References: <20251024083647.475239-5-lzampier@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176133476725.2601451.9526691626718728261.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     b5fa8915a50a44c01727ab5b60193188c88e4881
Gitweb:        https://git.kernel.org/tip/b5fa8915a50a44c01727ab5b60193188c88=
e4881
Author:        Charles Mirabile <cmirabil@redhat.com>
AuthorDate:    Fri, 24 Oct 2025 09:36:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 24 Oct 2025 21:34:32 +02:00

irqchip/sifive-plic: Add support for UltraRISC DP1000 PLIC

Add a new compatible for the plic found in UltraRISC DP1000 with a quirk to
work around a known hardware bug with IRQ claiming in the UR-CP100 cores.

When claiming an interrupt on UR-CP100 cores, all other interrupts must be
disabled before the claim register is accessed to prevent incorrect
handling of the interrupt. This is a hardware bug in the CP100 core
implementation, not specific to the DP1000 SoC.

When the PLIC_QUIRK_CP100_CLAIM_REGISTER_ERRATUM flag is present, a
specialized handler (plic_handle_irq_cp100) disables all interrupts except
for the first pending one before reading the claim register, and then
restores the interrupts before further processing of the claimed interrupt
continues.

This implementation leverages the enable_save optimization, which maintains
the current interrupt enable state in memory, avoiding additional register
reads during the workaround.

The driver matches on "ultrarisc,cp100-plic" to apply the quirk to all
SoCs using UR-CP100 cores, regardless of the specific SoC implementation.
This has no impact on other platforms.

[ tglx: Condensed the code a bit, massaged change log and comments ]

Co-developed-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
Signed-off-by: Zhang Xincheng <zhangxincheng@ultrarisc.com>
Signed-off-by: Charles Mirabile <cmirabil@redhat.com>
Signed-off-by: Lucas Zampieri <lzampier@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Samuel Holland <samuel.holland@sifive.com>
Link: https://patch.msgid.link/20251024083647.475239-5-lzampier@redhat.com
---
 drivers/irqchip/irq-sifive-plic.c | 104 ++++++++++++++++++++++++++++-
 1 file changed, 103 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-p=
lic.c
index d518a8b..99593d8 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -49,6 +49,8 @@
 #define CONTEXT_ENABLE_BASE		0x2000
 #define     CONTEXT_ENABLE_SIZE		0x80
=20
+#define PENDING_BASE			0x1000
+
 /*
  * Each hart context has a set of control registers associated with it.  Rig=
ht
  * now there's only two: a source priority threshold over which the hart will
@@ -63,6 +65,7 @@
 #define	PLIC_ENABLE_THRESHOLD		0
=20
 #define PLIC_QUIRK_EDGE_INTERRUPT	0
+#define PLIC_QUIRK_CP100_CLAIM_REGISTER_ERRATUM	1
=20
 struct plic_priv {
 	struct fwnode_handle *fwnode;
@@ -388,6 +391,98 @@ static void plic_handle_irq(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
=20
+static u32 cp100_isolate_pending_irq(int nr_irq_groups, struct plic_handler =
*handler)
+{
+	u32 __iomem *pending =3D handler->priv->regs + PENDING_BASE;
+	u32 __iomem *enable =3D handler->enable_base;
+	u32 pending_irqs =3D 0;
+	int i, j;
+
+	/* Look for first pending interrupt */
+	for (i =3D 0; i < nr_irq_groups; i++) {
+		/* Any pending interrupts would be annihilated, so skip checking them */
+		if (!handler->enabled_save[i])
+			continue;
+
+		pending_irqs =3D handler->enabled_save(i] & readl_relaxed(pending + i);
+		if (pending_irqs)
+			break;
+	}
+
+	if (!pending_irqs)
+		return 0;
+
+	/* Isolate lowest set bit*/
+	pending_irqs &=3D -pending_irqs;
+
+	/* Disable all interrupts but the first pending one */
+	for (j =3D 0; j < nr_irq_groups; j++) {
+		u32 new_mask =3D j =3D=3D i ? pending_irqs : 0;
+
+		if (new_mask !=3D handler->enabled_save[j])
+			writel_relaxed(new_mask, enable + j);
+	}
+	return pending_irqs;
+}
+
+static irq_hw_number_t cp100_get_hwirq(struct plic_handler *handler, void __=
iomem *claim)
+{
+	int nr_irq_groups =3D DIV_ROUND_UP(handler->priv->nr_irqs, 32);
+	u32 __iomem *enable =3D handler->enable_base;
+	irq_hw_number_t hwirq =3D 0;
+	u32 iso_mask;
+	int i;
+
+	guard(raw_spinlock)(&handler->enable_lock);
+
+	/* Existing enable state is already cached in enable_save */
+	iso_mask =3D cp100_isolate_pending_irq(nr_irq_groups, handler);
+	if (!iso_mask)
+		return 0;
+
+	/*
+	 * Interrupts delievered to hardware still become pending, but only
+	 * interrupts that are both pending and enabled can be claimed.
+	 * Clearing the enable bit for all interrupts but the first pending
+	 * one avoids a hardware bug that occurs during read from the claim
+	 * register with more than one eligible interrupt.
+	 */
+	hwirq =3D readl(claim);
+
+	/* Restore previous state */
+	for (i =3D 0; i < nr_irq_groups; i++) {
+		u32 written =3D i =3D=3D hwirq / 32 ? iso_mask : 0;
+		u32 stored =3D handler->enable_save[i];
+
+		if (stored !=3D written)
+			writel_relaxed(stored, enable + i);
+	}
+	return hwirq;
+}
+
+static void plic_handle_irq_cp100(struct irq_desc *desc)
+{
+	struct plic_handler *handler =3D this_cpu_ptr(&plic_handlers);
+	struct irq_chip *chip =3D irq_desc_get_chip(desc);
+	void __iomem *claim =3D handler->hart_base + CONTEXT_CLAIM;
+	irq_hw_number_t hwirq;
+
+	WARN_ON_ONCE(!handler->present);
+
+	chained_irq_enter(chip, desc);
+
+	while ((hwirq =3D cp100_get_hwirq(handler, claim))) {
+		int err =3D generic_handle_domain_irq(handler->priv->irqdomain, hwirq);
+
+		if (unlikely(err)) {
+			pr_warn_ratelimited("%pfwP: can't find mapping for hwirq %lu\n",
+					    handler->priv->fwnode, hwirq);
+		}
+	}
+
+	chained_irq_exit(chip, desc);
+}
+
 static void plic_set_threshold(struct plic_handler *handler, u32 threshold)
 {
 	/* priority must be > threshold to trigger an interrupt */
@@ -424,6 +519,8 @@ static const struct of_device_id plic_match[] =3D {
 	  .data =3D (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
 	{ .compatible =3D "thead,c900-plic",
 	  .data =3D (const void *)BIT(PLIC_QUIRK_EDGE_INTERRUPT) },
+	{ .compatible =3D "ultrarisc,cp100-plic",
+	  .data =3D (const void *)BIT(PLIC_QUIRK_CP100_CLAIM_REGISTER_ERRATUM) },
 	{}
 };
=20
@@ -658,12 +755,17 @@ done:
 		}
=20
 		if (global_setup) {
+			void (*handler_fn)(struct irq_desc *) =3D plic_handle_irq;
+
+			if (test_bit(PLIC_QUIRK_CP100_CLAIM_REGISTER_ERRATUM, &handler->priv->pli=
c_quirks))
+				handler_fn =3D plic_handle_irq_cp100;
+
 			/* Find parent domain and register chained handler */
 			domain =3D irq_find_matching_fwnode(riscv_get_intc_hwnode(), DOMAIN_BUS_A=
NY);
 			if (domain)
 				plic_parent_irq =3D irq_create_mapping(domain, RV_IRQ_EXT);
 			if (plic_parent_irq)
-				irq_set_chained_handler(plic_parent_irq, plic_handle_irq);
+				irq_set_chained_handler(plic_parent_irq, handler_fn);
=20
 			cpuhp_setup_state(CPUHP_AP_IRQ_SIFIVE_PLIC_STARTING,
 					  "irqchip/sifive/plic:starting",

