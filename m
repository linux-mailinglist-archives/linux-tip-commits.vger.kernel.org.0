Return-Path: <linux-tip-commits+bounces-8057-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AEC29D393D7
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 11:10:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 94DCD3029B9D
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 10:09:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4DBE92DCF52;
	Sun, 18 Jan 2026 10:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gLvL1YDr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oVK1tDvJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40F802DC786;
	Sun, 18 Jan 2026 10:09:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768730963; cv=none; b=lmeDcdbeciJtKareDxZs+gLpNOvcket89LHecHVUDoRBxkJnD8C2J7IYtzFEukmS4B4ldOhmna5yC29I3654ygCMtGlRwQRoG2SXRAVnymeBPCXCIr/fHczTLpu+Yr28MAfhLuEo4h57vVMj0Pvoi0+K+eYqWaNwxG7HZ2rAbHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768730963; c=relaxed/simple;
	bh=RUcvw4QJ4ONyEznZUMDYqFTYjgH1jHP2aHLDnYGfSk4=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gaz4WuG9uhL41f4l4H6x34tsLeVZuTR55zvcH1qmF4xzmgRtnzbMPatRAyjdP6Gf60dIQOMYLYYu9E43Ns4SEiylgwTvjL9QreNmBnexwIxQe1tFyBLKTgRvY99F010ccH2vGrIE/Z5uKbuQoY9dz37zd+niucgQm/GhE4pWvAU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gLvL1YDr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oVK1tDvJ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Jan 2026 10:09:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768730959;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ytkCmOIKy0ob6q4junhHsKcjiVuRJOapF+pJHcJOELM=;
	b=gLvL1YDrXwfrx9OeY2xpcQNcC+6cpAEaUdg7yfeF/XyGbVbYC49hwW+Y7CeF9GQUo6euzU
	DrxrXo3KGkB3ozpcged1MFsHGqsT6PAn/wVbPcnDfk/O+hfFEsNYEUNcZt7t0ARRYk/6MU
	UdjTlGruWFQAWXV7ayL9ARJ319euV+s5V1P+3oqdZvWruXulORI1Qc3pto1JBNCL5T4uLO
	ZvVTSwutkD0SYUkWKKpblZMY2Jl8MRfEsbNaBh3yGbw70I+zf862YjEFouCJNmHCPEU780
	hUNH4XvSccsoQPoCb/C/aawgb+jiZhOtzi6QByQvhPyvEUAQj64kNHf63kAEiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768730959;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ytkCmOIKy0ob6q4junhHsKcjiVuRJOapF+pJHcJOELM=;
	b=oVK1tDvJoHaqHivGxtnqRmUd4b6eoCr2z4rJNmSX0wde4UfB0xx4vgLInHkUH5RHoCWcMF
	Oc6U2GZ5aEUqFBAQ==
From: "tip-bot2 for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] irqchip/gic-v5: Add ACPI IRS probing
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260115-gicv5-host-acpi-v3-4-c13a9a150388@kernel.org>
References: <20260115-gicv5-host-acpi-v3-4-c13a9a150388@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176873095848.510.6068532504180713918.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     45390d1e4a017c0a3b8a4ff63198de7fdf27295e
Gitweb:        https://git.kernel.org/tip/45390d1e4a017c0a3b8a4ff63198de7fdf2=
7295e
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Thu, 15 Jan 2026 10:50:50 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 18 Jan 2026 11:07:57 +01:00

irqchip/gic-v5: Add ACPI IRS probing

On ARM64 ACPI systems GICv5 IRSes are described in MADT sub-entries.

Add the required plumbing to parse MADT IRS firmware table entries and
probe the IRS components in ACPI.

Augment the irqdomain_ops.translate() for PPI and SPI IRQs in order to
provide support for their ACPI based firmware translation.

Implement an irqchip ACPI based callback to initialize the global GSI
domain upon an MADT IRS detection.

The IRQCHIP_ACPI_DECLARE() entry in the top level GICv5 driver is only used
to trigger the IRS probing (ie the global GSI domain is initialized once on
the first call on multi-IRS systems); IRS probing takes place by calling
acpi_table_parse_madt() in the IRS sub-driver, that probes all IRSes
in sequence.

Add a new ACPI interrupt model so that it can be detected at runtime and
distinguished from previous GIC architecture models.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Link: https://patch.msgid.link/20260115-gicv5-host-acpi-v3-4-c13a9a150388@ker=
nel.org
---
 drivers/acpi/bus.c                 |   3 +-
 drivers/irqchip/irq-gic-v5-irs.c   | 128 +++++++++++++++++++++++++++-
 drivers/irqchip/irq-gic-v5.c       | 134 ++++++++++++++++++++++++----
 include/linux/acpi.h               |   1 +-
 include/linux/irqchip/arm-gic-v5.h |   1 +-
 5 files changed, 248 insertions(+), 19 deletions(-)

diff --git a/drivers/acpi/bus.c b/drivers/acpi/bus.c
index a984ccd..e4f4059 100644
--- a/drivers/acpi/bus.c
+++ b/drivers/acpi/bus.c
@@ -1197,6 +1197,9 @@ static int __init acpi_bus_init_irq(void)
 	case ACPI_IRQ_MODEL_GIC:
 		message =3D "GIC";
 		break;
+	case ACPI_IRQ_MODEL_GIC_V5:
+		message =3D "GICv5";
+		break;
 	case ACPI_IRQ_MODEL_PLATFORM:
 		message =3D "platform specific model";
 		break;
diff --git a/drivers/irqchip/irq-gic-v5-irs.c b/drivers/irqchip/irq-gic-v5-ir=
s.c
index 7db44a9..a27a01f 100644
--- a/drivers/irqchip/irq-gic-v5-irs.c
+++ b/drivers/irqchip/irq-gic-v5-irs.c
@@ -5,6 +5,7 @@
=20
 #define pr_fmt(fmt)	"GICv5 IRS: " fmt
=20
+#include <linux/acpi.h>
 #include <linux/kmemleak.h>
 #include <linux/log2.h>
 #include <linux/of.h>
@@ -833,3 +834,130 @@ int __init gicv5_irs_of_probe(struct device_node *paren=
t)
=20
 	return list_empty(&irs_nodes) ? -ENODEV : 0;
 }
+
+#ifdef CONFIG_ACPI
+
+#define ACPI_GICV5_IRS_MEM_SIZE (SZ_64K)
+static struct gicv5_irs_chip_data *current_irs_data __initdata;
+static int current_irsid __initdata =3D -1;
+static u8 current_iaffid_bits __initdata;
+
+static int __init gic_acpi_parse_iaffid(union acpi_subtable_headers *header,
+					const unsigned long end)
+{
+	struct acpi_madt_generic_interrupt *gicc =3D (struct acpi_madt_generic_inte=
rrupt *)header;
+	int cpu;
+
+	if (!(gicc->flags & (ACPI_MADT_ENABLED | ACPI_MADT_GICC_ONLINE_CAPABLE)))
+		return 0;
+
+	if (gicc->irs_id !=3D current_irsid)
+		return 0;
+
+	cpu =3D get_logical_index(gicc->arm_mpidr);
+
+	if (gicc->iaffid & ~GENMASK(current_iaffid_bits - 1, 0)) {
+		pr_warn("CPU %d iaffid 0x%x exceeds IRS iaffid bits\n", cpu, gicc->iaffid);
+		return 0;
+	}
+
+	/* Bind the IAFFID and the CPU */
+	per_cpu(cpu_iaffid, cpu).iaffid =3D gicc->iaffid;
+	per_cpu(cpu_iaffid, cpu).valid =3D true;
+	pr_debug("Processed IAFFID %u for CPU%d", per_cpu(cpu_iaffid, cpu).iaffid, =
cpu);
+
+	/* We also know that the CPU is connected to this IRS */
+	per_cpu(per_cpu_irs_data, cpu) =3D current_irs_data;
+
+	return 0;
+}
+
+static int __init gicv5_irs_acpi_init_affinity(u32 irsid, struct gicv5_irs_c=
hip_data *irs_data)
+{
+	u32 idr;
+
+	current_irsid =3D irsid;
+	current_irs_data =3D irs_data;
+
+	idr =3D irs_readl_relaxed(irs_data, GICV5_IRS_IDR1);
+	current_iaffid_bits =3D FIELD_GET(GICV5_IRS_IDR1_IAFFID_BITS, idr) + 1;
+
+	acpi_table_parse_madt(ACPI_MADT_TYPE_GENERIC_INTERRUPT, gic_acpi_parse_iaff=
id, 0);
+
+	return 0;
+}
+
+static struct resource * __init gic_request_region(resource_size_t base, res=
ource_size_t size,
+						   const char *name)
+{
+	struct resource *r =3D request_mem_region(base, size, name);
+
+	if (!r)
+		pr_warn_once(FW_BUG "%s region %pa has overlapping address\n", name, &base=
);
+
+	return r;
+}
+
+static int __init gic_acpi_parse_madt_irs(union acpi_subtable_headers *heade=
r,
+					  const unsigned long end)
+{
+	struct acpi_madt_gicv5_irs *irs =3D (struct acpi_madt_gicv5_irs *)header;
+	struct gicv5_irs_chip_data *irs_data;
+	void __iomem *irs_base;
+	struct resource *r;
+	int ret;
+
+	/* Per-IRS data structure */
+	irs_data =3D kzalloc(sizeof(*irs_data), GFP_KERNEL);
+	if (!irs_data)
+		return -ENOMEM;
+
+	/* This spinlock is used for SPI config changes */
+	raw_spin_lock_init(&irs_data->spi_config_lock);
+
+	r =3D gic_request_region(irs->config_base_address, ACPI_GICV5_IRS_MEM_SIZE,=
 "GICv5 IRS");
+	if (!r) {
+		ret =3D -EBUSY;
+		goto out_free;
+	}
+
+	irs_base =3D ioremap(irs->config_base_address, ACPI_GICV5_IRS_MEM_SIZE);
+	if (!irs_base) {
+		pr_err("Unable to map GIC IRS registers\n");
+		ret =3D -ENOMEM;
+		goto out_release;
+	}
+
+	gicv5_irs_init_bases(irs_data, irs_base, irs->flags & ACPI_MADT_IRS_NON_COH=
ERENT);
+
+	gicv5_irs_acpi_init_affinity(irs->irs_id, irs_data);
+
+	ret =3D gicv5_irs_init(irs_data);
+	if (ret)
+		goto out_map;
+
+	if (irs_data->spi_range) {
+		pr_info("%s @%llx detected SPI range [%u-%u]\n", "IRS", irs->config_base_a=
ddress,
+									irs_data->spi_min,
+									irs_data->spi_min +
+									irs_data->spi_range - 1);
+	}
+
+	return 0;
+
+out_map:
+	iounmap(irs_base);
+out_release:
+	release_mem_region(r->start, resource_size(r));
+out_free:
+	kfree(irs_data);
+	return ret;
+}
+
+int __init gicv5_irs_acpi_probe(void)
+{
+	acpi_table_parse_madt(ACPI_MADT_TYPE_GICV5_IRS, gic_acpi_parse_madt_irs, 0);
+
+	return list_empty(&irs_nodes) ? -ENODEV : 0;
+}
+#endif
diff --git a/drivers/irqchip/irq-gic-v5.c b/drivers/irqchip/irq-gic-v5.c
index 41ef286..23fd551 100644
--- a/drivers/irqchip/irq-gic-v5.c
+++ b/drivers/irqchip/irq-gic-v5.c
@@ -579,16 +579,36 @@ static __always_inline int gicv5_irq_domain_translate(s=
truct irq_domain *d,
 						      unsigned int *type,
 						      const u8 hwirq_type)
 {
-	if (!is_of_node(fwspec->fwnode))
-		return -EINVAL;
+	unsigned int hwirq_trigger;
+	u8 fwspec_irq_type;
=20
-	if (fwspec->param_count < 3)
-		return -EINVAL;
+	if (is_of_node(fwspec->fwnode)) {
=20
-	if (fwspec->param[0] !=3D hwirq_type)
-		return -EINVAL;
+		if (fwspec->param_count < 3)
+			return -EINVAL;
+
+		fwspec_irq_type =3D fwspec->param[0];
+
+		if (fwspec->param[0] !=3D hwirq_type)
+			return -EINVAL;
+
+		*hwirq =3D fwspec->param[1];
+		hwirq_trigger =3D fwspec->param[2];
+	}
+
+	if (is_fwnode_irqchip(fwspec->fwnode)) {
+
+		if (fwspec->param_count !=3D 2)
+			return -EINVAL;
=20
-	*hwirq =3D fwspec->param[1];
+		fwspec_irq_type =3D FIELD_GET(GICV5_HWIRQ_TYPE, fwspec->param[0]);
+
+		if (fwspec_irq_type !=3D hwirq_type)
+			return -EINVAL;
+
+		*hwirq =3D FIELD_GET(GICV5_HWIRQ_ID, fwspec->param[0]);
+		hwirq_trigger =3D fwspec->param[1];
+	}
=20
 	switch (hwirq_type) {
 	case GICV5_HWIRQ_TYPE_PPI:
@@ -600,7 +620,7 @@ static __always_inline int gicv5_irq_domain_translate(str=
uct irq_domain *d,
 							 IRQ_TYPE_EDGE_RISING;
 		break;
 	case GICV5_HWIRQ_TYPE_SPI:
-		*type =3D fwspec->param[2] & IRQ_TYPE_SENSE_MASK;
+		*type =3D hwirq_trigger & IRQ_TYPE_SENSE_MASK;
 		break;
 	default:
 		BUILD_BUG_ON(1);
@@ -660,10 +680,18 @@ static void gicv5_irq_domain_free(struct irq_domain *do=
main, unsigned int virq,
 static int gicv5_irq_ppi_domain_select(struct irq_domain *d, struct irq_fwsp=
ec *fwspec,
 				       enum irq_domain_bus_token bus_token)
 {
+	u32 hwirq_type;
+
 	if (fwspec->fwnode !=3D d->fwnode)
 		return 0;
=20
-	if (fwspec->param[0] !=3D GICV5_HWIRQ_TYPE_PPI)
+	if (is_of_node(fwspec->fwnode))
+		hwirq_type =3D fwspec->param[0];
+
+	if (is_fwnode_irqchip(fwspec->fwnode))
+		hwirq_type =3D FIELD_GET(GICV5_HWIRQ_TYPE, fwspec->param[0]);
+
+	if (hwirq_type !=3D GICV5_HWIRQ_TYPE_PPI)
 		return 0;
=20
 	return (d =3D=3D gicv5_global_data.ppi_domain);
@@ -718,10 +746,18 @@ static int gicv5_irq_spi_domain_alloc(struct irq_domain=
 *domain, unsigned int vi
 static int gicv5_irq_spi_domain_select(struct irq_domain *d, struct irq_fwsp=
ec *fwspec,
 				       enum irq_domain_bus_token bus_token)
 {
+	u32 hwirq_type;
+
 	if (fwspec->fwnode !=3D d->fwnode)
 		return 0;
=20
-	if (fwspec->param[0] !=3D GICV5_HWIRQ_TYPE_SPI)
+	if (is_of_node(fwspec->fwnode))
+		hwirq_type =3D fwspec->param[0];
+
+	if (is_fwnode_irqchip(fwspec->fwnode))
+		hwirq_type =3D FIELD_GET(GICV5_HWIRQ_TYPE, fwspec->param[0]);
+
+	if (hwirq_type !=3D GICV5_HWIRQ_TYPE_SPI)
 		return 0;
=20
 	return (d =3D=3D gicv5_global_data.spi_domain);
@@ -1082,16 +1118,12 @@ static inline void __init gic_of_setup_kvm_info(struc=
t device_node *node)
 }
 #endif // CONFIG_KVM
=20
-static int __init gicv5_of_init(struct device_node *node, struct device_node=
 *parent)
+static int __init gicv5_init_common(struct fwnode_handle *parent_domain)
 {
-	int ret =3D gicv5_irs_of_probe(node);
+	int ret =3D gicv5_init_domains(parent_domain);
 	if (ret)
 		return ret;
=20
-	ret =3D gicv5_init_domains(of_fwnode_handle(node));
-	if (ret)
-		goto out_irs;
-
 	gicv5_set_cpuif_pribits();
 	gicv5_set_cpuif_idbits();
=20
@@ -1113,18 +1145,82 @@ static int __init gicv5_of_init(struct device_node *n=
ode, struct device_node *pa
 	gicv5_smp_init();
=20
 	gicv5_irs_its_probe();
-
-	gic_of_setup_kvm_info(node);
-
 	return 0;
=20
 out_int:
 	gicv5_cpu_disable_interrupts();
 out_dom:
 	gicv5_free_domains();
+	return ret;
+}
+
+static int __init gicv5_of_init(struct device_node *node, struct device_node=
 *parent)
+{
+	int ret =3D gicv5_irs_of_probe(node);
+	if (ret)
+		return ret;
+
+	ret =3D gicv5_init_common(of_fwnode_handle(node));
+	if (ret)
+		goto out_irs;
+
+	gic_of_setup_kvm_info(node);
+
+	return 0;
 out_irs:
 	gicv5_irs_remove();
=20
 	return ret;
 }
 IRQCHIP_DECLARE(gic_v5, "arm,gic-v5", gicv5_of_init);
+
+#ifdef CONFIG_ACPI
+static bool __init acpi_validate_gic_table(struct acpi_subtable_header *head=
er,
+					   struct acpi_probe_entry *ape)
+{
+	struct acpi_madt_gicv5_irs *irs =3D (struct acpi_madt_gicv5_irs *)header;
+
+	return (irs->version =3D=3D ape->driver_data);
+}
+
+static struct fwnode_handle *gsi_domain_handle;
+
+static struct fwnode_handle *gic_v5_get_gsi_domain_id(u32 gsi)
+{
+	return gsi_domain_handle;
+}
+
+static int __init gic_acpi_init(union acpi_subtable_headers *header, const u=
nsigned long end)
+{
+	struct acpi_madt_gicv5_irs *irs =3D (struct acpi_madt_gicv5_irs *)header;
+	int ret;
+
+	if (gsi_domain_handle)
+		return 0;
+
+	gsi_domain_handle =3D irq_domain_alloc_fwnode(&irs->config_base_address);
+	if (!gsi_domain_handle)
+		return -ENOMEM;
+
+	ret =3D gicv5_irs_acpi_probe();
+	if (ret)
+		goto out_fwnode;
+
+	ret =3D gicv5_init_common(gsi_domain_handle);
+	if (ret)
+		goto out_irs;
+
+	acpi_set_irq_model(ACPI_IRQ_MODEL_GIC_V5, gic_v5_get_gsi_domain_id);
+
+	return 0;
+
+out_irs:
+	gicv5_irs_remove();
+out_fwnode:
+	irq_domain_free_fwnode(gsi_domain_handle);
+	return ret;
+}
+IRQCHIP_ACPI_DECLARE(gic_v5, ACPI_MADT_TYPE_GICV5_IRS,
+		     acpi_validate_gic_table, ACPI_MADT_GIC_VERSION_V5,
+		     gic_acpi_init);
+#endif
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index fbf0c3a..3a412dc 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -107,6 +107,7 @@ enum acpi_irq_model_id {
 	ACPI_IRQ_MODEL_IOSAPIC,
 	ACPI_IRQ_MODEL_PLATFORM,
 	ACPI_IRQ_MODEL_GIC,
+	ACPI_IRQ_MODEL_GIC_V5,
 	ACPI_IRQ_MODEL_LPIC,
 	ACPI_IRQ_MODEL_RINTC,
 	ACPI_IRQ_MODEL_COUNT
diff --git a/include/linux/irqchip/arm-gic-v5.h b/include/linux/irqchip/arm-g=
ic-v5.h
index 68ddcdb..ff5b1a4 100644
--- a/include/linux/irqchip/arm-gic-v5.h
+++ b/include/linux/irqchip/arm-gic-v5.h
@@ -344,6 +344,7 @@ void __init gicv5_init_lpi_domain(void);
 void __init gicv5_free_lpi_domain(void);
=20
 int gicv5_irs_of_probe(struct device_node *parent);
+int gicv5_irs_acpi_probe(void);
 void gicv5_irs_remove(void);
 int gicv5_irs_enable(void);
 void gicv5_irs_its_probe(void);

