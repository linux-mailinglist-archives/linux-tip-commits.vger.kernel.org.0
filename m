Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4CE2B310C
	for <lists+linux-tip-commits@lfdr.de>; Sat, 14 Nov 2020 22:44:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726125AbgKNVoB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 14 Nov 2020 16:44:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726121AbgKNVoB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 14 Nov 2020 16:44:01 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0419BC0613D1;
        Sat, 14 Nov 2020 13:44:00 -0800 (PST)
Date:   Sat, 14 Nov 2020 21:43:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605390238;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FA57tlyeiRT09yLmvSyYiA3hxv8YXd8cBaTnA8ammNA=;
        b=kKVr1q3BPALxInY0nH8+uLmF3dGPajwpkjL3p4pogbzrr9qpIekSnlnIon5GsWe3p8UoU1
        o0HPsLXL9WLLTead39KCoMmcN2y/DrEiYBF52WW+GFq/8JMnhJrn6jT9IOpAPJqZ8eg3XX
        EjRyxJ99ryxbYN6pfwBAZP08FemadW7y2LhC28oEmCmii5tqs4uVI7xqngrCiAFQs7CPCc
        gPVDH5TwvgtfLvseYRUH6o5TieTKxS2jEvXsR4E5gycug24kMb/Tc/zB3fzvSI11mebL8P
        0Tct3VtoMvP0GOIXMWNZDL5caAcpiyPjsA5S56Sxz7JXQeHpmJTDqjhTLO8E9w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605390238;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FA57tlyeiRT09yLmvSyYiA3hxv8YXd8cBaTnA8ammNA=;
        b=6WF/GWbSS+8rUVre7D/BWBC5G3/Y8UbwngiW2QLUq3b2YyH2kcJ4k5BYr/MpL7x/JTjDYW
        sijY/TuKCkrPsgAw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Remove GENERIC_IRQ_LEGACY_ALLOC_HWIRQ
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <87eekvac06.fsf@nanos.tec.linutronix.de>
References: <87eekvac06.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Message-ID: <160539023632.11244.9050114800835130352.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     f296dcd629aa412a80a53215e46087f53af87f08
Gitweb:        https://git.kernel.org/tip/f296dcd629aa412a80a53215e46087f53af87f08
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Sat, 14 Nov 2020 22:01:45 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 14 Nov 2020 22:39:00 +01:00

genirq: Remove GENERIC_IRQ_LEGACY_ALLOC_HWIRQ

Commit bb9d812643d8 ("arch: remove tile port") removed the last user of
this cruft two years ago...

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/87eekvac06.fsf@nanos.tec.linutronix.de

---
 include/linux/irq.h  | 15 +-------------
 kernel/irq/Kconfig   |  5 +----
 kernel/irq/irqdesc.c | 51 +-------------------------------------------
 3 files changed, 71 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index c543653..79ce314 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -954,21 +954,6 @@ static inline void irq_free_desc(unsigned int irq)
 	irq_free_descs(irq, 1);
 }
 
-#ifdef CONFIG_GENERIC_IRQ_LEGACY_ALLOC_HWIRQ
-unsigned int irq_alloc_hwirqs(int cnt, int node);
-static inline unsigned int irq_alloc_hwirq(int node)
-{
-	return irq_alloc_hwirqs(1, node);
-}
-void irq_free_hwirqs(unsigned int from, int cnt);
-static inline void irq_free_hwirq(unsigned int irq)
-{
-	return irq_free_hwirqs(irq, 1);
-}
-int arch_setup_hwirq(unsigned int irq, int node);
-void arch_teardown_hwirq(unsigned int irq);
-#endif
-
 #ifdef CONFIG_GENERIC_IRQ_LEGACY
 void irq_init_desc(unsigned int irq);
 #endif
diff --git a/kernel/irq/Kconfig b/kernel/irq/Kconfig
index 10a5aff..f2cda6b 100644
--- a/kernel/irq/Kconfig
+++ b/kernel/irq/Kconfig
@@ -26,11 +26,6 @@ config GENERIC_IRQ_SHOW_LEVEL
 config GENERIC_IRQ_EFFECTIVE_AFF_MASK
        bool
 
-# Facility to allocate a hardware interrupt. This is legacy support
-# and should not be used in new code. Use irq domains instead.
-config GENERIC_IRQ_LEGACY_ALLOC_HWIRQ
-       bool
-
 # Support for delayed migration from interrupt context
 config GENERIC_PENDING_IRQ
 	bool
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 1a77236..e810eb9 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -810,57 +810,6 @@ unlock:
 }
 EXPORT_SYMBOL_GPL(__irq_alloc_descs);
 
-#ifdef CONFIG_GENERIC_IRQ_LEGACY_ALLOC_HWIRQ
-/**
- * irq_alloc_hwirqs - Allocate an irq descriptor and initialize the hardware
- * @cnt:	number of interrupts to allocate
- * @node:	node on which to allocate
- *
- * Returns an interrupt number > 0 or 0, if the allocation fails.
- */
-unsigned int irq_alloc_hwirqs(int cnt, int node)
-{
-	int i, irq = __irq_alloc_descs(-1, 0, cnt, node, NULL, NULL);
-
-	if (irq < 0)
-		return 0;
-
-	for (i = irq; cnt > 0; i++, cnt--) {
-		if (arch_setup_hwirq(i, node))
-			goto err;
-		irq_clear_status_flags(i, _IRQ_NOREQUEST);
-	}
-	return irq;
-
-err:
-	for (i--; i >= irq; i--) {
-		irq_set_status_flags(i, _IRQ_NOREQUEST | _IRQ_NOPROBE);
-		arch_teardown_hwirq(i);
-	}
-	irq_free_descs(irq, cnt);
-	return 0;
-}
-EXPORT_SYMBOL_GPL(irq_alloc_hwirqs);
-
-/**
- * irq_free_hwirqs - Free irq descriptor and cleanup the hardware
- * @from:	Free from irq number
- * @cnt:	number of interrupts to free
- *
- */
-void irq_free_hwirqs(unsigned int from, int cnt)
-{
-	int i, j;
-
-	for (i = from, j = cnt; j > 0; i++, j--) {
-		irq_set_status_flags(i, _IRQ_NOREQUEST | _IRQ_NOPROBE);
-		arch_teardown_hwirq(i);
-	}
-	irq_free_descs(from, cnt);
-}
-EXPORT_SYMBOL_GPL(irq_free_hwirqs);
-#endif
-
 /**
  * irq_get_next_irq - get next allocated irq number
  * @offset:	where to start the search
