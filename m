Return-Path: <linux-tip-commits+bounces-1726-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FE39351C4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Jul 2024 20:41:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 932D428171F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 18 Jul 2024 18:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21CBD147C87;
	Thu, 18 Jul 2024 18:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xi0lrukO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="1ZXckBzu"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88E2C146A64;
	Thu, 18 Jul 2024 18:39:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721327949; cv=none; b=tCJ+aeTZewQLzPUsxGEN6QMdp9YS7Ok8cVwHkYWxxIBGWf4theJcMs/jPHlZwgHwt8a8GFDoU+1ObdA1JncTqeqW8MpowUKSNwcePJZKkKZs0cu44ckI2CgvlGidFe045EJH44DyQxJ0OrA5MvqE+6/DBdwcXCx+Pin+FHS8kHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721327949; c=relaxed/simple;
	bh=byQMLopCqEVVYeS6WbfqTQRpMwLFBiv3vq0o7ShpLkU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Wb6vciGnnanLx2pJjv5qxYwdsUFY6AI4gEykiGSbdYhBLhsbpHadieR3G+/P3/bwW+dzCrr/vlzoLyIWlAN0OEOizAdtergRG0O4avTvDF6RzX7beX0TDhVQhwJkFc1u+pbXrUGWBth+WFkhlEHRzdB/cPnVeL9h+WvH0Pdv0ps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xi0lrukO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=1ZXckBzu; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 18 Jul 2024 18:39:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1721327942;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iJJ9PkvFYr3P8Q2bsABOAxrpPtSU41rM8xRNaU7khy4=;
	b=xi0lrukOpIry7imgDaVKe7exdD6/1JTMinAbDQx6R7ATNtMROqw7fjSpSC+OtywJU2h0/9
	04rstgWw9veR1H1wyQmxuSA5CpVRe6Se/W9irKfav0WJyVX226lc2icjUC0ocCivY//cmC
	EM8YAfJFjqz0CRmbfrccu6FkoSM7SsL5ayYZiQTxsylQOmHCTgQfLo3d8YNv6JpdbhYfHT
	UH9YLCCEqaw8/ujS5M22e+GZBzkoezTHuCJWj4g8doI29uv5KvNZFnMhZAMiheMmJ+pskC
	V4JGlXVFcQib19pH9ilOu5ZDhCKcjpXKhHFiM/HUWMFZGV8fHpLJuqKvBMIIpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1721327942;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iJJ9PkvFYr3P8Q2bsABOAxrpPtSU41rM8xRNaU7khy4=;
	b=1ZXckBzuCpDsHAkquVU7GztzV1hkHyrY8aEnXJ50Gi0WmYJhndt1FFxfjzSd/bzm9wgxz8
	YsMQzhaQI1AqrtCw==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] irqchip: Provide irq-msi-lib
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240623142234.840975799@linutronix.de>
References: <20240623142234.840975799@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172132794226.2215.11615513597402701600.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     72e257c6f058032daba1c4fe0c81003d545d0f81
Gitweb:        https://git.kernel.org/tip/72e257c6f058032daba1c4fe0c81003d545d0f81
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 23 Jun 2024 17:18:34 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 18 Jul 2024 20:31:19 +02:00

irqchip: Provide irq-msi-lib

All irqdomains which provide MSI parent domain functionality for per device
MSI domains need to provide a select() callback for the irqdomain and a
function to initialize the child domain.

Most of these functions would just be copy&paste with minimal
modifications, so provide a library function which implements the required
functionality and is customizable via parent_domain::msi_parent_ops. The
check for the supported bus tokens in msi_lib_init_dev_msi_info() is
expanded step by step within the next patches.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240623142234.840975799@linutronix.de



---
 drivers/irqchip/Kconfig       |   3 +-
 drivers/irqchip/Makefile      |   1 +-
 drivers/irqchip/irq-msi-lib.c | 112 +++++++++++++++++++++++++++++++++-
 drivers/irqchip/irq-msi-lib.h |  19 ++++++-
 4 files changed, 135 insertions(+)
 create mode 100644 drivers/irqchip/irq-msi-lib.c
 create mode 100644 drivers/irqchip/irq-msi-lib.h

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 1446471..2bf8d94 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -74,6 +74,9 @@ config ARM_VIC_NR
 	  The maximum number of VICs available in the system, for
 	  power management.
 
+config IRQ_MSI_LIB
+	bool
+
 config ARMADA_370_XP_IRQ
 	bool
 	select GENERIC_IRQ_CHIP
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index d9dc3d9..72c7f62 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -29,6 +29,7 @@ obj-$(CONFIG_ARCH_SPEAR3XX)		+= spear-shirq.o
 obj-$(CONFIG_ARM_GIC)			+= irq-gic.o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_PM)		+= irq-gic-pm.o
 obj-$(CONFIG_ARCH_REALVIEW)		+= irq-gic-realview.o
+obj-$(CONFIG_IRQ_MSI_LIB)		+= irq-msi-lib.o
 obj-$(CONFIG_ARM_GIC_V2M)		+= irq-gic-v2m.o
 obj-$(CONFIG_ARM_GIC_V3)		+= irq-gic-v3.o irq-gic-v3-mbi.o irq-gic-common.o
 obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v3-its-platform-msi.o irq-gic-v4.o
diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
new file mode 100644
index 0000000..ec1a10f
--- /dev/null
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -0,0 +1,112 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2022 Linutronix GmbH
+// Copyright (C) 2022 Intel
+
+#include <linux/export.h>
+
+#include "irq-msi-lib.h"
+
+/**
+ * msi_lib_init_dev_msi_info - Domain info setup for MSI domains
+ * @dev:		The device for which the domain is created for
+ * @domain:		The domain providing this callback
+ * @real_parent:	The real parent domain of the domain to be initialized
+ *			which might be a domain built on top of @domain or
+ *			@domain itself
+ * @info:		The domain info for the domain to be initialize
+ *
+ * This function is to be used for all types of MSI domains above the root
+ * parent domain and any intermediates. The topmost parent domain specific
+ * functionality is determined via @real_parent.
+ *
+ * All intermediate domains between the root and the device domain must
+ * have either msi_parent_ops.init_dev_msi_info = msi_parent_init_dev_msi_info
+ * or invoke it down the line.
+ */
+bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
+			       struct irq_domain *real_parent,
+			       struct msi_domain_info *info)
+{
+	const struct msi_parent_ops *pops = real_parent->msi_parent_ops;
+
+	/* Parent ops available? */
+	if (WARN_ON_ONCE(!pops))
+		return false;
+
+	/*
+	 * MSI parent domain specific settings. For now there is only the
+	 * root parent domain, e.g. NEXUS, acting as a MSI parent, but it is
+	 * possible to stack MSI parents. See x86 vector -> irq remapping
+	 */
+	if (domain->bus_token == pops->bus_select_token) {
+		if (WARN_ON_ONCE(domain != real_parent))
+			return false;
+	} else {
+		WARN_ON_ONCE(1);
+		return false;
+	}
+
+	/* Is the target domain bus token supported? */
+	switch(info->bus_token) {
+	default:
+		/*
+		 * This should never be reached. See
+		 * msi_lib_irq_domain_select()
+		 */
+		WARN_ON_ONCE(1);
+		return false;
+	}
+
+	/*
+	 * Mask out the domain specific MSI feature flags which are not
+	 * supported by the real parent.
+	 */
+	info->flags			&= pops->supported_flags;
+	/* Enforce the required flags */
+	info->flags			|= pops->required_flags;
+
+	/* Chip updates for all child bus types */
+	if (!info->chip->irq_eoi)
+		info->chip->irq_eoi	= irq_chip_eoi_parent;
+
+	/*
+	 * The device MSI domain can never have a set affinity callback. It
+	 * always has to rely on the parent domain to handle affinity
+	 * settings. The device MSI domain just has to write the resulting
+	 * MSI message into the hardware which is the whole purpose of the
+	 * device MSI domain aside of mask/unmask which is provided e.g. by
+	 * PCI/MSI device domains.
+	 */
+	info->chip->irq_set_affinity	= msi_domain_set_affinity;
+	return true;
+}
+EXPORT_SYMBOL_GPL(msi_lib_init_dev_msi_info);
+
+/**
+ * msi_lib_irq_domain_select - Shared select function for NEXUS domains
+ * @d:		Pointer to the irq domain on which select is invoked
+ * @fwspec:	Firmware spec describing what is searched
+ * @bus_token:	The bus token for which a matching irq domain is looked up
+ *
+ * Returns:	%0 if @d is not what is being looked for
+ *
+ *		%1 if @d is either the domain which is directly searched for or
+ *		   if @d is providing the parent MSI domain for the functionality
+ *			 requested with @bus_token.
+ */
+int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
+			      enum irq_domain_bus_token bus_token)
+{
+	const struct msi_parent_ops *ops = d->msi_parent_ops;
+	u32 busmask = BIT(bus_token);
+
+	if (fwspec->fwnode != d->fwnode || fwspec->param_count != 0)
+		return 0;
+
+	/* Handle pure domain searches */
+	if (bus_token == ops->bus_select_token)
+		return 1;
+
+	return ops && !!(ops->bus_select_mask & busmask);
+}
+EXPORT_SYMBOL_GPL(msi_lib_irq_domain_select);
diff --git a/drivers/irqchip/irq-msi-lib.h b/drivers/irqchip/irq-msi-lib.h
new file mode 100644
index 0000000..f0706cc
--- /dev/null
+++ b/drivers/irqchip/irq-msi-lib.h
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2022 Linutronix GmbH
+// Copyright (C) 2022 Intel
+
+#ifndef _DRIVERS_IRQCHIP_IRQ_MSI_LIB_H
+#define _DRIVERS_IRQCHIP_IRQ_MSI_LIB_H
+
+#include <linux/bits.h>
+#include <linux/irqdomain.h>
+#include <linux/msi.h>
+
+int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
+			      enum irq_domain_bus_token bus_token);
+
+bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
+			       struct irq_domain *real_parent,
+			       struct msi_domain_info *info);
+
+#endif /* _DRIVERS_IRQCHIP_IRQ_MSI_LIB_H */

