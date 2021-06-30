Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA8123B83A0
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:47:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235722AbhF3NuS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:18 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32944 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235173AbhF3NuB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:01 -0400
Date:   Wed, 30 Jun 2021 13:47:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060851;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BXDIneO4GKdkO6nR8USbznamNP6X8S2alKXp4AfNOxw=;
        b=e7XKt78HX9JygQwnzR+LdZDwGiWeE7qqaD0CVHcBqZM5sSf5ZuSdpZFsi8JO4T0zKeMvrx
        ORuLHrmfsLLs7tKkB41LGqjSrRtGl4Bxw72ALOpbVnUXHLNVLiBLF5Qwu22dID2U8h6eu+
        cbszfdr1+ybGiUBzILREostrQKdfA3/UTyOoqfq6vAUj1pRXP4G4jgijowmH8+mQDzbkjd
        PWiaq+0TYPbUjqF8F2b4U5++RfIo1DCq/kmFrsgW+SQ83lcj/pmDZNm37fkW136w3tzGSW
        DAfWT064ZTbklb9lCZsndXC4zMidalRrEqJcbJU3mWfUYYIW+1gUY8jcu0V8MQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060851;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=BXDIneO4GKdkO6nR8USbznamNP6X8S2alKXp4AfNOxw=;
        b=+d4VYpOUDpdZxRM4fgU6bKy83swRYGUhanPZ/unkiYQDfRCN7dZI3Qt4glaWRA10EbVf0h
        u+sDCsdGmqMygDAw==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Don't penalize priority boosting when there is
 nothing to boost
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506085111.395.14803599676674863889.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     5390473ec1697b71af0e9d63ef7aaa7ecd27e2c9
Gitweb:        https://git.kernel.org/tip/5390473ec1697b71af0e9d63ef7aaa7ecd27e2c9
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Thu, 15 Apr 2021 16:30:34 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:44:11 -07:00

rcu: Don't penalize priority boosting when there is nothing to boost

RCU priority boosting cannot do anything unless there is at least one
task blocking the current RCU grace period that was preempted within
the RCU read-side critical section that it still resides in.  However,
the current rcu_torture_boost_failed() code will count this as an RCU
priority-boosting failure if there were no CPUs blocking the current
grace period.  This situation can happen (for example) if the last CPU
blocking the current grace period was subjected to vCPU preemption,
which is always a risk for rcutorture guest OSes.

This commit therefore causes rcu_torture_boost_failed() to refrain from
reporting failure unless there is at least one task blocking the current
RCU grace period that was preempted within the RCU read-side critical
section that it still resides in.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree_stall.h | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 8bde1b5..6530251 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -723,6 +723,10 @@ static void check_cpu_stall(struct rcu_data *rdp)
  * count this as an RCU priority boosting failure.  A return of true says
  * RCU priority boosting is to blame, and false says otherwise.  If false
  * is returned, the first of the CPUs to blame is stored through cpup.
+ * If there was no CPU blocking the current grace period, but also nothing
+ * in need of being boosted, *cpup is set to -1.  This can happen in case
+ * of vCPU preemption while the last CPU is reporting its quiscent state,
+ * for example.
  *
  * If cpup is NULL, then a lockless quick check is carried out, suitable
  * for high-rate usage.  On the other hand, if cpup is non-NULL, each
@@ -730,18 +734,25 @@ static void check_cpu_stall(struct rcu_data *rdp)
  */
 bool rcu_check_boost_fail(unsigned long gp_state, int *cpup)
 {
+	bool atb = false;
 	int cpu;
 	unsigned long flags;
 	struct rcu_node *rnp;
 
 	rcu_for_each_leaf_node(rnp) {
 		if (!cpup) {
-			if (READ_ONCE(rnp->qsmask))
+			if (READ_ONCE(rnp->qsmask)) {
 				return false;
-			else
+			} else {
+				if (READ_ONCE(rnp->gp_tasks))
+					atb = true;
 				continue;
+			}
 		}
+		*cpup = -1;
 		raw_spin_lock_irqsave_rcu_node(rnp, flags);
+		if (rnp->gp_tasks)
+			atb = true;
 		if (!rnp->qsmask) {
 			// No CPUs without quiescent states for this rnp.
 			raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
@@ -758,7 +769,7 @@ bool rcu_check_boost_fail(unsigned long gp_state, int *cpup)
 		raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	}
 	// Can't blame CPUs, so must blame RCU priority boosting.
-	return true;
+	return atb;
 }
 EXPORT_SYMBOL_GPL(rcu_check_boost_fail);
 
