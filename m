Return-Path: <linux-tip-commits+bounces-2277-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4E8972BC5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 10:14:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6A5BC1F263AF
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Sep 2024 08:14:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2627194088;
	Tue, 10 Sep 2024 08:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DqPaqm3M";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="R2TxQMKK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC52192B96;
	Tue, 10 Sep 2024 08:09:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725955774; cv=none; b=QyVhs4QkyUBkH6lMMV4HsFji/SqbvCn7BiF5zwCmj/6iYksiYSQh8Pof7LKSBlPl+E4EwL59CSvemAQ0XU5hPe8AQi522OXowcRgbYRYi2OHbF/oq/8Dqexvban8HgDvQ0IsI4tNmfH0NJjj0obANX1E7o8FX0aaKHlnzg4i6hA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725955774; c=relaxed/simple;
	bh=0D/ORG2e3vfbsp/PpdgojntmUrpLubh0yKustIXqU9U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=RqQ5YvPKfHNwzUGsf/4acu+K5emH8XRsMOtrM3l3TrOY/QdpuBi86yNxDUs+SUISyOi/cflYTZmstgYjJWbH+5FgMmcf2qzukez4Thy4hlM7A+knoCGWccSa93zq904MADDUxQekYuh+IDQPeTvBHmZb+rz4ZbNTX4amj1mnlKk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DqPaqm3M; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=R2TxQMKK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 10 Sep 2024 08:09:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725955764;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oUKmCcRho6mAOvLtRZubkErav2GqH18hLOvRGgdsPJM=;
	b=DqPaqm3MVaF3wveP42tSHrvzxQolFbGehfkLBKO95O77dPccF54+R+JsfiW7Kgv9elKYUh
	+CedBnk+/E/CgVJLqYJv/h7LmLBb6J4Q6o7WgjQH6xZoJUv6t7CVc2qwq6EselH5bWbwyZ
	glvvcykIYsifkAg8ODNeDorMKiuysGF7NB7ZAgAKS7Ou4QDYHMuB2gOw3pTOi/qlB5PBF6
	iW/2DkK1vhflIR+q2EaGac/IAG+hTGfwhk4WQFIrPD7n0ECP/m7M2++amPpvUPEjlPx+gZ
	xZtQk6s9IOO9fR+uro3bFiSfh0E4IsUS8owfwuZYB3puMbJy+6gu8qp7+XG0hA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725955764;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oUKmCcRho6mAOvLtRZubkErav2GqH18hLOvRGgdsPJM=;
	b=R2TxQMKK2SooEC4QdiJyRz5YSZU4BCopMpKhcV4MZMGF6OuDhHf808Qs9nx/AgZtg827uE
	rA07bGP2BjfKPbBw==
From: "tip-bot2 for Dietmar Eggemann" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] kernel/sched: Fix util_est accounting for DELAY_DEQUEUE
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <c49ef5fe-a909-43f1-b02f-a765ab9cedbf@arm.com>
References: <c49ef5fe-a909-43f1-b02f-a765ab9cedbf@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172595576353.2215.13332974093385124273.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     729288bc68560b4d5b094cb7a6f794c752ef22a2
Gitweb:        https://git.kernel.org/tip/729288bc68560b4d5b094cb7a6f794c752ef22a2
Author:        Dietmar Eggemann <dietmar.eggemann@arm.com>
AuthorDate:    Thu, 05 Sep 2024 00:05:23 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Sep 2024 09:51:15 +02:00

kernel/sched: Fix util_est accounting for DELAY_DEQUEUE

Remove delayed tasks from util_est even they are runnable.

Exclude delayed task which are (a) migrating between rq's or (b) in a
SAVE/RESTORE dequeue/enqueue.

Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/c49ef5fe-a909-43f1-b02f-a765ab9cedbf@arm.com
---
 kernel/sched/fair.c | 16 +++++++++-------
 1 file changed, 9 insertions(+), 7 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e946ca0..922d690 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6948,18 +6948,19 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	int rq_h_nr_running = rq->cfs.h_nr_running;
 	u64 slice = 0;
 
-	if (flags & ENQUEUE_DELAYED) {
-		requeue_delayed_entity(se);
-		return;
-	}
-
 	/*
 	 * The code below (indirectly) updates schedutil which looks at
 	 * the cfs_rq utilization to select a frequency.
 	 * Let's add the task's estimated utilization to the cfs_rq's
 	 * estimated utilization, before we update schedutil.
 	 */
-	util_est_enqueue(&rq->cfs, p);
+	if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & ENQUEUE_RESTORE))))
+		util_est_enqueue(&rq->cfs, p);
+
+	if (flags & ENQUEUE_DELAYED) {
+		requeue_delayed_entity(se);
+		return;
+	}
 
 	/*
 	 * If in_iowait is set, the code below may not trigger any cpufreq
@@ -7177,7 +7178,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
  */
 static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
-	util_est_dequeue(&rq->cfs, p);
+	if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & DEQUEUE_SAVE))))
+		util_est_dequeue(&rq->cfs, p);
 
 	if (dequeue_entities(rq, &p->se, flags) < 0) {
 		util_est_update(&rq->cfs, p, DEQUEUE_SLEEP);

