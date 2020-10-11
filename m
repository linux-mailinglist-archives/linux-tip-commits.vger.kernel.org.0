Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3535928A8F9
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 20:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730460AbgJKSAH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 14:00:07 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40062 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388430AbgJKR5c (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:32 -0400
Date:   Sun, 11 Oct 2020 17:57:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439050;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=+DYa4yMKnp+EAENRXW8fehgg9O4v9rA6xRdUVV5Tkr0=;
        b=k2w0KA1ZV8CMjItH+TifhrhSgVR1/b5cUEiGVcy93JHj2gEYaTqwRjsRMuBC/ToDoaglDg
        +rr73e9u5H+lZlEycECbXu/3G5Gjwl2A0jJUZZ7n1Gk9O8MKZM07fCXSNmI66hIJzOQY+a
        fKY5CLnOFzzsN0R0Rtjj0TKNpOGGC/R06AQSmSW/OAC8Z006o+OtBIfX6FdmBlvWyD7flY
        DrnaBO+h1KOnjaU+ksCM3xe08+yDmT83BWgRfRTgMvz5hRbfriBlOJ0DAU36Pl1/MB/+6T
        CMwebTEMpwoHJgnKO9K9MHy6p8OAsWzlsQR8cYM3t5RcWddc2jq0DF7uXECa8g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439050;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=+DYa4yMKnp+EAENRXW8fehgg9O4v9rA6xRdUVV5Tkr0=;
        b=y5PbP8TFzP/bSW/2oJQawzTpyLcQWkeN6mrHaYosbzCkjcnz1nSeIKnJqp21V956cpe5Qv
        +e3OWMeRGS0xeHCw==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/bcm2836: Provide mask/unmask dummy methods for IPIs
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160243905003.7002.14747918152458549784.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     c3330399931be38ce459e82bf7dea140338ae43f
Gitweb:        https://git.kernel.org/tip/c3330399931be38ce459e82bf7dea140338ae43f
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 14 Sep 2020 17:21:16 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 17 Sep 2020 16:37:28 +01:00

irqchip/bcm2836: Provide mask/unmask dummy methods for IPIs

Although it doesn't seem possible to disable individual mailbox
interrupts, we still need to provide some callbacks.

Fixes: 09eb672ce4fb ("irqchip/bcm2836: Configure mailbox interrupts as standard interrupts")
Reported-by: Marek Szyprowski <m.szyprowski@samsung.com>
Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-bcm2836.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-bcm2836.c b/drivers/irqchip/irq-bcm2836.c
index 85df6dd..97838eb 100644
--- a/drivers/irqchip/irq-bcm2836.c
+++ b/drivers/irqchip/irq-bcm2836.c
@@ -193,6 +193,8 @@ static void bcm2836_arm_irqchip_ipi_send_mask(struct irq_data *d,
 
 static struct irq_chip bcm2836_arm_irqchip_ipi = {
 	.name		= "IPI",
+	.irq_mask	= bcm2836_arm_irqchip_dummy_op,
+	.irq_unmask	= bcm2836_arm_irqchip_dummy_op,
 	.irq_eoi	= bcm2836_arm_irqchip_ipi_eoi,
 	.ipi_send_mask	= bcm2836_arm_irqchip_ipi_send_mask,
 };
