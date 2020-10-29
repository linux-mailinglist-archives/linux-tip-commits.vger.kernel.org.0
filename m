Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4B1629EB9F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 13:19:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726458AbgJ2MRE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 08:17:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726440AbgJ2MPo (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 08:15:44 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4B5EC0613CF;
        Thu, 29 Oct 2020 05:15:43 -0700 (PDT)
Date:   Thu, 29 Oct 2020 12:15:41 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603973742;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ETPt677tqpuB2jsoY8tshjq7MhxR5jlrS4YiWe0AUg8=;
        b=unt1MenmKSp9MOyJIwN8nAXE6aRYtMqiKbvKXjKmHBOShznpU2g6edO38vm3IQgKODNgI5
        P5Rr+/x5TvMVRW7IyDI/tegZTCCJiGQ5N9ndMmSmCLrKVslsnFSS50RqcSgm7QbBQiUPRY
        /xI2krp3nGWKrPUeUCvm0QNdbPeKswgsY1rrHVPRmtSZ+3F+wHTeCecTtXR0ZL0u0ZPczr
        J70/437+iiK3/JLQXiU14JlkqrCuqQRIL+4JNTaUlCqtWPku7f6oH9tuoYYSp6s0kuKNkV
        N5zHM3xrCFseB+bIuyDJysmRA3HGOTnCkfVfcADAG8yX8Kado3+qp5p4mOk5+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603973742;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ETPt677tqpuB2jsoY8tshjq7MhxR5jlrS4YiWe0AUg8=;
        b=j5Hfj+VxqT/zHnPB1tENXOV2y9xlGUCNcwSBlmz/OQe3/uinAtcHBI3D1N4u3WJJhwOVBw
        xeirLRFbqQKdGSBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] iommu/amd: Use msi_msg shadow structs
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201024213535.443185-15-dwmw2@infradead.org>
References: <20201024213535.443185-15-dwmw2@infradead.org>
MIME-Version: 1.0
Message-ID: <160397374141.397.16321232135241581868.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     b5c3786ee3704bd8cd5b29ae168526f2b1af4557
Gitweb:        https://git.kernel.org/tip/b5c3786ee3704bd8cd5b29ae168526f2b1af4557
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 24 Oct 2020 22:35:14 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Oct 2020 20:26:26 +01:00

iommu/amd: Use msi_msg shadow structs

Get rid of the macro mess and use the shadow structs for the x86 specific
MSI message format. Convert the intcapxt setup to use named bitfields as
well while touching it anyway.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201024213535.443185-15-dwmw2@infradead.org

---
 drivers/iommu/amd/init.c  | 46 +++++++++++++++++++++-----------------
 drivers/iommu/amd/iommu.c | 14 +++++++-----
 2 files changed, 35 insertions(+), 25 deletions(-)

diff --git a/drivers/iommu/amd/init.c b/drivers/iommu/amd/init.c
index 82e4af8..263670d 100644
--- a/drivers/iommu/amd/init.c
+++ b/drivers/iommu/amd/init.c
@@ -23,7 +23,6 @@
 #include <asm/pci-direct.h>
 #include <asm/iommu.h>
 #include <asm/apic.h>
-#include <asm/msidef.h>
 #include <asm/gart.h>
 #include <asm/x86_init.h>
 #include <asm/iommu_table.h>
@@ -1966,10 +1965,16 @@ static int iommu_setup_msi(struct amd_iommu *iommu)
 	return 0;
 }
 
-#define XT_INT_DEST_MODE(x)	(((x) & 0x1ULL) << 2)
-#define XT_INT_DEST_LO(x)	(((x) & 0xFFFFFFULL) << 8)
-#define XT_INT_VEC(x)		(((x) & 0xFFULL) << 32)
-#define XT_INT_DEST_HI(x)	((((x) >> 24) & 0xFFULL) << 56)
+union intcapxt {
+	u64	capxt;
+	u64	reserved_0		:  2,
+		dest_mode_logical	:  1,
+		reserved_1		:  5,
+		destid_0_23		: 24,
+		vector			:  8,
+		reserved_2		: 16,
+		destid_24_31		:  8;
+} __attribute__ ((packed));
 
 /*
  * Setup the IntCapXT registers with interrupt routing information
@@ -1978,28 +1983,29 @@ static int iommu_setup_msi(struct amd_iommu *iommu)
  */
 static void iommu_update_intcapxt(struct amd_iommu *iommu)
 {
-	u64 val;
-	u32 addr_lo = readl(iommu->mmio_base + MMIO_MSI_ADDR_LO_OFFSET);
-	u32 addr_hi = readl(iommu->mmio_base + MMIO_MSI_ADDR_HI_OFFSET);
-	u32 data    = readl(iommu->mmio_base + MMIO_MSI_DATA_OFFSET);
-	bool dm     = (addr_lo >> MSI_ADDR_DEST_MODE_SHIFT) & 0x1;
-	u32 dest    = ((addr_lo >> MSI_ADDR_DEST_ID_SHIFT) & 0xFF);
+	struct msi_msg msg;
+	union intcapxt xt;
+	u32 destid;
 
-	if (x2apic_enabled())
-		dest |= MSI_ADDR_EXT_DEST_ID(addr_hi);
+	msg.address_lo = readl(iommu->mmio_base + MMIO_MSI_ADDR_LO_OFFSET);
+	msg.address_hi = readl(iommu->mmio_base + MMIO_MSI_ADDR_HI_OFFSET);
+	msg.data = readl(iommu->mmio_base + MMIO_MSI_DATA_OFFSET);
 
-	val = XT_INT_VEC(data & 0xFF) |
-	      XT_INT_DEST_MODE(dm) |
-	      XT_INT_DEST_LO(dest) |
-	      XT_INT_DEST_HI(dest);
+	destid = x86_msi_msg_get_destid(&msg, x2apic_enabled());
+
+	xt.capxt = 0ULL;
+	xt.dest_mode_logical = msg.arch_data.dest_mode_logical;
+	xt.vector = msg.arch_data.vector;
+	xt.destid_0_23 = destid & GENMASK(23, 0);
+	xt.destid_24_31 = destid >> 24;
 
 	/**
 	 * Current IOMMU implemtation uses the same IRQ for all
 	 * 3 IOMMU interrupts.
 	 */
-	writeq(val, iommu->mmio_base + MMIO_INTCAPXT_EVT_OFFSET);
-	writeq(val, iommu->mmio_base + MMIO_INTCAPXT_PPR_OFFSET);
-	writeq(val, iommu->mmio_base + MMIO_INTCAPXT_GALOG_OFFSET);
+	writeq(xt.capxt, iommu->mmio_base + MMIO_INTCAPXT_EVT_OFFSET);
+	writeq(xt.capxt, iommu->mmio_base + MMIO_INTCAPXT_PPR_OFFSET);
+	writeq(xt.capxt, iommu->mmio_base + MMIO_INTCAPXT_GALOG_OFFSET);
 }
 
 static void _irq_notifier_notify(struct irq_affinity_notify *notify,
diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index d7f0c89..473de09 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -35,7 +35,6 @@
 #include <asm/io_apic.h>
 #include <asm/apic.h>
 #include <asm/hw_irq.h>
-#include <asm/msidef.h>
 #include <asm/proto.h>
 #include <asm/iommu.h>
 #include <asm/gart.h>
@@ -3656,13 +3655,20 @@ struct irq_remap_ops amd_iommu_irq_ops = {
 	.get_irq_domain		= get_irq_domain,
 };
 
+static void fill_msi_msg(struct msi_msg *msg, u32 index)
+{
+	msg->data = index;
+	msg->address_lo = 0;
+	msg->arch_addr_lo.base_address = X86_MSI_BASE_ADDRESS_LOW;
+	msg->address_hi = X86_MSI_BASE_ADDRESS_HIGH;
+}
+
 static void irq_remapping_prepare_irte(struct amd_ir_data *data,
 				       struct irq_cfg *irq_cfg,
 				       struct irq_alloc_info *info,
 				       int devid, int index, int sub_handle)
 {
 	struct irq_2_irte *irte_info = &data->irq_2_irte;
-	struct msi_msg *msg = &data->msi_entry;
 	struct IO_APIC_route_entry *entry;
 	struct amd_iommu *iommu = amd_iommu_rlookup_table[devid];
 
@@ -3693,9 +3699,7 @@ static void irq_remapping_prepare_irte(struct amd_ir_data *data,
 	case X86_IRQ_ALLOC_TYPE_HPET:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSI:
 	case X86_IRQ_ALLOC_TYPE_PCI_MSIX:
-		msg->address_hi = MSI_ADDR_BASE_HI;
-		msg->address_lo = MSI_ADDR_BASE_LO;
-		msg->data = irte_info->index;
+		fill_msi_msg(&data->msi_entry, irte_info->index);
 		break;
 
 	default:
