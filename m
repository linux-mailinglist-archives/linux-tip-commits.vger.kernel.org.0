Return-Path: <linux-tip-commits+bounces-8058-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 7445AD393DA
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 11:11:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 02E4430141DC
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 10:09:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BEAB12BE7CD;
	Sun, 18 Jan 2026 10:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dQiBknc1";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AX884g38"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F08E2DCF6B;
	Sun, 18 Jan 2026 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768730969; cv=none; b=QVWX5qYzkowttBSELtxCvK9/933HmPED80qqFTmyWDhQlziwc5ZufqzRQSULCTati27Q/T3R+KehgcsxnmD6PCvfQeoEI0h/GfJLVzhcrynV0SId2NF8Bxpi2Bau4K4yFC0YWHRrQuS1Sxi7WgE/rhN6jezmzp5K0HFpJiInqEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768730969; c=relaxed/simple;
	bh=auvKLWOWvKxBSDym+QwRkM8gua588mN3JemyIpd44g0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dAIzsl7PnB2mptrttU0m2WwafQQjA18Jy2S7wudB/mo3eHKja10dnRqXS8M1RJUuz2yBqxCd5ylsJww0p4xLf/++R3NWE0I2yu+OL+7jbjvyZsgu8DUlPbL3ftm09Q8W8OmAGTIL4aJkqVSE8LLoo2ZwT5QunpxcOSjNrI+USF0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dQiBknc1; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AX884g38; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Jan 2026 10:09:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768730960;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F2gtIzZTWIkX/VrfY6uP/ONixLb8/o69t3uI5ipYzR8=;
	b=dQiBknc1fLb/v6Meyl8eoJReXyEiekXVDhg+4Ny7/2CnXHDS3xMRkxoCehzkcHAbH8Ens8
	aF20msPVe5yah0Z90yy8Ud2JXRWpb7hM5+pejfw8Gn6MUUEpPmBcygpLJ69tDBXNjmyKjq
	2IEI4mS75HbC5HX+h1G1hkqBQFW2d8VwE+U0wIbzIZ5uukPoqIZyad6NZJtfDAwcUuvFQi
	9dK2F/rQ1a21zjFOK5PqTXhMgEb1zxLq8ElxTRJ/mNALhNrtjC2LZvt/LLpHERlZB+yI6N
	cgzs0Pap0aSEeb/guWFa4A2qk9vAv9YaQ5NqI0LHwy984Yz5h2WNp0NaWWWwWA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768730960;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F2gtIzZTWIkX/VrfY6uP/ONixLb8/o69t3uI5ipYzR8=;
	b=AX884g38JifwWHVXq/q1EY6VBV/EjidMi7osAB1Ssbovx0KzOOHST+88NdY+MgBNIK3UYW
	58FHxL9ZhPbyfrAQ==
From: "tip-bot2 for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/msi] irqchip/gic-v5: Split IRS probing into OF and generic portions
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260115-gicv5-host-acpi-v3-3-c13a9a150388@kernel.org>
References: <20260115-gicv5-host-acpi-v3-3-c13a9a150388@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176873095966.510.14667827980043130361.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     e587ca76d95f3587543f6f5e19c96f7d390061b6
Gitweb:        https://git.kernel.org/tip/e587ca76d95f3587543f6f5e19c96f7d390=
061b6
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Thu, 15 Jan 2026 10:50:49 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 18 Jan 2026 11:07:57 +01:00

irqchip/gic-v5: Split IRS probing into OF and generic portions

Split the IRS driver code into OF specific and generic portions in order
to pave the way for adding ACPI firmware bindings support.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Link: https://patch.msgid.link/20260115-gicv5-host-acpi-v3-3-c13a9a150388@ker=
nel.org
---
 drivers/irqchip/irq-gic-v5-irs.c | 92 ++++++++++++++++---------------
 1 file changed, 50 insertions(+), 42 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v5-irs.c b/drivers/irqchip/irq-gic-v5-ir=
s.c
index ce2732d..7db44a9 100644
--- a/drivers/irqchip/irq-gic-v5-irs.c
+++ b/drivers/irqchip/irq-gic-v5-irs.c
@@ -545,15 +545,13 @@ int gicv5_irs_register_cpu(int cpuid)
=20
 static void __init gicv5_irs_init_bases(struct gicv5_irs_chip_data *irs_data,
 					void __iomem *irs_base,
-					struct fwnode_handle *handle)
+					bool noncoherent)
 {
-	struct device_node *np =3D to_of_node(handle);
 	u32 cr0, cr1;
=20
-	irs_data->fwnode =3D handle;
 	irs_data->irs_base =3D irs_base;
=20
-	if (of_property_read_bool(np, "dma-noncoherent")) {
+	if (noncoherent) {
 		/*
 		 * A non-coherent IRS implies that some cache levels cannot be
 		 * used coherently by the cores and GIC. Our only option is to mark
@@ -678,12 +676,52 @@ static void irs_setup_pri_bits(u32 idr1)
 	}
 }
=20
-static int __init gicv5_irs_init(struct device_node *node)
+static int __init gicv5_irs_init(struct gicv5_irs_chip_data *irs_data)
+{
+	u32 spi_count, idr =3D irs_readl_relaxed(irs_data, GICV5_IRS_IDR2);
+
+	if (WARN(!FIELD_GET(GICV5_IRS_IDR2_LPI, idr),
+		 "LPI support not available - no IPIs, can't proceed\n")) {
+		return -ENODEV;
+	}
+
+	idr =3D irs_readl_relaxed(irs_data, GICV5_IRS_IDR7);
+	irs_data->spi_min =3D FIELD_GET(GICV5_IRS_IDR7_SPI_BASE, idr);
+
+	idr =3D irs_readl_relaxed(irs_data, GICV5_IRS_IDR6);
+	irs_data->spi_range =3D FIELD_GET(GICV5_IRS_IDR6_SPI_IRS_RANGE, idr);
+
+	/*
+	 * Do the global setting only on the first IRS.
+	 * Global properties (iaffid_bits, global spi count) are guaranteed to
+	 * be consistent across IRSes by the architecture.
+	 */
+	if (list_empty(&irs_nodes)) {
+
+		idr =3D irs_readl_relaxed(irs_data, GICV5_IRS_IDR1);
+		irs_setup_pri_bits(idr);
+
+		idr =3D irs_readl_relaxed(irs_data, GICV5_IRS_IDR5);
+
+		spi_count =3D FIELD_GET(GICV5_IRS_IDR5_SPI_RANGE, idr);
+		gicv5_global_data.global_spi_count =3D spi_count;
+
+		gicv5_init_lpi_domain();
+
+		pr_debug("Detected %u SPIs globally\n", spi_count);
+	}
+
+	list_add_tail(&irs_data->entry, &irs_nodes);
+
+	return 0;
+}
+
+static int __init gicv5_irs_of_init(struct device_node *node)
 {
 	struct gicv5_irs_chip_data *irs_data;
 	void __iomem *irs_base;
-	u32 idr, spi_count;
 	u8 iaffid_bits;
+	u32 idr;
 	int ret;
=20
 	irs_data =3D kzalloc(sizeof(*irs_data), GFP_KERNEL);
@@ -705,7 +743,8 @@ static int __init gicv5_irs_init(struct device_node *node)
 		goto out_err;
 	}
=20
-	gicv5_irs_init_bases(irs_data, irs_base, &node->fwnode);
+	irs_data->fwnode =3D of_fwnode_handle(node);
+	gicv5_irs_init_bases(irs_data, irs_base, of_property_read_bool(node, "dma-n=
oncoherent"));
=20
 	idr =3D irs_readl_relaxed(irs_data, GICV5_IRS_IDR1);
 	iaffid_bits =3D FIELD_GET(GICV5_IRS_IDR1_IAFFID_BITS, idr) + 1;
@@ -716,18 +755,9 @@ static int __init gicv5_irs_init(struct device_node *nod=
e)
 		goto out_iomem;
 	}
=20
-	idr =3D irs_readl_relaxed(irs_data, GICV5_IRS_IDR2);
-	if (WARN(!FIELD_GET(GICV5_IRS_IDR2_LPI, idr),
-		 "LPI support not available - no IPIs, can't proceed\n")) {
-		ret =3D -ENODEV;
+	ret =3D gicv5_irs_init(irs_data);
+	if (ret)
 		goto out_iomem;
-	}
-
-	idr =3D irs_readl_relaxed(irs_data, GICV5_IRS_IDR7);
-	irs_data->spi_min =3D FIELD_GET(GICV5_IRS_IDR7_SPI_BASE, idr);
-
-	idr =3D irs_readl_relaxed(irs_data, GICV5_IRS_IDR6);
-	irs_data->spi_range =3D FIELD_GET(GICV5_IRS_IDR6_SPI_IRS_RANGE, idr);
=20
 	if (irs_data->spi_range) {
 		pr_info("%s detected SPI range [%u-%u]\n",
@@ -737,29 +767,7 @@ static int __init gicv5_irs_init(struct device_node *nod=
e)
 						irs_data->spi_range - 1);
 	}
=20
-	/*
-	 * Do the global setting only on the first IRS.
-	 * Global properties (iaffid_bits, global spi count) are guaranteed to
-	 * be consistent across IRSes by the architecture.
-	 */
-	if (list_empty(&irs_nodes)) {
-
-		idr =3D irs_readl_relaxed(irs_data, GICV5_IRS_IDR1);
-		irs_setup_pri_bits(idr);
-
-		idr =3D irs_readl_relaxed(irs_data, GICV5_IRS_IDR5);
-
-		spi_count =3D FIELD_GET(GICV5_IRS_IDR5_SPI_RANGE, idr);
-		gicv5_global_data.global_spi_count =3D spi_count;
-
-		gicv5_init_lpi_domain();
-
-		pr_debug("Detected %u SPIs globally\n", spi_count);
-	}
-
-	list_add_tail(&irs_data->entry, &irs_nodes);
-
-	return 0;
+	return ret;
=20
 out_iomem:
 	iounmap(irs_base);
@@ -818,7 +826,7 @@ int __init gicv5_irs_of_probe(struct device_node *parent)
 		if (!of_device_is_compatible(np, "arm,gic-v5-irs"))
 			continue;
=20
-		ret =3D gicv5_irs_init(np);
+		ret =3D gicv5_irs_of_init(np);
 		if (ret)
 			pr_err("Failed to init IRS %s\n", np->full_name);
 	}

