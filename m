Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11A4933F470
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 16:50:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232565AbhCQPtd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 11:49:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51128 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbhCQPtA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 11:49:00 -0400
Date:   Wed, 17 Mar 2021 15:48:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615996139;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WcC1O/s/j2KwnL6z0XtKSgPHFzlNuzxVngxmaCSL3hY=;
        b=WBpeagyEfoLdjo78HokyeVVgPrwfXM4kHgPj5AKW0cGHIV0F0fvAGG+EC5tR6/7eAX7vZB
        VmXROhZp7bQp5Q/Au3EpD7VYYf1YWE9j1TNrQsrCZkT/hXliRyolMRLVGOtPtV4F0lRukG
        UhlaOp/ByF5UuvnZc9WrPkp2lUhDk3m/oEG0XnF1UEuRTeqqMzWQ0aZOyAKiVcN10a5Big
        xqkjqxrvAX6HdE1eFlZbV9R9DhjovuoHAYhEU8Z0d7uuyTEyrhPpHzqFtvg+2jcZ+21Um2
        Cfx20yOf2qXhTRrPpw6nQCwUVeJWfOcPP3gHx7k+0gd4ShDNy5aDNWKyyRn7DQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615996139;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WcC1O/s/j2KwnL6z0XtKSgPHFzlNuzxVngxmaCSL3hY=;
        b=avca8bHwx2JmTL7IVN+eJtkk6H1zPMBkPvfdqCCmX7orIR4d4t2oBpGn+55CYgbvNBuchF
        Zfl6Hb2MTqvC0IBg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] tasklets: Replace spin wait in tasklet_unlock_wait()
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210309084241.783936921@linutronix.de>
References: <20210309084241.783936921@linutronix.de>
MIME-Version: 1.0
Message-ID: <161599613857.398.7497802846088511497.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     da044747401fc16202e223c9da970ed4e84fd84d
Gitweb:        https://git.kernel.org/tip/da044747401fc16202e223c9da970ed4e84fd84d
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 09 Mar 2021 09:42:08 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 17 Mar 2021 16:33:55 +01:00

tasklets: Replace spin wait in tasklet_unlock_wait()

tasklet_unlock_wait() spin waits for TASKLET_STATE_RUN to be cleared. This
is wasting CPU cycles in a tight loop which is especially painful in a
guest when the CPU running the tasklet is scheduled out.

tasklet_unlock_wait() is invoked from tasklet_kill() which is used in
teardown paths and not performance critical at all. Replace the spin wait
with wait_var_event().

There are no users of tasklet_unlock_wait() which are invoked from atomic
contexts. The usage in tasklet_disable() has been replaced temporarily with
the spin waiting variant until the atomic users are fixed up and will be
converted to the sleep wait variant later.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210309084241.783936921@linutronix.de

---
 include/linux/interrupt.h | 13 ++-----------
 kernel/softirq.c          | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index b7f0012..b50be4f 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -664,17 +664,8 @@ static inline int tasklet_trylock(struct tasklet_struct *t)
 	return !test_and_set_bit(TASKLET_STATE_RUN, &(t)->state);
 }
 
-static inline void tasklet_unlock(struct tasklet_struct *t)
-{
-	smp_mb__before_atomic();
-	clear_bit(TASKLET_STATE_RUN, &(t)->state);
-}
-
-static inline void tasklet_unlock_wait(struct tasklet_struct *t)
-{
-	while (test_bit(TASKLET_STATE_RUN, &t->state))
-		cpu_relax();
-}
+void tasklet_unlock(struct tasklet_struct *t);
+void tasklet_unlock_wait(struct tasklet_struct *t);
 
 /*
  * Do not use in new code. Waiting for tasklets from atomic contexts is
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 8d56bbf..ef6429a 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -25,6 +25,7 @@
 #include <linux/smpboot.h>
 #include <linux/tick.h>
 #include <linux/irq.h>
+#include <linux/wait_bit.h>
 
 #include <asm/softirq_stack.h>
 
@@ -632,6 +633,23 @@ void tasklet_kill(struct tasklet_struct *t)
 }
 EXPORT_SYMBOL(tasklet_kill);
 
+#ifdef CONFIG_SMP
+void tasklet_unlock(struct tasklet_struct *t)
+{
+	smp_mb__before_atomic();
+	clear_bit(TASKLET_STATE_RUN, &t->state);
+	smp_mb__after_atomic();
+	wake_up_var(&t->state);
+}
+EXPORT_SYMBOL_GPL(tasklet_unlock);
+
+void tasklet_unlock_wait(struct tasklet_struct *t)
+{
+	wait_var_event(&t->state, !test_bit(TASKLET_STATE_RUN, &t->state));
+}
+EXPORT_SYMBOL_GPL(tasklet_unlock_wait);
+#endif
+
 void __init softirq_init(void)
 {
 	int cpu;
