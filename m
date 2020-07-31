Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4365D2342C9
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Jul 2020 11:26:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732453AbgGaJX0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 31 Jul 2020 05:23:26 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56564 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732436AbgGaJXZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:25 -0400
Date:   Fri, 31 Jul 2020 09:23:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187401;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AJ58IX3hhsW8bHAC1dgq66SbGSuuZZrS1WOYAxblIvc=;
        b=L0Rvyuzf63RIJ4Uz63aXfdxyyo7Gfd2c6Zphlyg8K98uiImkkIoPk5xKRrBZrt1T4HsRYZ
        CQZ82UWbU6AdspmLv1nmZxT6g8VGfoZEuSWQpXW6DCtnpKIoIsLRZKRQE/1t/F5PzdbMHT
        JFKeH6U1hNhWloWi31VHcyxZ1cbr8eVX8bZX06Z/mOM2Bi04Tj68G55kRogQvcyABm/6Sm
        riK2BRgcGDWOr4jks9yatoGYese95Nl2ba+9BnfcTVW9KJ2uvftNXtWfoLu6dwuhkkZsJU
        SQ5At2pEiKphwXGwlySCHGKf0Edxu+BaxcMSamOl2o/LKyS2DzlSHNksg7Irlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187401;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=AJ58IX3hhsW8bHAC1dgq66SbGSuuZZrS1WOYAxblIvc=;
        b=wnDhXcRmAxZ2CO3Mtygm4B9uCNqubj/vqZO4MvMtEbo4fxaTTwJBqYIWO9tJYyjMxG3TzI
        xXd3/tZomr2uiUBw==
From:   "tip-bot2 for Uladzislau Rezki (Sony)" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu/tree: Move kfree_rcu_cpu locking/unlocking to
 separate functions
Cc:     "Joel Fernandes (Google)" <joel@joelfernandes.org>,
        "Uladzislau Rezki (Sony)" <urezki@gmail.com>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618740119.4006.10910421165716608351.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     952371d6fc0bc360d1d5780f86bb355836117ca2
Gitweb:        https://git.kernel.org/tip/952371d6fc0bc360d1d5780f86bb355836117ca2
Author:        Uladzislau Rezki (Sony) <urezki@gmail.com>
AuthorDate:    Mon, 25 May 2020 23:47:50 +02:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:59:25 -07:00

rcu/tree: Move kfree_rcu_cpu locking/unlocking to separate functions

Introduce helpers to lock and unlock per-cpu "kfree_rcu_cpu"
structures. That will make kfree_call_rcu() more readable
and prevent programming errors.

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>
Signed-off-by: Uladzislau Rezki (Sony) <urezki@gmail.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index bcdc063..368bdc4 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3035,6 +3035,27 @@ debug_rcu_bhead_unqueue(struct kfree_rcu_bulk_data *bhead)
 #endif
 }
 
+static inline struct kfree_rcu_cpu *
+krc_this_cpu_lock(unsigned long *flags)
+{
+	struct kfree_rcu_cpu *krcp;
+
+	local_irq_save(*flags);	// For safely calling this_cpu_ptr().
+	krcp = this_cpu_ptr(&krc);
+	if (likely(krcp->initialized))
+		raw_spin_lock(&krcp->lock);
+
+	return krcp;
+}
+
+static inline void
+krc_this_cpu_unlock(struct kfree_rcu_cpu *krcp, unsigned long flags)
+{
+	if (likely(krcp->initialized))
+		raw_spin_unlock(&krcp->lock);
+	local_irq_restore(flags);
+}
+
 /*
  * This function is invoked in workqueue context after a grace period.
  * It frees all the objects queued on ->bhead_free or ->head_free.
@@ -3260,11 +3281,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	struct kfree_rcu_cpu *krcp;
 	void *ptr;
 
-	local_irq_save(flags);	// For safely calling this_cpu_ptr().
-	krcp = this_cpu_ptr(&krc);
-	if (krcp->initialized)
-		raw_spin_lock(&krcp->lock);
-
+	krcp = krc_this_cpu_lock(&flags);
 	ptr = (void *)head - (unsigned long)func;
 
 	// Queue the object but don't yet schedule the batch.
@@ -3295,9 +3312,7 @@ void kfree_call_rcu(struct rcu_head *head, rcu_callback_t func)
 	}
 
 unlock_return:
-	if (krcp->initialized)
-		raw_spin_unlock(&krcp->lock);
-	local_irq_restore(flags);
+	krc_this_cpu_unlock(krcp, flags);
 }
 EXPORT_SYMBOL_GPL(kfree_call_rcu);
 
