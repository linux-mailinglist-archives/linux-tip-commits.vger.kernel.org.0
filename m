Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E170A29EB92
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 13:19:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726107AbgJ2MPh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 08:15:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725876AbgJ2MPf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 08:15:35 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83461C0613CF;
        Thu, 29 Oct 2020 05:15:35 -0700 (PDT)
Date:   Thu, 29 Oct 2020 12:15:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603973732;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WZB+QTTPa98d7LFErl+2oiOVAAulytaZ5uvw3EK5Vn8=;
        b=xP5acuwLz5JTYTpNHVIgArXLcpqXoz1LAONAKy1117q95Y9/1svjmuOFH9NdTrapCwho7g
        XfMdhieA+diVvyvvRdSV5EcB7Ogkw9vIpIeRaQpc9KY0X8875eootnvtSO+KZNcUwBi9Vd
        facaCR8f4sKujTycmjwRzsfh3DjzM9OWnSHkR8WYTNszoXhUcJ3M34vJM1LQZy68MyW/QS
        gsxmotyCWJMcJrGlyZrPta993wtt5Fcf30m7y9lX9BUH6uMRvYdIhQMx/3JOhzNXN7rzL8
        8tSHPiL6SnqnyxnytfXklxVK0+A6fYp+wYL8uHyeotCLEUFU2w3LIgyp7i/4dA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603973732;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WZB+QTTPa98d7LFErl+2oiOVAAulytaZ5uvw3EK5Vn8=;
        b=QynbSsI3qZ9d6nkB8YhxE9PwKaHbjuW1LY9yvVaq9m3hasH+ac6iPGHG4+cjiqKoZU9crJ
        nWkoIpWkLo3R35DA==
From:   "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] iommu/vt-d: Simplify intel_irq_remapping_select()
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201024213535.443185-31-dwmw2@infradead.org>
References: <20201024213535.443185-31-dwmw2@infradead.org>
MIME-Version: 1.0
Message-ID: <160397373123.397.10388124473748618782.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     79eb3581bcaae9b5677629d945e14da212aa76e2
Gitweb:        https://git.kernel.org/tip/79eb3581bcaae9b5677629d945e14da212aa76e2
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Sat, 24 Oct 2020 22:35:30 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Oct 2020 20:26:28 +01:00

iommu/vt-d: Simplify intel_irq_remapping_select()

Now that the old get_irq_domain() method has gone, consolidate on just the
map_XXX_to_iommu() functions.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201024213535.443185-31-dwmw2@infradead.org

---
 drivers/iommu/intel/irq_remapping.c | 19 +++++++------------
 1 file changed, 7 insertions(+), 12 deletions(-)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index bca4401..aeffda9 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -203,13 +203,13 @@ static int modify_irte(struct irq_2_iommu *irq_iommu,
 	return rc;
 }
 
-static struct irq_domain *map_hpet_to_ir(u8 hpet_id)
+static struct intel_iommu *map_hpet_to_iommu(u8 hpet_id)
 {
 	int i;
 
 	for (i = 0; i < MAX_HPET_TBS; i++) {
 		if (ir_hpet[i].id == hpet_id && ir_hpet[i].iommu)
-			return ir_hpet[i].iommu->ir_domain;
+			return ir_hpet[i].iommu;
 	}
 	return NULL;
 }
@@ -225,13 +225,6 @@ static struct intel_iommu *map_ioapic_to_iommu(int apic)
 	return NULL;
 }
 
-static struct irq_domain *map_ioapic_to_ir(int apic)
-{
-	struct intel_iommu *iommu = map_ioapic_to_iommu(apic);
-
-	return iommu ? iommu->ir_domain : NULL;
-}
-
 static struct irq_domain *map_dev_to_ir(struct pci_dev *dev)
 {
 	struct dmar_drhd_unit *drhd = dmar_find_matched_drhd_unit(dev);
@@ -1418,12 +1411,14 @@ static int intel_irq_remapping_select(struct irq_domain *d,
 				      struct irq_fwspec *fwspec,
 				      enum irq_domain_bus_token bus_token)
 {
+	struct intel_iommu *iommu = NULL;
+
 	if (x86_fwspec_is_ioapic(fwspec))
-		return d == map_ioapic_to_ir(fwspec->param[0]);
+		iommu = map_ioapic_to_iommu(fwspec->param[0]);
 	else if (x86_fwspec_is_hpet(fwspec))
-		return d == map_hpet_to_ir(fwspec->param[0]);
+		iommu = map_hpet_to_iommu(fwspec->param[0]);
 
-	return 0;
+	return iommu && d == iommu->ir_domain;
 }
 
 static const struct irq_domain_ops intel_ir_domain_ops = {
