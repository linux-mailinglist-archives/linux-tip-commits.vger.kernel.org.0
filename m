Return-Path: <linux-tip-commits+bounces-5685-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DE7C1ABF3B8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 14:08:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D93751BC38AF
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 12:07:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30364265CCF;
	Wed, 21 May 2025 12:07:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dHifDJ4/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZDvnRghx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78A20256C9F;
	Wed, 21 May 2025 12:07:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829223; cv=none; b=h49nTZXf88Loz5GRMxciiY6XomFcp6KInkLoQ7muYZITjdn7HVbP7du9wuxQY/dtmo7jVujiH+VGJHq3S+oCELt3DfTzwEGv+LbwaT2UuN20q7sKs63Sl6Tzs9deSNGXIIlaNGSzjr3kDHpaWakp5VjbDuya/taeDFhmNw6nNNQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829223; c=relaxed/simple;
	bh=8NsJuQFwrC95Xe7hMjLsK1Ug4H339jqL+JbTDQI1+cw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XEdu/FjE7HMUN6I7UGlELoXpDfbKs8TxQa89GEuPoo40eNDjzxW0FLjg0fYhu+t//vM/4ZeXb/ohSoIFFXOznDyoFnYo6bmyDHcQRozAcWvM15pR63QCpad75gMW7qN27EIVNaGEoo7OsvkNBfv03sx/fvItOTM9oKomIQ84uD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dHifDJ4/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZDvnRghx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 12:06:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747829219;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ryus/mq3lNn3yJqy5ph1uS4I0lbbK9HipciUiWT8sx4=;
	b=dHifDJ4/KqBGU5vk4DgtYhdbAnoG71enNgbn/mA2NvbFP70cRUn6/mw7/2ICqVKS8FjWhD
	1vW+oOsXpb/opd7rkFTOr+veyiuBn3zmSMEfFZwFNeiBHt6/CZj4vzVzPD8a+YcLG/wOeD
	eOgU6VvPla7RyMDENv20pYg5dfB0PZqXy/F5YB05bS/38o/GKW+ziiikVfoRUoU4BCxwEO
	jUXKMHErTe/Zq/ilpNzplvaera9FxR79qPjlNBJKjhQs4ZaREvqSdzpjbsxIbTKEOJrFsc
	agLtiw/y3HRNUW9MOCGDS5a9QMaPsoxmmfEc/LMFvuyvxT+gZIJY9ahPoyoTMw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747829219;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ryus/mq3lNn3yJqy5ph1uS4I0lbbK9HipciUiWT8sx4=;
	b=ZDvnRghxGG9iqUIJ0FCvppZorWEUqEhw9BrljYDyQ2F3FzgBX9T56yrZs1HRFuSfp4bh7K
	eJ4AePnvme2NvqDw==
From: "tip-bot2 for Xuewen Yan" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/util_est: Simplify condition for
 util_est_{en,de}queue()
Cc: Xuewen Yan <xuewen.yan@unisoc.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250417043457.10632-2-xuewen.yan@unisoc.com>
References: <20250417043457.10632-2-xuewen.yan@unisoc.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174782921810.406.7735731150435046147.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0212696a844631a923aa6cedd74ebbb3cf434e51
Gitweb:        https://git.kernel.org/tip/0212696a844631a923aa6cedd74ebbb3cf434e51
Author:        Xuewen Yan <xuewen.yan@unisoc.com>
AuthorDate:    Thu, 17 Apr 2025 12:34:56 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 21 May 2025 13:57:38 +02:00

sched/util_est: Simplify condition for util_est_{en,de}queue()

To prevent double enqueue/dequeue of the util-est for sched_delayed tasks,
commit 729288bc6856 ("kernel/sched: Fix util_est accounting for DELAY_DEQUEUE")
added the corresponding check. This check excludes double en/dequeue during
task migration and priority changes.

In fact, these conditions can be simplified.

For util_est_dequeue, we know that sched_delayed flag is set in dequeue_entity.
When the task is sleeping, we need to call util_est_dequeue to subtract
util-est from the cfs_rq. At this point, sched_delayed has not yet been set.
If we find that sched_delayed is already set, it indicates that this task
has already called dequeue_task_fair once. In this case, there is no need to
call util_est_dequeue again. Therefore, simply checking the sched_delayed flag
should be sufficient to prevent unnecessary util_est updates during the dequeue.

For util_est_enqueue, our goal is to add the util_est to the cfs_rq
when task enqueue. However, we don't want to add the util_est of a
sched_delayed task to the cfs_rq because the task is sleeping.
Therefore, we can exclude the util_est_enqueue for sched_delayed tasks
by checking the sched_delayed flag. However, when waking up a delayed task,
the sched_delayed flag is cleared after util_est_enqueue. As a result,
if we only check the sched_delayed flag, we would miss the util_est_enqueue.
Since waking up a sched_delayed task calls enqueue_task with the ENQUEUE_DELAYED flag,
we can determine whether to call util_est_enqueue by checking if the
enqueue_flag contains ENQUEUE_DELAYED.

Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lore.kernel.org/r/20250417043457.10632-2-xuewen.yan@unisoc.com
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b00f167..a028c29 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6936,7 +6936,7 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 	 * Let's add the task's estimated utilization to the cfs_rq's
 	 * estimated utilization, before we update schedutil.
 	 */
-	if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & ENQUEUE_RESTORE))))
+	if (!p->se.sched_delayed || (flags & ENQUEUE_DELAYED))
 		util_est_enqueue(&rq->cfs, p);
 
 	if (flags & ENQUEUE_DELAYED) {
@@ -7178,7 +7178,7 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
  */
 static bool dequeue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 {
-	if (!(p->se.sched_delayed && (task_on_rq_migrating(p) || (flags & DEQUEUE_SAVE))))
+	if (!p->se.sched_delayed)
 		util_est_dequeue(&rq->cfs, p);
 
 	util_est_update(&rq->cfs, p, flags & DEQUEUE_SLEEP);

