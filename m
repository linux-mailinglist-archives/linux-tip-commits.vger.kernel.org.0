Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B7D0288295
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Oct 2020 08:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731817AbgJIGf1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Oct 2020 02:35:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731845AbgJIGfO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Oct 2020 02:35:14 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95F11C0613D4;
        Thu,  8 Oct 2020 23:35:14 -0700 (PDT)
Date:   Fri, 09 Oct 2020 06:35:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602225313;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9sd/ZRDtPyTAQwjxZNelfkdlun6QlT44m2PyrfOJN+o=;
        b=e4j4eumJJY8hNlLa0RJD3/0iXBCazq/NmILpH0bWAc+6YQbakkDbXtQnySroALSZif+0zB
        1h7eA2XKdoiZ5wPzM2sWXtBF1HmNv5VCSe0Y1PUS2qNxXjq0JE4Zj3yJTSSNU8wMlLLfiq
        SWYRYOTLm1K0rYODv2ApjcDD2bw1BphPc4wKI5e4Qmly4v3NdGSKEoNTGZMcjVqt4mYh+I
        N88Ab+gFMMlrwZWWbWgdRGbp5n5W1A+C4yeL3gvf5cS42CdICbpXgFaYhwXJBopFyIW84L
        rcfySqBfINvdYwjEteu2g9/GsDoSLS3DrDvwdxyChd5/cG1diNvdtAK5GPLujw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602225313;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=9sd/ZRDtPyTAQwjxZNelfkdlun6QlT44m2PyrfOJN+o=;
        b=lF/I3gPc2XTjAf2QDzjBli4UFGRGRmiIf+DLBfjKykMzy42nWbzK+sfbOeYZZ15NqXI+JH
        2JF2jY8FUzTWj7BA==
From:   "tip-bot2 for Paul E. McKenney" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] rcutorture: Properly synchronize with OOM notifier
Cc:     "Paul E. McKenney" <paulmck@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <160222531245.7002.6514159583240984002.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     57f602022e82ee8fa6476d0e16ddbaf3eb86b245
Gitweb:        https://git.kernel.org/tip/57f602022e82ee8fa6476d0e16ddbaf3eb86b245
Author:        Paul E. McKenney <paulmck@kernel.org>
AuthorDate:    Mon, 20 Jul 2020 08:34:07 -07:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Mon, 24 Aug 2020 18:45:34 -07:00

rcutorture: Properly synchronize with OOM notifier

The current rcutorture forward-progress code assumes that it is the
only cause of out-of-memory (OOM) events.  For script-based rcutorture
testing, this assumption is in fact correct.  However, testing based
on modprobe/rmmod might well encounter external OOM events, which could
happen at any time.

This commit therefore properly synchronizes the interaction between
rcutorture's forward-progress testing and its OOM notifier by adding a
global mutex.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/rcutorture.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 7942be4..2b3f04e 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -1796,6 +1796,7 @@ struct rcu_fwd {
 	unsigned long rcu_launder_gp_seq_start;
 };
 
+static DEFINE_MUTEX(rcu_fwd_mutex);
 static struct rcu_fwd *rcu_fwds;
 static bool rcu_fwd_emergency_stop;
 
@@ -2062,8 +2063,14 @@ static void rcu_torture_fwd_prog_cr(struct rcu_fwd *rfp)
 static int rcutorture_oom_notify(struct notifier_block *self,
 				 unsigned long notused, void *nfreed)
 {
-	struct rcu_fwd *rfp = rcu_fwds;
+	struct rcu_fwd *rfp;
 
+	mutex_lock(&rcu_fwd_mutex);
+	rfp = rcu_fwds;
+	if (!rfp) {
+		mutex_unlock(&rcu_fwd_mutex);
+		return NOTIFY_OK;
+	}
 	WARN(1, "%s invoked upon OOM during forward-progress testing.\n",
 	     __func__);
 	rcu_torture_fwd_cb_hist(rfp);
@@ -2081,6 +2088,7 @@ static int rcutorture_oom_notify(struct notifier_block *self,
 	smp_mb(); /* Frees before return to avoid redoing OOM. */
 	(*(unsigned long *)nfreed)++; /* Forward progress CBs freed! */
 	pr_info("%s returning after OOM processing.\n", __func__);
+	mutex_unlock(&rcu_fwd_mutex);
 	return NOTIFY_OK;
 }
 
@@ -2148,7 +2156,9 @@ static int __init rcu_torture_fwd_prog_init(void)
 		return -ENOMEM;
 	spin_lock_init(&rfp->rcu_fwd_lock);
 	rfp->rcu_fwd_cb_tail = &rfp->rcu_fwd_cb_head;
+	mutex_lock(&rcu_fwd_mutex);
 	rcu_fwds = rfp;
+	mutex_unlock(&rcu_fwd_mutex);
 	return torture_create_kthread(rcu_torture_fwd_prog, rfp, fwd_prog_task);
 }
 
@@ -2158,7 +2168,9 @@ static void rcu_torture_fwd_prog_cleanup(void)
 
 	torture_stop_kthread(rcu_torture_fwd_prog, fwd_prog_task);
 	rfp = rcu_fwds;
+	mutex_lock(&rcu_fwd_mutex);
 	rcu_fwds = NULL;
+	mutex_unlock(&rcu_fwd_mutex);
 	kfree(rfp);
 }
 
