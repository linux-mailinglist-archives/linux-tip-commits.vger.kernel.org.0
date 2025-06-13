Return-Path: <linux-tip-commits+bounces-5784-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8483CAD845C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:39:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15BA2189C76C
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:38:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCAD62E337C;
	Fri, 13 Jun 2025 07:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L1jZ7gIh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7MflSPQC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08C382E2EE6;
	Fri, 13 Jun 2025 07:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800233; cv=none; b=GVmHmxP8SzsaukR2qe04v6GpSUNSFg+B2GL6A3xhqtsscvsZIE1Z7yvfMsA91S/2GUMfJmvdpP2IhOs+BMcrKifKRG8oNPAhwXGb881/OSbTALVxUvp7ib9ZFG36FuL4FImfCRgOG4wAZ9qAZP0nbxCt4tggbuPkEJ0or1F88wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800233; c=relaxed/simple;
	bh=AfG9iK28CCQ/FFcsce8EWv4GmK8bHlpaH4L3jEfLz+o=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iY661TWsMM+7pOzQPNQzeDCGBN0kuQKFZiSEoXKWNMMGnfED2Hnt3EbqEYydhdvhYygEVRM58vLA046LLLUUT783jKaB8K28u1L1y+wnk5JfmB/VJbqOaIRrSNhNrNwO5srWusX0M+oQvFRgmz2HqEno6GiErjGfwcfuHaxluxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L1jZ7gIh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=7MflSPQC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:08 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800229;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=07yrROB7fDjWCnoHF3fXKbswM0HmzDqggK1YrGRUPJQ=;
	b=L1jZ7gIhZudHJQ8qM+tBxlCgXaWJ78qAth+CsBhViM7cLCSnnVkJAF0LwUurBH0IXNh8ci
	EbqI/QkBWm776OnyYdxuQw33toALiV/RslTgDScAe86vwr8iOqjjm6Rwv/rErzvFeFFaid
	4d4UC4paeWZFIDacQ13T+B61ri+Si0HvL3VMYwgdPivas9/B3Oyxyuq/s7TeUwTz5N3Lu/
	ckTzGzcwPUjEzlMTY4x0vbIB71V/1Upu1873422oXrD0w8LQCtsb7dKStLIW7LVTy5TEqP
	yTxwNBqmyrtN28BroG0uJk+IfkgG3YF8Bnsgj24E0EMMhRoIldnIMSePLrq61A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800229;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=07yrROB7fDjWCnoHF3fXKbswM0HmzDqggK1YrGRUPJQ=;
	b=7MflSPQCo4j89gMJQ3wi1Wqsx2Opdxsz4wle6bFpbU2iy7wcHu2VfgIbD4rwo+TyJ1KtEx
	3Z77U8N1Yc3Mq+BQ==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/smp: Use the SMP version of task_on_cpu()
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-40-mingo@kernel.org>
References: <20250528080924.2273858-40-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980022841.406.13900619431800115144.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     ea100b31eed459ea32d6df4489cf70219fd83a07
Gitweb:        https://git.kernel.org/tip/ea100b31eed459ea32d6df4489cf70219fd83a07
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:09:20 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:22 +02:00

sched/smp: Use the SMP version of task_on_cpu()

Simplify the scheduler by making CONFIG_SMP=y code in task_on_cpu()
unconditional.

Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Mel Gorman <mgorman@suse.de>
Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc: Shrikanth Hegde <sshegde@linux.ibm.com>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Valentin Schneider <vschneid@redhat.com>
Cc: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lore.kernel.org/r/20250528080924.2273858-40-mingo@kernel.org
---
 kernel/sched/sched.h | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index f4bac9f..7490473 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2238,11 +2238,7 @@ static inline int task_current_donor(struct rq *rq, struct task_struct *p)
 
 static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
 {
-#ifdef CONFIG_SMP
 	return p->on_cpu;
-#else
-	return task_current(rq, p);
-#endif
 }
 
 static inline int task_on_rq_queued(struct task_struct *p)

