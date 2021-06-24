Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B4A73B2980
	for <lists+linux-tip-commits@lfdr.de>; Thu, 24 Jun 2021 09:39:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231681AbhFXHlv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 24 Jun 2021 03:41:51 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42796 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231601AbhFXHlq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 24 Jun 2021 03:41:46 -0400
Date:   Thu, 24 Jun 2021 07:39:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624520367;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mqkl0JCF3NrI2c4Mc3G04vC0xTkYYndBaIaGhbC8UZM=;
        b=XnNh2A8XKB6TpDFeRBvdiLFiR2tOJmZ1EuyKkWA9kjlhHivwLjsinByIEEpVJ6tbEWSzWx
        j2TMTbqAdwUm3HDbfZjZHAINt2czKCj0DwHhQ1N/K1Yhokld+NRGFB2diFEgfXdvHru1wx
        wbdGWYVtmw85hOvt8K13qTRRpsbgb6ix/db7PvKXSSN0CbpMIMVhbgLLVIlTEJpvNl7uZt
        5JAxfCnNhnyqE2LNhYTN+0RYU7MUSDExXUVSM30t/s7XvkVHuQu6LQ42NqtTLRmpgHFDZl
        wkIRTHWBYr/6l0SESt/sEg1w7EsO8Uc+SNw7m73Jvm7xVrg7gZMXQdVAL4+N+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624520367;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mqkl0JCF3NrI2c4Mc3G04vC0xTkYYndBaIaGhbC8UZM=;
        b=OvuGL1p51vN4qZJYCdfn3FQE8Pd6UNPA111OGaZp4ZzLvslZfZp/CBW+SfoaQCkfqX0uuF
        DxNf75j4nwXduvBg==
From:   "tip-bot2 for Zhaoyang Huang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] psi: Fix race between psi_trigger_create/destroy
Cc:     "ziwei.dai" <ziwei.dai@unisoc.com>, "ke.wang" <ke.wang@unisoc.com>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Suren Baghdasaryan <surenb@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1623371374-15664-1-git-send-email-huangzhaoyang@gmail.com>
References: <1623371374-15664-1-git-send-email-huangzhaoyang@gmail.com>
MIME-Version: 1.0
Message-ID: <162452036638.395.9852468553852116430.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8f91efd870ea5d8bc10b0fcc9740db51cd4c0c83
Gitweb:        https://git.kernel.org/tip/8f91efd870ea5d8bc10b0fcc9740db51cd4c0c83
Author:        Zhaoyang Huang <zhaoyang.huang@unisoc.com>
AuthorDate:    Fri, 11 Jun 2021 08:29:34 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 24 Jun 2021 09:07:50 +02:00

psi: Fix race between psi_trigger_create/destroy

Race detected between psi_trigger_destroy/create as shown below, which
cause panic by accessing invalid psi_system->poll_wait->wait_queue_entry
and psi_system->poll_timer->entry->next. Under this modification, the
race window is removed by initialising poll_wait and poll_timer in
group_init which are executed only once at beginning.

  psi_trigger_destroy()                   psi_trigger_create()

  mutex_lock(trigger_lock);
  rcu_assign_pointer(poll_task, NULL);
  mutex_unlock(trigger_lock);
					  mutex_lock(trigger_lock);
					  if (!rcu_access_pointer(group->poll_task)) {
					    timer_setup(poll_timer, poll_timer_fn, 0);
					    rcu_assign_pointer(poll_task, task);
					  }
					  mutex_unlock(trigger_lock);

  synchronize_rcu();
  del_timer_sync(poll_timer); <-- poll_timer has been reinitialized by
                                  psi_trigger_create()

So, trigger_lock/RCU correctly protects destruction of
group->poll_task but misses this race affecting poll_timer and
poll_wait.

Fixes: 461daba06bdc ("psi: eliminate kthread_worker from psi trigger scheduling mechanism")
Co-developed-by: ziwei.dai <ziwei.dai@unisoc.com>
Signed-off-by: ziwei.dai <ziwei.dai@unisoc.com>
Co-developed-by: ke.wang <ke.wang@unisoc.com>
Signed-off-by: ke.wang <ke.wang@unisoc.com>
Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Suren Baghdasaryan <surenb@google.com>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Link: https://lkml.kernel.org/r/1623371374-15664-1-git-send-email-huangzhaoyang@gmail.com
---
 kernel/sched/psi.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/kernel/sched/psi.c b/kernel/sched/psi.c
index cc25a3c..58b36d1 100644
--- a/kernel/sched/psi.c
+++ b/kernel/sched/psi.c
@@ -182,6 +182,8 @@ struct psi_group psi_system = {
 
 static void psi_avgs_work(struct work_struct *work);
 
+static void poll_timer_fn(struct timer_list *t);
+
 static void group_init(struct psi_group *group)
 {
 	int cpu;
@@ -201,6 +203,8 @@ static void group_init(struct psi_group *group)
 	memset(group->polling_total, 0, sizeof(group->polling_total));
 	group->polling_next_update = ULLONG_MAX;
 	group->polling_until = 0;
+	init_waitqueue_head(&group->poll_wait);
+	timer_setup(&group->poll_timer, poll_timer_fn, 0);
 	rcu_assign_pointer(group->poll_task, NULL);
 }
 
@@ -1157,9 +1161,7 @@ struct psi_trigger *psi_trigger_create(struct psi_group *group,
 			return ERR_CAST(task);
 		}
 		atomic_set(&group->poll_wakeup, 0);
-		init_waitqueue_head(&group->poll_wait);
 		wake_up_process(task);
-		timer_setup(&group->poll_timer, poll_timer_fn, 0);
 		rcu_assign_pointer(group->poll_task, task);
 	}
 
@@ -1211,6 +1213,7 @@ static void psi_trigger_destroy(struct kref *ref)
 					group->poll_task,
 					lockdep_is_held(&group->trigger_lock));
 			rcu_assign_pointer(group->poll_task, NULL);
+			del_timer(&group->poll_timer);
 		}
 	}
 
@@ -1223,17 +1226,14 @@ static void psi_trigger_destroy(struct kref *ref)
 	 */
 	synchronize_rcu();
 	/*
-	 * Destroy the kworker after releasing trigger_lock to prevent a
+	 * Stop kthread 'psimon' after releasing trigger_lock to prevent a
 	 * deadlock while waiting for psi_poll_work to acquire trigger_lock
 	 */
 	if (task_to_destroy) {
 		/*
 		 * After the RCU grace period has expired, the worker
 		 * can no longer be found through group->poll_task.
-		 * But it might have been already scheduled before
-		 * that - deschedule it cleanly before destroying it.
 		 */
-		del_timer_sync(&group->poll_timer);
 		kthread_stop(task_to_destroy);
 	}
 	kfree(t);
