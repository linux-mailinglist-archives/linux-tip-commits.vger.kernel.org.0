Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3130441F06D
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Oct 2021 17:06:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354892AbhJAPHo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 1 Oct 2021 11:07:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58060 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354855AbhJAPHf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 1 Oct 2021 11:07:35 -0400
Date:   Fri, 01 Oct 2021 15:05:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633100750;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8fqwxnzpBpUMQmoHLbPiAek+Iahlpht2tcL4eSGmVbk=;
        b=4BhKNgQn9s13tqotKK4V2RUz1lUMZOFrMwPL5M02OVUjgP4I/4elSTT6o1XR55ILGWuubw
        ywwtbmypDEligXF6cs9ZK+AkFXMF8sEnmvcFSdXpxQ+me9saFm5eEQPf2gshEcJkgjWYXX
        MA/D7H8pVQmMopu/Gax8g/06YyrZJNDvNsF6h4WlReFwoSbMEWQ/SvGOYMO7yHjuS1vEsd
        /Q2DwEQ19OKWxgWW6ob2n4C/qhX3pahTaew7488CrBUWJS2SbBd8nb5kj2WJcHdt4FhbsW
        jmrDtq9NRUlzLuJZZb9WBrFwJuBXa+PaqwWHu6W87gCbdw4Grm01pmxTvfpURw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633100750;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8fqwxnzpBpUMQmoHLbPiAek+Iahlpht2tcL4eSGmVbk=;
        b=LcIECGtkc9fsU8qraLD22RVKPqSPZ2TSldKUz44RxnsZP7MD8liM0y3GOvpkcjDlZXJ2y8
        MEnibcAxUBvvdzCQ==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Remove pointless preemption disable in
 sched_submit_work()
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Jens Axboe <axboe@kernel.dk>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <8735pnafj7.ffs@tglx>
References: <8735pnafj7.ffs@tglx>
MIME-Version: 1.0
Message-ID: <163310074937.25758.2495577289305556588.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     579df3f2325191322b96906a5898462253a45ede
Gitweb:        https://git.kernel.org/tip/579df3f2325191322b96906a5898462253a45ede
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 29 Sep 2021 11:37:32 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 01 Oct 2021 13:58:07 +02:00

sched: Remove pointless preemption disable in sched_submit_work()

Neither wq_worker_sleeping() nor io_wq_worker_sleeping() require to be invoked
with preemption disabled:

  - The worker flag checks operations only need to be serialized against
    the worker thread itself.

  - The accounting and worker pool operations are serialized with locks.

which means that disabling preemption has neither a reason nor a
value. Remove it and update the stale comment.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Lai Jiangshan <jiangshanlai@gmail.com>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
Link: https://lkml.kernel.org/r/8735pnafj7.ffs@tglx
---
 kernel/sched/core.c | 10 ++--------
 1 file changed, 2 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8e49b17..d469c7b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6097,20 +6097,14 @@ static inline void sched_submit_work(struct task_struct *tsk)
 
 	task_flags = tsk->flags;
 	/*
-	 * If a worker went to sleep, notify and ask workqueue whether
-	 * it wants to wake up a task to maintain concurrency.
-	 * As this function is called inside the schedule() context,
-	 * we disable preemption to avoid it calling schedule() again
-	 * in the possible wakeup of a kworker and because wq_worker_sleeping()
-	 * requires it.
+	 * If a worker goes to sleep, notify and ask workqueue whether it
+	 * wants to wake up a task to maintain concurrency.
 	 */
 	if (task_flags & (PF_WQ_WORKER | PF_IO_WORKER)) {
-		preempt_disable();
 		if (task_flags & PF_WQ_WORKER)
 			wq_worker_sleeping(tsk);
 		else
 			io_wq_worker_sleeping(tsk);
-		preempt_enable_no_resched();
 	}
 
 	if (tsk_is_pi_blocked(tsk))
