Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A80F2D8693
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Dec 2020 14:04:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438900AbgLLNAa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 12 Dec 2020 08:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2438958AbgLLNAa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 12 Dec 2020 08:00:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DDE4C0611CA;
        Sat, 12 Dec 2020 04:58:45 -0800 (PST)
Date:   Sat, 12 Dec 2020 12:58:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1607777920;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aE2PPfPA5CvThEQVzbVw6mImk3myVuXPYyduaqON0Bw=;
        b=nEtzHqZLi4YUBsCQP0a93dal5/fdTdILHGcdLSVF3p7BLSbwGkRK6LY6MlAE9u7v2rWX3S
        BVuNFsZbgrbMDi7BFta2UxJFJ39ESlSdkCSx2F+izvOscwDlZNqB28KYjZy4EPhdoWSDaT
        ZZQF4YMbs1zbzBAV2ylzwTeXR7dF3qQ0K6jGmHzVUB77vaoQWvut0dJvTFYhln+doNsKI6
        mQcJO3mxkZrRG7ZbX8SfdddFzPNkqpqYvzA6eTvZP4n1HPLB0Urz8JWyqPfYWI1n1sq6Nr
        8oN3o/EDB0dyHSPjK7DMwAjByxY+KQX1OoyHVhqhtSS1i20XgIVDHWwnvpZDDA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1607777920;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aE2PPfPA5CvThEQVzbVw6mImk3myVuXPYyduaqON0Bw=;
        b=I/OAa79e0Zhi8zvUMd77NqwSN9dPO1I5/Q4WJqgNyL+/nKr/wUP9MhpQWW33V2soOSKgvn
        hmOzDkqhIzEoVWAQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Make kstat_irqs() static
Cc:     Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201210194043.268774449@linutronix.de>
References: <20201210194043.268774449@linutronix.de>
MIME-Version: 1.0
Message-ID: <160777792041.3364.7294928960882791899.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     63ca4e066a62afce8ebaf75ebd4c6ef67f7bb5ee
Gitweb:        https://git.kernel.org/tip/63ca4e066a62afce8ebaf75ebd4c6ef67f7bb5ee
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Thu, 10 Dec 2020 20:25:43 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 12 Dec 2020 12:59:03 +01:00

genirq: Make kstat_irqs() static

No more users outside the core code.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201210194043.268774449@linutronix.de

---
 include/linux/kernel_stat.h |  1 -
 kernel/irq/irqdesc.c        | 19 ++++++-------------
 2 files changed, 6 insertions(+), 14 deletions(-)

diff --git a/include/linux/kernel_stat.h b/include/linux/kernel_stat.h
index 89f0745..44ae1a7 100644
--- a/include/linux/kernel_stat.h
+++ b/include/linux/kernel_stat.h
@@ -67,7 +67,6 @@ static inline unsigned int kstat_softirqs_cpu(unsigned int irq, int cpu)
 /*
  * Number of interrupts per specific IRQ source, since bootup
  */
-extern unsigned int kstat_irqs(unsigned int irq);
 extern unsigned int kstat_irqs_usr(unsigned int irq);
 
 /*
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index d28f69e..1f7325f 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -924,15 +924,7 @@ static bool irq_is_nmi(struct irq_desc *desc)
 	return desc->istate & IRQS_NMI;
 }
 
-/**
- * kstat_irqs - Get the statistics for an interrupt
- * @irq:	The interrupt number
- *
- * Returns the sum of interrupt counts on all cpus since boot for
- * @irq. The caller must ensure that the interrupt is not removed
- * concurrently.
- */
-unsigned int kstat_irqs(unsigned int irq)
+static unsigned int kstat_irqs(unsigned int irq)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 	unsigned int sum = 0;
@@ -951,13 +943,14 @@ unsigned int kstat_irqs(unsigned int irq)
 }
 
 /**
- * kstat_irqs_usr - Get the statistics for an interrupt
+ * kstat_irqs_usr - Get the statistics for an interrupt from thread context
  * @irq:	The interrupt number
  *
  * Returns the sum of interrupt counts on all cpus since boot for @irq.
- * Contrary to kstat_irqs() this can be called from any context.
- * It uses rcu since a concurrent removal of an interrupt descriptor is
- * observing an rcu grace period before delayed_free_desc()/irq_kobj_release().
+ *
+ * It uses rcu to protect the access since a concurrent removal of an
+ * interrupt descriptor is observing an rcu grace period before
+ * delayed_free_desc()/irq_kobj_release().
  */
 unsigned int kstat_irqs_usr(unsigned int irq)
 {
