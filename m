Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 823403E5BF4
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 15:41:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238284AbhHJNln (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 09:41:43 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43458 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235257AbhHJNlm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 09:41:42 -0400
Date:   Tue, 10 Aug 2021 13:41:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628602879;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nV+NLjMHO7grMMy3oGzbX4CobAYgJrB1GLNhO9byzuw=;
        b=LOdW+/ALI7SFSeuWm5Ty65G2ZAGHl07hxtXFtA5IVZ2ujDgOTgoICkydNCBcTgou0aBY1d
        yl9E4TEnW8oMH1rIitPQmCbEr25YQ0DK1mwgH7+3UCB4kTf1mJqxRmZbn1/IPwzsg1IIod
        aVGh+nUeKBKDSoM1emesKOCX4fWuv3a7atSKnMsoBiwVk2AIGTvD23wwlP1Y6eHQrA7ChF
        VoFngq/qT+JzgaU2rKVLH5DeIiGIgXjtAw9hoCdXiKMqMQyT3CWS2LYO+UiYk7wIllplBr
        x1OZmiEQcMmVkxNN8cqCT5+mwiicOfWhJgYEOdQ5FOPPzlhrY6HZObqMIx5uOg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628602879;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nV+NLjMHO7grMMy3oGzbX4CobAYgJrB1GLNhO9byzuw=;
        b=hLFoEeXX6zJ9+B++C4ZkvsakUq0kblZ/4SFNZK9uztVhXBOrVAwlWtjHgnh4zWuuB133u9
        +e+o9KONqH6V/uCQ==
From:   "tip-bot2 for Gustavo A. R. Silva" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/generic_chip: Use struct_size() in kzalloc()
Cc:     "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210513212729.GA214145@embeddedor>
References: <20210513212729.GA214145@embeddedor>
MIME-Version: 1.0
Message-ID: <162860287844.395.14790281873469902502.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     5a6c76b5de59ed508d7cb133327a7c54e77fed97
Gitweb:        https://git.kernel.org/tip/5a6c76b5de59ed508d7cb133327a7c54e77fed97
Author:        Gustavo A. R. Silva <gustavoars@kernel.org>
AuthorDate:    Thu, 13 May 2021 16:27:29 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 15:35:20 +02:00

genirq/generic_chip: Use struct_size() in kzalloc()

Make use of the struct_size() helper instead of an open-coded version,
in order to avoid any potential type mistakes or integer overflows
that, in the worst scenario, could lead to heap overflows.

This code was detected with the help of Coccinelle and, audited and
fixed manually.

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210513212729.GA214145@embeddedor

---
 kernel/irq/generic-chip.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index f8f23af..cc7cdd2 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -240,9 +240,8 @@ irq_alloc_generic_chip(const char *name, int num_ct, unsigned int irq_base,
 		       void __iomem *reg_base, irq_flow_handler_t handler)
 {
 	struct irq_chip_generic *gc;
-	unsigned long sz = sizeof(*gc) + num_ct * sizeof(struct irq_chip_type);
 
-	gc = kzalloc(sz, GFP_KERNEL);
+	gc = kzalloc(struct_size(gc, chip_types, num_ct), GFP_KERNEL);
 	if (gc) {
 		irq_init_generic_chip(gc, name, num_ct, irq_base, reg_base,
 				      handler);
@@ -288,8 +287,11 @@ int __irq_alloc_domain_generic_chips(struct irq_domain *d, int irqs_per_chip,
 {
 	struct irq_domain_chip_generic *dgc;
 	struct irq_chip_generic *gc;
-	int numchips, sz, i;
 	unsigned long flags;
+	int numchips, i;
+	size_t dgc_sz;
+	size_t gc_sz;
+	size_t sz;
 	void *tmp;
 
 	if (d->gc)
@@ -300,8 +302,9 @@ int __irq_alloc_domain_generic_chips(struct irq_domain *d, int irqs_per_chip,
 		return -EINVAL;
 
 	/* Allocate a pointer, generic chip and chiptypes for each chip */
-	sz = sizeof(*dgc) + numchips * sizeof(gc);
-	sz += numchips * (sizeof(*gc) + num_ct * sizeof(struct irq_chip_type));
+	gc_sz = struct_size(gc, chip_types, num_ct);
+	dgc_sz = struct_size(dgc, gc, numchips);
+	sz = dgc_sz + numchips * gc_sz;
 
 	tmp = dgc = kzalloc(sz, GFP_KERNEL);
 	if (!dgc)
@@ -314,7 +317,7 @@ int __irq_alloc_domain_generic_chips(struct irq_domain *d, int irqs_per_chip,
 	d->gc = dgc;
 
 	/* Calc pointer to the first generic chip */
-	tmp += sizeof(*dgc) + numchips * sizeof(gc);
+	tmp += dgc_sz;
 	for (i = 0; i < numchips; i++) {
 		/* Store the pointer to the generic chip */
 		dgc->gc[i] = gc = tmp;
@@ -331,7 +334,7 @@ int __irq_alloc_domain_generic_chips(struct irq_domain *d, int irqs_per_chip,
 		list_add_tail(&gc->list, &gc_list);
 		raw_spin_unlock_irqrestore(&gc_lock, flags);
 		/* Calc pointer to the next generic chip */
-		tmp += sizeof(*gc) + num_ct * sizeof(struct irq_chip_type);
+		tmp += gc_sz;
 	}
 	return 0;
 }
