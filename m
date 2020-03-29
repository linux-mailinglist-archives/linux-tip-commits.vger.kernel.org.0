Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8D818196FF1
	for <lists+linux-tip-commits@lfdr.de>; Sun, 29 Mar 2020 22:26:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728917AbgC2U0d (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 29 Mar 2020 16:26:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:57054 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728900AbgC2U0c (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 29 Mar 2020 16:26:32 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jIeVp-0001Vs-8e; Sun, 29 Mar 2020 22:26:29 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 70C871C0470;
        Sun, 29 Mar 2020 22:26:23 +0200 (CEST)
Date:   Sun, 29 Mar 2020 20:26:23 -0000
From:   "tip-bot2 for Anson Huang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip: Add COMPILE_TEST support for IMX_INTMUX
Cc:     Anson Huang <Anson.Huang@nxp.com>, Marc Zyngier <maz@kernel.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1583588547-7164-1-git-send-email-Anson.Huang@nxp.com>
References: <1583588547-7164-1-git-send-email-Anson.Huang@nxp.com>
MIME-Version: 1.0
Message-ID: <158551358309.28353.13146480838541421693.tip-bot2@tip-bot2>
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

Commit-ID:     66968d7dfc3f545185236ba7814f3a056f6b5099
Gitweb:        https://git.kernel.org/tip/66968d7dfc3f545185236ba7814f3a056f6b5099
Author:        Anson Huang <Anson.Huang@nxp.com>
AuthorDate:    Sat, 07 Mar 2020 21:42:27 +08:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 08 Mar 2020 14:25:46 

irqchip: Add COMPILE_TEST support for IMX_INTMUX

Add COMPILE_TEST support to IMX_INTMUX driver for better compile
testing coverage.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/1583588547-7164-1-git-send-email-Anson.Huang@nxp.com
---
 drivers/irqchip/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
index 6d39773..24fe087 100644
--- a/drivers/irqchip/Kconfig
+++ b/drivers/irqchip/Kconfig
@@ -458,7 +458,7 @@ config IMX_IRQSTEER
 	  Support for the i.MX IRQSTEER interrupt multiplexer/remapper.
 
 config IMX_INTMUX
-	def_bool y if ARCH_MXC
+	def_bool y if ARCH_MXC || COMPILE_TEST
 	select IRQ_DOMAIN
 	help
 	  Support for the i.MX INTMUX interrupt multiplexer.
