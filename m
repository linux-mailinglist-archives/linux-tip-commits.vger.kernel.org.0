Return-Path: <linux-tip-commits+bounces-8047-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B42BD393BA
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 11:03:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 84CF7300462C
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 10:03:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03176284890;
	Sun, 18 Jan 2026 10:03:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wNCD/+G3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h8MsR/jC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6EE200113;
	Sun, 18 Jan 2026 10:03:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768730581; cv=none; b=sjS9cFerlipafdRycJ8r073Fyh9/j8H898Ek8tytPEEP0AuNwFGye3fNGhwjqnULnLMRto8ub4jQ+A+AJg7HDA7SxqEqH8MymzYirMTki6ucp7lujPRu7kcsekk2hsmVoVIgd+EzhZYieJe7f8eCRMHsbJPIXth3Lz+6giGiJrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768730581; c=relaxed/simple;
	bh=wXzynKtOgA7FC19tQOXairBCR3gK5kzKhtsuOHMhyns=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=NA2ZGQnaXiGYejjiYurtS9ULzGbk+5gn5uZfJFs3aEqbNJIXIeuSscqQCaH4KEPJuzOU9SKrY8OMfmtoPxoK8Jsy6klw124HxEH0tyX18QetBbaCPLwV5Sr1bzsDNnHSKfokLcMsRLAh1x7FRhBN6Y4Doxz8KnyZaFLMPJvDL4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wNCD/+G3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=h8MsR/jC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Jan 2026 10:02:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768730577;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fACBKBSLJjchadIM8I+xsvwiuu/HnPk2cn69ZrohCZ4=;
	b=wNCD/+G37D1ZE61o+4x3R8oLxylQbJbaJLF8zpPaRl6TTT+LtDUffaNixZpndS6AmEP/gz
	JevkDDjHwEB7EhzS6HIMOT+WvhfBrDabr9h3z3AhoxWTrUrZnGV3unqdWcY92VZQVtipj5
	ynQkxrBrfFqKCGZHAwj6NVjvdc/Jn671oorV0Oql3sGiTZ/GrVXGmHAIYTEC9tW2h012ks
	JgJsAlmFNRFz6N2StB9aTV4vyTq5QZrhvy++LsyrkYSoWBZ4L4Y8rqhUN4DnjunIEW/sld
	70pEKzFaVtaJfXfjxFwcjcBu1Cb1o3X/Jr7SyyiASBgd6ZKkj1x5nC0XjZM/rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768730577;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fACBKBSLJjchadIM8I+xsvwiuu/HnPk2cn69ZrohCZ4=;
	b=h8MsR/jCYv4Lg4IrmwuCpiltW7e636jVhXpLdE4IdzWNbLwX7K/7UutN7ceWvBzqIq9Ovi
	/4zfuIFqbodjdnCQ==
From: "tip-bot2 for Biju Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/renesas-rzv2h: Add suspend/resume support
Cc: Biju Das <biju.das.jz@bp.renesas.com>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260113125315.359967-3-biju.das.jz@bp.renesas.com>
References: <20260113125315.359967-3-biju.das.jz@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176873057590.510.936652578580136768.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     fba6ab8010bb3e77f7a590deae9ab23b49cb051d
Gitweb:        https://git.kernel.org/tip/fba6ab8010bb3e77f7a590deae9ab23b49c=
b051d
Author:        Biju Das <biju.das.jz@bp.renesas.com>
AuthorDate:    Tue, 13 Jan 2026 12:53:12=20
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 18 Jan 2026 11:00:29 +01:00

irqchip/renesas-rzv2h: Add suspend/resume support

On RZ/G3E using PSCI, s2ram powers down the SoC. Add suspend/resume
callbacks to restore IRQ type for NMI, TINT and external IRQ interrupts.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260113125315.359967-3-biju.das.jz@bp.renesas=
.com
---
 drivers/irqchip/irq-renesas-rzv2h.c | 60 ++++++++++++++++++++++++++--
 1 file changed, 57 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-rzv2h.c b/drivers/irqchip/irq-renesa=
s-rzv2h.c
index 0c44b61..69980a8 100644
--- a/drivers/irqchip/irq-renesas-rzv2h.c
+++ b/drivers/irqchip/irq-renesas-rzv2h.c
@@ -20,6 +20,7 @@
 #include <linux/pm_runtime.h>
 #include <linux/reset.h>
 #include <linux/spinlock.h>
+#include <linux/syscore_ops.h>
=20
 /* DT "interrupts" indexes */
 #define ICU_IRQ_START				1
@@ -90,6 +91,18 @@
 #define ICU_RZV2H_TSSEL_MAX_VAL			0x55
=20
 /**
+ * struct rzv2h_irqc_reg_cache - registers cache (necessary for suspend/resu=
me)
+ * @nitsr: ICU_NITSR register
+ * @iitsr: ICU_IITSR register
+ * @titsr: ICU_TITSR registers
+ */
+struct rzv2h_irqc_reg_cache {
+	u32	nitsr;
+	u32	iitsr;
+	u32	titsr[2];
+};
+
+/**
  * struct rzv2h_hw_info - Interrupt Control Unit controller hardware info st=
ructure.
  * @tssel_lut:		TINT lookup table
  * @t_offs:		TINT offset
@@ -118,13 +131,15 @@ struct rzv2h_hw_info {
  * @fwspec:	IRQ firmware specific data
  * @lock:	Lock to serialize access to hardware registers
  * @info:	Pointer to struct rzv2h_hw_info
+ * @cache:	Registers cache for suspend/resume
  */
-struct rzv2h_icu_priv {
+static struct rzv2h_icu_priv {
 	void __iomem			*base;
 	struct irq_fwspec		fwspec[ICU_NUM_IRQ];
 	raw_spinlock_t			lock;
 	const struct rzv2h_hw_info	*info;
-};
+	struct rzv2h_irqc_reg_cache	cache;
+} *rzv2h_icu_data;
=20
 void rzv2h_icu_register_dma_req(struct platform_device *icu_dev, u8 dmac_ind=
ex, u8 dmac_channel,
 				u16 req_no)
@@ -412,6 +427,44 @@ static int rzv2h_icu_set_type(struct irq_data *d, unsign=
ed int type)
 	return irq_chip_set_type_parent(d, IRQ_TYPE_LEVEL_HIGH);
 }
=20
+static int rzv2h_irqc_irq_suspend(void *data)
+{
+	struct rzv2h_irqc_reg_cache *cache =3D &rzv2h_icu_data->cache;
+	void __iomem *base =3D rzv2h_icu_data->base;
+
+	cache->nitsr =3D readl_relaxed(base + ICU_NITSR);
+	cache->iitsr =3D readl_relaxed(base + ICU_IITSR);
+	for (unsigned int i =3D 0; i < 2; i++)
+		cache->titsr[i] =3D readl_relaxed(base + rzv2h_icu_data->info->t_offs + IC=
U_TITSR(i));
+
+	return 0;
+}
+
+static void rzv2h_irqc_irq_resume(void *data)
+{
+	struct rzv2h_irqc_reg_cache *cache =3D &rzv2h_icu_data->cache;
+	void __iomem *base =3D rzv2h_icu_data->base;
+
+	/*
+	 * Restore only interrupt type. TSSRx will be restored at the
+	 * request of pin controller to avoid spurious interrupts due
+	 * to invalid PIN states.
+	 */
+	for (unsigned int i =3D 0; i < 2; i++)
+		writel_relaxed(cache->titsr[i], base + rzv2h_icu_data->info->t_offs + ICU_=
TITSR(i));
+	writel_relaxed(cache->iitsr, base + ICU_IITSR);
+	writel_relaxed(cache->nitsr, base + ICU_NITSR);
+}
+
+static const struct syscore_ops rzv2h_irqc_syscore_ops =3D {
+	.suspend	=3D rzv2h_irqc_irq_suspend,
+	.resume		=3D rzv2h_irqc_irq_resume,
+};
+
+static struct syscore rzv2h_irqc_syscore =3D {
+	.ops =3D &rzv2h_irqc_syscore_ops,
+};
+
 static const struct irq_chip rzv2h_icu_chip =3D {
 	.name			=3D "rzv2h-icu",
 	.irq_eoi		=3D rzv2h_icu_eoi,
@@ -495,7 +548,6 @@ static int rzv2h_icu_probe_common(struct platform_device =
*pdev, struct device_no
 {
 	struct irq_domain *irq_domain, *parent_domain;
 	struct device_node *node =3D pdev->dev.of_node;
-	struct rzv2h_icu_priv *rzv2h_icu_data;
 	struct reset_control *resetn;
 	int ret;
=20
@@ -553,6 +605,8 @@ static int rzv2h_icu_probe_common(struct platform_device =
*pdev, struct device_no
=20
 	rzv2h_icu_data->info =3D hw_info;
=20
+	register_syscore(&rzv2h_irqc_syscore);
+
 	/*
 	 * coccicheck complains about a missing put_device call before returning, b=
ut it's a false
 	 * positive. We still need &pdev->dev after successfully returning from thi=
s function.

