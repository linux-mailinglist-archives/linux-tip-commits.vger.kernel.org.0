Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D202AB6D7
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Sep 2019 13:11:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2392280AbfIFLIY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 6 Sep 2019 07:08:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:47031 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2392266AbfIFLIY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 6 Sep 2019 07:08:24 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i6C6G-00076O-VT; Fri, 06 Sep 2019 13:08:21 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 406481C0E21;
        Fri,  6 Sep 2019 13:08:16 +0200 (CEST)
Date:   Fri, 06 Sep 2019 11:08:16 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic: Skip DT quirks when evaluating IIDR-based quirks
Cc:     Marc Zyngier <maz@kernel.org>, Ingo Molnar <mingo@kernel.org>,
        Borislav Petkov <bp@alien8.de>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <156776809619.24167.5200625514349777851.tip-bot2@tip-bot2>
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

Commit-ID:     25edaed6c7feca8fded25348732c628283304364
Gitweb:        https://git.kernel.org/tip/25edaed6c7feca8fded25348732c628283304364
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Wed, 31 Jul 2019 17:28:49 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Tue, 20 Aug 2019 10:23:35 +01:00

irqchip/gic: Skip DT quirks when evaluating IIDR-based quirks

When evaluating potential quirks matched by reads of the IIDR
register, skip the quirk entries that use a "compatible"
property attached to them, as these are DT based.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-common.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index 14110db..8252000 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -41,6 +41,8 @@ void gic_enable_quirks(u32 iidr, const struct gic_quirk *quirks,
 		void *data)
 {
 	for (; quirks->desc; quirks++) {
+		if (quirks->compatible)
+			continue;
 		if (quirks->iidr != (quirks->mask & iidr))
 			continue;
 		if (quirks->init(data))
