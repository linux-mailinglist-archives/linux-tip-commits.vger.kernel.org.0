Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 19133388A4D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 19 May 2021 11:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344001AbhESJQA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 19 May 2021 05:16:00 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38018 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343716AbhESJQA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 19 May 2021 05:16:00 -0400
Date:   Wed, 19 May 2021 09:14:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621415679;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iJ1wPPW53XVoYNCT4k9QipBLpHO3waN6/h9gYQTSugg=;
        b=uIkq5h0zqWmPhAbeXaxJSv7y4U1Tbo1oq32NEI1Nf7fPoFIVHdxauwZKHOmCnPpUknFkf+
        XUwAetyfwXpEDEFC4t97VgqeqL5GIGC8rvvTNkhnViNAiEYNja3Em6sV40draj7zOcK17N
        +QpiuHj1D98udBZ17HxrSK0Sv2Y1hp+6Ob3tC/4QJFVYfVZFJikW/DZeXt9emxrx4W+9O3
        mIGM2rMDrFl0xu14uwHuA/j/BXCep9xQBh3Hws/uicNU6mAB1r4bsn4fUgHe1FL/1UVXX7
        irbMyJObD6C/Ux9Bq3qw6LlR+iMTmIvpbmA7708YPsZ+QO5/OBPcUNaFsXDqEw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621415679;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iJ1wPPW53XVoYNCT4k9QipBLpHO3waN6/h9gYQTSugg=;
        b=VgeN71BQZrPVKiSqMAkDbqH1FWT9Xc8HtAXE1qS/aD5nP83ypPcK+mra1Yrg989SmGhgh2
        AGopWoo6gAMUAOCw==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Export affinity setter for modules
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Mark Rutland <mark.rutland@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210518093117.968251441@linutronix.de>
References: <20210518093117.968251441@linutronix.de>
MIME-Version: 1.0
Message-ID: <162141567899.29796.14597202201574630212.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     4d80d6ca5d77fde9880da8466e5b64f250e5bf82
Gitweb:        https://git.kernel.org/tip/4d80d6ca5d77fde9880da8466e5b64f250e5bf82
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 18 May 2021 11:17:26 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 19 May 2021 11:01:51 +02:00

genirq: Export affinity setter for modules

Perf modules abuse irq_set_affinity_hint() to set the affinity of system
PMU interrupts just because irq_set_affinity() was not exported.

The fact that irq_set_affinity_hint() actually sets the affinity is a
non-documented side effect and the name is clearly saying it's a hint.

To clean this up, export the real affinity setter.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/r/20210518093117.968251441@linutronix.de
---
 include/linux/interrupt.h | 35 ++---------------------------------
 kernel/irq/manage.c       | 33 ++++++++++++++++++++++++++++++++-
 2 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 4777850..35a3742 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -319,39 +319,8 @@ struct irq_affinity_desc {
 
 extern cpumask_var_t irq_default_affinity;
 
-/* Internal implementation. Use the helpers below */
-extern int __irq_set_affinity(unsigned int irq, const struct cpumask *cpumask,
-			      bool force);
-
-/**
- * irq_set_affinity - Set the irq affinity of a given irq
- * @irq:	Interrupt to set affinity
- * @cpumask:	cpumask
- *
- * Fails if cpumask does not contain an online CPU
- */
-static inline int
-irq_set_affinity(unsigned int irq, const struct cpumask *cpumask)
-{
-	return __irq_set_affinity(irq, cpumask, false);
-}
-
-/**
- * irq_force_affinity - Force the irq affinity of a given irq
- * @irq:	Interrupt to set affinity
- * @cpumask:	cpumask
- *
- * Same as irq_set_affinity, but without checking the mask against
- * online cpus.
- *
- * Solely for low level cpu hotplug code, where we need to make per
- * cpu interrupts affine before the cpu becomes online.
- */
-static inline int
-irq_force_affinity(unsigned int irq, const struct cpumask *cpumask)
-{
-	return __irq_set_affinity(irq, cpumask, true);
-}
+extern int irq_set_affinity(unsigned int irq, const struct cpumask *cpumask);
+extern int irq_force_affinity(unsigned int irq, const struct cpumask *cpumask);
 
 extern int irq_can_set_affinity(unsigned int irq);
 extern int irq_select_affinity(unsigned int irq);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 4c14356..a847dd2 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -441,7 +441,8 @@ out_unlock:
 	return ret;
 }
 
-int __irq_set_affinity(unsigned int irq, const struct cpumask *mask, bool force)
+static int __irq_set_affinity(unsigned int irq, const struct cpumask *mask,
+			      bool force)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
 	unsigned long flags;
@@ -456,6 +457,36 @@ int __irq_set_affinity(unsigned int irq, const struct cpumask *mask, bool force)
 	return ret;
 }
 
+/**
+ * irq_set_affinity - Set the irq affinity of a given irq
+ * @irq:	Interrupt to set affinity
+ * @cpumask:	cpumask
+ *
+ * Fails if cpumask does not contain an online CPU
+ */
+int irq_set_affinity(unsigned int irq, const struct cpumask *cpumask)
+{
+	return __irq_set_affinity(irq, cpumask, false);
+}
+EXPORT_SYMBOL_GPL(irq_set_affinity);
+
+/**
+ * irq_force_affinity - Force the irq affinity of a given irq
+ * @irq:	Interrupt to set affinity
+ * @cpumask:	cpumask
+ *
+ * Same as irq_set_affinity, but without checking the mask against
+ * online cpus.
+ *
+ * Solely for low level cpu hotplug code, where we need to make per
+ * cpu interrupts affine before the cpu becomes online.
+ */
+int irq_force_affinity(unsigned int irq, const struct cpumask *cpumask)
+{
+	return __irq_set_affinity(irq, cpumask, true);
+}
+EXPORT_SYMBOL_GPL(irq_force_affinity);
+
 int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m)
 {
 	unsigned long flags;
