Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F41432A1FB7
	for <lists+linux-tip-commits@lfdr.de>; Sun,  1 Nov 2020 18:00:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727072AbgKARAN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 1 Nov 2020 12:00:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53834 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726791AbgKARAM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 1 Nov 2020 12:00:12 -0500
Date:   Sun, 01 Nov 2020 17:00:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604250010;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aCnuJ3lVmHHG4SSasG7csbDqsih9xX8WfJDoPw/c1LM=;
        b=ykIuZj0s4zoDLvY5BUcYHH6Eyos4NlR7+fWNuwKs1hLQOBjS3BXOxBfH+HjFATVfuKiVzp
        guKTmbVHksblERjPFzGqk6aFYWc4m9JWs82dTwZSGBvEK0+98j+U668oJMmZDhK8ZEf8PR
        pwWEfwcWsQP9tk4B/w+dKlqdb6+xwRx8w6Z32YwabMALPHyYA7Bb07WuR+jEQb+4JgpYLZ
        9Lq477hN0mjewaIOwlJPa53vwHGZpyO5JhTA6ZJFNCtyPWwy/qyCLwoZ2aOJD9YVUCrn+O
        BAIiKhbhbcMeaT6EQoHMQAuOPAueTPA9fYQOxF+coIweBPmBfvyiHM9hw/0Sqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604250010;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aCnuJ3lVmHHG4SSasG7csbDqsih9xX8WfJDoPw/c1LM=;
        b=BpkO4QJZ4/j/YcOPOwrXBf/x7wH1VjQb+MzHbUQ/XzM4v8brwvhYmvYXr+vzbtURgqODKu
        zsHqXryZhQDJx/DA==
From:   "tip-bot2 for Greentime Hu" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/sifive-plic: Fix chip_data access within a
 hierarchy
Cc:     Greentime Hu <greentime.hu@sifive.com>,
        Marc Zyngier <maz@kernel.org>,
        Anup Patel <anup@brainfault.org>,
        Atish Patra <atish.patra@wdc.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201029023738.127472-1-greentime.hu@sifive.com>
References: <20201029023738.127472-1-greentime.hu@sifive.com>
MIME-Version: 1.0
Message-ID: <160425000919.397.3903804075850306877.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     f9ac7bbd6e4540dcc6df621b9c9b6eb2e26ded1d
Gitweb:        https://git.kernel.org/tip/f9ac7bbd6e4540dcc6df621b9c9b6eb2e26ded1d
Author:        Greentime Hu <greentime.hu@sifive.com>
AuthorDate:    Thu, 29 Oct 2020 10:37:38 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 01 Nov 2020 11:52:27 

irqchip/sifive-plic: Fix chip_data access within a hierarchy

The plic driver crashes in plic_irq_unmask() when the interrupt is within a
hierarchy, as it picks the top-level chip_data instead of its local one.

Using irq_data_get_irq_chip_data() instead of irq_get_chip_data() solves
the issue for good.

Fixes: f1ad1133b18f ("irqchip/sifive-plic: Add support for multiple PLICs")
Signed-off-by: Greentime Hu <greentime.hu@sifive.com>
[maz: rewrote commit message]
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Anup Patel <anup@brainfault.org>
Reviewed-by: Atish Patra <atish.patra@wdc.com>
Link: https://lore.kernel.org/r/20201029023738.127472-1-greentime.hu@sifive.com
---
 drivers/irqchip/irq-sifive-plic.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/irqchip/irq-sifive-plic.c b/drivers/irqchip/irq-sifive-plic.c
index 4048657..6f432d2 100644
--- a/drivers/irqchip/irq-sifive-plic.c
+++ b/drivers/irqchip/irq-sifive-plic.c
@@ -99,7 +99,7 @@ static inline void plic_irq_toggle(const struct cpumask *mask,
 				   struct irq_data *d, int enable)
 {
 	int cpu;
-	struct plic_priv *priv = irq_get_chip_data(d->irq);
+	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
 
 	writel(enable, priv->regs + PRIORITY_BASE + d->hwirq * PRIORITY_PER_ID);
 	for_each_cpu(cpu, mask) {
@@ -115,7 +115,7 @@ static void plic_irq_unmask(struct irq_data *d)
 {
 	struct cpumask amask;
 	unsigned int cpu;
-	struct plic_priv *priv = irq_get_chip_data(d->irq);
+	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
 
 	cpumask_and(&amask, &priv->lmask, cpu_online_mask);
 	cpu = cpumask_any_and(irq_data_get_affinity_mask(d),
@@ -127,7 +127,7 @@ static void plic_irq_unmask(struct irq_data *d)
 
 static void plic_irq_mask(struct irq_data *d)
 {
-	struct plic_priv *priv = irq_get_chip_data(d->irq);
+	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
 
 	plic_irq_toggle(&priv->lmask, d, 0);
 }
@@ -138,7 +138,7 @@ static int plic_set_affinity(struct irq_data *d,
 {
 	unsigned int cpu;
 	struct cpumask amask;
-	struct plic_priv *priv = irq_get_chip_data(d->irq);
+	struct plic_priv *priv = irq_data_get_irq_chip_data(d);
 
 	cpumask_and(&amask, &priv->lmask, mask_val);
 
