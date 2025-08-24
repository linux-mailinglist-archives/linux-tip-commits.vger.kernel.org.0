Return-Path: <linux-tip-commits+bounces-6334-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A6B32B32F22
	for <lists+linux-tip-commits@lfdr.de>; Sun, 24 Aug 2025 12:57:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D3063483338
	for <lists+linux-tip-commits@lfdr.de>; Sun, 24 Aug 2025 10:56:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D513275AF9;
	Sun, 24 Aug 2025 10:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="sMEYOGff";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dHrYiPIb"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D9E3275865;
	Sun, 24 Aug 2025 10:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756032923; cv=none; b=ayKTpcy9nDlhcU+n/3uEp1hRZv8FDhDSwLhLJcg5J0VLR3tNxWv7lF8zH7Ypgw0YwkdKo3xmsSR/w56kmqM03r3BfMsbSXKn8yZ2D3U9a8RT2ywbTc755rDYe+R4NuRvebo4cy0bKJm00/2HZjnfmsbRkFs4RKMbsQV1vPIPR3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756032923; c=relaxed/simple;
	bh=WheYIEuzYybFK2AmJ0z3SgypUmoUtssKomjMkLH+NUU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gYteLTVBRLb6LMJoqsaJDEHunq5tzCfqqyHL/D38YRgH7WYXeD1wQ71ikkqUU65Y5gdoHn5FtEWKzxmHLvNPLcRsA99/5OjN4TyK/PUz3TDLgmFTXzIm5ebfjp+RDCc3VtUWOEsurEFfT92WZCGPTrMpBtOpsk5DXkna8XXPb9g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=sMEYOGff; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dHrYiPIb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 24 Aug 2025 10:55:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1756032919;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TedkKtZz0ht92ILDvZav+rWZii9opD0TU847JkHELG0=;
	b=sMEYOGffKB7M4D8ZL3IeIp8F4cMoRYBV6L5iw7NW3hW7l39DMwSJVaQlRIHJLGhDscASCO
	HVmuVSYFjyS0NFySREwj1BqXffVHP1Lr5sWrhX4zty6ov8nyhZeXdy4aVMJ7SEWPSrF++M
	yiED1Jt+Sda7EHq716hRNZ0hof7alEfj5xRo7FazM7Y+KalhNAHGHIN0KomsZskrS0qzP1
	7PzJV7TuHIolgstFXEdTP3zesblkGqw1NUoyIRsYcQYu9NsYUkBHrVf/QUQTY3DQStL5C6
	0mr6kbWZv+4QKry04dLJbmtDhAJzdEAz37UlmL0S46WCoDL64tMajnNdHLysZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1756032919;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TedkKtZz0ht92ILDvZav+rWZii9opD0TU847JkHELG0=;
	b=dHrYiPIbZvG0kxO2AKaU8HhTy+sMCeRcHBX77yP1uTlhi0gMvm5D+EXMch+9YyDnd05Rnq
	7zajE8ZgDLFZNHDA==
From: "tip-bot2 for Bibo Mao" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/drivers] irqchip/loongson-eiointc: Route interrupt parsed
 from bios table
Cc: Bibo Mao <maobibo@loongson.cn>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250804081946.1456573-2-maobibo@loongson.cn>
References: <20250804081946.1456573-2-maobibo@loongson.cn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175603291811.1420.17542644389668984685.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     7fb83eb664e9b3a0438dd28859e9f0fd49d4c165
Gitweb:        https://git.kernel.org/tip/7fb83eb664e9b3a0438dd28859e9f0fd49d=
4c165
Author:        Bibo Mao <maobibo@loongson.cn>
AuthorDate:    Mon, 04 Aug 2025 16:19:45 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 24 Aug 2025 12:51:04 +02:00

irqchip/loongson-eiointc: Route interrupt parsed from bios table

Interrupt controller eiointc routes interrupts to CPU interface IP0 - IP7.

It is currently hard-coded that eiointc routes interrupts to the CPU
starting from IP1, but it should base that decision on the parent
interrupt, which is provided by ACPI or DTS.

Retrieve the parent's hardware interrupt number and store it in the
descriptor of the eointc instance, so that the routing function can utilize
it for the correct route settings.

[ tglx: Massaged change log ]

Signed-off-by: Bibo Mao <maobibo@loongson.cn>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250804081946.1456573-2-maobibo@loongson.cn

---
 drivers/irqchip/irq-loongson-eiointc.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-loongson-eiointc.c b/drivers/irqchip/irq-loo=
ngson-eiointc.c
index b2860eb..baa4069 100644
--- a/drivers/irqchip/irq-loongson-eiointc.c
+++ b/drivers/irqchip/irq-loongson-eiointc.c
@@ -68,6 +68,7 @@ struct eiointc_priv {
 	struct fwnode_handle	*domain_handle;
 	struct irq_domain	*eiointc_domain;
 	int			flags;
+	irq_hw_number_t		parent_hwirq;
 };
=20
 static struct eiointc_priv *eiointc_priv[MAX_IO_PICS];
@@ -211,7 +212,12 @@ static int eiointc_router_init(unsigned int cpu)
 		}
=20
 		for (i =3D 0; i < eiointc_priv[0]->vec_count / 32 / 4; i++) {
-			bit =3D BIT(1 + index); /* Route to IP[1 + index] */
+			/*
+			 * Route to interrupt pin, relative offset used here
+			 * Offset 0 means routing to IP0 and so on
+			 * Every 32 vector routing to one interrupt pin
+			 */
+			bit =3D BIT(eiointc_priv[index]->parent_hwirq - INT_HWI0);
 			data =3D bit | (bit << 8) | (bit << 16) | (bit << 24);
 			iocsr_write32(data, EIOINTC_REG_IPMAP + i * 4);
 		}
@@ -495,7 +501,7 @@ int __init eiointc_acpi_init(struct irq_domain *parent,
=20
 	priv->vec_count =3D VEC_COUNT;
 	priv->node =3D acpi_eiointc->node;
-
+	priv->parent_hwirq =3D acpi_eiointc->cascade;
 	parent_irq =3D irq_create_mapping(parent, acpi_eiointc->cascade);
=20
 	ret =3D eiointc_init(priv, parent_irq, acpi_eiointc->node_map);
@@ -527,8 +533,9 @@ out_free_priv:
 static int __init eiointc_of_init(struct device_node *of_node,
 				  struct device_node *parent)
 {
-	int parent_irq, ret;
 	struct eiointc_priv *priv;
+	struct irq_data *irq_data;
+	int parent_irq, ret;
=20
 	priv =3D kzalloc(sizeof(*priv), GFP_KERNEL);
 	if (!priv)
@@ -544,6 +551,12 @@ static int __init eiointc_of_init(struct device_node *of=
_node,
 	if (ret < 0)
 		goto out_free_priv;
=20
+	irq_data =3D irq_get_irq_data(parent_irq);
+	if (!irq_data) {
+		ret =3D -ENODEV;
+		goto out_free_priv;
+	}
+
 	/*
 	 * In particular, the number of devices supported by the LS2K0500
 	 * extended I/O interrupt vector is 128.
@@ -552,7 +565,7 @@ static int __init eiointc_of_init(struct device_node *of_=
node,
 		priv->vec_count =3D 128;
 	else
 		priv->vec_count =3D VEC_COUNT;
-
+	priv->parent_hwirq =3D irqd_to_hwirq(irq_data);
 	priv->node =3D 0;
 	priv->domain_handle =3D of_fwnode_handle(of_node);
=20

