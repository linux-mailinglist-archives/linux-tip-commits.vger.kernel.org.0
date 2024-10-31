Return-Path: <linux-tip-commits+bounces-2674-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C79809B7865
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 11:09:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EBCEE1C23A57
	for <lists+linux-tip-commits@lfdr.de>; Thu, 31 Oct 2024 10:09:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41FF1990D8;
	Thu, 31 Oct 2024 10:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2EAJc7SY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PBgN+3Cr"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A87212C478;
	Thu, 31 Oct 2024 10:08:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730369342; cv=none; b=Wvk2DEfDyXuiGT6aoNxbEQ4N9PYwE7Lyzf5t1gCggvppzlEAnsHHXPQUfwzdqBAoRcRaOx6+gmdIZZnkhQd51bfOTLb06guTi/Gwye8Jab3CQBlJVsVv9pC9h6CiU0OplOcvxfoacp16zdnqQvlYCBxqWauZsHL22v4y3EopZlk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730369342; c=relaxed/simple;
	bh=idP9Xf0b+Eu8dzXA4vefLyyaqopbS0kEz0UiZyT/ZBw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=UtG6fv6bhcV1YPIMoapZzZTnJIEIvGhkGBKfkaWAuqfMRD3D1UCYw5MzR/0kdq6HzmA0UBipPanb3b68stNYepONBVCFaVdClt+q96Di8aVerxE9XaBg/7xqZNWShGGu46oa209IDBT5tKc4RfgGYg2HPjFhK0vG/Qvz4cyNjqs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2EAJc7SY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PBgN+3Cr; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 31 Oct 2024 10:08:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730369337;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ij88fll6XngZvDikah8mNO9aInb5eLqeOSvvlV7kd5U=;
	b=2EAJc7SY9UWh+wAzP4d2/QSoWw3bGkpJRn8hQbp5C7agIRb0Ht8zbe/02Nqdatbe7xjbUV
	Fks8Nwn9PjOwOVoxaHQuwUmYqgBOEq3gLomeluI322ewxGB17NElhFMVse7bQPpM8HM+jV
	BMOkIb4fXiOPc/9Bqf1dLCbwpkdkCh+6CbnOHamq/z2aY/QkZYjx1A+Vg2XSWeqSLAuGvx
	F1zXtTgrqKessQwZ/dy4/NbhHq4XuQOI0mm/aI+76keX5RLVPxqfPu4e58wjG8BtcepAi5
	gxaITo47iEsvmidwZ1QF5QpcgG5tO2sk4MecY4mRrjKaR0ghgKl4eUKG+iiSVw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730369337;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ij88fll6XngZvDikah8mNO9aInb5eLqeOSvvlV7kd5U=;
	b=PBgN+3CrRIlc8RAXp8hIn1bRoeodNxRXPI7bSdumWqHEeCvdD1LIrbX5FdNgj3k5lieAtK
	lxY+NdQiVzlL+OCg==
From: "tip-bot2 for Andrii Nakryiko" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] uprobes: SRCU-protect uretprobe lifetime (with timeout)
Cc: Andrii Nakryiko <andrii@kernel.org>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241024044159.3156646-3-andrii@kernel.org>
References: <20241024044159.3156646-3-andrii@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173036933641.3137.244607242210289949.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     dd1a7567784e2b1f80258be04f57bcfa82c997eb
Gitweb:        https://git.kernel.org/tip/dd1a7567784e2b1f80258be04f57bcfa82c=
997eb
Author:        Andrii Nakryiko <andrii@kernel.org>
AuthorDate:    Wed, 23 Oct 2024 21:41:59 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 30 Oct 2024 22:42:19 +01:00

uprobes: SRCU-protect uretprobe lifetime (with timeout)

Avoid taking refcount on uprobe in prepare_uretprobe(), instead take
uretprobe-specific SRCU lock and keep it active as kernel transfers
control back to user space.

Given we can't rely on user space returning from traced function within
reasonable time period, we need to make sure not to keep SRCU lock
active for too long, though. To that effect, we employ a timer callback
which is meant to terminate SRCU lock region after predefined timeout
(currently set to 100ms), and instead transfer underlying struct
uprobe's lifetime protection to refcounting.

This fallback to less scalable refcounting after 100ms is a fine
tradeoff from uretprobe's scalability and performance perspective,
because uretprobing *long running* user functions inherently doesn't run
into scalability issues (there is just not enough frequency to cause
noticeable issues with either performance or scalability).

The overall trick is in ensuring synchronization between current thread
and timer's callback fired on some other thread. To cope with that with
minimal logic complications, we add hprobe wrapper which is used to
contain all the synchronization related issues behind a small number of
basic helpers: hprobe_expire() for "downgrading" uprobe from SRCU-protected
state to refcounted state, and a hprobe_consume() and hprobe_finalize()
pair of single-use consuming helpers. Other than that, whatever current
thread's logic is there stays the same, as timer thread cannot modify
return_instance state (or add new/remove old return_instances). It only
takes care of SRCU unlock and uprobe refcounting, which is hidden from
the higher-level uretprobe handling logic.

We use atomic xchg() in hprobe_consume(), which is called from
performance critical handle_uretprobe_chain() function run in the
current context. When uncontended, this xchg() doesn't seem to hurt
performance as there are no other competing CPUs fighting for the same
cache line. We also mark struct return_instance as ____cacheline_aligned
to ensure no false sharing can happen.

Another technical moment. We need to make sure that the list of return
instances can be safely traversed under RCU from timer callback, so we
delay return_instance freeing with kfree_rcu() and make sure that list
modifications use RCU-aware operations.

Also, given SRCU lock survives transition from kernel to user space and
back we need to use lower-level __srcu_read_lock() and
__srcu_read_unlock() to avoid lockdep complaining.

Just to give an impression of a kind of performance improvements this
change brings, below are benchmarking results with and without these
SRCU changes, assuming other uprobe optimizations (mainly RCU Tasks
Trace for entry uprobes, lockless RB-tree lookup, and lockless VMA to
uprobe lookup) are left intact:

WITHOUT SRCU for uretprobes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
uretprobe-nop         ( 1 cpus):    2.197 =C2=B1 0.002M/s  (  2.197M/s/cpu)
uretprobe-nop         ( 2 cpus):    3.325 =C2=B1 0.001M/s  (  1.662M/s/cpu)
uretprobe-nop         ( 3 cpus):    4.129 =C2=B1 0.002M/s  (  1.376M/s/cpu)
uretprobe-nop         ( 4 cpus):    6.180 =C2=B1 0.003M/s  (  1.545M/s/cpu)
uretprobe-nop         ( 8 cpus):    7.323 =C2=B1 0.005M/s  (  0.915M/s/cpu)
uretprobe-nop         (16 cpus):    6.943 =C2=B1 0.005M/s  (  0.434M/s/cpu)
uretprobe-nop         (32 cpus):    5.931 =C2=B1 0.014M/s  (  0.185M/s/cpu)
uretprobe-nop         (64 cpus):    5.145 =C2=B1 0.003M/s  (  0.080M/s/cpu)
uretprobe-nop         (80 cpus):    4.925 =C2=B1 0.005M/s  (  0.062M/s/cpu)

WITH SRCU for uretprobes
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
uretprobe-nop         ( 1 cpus):    1.968 =C2=B1 0.001M/s  (  1.968M/s/cpu)
uretprobe-nop         ( 2 cpus):    3.739 =C2=B1 0.003M/s  (  1.869M/s/cpu)
uretprobe-nop         ( 3 cpus):    5.616 =C2=B1 0.003M/s  (  1.872M/s/cpu)
uretprobe-nop         ( 4 cpus):    7.286 =C2=B1 0.002M/s  (  1.822M/s/cpu)
uretprobe-nop         ( 8 cpus):   13.657 =C2=B1 0.007M/s  (  1.707M/s/cpu)
uretprobe-nop         (32 cpus):   45.305 =C2=B1 0.066M/s  (  1.416M/s/cpu)
uretprobe-nop         (64 cpus):   42.390 =C2=B1 0.922M/s  (  0.662M/s/cpu)
uretprobe-nop         (80 cpus):   47.554 =C2=B1 2.411M/s  (  0.594M/s/cpu)

Signed-off-by: Andrii Nakryiko <andrii@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20241024044159.3156646-3-andrii@kernel.org
---
 include/linux/uprobes.h |  54 ++++++-
 kernel/events/uprobes.c | 287 ++++++++++++++++++++++++++++++++++-----
 2 files changed, 304 insertions(+), 37 deletions(-)

diff --git a/include/linux/uprobes.h b/include/linux/uprobes.h
index dbaf041..7a051b5 100644
--- a/include/linux/uprobes.h
+++ b/include/linux/uprobes.h
@@ -15,6 +15,7 @@
 #include <linux/rbtree.h>
 #include <linux/types.h>
 #include <linux/wait.h>
+#include <linux/timer.h>
=20
 struct uprobe;
 struct vm_area_struct;
@@ -67,6 +68,53 @@ enum uprobe_task_state {
 	UTASK_SSTEP_TRAPPED,
 };
=20
+/* The state of hybrid-lifetime uprobe inside struct return_instance */
+enum hprobe_state {
+	HPROBE_LEASED,		/* uretprobes_srcu-protected uprobe */
+	HPROBE_STABLE,		/* refcounted uprobe */
+	HPROBE_GONE,		/* NULL uprobe, SRCU expired, refcount failed */
+	HPROBE_CONSUMED,	/* uprobe "consumed" by uretprobe handler */
+};
+
+/*
+ * Hybrid lifetime uprobe. Represents a uprobe instance that could be either
+ * SRCU protected (with SRCU protection eventually potentially timing out),
+ * refcounted using uprobe->ref, or there could be no valid uprobe (NULL).
+ *
+ * hprobe's internal state is setup such that background timer thread can
+ * atomically "downgrade" temporarily RCU-protected uprobe into refcounted o=
ne
+ * (or no uprobe, if refcounting failed).
+ *
+ * *stable* pointer always point to the uprobe (or could be NULL if there is
+ * was no valid underlying uprobe to begin with).
+ *
+ * *leased* pointer is the key to achieving race-free atomic lifetime state
+ * transition and can have three possible states:
+ *   - either the same non-NULL value as *stable*, in which case uprobe is
+ *     SRCU-protected;
+ *   - NULL, in which case uprobe (if there is any) is refcounted;
+ *   - special __UPROBE_DEAD value, which represents an uprobe that was SRCU
+ *     protected initially, but SRCU period timed out and we attempted to
+ *     convert it to refcounted, but refcount_inc_not_zero() failed, because
+ *     uprobe effectively went away (the last consumer unsubscribed). In this
+ *     case it's important to know that *stable* pointer (which still has
+ *     non-NULL uprobe pointer) shouldn't be used, because lifetime of
+ *     underlying uprobe is not guaranteed anymore. __UPROBE_DEAD is just an
+ *     internal marker and is handled transparently by hprobe_fetch() helper.
+ *
+ * When uprobe is SRCU-protected, we also record srcu_idx value, necessary f=
or
+ * SRCU unlocking.
+ *
+ * See hprobe_expire() and hprobe_fetch() for details of race-free uprobe
+ * state transitioning details. It all hinges on atomic xchg() over *leaded*
+ * pointer. *stable* pointer, once initially set, is not modified concurrent=
ly.
+ */
+struct hprobe {
+	enum hprobe_state state;
+	int srcu_idx;
+	struct uprobe *uprobe;
+};
+
 /*
  * uprobe_task: Metadata of a task while it singlesteps.
  */
@@ -86,6 +134,7 @@ struct uprobe_task {
 	};
=20
 	struct uprobe			*active_uprobe;
+	struct timer_list		ri_timer;
 	unsigned long			xol_vaddr;
=20
 	struct arch_uprobe              *auprobe;
@@ -100,7 +149,7 @@ struct return_consumer {
 };
=20
 struct return_instance {
-	struct uprobe		*uprobe;
+	struct hprobe		hprobe;
 	unsigned long		func;
 	unsigned long		stack;		/* stack pointer */
 	unsigned long		orig_ret_vaddr; /* original return address */
@@ -108,9 +157,10 @@ struct return_instance {
 	int			consumers_cnt;
=20
 	struct return_instance	*next;		/* keep as stack */
+	struct rcu_head		rcu;
=20
 	struct return_consumer	consumers[] __counted_by(consumers_cnt);
-};
+} ____cacheline_aligned;
=20
 enum rp_check {
 	RP_CHECK_CALL,
diff --git a/kernel/events/uprobes.c b/kernel/events/uprobes.c
index d7e4892..a76ddc5 100644
--- a/kernel/events/uprobes.c
+++ b/kernel/events/uprobes.c
@@ -28,6 +28,7 @@
 #include <linux/khugepaged.h>
 #include <linux/rcupdate_trace.h>
 #include <linux/workqueue.h>
+#include <linux/srcu.h>
=20
 #include <linux/uprobes.h>
=20
@@ -51,6 +52,9 @@ static struct mutex uprobes_mmap_mutex[UPROBES_HASH_SZ];
=20
 DEFINE_STATIC_PERCPU_RWSEM(dup_mmap_sem);
=20
+/* Covers return_instance's uprobe lifetime. */
+DEFINE_STATIC_SRCU(uretprobes_srcu);
+
 /* Have a copy of original instruction */
 #define UPROBE_COPY_INSN	0
=20
@@ -622,13 +626,20 @@ static inline bool uprobe_is_active(struct uprobe *upro=
be)
 	return !RB_EMPTY_NODE(&uprobe->rb_node);
 }
=20
-static void uprobe_free_rcu(struct rcu_head *rcu)
+static void uprobe_free_rcu_tasks_trace(struct rcu_head *rcu)
 {
 	struct uprobe *uprobe =3D container_of(rcu, struct uprobe, rcu);
=20
 	kfree(uprobe);
 }
=20
+static void uprobe_free_srcu(struct rcu_head *rcu)
+{
+	struct uprobe *uprobe =3D container_of(rcu, struct uprobe, rcu);
+
+	call_rcu_tasks_trace(&uprobe->rcu, uprobe_free_rcu_tasks_trace);
+}
+
 static void uprobe_free_deferred(struct work_struct *work)
 {
 	struct uprobe *uprobe =3D container_of(work, struct uprobe, work);
@@ -652,7 +663,8 @@ static void uprobe_free_deferred(struct work_struct *work)
 	delayed_uprobe_remove(uprobe, NULL);
 	mutex_unlock(&delayed_uprobe_lock);
=20
-	call_rcu_tasks_trace(&uprobe->rcu, uprobe_free_rcu);
+	/* start srcu -> rcu_tasks_trace -> kfree chain */
+	call_srcu(&uretprobes_srcu, &uprobe->rcu, uprobe_free_srcu);
 }
=20
 static void put_uprobe(struct uprobe *uprobe)
@@ -664,6 +676,151 @@ static void put_uprobe(struct uprobe *uprobe)
 	schedule_work(&uprobe->work);
 }
=20
+/* Initialize hprobe as SRCU-protected "leased" uprobe */
+static void hprobe_init_leased(struct hprobe *hprobe, struct uprobe *uprobe,=
 int srcu_idx)
+{
+	WARN_ON(!uprobe);
+	hprobe->state =3D HPROBE_LEASED;
+	hprobe->uprobe =3D uprobe;
+	hprobe->srcu_idx =3D srcu_idx;
+}
+
+/* Initialize hprobe as refcounted ("stable") uprobe (uprobe can be NULL). */
+static void hprobe_init_stable(struct hprobe *hprobe, struct uprobe *uprobe)
+{
+	hprobe->state =3D uprobe ? HPROBE_STABLE : HPROBE_GONE;
+	hprobe->uprobe =3D uprobe;
+	hprobe->srcu_idx =3D -1;
+}
+
+/*
+ * hprobe_consume() fetches hprobe's underlying uprobe and detects whether
+ * uprobe is SRCU protected or is refcounted. hprobe_consume() can be
+ * used only once for a given hprobe.
+ *
+ * Caller has to call hprobe_finalize() and pass previous hprobe_state, so
+ * that hprobe_finalize() can perform SRCU unlock or put uprobe, whichever
+ * is appropriate.
+ */
+static inline struct uprobe *hprobe_consume(struct hprobe *hprobe, enum hpro=
be_state *hstate)
+{
+	*hstate =3D xchg(&hprobe->state, HPROBE_CONSUMED);
+	switch (*hstate) {
+	case HPROBE_LEASED:
+	case HPROBE_STABLE:
+		return hprobe->uprobe;
+	case HPROBE_GONE:	/* uprobe is NULL, no SRCU */
+	case HPROBE_CONSUMED:	/* uprobe was finalized already, do nothing */
+		return NULL;
+	default:
+		WARN(1, "hprobe invalid state %d", *hstate);
+		return NULL;
+	}
+}
+
+/*
+ * Reset hprobe state and, if hprobe was LEASED, release SRCU lock.
+ * hprobe_finalize() can only be used from current context after
+ * hprobe_consume() call (which determines uprobe and hstate value).
+ */
+static void hprobe_finalize(struct hprobe *hprobe, enum hprobe_state hstate)
+{
+	switch (hstate) {
+	case HPROBE_LEASED:
+		__srcu_read_unlock(&uretprobes_srcu, hprobe->srcu_idx);
+		break;
+	case HPROBE_STABLE:
+		put_uprobe(hprobe->uprobe);
+		break;
+	case HPROBE_GONE:
+	case HPROBE_CONSUMED:
+		break;
+	default:
+		WARN(1, "hprobe invalid state %d", hstate);
+		break;
+	}
+}
+
+/*
+ * Attempt to switch (atomically) uprobe from being SRCU protected (LEASED)
+ * to refcounted (STABLE) state. Competes with hprobe_consume(); only one of
+ * them can win the race to perform SRCU unlocking. Whoever wins must perform
+ * SRCU unlock.
+ *
+ * Returns underlying valid uprobe or NULL, if there was no underlying uprobe
+ * to begin with or we failed to bump its refcount and it's going away.
+ *
+ * Returned non-NULL uprobe can be still safely used within an ongoing SRCU
+ * locked region. If `get` is true, it's guaranteed that non-NULL uprobe has
+ * an extra refcount for caller to assume and use. Otherwise, it's not
+ * guaranteed that returned uprobe has a positive refcount, so caller has to
+ * attempt try_get_uprobe(), if it needs to preserve uprobe beyond current
+ * SRCU lock region. See dup_utask().
+ */
+static struct uprobe *hprobe_expire(struct hprobe *hprobe, bool get)
+{
+	enum hprobe_state hstate;
+
+	/*
+	 * return_instance's hprobe is protected by RCU.
+	 * Underlying uprobe is itself protected from reuse by SRCU.
+	 */
+	lockdep_assert(rcu_read_lock_held() && srcu_read_lock_held(&uretprobes_srcu=
));
+
+	hstate =3D READ_ONCE(hprobe->state);
+	switch (hstate) {
+	case HPROBE_STABLE:
+		/* uprobe has positive refcount, bump refcount, if necessary */
+		return get ? get_uprobe(hprobe->uprobe) : hprobe->uprobe;
+	case HPROBE_GONE:
+		/*
+		 * SRCU was unlocked earlier and we didn't manage to take
+		 * uprobe refcnt, so it's effectively NULL
+		 */
+		return NULL;
+	case HPROBE_CONSUMED:
+		/*
+		 * uprobe was consumed, so it's effectively NULL as far as
+		 * uretprobe processing logic is concerned
+		 */
+		return NULL;
+	case HPROBE_LEASED: {
+		struct uprobe *uprobe =3D try_get_uprobe(hprobe->uprobe);
+		/*
+		 * Try to switch hprobe state, guarding against
+		 * hprobe_consume() or another hprobe_expire() racing with us.
+		 * Note, if we failed to get uprobe refcount, we use special
+		 * HPROBE_GONE state to signal that hprobe->uprobe shouldn't
+		 * be used as it will be freed after SRCU is unlocked.
+		 */
+		if (try_cmpxchg(&hprobe->state, &hstate, uprobe ? HPROBE_STABLE : HPROBE_G=
ONE)) {
+			/* We won the race, we are the ones to unlock SRCU */
+			__srcu_read_unlock(&uretprobes_srcu, hprobe->srcu_idx);
+			return get ? get_uprobe(uprobe) : uprobe;
+		}
+
+		/*
+		 * We lost the race, undo refcount bump (if it ever happened),
+		 * unless caller would like an extra refcount anyways.
+		 */
+		if (uprobe && !get)
+			put_uprobe(uprobe);
+		/*
+		 * Even if hprobe_consume() or another hprobe_expire() wins
+		 * the state update race and unlocks SRCU from under us, we
+		 * still have a guarantee that underyling uprobe won't be
+		 * freed due to ongoing caller's SRCU lock region, so we can
+		 * return it regardless. Also, if `get` was true, we also have
+		 * an extra ref for the caller to own. This is used in dup_utask().
+		 */
+		return uprobe;
+	}
+	default:
+		WARN(1, "unknown hprobe state %d", hstate);
+		return NULL;
+	}
+}
+
 static __always_inline
 int uprobe_cmp(const struct inode *l_inode, const loff_t l_offset,
 	       const struct uprobe *r)
@@ -1169,6 +1326,7 @@ void uprobe_unregister_sync(void)
 	 * handler_chain() or handle_uretprobe_chain() to do an use-after-free.
 	 */
 	synchronize_rcu_tasks_trace();
+	synchronize_srcu(&uretprobes_srcu);
 }
 EXPORT_SYMBOL_GPL(uprobe_unregister_sync);
=20
@@ -1731,11 +1889,18 @@ unsigned long uprobe_get_trap_addr(struct pt_regs *re=
gs)
 	return instruction_pointer(regs);
 }
=20
-static struct return_instance *free_ret_instance(struct return_instance *ri)
+static struct return_instance *free_ret_instance(struct return_instance *ri,=
 bool cleanup_hprobe)
 {
 	struct return_instance *next =3D ri->next;
-	put_uprobe(ri->uprobe);
-	kfree(ri);
+
+	if (cleanup_hprobe) {
+		enum hprobe_state hstate;
+
+		(void)hprobe_consume(&ri->hprobe, &hstate);
+		hprobe_finalize(&ri->hprobe, hstate);
+	}
+
+	kfree_rcu(ri, rcu);
 	return next;
 }
=20
@@ -1753,14 +1918,48 @@ void uprobe_free_utask(struct task_struct *t)
=20
 	WARN_ON_ONCE(utask->active_uprobe || utask->xol_vaddr);
=20
+	timer_delete_sync(&utask->ri_timer);
+
 	ri =3D utask->return_instances;
 	while (ri)
-		ri =3D free_ret_instance(ri);
+		ri =3D free_ret_instance(ri, true /* cleanup_hprobe */);
=20
 	kfree(utask);
 	t->utask =3D NULL;
 }
=20
+#define RI_TIMER_PERIOD (HZ / 10) /* 100 ms */
+
+#define for_each_ret_instance_rcu(pos, head) \
+	for (pos =3D rcu_dereference_raw(head); pos; pos =3D rcu_dereference_raw(po=
s->next))
+
+static void ri_timer(struct timer_list *timer)
+{
+	struct uprobe_task *utask =3D container_of(timer, struct uprobe_task, ri_ti=
mer);
+	struct return_instance *ri;
+
+	/* SRCU protects uprobe from reuse for the cmpxchg() inside hprobe_expire()=
. */
+	guard(srcu)(&uretprobes_srcu);
+	/* RCU protects return_instance from freeing. */
+	guard(rcu)();
+
+	for_each_ret_instance_rcu(ri, utask->return_instances)
+		hprobe_expire(&ri->hprobe, false);
+}
+
+static struct uprobe_task *alloc_utask(void)
+{
+	struct uprobe_task *utask;
+
+	utask =3D kzalloc(sizeof(*utask), GFP_KERNEL);
+	if (!utask)
+		return NULL;
+
+	timer_setup(&utask->ri_timer, ri_timer, 0);
+
+	return utask;
+}
+
 /*
  * Allocate a uprobe_task object for the task if necessary.
  * Called when the thread hits a breakpoint.
@@ -1772,7 +1971,7 @@ void uprobe_free_utask(struct task_struct *t)
 static struct uprobe_task *get_utask(void)
 {
 	if (!current->utask)
-		current->utask =3D kzalloc(sizeof(struct uprobe_task), GFP_KERNEL);
+		current->utask =3D alloc_utask();
 	return current->utask;
 }
=20
@@ -1808,29 +2007,37 @@ static int dup_utask(struct task_struct *t, struct up=
robe_task *o_utask)
 {
 	struct uprobe_task *n_utask;
 	struct return_instance **p, *o, *n;
+	struct uprobe *uprobe;
=20
-	n_utask =3D kzalloc(sizeof(struct uprobe_task), GFP_KERNEL);
+	n_utask =3D alloc_utask();
 	if (!n_utask)
 		return -ENOMEM;
 	t->utask =3D n_utask;
=20
+	/* protect uprobes from freeing, we'll need try_get_uprobe() them */
+	guard(srcu)(&uretprobes_srcu);
+
 	p =3D &n_utask->return_instances;
 	for (o =3D o_utask->return_instances; o; o =3D o->next) {
 		n =3D dup_return_instance(o);
 		if (!n)
 			return -ENOMEM;
=20
+		/* if uprobe is non-NULL, we'll have an extra refcount for uprobe */
+		uprobe =3D hprobe_expire(&o->hprobe, true);
+
 		/*
-		 * uprobe's refcnt has to be positive at this point, kept by
-		 * utask->return_instances items; return_instances can't be
-		 * removed right now, as task is blocked due to duping; so
-		 * get_uprobe() is safe to use here.
+		 * New utask will have stable properly refcounted uprobe or
+		 * NULL. Even if we failed to get refcounted uprobe, we still
+		 * need to preserve full set of return_instances for proper
+		 * uretprobe handling and nesting in forked task.
 		 */
-		get_uprobe(n->uprobe);
-		n->next =3D NULL;
+		hprobe_init_stable(&n->hprobe, uprobe);
=20
-		*p =3D n;
+		n->next =3D NULL;
+		rcu_assign_pointer(*p, n);
 		p =3D &n->next;
+
 		n_utask->depth++;
 	}
=20
@@ -1906,10 +2113,10 @@ static void cleanup_return_instances(struct uprobe_ta=
sk *utask, bool chained,
 	enum rp_check ctx =3D chained ? RP_CHECK_CHAIN_CALL : RP_CHECK_CALL;
=20
 	while (ri && !arch_uretprobe_is_alive(ri, ctx, regs)) {
-		ri =3D free_ret_instance(ri);
+		ri =3D free_ret_instance(ri, true /* cleanup_hprobe */);
 		utask->depth--;
 	}
-	utask->return_instances =3D ri;
+	rcu_assign_pointer(utask->return_instances, ri);
 }
=20
 static void prepare_uretprobe(struct uprobe *uprobe, struct pt_regs *regs,
@@ -1918,6 +2125,7 @@ static void prepare_uretprobe(struct uprobe *uprobe, st=
ruct pt_regs *regs,
 	struct uprobe_task *utask =3D current->utask;
 	unsigned long orig_ret_vaddr, trampoline_vaddr;
 	bool chained;
+	int srcu_idx;
=20
 	if (!get_xol_area())
 		goto free;
@@ -1929,14 +2137,10 @@ static void prepare_uretprobe(struct uprobe *uprobe, =
struct pt_regs *regs,
 		goto free;
 	}
=20
-	/* we need to bump refcount to store uprobe in utask */
-	if (!try_get_uprobe(uprobe))
-		goto free;
-
 	trampoline_vaddr =3D uprobe_get_trampoline_vaddr();
 	orig_ret_vaddr =3D arch_uretprobe_hijack_return_addr(trampoline_vaddr, regs=
);
 	if (orig_ret_vaddr =3D=3D -1)
-		goto put;
+		goto free;
=20
 	/* drop the entries invalidated by longjmp() */
 	chained =3D (orig_ret_vaddr =3D=3D trampoline_vaddr);
@@ -1954,23 +2158,28 @@ static void prepare_uretprobe(struct uprobe *uprobe, =
struct pt_regs *regs,
 			 * attack from user-space.
 			 */
 			uprobe_warn(current, "handle tail call");
-			goto put;
+			goto free;
 		}
 		orig_ret_vaddr =3D utask->return_instances->orig_ret_vaddr;
 	}
-	ri->uprobe =3D uprobe;
+
+	/* __srcu_read_lock() because SRCU lock survives switch to user space */
+	srcu_idx =3D __srcu_read_lock(&uretprobes_srcu);
+
 	ri->func =3D instruction_pointer(regs);
 	ri->stack =3D user_stack_pointer(regs);
 	ri->orig_ret_vaddr =3D orig_ret_vaddr;
 	ri->chained =3D chained;
=20
 	utask->depth++;
+
+	hprobe_init_leased(&ri->hprobe, uprobe, srcu_idx);
 	ri->next =3D utask->return_instances;
-	utask->return_instances =3D ri;
+	rcu_assign_pointer(utask->return_instances, ri);
+
+	mod_timer(&utask->ri_timer, jiffies + RI_TIMER_PERIOD);
=20
 	return;
-put:
-	put_uprobe(uprobe);
 free:
 	kfree(ri);
 }
@@ -2215,13 +2424,16 @@ static void handler_chain(struct uprobe *uprobe, stru=
ct pt_regs *regs)
 }
=20
 static void
-handle_uretprobe_chain(struct return_instance *ri, struct pt_regs *regs)
+handle_uretprobe_chain(struct return_instance *ri, struct uprobe *uprobe, st=
ruct pt_regs *regs)
 {
-	struct uprobe *uprobe =3D ri->uprobe;
 	struct return_consumer *ric;
 	struct uprobe_consumer *uc;
 	int ric_idx =3D 0;
=20
+	/* all consumers unsubscribed meanwhile */
+	if (unlikely(!uprobe))
+		return;
+
 	rcu_read_lock_trace();
 	list_for_each_entry_rcu(uc, &uprobe->consumers, cons_node, rcu_read_lock_tr=
ace_held()) {
 		bool session =3D uc->handler && uc->ret_handler;
@@ -2251,6 +2463,8 @@ void uprobe_handle_trampoline(struct pt_regs *regs)
 {
 	struct uprobe_task *utask;
 	struct return_instance *ri, *next;
+	struct uprobe *uprobe;
+	enum hprobe_state hstate;
 	bool valid;
=20
 	utask =3D current->utask;
@@ -2281,21 +2495,24 @@ void uprobe_handle_trampoline(struct pt_regs *regs)
 			 * trampoline addresses on the stack are replaced with correct
 			 * original return addresses
 			 */
-			utask->return_instances =3D ri->next;
+			rcu_assign_pointer(utask->return_instances, ri->next);
+
+			uprobe =3D hprobe_consume(&ri->hprobe, &hstate);
 			if (valid)
-				handle_uretprobe_chain(ri, regs);
-			ri =3D free_ret_instance(ri);
+				handle_uretprobe_chain(ri, uprobe, regs);
+			hprobe_finalize(&ri->hprobe, hstate);
+
+			/* We already took care of hprobe, no need to waste more time on that. */
+			ri =3D free_ret_instance(ri, false /* !cleanup_hprobe */);
 			utask->depth--;
 		} while (ri !=3D next);
 	} while (!valid);
=20
-	utask->return_instances =3D ri;
 	return;
=20
- sigill:
+sigill:
 	uprobe_warn(current, "handle uretprobe, sending SIGILL.");
 	force_sig(SIGILL);
-
 }
=20
 bool __weak arch_uprobe_ignore(struct arch_uprobe *aup, struct pt_regs *regs)

