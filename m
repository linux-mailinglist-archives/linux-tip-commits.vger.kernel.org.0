Return-Path: <linux-tip-commits+bounces-3031-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CC149E912A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 12:00:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0F85B281D9B
	for <lists+linux-tip-commits@lfdr.de>; Mon,  9 Dec 2024 11:00:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1F5218E8A;
	Mon,  9 Dec 2024 11:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HE3/cZRt";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JOceAcZG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6FF1217F3B;
	Mon,  9 Dec 2024 11:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733742010; cv=none; b=EC2c99If3i1Mee/+jQzRP3YorjZ9CrWljfxM2zHC7MxDo/qscnK2F6dIv/xE3UwbujfMSxcH6JC2yHUQbdb7ATLC3LFWlvWz5XJeQrxLrgFlp2mx6OntzF9cW9FPMwcS0ZZBPjDdV7oMpqAgaTHPY7fHnmWkhbwMk/yBF9FyvyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733742010; c=relaxed/simple;
	bh=5A1upHA6CoOZiUpmVgVnoXV593OZhmc7UQeNnfmP4/s=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Yi0ZdRYL2TjZ7ES4/84zAbaclmaLw2irwEqjEtBUYGSkGU0iERuKsYGSgz/YVl9/BSqdEaTm71bdBv4JaTHYLQiKhpH569ucpRjlsWFmft8r/j6W9ga7Ofb3RRd1JsQlcKGwSIwOppfUIXs2A5QrJPQ0/15N2hIZVzN1xYRur2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HE3/cZRt; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JOceAcZG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 09 Dec 2024 11:00:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733742007;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RjU6p6YwWoknvYBYy0lv6QhvFdAQlnle2EZFg5/wpQk=;
	b=HE3/cZRtpL+UfMy578xr/qLZMkF0dUFp7+grRPbnZ7VpvwHsPEDvAdMsMRO6teVqIqCzb/
	3EwvymNlzJq/vXterNgd8QISImgJZSpL6VqOUMmvf6U646DGx/TWPj/Vctl80uvafrF88+
	aw7rJ3v/ZRoNPTUnPutYwr0SUDZ4OFXT0G67zwVRgNXNXffmvN/6jSJjucXdm6KZh1Q8bZ
	927ikDP7R/i5jZTE+jf/Ngi6RKhOKEc53C6mx6h3xEIKK1ZmXIFnPPnR0DfeIKaQbDjIKx
	XMGAsOL6SBOa7F9JFGA9mGTPxYH4Vs26SSuA0HM2JU24BLwSk0e0QnzaDt3JIQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733742007;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RjU6p6YwWoknvYBYy0lv6QhvFdAQlnle2EZFg5/wpQk=;
	b=JOceAcZGTnPpiYG9MIoHCWhc3z+5ukub9w2fKTVgJNkWmAt2vaCgMw2QwZd6GA4rWNVsO8
	SoxaAums4grUIWCQ==
From: "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Remove unused cfs_rq.idle_nr_running
Cc: Vincent Guittot <vincent.guittot@linaro.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241202174606.4074512-9-vincent.guittot@linaro.org>
References: <20241202174606.4074512-9-vincent.guittot@linaro.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173374200608.412.15357342508268346602.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     43eef7c3a4a65e258244d63a8992d0a8d70e5974
Gitweb:        https://git.kernel.org/tip/43eef7c3a4a65e258244d63a8992d0a8d70e5974
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Mon, 02 Dec 2024 18:46:03 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 09 Dec 2024 11:48:12 +01:00

sched/fair: Remove unused cfs_rq.idle_nr_running

cfs_rq.idle_nr_running field is not used anywhere so we can remove the
useless associated computation. Last user went in commit 5e963f2bd465
("sched/fair: Commit to EEVDF").

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Link: https://lore.kernel.org/r/20241202174606.4074512-9-vincent.guittot@linaro.org
---
 kernel/sched/debug.c |  2 --
 kernel/sched/fair.c  | 14 +-------------
 kernel/sched/sched.h |  1 -
 3 files changed, 1 insertion(+), 16 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index e21b66b..e300ee4 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -846,8 +846,6 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_runnable", cfs_rq->h_nr_runnable);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_queued", cfs_rq->h_nr_queued);
-	SEQ_printf(m, "  .%-30s: %d\n", "idle_nr_running",
-			cfs_rq->idle_nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_idle", cfs_rq->h_nr_idle);
 	SEQ_printf(m, "  .%-30s: %ld\n", "load", cfs_rq->load.weight);
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 2ef3378..8afa0a4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3674,8 +3674,6 @@ account_entity_enqueue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	}
 #endif
 	cfs_rq->nr_running++;
-	if (se_is_idle(se))
-		cfs_rq->idle_nr_running++;
 }
 
 static void
@@ -3689,8 +3687,6 @@ account_entity_dequeue(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	}
 #endif
 	cfs_rq->nr_running--;
-	if (se_is_idle(se))
-		cfs_rq->idle_nr_running--;
 }
 
 /*
@@ -13507,7 +13503,7 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 	for_each_possible_cpu(i) {
 		struct rq *rq = cpu_rq(i);
 		struct sched_entity *se = tg->se[i];
-		struct cfs_rq *parent_cfs_rq, *grp_cfs_rq = tg->cfs_rq[i];
+		struct cfs_rq *grp_cfs_rq = tg->cfs_rq[i];
 		bool was_idle = cfs_rq_is_idle(grp_cfs_rq);
 		long idle_task_delta;
 		struct rq_flags rf;
@@ -13518,14 +13514,6 @@ int sched_group_set_idle(struct task_group *tg, long idle)
 		if (WARN_ON_ONCE(was_idle == cfs_rq_is_idle(grp_cfs_rq)))
 			goto next_cpu;
 
-		if (se->on_rq) {
-			parent_cfs_rq = cfs_rq_of(se);
-			if (cfs_rq_is_idle(grp_cfs_rq))
-				parent_cfs_rq->idle_nr_running++;
-			else
-				parent_cfs_rq->idle_nr_running--;
-		}
-
 		idle_task_delta = grp_cfs_rq->h_nr_queued -
 				  grp_cfs_rq->h_nr_idle;
 		if (!cfs_rq_is_idle(grp_cfs_rq))
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index afe5cb9..9a9220a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -648,7 +648,6 @@ struct cfs_rq {
 	unsigned int		nr_running;
 	unsigned int		h_nr_queued;       /* SCHED_{NORMAL,BATCH,IDLE} */
 	unsigned int		h_nr_runnable;     /* SCHED_{NORMAL,BATCH,IDLE} */
-	unsigned int		idle_nr_running;   /* SCHED_IDLE */
 	unsigned int		h_nr_idle; /* SCHED_IDLE */
 
 	s64			avg_vruntime;

