Return-Path: <linux-tip-commits+bounces-2066-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC2F5955B31
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 08:24:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B3F61C20E91
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 06:24:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 77930199B9;
	Sun, 18 Aug 2024 06:23:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s3PQbwSd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="LWdc1Xex"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5305E17555;
	Sun, 18 Aug 2024 06:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723962194; cv=none; b=S3zExK4B7I/M65zsHB8c7KWwmMAR3Y51yin9gLqoGNtHwW/CDfetxhGae6pdZbnEzy1m+2GaknHggK+XG583dEEUffaFcViA9VWoG4m2r7ug7pqzvXp3P4jeipY3qo+9sVUKXnjEeMsO6shzIrUcfuqqzqQK0nv9fT8h0fhvsMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723962194; c=relaxed/simple;
	bh=T/yXCF6NcStf7ED8yX4IfQACN1VKffEBfhEEVsPkZLM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=o6c8m2MvjSBGJCvM4hZNmI50I5U4J6uDmjKaoTy+YOZxnNtZYRDLd/v95fyTExF8oLhMyK13sW7VsdtURAw+6zkZux9klTMowXpbsXDWHwgCWJhRgRcU0i589eIFf25aCZmK7Rr+eGIKENs9lxdpAJEUkEyAms7vyf8Oc86SDo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s3PQbwSd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=LWdc1Xex; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Aug 2024 06:23:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723962189;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yu6+5+thBKkGtf+1gINvvUjwEwS5X2SVXb4oxBXKSFs=;
	b=s3PQbwSdak2M4B0Vuou3AAxLjsrgQVzu1AYCO0qRhX9XquVVNXgPx/LXe3GVkz5deyhcJm
	/lzptcMEbguCkti8dzgCRjITBLVpZM2ULqz2xDfuJgvFiCVsXDyeiWO+rl8rUJfqh6StX2
	Ze/2zQ0H5QQXIPeGHiMUbdhb4PocVEoj0TkjmgyUcQAACAZvxkod4FyH4Au76YPhCIlqUk
	90wrT5SjMWwlJ1f5cNAIuqibnWk3Ldv6SBTA+nsjfDddZESVkMeAkuVxrmfFgI1Z7nEVI2
	a2N7dGvvS1h5JMrGOza0PXautbPk8eGqzLYMqT7Jl6esvXjvM2nBluuhv2azSA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723962189;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Yu6+5+thBKkGtf+1gINvvUjwEwS5X2SVXb4oxBXKSFs=;
	b=LWdc1XexSm0TXtZ71dKCbLonJRI1f5JjvfA/3V1C6KMLGTAcUtjT5VREC3mLH+S+bnIIlX
	SjAN08oxG4hCqRCg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/fair: Prepare pick_next_task() for delayed dequeue
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240727105029.747330118@infradead.org>
References: <20240727105029.747330118@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172396218883.2215.6061200164052431314.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     f12e148892ede8d9ee82bcd3e469e6d01fc077ac
Gitweb:        https://git.kernel.org/tip/f12e148892ede8d9ee82bcd3e469e6d01fc077ac
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 23 May 2024 11:26:25 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 17 Aug 2024 11:06:43 +02:00

sched/fair: Prepare pick_next_task() for delayed dequeue

Delayed dequeue's natural end is when it gets picked again. Ensure
pick_next_task() knows what to do with delayed tasks.

Note, this relies on the earlier patch that made pick_next_task()
state invariant -- it will restart the pick on dequeue, because
obviously the just dequeued task is no longer eligible.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lkml.kernel.org/r/20240727105029.747330118@infradead.org
---
 kernel/sched/fair.c | 23 +++++++++++++++++++----
 1 file changed, 19 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 9a84903..a4f1f79 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5473,6 +5473,8 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
 	se->prev_sum_exec_runtime = se->sum_exec_runtime;
 }
 
+static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags);
+
 /*
  * Pick the next process, keeping these things in mind, in this order:
  * 1) keep things fair between processes/task groups
@@ -5481,16 +5483,27 @@ set_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *se)
  * 4) do not run the "skip" process, if something else is available
  */
 static struct sched_entity *
-pick_next_entity(struct cfs_rq *cfs_rq)
+pick_next_entity(struct rq *rq, struct cfs_rq *cfs_rq)
 {
 	/*
 	 * Enabling NEXT_BUDDY will affect latency but not fairness.
 	 */
 	if (sched_feat(NEXT_BUDDY) &&
-	    cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next))
+	    cfs_rq->next && entity_eligible(cfs_rq, cfs_rq->next)) {
+		/* ->next will never be delayed */
+		SCHED_WARN_ON(cfs_rq->next->sched_delayed);
 		return cfs_rq->next;
+	}
+
+	struct sched_entity *se = pick_eevdf(cfs_rq);
+	if (se->sched_delayed) {
+		dequeue_entities(rq, se, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
+		SCHED_WARN_ON(se->sched_delayed);
+		SCHED_WARN_ON(se->on_rq);
 
-	return pick_eevdf(cfs_rq);
+		return NULL;
+	}
+	return se;
 }
 
 static bool check_cfs_rq_runtime(struct cfs_rq *cfs_rq);
@@ -8507,7 +8520,9 @@ again:
 		if (unlikely(check_cfs_rq_runtime(cfs_rq)))
 			goto again;
 
-		se = pick_next_entity(cfs_rq);
+		se = pick_next_entity(rq, cfs_rq);
+		if (!se)
+			goto again;
 		cfs_rq = group_cfs_rq(se);
 	} while (cfs_rq);
 

