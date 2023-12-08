Return-Path: <linux-tip-commits+bounces-1-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ED85A80AEAA
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Dec 2023 22:14:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36958B20BCA
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 Dec 2023 21:14:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C1F35788A;
	Fri,  8 Dec 2023 21:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kVKLKOYk";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fd/NJW5l"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D732BA;
	Fri,  8 Dec 2023 13:14:39 -0800 (PST)
Date: Fri, 08 Dec 2023 21:14:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1702070078;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m03mTesIlMrxS5Qv8tSD3rwTD8P4+Fu9Srapvhn8Bpg=;
	b=kVKLKOYkoz3qMmE4bUuo7J/Ggx50IutUseYk6DyPlfIZwX2AzPlYDyH4Jj3d1Ucc9l2oO3
	Z80JE6/w9wSRZBGgVozvKn3w7ItAdmrQ/mTI9tDfOaRAQ8W2hx0YAuZlBMFZAqdFwnZrcv
	ojk0QvSFBsSJXuIli2isdrA6ZUMX77N3JTIiuEsxYolOZrHRLFjKuxa7CrmfxofYlTt+eO
	4p6HMbQrOUTBxYwC0eNUjuv+r+KWX5tbCiXNMzTRKOfBcPI/4R/Ht6iB3K4QzR0hLdfxyp
	98y+tPof7/UCLBlNOXUOaoZUCTc/BbmXRxmfNJh9BMR+/+GVXsS8z6yxTDB/xg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1702070078;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m03mTesIlMrxS5Qv8tSD3rwTD8P4+Fu9Srapvhn8Bpg=;
	b=Fd/NJW5lRzwu+C3899dmvNNsoXFA9PNg+yS9iMopClwePhfXmUR2wNe5m17m91rba9+ZSI
	IATAldQif2zs/VCA==
From: "tip-bot2 for Konrad Dybcio" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/qcom-mpm: Support passing a slice of SRAM as
 reg space
Cc: Konrad Dybcio <konrad.dybcio@linaro.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
 Shawn Guo <shawn.guo@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20230328-topic-msgram_mpm-v7-2-6ee2bfeaac2c@linaro.org>
References: <20230328-topic-msgram_mpm-v7-2-6ee2bfeaac2c@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <170207007705.398.3441673738710273946.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     4c601685434fd34f9fa328c861241d8433606c4c
Gitweb:        https://git.kernel.org/tip/4c601685434fd34f9fa328c861241d8433606c4c
Author:        Konrad Dybcio <konrad.dybcio@linaro.org>
AuthorDate:    Mon, 27 Nov 2023 16:52:13 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 08 Dec 2023 22:06:36 +01:00

irqchip/qcom-mpm: Support passing a slice of SRAM as reg space

The MPM hardware is accessible from the ARM CPUs through a shared memory
region (RPM MSG RAM) which is also concurrently accessed by other kinds of
cores on the system like modem, ADSP etc.

Modeling this relation in a (somewhat) sane manner in the device tree
requires to

  - either present the MPM as a child of said memory region, which
    makes little sense, as a mapped memory carveout is not a bus.

  - define nodes which bleed their register spaces into one another

  - or passing their slice of the MSG RAM through a property

Go with the third option and add a way to map a region passed through the
"qcom,rpm-msg-ram" property as register space for the MPM interrupt
controller.

The current way of using 'reg' is preserved for backwards compatibility
reasons.

[ tglx: Massaged changelog ]

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Acked-by: Shawn Guo <shawn.guo@linaro.org>
Link: https://lore.kernel.org/r/20230328-topic-msgram_mpm-v7-2-6ee2bfeaac2c@linaro.org

---
 drivers/irqchip/irq-qcom-mpm.c | 26 +++++++++++++++++++++++---
 1 file changed, 23 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-qcom-mpm.c b/drivers/irqchip/irq-qcom-mpm.c
index 7124565..cda5838 100644
--- a/drivers/irqchip/irq-qcom-mpm.c
+++ b/drivers/irqchip/irq-qcom-mpm.c
@@ -14,6 +14,7 @@
 #include <linux/mailbox_client.h>
 #include <linux/module.h>
 #include <linux/of.h>
+#include <linux/of_address.h>
 #include <linux/of_platform.h>
 #include <linux/platform_device.h>
 #include <linux/pm_domain.h>
@@ -322,8 +323,10 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
 	struct device *dev = &pdev->dev;
 	struct irq_domain *parent_domain;
 	struct generic_pm_domain *genpd;
+	struct device_node *msgram_np;
 	struct qcom_mpm_priv *priv;
 	unsigned int pin_cnt;
+	struct resource res;
 	int i, irq;
 	int ret;
 
@@ -374,9 +377,26 @@ static int qcom_mpm_init(struct device_node *np, struct device_node *parent)
 
 	raw_spin_lock_init(&priv->lock);
 
-	priv->base = devm_platform_ioremap_resource(pdev, 0);
-	if (IS_ERR(priv->base))
-		return PTR_ERR(priv->base);
+	/* If we have a handle to an RPM message ram partition, use it. */
+	msgram_np = of_parse_phandle(np, "qcom,rpm-msg-ram", 0);
+	if (msgram_np) {
+		ret = of_address_to_resource(msgram_np, 0, &res);
+		if (ret) {
+			of_node_put(msgram_np);
+			return ret;
+		}
+
+		/* Don't use devm_ioremap_resource, as we're accessing a shared region. */
+		priv->base = devm_ioremap(dev, res.start, resource_size(&res));
+		of_node_put(msgram_np);
+		if (IS_ERR(priv->base))
+			return PTR_ERR(priv->base);
+	} else {
+		/* Otherwise, fall back to simple MMIO. */
+		priv->base = devm_platform_ioremap_resource(pdev, 0);
+		if (IS_ERR(priv->base))
+			return PTR_ERR(priv->base);
+	}
 
 	for (i = 0; i < priv->reg_stride; i++) {
 		qcom_mpm_write(priv, MPM_REG_ENABLE, i, 0);

