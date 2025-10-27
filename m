Return-Path: <linux-tip-commits+bounces-7022-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B6AEC0F54E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 17:35:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id C596934F3EA
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 16:34:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C22731D36D;
	Mon, 27 Oct 2025 16:31:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="MF8WxQhe";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NTPGnBUn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C40F30AAC8;
	Mon, 27 Oct 2025 16:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582681; cv=none; b=mqahvjrf0Uj/JrjLJJm5IEaEMnHF0dg5vyIRgkql4u5sJfG3SmGOD8Rh8ajDiRVe/AnonoByRXDVcsdPLyxBHMvkHQPpsaozNu7QoaN2HSSmPGOB+/Fr+9WuaWH8gAMeagagPoW3+O0iupuI7TQrqnW/22YV/Eb0X0XcQqRil5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582681; c=relaxed/simple;
	bh=g1LmxvsQkwkxjpL+1VmBSdaERWyqigFfeLleexFkfrk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gWu33BHMvsAVDAzDx3qT2ZOJBAhtQt3dAiO2K1rpmXokBze0NLlF/90BSI8WNYZuvSkOyfnGJexm7voECs0nXOPicO4bn65tUtqYDf94fh3a1vWFotjsXrIjw2SA/sUF1ux7Hz7m1tL2yrerhyA+uq+loSZCS8xVSwGL3Su/I/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=MF8WxQhe; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NTPGnBUn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 16:31:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761582679;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eEg4DN3vQSEI8OMpxyYjiX+EtWocPomUYNpJuiUZNus=;
	b=MF8WxQheLgE/Jm7sPG+ugBexJ5zv49lSH372A5K//6G6z3AgpIkOKCf++Oh7JbYcuYJ46r
	6hdsCAVvEeTg54AxsNs8rQMF7JQUVs+0HjH+bbeZdYwQIyHxfv7vFvHoo4hkQXq1W4tiGA
	W2m16/XyiL1iiSH2/ek9HZQYRF8zr0rv5QU3rRHE4aaLMRzpeJX7HKRxmiL30vtZ6UlsJ4
	1NzI8KU9Cfd91TYql2cRaSW8CW1pA6v80o5TfuX8rBhJEQPoFnEulliNAg9etQmTMvTBcz
	4htut/cMGjmAFUo7SYceO10WtUFLDSFKcE/co++dvo0dz7vrf+f61u7SRuzNzA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761582679;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eEg4DN3vQSEI8OMpxyYjiX+EtWocPomUYNpJuiUZNus=;
	b=NTPGnBUnxNt1aTsqp5LpNFFKdvy8KeL3Lm+w+oyENE7AHaJWDbEgaTUgjuYLO+wV5U1E0q
	RcHnVN4SnFIXKSAQ==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v3: Add FW info retrieval support
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251020122944.3074811-6-maz@kernel.org>
References: <20251020122944.3074811-6-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176158267770.2601451.10503615253542161313.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     68905ea65ceff4f42ab14dbc6882de313127646f
Gitweb:        https://git.kernel.org/tip/68905ea65ceff4f42ab14dbc6882de31312=
7646f
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 20 Oct 2025 13:29:22 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 27 Oct 2025 17:16:33 +01:00

irqchip/gic-v3: Add FW info retrieval support

Plug the new .get_fwspec_info() callback into the GICv3 core driver, using
some of the existing PPI affinity handling infrastructure.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Will Deacon <will@kernel.org>
Link: https://patch.msgid.link/20251020122944.3074811-6-maz@kernel.org
---
 drivers/irqchip/irq-gic-v3.c | 53 +++++++++++++++++++++++++++++++++++-
 1 file changed, 53 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 3de351e..cf0ba83 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -69,6 +69,8 @@ struct gic_chip_data {
 	bool			has_rss;
 	unsigned int		ppi_nr;
 	struct partition_desc	**ppi_descs;
+	struct partition_affinity *parts;
+	unsigned int		nr_parts;
 };
=20
 #define T241_CHIPS_MAX		4
@@ -1797,11 +1799,58 @@ static int gic_irq_domain_select(struct irq_domain *d,
 	return d =3D=3D partition_get_domain(gic_data.ppi_descs[ppi_idx]);
 }
=20
+static int gic_irq_get_fwspec_info(struct irq_fwspec *fwspec, struct irq_fws=
pec_info *info)
+{
+	const struct cpumask *mask =3D NULL;
+
+	info->flags =3D 0;
+	info->affinity =3D NULL;
+
+	/* ACPI is not capable of describing PPI affinity -- yet */
+	if (!is_of_node(fwspec->fwnode))
+		return 0;
+
+	/* If the specifier provides an affinity, use it */
+	if (fwspec->param_count =3D=3D 4 && fwspec->param[3]) {
+		struct fwnode_handle *fw;
+
+		switch (fwspec->param[0]) {
+		case 1:			/* PPI */
+		case 3:			/* EPPI */
+			break;
+		default:
+			return 0;
+		}
+
+		fw =3D of_fwnode_handle(of_find_node_by_phandle(fwspec->param[3]));
+		if (!fw)
+			return -ENOENT;
+
+		for (int i =3D 0; i < gic_data.nr_parts; i++) {
+			if (gic_data.parts[i].partition_id =3D=3D fw) {
+				mask =3D &gic_data.parts[i].mask;
+				break;
+			}
+		}
+
+		if (!mask)
+			return -ENOENT;
+	} else {
+		mask =3D cpu_possible_mask;
+	}
+
+	info->affinity =3D mask;
+	info->flags =3D IRQ_FWSPEC_INFO_AFFINITY_VALID;
+
+	return 0;
+}
+
 static const struct irq_domain_ops gic_irq_domain_ops =3D {
 	.translate =3D gic_irq_domain_translate,
 	.alloc =3D gic_irq_domain_alloc,
 	.free =3D gic_irq_domain_free,
 	.select =3D gic_irq_domain_select,
+	.get_fwspec_info =3D gic_irq_get_fwspec_info,
 };
=20
 static int partition_domain_translate(struct irq_domain *d,
@@ -1840,6 +1889,7 @@ static int partition_domain_translate(struct irq_domain=
 *d,
 static const struct irq_domain_ops partition_domain_ops =3D {
 	.translate =3D partition_domain_translate,
 	.select =3D gic_irq_domain_select,
+	.get_fwspec_info =3D gic_irq_get_fwspec_info,
 };
=20
 static bool gic_enable_quirk_msm8996(void *data)
@@ -2232,6 +2282,9 @@ static void __init gic_populate_ppi_partitions(struct d=
evice_node *gic_node)
 		part_idx++;
 	}
=20
+	gic_data.parts =3D parts;
+	gic_data.nr_parts =3D nr_parts;
+
 	for (i =3D 0; i < gic_data.ppi_nr; i++) {
 		unsigned int irq;
 		struct partition_desc *desc;

