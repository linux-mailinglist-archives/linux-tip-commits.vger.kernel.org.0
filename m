Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EBBD103B39
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Nov 2019 14:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730508AbfKTNXR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Nov 2019 08:23:17 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:56689 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730150AbfKTNVK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Nov 2019 08:21:10 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iXPun-00074U-Ap; Wed, 20 Nov 2019 14:21:01 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0D44D1C19FE;
        Wed, 20 Nov 2019 14:21:01 +0100 (CET)
Date:   Wed, 20 Nov 2019 13:21:00 -0000
From:   "tip-bot2 for Lina Iyer" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/qcom-pdc: Update max PDC interrupts
Cc:     Lina Iyer <ilina@codeaurora.org>, Marc Zyngier <maz@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <1573855915-9841-3-git-send-email-ilina@codeaurora.org>
References: <1573855915-9841-3-git-send-email-ilina@codeaurora.org>
MIME-Version: 1.0
Message-ID: <157425606097.12247.10982896234326529807.tip-bot2@tip-bot2>
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

Commit-ID:     b2bb01ed0894c6d5d31cfa8aafb6ddbd7df2dd3f
Gitweb:        https://git.kernel.org/tip/b2bb01ed0894c6d5d31cfa8aafb6ddbd7df2dd3f
Author:        Lina Iyer <ilina@codeaurora.org>
AuthorDate:    Fri, 15 Nov 2019 15:11:45 -07:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 16 Nov 2019 10:20:40 

irqchip/qcom-pdc: Update max PDC interrupts

Newer SoCs have increased the number of interrupts routed to the PDC
interrupt controller. Update the definition of max PDC interrupts.

Signed-off-by: Lina Iyer <ilina@codeaurora.org>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Reviewed-by: Stephen Boyd <swboyd@chromium.org>
Link: https://lore.kernel.org/r/1573855915-9841-3-git-send-email-ilina@codeaurora.org
---
 drivers/irqchip/qcom-pdc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/irqchip/qcom-pdc.c b/drivers/irqchip/qcom-pdc.c
index c175333..690cf10 100644
--- a/drivers/irqchip/qcom-pdc.c
+++ b/drivers/irqchip/qcom-pdc.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 /*
- * Copyright (c) 2017-2018, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2017-2019, The Linux Foundation. All rights reserved.
  */
 
 #include <linux/err.h>
@@ -18,7 +18,7 @@
 #include <linux/slab.h>
 #include <linux/types.h>
 
-#define PDC_MAX_IRQS		126
+#define PDC_MAX_IRQS		168
 
 #define CLEAR_INTR(reg, intr)	(reg & ~(1 << intr))
 #define ENABLE_INTR(reg, intr)	(reg | (1 << intr))
