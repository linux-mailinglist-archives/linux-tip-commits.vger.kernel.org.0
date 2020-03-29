Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 59B4419700C
	for <lists+linux-tip-commits@lfdr.de>; Sun, 29 Mar 2020 22:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgC2U1Q (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 29 Mar 2020 16:27:16 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57026 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728880AbgC2U01 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 29 Mar 2020 16:26:27 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIeVl-0001TN-Ef; Sun, 29 Mar 2020 22:26:25 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1C1AB1C0334;
        Sun, 29 Mar 2020 22:26:20 +0200 (CEST)
Date:   Sun, 29 Mar 2020 20:26:19 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/atmel-aic: Fix irq_retrigger callback return value
Cc:     Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200310184921.23552-2-maz@kernel.org>
References: <20200310184921.23552-2-maz@kernel.org>
MIME-Version: 1.0
Message-ID: <158551357965.28353.10773665129651597686.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     7177144a54f594f8815b777ae647e58b07c03f86
Gitweb:        https://git.kernel.org/tip/7177144a54f594f8815b777ae647e58b07c03f86
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 10 Mar 2020 18:49:18 
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Mon, 16 Mar 2020 15:48:54 

irqchip/atmel-aic: Fix irq_retrigger callback return value

The irq_retrigger callback is supposed to return 0 when retrigger
has failed, and a non-zero value otherwise. Tell the core code
that the driver has succedded in using the HW to retrigger the
interrupt.

Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20200310184921.23552-2-maz@kernel.org
---
 drivers/irqchip/irq-atmel-aic.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/irq-atmel-aic.c b/drivers/irqchip/irq-atmel-aic.c
index bb1ad45..2c999dc 100644
--- a/drivers/irqchip/irq-atmel-aic.c
+++ b/drivers/irqchip/irq-atmel-aic.c
@@ -83,7 +83,7 @@ static int aic_retrigger(struct irq_data *d)
 	irq_reg_writel(gc, d->mask, AT91_AIC_ISCR);
 	irq_gc_unlock(gc);
 
-	return 0;
+	return 1;
 }
 
 static int aic_set_type(struct irq_data *d, unsigned type)
