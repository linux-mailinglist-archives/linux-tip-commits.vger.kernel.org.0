Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8E829EBAE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 13:19:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbgJ2MRk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 08:17:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33248 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726088AbgJ2MPi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 08:15:38 -0400
Date:   Thu, 29 Oct 2020 12:15:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603973735;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xKPjo9xvQnbHqhQzl4UTgEV6O1rMgAOT/TMoZc0hg6c=;
        b=vnTqnmues3Xlut5SZAe3d7lCOwJXtEGmgLozukwoTU618ZWwWqq/EzdXVXt9i9DGY/fz+E
        aTAsngFRXcYw42iv00/aQ2ZGJvM3dvytBxFS+56nbE4QLaeasfxFZCmXmDUNsAeQUADK24
        CnepfNH5bQ8DQv+s9xYbioomEn8ff5Ft5ykVFg2mWebvCd06eD1cPfvRaxLVLV+wCsa9fA
        jmagKmcIg4ua5p3fYJyMurMAQmZ14E/ubhH+hTCFrwBwAxn/BY+AJxCODr96VRSaQ7/ZTE
        ZK//Ukqc0XuXhbBIGFeSyb7/X+tRVrstcPlDKEHZPt7uKKRiPfrc+O4rmGAoww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603973735;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xKPjo9xvQnbHqhQzl4UTgEV6O1rMgAOT/TMoZc0hg6c=;
        b=mcDGWoBGOGzOt7cMkS5bJaIOajJzRyTQ7j6rDNxc85tF6MqxrsTEGsHGohmW+yVWvjt57a
        pmNqPrbZCnib0JCA==
From:   "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] iommu/amd: Implement select() method on remapping irqdomain
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201024213535.443185-25-dwmw2@infradead.org>
References: <20201024213535.443185-25-dwmw2@infradead.org>
MIME-Version: 1.0
Message-ID: <160397373506.397.4010149583429604883.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     a1a785b572425ab3ca5494a4be02ab59a796df51
Gitweb:        https://git.kernel.org/tip/a1a785b572425ab3ca5494a4be02ab59a796df51
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Sat, 24 Oct 2020 22:35:24 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Oct 2020 20:26:27 +01:00

iommu/amd: Implement select() method on remapping irqdomain

Preparatory change to remove irq_remapping_get_irq_domain().

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201024213535.443185-25-dwmw2@infradead.org

---
 drivers/iommu/amd/iommu.c | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index 9744cdb..31b2224 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -3882,7 +3882,26 @@ static void irq_remapping_deactivate(struct irq_domain *domain,
 					    irte_info->index);
 }
 
+static int irq_remapping_select(struct irq_domain *d, struct irq_fwspec *fwspec,
+				enum irq_domain_bus_token bus_token)
+{
+	struct amd_iommu *iommu;
+	int devid = -1;
+
+	if (x86_fwspec_is_ioapic(fwspec))
+		devid = get_ioapic_devid(fwspec->param[0]);
+	else if (x86_fwspec_is_hpet(fwspec))
+		devid = get_hpet_devid(fwspec->param[0]);
+
+	if (devid < 0)
+		return 0;
+
+	iommu = amd_iommu_rlookup_table[devid];
+	return iommu && iommu->ir_domain == d;
+}
+
 static const struct irq_domain_ops amd_ir_domain_ops = {
+	.select = irq_remapping_select,
 	.alloc = irq_remapping_alloc,
 	.free = irq_remapping_free,
 	.activate = irq_remapping_activate,
