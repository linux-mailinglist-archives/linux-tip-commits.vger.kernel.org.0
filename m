Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3A9C428A89A
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 19:57:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388366AbgJKR5W (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:57:22 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39926 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388348AbgJKR5W (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:22 -0400
Date:   Sun, 11 Oct 2020 17:57:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439040;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=eR6dW5CT4IrH4DnwXTdbSoufWlD1RQtLJ0Hon3850rs=;
        b=jXZyTVoFP1rhJoL7LG2RixQf+EsJUFvuVS5NBPt2a4rp14I5e2V6WiLuTRJiqS2JTXzWTv
        MHMxUWoBzTsacoy1xDjXFFvmQWhtIqx7PRUHBUxqKcaKmK93MJlGjzHBODq2d7QvYPEog/
        FZnlUwAPOFXlwhSFQi7td8TjfY7azLRyFaTKTQGskoV3hMqcz2Dqp2aKr7QijcRlOq6jbv
        VVYt5qXvQSaI7xZbc+5GICJw4uKdY5TVIb1u27VVRPKKhjgM2p9roKgPMghmfA/TbjSrqu
        gfPtkFzWk4LZzDl679Dk281J65rN3RVR/tqI55PC3mEUnCqv/rUCsiFNgQEemg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439040;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=eR6dW5CT4IrH4DnwXTdbSoufWlD1RQtLJ0Hon3850rs=;
        b=muqueg/ZEvr5m0ViBU+lDeDcoKJ0+vYsQUYjXtwTzDQ84DaDZ2Akg1OxxOOEKnWLOAgooU
        g2cAv9iw6jlzV9AA==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] soc/tegra: pmc: Allow optional irq parent callbacks
Cc:     Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160243903963.7002.3567031676396410554.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     8681cc33f817842df7ebe3c36558d97f5497a177
Gitweb:        https://git.kernel.org/tip/8681cc33f817842df7ebe3c36558d97f5497a177
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sun, 04 Oct 2020 21:16:24 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 10 Oct 2020 12:12:11 +01:00

soc/tegra: pmc: Allow optional irq parent callbacks

Make the PMC driver resistent to variable depth interrupt hierarchy,
which we are about to introduce.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/soc/tegra/pmc.c | 36 ++++++++++++++++++++++++++++++++----
 1 file changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index d332e5d..b39536c 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -2184,6 +2184,34 @@ static int tegra186_pmc_irq_set_type(struct irq_data *data, unsigned int type)
 	return 0;
 }
 
+static void tegra_irq_mask_parent(struct irq_data *data)
+{
+	if (data->parent_data)
+		irq_chip_mask_parent(data);
+}
+
+static void tegra_irq_unmask_parent(struct irq_data *data)
+{
+	if (data->parent_data)
+		irq_chip_unmask_parent(data);
+}
+
+static void tegra_irq_eoi_parent(struct irq_data *data)
+{
+	if (data->parent_data)
+		irq_chip_eoi_parent(data);
+}
+
+static int tegra_irq_set_affinity_parent(struct irq_data *data,
+					 const struct cpumask *dest,
+					 bool force)
+{
+	if (data->parent_data)
+		return irq_chip_set_affinity_parent(data, dest, force);
+
+	return -EINVAL;
+}
+
 static int tegra_pmc_irq_init(struct tegra_pmc *pmc)
 {
 	struct irq_domain *parent = NULL;
@@ -2199,10 +2227,10 @@ static int tegra_pmc_irq_init(struct tegra_pmc *pmc)
 		return 0;
 
 	pmc->irq.name = dev_name(pmc->dev);
-	pmc->irq.irq_mask = irq_chip_mask_parent;
-	pmc->irq.irq_unmask = irq_chip_unmask_parent;
-	pmc->irq.irq_eoi = irq_chip_eoi_parent;
-	pmc->irq.irq_set_affinity = irq_chip_set_affinity_parent;
+	pmc->irq.irq_mask = tegra_irq_mask_parent;
+	pmc->irq.irq_unmask = tegra_irq_unmask_parent;
+	pmc->irq.irq_eoi = tegra_irq_eoi_parent;
+	pmc->irq.irq_set_affinity = tegra_irq_set_affinity_parent;
 	pmc->irq.irq_set_type = pmc->soc->irq_set_type;
 	pmc->irq.irq_set_wake = pmc->soc->irq_set_wake;
 
