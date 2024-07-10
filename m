Return-Path: <linux-tip-commits+bounces-1668-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 35E5092D677
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jul 2024 18:30:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B46901F2145A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Jul 2024 16:30:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56BF3199E85;
	Wed, 10 Jul 2024 16:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bcVbN5Rx";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qa5KulEO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4ED1991A9;
	Wed, 10 Jul 2024 16:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720628759; cv=none; b=KyE/FU8JWaFkkUAbEay/Efiq9PZDHcFRHnFNY3UN7NphDtkxFtYetWLkxcIQOYLxiJploW4+kwfxmGgbfSBZW7z2U0ll8CJM0LYTINJdF8LBqJuHuEjLqDa5lqJIfZ0uI8m+M00BxaVb5PZJbtnQHWqLrH+ZYw519WLxnhaReR0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720628759; c=relaxed/simple;
	bh=APj0eepduwvvtwASW+SHCv0U/NBWDKOpbaZqy7AZB+k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kCG5eiUzjNzeRXGKrD3CmFfi75USl+ACvZ90BpUO0eeQSUd5HM1xgQJP4WwzTFltRjAIlPyLiBdkdiFxWUEZVlAgShJeMCGn/uLqAH8oOIv28HBWu/Jd5o+1afFXnw+uBlBntoqQzYck1nboA//00uKZ2kCKlTkCXWz849KZ0wA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bcVbN5Rx; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qa5KulEO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 10 Jul 2024 16:25:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720628755;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E84cVwbEDqsPv6tA5kpw6TQqpBXOKaFEtfY4fx8zrFE=;
	b=bcVbN5Rxsk4Zo2vHTBZyTd2kk5Uw3Ze/Vdb+GOONZ9N/AHYKUGZUhCurM6onRUzflDUioZ
	jlDV4TwLPkoHEhI/BMOU1y3Dm1WxiHwEiNl8E5c8TIO0R36KloMp1FxthJ8iuvGUEKbX/D
	LNfGrhfh0VWAD8Gwr7hOiwGHiAJl/FHbp6NPpIyyVBQ3Xqt6iUeMqZcuH/+UQasRaPO3m6
	dh1BJNr8E863+opD+gsDtjCJKLHraVzf8RjC91z4bGdXBK+5BWKbqBrjYgR16R2LN5XZ9P
	mywBeektIiYAL12MmNcBuJqkHQMc9byDxj1lz3MoUtpyfGAi2GIkZsma2LzBjA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720628755;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=E84cVwbEDqsPv6tA5kpw6TQqpBXOKaFEtfY4fx8zrFE=;
	b=qa5KulEOeq0sk1TqbXmykxliKNjzCeNfj+rHhglOjR6joYzNwjix58+j4nfEWyZARJYNdY
	HkuJPWF/bGEZxdCA==
From: "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v3-its: Provide MSI parent infrastructure
Cc: Thomas Gleixner <tglx@linutronix.de>,
 "Anna-Maria Behnsen" <anna-maria@linutronix.de>,
 Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240623142234.903076277@linutronix.de>
References: <20240623142234.903076277@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172062875472.2215.10832477259402758364.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     e3baf5e45373c788bc7e0d899d1563f2acdb0fa8
Gitweb:        https://git.kernel.org/tip/e3baf5e45373c788bc7e0d899d1563f2acdb0fa8
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sun, 23 Jun 2024 17:18:36 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 10 Jul 2024 18:19:23 +02:00

irqchip/gic-v3-its: Provide MSI parent infrastructure

To support per device MSI domains the ITS must provide MSI parent domain
functionality.

Provide the basic skeleton for this:

   - msi_parent_ops
   - child domain init callback
   - the MSI parent flag set in irqdomain::flags

This does not make ITS a functional parent domain as there is no bit set in
the bus_select_mask yet, but it provides the base to implement PCI and
platform MSI support gradually on top.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Anna-Maria Behnsen <anna-maria@linutronix.de>
Signed-off-by: Shivamurthy Shastri <shivamurthy.shastri@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240623142234.903076277@linutronix.de



---
 drivers/irqchip/Kconfig                     |  1 +-
 drivers/irqchip/Makefile                    |  2 +-
 drivers/irqchip/irq-gic-common.h            |  3 ++-
 drivers/irqchip/irq-gic-v3-its-msi-parent.c | 31 ++++++++++++++++++++-
 drivers/irqchip/irq-gic-v3-its.c            |  5 +++-
 5 files changed, 41 insertions(+), 1 deletion(-)
 create mode 100644 drivers/irqchip/irq-gic-v3-its-msi-parent.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 3e3cbe9..ee78716 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -41,6 +41,7 @@ config ARM_GIC_V3
 config ARM_GIC_V3_ITS
 	bool
 	select GENERIC_MSI_IRQ
+	select IRQ_MSI_LIB
 	default ARM_GIC_V3
 
 config ARM_GIC_V3_ITS_PCI
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index f5e0fa9..def6fea 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -32,7 +32,7 @@ obj-$(CONFIG_ARCH_REALVIEW)		+= irq-gic-realview.o
 obj-$(CONFIG_IRQ_MSI_LIB)		+= irq-msi-lib.o
 obj-$(CONFIG_ARM_GIC_V2M)		+= irq-gic-v2m.o
 obj-$(CONFIG_ARM_GIC_V3)		+= irq-gic-v3.o irq-gic-v3-mbi.o irq-gic-common.o
-obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v3-its-platform-msi.o irq-gic-v4.o
+obj-$(CONFIG_ARM_GIC_V3_ITS)		+= irq-gic-v3-its.o irq-gic-v3-its-platform-msi.o irq-gic-v4.o irq-gic-v3-its-msi-parent.o
 obj-$(CONFIG_ARM_GIC_V3_ITS_PCI)	+= irq-gic-v3-its-pci-msi.o
 obj-$(CONFIG_ARM_GIC_V3_ITS_FSL_MC)	+= irq-gic-v3-its-fsl-mc-msi.o
 obj-$(CONFIG_PARTITION_PERCPU)		+= irq-partition-percpu.o
diff --git a/drivers/irqchip/irq-gic-common.h b/drivers/irqchip/irq-gic-common.h
index f407cce..eb4a220 100644
--- a/drivers/irqchip/irq-gic-common.h
+++ b/drivers/irqchip/irq-gic-common.h
@@ -8,6 +8,7 @@
 
 #include <linux/of.h>
 #include <linux/irqdomain.h>
+#include <linux/msi.h>
 #include <linux/irqchip/arm-gic-common.h>
 
 struct gic_quirk {
@@ -29,6 +30,8 @@ void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
 void gic_enable_of_quirks(const struct device_node *np,
 			  const struct gic_quirk *quirks, void *data);
 
+extern const struct msi_parent_ops gic_v3_its_msi_parent_ops;
+
 #define RDIST_FLAGS_PROPBASE_NEEDS_FLUSHING    (1 << 0)
 #define RDIST_FLAGS_RD_TABLES_PREALLOCATED     (1 << 1)
 #define RDIST_FLAGS_FORCE_NON_SHAREABLE        (1 << 2)
diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
new file mode 100644
index 0000000..cdc0844
--- /dev/null
+++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2022 Linutronix GmbH
+// Copyright (C) 2022 Intel
+
+#include "irq-gic-common.h"
+#include "irq-msi-lib.h"
+
+#define ITS_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |	\
+				 MSI_FLAG_USE_DEF_CHIP_OPS)
+
+#define ITS_MSI_FLAGS_SUPPORTED (MSI_GENERIC_FLAGS_MASK |	\
+				 MSI_FLAG_PCI_MSIX      |	\
+				 MSI_FLAG_MULTI_PCI_MSI |	\
+				 MSI_FLAG_PCI_MSI_MASK_PARENT)
+
+static bool its_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
+				  struct irq_domain *real_parent, struct msi_domain_info *info)
+{
+	if (!msi_lib_init_dev_msi_info(dev, domain, real_parent, info))
+		return false;
+
+	return true;
+}
+
+const struct msi_parent_ops gic_v3_its_msi_parent_ops = {
+	.supported_flags	= ITS_MSI_FLAGS_SUPPORTED,
+	.required_flags		= ITS_MSI_FLAGS_REQUIRED,
+	.bus_select_token	= DOMAIN_BUS_NEXUS,
+	.prefix			= "ITS-",
+	.init_dev_msi_info	= its_init_dev_msi_info,
+};
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index af5297e..047e566 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -38,6 +38,7 @@
 #include <asm/exception.h>
 
 #include "irq-gic-common.h"
+#include "irq-msi-lib.h"
 
 #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1ULL << 0)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_22375	(1ULL << 1)
@@ -3708,6 +3709,7 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 }
 
 static const struct irq_domain_ops its_domain_ops = {
+	.select			= msi_lib_irq_domain_select,
 	.alloc			= its_irq_domain_alloc,
 	.free			= its_irq_domain_free,
 	.activate		= its_irq_domain_activate,
@@ -5013,6 +5015,9 @@ static int its_init_domain(struct its_node *its)
 
 	irq_domain_update_bus_token(inner_domain, DOMAIN_BUS_NEXUS);
 
+	inner_domain->msi_parent_ops = &gic_v3_its_msi_parent_ops;
+	inner_domain->flags |= IRQ_DOMAIN_FLAG_MSI_PARENT;
+
 	return 0;
 }
 

