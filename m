Return-Path: <linux-tip-commits+bounces-2990-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B1929E6A95
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2024 10:40:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0004B16B658
	for <lists+linux-tip-commits@lfdr.de>; Fri,  6 Dec 2024 09:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 588451DFDA2;
	Fri,  6 Dec 2024 09:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HnJEeK2s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FRDcRhgO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 247B71E130F;
	Fri,  6 Dec 2024 09:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733478007; cv=none; b=jzrjJEzu852lPoFssZupBd441it51cw/rlAd7GIVFhCNjJi3dQKalNAaD/h2O2rx+GX8Fn75jFqIDlKeegv0TF6YTE81BqgwKmKkhUhwNP5qVI+X6EoWbEFNSfAQNcnj07A1kAMbpyOGqmhb/8qHr9qHgGPO6TisyEd1w41GD5M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733478007; c=relaxed/simple;
	bh=mzSqbey6C2owWnVWQtAL9IH7gq+h4Uj033oVgO4bCro=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=kVDLgh1doj67//gGFbF9toK2h5S815c4WohB+99qZADeMBBxQ57ZBwe9Q7TIIIW2UqppfqX/0MeyY5KAs2NA+bMsdUGJEARHjFRwVe45HtoTSDecfePy8iParlLciPzu81xm87fgrozHnR2w+E/H6PcT2AfmpdVExBZXiS0azCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HnJEeK2s; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FRDcRhgO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 06 Dec 2024 09:40:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733478002;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xZ/J1kCyx0aTDjaWNn4/rYZ4PwXW2WS6EIyun8mwNhE=;
	b=HnJEeK2s7WC+RPNnpQfhDWhCB7+AT8BCyzTFa/e7+TMKPg4Gl7DyrVssTLbZBUd/BoeU+P
	ZHeVZBkaOkDOc0p/k8a0SIoedzY0cNaM1jx+C6il0gdh4WIy4gC4GogzdmJ8f0CppPhnjR
	Mb8vBTH5R3q6YyMB4ahCrI49o7dt1MSu68df4SgT66rTkv4C0SxpwdXdL7HjdSz0/WasIj
	MIAwnGIlvS+FCKZC34gHyUR8KNPSWMgu/VcKadeln1Ss3ButWXLXqmiw14PPHXNwFlRQEF
	Tltx+Sc3CSz/vF70lM3ILrL4NBcYICcJq0CTUt7EEY6ZshHvv/7SRHg6WTevuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733478002;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=xZ/J1kCyx0aTDjaWNn4/rYZ4PwXW2WS6EIyun8mwNhE=;
	b=FRDcRhgOSEuXCEWbxJnY/2GLqd2s+4StDWUE2G2q+af8unCj8/bEmEvnAhVJicm6oD0x2x
	vBsP/9YgXl6J8SBQ==
From: "tip-bot2 for Rik van Riel" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/mm] x86/mm/tlb: Also remove local CPU from mm_cpumask if stale
Cc: kernel test robot <oliver.sang@intel.com>, Rik van Riel <riel@surriel.com>,
 Ingo Molnar <mingo@kernel.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241205104630.755706ca@fangorn>
References: <20241205104630.755706ca@fangorn>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173347800117.412.912187512199282211.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     953753db887f9d70f70f61d6ecbe5cf209107672
Gitweb:        https://git.kernel.org/tip/953753db887f9d70f70f61d6ecbe5cf209107672
Author:        Rik van Riel <riel@surriel.com>
AuthorDate:    Thu, 05 Dec 2024 10:46:30 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 06 Dec 2024 10:25:53 +01:00

x86/mm/tlb: Also remove local CPU from mm_cpumask if stale

The code in flush_tlb_func() that removes a remote CPU from the
cpumask if it is no longer running the target mm is also needed
on the originating CPU of a TLB flush, now that CPUs are no
longer cleared from the mm_cpumask at context switch time.

Flushing the TLB when we are not running the target mm is
harmless, because the CPU's tlb_gen only gets updated to
match the mm_tlb_gen, but it does hit this warning:

        WARN_ON_ONCE(local_tlb_gen > mm_tlb_gen);

  [ 210.343902][ T4668] WARNING: CPU: 38 PID: 4668 at arch/x86/mm/tlb.c:815 flush_tlb_func (arch/x86/mm/tlb.c:815)

Removing both local and remote CPUs from the mm_cpumask
when doing a flush for a not currently loaded mm avoids
that warning.

Reported-by: kernel test robot <oliver.sang@intel.com>
Tested-by: kernel test robot <oliver.sang@intel.com>
Signed-off-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Dave Hansen <dave.hansen@linux.intel.com>
Cc: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Link: https://lore.kernel.org/r/20241205104630.755706ca@fangorn
Closes: https://lore.kernel.org/oe-lkp/202412051551.690e9656-lkp@intel.com
---
 arch/x86/mm/tlb.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 1aac4fa..3c30817 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -756,13 +756,13 @@ static void flush_tlb_func(void *info)
 	if (!local) {
 		inc_irq_stat(irq_tlb_count);
 		count_vm_tlb_event(NR_TLB_REMOTE_FLUSH_RECEIVED);
+	}
 
-		/* Can only happen on remote CPUs */
-		if (f->mm && f->mm != loaded_mm) {
-			cpumask_clear_cpu(raw_smp_processor_id(), mm_cpumask(f->mm));
-			trace_tlb_flush(TLB_REMOTE_WRONG_CPU, 0);
-			return;
-		}
+	/* The CPU was left in the mm_cpumask of the target mm. Clear it. */
+	if (f->mm && f->mm != loaded_mm) {
+		cpumask_clear_cpu(raw_smp_processor_id(), mm_cpumask(f->mm));
+		trace_tlb_flush(TLB_REMOTE_WRONG_CPU, 0);
+		return;
 	}
 
 	if (unlikely(loaded_mm == &init_mm))

