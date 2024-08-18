Return-Path: <linux-tip-commits+bounces-2070-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96A20955B35
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 08:24:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BB9D61C20FBF
	for <lists+linux-tip-commits@lfdr.de>; Sun, 18 Aug 2024 06:24:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4EC2CDDAB;
	Sun, 18 Aug 2024 06:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KPFEXWJY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JsXj5F5E"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B5F917BBF;
	Sun, 18 Aug 2024 06:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723962195; cv=none; b=PNH0CX/feAxZ+D1neRhhniekm5bCR+iJ44WB1EmQOHIAQFewtDty/VxG8gzKU8LqtYLLXhZ2DwTT0cJmDjeN1n/18IIGhsGcwCdm3K+jF1S7iQV0O0RTi/35k6W6tn7g3G1F7CD1VyzWXQJtmaozCI+M3L4pIlODkT9Fl1Fnpj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723962195; c=relaxed/simple;
	bh=fvqbc/NRLvnOWt5vKGhbPVCDjAZykSbr+O9LGGcyFYw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=gqKQq/Khyz8VI3yITJ9e3S702woT5WoiKqR0hqXbojmRnUSryL4JhjhFdvL/rsutcqT6wfwt2N0YdKRG1P4g6IoPChbSNMzFm5MmJknxesc1WFxlMyulhQctgIz7xiJV/D+aoN7LowBjqfhjKwMY6xAxZN3L9Muj7H0OqkijGJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KPFEXWJY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=JsXj5F5E; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 18 Aug 2024 06:23:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1723962190;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WphN8DQ6Df2Lkwj7Vm2tWec9+RHa6U9fXF66bZND/KI=;
	b=KPFEXWJYaS4FZmKo8Sfrmitq/1EoOXGzUCCrpvWFUK0EuQ/JdFs+eg0Ladvuy0gWFWamll
	lMyy6D1ysgzP7dGuSGd8TA+A3T3qMHfz5+UKzZS3lloCMR9BglT2rMmQwS7XJAJ3DPJQih
	bTSMnNRNwL3iC+wqnYkFcAfR+M3IdT4X/biEROuHdCwHQQlDQpNYIYKwQ7dXJrUKma2ThQ
	iVEIs6Q9FfOsZ+Z09Ur18aV3a5pbi249dFwUWtNqXIRqqrW20vs/QT29J5NHLowJG6RjLP
	E+LO5UPB708wav5+kctQC0ufT3JR/6Ndu6Zkc3CMCtu0L+4wMOq+rOl68DRMmw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1723962190;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WphN8DQ6Df2Lkwj7Vm2tWec9+RHa6U9fXF66bZND/KI=;
	b=JsXj5F5EOXIQNKmsWJhJh7IkTcBvhIOW8oUgPtnrZqd1zWb+iw3mOWtKLWWbKWU5A5nfXo
	6GLmBd8NwvyQ8mCw==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/uclamg: Handle delayed dequeue
Cc: Luis Machado <luis.machado@arm.com>, Hongyan Xia <hongyan.xia2@arm.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Valentin Schneider <vschneid@redhat.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240727105029.315205425@infradead.org>
References: <20240727105029.315205425@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172396218984.2215.18280492377096522742.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     dfa0a574cbc47bfd5f8985f74c8ea003a37fa078
Gitweb:        https://git.kernel.org/tip/dfa0a574cbc47bfd5f8985f74c8ea003a37fa078
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 05 Jun 2024 12:09:11 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 17 Aug 2024 11:06:42 +02:00

sched/uclamg: Handle delayed dequeue

Delayed dequeue has tasks sit around on the runqueue that are not
actually runnable -- specifically, they will be dequeued the moment
they get picked.

One side-effect is that such a task can get migrated, which leads to a
'nested' dequeue_task() scenario that messes up uclamp if we don't
take care.

Notably, dequeue_task(DEQUEUE_SLEEP) can 'fail' and keep the task on
the runqueue. This however will have removed the task from uclamp --
per uclamp_rq_dec() in dequeue_task(). So far so good.

However, if at that point the task gets migrated -- or nice adjusted
or any of a myriad of operations that does a dequeue-enqueue cycle --
we'll pass through dequeue_task()/enqueue_task() again. Without
modification this will lead to a double decrement for uclamp, which is
wrong.

Reported-by: Luis Machado <luis.machado@arm.com>
Reported-by: Hongyan Xia <hongyan.xia2@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <vschneid@redhat.com>
Tested-by: Valentin Schneider <vschneid@redhat.com>
Link: https://lkml.kernel.org/r/20240727105029.315205425@infradead.org
---
 kernel/sched/core.c | 16 +++++++++++++++-
 1 file changed, 15 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 7356464..80e639e 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1691,6 +1691,9 @@ static inline void uclamp_rq_inc(struct rq *rq, struct task_struct *p)
 	if (unlikely(!p->sched_class->uclamp_enabled))
 		return;
 
+	if (p->se.sched_delayed)
+		return;
+
 	for_each_clamp_id(clamp_id)
 		uclamp_rq_inc_id(rq, p, clamp_id);
 
@@ -1715,6 +1718,9 @@ static inline void uclamp_rq_dec(struct rq *rq, struct task_struct *p)
 	if (unlikely(!p->sched_class->uclamp_enabled))
 		return;
 
+	if (p->se.sched_delayed)
+		return;
+
 	for_each_clamp_id(clamp_id)
 		uclamp_rq_dec_id(rq, p, clamp_id);
 }
@@ -1994,8 +2000,12 @@ void enqueue_task(struct rq *rq, struct task_struct *p, int flags)
 		psi_enqueue(p, (flags & ENQUEUE_WAKEUP) && !(flags & ENQUEUE_MIGRATED));
 	}
 
-	uclamp_rq_inc(rq, p);
 	p->sched_class->enqueue_task(rq, p, flags);
+	/*
+	 * Must be after ->enqueue_task() because ENQUEUE_DELAYED can clear
+	 * ->sched_delayed.
+	 */
+	uclamp_rq_inc(rq, p);
 
 	if (sched_core_enabled(rq))
 		sched_core_enqueue(rq, p);
@@ -2017,6 +2027,10 @@ inline bool dequeue_task(struct rq *rq, struct task_struct *p, int flags)
 		psi_dequeue(p, flags & DEQUEUE_SLEEP);
 	}
 
+	/*
+	 * Must be before ->dequeue_task() because ->dequeue_task() can 'fail'
+	 * and mark the task ->sched_delayed.
+	 */
 	uclamp_rq_dec(rq, p);
 	return p->sched_class->dequeue_task(rq, p, flags);
 }

