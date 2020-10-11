Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6309C28A911
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 20:01:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726413AbgJKSBC (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 14:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388373AbgJKR5X (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:23 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 297D8C0613CE;
        Sun, 11 Oct 2020 10:57:23 -0700 (PDT)
Date:   Sun, 11 Oct 2020 17:57:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439041;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=jgLyAFwgrevzgXbmf+oI/pK+6vYeK7gb2zRyrAIMmI8=;
        b=sbz185gIr2zZ1uZvJ1gcdhKlT6WsshKx4yO08yeS8vLhgUDxCHxFZSeedSWQDRy6v6bX8m
        52H5x7mhgM/UiD84NP8mQOgVLBAWJp9sBZgJMHP7Xi9SNVrq47yDNC4QSEpOeSKhUrPY2W
        Epbj2P6H+27/y77Jv8ZbKK5iVGusA3WFfMsp7YjwejayMWwZhnMc/Z39M/9zFTVyrbUzAM
        GSxlGhiqE/2aQtaFc12DQTc90371AXpb/wcpQqB1hbPrNRA3efwFDoyX62LhRemRekbmG4
        m4rkkkaWc7dVYX7MlVdTJ6f7empsao16Gl1MuD/cfQTmbZ8sp/jnLPrFof4Mew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439041;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=jgLyAFwgrevzgXbmf+oI/pK+6vYeK7gb2zRyrAIMmI8=;
        b=6s/kIkWFHsSmHkZweP2JrPmWmW9CmtZCWzGrfLAM11woxAy+CqX0Jvz9lFHWhRQAb1ZcJZ
        csp40WK5gT8WBTBg==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq/irqdomain: Allow partial trimming of irq_data
 hierarchy
Cc:     Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160243904069.7002.13341966677671561410.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     55567976629e58fde28fb70612ca73228271eef2
Gitweb:        https://git.kernel.org/tip/55567976629e58fde28fb70612ca73228271eef2
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 06 Oct 2020 10:10:20 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 10 Oct 2020 12:12:10 +01:00

genirq/irqdomain: Allow partial trimming of irq_data hierarchy

It appears that some HW is ugly enough that not all the interrupts
connected to a particular interrupt controller end up with the same
hierarchy depth (some of them are terminated early). This leaves
the irqchip hacker with only two choices, both equally bad:

- create discrete domain chains, one for each "hierarchy depth",
  which is very hard to maintain

- create fake hierarchy levels for the shallow paths, leading
  to all kind of problems (what are the safe hwirq values for these
  fake levels?)

Implement the ability to cut short a single interrupt hierarchy
from a level marked as being disconnected by using the new
irq_domain_disconnect_hierarchy() helper.

The irqdomain allocation code will then perform the trimming

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irqdomain.h |   3 +-
 kernel/irq/irqdomain.c    |  99 +++++++++++++++++++++++++++++++++++--
 2 files changed, 98 insertions(+), 4 deletions(-)

diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index b37350c..a52b095 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -509,6 +509,9 @@ extern void irq_domain_free_irqs_parent(struct irq_domain *domain,
 					unsigned int irq_base,
 					unsigned int nr_irqs);
 
+extern int irq_domain_disconnect_hierarchy(struct irq_domain *domain,
+					   unsigned int virq);
+
 static inline bool irq_domain_is_hierarchy(struct irq_domain *domain)
 {
 	return domain->flags & IRQ_DOMAIN_FLAG_HIERARCHY;
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 76cd7eb..cf8b374 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -1136,6 +1136,17 @@ static struct irq_data *irq_domain_insert_irq_data(struct irq_domain *domain,
 	return irq_data;
 }
 
+static void __irq_domain_free_hierarchy(struct irq_data *irq_data)
+{
+	struct irq_data *tmp;
+
+	while (irq_data) {
+		tmp = irq_data;
+		irq_data = irq_data->parent_data;
+		kfree(tmp);
+	}
+}
+
 static void irq_domain_free_irq_data(unsigned int virq, unsigned int nr_irqs)
 {
 	struct irq_data *irq_data, *tmp;
@@ -1147,12 +1158,83 @@ static void irq_domain_free_irq_data(unsigned int virq, unsigned int nr_irqs)
 		irq_data->parent_data = NULL;
 		irq_data->domain = NULL;
 
-		while (tmp) {
-			irq_data = tmp;
-			tmp = tmp->parent_data;
-			kfree(irq_data);
+		__irq_domain_free_hierarchy(tmp);
+	}
+}
+
+/**
+ * irq_domain_disconnect_hierarchy - Mark the first unused level of a hierarchy
+ * @domain:	IRQ domain from which the hierarchy is to be disconnected
+ * @virq:	IRQ number where the hierarchy is to be trimmed
+ *
+ * Marks the @virq level belonging to @domain as disconnected.
+ * Returns -EINVAL if @virq doesn't have a valid irq_data pointing
+ * to @domain.
+ *
+ * Its only use is to be able to trim levels of hierarchy that do not
+ * have any real meaning for this interrupt, and that the driver marks
+ * as such from its .alloc() callback.
+ */
+int irq_domain_disconnect_hierarchy(struct irq_domain *domain,
+				    unsigned int virq)
+{
+	struct irq_data *irqd;
+
+	irqd = irq_domain_get_irq_data(domain, virq);
+	if (!irqd)
+		return -EINVAL;
+
+	irqd->chip = ERR_PTR(-ENOTCONN);
+	return 0;
+}
+
+static int irq_domain_trim_hierarchy(unsigned int virq)
+{
+	struct irq_data *tail, *irqd, *irq_data;
+
+	irq_data = irq_get_irq_data(virq);
+	tail = NULL;
+
+	/* The first entry must have a valid irqchip */
+	if (!irq_data->chip || IS_ERR(irq_data->chip))
+		return -EINVAL;
+
+	/*
+	 * Validate that the irq_data chain is sane in the presence of
+	 * a hierarchy trimming marker.
+	 */
+	for (irqd = irq_data->parent_data; irqd; irq_data = irqd, irqd = irqd->parent_data) {
+		/* Can't have a valid irqchip after a trim marker */
+		if (irqd->chip && tail)
+			return -EINVAL;
+
+		/* Can't have an empty irqchip before a trim marker */
+		if (!irqd->chip && !tail)
+			return -EINVAL;
+
+		if (IS_ERR(irqd->chip)) {
+			/* Only -ENOTCONN is a valid trim marker */
+			if (PTR_ERR(irqd->chip) != -ENOTCONN)
+				return -EINVAL;
+
+			tail = irq_data;
 		}
 	}
+
+	/* No trim marker, nothing to do */
+	if (!tail)
+		return 0;
+
+	pr_info("IRQ%d: trimming hierarchy from %s\n",
+		virq, tail->parent_data->domain->name);
+
+	/* Sever the inner part of the hierarchy...  */
+	irqd = tail;
+	tail = tail->parent_data;
+	irqd->parent_data = NULL;
+	__irq_domain_free_hierarchy(tail);
+
+	return 0;
 }
 
 static int irq_domain_alloc_irq_data(struct irq_domain *domain,
@@ -1362,6 +1444,15 @@ int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
 		mutex_unlock(&irq_domain_mutex);
 		goto out_free_irq_data;
 	}
+
+	for (i = 0; i < nr_irqs; i++) {
+		ret = irq_domain_trim_hierarchy(virq + i);
+		if (ret) {
+			mutex_unlock(&irq_domain_mutex);
+			goto out_free_irq_data;
+		}
+	}
+	
 	for (i = 0; i < nr_irqs; i++)
 		irq_domain_insert_irq(virq + i);
 	mutex_unlock(&irq_domain_mutex);
