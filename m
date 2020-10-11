Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 70F3F28A913
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 20:01:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgJKSBM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 14:01:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39934 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388349AbgJKR5W (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:22 -0400
Date:   Sun, 11 Oct 2020 17:57:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439040;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=YWdvCkXdqtsiodoW0+b/VtLJH3OR31cuDZ1jHDAlwlI=;
        b=XhbWXaZyYWe2WG+ND+/1FQQm7a3ILn401R9zrSgDkGICqL3CN0HTUZiWj5KYqFX1qq0qjP
        +yF2VvaUFcojmYkoKduWKl7vbHXwC8zuYk3IgkAmacE4aLAJCTavuHcwfo7iVoB4QIbfdZ
        2mtlifEOQ4JZye9m31M/FmIejbRHF4mWcYFjgjld/vunlHQNA/71ll2AMxvnIBrrAdIPH3
        DdBoZCqKT5ZR9DREaFUgf4MZcxmWNiEUcwx/e3xsWGJOafFf0aYD9gFNENNOSMHavOrj7O
        aPos+l1kBBHyvSFW0hI0VwudoxlIfkge+mPf4YlT6TlU08qtfPn+cOB1iv4qfw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439040;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=YWdvCkXdqtsiodoW0+b/VtLJH3OR31cuDZ1jHDAlwlI=;
        b=/+e0F4ycfp2eHm39hAvjzfbRkycigeN3s2+bY4zhrkRvFxMDNOQHxkO6QqOH9cGd5upO0B
        CAZMVLUwYlYe4UCw==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] gpio: tegra186: Allow optional irq parent callbacks
Cc:     Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160243904016.7002.1897000355914151479.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     986ec63d4482292570b579ac98b151acf8bdd1de
Gitweb:        https://git.kernel.org/tip/986ec63d4482292570b579ac98b151acf8bdd1de
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Mon, 05 Oct 2020 10:27:27 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sat, 10 Oct 2020 12:12:10 +01:00

gpio: tegra186: Allow optional irq parent callbacks

Make the tegra186 GPIO driver resistent to variable depth
interrupt hierarchy, which we are about to introduce.

No functionnal change yet.

Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/gpio/gpio-tegra186.c | 15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/gpio/gpio-tegra186.c b/drivers/gpio/gpio-tegra186.c
index 178e912..9500074 100644
--- a/drivers/gpio/gpio-tegra186.c
+++ b/drivers/gpio/gpio-tegra186.c
@@ -430,7 +430,18 @@ static int tegra186_irq_set_type(struct irq_data *data, unsigned int type)
 	else
 		irq_set_handler_locked(data, handle_edge_irq);
 
-	return irq_chip_set_type_parent(data, type);
+	if (data->parent_data)
+		return irq_chip_set_type_parent(data, type);
+
+	return 0;
+}
+
+static int tegra186_irq_set_wake(struct irq_data *data, unsigned int on)
+{
+	if (data->parent_data)
+		return irq_chip_set_wake_parent(data, on);
+
+	return 0;
 }
 
 static void tegra186_gpio_irq(struct irq_desc *desc)
@@ -678,7 +689,7 @@ static int tegra186_gpio_probe(struct platform_device *pdev)
 	gpio->intc.irq_mask = tegra186_irq_mask;
 	gpio->intc.irq_unmask = tegra186_irq_unmask;
 	gpio->intc.irq_set_type = tegra186_irq_set_type;
-	gpio->intc.irq_set_wake = irq_chip_set_wake_parent;
+	gpio->intc.irq_set_wake = tegra186_irq_set_wake;
 
 	irq = &gpio->gpio.irq;
 	irq->chip = &gpio->intc;
