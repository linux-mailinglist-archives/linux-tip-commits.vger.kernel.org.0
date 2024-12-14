Return-Path: <linux-tip-commits+bounces-3068-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0309F204F
	for <lists+linux-tip-commits@lfdr.de>; Sat, 14 Dec 2024 19:37:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2AE54167046
	for <lists+linux-tip-commits@lfdr.de>; Sat, 14 Dec 2024 18:37:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 882FD19E961;
	Sat, 14 Dec 2024 18:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LwT2+Tvc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TPE7SfPR"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 662223D96A;
	Sat, 14 Dec 2024 18:37:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734201431; cv=none; b=CB+lfzH7TqYuVEIaCTwFLOPEc/P4FZyolnhmZmsC3WIyGBY7eryBUF+UUtFM9+KN8CH+Ey9YoHcwJmbvvsJwxAP6kvf9JDiuulC7u6m1pZ2PgYGQWKFh1XCQriZ2/dTx8oKxSCm7EuIACNUTVBUC5+PjGMlWCsKMpdEOXZrg38M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734201431; c=relaxed/simple;
	bh=i5E4sjpLVyZxCf7uAwvBtIlCInNlSuC7jsClWY435Ik=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=VUgh8r0wZWwowzKKzytn6FDkIJdr4TeaDTrU1dIs16irZJ4IFuMDnligPlslcxuY/iSHu4bcPlP+d3TphpBoS7EUeaVIN4iLDiY8pAdMMWG4wYP/Oq1oEtFBzHoNAGq+/6HODuk6s/ZyCEz/7oJzdoaMo/sDCgS/Qf6UgY7gF8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LwT2+Tvc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TPE7SfPR; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 14 Dec 2024 18:37:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1734201421;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=olZnH3G3iWALt9wBdPAbf9gx1N36Vu7R/AibgPxJAwE=;
	b=LwT2+TvcQ4KmYuGKqPWh8JzIa2GQ5VlpnTLptjT+Xdy63XmcXQIgGEnM7tWbpVs/syxEUi
	XAK3QqIt5EIbPEDk/meT2gM2OdiNfX6p0hW+fwOk6pxZmJj9/DF+ylSX/BEYODA+EW/pCw
	2ZF1ADM6qtsMaSgyjQuKKgy6hETo+wz0Atl/Q2zM6NdR3KU+IZ2qVh5xgwE+gl8eFBvCDL
	4YFDEyDo1CMdRwswYUCHNqpbKl14wW5PL9qiHYKNgsjFt9R/8xZbOBUw/mC/0K9U69o21Y
	thy6WTXFI7zyrsCLfF2OQr7C6kgXYEbHmfEJ/1UmMvPNon++pBoznJi3n3OGug==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1734201421;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=olZnH3G3iWALt9wBdPAbf9gx1N36Vu7R/AibgPxJAwE=;
	b=TPE7SfPRglDsde1f4R6MSLc0C5sab6O7utSyODVSn63CIiVk3unA0y54mFqsQly5ckfCoa
	Il7rlzDO4QoAfiCw==
From: "tip-bot2 for Vineeth Pillai (Google)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/dlserver: Fix dlserver double enqueue
Cc: Peter Zijlstra <peterz@infradead.org>,
 "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>,
 Marcel Ziswiler <marcel.ziswiler@codethink.co.uk>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241213032244.877029-1-vineeth@bitbyteword.org>
References: <20241213032244.877029-1-vineeth@bitbyteword.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173420142053.412.3234430814445032113.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     b53127db1dbf7f1047cf35c10922d801dcd40324
Gitweb:        https://git.kernel.org/tip/b53127db1dbf7f1047cf35c10922d801dcd40324
Author:        Vineeth Pillai (Google) <vineeth@bitbyteword.org>
AuthorDate:    Thu, 12 Dec 2024 22:22:36 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 13 Dec 2024 12:57:34 +01:00

sched/dlserver: Fix dlserver double enqueue

dlserver can get dequeued during a dlserver pick_task due to the delayed
deueue feature and this can lead to issues with dlserver logic as it
still thinks that dlserver is on the runqueue. The dlserver throttling
and replenish logic gets confused and can lead to double enqueue of
dlserver.

Double enqueue of dlserver could happend due to couple of reasons:

Case 1
------

Delayed dequeue feature[1] can cause dlserver being stopped during a
pick initiated by dlserver:
  __pick_next_task
   pick_task_dl -> server_pick_task
    pick_task_fair
     pick_next_entity (if (sched_delayed))
      dequeue_entities
       dl_server_stop

server_pick_task goes ahead with update_curr_dl_se without knowing that
dlserver is dequeued and this confuses the logic and may lead to
unintended enqueue while the server is stopped.

Case 2
------
A race condition between a task dequeue on one cpu and same task's enqueue
on this cpu by a remote cpu while the lock is released causing dlserver
double enqueue.

One cpu would be in the schedule() and releasing RQ-lock:

current->state = TASK_INTERRUPTIBLE();
        schedule();
          deactivate_task()
            dl_stop_server();
          pick_next_task()
            pick_next_task_fair()
              sched_balance_newidle()
                rq_unlock(this_rq)

at which point another CPU can take our RQ-lock and do:

        try_to_wake_up()
          ttwu_queue()
            rq_lock()
            ...
            activate_task()
              dl_server_start() --> first enqueue
            wakeup_preempt() := check_preempt_wakeup_fair()
              update_curr()
                update_curr_task()
                  if (current->dl_server)
                    dl_server_update()
                      enqueue_dl_entity() --> second enqueue

This bug was not apparent as the enqueue in dl_server_start doesn't
usually happen because of the defer logic. But as a side effect of the
first case(dequeue during dlserver pick), dl_throttled and dl_yield will
be set and this causes the time accounting of dlserver to messup and
then leading to a enqueue in dl_server_start.

Have an explicit flag representing the status of dlserver to avoid the
confusion. This is set in dl_server_start and reset in dlserver_stop.

Fixes: 63ba8422f876 ("sched/deadline: Introduce deadline servers")
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: "Vineeth Pillai (Google)" <vineeth@bitbyteword.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Marcel Ziswiler <marcel.ziswiler@codethink.co.uk> # ROCK 5B
Link: https://lkml.kernel.org/r/20241213032244.877029-1-vineeth@bitbyteword.org
---
 include/linux/sched.h   | 7 +++++++
 kernel/sched/deadline.c | 8 ++++++--
 kernel/sched/sched.h    | 5 +++++
 3 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index d380bff..66b311f 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -656,6 +656,12 @@ struct sched_dl_entity {
 	 * @dl_defer_armed tells if the deferrable server is waiting
 	 * for the replenishment timer to activate it.
 	 *
+	 * @dl_server_active tells if the dlserver is active(started).
+	 * dlserver is started on first cfs enqueue on an idle runqueue
+	 * and is stopped when a dequeue results in 0 cfs tasks on the
+	 * runqueue. In other words, dlserver is active only when cpu's
+	 * runqueue has atleast one cfs task.
+	 *
 	 * @dl_defer_running tells if the deferrable server is actually
 	 * running, skipping the defer phase.
 	 */
@@ -664,6 +670,7 @@ struct sched_dl_entity {
 	unsigned int			dl_non_contending : 1;
 	unsigned int			dl_overrun	  : 1;
 	unsigned int			dl_server         : 1;
+	unsigned int			dl_server_active  : 1;
 	unsigned int			dl_defer	  : 1;
 	unsigned int			dl_defer_armed	  : 1;
 	unsigned int			dl_defer_running  : 1;
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index db47f33..d94f2ed 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1647,6 +1647,7 @@ void dl_server_start(struct sched_dl_entity *dl_se)
 	if (!dl_se->dl_runtime)
 		return;
 
+	dl_se->dl_server_active = 1;
 	enqueue_dl_entity(dl_se, ENQUEUE_WAKEUP);
 	if (!dl_task(dl_se->rq->curr) || dl_entity_preempt(dl_se, &rq->curr->dl))
 		resched_curr(dl_se->rq);
@@ -1661,6 +1662,7 @@ void dl_server_stop(struct sched_dl_entity *dl_se)
 	hrtimer_try_to_cancel(&dl_se->dl_timer);
 	dl_se->dl_defer_armed = 0;
 	dl_se->dl_throttled = 0;
+	dl_se->dl_server_active = 0;
 }
 
 void dl_server_init(struct sched_dl_entity *dl_se, struct rq *rq,
@@ -2421,8 +2423,10 @@ again:
 	if (dl_server(dl_se)) {
 		p = dl_se->server_pick_task(dl_se);
 		if (!p) {
-			dl_se->dl_yielded = 1;
-			update_curr_dl_se(rq, dl_se, 0);
+			if (dl_server_active(dl_se)) {
+				dl_se->dl_yielded = 1;
+				update_curr_dl_se(rq, dl_se, 0);
+			}
 			goto again;
 		}
 		rq->dl_server = dl_se;
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 1e494af..c5d67a4 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -398,6 +398,11 @@ extern void __dl_server_attach_root(struct sched_dl_entity *dl_se, struct rq *rq
 extern int dl_server_apply_params(struct sched_dl_entity *dl_se,
 		    u64 runtime, u64 period, bool init);
 
+static inline bool dl_server_active(struct sched_dl_entity *dl_se)
+{
+	return dl_se->dl_server_active;
+}
+
 #ifdef CONFIG_CGROUP_SCHED
 
 extern struct list_head task_groups;

