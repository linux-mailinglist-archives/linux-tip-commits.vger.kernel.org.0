Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C35132FA15
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Mar 2021 12:43:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231208AbhCFLmi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 6 Mar 2021 06:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbhCFLm0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 6 Mar 2021 06:42:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86478C06175F;
        Sat,  6 Mar 2021 03:42:26 -0800 (PST)
Date:   Sat, 06 Mar 2021 11:42:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615030945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C6H6piEjBGlR8wU4rEqr3evbct1El17n5uaiw50IvQg=;
        b=UzKCtNLPve4vbVjFuhFFjV7qqoG7dVYeCnsRh7i0iClQhFeQ9QlRtt+OiTzqP6u73Z/6kp
        YI9AQUXS3rV8/AEboVif3qWUBCatGQ8dLrOL8dpoMpyMkNqJMiqDltRYdttk2tgdqH6i9t
        3XCfPekpVc+ClJRDtrjPMjJR87FGGhPoi7KQwLpAL2S5Lfgv7eSUTM+84MC6mxrOJ/TcmU
        ng39gVUcJenUGSDL18eBcFM2VAhDmGgtHNh6xX4n4yROj5KOgjNsfQtwj+hV6KKZCYPtm6
        15Yxj5o6Y5GzjkwV162zF38ICQEzU3qmS4xPLTWjg3mny68ik7NfSlOjHqE8dA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615030945;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=C6H6piEjBGlR8wU4rEqr3evbct1El17n5uaiw50IvQg=;
        b=mePWZlIrNmAPn594QY8U/VPxDN6BpLqo7FE60LZJJXgBKkLcjQ0+Tfo1GR8xaZDV9nicZp
        991xMP2huTQpHuAg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Simplify set_affinity_pending refcounts
Cc:     stable@kernel.org, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210224131355.724130207@infradead.org>
References: <20210224131355.724130207@infradead.org>
MIME-Version: 1.0
Message-ID: <161503094467.398.4366901836084388395.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     50caf9c14b1498c90cf808dbba2ca29bd32ccba4
Gitweb:        https://git.kernel.org/tip/50caf9c14b1498c90cf808dbba2ca29bd32ccba4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 24 Feb 2021 11:42:08 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 06 Mar 2021 12:40:21 +01:00

sched: Simplify set_affinity_pending refcounts

Now that we have set_affinity_pending::stop_pending to indicate if a
stopper is in progress, and we have the guarantee that if that stopper
exists, it will (eventually) complete our @pending we can simplify the
refcount scheme by no longer counting the stopper thread.

Fixes: 6d337eab041d ("sched: Fix migrate_disable() vs set_cpus_allowed_ptr()")
Cc: stable@kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210224131355.724130207@infradead.org
---
 kernel/sched/core.c | 32 ++++++++++++++++++++------------
 1 file changed, 20 insertions(+), 12 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4e4d100..9819121 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1862,6 +1862,10 @@ struct migration_arg {
 	struct set_affinity_pending	*pending;
 };
 
+/*
+ * @refs: number of wait_for_completion()
+ * @stop_pending: is @stop_work in use
+ */
 struct set_affinity_pending {
 	refcount_t		refs;
 	unsigned int		stop_pending;
@@ -1997,10 +2001,6 @@ out:
 	if (complete)
 		complete_all(&pending->done);
 
-	/* For pending->{arg,stop_work} */
-	if (pending && refcount_dec_and_test(&pending->refs))
-		wake_up_var(&pending->refs);
-
 	return 0;
 }
 
@@ -2199,12 +2199,16 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 			push_task = get_task_struct(p);
 		}
 
+		/*
+		 * If there are pending waiters, but no pending stop_work,
+		 * then complete now.
+		 */
 		pending = p->migration_pending;
-		if (pending) {
-			refcount_inc(&pending->refs);
+		if (pending && !pending->stop_pending) {
 			p->migration_pending = NULL;
 			complete = true;
 		}
+
 		task_rq_unlock(rq, p, rf);
 
 		if (push_task) {
@@ -2213,7 +2217,7 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 		}
 
 		if (complete)
-			goto do_complete;
+			complete_all(&pending->done);
 
 		return 0;
 	}
@@ -2264,9 +2268,9 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 		if (!stop_pending)
 			pending->stop_pending = true;
 
-		refcount_inc(&pending->refs); /* pending->{arg,stop_work} */
 		if (flags & SCA_MIGRATE_ENABLE)
 			p->migration_flags &= ~MDF_PUSH;
+
 		task_rq_unlock(rq, p, rf);
 
 		if (!stop_pending) {
@@ -2282,12 +2286,13 @@ static int affine_move_task(struct rq *rq, struct task_struct *p, struct rq_flag
 			if (task_on_rq_queued(p))
 				rq = move_queued_task(rq, rf, p, dest_cpu);
 
-			p->migration_pending = NULL;
-			complete = true;
+			if (!pending->stop_pending) {
+				p->migration_pending = NULL;
+				complete = true;
+			}
 		}
 		task_rq_unlock(rq, p, rf);
 
-do_complete:
 		if (complete)
 			complete_all(&pending->done);
 	}
@@ -2295,7 +2300,7 @@ do_complete:
 	wait_for_completion(&pending->done);
 
 	if (refcount_dec_and_test(&pending->refs))
-		wake_up_var(&pending->refs);
+		wake_up_var(&pending->refs); /* No UaF, just an address */
 
 	/*
 	 * Block the original owner of &pending until all subsequent callers
@@ -2303,6 +2308,9 @@ do_complete:
 	 */
 	wait_var_event(&my_pending.refs, !refcount_read(&my_pending.refs));
 
+	/* ARGH */
+	WARN_ON_ONCE(my_pending.stop_pending);
+
 	return 0;
 }
 
