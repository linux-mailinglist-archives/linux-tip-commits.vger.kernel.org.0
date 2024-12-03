Return-Path: <linux-tip-commits+bounces-2957-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AA7AD9E19A2
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Dec 2024 11:45:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70633285BB0
	for <lists+linux-tip-commits@lfdr.de>; Tue,  3 Dec 2024 10:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC0521E230D;
	Tue,  3 Dec 2024 10:44:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="An5JReBz";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0nMmcWaw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EFA01E22E9;
	Tue,  3 Dec 2024 10:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733222680; cv=none; b=Z3q6zTC6l1cEoM6BWAld9OJbA9Nj8IqZeXkxk+m6+FmmD3qHEJNwi2nlQYXHLOvOKnJebIYpecDo78CHdWSD6sqUbm7eQEX8fyUfZgkK5ompuFbBVA4b0ItINK4FDoLQi+NIhSk+sidGCkC6zgUnm6UET8DYIcQeA5o7aJ1gySs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733222680; c=relaxed/simple;
	bh=Zr3P9bnPsfdrN22F3DTQ6+XOmUzBlGEeKjBs/OU/Avo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OuXecO4me4hIVAWpktPQAgBQdLbNgth9gxSh1LcLF1lY7h7O8LWK7BPk3Iymor0RzbKWLLSfm7k3HYbzwNObPT46BvkpwRROT/1LV7c0sToFGQyIURplsjvSUJFt2vIMd2jGK6wg6xBYob+QUXklk+tlZHUx0DrxifUM5fRmG0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=An5JReBz; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0nMmcWaw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 03 Dec 2024 10:44:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733222677;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BIrXjrNs8GypLg/iqHwrNA3eu3+7CZN+VKLSe2NLMjg=;
	b=An5JReBzGVMzJzjRwogG5W4IBYryW9IedMa/VtTJlYjlb1lDQ9JPaEkuYbydWstZnt5o0K
	cw27cPjbsg+LcaYVUTEVagkq/B6nI21Hjq0/q912X4d2u/Z+kXTXJKYXaWBxKW01Hp1OJ1
	CfXDWKLlYS59Wquw1GhxXZ52Yqwe1lvvqAb4R+V1SR9APQTL0ycnfSO9bY+W3c4rjR72EL
	5XSHNS23u7uA4mg8U3kQ61Wf6z6rRwpxu+xb9+3243CvRmOjasCF9yeBPTH42+4OUtTbMe
	T+XCAZwOuERElqmAEfDiD6dRFKP331Uwu3OIRwDymB0slN9SapqqUOWeQWFm8Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733222677;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BIrXjrNs8GypLg/iqHwrNA3eu3+7CZN+VKLSe2NLMjg=;
	b=0nMmcWawK1cOONTDAE2AObaLbL5dk9TuqU70eCDjtXdh8mg/vVZJNOGtcy4PhmSuNEtfQg
	z6YfHOQakggHwQBA==
From: "tip-bot2 for Waiman Long" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Unify HK_TYPE_{TIMER|TICK|MISC} to
 HK_TYPE_KERNEL_NOISE
Cc: Waiman Long <longman@redhat.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241030175253.125248-5-longman@redhat.com>
References: <20241030175253.125248-5-longman@redhat.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173322267649.412.12071655642494350420.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c907cd44a108eff7005a2b5689bb91f50637df8b
Gitweb:        https://git.kernel.org/tip/c907cd44a108eff7005a2b5689bb91f50637df8b
Author:        Waiman Long <longman@redhat.com>
AuthorDate:    Wed, 30 Oct 2024 13:52:53 -04:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:24:28 +01:00

sched: Unify HK_TYPE_{TIMER|TICK|MISC} to HK_TYPE_KERNEL_NOISE

As all the non-domain and non-managed_irq housekeeping types have been
unified to HK_TYPE_KERNEL_NOISE, replace all these references in the
scheduler to use HK_TYPE_KERNEL_NOISE.

Signed-off-by: Waiman Long <longman@redhat.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Frederic Weisbecker <frederic@kernel.org>
Link: https://lore.kernel.org/r/20241030175253.125248-5-longman@redhat.com
---
 kernel/sched/core.c | 12 ++++++------
 kernel/sched/fair.c |  5 +++--
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1dee3f5..5fbec67 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1170,13 +1170,13 @@ int get_nohz_timer_target(void)
 	struct sched_domain *sd;
 	const struct cpumask *hk_mask;
 
-	if (housekeeping_cpu(cpu, HK_TYPE_TIMER)) {
+	if (housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE)) {
 		if (!idle_cpu(cpu))
 			return cpu;
 		default_cpu = cpu;
 	}
 
-	hk_mask = housekeeping_cpumask(HK_TYPE_TIMER);
+	hk_mask = housekeeping_cpumask(HK_TYPE_KERNEL_NOISE);
 
 	guard(rcu)();
 
@@ -1191,7 +1191,7 @@ int get_nohz_timer_target(void)
 	}
 
 	if (default_cpu == -1)
-		default_cpu = housekeeping_any_cpu(HK_TYPE_TIMER);
+		default_cpu = housekeeping_any_cpu(HK_TYPE_KERNEL_NOISE);
 
 	return default_cpu;
 }
@@ -5634,7 +5634,7 @@ void sched_tick(void)
 	unsigned long hw_pressure;
 	u64 resched_latency;
 
-	if (housekeeping_cpu(cpu, HK_TYPE_TICK))
+	if (housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE))
 		arch_scale_freq_tick();
 
 	sched_clock_tick();
@@ -5773,7 +5773,7 @@ static void sched_tick_start(int cpu)
 	int os;
 	struct tick_work *twork;
 
-	if (housekeeping_cpu(cpu, HK_TYPE_TICK))
+	if (housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE))
 		return;
 
 	WARN_ON_ONCE(!tick_work_cpu);
@@ -5794,7 +5794,7 @@ static void sched_tick_stop(int cpu)
 	struct tick_work *twork;
 	int os;
 
-	if (housekeeping_cpu(cpu, HK_TYPE_TICK))
+	if (housekeeping_cpu(cpu, HK_TYPE_KERNEL_NOISE))
 		return;
 
 	WARN_ON_ONCE(!tick_work_cpu);
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index ef30226..d5127d9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -12203,7 +12203,7 @@ static inline int find_new_ilb(void)
 	const struct cpumask *hk_mask;
 	int ilb_cpu;
 
-	hk_mask = housekeeping_cpumask(HK_TYPE_MISC);
+	hk_mask = housekeeping_cpumask(HK_TYPE_KERNEL_NOISE);
 
 	for_each_cpu_and(ilb_cpu, nohz.idle_cpus_mask, hk_mask) {
 
@@ -12221,7 +12221,8 @@ static inline int find_new_ilb(void)
  * Kick a CPU to do the NOHZ balancing, if it is time for it, via a cross-CPU
  * SMP function call (IPI).
  *
- * We pick the first idle CPU in the HK_TYPE_MISC housekeeping set (if there is one).
+ * We pick the first idle CPU in the HK_TYPE_KERNEL_NOISE housekeeping set
+ * (if there is one).
  */
 static void kick_ilb(unsigned int flags)
 {

