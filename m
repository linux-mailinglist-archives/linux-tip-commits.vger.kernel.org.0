Return-Path: <linux-tip-commits+bounces-5635-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC7BFABA44C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 21:48:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3286A1C03DDA
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 May 2025 19:48:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A148280CE5;
	Fri, 16 May 2025 19:47:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="N6YdEPUR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ctdLvzan"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F02ED280313;
	Fri, 16 May 2025 19:47:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747424834; cv=none; b=YcXFkCZ5q5rpnok8FlHD8+lyuzkxifGYpHcMd/V+UQ/d4QJ4aWbkaRTXgY+5Jkib2LnPYnylUtVjBFQIMj20K10frctVuozgzDlf2JcD0clwPwK9RHLh0BQW0ZFl9WRhC9/DvtmHt2BET/nWan8lyz4N2TIl5OHrPkHwUEC2amA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747424834; c=relaxed/simple;
	bh=0zJzc51BZOP6P02NzC/lnQ3Z/8EuvIOP2LpGBTQlK6s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pr94K3cDAavIBgghkkXWMK6rpq9/5eRaaj6Teotcj9naVrmB+SKbGLVPVLvG3uyodFZLM8ycpeKDcvAFmFjBNJA1EKO1c6Qn1OjbWVuE2AQMyRCI990TDVxf1PnWLyLEjnl/R6FhjFPJp2VbRjaFH/vdwmgO9/XVVSuiDbuzhFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=N6YdEPUR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ctdLvzan; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 16 May 2025 19:47:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747424831;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a7e7+AnH0k8iwHSVLcgaH1uzZUC0/FHnmh13OViUqJE=;
	b=N6YdEPURilLNxoo3jHtNQFr+YilnroLrSO/z2S8rVzSyxluZwmUtycegWA30dFUucBUFXo
	otuyqaYkbS/St98CRWT/7eE8tzoCfyal7hY8RN5NvMcukPAbpT8/GQEs7XB+0Qlvbifefk
	7Q64M/2nNy2WS2tWdvmFdXvcPD0TgIa5WK1V2R+KT8p6F0sQevu2oSgoRESO1B8rKRsCcq
	GE/S4htnVjWkwK31s3vMsSSqMCplkYilrBXWxRZHRoZnaR4ggaF7+Fu7xdNeyAU3GTdsq3
	+d10T1+o6RYcFBV02HzqowOxcXUpABpo2MtXDUweKB6PXutdpEmSPbb8XZM0Ug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747424831;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=a7e7+AnH0k8iwHSVLcgaH1uzZUC0/FHnmh13OViUqJE=;
	b=ctdLvzanGfvDLQ3d/RwcNiQZkF4AW27Hc4XHXGB9SI1obnXV2/5053w00H4yXiZU9a+NMK
	EYRoBIcPjsJ0mhBg==
From: "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/msi] irqchip: Make irq-msi-lib.h globally available
Cc: Marc Zyngier <maz@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250513172819.2216709-2-maz@kernel.org>
References: <20250513172819.2216709-2-maz@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174742483029.406.15781361777192336489.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/msi branch of tip:

Commit-ID:     e51b27438a10391fdc94dd2046d9ffa9c2679c74
Gitweb:        https://git.kernel.org/tip/e51b27438a10391fdc94dd2046d9ffa9c2679c74
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 13 May 2025 18:28:11 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 16 May 2025 21:32:19 +02:00

irqchip: Make irq-msi-lib.h globally available

Move irq-msi-lib.h into include/linux/irqchip, making it available
to compilation units outside of drivers/irqchip.

This requires some churn in drivers to fetch it from the new location,
generated using this script:

	git grep -l -w \"irq-msi-lib.h\" | \
	xargs sed -i -e 's:"irq-msi-lib.h":\<linux/irqchip/irq-msi-lib.h\>:'

Signed-off-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250513172819.2216709-2-maz@kernel.org

---
 drivers/irqchip/irq-bcm2712-mip.c           |  2 +-
 drivers/irqchip/irq-gic-v2m.c               |  2 +-
 drivers/irqchip/irq-gic-v3-its-msi-parent.c |  2 +-
 drivers/irqchip/irq-gic-v3-its.c            |  2 +-
 drivers/irqchip/irq-gic-v3-mbi.c            |  2 +-
 drivers/irqchip/irq-imx-mu-msi.c            |  2 +-
 drivers/irqchip/irq-loongarch-avec.c        |  2 +-
 drivers/irqchip/irq-loongson-pch-msi.c      |  2 +-
 drivers/irqchip/irq-msi-lib.c               |  2 +-
 drivers/irqchip/irq-msi-lib.h               | 27 +--------------------
 drivers/irqchip/irq-mvebu-gicp.c            |  2 +-
 drivers/irqchip/irq-mvebu-icu.c             |  2 +-
 drivers/irqchip/irq-mvebu-odmi.c            |  2 +-
 drivers/irqchip/irq-mvebu-sei.c             |  2 +-
 drivers/irqchip/irq-riscv-imsic-platform.c  |  2 +-
 drivers/irqchip/irq-sg2042-msi.c            |  2 +-
 include/linux/irqchip/irq-msi-lib.h         | 27 ++++++++++++++++++++-
 17 files changed, 42 insertions(+), 42 deletions(-)
 delete mode 100644 drivers/irqchip/irq-msi-lib.h
 create mode 100644 include/linux/irqchip/irq-msi-lib.h

diff --git a/drivers/irqchip/irq-bcm2712-mip.c b/drivers/irqchip/irq-bcm2712-mip.c
index 49a19db..f04a42b 100644
--- a/drivers/irqchip/irq-bcm2712-mip.c
+++ b/drivers/irqchip/irq-bcm2712-mip.c
@@ -11,7 +11,7 @@
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
 
-#include "irq-msi-lib.h"
+#include <linux/irqchip/irq-msi-lib.h>
 
 #define MIP_INT_RAISE		0x00
 #define MIP_INT_CLEAR		0x10
diff --git a/drivers/irqchip/irq-gic-v2m.c b/drivers/irqchip/irq-gic-v2m.c
index c698948..6267699 100644
--- a/drivers/irqchip/irq-gic-v2m.c
+++ b/drivers/irqchip/irq-gic-v2m.c
@@ -26,7 +26,7 @@
 #include <linux/irqchip/arm-gic.h>
 #include <linux/irqchip/arm-gic-common.h>
 
-#include "irq-msi-lib.h"
+#include <linux/irqchip/irq-msi-lib.h>
 
 /*
 * MSI_TYPER:
diff --git a/drivers/irqchip/irq-gic-v3-its-msi-parent.c b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
index 6a5f64f..d039ec5 100644
--- a/drivers/irqchip/irq-gic-v3-its-msi-parent.c
+++ b/drivers/irqchip/irq-gic-v3-its-msi-parent.c
@@ -8,7 +8,7 @@
 #include <linux/pci.h>
 
 #include "irq-gic-common.h"
-#include "irq-msi-lib.h"
+#include <linux/irqchip/irq-msi-lib.h>
 
 #define ITS_MSI_FLAGS_REQUIRED  (MSI_FLAG_USE_DEF_DOM_OPS |	\
 				 MSI_FLAG_USE_DEF_CHIP_OPS |	\
diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index a77f11e..d651cd4 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -41,7 +41,7 @@
 #include <asm/exception.h>
 
 #include "irq-gic-common.h"
-#include "irq-msi-lib.h"
+#include <linux/irqchip/irq-msi-lib.h>
 
 #define ITS_FLAGS_CMDQ_NEEDS_FLUSHING		(1ULL << 0)
 #define ITS_FLAGS_WORKAROUND_CAVIUM_22375	(1ULL << 1)
diff --git a/drivers/irqchip/irq-gic-v3-mbi.c b/drivers/irqchip/irq-gic-v3-mbi.c
index 34e9ca7..e562b57 100644
--- a/drivers/irqchip/irq-gic-v3-mbi.c
+++ b/drivers/irqchip/irq-gic-v3-mbi.c
@@ -18,7 +18,7 @@
 
 #include <linux/irqchip/arm-gic-v3.h>
 
-#include "irq-msi-lib.h"
+#include <linux/irqchip/irq-msi-lib.h>
 
 struct mbi_range {
 	u32			spi_start;
diff --git a/drivers/irqchip/irq-imx-mu-msi.c b/drivers/irqchip/irq-imx-mu-msi.c
index 69aacdf..137da19 100644
--- a/drivers/irqchip/irq-imx-mu-msi.c
+++ b/drivers/irqchip/irq-imx-mu-msi.c
@@ -24,7 +24,7 @@
 #include <linux/pm_domain.h>
 #include <linux/spinlock.h>
 
-#include "irq-msi-lib.h"
+#include <linux/irqchip/irq-msi-lib.h>
 
 #define IMX_MU_CHANS            4
 
diff --git a/drivers/irqchip/irq-loongarch-avec.c b/drivers/irqchip/irq-loongarch-avec.c
index 80e5595..bf52dc8 100644
--- a/drivers/irqchip/irq-loongarch-avec.c
+++ b/drivers/irqchip/irq-loongarch-avec.c
@@ -18,7 +18,7 @@
 #include <asm/loongarch.h>
 #include <asm/setup.h>
 
-#include "irq-msi-lib.h"
+#include <linux/irqchip/irq-msi-lib.h>
 #include "irq-loongson.h"
 
 #define VECTORS_PER_REG		64
diff --git a/drivers/irqchip/irq-loongson-pch-msi.c b/drivers/irqchip/irq-loongson-pch-msi.c
index 9c62108..fb690c7 100644
--- a/drivers/irqchip/irq-loongson-pch-msi.c
+++ b/drivers/irqchip/irq-loongson-pch-msi.c
@@ -15,7 +15,7 @@
 #include <linux/pci.h>
 #include <linux/slab.h>
 
-#include "irq-msi-lib.h"
+#include <linux/irqchip/irq-msi-lib.h>
 #include "irq-loongson.h"
 
 static int nr_pics;
diff --git a/drivers/irqchip/irq-msi-lib.c b/drivers/irqchip/irq-msi-lib.c
index 51464c6..2a61c06 100644
--- a/drivers/irqchip/irq-msi-lib.c
+++ b/drivers/irqchip/irq-msi-lib.c
@@ -4,7 +4,7 @@
 
 #include <linux/export.h>
 
-#include "irq-msi-lib.h"
+#include <linux/irqchip/irq-msi-lib.h>
 
 /**
  * msi_lib_init_dev_msi_info - Domain info setup for MSI domains
diff --git a/drivers/irqchip/irq-msi-lib.h b/drivers/irqchip/irq-msi-lib.h
deleted file mode 100644
index 681ceab..0000000
--- a/drivers/irqchip/irq-msi-lib.h
+++ /dev/null
@@ -1,27 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-// Copyright (C) 2022 Linutronix GmbH
-// Copyright (C) 2022 Intel
-
-#ifndef _DRIVERS_IRQCHIP_IRQ_MSI_LIB_H
-#define _DRIVERS_IRQCHIP_IRQ_MSI_LIB_H
-
-#include <linux/bits.h>
-#include <linux/irqdomain.h>
-#include <linux/msi.h>
-
-#ifdef CONFIG_PCI_MSI
-#define MATCH_PCI_MSI		BIT(DOMAIN_BUS_PCI_MSI)
-#else
-#define MATCH_PCI_MSI		(0)
-#endif
-
-#define MATCH_PLATFORM_MSI	BIT(DOMAIN_BUS_PLATFORM_MSI)
-
-int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
-			      enum irq_domain_bus_token bus_token);
-
-bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
-			       struct irq_domain *real_parent,
-			       struct msi_domain_info *info);
-
-#endif /* _DRIVERS_IRQCHIP_IRQ_MSI_LIB_H */
diff --git a/drivers/irqchip/irq-mvebu-gicp.c b/drivers/irqchip/irq-mvebu-gicp.c
index d67f93f..0b2a857 100644
--- a/drivers/irqchip/irq-mvebu-gicp.c
+++ b/drivers/irqchip/irq-mvebu-gicp.c
@@ -17,7 +17,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
-#include "irq-msi-lib.h"
+#include <linux/irqchip/irq-msi-lib.h>
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
diff --git a/drivers/irqchip/irq-mvebu-icu.c b/drivers/irqchip/irq-mvebu-icu.c
index 4eebed3..db5dbc6 100644
--- a/drivers/irqchip/irq-mvebu-icu.c
+++ b/drivers/irqchip/irq-mvebu-icu.c
@@ -20,7 +20,7 @@
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 
-#include "irq-msi-lib.h"
+#include <linux/irqchip/irq-msi-lib.h>
 
 #include <dt-bindings/interrupt-controller/mvebu-icu.h>
 
diff --git a/drivers/irqchip/irq-mvebu-odmi.c b/drivers/irqchip/irq-mvebu-odmi.c
index 28f7e81..306a775 100644
--- a/drivers/irqchip/irq-mvebu-odmi.c
+++ b/drivers/irqchip/irq-mvebu-odmi.c
@@ -18,7 +18,7 @@
 #include <linux/of_address.h>
 #include <linux/slab.h>
 
-#include "irq-msi-lib.h"
+#include <linux/irqchip/irq-msi-lib.h>
 
 #include <dt-bindings/interrupt-controller/arm-gic.h>
 
diff --git a/drivers/irqchip/irq-mvebu-sei.c b/drivers/irqchip/irq-mvebu-sei.c
index ebd4a90..a962ef4 100644
--- a/drivers/irqchip/irq-mvebu-sei.c
+++ b/drivers/irqchip/irq-mvebu-sei.c
@@ -14,7 +14,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 
-#include "irq-msi-lib.h"
+#include <linux/irqchip/irq-msi-lib.h>
 
 /* Cause register */
 #define GICP_SECR(idx)		(0x0  + ((idx) * 0x4))
diff --git a/drivers/irqchip/irq-riscv-imsic-platform.c b/drivers/irqchip/irq-riscv-imsic-platform.c
index b8ae67c..1b9fbfc 100644
--- a/drivers/irqchip/irq-riscv-imsic-platform.c
+++ b/drivers/irqchip/irq-riscv-imsic-platform.c
@@ -20,7 +20,7 @@
 #include <linux/spinlock.h>
 #include <linux/smp.h>
 
-#include "irq-msi-lib.h"
+#include <linux/irqchip/irq-msi-lib.h>
 #include "irq-riscv-imsic-state.h"
 
 static bool imsic_cpu_page_phys(unsigned int cpu, unsigned int guest_index,
diff --git a/drivers/irqchip/irq-sg2042-msi.c b/drivers/irqchip/irq-sg2042-msi.c
index ee682e8..d641f3a 100644
--- a/drivers/irqchip/irq-sg2042-msi.c
+++ b/drivers/irqchip/irq-sg2042-msi.c
@@ -17,7 +17,7 @@
 #include <linux/property.h>
 #include <linux/slab.h>
 
-#include "irq-msi-lib.h"
+#include <linux/irqchip/irq-msi-lib.h>
 
 #define SG2042_MAX_MSI_VECTOR	32
 
diff --git a/include/linux/irqchip/irq-msi-lib.h b/include/linux/irqchip/irq-msi-lib.h
new file mode 100644
index 0000000..dd8d1d1
--- /dev/null
+++ b/include/linux/irqchip/irq-msi-lib.h
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0-only
+// Copyright (C) 2022 Linutronix GmbH
+// Copyright (C) 2022 Intel
+
+#ifndef _IRQCHIP_IRQ_MSI_LIB_H
+#define _IRQCHIP_IRQ_MSI_LIB_H
+
+#include <linux/bits.h>
+#include <linux/irqdomain.h>
+#include <linux/msi.h>
+
+#ifdef CONFIG_PCI_MSI
+#define MATCH_PCI_MSI		BIT(DOMAIN_BUS_PCI_MSI)
+#else
+#define MATCH_PCI_MSI		(0)
+#endif
+
+#define MATCH_PLATFORM_MSI	BIT(DOMAIN_BUS_PLATFORM_MSI)
+
+int msi_lib_irq_domain_select(struct irq_domain *d, struct irq_fwspec *fwspec,
+			      enum irq_domain_bus_token bus_token);
+
+bool msi_lib_init_dev_msi_info(struct device *dev, struct irq_domain *domain,
+			       struct irq_domain *real_parent,
+			       struct msi_domain_info *info);
+
+#endif /* _IRQCHIP_IRQ_MSI_LIB_H */

