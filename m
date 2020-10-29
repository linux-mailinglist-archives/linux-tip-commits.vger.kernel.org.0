Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2DE929EB71
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 13:16:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726495AbgJ2MPr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 08:15:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33248 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726438AbgJ2MPp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 08:15:45 -0400
Date:   Thu, 29 Oct 2020 12:15:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603973743;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1powjNUa0N7MHN2bMwFP9VGhprS2EJr+KEzoS2oWZjw=;
        b=tnogGTQf2GcfWS6TxqUBKiXUn0TvTbLmPIwoTV8K/fUyh65T0xlKF3rXDnoWXR60fBc344
        vldOlfFDb06K+JKLwQLhUGgJdsqG5Xr3eFLnVoK9QzrTy4X/KjYVWfrJMvitjHSP19pnG2
        ym5LsP2gI6x1P38oDlQpNOt59Sgo/6FqcPLVQ7fFfXfjUe6UGcldaY2JBWGnb+2/csgfJE
        Qj4difEdNA+uymE8wSi044rEy92v0d602tGRrMpjk/By87b76OmxTwlu1KlKMg8LmUS3px
        rjQoou+8rs+aTdsCqB+MQAklEM0Dawqt3HP8jxwhLymM3HorNJuJooLTp3Yy8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603973743;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1powjNUa0N7MHN2bMwFP9VGhprS2EJr+KEzoS2oWZjw=;
        b=e5izVtsohgjOohOhl71b71nCPbtVbESanZcBsWXyW3hZTlPGKXBeO+bstVARV3lkiUe8vm
        FnwTMw+pSi/gFyCA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/msi: Provide msi message shadow structs
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201024213535.443185-13-dwmw2@infradead.org>
References: <20201024213535.443185-13-dwmw2@infradead.org>
MIME-Version: 1.0
Message-ID: <160397374261.397.11596890759912493122.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     6285aa507366729c618d5295fb540b24a956088a
Gitweb:        https://git.kernel.org/tip/6285aa507366729c618d5295fb540b24a956088a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 24 Oct 2020 22:35:12 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Oct 2020 20:26:25 +01:00

x86/msi: Provide msi message shadow structs

Create shadow structs with named bitfields for msi_msg data, address_lo and
address_hi and use them in the MSI message composer.

Provide a function to retrieve the destination ID. This could be inline,
but that'd create a circular header dependency.

[dwmw2: fix bitfields not all to be a union]

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201024213535.443185-13-dwmw2@infradead.org

---
 arch/x86/include/asm/msi.h  | 49 ++++++++++++++++++++++++++++++++++++-
 arch/x86/kernel/apic/apic.c | 35 ++++++++++++++------------
 2 files changed, 68 insertions(+), 16 deletions(-)

diff --git a/arch/x86/include/asm/msi.h b/arch/x86/include/asm/msi.h
index cd30013..322fd90 100644
--- a/arch/x86/include/asm/msi.h
+++ b/arch/x86/include/asm/msi.h
@@ -9,4 +9,53 @@ typedef struct irq_alloc_info msi_alloc_info_t;
 int pci_msi_prepare(struct irq_domain *domain, struct device *dev, int nvec,
 		    msi_alloc_info_t *arg);
 
+/* Structs and defines for the X86 specific MSI message format */
+
+typedef struct x86_msi_data {
+	u32	vector			:  8,
+		delivery_mode		:  3,
+		dest_mode_logical	:  1,
+		reserved		:  2,
+		active_low		:  1,
+		is_level		:  1;
+
+	u32	dmar_subhandle;
+} __attribute__ ((packed)) arch_msi_msg_data_t;
+#define arch_msi_msg_data	x86_msi_data
+
+typedef struct x86_msi_addr_lo {
+	union {
+		struct {
+			u32	reserved_0		:  2,
+				dest_mode_logical	:  1,
+				redirect_hint		:  1,
+				reserved_1		:  8,
+				destid_0_7		:  8,
+				base_address		: 12;
+		};
+		struct {
+			u32	dmar_reserved_0		:  2,
+				dmar_index_15		:  1,
+				dmar_subhandle_valid	:  1,
+				dmar_format		:  1,
+				dmar_index_0_14		: 15,
+				dmar_base_address	: 12;
+		};
+	};
+} __attribute__ ((packed)) arch_msi_msg_addr_lo_t;
+#define arch_msi_msg_addr_lo	x86_msi_addr_lo
+
+#define X86_MSI_BASE_ADDRESS_LOW	(0xfee00000 >> 20)
+
+typedef struct x86_msi_addr_hi {
+	u32	reserved		:  8,
+		destid_8_31		: 24;
+} __attribute__ ((packed)) arch_msi_msg_addr_hi_t;
+#define arch_msi_msg_addr_hi	x86_msi_addr_hi
+
+#define X86_MSI_BASE_ADDRESS_HIGH	(0)
+
+struct msi_msg;
+u32 x86_msi_msg_get_destid(struct msi_msg *msg, bool extid);
+
 #endif /* _ASM_X86_MSI_H */
diff --git a/arch/x86/kernel/apic/apic.c b/arch/x86/kernel/apic/apic.c
index 4c15bf2..f7196ee 100644
--- a/arch/x86/kernel/apic/apic.c
+++ b/arch/x86/kernel/apic/apic.c
@@ -50,7 +50,6 @@
 #include <asm/io_apic.h>
 #include <asm/desc.h>
 #include <asm/hpet.h>
-#include <asm/msidef.h>
 #include <asm/mtrr.h>
 #include <asm/time.h>
 #include <asm/smp.h>
@@ -2484,22 +2483,16 @@ int hard_smp_processor_id(void)
 void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg,
 			   bool dmar)
 {
-	msg->address_hi = MSI_ADDR_BASE_HI;
+	memset(msg, 0, sizeof(*msg));
 
-	msg->address_lo =
-		MSI_ADDR_BASE_LO |
-		(apic->dest_mode_logical ?
-			MSI_ADDR_DEST_MODE_LOGICAL :
-			MSI_ADDR_DEST_MODE_PHYSICAL) |
-		MSI_ADDR_REDIRECTION_CPU |
-		MSI_ADDR_DEST_ID(cfg->dest_apicid);
+	msg->arch_addr_lo.base_address = X86_MSI_BASE_ADDRESS_LOW;
+	msg->arch_addr_lo.dest_mode_logical = apic->dest_mode_logical;
+	msg->arch_addr_lo.destid_0_7 = cfg->dest_apicid & 0xFF;
 
-	msg->data =
-		MSI_DATA_TRIGGER_EDGE |
-		MSI_DATA_LEVEL_ASSERT |
-		MSI_DATA_DELIVERY_FIXED |
-		MSI_DATA_VECTOR(cfg->vector);
+	msg->arch_data.delivery_mode = APIC_DELIVERY_MODE_FIXED;
+	msg->arch_data.vector = cfg->vector;
 
+	msg->address_hi = X86_MSI_BASE_ADDRESS_HIGH;
 	/*
 	 * Only the IOMMU itself can use the trick of putting destination
 	 * APIC ID into the high bits of the address. Anything else would
@@ -2507,11 +2500,21 @@ void __irq_msi_compose_msg(struct irq_cfg *cfg, struct msi_msg *msg,
 	 * address higher APIC IDs.
 	 */
 	if (dmar)
-		msg->address_hi |= MSI_ADDR_EXT_DEST_ID(cfg->dest_apicid);
+		msg->arch_addr_hi.destid_8_31 = cfg->dest_apicid >> 8;
 	else
-		WARN_ON_ONCE(MSI_ADDR_EXT_DEST_ID(cfg->dest_apicid));
+		WARN_ON_ONCE(cfg->dest_apicid > 0xFF);
 }
 
+u32 x86_msi_msg_get_destid(struct msi_msg *msg, bool extid)
+{
+	u32 dest = msg->arch_addr_lo.destid_0_7;
+
+	if (extid)
+		dest |= msg->arch_addr_hi.destid_8_31 << 8;
+	return dest;
+}
+EXPORT_SYMBOL_GPL(x86_msi_msg_get_destid);
+
 /*
  * Override the generic EOI implementation with an optimized version.
  * Only called during early boot when only one CPU is active and with
