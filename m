Return-Path: <linux-tip-commits+bounces-1502-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BA63913D65
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jun 2024 19:52:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DFC0E1F232B7
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jun 2024 17:52:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9CCB184121;
	Sun, 23 Jun 2024 17:52:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Crsc4/5E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="W8zw8y4m"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 674F41836E3;
	Sun, 23 Jun 2024 17:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719165136; cv=none; b=IZ3UbpIQQQcLU9ukqs1Y/WYdsflLBIPJ0TZYO1eOyYYG2BqNuvm22M6EGbiFVAoELnj/Mq4bifopbdgaZOG2lQD1SaUf+5Tk6Sb5wfs5oF75vi8uALnkzK3Z1NGGXWIyMuNCs/H41ndR7yelQtMnW/jPvWdFGgHddcRBg2ttbug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719165136; c=relaxed/simple;
	bh=bHLflPslC1FQgNomqnmhYN+mC2HC/HFGnHM45YCLbwU=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ME8gEmowYCBTx+hcH4tmyHn0Pj7vNVrLsBAMqCpnpkb7UG5gBmtIjco76b6x6ZFwNHMqpSFsx+wc1aqmSo1gKDtHvfgRHM4tj08OXNPlSeyRS073nP40rziJyOEIdqS8UyIimDXuZ2PSGapfUG8nEOrH8V4lhoKMRVZrzqJ08YI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Crsc4/5E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=W8zw8y4m; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 23 Jun 2024 17:52:11 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719165131;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XsjU9LSOLh8kvINVOxc2dJOSFX8ZXHRgq7fIR0zuMcQ=;
	b=Crsc4/5Er58EB+eHwESeGviDjzAgi9aHbOCwK865XbMKGjjMLJFQr2v1yYDagd4apWyHve
	np0VU2ickFtWnOB8EvGutxxSFUbzSLwJk7LIFuDt1jWbiFoMY8oBgJOuNP2EHPL7XS3QUO
	rGo6eEfwE1dJ0Tk7H41Bvim8t89y2fui9fC51yAvn1GE9bAU9m38Jf6mEy6NVGiO37T0hH
	i9c4QDqSypR2qXUzzLsV23x3S1F5b9Wj88+5CLeyWxAqmtlUZEm2ymgYDHcO+U8p4UDEYJ
	bta/x9eNjgcp4GhtG7LdgzU9rPr+uhAhpdHuFQjtmEJujUQLO/y9wnki3cOacQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719165131;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XsjU9LSOLh8kvINVOxc2dJOSFX8ZXHRgq7fIR0zuMcQ=;
	b=W8zw8y4mVffpGP2lrCe2SlbLvV2tyYXLxPP97ZfjeXueil3F7pwsKTbNS54Tr96xHvCWbG
	R/HRldzmThlPUWBQ==
From: "tip-bot2 for Antonio Borneo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/stm32-exti: Split MCU and MPU code
Cc: Antonio Borneo <antonio.borneo@foss.st.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240620083115.204362-5-antonio.borneo@foss.st.com>
References: <20240620083115.204362-5-antonio.borneo@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171916513146.10875.5808120055008266414.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     350755e2e548ccbe941d045900b57233efa906cb
Gitweb:        https://git.kernel.org/tip/350755e2e548ccbe941d045900b57233efa906cb
Author:        Antonio Borneo <antonio.borneo@foss.st.com>
AuthorDate:    Thu, 20 Jun 2024 10:31:11 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 23 Jun 2024 19:49:45 +02:00

irqchip/stm32-exti: Split MCU and MPU code

Keep only the code for ARMv7m STM32 MCUs in in stm32-exti.c and split out
the code for ARMv7a & ARMv8a STM32MPxxx MPUs into stm32mp-exti.c

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240620083115.204362-5-antonio.borneo@foss.st.com

---
 drivers/irqchip/Kconfig            |   3 +-
 drivers/irqchip/Makefile           |   1 +-
 drivers/irqchip/irq-stm32-exti.c   | 670 +-------------------------
 drivers/irqchip/irq-stm32mp-exti.c | 744 ++++++++++++++++++++++++++++-
 4 files changed, 751 insertions(+), 667 deletions(-)
 create mode 100644 drivers/irqchip/irq-stm32mp-exti.c

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index bc5e191..978639d 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -406,7 +406,8 @@ config PARTITION_PERCPU
 
 config STM32MP_EXTI
 	bool
-	select STM32_EXTI
+	select IRQ_DOMAIN
+	select GENERIC_IRQ_CHIP
 
 config STM32_EXTI
 	bool
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index 1062e71..de091a9 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -84,6 +84,7 @@ obj-$(CONFIG_MVEBU_SEI)			+= irq-mvebu-sei.o
 obj-$(CONFIG_LS_EXTIRQ)			+= irq-ls-extirq.o
 obj-$(CONFIG_LS_SCFG_MSI)		+= irq-ls-scfg-msi.o
 obj-$(CONFIG_ARCH_ASPEED)		+= irq-aspeed-vic.o irq-aspeed-i2c-ic.o irq-aspeed-scu-ic.o
+obj-$(CONFIG_STM32MP_EXTI)		+= irq-stm32mp-exti.o
 obj-$(CONFIG_STM32_EXTI) 		+= irq-stm32-exti.o
 obj-$(CONFIG_QCOM_IRQ_COMBINER)		+= qcom-irq-combiner.o
 obj-$(CONFIG_IRQ_UNIPHIER_AIDET)	+= irq-uniphier-aidet.o
diff --git a/drivers/irqchip/irq-stm32-exti.c b/drivers/irqchip/irq-stm32-exti.c
index 2cc9f3b..7c6a008 100644
--- a/drivers/irqchip/irq-stm32-exti.c
+++ b/drivers/irqchip/irq-stm32-exti.c
@@ -1,45 +1,22 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
  * Copyright (C) Maxime Coquelin 2015
- * Copyright (C) STMicroelectronics 2017
+ * Copyright (C) STMicroelectronics 2017-2024
  * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
  */
 
 #include <linux/bitops.h>
-#include <linux/delay.h>
-#include <linux/hwspinlock.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
-#include <linux/mod_devicetable.h>
-#include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
-#include <linux/platform_device.h>
-#include <linux/pm.h>
-
-#include <dt-bindings/interrupt-controller/arm-gic.h>
 
 #define IRQS_PER_BANK			32
 
-#define HWSPNLCK_TIMEOUT		1000 /* usec */
-
-#define EXTI_EnCIDCFGR(n)		(0x180 + (n) * 4)
-#define EXTI_HWCFGR1			0x3f0
-
-/* Register: EXTI_EnCIDCFGR(n) */
-#define EXTI_CIDCFGR_CFEN_MASK		BIT(0)
-#define EXTI_CIDCFGR_CID_MASK		GENMASK(6, 4)
-#define EXTI_CIDCFGR_CID_SHIFT		4
-
-/* Register: EXTI_HWCFGR1 */
-#define EXTI_HWCFGR1_CIDWIDTH_MASK	GENMASK(27, 24)
-
-#define EXTI_CID1			1
-
 struct stm32_exti_bank {
 	u32 imr_ofst;
 	u32 emr_ofst;
@@ -47,13 +24,8 @@ struct stm32_exti_bank {
 	u32 ftsr_ofst;
 	u32 swier_ofst;
 	u32 rpr_ofst;
-	u32 fpr_ofst;
-	u32 trg_ofst;
-	u32 seccfgr_ofst;
 };
 
-#define UNDEF_REG ~0
-
 struct stm32_exti_drv_data {
 	const struct stm32_exti_bank **exti_banks;
 	const u8 *desc_irqs;
@@ -63,7 +35,6 @@ struct stm32_exti_drv_data {
 struct stm32_exti_chip_data {
 	struct stm32_exti_host_data *host_data;
 	const struct stm32_exti_bank *reg_bank;
-	struct raw_spinlock rlock;
 	u32 wake_active;
 	u32 mask_cache;
 	u32 rtsr_cache;
@@ -76,8 +47,6 @@ struct stm32_exti_host_data {
 	struct device *dev;
 	struct stm32_exti_chip_data *chips_data;
 	const struct stm32_exti_drv_data *drv_data;
-	struct hwspinlock *hwlock;
-	bool dt_has_irqs_desc; /* skip internal desc_irqs array and get it from DT */
 };
 
 static const struct stm32_exti_bank stm32f4xx_exti_b1 = {
@@ -87,9 +56,6 @@ static const struct stm32_exti_bank stm32f4xx_exti_b1 = {
 	.ftsr_ofst	= 0x0C,
 	.swier_ofst	= 0x10,
 	.rpr_ofst	= 0x14,
-	.fpr_ofst	= UNDEF_REG,
-	.trg_ofst	= UNDEF_REG,
-	.seccfgr_ofst	= UNDEF_REG,
 };
 
 static const struct stm32_exti_bank *stm32f4xx_exti_banks[] = {
@@ -108,9 +74,6 @@ static const struct stm32_exti_bank stm32h7xx_exti_b1 = {
 	.ftsr_ofst	= 0x04,
 	.swier_ofst	= 0x08,
 	.rpr_ofst	= 0x88,
-	.fpr_ofst	= UNDEF_REG,
-	.trg_ofst	= UNDEF_REG,
-	.seccfgr_ofst	= UNDEF_REG,
 };
 
 static const struct stm32_exti_bank stm32h7xx_exti_b2 = {
@@ -120,9 +83,6 @@ static const struct stm32_exti_bank stm32h7xx_exti_b2 = {
 	.ftsr_ofst	= 0x24,
 	.swier_ofst	= 0x28,
 	.rpr_ofst	= 0x98,
-	.fpr_ofst	= UNDEF_REG,
-	.trg_ofst	= UNDEF_REG,
-	.seccfgr_ofst	= UNDEF_REG,
 };
 
 static const struct stm32_exti_bank stm32h7xx_exti_b3 = {
@@ -132,9 +92,6 @@ static const struct stm32_exti_bank stm32h7xx_exti_b3 = {
 	.ftsr_ofst	= 0x44,
 	.swier_ofst	= 0x48,
 	.rpr_ofst	= 0xA8,
-	.fpr_ofst	= UNDEF_REG,
-	.trg_ofst	= UNDEF_REG,
-	.seccfgr_ofst	= UNDEF_REG,
 };
 
 static const struct stm32_exti_bank *stm32h7xx_exti_banks[] = {
@@ -148,183 +105,12 @@ static const struct stm32_exti_drv_data stm32h7xx_drv_data = {
 	.bank_nr = ARRAY_SIZE(stm32h7xx_exti_banks),
 };
 
-static const struct stm32_exti_bank stm32mp1_exti_b1 = {
-	.imr_ofst	= 0x80,
-	.emr_ofst	= UNDEF_REG,
-	.rtsr_ofst	= 0x00,
-	.ftsr_ofst	= 0x04,
-	.swier_ofst	= 0x08,
-	.rpr_ofst	= 0x0C,
-	.fpr_ofst	= 0x10,
-	.trg_ofst	= 0x3EC,
-	.seccfgr_ofst	= 0x14,
-};
-
-static const struct stm32_exti_bank stm32mp1_exti_b2 = {
-	.imr_ofst	= 0x90,
-	.emr_ofst	= UNDEF_REG,
-	.rtsr_ofst	= 0x20,
-	.ftsr_ofst	= 0x24,
-	.swier_ofst	= 0x28,
-	.rpr_ofst	= 0x2C,
-	.fpr_ofst	= 0x30,
-	.trg_ofst	= 0x3E8,
-	.seccfgr_ofst	= 0x34,
-};
-
-static const struct stm32_exti_bank stm32mp1_exti_b3 = {
-	.imr_ofst	= 0xA0,
-	.emr_ofst	= UNDEF_REG,
-	.rtsr_ofst	= 0x40,
-	.ftsr_ofst	= 0x44,
-	.swier_ofst	= 0x48,
-	.rpr_ofst	= 0x4C,
-	.fpr_ofst	= 0x50,
-	.trg_ofst	= 0x3E4,
-	.seccfgr_ofst	= 0x54,
-};
-
-static const struct stm32_exti_bank *stm32mp1_exti_banks[] = {
-	&stm32mp1_exti_b1,
-	&stm32mp1_exti_b2,
-	&stm32mp1_exti_b3,
-};
-
-static struct irq_chip stm32_exti_h_chip;
-static struct irq_chip stm32_exti_h_chip_direct;
-
-#define EXTI_INVALID_IRQ       U8_MAX
-#define STM32MP1_DESC_IRQ_SIZE (ARRAY_SIZE(stm32mp1_exti_banks) * IRQS_PER_BANK)
-
-/*
- * Use some intentionally tricky logic here to initialize the whole array to
- * EXTI_INVALID_IRQ, but then override certain fields, requiring us to indicate
- * that we "know" that there are overrides in this structure, and we'll need to
- * disable that warning from W=1 builds.
- */
-__diag_push();
-__diag_ignore_all("-Woverride-init",
-		  "logic to initialize all and then override some is OK");
-
-static const u8 stm32mp1_desc_irq[] = {
-	/* default value */
-	[0 ... (STM32MP1_DESC_IRQ_SIZE - 1)] = EXTI_INVALID_IRQ,
-
-	[0] = 6,
-	[1] = 7,
-	[2] = 8,
-	[3] = 9,
-	[4] = 10,
-	[5] = 23,
-	[6] = 64,
-	[7] = 65,
-	[8] = 66,
-	[9] = 67,
-	[10] = 40,
-	[11] = 42,
-	[12] = 76,
-	[13] = 77,
-	[14] = 121,
-	[15] = 127,
-	[16] = 1,
-	[19] = 3,
-	[21] = 31,
-	[22] = 33,
-	[23] = 72,
-	[24] = 95,
-	[25] = 107,
-	[26] = 37,
-	[27] = 38,
-	[28] = 39,
-	[29] = 71,
-	[30] = 52,
-	[31] = 53,
-	[32] = 82,
-	[33] = 83,
-	[46] = 151,
-	[47] = 93,
-	[48] = 138,
-	[50] = 139,
-	[52] = 140,
-	[53] = 141,
-	[54] = 135,
-	[61] = 100,
-	[65] = 144,
-	[68] = 143,
-	[70] = 62,
-	[73] = 129,
-};
-
-static const u8 stm32mp13_desc_irq[] = {
-	/* default value */
-	[0 ... (STM32MP1_DESC_IRQ_SIZE - 1)] = EXTI_INVALID_IRQ,
-
-	[0] = 6,
-	[1] = 7,
-	[2] = 8,
-	[3] = 9,
-	[4] = 10,
-	[5] = 24,
-	[6] = 65,
-	[7] = 66,
-	[8] = 67,
-	[9] = 68,
-	[10] = 41,
-	[11] = 43,
-	[12] = 77,
-	[13] = 78,
-	[14] = 106,
-	[15] = 109,
-	[16] = 1,
-	[19] = 3,
-	[21] = 32,
-	[22] = 34,
-	[23] = 73,
-	[24] = 93,
-	[25] = 114,
-	[26] = 38,
-	[27] = 39,
-	[28] = 40,
-	[29] = 72,
-	[30] = 53,
-	[31] = 54,
-	[32] = 83,
-	[33] = 84,
-	[44] = 96,
-	[47] = 92,
-	[48] = 116,
-	[50] = 117,
-	[52] = 118,
-	[53] = 119,
-	[68] = 63,
-	[70] = 98,
-};
-
-__diag_pop();
-
-static const struct stm32_exti_drv_data stm32mp1_drv_data = {
-	.exti_banks = stm32mp1_exti_banks,
-	.bank_nr = ARRAY_SIZE(stm32mp1_exti_banks),
-	.desc_irqs = stm32mp1_desc_irq,
-};
-
-static const struct stm32_exti_drv_data stm32mp13_drv_data = {
-	.exti_banks = stm32mp1_exti_banks,
-	.bank_nr = ARRAY_SIZE(stm32mp1_exti_banks),
-	.desc_irqs = stm32mp13_desc_irq,
-};
-
 static unsigned long stm32_exti_pending(struct irq_chip_generic *gc)
 {
 	struct stm32_exti_chip_data *chip_data = gc->private;
 	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
-	unsigned long pending;
 
-	pending = irq_reg_readl(gc, stm32_bank->rpr_ofst);
-	if (stm32_bank->fpr_ofst != UNDEF_REG)
-		pending |= irq_reg_readl(gc, stm32_bank->fpr_ofst);
-
-	return pending;
+	return irq_reg_readl(gc, stm32_bank->rpr_ofst);
 }
 
 static void stm32_irq_handler(struct irq_desc *desc)
@@ -380,33 +166,21 @@ static int stm32_irq_set_type(struct irq_data *d, unsigned int type)
 	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
 	struct stm32_exti_chip_data *chip_data = gc->private;
 	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
-	struct hwspinlock *hwlock = chip_data->host_data->hwlock;
 	u32 rtsr, ftsr;
 	int err;
 
 	irq_gc_lock(gc);
 
-	if (hwlock) {
-		err = hwspin_lock_timeout_in_atomic(hwlock, HWSPNLCK_TIMEOUT);
-		if (err) {
-			pr_err("%s can't get hwspinlock (%d)\n", __func__, err);
-			goto unlock;
-		}
-	}
-
 	rtsr = irq_reg_readl(gc, stm32_bank->rtsr_ofst);
 	ftsr = irq_reg_readl(gc, stm32_bank->ftsr_ofst);
 
 	err = stm32_exti_set_type(d, type, &rtsr, &ftsr);
 	if (err)
-		goto unspinlock;
+		goto unlock;
 
 	irq_reg_writel(gc, rtsr, stm32_bank->rtsr_ofst);
 	irq_reg_writel(gc, ftsr, stm32_bank->ftsr_ofst);
 
-unspinlock:
-	if (hwlock)
-		hwspin_unlock_in_atomic(hwlock);
 unlock:
 	irq_gc_unlock(gc);
 
@@ -494,287 +268,10 @@ static void stm32_irq_ack(struct irq_data *d)
 	irq_gc_lock(gc);
 
 	irq_reg_writel(gc, d->mask, stm32_bank->rpr_ofst);
-	if (stm32_bank->fpr_ofst != UNDEF_REG)
-		irq_reg_writel(gc, d->mask, stm32_bank->fpr_ofst);
 
 	irq_gc_unlock(gc);
 }
 
-/* directly set the target bit without reading first. */
-static inline void stm32_exti_write_bit(struct irq_data *d, u32 reg)
-{
-	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
-	void __iomem *base = chip_data->host_data->base;
-	u32 val = BIT(d->hwirq % IRQS_PER_BANK);
-
-	writel_relaxed(val, base + reg);
-}
-
-static inline u32 stm32_exti_set_bit(struct irq_data *d, u32 reg)
-{
-	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
-	void __iomem *base = chip_data->host_data->base;
-	u32 val;
-
-	val = readl_relaxed(base + reg);
-	val |= BIT(d->hwirq % IRQS_PER_BANK);
-	writel_relaxed(val, base + reg);
-
-	return val;
-}
-
-static inline u32 stm32_exti_clr_bit(struct irq_data *d, u32 reg)
-{
-	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
-	void __iomem *base = chip_data->host_data->base;
-	u32 val;
-
-	val = readl_relaxed(base + reg);
-	val &= ~BIT(d->hwirq % IRQS_PER_BANK);
-	writel_relaxed(val, base + reg);
-
-	return val;
-}
-
-static void stm32_exti_h_eoi(struct irq_data *d)
-{
-	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
-	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
-
-	raw_spin_lock(&chip_data->rlock);
-
-	stm32_exti_write_bit(d, stm32_bank->rpr_ofst);
-	if (stm32_bank->fpr_ofst != UNDEF_REG)
-		stm32_exti_write_bit(d, stm32_bank->fpr_ofst);
-
-	raw_spin_unlock(&chip_data->rlock);
-
-	if (d->parent_data->chip)
-		irq_chip_eoi_parent(d);
-}
-
-static void stm32_exti_h_mask(struct irq_data *d)
-{
-	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
-	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
-
-	raw_spin_lock(&chip_data->rlock);
-	chip_data->mask_cache = stm32_exti_clr_bit(d, stm32_bank->imr_ofst);
-	raw_spin_unlock(&chip_data->rlock);
-
-	if (d->parent_data->chip)
-		irq_chip_mask_parent(d);
-}
-
-static void stm32_exti_h_unmask(struct irq_data *d)
-{
-	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
-	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
-
-	raw_spin_lock(&chip_data->rlock);
-	chip_data->mask_cache = stm32_exti_set_bit(d, stm32_bank->imr_ofst);
-	raw_spin_unlock(&chip_data->rlock);
-
-	if (d->parent_data->chip)
-		irq_chip_unmask_parent(d);
-}
-
-static int stm32_exti_h_set_type(struct irq_data *d, unsigned int type)
-{
-	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
-	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
-	struct hwspinlock *hwlock = chip_data->host_data->hwlock;
-	void __iomem *base = chip_data->host_data->base;
-	u32 rtsr, ftsr;
-	int err;
-
-	raw_spin_lock(&chip_data->rlock);
-
-	if (hwlock) {
-		err = hwspin_lock_timeout_in_atomic(hwlock, HWSPNLCK_TIMEOUT);
-		if (err) {
-			pr_err("%s can't get hwspinlock (%d)\n", __func__, err);
-			goto unlock;
-		}
-	}
-
-	rtsr = readl_relaxed(base + stm32_bank->rtsr_ofst);
-	ftsr = readl_relaxed(base + stm32_bank->ftsr_ofst);
-
-	err = stm32_exti_set_type(d, type, &rtsr, &ftsr);
-	if (err)
-		goto unspinlock;
-
-	writel_relaxed(rtsr, base + stm32_bank->rtsr_ofst);
-	writel_relaxed(ftsr, base + stm32_bank->ftsr_ofst);
-
-unspinlock:
-	if (hwlock)
-		hwspin_unlock_in_atomic(hwlock);
-unlock:
-	raw_spin_unlock(&chip_data->rlock);
-
-	return err;
-}
-
-static int stm32_exti_h_set_wake(struct irq_data *d, unsigned int on)
-{
-	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
-	u32 mask = BIT(d->hwirq % IRQS_PER_BANK);
-
-	raw_spin_lock(&chip_data->rlock);
-
-	if (on)
-		chip_data->wake_active |= mask;
-	else
-		chip_data->wake_active &= ~mask;
-
-	raw_spin_unlock(&chip_data->rlock);
-
-	return 0;
-}
-
-static int stm32_exti_h_set_affinity(struct irq_data *d,
-				     const struct cpumask *dest, bool force)
-{
-	if (d->parent_data->chip)
-		return irq_chip_set_affinity_parent(d, dest, force);
-
-	return IRQ_SET_MASK_OK_DONE;
-}
-
-static int stm32_exti_h_suspend(struct device *dev)
-{
-	struct stm32_exti_host_data *host_data = dev_get_drvdata(dev);
-	struct stm32_exti_chip_data *chip_data;
-	int i;
-
-	for (i = 0; i < host_data->drv_data->bank_nr; i++) {
-		chip_data = &host_data->chips_data[i];
-		stm32_chip_suspend(chip_data, chip_data->wake_active);
-	}
-
-	return 0;
-}
-
-static int stm32_exti_h_resume(struct device *dev)
-{
-	struct stm32_exti_host_data *host_data = dev_get_drvdata(dev);
-	struct stm32_exti_chip_data *chip_data;
-	int i;
-
-	for (i = 0; i < host_data->drv_data->bank_nr; i++) {
-		chip_data = &host_data->chips_data[i];
-		stm32_chip_resume(chip_data, chip_data->mask_cache);
-	}
-
-	return 0;
-}
-
-static int stm32_exti_h_retrigger(struct irq_data *d)
-{
-	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
-	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
-	void __iomem *base = chip_data->host_data->base;
-	u32 mask = BIT(d->hwirq % IRQS_PER_BANK);
-
-	writel_relaxed(mask, base + stm32_bank->swier_ofst);
-
-	return 0;
-}
-
-static struct irq_chip stm32_exti_h_chip = {
-	.name			= "stm32-exti-h",
-	.irq_eoi		= stm32_exti_h_eoi,
-	.irq_mask		= stm32_exti_h_mask,
-	.irq_unmask		= stm32_exti_h_unmask,
-	.irq_retrigger		= stm32_exti_h_retrigger,
-	.irq_set_type		= stm32_exti_h_set_type,
-	.irq_set_wake		= stm32_exti_h_set_wake,
-	.flags			= IRQCHIP_MASK_ON_SUSPEND,
-	.irq_set_affinity	= IS_ENABLED(CONFIG_SMP) ? stm32_exti_h_set_affinity : NULL,
-};
-
-static struct irq_chip stm32_exti_h_chip_direct = {
-	.name			= "stm32-exti-h-direct",
-	.irq_eoi		= irq_chip_eoi_parent,
-	.irq_ack		= irq_chip_ack_parent,
-	.irq_mask		= stm32_exti_h_mask,
-	.irq_unmask		= stm32_exti_h_unmask,
-	.irq_retrigger		= irq_chip_retrigger_hierarchy,
-	.irq_set_type		= irq_chip_set_type_parent,
-	.irq_set_wake		= stm32_exti_h_set_wake,
-	.flags			= IRQCHIP_MASK_ON_SUSPEND,
-	.irq_set_affinity	= IS_ENABLED(CONFIG_SMP) ? irq_chip_set_affinity_parent : NULL,
-};
-
-static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
-				     unsigned int virq,
-				     unsigned int nr_irqs, void *data)
-{
-	struct stm32_exti_host_data *host_data = dm->host_data;
-	struct stm32_exti_chip_data *chip_data;
-	u8 desc_irq;
-	struct irq_fwspec *fwspec = data;
-	struct irq_fwspec p_fwspec;
-	irq_hw_number_t hwirq;
-	int bank;
-	u32 event_trg;
-	struct irq_chip *chip;
-
-	hwirq = fwspec->param[0];
-	if (hwirq >= host_data->drv_data->bank_nr * IRQS_PER_BANK)
-		return -EINVAL;
-
-	bank  = hwirq / IRQS_PER_BANK;
-	chip_data = &host_data->chips_data[bank];
-
-	/* Check if event is reserved (Secure) */
-	if (chip_data->event_reserved & BIT(hwirq % IRQS_PER_BANK)) {
-		dev_err(host_data->dev, "event %lu is reserved, secure\n", hwirq);
-		return -EPERM;
-	}
-
-	event_trg = readl_relaxed(host_data->base + chip_data->reg_bank->trg_ofst);
-	chip = (event_trg & BIT(hwirq % IRQS_PER_BANK)) ?
-	       &stm32_exti_h_chip : &stm32_exti_h_chip_direct;
-
-	irq_domain_set_hwirq_and_chip(dm, virq, hwirq, chip, chip_data);
-
-	if (host_data->dt_has_irqs_desc) {
-		struct of_phandle_args out_irq;
-		int ret;
-
-		ret = of_irq_parse_one(host_data->dev->of_node, hwirq, &out_irq);
-		if (ret)
-			return ret;
-		/* we only support one parent, so far */
-		if (of_node_to_fwnode(out_irq.np) != dm->parent->fwnode)
-			return -EINVAL;
-
-		of_phandle_args_to_fwspec(out_irq.np, out_irq.args,
-					  out_irq.args_count, &p_fwspec);
-
-		return irq_domain_alloc_irqs_parent(dm, virq, 1, &p_fwspec);
-	}
-
-	if (!host_data->drv_data->desc_irqs)
-		return -EINVAL;
-
-	desc_irq = host_data->drv_data->desc_irqs[hwirq];
-	if (desc_irq != EXTI_INVALID_IRQ) {
-		p_fwspec.fwnode = dm->parent->fwnode;
-		p_fwspec.param_count = 3;
-		p_fwspec.param[0] = GIC_SPI;
-		p_fwspec.param[1] = desc_irq;
-		p_fwspec.param[2] = IRQ_TYPE_LEVEL_HIGH;
-
-		return irq_domain_alloc_irqs_parent(dm, virq, 1, &p_fwspec);
-	}
-
-	return 0;
-}
-
 static struct
 stm32_exti_host_data *stm32_exti_host_init(const struct stm32_exti_drv_data *dd,
 					   struct device_node *node)
@@ -822,19 +319,12 @@ stm32_exti_chip_data *stm32_exti_chip_init(struct stm32_exti_host_data *h_data,
 	chip_data->host_data = h_data;
 	chip_data->reg_bank = stm32_bank;
 
-	raw_spin_lock_init(&chip_data->rlock);
-
 	/*
 	 * This IP has no reset, so after hot reboot we should
 	 * clear registers to avoid residue
 	 */
 	writel_relaxed(0, base + stm32_bank->imr_ofst);
-	if (stm32_bank->emr_ofst != UNDEF_REG)
-		writel_relaxed(0, base + stm32_bank->emr_ofst);
-
-	/* reserve Secure events */
-	if (stm32_bank->seccfgr_ofst != UNDEF_REG)
-		chip_data->event_reserved = readl_relaxed(base + stm32_bank->seccfgr_ofst);
+	writel_relaxed(0, base + stm32_bank->emr_ofst);
 
 	pr_info("%pOF: bank%d\n", node, bank_idx);
 
@@ -914,158 +404,6 @@ out_unmap:
 	return ret;
 }
 
-static const struct irq_domain_ops stm32_exti_h_domain_ops = {
-	.alloc	= stm32_exti_h_domain_alloc,
-	.free	= irq_domain_free_irqs_common,
-	.xlate = irq_domain_xlate_twocell,
-};
-
-static void stm32_exti_check_rif(struct stm32_exti_host_data *host_data)
-{
-	unsigned int bank, i, event;
-	u32 cid, cidcfgr, hwcfgr1;
-
-	/* quit on CID not supported */
-	hwcfgr1 = readl_relaxed(host_data->base + EXTI_HWCFGR1);
-	if ((hwcfgr1 & EXTI_HWCFGR1_CIDWIDTH_MASK) == 0)
-		return;
-
-	for (bank = 0; bank < host_data->drv_data->bank_nr; bank++) {
-		for (i = 0; i < IRQS_PER_BANK; i++) {
-			event = bank * IRQS_PER_BANK + i;
-			cidcfgr = readl_relaxed(host_data->base + EXTI_EnCIDCFGR(event));
-			cid = (cidcfgr & EXTI_CIDCFGR_CID_MASK) >> EXTI_CIDCFGR_CID_SHIFT;
-			if ((cidcfgr & EXTI_CIDCFGR_CFEN_MASK) && cid != EXTI_CID1)
-				host_data->chips_data[bank].event_reserved |= BIT(i);
-		}
-	}
-}
-
-static void stm32_exti_remove_irq(void *data)
-{
-	struct irq_domain *domain = data;
-
-	irq_domain_remove(domain);
-}
-
-static int stm32_exti_probe(struct platform_device *pdev)
-{
-	int ret, i;
-	struct device *dev = &pdev->dev;
-	struct device_node *np = dev->of_node;
-	struct irq_domain *parent_domain, *domain;
-	struct stm32_exti_host_data *host_data;
-	const struct stm32_exti_drv_data *drv_data;
-
-	host_data = devm_kzalloc(dev, sizeof(*host_data), GFP_KERNEL);
-	if (!host_data)
-		return -ENOMEM;
-
-	dev_set_drvdata(dev, host_data);
-	host_data->dev = dev;
-
-	/* check for optional hwspinlock which may be not available yet */
-	ret = of_hwspin_lock_get_id(np, 0);
-	if (ret == -EPROBE_DEFER)
-		/* hwspinlock framework not yet ready */
-		return ret;
-
-	if (ret >= 0) {
-		host_data->hwlock = devm_hwspin_lock_request_specific(dev, ret);
-		if (!host_data->hwlock) {
-			dev_err(dev, "Failed to request hwspinlock\n");
-			return -EINVAL;
-		}
-	} else if (ret != -ENOENT) {
-		/* note: ENOENT is a valid case (means 'no hwspinlock') */
-		dev_err(dev, "Failed to get hwspinlock\n");
-		return ret;
-	}
-
-	/* initialize host_data */
-	drv_data = of_device_get_match_data(dev);
-	if (!drv_data) {
-		dev_err(dev, "no of match data\n");
-		return -ENODEV;
-	}
-	host_data->drv_data = drv_data;
-
-	host_data->chips_data = devm_kcalloc(dev, drv_data->bank_nr,
-					     sizeof(*host_data->chips_data),
-					     GFP_KERNEL);
-	if (!host_data->chips_data)
-		return -ENOMEM;
-
-	host_data->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(host_data->base))
-		return PTR_ERR(host_data->base);
-
-	for (i = 0; i < drv_data->bank_nr; i++)
-		stm32_exti_chip_init(host_data, i, np);
-
-	stm32_exti_check_rif(host_data);
-
-	parent_domain = irq_find_host(of_irq_find_parent(np));
-	if (!parent_domain) {
-		dev_err(dev, "GIC interrupt-parent not found\n");
-		return -EINVAL;
-	}
-
-	domain = irq_domain_add_hierarchy(parent_domain, 0,
-					  drv_data->bank_nr * IRQS_PER_BANK,
-					  np, &stm32_exti_h_domain_ops,
-					  host_data);
-
-	if (!domain) {
-		dev_err(dev, "Could not register exti domain\n");
-		return -ENOMEM;
-	}
-
-	ret = devm_add_action_or_reset(dev, stm32_exti_remove_irq, domain);
-	if (ret)
-		return ret;
-
-	if (of_property_read_bool(np, "interrupts-extended"))
-		host_data->dt_has_irqs_desc = true;
-
-	return 0;
-}
-
-/* platform driver only for MP1 */
-static const struct of_device_id stm32_exti_ids[] = {
-	{ .compatible = "st,stm32mp1-exti", .data = &stm32mp1_drv_data},
-	{ .compatible = "st,stm32mp13-exti", .data = &stm32mp13_drv_data},
-	{},
-};
-MODULE_DEVICE_TABLE(of, stm32_exti_ids);
-
-static const struct dev_pm_ops stm32_exti_dev_pm_ops = {
-	NOIRQ_SYSTEM_SLEEP_PM_OPS(stm32_exti_h_suspend, stm32_exti_h_resume)
-};
-
-static struct platform_driver stm32_exti_driver = {
-	.probe		= stm32_exti_probe,
-	.driver		= {
-		.name		= "stm32_exti",
-		.of_match_table	= stm32_exti_ids,
-		.pm		= &stm32_exti_dev_pm_ops,
-	},
-};
-
-static int __init stm32_exti_arch_init(void)
-{
-	return platform_driver_register(&stm32_exti_driver);
-}
-
-static void __exit stm32_exti_arch_exit(void)
-{
-	return platform_driver_unregister(&stm32_exti_driver);
-}
-
-arch_initcall(stm32_exti_arch_init);
-module_exit(stm32_exti_arch_exit);
-
-/* no platform driver for F4 and H7 */
 static int __init stm32f4_exti_of_init(struct device_node *np,
 				       struct device_node *parent)
 {
diff --git a/drivers/irqchip/irq-stm32mp-exti.c b/drivers/irqchip/irq-stm32mp-exti.c
new file mode 100644
index 0000000..8a45ece
--- /dev/null
+++ b/drivers/irqchip/irq-stm32mp-exti.c
@@ -0,0 +1,744 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) Maxime Coquelin 2015
+ * Copyright (C) STMicroelectronics 2017-2024
+ * Author:  Maxime Coquelin <mcoquelin.stm32@gmail.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/hwspinlock.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/irq.h>
+#include <linux/irqchip.h>
+#include <linux/irqdomain.h>
+#include <linux/mod_devicetable.h>
+#include <linux/module.h>
+#include <linux/of_address.h>
+#include <linux/of_irq.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+
+#include <dt-bindings/interrupt-controller/arm-gic.h>
+
+#define IRQS_PER_BANK			32
+
+#define HWSPNLCK_TIMEOUT		1000 /* usec */
+
+#define EXTI_EnCIDCFGR(n)		(0x180 + (n) * 4)
+#define EXTI_HWCFGR1			0x3f0
+
+/* Register: EXTI_EnCIDCFGR(n) */
+#define EXTI_CIDCFGR_CFEN_MASK		BIT(0)
+#define EXTI_CIDCFGR_CID_MASK		GENMASK(6, 4)
+#define EXTI_CIDCFGR_CID_SHIFT		4
+
+/* Register: EXTI_HWCFGR1 */
+#define EXTI_HWCFGR1_CIDWIDTH_MASK	GENMASK(27, 24)
+
+#define EXTI_CID1			1
+
+struct stm32_exti_bank {
+	u32 imr_ofst;
+	u32 rtsr_ofst;
+	u32 ftsr_ofst;
+	u32 swier_ofst;
+	u32 rpr_ofst;
+	u32 fpr_ofst;
+	u32 trg_ofst;
+	u32 seccfgr_ofst;
+};
+
+struct stm32_exti_drv_data {
+	const struct stm32_exti_bank **exti_banks;
+	const u8 *desc_irqs;
+	u32 bank_nr;
+};
+
+struct stm32_exti_chip_data {
+	struct stm32_exti_host_data *host_data;
+	const struct stm32_exti_bank *reg_bank;
+	struct raw_spinlock rlock;
+	u32 wake_active;
+	u32 mask_cache;
+	u32 rtsr_cache;
+	u32 ftsr_cache;
+	u32 event_reserved;
+};
+
+struct stm32_exti_host_data {
+	void __iomem *base;
+	struct device *dev;
+	struct stm32_exti_chip_data *chips_data;
+	const struct stm32_exti_drv_data *drv_data;
+	struct hwspinlock *hwlock;
+	bool dt_has_irqs_desc; /* skip internal desc_irqs array and get it from DT */
+};
+
+static const struct stm32_exti_bank stm32mp1_exti_b1 = {
+	.imr_ofst	= 0x80,
+	.rtsr_ofst	= 0x00,
+	.ftsr_ofst	= 0x04,
+	.swier_ofst	= 0x08,
+	.rpr_ofst	= 0x0C,
+	.fpr_ofst	= 0x10,
+	.trg_ofst	= 0x3EC,
+	.seccfgr_ofst	= 0x14,
+};
+
+static const struct stm32_exti_bank stm32mp1_exti_b2 = {
+	.imr_ofst	= 0x90,
+	.rtsr_ofst	= 0x20,
+	.ftsr_ofst	= 0x24,
+	.swier_ofst	= 0x28,
+	.rpr_ofst	= 0x2C,
+	.fpr_ofst	= 0x30,
+	.trg_ofst	= 0x3E8,
+	.seccfgr_ofst	= 0x34,
+};
+
+static const struct stm32_exti_bank stm32mp1_exti_b3 = {
+	.imr_ofst	= 0xA0,
+	.rtsr_ofst	= 0x40,
+	.ftsr_ofst	= 0x44,
+	.swier_ofst	= 0x48,
+	.rpr_ofst	= 0x4C,
+	.fpr_ofst	= 0x50,
+	.trg_ofst	= 0x3E4,
+	.seccfgr_ofst	= 0x54,
+};
+
+static const struct stm32_exti_bank *stm32mp1_exti_banks[] = {
+	&stm32mp1_exti_b1,
+	&stm32mp1_exti_b2,
+	&stm32mp1_exti_b3,
+};
+
+static struct irq_chip stm32_exti_h_chip;
+static struct irq_chip stm32_exti_h_chip_direct;
+
+#define EXTI_INVALID_IRQ       U8_MAX
+#define STM32MP1_DESC_IRQ_SIZE (ARRAY_SIZE(stm32mp1_exti_banks) * IRQS_PER_BANK)
+
+/*
+ * Use some intentionally tricky logic here to initialize the whole array to
+ * EXTI_INVALID_IRQ, but then override certain fields, requiring us to indicate
+ * that we "know" that there are overrides in this structure, and we'll need to
+ * disable that warning from W=1 builds.
+ */
+__diag_push();
+__diag_ignore_all("-Woverride-init",
+		  "logic to initialize all and then override some is OK");
+
+static const u8 stm32mp1_desc_irq[] = {
+	/* default value */
+	[0 ... (STM32MP1_DESC_IRQ_SIZE - 1)] = EXTI_INVALID_IRQ,
+
+	[0] = 6,
+	[1] = 7,
+	[2] = 8,
+	[3] = 9,
+	[4] = 10,
+	[5] = 23,
+	[6] = 64,
+	[7] = 65,
+	[8] = 66,
+	[9] = 67,
+	[10] = 40,
+	[11] = 42,
+	[12] = 76,
+	[13] = 77,
+	[14] = 121,
+	[15] = 127,
+	[16] = 1,
+	[19] = 3,
+	[21] = 31,
+	[22] = 33,
+	[23] = 72,
+	[24] = 95,
+	[25] = 107,
+	[26] = 37,
+	[27] = 38,
+	[28] = 39,
+	[29] = 71,
+	[30] = 52,
+	[31] = 53,
+	[32] = 82,
+	[33] = 83,
+	[46] = 151,
+	[47] = 93,
+	[48] = 138,
+	[50] = 139,
+	[52] = 140,
+	[53] = 141,
+	[54] = 135,
+	[61] = 100,
+	[65] = 144,
+	[68] = 143,
+	[70] = 62,
+	[73] = 129,
+};
+
+static const u8 stm32mp13_desc_irq[] = {
+	/* default value */
+	[0 ... (STM32MP1_DESC_IRQ_SIZE - 1)] = EXTI_INVALID_IRQ,
+
+	[0] = 6,
+	[1] = 7,
+	[2] = 8,
+	[3] = 9,
+	[4] = 10,
+	[5] = 24,
+	[6] = 65,
+	[7] = 66,
+	[8] = 67,
+	[9] = 68,
+	[10] = 41,
+	[11] = 43,
+	[12] = 77,
+	[13] = 78,
+	[14] = 106,
+	[15] = 109,
+	[16] = 1,
+	[19] = 3,
+	[21] = 32,
+	[22] = 34,
+	[23] = 73,
+	[24] = 93,
+	[25] = 114,
+	[26] = 38,
+	[27] = 39,
+	[28] = 40,
+	[29] = 72,
+	[30] = 53,
+	[31] = 54,
+	[32] = 83,
+	[33] = 84,
+	[44] = 96,
+	[47] = 92,
+	[48] = 116,
+	[50] = 117,
+	[52] = 118,
+	[53] = 119,
+	[68] = 63,
+	[70] = 98,
+};
+
+__diag_pop();
+
+static const struct stm32_exti_drv_data stm32mp1_drv_data = {
+	.exti_banks = stm32mp1_exti_banks,
+	.bank_nr = ARRAY_SIZE(stm32mp1_exti_banks),
+	.desc_irqs = stm32mp1_desc_irq,
+};
+
+static const struct stm32_exti_drv_data stm32mp13_drv_data = {
+	.exti_banks = stm32mp1_exti_banks,
+	.bank_nr = ARRAY_SIZE(stm32mp1_exti_banks),
+	.desc_irqs = stm32mp13_desc_irq,
+};
+
+static int stm32_exti_set_type(struct irq_data *d,
+			       unsigned int type, u32 *rtsr, u32 *ftsr)
+{
+	u32 mask = BIT(d->hwirq % IRQS_PER_BANK);
+
+	switch (type) {
+	case IRQ_TYPE_EDGE_RISING:
+		*rtsr |= mask;
+		*ftsr &= ~mask;
+		break;
+	case IRQ_TYPE_EDGE_FALLING:
+		*rtsr &= ~mask;
+		*ftsr |= mask;
+		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		*rtsr |= mask;
+		*ftsr |= mask;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static void stm32_chip_suspend(struct stm32_exti_chip_data *chip_data,
+			       u32 wake_active)
+{
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+	void __iomem *base = chip_data->host_data->base;
+
+	/* save rtsr, ftsr registers */
+	chip_data->rtsr_cache = readl_relaxed(base + stm32_bank->rtsr_ofst);
+	chip_data->ftsr_cache = readl_relaxed(base + stm32_bank->ftsr_ofst);
+
+	writel_relaxed(wake_active, base + stm32_bank->imr_ofst);
+}
+
+static void stm32_chip_resume(struct stm32_exti_chip_data *chip_data,
+			      u32 mask_cache)
+{
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+	void __iomem *base = chip_data->host_data->base;
+
+	/* restore rtsr, ftsr, registers */
+	writel_relaxed(chip_data->rtsr_cache, base + stm32_bank->rtsr_ofst);
+	writel_relaxed(chip_data->ftsr_cache, base + stm32_bank->ftsr_ofst);
+
+	writel_relaxed(mask_cache, base + stm32_bank->imr_ofst);
+}
+
+/* directly set the target bit without reading first. */
+static inline void stm32_exti_write_bit(struct irq_data *d, u32 reg)
+{
+	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	void __iomem *base = chip_data->host_data->base;
+	u32 val = BIT(d->hwirq % IRQS_PER_BANK);
+
+	writel_relaxed(val, base + reg);
+}
+
+static inline u32 stm32_exti_set_bit(struct irq_data *d, u32 reg)
+{
+	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	void __iomem *base = chip_data->host_data->base;
+	u32 val;
+
+	val = readl_relaxed(base + reg);
+	val |= BIT(d->hwirq % IRQS_PER_BANK);
+	writel_relaxed(val, base + reg);
+
+	return val;
+}
+
+static inline u32 stm32_exti_clr_bit(struct irq_data *d, u32 reg)
+{
+	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	void __iomem *base = chip_data->host_data->base;
+	u32 val;
+
+	val = readl_relaxed(base + reg);
+	val &= ~BIT(d->hwirq % IRQS_PER_BANK);
+	writel_relaxed(val, base + reg);
+
+	return val;
+}
+
+static void stm32_exti_h_eoi(struct irq_data *d)
+{
+	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+
+	raw_spin_lock(&chip_data->rlock);
+
+	stm32_exti_write_bit(d, stm32_bank->rpr_ofst);
+	stm32_exti_write_bit(d, stm32_bank->fpr_ofst);
+
+	raw_spin_unlock(&chip_data->rlock);
+
+	if (d->parent_data->chip)
+		irq_chip_eoi_parent(d);
+}
+
+static void stm32_exti_h_mask(struct irq_data *d)
+{
+	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+
+	raw_spin_lock(&chip_data->rlock);
+	chip_data->mask_cache = stm32_exti_clr_bit(d, stm32_bank->imr_ofst);
+	raw_spin_unlock(&chip_data->rlock);
+
+	if (d->parent_data->chip)
+		irq_chip_mask_parent(d);
+}
+
+static void stm32_exti_h_unmask(struct irq_data *d)
+{
+	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+
+	raw_spin_lock(&chip_data->rlock);
+	chip_data->mask_cache = stm32_exti_set_bit(d, stm32_bank->imr_ofst);
+	raw_spin_unlock(&chip_data->rlock);
+
+	if (d->parent_data->chip)
+		irq_chip_unmask_parent(d);
+}
+
+static int stm32_exti_h_set_type(struct irq_data *d, unsigned int type)
+{
+	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+	struct hwspinlock *hwlock = chip_data->host_data->hwlock;
+	void __iomem *base = chip_data->host_data->base;
+	u32 rtsr, ftsr;
+	int err;
+
+	raw_spin_lock(&chip_data->rlock);
+
+	if (hwlock) {
+		err = hwspin_lock_timeout_in_atomic(hwlock, HWSPNLCK_TIMEOUT);
+		if (err) {
+			pr_err("%s can't get hwspinlock (%d)\n", __func__, err);
+			goto unlock;
+		}
+	}
+
+	rtsr = readl_relaxed(base + stm32_bank->rtsr_ofst);
+	ftsr = readl_relaxed(base + stm32_bank->ftsr_ofst);
+
+	err = stm32_exti_set_type(d, type, &rtsr, &ftsr);
+	if (err)
+		goto unspinlock;
+
+	writel_relaxed(rtsr, base + stm32_bank->rtsr_ofst);
+	writel_relaxed(ftsr, base + stm32_bank->ftsr_ofst);
+
+unspinlock:
+	if (hwlock)
+		hwspin_unlock_in_atomic(hwlock);
+unlock:
+	raw_spin_unlock(&chip_data->rlock);
+
+	return err;
+}
+
+static int stm32_exti_h_set_wake(struct irq_data *d, unsigned int on)
+{
+	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	u32 mask = BIT(d->hwirq % IRQS_PER_BANK);
+
+	raw_spin_lock(&chip_data->rlock);
+
+	if (on)
+		chip_data->wake_active |= mask;
+	else
+		chip_data->wake_active &= ~mask;
+
+	raw_spin_unlock(&chip_data->rlock);
+
+	return 0;
+}
+
+static int stm32_exti_h_set_affinity(struct irq_data *d,
+				     const struct cpumask *dest, bool force)
+{
+	if (d->parent_data->chip)
+		return irq_chip_set_affinity_parent(d, dest, force);
+
+	return IRQ_SET_MASK_OK_DONE;
+}
+
+static int stm32_exti_h_suspend(struct device *dev)
+{
+	struct stm32_exti_host_data *host_data = dev_get_drvdata(dev);
+	struct stm32_exti_chip_data *chip_data;
+	int i;
+
+	for (i = 0; i < host_data->drv_data->bank_nr; i++) {
+		chip_data = &host_data->chips_data[i];
+		stm32_chip_suspend(chip_data, chip_data->wake_active);
+	}
+
+	return 0;
+}
+
+static int stm32_exti_h_resume(struct device *dev)
+{
+	struct stm32_exti_host_data *host_data = dev_get_drvdata(dev);
+	struct stm32_exti_chip_data *chip_data;
+	int i;
+
+	for (i = 0; i < host_data->drv_data->bank_nr; i++) {
+		chip_data = &host_data->chips_data[i];
+		stm32_chip_resume(chip_data, chip_data->mask_cache);
+	}
+
+	return 0;
+}
+
+static int stm32_exti_h_retrigger(struct irq_data *d)
+{
+	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+	void __iomem *base = chip_data->host_data->base;
+	u32 mask = BIT(d->hwirq % IRQS_PER_BANK);
+
+	writel_relaxed(mask, base + stm32_bank->swier_ofst);
+
+	return 0;
+}
+
+static struct irq_chip stm32_exti_h_chip = {
+	.name			= "stm32-exti-h",
+	.irq_eoi		= stm32_exti_h_eoi,
+	.irq_mask		= stm32_exti_h_mask,
+	.irq_unmask		= stm32_exti_h_unmask,
+	.irq_retrigger		= stm32_exti_h_retrigger,
+	.irq_set_type		= stm32_exti_h_set_type,
+	.irq_set_wake		= stm32_exti_h_set_wake,
+	.flags			= IRQCHIP_MASK_ON_SUSPEND,
+	.irq_set_affinity	= IS_ENABLED(CONFIG_SMP) ? stm32_exti_h_set_affinity : NULL,
+};
+
+static struct irq_chip stm32_exti_h_chip_direct = {
+	.name			= "stm32-exti-h-direct",
+	.irq_eoi		= irq_chip_eoi_parent,
+	.irq_ack		= irq_chip_ack_parent,
+	.irq_mask		= stm32_exti_h_mask,
+	.irq_unmask		= stm32_exti_h_unmask,
+	.irq_retrigger		= irq_chip_retrigger_hierarchy,
+	.irq_set_type		= irq_chip_set_type_parent,
+	.irq_set_wake		= stm32_exti_h_set_wake,
+	.flags			= IRQCHIP_MASK_ON_SUSPEND,
+	.irq_set_affinity	= IS_ENABLED(CONFIG_SMP) ? irq_chip_set_affinity_parent : NULL,
+};
+
+static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
+				     unsigned int virq,
+				     unsigned int nr_irqs, void *data)
+{
+	struct stm32_exti_host_data *host_data = dm->host_data;
+	struct stm32_exti_chip_data *chip_data;
+	u8 desc_irq;
+	struct irq_fwspec *fwspec = data;
+	struct irq_fwspec p_fwspec;
+	irq_hw_number_t hwirq;
+	int bank;
+	u32 event_trg;
+	struct irq_chip *chip;
+
+	hwirq = fwspec->param[0];
+	if (hwirq >= host_data->drv_data->bank_nr * IRQS_PER_BANK)
+		return -EINVAL;
+
+	bank  = hwirq / IRQS_PER_BANK;
+	chip_data = &host_data->chips_data[bank];
+
+	/* Check if event is reserved (Secure) */
+	if (chip_data->event_reserved & BIT(hwirq % IRQS_PER_BANK)) {
+		dev_err(host_data->dev, "event %lu is reserved, secure\n", hwirq);
+		return -EPERM;
+	}
+
+	event_trg = readl_relaxed(host_data->base + chip_data->reg_bank->trg_ofst);
+	chip = (event_trg & BIT(hwirq % IRQS_PER_BANK)) ?
+	       &stm32_exti_h_chip : &stm32_exti_h_chip_direct;
+
+	irq_domain_set_hwirq_and_chip(dm, virq, hwirq, chip, chip_data);
+
+	if (host_data->dt_has_irqs_desc) {
+		struct of_phandle_args out_irq;
+		int ret;
+
+		ret = of_irq_parse_one(host_data->dev->of_node, hwirq, &out_irq);
+		if (ret)
+			return ret;
+		/* we only support one parent, so far */
+		if (of_node_to_fwnode(out_irq.np) != dm->parent->fwnode)
+			return -EINVAL;
+
+		of_phandle_args_to_fwspec(out_irq.np, out_irq.args,
+					  out_irq.args_count, &p_fwspec);
+
+		return irq_domain_alloc_irqs_parent(dm, virq, 1, &p_fwspec);
+	}
+
+	if (!host_data->drv_data->desc_irqs)
+		return -EINVAL;
+
+	desc_irq = host_data->drv_data->desc_irqs[hwirq];
+	if (desc_irq != EXTI_INVALID_IRQ) {
+		p_fwspec.fwnode = dm->parent->fwnode;
+		p_fwspec.param_count = 3;
+		p_fwspec.param[0] = GIC_SPI;
+		p_fwspec.param[1] = desc_irq;
+		p_fwspec.param[2] = IRQ_TYPE_LEVEL_HIGH;
+
+		return irq_domain_alloc_irqs_parent(dm, virq, 1, &p_fwspec);
+	}
+
+	return 0;
+}
+
+static struct
+stm32_exti_chip_data *stm32_exti_chip_init(struct stm32_exti_host_data *h_data,
+					   u32 bank_idx,
+					   struct device_node *node)
+{
+	const struct stm32_exti_bank *stm32_bank;
+	struct stm32_exti_chip_data *chip_data;
+	void __iomem *base = h_data->base;
+
+	stm32_bank = h_data->drv_data->exti_banks[bank_idx];
+	chip_data = &h_data->chips_data[bank_idx];
+	chip_data->host_data = h_data;
+	chip_data->reg_bank = stm32_bank;
+
+	raw_spin_lock_init(&chip_data->rlock);
+
+	/*
+	 * This IP has no reset, so after hot reboot we should
+	 * clear registers to avoid residue
+	 */
+	writel_relaxed(0, base + stm32_bank->imr_ofst);
+
+	/* reserve Secure events */
+	chip_data->event_reserved = readl_relaxed(base + stm32_bank->seccfgr_ofst);
+
+	pr_info("%pOF: bank%d\n", node, bank_idx);
+
+	return chip_data;
+}
+
+static const struct irq_domain_ops stm32_exti_h_domain_ops = {
+	.alloc	= stm32_exti_h_domain_alloc,
+	.free	= irq_domain_free_irqs_common,
+	.xlate = irq_domain_xlate_twocell,
+};
+
+static void stm32_exti_check_rif(struct stm32_exti_host_data *host_data)
+{
+	unsigned int bank, i, event;
+	u32 cid, cidcfgr, hwcfgr1;
+
+	/* quit on CID not supported */
+	hwcfgr1 = readl_relaxed(host_data->base + EXTI_HWCFGR1);
+	if ((hwcfgr1 & EXTI_HWCFGR1_CIDWIDTH_MASK) == 0)
+		return;
+
+	for (bank = 0; bank < host_data->drv_data->bank_nr; bank++) {
+		for (i = 0; i < IRQS_PER_BANK; i++) {
+			event = bank * IRQS_PER_BANK + i;
+			cidcfgr = readl_relaxed(host_data->base + EXTI_EnCIDCFGR(event));
+			cid = (cidcfgr & EXTI_CIDCFGR_CID_MASK) >> EXTI_CIDCFGR_CID_SHIFT;
+			if ((cidcfgr & EXTI_CIDCFGR_CFEN_MASK) && cid != EXTI_CID1)
+				host_data->chips_data[bank].event_reserved |= BIT(i);
+		}
+	}
+}
+
+static void stm32_exti_remove_irq(void *data)
+{
+	struct irq_domain *domain = data;
+
+	irq_domain_remove(domain);
+}
+
+static int stm32_exti_probe(struct platform_device *pdev)
+{
+	int ret, i;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct irq_domain *parent_domain, *domain;
+	struct stm32_exti_host_data *host_data;
+	const struct stm32_exti_drv_data *drv_data;
+
+	host_data = devm_kzalloc(dev, sizeof(*host_data), GFP_KERNEL);
+	if (!host_data)
+		return -ENOMEM;
+
+	dev_set_drvdata(dev, host_data);
+	host_data->dev = dev;
+
+	/* check for optional hwspinlock which may be not available yet */
+	ret = of_hwspin_lock_get_id(np, 0);
+	if (ret == -EPROBE_DEFER)
+		/* hwspinlock framework not yet ready */
+		return ret;
+
+	if (ret >= 0) {
+		host_data->hwlock = devm_hwspin_lock_request_specific(dev, ret);
+		if (!host_data->hwlock) {
+			dev_err(dev, "Failed to request hwspinlock\n");
+			return -EINVAL;
+		}
+	} else if (ret != -ENOENT) {
+		/* note: ENOENT is a valid case (means 'no hwspinlock') */
+		dev_err(dev, "Failed to get hwspinlock\n");
+		return ret;
+	}
+
+	/* initialize host_data */
+	drv_data = of_device_get_match_data(dev);
+	if (!drv_data) {
+		dev_err(dev, "no of match data\n");
+		return -ENODEV;
+	}
+	host_data->drv_data = drv_data;
+
+	host_data->chips_data = devm_kcalloc(dev, drv_data->bank_nr,
+					     sizeof(*host_data->chips_data),
+					     GFP_KERNEL);
+	if (!host_data->chips_data)
+		return -ENOMEM;
+
+	host_data->base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(host_data->base))
+		return PTR_ERR(host_data->base);
+
+	for (i = 0; i < drv_data->bank_nr; i++)
+		stm32_exti_chip_init(host_data, i, np);
+
+	stm32_exti_check_rif(host_data);
+
+	parent_domain = irq_find_host(of_irq_find_parent(np));
+	if (!parent_domain) {
+		dev_err(dev, "GIC interrupt-parent not found\n");
+		return -EINVAL;
+	}
+
+	domain = irq_domain_add_hierarchy(parent_domain, 0,
+					  drv_data->bank_nr * IRQS_PER_BANK,
+					  np, &stm32_exti_h_domain_ops,
+					  host_data);
+
+	if (!domain) {
+		dev_err(dev, "Could not register exti domain\n");
+		return -ENOMEM;
+	}
+
+	ret = devm_add_action_or_reset(dev, stm32_exti_remove_irq, domain);
+	if (ret)
+		return ret;
+
+	if (of_property_read_bool(np, "interrupts-extended"))
+		host_data->dt_has_irqs_desc = true;
+
+	return 0;
+}
+
+static const struct of_device_id stm32_exti_ids[] = {
+	{ .compatible = "st,stm32mp1-exti", .data = &stm32mp1_drv_data},
+	{ .compatible = "st,stm32mp13-exti", .data = &stm32mp13_drv_data},
+	{},
+};
+MODULE_DEVICE_TABLE(of, stm32_exti_ids);
+
+static const struct dev_pm_ops stm32_exti_dev_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(stm32_exti_h_suspend, stm32_exti_h_resume)
+};
+
+static struct platform_driver stm32_exti_driver = {
+	.probe		= stm32_exti_probe,
+	.driver		= {
+		.name		= "stm32_exti",
+		.of_match_table	= stm32_exti_ids,
+		.pm		= &stm32_exti_dev_pm_ops,
+	},
+};
+
+static int __init stm32_exti_arch_init(void)
+{
+	return platform_driver_register(&stm32_exti_driver);
+}
+
+static void __exit stm32_exti_arch_exit(void)
+{
+	return platform_driver_unregister(&stm32_exti_driver);
+}
+
+arch_initcall(stm32_exti_arch_init);
+module_exit(stm32_exti_arch_exit);

