Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 98DB02D86B9
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Dec 2020 14:10:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726881AbgLLNJK (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 12 Dec 2020 08:09:10 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41306 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438896AbgLLM7b (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 12 Dec 2020 07:59:31 -0500
Date:   Sat, 12 Dec 2020 12:58:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607777917;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=24CDoiH7PiFznPmnwyBRr6HduTngsxDuscSTg4kS67k=;
        b=ePEyZedRsjUyPEnGeW8H9IhbJ6wWu0yuictZmtFjEG8q+Wy2AE+YRzidL+5CcnJfbbVsWi
        6Dfj9YqdxkdAhbLBU0CNLVpTRYJ+/+luwp4611EZJKhjKgC67CNIOFek0+H1wAD7h/fFjh
        urVXSv+GyyY5mATTGxo10eGbHDGL7KIkaln41Rj7El5rxEf6F7wYRMtD+8J3YUjdg56/b9
        IdDdXCQsC/QSsuD0d1qz+PiovHv0Im3X0L4qiW4HeAkxRLnLUY6kFz+5RTA/Iwe2UsE1sq
        sKbLj4oMdn/Vb1qP4F6ZUSZH4B1opFxbCuV+igg93moW1hY90cVOZzSMN1vQpA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607777917;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=24CDoiH7PiFznPmnwyBRr6HduTngsxDuscSTg4kS67k=;
        b=T6pGYI+R5X4acGS7A3Yhz02rZ7Y+0zDrTj3ACCy1v1P4FJDaJew/th9Ei2E9EQLTwH1Lgu
        hERfNKZ91JFNpACA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI: mobiveil: Use irq_data_get_irq_chip_data()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201210194044.473308721@linutronix.de>
References: <20201210194044.473308721@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777791723.3364.6914540326382988101.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     c9bfac576ac620b71f42fb695493d6eb6e382637
Gitweb:        https://git.kernel.org/tip/c9bfac576ac620b71f42fb695493d6eb6e382637
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:25:55 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:05 +01:00

PCI: mobiveil: Use irq_data_get_irq_chip_data()

Going through a full irq descriptor lookup instead of just using the proper
helper function which provides direct access is suboptimal.

In fact it _is_ wrong because the chip callback needs to get the chip data
which is relevant for the chip while using the irq descriptor variant
returns the irq chip data of the top level chip of a hierarchy. It does not
matter in this case because the chip is the top level chip, but that
doesn't make it more correct.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Rob Herring <robh@kernel.org>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Link: https://lore.kernel.org/r/20201210194044.473308721@linutronix.de

---
 drivers/pci/controller/mobiveil/pcie-mobiveil-host.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
index a2632d0..c637de3 100644
--- a/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
+++ b/drivers/pci/controller/mobiveil/pcie-mobiveil-host.c
@@ -306,13 +306,11 @@ int mobiveil_host_init(struct mobiveil_pcie *pcie, bool reinit)
 
 static void mobiveil_mask_intx_irq(struct irq_data *data)
 {
-	struct irq_desc *desc = irq_to_desc(data->irq);
-	struct mobiveil_pcie *pcie;
+	struct mobiveil_pcie *pcie = irq_data_get_irq_chip_data(data);
 	struct mobiveil_root_port *rp;
 	unsigned long flags;
 	u32 mask, shifted_val;
 
-	pcie = irq_desc_get_chip_data(desc);
 	rp = &pcie->rp;
 	mask = 1 << ((data->hwirq + PAB_INTX_START) - 1);
 	raw_spin_lock_irqsave(&rp->intx_mask_lock, flags);
@@ -324,13 +322,11 @@ static void mobiveil_mask_intx_irq(struct irq_data *data)
 
 static void mobiveil_unmask_intx_irq(struct irq_data *data)
 {
-	struct irq_desc *desc = irq_to_desc(data->irq);
-	struct mobiveil_pcie *pcie;
+	struct mobiveil_pcie *pcie = irq_data_get_irq_chip_data(data);
 	struct mobiveil_root_port *rp;
 	unsigned long flags;
 	u32 shifted_val, mask;
 
-	pcie = irq_desc_get_chip_data(desc);
 	rp = &pcie->rp;
 	mask = 1 << ((data->hwirq + PAB_INTX_START) - 1);
 	raw_spin_lock_irqsave(&rp->intx_mask_lock, flags);
