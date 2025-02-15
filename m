Return-Path: <linux-tip-commits+bounces-3364-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0078AA36D65
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Feb 2025 11:56:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9768D18951FE
	for <lists+linux-tip-commits@lfdr.de>; Sat, 15 Feb 2025 10:56:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 14B671A5B93;
	Sat, 15 Feb 2025 10:56:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eY7xEh/y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/Oj9zuW2"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 722FC1A262D;
	Sat, 15 Feb 2025 10:55:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739616961; cv=none; b=EiBvj1E95Vy7zpDMoklhcZRllk+FwwWv8pe5fp2jmPoGhJgpuLEnFEH+ciNLpSjgfyYcsaR6c3oNSRDfncG2PUOMeFfu1umyQm1QGAlDagzWyACRjK4FLqCtJUQipIFyZsS7hd6RSfen2w7JBx5isZzam5k53ZN2t/STrZJMLiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739616961; c=relaxed/simple;
	bh=AlSH7K98uv6KyWKFWqQ4XBdXukTn4sBYfnrmMW/f+pw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=rJzmHuri5rRaiV2ABJbB6hNtildYjIq3SSKALKrRtCkSnnq5wjclS+jM+KNczdbxsRkjcY3sLPdcOWYTPAbw4c/r9TlfjoRzTogFlw5cOMkRKLIPxkraUFpLtKQG1ejjbY7+Mf0O0y5j3jpi9Nb5rxk0rVaGktvQz5udZhF19P8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eY7xEh/y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/Oj9zuW2; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 15 Feb 2025 10:55:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739616957;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cPE1Bdmj3ya/QnkZxBWLjWaXkuCaHBwptel7mIe5Sic=;
	b=eY7xEh/y8mdM+AAEyauNf2q93pNBcN0iR758CO+i5WWBZPixlflhMVJ/0Gq3LC1RrjWbHZ
	XNGIzPLUTmfITcRywfxtiW4AqRp+IvXNFk+qDrY+nbhSzvuenk2DY3SppgHSGwDjQh3Xk0
	3NZc9qYD/1wMOtuMu/GKxX3mhOJTmstVPfa3fM6hvTAPNYdP24QkiBYK1yXJLxB+BVSbux
	KnDX64EOXlTXwVb6Ubu6oehJv4Nobfr1O8pscit5eRAH8rr4O4e1PzZFi2egpRbsiziUKX
	FRpPX8vZm8+Tow/2E3ww8ICdy3qRY4O5EqYoqaQKABpaEj8ZpwfdXOQ/BX3XUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739616957;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cPE1Bdmj3ya/QnkZxBWLjWaXkuCaHBwptel7mIe5Sic=;
	b=/Oj9zuW2HOw0onMjcR8fVgoKql1nh/2ArpIVaSQAiPriM/eN9eEdgw2KhxzYV6f7VPc1g0
	RDSrcYPXGdirrgCQ==
From: "tip-bot2 for Tianchen Ding" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/eevdf: Force propagating min_slice of cfs_rq
 when {en,de}queue tasks
Cc: Tianchen Ding <dtcccc@linux.alibaba.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250211063659.7180-1-dtcccc@linux.alibaba.com>
References: <20250211063659.7180-1-dtcccc@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173961695692.10177.11974788721404078533.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     563bc2161b94571ea425bbe2cf69fd38e24cdedf
Gitweb:        https://git.kernel.org/tip/563bc2161b94571ea425bbe2cf69fd38e24cdedf
Author:        Tianchen Ding <dtcccc@linux.alibaba.com>
AuthorDate:    Tue, 11 Feb 2025 14:36:59 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 14 Feb 2025 10:32:01 +01:00

sched/eevdf: Force propagating min_slice of cfs_rq when {en,de}queue tasks

When a task is enqueued and its parent cgroup se is already on_rq, this
parent cgroup se will not be enqueued again, and hence the root->min_slice
leaves unchanged. The same issue happens when a task is dequeued and its
parent cgroup se has other runnable entities, and the parent cgroup se
will not be dequeued.

Force propagating min_slice when se doesn't need to be enqueued or
dequeued. Ensure the se hierarchy always get the latest min_slice.

Fixes: aef6987d8954 ("sched/eevdf: Propagate min_slice up the cgroup hierarchy")
Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250211063659.7180-1-dtcccc@linux.alibaba.com
---
 kernel/sched/fair.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1784752..9279bfb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7002,6 +7002,8 @@ enqueue_task_fair(struct rq *rq, struct task_struct *p, int flags)
 		update_cfs_group(se);
 
 		se->slice = slice;
+		if (se != cfs_rq->curr)
+			min_vruntime_cb_propagate(&se->run_node, NULL);
 		slice = cfs_rq_min_slice(cfs_rq);
 
 		cfs_rq->h_nr_runnable += h_nr_runnable;
@@ -7131,6 +7133,8 @@ static int dequeue_entities(struct rq *rq, struct sched_entity *se, int flags)
 		update_cfs_group(se);
 
 		se->slice = slice;
+		if (se != cfs_rq->curr)
+			min_vruntime_cb_propagate(&se->run_node, NULL);
 		slice = cfs_rq_min_slice(cfs_rq);
 
 		cfs_rq->h_nr_runnable -= h_nr_runnable;

