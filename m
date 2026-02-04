Return-Path: <linux-tip-commits+bounces-8199-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MuEHKMdg2nWhwMAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8199-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Feb 2026 11:21:23 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 265A1E4695
	for <lists+linux-tip-commits@lfdr.de>; Wed, 04 Feb 2026 11:21:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E3620302CD07
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 Feb 2026 10:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D24C33D7D8F;
	Wed,  4 Feb 2026 10:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t3+XO5SZ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="60bKUOx0"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A4693D6473;
	Wed,  4 Feb 2026 10:20:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770200450; cv=none; b=dz1zHj1JLHlR4CSzB674hh/X+VPhkGwpBBJfKcEHPuMGUJDt0kTNJTNQb/YgUAQmBQpawiaIn3vvXHHemCO7Fop8AvkFbk54nssKlIq9kGKyZ7RzkoyFrG9VPzoUmcLQeM1vzQ12Ou7Id5Zk8EKBmJe6S8BTnjXp4/cMtNP0qW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770200450; c=relaxed/simple;
	bh=jtgrAR02aow7/afUdDRwUi3iDc2G+LEC3AVzmNioLH0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=PMl47kB5DMIqiRVsFHeVOulGUvFhbqVQsJVGsgvneWbaapDwvDfsiORdsMSxOW/EZzYc4iy6RvrN62m0P75EXD5vaMv9TMvuqvLJazadPa5L1od7N18pjE0cGLQCTPnJ9Fo1D9tHfeUztUq0axVyt1yzTSUaJnzwcXhZEEJtDkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t3+XO5SZ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=60bKUOx0; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 04 Feb 2026 10:20:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1770200449;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SGY+z1wSSkq2X6AMB13HrrwqjAedT4ACxRQxAKCi/l4=;
	b=t3+XO5SZX70BP30/16muG24ubQVm7XxaYwcGec9MzwQfYxem89nRTI9ZqR6xlYCy3ToCxO
	07wMp0iWMAmVplAwKGXinutBG/eM+aQVKf5t7OsjJCD/1Cgvfs9R60D3lafpd8CbFqPh9u
	Md5ZMzTiyqkrfQakNTCGy9HxUob3XuZr7M1HNlI7emCy/4yhv4HOcPc1hPf0G7rzv8E9Pr
	bwkXNGQHB48IT6b9IJ8ab64fV1a35czsrFTJnS0Vyex2TcxICRY10ypmqMcY8lHsB1BowC
	TjZhvgJJym83TUOhP1UEYqA8SHhiGWx3CGt+cSqSE7FEV2A+KxVdEw4Iu0c++Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1770200449;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SGY+z1wSSkq2X6AMB13HrrwqjAedT4ACxRQxAKCi/l4=;
	b=60bKUOx0AMAhGbtGVZtjGnAuGASbCUCok2k3OH6N5KyVs+woLEWFKp4cVUkSlThqYMP3Zz
	sfNAEcRRTV8lmUAA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/sifive-plic: Handle number of hardware
 interrupts correctly
Cc: Yangyu Chen <cyy@cyyself.name>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <87ikcd36i9.ffs@tglx>
References: <87ikcd36i9.ffs@tglx>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <177020044787.2495410.8258388345002223081.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linutronix.de,none];
	MID_RHS_NOT_FQDN(0.50)[];
	R_DKIM_ALLOW(-0.20)[linutronix.de:s=2020,linutronix.de:s=2020e];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8199-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linutronix.de:dkim,vger.kernel.org:replyto,msgid.link:url,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,cyyself.name:email];
	REPLYTO_DOM_EQ_TO_DOM(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	REPLYTO_DOM_NEQ_FROM_DOM(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[tip-bot2@linutronix.de,linux-tip-commits@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[linutronix.de:+];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-tip-commits];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[linux-kernel@vger.kernel.org]
X-Rspamd-Queue-Id: 265A1E4695
X-Rspamd-Action: no action

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     42e025b719c128bdf8ff88584589a1e4a2448c81
Gitweb:        https://git.kernel.org/tip/42e025b719c128bdf8ff88584589a1e4a24=
48c81
Author:        Thomas Gleixner <tglx@kernel.org>
AuthorDate:    Tue, 03 Feb 2026 20:16:12 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Wed, 04 Feb 2026 11:12:18 +01:00

irqchip/sifive-plic: Handle number of hardware interrupts correctly

The driver is handling the number of hardware interrupts inconsistently.

The reason is that the firmware enumerates the maximum number of device
interrupts, but the actual number of hardware interrupts is one more
because hardware interrupt 0 is reserved.

There are two loop variants where this matters:

  1) Iterating over the device interrupts

     for (irq =3D 1; irq < total_irqs; irq++)

  2) Iterating over the number of interrupt register groups

     for (grp =3D 0; grp < irq_groups; grp++)

The current code stores the number of device interrupts and that requires
to write the loops as:

  1) for (irq =3D 1; irq <=3D device_irqs; irq++)

  2) for (grp =3D 0; grp < DIV_ROUND_UP(device_irqs + 1); grp++)

But the code gets it wrong all over the place. Just fixing up the
conditions and off by ones is not a sustainable solution as the next changes
will reintroduce the same bugs over and over.

Sanitize it by storing the total number of hardware interrupts during probe
and precalculating the number of groups. To future proof it mark
priv::total_irqs __private, provide a correct iterator macro and adjust the
code to this.

Marking it private allows sparse (C=3D1 build) to catch direct access to this
member:

  drivers/irqchip/irq-sifive-plic.c:270:9: warning: dereference of noderef ex=
pression

That should prevent at least the most obvious future damage in that area.

Fixes: e80f0b6a2cf3 ("irqchip/irq-sifive-plic: Add syscore callbacks for hibe=
rnation")
Reported-by: Yangyu Chen <cyy@cyyself.name>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Tested-by: Yangyu Chen <cyy@cyyself.name>
Link: https://patch.msgid.link/87ikcd36i9.ffs@tglx
---
 drivers/irqchip/irq-sifive-plic.c | 82 ++++++++++++++++--------------
 1 file changed, 45 insertions(+), 37 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-p=
lic.c
index 210a579..60fd8f9 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -68,15 +68,17 @@
 #define PLIC_QUIRK_CP100_CLAIM_REGISTER_ERRATUM	1
=20
 struct plic_priv {
-	struct fwnode_handle *fwnode;
-	struct cpumask lmask;
-	struct irq_domain *irqdomain;
-	void __iomem *regs;
-	unsigned long plic_quirks;
-	unsigned int nr_irqs;
-	unsigned long *prio_save;
-	u32 gsi_base;
-	int acpi_plic_id;
+	struct fwnode_handle	*fwnode;
+	struct cpumask		lmask;
+	struct irq_domain	*irqdomain;
+	void __iomem		*regs;
+	unsigned long		plic_quirks;
+	/* device interrupts + 1 to compensate for the reserved hwirq 0 */
+	unsigned int __private	total_irqs;
+	unsigned int		irq_groups;
+	unsigned long		*prio_save;
+	u32			gsi_base;
+	int			acpi_plic_id;
 };
=20
 struct plic_handler {
@@ -91,6 +93,12 @@ struct plic_handler {
 	u32			*enable_save;
 	struct plic_priv	*priv;
 };
+
+/*
+ * Macro to deal with the insanity of hardware interrupt 0 being reserved */
+#define for_each_device_irq(iter, priv)	\
+	for (unsigned int iter =3D 1; iter < ACCESS_PRIVATE(priv, total_irqs); iter=
++)
+
 static int plic_parent_irq __ro_after_init;
 static bool plic_global_setup_done __ro_after_init;
 static DEFINE_PER_CPU(struct plic_handler, plic_handlers);
@@ -257,14 +265,11 @@ static int plic_irq_set_type(struct irq_data *d, unsign=
ed int type)
=20
 static int plic_irq_suspend(void *data)
 {
-	struct plic_priv *priv;
-
-	priv =3D per_cpu_ptr(&plic_handlers, smp_processor_id())->priv;
+	struct plic_priv *priv =3D this_cpu_ptr(&plic_handlers)->priv;
=20
-	/* irq ID 0 is reserved */
-	for (unsigned int i =3D 1; i < priv->nr_irqs; i++) {
-		__assign_bit(i, priv->prio_save,
-			     readl(priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID));
+	for_each_device_irq(irq, priv) {
+		__assign_bit(irq, priv->prio_save,
+			     readl(priv->regs + PRIORITY_BASE + irq * PRIORITY_PER_ID));
 	}
=20
 	return 0;
@@ -272,18 +277,15 @@ static int plic_irq_suspend(void *data)
=20
 static void plic_irq_resume(void *data)
 {
-	unsigned int i, index, cpu;
+	struct plic_priv *priv =3D this_cpu_ptr(&plic_handlers)->priv;
+	unsigned int index, cpu;
 	unsigned long flags;
 	u32 __iomem *reg;
-	struct plic_priv *priv;
-
-	priv =3D per_cpu_ptr(&plic_handlers, smp_processor_id())->priv;
=20
-	/* irq ID 0 is reserved */
-	for (i =3D 1; i < priv->nr_irqs; i++) {
-		index =3D BIT_WORD(i);
-		writel((priv->prio_save[index] & BIT_MASK(i)) ? 1 : 0,
-		       priv->regs + PRIORITY_BASE + i * PRIORITY_PER_ID);
+	for_each_device_irq(irq, priv) {
+		index =3D BIT_WORD(irq);
+		writel((priv->prio_save[index] & BIT_MASK(irq)) ? 1 : 0,
+		       priv->regs + PRIORITY_BASE + irq * PRIORITY_PER_ID);
 	}
=20
 	for_each_present_cpu(cpu) {
@@ -293,7 +295,7 @@ static void plic_irq_resume(void *data)
 			continue;
=20
 		raw_spin_lock_irqsave(&handler->enable_lock, flags);
-		for (i =3D 0; i < DIV_ROUND_UP(priv->nr_irqs, 32); i++) {
+		for (unsigned int i =3D 0; i < priv->irq_groups; i++) {
 			reg =3D handler->enable_base + i * sizeof(u32);
 			writel(handler->enable_save[i], reg);
 		}
@@ -431,7 +433,7 @@ static u32 cp100_isolate_pending_irq(int nr_irq_groups, s=
truct plic_handler *han
=20
 static irq_hw_number_t cp100_get_hwirq(struct plic_handler *handler, void __=
iomem *claim)
 {
-	int nr_irq_groups =3D DIV_ROUND_UP(handler->priv->nr_irqs, 32);
+	int nr_irq_groups =3D handler->priv->irq_groups;
 	u32 __iomem *enable =3D handler->enable_base;
 	irq_hw_number_t hwirq =3D 0;
 	u32 iso_mask;
@@ -614,7 +616,6 @@ static int plic_probe(struct fwnode_handle *fwnode)
 	struct plic_handler *handler;
 	u32 nr_irqs, parent_hwirq;
 	struct plic_priv *priv;
-	irq_hw_number_t hwirq;
 	void __iomem *regs;
 	int id, context_id;
 	u32 gsi_base;
@@ -647,7 +648,16 @@ static int plic_probe(struct fwnode_handle *fwnode)
=20
 	priv->fwnode =3D fwnode;
 	priv->plic_quirks =3D plic_quirks;
-	priv->nr_irqs =3D nr_irqs;
+	/*
+	 * The firmware provides the number of device interrupts. As
+	 * hardware interrupt 0 is reserved, the number of total interrupts
+	 * is nr_irqs + 1.
+	 */
+	nr_irqs++;
+	ACCESS_PRIVATE(priv, total_irqs) =3D nr_irqs;
+	/* Precalculate the number of register groups */
+	priv->irq_groups =3D DIV_ROUND_UP(nr_irqs, 32);
+
 	priv->regs =3D regs;
 	priv->gsi_base =3D gsi_base;
 	priv->acpi_plic_id =3D id;
@@ -686,7 +696,7 @@ static int plic_probe(struct fwnode_handle *fwnode)
 				u32 __iomem *enable_base =3D priv->regs +	CONTEXT_ENABLE_BASE +
 							   i * CONTEXT_ENABLE_SIZE;
=20
-				for (int j =3D 0; j <=3D nr_irqs / 32; j++)
+				for (int j =3D 0; j < priv->irq_groups; j++)
 					writel(0, enable_base + j);
 			}
 			continue;
@@ -718,23 +728,21 @@ static int plic_probe(struct fwnode_handle *fwnode)
 			context_id * CONTEXT_ENABLE_SIZE;
 		handler->priv =3D priv;
=20
-		handler->enable_save =3D kcalloc(DIV_ROUND_UP(nr_irqs, 32),
-					       sizeof(*handler->enable_save), GFP_KERNEL);
+		handler->enable_save =3D kcalloc(priv->irq_groups, sizeof(*handler->enable=
_save),
+					       GFP_KERNEL);
 		if (!handler->enable_save) {
 			error =3D -ENOMEM;
 			goto fail_cleanup_contexts;
 		}
 done:
-		for (hwirq =3D 1; hwirq <=3D nr_irqs; hwirq++) {
+		for_each_device_irq(hwirq, priv) {
 			plic_toggle(handler, hwirq, 0);
-			writel(1, priv->regs + PRIORITY_BASE +
-				  hwirq * PRIORITY_PER_ID);
+			writel(1, priv->regs + PRIORITY_BASE + hwirq * PRIORITY_PER_ID);
 		}
 		nr_handlers++;
 	}
=20
-	priv->irqdomain =3D irq_domain_create_linear(fwnode, nr_irqs + 1,
-						   &plic_irqdomain_ops, priv);
+	priv->irqdomain =3D irq_domain_create_linear(fwnode, nr_irqs, &plic_irqdoma=
in_ops, priv);
 	if (WARN_ON(!priv->irqdomain)) {
 		error =3D -ENOMEM;
 		goto fail_cleanup_contexts;

