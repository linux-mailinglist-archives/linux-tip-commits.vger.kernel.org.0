Return-Path: <linux-tip-commits+bounces-1585-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EB3E7924A04
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 23:40:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AD663285E11
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 21:40:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BDD77205E0D;
	Tue,  2 Jul 2024 21:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="s7LIah/J";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="+jUKWyuT"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E72DE201279;
	Tue,  2 Jul 2024 21:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719956395; cv=none; b=SweYy7LAjOVp0pOHA/tz+xPmnWlAiNk1K0IqSB+cfFjtn5dd4iNTkxSisGUabBjVHueDvpmSBbROmvKG9997aGeK9DlAwKhsfeewcgYH3HnGH0fBbFB0rz+bbD0gcq8O9l3CNgbGo4uvwkqNE3rzgFXULCljdJTIJBZ57cYW02Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719956395; c=relaxed/simple;
	bh=YrSGBgXnYq8R8F7CAYcvlKpY1wjydH6UQOKmmY54csM=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=T/pGt8gFH11JwTHI7eJbd4bU5Cqb3BKm1DHqbUMAeHIoCKGxgwTrFiPtPlvSgCEk+YsAlpUwSwQBn7dxLrFF7l0fTGLjKBStsek3rIFtO63r2LlVNz+34YiNnPKe3Ngcy7WfZnrby5nRo0d8nZ6i3kD9htxq/25RfttY0YWwm0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=s7LIah/J; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=+jUKWyuT; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Jul 2024 21:39:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719956392;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=cmDCzOzK7zb7Zz8xPx5MiSsaOU8NA3Z51iO8W05uLnY=;
	b=s7LIah/JAejXXptP5X40zfmasQw2a2jU6IZWMfHhYLEbb2yq3GFZPPAsH8PgbURpswEKN8
	MxAwg/Ot2sBS6tE9kodpLQlaWkIQuWJVr4x+xOZctJ7Yt9Mj6+eaptE6lQu56aIZT18dU6
	dVRZsTP2qkTdmWlk1lrSncGSaGDbsIgg7nbaJrEOXJhxxPdW+z2qtG0sbcvty1hHbq0rBI
	hnDjgZcJW+ZXGo3TH//37LCnIOsWjJoFDt5F9+5AuU6dExiFN66s9QpkMw9M1ybiP/j1ni
	SHC2/F3AsYu4F9grRF9LFYey7+43lcchI+F8GxG6u0TbrEIKVXe/GYY3qtRKdA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719956392;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=cmDCzOzK7zb7Zz8xPx5MiSsaOU8NA3Z51iO8W05uLnY=;
	b=+jUKWyuT05mMbJfoquACq2d//+9hCu9/TSwY+WUZ+VTU75LNIK7NLjnXmKIGu9fS+L3Mt/
	DaWcxzkKT3H7DcDg==
From: "tip-bot2 for Yosry Ahmed" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Use IPIs to synchronize LAM enablement
Cc: Andy Lutomirski <luto@kernel.org>, Yosry Ahmed <yosryahmed@google.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171995639211.2215.8349848296734689610.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     3b299b99556c1753923f8d9bbd9304bcd139282f
Gitweb:        https://git.kernel.org/tip/3b299b99556c1753923f8d9bbd9304bcd139282f
Author:        Yosry Ahmed <yosryahmed@google.com>
AuthorDate:    Tue, 02 Jul 2024 13:21:37 
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 02 Jul 2024 11:31:51 -07:00

x86/mm: Use IPIs to synchronize LAM enablement

LAM can only be enabled when a process is single-threaded.  But _kernel_
threads can temporarily use a single-threaded process's mm.

If LAM is enabled by a userspace process while a kthread is using its
mm, the kthread will not observe LAM enablement (i.e.  LAM will be
disabled in CR3). This could be fine for the kthread itself, as LAM only
affects userspace addresses. However, if the kthread context switches to
a thread in the same userspace process, CR3 may or may not be updated
because the mm_struct doesn't change (based on pending TLB flushes). If
CR3 is not updated, the userspace thread will run incorrectly with LAM
disabled, which may cause page faults when using tagged addresses.
Example scenario:

CPU 1                                   CPU 2
/* kthread */
kthread_use_mm()
                                        /* user thread */
                                        prctl_enable_tagged_addr()
                                        /* LAM enabled on CPU 2 */
/* LAM disabled on CPU 1 */
                                        context_switch() /* to CPU 1 */
/* Switching to user thread */
switch_mm_irqs_off()
/* CR3 not updated */
/* LAM is still disabled on CPU 1 */

Synchronize LAM enablement by sending an IPI to all CPUs running with
the mm_struct to enable LAM. This makes sure LAM is enabled on CPU 1
in the above scenario before prctl_enable_tagged_addr() returns and
userspace starts using tagged addresses, and before it's possible to
run the userspace process on CPU 1.

In switch_mm_irqs_off(), move reading the LAM mask until after
mm_cpumask() is updated. This ensures that if an outdated LAM mask is
written to CR3, an IPI is received to update it right after IRQs are
re-enabled.

[ dhansen: Add a LAM enabling helper and comment it ]

Fixes: 82721d8b25d7 ("x86/mm: Handle LAM on context switch")
Suggested-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/all/20240702132139.3332013-2-yosryahmed%40google.com
---
 arch/x86/kernel/process_64.c | 29 ++++++++++++++++++++++++++---
 arch/x86/mm/tlb.c            |  7 +++----
 2 files changed, 29 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 6d3d20e..d8d582b 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -798,6 +798,27 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
 
 #define LAM_U57_BITS 6
 
+static void enable_lam_func(void *__mm)
+{
+	struct mm_struct *mm = __mm;
+
+	if (this_cpu_read(cpu_tlbstate.loaded_mm) == mm) {
+		write_cr3(__read_cr3() | mm->context.lam_cr3_mask);
+		set_tlbstate_lam_mode(mm);
+	}
+}
+
+static void mm_enable_lam(struct mm_struct *mm)
+{
+	/*
+	 * Even though the process must still be single-threaded at this
+	 * point, kernel threads may be using the mm.  IPI those kernel
+	 * threads if they exist.
+	 */
+	on_each_cpu_mask(mm_cpumask(mm), enable_lam_func, mm, true);
+	set_bit(MM_CONTEXT_LOCK_LAM, &mm->context.flags);
+}
+
 static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 {
 	if (!cpu_feature_enabled(X86_FEATURE_LAM))
@@ -814,6 +835,10 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 	if (mmap_write_lock_killable(mm))
 		return -EINTR;
 
+	/*
+	 * MM_CONTEXT_LOCK_LAM is set on clone.  Prevent LAM from
+	 * being enabled unless the process is single threaded:
+	 */
 	if (test_bit(MM_CONTEXT_LOCK_LAM, &mm->context.flags)) {
 		mmap_write_unlock(mm);
 		return -EBUSY;
@@ -830,9 +855,7 @@ static int prctl_enable_tagged_addr(struct mm_struct *mm, unsigned long nr_bits)
 		return -EINVAL;
 	}
 
-	write_cr3(__read_cr3() | mm->context.lam_cr3_mask);
-	set_tlbstate_lam_mode(mm);
-	set_bit(MM_CONTEXT_LOCK_LAM, &mm->context.flags);
+	mm_enable_lam(mm);
 
 	mmap_write_unlock(mm);
 
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 44ac64f..a041d2e 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -503,9 +503,9 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 {
 	struct mm_struct *prev = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u16 prev_asid = this_cpu_read(cpu_tlbstate.loaded_mm_asid);
-	unsigned long new_lam = mm_lam_cr3_mask(next);
 	bool was_lazy = this_cpu_read(cpu_tlbstate_shared.is_lazy);
 	unsigned cpu = smp_processor_id();
+	unsigned long new_lam;
 	u64 next_tlb_gen;
 	bool need_flush;
 	u16 new_asid;
@@ -619,9 +619,7 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 			cpumask_clear_cpu(cpu, mm_cpumask(prev));
 		}
 
-		/*
-		 * Start remote flushes and then read tlb_gen.
-		 */
+		/* Start receiving IPIs and then read tlb_gen (and LAM below) */
 		if (next != &init_mm)
 			cpumask_set_cpu(cpu, mm_cpumask(next));
 		next_tlb_gen = atomic64_read(&next->context.tlb_gen);
@@ -633,6 +631,7 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 		barrier();
 	}
 
+	new_lam = mm_lam_cr3_mask(next);
 	set_tlbstate_lam_mode(next);
 	if (need_flush) {
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].ctx_id, next->context.ctx_id);

