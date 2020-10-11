Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 370C528A8FF
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 20:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730680AbgJKSAX (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 14:00:23 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39974 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388405AbgJKR53 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:29 -0400
Date:   Sun, 11 Oct 2020 17:57:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439047;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sO4s+jUvbQrKDwPLITRmnBimCNiDQ5fFgPhuCHJg2eQ=;
        b=ui3YwwStU8b1DPH9+QgTrT8WePQUZMXEZa2iimifF1aL+k0ipXBLQe5gzQR8wQ8La0sE+c
        CNffCX9aeK4U4KgO1WcH7CWWZJLJE/rp377yGG56rfEJQT07+yryNxjzdoqg+cYfvOoA8H
        kENfeBeOQIj9hiuDprmc34+b5MLW/g4P0Gy98Yt5aidVk/aKDYprTu/ji/NWAk9RhvQTPZ
        iUS7kGMMl9Kvrj/tks0Pq8KmMYxXNvQCUCZ3ZPr+f++cj4bIewETwwiTBNbIlhhOsrQoKL
        YcduUqm7akKwv9CIVNqOvOyT3x/YYM2hg9ZX7Mt7bqfnk6F4WiAY7F6P1zU1pA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439047;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sO4s+jUvbQrKDwPLITRmnBimCNiDQ5fFgPhuCHJg2eQ=;
        b=Jch8BCiNFSQsGJjJkiXuTB0LgG2fRAJfdEXtkbGkmmq2mSKNgy6Ut0/7YurPL5Evb/nRI1
        BG4NArbeX4pE6JBQ==
From:   "tip-bot2 for Zhen Lei" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/dw-apb-ictl: Add primary interrupt controller support
Cc:     Marc Zyngier <maz@kernel.org>,
        Zhen Lei <thunder.leizhen@huawei.com>,
        Haoyu Lv <lvhaoyu@huawei.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200924071754.4509-4-thunder.leizhen@huawei.com>
References: <20200924071754.4509-4-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Message-ID: <160243904695.7002.7464039105575921639.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     54a38440b84f8933b555c23273deca6a396f6708
Gitweb:        https://git.kernel.org/tip/54a38440b84f8933b555c23273deca6a396f6708
Author:        Zhen Lei <thunder.leizhen@huawei.com>
AuthorDate:    Thu, 24 Sep 2020 15:17:51 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 25 Sep 2020 16:49:14 +01:00

irqchip/dw-apb-ictl: Add primary interrupt controller support

Add support to use dw-apb-ictl as primary interrupt controller.

Suggested-by: Marc Zyngier <maz@kernel.org>
Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
[maz: minor fixups]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Tested-by: Haoyu Lv <lvhaoyu@huawei.com>
Link: https://lore.kernel.org/r/20200924071754.4509-4-thunder.leizhen@huawei.com
---
 drivers/irqchip/Kconfig           |  2 +-
 drivers/irqchip/irq-dw-apb-ictl.c | 72 ++++++++++++++++++++++++++----
 2 files changed, 65 insertions(+), 9 deletions(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index bfc9719..7c2d1c8 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -148,7 +148,7 @@ config DAVINCI_CP_INTC
 config DW_APB_ICTL
 	bool
 	select GENERIC_IRQ_CHIP
-	select IRQ_DOMAIN
+	select IRQ_DOMAIN_HIERARCHY
 
 config FARADAY_FTINTC010
 	bool
diff --git a/drivers/irqchip/irq-dw-apb-ictl.c b/drivers/irqchip/irq-dw-apb-ictl.c
index 353fe62..54b09d6 100644
--- a/drivers/irqchip/irq-dw-apb-ictl.c
+++ b/drivers/irqchip/irq-dw-apb-ictl.c
@@ -17,6 +17,7 @@
 #include <linux/irqchip/chained_irq.h>
 #include <linux/of_address.h>
 #include <linux/of_irq.h>
+#include <linux/interrupt.h>
 
 #define APB_INT_ENABLE_L	0x00
 #define APB_INT_ENABLE_H	0x04
@@ -26,6 +27,27 @@
 #define APB_INT_FINALSTATUS_H	0x34
 #define APB_INT_BASE_OFFSET	0x04
 
+/* irq domain of the primary interrupt controller. */
+static struct irq_domain *dw_apb_ictl_irq_domain;
+
+static void __irq_entry dw_apb_ictl_handle_irq(struct pt_regs *regs)
+{
+	struct irq_domain *d = dw_apb_ictl_irq_domain;
+	int n;
+
+	for (n = 0; n < d->revmap_size; n += 32) {
+		struct irq_chip_generic *gc = irq_get_domain_generic_chip(d, n);
+		u32 stat = readl_relaxed(gc->reg_base + APB_INT_FINALSTATUS_L);
+
+		while (stat) {
+			u32 hwirq = ffs(stat) - 1;
+
+			handle_domain_irq(d, hwirq, regs);
+			stat &= ~BIT(hwirq);
+		}
+	}
+}
+
 static void dw_apb_ictl_handle_irq_cascaded(struct irq_desc *desc)
 {
 	struct irq_domain *d = irq_desc_get_handler_data(desc);
@@ -50,6 +72,30 @@ static void dw_apb_ictl_handle_irq_cascaded(struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
+static int dw_apb_ictl_irq_domain_alloc(struct irq_domain *domain, unsigned int virq,
+				unsigned int nr_irqs, void *arg)
+{
+	int i, ret;
+	irq_hw_number_t hwirq;
+	unsigned int type = IRQ_TYPE_NONE;
+	struct irq_fwspec *fwspec = arg;
+
+	ret = irq_domain_translate_onecell(domain, fwspec, &hwirq, &type);
+	if (ret)
+		return ret;
+
+	for (i = 0; i < nr_irqs; i++)
+		irq_map_generic_chip(domain, virq + i, hwirq + i);
+
+	return 0;
+}
+
+static const struct irq_domain_ops dw_apb_ictl_irq_domain_ops = {
+	.translate = irq_domain_translate_onecell,
+	.alloc = dw_apb_ictl_irq_domain_alloc,
+	.free = irq_domain_free_irqs_top,
+};
+
 #ifdef CONFIG_PM
 static void dw_apb_ictl_resume(struct irq_data *d)
 {
@@ -77,13 +123,18 @@ static int __init dw_apb_ictl_init(struct device_node *np,
 	int ret, nrirqs, parent_irq, i;
 	u32 reg;
 
-	domain_ops = &irq_generic_chip_ops;
-
-	/* Map the parent interrupt for the chained handler */
-	parent_irq = irq_of_parse_and_map(np, 0);
-	if (parent_irq <= 0) {
-		pr_err("%pOF: unable to parse irq\n", np);
-		return -EINVAL;
+	if (!parent) {
+		/* Used as the primary interrupt controller */
+		parent_irq = 0;
+		domain_ops = &dw_apb_ictl_irq_domain_ops;
+	} else {
+		/* Map the parent interrupt for the chained handler */
+		parent_irq = irq_of_parse_and_map(np, 0);
+		if (parent_irq <= 0) {
+			pr_err("%pOF: unable to parse irq\n", np);
+			return -EINVAL;
+		}
+		domain_ops = &irq_generic_chip_ops;
 	}
 
 	ret = of_address_to_resource(np, 0, &r);
@@ -148,8 +199,13 @@ static int __init dw_apb_ictl_init(struct device_node *np,
 		gc->chip_types[0].chip.irq_resume = dw_apb_ictl_resume;
 	}
 
-	irq_set_chained_handler_and_data(parent_irq,
+	if (parent_irq) {
+		irq_set_chained_handler_and_data(parent_irq,
 				dw_apb_ictl_handle_irq_cascaded, domain);
+	} else {
+		dw_apb_ictl_irq_domain = domain;
+		set_handle_irq(dw_apb_ictl_handle_irq);
+	}
 
 	return 0;
 
