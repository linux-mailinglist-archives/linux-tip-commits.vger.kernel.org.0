Return-Path: <linux-tip-commits+bounces-7437-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 19686C76618
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 22:32:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.lore.kernel.org (Postfix) with ESMTPS id 5EFEC3048B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Nov 2025 21:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 087742D12ED;
	Thu, 20 Nov 2025 21:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TYut7VCl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FPql+EP1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3CCC27E054;
	Thu, 20 Nov 2025 21:29:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763674163; cv=none; b=EQH7mUZtB2vgsFP1ZHF0QdwmaGL7fm7i5BVidEndNHc5J1LgiWqAIJVIEURecjvmvRwWJTfx/8bChzNp+4Qdp965hHqRctF5l2+d/lioev9xXs6dMElck0PWocjkGg7hFRNS/4195UHRzKcBoR03KdP5xM78sR8xG5bPwt/xSCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763674163; c=relaxed/simple;
	bh=zBQvkl1WuYNj2rbQf536oDiqr5vUw+b5l0tQlE9PfcI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iDqtqxcWKVr9dwh9AlaA+Q3063P/alQqefSRtcCxoq2OsWOsYNVWU8zh1LfsQW+mjy4AsbG4CpA95vMiPnD4NkXuTD/2d3xgjJWDFNr0yRtMef28RM4DyfpisLxORwo+IgiqD4Qg67YTsfRWOMGyAAmU2hoFTFQYqmHcaMGGTtM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TYut7VCl; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=FPql+EP1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 20 Nov 2025 21:29:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1763674159;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sAvjfeeHBVxELKCtzN2GaBZvqoC1GH2CDmPnk98UGEw=;
	b=TYut7VClt9g7P5GmB2y3tijq3PpcE2G8VfGeuKBskbyQK5CYps99jNxkuM/oTFQx9IplMi
	AHhOsE7iNf+IsrZic+da53cLNZB1oZogKTJiKAs3F6h79nNQer/xZntf/9fS/e9qQ/v6Hi
	NdWBlFXy/VFGrt8+EfdQ39pj36ejJbrpM2tTGpHgw0Ihgl1z4LYIXDwNFtI3mZUeUvPdJC
	FVg7krrE1p6swAKZCUFIOG7YfwS2aurdOCFqUtvqGdxXFrPvis+QBsU+wNFkKMCalO42tT
	82/tfX/Kru2qIqZQKym2CQhU6RFRIUT4/SaNnTLl2z4OywIBE2YXu+Yvgnyesg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1763674159;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=sAvjfeeHBVxELKCtzN2GaBZvqoC1GH2CDmPnk98UGEw=;
	b=FPql+EP1BrwUobw+RE4jefDCHFZNgsmlbPIcSMGWeqPBOripglnK+0QIcd4BZab1N6zM24
	BxrjuxW99gmJvACQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Provide and use set_need_resched_current()
Cc: Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20251116174750.665769842@linutronix.de>
References: <20251116174750.665769842@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176367415794.498.14740697616446477897.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c04507ac500e2cc8048000c2a849588227554e06
Gitweb:        https://git.kernel.org/tip/c04507ac500e2cc8048000c2a8495882275=
54e06
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Sun, 16 Nov 2025 21:51:07 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 20 Nov 2025 22:26:09 +01:00

sched: Provide and use set_need_resched_current()

set_tsk_need_resched(current) requires set_preempt_need_resched(current) to
work correctly outside of the scheduler.

Provide set_need_resched_current() which wraps this correctly and replace
all the open coded instances.

Signed-off-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://patch.msgid.link/20251116174750.665769842@linutronix.de
---
 arch/s390/mm/pfault.c    |  3 +--
 include/linux/sched.h    |  7 +++++++
 kernel/rcu/tiny.c        |  8 +++-----
 kernel/rcu/tree.c        | 14 +++++---------
 kernel/rcu/tree_exp.h    |  3 +--
 kernel/rcu/tree_plugin.h |  9 +++------
 kernel/rcu/tree_stall.h  |  3 +--
 7 files changed, 21 insertions(+), 26 deletions(-)

diff --git a/arch/s390/mm/pfault.c b/arch/s390/mm/pfault.c
index e6175d7..2f82944 100644
--- a/arch/s390/mm/pfault.c
+++ b/arch/s390/mm/pfault.c
@@ -199,8 +199,7 @@ block:
 			 * return to userspace schedule() to block.
 			 */
 			__set_current_state(TASK_UNINTERRUPTIBLE);
-			set_tsk_need_resched(tsk);
-			set_preempt_need_resched();
+			set_need_resched_current();
 		}
 	}
 out:
diff --git a/include/linux/sched.h b/include/linux/sched.h
index bb436ee..021d05a 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -2058,6 +2058,13 @@ static inline int test_tsk_need_resched(struct task_st=
ruct *tsk)
 	return unlikely(test_tsk_thread_flag(tsk,TIF_NEED_RESCHED));
 }
=20
+static inline void set_need_resched_current(void)
+{
+	lockdep_assert_irqs_disabled();
+	set_tsk_need_resched(current);
+	set_preempt_need_resched();
+}
+
 /*
  * cond_resched() and cond_resched_lock(): latency reduction via
  * explicit rescheduling in places that are safe. The return
diff --git a/kernel/rcu/tiny.c b/kernel/rcu/tiny.c
index c1ebfd5..585cade 100644
--- a/kernel/rcu/tiny.c
+++ b/kernel/rcu/tiny.c
@@ -70,12 +70,10 @@ void rcu_qs(void)
  */
 void rcu_sched_clock_irq(int user)
 {
-	if (user) {
+	if (user)
 		rcu_qs();
-	} else if (rcu_ctrlblk.donetail !=3D rcu_ctrlblk.curtail) {
-		set_tsk_need_resched(current);
-		set_preempt_need_resched();
-	}
+	else if (rcu_ctrlblk.donetail !=3D rcu_ctrlblk.curtail)
+		set_need_resched_current();
 }
=20
 /*
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 8293bae..85b82a7 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -2696,10 +2696,8 @@ void rcu_sched_clock_irq(int user)
 	/* The load-acquire pairs with the store-release setting to true. */
 	if (smp_load_acquire(this_cpu_ptr(&rcu_data.rcu_urgent_qs))) {
 		/* Idle and userspace execution already are quiescent states. */
-		if (!rcu_is_cpu_rrupt_from_idle() && !user) {
-			set_tsk_need_resched(current);
-			set_preempt_need_resched();
-		}
+		if (!rcu_is_cpu_rrupt_from_idle() && !user)
+			set_need_resched_current();
 		__this_cpu_write(rcu_data.rcu_urgent_qs, false);
 	}
 	rcu_flavor_sched_clock_irq(user);
@@ -2824,7 +2822,6 @@ static void strict_work_handler(struct work_struct *wor=
k)
 /* Perform RCU core processing work for the current CPU.  */
 static __latent_entropy void rcu_core(void)
 {
-	unsigned long flags;
 	struct rcu_data *rdp =3D raw_cpu_ptr(&rcu_data);
 	struct rcu_node *rnp =3D rdp->mynode;
=20
@@ -2837,8 +2834,8 @@ static __latent_entropy void rcu_core(void)
 	if (IS_ENABLED(CONFIG_PREEMPT_COUNT) && (!(preempt_count() & PREEMPT_MASK))=
) {
 		rcu_preempt_deferred_qs(current);
 	} else if (rcu_preempt_need_deferred_qs(current)) {
-		set_tsk_need_resched(current);
-		set_preempt_need_resched();
+		guard(irqsave)();
+		set_need_resched_current();
 	}
=20
 	/* Update RCU state based on any recent quiescent states. */
@@ -2847,10 +2844,9 @@ static __latent_entropy void rcu_core(void)
 	/* No grace period and unregistered callbacks? */
 	if (!rcu_gp_in_progress() &&
 	    rcu_segcblist_is_enabled(&rdp->cblist) && !rcu_rdp_is_offloaded(rdp)) {
-		local_irq_save(flags);
+		guard(irqsave)();
 		if (!rcu_segcblist_restempty(&rdp->cblist, RCU_NEXT_READY_TAIL))
 			rcu_accelerate_cbs_unlocked(rnp, rdp);
-		local_irq_restore(flags);
 	}
=20
 	rcu_check_gp_start_stall(rnp, rdp, rcu_jiffies_till_stall_check());
diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index 6058a73..96c49c5 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -729,8 +729,7 @@ static void rcu_exp_need_qs(void)
 	__this_cpu_write(rcu_data.cpu_no_qs.b.exp, true);
 	/* Store .exp before .rcu_urgent_qs. */
 	smp_store_release(this_cpu_ptr(&rcu_data.rcu_urgent_qs), true);
-	set_tsk_need_resched(current);
-	set_preempt_need_resched();
+	set_need_resched_current();
 }
=20
 #ifdef CONFIG_PREEMPT_RCU
diff --git a/kernel/rcu/tree_plugin.h b/kernel/rcu/tree_plugin.h
index d857633..dbe2d02 100644
--- a/kernel/rcu/tree_plugin.h
+++ b/kernel/rcu/tree_plugin.h
@@ -753,8 +753,7 @@ static void rcu_read_unlock_special(struct task_struct *t)
 			// Also if no expediting and no possible deboosting,
 			// slow is OK.  Plus nohz_full CPUs eventually get
 			// tick enabled.
-			set_tsk_need_resched(current);
-			set_preempt_need_resched();
+			set_need_resched_current();
 			if (IS_ENABLED(CONFIG_IRQ_WORK) && irqs_were_disabled &&
 			    needs_exp && rdp->defer_qs_iw_pending !=3D DEFER_QS_PENDING &&
 			    cpu_online(rdp->cpu)) {
@@ -813,10 +812,8 @@ static void rcu_flavor_sched_clock_irq(int user)
 	if (rcu_preempt_depth() > 0 ||
 	    (preempt_count() & (PREEMPT_MASK | SOFTIRQ_MASK))) {
 		/* No QS, force context switch if deferred. */
-		if (rcu_preempt_need_deferred_qs(t)) {
-			set_tsk_need_resched(t);
-			set_preempt_need_resched();
-		}
+		if (rcu_preempt_need_deferred_qs(t))
+			set_need_resched_current();
 	} else if (rcu_preempt_need_deferred_qs(t)) {
 		rcu_preempt_deferred_qs(t); /* Report deferred QS. */
 		return;
diff --git a/kernel/rcu/tree_stall.h b/kernel/rcu/tree_stall.h
index d16afeb..b67532c 100644
--- a/kernel/rcu/tree_stall.h
+++ b/kernel/rcu/tree_stall.h
@@ -763,8 +763,7 @@ static void print_cpu_stall(unsigned long gp_seq, unsigne=
d long gps)
 	 * progress and it could be we're stuck in kernel space without context
 	 * switches for an entirely unreasonable amount of time.
 	 */
-	set_tsk_need_resched(current);
-	set_preempt_need_resched();
+	set_need_resched_current();
 }
=20
 static bool csd_lock_suppress_rcu_stall;

