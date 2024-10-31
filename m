Return-Path: <linux-tip-commits+bounces-2678-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A46329B7EAF
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 16:40:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5C1E81F210DC
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 15:40:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B2C01A0BEC;
	Thu, 31 Oct 2024 15:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kdBisITm";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lJdZyhEG"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A52C13342F;
	Thu, 31 Oct 2024 15:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730389224; cv=none; b=tI2KOn1I/HosqdIU5ZUsDdEFug8be77v35lJQb4TexaJGq2CtkvqHMysXHWpkUHD2S3ZszhXCSPx6MwVKbLvlu9fLJBFlB6Gf/hifrp6T73XUIHLwjYRbuyk1rZOx/2yvCFYOB71m9ctS70/MhVqkKwltYnfwft++3jJ+GlyF1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730389224; c=relaxed/simple;
	bh=b3tU87K3qE0vBZb9A0HfD1aCBXZQpIa0W8dvxWB2NaE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HzJ9X5dmNvbUOy+XYKKIDKC31JGO7HwvtQx6XNDzIzflBaBjozKSNO1IhL4rpH2SkDktEUM9zoMWsurZXk0QlzM6orAe0RJMsaiUsXhtKME/sSH72R6TbhctbZ7AM8EQHMAZAlbmnijZbm1yt4vv16sQYur9i5lWixv+t/nO3gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kdBisITm; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lJdZyhEG; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 31 Oct 2024 15:40:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730389220;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6T33aR6hI+FfIZYgzVkL7mZtWmN85aXd2kUD0PyCcF4=;
	b=kdBisITmaTjVCPtyLPkg2KnyJMGtMiYfkTE61cNJ3iXtmRh1u8gdI/D5rlECwMKNWZz/ET
	twMt+4pSyLnTBWw+E8CanU7zyhSBJurMZKR7JqwVkUY8/wj2+k4tpTCJrSUB1AuTkhgfz4
	c1Wu/hzGOqMJsjCZpfsLsfYXkr9CMrMNR79Dn/C2FgwGruFtGp4jfp87xwyAG3R4H3qEz+
	QYPN7c9YIQHuZ0lEQLVZHkmIBGK33+mgBFtu6f+35AUsNi45SAkxPojf6VyMfGrDP3A6CJ
	3nVI55Sni9pAk8lr/TjaC0GIeWqAd3jJ/g+Qap3+VccA+yAlq3aO3Wqb8MG3jw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730389220;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6T33aR6hI+FfIZYgzVkL7mZtWmN85aXd2kUD0PyCcF4=;
	b=lJdZyhEGRrmsp392AZfRs1Xm+7m+/8KR6ng/PJLlZfiedBWI9Hyh5n7QU5abw6OLW/d1kJ
	rCU8PNYDIEofTJDg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/ext: Fix scx vs sched_delayed
Cc: Tejun Heo <tj@kernel.org>, "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241030104934.GK14555@noisy.programming.kicks-ass.net>
References: <20241030104934.GK14555@noisy.programming.kicks-ass.net>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173038921961.3137.2036792013503366045.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     69d5e722be949a1e2409c3f2865ba6020c279db6
Gitweb:        https://git.kernel.org/tip/69d5e722be949a1e2409c3f2865ba6020c279db6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 30 Oct 2024 11:49:34 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 30 Oct 2024 22:42:12 +01:00

sched/ext: Fix scx vs sched_delayed

Commit 98442f0ccd82 ("sched: Fix delayed_dequeue vs
switched_from_fair()") forgot about scx :/

Fixes: 98442f0ccd82 ("sched: Fix delayed_dequeue vs switched_from_fair()")
Reported-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Tejun Heo <tj@kernel.org>
Link: https://lkml.kernel.org/r/20241030104934.GK14555@noisy.programming.kicks-ass.net
---
 kernel/sched/ext.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/ext.c b/kernel/sched/ext.c
index 40bdfe8..721a754 100644
--- a/kernel/sched/ext.c
+++ b/kernel/sched/ext.c
@@ -4489,11 +4489,16 @@ static void scx_ops_disable_workfn(struct kthread_work *work)
 	scx_task_iter_start(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		const struct sched_class *old_class = p->sched_class;
+		const struct sched_class *new_class =
+			__setscheduler_class(p->policy, p->prio);
 		struct sched_enq_and_set_ctx ctx;
 
+		if (old_class != new_class && p->se.sched_delayed)
+			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
+
 		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
 
-		p->sched_class = __setscheduler_class(p->policy, p->prio);
+		p->sched_class = new_class;
 		check_class_changing(task_rq(p), p, old_class);
 
 		sched_enq_and_set_task(&ctx);
@@ -5199,12 +5204,17 @@ static int scx_ops_enable(struct sched_ext_ops *ops, struct bpf_link *link)
 	scx_task_iter_start(&sti);
 	while ((p = scx_task_iter_next_locked(&sti))) {
 		const struct sched_class *old_class = p->sched_class;
+		const struct sched_class *new_class =
+			__setscheduler_class(p->policy, p->prio);
 		struct sched_enq_and_set_ctx ctx;
 
+		if (old_class != new_class && p->se.sched_delayed)
+			dequeue_task(task_rq(p), p, DEQUEUE_SLEEP | DEQUEUE_DELAYED);
+
 		sched_deq_and_put_task(p, DEQUEUE_SAVE | DEQUEUE_MOVE, &ctx);
 
 		p->scx.slice = SCX_SLICE_DFL;
-		p->sched_class = __setscheduler_class(p->policy, p->prio);
+		p->sched_class = new_class;
 		check_class_changing(task_rq(p), p, old_class);
 
 		sched_enq_and_set_task(&ctx);

