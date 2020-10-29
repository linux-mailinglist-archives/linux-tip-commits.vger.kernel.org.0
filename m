Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 363AE29EB70
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 13:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgJ2MPo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 08:15:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33268 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726385AbgJ2MPn (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 08:15:43 -0400
Date:   Thu, 29 Oct 2020 12:15:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603973741;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=buTEroTZIluAnHXpe/RAXNq+oTJjbNgIEbD18RTjA5U=;
        b=Coly0Kbzpu/7hdsGswLVPOY1Om7XUeAzONzyPlR/kcY2n4tCbu2V7lvbmwa1GDUhtnkcor
        9P7uf059d93k0BIV/vJCSvDLgqrBggJoLmxDv8Lo3K78YxVavMKfm2BrhuHafybciPR5Mc
        dmG/A6UPGj+jWySZzr8FXCKJpckBZKqyAIvnbwsaI0aXxOr5UmrP/4uBW86SaiscB/1Nun
        H7SBnscQ6MK943dxohijRPSDKRn5E+Z3M30m30m7Axy6QVOrGwtYmzhs4mnFE3xuV72310
        SywELgNJ0OZskBG6SJH3b1yZhUHM9Yyz4JysM/rkJUYMwBKxgOUm/oFzgavwUA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603973741;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=buTEroTZIluAnHXpe/RAXNq+oTJjbNgIEbD18RTjA5U=;
        b=v9qQRYjs2FBmCxWhxLY7VeYJ0i37Fub75zPK7f6UhSQv7deke+qVgxhAWEzJVfWXNlFm4K
        UmMabUNzf2sivHDA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] PCI: vmd: Use msi_msg shadow structs
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201024213535.443185-16-dwmw2@infradead.org>
References: <20201024213535.443185-16-dwmw2@infradead.org>
MIME-Version: 1.0
Message-ID: <160397374067.397.404139187177842904.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     e16c8058a10ba8e38d0d1ad0b64e444b245ffdbd
Gitweb:        https://git.kernel.org/tip/e16c8058a10ba8e38d0d1ad0b64e444b245ffdbd
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 24 Oct 2020 22:35:15 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Oct 2020 20:26:26 +01:00

PCI: vmd: Use msi_msg shadow structs

Use the x86 shadow structs in msi_msg instead of the macros.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201024213535.443185-16-dwmw2@infradead.org

---
 drivers/pci/controller/vmd.c |  9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index f375c21..6f87954 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -18,7 +18,6 @@
 #include <asm/irqdomain.h>
 #include <asm/device.h>
 #include <asm/msi.h>
-#include <asm/msidef.h>
 
 #define VMD_CFGBAR	0
 #define VMD_MEMBAR1	2
@@ -131,10 +130,10 @@ static void vmd_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
 	struct vmd_irq_list *irq = vmdirq->irq;
 	struct vmd_dev *vmd = irq_data_get_irq_handler_data(data);
 
-	msg->address_hi = MSI_ADDR_BASE_HI;
-	msg->address_lo = MSI_ADDR_BASE_LO |
-			  MSI_ADDR_DEST_ID(index_from_irqs(vmd, irq));
-	msg->data = 0;
+	memset(msg, 0, sizeof(*msg));
+	msg->address_hi = X86_MSI_BASE_ADDRESS_HIGH;
+	msg->arch_addr_lo.base_address = X86_MSI_BASE_ADDRESS_LOW;
+	msg->arch_addr_lo.destid_0_7 = index_from_irqs(vmd, irq);
 }
 
 /*
