Return-Path: <linux-tip-commits+bounces-2069-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E695955B34
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 08:24:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C67421F21132
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 06:24:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 18F431CA8D;
	Sun, 18 Aug 2024 06:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Xu7ZpBgJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="n9EGqr8S"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DE116426;
	Sun, 18 Aug 2024 06:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723962195; cv=none; b=MC+DNi0fXuezw2ZKAlbvUTWm5iebN4rNX8OIMKeg8d7rrGNbjgG5QvUm+nRUbJ2MiLtqPufy2b1vrqShSBoEsQDeEF+WLfjTZzfKgUeTTq1qydwEdPDPO6otlQv/VUUQ/68oqJBS4HOZjHHFY1ctF6A45DL1PrV+0JDKI5ZZ77M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723962195; c=relaxed/simple;
	bh=GqoQ8HfJa3o5E9VB00tGAdfSqdThxXcMXTOKGp/UCeQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UGFl45FYL+PfOUisylqZ24muYhCc2Q7lysvn1lV/00H/7hokPD1BlR9MdiMqXyoGrlil5to4M/riFl2/+yYgsZNDCsBW7UeHXbI9Zm7342peB+fWp/tTjeebVOufkkFq3iNb4UC/P7LsPU5nuCn2YsVB7T1+LXI8Cehx24TAsnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Xu7ZpBgJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=n9EGqr8S; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Aug 2024 06:23:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723962188;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+iS60uE5F1Q60LKlAAEKJ3IHAfbYPD0ZAd1tJHH28U=;
	b=Xu7ZpBgJ8++yqBQYGlIiida5a7EruRMlg0fkzFUD0gspKRQdzFeK2KHJljcqucFVQr5dCS
	j39z460w6zFhnxQRCXV/2i6kEPZ6LCa4pNvlUpW1wlFPTYjoTx6ZvZ+89zcIYXJekePyUd
	x79PuIbDp3Hdlo0qiCd2L3hl+s2u6l8SF6m+XwtzrXH+GktUF1ItfP85B4Xi6vsoAA7Ool
	O4BnyQ6s7WBNbkZnI2xDJqv+lVx6eeykZ9xSx6WTWajZdHk0HDXo6MY+QhOYT9ud3GCQBZ
	RVLEJh2T6HvmZPzLSOWvtI1FksUUZyU+/Rgxqkm79Ted+n44EWlDxIS/0W7sEQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723962189;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+iS60uE5F1Q60LKlAAEKJ3IHAfbYPD0ZAd1tJHH28U=;
	b=n9EGqr8SNGKDMWxwtZoNVQsBc4sbksYiIJRmLNTpk/Sv69MujONyA7brBxLg6nv3rFgTAn
	Vy8yvdUqaTcQV0CQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Implement ENQUEUE_DELAYED
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240727105029.888107381@infradead.org>
References: <20240727105029.888107381@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172396218856.2215.6446008555962763303.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     781773e3b68031bd001c0c18aa72e8470c225ebd
Gitweb:        https://git.kernel.org/tip/781773e3b68031bd001c0c18aa72e8470c225ebd
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 23 May 2024 11:57:43 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 17 Aug 2024 11:06:43 +02:00

sched/fair: Implement ENQUEUE_DELAYED

Doing a wakeup on a delayed dequeue task is about as simple as it
sounds -- remove the delayed mark and enjoy the fact it was actually
still on the runqueue.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lkml.kernel.org/r/20240727105029.888107381@infradead.org
---
 kernel/sched/fair.c | 33 +++++++++++++++++++++++++++++++--
 1 file changed, 31 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index a4f1f79..25b14df 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5290,6 +5290,9 @@ static inline int cfs_rq_throttled(struct cfs_rq *cfs_rq);
 static inline bool cfs_bandwidth_used(void);
 
 static void
+requeue_delayed_entity(struct sched_entity *se);
+
+static void
 enqueue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int flags)
 {
 	bool curr = cfs_rq->curr == se;
@@ -5922,8 +5925,10 @@ void unthrottle_cfs_rq(struct cfs_rq *cfs_rq)
 	for_each_sched_entity(se) {
 		struct cfs_rq *qcfs_rq = cfs_rq_of(se);
 
-		if (se->on_rq)
+		if (se->on_rq) {
+			SCHED_WARN_ON(se->sched_delayed);
 			break;
+		}
 		enqueue_entity(qcfs_rq, se, ENQUEUE_WAKEUP);
 
 		if (cfs_rq_is_idle(group_cfs_rq(se)))
@@ -6773,6 +6778,22 @@ static int sched_idle_cpu(int cpu)
 }
 #endif
 
+static void
+requeue_delayed_entity(struct sched_entity *se)
+{
+	struct cfs_rq *cfs_rq = cfs_rq_of(se);
+
+	/*
+	 * se->sched_delayed should imply: se->on_rq == 1.
+	 * Because a delayed entity is one that is still on
+	 * the runqueue competing until elegibility.
+	 */
+	SCHED_WARN_ON(!se->sched_delayed);
+	SCHED_WARN_ON(!se->on_rq);
+
+	se->sched_delayed = 0;
+}
+
 /*
  * The enqueue_task method is called before nr_running is
  * increased. Here we update the fair scheduling stats and
@@ -6787,6 +6808,11 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	int task_new = !(flags & ENQUEUE_WAKEUP);
 	int rq_h_nr_running = rq->cfs.h_nr_running;
 
+	if (flags & ENQUEUE_DELAYED) {
+		requeue_delayed_entity(se);
+		return;
+	}
+
 	/*
 	 * The code below (indirectly) updates schedutil which looks at
 	 * the cfs_rq utilization to select a frequency.
@@ -6804,8 +6830,11 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		cpufreq_update_util(rq, SCHED_CPUFREQ_IOWAIT);
 
 	for_each_sched_entity(se) {
-		if (se->on_rq)
+		if (se->on_rq) {
+			if (se->sched_delayed)
+				requeue_delayed_entity(se);
 			break;
+		}
 		cfs_rq = cfs_rq_of(se);
 		enqueue_entity(cfs_rq, se, flags);
 

