Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FBC12A1FB5
	for <lists+linux-tip-commits@lfdr.de>; Sun,  1 Nov 2020 18:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgKARAN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 1 Nov 2020 12:00:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53826 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgKARAM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 1 Nov 2020 12:00:12 -0500
Date:   Sun, 01 Nov 2020 17:00:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1604250009;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eMqVqtc2C4auwzMu8GaTt+B0rSb97C4C/gdI6Z46Klw=;
        b=xMQeAGEzydEt9enP/Evk6F/hDUj3C4gkgwoNLAwxU9ilta6mZ1x+SN0syeVuUgbi1aHCgz
        hm1HME3rfLdCROxUsZiufrV2eLTYKAU8xzAf6pxah/gF3yQ8RF6hI+rs7pAXxqrLs0uOme
        D00gtTQK3AHTKQEqiJR8MjRZBylP3uqKLR7COytFIsdkCDzCf+AqXbkdExwGq5eCLwI0YH
        D1wsHS234ECA2iPcBpfwIDXRzdrUv7SV8CuoKxMRm1WpS0/5OP13lGTNpvbE1R60rCuv7J
        6NeFF63OLO1qnAIswn51d4HgH2xUsG4zAvpw8B8PJt6Yjer9Mf+LFV93ywWfhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1604250009;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=eMqVqtc2C4auwzMu8GaTt+B0rSb97C4C/gdI6Z46Klw=;
        b=CspyW5yjv3je8vQlirOZSjZ2JtdjITsPlFWxCIzpYv/Xj7RwVmIaNR4VET7iz9uAJneBtz
        oLqWkLdTiSZqNMDg==
From:   "tip-bot2 for Geert Uytterhoeven" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/urgent] irqchip/renesas-intc-irqpin: Merge irlm_bit and needs_irlm
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201028153955.1736767-1-geert+renesas@glider.be>
References: <20201028153955.1736767-1-geert+renesas@glider.be>
MIME-Version: 1.0
Message-ID: <160425000858.397.1155944274384830993.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/urgent branch of tip:

Commit-ID:     b388bdf2bac7aedac9bde5ab63eaf7646f29fc00
Gitweb:        https://git.kernel.org/tip/b388bdf2bac7aedac9bde5ab63eaf7646f29fc00
Author:        Geert Uytterhoeven <geert+renesas@glider.be>
AuthorDate:    Wed, 28 Oct 2020 16:39:55 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Sun, 01 Nov 2020 11:59:22 

irqchip/renesas-intc-irqpin: Merge irlm_bit and needs_irlm

Get rid of the separate flag to indicate if the IRLM bit is present in
the INTC/Interrupt Control Register 0, by considering -1 an invalid
irlm_bit value.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Signed-off-by: Marc Zyngier <maz@kernel.org>
Link: https://lore.kernel.org/r/20201028153955.1736767-1-geert+renesas@glider.be
---
 drivers/irqchip/irq-renesas-intc-irqpin.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/drivers/irqchip/irq-renesas-intc-irqpin.c b/drivers/irqchip/irq-renesas-intc-irqpin.c
index 3819185..cb7f60b 100644
--- a/drivers/irqchip/irq-renesas-intc-irqpin.c
+++ b/drivers/irqchip/irq-renesas-intc-irqpin.c
@@ -71,8 +71,7 @@ struct intc_irqpin_priv {
 };
 
 struct intc_irqpin_config {
-	unsigned int irlm_bit;
-	unsigned needs_irlm:1;
+	int irlm_bit;		/* -1 if non-existent */
 };
 
 static unsigned long intc_irqpin_read32(void __iomem *iomem)
@@ -349,11 +348,10 @@ static const struct irq_domain_ops intc_irqpin_irq_domain_ops = {
 
 static const struct intc_irqpin_config intc_irqpin_irlm_r8a777x = {
 	.irlm_bit = 23, /* ICR0.IRLM0 */
-	.needs_irlm = 1,
 };
 
 static const struct intc_irqpin_config intc_irqpin_rmobile = {
-	.needs_irlm = 0,
+	.irlm_bit = -1,
 };
 
 static const struct of_device_id intc_irqpin_dt_ids[] = {
@@ -470,7 +468,7 @@ static int intc_irqpin_probe(struct platform_device *pdev)
 	}
 
 	/* configure "individual IRQ mode" where needed */
-	if (config && config->needs_irlm) {
+	if (config && config->irlm_bit >= 0) {
 		if (io[INTC_IRQPIN_REG_IRLM])
 			intc_irqpin_read_modify_write(p, INTC_IRQPIN_REG_IRLM,
 						      config->irlm_bit, 1, 1);
