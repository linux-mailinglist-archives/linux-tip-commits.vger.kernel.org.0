Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B89B23B8388
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:47:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235328AbhF3Nt7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:49:59 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32818 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235184AbhF3Ntz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:49:55 -0400
Date:   Wed, 30 Jun 2021 13:47:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060845;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=s+VvoYGN7rs2UVglpwQpVdDpysHgzwD2sU9IbE6oAUs=;
        b=lDigmOvypFZDGUp2mQ9L+T5ErxSkCoDz6dgehbp3GBiCLfWBYsvIr9OFZs5N/Z16Ahw/5X
        jzcABox9mrv0s4LHwhAjDXcVY2aq3HuKF1fUwgdC8zMaltvBoMyDCRyr1ub7qRu4pMunqB
        iR6thilqjldNBCV85USh2nqURYyVeOdyBn9wBBIqQT4TsCegBeipsdyDXD//3MoVrkLztG
        mUmLo9YD+48KqUU+GJIqsVyGEsI5fHtwWA9+Ysk5ys0TD1StifStcEv6gnT4e6v00li8TU
        rTocjEKBhkDYagZlAarJIJkRhLm9klK4Kb2VraGhK9DEuO120QwmRFF6bMM9rg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060845;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=s+VvoYGN7rs2UVglpwQpVdDpysHgzwD2sU9IbE6oAUs=;
        b=W2LnwQsDlGtBr+YfI639PamFrQjCT/87tNQXMWEEkmnvQS9PmAUScm0liaAxxaeqMIVHnj
        pS7vVM+to2B382AQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Remove obsolete rcu_read_unlock() deadlock commentary
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506084486.395.2550238348410539595.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     0223846010750e28e4330f1beefb5564ba406ef7
Gitweb:        https://git.kernel.org/tip/0223846010750e28e4330f1beefb5564ba406ef7
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 29 Apr 2021 11:30:49 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 13 May 2021 09:13:23 -07:00

rcu: Remove obsolete rcu_read_unlock() deadlock commentary

The deferred quiescent states resulting from the consolidation of RCU-bh
and RCU-sched into RCU means that rcu_read_unlock() will no longer attempt
to acquire scheduler locks if interrupts were disabled across that call
to rcu_read_unlock().  The cautions in the rcu_read_unlock() header
comment are therefore obsolete.  This commit therefore removes them.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/rcupdate.h | 33 ++++++---------------------------
 1 file changed, 6 insertions(+), 27 deletions(-)

diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index f0eecb9..d9680b7 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -702,33 +702,12 @@ static __always_inline void rcu_read_lock(void)
 /**
  * rcu_read_unlock() - marks the end of an RCU read-side critical section.
  *
- * In most situations, rcu_read_unlock() is immune from deadlock.
- * However, in kernels built with CONFIG_RCU_BOOST, rcu_read_unlock()
- * is responsible for deboosting, which it does via rt_mutex_unlock().
- * Unfortunately, this function acquires the scheduler's runqueue and
- * priority-inheritance spinlocks.  This means that deadlock could result
- * if the caller of rcu_read_unlock() already holds one of these locks or
- * any lock that is ever acquired while holding them.
- *
- * That said, RCU readers are never priority boosted unless they were
- * preempted.  Therefore, one way to avoid deadlock is to make sure
- * that preemption never happens within any RCU read-side critical
- * section whose outermost rcu_read_unlock() is called with one of
- * rt_mutex_unlock()'s locks held.  Such preemption can be avoided in
- * a number of ways, for example, by invoking preempt_disable() before
- * critical section's outermost rcu_read_lock().
- *
- * Given that the set of locks acquired by rt_mutex_unlock() might change
- * at any time, a somewhat more future-proofed approach is to make sure
- * that that preemption never happens within any RCU read-side critical
- * section whose outermost rcu_read_unlock() is called with irqs disabled.
- * This approach relies on the fact that rt_mutex_unlock() currently only
- * acquires irq-disabled locks.
- *
- * The second of these two approaches is best in most situations,
- * however, the first approach can also be useful, at least to those
- * developers willing to keep abreast of the set of locks acquired by
- * rt_mutex_unlock().
+ * In almost all situations, rcu_read_unlock() is immune from deadlock.
+ * In recent kernels that have consolidated synchronize_sched() and
+ * synchronize_rcu_bh() into synchronize_rcu(), this deadlock immunity
+ * also extends to the scheduler's runqueue and priority-inheritance
+ * spinlocks, courtesy of the quiescent-state deferral that is carried
+ * out when rcu_read_unlock() is invoked with interrupts disabled.
  *
  * See rcu_read_lock() for more information.
  */
