Return-Path: <linux-tip-commits+bounces-6327-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 51BC4B32BA7
	for <lists+linux-tip-commits@lfdr.de>; Sat, 23 Aug 2025 21:30:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0327456717A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 23 Aug 2025 19:30:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 613102EBBAB;
	Sat, 23 Aug 2025 19:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XuSsfYFQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="O25tj2w/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D803E2EACEE;
	Sat, 23 Aug 2025 19:30:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755977430; cv=none; b=F+5BU7v29MFpPBykT4RWKfqAV3GAp/r0CaZDFQl8aGA/QVGN+VlQJcxM7xOHzLsSsz6FOEhU+Tdr2PQLuVNbSs93AsLSzkXSEL/qRTf8ya10tX/YW7SY5QlzFM2sExgRgrHtLT/ta7xxZaWXFAu+zGBvdSLRhIdZIvkP69+VtYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755977430; c=relaxed/simple;
	bh=cqhbZliEgCw06LWjb4Etn6caGoDfjS1O8wgS/RxBbQA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=M6WF1Rrrxky1EsbntJHRDjQXdMd4/8JB96UEt6ZAVfugY2moKh4Hw3cpb37BZ2fJ3H+/hgwchh0FBQcD2PgNYQbwCVPkyEu48lwHjgNURPuR55l9SAjjV76QGrppk0J84rniedZP/TfE0NGKqLnZz1gUCw24/Zq8duDAw4tXcfs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XuSsfYFQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=O25tj2w/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 23 Aug 2025 19:30:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1755977425;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oO8oVBpDtIm03zfRBASenoVtH2C2/4GMbx6IwR5Dhdc=;
	b=XuSsfYFQzEZJBcQFsdU4Cw5bU3rQrN8ZF0c7cnYmjqkR60wCKE6fqrsDxn2kBfnna81p1k
	l4/XmCnk3zp99ZMT0dT0VyQbdrmee40IBmqa2K7OQGpROErBkEqeP0FBnvNWYGvCw2d6mv
	+l0m4QRzkgDzlAH+pJWkaz56iNBsw3h7jS52pa4xCaElC3tJoCVsu+T9R76Ft18xbxV5EN
	ZB6TmUcLN65vU53jNzK3Tw73wYwzrxkVRpnyUHN3/gXVV0krF3PH94H6JmIfARcFZ1qlsm
	VUT/Cn2ivDmf+LTknpk7sURAplxxQrFvoQpZCPdBFK9nAMTb9t7RNOo7KZQkUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1755977425;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oO8oVBpDtIm03zfRBASenoVtH2C2/4GMbx6IwR5Dhdc=;
	b=O25tj2w/p8BX45iILiWf66v00wjmUvy13wSMSsHYZHxU0hPrdicBdMavkRuVeeWV/It6/h
	It50wqj1Ho3VF/Cg==
From: "tip-bot2 for Inochi Amaoto" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: irq/drivers] PCI/MSI: Add startup/shutdown for per device domains
Cc: Thomas Gleixner <tglx@linutronix.de>, Inochi Amaoto <inochiama@gmail.com>,
 Chen Wang <unicorn_wang@outlook.com>, Bjorn Helgaas <bhelgaas@google.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250813232835.43458-3-inochiama@gmail.com>
References: <20250813232835.43458-3-inochiama@gmail.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175597742445.1420.15698772971358170313.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the irq/drivers branch of tip:

Commit-ID:     54f45a30c0d0153d2be091ba2d683ab6db6d1d5b
Gitweb:        https://git.kernel.org/tip/54f45a30c0d0153d2be091ba2d683ab6db6=
d1d5b
Author:        Inochi Amaoto <inochiama@gmail.com>
AuthorDate:    Thu, 14 Aug 2025 07:28:32 +08:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 23 Aug 2025 21:21:13 +02:00

PCI/MSI: Add startup/shutdown for per device domains

As the RISC-V PLIC cannot apply affinity settings without invoking
irq_enable(), it will make the interrupt unavailble when used as an
underlying interrupt chip for the MSI controller.

Implement the irq_startup() and irq_shutdown() callbacks for the PCI MSI
and MSI-X templates.

For chips that specify MSI_FLAG_PCI_MSI_STARTUP_PARENT, the parent startup
and shutdown functions are invoked. That allows the interrupt on the parent
chip to be enabled if the interrupt has not been enabled during
allocation. This is necessary for MSI controllers which use PLIC as
underlying parent interrupt chip.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Inochi Amaoto <inochiama@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Chen Wang <unicorn_wang@outlook.com> # Pioneerbox
Reviewed-by: Chen Wang <unicorn_wang@outlook.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/all/20250813232835.43458-3-inochiama@gmail.com

---
 drivers/pci/msi/irqdomain.c | 52 ++++++++++++++++++++++++++++++++++++-
 include/linux/msi.h         |  2 +-
 2 files changed, 54 insertions(+)

diff --git a/drivers/pci/msi/irqdomain.c b/drivers/pci/msi/irqdomain.c
index 0938ef7..e0a800f 100644
--- a/drivers/pci/msi/irqdomain.c
+++ b/drivers/pci/msi/irqdomain.c
@@ -148,6 +148,23 @@ static void pci_device_domain_set_desc(msi_alloc_info_t =
*arg, struct msi_desc *d
 	arg->hwirq =3D desc->msi_index;
 }
=20
+static void cond_shutdown_parent(struct irq_data *data)
+{
+	struct msi_domain_info *info =3D data->domain->host_data;
+
+	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_STARTUP_PARENT))
+		irq_chip_shutdown_parent(data);
+}
+
+static unsigned int cond_startup_parent(struct irq_data *data)
+{
+	struct msi_domain_info *info =3D data->domain->host_data;
+
+	if (unlikely(info->flags & MSI_FLAG_PCI_MSI_STARTUP_PARENT))
+		return irq_chip_startup_parent(data);
+	return 0;
+}
+
 static __always_inline void cond_mask_parent(struct irq_data *data)
 {
 	struct msi_domain_info *info =3D data->domain->host_data;
@@ -164,6 +181,23 @@ static __always_inline void cond_unmask_parent(struct ir=
q_data *data)
 		irq_chip_unmask_parent(data);
 }
=20
+static void pci_irq_shutdown_msi(struct irq_data *data)
+{
+	struct msi_desc *desc =3D irq_data_get_msi_desc(data);
+
+	pci_msi_mask(desc, BIT(data->irq - desc->irq));
+	cond_shutdown_parent(data);
+}
+
+static unsigned int pci_irq_startup_msi(struct irq_data *data)
+{
+	struct msi_desc *desc =3D irq_data_get_msi_desc(data);
+	unsigned int ret =3D cond_startup_parent(data);
+
+	pci_msi_unmask(desc, BIT(data->irq - desc->irq));
+	return ret;
+}
+
 static void pci_irq_mask_msi(struct irq_data *data)
 {
 	struct msi_desc *desc =3D irq_data_get_msi_desc(data);
@@ -194,6 +228,8 @@ static void pci_irq_unmask_msi(struct irq_data *data)
 static const struct msi_domain_template pci_msi_template =3D {
 	.chip =3D {
 		.name			=3D "PCI-MSI",
+		.irq_startup		=3D pci_irq_startup_msi,
+		.irq_shutdown		=3D pci_irq_shutdown_msi,
 		.irq_mask		=3D pci_irq_mask_msi,
 		.irq_unmask		=3D pci_irq_unmask_msi,
 		.irq_write_msi_msg	=3D pci_msi_domain_write_msg,
@@ -210,6 +246,20 @@ static const struct msi_domain_template pci_msi_template=
 =3D {
 	},
 };
=20
+static void pci_irq_shutdown_msix(struct irq_data *data)
+{
+	pci_msix_mask(irq_data_get_msi_desc(data));
+	cond_shutdown_parent(data);
+}
+
+static unsigned int pci_irq_startup_msix(struct irq_data *data)
+{
+	unsigned int ret =3D cond_startup_parent(data);
+
+	pci_msix_unmask(irq_data_get_msi_desc(data));
+	return ret;
+}
+
 static void pci_irq_mask_msix(struct irq_data *data)
 {
 	pci_msix_mask(irq_data_get_msi_desc(data));
@@ -234,6 +284,8 @@ EXPORT_SYMBOL_GPL(pci_msix_prepare_desc);
 static const struct msi_domain_template pci_msix_template =3D {
 	.chip =3D {
 		.name			=3D "PCI-MSIX",
+		.irq_startup		=3D pci_irq_startup_msix,
+		.irq_shutdown		=3D pci_irq_shutdown_msix,
 		.irq_mask		=3D pci_irq_mask_msix,
 		.irq_unmask		=3D pci_irq_unmask_msix,
 		.irq_write_msi_msg	=3D pci_msi_domain_write_msg,
diff --git a/include/linux/msi.h b/include/linux/msi.h
index e5e86a8..3111ba9 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -568,6 +568,8 @@ enum {
 	MSI_FLAG_PARENT_PM_DEV		=3D (1 << 8),
 	/* Support for parent mask/unmask */
 	MSI_FLAG_PCI_MSI_MASK_PARENT	=3D (1 << 9),
+	/* Support for parent startup/shutdown */
+	MSI_FLAG_PCI_MSI_STARTUP_PARENT	=3D (1 << 10),
=20
 	/* Mask for the generic functionality */
 	MSI_GENERIC_FLAGS_MASK		=3D GENMASK(15, 0),

