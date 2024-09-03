Return-Path: <linux-tip-commits+bounces-2150-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E7C9969F28
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Sep 2024 15:38:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EA16428313F
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Sep 2024 13:38:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F016879EA;
	Tue,  3 Sep 2024 13:38:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Iw2QCxW/";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AYMmfW+y"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D648C06;
	Tue,  3 Sep 2024 13:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725370703; cv=none; b=HgseKBl17GAL2MZ0fF3fL0zdelMsX2S4TaBNtEKvRK37TijhmBdV6ePMdAr6d7F0OLu2sxOhQ/9lY0shfo0yYXShzpMs5cMbQqrhbq7Yk/5OEfKWMoBBrSCK151j9m1+OednYaFd8Ld77EgfTK9w9BvCIL44zOKQ6zPnPh1DEEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725370703; c=relaxed/simple;
	bh=xp7f8nLWEqAMmtfNNcDy5PlRHMpXmtORVRipmLSkonk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=DVcNsw0XdvHFsugiUSxu2mfnRfTR4XIX+K2VMpFUM4XQqxmU5HvBRf9P9jhWd4XNLB4W6ZWKHwBwnA9zVjFWF38bG5+IwiE0kekoW0fSO72q6Z2zIquyDo2JDPolSEyklOW++279fbTQ0uP142N2LvokH6n8nvwJMqSUfQNfacI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Iw2QCxW/; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=AYMmfW+y; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Sep 2024 13:38:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1725370700;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kt8N9R7Ia+PT1R6huN1rBetdA4xL+ORKXl1fOe0Zx7A=;
	b=Iw2QCxW/NBmXBn2e1xoFqYk1RMyW1+eCIQcKyfz8meZr8o3rTJpyZ6HVntax+1mN4SFP6E
	GXqE5AUOusW9qnuM1A8mdD4UXtkGUjp91bAD3e0AS4WYYCXvvZgZFq/perg591bB23MtuH
	hZ1ggInx1u77gjBzBJ1qWNzRDUIJVlbU12bpCmcJ4IDymsYBFKHL5V3jGu+zUY4MBFX4Ji
	mkLBMKpSyf//AeUTy5tqGS0fmXGpM9wNH+Pa/JdkKs/FqwzxHbmiB9ZzxJ3p9btfZwoMhm
	41sZ+YF1dna1H9k24gWdbf31XptcKC0Sw/yn/RLbFlJ9cTM5f+dFK0+Kksj35A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1725370700;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Kt8N9R7Ia+PT1R6huN1rBetdA4xL+ORKXl1fOe0Zx7A=;
	b=AYMmfW+yrj2Ie+d16+0dIsK/YMjska+nX0FSCQSOtnL3+834b8eZbv7tCGFXOQdxcqHcaa
	k/m8SMODoKMlYYBA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Combine the last put_prev_task() and the
 first set_next_task()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240813224016.158454756@infradead.org>
References: <20240813224016.158454756@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172537070017.2215.4630903266570877162.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     436f3eed5c69c1048a5754df6e3dbb291e5cccbd
Gitweb:        https://git.kernel.org/tip/436f3eed5c69c1048a5754df6e3dbb291e5cccbd
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 14 Aug 2024 00:25:54 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 03 Sep 2024 15:26:31 +02:00

sched: Combine the last put_prev_task() and the first set_next_task()

Ensure the last put_prev_task() and the first set_next_task() always
go together.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20240813224016.158454756@infradead.org
---
 kernel/sched/core.c  | 17 ++++-------------
 kernel/sched/fair.c  |  3 +--
 kernel/sched/sched.h | 10 +++++++++-
 3 files changed, 14 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index b9429eb..8a1cf93 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5894,8 +5894,7 @@ __pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		/* Assume the next prioritized class is idle_sched_class */
 		if (!p) {
 			p = pick_task_idle(rq);
-			put_prev_task(rq, prev);
-			set_next_task_first(rq, p);
+			put_prev_set_next_task(rq, prev, p);
 		}
 
 		/*
@@ -5926,8 +5925,7 @@ restart:
 		} else {
 			p = class->pick_task(rq);
 			if (p) {
-				put_prev_task(rq, prev);
-				set_next_task_first(rq, p);
+				put_prev_set_next_task(rq, prev, p);
 				return p;
 			}
 		}
@@ -6016,13 +6014,8 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		WRITE_ONCE(rq->core_sched_seq, rq->core->core_pick_seq);
 
 		next = rq->core_pick;
-		if (next != prev) {
-			put_prev_task(rq, prev);
-			set_next_task_first(rq, next);
-		}
-
 		rq->core_pick = NULL;
-		goto out;
+		goto out_set_next;
 	}
 
 	prev_balance(rq, prev, rf);
@@ -6192,9 +6185,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 	}
 
 out_set_next:
-	put_prev_task(rq, prev);
-	set_next_task_first(rq, next);
-out:
+	put_prev_set_next_task(rq, prev, next);
 	if (rq->core->core_forceidle_count && next == rq->idle)
 		queue_core_balance(rq);
 
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 53556b0..c5b7873 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -8819,8 +8819,7 @@ again:
 
 simple:
 #endif
-	put_prev_task(rq, prev);
-	set_next_task_fair(rq, p, true);
+	put_prev_set_next_task(rq, prev, p);
 	return p;
 
 idle:
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 64a4ed7..aae3581 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2370,8 +2370,16 @@ static inline void set_next_task(struct rq *rq, struct task_struct *next)
 	next->sched_class->set_next_task(rq, next, false);
 }
 
-static inline void set_next_task_first(struct rq *rq, struct task_struct *next)
+static inline void put_prev_set_next_task(struct rq *rq,
+					  struct task_struct *prev,
+					  struct task_struct *next)
 {
+	WARN_ON_ONCE(rq->curr != prev);
+
+	if (next == prev)
+		return;
+
+	prev->sched_class->put_prev_task(rq, prev);
 	next->sched_class->set_next_task(rq, next, true);
 }
 

