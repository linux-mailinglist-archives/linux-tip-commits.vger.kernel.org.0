Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AAE229EB86
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 13:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726809AbgJ2MQZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 08:16:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33326 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725782AbgJ2MPu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 08:15:50 -0400
Date:   Thu, 29 Oct 2020 12:15:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603973748;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZD3UymYj929wPsp3ExzTwZiXerSVwnfoDj6+Wk3w0mQ=;
        b=nCBM8V9N7uPQEMImArD9KtIb5S6vyPI9CDqTzyoiRA9NG0dFNTGBzt/6Orxagl/vu59SI3
        C0IZMv3geIT4Swb/aPZkh+LFcaDj0nEwTxzGd3LVeqlp1x9aS8C44HhQmVT1kai/98sSEt
        EvHtZOsj2lf59wP7WOCeMCCEvVDwSv3RmneR2h/J+A/V5t/BdcQVaUMKXiczfEJkPf6y8v
        GgVDOwv4YOP1isFeMVBSz6zdxxQuuDk4m9C64bTgOJtxBUGiPxmQNxKimtJ7g860+fm5TW
        g325IWUBumVwwuOrY/W0lO6yv0iT7lIv/sGhURYKn60KqXi+uC9ItVB9HhHqrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603973748;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZD3UymYj929wPsp3ExzTwZiXerSVwnfoDj6+Wk3w0mQ=;
        b=gfAxtOiI+UNF7vKA6WOi9SumYi2OLqooOydz2z+aXYN6r9zPeIwpkJ9ZzPvis6+wsDcHi/
        QSLKO9YBIlbSPzDg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/apic] x86/devicetree: Fix the ioapic interrupt type table
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        David Woodhouse <dwmw@amazon.co.uk>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201024213535.443185-5-dwmw2@infradead.org>
References: <20201024213535.443185-5-dwmw2@infradead.org>
MIME-Version: 1.0
Message-ID: <160397374759.397.13060318375448986961.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/apic branch of tip:

Commit-ID:     2e730cb56b2cd1626fecaf23ef1537fb24721ef2
Gitweb:        https://git.kernel.org/tip/2e730cb56b2cd1626fecaf23ef1537fb24721ef2
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 24 Oct 2020 22:35:04 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Oct 2020 20:26:24 +01:00

x86/devicetree: Fix the ioapic interrupt type table

The ioapic interrupt type table is wrong as it assumes that polarity in
IO/APIC context means active high when set. But the IO/APIC polarity is
working the other way round. This works because the ordering of the entries
is consistent with the device tree and the type information is not used by
the IO/APIC interrupt chip.

The whole trigger and polarity business of IO/APIC is misleading and the
corresponding constants which are defined as 0/1 are not used consistently
and are going to be removed.

Rename the type table members to 'is_level' and 'active_low' and adjust the
type information for consistency sake.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: David Woodhouse <dwmw@amazon.co.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201024213535.443185-5-dwmw2@infradead.org

---
 arch/x86/kernel/devicetree.c | 30 +++++++++++++++---------------
 1 file changed, 15 insertions(+), 15 deletions(-)

diff --git a/arch/x86/kernel/devicetree.c b/arch/x86/kernel/devicetree.c
index ddffd80..6a4cb71 100644
--- a/arch/x86/kernel/devicetree.c
+++ b/arch/x86/kernel/devicetree.c
@@ -184,31 +184,31 @@ static unsigned int ioapic_id;
 
 struct of_ioapic_type {
 	u32 out_type;
-	u32 trigger;
-	u32 polarity;
+	u32 is_level;
+	u32 active_low;
 };
 
 static struct of_ioapic_type of_ioapic_type[] =
 {
 	{
-		.out_type	= IRQ_TYPE_EDGE_RISING,
-		.trigger	= IOAPIC_EDGE,
-		.polarity	= 1,
+		.out_type	= IRQ_TYPE_EDGE_FALLING,
+		.is_level	= 0,
+		.active_low	= 1,
 	},
 	{
-		.out_type	= IRQ_TYPE_LEVEL_LOW,
-		.trigger	= IOAPIC_LEVEL,
-		.polarity	= 0,
+		.out_type	= IRQ_TYPE_LEVEL_HIGH,
+		.is_level	= 1,
+		.active_low	= 0,
 	},
 	{
-		.out_type	= IRQ_TYPE_LEVEL_HIGH,
-		.trigger	= IOAPIC_LEVEL,
-		.polarity	= 1,
+		.out_type	= IRQ_TYPE_LEVEL_LOW,
+		.is_level	= 1,
+		.active_low	= 1,
 	},
 	{
-		.out_type	= IRQ_TYPE_EDGE_FALLING,
-		.trigger	= IOAPIC_EDGE,
-		.polarity	= 0,
+		.out_type	= IRQ_TYPE_EDGE_RISING,
+		.is_level	= 0,
+		.active_low	= 0,
 	},
 };
 
@@ -228,7 +228,7 @@ static int dt_irqdomain_alloc(struct irq_domain *domain, unsigned int virq,
 		return -EINVAL;
 
 	it = &of_ioapic_type[type_index];
-	ioapic_set_alloc_attr(&tmp, NUMA_NO_NODE, it->trigger, it->polarity);
+	ioapic_set_alloc_attr(&tmp, NUMA_NO_NODE, it->is_level, it->active_low);
 	tmp.devid = mpc_ioapic_id(mp_irqdomain_ioapic_idx(domain));
 	tmp.ioapic.pin = fwspec->param[0];
 
