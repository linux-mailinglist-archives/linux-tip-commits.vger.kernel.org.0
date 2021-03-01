Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47FFD327BC3
	for <lists+linux-tip-commits@lfdr.de>; Mon,  1 Mar 2021 11:17:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232644AbhCAKRN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 1 Mar 2021 05:17:13 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:58290 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232585AbhCAKQ7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 1 Mar 2021 05:16:59 -0500
Date:   Mon, 01 Mar 2021 10:16:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614593776;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nj6PioAslSykKWd8ZPvmEGlcXDdfiGHUb/x4ungTxwM=;
        b=0LAfyK3G87SejY/r6fquUCMWu4HP8Nfe+NI1wkdmKx/vnCo31DnWefEOqhbUSCOvQmZbQh
        zaviy2WJCrstChp9caHR5CLFwifZIgf5uokSHEHpGUN1xwvYP5jSazJdy+ei4FC6NcHwUu
        45PK5Dh7dyKxErbUhytEDniDcBZt0hM9DnZ3qCuxT4O3k85a5fUTNeVjPHTeMjfi3H3pEz
        cjtJALAVr/Ar0ePjrjZKVwA52y8a+ssS972HuOf6dg1hzIvF+r7vsk852G+1EB0SG8E+Nl
        V04gXhU++gC8yG2QbQItQOkrET0AADTj4aoAJeKfwJWhmLF/HjT+xjjrfNkI7A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614593776;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Nj6PioAslSykKWd8ZPvmEGlcXDdfiGHUb/x4ungTxwM=;
        b=my9MXwW4hjonwFUKEqwGXWSHlfS9aQ74+5pMKyfKVA8WcOoqsm4aLsAakg3iK1UCWC5v8i
        beKcc0STdqoV+3AA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Simplify set_affinity_pending refcounts
Cc:     stable@kernel.org, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210224131355.724130207@infradead.org>
References: <20210224131355.724130207@infradead.org>
MIME-Version: 1.0
Message-ID: <161459377628.20312.17557474951313290119.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     a4c2579076dc6951709a8e425df8369ab6eb2f24
Gitweb:        https://git.kernel.org/tip/a4c2579076dc6951709a8e425df8369ab6eb2f24
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 24 Feb 2021 11:42:08 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 01 Mar 2021 11:02:15 +01:00

sched: Simplify set_affinity_pending refcounts

Now that we have set_affinity_pending::stop_pending to indicate if a
stopper is in progress, and we have the guarantee that if that stopper
exists, it will (eventually) complete our @pending we can simplify the
refcount scheme by no longer counting the stopper thread.

Fixes: 6d337eab041d ("sched: Fix migrate_disable() vs set_cpus_allowed_ptr()")
Cc: stable@kernel.org
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
 
