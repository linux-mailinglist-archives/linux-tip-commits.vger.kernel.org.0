Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94DB228A8B2
	for <lists+linux-tip-commits@lfdr.de>; Sun, 11 Oct 2020 19:58:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388542AbgJKR5x (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 11 Oct 2020 13:57:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388462AbgJKR5k (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 11 Oct 2020 13:57:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89928C0613D8;
        Sun, 11 Oct 2020 10:57:36 -0700 (PDT)
Date:   Sun, 11 Oct 2020 17:57:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602439055;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=CqpE+kZG0UIp8vRlUWPb8kKfE+nwr2m3PCM5FLvI/Rk=;
        b=UpQxCXNFYMf0BWdix06xZVPb6bT5aAK2DwHxMljCrq0IiyWr6EyEKutvQQ1QrR7eVpYRj8
        kEYN9jiNqR54LfNhYJjEDpNdNfx3i+nY/MG/S/n2V10eveQMhUDU2sSsZCO2eKk8IWrxqg
        lzuouGZmkHpYyYi0xZqXQa0w21G9T0OD6dEaD5TPeGrOKKaG97zie2RCcgIP9OQw5XKgdD
        o2LJpZC5i0dLtMPp0nhT6FfEitD+JInd+5Tt1BLQZeoetkoqw+GbiORKpsp5fSmrViCVhT
        Ww+7zE3pbnLBnSvIZOsGAODC3KnHuN20SPdo5vY07MXm3Crjg7YjmmNap1WAAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602439055;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=CqpE+kZG0UIp8vRlUWPb8kKfE+nwr2m3PCM5FLvI/Rk=;
        b=90OmfUNGtLYNMdwHHVNItZPcHTaaQmWyMd4p4OQiTWnYTg8OuAsVd9P/jITv+b04jnYOUL
        xYI0qG5mi8XxnZBQ==
From:   "tip-bot2 for Marc Zyngier" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] irqchip/gic-common: Don't enable SGIs by default
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Marc Zyngier <maz@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160243905427.7002.7612632697947501019.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     3567c6ca47546106d36d995790e4eb80e3f14632
Gitweb:        https://git.kernel.org/tip/3567c6ca47546106d36d995790e4eb80e3f14632
Author:        Marc Zyngier <maz@kernel.org>
AuthorDate:    Tue, 19 May 2020 09:42:46 +01:00
Committer:     Marc Zyngier <maz@kernel.org>
CommitterDate: Thu, 17 Sep 2020 16:37:27 +01:00

irqchip/gic-common: Don't enable SGIs by default

The architecture code now enables the IPIs as required, so no
need to enable SGIs by default in the GIC code.

Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Marc Zyngier <maz@kernel.org>
---
 drivers/irqchip/irq-gic-common.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/irqchip/irq-gic-common.c b/drivers/irqchip/irq-gic-common.c
index 8252000..f47b41d 100644
--- a/drivers/irqchip/irq-gic-common.c
+++ b/drivers/irqchip/irq-gic-common.c
@@ -152,9 +152,6 @@ void gic_cpu_config(void __iomem *base, int nr, void (*sync_access)(void))
 		writel_relaxed(GICD_INT_DEF_PRI_X4,
 					base + GIC_DIST_PRI + i * 4 / 4);
 
-	/* Ensure all SGI interrupts are now enabled */
-	writel_relaxed(GICD_INT_EN_SET_SGI, base + GIC_DIST_ENABLE_SET);
-
 	if (sync_access)
 		sync_access();
 }
