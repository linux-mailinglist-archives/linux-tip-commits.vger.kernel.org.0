Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 99D6C8605F
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Aug 2019 12:52:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731755AbfHHKwV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 8 Aug 2019 06:52:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:41441 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731054AbfHHKwU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 8 Aug 2019 06:52:20 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x78Aq6iF3126671
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 8 Aug 2019 03:52:06 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x78Aq6iF3126671
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565261526;
        bh=lIIHE/fFUrz66us/6Nq/KuXggEWKdiTw8TFdSzS0pLc=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=bBmfgNJ6WOD7guENwhE31F94o6VOVBAPWp7nOvkz8iv1xa4o3BrAr9qCYxIhP6BFa
         ADFSNzCTyH99D0tUoGRwEAa+Q9cZakagmjmCd/aByI4ird3OVhS63QpR6zXrue9R4O
         ClNejG+vPUoGDRcojV+zD1NGcNu/quFz1uCUsO/H0SZLgauWWvIXKOc3CDnhD4xFZl
         FRGZklIbw+uqGmMlR5Tb0iZWn/MvmM8E3q3PegfyLJoX1qBVYj1Axnha9olTxwhAXM
         ea6fl7kilyahLt2nVG2HJ8Mj3le/WGgOLkJ0iGdQw/3DCsjvIjSFsF+Z4uf601XTXd
         FSUQYfqaeXjkg==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x78Aq55W3126668;
        Thu, 8 Aug 2019 03:52:05 -0700
Date:   Thu, 8 Aug 2019 03:52:05 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Peter Zijlstra <tipbot@zytor.com>
Message-ID: <tip-130d9c331bc59a8733b47c58ef197a2b1fa3ed43@git.kernel.org>
Cc:     juri.lelli@redhat.com, tglx@linutronix.de, peterz@infradead.org,
        paulmck@linux.ibm.com, hpa@zytor.com, mingo@kernel.org
Reply-To: mingo@kernel.org, hpa@zytor.com, linux-kernel@vger.kernel.org,
          paulmck@linux.ibm.com, peterz@infradead.org, tglx@linutronix.de,
          juri.lelli@redhat.com
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:sched/core] rcu/tree: Fix SCHED_FIFO params
Git-Commit-ID: 130d9c331bc59a8733b47c58ef197a2b1fa3ed43
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.3 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Commit-ID:  130d9c331bc59a8733b47c58ef197a2b1fa3ed43
Gitweb:     https://git.kernel.org/tip/130d9c331bc59a8733b47c58ef197a2b1fa3ed43
Author:     Peter Zijlstra <peterz@infradead.org>
AuthorDate: Thu, 1 Aug 2019 12:42:06 +0200
Committer:  Peter Zijlstra <peterz@infradead.org>
CommitDate: Thu, 8 Aug 2019 09:09:30 +0200

rcu/tree: Fix SCHED_FIFO params

A rather embarrasing mistake had us call sched_setscheduler() before
initializing the parameters passed to it.

Fixes: 1a763fd7c633 ("rcu/tree: Call setschedule() gp ktread to SCHED_FIFO outside of atomic region")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Paul E. McKenney <paulmck@linux.ibm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
---
 kernel/rcu/tree.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index eb764c24bc4d..5efdce756fdf 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3234,13 +3234,13 @@ static int __init rcu_spawn_gp_kthread(void)
 	t = kthread_create(rcu_gp_kthread, NULL, "%s", rcu_state.name);
 	if (WARN_ONCE(IS_ERR(t), "%s: Could not start grace-period kthread, OOM is now expected behavior\n", __func__))
 		return 0;
-	if (kthread_prio)
+	if (kthread_prio) {
+		sp.sched_priority = kthread_prio;
 		sched_setscheduler_nocheck(t, SCHED_FIFO, &sp);
+	}
 	rnp = rcu_get_root();
 	raw_spin_lock_irqsave_rcu_node(rnp, flags);
 	rcu_state.gp_kthread = t;
-	if (kthread_prio)
-		sp.sched_priority = kthread_prio;
 	raw_spin_unlock_irqrestore_rcu_node(rnp, flags);
 	wake_up_process(t);
 	rcu_spawn_nocb_kthreads();
