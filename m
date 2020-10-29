Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19AF229EB99
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 13:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726960AbgJ2MQv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 08:16:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33306 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726411AbgJ2MPp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 08:15:45 -0400
Date:   Thu, 29 Oct 2020 12:15:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603973742;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6RCBehm7zkq7gJxGCHZr23h0m55YTmACO25G3+RpmSA=;
        b=3BNgC+yEFn8BXUadV6o/lufSSLCkFSJU+oV10F1Kw7+QoQswcDn312RsDWmutahUK9Ezu9
        GsO/sIuXC/WtzNREutuLIkp3KuFNOUddlmuOUacT/OgvTajh3pfn3wjhK1oLyg20ex+ApX
        OFtpi1wVD6ZRNm6dOUbrSVuDE56IOV/tbV2IkKqDtbt4naMZrV5jcxMfD76JIVxZzb+4qG
        AqkzwtYzpdppeO0ecDKNLiM/L7n/0sR2iauNFwkbVMbhJ9yMt6/D3o3xSxKx4/3AdrKn8D
        71Do3QBBv14ISRYNa89v8n9FVy/yDN95miJymdFKwG6mNrD2J4dB0ll7TMHEmg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603973742;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6RCBehm7zkq7gJxGCHZr23h0m55YTmACO25G3+RpmSA=;
        b=plV4JflAEneDdzw3kwtd4ACQS5eANP3uQvMy8m9r4mJsH8enFo4IzQn5XGepPGQRYW8LAe
        ucSBF2Ji4nAlZwCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] iommu/intel: Use msi_msg shadow structs
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201024213535.443185-14-dwmw2@infradead.org>
References: <20201024213535.443185-14-dwmw2@infradead.org>
MIME-Version: 1.0
Message-ID: <160397374201.397.2267143454147222965.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     5c0d0e2cc6e0e7a96c25351fd67c775e7b1f11f0
Gitweb:        https://git.kernel.org/tip/5c0d0e2cc6e0e7a96c25351fd67c775e7b1f11f0
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 24 Oct 2020 22:35:13 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Oct 2020 20:26:25 +01:00

iommu/intel: Use msi_msg shadow structs

Use the bitfields in the x86 shadow struct to compose the MSI message.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201024213535.443185-14-dwmw2@infradead.org

---
 drivers/iommu/intel/irq_remapping.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 5628d43..30269b7 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -20,7 +20,6 @@
 #include <asm/cpu.h>
 #include <asm/irq_remapping.h>
 #include <asm/pci-direct.h>
-#include <asm/msidef.h>
 
 #include "../irq_remapping.h"
 
@@ -1260,6 +1259,21 @@ static struct irq_chip intel_ir_chip = {
 	.irq_set_vcpu_affinity	= intel_ir_set_vcpu_affinity,
 };
 
+static void fill_msi_msg(struct msi_msg *msg, u32 index, u32 subhandle)
+{
+	memset(msg, 0, sizeof(*msg));
+
+	msg->arch_addr_lo.dmar_base_address = X86_MSI_BASE_ADDRESS_LOW;
+	msg->arch_addr_lo.dmar_subhandle_valid = true;
+	msg->arch_addr_lo.dmar_format = true;
+	msg->arch_addr_lo.dmar_index_0_14 = index & 0x7FFF;
+	msg->arch_addr_lo.dmar_index_15 = !!(index & 0x8000);
+
+	msg->address_hi = X86_MSI_BASE_ADDRESS_HIGH;
+
+	msg->arch_data.dmar_subhandle = subhandle;
+}
+
 static void intel_irq_remapping_prepare_irte(struct intel_ir_data *data,
 					     struct irq_cfg *irq_cfg,
 					     struct irq_alloc_info *info,
@@ -1267,7 +1281,6 @@ static void intel_irq_remapping_prepare_irte(struct intel_ir_data *data,
 {
 	struct IR_IO_APIC_route_entry *entry;
 	struct irte *irte = &data->irte_entry;
-	struct msi_msg *msg = &data->msi_entry;
 
 	prepare_irte(irte, irq_cfg->vector, irq_cfg->dest_apicid);
 	switch (info->type) {
@@ -1308,12 +1321,7 @@ static void intel_irq_remapping_prepare_irte(struct intel_ir_data *data,
 		else
 			set_msi_sid(irte, msi_desc_to_pci_dev(info->desc));
 
-		msg->address_hi = MSI_ADDR_BASE_HI;
-		msg->data = sub_handle;
-		msg->address_lo = MSI_ADDR_BASE_LO | MSI_ADDR_IR_EXT_INT |
-				  MSI_ADDR_IR_SHV |
-				  MSI_ADDR_IR_INDEX1(index) |
-				  MSI_ADDR_IR_INDEX2(index);
+		fill_msi_msg(&data->msi_entry, index, sub_handle);
 		break;
 
 	default:
