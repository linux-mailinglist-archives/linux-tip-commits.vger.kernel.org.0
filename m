Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4E2A29EB89
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 13:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgJ2MQj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 08:16:39 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33326 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgJ2MPs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 08:15:48 -0400
Date:   Thu, 29 Oct 2020 12:15:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603973745;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qk1jMA+1fAP/fopY/57ylRESDGSBxF/BaGfPhlRuM/Y=;
        b=J5DNTo1+kHxaFGOBIfWNVKLW7fHQ8qhHzJxJZQa4POUMrY0i6usfxnCw6yzHv9P50jdPz6
        iF0GLOPmusNPUKkjx3RqfkgmEChyuD3AWousldIZAGCK0Or6G1BgLgWJfTOhln3drZMnxU
        tq4wHPza7BHdKb44iFG6gjiS+ckAThxHUMJaBgTefNjxi2EqLroyvRKlApVJFB+i9zf8f+
        y9E6xAuisFJOkO5PYnDalX8ahJPUeugsKSqyRmqO9bo7Q1xe/zFVhwT/xWOYpVb12MHZSl
        JoborSLzpydsfBEHlbcUd4ESL7QozqmBWhn/FmeN9hMzs+yHREAtGew9Y0HI1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603973745;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qk1jMA+1fAP/fopY/57ylRESDGSBxF/BaGfPhlRuM/Y=;
        b=7FgkQsRoPngjdz/k4dbOVJFhcExxf/m7wmxKpIUJx8Xenp0CdzLwjUElN1YRSTOMwuAmwx
        RVdNbyZBMjM95FAw==
From:   "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/apic: Always provide irq_compose_msi_msg() method
 for vector domain
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201024213535.443185-10-dwmw2@infradead.org>
References: <20201024213535.443185-10-dwmw2@infradead.org>
MIME-Version: 1.0
Message-ID: <160397374456.397.9490642570838940442.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     f598181acfb36f67e1de138cbe80a7db497f7d8c
Gitweb:        https://git.kernel.org/tip/f598181acfb36f67e1de138cbe80a7db497f7d8c
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Sat, 24 Oct 2020 22:35:09 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Oct 2020 20:26:25 +01:00

x86/apic: Always provide irq_compose_msi_msg() method for vector domain

This shouldn't be dependent on PCI_MSI. HPET and I/O-APIC can deliver
interrupts through MSI without having any PCI in the system at all.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201024213535.443185-10-dwmw2@infradead.org

---
 arch/x86/include/asm/apic.h   |  8 ++-----
 arch/x86/kernel/apic/apic.c   | 32 +++++++++++++++++++++++++++++-
 arch/x86/kernel/apic/msi.c    | 37 +----------------------------------
 arch/x86/kernel/apic/vector.c |  6 ++++++-
 4 files changed, 41 insertions(+), 42 deletions(-)

diff --git a/arch/x86/include/asm/apic.h b/arch/x86/include/asm/apic.h
index c1f64c6..34cb3c1 100644
--- a/arch/x86/include/asm/apic.h
+++ b/arch/x86/include/asm/apic.h
@@ -520,12 +520,10 @@ static inline void apic_smt_update(void) { }
 #endif
 
 struct msi_msg;
+struct irq_cfg;
 
-#ifdef CONFIG_PCI_MSI
-void x86_vector_msi_compose_msg(struct irq_data *data, struct msi_msg *msg);
-#else
-# define x86_vector_msi_compose_msg NULL
-#endif
+extern void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg,
+				  bool dmar);
 
 extern void ioapic_zap_locks(void);
 
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 54f0435..4c15bf2 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -50,6 +50,7 @@
 #include <asm/io_apic.h>
 #include <asm/desc.h>
 #include <asm/hpet.h>
+#include <asm/msidef.h>
 #include <asm/mtrr.h>
 #include <asm/time.h>
 #include <asm/smp.h>
@@ -2480,6 +2481,37 @@ int hard_smp_processor_id(void)
 	return read_apic_id();
 }
 
+void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg,
+			   bool dmar)
+{
+	msg->address_hi = MSI_ADDR_BASE_HI;
+
+	msg->address_lo =
+		MSI_ADDR_BASE_LO |
+		(apic->dest_mode_logical ?
+			MSI_ADDR_DEST_MODE_LOGICAL :
+			MSI_ADDR_DEST_MODE_PHYSICAL) |
+		MSI_ADDR_REDIRECTION_CPU |
+		MSI_ADDR_DEST_ID(cfg->dest_apicid);
+
+	msg->data =
+		MSI_DATA_TRIGGER_EDGE |
+		MSI_DATA_LEVEL_ASSERT |
+		MSI_DATA_DELIVERY_FIXED |
+		MSI_DATA_VECTOR(cfg->vector);
+
+	/*
+	 * Only the IOMMU itself can use the trick of putting destination
+	 * APIC ID into the high bits of the address. Anything else would
+	 * just be writing to memory if it tried that, and needs IR to
+	 * address higher APIC IDs.
+	 */
+	if (dmar)
+		msg->address_hi |= MSI_ADDR_EXT_DEST_ID(cfg->dest_apicid);
+	else
+		WARN_ON_ONCE(MSI_ADDR_EXT_DEST_ID(cfg->dest_apicid));
+}
+
 /*
  * Override the generic EOI implementation with an optimized version.
  * Only called during early boot when only one CPU is active and with
diff --git a/arch/x86/kernel/apic/msi.c b/arch/x86/kernel/apic/msi.c
index 46ffd41..4eda617 100644
--- a/arch/x86/kernel/apic/msi.c
+++ b/arch/x86/kernel/apic/msi.c
@@ -15,7 +15,6 @@
 #include <linux/hpet.h>
 #include <linux/msi.h>
 #include <asm/irqdomain.h>
-#include <asm/msidef.h>
 #include <asm/hpet.h>
 #include <asm/hw_irq.h>
 #include <asm/apic.h>
@@ -23,42 +22,6 @@
 
 struct irq_domain *x86_pci_msi_default_domain __ro_after_init;
 
-static void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg,
-				  bool dmar)
-{
-	msg->address_hi = MSI_ADDR_BASE_HI;
-
-	msg->address_lo =
-		MSI_ADDR_BASE_LO |
-		(apic->dest_mode_logical ?
-			MSI_ADDR_DEST_MODE_LOGICAL :
-			MSI_ADDR_DEST_MODE_PHYSICAL) |
-		MSI_ADDR_REDIRECTION_CPU |
-		MSI_ADDR_DEST_ID(cfg->dest_apicid);
-
-	msg->data =
-		MSI_DATA_TRIGGER_EDGE |
-		MSI_DATA_LEVEL_ASSERT |
-		MSI_DATA_DELIVERY_FIXED |
-		MSI_DATA_VECTOR(cfg->vector);
-
-	/*
-	 * Only the IOMMU itself can use the trick of putting destination
-	 * APIC ID into the high bits of the address. Anything else would
-	 * just be writing to memory if it tried that, and needs IR to
-	 * address higher APIC IDs.
-	 */
-	if (dmar)
-		msg->address_hi |= MSI_ADDR_EXT_DEST_ID(cfg->dest_apicid);
-	else
-		WARN_ON_ONCE(MSI_ADDR_EXT_DEST_ID(cfg->dest_apicid));
-}
-
-void x86_vector_msi_compose_msg(struct irq_data *data, struct msi_msg *msg)
-{
-	__irq_msi_compose_msg(irqd_cfg(data), msg, false);
-}
-
 static void irq_msi_update_msg(struct irq_data *irqd, struct irq_cfg *cfg)
 {
 	struct msi_msg msg[2] = { [1] = { }, };
diff --git a/arch/x86/kernel/apic/vector.c b/arch/x86/kernel/apic/vector.c
index 1eac536..bb2e2a2 100644
--- a/arch/x86/kernel/apic/vector.c
+++ b/arch/x86/kernel/apic/vector.c
@@ -818,6 +818,12 @@ void apic_ack_edge(struct irq_data *irqd)
 	apic_ack_irq(irqd);
 }
 
+static void x86_vector_msi_compose_msg(struct irq_data *data,
+				       struct msi_msg *msg)
+{
+       __irq_msi_compose_msg(irqd_cfg(data), msg, false);
+}
+
 static struct irq_chip lapic_controller = {
 	.name			= "APIC",
 	.irq_ack		= apic_ack_edge,
