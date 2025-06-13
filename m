Return-Path: <linux-tip-commits+bounces-5797-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 15522AD846A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:40:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 43A397ACB60
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:39:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8BE722E92B2;
	Fri, 13 Jun 2025 07:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vFFbYqfg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="14ClsMZa"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F2A2E88A9;
	Fri, 13 Jun 2025 07:37:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800244; cv=none; b=PxGjt7HcU0BPHR0xMQfwLBXjmJHPKyFjvSGgA8MGwJziKlXCosGm4ZBZ8veuBGeNFuzVp765vS5rwQuC1uILHzGVjkJhfvEXGfNTnW0fFBvoJu9oM0JtrAXwhipPTgmhhyfuWmTSaKJEXLVrzgAkVTYTD0+N3GKfaNhBhdP+d7Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800244; c=relaxed/simple;
	bh=FiAWfKEVAHMz4SQoP95N1hj1XBE7vpc1ZeyoJeBilKE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Be4Dm6ousoPZgvWd7zDEIySxGIRFbYDXrwEUGHP5wIJ7ixS1VzOgKa7+dC0RnZt0dH0BTb5W3EE+oYjN4y3yAv5UmzxbP+aP2kIDHxHINN8CV3E4/NSrBGfSLJZZPMHX5sYLthCc0pL0EOveuOLKqxDVXt03AI3tvPffBTPQEm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=vFFbYqfg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=14ClsMZa; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800241;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3eiHT3e5C0s5cX9u+x9mBMFmyUxUxtyn71AT1F1ry/Y=;
	b=vFFbYqfgOzR3rrBd6Yzei0wGIq3izDZ3OfTVk3EM1oun34BoYrCWSLuKA0cbjtgTzIJaaA
	/LmyVycGxG5JAXt1vHgGVV9ISPomCiFhA3ygj9Z2ycJ/2PTU14+sDqMqylbZas3RT1G+Nh
	HDiCzN/UQXQrajEuo3QprmXHbNAxRdiHXhcLOtRZ6VTs1MIj8FNG6+tFaaVWRcUs7VWvCN
	ocJpNwRnrHboq5xxU0b/JgPOPIfytzvmvDOY2h0SMKXBodtFnMUOCG8w6hxOspwh4FmmEc
	HkLz6eFUKfySOrjTedEhHQM3ixS+mn3OJ7+l9omqM8Uc8vje3kgOKTCZaye8TA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800241;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3eiHT3e5C0s5cX9u+x9mBMFmyUxUxtyn71AT1F1ry/Y=;
	b=14ClsMZaGiI1cpT8PXHOegaS8TXeRbDwI3bDq5f+ziOIE8gvjMJjJ+7qNerpntfq7Hnq+r
	cp46NC77Ci7wXjBA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/smp: Use the SMP version of sched_exec()
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-27-mingo@kernel.org>
References: <20250528080924.2273858-27-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980024044.406.15764716785808234100.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     1f25730e5a780b33f78e3ea23e64d3f75e0b2042
Gitweb:        https://git.kernel.org/tip/1f25730e5a780b33f78e3ea23e64d3f75e0b2042
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:09:07 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:20 +02:00

sched/smp: Use the SMP version of sched_exec()

Simplify the scheduler making CONFIG_SMP=y sched_exec()
code unconditional.

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
Link: https://lore.kernel.org/r/20250528080924.2273858-27-mingo@kernel.org
---
 include/linux/sched/task.h | 4 ----
 kernel/sched/core.c        | 4 ----
 2 files changed, 8 deletions(-)

diff --git a/include/linux/sched/task.h b/include/linux/sched/task.h
index ca1db4b..c517dbc 100644
--- a/include/linux/sched/task.h
+++ b/include/linux/sched/task.h
@@ -109,11 +109,7 @@ int kernel_wait(pid_t pid, int *stat);
 extern void free_task(struct task_struct *tsk);
 
 /* sched_exec is called by processes performing an exec */
-#ifdef CONFIG_SMP
 extern void sched_exec(void);
-#else
-#define sched_exec()   {}
-#endif
 
 static inline struct task_struct *get_task_struct(struct task_struct *t)
 {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c108b5c..fa89006 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5419,8 +5419,6 @@ unsigned int nr_iowait(void)
 	return sum;
 }
 
-#ifdef CONFIG_SMP
-
 /*
  * sched_exec - execve() is a valuable balancing opportunity, because at
  * this point the task has the smallest effective memory and cache footprint.
@@ -5444,8 +5442,6 @@ void sched_exec(void)
 	stop_one_cpu(task_cpu(p), migration_cpu_stop, &arg);
 }
 
-#endif /* CONFIG_SMP */
-
 DEFINE_PER_CPU(struct kernel_stat, kstat);
 DEFINE_PER_CPU(struct kernel_cpustat, kernel_cpustat);
 

