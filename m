Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 154272D86C1
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Dec 2020 14:11:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439037AbgLLNJP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 12 Dec 2020 08:09:15 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:41304 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438895AbgLLM7b (ORCPT
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
        bh=oc8cgm7UUN7XaLwIPXgk3bunxGRBKvMP229OQ6pLvpA=;
        b=q9zFVAgqodNwBdgIuK0hWZu5h+v+grGfU83BmuxgzgjJlDI+khJOvxu2BwbzLOvL/25y0G
        aC1QR03pKpnrs3aT6NNNHFSXqjK2J2rHwF30XW2XCwGOYJaCXnBWYO7BDX5kF/tT0C3nHV
        DsWWhqQdnLhO+hk75ssZ3o8r2awDocQe1qg0oSoYITeTu2rRx7NOF8QX/9dycdX5mA8XnC
        8ELPFtPaUaDyZBqSH7L9zbrFokSDIfT6FkoklB/Wqncbuc0xDRj/a5aTY3zF80cLNdXZoR
        Wg7rYKz680WNzRFet3/UiZTPFCDRkTzjWHiOIJPnpq6YxarTJX0smqDzJhLB8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607777917;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oc8cgm7UUN7XaLwIPXgk3bunxGRBKvMP229OQ6pLvpA=;
        b=28vVBil9b9/iBxa7w2EaX9unACl5caN3u0M1s8nVeKAFnMQmq2h/3Wkp6N/HZEB45NZpuC
        NTrU5WYlUsJHSpAg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] PCI: xilinx-nwl: Use irq_data_get_irq_chip_data()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201210194044.364211860@linutronix.de>
References: <20201210194044.364211860@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777791748.3364.4812480310871675110.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     f44d2329d5c179d24708ada87f5e77b781e336ca
Gitweb:        https://git.kernel.org/tip/f44d2329d5c179d24708ada87f5e77b781e336ca
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:25:54 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:05 +01:00

PCI: xilinx-nwl: Use irq_data_get_irq_chip_data()

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
Link: https://lore.kernel.org/r/20201210194044.364211860@linutronix.de

---
 drivers/pci/controller/pcie-xilinx-nwl.c | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/pcie-xilinx-nwl.c b/drivers/pci/controller/pcie-xilinx-nwl.c
index f3cf7d6..22135df 100644
--- a/drivers/pci/controller/pcie-xilinx-nwl.c
+++ b/drivers/pci/controller/pcie-xilinx-nwl.c
@@ -379,13 +379,11 @@ static void nwl_pcie_msi_handler_low(struct irq_desc *desc)
 
 static void nwl_mask_leg_irq(struct irq_data *data)
 {
-	struct irq_desc *desc = irq_to_desc(data->irq);
-	struct nwl_pcie *pcie;
+	struct nwl_pcie *pcie = irq_data_get_irq_chip_data(data);
 	unsigned long flags;
 	u32 mask;
 	u32 val;
 
-	pcie = irq_desc_get_chip_data(desc);
 	mask = 1 << (data->hwirq - 1);
 	raw_spin_lock_irqsave(&pcie->leg_mask_lock, flags);
 	val = nwl_bridge_readl(pcie, MSGF_LEG_MASK);
@@ -395,13 +393,11 @@ static void nwl_mask_leg_irq(struct irq_data *data)
 
 static void nwl_unmask_leg_irq(struct irq_data *data)
 {
-	struct irq_desc *desc = irq_to_desc(data->irq);
-	struct nwl_pcie *pcie;
+	struct nwl_pcie *pcie = irq_data_get_irq_chip_data(data);
 	unsigned long flags;
 	u32 mask;
 	u32 val;
 
-	pcie = irq_desc_get_chip_data(desc);
 	mask = 1 << (data->hwirq - 1);
 	raw_spin_lock_irqsave(&pcie->leg_mask_lock, flags);
 	val = nwl_bridge_readl(pcie, MSGF_LEG_MASK);
