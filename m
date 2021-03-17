Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95B5933F46B
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 16:50:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbhCQPt3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 11:49:29 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51114 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232412AbhCQPs7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 11:48:59 -0400
Date:   Wed, 17 Mar 2021 15:48:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615996138;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cf0TazeKMrNvvMYqp9qJHNgMq2xopwDOqiuLTbLkNOk=;
        b=Un0R9U3rvLNqDA+biCXOm5t1kAvb252RsAWhFZOqW4CZnrzPXZfJ+30dnYPGcymydi5o/o
        29hZJWwt9mgximw8Km+skM54SQYesUDrju1Ec9+P2mOsTVwydT+5keUPPYT/ldy7ngI2qb
        TN1GMrPcskF4I3fx/+IGDtWW5gCstlqj+wBsS9M/6KyyYwNKEOutjbTzQp/oXeLwi2r1DM
        l5t9FtS1HYNdEj5X/NhVL2QB8MFZMNJmnI8dosGkyT34fxAU7KR0+JrnGbYgMMIbD1//Li
        bFOOHd9phLtHtJl9zZCkru2vbagXcd7nU2cW4qIEqnmCpiTBLti03Z7sJlIrtQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615996138;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cf0TazeKMrNvvMYqp9qJHNgMq2xopwDOqiuLTbLkNOk=;
        b=397ZrgztY+mzF9un8Hlh8JYBq4ft3Fmg5m7JtdcKYakQ4gRP5lwUFXuT14uit5jPSSAn4K
        aiq9nFtWXY1P3gCg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] tasklets: Prevent tasklet_unlock_spin_wait() deadlock on RT
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210309084241.988908275@linutronix.de>
References: <20210309084241.988908275@linutronix.de>
MIME-Version: 1.0
Message-ID: <161599613786.398.9919522041439176909.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     eb2dafbba8b824ee77f166629babd470dd0b1c0a
Gitweb:        https://git.kernel.org/tip/eb2dafbba8b824ee77f166629babd470dd0b1c0a
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Tue, 09 Mar 2021 09:42:10 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 17 Mar 2021 16:33:57 +01:00

tasklets: Prevent tasklet_unlock_spin_wait() deadlock on RT

tasklet_unlock_spin_wait() spin waits for the TASKLET_STATE_SCHED bit in
the tasklet state to be cleared. This works on !RT nicely because the
corresponding execution can only happen on a different CPU.

On RT softirq processing is preemptible, therefore a task preempting the
softirq processing thread can spin forever.

Prevent this by invoking local_bh_disable()/enable() inside the loop. In
case that the softirq processing thread was preempted by the current task,
current will block on the local lock which yields the CPU to the preempted
softirq processing thread. If the tasklet is processed on a different CPU
then the local_bh_disable()/enable() pair is just a waste of processor
cycles.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210309084241.988908275@linutronix.de

---
 include/linux/interrupt.h | 12 ++----------
 kernel/softirq.c          | 28 +++++++++++++++++++++++++++-
 2 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index b50be4f..352db93 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -658,7 +658,7 @@ enum
 	TASKLET_STATE_RUN	/* Tasklet is running (SMP only) */
 };
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
 static inline int tasklet_trylock(struct tasklet_struct *t)
 {
 	return !test_and_set_bit(TASKLET_STATE_RUN, &(t)->state);
@@ -666,16 +666,8 @@ static inline int tasklet_trylock(struct tasklet_struct *t)
 
 void tasklet_unlock(struct tasklet_struct *t);
 void tasklet_unlock_wait(struct tasklet_struct *t);
+void tasklet_unlock_spin_wait(struct tasklet_struct *t);
 
-/*
- * Do not use in new code. Waiting for tasklets from atomic contexts is
- * error prone and should be avoided.
- */
-static inline void tasklet_unlock_spin_wait(struct tasklet_struct *t)
-{
-	while (test_bit(TASKLET_STATE_RUN, &t->state))
-		cpu_relax();
-}
 #else
 static inline int tasklet_trylock(struct tasklet_struct *t) { return 1; }
 static inline void tasklet_unlock(struct tasklet_struct *t) { }
diff --git a/kernel/softirq.c b/kernel/softirq.c
index ba89ca7..f1eb83d 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -620,6 +620,32 @@ void tasklet_init(struct tasklet_struct *t,
 }
 EXPORT_SYMBOL(tasklet_init);
 
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
+/*
+ * Do not use in new code. Waiting for tasklets from atomic contexts is
+ * error prone and should be avoided.
+ */
+void tasklet_unlock_spin_wait(struct tasklet_struct *t)
+{
+	while (test_bit(TASKLET_STATE_RUN, &(t)->state)) {
+		if (IS_ENABLED(CONFIG_PREEMPT_RT)) {
+			/*
+			 * Prevent a live lock when current preempted soft
+			 * interrupt processing or prevents ksoftirqd from
+			 * running. If the tasklet runs on a different CPU
+			 * then this has no effect other than doing the BH
+			 * disable/enable dance for nothing.
+			 */
+			local_bh_disable();
+			local_bh_enable();
+		} else {
+			cpu_relax();
+		}
+	}
+}
+EXPORT_SYMBOL(tasklet_unlock_spin_wait);
+#endif
+
 void tasklet_kill(struct tasklet_struct *t)
 {
 	if (in_interrupt())
@@ -633,7 +659,7 @@ void tasklet_kill(struct tasklet_struct *t)
 }
 EXPORT_SYMBOL(tasklet_kill);
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
 void tasklet_unlock(struct tasklet_struct *t)
 {
 	smp_mb__before_atomic();
