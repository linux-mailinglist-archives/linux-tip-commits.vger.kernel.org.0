Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F71728A8C8
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 19:59:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388462AbgJKR6b (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:58:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40226 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388506AbgJKR5r (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:47 -0400
Date:   Sun, 11 Oct 2020 17:57:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439065;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Tux9LzQN7cQHaR9G8nK1YMCGNjPRs12VE3MaT88/1sA=;
        b=ZNJ++KJoEh4fcXFb163SU5anhbr4cnaC6lQHw9BU6tft483EThtJv/0c4DGyab43ydehDb
        Y64uZDCHW9ktiOiQbRIXbODXMPJ3zWhwuE3/dIsx5Bn9vXtg07kUzUb+e/gD/LKVg/U6CR
        5MBRM2ztwun6Smk1Kvi70Jy8G3gJi3BcQ9F62TnGubW8qECzILL4fdbo2VOnamMWdGQ7LC
        i2M6qoiMIhfqq56uqDO6RghiwF//uP3Jb7QURbQjnQS6gBEroeEV9FQArey9NR5ikpe9Oz
        ZOqTfydf1w8P47pPT2izK/+seOb1GyCobco3i4oRdumfT0rmFWaUXJHM9cFoQQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439065;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=Tux9LzQN7cQHaR9G8nK1YMCGNjPRs12VE3MaT88/1sA=;
        b=bsoZOz8Sy1JFlKWexFi05E0OAvu2YSd5TxTAzXGUPZYypVJyXJBAaIEbNoYR/2oSC5OCzj
        B6e/may4WPJm9rBw==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Add fasteoi IPI flow
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160243906427.7002.3625054420243219634.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     c5e5ec033c4ab25c53f1fd217849e75deb0bf7bf
Gitweb:        https://git.kernel.org/tip/c5e5ec033c4ab25c53f1fd217849e75deb0bf7bf
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 19 May 2020 10:41:00 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 13 Sep 2020 17:04:38 +01:00

genirq: Add fasteoi IPI flow

For irqchips using the fasteoi flow, IPIs are a bit special.
They need to be EOI'd early (before calling the handler), as
funny things may happen in the handler (they do not necessarily
behave like a normal interrupt).

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irq.h |  1 +
 kernel/irq/chip.c   | 27 +++++++++++++++++++++++++++
 2 files changed, 28 insertions(+)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 1b7f4df..57205bb 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -634,6 +634,7 @@ static inline int irq_set_parent(int irq, int parent_irq)
  */
 extern void handle_level_irq(struct irq_desc *desc);
 extern void handle_fasteoi_irq(struct irq_desc *desc);
+extern void handle_percpu_devid_fasteoi_ipi(struct irq_desc *desc);
 extern void handle_edge_irq(struct irq_desc *desc);
 extern void handle_edge_eoi_irq(struct irq_desc *desc);
 extern void handle_simple_irq(struct irq_desc *desc);
diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 857f5f4..bed517d 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -945,6 +945,33 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
 }
 
 /**
+ * handle_percpu_devid_fasteoi_ipi - Per CPU local IPI handler with per cpu
+ *				     dev ids
+ * @desc:	the interrupt description structure for this irq
+ *
+ * The biggest difference with the IRQ version is that the interrupt is
+ * EOIed early, as the IPI could result in a context switch, and we need to
+ * make sure the IPI can fire again. We also assume that the arch code has
+ * registered an action. If not, we are positively doomed.
+ */
+void handle_percpu_devid_fasteoi_ipi(struct irq_desc *desc)
+{
+	struct irq_chip *chip = irq_desc_get_chip(desc);
+	struct irqaction *action = desc->action;
+	unsigned int irq = irq_desc_get_irq(desc);
+	irqreturn_t res;
+
+	__kstat_incr_irqs_this_cpu(desc);
+
+	if (chip->irq_eoi)
+		chip->irq_eoi(&desc->irq_data);
+
+	trace_irq_handler_entry(irq, action);
+	res = action->handler(irq, raw_cpu_ptr(action->percpu_dev_id));
+	trace_irq_handler_exit(irq, action, res);
+}
+
+/**
  * handle_percpu_devid_fasteoi_nmi - Per CPU local NMI handler with per cpu
  *				     dev ids
  * @desc:	the interrupt description structure for this irq
