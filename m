Return-Path: <linux-tip-commits+bounces-3539-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 27437A3EF15
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 09:51:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CE5F319C533E
	for <lists+linux-tip-commits@lfdr.de>; Fri, 21 Feb 2025 08:51:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88FE92010E2;
	Fri, 21 Feb 2025 08:50:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="leqBR5vf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/ezAZ+XW"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C2AE200BB2;
	Fri, 21 Feb 2025 08:50:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740127855; cv=none; b=fCjqP7qHAo9moPLpW78r60ilzc/Pu6gNtd5n3CzDqUIblOVBXHjaJgCkWzkvPDXzvJrDgMk2ptsLJfg7yknCEz7WSg3Ox7mTESUsgxmr9/WGV8X0UgqQ6333m6bAZPHVIiDEHYAw0ASVdZrpVPQD+Gjfwur7NFHUEwdVpgIm3G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740127855; c=relaxed/simple;
	bh=fILunFqm5OSyNPBDYQzZNGJZfLWZQSEB76z/NVRN2ls=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kAoLzA3ULeF5LAXf1xBwg8RzpyUzS5eLwjj8qtQZ/D8hKRpx4mFY+40HBeIDzJ7yXqDHtpAi13XpILVdGEjTPjk97vZ9P4O+3/LrHGT29/kb7OalmIQXUI4zVpHs+i80JldrHwTPD8DbQf2OGwq6FDaz/Be357OqwcHP0RvcFJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=leqBR5vf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/ezAZ+XW; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 21 Feb 2025 08:50:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740127851;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iGzMxisqqd0Myv9f3deXpKEqbdiY9DmxDyXm1RMK6aA=;
	b=leqBR5vfmMnc/vqO9gUo3HJgeWngSpMt0ANyzoWqunjbxiqG8R0F5O8I0pbESAAyREWMox
	L03GtNuXyjbopk+syiTyv8LgsfG0qwijgNZ9iCf0muO1UWeoubDQRpsVPFqoqnLXQmoXPy
	TW+TtrUTpE6/LJaE0UnwKcaBi9I8W+Q5qiibB7fsGKs4MPCpzUSaenFE1LXUiYVscyRnya
	2e2rKPCvu4lgUHEuvk85WnfBgh47YgMgs9tglPCIoUPlmYzSE54dvwlTKoxhjVp/kw+oSU
	jBD9h90rUrEybG5EAsYNUZU9pvCOkmAhdSVXDLwR7CcYSlj2vjMPMupnxmvg9g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740127851;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iGzMxisqqd0Myv9f3deXpKEqbdiY9DmxDyXm1RMK6aA=;
	b=/ezAZ+XWJXsIgTKHQnojFJP3Ci+zIWtT1KEXjr8QQbUzVbPEo5+EzGKXGPLZXyRhsbuaxH
	dQv+enNjtP3YH8Aw==
From: "tip-bot2 for Stephan Gerhold" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/qcom-pdc: Workaround hardware register bug
 on X1E80100
Cc: Stephan Gerhold <stephan.gerhold@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>, Johan Hovold <johan+linaro@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20250218-x1e80100-pdc-hw-wa-v2-1-29be4c98e355@linaro.org>
References: <20250218-x1e80100-pdc-hw-wa-v2-1-29be4c98e355@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174012784484.10177.9781800944109345307.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     e9a48ea4d90be251e0d057d41665745caccb0351
Gitweb:        https://git.kernel.org/tip/e9a48ea4d90be251e0d057d41665745caccb0351
Author:        Stephan Gerhold <stephan.gerhold@linaro.org>
AuthorDate:    Tue, 18 Feb 2025 16:59:18 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 21 Feb 2025 09:47:06 +01:00

irqchip/qcom-pdc: Workaround hardware register bug on X1E80100

On X1E80100, there is a hardware bug in the register logic of the
IRQ_ENABLE_BANK register: While read accesses work on the normal address,
all write accesses must be made to a shifted address. Without a workaround
for this, the wrong interrupt gets enabled in the PDC and it is impossible
to wakeup from deep suspend (CX collapse). This has not caused problems so
far, because the deep suspend state was not enabled. A workaround is
required now since work is ongoing to fix this.

The PDC has multiple "DRV" regions, each one has a size of 0x10000 and
provides the same set of registers for a particular client in the system.
Linux is one the clients and uses DRV region 2 on X1E. Each "bank" inside
the DRV region consists of 32 interrupt pins that can be enabled using the
IRQ_ENABLE_BANK register:

  IRQ_ENABLE_BANK[bank] = base + IRQ_ENABLE_BANK + bank * sizeof(u32)

On X1E, this works as intended for read access. However, write access to
most banks is shifted by 2:

  IRQ_ENABLE_BANK_X1E[0] = IRQ_ENABLE_BANK[-2]
  IRQ_ENABLE_BANK_X1E[1] = IRQ_ENABLE_BANK[-1]
  IRQ_ENABLE_BANK_X1E[2] = IRQ_ENABLE_BANK[0] = IRQ_ENABLE_BANK[2 - 2]
  IRQ_ENABLE_BANK_X1E[3] = IRQ_ENABLE_BANK[1] = IRQ_ENABLE_BANK[3 - 2]
  IRQ_ENABLE_BANK_X1E[4] = IRQ_ENABLE_BANK[2] = IRQ_ENABLE_BANK[4 - 2]
  IRQ_ENABLE_BANK_X1E[5] = IRQ_ENABLE_BANK[5] (this one works as intended)

The negative indexes underflow to banks of the previous DRV/client region:

  IRQ_ENABLE_BANK_X1E[drv 2][bank 0] = IRQ_ENABLE_BANK[drv 2][bank -2]
                                     = IRQ_ENABLE_BANK[drv 1][bank 5-2]
                                     = IRQ_ENABLE_BANK[drv 1][bank 3]
                                     = IRQ_ENABLE_BANK[drv 1][bank 0 + 3]
  IRQ_ENABLE_BANK_X1E[drv 2][bank 1] = IRQ_ENABLE_BANK[drv 2][bank -1]
                                     = IRQ_ENABLE_BANK[drv 1][bank 5-1]
                                     = IRQ_ENABLE_BANK[drv 1][bank 4]
                                     = IRQ_ENABLE_BANK[drv 1][bank 1 + 3]

Introduce a workaround for the bug by matching the qcom,x1e80100-pdc
compatible and apply the offsets as shown above:

 - Bank 0...1: previous DRV region, bank += 3
 - Bank 1...4: our DRV region, bank -= 2
 - Bank 5: our DRV region, no fixup required

The PDC node in the device tree only describes the DRV region for the Linux
client, but the workaround also requires to map parts of the previous DRV
region to issue writes there. To maintain compatibility with old device
trees, obtain the base address of the preceeding region by applying the
-0x10000 offset. Note that this is also more correct from a conceptual
point of view:

It does not really make use of the other region; it just issues shifted
writes that end up in the registers of the Linux associated DRV region 2.

Signed-off-by: Stephan Gerhold <stephan.gerhold@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Johan Hovold <johan+linaro@kernel.org>
Link: https://lore.kernel.org/all/20250218-x1e80100-pdc-hw-wa-v2-1-29be4c98e355@linaro.org

---
 drivers/irqchip/qcom-pdc.c | 67 +++++++++++++++++++++++++++++++++++--
 1 file changed, 64 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index 74b2f12..52d7754 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -21,9 +21,11 @@
 #include <linux/types.h>
 
 #define PDC_MAX_GPIO_IRQS	256
+#define PDC_DRV_OFFSET		0x10000
 
 /* Valid only on HW version < 3.2 */
 #define IRQ_ENABLE_BANK		0x10
+#define IRQ_ENABLE_BANK_MAX	(IRQ_ENABLE_BANK + BITS_TO_BYTES(PDC_MAX_GPIO_IRQS))
 #define IRQ_i_CFG		0x110
 
 /* Valid only on HW version >= 3.2 */
@@ -46,13 +48,20 @@ struct pdc_pin_region {
 
 static DEFINE_RAW_SPINLOCK(pdc_lock);
 static void __iomem *pdc_base;
+static void __iomem *pdc_prev_base;
 static struct pdc_pin_region *pdc_region;
 static int pdc_region_cnt;
 static unsigned int pdc_version;
+static bool pdc_x1e_quirk;
+
+static void pdc_base_reg_write(void __iomem *base, int reg, u32 i, u32 val)
+{
+	writel_relaxed(val, base + reg + i * sizeof(u32));
+}
 
 static void pdc_reg_write(int reg, u32 i, u32 val)
 {
-	writel_relaxed(val, pdc_base + reg + i * sizeof(u32));
+	pdc_base_reg_write(pdc_base, reg, i, val);
 }
 
 static u32 pdc_reg_read(int reg, u32 i)
@@ -60,6 +69,34 @@ static u32 pdc_reg_read(int reg, u32 i)
 	return readl_relaxed(pdc_base + reg + i * sizeof(u32));
 }
 
+static void pdc_x1e_irq_enable_write(u32 bank, u32 enable)
+{
+	void __iomem *base;
+
+	/* Remap the write access to work around a hardware bug on X1E */
+	switch (bank) {
+	case 0 ... 1:
+		/* Use previous DRV (client) region and shift to bank 3-4 */
+		base = pdc_prev_base;
+		bank += 3;
+		break;
+	case 2 ... 4:
+		/* Use our own region and shift to bank 0-2 */
+		base = pdc_base;
+		bank -= 2;
+		break;
+	case 5:
+		/* No fixup required for bank 5 */
+		base = pdc_base;
+		break;
+	default:
+		WARN_ON(1);
+		return;
+	}
+
+	pdc_base_reg_write(base, IRQ_ENABLE_BANK, bank, enable);
+}
+
 static void __pdc_enable_intr(int pin_out, bool on)
 {
 	unsigned long enable;
@@ -72,7 +109,11 @@ static void __pdc_enable_intr(int pin_out, bool on)
 
 		enable = pdc_reg_read(IRQ_ENABLE_BANK, index);
 		__assign_bit(mask, &enable, on);
-		pdc_reg_write(IRQ_ENABLE_BANK, index, enable);
+
+		if (pdc_x1e_quirk)
+			pdc_x1e_irq_enable_write(index, enable);
+		else
+			pdc_reg_write(IRQ_ENABLE_BANK, index, enable);
 	} else {
 		enable = pdc_reg_read(IRQ_i_CFG, pin_out);
 		__assign_bit(IRQ_i_CFG_IRQ_ENABLE, &enable, on);
@@ -324,10 +365,29 @@ static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
 	if (res_size > resource_size(&res))
 		pr_warn("%pOF: invalid reg size, please fix DT\n", node);
 
+	/*
+	 * PDC has multiple DRV regions, each one provides the same set of
+	 * registers for a particular client in the system. Due to a hardware
+	 * bug on X1E, some writes to the IRQ_ENABLE_BANK register must be
+	 * issued inside the previous region. This region belongs to
+	 * a different client and is not described in the device tree. Map the
+	 * region with the expected offset to preserve support for old DTs.
+	 */
+	if (of_device_is_compatible(node, "qcom,x1e80100-pdc")) {
+		pdc_prev_base = ioremap(res.start - PDC_DRV_OFFSET, IRQ_ENABLE_BANK_MAX);
+		if (!pdc_prev_base) {
+			pr_err("%pOF: unable to map previous PDC DRV region\n", node);
+			return -ENXIO;
+		}
+
+		pdc_x1e_quirk = true;
+	}
+
 	pdc_base = ioremap(res.start, res_size);
 	if (!pdc_base) {
 		pr_err("%pOF: unable to map PDC registers\n", node);
-		return -ENXIO;
+		ret = -ENXIO;
+		goto fail;
 	}
 
 	pdc_version = pdc_reg_read(PDC_VERSION_REG, 0);
@@ -363,6 +423,7 @@ static int qcom_pdc_init(struct device_node *node, struct device_node *parent)
 fail:
 	kfree(pdc_region);
 	iounmap(pdc_base);
+	iounmap(pdc_prev_base);
 	return ret;
 }
 

