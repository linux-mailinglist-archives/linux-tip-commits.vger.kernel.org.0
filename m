Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 842CC26CB76
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 22:28:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727624AbgIPU2K (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 16:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726973AbgIPRYQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 13:24:16 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C18C0A893C;
        Wed, 16 Sep 2020 06:11:22 -0700 (PDT)
Date:   Wed, 16 Sep 2020 13:11:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600261879;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wHcQMFIlEE4yfMflpfLhJ97enWhS8faSkDIM67XcnVU=;
        b=LqoamPPPRs3i3hPIeoGIM5ENer89YWoiLzUbXBhxw9jMT9GHaQiMBUiiVl4+Y+ULffvVD4
        6PqbJY/57tcFXV2TTkpgM3eWmNPqqT6yKUFgkJ7zqwh8MBc1aDDJmM4s57vSF0fUhQFfQI
        irRr55GHJVvXCGHz1xSEPgwYi6Q9fSjM0mKD3aVgolPkSU5+BM03nPJi9Teh/8Buwetuzv
        fhEM9n7SAlurWTBW6oWY020TQ4wXr5ynbg8WRZMT6vkYdGj79EndJ/JOxeoCsBezjd9ZXk
        JETBbD8v/dEAM9XQOmQLSi7ssdci9mS2JC4ThVBlWRmEJRn7YpX5CNQ/0VZ9Rw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600261879;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=wHcQMFIlEE4yfMflpfLhJ97enWhS8faSkDIM67XcnVU=;
        b=LlaKtUI77uYKQqyPofHHSNbuASRb2nOIVqrEMC9LrBPY2nu9vrlgkb6Dq1QQsLQ/8uSoJZ
        KVCtNEkDGsYXfhAQ==
From:   "tip-bot2 for Balbir Singh" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/pti] x86/mm: Optionally flush L1D on context switch
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Balbir Singh <sblbir@amazon.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200729001103.6450-4-sblbir@amazon.com>
References: <20200729001103.6450-4-sblbir@amazon.com>
MIME-Version: 1.0
Message-ID: <160026187911.15536.18319428088594496840.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/pti branch of tip:

Commit-ID:     a9210620ec360f7375282ff1d35c8f8016ccc986
Gitweb:        https://git.kernel.org/tip/a9210620ec360f7375282ff1d35c8f8016ccc986
Author:        Balbir Singh <sblbir@amazon.com>
AuthorDate:    Wed, 29 Jul 2020 10:11:01 +10:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 15:08:02 +02:00

x86/mm: Optionally flush L1D on context switch

Implement a mechanism to selectively flush the L1D cache. The goal is to
allow tasks that want to save sensitive information, found by the recent
snoop assisted data sampling vulnerabilites, to flush their L1D on being
switched out.  This protects their data from being snooped or leaked via
side channels after the task has context switched out.

There are two scenarios we might want to protect against, a task leaving
the CPU with data still in L1D (which is the main concern of this patch),
the second scenario is a malicious task coming in (not so well trusted)
for which we want to clean up the cache before it starts. Only the case
for the former is addressed.

A new thread_info flag TIF_SPEC_L1D_FLUSH is added to track tasks which
opt-into L1D flushing. cpu_tlbstate.last_user_mm_spec is used to convert
the TIF flags into mm state (per cpu via last_user_mm_spec) in
cond_mitigation(), which then used to do decide when to flush the
L1D cache.

A new helper inline function l1d_flush_hw() has been introduced.
Currently it returns an error code if hardware flushing is not
supported.  The caller currently does not check the return value, in the
context of these patches, the routine is called only when HW assisted
flushing is available.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Balbir Singh <sblbir@amazon.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20200729001103.6450-4-sblbir@amazon.com

---
 arch/x86/include/asm/cacheflush.h  |  8 ++++++++-
 arch/x86/include/asm/thread_info.h |  9 +++++++--
 arch/x86/mm/tlb.c                  | 30 ++++++++++++++++++++++++++---
 3 files changed, 42 insertions(+), 5 deletions(-)

diff --git a/arch/x86/include/asm/cacheflush.h b/arch/x86/include/asm/cacheflush.h
index b192d91..554eaf6 100644
--- a/arch/x86/include/asm/cacheflush.h
+++ b/arch/x86/include/asm/cacheflush.h
@@ -10,4 +10,12 @@
 
 void clflush_cache_range(void *addr, unsigned int size);
 
+static inline int l1d_flush_hw(void)
+{
+	if (static_cpu_has(X86_FEATURE_FLUSH_L1D)) {
+		wrmsrl(MSR_IA32_FLUSH_CMD, L1D_FLUSH);
+		return 0;
+	}
+	return -EOPNOTSUPP;
+}
 #endif /* _ASM_X86_CACHEFLUSH_H */
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 267701a..c448fcf 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -84,7 +84,7 @@ struct thread_info {
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_SECCOMP		8	/* secure computing */
 #define TIF_SPEC_IB		9	/* Indirect branch speculation mitigation */
-#define TIF_SPEC_FORCE_UPDATE	10	/* Force speculation MSR update in context switch */
+#define TIF_SPEC_L1D_FLUSH	10	/* Flush L1D on mm switches (processes) */
 #define TIF_USER_RETURN_NOTIFY	11	/* notify kernel of userspace return */
 #define TIF_UPROBE		12	/* breakpointed or singlestepping */
 #define TIF_PATCH_PENDING	13	/* pending live patching update */
@@ -96,6 +96,7 @@ struct thread_info {
 #define TIF_MEMDIE		20	/* is terminating due to OOM killer */
 #define TIF_POLLING_NRFLAG	21	/* idle is polling for TIF_NEED_RESCHED */
 #define TIF_IO_BITMAP		22	/* uses I/O bitmap */
+#define TIF_SPEC_FORCE_UPDATE	23	/* Force speculation MSR update in context switch */
 #define TIF_FORCED_TF		24	/* true if TF in eflags artificially */
 #define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
 #define TIF_LAZY_MMU_UPDATES	27	/* task is updating the mmu lazily */
@@ -114,7 +115,7 @@ struct thread_info {
 #define _TIF_SYSCALL_AUDIT	(1 << TIF_SYSCALL_AUDIT)
 #define _TIF_SECCOMP		(1 << TIF_SECCOMP)
 #define _TIF_SPEC_IB		(1 << TIF_SPEC_IB)
-#define _TIF_SPEC_FORCE_UPDATE	(1 << TIF_SPEC_FORCE_UPDATE)
+#define _TIF_SPEC_L1D_FLUSH	(1 << TIF_SPEC_L1D_FLUSH)
 #define _TIF_USER_RETURN_NOTIFY	(1 << TIF_USER_RETURN_NOTIFY)
 #define _TIF_UPROBE		(1 << TIF_UPROBE)
 #define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
@@ -125,6 +126,7 @@ struct thread_info {
 #define _TIF_SLD		(1 << TIF_SLD)
 #define _TIF_POLLING_NRFLAG	(1 << TIF_POLLING_NRFLAG)
 #define _TIF_IO_BITMAP		(1 << TIF_IO_BITMAP)
+#define _TIF_SPEC_FORCE_UPDATE	(1 << TIF_SPEC_FORCE_UPDATE)
 #define _TIF_FORCED_TF		(1 << TIF_FORCED_TF)
 #define _TIF_BLOCKSTEP		(1 << TIF_BLOCKSTEP)
 #define _TIF_LAZY_MMU_UPDATES	(1 << TIF_LAZY_MMU_UPDATES)
@@ -230,6 +232,9 @@ static inline int arch_within_stack_frames(const void * const stack,
 			   current_thread_info()->status & TS_COMPAT)
 #endif
 
+extern int enable_l1d_flush_for_task(struct task_struct *tsk);
+extern int disable_l1d_flush_for_task(struct task_struct *tsk);
+
 extern void arch_task_cache_init(void);
 extern int arch_dup_task_struct(struct task_struct *dst, struct task_struct *src);
 extern void arch_release_task_struct(struct task_struct *tsk);
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index 6bbd758..6369a54 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -8,11 +8,13 @@
 #include <linux/export.h>
 #include <linux/cpu.h>
 #include <linux/debugfs.h>
+#include <linux/sched/smt.h>
 
 #include <asm/tlbflush.h>
 #include <asm/mmu_context.h>
 #include <asm/nospec-branch.h>
 #include <asm/cache.h>
+#include <asm/cacheflush.h>
 #include <asm/apic.h>
 #include <asm/uv/uv.h>
 
@@ -43,14 +45,15 @@
  */
 
 /*
- * Bits to mangle the TIF_SPEC_IB state into the mm pointer which is
+ * Bits to mangle the TIF_SPEC_* state into the mm pointer which is
  * stored in cpu_tlb_state.last_user_mm_spec.
  */
 #define LAST_USER_MM_IBPB	0x1UL
-#define LAST_USER_MM_SPEC_MASK	(LAST_USER_MM_IBPB)
+#define LAST_USER_MM_L1D_FLUSH	0x2UL
+#define LAST_USER_MM_SPEC_MASK	(LAST_USER_MM_IBPB | LAST_USER_MM_L1D_FLUSH)
 
 /* Bits to set when tlbstate and flush is (re)initialized */
-#define LAST_USER_MM_INIT	LAST_USER_MM_IBPB
+#define LAST_USER_MM_INIT	(LAST_USER_MM_IBPB | LAST_USER_MM_L1D_FLUSH)
 
 /*
  * The x86 feature is called PCID (Process Context IDentifier). It is similar
@@ -311,6 +314,18 @@ void leave_mm(int cpu)
 }
 EXPORT_SYMBOL_GPL(leave_mm);
 
+int enable_l1d_flush_for_task(struct task_struct *tsk)
+{
+	set_ti_thread_flag(&tsk->thread_info, TIF_SPEC_L1D_FLUSH);
+	return 0;
+}
+
+int disable_l1d_flush_for_task(struct task_struct *tsk)
+{
+	clear_ti_thread_flag(&tsk->thread_info, TIF_SPEC_L1D_FLUSH);
+	return 0;
+}
+
 void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	       struct task_struct *tsk)
 {
@@ -326,6 +341,7 @@ static inline unsigned long mm_mangle_tif_spec_bits(struct task_struct *next)
 	unsigned long next_tif = task_thread_info(next)->flags;
 	unsigned long spec_bits = (next_tif >> TIF_SPEC_IB) & LAST_USER_MM_SPEC_MASK;
 
+	BUILD_BUG_ON(TIF_SPEC_L1D_FLUSH != TIF_SPEC_IB + 1);
 	return (unsigned long)next->mm | spec_bits;
 }
 
@@ -403,6 +419,14 @@ static void cond_mitigation(struct task_struct *next)
 			indirect_branch_prediction_barrier();
 	}
 
+	/*
+	 * Flush only if SMT is disabled as per the contract, which is checked
+	 * when the feature is enabled.
+	 */
+	if (sched_smt_active() && !this_cpu_read(cpu_info.smt_active) &&
+		(prev_mm & LAST_USER_MM_L1D_FLUSH))
+		l1d_flush_hw();
+
 	this_cpu_write(cpu_tlbstate.last_user_mm_spec, next_mm);
 }
 
