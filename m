Return-Path: <linux-tip-commits+bounces-2071-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 74AE8955B37
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 08:24:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2FD1C2824F8
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 06:24:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEFA72940D;
	Sun, 18 Aug 2024 06:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AyQfI687";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bsD3DQIJ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DBB617C6C;
	Sun, 18 Aug 2024 06:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723962195; cv=none; b=hf7GZEyhTJwVrJSuUfS+/DxasyF3LqiyczeWPkO60nTVqnpk00bIl4B6c5U8OfX0fEQXhK1337MtatQNgHjVIgkyjtRcsxVuZedPCpF+TDo2h1uGumKN87grClCYiMcQ46+GS3z+aPJ6aTIoNiAINJxISRIP4TlUmxyUBlJkFCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723962195; c=relaxed/simple;
	bh=ALaMhm9ZJy//W1kSfONVyU0+Hnx5PWdOr0EVh5yssMo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=O1ZOuekdrLH1v5/cnqIUWIRTmR/0Eny9fSCKvZF/BWHidHhtf5FRd8IVsr1ii9/NQPKWx3i3VnSL5jm/gIuuVkGpbofKoGSt8gxva2qpjaFY7PM937y3v8c/DBfryV+w1E7HrBXBS6Pa6y34fZH0i5pnqUkxdmFPTF7ANg/GODw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AyQfI687; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bsD3DQIJ; arc=none smtp.client-ip=193.142.43.55
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
	bh=rwdQjbJJSd8q8nv/3dz0bcYlVhFTM80MKqeeZfqvG2s=;
	b=AyQfI687gpBHNM6NMqgLJ/lLxBDR6T7YdpXmxcXjqYgt9IbGZJ5KWmPe8IIrYMIKXylkla
	Y3ZgTCIkqk5Yx8/d2Z4fZcvIGuR/TAis1MuvkxMaQEgq3NRAD4P6GmCNskd1+IIeiRRMNm
	Ooe75ksPer+j7rT9gXsISVuvMtZVdSEiE67I+3+EmUlbPJ9D4iQod9cg4v830okSGnTqu9
	r2HQyuv9lQ2V20eY9/vLRGUIGVx0gbSkRZh+gM8Oqt9sqCYn5om57KbIbNUJ/SgmBoqxzU
	iHADBoNJekXH4EziybKQi1g7qxvQxffbtt871DzSIBA+iwouuKIZFlnpsF3ZMg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723962190;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rwdQjbJJSd8q8nv/3dz0bcYlVhFTM80MKqeeZfqvG2s=;
	b=bsD3DQIJ5xAn/00I3QypRoMNA3J0/OhA3t4R4ZmevKpZFpGUGKPngx0Nap4pkttiroL9F9
	KTjAWdgr+/J0S9DQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Prepare generic code for delayed dequeue
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240727105029.200000445@infradead.org>
References: <20240727105029.200000445@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172396219016.2215.8323874093243356703.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     abc158c82ae555078aa5dd2d8407c3df0f868904
Gitweb:        https://git.kernel.org/tip/abc158c82ae555078aa5dd2d8407c3df0f868904
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 23 May 2024 10:55:59 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 17 Aug 2024 11:06:42 +02:00

sched: Prepare generic code for delayed dequeue

While most of the delayed dequeue code can be done inside the
sched_class itself, there is one location where we do not have an
appropriate hook, namely ttwu_runnable().

Add an ENQUEUE_DELAYED call to the on_rq path to deal with waking
delayed dequeue tasks.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lkml.kernel.org/r/20240727105029.200000445@infradead.org
---
 include/linux/sched.h |  1 +
 kernel/sched/core.c   | 14 +++++++++++++-
 kernel/sched/sched.h  |  2 ++
 3 files changed, 16 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2c1b4ee..f4a648e 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -544,6 +544,7 @@ struct sched_entity {
 
 	struct list_head		group_node;
 	unsigned int			on_rq;
+	unsigned int			sched_delayed;
 
 	u64				exec_start;
 	u64				sum_exec_runtime;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6c59548..7356464 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2036,6 +2036,8 @@ void activate_task(struct rq *rq, struct task_struct *p, int flags)
 
 void deactivate_task(struct rq *rq, struct task_struct *p, int flags)
 {
+	SCHED_WARN_ON(flags & DEQUEUE_SLEEP);
+
 	WRITE_ONCE(p->on_rq, TASK_ON_RQ_MIGRATING);
 	ASSERT_EXCLUSIVE_WRITER(p->on_rq);
 
@@ -3689,12 +3691,14 @@ static int ttwu_runnable(struct task_struct *p, int wake_flags)
 
 	rq = __task_rq_lock(p, &rf);
 	if (task_on_rq_queued(p)) {
+		update_rq_clock(rq);
+		if (p->se.sched_delayed)
+			enqueue_task(rq, p, ENQUEUE_NOCLOCK | ENQUEUE_DELAYED);
 		if (!task_on_cpu(rq, p)) {
 			/*
 			 * When on_rq && !on_cpu the task is preempted, see if
 			 * it should preempt the task that is current now.
 			 */
-			update_rq_clock(rq);
 			wakeup_preempt(rq, p, wake_flags);
 		}
 		ttwu_do_wakeup(p);
@@ -4074,11 +4078,16 @@ int try_to_wake_up(struct task_struct *p, unsigned int state, int wake_flags)
 		 * case the whole 'p->on_rq && ttwu_runnable()' case below
 		 * without taking any locks.
 		 *
+		 * Specifically, given current runs ttwu() we must be before
+		 * schedule()'s block_task(), as such this must not observe
+		 * sched_delayed.
+		 *
 		 * In particular:
 		 *  - we rely on Program-Order guarantees for all the ordering,
 		 *  - we're serialized against set_special_state() by virtue of
 		 *    it disabling IRQs (this allows not taking ->pi_lock).
 		 */
+		SCHED_WARN_ON(p->se.sched_delayed);
 		if (!ttwu_state_match(p, state, &success))
 			goto out;
 
@@ -4370,6 +4379,9 @@ static void __sched_fork(unsigned long clone_flags, struct task_struct *p)
 	p->se.slice			= sysctl_sched_base_slice;
 	INIT_LIST_HEAD(&p->se.group_node);
 
+	/* A delayed task cannot be in clone(). */
+	SCHED_WARN_ON(p->se.sched_delayed);
+
 #ifdef CONFIG_FAIR_GROUP_SCHED
 	p->se.cfs_rq			= NULL;
 #endif
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 69ab3b0..ffca977 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2253,6 +2253,7 @@ extern const u32		sched_prio_to_wmult[40];
 #define DEQUEUE_MOVE		0x04 /* Matches ENQUEUE_MOVE */
 #define DEQUEUE_NOCLOCK		0x08 /* Matches ENQUEUE_NOCLOCK */
 #define DEQUEUE_MIGRATING	0x100 /* Matches ENQUEUE_MIGRATING */
+#define DEQUEUE_DELAYED		0x200 /* Matches ENQUEUE_DELAYED */
 
 #define ENQUEUE_WAKEUP		0x01
 #define ENQUEUE_RESTORE		0x02
@@ -2268,6 +2269,7 @@ extern const u32		sched_prio_to_wmult[40];
 #endif
 #define ENQUEUE_INITIAL		0x80
 #define ENQUEUE_MIGRATING	0x100
+#define ENQUEUE_DELAYED		0x200
 
 #define RETRY_TASK		((void *)-1UL)
 

