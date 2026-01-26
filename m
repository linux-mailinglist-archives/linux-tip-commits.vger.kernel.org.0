Return-Path: <linux-tip-commits+bounces-8116-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id qKP6Ez+Ld2m9hgEAu9opvQ
	(envelope-from <linux-tip-commits+bounces-8116-lists+linux-tip-commits=lfdr.de@vger.kernel.org>)
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Jan 2026 16:41:51 +0100
X-Original-To: lists+linux-tip-commits@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0190C8A429
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Jan 2026 16:41:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 77EAB3019CA6
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Jan 2026 15:41:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9019033FE2F;
	Mon, 26 Jan 2026 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YX7jnWJQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="6XOvq/Mi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0912838DF9;
	Mon, 26 Jan 2026 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769442078; cv=none; b=k1efSK6ltJPqLToKmHlX5vawC9UYHvNs+lcIATkDh3nasDiRkebovdffZcxen4pw41uWeNusMPmdUuP+j5G9fN608RWwr/WajJnKI3UNVxHAD9Y3i72ACiJL2+b5uNJkWYzQJdAzi0twSuYRIThKbNMC3yRE1wgrdBzkVznN/hU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769442078; c=relaxed/simple;
	bh=w5cozCyd8EjSbrzLMpUYxCsslKHFQpCn7ldwuTjGObA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=hXQVLITPjPROw0oai2Xrnk/eozmwMlGxHfKymv3BAu544HXlXckr7JOnFe+z2EVizkqjZTgmvenZvJ2jQElNGAGk1sHU6jrUf14mkvE3wfdCHDAu2LY8J75+U4tnLI0tNnj2agaa+b15zg4jZewuAM5px006gsTe+0rHcEU0+b0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YX7jnWJQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=6XOvq/Mi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 26 Jan 2026 15:41:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1769442074;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=muE7V5/pHp4zGNoyP6L2KqA2N63VnR5GA53KUXIO/x0=;
	b=YX7jnWJQpLY4lVVwtoEP3e/6aUU0m8auoYjthvULAW2F4Rbwr+3lco/TyUdzXLQaUxVzIU
	YUonium2Cd7ZzqyQLZEcos0jL6khvEf+4coaoooQSV1pQUjedm5VXnsHStwfz9hfIPkgx7
	fwWBcuS6b3Xda+n+6dBOh/baDMV8ADi8wOSCniL5l53W/mzlNH5xcUd8Qj9swKw0HZG/Xm
	dvnLGjFmiOZUx+qMcNQmklrF7l87RlpQbRo3cP9EetKRXli0mV/dPlXlHzekFwxcOrzlCA
	Dl0oBn8HrPwlUoxFstmrU/nx6KwcZqlt6rm2/VlTQplYaFud1rVzAkd0ifTnuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1769442074;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=muE7V5/pHp4zGNoyP6L2KqA2N63VnR5GA53KUXIO/x0=;
	b=6XOvq/MiflH2m3n2VY+cNdBhEY2vHq0rosYc0+lnsLX36dxcqMVABeGsbgpj2As7Bm30P6
	g7NudUOV19li+GBg==
From: "tip-bot2 for Aniket Limaye" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/ti-sci-intr: Allow parsing interrupt-types
 per-line
Cc: Aniket Limaye <a-limaye@ti.com>, Thomas Gleixner <tglx@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20260123-ul-driver-i2c-j722s-v4-2-b08625c487d5@ti.com>
References: <20260123-ul-driver-i2c-j722s-v4-2-b08625c487d5@ti.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176944207229.510.8507537492169657639.tip-bot2@tip-bot2>
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
	TAGGED_FROM(0.00)[bounces-8116-lists,linux-tip-commits=lfdr.de];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:replyto,msgid.link:url,linutronix.de:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
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
X-Rspamd-Queue-Id: 0190C8A429
X-Rspamd-Action: no action

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     3d9617ea8ab5ca779a227d1e7d23741f5f8400c1
Gitweb:        https://git.kernel.org/tip/3d9617ea8ab5ca779a227d1e7d23741f5f8=
400c1
Author:        Aniket Limaye <a-limaye@ti.com>
AuthorDate:    Fri, 23 Jan 2026 12:25:46 +05:30
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Mon, 26 Jan 2026 16:40:04 +01:00

irqchip/ti-sci-intr: Allow parsing interrupt-types per-line

Some INTR router instances act as simple passthroughs that preserve the
source interrupt type unchanged at the output line, rather than
converting all interrupts to a fixed type.

When interrupt sources are not homogeneous with respect to trigger type,
the driver needs to read each source's interrupt type from DT and pass
it unchanged to its interrupt parent.

Add support to check for absence of "ti,intr-trigger-type" to indicate
passthrough mode. When this property is absent, parse interrupt type
per-line from the DT fwspec provided by the interrupt source. Else, use
the global setting for all interrupt lines.

Signed-off-by: Aniket Limaye <a-limaye@ti.com>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Link: https://patch.msgid.link/20260123-ul-driver-i2c-j722s-v4-2-b08625c487d5=
@ti.com
---
 drivers/irqchip/irq-ti-sci-intr.c | 54 ++++++++++++++++++++----------
 1 file changed, 36 insertions(+), 18 deletions(-)

diff --git a/drivers/irqchip/irq-ti-sci-intr.c b/drivers/irqchip/irq-ti-sci-i=
ntr.c
index 354613e..0ea1704 100644
--- a/drivers/irqchip/irq-ti-sci-intr.c
+++ b/drivers/irqchip/irq-ti-sci-intr.c
@@ -61,12 +61,21 @@ static int ti_sci_intr_irq_domain_translate(struct irq_do=
main *domain,
 {
 	struct ti_sci_intr_irq_domain *intr =3D domain->host_data;
=20
-	if (fwspec->param_count !=3D 1)
-		return -EINVAL;
+	if (intr->type) {
+		/* Global interrupt-type */
+		if (fwspec->param_count !=3D 1)
+			return -EINVAL;
=20
-	*hwirq =3D fwspec->param[0];
-	*type =3D intr->type;
+		*hwirq =3D fwspec->param[0];
+		*type =3D intr->type;
+	} else {
+		/* Per-Line interrupt-type */
+		if (fwspec->param_count !=3D 2)
+			return -EINVAL;
=20
+		*hwirq =3D fwspec->param[0];
+		*type =3D fwspec->param[1];
+	}
 	return 0;
 }
=20
@@ -128,11 +137,12 @@ static void ti_sci_intr_irq_domain_free(struct irq_doma=
in *domain,
  * @domain:	Pointer to the interrupt router IRQ domain
  * @virq:	Corresponding Linux virtual IRQ number
  * @hwirq:	Corresponding hwirq for the IRQ within this IRQ domain
+ * @hwirq_type:	Corresponding hwirq trigger type for the IRQ within this IRQ=
 domain
  *
  * Returns intr output irq if all went well else appropriate error pointer.
  */
-static int ti_sci_intr_alloc_parent_irq(struct irq_domain *domain,
-					unsigned int virq, u32 hwirq)
+static int ti_sci_intr_alloc_parent_irq(struct irq_domain *domain, unsigned =
int virq,
+					u32 hwirq, u32 hwirq_type)
 {
 	struct ti_sci_intr_irq_domain *intr =3D domain->host_data;
 	struct device_node *parent_node;
@@ -156,11 +166,22 @@ static int ti_sci_intr_alloc_parent_irq(struct irq_doma=
in *domain,
 		fwspec.param_count =3D 3;
 		fwspec.param[0] =3D 0;	/* SPI */
 		fwspec.param[1] =3D p_hwirq - 32; /* SPI offset */
-		fwspec.param[2] =3D intr->type;
+		fwspec.param[2] =3D hwirq_type;
 	} else {
 		/* Parent is Interrupt Router */
-		fwspec.param_count =3D 1;
-		fwspec.param[0] =3D p_hwirq;
+		u32 parent_trigger_type;
+
+		if (!of_property_read_u32(parent_node, "ti,intr-trigger-type",
+					  &parent_trigger_type)) {
+			/* Parent has global trigger type */
+			fwspec.param_count =3D 1;
+			fwspec.param[0] =3D p_hwirq;
+		} else {
+			/* Parent supports per-line trigger types */
+			fwspec.param_count =3D 2;
+			fwspec.param[0] =3D p_hwirq;
+			fwspec.param[1] =3D hwirq_type;
+		}
 	}
=20
 	err =3D irq_domain_alloc_irqs_parent(domain, virq, 1, &fwspec);
@@ -196,15 +217,15 @@ static int ti_sci_intr_irq_domain_alloc(struct irq_doma=
in *domain,
 					void *data)
 {
 	struct irq_fwspec *fwspec =3D data;
+	unsigned int hwirq_type;
 	unsigned long hwirq;
-	unsigned int flags;
 	int err, out_irq;
=20
-	err =3D ti_sci_intr_irq_domain_translate(domain, fwspec, &hwirq, &flags);
+	err =3D ti_sci_intr_irq_domain_translate(domain, fwspec, &hwirq, &hwirq_typ=
e);
 	if (err)
 		return err;
=20
-	out_irq =3D ti_sci_intr_alloc_parent_irq(domain, virq, hwirq);
+	out_irq =3D ti_sci_intr_alloc_parent_irq(domain, virq, hwirq, hwirq_type);
 	if (out_irq < 0)
 		return out_irq;
=20
@@ -247,12 +268,9 @@ static int ti_sci_intr_irq_domain_probe(struct platform_=
device *pdev)
 		return -ENOMEM;
=20
 	intr->dev =3D dev;
-	ret =3D of_property_read_u32(dev_of_node(dev), "ti,intr-trigger-type",
-				   &intr->type);
-	if (ret) {
-		dev_err(dev, "missing ti,intr-trigger-type property\n");
-		return -EINVAL;
-	}
+
+	if (of_property_read_u32(dev_of_node(dev), "ti,intr-trigger-type", &intr->t=
ype))
+		intr->type =3D IRQ_TYPE_NONE;
=20
 	intr->sci =3D devm_ti_sci_get_by_phandle(dev, "ti,sci");
 	if (IS_ERR(intr->sci))

