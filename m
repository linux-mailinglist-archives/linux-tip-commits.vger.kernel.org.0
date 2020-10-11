Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9425728A90B
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 20:00:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728858AbgJKSAW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 14:00:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40004 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388412AbgJKR5a (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:30 -0400
Date:   Sun, 11 Oct 2020 17:57:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439048;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tKH/mZnZhopVXCDDdjtJJYhDcr30GcDIM6xX82LZ9wU=;
        b=bX+5fOkHeGb0K8c6KrAyEXVYf4OhVxOwDTRav1n+VfM2P3qououOH67BQuEFGGvuKurwcB
        08NROVkJidqC7v3FLCHo57GUheeq9pRf0gDywL89zS/UM8QUS4msvdPnkNJ2XPjPPgiqHJ
        DRcYX1bzzgh5ECd6lB7jpi4x6h++QVdk9qC4y6PlD2RY/x4nd/oIFGlZ+VtdNnfhshckTh
        pHv68oinOJqLfKF6gO2epD2XAq2y29zF4MUVu1pJNbZli8EYcoHRAcgRVBnPMFLrmIy0oK
        I85aoLG05nmbRq7o/ckwNwghpon3f9P+M8byGtXdswCAXr7q8O2RYn69Q1dDVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439048;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tKH/mZnZhopVXCDDdjtJJYhDcr30GcDIM6xX82LZ9wU=;
        b=PUTnY/qDXo923p1l9CsJw86f7yD4ZuH+L3SK2in2RHZDop/lhr00EpUJaEiv5Ynhm6IoqP
        8Phd9TMbzCHCdZDA==
From:   "tip-bot2 for Zhen Lei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/dw-apb-ictl: Refactor priot to introducing
 hierarchical irq domains
Cc:     Zhen Lei <thunder.leizhen@huawei.com>,
        Marc Zyngier <maz@kernel.org>, Haoyu Lv <lvhaoyu@huawei.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200924071754.4509-3-thunder.leizhen@huawei.com>
References: <20200924071754.4509-3-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Message-ID: <160243904745.7002.18322312004522474060.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     d59f7d159891466361808522b63cf3548ea3ecb0
Gitweb:        https://git.kernel.org/tip/d59f7d159891466361808522b63cf3548ea3ecb0
Author:        Zhen Lei <thunder.leizhen@huawei.com>
AuthorDate:    Thu, 24 Sep 2020 15:17:50 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 25 Sep 2020 16:49:09 +01:00

irqchip/dw-apb-ictl: Refactor priot to introducing hierarchical irq domains

Add the required abstractions that will help introducing hierarchical
domain support to the dw-apb-ictl driver.

No functional change.

Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
[maz: commit message, some cleanups]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Tested-by: Haoyu Lv <lvhaoyu@huawei.com>
Link: https://lore.kernel.org/r/20200924071754.4509-3-thunder.leizhen@huawei.com
---
 drivers/irqchip/irq-dw-apb-ictl.c | 19 +++++++++++--------
 1 file changed, 11 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-dw-apb-ictl.c b/drivers/irqchip/irq-dw-apb-ictl.c
index e4550e9..353fe62 100644
--- a/drivers/irqchip/irq-dw-apb-ictl.c
+++ b/drivers/irqchip/irq-dw-apb-ictl.c
@@ -26,7 +26,7 @@
 #define APB_INT_FINALSTATUS_H	0x34
 #define APB_INT_BASE_OFFSET	0x04
 
-static void dw_apb_ictl_handler(struct irq_desc *desc)
+static void dw_apb_ictl_handle_irq_cascaded(struct irq_desc *desc)
 {
 	struct irq_domain *d = irq_desc_get_handler_data(desc);
 	struct irq_chip *chip = irq_desc_get_chip(desc);
@@ -43,7 +43,7 @@ static void dw_apb_ictl_handler(struct irq_desc *desc)
 			u32 virq = irq_find_mapping(d, gc->irq_base + hwirq);
 
 			generic_handle_irq(virq);
-			stat &= ~(1 << hwirq);
+			stat &= ~BIT(hwirq);
 		}
 	}
 
@@ -68,17 +68,20 @@ static void dw_apb_ictl_resume(struct irq_data *d)
 static int __init dw_apb_ictl_init(struct device_node *np,
 				   struct device_node *parent)
 {
+	const struct irq_domain_ops *domain_ops;
 	unsigned int clr = IRQ_NOREQUEST | IRQ_NOPROBE | IRQ_NOAUTOEN;
 	struct resource r;
 	struct irq_domain *domain;
 	struct irq_chip_generic *gc;
 	void __iomem *iobase;
-	int ret, nrirqs, irq, i;
+	int ret, nrirqs, parent_irq, i;
 	u32 reg;
 
+	domain_ops = &irq_generic_chip_ops;
+
 	/* Map the parent interrupt for the chained handler */
-	irq = irq_of_parse_and_map(np, 0);
-	if (irq <= 0) {
+	parent_irq = irq_of_parse_and_map(np, 0);
+	if (parent_irq <= 0) {
 		pr_err("%pOF: unable to parse irq\n", np);
 		return -EINVAL;
 	}
@@ -120,8 +123,7 @@ static int __init dw_apb_ictl_init(struct device_node *np,
 	else
 		nrirqs = fls(readl_relaxed(iobase + APB_INT_ENABLE_L));
 
-	domain = irq_domain_add_linear(np, nrirqs,
-				       &irq_generic_chip_ops, NULL);
+	domain = irq_domain_add_linear(np, nrirqs, domain_ops, NULL);
 	if (!domain) {
 		pr_err("%pOF: unable to add irq domain\n", np);
 		ret = -ENOMEM;
@@ -146,7 +148,8 @@ static int __init dw_apb_ictl_init(struct device_node *np,
 		gc->chip_types[0].chip.irq_resume = dw_apb_ictl_resume;
 	}
 
-	irq_set_chained_handler_and_data(irq, dw_apb_ictl_handler, domain);
+	irq_set_chained_handler_and_data(parent_irq,
+				dw_apb_ictl_handle_irq_cascaded, domain);
 
 	return 0;
 
