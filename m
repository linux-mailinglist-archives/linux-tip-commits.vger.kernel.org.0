Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0515E19AA47
	for <lists+linux-tip-commits@lfdr.de>; Wed,  1 Apr 2020 13:09:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732618AbgDALF6 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 1 Apr 2020 07:05:58 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:34827 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732335AbgDALF5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 1 Apr 2020 07:05:57 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jJbBt-000863-Uc; Wed, 01 Apr 2020 13:05:50 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 8AE221C047B;
        Wed,  1 Apr 2020 13:05:49 +0200 (CEST)
Date:   Wed, 01 Apr 2020 11:05:49 -0000
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] Revert "irqchip/xilinx: Do not call irq_set_default_host()"
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <44b64be7-9240-fd52-af90-e0245220f38b@xilinx.com>
References: <44b64be7-9240-fd52-af90-e0245220f38b@xilinx.com>
MIME-Version: 1.0
Message-ID: <158573914921.28353.5903314598281659290.tip-bot2@tip-bot2>
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

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     e02f6c01748df77b3fe202bbf7dde0aae6ecced7
Gitweb:        https://git.kernel.org/tip/e02f6c01748df77b3fe202bbf7dde0aae6ecced7
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 30 Mar 2020 10:41:58 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Wed, 01 Apr 2020 09:10:45 +01:00

Revert "irqchip/xilinx: Do not call irq_set_default_host()"

This reverts commit 9c2d4f525c002591f4e0c14a37663663aaba1656, which
breaks a number of PPC platforms.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/44b64be7-9240-fd52-af90-e0245220f38b@xilinx.com
---
 drivers/irqchip/irq-xilinx-intc.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/irqchip/irq-xilinx-intc.c b/drivers/irqchip/irq-xilinx-intc.c
index 7f811fe..ea74181 100644
--- a/drivers/irqchip/irq-xilinx-intc.c
+++ b/drivers/irqchip/irq-xilinx-intc.c
@@ -250,6 +250,7 @@ static int __init xilinx_intc_of_init(struct device_node *intc,
 		}
 	} else {
 		primary_intc = irqc;
+		irq_set_default_host(primary_intc->root_domain);
 		set_handle_irq(xil_intc_handle_irq);
 	}
 
