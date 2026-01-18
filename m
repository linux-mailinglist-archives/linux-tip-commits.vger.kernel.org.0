Return-Path: <linux-tip-commits+bounces-8056-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCB60D393D5
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 11:10:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 84209302410A
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 10:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2790F2DCF52;
	Sun, 18 Jan 2026 10:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qTudMp9I";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aNR7ew/v"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F198A2D9EE7;
	Sun, 18 Jan 2026 10:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768730962; cv=none; b=QVfMy4Q63Yd7Nnvg4+2fOroaJFWe50lxl9tII6A4vXH2nS29ETP+RN8M1B4Q4FICHFc8TskHJ0p+kn8k22tFFI8/Lcs33Lo56G8u3GejITeVGPoh4xve3NnQ7eZBYpH2e2QHDcI5+6rC9nD4d6Dr5X/P+M3u5+Ao5+YJi/Cnz3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768730962; c=relaxed/simple;
	bh=c9qv587yO3ZWP6PPO9Ugn0/YeRPrWiYLA0m+JJG57nM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Biv45qXmAhjhnjAMC02HehyHOFzSdD7WVNyzk9fW45rgnn9HKAsPSyz7M1XD+IVjzh/pwBhz1YxJ8Y6C/JvlCjgLIsTdUP4+kJaS0lOTKjUc9JLCEEuz2NsZSWBEob7imOHCHxZ2ZExBlZ2i287L9AZLQcnnK68uD6L9z/pK1uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qTudMp9I; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aNR7ew/v; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Jan 2026 10:09:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768730958;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HV5Fo2FVibsVrKi+xZh+BPD9smEpY7aas+D5MRWBnu0=;
	b=qTudMp9IufR47RRW7fCbqSrJhZfpa/llHCLovC6CbDULu1Z7PkCTxlKVVoUOwOUSAcbW2N
	4qnE+wZLuacyWgc2Fv7TaPwXloU6TXjbrIoCW4WhVFmzbpa3mZqVD985c7LtF0ie84d1Bg
	FyN1ZdwKSQBmJ2EyH1dwq9DG5IsUEuNpyUb9DKaJaYVe+DR1HWsbh1iwWal7MnN6CEL1be
	PDKjO/1262UyjkiaE5Tncq+IGz+IJu4WS2VxZkzPQr6RrD3/+uudqAVIptUcObiAt1mR+w
	nDfbynYZqWMBVkQbU0wtpOW0ZFFVI4qBdSnIInUcVnTnnCtOywI1pP/ncEGeBw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768730958;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HV5Fo2FVibsVrKi+xZh+BPD9smEpY7aas+D5MRWBnu0=;
	b=aNR7ew/vewqrjnfaHGSv+2SGvb5vH8rYemwJbOVFtTy5gEE/g2PPCH5v+TKaYADaRlP2Hf
	DNjadebGpF1AaHDA==
From: "tip-bot2 for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] irqchip/gic-v5: Add ACPI ITS probing
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260115-gicv5-host-acpi-v3-5-c13a9a150388@kernel.org>
References: <20260115-gicv5-host-acpi-v3-5-c13a9a150388@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176873095727.510.5088175276420947938.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     a11cd753c6a5a9e9842c40be1ce558886569748b
Gitweb:        https://git.kernel.org/tip/a11cd753c6a5a9e9842c40be1ce55888656=
9748b
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Thu, 15 Jan 2026 10:50:51 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 18 Jan 2026 11:07:57 +01:00

irqchip/gic-v5: Add ACPI ITS probing

On ACPI ARM64 systems the GICv5 ITS configuration and translate frames
are described in the MADT table.

Refactor the current GICv5 ITS driver code to share common functions
between ACPI and OF and implement ACPI probing in the GICv5 ITS driver.

Add iort_msi_xlate() to map a device ID and retrieve an MSI controller
fwnode node for ACPI systems and update pci_msi_map_rid_ctlr_node() to
use it in its ACPI code path.

Add the required functions to IORT code for deviceID retrieval and IRQ
domain registration and look-up so that the GICv5 ITS driver in an
ACPI based system can be successfully probed.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Link: https://patch.msgid.link/20260115-gicv5-host-acpi-v3-5-c13a9a150388@ker=
nel.org
---
 drivers/acpi/arm64/iort.c                |  98 ++++++++++++----
 drivers/irqchip/irq-gic-its-msi-parent.c |  39 +++----
 drivers/irqchip/irq-gic-v5-irs.c         |   7 +-
 drivers/irqchip/irq-gic-v5-its.c         | 132 +++++++++++++++++++++-
 drivers/pci/msi/irqdomain.c              |   2 +-
 include/linux/acpi_iort.h                |  10 +-
 include/linux/irqchip/arm-gic-v5.h       |   1 +-
 7 files changed, 244 insertions(+), 45 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index 65f0f56..ddd857f 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -595,45 +595,45 @@ u32 iort_msi_map_id(struct device *dev, u32 input_id)
 }
=20
 /**
- * iort_pmsi_get_dev_id() - Get the device id for a device
+ * iort_msi_xlate() - Map a MSI input ID for a device
  * @dev: The device for which the mapping is to be done.
- * @dev_id: The device ID found.
+ * @input_id: The device input ID.
+ * @fwnode: Pointer to store the fwnode.
  *
- * Returns: 0 for successful find a dev id, -ENODEV on error
+ * Returns: mapped MSI ID on success, input ID otherwise
+ *	    On success, the fwnode pointer is initialized to the MSI
+ *	    controller fwnode handle.
  */
-int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
+u32 iort_msi_xlate(struct device *dev, u32 input_id, struct fwnode_handle **=
fwnode)
 {
-	int i, index;
+	struct acpi_iort_its_group *its;
 	struct acpi_iort_node *node;
+	u32 dev_id;
=20
 	node =3D iort_find_dev_node(dev);
 	if (!node)
-		return -ENODEV;
+		return input_id;
=20
-	index =3D iort_get_id_mapping_index(node);
-	/* if there is a valid index, go get the dev_id directly */
-	if (index >=3D 0) {
-		if (iort_node_get_id(node, dev_id, index))
-			return 0;
-	} else {
-		for (i =3D 0; i < node->mapping_count; i++) {
-			if (iort_node_map_platform_id(node, dev_id,
-						      IORT_MSI_TYPE, i))
-				return 0;
-		}
-	}
+	node =3D iort_node_map_id(node, input_id, &dev_id, IORT_MSI_TYPE);
+	if (!node)
+		return input_id;
=20
-	return -ENODEV;
+	/* Move to ITS specific data */
+	its =3D (struct acpi_iort_its_group *)node->node_data;
+
+	*fwnode =3D iort_find_domain_token(its->identifiers[0]);
+
+	return dev_id;
 }
=20
-static int __maybe_unused iort_find_its_base(u32 its_id, phys_addr_t *base)
+int iort_its_translate_pa(struct fwnode_handle *node, phys_addr_t *base)
 {
 	struct iort_its_msi_chip *its_msi_chip;
 	int ret =3D -ENODEV;
=20
 	spin_lock(&iort_msi_chip_lock);
 	list_for_each_entry(its_msi_chip, &iort_msi_chip_list, list) {
-		if (its_msi_chip->translation_id =3D=3D its_id) {
+		if (its_msi_chip->fw_node =3D=3D node) {
 			*base =3D its_msi_chip->base_addr;
 			ret =3D 0;
 			break;
@@ -644,6 +644,62 @@ static int __maybe_unused iort_find_its_base(u32 its_id,=
 phys_addr_t *base)
 	return ret;
 }
=20
+static int __maybe_unused iort_find_its_base(u32 its_id, phys_addr_t *base)
+{
+	struct fwnode_handle *fwnode =3D iort_find_domain_token(its_id);
+
+	if (!fwnode)
+		return -ENODEV;
+
+	return iort_its_translate_pa(fwnode, base);
+}
+
+/**
+ * iort_pmsi_get_msi_info() - Get the device id and translate frame PA for a=
 device
+ * @dev: The device for which the mapping is to be done.
+ * @dev_id: The device ID found.
+ * @pa: optional pointer to store translate frame address.
+ *
+ * Returns: 0 for successful devid and pa retrieval, -ENODEV on error
+ */
+int iort_pmsi_get_msi_info(struct device *dev, u32 *dev_id, phys_addr_t *pa)
+{
+	struct acpi_iort_node *node, *parent =3D NULL;
+	struct acpi_iort_its_group *its;
+	int i, index;
+
+	node =3D iort_find_dev_node(dev);
+	if (!node)
+		return -ENODEV;
+
+	index =3D iort_get_id_mapping_index(node);
+	/* if there is a valid index, go get the dev_id directly */
+	if (index >=3D 0) {
+		parent =3D iort_node_get_id(node, dev_id, index);
+	} else {
+		for (i =3D 0; i < node->mapping_count; i++) {
+			parent =3D iort_node_map_platform_id(node, dev_id,
+						      IORT_MSI_TYPE, i);
+			if (parent)
+				break;
+		}
+	}
+
+	if (!parent)
+		return -ENODEV;
+
+	if (pa) {
+		int ret;
+
+		its =3D (struct acpi_iort_its_group *)node->node_data;
+		ret =3D iort_find_its_base(its->identifiers[0], pa);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
 /**
  * iort_dev_find_its_id() - Find the ITS identifier for a device
  * @dev: The device.
diff --git a/drivers/irqchip/irq-gic-its-msi-parent.c b/drivers/irqchip/irq-g=
ic-its-msi-parent.c
index 4d1ad1e..a832cdb 100644
--- a/drivers/irqchip/irq-gic-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-its-msi-parent.c
@@ -19,18 +19,24 @@
 				 MSI_FLAG_PCI_MSIX      |	\
 				 MSI_FLAG_MULTI_PCI_MSI)
=20
-static int its_translate_frame_address(struct device_node *msi_node, phys_ad=
dr_t *pa)
+static int its_translate_frame_address(struct fwnode_handle *msi_node, phys_=
addr_t *pa)
 {
 	struct resource res;
 	int ret;
=20
-	ret =3D of_property_match_string(msi_node, "reg-names", "ns-translate");
-	if (ret < 0)
-		return ret;
+	if (is_of_node(msi_node)) {
+		struct device_node *msi_np =3D to_of_node(msi_node);
=20
-	ret =3D of_address_to_resource(msi_node, ret, &res);
-	if (ret)
-		return ret;
+		ret =3D of_property_match_string(msi_np, "reg-names", "ns-translate");
+		if (ret < 0)
+			return ret;
+
+		ret =3D of_address_to_resource(msi_np, ret, &res);
+		if (ret)
+			return ret;
+	} else {
+		ret =3D iort_its_translate_pa(msi_node, &res.start);
+	}
=20
 	*pa =3D res.start;
 	return 0;
@@ -120,7 +126,7 @@ static int its_v5_pci_msi_prepare(struct irq_domain *doma=
in, struct device *dev,
 	if (!msi_node)
 		return -ENODEV;
=20
-	ret =3D its_translate_frame_address(to_of_node(msi_node), &pa);
+	ret =3D its_translate_frame_address(msi_node, &pa);
 	if (ret)
 		return -ENODEV;
=20
@@ -161,7 +167,7 @@ static int of_pmsi_get_msi_info(struct irq_domain *domain=
, struct device *dev, u
 				ret =3D -EINVAL;
=20
 			if (!ret && pa)
-				ret =3D its_translate_frame_address(it.node, pa);
+				ret =3D its_translate_frame_address(of_fwnode_handle(it.node), pa);
=20
 			if (!ret)
 				*dev_id =3D args;
@@ -176,11 +182,6 @@ static int of_pmsi_get_msi_info(struct irq_domain *domai=
n, struct device *dev, u
 	return of_map_id(dev->of_node, dev->id, "msi-map", "msi-map-mask", &msi_ctr=
l, dev_id);
 }
=20
-int __weak iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id)
-{
-	return -1;
-}
-
 static int its_pmsi_prepare(struct irq_domain *domain, struct device *dev,
 			    int nvec, msi_alloc_info_t *info)
 {
@@ -191,7 +192,7 @@ static int its_pmsi_prepare(struct irq_domain *domain, st=
ruct device *dev,
 	if (dev->of_node)
 		ret =3D of_pmsi_get_msi_info(domain->parent, dev, &dev_id, NULL);
 	else
-		ret =3D iort_pmsi_get_dev_id(dev, &dev_id);
+		ret =3D iort_pmsi_get_msi_info(dev, &dev_id, NULL);
 	if (ret)
 		return ret;
=20
@@ -214,10 +215,10 @@ static int its_v5_pmsi_prepare(struct irq_domain *domai=
n, struct device *dev,
 	u32 dev_id;
 	int ret;
=20
-	if (!dev->of_node)
-		return -ENODEV;
-
-	ret =3D of_pmsi_get_msi_info(domain->parent, dev, &dev_id, &pa);
+	if (dev->of_node)
+		ret =3D of_pmsi_get_msi_info(domain->parent, dev, &dev_id, &pa);
+	else
+		ret =3D iort_pmsi_get_msi_info(dev, &dev_id, &pa);
 	if (ret)
 		return ret;
=20
diff --git a/drivers/irqchip/irq-gic-v5-irs.c b/drivers/irqchip/irq-gic-v5-ir=
s.c
index a27a01f..fcd032b 100644
--- a/drivers/irqchip/irq-gic-v5-irs.c
+++ b/drivers/irqchip/irq-gic-v5-irs.c
@@ -814,8 +814,11 @@ void __init gicv5_irs_its_probe(void)
 {
 	struct gicv5_irs_chip_data *irs_data;
=20
-	list_for_each_entry(irs_data, &irs_nodes, entry)
-		gicv5_its_of_probe(to_of_node(irs_data->fwnode));
+	if (acpi_disabled)
+		list_for_each_entry(irs_data, &irs_nodes, entry)
+			gicv5_its_of_probe(to_of_node(irs_data->fwnode));
+	else
+		gicv5_its_acpi_probe();
 }
=20
 int __init gicv5_irs_of_probe(struct device_node *parent)
diff --git a/drivers/irqchip/irq-gic-v5-its.c b/drivers/irqchip/irq-gic-v5-it=
s.c
index 554485f..8827207 100644
--- a/drivers/irqchip/irq-gic-v5-its.c
+++ b/drivers/irqchip/irq-gic-v5-its.c
@@ -5,6 +5,8 @@
=20
 #define pr_fmt(fmt)	"GICv5 ITS: " fmt
=20
+#include <linux/acpi.h>
+#include <linux/acpi_iort.h>
 #include <linux/bitmap.h>
 #include <linux/iommu.h>
 #include <linux/init.h>
@@ -1115,7 +1117,7 @@ static int gicv5_its_init_domain(struct gicv5_its_chip_=
data *its, struct irq_dom
 }
=20
 static int __init gicv5_its_init_bases(void __iomem *its_base, struct fwnode=
_handle *handle,
-				       struct irq_domain *parent_domain)
+				       struct irq_domain *parent_domain, bool noncoherent)
 {
 	struct device_node *np =3D to_of_node(handle);
 	struct gicv5_its_chip_data *its_node;
@@ -1208,7 +1210,8 @@ static int __init gicv5_its_init(struct device_node *no=
de)
 	}
=20
 	ret =3D gicv5_its_init_bases(its_base, of_fwnode_handle(node),
-				   gicv5_global_data.lpi_domain);
+				   gicv5_global_data.lpi_domain,
+				   of_property_read_bool(node, "dma-noncoherent"));
 	if (ret)
 		goto out_unmap;
=20
@@ -1231,3 +1234,128 @@ void __init gicv5_its_of_probe(struct device_node *pa=
rent)
 			pr_err("Failed to init ITS %s\n", np->full_name);
 	}
 }
+
+#ifdef CONFIG_ACPI
+
+#define ACPI_GICV5_ITS_MEM_SIZE (SZ_64K)
+
+static struct acpi_madt_gicv5_translator *current_its_entry __initdata;
+static struct fwnode_handle *current_its_fwnode __initdata;
+
+static int __init gic_acpi_parse_madt_its_translate(union acpi_subtable_head=
ers *header,
+						    const unsigned long end)
+{
+	struct acpi_madt_gicv5_translate_frame *its_frame;
+	struct fwnode_handle *msi_dom_handle;
+	struct resource res =3D {};
+	int err;
+
+	its_frame =3D (struct acpi_madt_gicv5_translate_frame *)header;
+	if (its_frame->linked_translator_id !=3D current_its_entry->translator_id)
+		return 0;
+
+	res.start =3D its_frame->base_address;
+	res.end =3D its_frame->base_address + ACPI_GICV5_ITS_MEM_SIZE - 1;
+	res.flags =3D IORESOURCE_MEM;
+
+	msi_dom_handle =3D irq_domain_alloc_parented_fwnode(&res.start, current_its=
_fwnode);
+	if (!msi_dom_handle) {
+		pr_err("ITS@%pa: Unable to allocate GICv5 ITS translate domain token\n",
+		       &res.start);
+		return -ENOMEM;
+	}
+
+	err =3D iort_register_domain_token(its_frame->translate_frame_id, res.start,
+					 msi_dom_handle);
+	if (err) {
+		pr_err("ITS@%pa: Unable to register GICv5 ITS domain token (ITS TRANSLATE =
FRAME ID %d) to IORT\n",
+		       &res.start, its_frame->translate_frame_id);
+		irq_domain_free_fwnode(msi_dom_handle);
+		return err;
+	}
+
+	return 0;
+}
+
+static int __init gic_acpi_free_madt_its_translate(union acpi_subtable_heade=
rs *header,
+						   const unsigned long end)
+{
+	struct acpi_madt_gicv5_translate_frame *its_frame;
+	struct fwnode_handle *msi_dom_handle;
+
+	its_frame =3D (struct acpi_madt_gicv5_translate_frame *)header;
+	if (its_frame->linked_translator_id !=3D current_its_entry->translator_id)
+		return 0;
+
+	msi_dom_handle =3D iort_find_domain_token(its_frame->translate_frame_id);
+	if (!msi_dom_handle)
+		return 0;
+
+	iort_deregister_domain_token(its_frame->translate_frame_id);
+	irq_domain_free_fwnode(msi_dom_handle);
+
+	return 0;
+}
+
+static int __init gic_acpi_parse_madt_its(union acpi_subtable_headers *heade=
r,
+					  const unsigned long end)
+{
+	struct acpi_madt_gicv5_translator *its_entry;
+	struct fwnode_handle *dom_handle;
+	struct resource res =3D {};
+	void __iomem *its_base;
+	int err;
+
+	its_entry =3D (struct acpi_madt_gicv5_translator *)header;
+	res.start =3D its_entry->base_address;
+	res.end =3D its_entry->base_address + ACPI_GICV5_ITS_MEM_SIZE - 1;
+	res.flags =3D IORESOURCE_MEM;
+
+	if (!request_mem_region(res.start, resource_size(&res), "GICv5 ITS"))
+		return -EBUSY;
+
+	dom_handle =3D irq_domain_alloc_fwnode(&res.start);
+	if (!dom_handle) {
+		pr_err("ITS@%pa: Unable to allocate GICv5 ITS domain token\n",
+		       &res.start);
+		err =3D -ENOMEM;
+		goto out_rel_res;
+	}
+
+	current_its_entry =3D its_entry;
+	current_its_fwnode =3D dom_handle;
+
+	acpi_table_parse_madt(ACPI_MADT_TYPE_GICV5_ITS_TRANSLATE,
+			      gic_acpi_parse_madt_its_translate, 0);
+
+	its_base =3D ioremap(res.start, ACPI_GICV5_ITS_MEM_SIZE);
+	if (!its_base) {
+		err =3D -ENOMEM;
+		goto out_unregister;
+	}
+
+	err =3D gicv5_its_init_bases(its_base, dom_handle, gicv5_global_data.lpi_do=
main,
+				   its_entry->flags & ACPI_MADT_GICV5_ITS_NON_COHERENT);
+	if (err)
+		goto out_unmap;
+
+	return 0;
+
+out_unmap:
+	iounmap(its_base);
+out_unregister:
+	acpi_table_parse_madt(ACPI_MADT_TYPE_GICV5_ITS_TRANSLATE,
+			      gic_acpi_free_madt_its_translate, 0);
+	irq_domain_free_fwnode(dom_handle);
+out_rel_res:
+	release_mem_region(res.start, resource_size(&res));
+	return err;
+}
+
+void __init gicv5_its_acpi_probe(void)
+{
+	acpi_table_parse_madt(ACPI_MADT_TYPE_GICV5_ITS, gic_acpi_parse_madt_its, 0);
+}
+#else
+void __init gicv5_its_acpi_probe(void) { }
+#endif
diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index 3a40386..6e65f0f 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -401,6 +401,8 @@ u32 pci_msi_map_rid_ctlr_node(struct irq_domain *domain, =
struct pci_dev *pdev,
 		rid =3D of_msi_xlate(&pdev->dev, &msi_ctlr_node, rid);
 		if (msi_ctlr_node)
 			*node =3D of_fwnode_handle(msi_ctlr_node);
+	} else {
+		rid =3D iort_msi_xlate(&pdev->dev, rid, node);
 	}
=20
 	return rid;
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index d4ed562..2d22268 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -27,12 +27,14 @@ int iort_register_domain_token(int trans_id, phys_addr_t =
base,
 			       struct fwnode_handle *fw_node);
 void iort_deregister_domain_token(int trans_id);
 struct fwnode_handle *iort_find_domain_token(int trans_id);
-int iort_pmsi_get_dev_id(struct device *dev, u32 *dev_id);
=20
 #ifdef CONFIG_ACPI_IORT
 u32 iort_msi_map_id(struct device *dev, u32 id);
+u32 iort_msi_xlate(struct device *dev, u32 id, struct fwnode_handle **node);
+int iort_its_translate_pa(struct fwnode_handle *node, phys_addr_t *base);
 struct irq_domain *iort_get_device_domain(struct device *dev, u32 id,
 					  enum irq_domain_bus_token bus_token);
+int iort_pmsi_get_msi_info(struct device *dev, u32 *dev_id, phys_addr_t *pa);
 void acpi_configure_pmsi_domain(struct device *dev);
 void iort_get_rmr_sids(struct fwnode_handle *iommu_fwnode,
 		       struct list_head *head);
@@ -46,9 +48,15 @@ phys_addr_t acpi_iort_dma_get_max_cpu_address(void);
 #else
 static inline u32 iort_msi_map_id(struct device *dev, u32 id)
 { return id; }
+static inline u32 iort_msi_xlate(struct device *dev, u32 id, struct fwnode_h=
andle **node)
+{ return id; }
+static inline int iort_its_translate_pa(struct fwnode_handle *node, phys_add=
r_t *base)
+{ return -ENODEV; }
 static inline struct irq_domain *iort_get_device_domain(
 	struct device *dev, u32 id, enum irq_domain_bus_token bus_token)
 { return NULL; }
+static inline int iort_pmsi_get_msi_info(struct device *dev, u32 *dev_id, ph=
ys_addr_t *pa)
+{ return -ENODEV; }
 static inline void acpi_configure_pmsi_domain(struct device *dev) { }
 static inline
 void iort_get_rmr_sids(struct fwnode_handle *iommu_fwnode, struct list_head =
*head) { }
diff --git a/include/linux/irqchip/arm-gic-v5.h b/include/linux/irqchip/arm-g=
ic-v5.h
index ff5b1a4..334b698 100644
--- a/include/linux/irqchip/arm-gic-v5.h
+++ b/include/linux/irqchip/arm-gic-v5.h
@@ -392,4 +392,5 @@ int gicv5_alloc_lpi(void);
 void gicv5_free_lpi(u32 lpi);
=20
 void __init gicv5_its_of_probe(struct device_node *parent);
+void __init gicv5_its_acpi_probe(void);
 #endif

