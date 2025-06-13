Return-Path: <linux-tip-commits+bounces-5790-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DBC01AD8461
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:40:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F17CD3A2924
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:39:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D60492E6D0A;
	Fri, 13 Jun 2025 07:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zKepaxqr";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="borbCgCN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1852E2E6D39;
	Fri, 13 Jun 2025 07:37:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800238; cv=none; b=Z+WQH3o5zf7bSebLod2rbnRisfyaujonQmiugYKsBBqExTitvfRATfH6Rp6/CRExMkY9kaMxOmMOrwW7BUMyaTG/NV2ixLnXotKRSCL3X88584JAc7eDuLcg30iSb+DVnxECzj9XfYiZOycmLKieKVm2aajmjAHRLQSg3HuVBko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800238; c=relaxed/simple;
	bh=qfMSdKQBq9qGMokno29QVYff0UkaBMS16sNeNRTrKTk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=cbulGDTk9RLTHC1CYVHNpxnY+yhg8alizpNj09sG5GzIGQLIs1ZevmL95CLmci+9T38WY9XUFSNbNvA77Z+1wKpah2wgz1KQOA8k9zLwL1wXfUgFjnUSvmPjGMV4q6L78xX+F/z3E3Grbkp4dBropDSu7xmU4jcBhazfG4GZOac=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zKepaxqr; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=borbCgCN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800234;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cByiB35CdBgp4kfuTQ0etDGRVFWdE62vB3LlnBmFKO8=;
	b=zKepaxqrE95pVPPD7V5niCpne0A2gfgY6bZr7htBBmWPozG7wfhWLJwz/MRtiyTFaM7RwH
	ZzV8BdL4Pr0oaI/88E7HpnVQ1rw32GPpZjLC3eG82Z9B1ZZtDWAcxlSYfuY9lRD+71Ju6t
	qtKW3wX0SunBHib8BcbWz70+gzdh66+x5OdWiEKtcu7WIZ2lyfXuEzlDo53v41MrvtBf+U
	gfQv8DxASnD9Rq8RmkX+QPD+D9TsohYe1bXgj2Pv7aNZhs3Z6NSs6khCo62TCWXqR6A63m
	2ukPWGma92rvwjWNaVa3yZhgvV0S3Wgd5OhBxx5XXB+xF38yBtdRwdrcBwkKng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800234;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cByiB35CdBgp4kfuTQ0etDGRVFWdE62vB3LlnBmFKO8=;
	b=borbCgCNLyloaEfCSmFwobJSW3ILZtAFJ+3u34/0JeJ6prRmh5vrJQDOxmQHqEP1Vo/h92
	spCpaX2Tn5rCC3CA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/smp: Use the SMP version of the idle scheduling class
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-35-mingo@kernel.org>
References: <20250528080924.2273858-35-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980023332.406.10511179396125836461.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     482c4dae75cbe3a3bc7109d6c2346e400facbea8
Gitweb:        https://git.kernel.org/tip/482c4dae75cbe3a3bc7109d6c2346e400facbea8
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:09:15 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:21 +02:00

sched/smp: Use the SMP version of the idle scheduling class

Simplify the scheduler by making CONFIG_SMP=y code in the
idle scheduling classunconditional.

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
Link: https://lore.kernel.org/r/20250528080924.2273858-35-mingo@kernel.org
---
 kernel/sched/idle.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 43d6e00..c39b089 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -432,7 +432,6 @@ void cpu_startup_entry(enum cpuhp_state state)
  * idle-task scheduling class.
  */
 
-#ifdef CONFIG_SMP
 static int
 select_task_rq_idle(struct task_struct *p, int cpu, int flags)
 {
@@ -444,7 +443,6 @@ balance_idle(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
 	return WARN_ON_ONCE(1);
 }
-#endif /* CONFIG_SMP */
 
 /*
  * Idle tasks are unconditionally rescheduled:
@@ -531,11 +529,9 @@ DEFINE_SCHED_CLASS(idle) = {
 	.put_prev_task		= put_prev_task_idle,
 	.set_next_task          = set_next_task_idle,
 
-#ifdef CONFIG_SMP
 	.balance		= balance_idle,
 	.select_task_rq		= select_task_rq_idle,
 	.set_cpus_allowed	= set_cpus_allowed_common,
-#endif
 
 	.task_tick		= task_tick_idle,
 

