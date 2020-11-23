Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 60F9E2C18DD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Nov 2020 23:59:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387427AbgKWWwf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 23 Nov 2020 17:52:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387533AbgKWWvr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 23 Nov 2020 17:51:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 070CFC0613CF;
        Mon, 23 Nov 2020 14:51:46 -0800 (PST)
Date:   Mon, 23 Nov 2020 22:51:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606171905;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I2yRVGKp5DQGmKIrVePhCEZ3ZAzs1EXsL/mIi33fzRM=;
        b=mGYj1H+zcYpb3tYmFsjenERIKvcolYe3fsE36TSl9/Xx61yIwNoREQ280jrT9iU8OJV3iR
        Cp5r5uKI6Jz70iL5DolabpremUzmXoI8+TdlJl/HsTYLiJKZs3jIIDBCxetWtW+wdAzpVE
        YXmubQtQQkv6qvgme19TjjEp2ZmffLanQORGUnWiBY00IaRaYlC5WLzKpYUoZEv3gF+Q1N
        s52DBPIVfBcLi3s0NGsMFm9zuQ+AZQdHfFoeAenmhWiC1/50ZDrOtaof+Pl7Rv+K5JJVMU
        EdokNj5RNBo6LC9jdmiFTTzzauqYZqWne8I2ia0gpONzI11sYGdbGKnIKVRhVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606171905;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=I2yRVGKp5DQGmKIrVePhCEZ3ZAzs1EXsL/mIi33fzRM=;
        b=QT8yLquEpUGRklMqj894scsUHIOQ1p54Zjqe/nGaRR/33JTxCG1gujqCgBzbNdhmyoc0tW
        N8B0ZvqTLwIHhmBQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] softirq: Move related code into one section
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20201113141733.974214480@linutronix.de>
References: <20201113141733.974214480@linutronix.de>
MIME-Version: 1.0
Message-ID: <160617190365.11115.3838746604966137453.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     ae9ef58996a4447dd44aa638759f913c883ba816
Gitweb:        https://git.kernel.org/tip/ae9ef58996a4447dd44aa638759f913c883ba816
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 13 Nov 2020 15:02:18 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 23 Nov 2020 10:31:06 +01:00

softirq: Move related code into one section

To prepare for adding a RT aware variant of softirq serialization and
processing move related code into one section so the necessary #ifdeffery
is reduced to one.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20201113141733.974214480@linutronix.de

---
 kernel/softirq.c | 107 +++++++++++++++++++++++-----------------------
 1 file changed, 54 insertions(+), 53 deletions(-)

diff --git a/kernel/softirq.c b/kernel/softirq.c
index 09229ad..617009c 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -92,6 +92,13 @@ static bool ksoftirqd_running(unsigned long pending)
 		!__kthread_should_park(tsk);
 }
 
+#ifdef CONFIG_TRACE_IRQFLAGS
+DEFINE_PER_CPU(int, hardirqs_enabled);
+DEFINE_PER_CPU(int, hardirq_context);
+EXPORT_PER_CPU_SYMBOL_GPL(hardirqs_enabled);
+EXPORT_PER_CPU_SYMBOL_GPL(hardirq_context);
+#endif
+
 /*
  * preempt_count and SOFTIRQ_OFFSET usage:
  * - preempt_count is changed by SOFTIRQ_OFFSET on entering or leaving
@@ -102,17 +109,11 @@ static bool ksoftirqd_running(unsigned long pending)
  * softirq and whether we just have bh disabled.
  */
 
+#ifdef CONFIG_TRACE_IRQFLAGS
 /*
- * This one is for softirq.c-internal use,
- * where hardirqs are disabled legitimately:
+ * This is for softirq.c-internal use, where hardirqs are disabled
+ * legitimately:
  */
-#ifdef CONFIG_TRACE_IRQFLAGS
-
-DEFINE_PER_CPU(int, hardirqs_enabled);
-DEFINE_PER_CPU(int, hardirq_context);
-EXPORT_PER_CPU_SYMBOL_GPL(hardirqs_enabled);
-EXPORT_PER_CPU_SYMBOL_GPL(hardirq_context);
-
 void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 {
 	unsigned long flags;
@@ -203,6 +204,50 @@ void __local_bh_enable_ip(unsigned long ip, unsigned int cnt)
 }
 EXPORT_SYMBOL(__local_bh_enable_ip);
 
+static inline void invoke_softirq(void)
+{
+	if (ksoftirqd_running(local_softirq_pending()))
+		return;
+
+	if (!force_irqthreads) {
+#ifdef CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
+		/*
+		 * We can safely execute softirq on the current stack if
+		 * it is the irq stack, because it should be near empty
+		 * at this stage.
+		 */
+		__do_softirq();
+#else
+		/*
+		 * Otherwise, irq_exit() is called on the task stack that can
+		 * be potentially deep already. So call softirq in its own stack
+		 * to prevent from any overrun.
+		 */
+		do_softirq_own_stack();
+#endif
+	} else {
+		wakeup_softirqd();
+	}
+}
+
+asmlinkage __visible void do_softirq(void)
+{
+	__u32 pending;
+	unsigned long flags;
+
+	if (in_interrupt())
+		return;
+
+	local_irq_save(flags);
+
+	pending = local_softirq_pending();
+
+	if (pending && !ksoftirqd_running(pending))
+		do_softirq_own_stack();
+
+	local_irq_restore(flags);
+}
+
 /*
  * We restart softirq processing for at most MAX_SOFTIRQ_RESTART times,
  * but break the loop if need_resched() is set or after 2 ms.
@@ -327,24 +372,6 @@ restart:
 	current_restore_flags(old_flags, PF_MEMALLOC);
 }
 
-asmlinkage __visible void do_softirq(void)
-{
-	__u32 pending;
-	unsigned long flags;
-
-	if (in_interrupt())
-		return;
-
-	local_irq_save(flags);
-
-	pending = local_softirq_pending();
-
-	if (pending && !ksoftirqd_running(pending))
-		do_softirq_own_stack();
-
-	local_irq_restore(flags);
-}
-
 /**
  * irq_enter_rcu - Enter an interrupt context with RCU watching
  */
@@ -371,32 +398,6 @@ void irq_enter(void)
 	irq_enter_rcu();
 }
 
-static inline void invoke_softirq(void)
-{
-	if (ksoftirqd_running(local_softirq_pending()))
-		return;
-
-	if (!force_irqthreads) {
-#ifdef CONFIG_HAVE_IRQ_EXIT_ON_IRQ_STACK
-		/*
-		 * We can safely execute softirq on the current stack if
-		 * it is the irq stack, because it should be near empty
-		 * at this stage.
-		 */
-		__do_softirq();
-#else
-		/*
-		 * Otherwise, irq_exit() is called on the task stack that can
-		 * be potentially deep already. So call softirq in its own stack
-		 * to prevent from any overrun.
-		 */
-		do_softirq_own_stack();
-#endif
-	} else {
-		wakeup_softirqd();
-	}
-}
-
 static inline void tick_irq_exit(void)
 {
 #ifdef CONFIG_NO_HZ_COMMON
