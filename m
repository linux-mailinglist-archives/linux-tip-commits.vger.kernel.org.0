Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 636EF28A8BA
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 19:58:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388617AbgJKR6U (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:58:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40252 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388521AbgJKR5t (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:49 -0400
Date:   Sun, 11 Oct 2020 17:57:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zSLQIo6GDvVU/JIB1rfnuu11ZNIA+FwpxQPi1tYrvYY=;
        b=ak99HN0WU0xPwbis+iw7HVJ6S8gtnBzN1Sdiy3+E5PJmxSe7a1a+x/zuGjHNko6jS4s0IH
        PEe+2VEJbFrrAe5ppm4eje66FWwWFaxHFsWpbh8zFcKrcsGa8k4rRwZs2+baLA/xL3DPY9
        QXTiLV5jVDGGfVrf15TXuS1GJWTw+xtEItSBa7A+XHj1PZ7u9PVFSmmmK463mJmODxo5Os
        nqEr494DiuHsSwTEdTko6Ei12y2M+/s/Gwx2wW8ZnFk2WHb7WjUG6+wWx1r7PJO96pjAOD
        JgzpYa2cXMmah8/goGQraQHrmJ9LF2dC+BczkU66QyQ9epZOnfUc/Vf/dgHmyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439067;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zSLQIo6GDvVU/JIB1rfnuu11ZNIA+FwpxQPi1tYrvYY=;
        b=oxSKT8UOPIOdsAjmP4qDbfXst1CxJy9WUZDQqCDDex67dj/VpjBWFhEh+EaudAu7jQ0DtR
        wZmtVif2BJPfSiAA==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-v2, v3: Prevent SW resends entirely
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200730170321.31228-3-valentin.schneider@arm.com>
References: <20200730170321.31228-3-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <160243906633.7002.16746873464528215330.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     1b57d91b969cda1d2c3530f2e829ca366a9c7df7
Gitweb:        https://git.kernel.org/tip/1b57d91b969cda1d2c3530f2e829ca366a9c7df7
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Thu, 30 Jul 2020 18:03:21 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 06 Sep 2020 18:26:13 +01:00

irqchip/gic-v2, v3: Prevent SW resends entirely

The GIC irqchips can now use a HW resend when a retrigger is invoked by
check_irq_resend(). However, should the HW resend fail, check_irq_resend()
will still attempt to trigger a SW resend, which is still a bad idea for
the GICs.

Prevent this from happening by setting IRQD_HANDLE_ENFORCE_IRQCTX on all
GIC IRQs. Technically per-cpu IRQs do not need this, as their flow handlers
never set IRQS_PENDING, but this aligns all IRQs wrt context enforcement:
this also forces all GIC IRQ handling to happen in IRQ context (as defined
by in_irq()).

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200730170321.31228-3-valentin.schneider@arm.com
---
 drivers/irqchip/irq-gic-v3.c | 5 ++++-
 drivers/irqchip/irq-gic.c    | 6 +++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/irq-gic-v3.c b/drivers/irqchip/irq-gic-v3.c
index b507bc7..4e9387a 100644
--- a/drivers/irqchip/irq-gic-v3.c
+++ b/drivers/irqchip/irq-gic-v3.c
@@ -1279,6 +1279,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 			      irq_hw_number_t hw)
 {
 	struct irq_chip *chip = &gic_chip;
+	struct irq_data *irqd = irq_desc_get_irq_data(irq_to_desc(irq));
 
 	if (static_branch_likely(&supports_deactivate_key))
 		chip = &gic_eoimode1_chip;
@@ -1296,7 +1297,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 		irq_domain_set_info(d, irq, hw, chip, d->host_data,
 				    handle_fasteoi_irq, NULL, NULL);
 		irq_set_probe(irq);
-		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(irq)));
+		irqd_set_single_target(irqd);
 		break;
 
 	case LPI_RANGE:
@@ -1310,6 +1311,8 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 		return -EPERM;
 	}
 
+	/* Prevents SW retriggers which mess up the ACK/EOI ordering */
+	irqd_set_handle_enforce_irqctx(irqd);
 	return 0;
 }
 
diff --git a/drivers/irqchip/irq-gic.c b/drivers/irqchip/irq-gic.c
index e92ee2b..b59bcef 100644
--- a/drivers/irqchip/irq-gic.c
+++ b/drivers/irqchip/irq-gic.c
@@ -975,6 +975,7 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 				irq_hw_number_t hw)
 {
 	struct gic_chip_data *gic = d->host_data;
+	struct irq_data *irqd = irq_desc_get_irq_data(irq_to_desc(irq));
 
 	if (hw < 32) {
 		irq_set_percpu_devid(irq);
@@ -984,8 +985,11 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int irq,
 		irq_domain_set_info(d, irq, hw, &gic->chip, d->host_data,
 				    handle_fasteoi_irq, NULL, NULL);
 		irq_set_probe(irq);
-		irqd_set_single_target(irq_desc_get_irq_data(irq_to_desc(irq)));
+		irqd_set_single_target(irqd);
 	}
+
+	/* Prevents SW retriggers which mess up the ACK/EOI ordering */
+	irqd_set_handle_enforce_irqctx(irqd);
 	return 0;
 }
 
