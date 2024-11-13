Return-Path: <linux-tip-commits+bounces-2843-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 93A8C9C677F
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Nov 2024 04:00:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56C8D28408E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Nov 2024 03:00:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F69C15D5A1;
	Wed, 13 Nov 2024 02:59:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RdmYylqg";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Kvu9rVFy"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59E9115ADA6;
	Wed, 13 Nov 2024 02:59:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731466796; cv=none; b=GBOqZpLCyuPsDsTpaSmnQsX38aBh+Tf72WUeHnC3ZqdLz0reFsrdZdeHUosf/ok+XcLQxRSFTZ83yg8hzGFrkdp8iaj0oOLmqRIsbwOdFl2bbj1fNgdbp+P3bcQCET3U8StI/BG8FVhvIh8kmMjjKQM64jxjNhV1QSsSJUmBJqM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731466796; c=relaxed/simple;
	bh=WL19qmKu92Nxo6APJvnG8iFxSTqdydLBit2onDOktYI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ZGTIsCMhXWSrOvCF0zP2HW7B7llTqEImfe98CTfl47Od6tVKqJ5ns2E7dLKv8eh/jRVs7sW0+9FZC3b2+BFKHHPhQMlVr0rSP/k080vMqyaANZKSHYOTq5ckjfXjZmL1LUJm5r1wakck4Ruze2Jd7zsPTosns1PkrBa5rzZOg5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RdmYylqg; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Kvu9rVFy; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 13 Nov 2024 02:59:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1731466792;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v882CPUuqD1RUjJ261eUthSQEZzzdrr4v6FWxALS6UI=;
	b=RdmYylqgOuEwhZnw+K9sxceM63cnSALgF7dG7kx9deXUI0wxoa3h4aNwXh97tRPpploA2X
	R/uumsGvdcxY9OvXUh9vGCLiH9WAWY7+qr8F7WdFuDusZW4mUQ2/yOTRSZrOfbJIbOnsL1
	FaU3N+jSxk+jxuCSLT+Pe+c4/PiFrVH/9VN7MuHgJRpNmu9007yWRbsauMwhfsEKAK9EHr
	qHRJE6kNycYFPDM4KsuPlX637wOkxogAIJzXmvfvxNDxP//pSqB3gXDzMc4NeYOD+dEjMK
	9S6YnvjFMLDCSyBto6Uf95McD8qLzE4c5qHx+jJcJbKu/MeH1OzKXwNe2xSneA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1731466792;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v882CPUuqD1RUjJ261eUthSQEZzzdrr4v6FWxALS6UI=;
	b=Kvu9rVFywZZZ8Vx6O4OewvASAyt5uaHlN1AeOS6KIPF21qGHT94D6UJeS4OKc4eJ4MSgc7
	Ypt5TkY5HBNjKrCA==
From: "tip-bot2 for Rik van Riel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/tlb: Update mm_cpumask lazily
Cc: Rik van Riel <riel@surriel.com>, Ingo Molnar <mingo@kernel.org>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241109003727.3958374-2-riel@surriel.com>
References: <20241109003727.3958374-2-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173146679188.32228.42560571349217044.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     d6c1b74d0d5e06106ed6571e4dc90f6b94fff63a
Gitweb:        https://git.kernel.org/tip/d6c1b74d0d5e06106ed6571e4dc90f6b94fff63a
Author:        Rik van Riel <riel@surriel.com>
AuthorDate:    Fri, 08 Nov 2024 19:27:48 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 13 Nov 2024 03:42:41 +01:00

x86/mm/tlb: Update mm_cpumask lazily

On busy multi-threaded workloads, there can be significant contention
on the mm_cpumask at context switch time.

Reduce that contention by updating mm_cpumask lazily, setting the CPU bit
at context switch time (if not already set), and clearing the CPU bit at
the first TLB flush sent to a CPU where the process isn't running.

When a flurry of TLB flushes for a process happen, only the first one
will be sent to CPUs where the process isn't running. The others will
be sent to CPUs where the process is currently running.

On an AMD Milan system with 36 cores, there is a noticeable difference:

  $ hackbench --groups 20 --loops 10000

  Before: ~4.5s +/- 0.1s
  After:  ~4.2s +/- 0.1s

Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20241109003727.3958374-2-riel@surriel.com
---
 arch/x86/mm/tlb.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index b0d5a64..cc4e57a 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -606,18 +606,15 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 		cond_mitigation(tsk);
 
 		/*
-		 * Stop remote flushes for the previous mm.
-		 * Skip kernel threads; we never send init_mm TLB flushing IPIs,
-		 * but the bitmap manipulation can cause cache line contention.
+		 * Leave this CPU in prev's mm_cpumask. Atomic writes to
+		 * mm_cpumask can be expensive under contention. The CPU
+		 * will be removed lazily at TLB flush time.
 		 */
-		if (prev != &init_mm) {
-			VM_WARN_ON_ONCE(!cpumask_test_cpu(cpu,
-						mm_cpumask(prev)));
-			cpumask_clear_cpu(cpu, mm_cpumask(prev));
-		}
+		VM_WARN_ON_ONCE(prev != &init_mm && !cpumask_test_cpu(cpu,
+				mm_cpumask(prev)));
 
 		/* Start receiving IPIs and then read tlb_gen (and LAM below) */
-		if (next != &init_mm)
+		if (next != &init_mm && !cpumask_test_cpu(cpu, mm_cpumask(next)))
 			cpumask_set_cpu(cpu, mm_cpumask(next));
 		next_tlb_gen = atomic64_read(&next->context.tlb_gen);
 
@@ -761,8 +758,10 @@ static void flush_tlb_func(void *info)
 		count_vm_tlb_event(NR_TLB_REMOTE_FLUSH_RECEIVED);
 
 		/* Can only happen on remote CPUs */
-		if (f->mm && f->mm != loaded_mm)
+		if (f->mm && f->mm != loaded_mm) {
+			cpumask_clear_cpu(raw_smp_processor_id(), mm_cpumask(f->mm));
 			return;
+		}
 	}
 
 	if (unlikely(loaded_mm == &init_mm))

