Return-Path: <linux-tip-commits+bounces-2874-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E5C89D24CD
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 Nov 2024 12:27:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4C3041F22763
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 Nov 2024 11:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 861561C57B2;
	Tue, 19 Nov 2024 11:27:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="as2KP4RB";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="q+Odhu43"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 402F91C1F1B;
	Tue, 19 Nov 2024 11:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732015661; cv=none; b=pt+1fZPW/q++1bt0mxSjV+N5WDkxvtIRP6VN9MXI8rjY+8NEwlggn7Oyd+nNNOlFLfP6yBu1VX5FlPo+S8RUswuCsAixudhTnua0wGFCzTRPuJqHeuR1H21gxau2TTifMgG1neG5atdHsDPagfcRfNyHgaFv1PvvB33e/xVjlbw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732015661; c=relaxed/simple;
	bh=rJnNnMFY8HISxLGJsg//MuyPgpfuFaOwmxKNuDB+i1A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=OTGXsHd0GiRreWsk5uFaAbmv9aAsG00wjPTNksAD6aiVFqwJ8RuE6aPdSxqki1JhY0ngYTGPPq+SMTPek/n+tVG5qx+v4dhv+VVEnOokEB7Xo7tJB32eXz1z6yxP9wzwUL7W2TI/oAQtnkL2nSzH+2LAeCAQNoRSqaH3KOSiHwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=as2KP4RB; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=q+Odhu43; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 19 Nov 2024 11:27:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1732015656;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Rc2lqZs/OiWX41qTsaHTYJ90W2/M6qXEhnJxmQf6KI=;
	b=as2KP4RB5IgbnZB+5pUjnTmSjL1siqrjVn/8rTwjovA/HNqCn0LGxy5/r3bp95DQ7nVDsd
	iTNoDeFZ4T4C5cKjCvGLJPsQcbd99uTF1O4X28BiY0rxt3Qd73UytTEdgYfrf+ESgM9Hlt
	0zvsab9cEKbOxRl+6DISAtvmSnbEGnEjR7uDtDpbxSzLtLdMFdOX9bNW1YYdbtf8bTTHMi
	MP4xzqzZ3xpzdyKa+nDgNeJX3TpYCTpkGTQy0zAyOOyJxEEJP7B2Mv9t7v7w5SlDYzb/X9
	8pEaC0xXBUanNwnZAr6nS9r7fKWFMAtnV9kskIymyBERyopI1D6AEUhaDve1BQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1732015656;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Rc2lqZs/OiWX41qTsaHTYJ90W2/M6qXEhnJxmQf6KI=;
	b=q+Odhu43F0ohBWvl22Z646KCMqf1otMS5HTaV1S59NOEoK6pkUCTjiRjWMbY/udyO+A+7H
	z85eZhweGCC1tKBA==
From: "tip-bot2 for Rik van Riel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm/tlb: Update mm_cpumask lazily
Cc: Rik van Riel <riel@surriel.com>, Ingo Molnar <mingo@kernel.org>,
 Dave Hansen <dave.hansen@intel.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Peter Zijlstra <peterz@infradead.org>, Mel Gorman <mgorman@suse.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241114152723.1294686-2-riel@surriel.com>
References: <20241114152723.1294686-2-riel@surriel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173201565541.412.15037901822386376271.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     209954cbc7d0ce1a190fc725d20ce303d74d2680
Gitweb:        https://git.kernel.org/tip/209954cbc7d0ce1a190fc725d20ce303d74d2680
Author:        Rik van Riel <riel@surriel.com>
AuthorDate:    Thu, 14 Nov 2024 10:26:16 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 19 Nov 2024 12:02:46 +01:00

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
Cc: Dave Hansen <dave.hansen@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Mel Gorman <mgorman@suse.de>
Link: https://lore.kernel.org/r/20241114152723.1294686-2-riel@surriel.com
---
 arch/x86/kernel/alternative.c | 10 +++++++---
 arch/x86/mm/tlb.c             | 19 +++++++++----------
 2 files changed, 16 insertions(+), 13 deletions(-)

diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index d17518c..8b66a55 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -1825,11 +1825,18 @@ static inline temp_mm_state_t use_temporary_mm(struct mm_struct *mm)
 	return temp_state;
 }
 
+__ro_after_init struct mm_struct *poking_mm;
+__ro_after_init unsigned long poking_addr;
+
 static inline void unuse_temporary_mm(temp_mm_state_t prev_state)
 {
 	lockdep_assert_irqs_disabled();
+
 	switch_mm_irqs_off(NULL, prev_state.mm, current);
 
+	/* Clear the cpumask, to indicate no TLB flushing is needed anywhere */
+	cpumask_clear_cpu(raw_smp_processor_id(), mm_cpumask(poking_mm));
+
 	/*
 	 * Restore the breakpoints if they were disabled before the temporary mm
 	 * was loaded.
@@ -1838,9 +1845,6 @@ static inline void unuse_temporary_mm(temp_mm_state_t prev_state)
 		hw_breakpoint_restore();
 }
 
-__ro_after_init struct mm_struct *poking_mm;
-__ro_after_init unsigned long poking_addr;
-
 static void text_poke_memcpy(void *dst, const void *src, size_t len)
 {
 	memcpy(dst, src, len);
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

