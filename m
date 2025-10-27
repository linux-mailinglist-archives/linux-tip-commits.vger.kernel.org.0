Return-Path: <linux-tip-commits+bounces-7006-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AEECDC0F533
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 17:34:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 19828188F28E
	for <lists+linux-tip-commits@lfdr.de>; Mon, 27 Oct 2025 16:32:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 54E06314D2F;
	Mon, 27 Oct 2025 16:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XfZwG3+4";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kjWdEoEi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B695314B80;
	Mon, 27 Oct 2025 16:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761582662; cv=none; b=l91Esho/BlMKlaAMwyjSijb32MG/Vlx+OdeBx0TWwjGwoaHRwQa/C65dkQLFAgCv7bZJULMb6Z9sQ6x0zybhqypdfEUrOMU786uT7qEXR3vJ7Up16s1FJX1OyYUiAgDQRqWnPmAKeGefiZA2qgb7jiG/dc0jAFJ5tdf4/IJUvjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761582662; c=relaxed/simple;
	bh=h7wLd23oEiMKxPNiMBYYMnZwP9dgqHgNiNKoAF1Marw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tacM36jQz1OJoUDwo6PWelbke9GcYI/AgFhaLJ39Qs1pwNUZq2ru7SW1fw4CcGVvdKHcqSJDzIgYNL6N/yQpXb/O/RQXZtsm7X3YPeYxrzksg5bwcqIwl44UmVFcueoUxrhaXTTTs5p1BjyZezEdFewfejEh9vwtmpqo/ypPYKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XfZwG3+4; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kjWdEoEi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 27 Oct 2025 16:30:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1761582658;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eD8+oZytQn5fpry9/CIINpbAZqmjpYurhtlJpA6vSR8=;
	b=XfZwG3+4O7WKTi/Jghj6P/UyCcmYnIgHeqwIwWWDd7BRXE1C9RCR43C/Bmyyr/RMTu1MtH
	9drZ33JwuxBYGuCvE2N+at6ZvsM4xM71+6N6T2EvTF2caD1qtTdH+kuD68cnXj+ofs/wnU
	TxPBaEFMXdulIo0Otcrf1J5Y1oGjG6TNZiX7zjVtXZ5rmeffGWRW7rNN20qgqaN89VTn2Q
	es9QGr11x9tYa4wnQSpsfX/rmZLVVAQf0XIzJ8WnPWLbJ8OU2/OBhsRKS9DndKqxTMJ0t5
	9KbppxQgpltJzOGEMSQJnZ78nsm/PJLPo0Bm5dncHMc5I2wuzi+NUh1zc9u8Xw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1761582658;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=eD8+oZytQn5fpry9/CIINpbAZqmjpYurhtlJpA6vSR8=;
	b=kjWdEoEiNIhAvofUmu8eYd39LITvHgBw1v2ENF8ZyhFmFtfZQwwBs04dVu0KTu3i4G5RqD
	/LvK8EsjjV8u7mAg==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/core] irqchip/gic-v3: Drop support for custom PPI partitions
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251020122944.3074811-22-maz@kernel.org>
References: <20251020122944.3074811-22-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176158265752.2601451.12826389944170084269.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     64b9738eaa937232f2567fd55bbb4fc1a00242ea
Gitweb:        https://git.kernel.org/tip/64b9738eaa937232f2567fd55bbb4fc1a00=
242ea
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 20 Oct 2025 13:29:38 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 27 Oct 2025 17:16:36 +01:00

irqchip/gic-v3: Drop support for custom PPI partitions

The only thing getting in the way of correctly handling PPIs the way they
were intended is the GICv3 hack that deals with PPI partitions.

Remove that code, allowing the common code to kick in.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Will Deacon <will@kernel.org>
Link: https://patch.msgid.link/20251020122944.3074811-22-maz@kernel.org
---
 drivers/irqchip/Kconfig      |   1 +-
 drivers/irqchip/irq-gic-v3.c | 133 ++--------------------------------
 2 files changed, 8 insertions(+), 126 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index a61c6dc..648b361 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -36,7 +36,6 @@ config GIC_NON_BANKED
 config ARM_GIC_V3
 	bool
 	select IRQ_DOMAIN_HIERARCHY
-	select PARTITION_PERCPU
 	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
 	select HAVE_ARM_SMCCC_DISCOVERY
 	select IRQ_MSI_IOMMU
diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index dd2d6d7..6607ab5 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -26,7 +26,6 @@
 #include <linux/irqchip/arm-gic-common.h>
 #include <linux/irqchip/arm-gic-v3.h>
 #include <linux/irqchip/arm-gic-v3-prio.h>
-#include <linux/irqchip/irq-partition-percpu.h>
 #include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/arm-smccc.h>
@@ -46,8 +45,6 @@ static u8 dist_prio_nmi __ro_after_init =3D GICV3_PRIO_NMI;
 #define FLAGS_WORKAROUND_ASR_ERRATUM_8601001	(1ULL << 2)
 #define FLAGS_WORKAROUND_INSECURE		(1ULL << 3)
=20
-#define GIC_IRQ_TYPE_PARTITION	(GIC_IRQ_TYPE_LPI + 1)
-
 static struct cpumask broken_rdists __read_mostly __maybe_unused;
=20
 struct redist_region {
@@ -68,11 +65,15 @@ struct gic_chip_data {
 	u64			flags;
 	bool			has_rss;
 	unsigned int		ppi_nr;
-	struct partition_desc	**ppi_descs;
 	struct partition_affinity *parts;
 	unsigned int		nr_parts;
 };
=20
+struct partition_affinity {
+	cpumask_t			mask;
+	struct fwnode_handle		*partition_id;
+};
+
 #define T241_CHIPS_MAX		4
 static void __iomem *t241_dist_base_alias[T241_CHIPS_MAX] __read_mostly;
 static DEFINE_STATIC_KEY_FALSE(gic_nvidia_t241_erratum);
@@ -593,18 +594,6 @@ static void gic_irq_set_prio(struct irq_data *d, u8 prio)
 	writeb_relaxed(prio, base + offset + index);
 }
=20
-static u32 __gic_get_ppi_index(irq_hw_number_t hwirq)
-{
-	switch (__get_intid_range(hwirq)) {
-	case PPI_RANGE:
-		return hwirq - 16;
-	case EPPI_RANGE:
-		return hwirq - EPPI_BASE_INTID + 16;
-	default:
-		unreachable();
-	}
-}
-
 static int gic_irq_nmi_setup(struct irq_data *d)
 {
 	struct irq_desc *desc =3D irq_to_desc(d->irq);
@@ -1628,13 +1617,6 @@ static int gic_irq_domain_translate(struct irq_domain =
*d,
 		case GIC_IRQ_TYPE_LPI:	/* LPI */
 			*hwirq =3D fwspec->param[1];
 			break;
-		case GIC_IRQ_TYPE_PARTITION:
-			*hwirq =3D fwspec->param[1];
-			if (fwspec->param[1] >=3D 16)
-				*hwirq +=3D EPPI_BASE_INTID - 16;
-			else
-				*hwirq +=3D 16;
-			break;
 		default:
 			return -EINVAL;
 		}
@@ -1643,10 +1625,8 @@ static int gic_irq_domain_translate(struct irq_domain =
*d,
=20
 		/*
 		 * Make it clear that broken DTs are... broken.
-		 * Partitioned PPIs are an unfortunate exception.
 		 */
-		WARN_ON(*type =3D=3D IRQ_TYPE_NONE &&
-			fwspec->param[0] !=3D GIC_IRQ_TYPE_PARTITION);
+		WARN_ON(*type =3D=3D IRQ_TYPE_NONE);
 		return 0;
 	}
=20
@@ -1703,33 +1683,12 @@ static void gic_irq_domain_free(struct irq_domain *do=
main, unsigned int virq,
 	}
 }
=20
-static bool fwspec_is_partitioned_ppi(struct irq_fwspec *fwspec,
-				      irq_hw_number_t hwirq)
-{
-	enum gic_intid_range range;
-
-	if (!gic_data.ppi_descs)
-		return false;
-
-	if (!is_of_node(fwspec->fwnode))
-		return false;
-
-	if (fwspec->param_count < 4 || !fwspec->param[3])
-		return false;
-
-	range =3D __get_intid_range(hwirq);
-	if (range !=3D PPI_RANGE && range !=3D EPPI_RANGE)
-		return false;
-
-	return true;
-}
-
 static int gic_irq_domain_select(struct irq_domain *d,
 				 struct irq_fwspec *fwspec,
 				 enum irq_domain_bus_token bus_token)
 {
-	unsigned int type, ppi_idx;
 	irq_hw_number_t hwirq;
+	unsigned int type;
 	int ret;
=20
 	/* Not for us */
@@ -1748,15 +1707,7 @@ static int gic_irq_domain_select(struct irq_domain *d,
 	if (WARN_ON_ONCE(ret))
 		return 0;
=20
-	if (!fwspec_is_partitioned_ppi(fwspec, hwirq))
-		return d =3D=3D gic_data.domain;
-
-	/*
-	 * If this is a PPI and we have a 4th (non-null) parameter,
-	 * then we need to match the partition domain.
-	 */
-	ppi_idx =3D __gic_get_ppi_index(hwirq);
-	return d =3D=3D partition_get_domain(gic_data.ppi_descs[ppi_idx]);
+	return d =3D=3D gic_data.domain;
 }
=20
 static int gic_irq_get_fwspec_info(struct irq_fwspec *fwspec, struct irq_fws=
pec_info *info)
@@ -1813,45 +1764,6 @@ static const struct irq_domain_ops gic_irq_domain_ops =
=3D {
 	.get_fwspec_info =3D gic_irq_get_fwspec_info,
 };
=20
-static int partition_domain_translate(struct irq_domain *d,
-				      struct irq_fwspec *fwspec,
-				      unsigned long *hwirq,
-				      unsigned int *type)
-{
-	unsigned long ppi_intid;
-	struct device_node *np;
-	unsigned int ppi_idx;
-	int ret;
-
-	if (!gic_data.ppi_descs)
-		return -ENOMEM;
-
-	np =3D of_find_node_by_phandle(fwspec->param[3]);
-	if (WARN_ON(!np))
-		return -EINVAL;
-
-	ret =3D gic_irq_domain_translate(d, fwspec, &ppi_intid, type);
-	if (WARN_ON_ONCE(ret))
-		return 0;
-
-	ppi_idx =3D __gic_get_ppi_index(ppi_intid);
-	ret =3D partition_translate_id(gic_data.ppi_descs[ppi_idx],
-				     of_fwnode_handle(np));
-	if (ret < 0)
-		return ret;
-
-	*hwirq =3D ret;
-	*type =3D fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
-
-	return 0;
-}
-
-static const struct irq_domain_ops partition_domain_ops =3D {
-	.translate =3D partition_domain_translate,
-	.select =3D gic_irq_domain_select,
-	.get_fwspec_info =3D gic_irq_get_fwspec_info,
-};
-
 static bool gic_enable_quirk_msm8996(void *data)
 {
 	struct gic_chip_data *d =3D data;
@@ -2174,12 +2086,7 @@ static void __init gic_populate_ppi_partitions(struct =
device_node *gic_node)
 	if (!parts_node)
 		return;
=20
-	gic_data.ppi_descs =3D kcalloc(gic_data.ppi_nr, sizeof(*gic_data.ppi_descs)=
, GFP_KERNEL);
-	if (!gic_data.ppi_descs)
-		goto out_put_node;
-
 	nr_parts =3D of_get_child_count(parts_node);
-
 	if (!nr_parts)
 		goto out_put_node;
=20
@@ -2235,30 +2142,6 @@ static void __init gic_populate_ppi_partitions(struct =
device_node *gic_node)
 	gic_data.parts =3D parts;
 	gic_data.nr_parts =3D nr_parts;
=20
-	for (i =3D 0; i < gic_data.ppi_nr; i++) {
-		unsigned int irq;
-		struct partition_desc *desc;
-		struct irq_fwspec ppi_fwspec =3D {
-			.fwnode		=3D gic_data.fwnode,
-			.param_count	=3D 3,
-			.param		=3D {
-				[0]	=3D GIC_IRQ_TYPE_PARTITION,
-				[1]	=3D i,
-				[2]	=3D IRQ_TYPE_NONE,
-			},
-		};
-
-		irq =3D irq_create_fwspec_mapping(&ppi_fwspec);
-		if (WARN_ON(!irq))
-			continue;
-		desc =3D partition_create_desc(gic_data.fwnode, parts, nr_parts,
-					     irq, &partition_domain_ops);
-		if (WARN_ON(!desc))
-			continue;
-
-		gic_data.ppi_descs[i] =3D desc;
-	}
-
 out_put_node:
 	of_node_put(parts_node);
 }

