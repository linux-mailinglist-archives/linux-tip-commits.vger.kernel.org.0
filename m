Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B83AE422A4E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Oct 2021 16:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235140AbhJEONt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 5 Oct 2021 10:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233727AbhJEONs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 5 Oct 2021 10:13:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCC34C061749;
        Tue,  5 Oct 2021 07:11:57 -0700 (PDT)
Date:   Tue, 05 Oct 2021 14:11:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633443116;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ydB2ctNol5Yfjy9cnuiA4Rdbqg/OB9Q2zTXfg20aLhQ=;
        b=ZvZWR8SucM6aSYBq4nr96PJpzDhUJq1u6o+24lPw0CvhIJa5vquy1oWUonvFZnoya3LbDN
        BGE4Hdkjq7Oxr6oDsk32D8hGfN1F8RLzDz+V4hVq7hkyn72j9Ue1iwLFxZdUCMA3OkknnG
        Ord8Eij0TNu/2+3coMyA8vin/Cotl9P/5/Atn7fTrrspObcJtYToyxzmQ83ddUatkrp782
        I412Ug2O0T2LabQR9L44pyt7ByTCjlUWzC/c1dpXdyS8utNR9wKLyMTX8Unx+f8z+DwARv
        WO0Zdn6a7E/YDAcpoMQfPqwpXMT/93hX/za5ZrKmPhhMM0/jCdRHFB+1go3Kpw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633443116;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ydB2ctNol5Yfjy9cnuiA4Rdbqg/OB9Q2zTXfg20aLhQ=;
        b=uj5e+oWweI6zKS5dvXiAzTHFE6xvPSEBS9qFYIziTndaCAQlCvRB24gj1j74hVaat52OOi
        xjEf2ALI8RKDwfDg==
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
Message-ID: <163344311541.25758.118804039296753367.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b945efcdd07d86cece1cce68503aae91f107eacb
Gitweb:        https://git.kernel.org/tip/b945efcdd07d86cece1cce68503aae91f107eacb
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 29 Sep 2021 11:37:32 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Oct 2021 15:52:15 +02:00

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
index e33b03c..e47d7e5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6251,20 +6251,14 @@ static inline void sched_submit_work(struct task_struct *tsk)
 
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
