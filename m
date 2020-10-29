Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B5F3229EBB4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 13:19:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727068AbgJ2MR5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 08:17:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726109AbgJ2MPh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 08:15:37 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA6E0C0613D2;
        Thu, 29 Oct 2020 05:15:36 -0700 (PDT)
Date:   Thu, 29 Oct 2020 12:15:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603973735;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9GSu6S7Fu5B6h9g0wZPmBdgi/GVd9rQUxQCa9+0HSyM=;
        b=pSNj1PXaoiPXX+CvTnk3lOdQfhZVbUaymqP3SDw0VteNZ/sGsZ/0tessTkM7HTWULA4tf4
        NgqMNmdZZ6SrnMv9F5toFWEZRA7/JqKsfHNEv2+xe4zlLKgTJy2T+eLIU2ZUpn3t+pYmI+
        kTtlIYfSEjQj8977V/xr1CqEDVEO8oGvBhp9yE8bQ7KGMkF6AXb2fO0f/1nWhOwKxApJwx
        Qg/kXcwf39OpsT9xfIQwyXbkd/dv+DUuIorHRwh/F9GpBS87mfmh1PTK0nETFutAP0+vc8
        PxCfLUNQ7SXAo09OjCnoW6PH8r6/y721CWad8CLcBWgco0SPCXbGyUOnZAGyHg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603973735;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9GSu6S7Fu5B6h9g0wZPmBdgi/GVd9rQUxQCa9+0HSyM=;
        b=EBzFHvwriCrye0jmUShZfo92OFQGJMrlhTyglDhV+Zj888rjFAmkboj0Gznu8GqN+iunAa
        Hqf6edHtf5oodXDw==
From:   "tip-bot2 for David Woodhouse" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] iommu/vt-d: Implement select() method on remapping irqdomain
Cc:     David Woodhouse <dwmw@amazon.co.uk>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201024213535.443185-26-dwmw2@infradead.org>
References: <20201024213535.443185-26-dwmw2@infradead.org>
MIME-Version: 1.0
Message-ID: <160397373441.397.9363626143265340860.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     a87fb465ffe8eacd0d69032da33455e4f6fd8b41
Gitweb:        https://git.kernel.org/tip/a87fb465ffe8eacd0d69032da33455e4f6fd8b41
Author:        David Woodhouse <dwmw@amazon.co.uk>
AuthorDate:    Sat, 24 Oct 2020 22:35:25 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Oct 2020 20:26:27 +01:00

iommu/vt-d: Implement select() method on remapping irqdomain

Preparatory for removing irq_remapping_get_irq_domain()

Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201024213535.443185-26-dwmw2@infradead.org

---
 drivers/iommu/intel/irq_remapping.c | 13 +++++++++++++
 1 file changed, 13 insertions(+)

diff --git a/drivers/iommu/intel/irq_remapping.c b/drivers/iommu/intel/irq_remapping.c
index 96c84b1..b3b079c 100644
--- a/drivers/iommu/intel/irq_remapping.c
+++ b/drivers/iommu/intel/irq_remapping.c
@@ -1431,7 +1431,20 @@ static void intel_irq_remapping_deactivate(struct irq_domain *domain,
 	modify_irte(&data->irq_2_iommu, &entry);
 }
 
+static int intel_irq_remapping_select(struct irq_domain *d,
+				      struct irq_fwspec *fwspec,
+				      enum irq_domain_bus_token bus_token)
+{
+	if (x86_fwspec_is_ioapic(fwspec))
+		return d == map_ioapic_to_ir(fwspec->param[0]);
+	else if (x86_fwspec_is_hpet(fwspec))
+		return d == map_hpet_to_ir(fwspec->param[0]);
+
+	return 0;
+}
+
 static const struct irq_domain_ops intel_ir_domain_ops = {
+	.select = intel_irq_remapping_select,
 	.alloc = intel_irq_remapping_alloc,
 	.free = intel_irq_remapping_free,
 	.activate = intel_irq_remapping_activate,
