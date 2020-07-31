Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8446234288
	for <lists+linux-tip-commits@lfdr.de>; Fri, 31 Jul 2020 11:23:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732535AbgGaJXl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 31 Jul 2020 05:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732531AbgGaJXl (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 31 Jul 2020 05:23:41 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF588C061574;
        Fri, 31 Jul 2020 02:23:40 -0700 (PDT)
Date:   Fri, 31 Jul 2020 09:23:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596187419;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ktW1NdahrsP2yDDdBeC4g8Lm5qa2r8qdf0PxaMx8dEA=;
        b=c57NNWtv5UidQ2q52XIW5hdEm0LGOmLblWBElQMBg4z/pSHkIhs0S/bntkszjKOj2QUKk5
        pKE0ZLB4xiKCsxevT4p7K5P8M60pMsh3Bpz28pTH8y86DIGPjWudW9F+9ohmBMWGN0TOym
        VqaxAb6p5jsqVoqfGgQ92t+o8yCEWRXMNWLdomw4RBMaIgSM/WBkcGZIiGgONbZ/sWy5AH
        +dOxEhcrF27QtAVKhozoaBDzoH0BtWYc5+rOMxuos7MlmTQn9EdZsmVdwZNDRBtXu5R9NU
        alFPKZBhjrMvhuTsOGN89/bRTUbjKO4Dyxv8dHCFo9bezLod/HeO/p85Zo5vXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596187419;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=ktW1NdahrsP2yDDdBeC4g8Lm5qa2r8qdf0PxaMx8dEA=;
        b=RaIMQL9UxKREf7v1ofJZJqNnzXMD1wh4Me1BFT/3y5UrARRNvN1EKE8lkTAClx4oxElR81
        wJ0FhXAGkey7q9Bg==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add callbacks-invoked counters
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <159618741860.4006.11167008197606572915.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     e816d56fad57ba9817cef6606b12f5e14647c3bf
Gitweb:        https://git.kernel.org/tip/e816d56fad57ba9817cef6606b12f5e14647c3bf
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Fri, 01 May 2020 16:49:48 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 29 Jun 2020 11:58:49 -07:00

rcu: Add callbacks-invoked counters

This commit adds a count of the callbacks invoked to the per-CPU rcu_data
structure.  This count is printed by the show_rcu_gp_kthreads() that
is invoked by rcutorture and the RCU CPU stall-warning code.  It is also
intended for use by drgn.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c       | 1 +
 kernel/rcu/tree.h       | 1 +
 kernel/rcu/tree_stall.h | 3 +++
 3 files changed, 5 insertions(+)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index bef1dc9..874c831 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2443,6 +2443,7 @@ static void rcu_do_batch(struct rcu_data *rdp)
 	local_irq_save(flags);
 	rcu_nocb_lock(rdp);
 	count = -rcl.len;
+	rdp->n_cbs_invoked += count;
 	trace_rcu_batch_end(rcu_state.name, count, !!rcl.head, need_resched(),
 			    is_idle_task(current), rcu_is_callbacks_kthread());
 
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 43991a4..9c6f734 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -171,6 +171,7 @@ struct rcu_data {
 					/* different grace periods. */
 	long		qlen_last_fqs_check;
 					/* qlen at last check for QS forcing */
+	unsigned long	n_cbs_invoked;	/* # callbacks invoked since boot. */
 	unsigned long	n_force_qs_snap;
 					/* did other CPU force QS recently? */
 	long		blimit;		/* Upper limit on a processed batch */
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index 54a6dba..2768ce6 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -649,6 +649,7 @@ static void check_cpu_stall(struct rcu_data *rdp)
  */
 void show_rcu_gp_kthreads(void)
 {
+	unsigned long cbs = 0;
 	int cpu;
 	unsigned long j;
 	unsigned long ja;
@@ -690,9 +691,11 @@ void show_rcu_gp_kthreads(void)
 	}
 	for_each_possible_cpu(cpu) {
 		rdp = per_cpu_ptr(&rcu_data, cpu);
+		cbs += data_race(rdp->n_cbs_invoked);
 		if (rcu_segcblist_is_offloaded(&rdp->cblist))
 			show_rcu_nocb_state(rdp);
 	}
+	pr_info("RCU callbacks invoked since boot: %lu\n", cbs);
 	show_rcu_tasks_gp_kthreads();
 }
 EXPORT_SYMBOL_GPL(show_rcu_gp_kthreads);
