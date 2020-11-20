Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BC732BAA35
	for <lists+linux-tip-commits@lfdr.de>; Fri, 20 Nov 2020 13:34:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728156AbgKTMeN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 20 Nov 2020 07:34:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728136AbgKTMeM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 20 Nov 2020 07:34:12 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 295CCC0617A7;
        Fri, 20 Nov 2020 04:34:12 -0800 (PST)
Date:   Fri, 20 Nov 2020 12:34:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605875650;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=adTR/ZzEE9+Fki0waYDdfgexZDXUHJMWOJkKEONpXEw=;
        b=nXCt3Amp5jZWylNYZfsbFRVTSAB9WOeUZ96a+kdCN5YlvcH1PyooYOgYUxky5Rqvwzhb1X
        FfWAuhPQXx0l/G1XwEUFh/IvYUnZRFvaCQK0kS6BsgpOKw9DsNEBh/Sktu9rlUziO47lxv
        Oowb/gYFwDnso2j/lAdkvlBmo8ssHCaUCYEJgaPrUD6ZOt2ZYXdBZq+WIM1VIsBDUYebNr
        Jp9HpdV63DoJUr1hIyWDRUeJZ9tq41yw09RksR0wYOasH3u+9GPgyYkM+MY+BrJGilZY9c
        Co09DBwFWeZsCfNFelyMHPtAlHCpt/xzuGHaXK/+NLYxkJDxfV/IF4zhPvbKAw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605875650;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=adTR/ZzEE9+Fki0waYDdfgexZDXUHJMWOJkKEONpXEw=;
        b=aUtusVr1PONTEDgwX+9pB9bf1+Pzi/og5RUXO5eWIO3WOo9N63Pe0NRVVH6HP8aBMTDLW8
        OdoCDYkq0I8xDJAg==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/core: Add missing completion for
 affine_move_task() waiters
Cc:     Qian Cai <cai@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <8b62fd1ad1b18def27f18e2ee2df3ff5b36d0762.camel@redhat.com>
References: <8b62fd1ad1b18def27f18e2ee2df3ff5b36d0762.camel@redhat.com>
MIME-Version: 1.0
Message-ID: <160587564979.11244.16095006261523066823.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     d707faa64d03d26b529cc4aea59dab1b016d4d33
Gitweb:        https://git.kernel.org/tip/d707faa64d03d26b529cc4aea59dab1b016d4d33
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Fri, 13 Nov 2020 11:24:14 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 19 Nov 2020 11:25:45 +01:00

sched/core: Add missing completion for affine_move_task() waiters

Qian reported that some fuzzer issuing sched_setaffinity() ends up stuck on
a wait_for_completion(). The problematic pattern seems to be:

  affine_move_task()
      // task_running() case
      stop_one_cpu();
      wait_for_completion(&pending->done);

Combined with, on the stopper side:

  migration_cpu_stop()
    // Task moved between unlocks and scheduling the stopper
    task_rq(p) != rq &&
    // task_running() case
    dest_cpu >= 0

    => no complete_all()

This can happen with both PREEMPT and !PREEMPT, although !PREEMPT should
be more likely to see this given the targeted task has a much bigger window
to block and be woken up elsewhere before the stopper runs.

Make migration_cpu_stop() always look at pending affinity requests; signal
their completion if the stopper hits a rq mismatch but the task is
still within its allowed mask. When Migrate-Disable isn't involved, this
matches the previous set_cpus_allowed_ptr() vs migration_cpu_stop()
behaviour.

Fixes: 6d337eab041d ("sched: Fix migrate_disable() vs set_cpus_allowed_ptr()")
Reported-by: Qian Cai <cai@redhat.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/lkml/8b62fd1ad1b18def27f18e2ee2df3ff5b36d0762.camel@redhat.com
---
 kernel/sched/core.c | 13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a6aaf9f..4d1fd4b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1923,7 +1923,7 @@ static int migration_cpu_stop(void *data)
 		else
 			p->wake_cpu = dest_cpu;
 
-	} else if (dest_cpu < 0) {
+	} else if (dest_cpu < 0 || pending) {
 		/*
 		 * This happens when we get migrated between migrate_enable()'s
 		 * preempt_enable() and scheduling the stopper task. At that
@@ -1934,6 +1934,17 @@ static int migration_cpu_stop(void *data)
 		 */
 
 		/*
+		 * The task moved before the stopper got to run. We're holding
+		 * ->pi_lock, so the allowed mask is stable - if it got
+		 * somewhere allowed, we're done.
+		 */
+		if (pending && cpumask_test_cpu(task_cpu(p), p->cpus_ptr)) {
+			p->migration_pending = NULL;
+			complete = true;
+			goto out;
+		}
+
+		/*
 		 * When this was migrate_enable() but we no longer have an
 		 * @pending, a concurrent SCA 'fixed' things and we should be
 		 * valid again. Nothing to do.
