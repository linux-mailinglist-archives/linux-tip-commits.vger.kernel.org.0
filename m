Return-Path: <linux-tip-commits+bounces-2074-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BA78F955B42
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 08:25:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 722B028241D
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 06:25:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C0B85A4D5;
	Sun, 18 Aug 2024 06:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vbLzurhf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lrBxl4ck"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33A9FD515;
	Sun, 18 Aug 2024 06:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723962197; cv=none; b=Czzh7oSYJC5qoeFbCTw4Qnl9J7mMB6yhftNBHePR8UVDrMhFwNZM5ISwnHBAvo1fbiJV/cffX+5T6XzRHCQiHRvT+uXstbagdMHEshJSDgWpDnuWV4+j5o0pFIsGr0Aumf8SAXxe1Plu4b7sRg6gHwVS0vhbyEuzgdaTkucNj5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723962197; c=relaxed/simple;
	bh=X8CY9J27VU8jyCPOJz2P49GeywH6QfeqjQkktptaqaQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=W2WzNrzIHR0k0HkmcFU2SaHtmPolzzNGxukpEk4C/qRNOjzT3NfvQmx+0N2BuCjwmXRlIYXwvT3YLQ9N2qNYHuvcau3kQuf44HreBzmwenA++FdQEKhq5veYsykGyfrcPiD0Amd8ZsnKrAUvPpEcVEzKUHsynu2FJRovUU6l76E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vbLzurhf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lrBxl4ck; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Aug 2024 06:23:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723962190;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=btsDmRhV9p4TtztzcGS8KU/hzvDIlCUcdKoqZVj2tPk=;
	b=vbLzurhfyqSd7jF0F/VUc1ITF7kDt1O5VJLeyfv2jaAITkJTXNvJQmOVWIxHAV+rkczHpX
	anRfxsyUXICG+Hkuhxg3q66SxEF46pT91f2STAYR+rRfQ5Hd/XrJ8Ug8zdW4s8/PvbEOkC
	CGC1ZUe5fRW/DNl4nSA2zIgiqBljaxzv2maQnWoTs9BU74FXw9OMZCq7myY3xhrA3q3Cuv
	MYtVdQzfBhkZeFt8A8lBcUZXImcSo0gSu0vPPXDZWjadRhC9p4kzwiH+wDskOYC7MItP2z
	i1O/MPbt6afS/DO7ulHo/RWpI9fkAq3/NcMjyi3Bu7Jw0XTO4Py6AAeArvBj1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723962190;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=btsDmRhV9p4TtztzcGS8KU/hzvDIlCUcdKoqZVj2tPk=;
	b=lrBxl4ckVvYNVVMgaNfMvGVTke6SLEjMfFHbxNzJUF5QvzvBAHGweEz2borolAB//1dbcl
	HcxKZM18LTK/TCBg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Split DEQUEUE_SLEEP from deactivate_task()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240727105029.086192709@infradead.org>
References: <20240727105029.086192709@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172396219044.2215.7184290613591661064.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e8901061ca0cd9acbd3d29d41d16c69c2bfff9f0
Gitweb:        https://git.kernel.org/tip/e8901061ca0cd9acbd3d29d41d16c69c2bfff9f0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 23 May 2024 10:48:09 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 17 Aug 2024 11:06:42 +02:00

sched: Split DEQUEUE_SLEEP from deactivate_task()

As a preparation for dequeue_task() failing, and a second code-path
needing to take care of the 'success' path, split out the DEQEUE_SLEEP
path from deactivate_task().

Much thanks to Libo for spotting and fixing a TASK_ON_RQ_MIGRATING
ordering fail.

Fixed-by: Libo Chen <libo.chen@oracle.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lkml.kernel.org/r/20240727105029.086192709@infradead.org
---
 kernel/sched/core.c  | 23 +++++++++++++----------
 kernel/sched/sched.h | 14 ++++++++++++++
 2 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4f7a4e9..6c59548 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2036,12 +2036,23 @@ void activate_task(struct rq *rq, struct task_struct *p, int flags)
 
 void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
 {
-	WRITE_ONCE(p->on_rq, (flags & DEQUEUE_SLEEP) ? 0 : TASK_ON_RQ_MIGRATING);
+	WRITE_ONCE(p->on_rq, TASK_ON_RQ_MIGRATING);
 	ASSERT_EXCLUSIVE_WRITER(p->on_rq);
 
+	/*
+	 * Code explicitly relies on TASK_ON_RQ_MIGRATING begin set *before*
+	 * dequeue_task() and cleared *after* enqueue_task().
+	 */
+
 	dequeue_task(rq, p, flags);
 }
 
+static void block_task(struct rq *rq, struct task_struct *p, int flags)
+{
+	if (dequeue_task(rq, p, DEQUEUE_SLEEP | flags))
+		__block_task(rq, p);
+}
+
 /**
  * task_curr - is this task currently executing on a CPU?
  * @p: the task in question.
@@ -6498,9 +6509,6 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 				!(prev_state & TASK_NOLOAD) &&
 				!(prev_state & TASK_FROZEN);
 
-			if (prev->sched_contributes_to_load)
-				rq->nr_uninterruptible++;
-
 			/*
 			 * __schedule()			ttwu()
 			 *   prev_state = prev->state;    if (p->on_rq && ...)
@@ -6512,12 +6520,7 @@ static void __sched notrace __schedule(unsigned int sched_mode)
 			 *
 			 * After this, schedule() must not care about p->state any more.
 			 */
-			deactivate_task(rq, prev, DEQUEUE_SLEEP | DEQUEUE_NOCLOCK);
-
-			if (prev->in_iowait) {
-				atomic_inc(&rq->nr_iowait);
-				delayacct_blkio_start();
-			}
+			block_task(rq, prev, DEQUEUE_NOCLOCK);
 		}
 		switch_count = &prev->nvcsw;
 	}
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6196f90..69ab3b0 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -68,6 +68,7 @@
 #include <linux/wait_api.h>
 #include <linux/wait_bit.h>
 #include <linux/workqueue_api.h>
+#include <linux/delayacct.h>
 
 #include <trace/events/power.h>
 #include <trace/events/sched.h>
@@ -2585,6 +2586,19 @@ static inline void sub_nr_running(struct rq *rq, unsigned count)
 	sched_update_tick_dependency(rq);
 }
 
+static inline void __block_task(struct rq *rq, struct task_struct *p)
+{
+	WRITE_ONCE(p->on_rq, 0);
+	ASSERT_EXCLUSIVE_WRITER(p->on_rq);
+	if (p->sched_contributes_to_load)
+		rq->nr_uninterruptible++;
+
+	if (p->in_iowait) {
+		atomic_inc(&rq->nr_iowait);
+		delayacct_blkio_start();
+	}
+}
+
 extern void activate_task(struct rq *rq, struct task_struct *p, int flags);
 extern void deactivate_task(struct rq *rq, struct task_struct *p, int flags);
 

