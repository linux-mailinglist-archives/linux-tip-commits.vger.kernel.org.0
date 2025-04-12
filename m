Return-Path: <linux-tip-commits+bounces-4909-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DA53A86EFB
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Apr 2025 20:47:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0FE2917E9C6
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Apr 2025 18:47:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 884F321D3EE;
	Sat, 12 Apr 2025 18:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wZwmq9I8";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OXZbFCNS"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53FAC1946C3;
	Sat, 12 Apr 2025 18:46:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744483617; cv=none; b=cQCt8ig4oSLkMsrSy5SVWxyz859+1MGCJ3TMnq8C8+VJ3Tj3MqYgy0PzNzThyd2QS5XT5gg/3sQNMxzxZGihZ7xKb+Lmwp3pt54Y6dmOmx4bTjiH3REsQTB5GtFIdnF60chuZly0dbm30Vjh1z+0rCb6uvfjjl+MqhXXRFdAv5A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744483617; c=relaxed/simple;
	bh=4KL/2Qi5kAkchXg/4Saj5zrDmAwXeqfugbP6f8bxzi0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=o28KDJFFlKXZHUqcRIxS951LWLLCYUOirRQ2wP7c5sPct3P02/TvuYBOUvAAuggzSAmJWyC1skLYm16PRip2/ukIK+b1QyM2Aoto+ozxz8o9F3MfDAyZIkAHjPK4uux/+yvUGSYI1pDvUHoBULssqYEnsQNqB4rswp2CHHtJaek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=wZwmq9I8; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OXZbFCNS; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 12 Apr 2025 18:46:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744483612;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e2XtOn1NuOe8lwT//g1/NEbt+eBmvNW+evBZrOXyVj8=;
	b=wZwmq9I8PrQ3TzXjfhePP/NQVce6fn/8bo6IkZH95/ROLp+yWeJ4i3CnaEHEE7wyiXZhO+
	iwXL0/6GgEgKvl0HOENDHnA+p9G04J1cAknFE6qSCM9IYZL4RpHNkB0vntDXJlAsRA/aPL
	x/5JXMH7uhUh8mx7ewhMOiM0r+YukWLx2p3LegXi3PmomNcdMAinU1EBS817+EXsNMXXEi
	oFyqz6uIMzeCPgpuB9U9bvSzX3K+Tg2U8r3pvms1sEeEcS2TpaC7UEQojjc1hpusvgtdho
	HPbAmkkx2e6v9XeGfUdYRpUL/OCiOhgfEsQtK79HxiChYnQ0B9G0nXjRS5mieg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744483612;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=e2XtOn1NuOe8lwT//g1/NEbt+eBmvNW+evBZrOXyVj8=;
	b=OXZbFCNSGRRmmDuBQ/ThLq5m0GhrzPDPkh1MEl0l1oqEwgUoiqom83jCcHVmY20mGN3Cl0
	pSNWKfFbOXHYUWDg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/mm: Remove 'mm' argument from
 unuse_temporary_mm() again
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 Rik van Riel <riel@surriel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250402094540.3586683-5-mingo@kernel.org>
References: <20250402094540.3586683-5-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174448361126.31282.16172634095682197320.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     4873f494bbe4670f353a9b76ce44e6028c811cbb
Gitweb:        https://git.kernel.org/tip/4873f494bbe4670f353a9b76ce44e6028c811cbb
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 02 Apr 2025 11:45:37 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 12 Apr 2025 10:05:56 +02:00

x86/mm: Remove 'mm' argument from unuse_temporary_mm() again

Now that unuse_temporary_mm() lives in tlb.c it can access
cpu_tlbstate.loaded_mm.

[ mingo: Merged it on top of x86/alternatives ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Link: https://lore.kernel.org/r/20250402094540.3586683-5-mingo@kernel.org
---
 arch/x86/include/asm/mmu_context.h | 2 +-
 arch/x86/kernel/alternative.c      | 2 +-
 arch/x86/mm/tlb.c                  | 8 ++++----
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index b103e17..988c117 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -273,6 +273,6 @@ unsigned long __get_current_cr3_fast(void);
 #include <asm-generic/mmu_context.h>
 
 extern struct mm_struct *use_temporary_mm(struct mm_struct *temp_mm);
-extern void unuse_temporary_mm(struct mm_struct *mm, struct mm_struct *prev_mm);
+extern void unuse_temporary_mm(struct mm_struct *prev_mm);
 
 #endif /* _ASM_X86_MMU_CONTEXT_H */
diff --git a/arch/x86/kernel/alternative.c b/arch/x86/kernel/alternative.c
index bdbdfa0..ddbc303 100644
--- a/arch/x86/kernel/alternative.c
+++ b/arch/x86/kernel/alternative.c
@@ -2211,7 +2211,7 @@ static void *__text_poke(text_poke_f func, void *addr, const void *src, size_t l
 	 * instruction that already allows the core to see the updated version.
 	 * Xen-PV is assumed to serialize execution in a similar manner.
 	 */
-	unuse_temporary_mm(text_poke_mm, prev_mm);
+	unuse_temporary_mm(prev_mm);
 
 	/*
 	 * Flushing the TLB might involve IPIs, which would require enabled
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index f3da20b..38fdcf8 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -1018,14 +1018,14 @@ struct mm_struct *use_temporary_mm(struct mm_struct *temp_mm)
 	return prev_mm;
 }
 
-void unuse_temporary_mm(struct mm_struct *mm, struct mm_struct *prev_mm)
+void unuse_temporary_mm(struct mm_struct *prev_mm)
 {
 	lockdep_assert_irqs_disabled();
 
-	switch_mm_irqs_off(NULL, prev_mm, current);
-
 	/* Clear the cpumask, to indicate no TLB flushing is needed anywhere */
-	cpumask_clear_cpu(raw_smp_processor_id(), mm_cpumask(mm));
+	cpumask_clear_cpu(smp_processor_id(), mm_cpumask(this_cpu_read(cpu_tlbstate.loaded_mm)));
+
+	switch_mm_irqs_off(NULL, prev_mm, current);
 
 	/*
 	 * Restore the breakpoints if they were disabled before the temporary mm

