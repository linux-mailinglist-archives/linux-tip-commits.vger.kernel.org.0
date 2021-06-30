Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FA73B83AC
	for <lists+linux-tip-commits@lfdr.de>; Wed, 30 Jun 2021 15:48:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235828AbhF3Nua (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 30 Jun 2021 09:50:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235523AbhF3NuG (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 30 Jun 2021 09:50:06 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68428C061226;
        Wed, 30 Jun 2021 06:47:36 -0700 (PDT)
Date:   Wed, 30 Jun 2021 13:47:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1625060855;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=gTXDBc/3nnzp/o5D1+NBHH6XfbtE9eJgjLbKuFjopzI=;
        b=bGP9Boh9rQ8ptig5eVyjMEL12RiPwJRuQnbTEFum11Gph+wYOV0FJjdLi4e44E+FoyhDHo
        8hpHPehmWPTwnb4MbVOmzwgbidIYWTv9uBphwUDmfjM5PngnP1h6dFWiozD6PU0Y0zxa08
        rtP6ujBbVeev3CSg1wTB8FdJnV0ZxwUKQWhSuxXjgVCR2VxH6vlmFtWRQuMA1UwsNJNUOB
        V5PrzA1Miwef2diFrDaahnR9ZpMBAdTCTQlPdpcYTD0iJn1A7O/AeyaGip2cIgopcDL0Vb
        xiUL9NUERhaFYfTC8I6RG0UgQ0iSQItUGE3bXfAmWuXnCu0O5vyyPV1tmaoaJQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1625060855;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=gTXDBc/3nnzp/o5D1+NBHH6XfbtE9eJgjLbKuFjopzI=;
        b=wa+JGKnrWd9bHrw8hQWn8rKQZ14vXsRKPqgvJcnfWOV15k/0FNLmCxahLpeFT/CS075MGg
        8j3AzznR67f/xwBQ==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcu: Add quiescent states and boost states to
 show_rcu_gp_kthreads() output
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <162506085433.395.10973768838290035872.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     396eba65f62414ee8850ed5f7b5ce844719ebebf
Gitweb:        https://git.kernel.org/tip/396eba65f62414ee8850ed5f7b5ce844719ebebf
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Tue, 06 Apr 2021 16:31:42 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 10 May 2021 16:22:54 -07:00

rcu: Add quiescent states and boost states to show_rcu_gp_kthreads() output

This commit adds each rcu_node structure's ->qsmask and "bBEG" output
indicating whether: (1) There is a boost kthread, (2) A reader needs
to be (or is in the process of being) boosted, (3) A reader is blocking
an expedited grace period, and (4) A reader is blocking a normal grace
period.  This helps diagnose RCU priority boosting failures.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.h        |  1 +
 kernel/rcu/tree_plugin.h |  1 +
 kernel/rcu/tree_stall.h  | 12 +++++++++---
 3 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 71821d5..5fd0c44 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -115,6 +115,7 @@ struct rcu_node {
 				/*  boosting for this rcu_node structure. */
 	unsigned int boost_kthread_status;
 				/* State of boost_kthread_task for tracing. */
+	unsigned long n_boosts;	/* Number of boosts for this rcu_node structure. */
 #ifdef CONFIG_RCU_NOCB_CPU
 	struct swait_queue_head nocb_gp_wq[2];
 				/* Place for rcu_nocb_kthread() to wait GP. */
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index 2cbe8f8..ef004cc 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -1098,6 +1098,7 @@ static int rcu_boost(struct rcu_node *rnp)
 	/* Lock only for side effect: boosts task t's priority. */
 	rt_mutex_lock(&rnp->boost_mtx);
 	rt_mutex_unlock(&rnp->boost_mtx);  /* Then keep lockdep happy. */
+	rnp->n_boosts++;
 
 	return READ_ONCE(rnp->exp_tasks) != NULL ||
 	       READ_ONCE(rnp->boost_tasks) != NULL;
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index a4e2bb3..c1f8386 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -749,9 +749,15 @@ void show_rcu_gp_kthreads(void)
 		if (ULONG_CMP_GE(READ_ONCE(rcu_state.gp_seq),
 				 READ_ONCE(rnp->gp_seq_needed)))
 			continue;
-		pr_info("\trcu_node %d:%d ->gp_seq %ld ->gp_seq_needed %ld\n",
-			rnp->grplo, rnp->grphi, (long)data_race(rnp->gp_seq),
-			(long)data_race(rnp->gp_seq_needed));
+		pr_info("\trcu_node %d:%d ->gp_seq %ld ->gp_seq_needed %ld ->qsmask %#lx %c%c%c%c ->n_boosts %ld\n",
+			rnp->grplo, rnp->grphi,
+			(long)data_race(rnp->gp_seq), (long)data_race(rnp->gp_seq_needed),
+			data_race(rnp->qsmask),
+			".b"[!!data_race(rnp->boost_kthread_task)],
+			".B"[!!data_race(rnp->boost_tasks)],
+			".E"[!!data_race(rnp->exp_tasks)],
+			".G"[!!data_race(rnp->gp_tasks)],
+			data_race(rnp->n_boosts));
 		if (!rcu_is_leaf_node(rnp))
 			continue;
 		for_each_leaf_node_possible_cpu(rnp, cpu) {
