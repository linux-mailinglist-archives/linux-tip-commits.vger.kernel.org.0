Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30F913E5C9D
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Aug 2021 16:12:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241386AbhHJOMa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Aug 2021 10:12:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43654 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240580AbhHJOM3 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Aug 2021 10:12:29 -0400
Date:   Tue, 10 Aug 2021 14:12:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1628604725;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9znJhSebKL+O+kQ08F7coI8c5qH+PXl+LIk3PxlRzU4=;
        b=Cmit3Uc6dXZYPAwH6RiHwU4HuKHSzSyrjkrSOj4i9vTJqAbT/qP0/hDXWwtzkTP3ASPoG3
        NQ0BpoiLd0xd7ssSHUHV3KswrNIMbh0WrWzVGW1x6b/4/d/vuUKA1yavTXOxv6d4Ckyyyr
        DGXKGlz35pD0IG8JiCeOCw600ETlhCr7LT5I5eJTxqz9xzpQBEgIDNIzANImXR25hZzrh4
        r8S+eY9QQN8yERZ9a0+5QnqjO934FshShm5Rom3UhfuD24Vpwm++xx/pCj9q30oDx/YAJo
        Kqq6MPpKerqzqGhQlLp/L7e6ycgLooeZdeFEC8ve+BzuE91Qm/tNBi3MEIwiXQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1628604725;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9znJhSebKL+O+kQ08F7coI8c5qH+PXl+LIk3PxlRzU4=;
        b=id/z09jZm30IiTrbi756FJ7yOnnB70tFvzbLssnEjvx/du3RbZw7KtL0py/JzgJ4vlY3Kb
        otKT0d74MdR9GeDg==
From:   "tip-bot2 for Tanner Love" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Change force_irqthreads to a static key
Cc:     Eric Dumazet <edumazet@google.com>,
        Tanner Love <tannerlove@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210602180338.3324213-1-tannerlove.kernel@gmail.com>
References: <20210602180338.3324213-1-tannerlove.kernel@gmail.com>
MIME-Version: 1.0
Message-ID: <162860472466.395.18404030703403232612.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     af5b7fe6bb77ac775d446e2f25f013d5df551e9a
Gitweb:        https://git.kernel.org/tip/af5b7fe6bb77ac775d446e2f25f013d5df551e9a
Author:        Tanner Love <tannerlove@google.com>
AuthorDate:    Wed, 02 Jun 2021 14:03:38 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 10 Aug 2021 16:06:55 +02:00

genirq: Change force_irqthreads to a static key

With CONFIG_IRQ_FORCED_THREADING=y, testing the boolean force_irqthreads
could incur a cache line miss in invoke_softirq() and other places.

Replace the test with a static key to avoid the potential cache miss.

[ tglx: Dropped the IDE part, removed the export and updated blk-mq ]

Suggested-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Tanner Love <tannerlove@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Reviewed-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20210602180338.3324213-1-tannerlove.kernel@gmail.com
---
 block/blk-mq.c            |  2 +-
 include/linux/interrupt.h |  8 +++++---
 kernel/irq/manage.c       |  9 ++++-----
 kernel/softirq.c          |  2 +-
 4 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 2c4ac51..572d8ab 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -606,7 +606,7 @@ static inline bool blk_mq_complete_need_ipi(struct request *rq)
 	 * This is probably worse than completing the request on a different
 	 * cache domain.
 	 */
-	if (force_irqthreads)
+	if (force_irqthreads())
 		return false;
 
 	/* same CPU or cache domain?  Complete locally */
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 2ed65b0..1f22a30 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -13,6 +13,7 @@
 #include <linux/hrtimer.h>
 #include <linux/kref.h>
 #include <linux/workqueue.h>
+#include <linux/jump_label.h>
 
 #include <linux/atomic.h>
 #include <asm/ptrace.h>
@@ -474,12 +475,13 @@ extern int irq_set_irqchip_state(unsigned int irq, enum irqchip_irq_state which,
 
 #ifdef CONFIG_IRQ_FORCED_THREADING
 # ifdef CONFIG_PREEMPT_RT
-#  define force_irqthreads	(true)
+#  define force_irqthreads()	(true)
 # else
-extern bool force_irqthreads;
+DECLARE_STATIC_KEY_FALSE(force_irqthreads_key);
+#  define force_irqthreads()	(static_branch_unlikely(&force_irqthreads_key))
 # endif
 #else
-#define force_irqthreads	(0)
+#define force_irqthreads()	(false)
 #endif
 
 #ifndef local_softirq_pending
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 766468a..bb3c51d 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -25,12 +25,11 @@
 #include "internals.h"
 
 #if defined(CONFIG_IRQ_FORCED_THREADING) && !defined(CONFIG_PREEMPT_RT)
-__read_mostly bool force_irqthreads;
-EXPORT_SYMBOL_GPL(force_irqthreads);
+DEFINE_STATIC_KEY_FALSE(force_irqthreads_key);
 
 static int __init setup_forced_irqthreads(char *arg)
 {
-	force_irqthreads = true;
+	static_branch_enable(&force_irqthreads_key);
 	return 0;
 }
 early_param("threadirqs", setup_forced_irqthreads);
@@ -1260,8 +1259,8 @@ static int irq_thread(void *data)
 	irqreturn_t (*handler_fn)(struct irq_desc *desc,
 			struct irqaction *action);
 
-	if (force_irqthreads && test_bit(IRQTF_FORCED_THREAD,
-					&action->thread_flags))
+	if (force_irqthreads() && test_bit(IRQTF_FORCED_THREAD,
+					   &action->thread_flags))
 		handler_fn = irq_forced_thread_fn;
 	else
 		handler_fn = irq_thread_fn;
diff --git a/kernel/softirq.c b/kernel/softirq.c
index f3a0121..322b65d 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -422,7 +422,7 @@ static inline void invoke_softirq(void)
 	if (ksoftirqd_running(local_softirq_pending()))
 		return;
 
-	if (!force_irqthreads || !__this_cpu_read(ksoftirqd)) {
+	if (!force_irqthreads() || !__this_cpu_read(ksoftirqd)) {
 #ifdef CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
 		/*
 		 * We can safely execute softirq on the current stack if
