Return-Path: <linux-tip-commits+bounces-2836-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E9749C3C8D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 Nov 2024 11:59:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92B341C2182B
	for <lists+linux-tip-commits@lfdr.de>; Mon, 11 Nov 2024 10:59:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7599517DFE3;
	Mon, 11 Nov 2024 10:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FHVWo129";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/aVHiWJU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 977A1176FB6;
	Mon, 11 Nov 2024 10:59:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731322752; cv=none; b=qi7Zql+YuZ6sLusLMRUPO20Og5NqMEcSU5vfnxOxYkTj7IZjgIrGkvdlOHL4GSMb88PtUZGvyxX0FP4+oUUkEVxPd0XKTm8IhDZZIIDSHwc1r0NgLx+I/pwuEmd6MCBmfpn12A38ARBugUuOAH/xc47fOAe6RYmWLUJ+KdZeq6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731322752; c=relaxed/simple;
	bh=cWH535Kro+fECzp4GXr8lIwOs/kcHV+gZIf503dDNkA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=WQM+cnCScSapxcvkn2q/RZNVxfObeUSPZWpqIxhbzHS5gWzbETtCbgTlwST4PqjRQ57chUxArI6OtqF7s4kTSgP1+edPmZfFPet22jSQmwdLRglmrMBoNLFe20cXy03Zdyx1q15Rkfj1QQhnHs00MyeHTxaiZiLG3SEYhVR9WdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FHVWo129; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/aVHiWJU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 11 Nov 2024 10:59:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731322749;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yHvQiI/81VdjJP/cSUFTrLyvQChOt+GHTyGAlWg02zU=;
	b=FHVWo129lzZpq67Sx/MBequGcDr0ALRcGp22MGvdtjoGknyE4Fgb5Qg50IJ1DkNE+gsBlz
	4FtTBs++KI+KCrTttTYD7DeKwsvPSw2kn2eAbE2tIktM7EhlUeor3s26CAiPQRNhrWd7y9
	m7cGPa1uojlHkARUEj6zN6Qw8rPICbE1GrXgaN/swRLq+hp/41ZGN1XbcbT3YBY0gm1sT9
	mhZZBDBwSI4dyf2Sr1u2O3+p1r4P40lGBhp6NKlLM3cSptmwb/PgWfm480lQEdKUihTOZM
	PVXHLQxYTMGASg2PvYHqDHTYZ8gotzUp/nVwkRfXgY3y7kUHo9OqtVUEF4/Fig==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731322749;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yHvQiI/81VdjJP/cSUFTrLyvQChOt+GHTyGAlWg02zU=;
	b=/aVHiWJUYSPaCMmm098SMVa8ISnSaGHCU44Es13ckQ+DbgoWSkgdpTwdrjjkkwNUsaPb8z
	vVzGb44XuseMhYDg==
From: "tip-bot2 for Mike Galbraith" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Dequeue sched_delayed tasks when
 waking to a busy CPU
Cc: Phil Auld <pauld@redhat.com>, Jirka Hladky <jhladky@redhat.com>,
 Mike Galbraith <efault@gmx.de>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241101124715.GA689589@pauld.westford.=>
References: <20241101124715.GA689589@pauld.westford.=>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173132274823.32228.8453262160345981520.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     d68803506ffb4f72cbeaea94a3a745a6faf62bdd
Gitweb:        https://git.kernel.org/tip/d68803506ffb4f72cbeaea94a3a745a6faf62bdd
Author:        Mike Galbraith <efault@gmx.de>
AuthorDate:    Fri, 08 Nov 2024 01:24:35 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 11 Nov 2024 11:49:44 +01:00

sched/fair: Dequeue sched_delayed tasks when waking to a busy CPU

Phil Auld (Redhat) reported an fio benchmark regression having been found
to have been caused by addition of the DELAY_DEQUEUE feature, suggested it
may be related to wakees losing the ability to migrate, and confirmed that
restoration of same indeed did restore previous performance.

(de-uglified-a-lot-by)

Fixes: 152e11f6df29 ("sched/fair: Implement delayed dequeue")
Reported-by: Phil Auld <pauld@redhat.com>
Suggested-by: Phil Auld <pauld@redhat.com>
Reviewed-by: Phil Auld <pauld@redhat.com>
Tested-by: Jirka Hladky <jhladky@redhat.com>
Signed-off-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/lkml/20241101124715.GA689589@pauld.westford.=
 kernel/sched/core.c  |   48 +++++++++++++++++++++++++++++-------------------
 kernel/sched/sched.h |    5 +++++
 2 files changed, 34 insertions(+), 19 deletions(-)
---
 kernel/sched/core.c  | 46 ++++++++++++++++++++++++++-----------------
 kernel/sched/sched.h |  5 +++++-
 2 files changed, 33 insertions(+), 18 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 719e0ed..b35752f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -3734,28 +3734,38 @@ ttwu_do_activate(struct rq *rq, struct task_struct *p, int wake_flags,
  */
 static int ttwu_runnable(struct task_struct *p, int wake_flags)
 {
-	struct rq_flags rf;
-	struct rq *rq;
-	int ret = 0;
+	CLASS(__task_rq_lock, rq_guard)(p);
+	struct rq *rq = rq_guard.rq;
 
-	rq = __task_rq_lock(p, &rf);
-	if (task_on_rq_queued(p)) {
-		update_rq_clock(rq);
-		if (p->se.sched_delayed)
-			enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_DELAYED);
-		if (!task_on_cpu(rq, p)) {
-			/*
-			 * When on_rq && !on_cpu the task is preempted, see if
-			 * it should preempt the task that is current now.
-			 */
-			wakeup_preempt(rq, p, wake_flags);
+	if (!task_on_rq_queued(p))
+		return 0;
+
+	update_rq_clock(rq);
+	if (p->se.sched_delayed) {
+		int queue_flags = ENQUEUE_DELAYED | ENQUEUE_NOCLOCK;
+
+		/*
+		 * Since sched_delayed means we cannot be current anywhere,
+		 * dequeue it here and have it fall through to the
+		 * select_task_rq() case further along the ttwu() path.
+		 */
+		if (rq->nr_running > 1 && p->nr_cpus_allowed > 1) {
+			dequeue_task(rq, p, DEQUEUE_SLEEP | queue_flags);
+			return 0;
 		}
-		ttwu_do_wakeup(p);
-		ret = 1;
+
+		enqueue_task(rq, p, queue_flags);
 	}
-	__task_rq_unlock(rq, &rf);
+	if (!task_on_cpu(rq, p)) {
+		/*
+		 * When on_rq && !on_cpu the task is preempted, see if
+		 * it should preempt the task that is current now.
+		 */
+		wakeup_preempt(rq, p, wake_flags);
+	}
+	ttwu_do_wakeup(p);
 
-	return ret;
+	return 1;
 }
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 6c54a57..97f7936 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1779,6 +1779,11 @@ task_rq_unlock(struct rq *rq, struct task_struct *p, struct rq_flags *rf)
 	raw_spin_unlock_irqrestore(&p->pi_lock, rf->flags);
 }
 
+DEFINE_LOCK_GUARD_1(__task_rq_lock, struct task_struct,
+		    _T->rq = __task_rq_lock(_T->lock, &_T->rf),
+		    __task_rq_unlock(_T->rq, &_T->rf),
+		    struct rq *rq; struct rq_flags rf)
+
 DEFINE_LOCK_GUARD_1(task_rq_lock, struct task_struct,
 		    _T->rq = task_rq_lock(_T->lock, &_T->rf),
 		    task_rq_unlock(_T->rq, _T->lock, &_T->rf),

