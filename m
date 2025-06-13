Return-Path: <linux-tip-commits+bounces-5791-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id E7371AD8470
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:41:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9C8A5189BFF7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 383AC2E7627;
	Fri, 13 Jun 2025 07:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="S3R3b/AR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="poHaB9Oh"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B7A32E7623;
	Fri, 13 Jun 2025 07:37:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749800239; cv=none; b=g/NQk5H+fxRVHw1b8hT2bXojIoaz3VaNRe6TbHTVMqaozLa6JcyHoA0R/J7J5yCejvSBS2bP0eIJl7/hHOd0NbKV70oRREbFsvLSRj/oTxj3hfTTYuDQIkGPyahJT2reUaW+jKc5mM06Y8AbYoGU/N/3R8YR1HmQcNDw32BF960=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749800239; c=relaxed/simple;
	bh=Gz3YO/rkYO2yQM88vcS8E2BXUe0crAailWWojf3Bs5c=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kXeAsoxrMnwOsjpNUeHGUMOrbKDLT6NUL+FFPYzu2foC1vmIa/BD4JKXZKmde3Eay0HnW+8Up2aQ6fI4KF9vTdG0JN3Nf8CXhcElvRJPne5eIJNkmohtYJiVFArFE/2TkN0mwc4K7g1GESB7uzOkGq+EyoaCwgWYLHOlhIx9r8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=S3R3b/AR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=poHaB9Oh; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:37:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749800236;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hUbrOoGU9ePGcNLbGKyMHzpLE5Kymvi6zsbRMn2/Fhw=;
	b=S3R3b/ARzTQWHeXRocXs4R/E5DHK0HaGyjJVrRoTxxbFP1rIZmmaJh/oTkAk0pTtpK+cXG
	hjmxLR9TjZO7p5DGn/PToss4kSbGlmqmTVlaUZA4MuvZkHpgUqHGoq8mo3mXwkK12ZLTW2
	3NTghsdxQZkZGm9cq2pk5dp4N/jyoKt0FJQSqfkUKW1iTtXjRSsrc1xVbWU4X192/3l9/C
	Yuj8dPb6ANrrmIaJBCrusWUfK8wbGHZwFLzOhmZit+ntdvn+XRnFaZ+jNosNvu96h9yicK
	Pa0TpFbhhwliQspX4GTsfLOCVrq9T2liQ2yVGKTP6BVyAA1caUGK8zvjfhFV2Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749800236;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hUbrOoGU9ePGcNLbGKyMHzpLE5Kymvi6zsbRMn2/Fhw=;
	b=poHaB9Ohw7chnej57ldRA/2BA0I9b5GdmxzcFze5hBXU+2HvozXfKJEWwrwn550HNYCV/z
	Bw8XzZ1/HxSABCCg==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched/smp: Use the SMP version of the scheduler syscalls
Cc: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>,
 Juri Lelli <juri.lelli@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, Mel Gorman <mgorman@suse.de>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Shrikanth Hegde <sshegde@linux.ibm.com>, Steven Rostedt <rostedt@goodmis.org>,
 Valentin Schneider <vschneid@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250528080924.2273858-33-mingo@kernel.org>
References: <20250528080924.2273858-33-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174980023505.406.1464364783824682136.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8a9246ddc16c0feaa3b09ca9d2e30fbfa88d09de
Gitweb:        https://git.kernel.org/tip/8a9246ddc16c0feaa3b09ca9d2e30fbfa88d09de
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Wed, 28 May 2025 10:09:13 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 13 Jun 2025 08:47:21 +02:00

sched/smp: Use the SMP version of the scheduler syscalls

Simplify the scheduler by making CONFIG_SMP=y code in
idle_cpu(), __sched_setscheduler() and sched_setaffinity()
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
Link: https://lore.kernel.org/r/20250528080924.2273858-33-mingo@kernel.org
---
 kernel/sched/syscalls.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index d7fccf8..77ae87f 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -209,10 +209,8 @@ int idle_cpu(int cpu)
 	if (rq->nr_running)
 		return 0;
 
-#ifdef CONFIG_SMP
 	if (rq->ttwu_pending)
 		return 0;
-#endif
 
 	return 1;
 }
@@ -641,7 +639,6 @@ change:
 			goto unlock;
 		}
 #endif /* CONFIG_RT_GROUP_SCHED */
-#ifdef CONFIG_SMP
 		if (dl_bandwidth_enabled() && dl_policy(policy) &&
 				!(attr->sched_flags & SCHED_FLAG_SUGOV)) {
 			cpumask_t *span = rq->rd->span;
@@ -657,7 +654,6 @@ change:
 				goto unlock;
 			}
 		}
-#endif /* CONFIG_SMP */
 	}
 
 	/* Re-check policy now with rq lock held: */
@@ -1239,7 +1235,7 @@ long sched_setaffinity(pid_t pid, const struct cpumask *in_mask)
 	user_mask = alloc_user_cpus_ptr(NUMA_NO_NODE);
 	if (user_mask) {
 		cpumask_copy(user_mask, in_mask);
-	} else if (IS_ENABLED(CONFIG_SMP)) {
+	} else {
 		return -ENOMEM;
 	}
 

