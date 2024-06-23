Return-Path: <linux-tip-commits+bounces-1500-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 83ACD913D62
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jun 2024 19:52:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FF481F231AD
	for <lists+linux-tip-commits@lfdr.de>; Sun, 23 Jun 2024 17:52:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB40B1836FF;
	Sun, 23 Jun 2024 17:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bYCShp9O";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="9Lm2o4sx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 675401836E6;
	Sun, 23 Jun 2024 17:52:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719165135; cv=none; b=PJcNLeLd+NsWZfsk1ZiOspGnHzldTwm9IpCag3Ay7n1pl7HUo9F43zpE9ckq4U2jE6YF9zkCaqjZJC0mdqBSB9H8c0TcQqBulAuWB2EDX6nkT4H17R52LcBJTTDVfaCGAXgCxgsSOH7gdLKQg4w8plfSoP37U2Pwhc6aod7c9TA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719165135; c=relaxed/simple;
	bh=eDTKFTAXO8mkWwJrCoz4y+x7fqt9THVwbJDzeQMzqHw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OkOxlV6fiGAuA+4td0PgNHkfKMttC2X/Y4M2wXeWqQQgfCu4gZA667ir2IOY9beQhDGuZsYtknFF5Vr3fa78DO+wU63uyiiS2Bbibj07i1wUKqpiy7sqWE01mIm/g/3Qj0aZC2K9BN0+P+dkvXjnlbQ5mHjc1MNf50ncitS+hJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bYCShp9O; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=9Lm2o4sx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 23 Jun 2024 17:52:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719165131;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YUN+8LoVgftE9oY1BJI9dMTeSwUNLR1k/9pyPskTYng=;
	b=bYCShp9OZDKslrhF35tZNgGfiMzc40rZ44uRSU03NnZYPrvSO5kp4u8Sby8x/zRKLNbrgh
	F5sRNlbHi4R3FrkziBiFQw9BZELxrEG4dqPXnMAfCsn7Kpt/McGMJc/4inS8rlACdXVyxy
	/qAQ+F451x4jecEO4CYaLv9g1rnZuxkRJlB5L/1zzxwuNZ9whERWXrdHU1/iY2cXRF2rWo
	EudbEsq0hWdGkjgEM3EEx6pP0b3LgR/ktUufQXHx7xfveQyjPVARk6gsPJBUuZrvggek1C
	zC+El6w64N0zA8cUlvinOuDMDjNioSuda52rlIiDXgkQwdfWH/gKzTtJaRIn/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719165131;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YUN+8LoVgftE9oY1BJI9dMTeSwUNLR1k/9pyPskTYng=;
	b=9Lm2o4sxQobeUOPq/Fj/qVBQ89hesivm3lTXQ6gHCD47kW8jcYEFR6d0GwTECb3NNbu4iQ
	Rd7llcIyeQEBoBBg==
From: "tip-bot2 for Antonio Borneo" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/stm32mp-exti: Rename internal symbols
Cc: Antonio Borneo <antonio.borneo@foss.st.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20240620083115.204362-6-antonio.borneo@foss.st.com>
References: <20240620083115.204362-6-antonio.borneo@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171916513095.10875.5349539394822695701.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     c9d269469d2b9a06559cdc84d12dd3fb4d552581
Gitweb:        https://git.kernel.org/tip/c9d269469d2b9a06559cdc84d12dd3fb4d552581
Author:        Antonio Borneo <antonio.borneo@foss.st.com>
AuthorDate:    Thu, 20 Jun 2024 10:31:12 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sun, 23 Jun 2024 19:49:45 +02:00

irqchip/stm32mp-exti: Rename internal symbols

Rename all the internal symbols accordingly to the new name of the
driver.

Renaming done automatically through sed rules:
	s/stm32_exti_set_type/stm32mp_exti_convert_type/g
	s/stm32_exti_h_/stm32mp_exti_/g
	s/stm32_exti/stm32mp_exti/g
	s/stm32_bank/bank/g
	s/stm32_/stm32mp_/g
	s/STM32_/STM32MP_/g
	s/STM32MP1_/STM32MP_/g
	s/stm32mp1_exti_/stm32mp_exti_/g
	s/stm32-exti-h/stm32mp-exti/g

Manually fix some indentation after the rename.

[ tglx: Mop up more coding style issues while at it ]

Signed-off-by: Antonio Borneo <antonio.borneo@foss.st.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20240620083115.204362-6-antonio.borneo@foss.st.com

---
 drivers/irqchip/irq-stm32mp-exti.c | 312 +++++++++++++---------------
 1 file changed, 152 insertions(+), 160 deletions(-)

diff --git a/drivers/irqchip/irq-stm32mp-exti.c b/drivers/irqchip/irq-stm32mp-exti.c
index 8a45ece..727859e 100644
--- a/drivers/irqchip/irq-stm32mp-exti.c
+++ b/drivers/irqchip/irq-stm32mp-exti.c
@@ -38,7 +38,7 @@
 
 #define EXTI_CID1			1
 
-struct stm32_exti_bank {
+struct stm32mp_exti_bank {
 	u32 imr_ofst;
 	u32 rtsr_ofst;
 	u32 ftsr_ofst;
@@ -49,33 +49,34 @@ struct stm32_exti_bank {
 	u32 seccfgr_ofst;
 };
 
-struct stm32_exti_drv_data {
-	const struct stm32_exti_bank **exti_banks;
-	const u8 *desc_irqs;
-	u32 bank_nr;
+struct stm32mp_exti_drv_data {
+	const struct stm32mp_exti_bank	**exti_banks;
+	const u8			*desc_irqs;
+	u32				bank_nr;
 };
 
-struct stm32_exti_chip_data {
-	struct stm32_exti_host_data *host_data;
-	const struct stm32_exti_bank *reg_bank;
-	struct raw_spinlock rlock;
-	u32 wake_active;
-	u32 mask_cache;
-	u32 rtsr_cache;
-	u32 ftsr_cache;
-	u32 event_reserved;
+struct stm32mp_exti_chip_data {
+	struct stm32mp_exti_host_data	*host_data;
+	const struct stm32mp_exti_bank	*reg_bank;
+	struct raw_spinlock		rlock;
+	u32				wake_active;
+	u32				mask_cache;
+	u32				rtsr_cache;
+	u32				ftsr_cache;
+	u32				event_reserved;
 };
 
-struct stm32_exti_host_data {
-	void __iomem *base;
-	struct device *dev;
-	struct stm32_exti_chip_data *chips_data;
-	const struct stm32_exti_drv_data *drv_data;
-	struct hwspinlock *hwlock;
-	bool dt_has_irqs_desc; /* skip internal desc_irqs array and get it from DT */
+struct stm32mp_exti_host_data {
+	void __iomem				*base;
+	struct device				*dev;
+	struct stm32mp_exti_chip_data		*chips_data;
+	const struct stm32mp_exti_drv_data	*drv_data;
+	struct hwspinlock			*hwlock;
+	/* skip internal desc_irqs array and get it from DT */
+	bool dt_has_irqs_desc;
 };
 
-static const struct stm32_exti_bank stm32mp1_exti_b1 = {
+static const struct stm32mp_exti_bank stm32mp_exti_b1 = {
 	.imr_ofst	= 0x80,
 	.rtsr_ofst	= 0x00,
 	.ftsr_ofst	= 0x04,
@@ -86,7 +87,7 @@ static const struct stm32_exti_bank stm32mp1_exti_b1 = {
 	.seccfgr_ofst	= 0x14,
 };
 
-static const struct stm32_exti_bank stm32mp1_exti_b2 = {
+static const struct stm32mp_exti_bank stm32mp_exti_b2 = {
 	.imr_ofst	= 0x90,
 	.rtsr_ofst	= 0x20,
 	.ftsr_ofst	= 0x24,
@@ -97,7 +98,7 @@ static const struct stm32_exti_bank stm32mp1_exti_b2 = {
 	.seccfgr_ofst	= 0x34,
 };
 
-static const struct stm32_exti_bank stm32mp1_exti_b3 = {
+static const struct stm32mp_exti_bank stm32mp_exti_b3 = {
 	.imr_ofst	= 0xA0,
 	.rtsr_ofst	= 0x40,
 	.ftsr_ofst	= 0x44,
@@ -108,17 +109,17 @@ static const struct stm32_exti_bank stm32mp1_exti_b3 = {
 	.seccfgr_ofst	= 0x54,
 };
 
-static const struct stm32_exti_bank *stm32mp1_exti_banks[] = {
-	&stm32mp1_exti_b1,
-	&stm32mp1_exti_b2,
-	&stm32mp1_exti_b3,
+static const struct stm32mp_exti_bank *stm32mp_exti_banks[] = {
+	&stm32mp_exti_b1,
+	&stm32mp_exti_b2,
+	&stm32mp_exti_b3,
 };
 
-static struct irq_chip stm32_exti_h_chip;
-static struct irq_chip stm32_exti_h_chip_direct;
+static struct irq_chip stm32mp_exti_chip;
+static struct irq_chip stm32mp_exti_chip_direct;
 
 #define EXTI_INVALID_IRQ       U8_MAX
-#define STM32MP1_DESC_IRQ_SIZE (ARRAY_SIZE(stm32mp1_exti_banks) * IRQS_PER_BANK)
+#define STM32MP_DESC_IRQ_SIZE  (ARRAY_SIZE(stm32mp_exti_banks) * IRQS_PER_BANK)
 
 /*
  * Use some intentionally tricky logic here to initialize the whole array to
@@ -132,7 +133,7 @@ __diag_ignore_all("-Woverride-init",
 
 static const u8 stm32mp1_desc_irq[] = {
 	/* default value */
-	[0 ... (STM32MP1_DESC_IRQ_SIZE - 1)] = EXTI_INVALID_IRQ,
+	[0 ... (STM32MP_DESC_IRQ_SIZE - 1)] = EXTI_INVALID_IRQ,
 
 	[0] = 6,
 	[1] = 7,
@@ -181,7 +182,7 @@ static const u8 stm32mp1_desc_irq[] = {
 
 static const u8 stm32mp13_desc_irq[] = {
 	/* default value */
-	[0 ... (STM32MP1_DESC_IRQ_SIZE - 1)] = EXTI_INVALID_IRQ,
+	[0 ... (STM32MP_DESC_IRQ_SIZE - 1)] = EXTI_INVALID_IRQ,
 
 	[0] = 6,
 	[1] = 7,
@@ -226,20 +227,19 @@ static const u8 stm32mp13_desc_irq[] = {
 
 __diag_pop();
 
-static const struct stm32_exti_drv_data stm32mp1_drv_data = {
-	.exti_banks = stm32mp1_exti_banks,
-	.bank_nr = ARRAY_SIZE(stm32mp1_exti_banks),
+static const struct stm32mp_exti_drv_data stm32mp1_drv_data = {
+	.exti_banks = stm32mp_exti_banks,
+	.bank_nr = ARRAY_SIZE(stm32mp_exti_banks),
 	.desc_irqs = stm32mp1_desc_irq,
 };
 
-static const struct stm32_exti_drv_data stm32mp13_drv_data = {
-	.exti_banks = stm32mp1_exti_banks,
-	.bank_nr = ARRAY_SIZE(stm32mp1_exti_banks),
+static const struct stm32mp_exti_drv_data stm32mp13_drv_data = {
+	.exti_banks = stm32mp_exti_banks,
+	.bank_nr = ARRAY_SIZE(stm32mp_exti_banks),
 	.desc_irqs = stm32mp13_desc_irq,
 };
 
-static int stm32_exti_set_type(struct irq_data *d,
-			       unsigned int type, u32 *rtsr, u32 *ftsr)
+static int stm32mp_exti_convert_type(struct irq_data *d, unsigned int type, u32 *rtsr, u32 *ftsr)
 {
 	u32 mask = BIT(d->hwirq % IRQS_PER_BANK);
 
@@ -263,45 +263,43 @@ static int stm32_exti_set_type(struct irq_data *d,
 	return 0;
 }
 
-static void stm32_chip_suspend(struct stm32_exti_chip_data *chip_data,
-			       u32 wake_active)
+static void stm32mp_chip_suspend(struct stm32mp_exti_chip_data *chip_data, u32 wake_active)
 {
-	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+	const struct stm32mp_exti_bank *bank = chip_data->reg_bank;
 	void __iomem *base = chip_data->host_data->base;
 
 	/* save rtsr, ftsr registers */
-	chip_data->rtsr_cache = readl_relaxed(base + stm32_bank->rtsr_ofst);
-	chip_data->ftsr_cache = readl_relaxed(base + stm32_bank->ftsr_ofst);
+	chip_data->rtsr_cache = readl_relaxed(base + bank->rtsr_ofst);
+	chip_data->ftsr_cache = readl_relaxed(base + bank->ftsr_ofst);
 
-	writel_relaxed(wake_active, base + stm32_bank->imr_ofst);
+	writel_relaxed(wake_active, base + bank->imr_ofst);
 }
 
-static void stm32_chip_resume(struct stm32_exti_chip_data *chip_data,
-			      u32 mask_cache)
+static void stm32mp_chip_resume(struct stm32mp_exti_chip_data *chip_data, u32 mask_cache)
 {
-	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+	const struct stm32mp_exti_bank *bank = chip_data->reg_bank;
 	void __iomem *base = chip_data->host_data->base;
 
 	/* restore rtsr, ftsr, registers */
-	writel_relaxed(chip_data->rtsr_cache, base + stm32_bank->rtsr_ofst);
-	writel_relaxed(chip_data->ftsr_cache, base + stm32_bank->ftsr_ofst);
+	writel_relaxed(chip_data->rtsr_cache, base + bank->rtsr_ofst);
+	writel_relaxed(chip_data->ftsr_cache, base + bank->ftsr_ofst);
 
-	writel_relaxed(mask_cache, base + stm32_bank->imr_ofst);
+	writel_relaxed(mask_cache, base + bank->imr_ofst);
 }
 
 /* directly set the target bit without reading first. */
-static inline void stm32_exti_write_bit(struct irq_data *d, u32 reg)
+static inline void stm32mp_exti_write_bit(struct irq_data *d, u32 reg)
 {
-	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	struct stm32mp_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
 	void __iomem *base = chip_data->host_data->base;
 	u32 val = BIT(d->hwirq % IRQS_PER_BANK);
 
 	writel_relaxed(val, base + reg);
 }
 
-static inline u32 stm32_exti_set_bit(struct irq_data *d, u32 reg)
+static inline u32 stm32mp_exti_set_bit(struct irq_data *d, u32 reg)
 {
-	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	struct stm32mp_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
 	void __iomem *base = chip_data->host_data->base;
 	u32 val;
 
@@ -312,9 +310,9 @@ static inline u32 stm32_exti_set_bit(struct irq_data *d, u32 reg)
 	return val;
 }
 
-static inline u32 stm32_exti_clr_bit(struct irq_data *d, u32 reg)
+static inline u32 stm32mp_exti_clr_bit(struct irq_data *d, u32 reg)
 {
-	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	struct stm32mp_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
 	void __iomem *base = chip_data->host_data->base;
 	u32 val;
 
@@ -325,15 +323,15 @@ static inline u32 stm32_exti_clr_bit(struct irq_data *d, u32 reg)
 	return val;
 }
 
-static void stm32_exti_h_eoi(struct irq_data *d)
+static void stm32mp_exti_eoi(struct irq_data *d)
 {
-	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
-	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+	struct stm32mp_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	const struct stm32mp_exti_bank *bank = chip_data->reg_bank;
 
 	raw_spin_lock(&chip_data->rlock);
 
-	stm32_exti_write_bit(d, stm32_bank->rpr_ofst);
-	stm32_exti_write_bit(d, stm32_bank->fpr_ofst);
+	stm32mp_exti_write_bit(d, bank->rpr_ofst);
+	stm32mp_exti_write_bit(d, bank->fpr_ofst);
 
 	raw_spin_unlock(&chip_data->rlock);
 
@@ -341,36 +339,36 @@ static void stm32_exti_h_eoi(struct irq_data *d)
 		irq_chip_eoi_parent(d);
 }
 
-static void stm32_exti_h_mask(struct irq_data *d)
+static void stm32mp_exti_mask(struct irq_data *d)
 {
-	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
-	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+	struct stm32mp_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	const struct stm32mp_exti_bank *bank = chip_data->reg_bank;
 
 	raw_spin_lock(&chip_data->rlock);
-	chip_data->mask_cache = stm32_exti_clr_bit(d, stm32_bank->imr_ofst);
+	chip_data->mask_cache = stm32mp_exti_clr_bit(d, bank->imr_ofst);
 	raw_spin_unlock(&chip_data->rlock);
 
 	if (d->parent_data->chip)
 		irq_chip_mask_parent(d);
 }
 
-static void stm32_exti_h_unmask(struct irq_data *d)
+static void stm32mp_exti_unmask(struct irq_data *d)
 {
-	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
-	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+	struct stm32mp_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	const struct stm32mp_exti_bank *bank = chip_data->reg_bank;
 
 	raw_spin_lock(&chip_data->rlock);
-	chip_data->mask_cache = stm32_exti_set_bit(d, stm32_bank->imr_ofst);
+	chip_data->mask_cache = stm32mp_exti_set_bit(d, bank->imr_ofst);
 	raw_spin_unlock(&chip_data->rlock);
 
 	if (d->parent_data->chip)
 		irq_chip_unmask_parent(d);
 }
 
-static int stm32_exti_h_set_type(struct irq_data *d, unsigned int type)
+static int stm32mp_exti_set_type(struct irq_data *d, unsigned int type)
 {
-	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
-	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+	struct stm32mp_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	const struct stm32mp_exti_bank *bank = chip_data->reg_bank;
 	struct hwspinlock *hwlock = chip_data->host_data->hwlock;
 	void __iomem *base = chip_data->host_data->base;
 	u32 rtsr, ftsr;
@@ -386,28 +384,25 @@ static int stm32_exti_h_set_type(struct irq_data *d, unsigned int type)
 		}
 	}
 
-	rtsr = readl_relaxed(base + stm32_bank->rtsr_ofst);
-	ftsr = readl_relaxed(base + stm32_bank->ftsr_ofst);
+	rtsr = readl_relaxed(base + bank->rtsr_ofst);
+	ftsr = readl_relaxed(base + bank->ftsr_ofst);
 
-	err = stm32_exti_set_type(d, type, &rtsr, &ftsr);
-	if (err)
-		goto unspinlock;
-
-	writel_relaxed(rtsr, base + stm32_bank->rtsr_ofst);
-	writel_relaxed(ftsr, base + stm32_bank->ftsr_ofst);
+	err = stm32mp_exti_convert_type(d, type, &rtsr, &ftsr);
+	if (!err) {
+		writel_relaxed(rtsr, base + bank->rtsr_ofst);
+		writel_relaxed(ftsr, base + bank->ftsr_ofst);
+	}
 
-unspinlock:
 	if (hwlock)
 		hwspin_unlock_in_atomic(hwlock);
 unlock:
 	raw_spin_unlock(&chip_data->rlock);
-
 	return err;
 }
 
-static int stm32_exti_h_set_wake(struct irq_data *d, unsigned int on)
+static int stm32mp_exti_set_wake(struct irq_data *d, unsigned int on)
 {
-	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	struct stm32mp_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
 	u32 mask = BIT(d->hwirq % IRQS_PER_BANK);
 
 	raw_spin_lock(&chip_data->rlock);
@@ -422,8 +417,7 @@ static int stm32_exti_h_set_wake(struct irq_data *d, unsigned int on)
 	return 0;
 }
 
-static int stm32_exti_h_set_affinity(struct irq_data *d,
-				     const struct cpumask *dest, bool force)
+static int stm32mp_exti_set_affinity(struct irq_data *d, const struct cpumask *dest, bool force)
 {
 	if (d->parent_data->chip)
 		return irq_chip_set_affinity_parent(d, dest, force);
@@ -431,84 +425,84 @@ static int stm32_exti_h_set_affinity(struct irq_data *d,
 	return IRQ_SET_MASK_OK_DONE;
 }
 
-static int stm32_exti_h_suspend(struct device *dev)
+static int stm32mp_exti_suspend(struct device *dev)
 {
-	struct stm32_exti_host_data *host_data = dev_get_drvdata(dev);
-	struct stm32_exti_chip_data *chip_data;
+	struct stm32mp_exti_host_data *host_data = dev_get_drvdata(dev);
+	struct stm32mp_exti_chip_data *chip_data;
 	int i;
 
 	for (i = 0; i < host_data->drv_data->bank_nr; i++) {
 		chip_data = &host_data->chips_data[i];
-		stm32_chip_suspend(chip_data, chip_data->wake_active);
+		stm32mp_chip_suspend(chip_data, chip_data->wake_active);
 	}
 
 	return 0;
 }
 
-static int stm32_exti_h_resume(struct device *dev)
+static int stm32mp_exti_resume(struct device *dev)
 {
-	struct stm32_exti_host_data *host_data = dev_get_drvdata(dev);
-	struct stm32_exti_chip_data *chip_data;
+	struct stm32mp_exti_host_data *host_data = dev_get_drvdata(dev);
+	struct stm32mp_exti_chip_data *chip_data;
 	int i;
 
 	for (i = 0; i < host_data->drv_data->bank_nr; i++) {
 		chip_data = &host_data->chips_data[i];
-		stm32_chip_resume(chip_data, chip_data->mask_cache);
+		stm32mp_chip_resume(chip_data, chip_data->mask_cache);
 	}
 
 	return 0;
 }
 
-static int stm32_exti_h_retrigger(struct irq_data *d)
+static int stm32mp_exti_retrigger(struct irq_data *d)
 {
-	struct stm32_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
-	const struct stm32_exti_bank *stm32_bank = chip_data->reg_bank;
+	struct stm32mp_exti_chip_data *chip_data = irq_data_get_irq_chip_data(d);
+	const struct stm32mp_exti_bank *bank = chip_data->reg_bank;
 	void __iomem *base = chip_data->host_data->base;
 	u32 mask = BIT(d->hwirq % IRQS_PER_BANK);
 
-	writel_relaxed(mask, base + stm32_bank->swier_ofst);
+	writel_relaxed(mask, base + bank->swier_ofst);
 
 	return 0;
 }
 
-static struct irq_chip stm32_exti_h_chip = {
-	.name			= "stm32-exti-h",
-	.irq_eoi		= stm32_exti_h_eoi,
-	.irq_mask		= stm32_exti_h_mask,
-	.irq_unmask		= stm32_exti_h_unmask,
-	.irq_retrigger		= stm32_exti_h_retrigger,
-	.irq_set_type		= stm32_exti_h_set_type,
-	.irq_set_wake		= stm32_exti_h_set_wake,
+static struct irq_chip stm32mp_exti_chip = {
+	.name			= "stm32mp-exti",
+	.irq_eoi		= stm32mp_exti_eoi,
+	.irq_mask		= stm32mp_exti_mask,
+	.irq_unmask		= stm32mp_exti_unmask,
+	.irq_retrigger		= stm32mp_exti_retrigger,
+	.irq_set_type		= stm32mp_exti_set_type,
+	.irq_set_wake		= stm32mp_exti_set_wake,
 	.flags			= IRQCHIP_MASK_ON_SUSPEND,
-	.irq_set_affinity	= IS_ENABLED(CONFIG_SMP) ? stm32_exti_h_set_affinity : NULL,
+	.irq_set_affinity	= IS_ENABLED(CONFIG_SMP) ? stm32mp_exti_set_affinity : NULL,
 };
 
-static struct irq_chip stm32_exti_h_chip_direct = {
-	.name			= "stm32-exti-h-direct",
+static struct irq_chip stm32mp_exti_chip_direct = {
+	.name			= "stm32mp-exti-direct",
 	.irq_eoi		= irq_chip_eoi_parent,
 	.irq_ack		= irq_chip_ack_parent,
-	.irq_mask		= stm32_exti_h_mask,
-	.irq_unmask		= stm32_exti_h_unmask,
+	.irq_mask		= stm32mp_exti_mask,
+	.irq_unmask		= stm32mp_exti_unmask,
 	.irq_retrigger		= irq_chip_retrigger_hierarchy,
 	.irq_set_type		= irq_chip_set_type_parent,
-	.irq_set_wake		= stm32_exti_h_set_wake,
+	.irq_set_wake		= stm32mp_exti_set_wake,
 	.flags			= IRQCHIP_MASK_ON_SUSPEND,
 	.irq_set_affinity	= IS_ENABLED(CONFIG_SMP) ? irq_chip_set_affinity_parent : NULL,
 };
 
-static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
+static int stm32mp_exti_domain_alloc(struct irq_domain *dm,
 				     unsigned int virq,
 				     unsigned int nr_irqs, void *data)
 {
-	struct stm32_exti_host_data *host_data = dm->host_data;
-	struct stm32_exti_chip_data *chip_data;
-	u8 desc_irq;
+	struct stm32mp_exti_host_data *host_data = dm->host_data;
+	struct stm32mp_exti_chip_data *chip_data;
 	struct irq_fwspec *fwspec = data;
 	struct irq_fwspec p_fwspec;
 	irq_hw_number_t hwirq;
-	int bank;
-	u32 event_trg;
 	struct irq_chip *chip;
+	u32 event_trg;
+	u8 desc_irq;
+	int bank;
 
 	hwirq = fwspec->param[0];
 	if (hwirq >= host_data->drv_data->bank_nr * IRQS_PER_BANK)
@@ -525,7 +519,7 @@ static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
 
 	event_trg = readl_relaxed(host_data->base + chip_data->reg_bank->trg_ofst);
 	chip = (event_trg & BIT(hwirq % IRQS_PER_BANK)) ?
-	       &stm32_exti_h_chip : &stm32_exti_h_chip_direct;
+	       &stm32mp_exti_chip : &stm32mp_exti_chip_direct;
 
 	irq_domain_set_hwirq_and_chip(dm, virq, hwirq, chip, chip_data);
 
@@ -563,19 +557,17 @@ static int stm32_exti_h_domain_alloc(struct irq_domain *dm,
 	return 0;
 }
 
-static struct
-stm32_exti_chip_data *stm32_exti_chip_init(struct stm32_exti_host_data *h_data,
-					   u32 bank_idx,
-					   struct device_node *node)
+static struct stm32mp_exti_chip_data *stm32mp_exti_chip_init(struct stm32mp_exti_host_data *h_data,
+							     u32 bank_idx, struct device_node *node)
 {
-	const struct stm32_exti_bank *stm32_bank;
-	struct stm32_exti_chip_data *chip_data;
+	struct stm32mp_exti_chip_data *chip_data;
+	const struct stm32mp_exti_bank *bank;
 	void __iomem *base = h_data->base;
 
-	stm32_bank = h_data->drv_data->exti_banks[bank_idx];
+	bank = h_data->drv_data->exti_banks[bank_idx];
 	chip_data = &h_data->chips_data[bank_idx];
 	chip_data->host_data = h_data;
-	chip_data->reg_bank = stm32_bank;
+	chip_data->reg_bank = bank;
 
 	raw_spin_lock_init(&chip_data->rlock);
 
@@ -583,23 +575,23 @@ stm32_exti_chip_data *stm32_exti_chip_init(struct stm32_exti_host_data *h_data,
 	 * This IP has no reset, so after hot reboot we should
 	 * clear registers to avoid residue
 	 */
-	writel_relaxed(0, base + stm32_bank->imr_ofst);
+	writel_relaxed(0, base + bank->imr_ofst);
 
 	/* reserve Secure events */
-	chip_data->event_reserved = readl_relaxed(base + stm32_bank->seccfgr_ofst);
+	chip_data->event_reserved = readl_relaxed(base + bank->seccfgr_ofst);
 
 	pr_info("%pOF: bank%d\n", node, bank_idx);
 
 	return chip_data;
 }
 
-static const struct irq_domain_ops stm32_exti_h_domain_ops = {
-	.alloc	= stm32_exti_h_domain_alloc,
+static const struct irq_domain_ops stm32mp_exti_domain_ops = {
+	.alloc	= stm32mp_exti_domain_alloc,
 	.free	= irq_domain_free_irqs_common,
 	.xlate = irq_domain_xlate_twocell,
 };
 
-static void stm32_exti_check_rif(struct stm32_exti_host_data *host_data)
+static void stm32mp_exti_check_rif(struct stm32mp_exti_host_data *host_data)
 {
 	unsigned int bank, i, event;
 	u32 cid, cidcfgr, hwcfgr1;
@@ -620,21 +612,21 @@ static void stm32_exti_check_rif(struct stm32_exti_host_data *host_data)
 	}
 }
 
-static void stm32_exti_remove_irq(void *data)
+static void stm32mp_exti_remove_irq(void *data)
 {
 	struct irq_domain *domain = data;
 
 	irq_domain_remove(domain);
 }
 
-static int stm32_exti_probe(struct platform_device *pdev)
+static int stm32mp_exti_probe(struct platform_device *pdev)
 {
-	int ret, i;
+	const struct stm32mp_exti_drv_data *drv_data;
+	struct irq_domain *parent_domain, *domain;
+	struct stm32mp_exti_host_data *host_data;
 	struct device *dev = &pdev->dev;
 	struct device_node *np = dev->of_node;
-	struct irq_domain *parent_domain, *domain;
-	struct stm32_exti_host_data *host_data;
-	const struct stm32_exti_drv_data *drv_data;
+	int ret, i;
 
 	host_data = devm_kzalloc(dev, sizeof(*host_data), GFP_KERNEL);
 	if (!host_data)
@@ -680,9 +672,9 @@ static int stm32_exti_probe(struct platform_device *pdev)
 		return PTR_ERR(host_data->base);
 
 	for (i = 0; i < drv_data->bank_nr; i++)
-		stm32_exti_chip_init(host_data, i, np);
+		stm32mp_exti_chip_init(host_data, i, np);
 
-	stm32_exti_check_rif(host_data);
+	stm32mp_exti_check_rif(host_data);
 
 	parent_domain = irq_find_host(of_irq_find_parent(np));
 	if (!parent_domain) {
@@ -692,7 +684,7 @@ static int stm32_exti_probe(struct platform_device *pdev)
 
 	domain = irq_domain_add_hierarchy(parent_domain, 0,
 					  drv_data->bank_nr * IRQS_PER_BANK,
-					  np, &stm32_exti_h_domain_ops,
+					  np, &stm32mp_exti_domain_ops,
 					  host_data);
 
 	if (!domain) {
@@ -700,7 +692,7 @@ static int stm32_exti_probe(struct platform_device *pdev)
 		return -ENOMEM;
 	}
 
-	ret = devm_add_action_or_reset(dev, stm32_exti_remove_irq, domain);
+	ret = devm_add_action_or_reset(dev, stm32mp_exti_remove_irq, domain);
 	if (ret)
 		return ret;
 
@@ -710,35 +702,35 @@ static int stm32_exti_probe(struct platform_device *pdev)
 	return 0;
 }
 
-static const struct of_device_id stm32_exti_ids[] = {
+static const struct of_device_id stm32mp_exti_ids[] = {
 	{ .compatible = "st,stm32mp1-exti", .data = &stm32mp1_drv_data},
 	{ .compatible = "st,stm32mp13-exti", .data = &stm32mp13_drv_data},
 	{},
 };
-MODULE_DEVICE_TABLE(of, stm32_exti_ids);
+MODULE_DEVICE_TABLE(of, stm32mp_exti_ids);
 
-static const struct dev_pm_ops stm32_exti_dev_pm_ops = {
-	NOIRQ_SYSTEM_SLEEP_PM_OPS(stm32_exti_h_suspend, stm32_exti_h_resume)
+static const struct dev_pm_ops stm32mp_exti_dev_pm_ops = {
+	NOIRQ_SYSTEM_SLEEP_PM_OPS(stm32mp_exti_suspend, stm32mp_exti_resume)
 };
 
-static struct platform_driver stm32_exti_driver = {
-	.probe		= stm32_exti_probe,
+static struct platform_driver stm32mp_exti_driver = {
+	.probe		= stm32mp_exti_probe,
 	.driver		= {
-		.name		= "stm32_exti",
-		.of_match_table	= stm32_exti_ids,
-		.pm		= &stm32_exti_dev_pm_ops,
+		.name		= "stm32mp_exti",
+		.of_match_table	= stm32mp_exti_ids,
+		.pm		= &stm32mp_exti_dev_pm_ops,
 	},
 };
 
-static int __init stm32_exti_arch_init(void)
+static int __init stm32mp_exti_arch_init(void)
 {
-	return platform_driver_register(&stm32_exti_driver);
+	return platform_driver_register(&stm32mp_exti_driver);
 }
 
-static void __exit stm32_exti_arch_exit(void)
+static void __exit stm32mp_exti_arch_exit(void)
 {
-	return platform_driver_unregister(&stm32_exti_driver);
+	return platform_driver_unregister(&stm32mp_exti_driver);
 }
 
-arch_initcall(stm32_exti_arch_init);
-module_exit(stm32_exti_arch_exit);
+arch_initcall(stm32mp_exti_arch_init);
+module_exit(stm32mp_exti_arch_exit);

