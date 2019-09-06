Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6FB65AB6D9
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Sep 2019 13:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728742AbfIFLJs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 6 Sep 2019 07:09:48 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47035 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392277AbfIFLIZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 6 Sep 2019 07:08:25 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i6C6H-00073S-CR; Fri, 06 Sep 2019 13:08:21 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 9385A1C0E04;
        Fri,  6 Sep 2019 13:08:15 +0200 (CEST)
Date:   Fri, 06 Sep 2019 11:08:15 -0000
From:   "tip-bot2 for Masahiro Yamada" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip: Add include guard to irq-partition-percpu.h
Cc:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156776809546.24167.16607497136307365643.tip-bot2@tip-bot2>
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

Commit-ID:     a512584abd7ab860560ac21e6daac1aaebc1c14f
Gitweb:        https://git.kernel.org/tip/a512584abd7ab860560ac21e6daac1aaebc1c14f
Author:        Masahiro Yamada <yamada.masahiro@socionext.com>
AuthorDate:    Mon, 19 Aug 2019 16:45:34 +09:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 20 Aug 2019 10:35:46 +01:00

irqchip: Add include guard to irq-partition-percpu.h

Add a header include guard just in case.

Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 include/linux/irqchip/irq-partition-percpu.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/linux/irqchip/irq-partition-percpu.h b/include/linux/irqchip/irq-partition-percpu.h
index a783ddb..2f6ae75 100644
--- a/include/linux/irqchip/irq-partition-percpu.h
+++ b/include/linux/irqchip/irq-partition-percpu.h
@@ -4,6 +4,9 @@
  * Author: Marc Zyngier <marc.zyngier@arm.com>
  */
 
+#ifndef __LINUX_IRQCHIP_IRQ_PARTITION_PERCPU_H
+#define __LINUX_IRQCHIP_IRQ_PARTITION_PERCPU_H
+
 #include <linux/fwnode.h>
 #include <linux/cpumask.h>
 #include <linux/irqdomain.h>
@@ -46,3 +49,5 @@ struct irq_domain *partition_get_domain(struct partition_desc *dsc)
 	return NULL;
 }
 #endif
+
+#endif /* __LINUX_IRQCHIP_IRQ_PARTITION_PERCPU_H */
