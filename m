Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30D623974F1
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jun 2021 16:05:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234292AbhFAOGl (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 1 Jun 2021 10:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234145AbhFAOGk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 1 Jun 2021 10:06:40 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EB7EC061574;
        Tue,  1 Jun 2021 07:04:59 -0700 (PDT)
Date:   Tue, 01 Jun 2021 14:04:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622556297;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qsSksMoFHb71KZ6Gzl6UA6wkKqMUMNN0rd8LNXFyD7w=;
        b=YxuVap3e8GlSaquoaEVc6nQg3kRoW/erF7ID0v8ueuadzIZQf6tfXa0cqWer6+65A5UI+d
        R2L7YfFtUHl4Y4Up4aV4TwS+/4Jd3YqR85ZVcrx3FEHh2XyQDcR7lXjD0SjZv7nfTwap0U
        IhxjKRFazsFxGO9saJIt4Qme6EPgmIznnXcDvc21T8Y1v2b4pAx7LONyujVJdTTOZrHuBe
        P2O3f+wDjTWHmNspZgpHmnV2V9H9E/6G5XapkSr7nRXOguCp6YuuDAjWCEzYtzLDgPkch8
        yc9tEbDrmc6LPdRWHgA9QrWPs6Jx8zB//kcvy+IIlWz/LzI/PK7XGcvVzIpHNQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622556297;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qsSksMoFHb71KZ6Gzl6UA6wkKqMUMNN0rd8LNXFyD7w=;
        b=e5yas7IdFcexW0r0yMjwTfDybwJzsA0RIZsepNxhfmbjsmsa/cdOF7hvF1ywZATalm63Py
        yqiuCEXqp+EoXrCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched,init: Fix DEBUG_PREEMPT vs early boot
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Borislav Petkov <bp@alien8.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YLS4mbKUrA3Gnb4t@hirez.programming.kicks-ass.net>
References: <YLS4mbKUrA3Gnb4t@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <162255629704.29796.6291052814035637150.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     15faafc6b449777a85c0cf82dd8286c293fed4eb
Gitweb:        https://git.kernel.org/tip/15faafc6b449777a85c0cf82dd8286c293fed4eb
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 31 May 2021 12:21:13 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Jun 2021 16:00:11 +02:00

sched,init: Fix DEBUG_PREEMPT vs early boot

Extend 8fb12156b8db ("init: Pin init task to the boot CPU, initially")
to cover the new PF_NO_SETAFFINITY requirement.

While there, move wait_for_completion(&kthreadd_done) into kernel_init()
to make it absolutely clear it is the very first thing done by the init
thread.

Fixes: 570a752b7a9b ("lib/smp_processor_id: Use is_percpu_thread() instead of nr_cpus_allowed")
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Borislav Petkov <bp@alien8.de>
Link: https://lkml.kernel.org/r/YLS4mbKUrA3Gnb4t@hirez.programming.kicks-ass.net
---
 init/main.c         | 11 ++++++-----
 kernel/sched/core.c |  1 +
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/init/main.c b/init/main.c
index 7b027d9..e945ec8 100644
--- a/init/main.c
+++ b/init/main.c
@@ -692,6 +692,7 @@ noinline void __ref rest_init(void)
 	 */
 	rcu_read_lock();
 	tsk = find_task_by_pid_ns(pid, &init_pid_ns);
+	tsk->flags |= PF_NO_SETAFFINITY;
 	set_cpus_allowed_ptr(tsk, cpumask_of(smp_processor_id()));
 	rcu_read_unlock();
 
@@ -1440,6 +1441,11 @@ static int __ref kernel_init(void *unused)
 {
 	int ret;
 
+	/*
+	 * Wait until kthreadd is all set-up.
+	 */
+	wait_for_completion(&kthreadd_done);
+
 	kernel_init_freeable();
 	/* need to finish all async __init code before freeing the memory */
 	async_synchronize_full();
@@ -1520,11 +1526,6 @@ void __init console_on_rootfs(void)
 
 static noinline void __init kernel_init_freeable(void)
 {
-	/*
-	 * Wait until kthreadd is all set-up.
-	 */
-	wait_for_completion(&kthreadd_done);
-
 	/* Now the scheduler is fully set up and can do blocking allocations */
 	gfp_allowed_mask = __GFP_BITS_MASK;
 
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3d25272..e205c19 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8862,6 +8862,7 @@ void __init sched_init_smp(void)
 	/* Move init over to a non-isolated CPU */
 	if (set_cpus_allowed_ptr(current, housekeeping_cpumask(HK_FLAG_DOMAIN)) < 0)
 		BUG();
+	current->flags &= ~PF_NO_SETAFFINITY;
 	sched_init_granularity();
 
 	init_sched_rt_class();
