Return-Path: <linux-tip-commits+bounces-1584-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FC6B924A03
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 23:40:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 178E3285E51
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Jul 2024 21:39:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D602205E08;
	Tue,  2 Jul 2024 21:39:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DUdJH60h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="kWsTq+uA"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C71D720125E;
	Tue,  2 Jul 2024 21:39:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719956395; cv=none; b=RAyBfA6wRk1gq6+VIktVpcTwm5HsmSfmujx5KRJiyGuN6X4whbdtVAwo+agTAwMKQ2mayQAcW/73yR0ywfCR5PjABpZI4l7WQ7lM7lnnyg8h4S8a5PQmAMADVHx+ITY1RzAaopSdlZxEOY+c9ESfETofLKAcVkasHPbZZuXCbvo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719956395; c=relaxed/simple;
	bh=EXkTHA36xaZ/WJuwN6jYULdgAzktbcUdUF3f+CHgTnk=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=Z0QvwV7ifJGAx8oHYRCijZYuXv31KFJTDWIfNths7U5uIVo6koFUqaxfm/a6I/+P0FfVtsd1B7Ha2PJhR3i4aoDRwdOH3O7wErfvYd8Kbhk2rx6MM3jv0fhW0iDhzhTtjAzbpMawLkds1A+64F6yWeQ5zuay9LgQEki08L6MKEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DUdJH60h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=kWsTq+uA; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 02 Jul 2024 21:39:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719956392;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ZxfFbmuZSoDY7dVzUMgeZi3BsB6nEAgTdeawgGRHWP0=;
	b=DUdJH60hiC6QPvMPOpnvJgydNfCwHhPwuc4nPHDMb/Gbsbo4fPK8/sOKMJVeZFUxMgzke7
	MXAyxoIM6a3Zf/t1C1vTvZNIkEfIA4HPqI7J/UasQmY3Iqgbqk0Jc/+ILL/A2sNKEOpGIK
	jIXzZI9+L+0KpRIojOLfc26BSOu+isrjavAT9rS141sQcoAu1fSHFTchHBHTaERLtCRO8g
	+lUAc1Y+Wdn7e2Ns7O0pNBBur+AjB33XW6u/m3I3Ky3kdNqBciX+/2vpFplVCkHkcPaQki
	/JVjK2m2pm+vfzSx3fJWUO8QFqrhIpj1CkbUIUZwycPdeJE69HL5UUDpjEuCOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719956392;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=ZxfFbmuZSoDY7dVzUMgeZi3BsB6nEAgTdeawgGRHWP0=;
	b=kWsTq+uAg9qDitwGzZr+cURfJgYnwr8sISdR+kbOZRn+E1eansPvMwp8fNXhGfgvequv+6
	5f853vqHCCZrXtAg==
From: "tip-bot2 for Yosry Ahmed" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] x86/mm: Fix LAM inconsistency during context switch
Cc: Yosry Ahmed <yosryahmed@google.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171995639179.2215.2455168547514360751.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     ec225f8c255fd0f256c282cc73d211550cb08b34
Gitweb:        https://git.kernel.org/tip/ec225f8c255fd0f256c282cc73d211550cb08b34
Author:        Yosry Ahmed <yosryahmed@google.com>
AuthorDate:    Tue, 02 Jul 2024 13:21:38 
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 02 Jul 2024 11:32:16 -07:00

x86/mm: Fix LAM inconsistency during context switch

LAM can only be enabled when a process is single-threaded.  But _kernel_
threads can temporarily use a single-threaded process's mm.  That means
that a context-switching kernel thread can race and observe the mm's LAM
metadata (mm->context.lam_cr3_mask) change.

The context switch code does two logical things with that metadata:
populate CR3 and populate 'cpu_tlbstate.lam'.  If it hits this race,
'cpu_tlbstate.lam' and CR3 can end up out of sync.

This de-synchronization is currently harmless.  But it is confusing and
might lead to warnings or real bugs.

Update set_tlbstate_lam_mode() to take in the LAM mask and untag mask
instead of an mm_struct pointer, and while we are at it, rename it to
cpu_tlbstate_update_lam(). This should also make it clearer that we are
updating cpu_tlbstate. In switch_mm_irqs_off(), read the LAM mask once
and use it for both the cpu_tlbstate update and the CR3 update.

Signed-off-by: Yosry Ahmed <yosryahmed@google.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Reviewed-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
Link: https://lore.kernel.org/all/20240702132139.3332013-3-yosryahmed%40google.com
---
 arch/x86/include/asm/mmu_context.h |  8 +++++++-
 arch/x86/include/asm/tlbflush.h    |  9 ++++-----
 arch/x86/kernel/process_64.c       |  6 ++++--
 arch/x86/mm/tlb.c                  |  8 +++++---
 4 files changed, 20 insertions(+), 11 deletions(-)

diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index 8dac45a..19091eb 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -88,7 +88,13 @@ static inline void switch_ldt(struct mm_struct *prev, struct mm_struct *next)
 #ifdef CONFIG_ADDRESS_MASKING
 static inline unsigned long mm_lam_cr3_mask(struct mm_struct *mm)
 {
-	return mm->context.lam_cr3_mask;
+	/*
+	 * When switch_mm_irqs_off() is called for a kthread, it may race with
+	 * LAM enablement. switch_mm_irqs_off() uses the LAM mask to do two
+	 * things: populate CR3 and populate 'cpu_tlbstate.lam'. Make sure it
+	 * reads a single value for both.
+	 */
+	return READ_ONCE(mm->context.lam_cr3_mask);
 }
 
 static inline void dup_lam(struct mm_struct *oldmm, struct mm_struct *mm)
diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 2572689..69e79ff 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -399,11 +399,10 @@ static inline  u64 tlbstate_lam_cr3_mask(void)
 	return lam << X86_CR3_LAM_U57_BIT;
 }
 
-static inline void set_tlbstate_lam_mode(struct mm_struct *mm)
+static inline void cpu_tlbstate_update_lam(unsigned long lam, u64 untag_mask)
 {
-	this_cpu_write(cpu_tlbstate.lam,
-		       mm->context.lam_cr3_mask >> X86_CR3_LAM_U57_BIT);
-	this_cpu_write(tlbstate_untag_mask, mm->context.untag_mask);
+	this_cpu_write(cpu_tlbstate.lam, lam >> X86_CR3_LAM_U57_BIT);
+	this_cpu_write(tlbstate_untag_mask, untag_mask);
 }
 
 #else
@@ -413,7 +412,7 @@ static inline u64 tlbstate_lam_cr3_mask(void)
 	return 0;
 }
 
-static inline void set_tlbstate_lam_mode(struct mm_struct *mm)
+static inline void cpu_tlbstate_update_lam(unsigned long lam, u64 untag_mask)
 {
 }
 #endif
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index d8d582b..e9f7cfd 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -801,10 +801,12 @@ static long prctl_map_vdso(const struct vdso_image *image, unsigned long addr)
 static void enable_lam_func(void *__mm)
 {
 	struct mm_struct *mm = __mm;
+	unsigned long lam;
 
 	if (this_cpu_read(cpu_tlbstate.loaded_mm) == mm) {
-		write_cr3(__read_cr3() | mm->context.lam_cr3_mask);
-		set_tlbstate_lam_mode(mm);
+		lam = mm_lam_cr3_mask(mm);
+		write_cr3(__read_cr3() | lam);
+		cpu_tlbstate_update_lam(lam, mm_untag_mask(mm));
 	}
 }
 
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index a041d2e..1fe9ba3 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -11,6 +11,7 @@
 #include <linux/sched/smt.h>
 #include <linux/task_work.h>
 #include <linux/mmu_notifier.h>
+#include <linux/mmu_context.h>
 
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
@@ -632,7 +633,6 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 	}
 
 	new_lam = mm_lam_cr3_mask(next);
-	set_tlbstate_lam_mode(next);
 	if (need_flush) {
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].ctx_id, next->context.ctx_id);
 		this_cpu_write(cpu_tlbstate.ctxs[new_asid].tlb_gen, next_tlb_gen);
@@ -651,6 +651,7 @@ void switch_mm_irqs_off(struct mm_struct *unused, struct mm_struct *next,
 
 	this_cpu_write(cpu_tlbstate.loaded_mm, next);
 	this_cpu_write(cpu_tlbstate.loaded_mm_asid, new_asid);
+	cpu_tlbstate_update_lam(new_lam, mm_untag_mask(next));
 
 	if (next != prev) {
 		cr4_update_pce_mm(next);
@@ -697,6 +698,7 @@ void initialize_tlbstate_and_flush(void)
 	int i;
 	struct mm_struct *mm = this_cpu_read(cpu_tlbstate.loaded_mm);
 	u64 tlb_gen = atomic64_read(&init_mm.context.tlb_gen);
+	unsigned long lam = mm_lam_cr3_mask(mm);
 	unsigned long cr3 = __read_cr3();
 
 	/* Assert that CR3 already references the right mm. */
@@ -704,7 +706,7 @@ void initialize_tlbstate_and_flush(void)
 
 	/* LAM expected to be disabled */
 	WARN_ON(cr3 & (X86_CR3_LAM_U48 | X86_CR3_LAM_U57));
-	WARN_ON(mm_lam_cr3_mask(mm));
+	WARN_ON(lam);
 
 	/*
 	 * Assert that CR4.PCIDE is set if needed.  (CR4.PCIDE initialization
@@ -723,7 +725,7 @@ void initialize_tlbstate_and_flush(void)
 	this_cpu_write(cpu_tlbstate.next_asid, 1);
 	this_cpu_write(cpu_tlbstate.ctxs[0].ctx_id, mm->context.ctx_id);
 	this_cpu_write(cpu_tlbstate.ctxs[0].tlb_gen, tlb_gen);
-	set_tlbstate_lam_mode(mm);
+	cpu_tlbstate_update_lam(lam, mm_untag_mask(mm));
 
 	for (i = 1; i < TLB_NR_DYN_ASIDS; i++)
 		this_cpu_write(cpu_tlbstate.ctxs[i].ctx_id, 0);

