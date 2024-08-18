Return-Path: <linux-tip-commits+bounces-2059-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 37542955B25
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 08:23:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A382E282501
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 06:23:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B5A81DF51;
	Sun, 18 Aug 2024 06:23:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Wph+7EYV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BBD0rETQ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B950BDDA8;
	Sun, 18 Aug 2024 06:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723962190; cv=none; b=gMM9Id1ZD+q+gvlPXCPZbQyG4yAoKiPOABaxpEHBZ0yIp4Ang0wAhXMNE9QXFfOIQPo6DAyZ+iCcctvQUIdGXH+eGQvtCrzNMTDfUY4FucsSwKebRueRu6apmUISMu1KzF0KEgb4fmNUUs0MDO9+7DWNdvZO2Mp79Xbm1wkvW6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723962190; c=relaxed/simple;
	bh=RdyDr3VxyQHcgvex/MInEbumP4rTBDD40D8tayU9M7Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RFXTbUFoouAqkI1Ml3FIaDPVDc+dmw1YOfn99OHOPvtaNB7FvbWWHauStQV/m3Ly1ab+KkL1JECG7GhGgnWKJW18vnn1wU1xseAhX1bJw8q7L6xRbK/WEKkIOY0TV6pBMBMFoiZch5Yf9pteuUa/gOiA24CxJEPBADPBUYCTY7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Wph+7EYV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BBD0rETQ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Aug 2024 06:23:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723962187;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GFmwJvtgs3uXEl33w4R7PgAbD365tb5JcdG8ytYSxDk=;
	b=Wph+7EYVvcVVgr5QbE0y0r/Wnzn4cgROG//Oy3T4WBgjEow5XvqoEaFj63tmrgel4KUj7f
	vEb67rwwErVY3om0TzCl1+E+uiIJIIpwugbfcuTFgNI4TwHM6Nt3K+m9BT3ilJ6KTxIdf8
	1O+6cNXorlLAi8Vxw8pzNrmwIGxX91BS7ts9GqWY435UeNqC9UWJJICmd9fII49J4D0EJq
	EfB4bq4O2H9MN6DjtxqN9trYoHJlFfuQ8pc2bFhxG04Rm8/AeOQ4VPWnA7vaixukofzDuZ
	smGQ+92KsVhGtAT9WlheLQDDHnH4KazfEPl9wjt48x00hX//c/5RkcDEdZaZVg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723962187;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GFmwJvtgs3uXEl33w4R7PgAbD365tb5JcdG8ytYSxDk=;
	b=BBD0rETQP8aCbQPwnXlYPkxe87vjvadYG92wbedtlQWiCWVcU6PBafYumxDkGky9jOmJKv
	UWCktxbPKUC1AmDw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Avoid re-setting virtual deadline on
 'migrations'
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240727105030.625119246@infradead.org>
References: <20240727105030.625119246@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172396218683.2215.5396748918559130323.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     82e9d0456e06cebe2c89f3c73cdbc9e3805e9437
Gitweb:        https://git.kernel.org/tip/82e9d0456e06cebe2c89f3c73cdbc9e3805e9437
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 31 May 2024 15:49:40 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 17 Aug 2024 11:06:45 +02:00

sched/fair: Avoid re-setting virtual deadline on 'migrations'

During OSPM24 Youssef noted that migrations are re-setting the virtual
deadline. Notably everything that does a dequeue-enqueue, like setting
nice, changing preferred numa-node, and a myriad of other random crap,
will cause this to happen.

This shouldn't be. Preserve the relative virtual deadline across such
dequeue/enqueue cycles.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lkml.kernel.org/r/20240727105030.625119246@infradead.org
---
 include/linux/sched.h   |  6 ++++--
 kernel/sched/fair.c     | 23 ++++++++++++++++++-----
 kernel/sched/features.h |  4 ++++
 3 files changed, 26 insertions(+), 7 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 8a3a389..d25e1cf 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -544,8 +544,10 @@ struct sched_entity {
 	u64				min_vruntime;
 
 	struct list_head		group_node;
-	unsigned int			on_rq;
-	unsigned int			sched_delayed;
+	unsigned char			on_rq;
+	unsigned char			sched_delayed;
+	unsigned char			rel_deadline;
+					/* hole */
 
 	u64				exec_start;
 	u64				sum_exec_runtime;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 0eb1bbf..fef0e1f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5270,6 +5270,12 @@ place_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 
 	se->vruntime = vruntime - lag;
 
+	if (sched_feat(PLACE_REL_DEADLINE) && se->rel_deadline) {
+		se->deadline += se->vruntime;
+		se->rel_deadline = 0;
+		return;
+	}
+
 	/*
 	 * When joining the competition; the existing tasks will be,
 	 * on average, halfway through their slice, as such start tasks
@@ -5382,23 +5388,24 @@ static __always_inline void return_cfs_rq_runtime(struct cfs_rq *cfs_rq);
 static bool
 dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
+	bool sleep = flags & DEQUEUE_SLEEP;
+
 	update_curr(cfs_rq);
 
 	if (flags & DEQUEUE_DELAYED) {
 		SCHED_WARN_ON(!se->sched_delayed);
 	} else {
-		bool sleep = flags & DEQUEUE_SLEEP;
-
+		bool delay = sleep;
 		/*
 		 * DELAY_DEQUEUE relies on spurious wakeups, special task
 		 * states must not suffer spurious wakeups, excempt them.
 		 */
 		if (flags & DEQUEUE_SPECIAL)
-			sleep = false;
+			delay = false;
 
-		SCHED_WARN_ON(sleep && se->sched_delayed);
+		SCHED_WARN_ON(delay && se->sched_delayed);
 
-		if (sched_feat(DELAY_DEQUEUE) && sleep &&
+		if (sched_feat(DELAY_DEQUEUE) && delay &&
 		    !entity_eligible(cfs_rq, se)) {
 			if (cfs_rq->next == se)
 				cfs_rq->next = NULL;
@@ -5429,6 +5436,11 @@ dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 	clear_buddies(cfs_rq, se);
 
 	update_entity_lag(cfs_rq, se);
+	if (sched_feat(PLACE_REL_DEADLINE) && !sleep) {
+		se->deadline -= se->vruntime;
+		se->rel_deadline = 1;
+	}
+
 	if (se != cfs_rq->curr)
 		__dequeue_entity(cfs_rq, se);
 	se->on_rq = 0;
@@ -12992,6 +13004,7 @@ static void switched_from_fair(struct rq *rq, struct task_struct *p)
 	if (p->se.sched_delayed) {
 		dequeue_task(rq, p, DEQUEUE_NOCLOCK | DEQUEUE_SLEEP);
 		p->se.sched_delayed = 0;
+		p->se.rel_deadline = 0;
 		if (sched_feat(DELAY_ZERO) && p->se.vlag > 0)
 			p->se.vlag = 0;
 	}
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 7fdeb55..caa4d72 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -10,6 +10,10 @@ SCHED_FEAT(PLACE_LAG, true)
  */
 SCHED_FEAT(PLACE_DEADLINE_INITIAL, true)
 /*
+ * Preserve relative virtual deadline on 'migration'.
+ */
+SCHED_FEAT(PLACE_REL_DEADLINE, true)
+/*
  * Inhibit (wakeup) preemption until the current task has either matched the
  * 0-lag point or until is has exhausted it's slice.
  */

