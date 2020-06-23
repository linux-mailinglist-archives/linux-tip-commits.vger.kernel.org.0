Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 55B05204CEC
	for <lists+linux-tip-commits@lfdr.de>; Tue, 23 Jun 2020 10:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731998AbgFWIsr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 23 Jun 2020 04:48:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731914AbgFWIsc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 23 Jun 2020 04:48:32 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 528AFC061795;
        Tue, 23 Jun 2020 01:48:32 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jnebR-0005RL-7k; Tue, 23 Jun 2020 10:48:25 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DE2E01C0470;
        Tue, 23 Jun 2020 10:48:24 +0200 (CEST)
Date:   Tue, 23 Jun 2020 08:48:24 -0000
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/core: s/WF_ON_RQ/WQ_ON_CPU/
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, Mel Gorman <mgorman@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200622100825.785115830@infradead.org>
References: <20200622100825.785115830@infradead.org>
MIME-Version: 1.0
Message-ID: <159290210469.16989.16510266795734293690.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     5311fd9f4c49ccc597021d901136fc807c01d678
Gitweb:        https://git.kernel.org/tip/5311fd9f4c49ccc597021d901136fc807c01d678
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 22 Jun 2020 12:01:24 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 23 Jun 2020 10:42:39 +02:00

sched/core: s/WF_ON_RQ/WQ_ON_CPU/

Use a better name for this poorly named flag, to avoid confusion...

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Mel Gorman <mgorman@suse.de>
Link: https://lkml.kernel.org/r/20200622100825.785115830@infradead.org
---
 kernel/sched/core.c  | 4 ++--
 kernel/sched/sched.h | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 60791b9..f778067 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2376,7 +2376,7 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)
 	 * the soon-to-be-idle CPU as the current CPU is likely busy.
 	 * nr_running is checked to avoid unnecessary task stacking.
 	 */
-	if ((wake_flags & WF_ON_RQ) && cpu_rq(cpu)->nr_running <= 1)
+	if ((wake_flags & WF_ON_CPU) && cpu_rq(cpu)->nr_running <= 1)
 		return true;
 
 	return false;
@@ -2636,7 +2636,7 @@ try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 	 * scheduling.
 	 */
 	if (smp_load_acquire(&p->on_cpu) &&
-	    ttwu_queue_wakelist(p, task_cpu(p), wake_flags | WF_ON_RQ))
+	    ttwu_queue_wakelist(p, task_cpu(p), wake_flags | WF_ON_CPU))
 		goto unlock;
 
 	/*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1d4e94c..877fb08 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1682,7 +1682,7 @@ static inline int task_on_rq_migrating(struct task_struct *p)
 #define WF_SYNC			0x01		/* Waker goes to sleep after wakeup */
 #define WF_FORK			0x02		/* Child wakeup after fork */
 #define WF_MIGRATED		0x04		/* Internal use, task got migrated */
-#define WF_ON_RQ		0x08		/* Wakee is on_rq */
+#define WF_ON_CPU		0x08		/* Wakee is on_cpu */
 
 /*
  * To aid in avoiding the subversion of "niceness" due to uneven distribution
