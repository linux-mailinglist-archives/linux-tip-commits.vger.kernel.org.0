Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9524028A8B6
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 19:58:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388438AbgJKR6N (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:58:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40264 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388329AbgJKR5u (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:50 -0400
Date:   Sun, 11 Oct 2020 17:57:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439068;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=09HPNPY90TqCVbeYr8hs2feznvKP4K5w4jdxVA3Z9jo=;
        b=OZEOY5k+FfcF7PZLKSCIs4vZFe0hGrFCimjghRNBFOpAMTAQ+in3ahALWC4BY9naL5+8Uu
        KfCEejBGfWSwVtLPyWDNamRjamPV3YR8BW+qRG3v59srOD3ibTL4oTdx03UTIiYmTNtNad
        79oU/VQQ+cRNq7n5lM1f3Hx7aKreukiTKPSQyyBNDSIAoPSWymCiWFyLGXL0rHJ74OUH37
        vFnNZgolnmlXvhbmgut92Cta1xK+dceXBfqjDcs3NhNv+jxaL5JCQOou2Cx/Cak0kwu7/u
        33rWESJCWTxVjF+mzhSGO1nvFwWd/Cq9N54ITWaUfU/WyGzECWpKIEi4VUDmJw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439068;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=09HPNPY90TqCVbeYr8hs2feznvKP4K5w4jdxVA3Z9jo=;
        b=92sCyNJk3QUgnZSimRfSh6uuXNHIK+lwS3oPbSPvv64o9CG/ncQdMPVj2tOlP94XQthwjK
        n2J+moJWFARewJAg==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v2, v3: Implement irq_chip->irq_retrigger()
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200730170321.31228-2-valentin.schneider@arm.com>
References: <20200730170321.31228-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <160243906734.7002.1103809898484089750.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     17f644e949ffb14e9c8870d99bc574066d8b685c
Gitweb:        https://git.kernel.org/tip/17f644e949ffb14e9c8870d99bc574066d8b685c
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Thu, 30 Jul 2020 18:03:20 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 06 Sep 2020 18:26:13 +01:00

irqchip/gic-v2, v3: Implement irq_chip->irq_retrigger()

While digging around IRQCHIP_EOI_IF_HANDLED and irq/resend.c, it has come
to my attention that the IRQ resend situation seems a bit precarious for
the GIC(s).

When marking an IRQ with IRQS_PENDING, handle_fasteoi_irq() will bail out
and issue an irq_eoi(). Should the IRQ in question be re-enabled,
check_irq_resend() will trigger a SW resend, which will go through the flow
handler again and issue *another* irq_eoi() on the *same* IRQ
activation. This is something the GIC spec clearly describes as a bad idea:
any EOI must match a previous ACK.

Implement irq_chip.irq_retrigger() for the GIC chips by setting the GIC
pending bit of the relevant IRQ. After being called by check_irq_resend(),
this will eventually trigger a *new* interrupt which we will handle as usual.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200730170321.31228-2-valentin.schneider@arm.com
---
 drivers/irqchip/irq-gic-v3.c | 7 +++++++
 drivers/irqchip/irq-gic.c    | 6 ++++++
 2 files changed, 13 insertions(+)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index 324f280..b507bc7 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1207,6 +1207,11 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 #define gic_smp_init()		do { } while(0)
 #endif
 
+static int gic_retrigger(struct irq_data *data)
+{
+	return !gic_irq_set_irqchip_state(data, IRQCHIP_STATE_PENDING, true);
+}
+
 #ifdef CONFIG_CPU_PM
 static int gic_cpu_pm_notifier(struct notifier_block *self,
 			       unsigned long cmd, void *v)
@@ -1242,6 +1247,7 @@ static struct irq_chip gic_chip = {
 	.irq_eoi		= gic_eoi_irq,
 	.irq_set_type		= gic_set_type,
 	.irq_set_affinity	= gic_set_affinity,
+	.irq_retrigger          = gic_retrigger,
 	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
 	.irq_nmi_setup		= gic_irq_nmi_setup,
@@ -1258,6 +1264,7 @@ static struct irq_chip gic_eoimode1_chip = {
 	.irq_eoi		= gic_eoimode1_eoi_irq,
 	.irq_set_type		= gic_set_type,
 	.irq_set_affinity	= gic_set_affinity,
+	.irq_retrigger          = gic_retrigger,
 	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
 	.irq_set_vcpu_affinity	= gic_irq_set_vcpu_affinity,
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index a27ba2c..e92ee2b 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -347,6 +347,11 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *mask_val,
 }
 #endif
 
+static int gic_retrigger(struct irq_data *data)
+{
+	return !gic_irq_set_irqchip_state(data, IRQCHIP_STATE_PENDING, true);
+}
+
 static void __exception_irq_entry gic_handle_irq(struct pt_regs *regs)
 {
 	u32 irqstat, irqnr;
@@ -417,6 +422,7 @@ static const struct irq_chip gic_chip = {
 	.irq_unmask		= gic_unmask_irq,
 	.irq_eoi		= gic_eoi_irq,
 	.irq_set_type		= gic_set_type,
+	.irq_retrigger          = gic_retrigger,
 	.irq_get_irqchip_state	= gic_irq_get_irqchip_state,
 	.irq_set_irqchip_state	= gic_irq_set_irqchip_state,
 	.flags			= IRQCHIP_SET_TYPE_MASKED |
