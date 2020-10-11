Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E92B28A899
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 19:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388350AbgJKR5V (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:57:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39920 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388346AbgJKR5V (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:21 -0400
Date:   Sun, 11 Oct 2020 17:57:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439039;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=1m35zJanVmLsB6a66zfzTeIqsCiAeFCLBiJAUxAUeLs=;
        b=vK2hjiuQFbclDuJx+EXrSmSMywjr//nFL/JbOVvxPYtgU/XTPW9nYjPvm464/bUmrdGZ30
        feRG345PmoGMuX2fsgrr3SQrbHbws9Wt60ZsOMVgUXtrVNSgdUWu9MR7GKVg0wB8Z8SzdR
        2UdGkJje2vs1YNYBBdgWFHTM0JOFCcFjWQN5mC939+LYVB5wKxlPGUAx3vORvhpWMOHgZU
        HGY3lwjyBHI9cbRFFRPwHpY36BGsNzMehHbRHFheRcKnp34nSqoWM7MXTFGRHpOnhBCve+
        /3O76LUF7wIAsdpSMOFQltcNnhJbLL6ddU5p29G95+2zVWRkvXOUvWoqnW1/AQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439039;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=1m35zJanVmLsB6a66zfzTeIqsCiAeFCLBiJAUxAUeLs=;
        b=+pEAfrVkMzR2XElFchbYb51xS6gtfFtGj6Gpth+iuwM+iBwhYKtTWy3rNnad70yCC60pPn
        GXSFG2okI9M1zWBw==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] soc/tegra: pmc: Don't create fake interrupt hierarchy levels
Cc:     Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160243903906.7002.10359129780852098359.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     c351ab7bf2a565951172cadbdebe686137c3fd43
Gitweb:        https://git.kernel.org/tip/c351ab7bf2a565951172cadbdebe686137c3fd43
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Sun, 04 Oct 2020 18:27:04 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 10 Oct 2020 12:12:11 +01:00

soc/tegra: pmc: Don't create fake interrupt hierarchy levels

The Tegra PMC driver does ungodly things with the interrupt hierarchy,
repeatedly corrupting it by pulling hwirq numbers out of thin air,
overriding existing IRQ mappings and changing the handling flow
of unsuspecting users.

All of this is done in the name of preserving the interrupt hierarchy
even when these levels do not exist in the HW. Together with the use
of proper IRQs for IPIs, this leads to an unbootable system as the
rescheduling IPI gets repeatedly repurposed for random drivers...

Instead, let's simply mark the level from which the hierarchy does
not make sense for the HW, and let the core code trim the usused
levels from the hierarchy.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/soc/tegra/pmc.c | 55 +++++-----------------------------------
 1 file changed, 7 insertions(+), 48 deletions(-)

diff --git a/drivers/soc/tegra/pmc.c b/drivers/soc/tegra/pmc.c
index b39536c..b0bba8a 100644
--- a/drivers/soc/tegra/pmc.c
+++ b/drivers/soc/tegra/pmc.c
@@ -1990,44 +1990,17 @@ static int tegra_pmc_irq_alloc(struct irq_domain *domain, unsigned int virq,
 							    event->id,
 							    &pmc->irq, pmc);
 
-			/*
-			 * GPIOs don't have an equivalent interrupt in the
-			 * parent controller (GIC). However some code, such
-			 * as the one in irq_get_irqchip_state(), require a
-			 * valid IRQ chip to be set. Make sure that's the
-			 * case by passing NULL here, which will install a
-			 * dummy IRQ chip for the interrupt in the parent
-			 * domain.
-			 */
-			if (domain->parent)
-				irq_domain_set_hwirq_and_chip(domain->parent,
-							      virq, 0, NULL,
-							      NULL);
-
+			/* GPIO hierarchies stop at the PMC level */
+			if (!err && domain->parent)
+ 				err = irq_domain_disconnect_hierarchy(domain->parent,
+								      virq);
 			break;
 		}
 	}
 
-	/*
-	 * For interrupts that don't have associated wake events, assign a
-	 * dummy hardware IRQ number. This is used in the ->irq_set_type()
-	 * and ->irq_set_wake() callbacks to return early for these IRQs.
-	 */
-	if (i == soc->num_wake_events) {
-		err = irq_domain_set_hwirq_and_chip(domain, virq, ULONG_MAX,
-						    &pmc->irq, pmc);
-
-		/*
-		 * Interrupts without a wake event don't have a corresponding
-		 * interrupt in the parent controller (GIC). Pass NULL for the
-		 * chip here, which causes a dummy IRQ chip to be installed
-		 * for the interrupt in the parent domain, to make this
-		 * explicit.
-		 */
-		if (domain->parent)
-			irq_domain_set_hwirq_and_chip(domain->parent, virq, 0,
-						      NULL, NULL);
-	}
+	/* If there is no wake-up event, there is no PMC mapping */
+	if (i == soc->num_wake_events)
+		err = irq_domain_disconnect_hierarchy(domain, virq);
 
 	return err;
 }
@@ -2043,9 +2016,6 @@ static int tegra210_pmc_irq_set_wake(struct irq_data *data, unsigned int on)
 	unsigned int offset, bit;
 	u32 value;
 
-	if (data->hwirq == ULONG_MAX)
-		return 0;
-
 	offset = data->hwirq / 32;
 	bit = data->hwirq % 32;
 
@@ -2080,9 +2050,6 @@ static int tegra210_pmc_irq_set_type(struct irq_data *data, unsigned int type)
 	unsigned int offset, bit;
 	u32 value;
 
-	if (data->hwirq == ULONG_MAX)
-		return 0;
-
 	offset = data->hwirq / 32;
 	bit = data->hwirq % 32;
 
@@ -2123,10 +2090,6 @@ static int tegra186_pmc_irq_set_wake(struct irq_data *data, unsigned int on)
 	unsigned int offset, bit;
 	u32 value;
 
-	/* nothing to do if there's no associated wake event */
-	if (WARN_ON(data->hwirq == ULONG_MAX))
-		return 0;
-
 	offset = data->hwirq / 32;
 	bit = data->hwirq % 32;
 
@@ -2154,10 +2117,6 @@ static int tegra186_pmc_irq_set_type(struct irq_data *data, unsigned int type)
 	struct tegra_pmc *pmc = irq_data_get_irq_chip_data(data);
 	u32 value;
 
-	/* nothing to do if there's no associated wake event */
-	if (data->hwirq == ULONG_MAX)
-		return 0;
-
 	value = readl(pmc->wake + WAKE_AOWAKE_CNTRL(data->hwirq));
 
 	switch (type) {
