Return-Path: <linux-tip-commits+bounces-8055-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CB9DD393D0
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 11:09:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8F48A3002D10
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Jan 2026 10:09:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0CD32DAFD2;
	Sun, 18 Jan 2026 10:09:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="A1vCwejc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="isSs+XdU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0021E1DB356;
	Sun, 18 Jan 2026 10:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768730960; cv=none; b=YwBLrIhwsCkT96Ra5kj0Cf040pYyFwvLk3TDaA0IY4d9UF5L6+GxW0r7T+OQOj1ObJxCni0bvm/a931O/8nlyWtZ7oNDyW5Ha1UxOi/OcqNqp11jw5h8bRpe48OaPgC8bCbAo+QXR3grZPNfxaLlwCoD9pRvvxmeH5ODZzCXS8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768730960; c=relaxed/simple;
	bh=lTUxqkdX3uGW+RBbnf1BA+ifP/ZnPGFyHQkY/gIhEZM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=prm0VbK405KZWeEDNFZ+TRdDrlXfi3vtF6G7RqDibno8cWA0/4EFvEo/nBQ/k5tMrQDlEwkGqnUi1fQ5ihpzgVe5JTU7yCzm1UwrK4ekq5zzzaTWMe9qbE3sdm3DW0e6xtKjEse6DEbVO8GEZoyuI3rSAoApfu7lZ1E3I2HF0sY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=A1vCwejc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=isSs+XdU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Jan 2026 10:09:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768730957;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UM1uOGjK2G2u/KhxNzSjyaXOM/Fy7s3uCdK1vmndFu8=;
	b=A1vCwejcQDOc8a7N/kkfc85WH32c0yensJ8+Ly6hkji4vS0bO91hBfU3X35o1Rl/xrqjt7
	QfnteOyHijPA2KgydivFgCSMf64KBiSXFDzgl9B2VTHVLd4PMqeRx4meUG3KkkyEyucWML
	GgdEePXv/xAyAbFaBNDHFYsSDL6uSlJ19UcxluaCLbD9nM3+YjlhhGCg/Je7We5Qi2AzBE
	XNPyjF+I16v+RvBq/IfhIJyOJY0lL+W/gbwrto33egxjUFTN2tk6eTCgdR3WSBCuOcTqoB
	IEpr0VTI/vUm0dVIuElE6gQ+M7kUEpFFZWcNU528TDy2+thILN1Ca6Z0OtoHVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768730957;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UM1uOGjK2G2u/KhxNzSjyaXOM/Fy7s3uCdK1vmndFu8=;
	b=isSs+XdUJhUbg4/CPQlyyOlbce4wp/qnXqJLYtU55WTwJaDnbCZZgwfaXftQJKWi8f+pyS
	tl68+wpoHOCWD0DA==
From: "tip-bot2 for Lorenzo Pieralisi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] irqchip/gic-v5: Add ACPI IWB probing
Cc: Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Thomas Gleixner <tglx@kernel.org>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20260115-gicv5-host-acpi-v3-6-c13a9a150388@kernel.org>
References: <20260115-gicv5-host-acpi-v3-6-c13a9a150388@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176873095581.510.7622768277858047385.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     7bf647e73d9a63c5e1aa28717d5cb94037d8e3a0
Gitweb:        https://git.kernel.org/tip/7bf647e73d9a63c5e1aa28717d5cb94037d=
8e3a0
Author:        Lorenzo Pieralisi <lpieralisi@kernel.org>
AuthorDate:    Thu, 15 Jan 2026 10:50:52 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Sun, 18 Jan 2026 11:07:58 +01:00

irqchip/gic-v5: Add ACPI IWB probing

To probe an IWB in an ACPI based system it is required:

 - to implement the IORT functions handling the IWB IORT node and create
   functions to retrieve IWB firmware information
 - to augment the driver to match the DSDT ACPI "ARMH0003" device and
   retrieve the IWB wire and trigger mask from the GSI interrupt descriptor
   in the IWB msi_domain_ops.msi_translate() function

Make the required driver changes to enable IWB probing in ACPI systems.

The GICv5 GSI format requires special handling for IWB routed interrupts.

Add IWB GSI detection to the top level driver gic_v5_get_gsi_domain_id()
function so that the correct interrupt domain for a GSI can be detected by
parsing the GSI and checking whether it is an IWB-backed interrupt or not.

Signed-off-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Jonathan Cameron <jonathan.cameron@huawei.com>
Link: https://patch.msgid.link/20260115-gicv5-host-acpi-v3-6-c13a9a150388@ker=
nel.org
---
 drivers/acpi/arm64/iort.c          | 95 ++++++++++++++++++++++++-----
 drivers/irqchip/irq-gic-v5-iwb.c   | 42 +++++++++----
 drivers/irqchip/irq-gic-v5.c       |  4 +-
 include/linux/acpi_iort.h          |  1 +-
 include/linux/irqchip/arm-gic-v5.h |  6 ++-
 5 files changed, 123 insertions(+), 25 deletions(-)

diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
index ddd857f..ed827b2 100644
--- a/drivers/acpi/arm64/iort.c
+++ b/drivers/acpi/arm64/iort.c
@@ -264,39 +264,47 @@ static acpi_status iort_match_node_callback(struct acpi=
_iort_node *node,
 	struct device *dev =3D context;
 	acpi_status status =3D AE_NOT_FOUND;
=20
-	if (node->type =3D=3D ACPI_IORT_NODE_NAMED_COMPONENT) {
+	if (node->type =3D=3D ACPI_IORT_NODE_NAMED_COMPONENT ||
+	    node->type =3D=3D ACPI_IORT_NODE_IWB) {
 		struct acpi_buffer buf =3D { ACPI_ALLOCATE_BUFFER, NULL };
-		struct acpi_device *adev;
 		struct acpi_iort_named_component *ncomp;
-		struct device *nc_dev =3D dev;
+		struct acpi_iort_iwb *iwb;
+		struct device *cdev =3D dev;
+		struct acpi_device *adev;
+		const char *device_name;
=20
 		/*
 		 * Walk the device tree to find a device with an
 		 * ACPI companion; there is no point in scanning
-		 * IORT for a device matching a named component if
+		 * IORT for a device matching a named component or IWB if
 		 * the device does not have an ACPI companion to
 		 * start with.
 		 */
 		do {
-			adev =3D ACPI_COMPANION(nc_dev);
+			adev =3D ACPI_COMPANION(cdev);
 			if (adev)
 				break;
=20
-			nc_dev =3D nc_dev->parent;
-		} while (nc_dev);
+			cdev =3D cdev->parent;
+		} while (cdev);
=20
 		if (!adev)
 			goto out;
=20
 		status =3D acpi_get_name(adev->handle, ACPI_FULL_PATHNAME, &buf);
 		if (ACPI_FAILURE(status)) {
-			dev_warn(nc_dev, "Can't get device full path name\n");
+			dev_warn(cdev, "Can't get device full path name\n");
 			goto out;
 		}
=20
-		ncomp =3D (struct acpi_iort_named_component *)node->node_data;
-		status =3D !strcmp(ncomp->device_name, buf.pointer) ?
-							AE_OK : AE_NOT_FOUND;
+		if (node->type =3D=3D ACPI_IORT_NODE_NAMED_COMPONENT) {
+			ncomp =3D (struct acpi_iort_named_component *)node->node_data;
+			device_name =3D ncomp->device_name;
+		} else {
+			iwb =3D (struct acpi_iort_iwb *)node->node_data;
+			device_name =3D iwb->device_name;
+		}
+		status =3D !strcmp(device_name, buf.pointer) ?  AE_OK : AE_NOT_FOUND;
 		acpi_os_free(buf.pointer);
 	} else if (node->type =3D=3D ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
 		struct acpi_iort_root_complex *pci_rc;
@@ -317,12 +325,28 @@ out:
 	return status;
 }
=20
+static acpi_status iort_match_iwb_callback(struct acpi_iort_node *node, void=
 *context)
+{
+	struct acpi_iort_iwb *iwb;
+	u32 *id =3D context;
+
+	if (node->type !=3D ACPI_IORT_NODE_IWB)
+		return AE_NOT_FOUND;
+
+	iwb =3D (struct acpi_iort_iwb *)node->node_data;
+	if (iwb->iwb_index !=3D *id)
+		return AE_NOT_FOUND;
+
+	return AE_OK;
+}
+
 static int iort_id_map(struct acpi_iort_id_mapping *map, u8 type, u32 rid_in,
 		       u32 *rid_out, bool check_overlap)
 {
 	/* Single mapping does not care for input id */
 	if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
 		if (type =3D=3D ACPI_IORT_NODE_NAMED_COMPONENT ||
+		    type =3D=3D ACPI_IORT_NODE_IWB		   ||
 		    type =3D=3D ACPI_IORT_NODE_PCI_ROOT_COMPLEX) {
 			*rid_out =3D map->output_base;
 			return 0;
@@ -392,6 +416,7 @@ static struct acpi_iort_node *iort_node_get_id(struct acp=
i_iort_node *node,
=20
 	if (map->flags & ACPI_IORT_ID_SINGLE_MAPPING) {
 		if (node->type =3D=3D ACPI_IORT_NODE_NAMED_COMPONENT ||
+		    node->type =3D=3D ACPI_IORT_NODE_IWB ||
 		    node->type =3D=3D ACPI_IORT_NODE_PCI_ROOT_COMPLEX ||
 		    node->type =3D=3D ACPI_IORT_NODE_SMMU_V3 ||
 		    node->type =3D=3D ACPI_IORT_NODE_PMCG) {
@@ -562,9 +587,14 @@ static struct acpi_iort_node *iort_find_dev_node(struct =
device *dev)
 			return node;
 		/*
 		 * if not, then it should be a platform device defined in
-		 * DSDT/SSDT (with Named Component node in IORT)
+		 * DSDT/SSDT (with Named Component node in IORT) or an
+		 * IWB device in the DSDT/SSDT.
 		 */
-		return iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
+		node =3D iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
+				      iort_match_node_callback, dev);
+		if (node)
+			return node;
+		return iort_scan_node(ACPI_IORT_NODE_IWB,
 				      iort_match_node_callback, dev);
 	}
=20
@@ -759,6 +789,35 @@ struct irq_domain *iort_get_device_domain(struct device =
*dev, u32 id,
 	return irq_find_matching_fwnode(handle, bus_token);
 }
=20
+struct fwnode_handle *iort_iwb_handle(u32 iwb_id)
+{
+	struct fwnode_handle *fwnode;
+	struct acpi_iort_node *node;
+	struct acpi_device *device;
+	struct acpi_iort_iwb *iwb;
+	acpi_status status;
+	acpi_handle handle;
+
+	/* find its associated IWB node */
+	node =3D iort_scan_node(ACPI_IORT_NODE_IWB, iort_match_iwb_callback, &iwb_i=
d);
+	if (!node)
+		return NULL;
+
+	iwb =3D (struct acpi_iort_iwb *)node->node_data;
+	status =3D acpi_get_handle(NULL, iwb->device_name, &handle);
+	if (ACPI_FAILURE(status))
+		return NULL;
+
+	device =3D acpi_get_acpi_dev(handle);
+	if (!device)
+		return NULL;
+
+	fwnode =3D acpi_fwnode_handle(device);
+	acpi_put_acpi_dev(device);
+
+	return fwnode;
+}
+
 static void iort_set_device_domain(struct device *dev,
 				   struct acpi_iort_node *node)
 {
@@ -819,8 +878,14 @@ static struct irq_domain *iort_get_platform_device_domai=
n(struct device *dev)
 	/* find its associated iort node */
 	node =3D iort_scan_node(ACPI_IORT_NODE_NAMED_COMPONENT,
 			      iort_match_node_callback, dev);
-	if (!node)
-		return NULL;
+	if (!node) {
+		/* find its associated iort node */
+		node =3D iort_scan_node(ACPI_IORT_NODE_IWB,
+				      iort_match_node_callback, dev);
+
+		if (!node)
+			return NULL;
+	}
=20
 	/* then find its msi parent node */
 	for (i =3D 0; i < node->mapping_count; i++) {
diff --git a/drivers/irqchip/irq-gic-v5-iwb.c b/drivers/irqchip/irq-gic-v5-iw=
b.c
index ad9fdc1..c7d5fd3 100644
--- a/drivers/irqchip/irq-gic-v5-iwb.c
+++ b/drivers/irqchip/irq-gic-v5-iwb.c
@@ -4,6 +4,7 @@
  */
 #define pr_fmt(fmt)	"GICv5 IWB: " fmt
=20
+#include <linux/acpi.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
 #include <linux/msi.h>
@@ -136,18 +137,31 @@ static int gicv5_iwb_irq_domain_translate(struct irq_do=
main *d, struct irq_fwspe
 					  irq_hw_number_t *hwirq,
 					  unsigned int *type)
 {
-	if (!is_of_node(fwspec->fwnode))
-		return -EINVAL;
+	if (is_of_node(fwspec->fwnode)) {
=20
-	if (fwspec->param_count < 2)
-		return -EINVAL;
+		if (fwspec->param_count < 2)
+			return -EINVAL;
=20
-	/*
-	 * param[0] is be the wire
-	 * param[1] is the interrupt type
-	 */
-	*hwirq =3D fwspec->param[0];
-	*type =3D fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+		/*
+		 * param[0] is be the wire
+		 * param[1] is the interrupt type
+		 */
+		*hwirq =3D fwspec->param[0];
+		*type =3D fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+	}
+
+	if (is_acpi_device_node(fwspec->fwnode)) {
+
+		if (fwspec->param_count < 2)
+			return -EINVAL;
+
+		/*
+		 * Extract the wire from param[0]
+		 * param[1] is the interrupt type
+		 */
+		*hwirq =3D FIELD_GET(GICV5_GSI_IWB_WIRE, fwspec->param[0]);
+		*type =3D fwspec->param[1] & IRQ_TYPE_SENSE_MASK;
+	}
=20
 	return 0;
 }
@@ -265,10 +279,18 @@ static const struct of_device_id gicv5_iwb_of_match[] =
=3D {
 };
 MODULE_DEVICE_TABLE(of, gicv5_iwb_of_match);
=20
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id iwb_acpi_match[] =3D {
+	{ "ARMH0003", 0 },
+	{}
+};
+#endif
+
 static struct platform_driver gicv5_iwb_platform_driver =3D {
 	.driver =3D {
 		.name			=3D "GICv5 IWB",
 		.of_match_table		=3D gicv5_iwb_of_match,
+		.acpi_match_table	=3D ACPI_PTR(iwb_acpi_match),
 		.suppress_bind_attrs	=3D true,
 	},
 	.probe				=3D gicv5_iwb_device_probe,
diff --git a/drivers/irqchip/irq-gic-v5.c b/drivers/irqchip/irq-gic-v5.c
index 23fd551..da867dd 100644
--- a/drivers/irqchip/irq-gic-v5.c
+++ b/drivers/irqchip/irq-gic-v5.c
@@ -5,6 +5,7 @@
=20
 #define pr_fmt(fmt)	"GICv5: " fmt
=20
+#include <linux/acpi_iort.h>
 #include <linux/cpuhotplug.h>
 #include <linux/idr.h>
 #include <linux/irqdomain.h>
@@ -1187,6 +1188,9 @@ static struct fwnode_handle *gsi_domain_handle;
=20
 static struct fwnode_handle *gic_v5_get_gsi_domain_id(u32 gsi)
 {
+	if (FIELD_GET(GICV5_GSI_IC_TYPE, gsi) =3D=3D GICV5_GSI_IWB_TYPE)
+		return iort_iwb_handle(FIELD_GET(GICV5_GSI_IWB_FRAME_ID, gsi));
+
 	return gsi_domain_handle;
 }
=20
diff --git a/include/linux/acpi_iort.h b/include/linux/acpi_iort.h
index 2d22268..17bb337 100644
--- a/include/linux/acpi_iort.h
+++ b/include/linux/acpi_iort.h
@@ -27,6 +27,7 @@ int iort_register_domain_token(int trans_id, phys_addr_t ba=
se,
 			       struct fwnode_handle *fw_node);
 void iort_deregister_domain_token(int trans_id);
 struct fwnode_handle *iort_find_domain_token(int trans_id);
+struct fwnode_handle *iort_iwb_handle(u32 iwb_id);
=20
 #ifdef CONFIG_ACPI_IORT
 u32 iort_msi_map_id(struct device *dev, u32 id);
diff --git a/include/linux/irqchip/arm-gic-v5.h b/include/linux/irqchip/arm-g=
ic-v5.h
index 334b698..3da1ad8 100644
--- a/include/linux/irqchip/arm-gic-v5.h
+++ b/include/linux/irqchip/arm-gic-v5.h
@@ -265,6 +265,12 @@
=20
 #define GICV5_IWB_WENABLE_STATUSR_IDLE		BIT(0)
=20
+#define GICV5_GSI_IC_TYPE			GENMASK(31, 29)
+#define GICV5_GSI_IWB_TYPE			0x7
+
+#define GICV5_GSI_IWB_FRAME_ID			GENMASK(28, 16)
+#define GICV5_GSI_IWB_WIRE			GENMASK(15, 0)
+
 /*
  * Global Data structures and functions
  */

