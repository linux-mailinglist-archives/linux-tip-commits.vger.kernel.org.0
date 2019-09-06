Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 67E8DAB69E
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Sep 2019 13:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392179AbfIFLIU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 6 Sep 2019 07:08:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46992 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727053AbfIFLIT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 6 Sep 2019 07:08:19 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i6C6B-00072h-LB; Fri, 06 Sep 2019 13:08:15 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C9A7C1C0E20;
        Fri,  6 Sep 2019 13:08:14 +0200 (CEST)
Date:   Fri, 06 Sep 2019 11:08:14 -0000
From:   "tip-bot2 for Lubomir Rintel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/mmp: Add missing chained_irq_{enter,exit}()
Cc:     Lubomir Rintel <lkundrak@v3.sk>, Marc Zyngier <maz@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190822092643.593488-8-lkundrak@v3.sk>
References: <20190822092643.593488-8-lkundrak@v3.sk>
MIME-Version: 1.0
Message-ID: <156776809474.24167.8447201645063845818.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     a46bc5fd8b205050ebbdccc6d5ca4124edb8dc6c
Gitweb:        https://git.kernel.org/tip/a46bc5fd8b205050ebbdccc6d5ca4124edb8dc6c
Author:        Lubomir Rintel <lkundrak@v3.sk>
AuthorDate:    Thu, 22 Aug 2019 11:26:30 +02:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Fri, 30 Aug 2019 15:23:30 +01:00

irqchip/mmp: Add missing chained_irq_{enter,exit}()

The lack of chained_irq_exit() leaves the muxed interrupt masked on MMP3.
For reasons unknown this is not a problem on MMP2.

Signed-off-by: Lubomir Rintel <lkundrak@v3.sk>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20190822092643.593488-8-lkundrak@v3.sk
---
 drivers/irqchip/irq-mmp.c |  9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-mmp.c b/drivers/irqchip/irq-mmp.c
index f60e52b..fa23947 100644
--- a/drivers/irqchip/irq-mmp.c
+++ b/drivers/irqchip/irq-mmp.c
@@ -13,6 +13,7 @@
 #include <linux/init.h>
 #include <linux/irq.h>
 #include <linux/irqchip.h>
+#include <linux/irqchip/chained_irq.h>
 #include <linux/irqdomain.h>
 #include <linux/io.h>
 #include <linux/ioport.h>
@@ -132,11 +133,14 @@ struct irq_chip icu_irq_chip = {
 static void icu_mux_irq_demux(struct irq_desc *desc)
 {
 	unsigned int irq = irq_desc_get_irq(desc);
+	struct irq_chip *chip = irq_desc_get_chip(desc);
 	struct irq_domain *domain;
 	struct icu_chip_data *data;
 	int i;
 	unsigned long mask, status, n;
 
+	chained_irq_enter(chip, desc);
+
 	for (i = 1; i < max_icu_nr; i++) {
 		if (irq == icu_data[i].cascade_irq) {
 			domain = icu_data[i].domain;
@@ -146,7 +150,7 @@ static void icu_mux_irq_demux(struct irq_desc *desc)
 	}
 	if (i >= max_icu_nr) {
 		pr_err("Spurious irq %d in MMP INTC\n", irq);
-		return;
+		goto out;
 	}
 
 	mask = readl_relaxed(data->reg_mask);
@@ -158,6 +162,9 @@ static void icu_mux_irq_demux(struct irq_desc *desc)
 			generic_handle_irq(icu_data[i].virq_base + n);
 		}
 	}
+
+out:
+	chained_irq_exit(chip, desc);
 }
 
 static int mmp_irq_domain_map(struct irq_domain *d, unsigned int irq,
