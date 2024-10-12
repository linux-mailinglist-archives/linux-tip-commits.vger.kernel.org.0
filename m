Return-Path: <linux-tip-commits+bounces-2402-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5375599B56B
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Oct 2024 16:16:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D7A681F22A1A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Oct 2024 14:16:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 551F7198E8C;
	Sat, 12 Oct 2024 14:16:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="f8ernEGr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xomZHxTv"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8568519308A;
	Sat, 12 Oct 2024 14:16:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728742571; cv=none; b=T2mLI2a54hk6JHLtcVfPwAKGgYpOjJJ8yYb5MymEwalYalO71IDc+HTw1zNK+vFnOucmbPu1xBwucw0ucQEwmpLaWXas8yJNiednHIieRNFk9Hv9j/AMcBtnam1mZcMM5N44ykz33IE6Er4vvxEmYbO3sDPZP6I+xl/+jaYmBNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728742571; c=relaxed/simple;
	bh=0/RYzvGUFbsFfj1sMdP8Wd5qYESLnW6fb8beS5GdiHc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kdD+MfxGoK6jymZk49pRwqXsA6QNr8YAhoQAvBysAulfX5t3a4yNU2U+4Zcd7N7XnKYcdMqbflmHx0EcsoTsFVCztmOBODAwYWARhEGMzv7L5MSGbzXYOdGUP7QaqdM8UByIodbZtIKCRFRqwNRTDtZxt5ig8avTFHUPv9Z5atM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=f8ernEGr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xomZHxTv; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 12 Oct 2024 14:16:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728742561;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p1pXOBoxjzU9nr3rsWS4V0LQmNtm59zMFSsKrkGALt0=;
	b=f8ernEGripD1ounHBLUxcLPA7Oks5NdZaglzNRnmhyvcccxc+WUuF5frqJl4ITiZXhbClq
	jFsgazwWXhrnFT2lDMn5PzNL/qjuMlk8B2S4etrrqXCp09PbSUIFbEOgcHf5r+HExxuQFS
	lQ9Qm3zbDl+UBxAeQN2+DjEWytg7fgxUEOCxesWx9yS3hVi5aHl/ePlWyJMtAxXHrvUSQW
	+RzYhAqL/aZCSttA7dZpyd4J6qQOdfB8CbmzRxvoacxgClJ5C4NOTy2TBBd2cUkBKNh+vz
	31c1fSrNp9cq+55MJd+ao7LS6OHx3Pa74kI8pq+h+MBvuiUwE9X31gb7qexh7w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728742561;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=p1pXOBoxjzU9nr3rsWS4V0LQmNtm59zMFSsKrkGALt0=;
	b=xomZHxTvClWcz0pt7o3ThCLPtXIiF/lvjRyNdU3Q9FeXsSiiCapEtLRg3CnDuD9gef7xbb
	4M7HtKzNcqC2itDQ==
From: "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/urgent] sched/core: Disable page allocation in task_tick_mm_cid()
Cc: Waiman Long <longman@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241010014432.194742-1-longman@redhat.com>
References: <20241010014432.194742-1-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172874256094.1442.15152934978604510984.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     73ab05aa46b02d96509cb029a8d04fca7bbde8c7
Gitweb:        https://git.kernel.org/tip/73ab05aa46b02d96509cb029a8d04fca7bbde8c7
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Wed, 09 Oct 2024 21:44:32 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 11 Oct 2024 10:49:32 +02:00

sched/core: Disable page allocation in task_tick_mm_cid()

With KASAN and PREEMPT_RT enabled, calling task_work_add() in
task_tick_mm_cid() may cause the following splat.

[   63.696416] BUG: sleeping function called from invalid context at kernel/locking/spinlock_rt.c:48
[   63.696416] in_atomic(): 1, irqs_disabled(): 1, non_block: 0, pid: 610, name: modprobe
[   63.696416] preempt_count: 10001, expected: 0
[   63.696416] RCU nest depth: 1, expected: 1

This problem is caused by the following call trace.

  sched_tick() [ acquire rq->__lock ]
   -> task_tick_mm_cid()
    -> task_work_add()
     -> __kasan_record_aux_stack()
      -> kasan_save_stack()
       -> stack_depot_save_flags()
        -> alloc_pages_mpol_noprof()
         -> __alloc_pages_noprof()
	  -> get_page_from_freelist()
	   -> rmqueue()
	    -> rmqueue_pcplist()
	     -> __rmqueue_pcplist()
	      -> rmqueue_bulk()
	       -> rt_spin_lock()

The rq lock is a raw_spinlock_t. We can't sleep while holding
it. IOW, we can't call alloc_pages() in stack_depot_save_flags().

The task_tick_mm_cid() function with its task_work_add() call was
introduced by commit 223baf9d17f2 ("sched: Fix performance regression
introduced by mm_cid") in v6.4 kernel.

Fortunately, there is a kasan_record_aux_stack_noalloc() variant that
calls stack_depot_save_flags() while not allowing it to allocate
new pages.  To allow task_tick_mm_cid() to use task_work without
page allocation, a new TWAF_NO_ALLOC flag is added to enable calling
kasan_record_aux_stack_noalloc() instead of kasan_record_aux_stack()
if set. The task_tick_mm_cid() function is modified to add this new flag.

The possible downside is the missing stack trace in a KASAN report due
to new page allocation required when task_work_add_noallloc() is called
which should be rare.

Fixes: 223baf9d17f2 ("sched: Fix performance regression introduced by mm_cid")
Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20241010014432.194742-1-longman@redhat.com
---
 include/linux/task_work.h |  5 ++++-
 kernel/sched/core.c       |  4 +++-
 kernel/task_work.c        | 15 +++++++++++++--
 3 files changed, 20 insertions(+), 4 deletions(-)

diff --git a/include/linux/task_work.h b/include/linux/task_work.h
index cf5e7e8..2964171 100644
--- a/include/linux/task_work.h
+++ b/include/linux/task_work.h
@@ -14,11 +14,14 @@ init_task_work(struct callback_head *twork, task_work_func_t func)
 }
 
 enum task_work_notify_mode {
-	TWA_NONE,
+	TWA_NONE = 0,
 	TWA_RESUME,
 	TWA_SIGNAL,
 	TWA_SIGNAL_NO_IPI,
 	TWA_NMI_CURRENT,
+
+	TWA_FLAGS = 0xff00,
+	TWAF_NO_ALLOC = 0x0100,
 };
 
 static inline bool task_work_pending(struct task_struct *task)
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 43e453a..0259301 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -10458,7 +10458,9 @@ void task_tick_mm_cid(struct rq *rq, struct task_struct *curr)
 		return;
 	if (time_before(now, READ_ONCE(curr->mm->mm_cid_next_scan)))
 		return;
-	task_work_add(curr, work, TWA_RESUME);
+
+	/* No page allocation under rq lock */
+	task_work_add(curr, work, TWA_RESUME | TWAF_NO_ALLOC);
 }
 
 void sched_mm_cid_exit_signals(struct task_struct *t)
diff --git a/kernel/task_work.c b/kernel/task_work.c
index 5d14d63..c969f1f 100644
--- a/kernel/task_work.c
+++ b/kernel/task_work.c
@@ -55,15 +55,26 @@ int task_work_add(struct task_struct *task, struct callback_head *work,
 		  enum task_work_notify_mode notify)
 {
 	struct callback_head *head;
+	int flags = notify & TWA_FLAGS;
 
+	notify &= ~TWA_FLAGS;
 	if (notify == TWA_NMI_CURRENT) {
 		if (WARN_ON_ONCE(task != current))
 			return -EINVAL;
 		if (!IS_ENABLED(CONFIG_IRQ_WORK))
 			return -EINVAL;
 	} else {
-		/* record the work call stack in order to print it in KASAN reports */
-		kasan_record_aux_stack(work);
+		/*
+		 * Record the work call stack in order to print it in KASAN
+		 * reports.
+		 *
+		 * Note that stack allocation can fail if TWAF_NO_ALLOC flag
+		 * is set and new page is needed to expand the stack buffer.
+		 */
+		if (flags & TWAF_NO_ALLOC)
+			kasan_record_aux_stack_noalloc(work);
+		else
+			kasan_record_aux_stack(work);
 	}
 
 	head = READ_ONCE(task->task_works);

