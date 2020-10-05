Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BCE828310C
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Oct 2020 09:43:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725880AbgJEHnY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Oct 2020 03:43:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56698 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725870AbgJEHnY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Oct 2020 03:43:24 -0400
Date:   Mon, 05 Oct 2020 07:43:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601883801;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PEOK3zx6IGWDIGrzIT5RTnI63Z2+ZiiIjamj6N4ValA=;
        b=jkmAKP0FBsOMSaIQ2lE4FNeMgRtxAMwzpGs0zuwAmTrDM1ea4lHMWzwWon2LMMViPk5Lzm
        gD90FdRrLihuPQykrbZmaE7WBQrKX1GK7S/iymSOxohypcAuNHLX9r5RSQP32V03E/VHGA
        3BQ5ISVRtNZTo3kiz27pzMsbuBEme5XhSOG5LN7wmlXxXCOt8Aw+yxO5Pi4dW+k5C1746E
        6woi2FUZu8L+cGt1WsjIiy7oFY7LzBGbLxcclPwUPnVDA84gdHuWvTR5otNIMFFGy3sMWx
        2YMAkiRMVj3PSz+c14eQM/OKAbUzy7SQM6kTKxCz+YG4SZzxHQ84FqPJJic6qw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601883801;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PEOK3zx6IGWDIGrzIT5RTnI63Z2+ZiiIjamj6N4ValA=;
        b=e88ataEi8RAWA8kdQd7181OWfED6rJr6NsQ4B+dTrpOYDWmE66GtKaaYviVH2+giWJsOs5
        t7X7rdYUMoc8FwAw==
From:   "tip-bot2 for Daniel Bristot de Oliveira" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Unthrottle PI boosted threads while
 enqueuing
Cc:     Mark Simmons <msimmons@redhat.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <5076e003450835ec74e6fa5917d02c4fa41687e6.1600170294.git.bristot@redhat.com>
References: <5076e003450835ec74e6fa5917d02c4fa41687e6.1600170294.git.bristot@redhat.com>
MIME-Version: 1.0
Message-ID: <160188380002.7002.3321703660112197188.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     feff2e65efd8d84cf831668e182b2ce73c604bbb
Gitweb:        https://git.kernel.org/tip/feff2e65efd8d84cf831668e182b2ce73c604bbb
Author:        Daniel Bristot de Oliveira <bristot@redhat.com>
AuthorDate:    Wed, 16 Sep 2020 09:06:39 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 03 Oct 2020 16:30:53 +02:00

sched/deadline: Unthrottle PI boosted threads while enqueuing

stress-ng has a test (stress-ng --cyclic) that creates a set of threads
under SCHED_DEADLINE with the following parameters:

    dl_runtime   =  10000 (10 us)
    dl_deadline  = 100000 (100 us)
    dl_period    = 100000 (100 us)

These parameters are very aggressive. When using a system without HRTICK
set, these threads can easily execute longer than the dl_runtime because
the throttling happens with 1/HZ resolution.

During the main part of the test, the system works just fine because
the workload does not try to run over the 10 us. The problem happens at
the end of the test, on the exit() path. During exit(), the threads need
to do some cleanups that require real-time mutex locks, mainly those
related to memory management, resulting in this scenario:

Note: locks are rt_mutexes...
 ------------------------------------------------------------------------
    TASK A:		TASK B:				TASK C:
    activation
							activation
			activation

    lock(a): OK!	lock(b): OK!
    			<overrun runtime>
    			lock(a)
    			-> block (task A owns it)
			  -> self notice/set throttled
 +--<			  -> arm replenished timer
 |    			switch-out
 |    							lock(b)
 |    							-> <C prio > B prio>
 |    							-> boost TASK B
 |  unlock(a)						switch-out
 |  -> handle lock a to B
 |    -> wakeup(B)
 |      -> B is throttled:
 |        -> do not enqueue
 |     switch-out
 |
 |
 +---------------------> replenishment timer
			-> TASK B is boosted:
			  -> do not enqueue
 ------------------------------------------------------------------------

BOOM: TASK B is runnable but !enqueued, holding TASK C: the system
crashes with hung task C.

This problem is avoided by removing the throttle state from the boosted
thread while boosting it (by TASK A in the example above), allowing it to
be queued and run boosted.

The next replenishment will take care of the runtime overrun, pushing
the deadline further away. See the "while (dl_se->runtime <= 0)" on
replenish_dl_entity() for more information.

Reported-by: Mark Simmons <msimmons@redhat.com>
Signed-off-by: Daniel Bristot de Oliveira <bristot@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Tested-by: Mark Simmons <msimmons@redhat.com>
Link: https://lkml.kernel.org/r/5076e003450835ec74e6fa5917d02c4fa41687e6.1600170294.git.bristot@redhat.com
---
 kernel/sched/deadline.c | 21 +++++++++++++++++++++
 1 file changed, 21 insertions(+)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index c19c188..6d93f45 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1525,6 +1525,27 @@ static void enqueue_task_dl(struct rq *rq, struct task_struct *p, int flags)
 	 */
 	if (pi_task && dl_prio(pi_task->normal_prio) && p->dl.dl_boosted) {
 		pi_se = &pi_task->dl;
+		/*
+		 * Because of delays in the detection of the overrun of a
+		 * thread's runtime, it might be the case that a thread
+		 * goes to sleep in a rt mutex with negative runtime. As
+		 * a consequence, the thread will be throttled.
+		 *
+		 * While waiting for the mutex, this thread can also be
+		 * boosted via PI, resulting in a thread that is throttled
+		 * and boosted at the same time.
+		 *
+		 * In this case, the boost overrides the throttle.
+		 */
+		if (p->dl.dl_throttled) {
+			/*
+			 * The replenish timer needs to be canceled. No
+			 * problem if it fires concurrently: boosted threads
+			 * are ignored in dl_task_timer().
+			 */
+			hrtimer_try_to_cancel(&p->dl.dl_timer);
+			p->dl.dl_throttled = 0;
+		}
 	} else if (!dl_prio(p->normal_prio)) {
 		/*
 		 * Special case in which we have a !SCHED_DEADLINE task that is going
