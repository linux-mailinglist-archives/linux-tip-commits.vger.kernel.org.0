Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7759F26CDC7
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 23:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726479AbgIPQO5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 12:14:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgIPQOc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 12:14:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94CEFC02C285;
        Wed, 16 Sep 2020 08:17:14 -0700 (PDT)
Date:   Wed, 16 Sep 2020 15:12:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600269139;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sGgG/m6MeomSQHkMS9lCCRWvMFa7P9V0hPQZKtoVy6E=;
        b=2nAgXT/8MEVvjXHU1OiC23ehJGX2zxDKDz9DM8uuDfLnQCpo7Y2IVUU9LTM/JQlCrkkiwS
        Bj66iUgw9fXJNXsTYlLnl1zFER37Fz8ofDMA0s62UN0j68Njf1uVbs31Sg3LQ89y7qYQgg
        FcmwnjS8pthLf+jd2ymaeVgw51EwZ+914ZcXD5oM0JZgxVm8LhIDTEC9MoFel5T7b0GKze
        Wy/I8RjNDZSMguzWN8jabxiKZuuvUlV/xBX2UcvxoHygEhMSasBC1B6Mk1lzs8E3nXm4q+
        jevR15X6KYV1UmwjygHrwjUWJ0/NMQtAURkkfitXH05mx8kSnkI4OB2ixEaEfA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600269139;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sGgG/m6MeomSQHkMS9lCCRWvMFa7P9V0hPQZKtoVy6E=;
        b=ib86plgn/6tl5gGSCZ2U0owMIReLK/2E1AloS7LPRcTSV23WY7jkbBq5EqNArP+IPyW5kR
        sKCsfHGM5dTkjECg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/irq] x86/irq: Consolidate UV domain allocation
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200826112332.255792469@linutronix.de>
References: <20200826112332.255792469@linutronix.de>
MIME-Version: 1.0
Message-ID: <160026913882.15536.15431109818403362062.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/irq branch of tip:

Commit-ID:     0f5cbdaf203e201f151c2e44a49f6165a7d2c2f9
Gitweb:        https://git.kernel.org/tip/0f5cbdaf203e201f151c2e44a49f6165a7d2c2f9
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 26 Aug 2020 13:16:44 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 16:52:33 +02:00

x86/irq: Consolidate UV domain allocation

Move the UV specific fields into their own struct for readability sake. Get
rid of the #ifdeffery as it does not matter at all whether the alloc info
is a couple of bytes longer or not.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200826112332.255792469@linutronix.de

---
 arch/x86/include/asm/hw_irq.h | 21 ++++++++++++---------
 arch/x86/platform/uv/uv_irq.c | 16 ++++++++--------
 2 files changed, 20 insertions(+), 17 deletions(-)

diff --git a/arch/x86/include/asm/hw_irq.h b/arch/x86/include/asm/hw_irq.h
index 79f6d1d..dd0b479 100644
--- a/arch/x86/include/asm/hw_irq.h
+++ b/arch/x86/include/asm/hw_irq.h
@@ -53,6 +53,14 @@ struct ioapic_alloc_info {
 	struct IO_APIC_route_entry	*entry;
 };
 
+struct uv_alloc_info {
+	int		limit;
+	int		blade;
+	unsigned long	offset;
+	char		*name;
+
+};
+
 /**
  * irq_alloc_info - X86 specific interrupt allocation info
  * @type:	X86 specific allocation type
@@ -64,7 +72,8 @@ struct ioapic_alloc_info {
  * @data:	Allocation specific data
  *
  * @ioapic:	IOAPIC specific allocation data
- */
+ * @uv:		UV specific allocation data
+*/
 struct irq_alloc_info {
 	enum irq_alloc_type	type;
 	u32			flags;
@@ -76,6 +85,8 @@ struct irq_alloc_info {
 
 	union {
 		struct ioapic_alloc_info	ioapic;
+		struct uv_alloc_info		uv;
+
 		int		unused;
 #ifdef	CONFIG_PCI_MSI
 		struct {
@@ -83,14 +94,6 @@ struct irq_alloc_info {
 			irq_hw_number_t	msi_hwirq;
 		};
 #endif
-#ifdef	CONFIG_X86_UV
-		struct {
-			int		uv_limit;
-			int		uv_blade;
-			unsigned long	uv_offset;
-			char		*uv_name;
-		};
-#endif
 	};
 };
 
diff --git a/arch/x86/platform/uv/uv_irq.c b/arch/x86/platform/uv/uv_irq.c
index abb6075..18ca226 100644
--- a/arch/x86/platform/uv/uv_irq.c
+++ b/arch/x86/platform/uv/uv_irq.c
@@ -90,15 +90,15 @@ static int uv_domain_alloc(struct irq_domain *domain, unsigned int virq,
 
 	ret = irq_domain_alloc_irqs_parent(domain, virq, nr_irqs, arg);
 	if (ret >= 0) {
-		if (info->uv_limit == UV_AFFINITY_CPU)
+		if (info->uv.limit == UV_AFFINITY_CPU)
 			irq_set_status_flags(virq, IRQ_NO_BALANCING);
 		else
 			irq_set_status_flags(virq, IRQ_MOVE_PCNTXT);
 
-		chip_data->pnode = uv_blade_to_pnode(info->uv_blade);
-		chip_data->offset = info->uv_offset;
+		chip_data->pnode = uv_blade_to_pnode(info->uv.blade);
+		chip_data->offset = info->uv.offset;
 		irq_domain_set_info(domain, virq, virq, &uv_irq_chip, chip_data,
-				    handle_percpu_irq, NULL, info->uv_name);
+				    handle_percpu_irq, NULL, info->uv.name);
 	} else {
 		kfree(chip_data);
 	}
@@ -193,10 +193,10 @@ int uv_setup_irq(char *irq_name, int cpu, int mmr_blade,
 
 	init_irq_alloc_info(&info, cpumask_of(cpu));
 	info.type = X86_IRQ_ALLOC_TYPE_UV;
-	info.uv_limit = limit;
-	info.uv_blade = mmr_blade;
-	info.uv_offset = mmr_offset;
-	info.uv_name = irq_name;
+	info.uv.limit = limit;
+	info.uv.blade = mmr_blade;
+	info.uv.offset = mmr_offset;
+	info.uv.name = irq_name;
 
 	return irq_domain_alloc_irqs(domain, 1,
 				     uv_blade_to_memory_nid(mmr_blade), &info);
