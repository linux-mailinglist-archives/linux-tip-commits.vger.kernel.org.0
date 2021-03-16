Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B57C33D58B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 16 Mar 2021 15:11:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236011AbhCPOKy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 16 Mar 2021 10:10:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42422 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236006AbhCPOKq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 16 Mar 2021 10:10:46 -0400
Date:   Tue, 16 Mar 2021 14:10:43 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615903844;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=31BuUq3ZkmaY+V8Y4FbLY8PcXISKhy6Cx8k1ODkpWjk=;
        b=2vF0hTVMPAUUwy/8PWUfhOtSnzYeQIcp459P2Cg9sc5Ii+WdBdzyEtdJaSf3PAHMlDW9J3
        9xZJrFQHVDcLDnJNb2p6FjnEIbwznxtht/mNfpHV0o+pRdCwYyCKF8HglKfkggfZRicMMl
        bRAj9BKTdnhNXbbc2mSEQokyat9RkLmsTsJSoeMadbxWiwVwffIktXy6aT4FWT4u/uTrAP
        fnUjA3zUwEWVGrRVmBa8Wvyt0OeeYSA0NlAGEWzZkt5Q5RneXSuM3q3wYb8FzjF0wyuw8x
        kBw5bhydPnV4C5h6jIaIkZe/lkganBO9jmH5rPsxmTf54/Vv5RjVlavgMW8uyw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615903844;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=31BuUq3ZkmaY+V8Y4FbLY8PcXISKhy6Cx8k1ODkpWjk=;
        b=6TdSjKqTG0owJcUwYA1A8vxEucikm3e2K9rpBvIii5RxifnLvlRzWRx2GrioAJMbMVZtXa
        iRCXzv8u96l7LHBw==
From:   "tip-bot2 for Krzysztof Kozlowski" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: irq/core] genirq: Fix typos and misspellings in comments
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org, maz@kernel.org
In-Reply-To: <20210316100205.23492-1-krzysztof.kozlowski@canonical.com>
References: <20210316100205.23492-1-krzysztof.kozlowski@canonical.com>
MIME-Version: 1.0
Message-ID: <161590384374.398.6620744885292439899.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the irq/core branch of tip:

Commit-ID:     5c982c58752118b6c1f295024d3fda5ff22d3c52
Gitweb:        https://git.kernel.org/tip/5c982c58752118b6c1f295024d3fda5ff22d3c52
Author:        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
AuthorDate:    Tue, 16 Mar 2021 11:02:05 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 16 Mar 2021 15:08:29 +01:00

genirq: Fix typos and misspellings in comments

No functional change.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210316100205.23492-1-krzysztof.kozlowski@canonical.com

---
 kernel/irq/chip.c      | 6 +++---
 kernel/irq/ipi.c       | 2 +-
 kernel/irq/manage.c    | 6 +++---
 kernel/irq/matrix.c    | 2 +-
 kernel/irq/migration.c | 2 +-
 kernel/irq/resend.c    | 2 +-
 kernel/irq/timings.c   | 6 +++---
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index 6d89e33..042399c 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -761,7 +761,7 @@ EXPORT_SYMBOL_GPL(handle_fasteoi_nmi);
  *	handle_edge_irq - edge type IRQ handler
  *	@desc:	the interrupt description structure for this irq
  *
- *	Interrupt occures on the falling and/or rising edge of a hardware
+ *	Interrupt occurs on the falling and/or rising edge of a hardware
  *	signal. The occurrence is latched into the irq controller hardware
  *	and must be acked in order to be reenabled. After the ack another
  *	interrupt can happen on the same source even before the first one
@@ -1419,7 +1419,7 @@ EXPORT_SYMBOL_GPL(irq_chip_eoi_parent);
  * @dest:	The affinity mask to set
  * @force:	Flag to enforce setting (disable online checks)
  *
- * Conditinal, as the underlying parent chip might not implement it.
+ * Conditional, as the underlying parent chip might not implement it.
  */
 int irq_chip_set_affinity_parent(struct irq_data *data,
 				 const struct cpumask *dest, bool force)
@@ -1531,7 +1531,7 @@ EXPORT_SYMBOL_GPL(irq_chip_release_resources_parent);
 #endif
 
 /**
- * irq_chip_compose_msi_msg - Componse msi message for a irq chip
+ * irq_chip_compose_msi_msg - Compose msi message for a irq chip
  * @data:	Pointer to interrupt specific data
  * @msg:	Pointer to the MSI message
  *
diff --git a/kernel/irq/ipi.c b/kernel/irq/ipi.c
index 43e3d1b..52f11c7 100644
--- a/kernel/irq/ipi.c
+++ b/kernel/irq/ipi.c
@@ -107,7 +107,7 @@ free_descs:
  * @irq:	linux irq number to be destroyed
  * @dest:	cpumask of cpus which should have the IPI removed
  *
- * The IPIs allocated with irq_reserve_ipi() are retuerned to the system
+ * The IPIs allocated with irq_reserve_ipi() are returned to the system
  * destroying all virqs associated with them.
  *
  * Return 0 on success or error code on failure.
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 97c231a..07ed2e4 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -179,7 +179,7 @@ bool irq_can_set_affinity_usr(unsigned int irq)
 
 /**
  *	irq_set_thread_affinity - Notify irq threads to adjust affinity
- *	@desc:		irq descriptor which has affitnity changed
+ *	@desc:		irq descriptor which has affinity changed
  *
  *	We just set IRQTF_AFFINITY and delegate the affinity setting
  *	to the interrupt thread itself. We can not call
@@ -1153,7 +1153,7 @@ irq_forced_thread_fn(struct irq_desc *desc, struct irqaction *action)
 
 /*
  * Interrupts explicitly requested as threaded interrupts want to be
- * preemtible - many of them need to sleep and wait for slow busses to
+ * preemptible - many of them need to sleep and wait for slow busses to
  * complete.
  */
 static irqreturn_t irq_thread_fn(struct irq_desc *desc,
@@ -2749,7 +2749,7 @@ int __irq_get_irqchip_state(struct irq_data *data, enum irqchip_irq_state which,
  *	irq_get_irqchip_state - returns the irqchip state of a interrupt.
  *	@irq: Interrupt line that is forwarded to a VM
  *	@which: One of IRQCHIP_STATE_* the caller wants to know about
- *	@state: a pointer to a boolean where the state is to be storeed
+ *	@state: a pointer to a boolean where the state is to be stored
  *
  *	This call snapshots the internal irqchip state of an
  *	interrupt, returning into @state the bit corresponding to
diff --git a/kernel/irq/matrix.c b/kernel/irq/matrix.c
index 651a4ad..7a9465f 100644
--- a/kernel/irq/matrix.c
+++ b/kernel/irq/matrix.c
@@ -356,7 +356,7 @@ void irq_matrix_reserve(struct irq_matrix *m)
  * irq_matrix_remove_reserved - Remove interrupt reservation
  * @m:		Matrix pointer
  *
- * This is merily a book keeping call. It decrements the number of globally
+ * This is merely a book keeping call. It decrements the number of globally
  * reserved interrupt bits. This is used to undo irq_matrix_reserve() when the
  * interrupt was never in use and a real vector allocated, which undid the
  * reservation.
diff --git a/kernel/irq/migration.c b/kernel/irq/migration.c
index def4858..61ca924 100644
--- a/kernel/irq/migration.c
+++ b/kernel/irq/migration.c
@@ -7,7 +7,7 @@
 
 /**
  * irq_fixup_move_pending - Cleanup irq move pending from a dying CPU
- * @desc:		Interrupt descpriptor to clean up
+ * @desc:		Interrupt descriptor to clean up
  * @force_clear:	If set clear the move pending bit unconditionally.
  *			If not set, clear it only when the dying CPU is the
  *			last one in the pending mask.
diff --git a/kernel/irq/resend.c b/kernel/irq/resend.c
index bd1d85c..0c46e9f 100644
--- a/kernel/irq/resend.c
+++ b/kernel/irq/resend.c
@@ -128,7 +128,7 @@ int check_irq_resend(struct irq_desc *desc, bool inject)
 	if (!try_retrigger(desc))
 		err = irq_sw_resend(desc);
 
-	/* If the retrigger was successfull, mark it with the REPLAY bit */
+	/* If the retrigger was successful, mark it with the REPLAY bit */
 	if (!err)
 		desc->istate |= IRQS_REPLAY;
 	return err;
diff --git a/kernel/irq/timings.c b/kernel/irq/timings.c
index 773b610..c318605 100644
--- a/kernel/irq/timings.c
+++ b/kernel/irq/timings.c
@@ -84,7 +84,7 @@ void irq_timings_disable(void)
  * 2. Log interval
  *
  * We saw the irq timings allow to compute the interval of the
- * occurrences for a specific interrupt. We can reasonibly assume the
+ * occurrences for a specific interrupt. We can reasonably assume the
  * longer is the interval, the higher is the error for the next event
  * and we can consider storing those interval values into an array
  * where each slot in the array correspond to an interval at the power
@@ -416,7 +416,7 @@ static u64 __irq_timings_next_event(struct irqt_stat *irqs, int irq, u64 now)
 	 * Copy the content of the circular buffer into another buffer
 	 * in order to linearize the buffer instead of dealing with
 	 * wrapping indexes and shifted array which will be prone to
-	 * error and extremelly difficult to debug.
+	 * error and extremely difficult to debug.
 	 */
 	for (i = 0; i < count; i++) {
 		int index = (start + i) & IRQ_TIMINGS_MASK;
@@ -514,7 +514,7 @@ static inline void irq_timings_store(int irq, struct irqt_stat *irqs, u64 ts)
  *      If more than the array size interrupts happened during the
  *      last busy/idle cycle, the index wrapped up and we have to
  *      begin with the next element in the array which is the last one
- *      in the sequence, otherwise it is a the index 0.
+ *      in the sequence, otherwise it is at the index 0.
  *
  * - have an indication of the interrupts activity on this CPU
  *   (eg. irq/sec)
