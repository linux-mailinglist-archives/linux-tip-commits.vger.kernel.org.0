Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5974426CB6E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 16 Sep 2020 22:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbgIPU1P (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 16 Sep 2020 16:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726932AbgIPRYm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 16 Sep 2020 13:24:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31EEC0A893E;
        Wed, 16 Sep 2020 06:11:26 -0700 (PDT)
Date:   Wed, 16 Sep 2020 13:11:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1600261885;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hICX3eIXaNN5lGw4Idja4ETjeYv+3b2SANUQdtYZeHM=;
        b=D9Q09Gork06iy1IiWCdyu0gM+PbV4SFRBx07n1czCxLvTysnGieWR/iIucbeQh9mqBjBYW
        HzeAX+TwrGZJE4BU/9IE3DnA7L1YqMGAS7ZlTEEVpVLfMNmaLapy4tnKq2eAG64yEIy4Rp
        FpF96z5yqH+Rw+x9iZJ0rLK6yjzOWb/cTxT5oBT2JfrZro6SJeqRUevuKrlOGuJmaNgQsg
        vKHzPoVFoKc7BbTejVHPfifFzB+v+T9h1IWAkaXUsSuAlOY5o0UFZuAAHyhGYr8ElDl8lc
        i3D+Wpxg4VvMCYoRN1+tOLQ6JeeVHdR5oX9Aw4ACqVOaxVozfu7xO0kqtGhdSg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1600261885;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hICX3eIXaNN5lGw4Idja4ETjeYv+3b2SANUQdtYZeHM=;
        b=u/8CLD7VYQHCqkj/rycdBfnZpKuht9ly7PtXFD8KQ4p9WLMrQoGtjGbKEBFQ/ezUpC8FM+
        fRWy6TgGJ6U5rGCQ==
From:   "tip-bot2 for Balbir Singh" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/pti] x86/mm: Refactor cond_ibpb() to support other use cases
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Balbir Singh <sblbir@amazon.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200510014803.12190-4-sblbir@amazon.com>
References: <20200510014803.12190-4-sblbir@amazon.com>
MIME-Version: 1.0
Message-ID: <160026187981.15536.17927491932304015051.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/pti branch of tip:

Commit-ID:     81f449985c12b83b91849d94724b803ebf856301
Gitweb:        https://git.kernel.org/tip/81f449985c12b83b91849d94724b803ebf856301
Author:        Balbir Singh <sblbir@amazon.com>
AuthorDate:    Wed, 29 Jul 2020 10:11:00 +10:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 16 Sep 2020 15:08:02 +02:00

x86/mm: Refactor cond_ibpb() to support other use cases

cond_ibpb() has the necessary bits required to track the previous mm in
switch_mm_irqs_off(). This can be reused for other use cases like L1D
flushing on context switch.

[ tglx: Moved comment, added a separate define for state (re)initialization ]

Suggested-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Balbir Singh <sblbir@amazon.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200510014803.12190-4-sblbir@amazon.com
Link: https://lore.kernel.org/r/20200729001103.6450-3-sblbir@amazon.com

---
 arch/x86/include/asm/tlbflush.h |  2 +-
 arch/x86/mm/tlb.c               | 53 +++++++++++++++++---------------
 2 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/arch/x86/include/asm/tlbflush.h b/arch/x86/include/asm/tlbflush.h
index 8c87a2e..a927d40 100644
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
index 0951b47..6bbd758 100644
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
 
-static inline unsigned long mm_mangle_tif_spec_ib(struct task_struct *next)
+static inline unsigned long mm_mangle_tif_spec_bits(struct task_struct *next)
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
@@ -519,11 +525,10 @@ void switch_mm_irqs_off(struct mm_struct *prev, struct mm_struct *next,
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
@@ -631,7 +636,7 @@ void initialize_tlbstate_and_flush(void)
 	write_cr3(build_cr3(mm->pgd, 0));
 
 	/* Reinitialize tlbstate. */
-	this_cpu_write(cpu_tlbstate.last_user_mm_ibpb, LAST_USER_MM_IBPB);
+	this_cpu_write(cpu_tlbstate.last_user_mm_spec, LAST_USER_MM_INIT);
 	this_cpu_write(cpu_tlbstate.loaded_mm_asid, 0);
 	this_cpu_write(cpu_tlbstate.next_asid, 1);
 	this_cpu_write(cpu_tlbstate.ctxs[0].ctx_id, mm->context.ctx_id);
