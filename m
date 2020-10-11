Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5BB28A8ED
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 20:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730396AbgJKR7Z (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388479AbgJKR5l (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80788C0613DD;
        Sun, 11 Oct 2020 10:57:39 -0700 (PDT)
Date:   Sun, 11 Oct 2020 17:57:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439057;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=+whYw7Z5fzSEVbDgHm6cKYL3EqMbzhILPOJwhMOjxzg=;
        b=yIMw67rSYzMMnrUfTP7M9OF8BIlTJB/IjLdw1EXu28pwWrhKIi8sdjOoDZ37DU02AQ3vk0
        1eCLhg6T62wf8bNuNs4P+nkbVoBy38VQ35oAfS+F6L0sfXyzXjh/t6sFsvkihlqXnL3ott
        y6tLkfGrZ1F5VM8w4kokHogFM4KrMeoNw24noBClGe6mzX2y0v0jyRl6asfpn4C/ch4ugR
        p3oj3nJqSKxCyDSqm7zITHHfookoqsDFP+C3b5oYs+dikpKhd+c4liQgkXdkZ8m1QrxuqB
        gYEmIsFUvC9guropJgTs94PdE6dqouFbGA42pCIxEKKbIrwYQ4ubdPHr1FihDQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439057;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=+whYw7Z5fzSEVbDgHm6cKYL3EqMbzhILPOJwhMOjxzg=;
        b=dcRyhuTUg8zJeDEEmYWCukFvmpf2FuobnT9ZG1zCv2b7AoWwCCgwO3vFxA1m5nLkV25t+r
        JN5CIEm+brn8G4Cg==
From:   "tip-bot2 for David Lechner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/irq-pruss-intc: Implement irq_{get,
 set}_irqchip_state ops
Cc:     Suman Anna <s-anna@ti.com>, David Lechner <david@lechnology.com>,
        Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>,
        Lee Jones <lee.jones@linaro.org>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160243905711.7002.4674488860526950145.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     b1026e8a95e430e615579f14f0f73c94f9690468
Gitweb:        https://git.kernel.org/tip/b1026e8a95e430e615579f14f0f73c94f9690468
Author:        David Lechner <david@lechnology.com>
AuthorDate:    Wed, 16 Sep 2020 18:36:37 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 17 Sep 2020 12:20:32 +01:00

irqchip/irq-pruss-intc: Implement irq_{get, set}_irqchip_state ops

This implements the irq_get_irqchip_state and irq_set_irqchip_state
callbacks for the TI PRUSS INTC driver. The set callback can be used
by drivers to "kick" a PRU by injecting a PRU system event.

Co-developed-by: Suman Anna <s-anna@ti.com>
Co-developed-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Signed-off-by: Suman Anna <s-anna@ti.com>
Signed-off-by: David Lechner <david@lechnology.com>
Signed-off-by: Grzegorz Jaszczyk <grzegorz.jaszczyk@linaro.org>
Reviewed-by: Lee Jones <lee.jones@linaro.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-pruss-intc.c | 40 +++++++++++++++++++++++++++++++-
 1 file changed, 40 insertions(+)

diff --git a/drivers/irqchip/irq-pruss-intc.c b/drivers/irqchip/irq-pruss-intc.c
index e7ba358..bfe529a 100644
--- a/drivers/irqchip/irq-pruss-intc.c
+++ b/drivers/irqchip/irq-pruss-intc.c
@@ -12,6 +12,7 @@
  * Copyright (C) 2019 David Lechner <david@lechnology.com>
  */
 
+#include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
@@ -323,6 +324,43 @@ static void pruss_intc_irq_relres(struct irq_data *data)
 	module_put(THIS_MODULE);
 }
 
+static int pruss_intc_irq_get_irqchip_state(struct irq_data *data,
+					    enum irqchip_irq_state which,
+					    bool *state)
+{
+	struct pruss_intc *intc = irq_data_get_irq_chip_data(data);
+	u32 reg, mask, srsr;
+
+	if (which != IRQCHIP_STATE_PENDING)
+		return -EINVAL;
+
+	reg = PRU_INTC_SRSR(data->hwirq / 32);
+	mask = BIT(data->hwirq % 32);
+
+	srsr = pruss_intc_read_reg(intc, reg);
+
+	*state = !!(srsr & mask);
+
+	return 0;
+}
+
+static int pruss_intc_irq_set_irqchip_state(struct irq_data *data,
+					    enum irqchip_irq_state which,
+					    bool state)
+{
+	struct pruss_intc *intc = irq_data_get_irq_chip_data(data);
+
+	if (which != IRQCHIP_STATE_PENDING)
+		return -EINVAL;
+
+	if (state)
+		pruss_intc_write_reg(intc, PRU_INTC_SISR, data->hwirq);
+	else
+		pruss_intc_write_reg(intc, PRU_INTC_SICR, data->hwirq);
+
+	return 0;
+}
+
 static struct irq_chip pruss_irqchip = {
 	.name			= "pruss-intc",
 	.irq_ack		= pruss_intc_irq_ack,
@@ -330,6 +368,8 @@ static struct irq_chip pruss_irqchip = {
 	.irq_unmask		= pruss_intc_irq_unmask,
 	.irq_request_resources	= pruss_intc_irq_reqres,
 	.irq_release_resources	= pruss_intc_irq_relres,
+	.irq_get_irqchip_state	= pruss_intc_irq_get_irqchip_state,
+	.irq_set_irqchip_state	= pruss_intc_irq_set_irqchip_state,
 };
 
 static int pruss_intc_validate_mapping(struct pruss_intc *intc, int event,
