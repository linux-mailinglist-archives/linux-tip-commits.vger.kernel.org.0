Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF54F29EBB2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 13:19:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725791AbgJ2MRt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 08:17:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33224 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726083AbgJ2MPh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 08:15:37 -0400
Date:   Thu, 29 Oct 2020 12:15:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603973733;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9JJHeTF7XCwnAuhR9nLiAAZrI3yZ7G1esV9HDjFGiUE=;
        b=C6oFt49cBxytv+cH75UJtTmvmvajlydnyv1zk78jZ+7KsAlgrqxX8RpCGFuwDztRbr7yc4
        919UKe7Tco/XzccOGd4TgFDhSndYGdNmy5tRXtdjXBedpKdPc9i0hb8aO4Mexh7I4vLpwR
        NF2liJJauI8H4TmsXiRZdzFMVkF3xY58SLW8SRBWXc9Yg/nY0rMD7/MkVe+bV8oca01wPW
        BR1MGwV1IV/u1K/Efaby6QRtCmeSVcIsdoORpmP+Feg4hbeUlbAXCBMDpuYeMyN9ihv59R
        evvNXUusfylxg8Ki13jhmLRoFpD0CTQXF9A9oSDB2173RDZofrNgfUob4t9WrA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603973733;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9JJHeTF7XCwnAuhR9nLiAAZrI3yZ7G1esV9HDjFGiUE=;
        b=1LswGIWWRPZJ1D7r0noqv9z79mi2YG44XNMItl5jqPlXkC/28vk9ciMHa3D2jloixdWHkL
        Ds/ECuUaFDyPsDAg==
From:   "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/ioapic: Use irq_find_matching_fwspec() to find
 remapping irqdomain
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201024213535.443185-29-dwmw2@infradead.org>
References: <20201024213535.443185-29-dwmw2@infradead.org>
MIME-Version: 1.0
Message-ID: <160397373251.397.133764854902256611.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     b643128b917ca8f1c8b1e14af64ebdc81147b2d1
Gitweb:        https://git.kernel.org/tip/b643128b917ca8f1c8b1e14af64ebdc81147b2d1
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Sat, 24 Oct 2020 22:35:28 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Oct 2020 20:26:28 +01:00

x86/ioapic: Use irq_find_matching_fwspec() to find remapping irqdomain

All possible parent domains have a select method now. Make use of it.

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201024213535.443185-29-dwmw2@infradead.org

---
 arch/x86/kernel/apic/io_apic.c | 25 +++++++++++++------------
 1 file changed, 13 insertions(+), 12 deletions(-)

diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index ea983da..443d2c9 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -2320,36 +2320,37 @@ out:
 
 static int mp_irqdomain_create(int ioapic)
 {
-	struct irq_alloc_info info;
 	struct irq_domain *parent;
 	int hwirqs = mp_ioapic_pin_count(ioapic);
 	struct ioapic *ip = &ioapics[ioapic];
 	struct ioapic_domain_cfg *cfg = &ip->irqdomain_cfg;
 	struct mp_ioapic_gsi *gsi_cfg = mp_ioapic_gsi_routing(ioapic);
 	struct fwnode_handle *fn;
-	char *name = "IO-APIC";
+	struct irq_fwspec fwspec;
 
 	if (cfg->type == IOAPIC_DOMAIN_INVALID)
 		return 0;
 
-	init_irq_alloc_info(&info, NULL);
-	info.type = X86_IRQ_ALLOC_TYPE_IOAPIC_GET_PARENT;
-	info.devid = mpc_ioapic_id(ioapic);
-	parent = irq_remapping_get_irq_domain(&info);
-	if (!parent)
-		parent = x86_vector_domain;
-	else
-		name = "IO-APIC-IR";
-
 	/* Handle device tree enumerated APICs proper */
 	if (cfg->dev) {
 		fn = of_node_to_fwnode(cfg->dev);
 	} else {
-		fn = irq_domain_alloc_named_id_fwnode(name, ioapic);
+		fn = irq_domain_alloc_named_id_fwnode("IO-APIC", ioapic);
 		if (!fn)
 			return -ENOMEM;
 	}
 
+	fwspec.fwnode = fn;
+	fwspec.param_count = 1;
+	fwspec.param[0] = ioapic;
+
+	parent = irq_find_matching_fwspec(&fwspec, DOMAIN_BUS_ANY);
+	if (!parent) {
+		if (!cfg->dev)
+			irq_domain_free_fwnode(fn);
+		return -ENODEV;
+	}
+
 	ip->irqdomain = irq_domain_create_linear(fn, hwirqs, cfg->ops,
 						 (void *)(long)ioapic);
 
