Return-Path: <linux-tip-commits+bounces-4907-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 27BECA86EFA
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Apr 2025 20:47:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 004CC8C0C42
	for <lists+linux-tip-commits@lfdr.de>; Sat, 12 Apr 2025 18:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1161B211A3C;
	Sat, 12 Apr 2025 18:46:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NVmKkdaK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="QdF2uUYU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89C2218DB20;
	Sat, 12 Apr 2025 18:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744483617; cv=none; b=BqOFK4IUzdAuOKCE49tyIW6ZpO5gkep/p2smS8PrOzG+fk0y+XvK9kij0GQjH6cr/NaUIErwAWlKivY3XxVew3ZyJnjOjhTzBtbhD+ZVrCG6yub2m8A06OA9SONxw3Ir0qa2ljweCWTeL0t/Dz+AYrot8jcL4TvjWOWYPv+PnF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744483617; c=relaxed/simple;
	bh=/P5a6PBRz7Mtjyw10t/a3Dfk4nGJnzKHMUkcABvy8Eg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dGT6DUkeOyPJYvWygG5MhHqk6ZlB7Dc5sJgZveDdPVaSdcmLB25pwSHIv/3Mg3zP9ZhIP0jaYDscO9MWS2BzAkvrmnB43K4uu+R+FJ3Tq3yvyAwxZenByL3iAaHNaalridGJinD7G7fSD6Vi4qpHWtKXXY1ZAySZy1zoer7bpng=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NVmKkdaK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=QdF2uUYU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 12 Apr 2025 18:46:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744483610;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=habJwXdCOn+ND+XX9fYkE1e5Sx1xRtmbMxj0Z5kWxXo=;
	b=NVmKkdaK4lB6NV2SPvFnBPMbfOx/iurivN+53kBokgy3247+3gjpX7hQQacxUfDVDG2nE/
	fQBJaSBKh5rmmIYFu4LV7mwFhUg//QQeXTlxgvWuDTzzWLbRQZUJqqUiJqcTVDN2uAkDiu
	3R4Awtdyg/kDUyXIvDQMkthW2AkTbm2lv38ASv9yPfGtH4c77pbeCBfdsJ2wae0IkOsUov
	XxpPtzSPRl+VDMNqk5sGfLjaCTN5GxfOsxcCqu/BlTL272nQc8fKupa6E2t8NWcjFFocZZ
	JgLqnBhmZftrc34CXubOTaXtTurtJceaWTyelSlzA/CNOj1HrWM242ZCQ+9YbA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744483610;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=habJwXdCOn+ND+XX9fYkE1e5Sx1xRtmbMxj0Z5kWxXo=;
	b=QdF2uUYUs00rXg/gY074lMjnECR+ezD9pj40RUIlT3vlp7MQq0mfu+iTxznFdLr1zjzwdT
	EVfVAlGnIw15YLBw==
From: "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/alternatives] x86/mm: Allow temporary MMs when IRQs are on
Cc: Andy Lutomirski <luto@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Rik van Riel <riel@surriel.com>,
 "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Andrew Morton <akpm@linux-foundation.org>, Ard Biesheuvel <ardb@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250402094540.3586683-6-mingo@kernel.org>
References: <20250402094540.3586683-6-mingo@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174448360994.31282.6401289207692327621.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/alternatives branch of tip:

Commit-ID:     58f8ffa917669a0c8c027e24d5349f0b488f8181
Gitweb:        https://git.kernel.org/tip/58f8ffa917669a0c8c027e24d5349f0b488f8181
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Wed, 02 Apr 2025 11:45:38 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 12 Apr 2025 10:06:00 +02:00

x86/mm: Allow temporary MMs when IRQs are on

EFI runtime services should use temporary MMs, but EFI runtime services
want IRQs on.  Preemption must still be disabled in a temporary MM context.

At some point, the entirely temporary MM mechanism should be moved out of
arch code.

Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Rik van Riel <riel@surriel.com>
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Ard Biesheuvel <ardb@kernel.org>
Link: https://lore.kernel.org/r/20250402094540.3586683-6-mingo@kernel.org
---
 arch/x86/mm/tlb.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 38fdcf8..c9b87e5 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -977,18 +977,23 @@ void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
  * that override the kernel memory protections (e.g., W^X), without exposing the
  * temporary page-table mappings that are required for these write operations to
  * other CPUs. Using a temporary mm also allows to avoid TLB shootdowns when the
- * mapping is torn down.
+ * mapping is torn down.  Temporary mms can also be used for EFI runtime service
+ * calls or similar functionality.
  *
- * Context: The temporary mm needs to be used exclusively by a single core. To
- *          harden security IRQs must be disabled while the temporary mm is
- *          loaded, thereby preventing interrupt handler bugs from overriding
- *          the kernel memory protection.
+ * It is illegal to schedule while using a temporary mm -- the context switch
+ * code is unaware of the temporary mm and does not know how to context switch.
+ * Use a real (non-temporary) mm in a kernel thread if you need to sleep.
+ *
+ * Note: For sensitive memory writes, the temporary mm needs to be used
+ *       exclusively by a single core, and IRQs should be disabled while the
+ *       temporary mm is loaded, thereby preventing interrupt handler bugs from
+ *       overriding the kernel memory protection.
  */
 struct mm_struct *use_temporary_mm(struct mm_struct *temp_mm)
 {
 	struct mm_struct *prev_mm;
 
-	lockdep_assert_irqs_disabled();
+	lockdep_assert_preemption_disabled();
 
 	/*
 	 * Make sure not to be in TLB lazy mode, as otherwise we'll end up
@@ -1020,7 +1025,7 @@ struct mm_struct *use_temporary_mm(struct mm_struct *temp_mm)
 
 void unuse_temporary_mm(struct mm_struct *prev_mm)
 {
-	lockdep_assert_irqs_disabled();
+	lockdep_assert_preemption_disabled();
 
 	/* Clear the cpumask, to indicate no TLB flushing is needed anywhere */
 	cpumask_clear_cpu(smp_processor_id(), mm_cpumask(this_cpu_read(cpu_tlbstate.loaded_mm)));

