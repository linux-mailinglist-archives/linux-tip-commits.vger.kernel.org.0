Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F61D3D8B3D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 28 Jul 2021 11:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235906AbhG1J6O (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 28 Jul 2021 05:58:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:59032 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235832AbhG1J6M (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 28 Jul 2021 05:58:12 -0400
Date:   Wed, 28 Jul 2021 09:58:09 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1627466290;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DzE5zmap7Rh6CyCkoq1DJjmlX8hutZhkwRP9JbUrgNQ=;
        b=MX9gUwB4SIFEosbH6S3zkG/HEuxXqA6Nj1WM5f/KpLmnb8G+jTSc5PEXIk5EQKeK2IogYM
        khbUScJ6arSw17qKDebnprPIK5ihzjk7TsEWkYNLIW66iNm17j4321N6Y4QX3BlyEr5y0Z
        aaMerTSZWiKVd8JJdZMKb641adO20FAIvwOHC2vc291Z44hMaCxVVlo0TrjjlZL0OouMaz
        /rEh7vwvFQWy8jiXxtxZywz8pv2EJGIcIUuG9FP7TTHYsPURf94D8uEYRC510LPx5fWOgv
        lz8aRh/o1w6Dsuxs/RG7x++j4fae9sudZhEKyp1zK5NRWidU/Z+feqJ57Hx2/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1627466290;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DzE5zmap7Rh6CyCkoq1DJjmlX8hutZhkwRP9JbUrgNQ=;
        b=SOY+AUIiI3h/U80f6MVE79GVSFwWFCbsqTyYD2BnQYp8ZpUr0XP14m0ktlF3Odk39WG+ux
        dLc34iFjV4ODHuCQ==
From:   "tip-bot2 for Balbir Singh" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cpu] x86/mm: Refactor cond_ibpb() to support other use cases
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Balbir Singh <sblbir@amazon.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210108121056.21940-3-sblbir@amazon.com>
References: <20210108121056.21940-3-sblbir@amazon.com>
MIME-Version: 1.0
Message-ID: <162746628958.395.8862946794867595435.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     371b09c6fdc436f2c7bb67fc90df5eec8ce90f06
Gitweb:        https://git.kernel.org/tip/371b09c6fdc436f2c7bb67fc90df5eec8ce90f06
Author:        Balbir Singh <sblbir@amazon.com>
AuthorDate:    Fri, 08 Jan 2021 23:10:53 +11:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 28 Jul 2021 11:42:24 +02:00

x86/mm: Refactor cond_ibpb() to support other use cases

cond_ibpb() has the necessary bits required to track the previous mm in
switch_mm_irqs_off(). This can be reused for other use cases like L1D
flushing on context switch.

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Balbir Singh <sblbir@amazon.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210108121056.21940-3-sblbir@amazon.com
---
 arch/x86/include/asm/tlbflush.h |  2 +-
 arch/x86/mm/tlb.c               | 53 +++++++++++++++++---------------
 2 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index fa952ea..b587a9e 100644
--- a/arch/x86/include/asm/tlbflush.h
+++ b/arch/x86/include/asm/tlbflush.h
@@ -83,7 +83,7 @@ struct tlb_state {
 	/* Last user mm for optimizing IBPB */
 	union {
 		struct mm_struct	*last_user_mm;
-		unsigned long		last_user_mm_ibpb;
+		unsigned long		last_user_mm_spec;
 	};
 
 	u16 loaded_mm_asid;
diff --git a/arch/x86/mm/tlb.c b/arch/x86/mm/tlb.c
index cfe6b1e..c98bc84 100644
--- a/arch/x86/mm/tlb.c
+++ b/arch/x86/mm/tlb.c
@@ -43,10 +43,14 @@
  */
 
 /*
- * Use bit 0 to mangle the TIF_SPEC_IB state into the mm pointer which is
- * stored in cpu_tlb_state.last_user_mm_ibpb.
+ * Bits to mangle the TIF_SPEC_IB state into the mm pointer which is
+ * stored in cpu_tlb_state.last_user_mm_spec.
  */
 #define LAST_USER_MM_IBPB	0x1UL
+#define LAST_USER_MM_SPEC_MASK	(LAST_USER_MM_IBPB)
+
+/* Bits to set when tlbstate and flush is (re)initialized */
+#define LAST_USER_MM_INIT	LAST_USER_MM_IBPB
 
 /*
  * The x86 feature is called PCID (Process Context IDentifier). It is similar
@@ -317,20 +321,29 @@ void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 	local_irq_restore(flags);
 }
 
-static unsigned long mm_mangle_tif_spec_ib(struct task_struct *next)
+static unsigned long mm_mangle_tif_spec_bits(struct task_struct *next)
 {
 	unsigned long next_tif = task_thread_info(next)->flags;
-	unsigned long ibpb = (next_tif >> TIF_SPEC_IB) & LAST_USER_MM_IBPB;
+	unsigned long spec_bits = (next_tif >> TIF_SPEC_IB) & LAST_USER_MM_SPEC_MASK;
 
-	return (unsigned long)next->mm | ibpb;
+	return (unsigned long)next->mm | spec_bits;
 }
 
-static void cond_ibpb(struct task_struct *next)
+static void cond_mitigation(struct task_struct *next)
 {
+	unsigned long prev_mm, next_mm;
+
 	if (!next || !next->mm)
 		return;
 
+	next_mm = mm_mangle_tif_spec_bits(next);
+	prev_mm = this_cpu_read(cpu_tlbstate.last_user_mm_spec);
+
 	/*
+	 * Avoid user/user BTB poisoning by flushing the branch predictor
+	 * when switching between processes. This stops one process from
+	 * doing Spectre-v2 attacks on another.
+	 *
 	 * Both, the conditional and the always IBPB mode use the mm
 	 * pointer to avoid the IBPB when switching between tasks of the
 	 * same process. Using the mm pointer instead of mm->context.ctx_id
@@ -340,8 +353,6 @@ static void cond_ibpb(struct task_struct *next)
 	 * exposed data is not really interesting.
 	 */
 	if (static_branch_likely(&switch_mm_cond_ibpb)) {
-		unsigned long prev_mm, next_mm;
-
 		/*
 		 * This is a bit more complex than the always mode because
 		 * it has to handle two cases:
@@ -371,20 +382,14 @@ static void cond_ibpb(struct task_struct *next)
 		 * Optimize this with reasonably small overhead for the
 		 * above cases. Mangle the TIF_SPEC_IB bit into the mm
 		 * pointer of the incoming task which is stored in
-		 * cpu_tlbstate.last_user_mm_ibpb for comparison.
-		 */
-		next_mm = mm_mangle_tif_spec_ib(next);
-		prev_mm = this_cpu_read(cpu_tlbstate.last_user_mm_ibpb);
-
-		/*
+		 * cpu_tlbstate.last_user_mm_spec for comparison.
+		 *
 		 * Issue IBPB only if the mm's are different and one or
 		 * both have the IBPB bit set.
 		 */
 		if (next_mm != prev_mm &&
 		    (next_mm | prev_mm) & LAST_USER_MM_IBPB)
 			indirect_branch_prediction_barrier();
-
-		this_cpu_write(cpu_tlbstate.last_user_mm_ibpb, next_mm);
 	}
 
 	if (static_branch_unlikely(&switch_mm_always_ibpb)) {
@@ -393,11 +398,12 @@ static void cond_ibpb(struct task_struct *next)
 		 * different context than the user space task which ran
 		 * last on this CPU.
 		 */
-		if (this_cpu_read(cpu_tlbstate.last_user_mm) != next->mm) {
+		if ((prev_mm & ~LAST_USER_MM_SPEC_MASK) !=
+					(unsigned long)next->mm)
 			indirect_branch_prediction_barrier();
-			this_cpu_write(cpu_tlbstate.last_user_mm, next->mm);
-		}
 	}
+
+	this_cpu_write(cpu_tlbstate.last_user_mm_spec, next_mm);
 }
 
 #ifdef CONFIG_PERF_EVENTS
@@ -531,11 +537,10 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
 		need_flush = true;
 	} else {
 		/*
-		 * Avoid user/user BTB poisoning by flushing the branch
-		 * predictor when switching between processes. This stops
-		 * one process from doing Spectre-v2 attacks on another.
+		 * Apply process to process speculation vulnerability
+		 * mitigations if applicable.
 		 */
-		cond_ibpb(tsk);
+		cond_mitigation(tsk);
 
 		/*
 		 * Stop remote flushes for the previous mm.
@@ -643,7 +648,7 @@ void initialize_tlbstate_and_flush(void)
 	write_cr3(build_cr3(mm->pgd, 0));
 
 	/* Reinitialize tlbstate. */
-	this_cpu_write(cpu_tlbstate.last_user_mm_ibpb, LAST_USER_MM_IBPB);
+	this_cpu_write(cpu_tlbstate.last_user_mm_spec, LAST_USER_MM_INIT);
 	this_cpu_write(cpu_tlbstate.loaded_mm_asid, 0);
 	this_cpu_write(cpu_tlbstate.next_asid, 1);
 	this_cpu_write(cpu_tlbstate.ctxs[0].ctx_id, mm->context.ctx_id);
