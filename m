Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C53EB197020
	for <lists+linux-tip-commits@lfdr.de>; Sun, 29 Mar 2020 22:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728725AbgC2U0U (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 29 Mar 2020 16:26:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56953 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728814AbgC2U0T (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 29 Mar 2020 16:26:19 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIeVc-0001MC-Vq; Sun, 29 Mar 2020 22:26:17 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 919DE1C0470;
        Sun, 29 Mar 2020 22:26:11 +0200 (CEST)
Date:   Sun, 29 Mar 2020 20:26:11 -0000
From:   "tip-bot2 for Michal Simek" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/xilinx: Fill error code when irq domain
 registration fails
Cc:     Michal Simek <michal.simek@xilinx.com>,
        Marc Zyngier <maz@kernel.org>,
        Stefan Asserhall <stefan.asserhall@xilinx.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200317125600.15913-3-mubin.usman.sayyed@xilinx.com>
References: <20200317125600.15913-3-mubin.usman.sayyed@xilinx.com>
MIME-Version: 1.0
Message-ID: <158551357125.28353.14243002761268594399.tip-bot2@tip-bot2>
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

Commit-ID:     c74038baa9bccac76344b7215a55be136c81dfc3
Gitweb:        https://git.kernel.org/tip/c74038baa9bccac76344b7215a55be136c81dfc3
Author:        Michal Simek <michal.simek@xilinx.com>
AuthorDate:    Tue, 17 Mar 2020 18:25:58 +05:30
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 22 Mar 2020 11:52:53 

irqchip/xilinx: Fill error code when irq domain registration fails

There is no ret filled in case of irq_domain_add_linear() failure.

Signed-off-by: Michal Simek <michal.simek@xilinx.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Stefan Asserhall <stefan.asserhall@xilinx.com>
Link: https://lore.kernel.org/r/20200317125600.15913-3-mubin.usman.sayyed@xilinx.com
---
 drivers/irqchip/irq-xilinx-intc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
index 34593fa..1d3d273 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -228,6 +228,7 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
 						  &xintc_irq_domain_ops, irqc);
 	if (!irqc->root_domain) {
 		pr_err("irq-xilinx: Unable to create IRQ domain\n");
+		ret = -EINVAL;
 		goto error;
 	}
 
