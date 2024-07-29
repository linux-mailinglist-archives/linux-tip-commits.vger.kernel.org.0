Return-Path: <linux-tip-commits+bounces-1800-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1747493F2DD
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 12:35:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 95CE6B234F5
	for <lists+linux-tip-commits@lfdr.de>; Mon, 29 Jul 2024 10:35:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13846145B2B;
	Mon, 29 Jul 2024 10:34:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="XvbxBtVc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QMxkVDdL"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90CE145347;
	Mon, 29 Jul 2024 10:34:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722249251; cv=none; b=cUEprF7hOYx78dZiaXlpQ4DduDAkqo7Ax+de2IOiQNIYwrbqQKPpL6GSW2AIC9BhCMGSRZ8DPU1ti+TxV87RTNVnfqzs3tQBFgPkbxXx7WW0YYSeJ4DHB7pletOt+jgWyIZkh0FfrmQxIOZsCBOC4kb2VqN41vY96zvAOEbEstk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722249251; c=relaxed/simple;
	bh=XUAXbGHEPibnFLqSUsencJ3G3Oi8ElsU/omqxPp4lTo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=XhiTg+FWHRUl4YJY1i7+/b6TalMdsc7wSaDpOd4Wjq22/I4SGg0iSJcwjLSmYNi9oFbBe05aRE00U/4suTiDrhPVdLKg8J/rQDKYUutOydDjQsKmoOyNtVDxj5IErgh4cRKvFHb3dFV3ZxR/TVwrPQ5GIbl9iJywxNagzglK9nY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=XvbxBtVc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QMxkVDdL; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 29 Jul 2024 10:34:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722249247;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1o/GpCMBB0QE6AIceN3yvxNb94Eejvc5wkiPdR64LRo=;
	b=XvbxBtVcbS7DJ7bxEAZSFy1Cdzy4ma4QU4TWbHp7edRrkUF86fQFHR2nHyp8csQxLzY50K
	H5vLZJM/BulAmnr0+dzBvlWPPG/4L69PCCafwLWghzkbFjNoIY5LJwtk92RQuqauxbfDFP
	Jy5K9gl0XccGsonJlGXIqefFn5bQcbs7NFDWBvMT7Wr9sTdkB49vdirRBvt3PWyahHXU5o
	VdWOnBx3f97SctDdA2MW242bDLMTyy0SjR/UwLTWOGw+MztzPUdjlLEahvrM2Dg7i/mdyU
	d7h47DEK9o+na5o7jN+zTJ834TuBdY0h9gtoViapy3wdueWQp6qIPV0wEnnIdw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722249247;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1o/GpCMBB0QE6AIceN3yvxNb94Eejvc5wkiPdR64LRo=;
	b=QMxkVDdLgNj1Y8l/D/Ow5fBqv9uyRbGJAwAW/rd6SfmC+6ZELv4UxrJ5wNkzaMz1xXyx+w
	IxU/ghY/33nVXrCQ==
From: "tip-bot2 for Chuyi Zhou" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Remove cfs_rq::nr_spread_over and
 cfs_rq::exec_clock
Cc: Chuyi Zhou <zhouchuyi@bytedance.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Chengming Zhou <chengming.zhou@linux.dev>,
 K Prateek Nayak <kprateek.nayak@amd.com>,
 Vishal Chourasia <vishalc@linux.ibm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240717143342.593262-1-zhouchuyi@bytedance.com>
References: <20240717143342.593262-1-zhouchuyi@bytedance.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172224924709.2215.11867466567692940434.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2c2d9624697fc5e7dd84490ae01b80cc43ec2def
Gitweb:        https://git.kernel.org/tip/2c2d9624697fc5e7dd84490ae01b80cc43ec2def
Author:        Chuyi Zhou <zhouchuyi@bytedance.com>
AuthorDate:    Wed, 17 Jul 2024 22:33:42 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 29 Jul 2024 12:22:34 +02:00

sched/fair: Remove cfs_rq::nr_spread_over and cfs_rq::exec_clock

nr_spread_over tracks the number of instances where the difference
between a scheduling entity's virtual runtime and the minimum virtual
runtime in the runqueue exceeds three times the scheduler latency,
indicating significant disparity in task scheduling.
Commit that removed its usage: 5e963f2bd: sched/fair: Commit to EEVDF

cfs_rq->exec_clock was used to account for time spent executing tasks.
Commit that removed its usage: 5d69eca542ee1 sched: Unify runtime
accounting across classes

cfs_rq::nr_spread_over and cfs_rq::exec_clock are not used anymore in
eevdf. Remove them from struct cfs_rq.

Signed-off-by: Chuyi Zhou <zhouchuyi@bytedance.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Chengming Zhou <chengming.zhou@linux.dev>
Reviewed-by: K Prateek Nayak <kprateek.nayak@amd.com>
Acked-by: Vishal Chourasia <vishalc@linux.ibm.com>
Link: https://lore.kernel.org/r/20240717143342.593262-1-zhouchuyi@bytedance.com
---
 kernel/sched/debug.c | 4 ----
 kernel/sched/sched.h | 6 ------
 2 files changed, 10 deletions(-)

diff --git a/kernel/sched/debug.c b/kernel/sched/debug.c
index c1eb9a1..90c4a99 100644
--- a/kernel/sched/debug.c
+++ b/kernel/sched/debug.c
@@ -641,8 +641,6 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 	SEQ_printf(m, "\n");
 	SEQ_printf(m, "cfs_rq[%d]:\n", cpu);
 #endif
-	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "exec_clock",
-			SPLIT_NS(cfs_rq->exec_clock));
 
 	raw_spin_rq_lock_irqsave(rq, flags);
 	root = __pick_root_entity(cfs_rq);
@@ -669,8 +667,6 @@ void print_cfs_rq(struct seq_file *m, int cpu, struct cfs_rq *cfs_rq)
 			SPLIT_NS(right_vruntime));
 	spread = right_vruntime - left_vruntime;
 	SEQ_printf(m, "  .%-30s: %Ld.%06ld\n", "spread", SPLIT_NS(spread));
-	SEQ_printf(m, "  .%-30s: %d\n", "nr_spread_over",
-			cfs_rq->nr_spread_over);
 	SEQ_printf(m, "  .%-30s: %d\n", "nr_running", cfs_rq->nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "h_nr_running", cfs_rq->h_nr_running);
 	SEQ_printf(m, "  .%-30s: %d\n", "idle_nr_running",
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 4c36cc6..8a07102 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -599,7 +599,6 @@ struct cfs_rq {
 	s64			avg_vruntime;
 	u64			avg_load;
 
-	u64			exec_clock;
 	u64			min_vruntime;
 #ifdef CONFIG_SCHED_CORE
 	unsigned int		forceidle_seq;
@@ -619,10 +618,6 @@ struct cfs_rq {
 	struct sched_entity	*curr;
 	struct sched_entity	*next;
 
-#ifdef	CONFIG_SCHED_DEBUG
-	unsigned int		nr_spread_over;
-#endif
-
 #ifdef CONFIG_SMP
 	/*
 	 * CFS load tracking
@@ -1158,7 +1153,6 @@ struct rq {
 	/* latency stats */
 	struct sched_info	rq_sched_info;
 	unsigned long long	rq_cpu_time;
-	/* could above be rq->cfs_rq.exec_clock + rq->rt_rq.rt_runtime ? */
 
 	/* sys_sched_yield() stats */
 	unsigned int		yld_count;

