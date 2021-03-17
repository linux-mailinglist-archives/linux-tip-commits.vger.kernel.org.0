Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6881833F459
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 16:50:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232049AbhCQPtT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 11:49:19 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51072 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232265AbhCQPsz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 11:48:55 -0400
Date:   Wed, 17 Mar 2021 15:48:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615996133;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cQDSZLWqWdUFj+WdpKioQTWdZyy8R5Kg6Q9wp1gj5Qc=;
        b=cb6DsWaYCn/VKWIYS+Rd4cVJalKD8vj6ITFkF0eLStVKrvcASTO4R8ZCtwkg3bYToshFrS
        oIyI5l3J6vxX9b4yJLfPkwujI6vLBYb8STInmek7MHYIdy8dAQXCwy65UPPH0+gTZGQQss
        tHrVwfBKc8yUC3RlkCOAbwN3XzjLZfyi+ZOC7xNhbaRbSDULJZm3bqLyaKPbb1qzp6umJC
        HVo707gcBjJp/uDpD2cK/6/xCT/uKY41Va0Gv10eTWSw9Hr1dAuqcGvdFF4gvMhI878Rgh
        Gdj04ZkMhPLMWewRIW/OOvN8Nzbg3fenr+VtI/yEkfOqORXerlQ9aH9ai7KDYA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615996133;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cQDSZLWqWdUFj+WdpKioQTWdZyy8R5Kg6Q9wp1gj5Qc=;
        b=SgMyFK2qCi68NNxrvuJxFlJe6GDsrdj6xXpbOoTCRd4N3waeYeOrb7cHfx4t08NHd0mxTH
        1jNf39vQnk7w3qCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] tick/sched: Prevent false positive softirq pending
 warnings on RT
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210309085727.527563866@linutronix.de>
References: <20210309085727.527563866@linutronix.de>
MIME-Version: 1.0
Message-ID: <161599613319.398.6653530091182078355.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     47c218dcae6587fb5bce30f1656b13e22391c8e3
Gitweb:        https://git.kernel.org/tip/47c218dcae6587fb5bce30f1656b13e22391c8e3
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 09 Mar 2021 09:55:57 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 17 Mar 2021 16:34:11 +01:00

tick/sched: Prevent false positive softirq pending warnings on RT

On RT a task which has soft interrupts disabled can block on a lock and
schedule out to idle while soft interrupts are pending. This triggers the
warning in the NOHZ idle code which complains about going idle with pending
soft interrupts. But as the task is blocked soft interrupt processing is
temporarily blocked as well which means that such a warning is a false
positive.

To prevent that check the per CPU state which indicates that a scheduled
out task has soft interrupts disabled.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210309085727.527563866@linutronix.de

---
 include/linux/bottom_half.h |  6 ++++++
 kernel/softirq.c            | 15 +++++++++++++++
 kernel/time/tick-sched.c    |  2 +-
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/linux/bottom_half.h b/include/linux/bottom_half.h
index e4dd613..eed86eb 100644
--- a/include/linux/bottom_half.h
+++ b/include/linux/bottom_half.h
@@ -32,4 +32,10 @@ static inline void local_bh_enable(void)
 	__local_bh_enable_ip(_THIS_IP_, SOFTIRQ_DISABLE_OFFSET);
 }
 
+#ifdef CONFIG_PREEMPT_RT
+extern bool local_bh_blocked(void);
+#else
+static inline bool local_bh_blocked(void) { return false; }
+#endif
+
 #endif /* _LINUX_BH_H */
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 1ed1c55..5a99696 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -141,6 +141,21 @@ static DEFINE_PER_CPU(struct softirq_ctrl, softirq_ctrl) = {
 	.lock	= INIT_LOCAL_LOCK(softirq_ctrl.lock),
 };
 
+/**
+ * local_bh_blocked() - Check for idle whether BH processing is blocked
+ *
+ * Returns false if the per CPU softirq::cnt is 0 otherwise true.
+ *
+ * This is invoked from the idle task to guard against false positive
+ * softirq pending warnings, which would happen when the task which holds
+ * softirq_ctrl::lock was the only running task on the CPU and blocks on
+ * some other lock.
+ */
+bool local_bh_blocked(void)
+{
+	return __this_cpu_read(softirq_ctrl.cnt) != 0;
+}
+
 void __local_bh_disable_ip(unsigned long ip, unsigned int cnt)
 {
 	unsigned long flags;
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index e10a4af..0cc5579 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -973,7 +973,7 @@ static bool can_stop_idle_tick(int cpu, struct tick_sched *ts)
 	if (unlikely(local_softirq_pending())) {
 		static int ratelimit;
 
-		if (ratelimit < 10 &&
+		if (ratelimit < 10 && !local_bh_blocked() &&
 		    (local_softirq_pending() & SOFTIRQ_STOP_IDLE_MASK)) {
 			pr_warn("NOHZ tick-stop error: Non-RCU local softirq work is pending, handler #%02x!!!\n",
 				(unsigned int) local_softirq_pending());
