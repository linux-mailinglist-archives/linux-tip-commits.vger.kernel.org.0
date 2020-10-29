Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AACBD29EBA1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 13:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727074AbgJ2MRN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 08:17:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33248 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgJ2MPm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 08:15:42 -0400
Date:   Thu, 29 Oct 2020 12:15:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603973740;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l0qP5vXEd/x+ZH3db7znfgpF1tmFYviY7OGd/4Bl2Tw=;
        b=il8Cn7DavJKi97Zb+OsbefLy0W2nVyy+FyxQYG11gtxvlgn/1IizUWeZ5ccmqgUzaVqvLR
        MVD01y+JtzOmeHWI2NVA4NBMoE350NJ3CbApk7ij605tdWtp2xZN9InrvEyabuJ01MeUmF
        h17ot2OfNzP97ZpPVdZC3JkA/4Sfp3Z7HmV5Q0gsA61pmfafg53+WP/d/fkLJbhAaTWn9G
        tKrZKSVNvscRO8R9O/Jfv4xnAYAXpq6edWkmfNsrPNS7RnUEIUhjspT1OIKLYZHZyDGsN+
        HKRkrVS6o4O+3FD7+WhRDCPs1bOelH15x4QH3nziH6MIHPur0L16VoOeWvVBqw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603973740;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=l0qP5vXEd/x+ZH3db7znfgpF1tmFYviY7OGd/4Bl2Tw=;
        b=FAHjYLh1Ac2ETCvakVojuI/Tcomjs5kSkQYpRLeH/kQk1RD7rzvxL+MpXdtHIJbD9C80zv
        Lpn4YZZIIeDLxbCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/pci/xen: Use msi_msg shadow structs
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201024213535.443185-18-dwmw2@infradead.org>
References: <20201024213535.443185-18-dwmw2@infradead.org>
MIME-Version: 1.0
Message-ID: <160397373934.397.197324234855870461.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     41bb2115beec5e318095a89f5ad4a9c343cb21ad
Gitweb:        https://git.kernel.org/tip/41bb2115beec5e318095a89f5ad4a9c343cb21ad
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 24 Oct 2020 22:35:17 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Oct 2020 20:26:26 +01:00

x86/pci/xen: Use msi_msg shadow structs

Use the msi_msg shadow structs and compose the message with named bitfields
instead of the unreadable macro maze.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201024213535.443185-18-dwmw2@infradead.org

---
 arch/x86/pci/xen.c | 26 +++++++++++---------------
 1 file changed, 11 insertions(+), 15 deletions(-)

diff --git a/arch/x86/pci/xen.c b/arch/x86/pci/xen.c
index c552cd2..3d41a09 100644
--- a/arch/x86/pci/xen.c
+++ b/arch/x86/pci/xen.c
@@ -152,7 +152,6 @@ static int acpi_register_gsi_xen(struct device *dev, u32 gsi,
 
 #if defined(CONFIG_PCI_MSI)
 #include <linux/msi.h>
-#include <asm/msidef.h>
 
 struct xen_pci_frontend_ops *xen_pci_frontend;
 EXPORT_SYMBOL_GPL(xen_pci_frontend);
@@ -210,23 +209,20 @@ free:
 	return ret;
 }
 
-#define XEN_PIRQ_MSI_DATA  (MSI_DATA_TRIGGER_EDGE | \
-		MSI_DATA_LEVEL_ASSERT | (3 << 8) | MSI_DATA_VECTOR(0))
-
 static void xen_msi_compose_msg(struct pci_dev *pdev, unsigned int pirq,
 		struct msi_msg *msg)
 {
-	/* We set vector == 0 to tell the hypervisor we don't care about it,
-	 * but we want a pirq setup instead.
-	 * We use the dest_id field to pass the pirq that we want. */
-	msg->address_hi = MSI_ADDR_BASE_HI | MSI_ADDR_EXT_DEST_ID(pirq);
-	msg->address_lo =
-		MSI_ADDR_BASE_LO |
-		MSI_ADDR_DEST_MODE_PHYSICAL |
-		MSI_ADDR_REDIRECTION_CPU |
-		MSI_ADDR_DEST_ID(pirq);
-
-	msg->data = XEN_PIRQ_MSI_DATA;
+	/*
+	 * We set vector == 0 to tell the hypervisor we don't care about
+	 * it, but we want a pirq setup instead.  We use the dest_id fields
+	 * to pass the pirq that we want.
+	 */
+	memset(msg, 0, sizeof(*msg));
+	msg->address_hi = X86_MSI_BASE_ADDRESS_HIGH;
+	msg->arch_addr_hi.destid_8_31 = pirq >> 8;
+	msg->arch_addr_lo.destid_0_7 = pirq & 0xFF;
+	msg->arch_addr_lo.base_address = X86_MSI_BASE_ADDRESS_LOW;
+	msg->arch_data.delivery_mode = APIC_DELIVERY_MODE_EXTINT;
 }
 
 static int xen_hvm_setup_msi_irqs(struct pci_dev *dev, int nvec, int type)
