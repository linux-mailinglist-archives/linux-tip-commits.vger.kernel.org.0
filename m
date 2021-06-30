Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 019D33B83B1
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbhF3Nue (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33020 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235565AbhF3NuI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:08 -0400
Date:   Wed, 30 Jun 2021 13:47:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060858;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=6YiS1pulqScNuPZKDXVSPn3BBlzKcdZshBdNz9hWAAg=;
        b=CHA5KkebHJ2BZKywR/2guxsM66f1VdbhFXQUEE6VicBJ+dOVuocN7r9/VBWVZVG81Q5Gh+
        ucMbwrYZ9O9AWhTnQ6ZlqenUV/eEFayodcLRFZPVCydS+zUdMfojjp/5QCNNn7ixhh7zpi
        DQx9mlCaGvLO/BZ2o7/3gHb7lesbz4EvAvb4RMJinSHTHpdoAEh6DrjMW80Z0N7ZRJqmaI
        yosRk9EDdL+7w9umLL58tMDqIaQ9iFKAIIIZaL6q6SW/w7WphwXZSg2W4QKhK1WhoaG9uW
        zCguBe8IcEU6i3Rc5VqdHCHvr+XvYiijEL/hqY4xBNuZ7Twk+a+TBGf38D7eLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060858;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=6YiS1pulqScNuPZKDXVSPn3BBlzKcdZshBdNz9hWAAg=;
        b=32HhjTwTumtslUvsJbVuyl2rhdC0LA0L5zX4+zZwXA7rFBbeBZajM9FghTpjzBz9OvGNFD
        gsE7mnG2vrpQU8Cg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Remove the unused rcu_irq_exit_preempt() function
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506085799.395.6842149329962326753.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     ce7c169dee28866539abb0e603b9a23055d30fdc
Gitweb:        https://git.kernel.org/tip/ce7c169dee28866539abb0e603b9a23055d30fdc
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 30 Mar 2021 13:23:49 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:22:53 -07:00

rcu: Remove the unused rcu_irq_exit_preempt() function

Commit 9ee01e0f69a9 ("x86/entry: Clean up idtentry_enter/exit()
leftovers") left the rcu_irq_exit_preempt() in place in order to avoid
conflicts with the -rcu tree.  Now that this change has long since hit
mainline, this commit removes the no-longer-used rcu_irq_exit_preempt()
function.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcutiny.h |  1 -
 include/linux/rcutree.h |  1 -
 kernel/rcu/tree.c       | 22 ----------------------
 3 files changed, 24 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 35e0be3..953e70f 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -86,7 +86,6 @@ static inline void rcu_irq_enter(void) { }
 static inline void rcu_irq_exit_irqson(void) { }
 static inline void rcu_irq_enter_irqson(void) { }
 static inline void rcu_irq_exit(void) { }
-static inline void rcu_irq_exit_preempt(void) { }
 static inline void rcu_irq_exit_check_preempt(void) { }
 #define rcu_is_idle_cpu(cpu) \
 	(is_idle_task(current) && !in_nmi() && !in_irq() && !in_serving_softirq())
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index b89b541..53209d6 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -49,7 +49,6 @@ void rcu_idle_enter(void);
 void rcu_idle_exit(void);
 void rcu_irq_enter(void);
 void rcu_irq_exit(void);
-void rcu_irq_exit_preempt(void);
 void rcu_irq_enter_irqson(void);
 void rcu_irq_exit_irqson(void);
 bool rcu_is_idle_cpu(int cpu);
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8e78b24..f6543b8 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -833,28 +833,6 @@ void noinstr rcu_irq_exit(void)
 	rcu_nmi_exit();
 }
 
-/**
- * rcu_irq_exit_preempt - Inform RCU that current CPU is exiting irq
- *			  towards in kernel preemption
- *
- * Same as rcu_irq_exit() but has a sanity check that scheduling is safe
- * from RCU point of view. Invoked from return from interrupt before kernel
- * preemption.
- */
-void rcu_irq_exit_preempt(void)
-{
-	lockdep_assert_irqs_disabled();
-	rcu_nmi_exit();
-
-	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nesting) <= 0,
-			 "RCU dynticks_nesting counter underflow/zero!");
-	RCU_LOCKDEP_WARN(__this_cpu_read(rcu_data.dynticks_nmi_nesting) !=
-			 DYNTICK_IRQ_NONIDLE,
-			 "Bad RCU  dynticks_nmi_nesting counter\n");
-	RCU_LOCKDEP_WARN(rcu_dynticks_curr_cpu_in_eqs(),
-			 "RCU in extended quiescent state!");
-}
-
 #ifdef CONFIG_PROVE_RCU
 /**
  * rcu_irq_exit_check_preempt - Validate that scheduling is possible
