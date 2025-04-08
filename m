Return-Path: <linux-tip-commits+bounces-4754-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1CDBBA8155B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 21:06:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 764A0189B1A3
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 19:06:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932FA24FC1E;
	Tue,  8 Apr 2025 19:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3sIyQVPK";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="U0CPspid"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05928245001;
	Tue,  8 Apr 2025 19:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139106; cv=none; b=M5gFfDlP7wLuIOpqk1N0/604OZYWZCI+n8H/As+LGzpeUAlmQ28Q1u5ep47VyCOg7ZrW3jK0fspzwtCBF1ZM1bCX6jXrbqoeG4rH6zbYZFBSQupske6Dhx2IXH939TcJd+qC+XGqgOw/aLxrtMf4oYEypyNQ8odj/ZDySN5VbJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139106; c=relaxed/simple;
	bh=jpnkIqq+SyHb9OIaSEHcYWixKYDgToRhCtI/yDh+5Qo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=IziCiV6/u0wLFbSUGPnPLE56I81bHGcZYtqelQBekahnlTbzjn05gNEkZFzL7b3xHC71AiAJ65JTIZjAxiNc/Hxua99ADiJPC9vZf5QHh5m4pPFBwVPR4FUv6GMMbK9uopjI5tCAZvEjBsPTbWOd7nKojqFgXwUazDs4X3oyGN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3sIyQVPK; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=U0CPspid; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Apr 2025 19:05:00 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744139101;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n1NIK0tHwkSyjmUJpC5jp/u2rLhkGl48EZP81y2HL54=;
	b=3sIyQVPKh3Z36nZbfUgEO49NMF05Os6y8nmXPJypuyMHCe9J6UERRfNTt1r0wSJ3XhGyEq
	AmOdyVk/Q1vY4gjAnrVYMkXn5L+6DYaJFidIrK6SKgLrlteKcNDKaIstjJibiaDIxOtDjl
	bI4FbYxbIFQPgb4fcAkY5uwYw8azUkZyUKJJVjSFXRHXsg3ujJGABEw5J6RgzatabKgq97
	9MtMPrT6Fs1fz77LluDg6hYfF3aHmAVqIJCU1YuuwvF1M26Qt1EWep7rbCY0mnCZq0LOpJ
	YhEMTIeNEfZNNcXn93N5Ho99cPyvCMgcVHni6kvxuwghxnvJkrON4fx4muFIBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744139101;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=n1NIK0tHwkSyjmUJpC5jp/u2rLhkGl48EZP81y2HL54=;
	b=U0CPspid2Ta5JIjMEhnnqV50uDKx9TQrEmYEG3KHsWypzWAufICfBu5kRB8OTm+x7JePTu
	JqjOYyHmvF3nWlAA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Make perf_pmu_unregister() useable
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ravi Bangoria <ravi.bangoria@amd.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250307193723.525402029@infradead.org>
References: <20250307193723.525402029@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174413910060.31282.8504333237561774159.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     da916e96e2dedcb2d40de77a7def833d315b81a6
Gitweb:        https://git.kernel.org/tip/da916e96e2dedcb2d40de77a7def833d315b81a6
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 25 Oct 2024 10:21:41 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Apr 2025 20:55:48 +02:00

perf: Make perf_pmu_unregister() useable

Previously it was only safe to call perf_pmu_unregister() if there
were no active events of that pmu around -- which was impossible to
guarantee since it races all sorts against perf_init_event().

Rework the whole thing by:

 - keeping track of all events for a given pmu

 - 'hiding' the pmu from perf_init_event()

 - waiting for the appropriate (s)rcu grace periods such that all
   prior references to the PMU will be completed

 - detaching all still existing events of that pmu (see first point)
   and moving them to a new REVOKED state.

 - actually freeing the pmu data.

Where notably the new REVOKED state must inhibit all event actions
from reaching code that wants to use event->pmu.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lkml.kernel.org/r/20250307193723.525402029@infradead.org
---
 include/linux/perf_event.h |  15 +-
 kernel/events/core.c       | 320 ++++++++++++++++++++++++++++++------
 2 files changed, 280 insertions(+), 55 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 0069ba6..7f49a58 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -325,6 +325,9 @@ struct perf_output_handle;
 struct pmu {
 	struct list_head		entry;
 
+	spinlock_t			events_lock;
+	struct list_head		events;
+
 	struct module			*module;
 	struct device			*dev;
 	struct device			*parent;
@@ -622,9 +625,10 @@ struct perf_addr_filter_range {
  * enum perf_event_state - the states of an event:
  */
 enum perf_event_state {
-	PERF_EVENT_STATE_DEAD		= -4,
-	PERF_EVENT_STATE_EXIT		= -3,
-	PERF_EVENT_STATE_ERROR		= -2,
+	PERF_EVENT_STATE_DEAD		= -5,
+	PERF_EVENT_STATE_REVOKED	= -4, /* pmu gone, must not touch */
+	PERF_EVENT_STATE_EXIT		= -3, /* task died, still inherit */
+	PERF_EVENT_STATE_ERROR		= -2, /* scheduling error, can enable */
 	PERF_EVENT_STATE_OFF		= -1,
 	PERF_EVENT_STATE_INACTIVE	=  0,
 	PERF_EVENT_STATE_ACTIVE		=  1,
@@ -865,6 +869,7 @@ struct perf_event {
 	void *security;
 #endif
 	struct list_head		sb_list;
+	struct list_head		pmu_list;
 
 	/*
 	 * Certain events gets forwarded to another pmu internally by over-
@@ -1155,7 +1160,7 @@ extern void perf_aux_output_flag(struct perf_output_handle *handle, u64 flags);
 extern void perf_event_itrace_started(struct perf_event *event);
 
 extern int perf_pmu_register(struct pmu *pmu, const char *name, int type);
-extern void perf_pmu_unregister(struct pmu *pmu);
+extern int perf_pmu_unregister(struct pmu *pmu);
 
 extern void __perf_event_task_sched_in(struct task_struct *prev,
 				       struct task_struct *task);
@@ -1760,7 +1765,7 @@ static inline bool needs_branch_stack(struct perf_event *event)
 
 static inline bool has_aux(struct perf_event *event)
 {
-	return event->pmu->setup_aux;
+	return event->pmu && event->pmu->setup_aux;
 }
 
 static inline bool has_aux_action(struct perf_event *event)
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 985b5c7..2eb9cd5 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -208,6 +208,7 @@ static void perf_ctx_unlock(struct perf_cpu_context *cpuctx,
 }
 
 #define TASK_TOMBSTONE ((void *)-1L)
+#define EVENT_TOMBSTONE ((void *)-1L)
 
 static bool is_kernel_event(struct perf_event *event)
 {
@@ -2336,6 +2337,11 @@ static void perf_child_detach(struct perf_event *event)
 
 	sync_child_event(event);
 	list_del_init(&event->child_list);
+	/*
+	 * Cannot set to NULL, as that would confuse the situation vs
+	 * not being a child event. See for example unaccount_event().
+	 */
+	event->parent = EVENT_TOMBSTONE;
 }
 
 static bool is_orphaned_event(struct perf_event *event)
@@ -2457,8 +2463,9 @@ ctx_time_update_event(struct perf_event_context *ctx, struct perf_event *event)
 
 #define DETACH_GROUP	0x01UL
 #define DETACH_CHILD	0x02UL
-#define DETACH_DEAD	0x04UL
-#define DETACH_EXIT	0x08UL
+#define DETACH_EXIT	0x04UL
+#define DETACH_REVOKE	0x08UL
+#define DETACH_DEAD	0x10UL
 
 /*
  * Cross CPU call to remove a performance event
@@ -2484,18 +2491,21 @@ __perf_remove_from_context(struct perf_event *event,
 	 */
 	if (flags & DETACH_EXIT)
 		state = PERF_EVENT_STATE_EXIT;
+	if (flags & DETACH_REVOKE)
+		state = PERF_EVENT_STATE_REVOKED;
 	if (flags & DETACH_DEAD) {
 		event->pending_disable = 1;
 		state = PERF_EVENT_STATE_DEAD;
 	}
 	event_sched_out(event, ctx);
-	perf_event_set_state(event, min(event->state, state));
 	if (flags & DETACH_GROUP)
 		perf_group_detach(event);
 	if (flags & DETACH_CHILD)
 		perf_child_detach(event);
 	list_del_event(event, ctx);
 
+	event->state = min(event->state, state);
+
 	if (!pmu_ctx->nr_events) {
 		pmu_ctx->rotate_necessary = 0;
 
@@ -4523,7 +4533,8 @@ out:
 
 static void perf_remove_from_owner(struct perf_event *event);
 static void perf_event_exit_event(struct perf_event *event,
-				  struct perf_event_context *ctx);
+				  struct perf_event_context *ctx,
+				  bool revoke);
 
 /*
  * Removes all events from the current task that have been marked
@@ -4550,7 +4561,7 @@ static void perf_event_remove_on_exec(struct perf_event_context *ctx)
 
 		modified = true;
 
-		perf_event_exit_event(event, ctx);
+		perf_event_exit_event(event, ctx, false);
 	}
 
 	raw_spin_lock_irqsave(&ctx->lock, flags);
@@ -5132,6 +5143,7 @@ static bool is_sb_event(struct perf_event *event)
 	    attr->context_switch || attr->text_poke ||
 	    attr->bpf_event)
 		return true;
+
 	return false;
 }
 
@@ -5528,6 +5540,8 @@ static void perf_free_addr_filters(struct perf_event *event);
 /* vs perf_event_alloc() error */
 static void __free_event(struct perf_event *event)
 {
+	struct pmu *pmu = event->pmu;
+
 	if (event->attach_state & PERF_ATTACH_CALLCHAIN)
 		put_callchain_buffers();
 
@@ -5557,6 +5571,7 @@ static void __free_event(struct perf_event *event)
 		 * put_pmu_ctx() needs an event->ctx reference, because of
 		 * epc->ctx.
 		 */
+		WARN_ON_ONCE(!pmu);
 		WARN_ON_ONCE(!event->ctx);
 		WARN_ON_ONCE(event->pmu_ctx->ctx != event->ctx);
 		put_pmu_ctx(event->pmu_ctx);
@@ -5569,8 +5584,13 @@ static void __free_event(struct perf_event *event)
 	if (event->ctx)
 		put_ctx(event->ctx);
 
-	if (event->pmu)
-		module_put(event->pmu->module);
+	if (pmu) {
+		module_put(pmu->module);
+		scoped_guard (spinlock, &pmu->events_lock) {
+			list_del(&event->pmu_list);
+			wake_up_var(pmu);
+		}
+	}
 
 	call_rcu(&event->rcu_head, free_event_rcu);
 }
@@ -5606,22 +5626,6 @@ static void _free_event(struct perf_event *event)
 }
 
 /*
- * Used to free events which have a known refcount of 1, such as in error paths
- * where the event isn't exposed yet and inherited events.
- */
-static void free_event(struct perf_event *event)
-{
-	if (WARN(atomic_long_cmpxchg(&event->refcount, 1, 0) != 1,
-				"unexpected event refcount: %ld; ptr=%p\n",
-				atomic_long_read(&event->refcount), event)) {
-		/* leak to avoid use-after-free */
-		return;
-	}
-
-	_free_event(event);
-}
-
-/*
  * Remove user event from the owner task.
  */
 static void perf_remove_from_owner(struct perf_event *event)
@@ -5724,7 +5728,11 @@ int perf_event_release_kernel(struct perf_event *event)
 	 * Thus this guarantees that we will in fact observe and kill _ALL_
 	 * child events.
 	 */
-	perf_remove_from_context(event, DETACH_GROUP|DETACH_DEAD);
+	if (event->state > PERF_EVENT_STATE_REVOKED) {
+		perf_remove_from_context(event, DETACH_GROUP|DETACH_DEAD);
+	} else {
+		event->state = PERF_EVENT_STATE_DEAD;
+	}
 
 	perf_event_ctx_unlock(event, ctx);
 
@@ -6013,7 +6021,7 @@ __perf_read(struct perf_event *event, char __user *buf, size_t count)
 	 * error state (i.e. because it was pinned but it couldn't be
 	 * scheduled on to the CPU at some point).
 	 */
-	if (event->state == PERF_EVENT_STATE_ERROR)
+	if (event->state <= PERF_EVENT_STATE_ERROR)
 		return 0;
 
 	if (count < event->read_size)
@@ -6052,8 +6060,14 @@ static __poll_t perf_poll(struct file *file, poll_table *wait)
 	struct perf_buffer *rb;
 	__poll_t events = EPOLLHUP;
 
+	if (event->state <= PERF_EVENT_STATE_REVOKED)
+		return EPOLLERR;
+
 	poll_wait(file, &event->waitq, wait);
 
+	if (event->state <= PERF_EVENT_STATE_REVOKED)
+		return EPOLLERR;
+
 	if (is_event_hup(event))
 		return events;
 
@@ -6232,6 +6246,9 @@ static long _perf_ioctl(struct perf_event *event, unsigned int cmd, unsigned lon
 	void (*func)(struct perf_event *);
 	u32 flags = arg;
 
+	if (event->state <= PERF_EVENT_STATE_REVOKED)
+		return -ENODEV;
+
 	switch (cmd) {
 	case PERF_EVENT_IOC_ENABLE:
 		func = _perf_event_enable;
@@ -6607,9 +6624,22 @@ void ring_buffer_put(struct perf_buffer *rb)
 	call_rcu(&rb->rcu_head, rb_free_rcu);
 }
 
+typedef void (*mapped_f)(struct perf_event *event, struct mm_struct *mm);
+
+#define get_mapped(event, func)			\
+({	struct pmu *pmu;			\
+	mapped_f f = NULL;			\
+	guard(rcu)();				\
+	pmu = READ_ONCE(event->pmu);		\
+	if (pmu)				\
+		f = pmu->func;			\
+	f;					\
+})
+
 static void perf_mmap_open(struct vm_area_struct *vma)
 {
 	struct perf_event *event = vma->vm_file->private_data;
+	mapped_f mapped = get_mapped(event, event_mapped);
 
 	atomic_inc(&event->mmap_count);
 	atomic_inc(&event->rb->mmap_count);
@@ -6617,8 +6647,8 @@ static void perf_mmap_open(struct vm_area_struct *vma)
 	if (vma->vm_pgoff)
 		atomic_inc(&event->rb->aux_mmap_count);
 
-	if (event->pmu->event_mapped)
-		event->pmu->event_mapped(event, vma->vm_mm);
+	if (mapped)
+		mapped(event, vma->vm_mm);
 }
 
 static void perf_pmu_output_stop(struct perf_event *event);
@@ -6634,14 +6664,16 @@ static void perf_pmu_output_stop(struct perf_event *event);
 static void perf_mmap_close(struct vm_area_struct *vma)
 {
 	struct perf_event *event = vma->vm_file->private_data;
+	mapped_f unmapped = get_mapped(event, event_unmapped);
 	struct perf_buffer *rb = ring_buffer_get(event);
 	struct user_struct *mmap_user = rb->mmap_user;
 	int mmap_locked = rb->mmap_locked;
 	unsigned long size = perf_data_size(rb);
 	bool detach_rest = false;
 
-	if (event->pmu->event_unmapped)
-		event->pmu->event_unmapped(event, vma->vm_mm);
+	/* FIXIES vs perf_pmu_unregister() */
+	if (unmapped)
+		unmapped(event, vma->vm_mm);
 
 	/*
 	 * The AUX buffer is strictly a sub-buffer, serialize using aux_mutex
@@ -6834,6 +6866,7 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 	unsigned long nr_pages;
 	long user_extra = 0, extra = 0;
 	int ret, flags = 0;
+	mapped_f mapped;
 
 	/*
 	 * Don't allow mmap() of inherited per-task counters. This would
@@ -6864,6 +6897,16 @@ static int perf_mmap(struct file *file, struct vm_area_struct *vma)
 	mutex_lock(&event->mmap_mutex);
 	ret = -EINVAL;
 
+	/*
+	 * This relies on __pmu_detach_event() taking mmap_mutex after marking
+	 * the event REVOKED. Either we observe the state, or __pmu_detach_event()
+	 * will detach the rb created here.
+	 */
+	if (event->state <= PERF_EVENT_STATE_REVOKED) {
+		ret = -ENODEV;
+		goto unlock;
+	}
+
 	if (vma->vm_pgoff == 0) {
 		nr_pages -= 1;
 
@@ -7042,8 +7085,9 @@ aux_unlock:
 	if (!ret)
 		ret = map_range(rb, vma);
 
-	if (!ret && event->pmu->event_mapped)
-		event->pmu->event_mapped(event, vma->vm_mm);
+	mapped = get_mapped(event, event_mapped);
+	if (mapped)
+		mapped(event, vma->vm_mm);
 
 	return ret;
 }
@@ -7054,6 +7098,9 @@ static int perf_fasync(int fd, struct file *filp, int on)
 	struct perf_event *event = filp->private_data;
 	int retval;
 
+	if (event->state <= PERF_EVENT_STATE_REVOKED)
+		return -ENODEV;
+
 	inode_lock(inode);
 	retval = fasync_helper(fd, filp, on, &event->fasync);
 	inode_unlock(inode);
@@ -11062,6 +11109,9 @@ static int __perf_event_set_bpf_prog(struct perf_event *event,
 {
 	bool is_kprobe, is_uprobe, is_tracepoint, is_syscall_tp;
 
+	if (event->state <= PERF_EVENT_STATE_REVOKED)
+		return -ENODEV;
+
 	if (!perf_event_is_tracing(event))
 		return perf_event_set_bpf_handler(event, prog, bpf_cookie);
 
@@ -12245,6 +12295,9 @@ int perf_pmu_register(struct pmu *_pmu, const char *name, int type)
 	if (!pmu->event_idx)
 		pmu->event_idx = perf_event_idx_default;
 
+	INIT_LIST_HEAD(&pmu->events);
+	spin_lock_init(&pmu->events_lock);
+
 	/*
 	 * Now that the PMU is complete, make it visible to perf_try_init_event().
 	 */
@@ -12258,21 +12311,143 @@ int perf_pmu_register(struct pmu *_pmu, const char *name, int type)
 }
 EXPORT_SYMBOL_GPL(perf_pmu_register);
 
-void perf_pmu_unregister(struct pmu *pmu)
+static void __pmu_detach_event(struct pmu *pmu, struct perf_event *event,
+			       struct perf_event_context *ctx)
+{
+	/*
+	 * De-schedule the event and mark it REVOKED.
+	 */
+	perf_event_exit_event(event, ctx, true);
+
+	/*
+	 * All _free_event() bits that rely on event->pmu:
+	 *
+	 * Notably, perf_mmap() relies on the ordering here.
+	 */
+	scoped_guard (mutex, &event->mmap_mutex) {
+		WARN_ON_ONCE(pmu->event_unmapped);
+		/*
+		 * Mostly an empty lock sequence, such that perf_mmap(), which
+		 * relies on mmap_mutex, is sure to observe the state change.
+		 */
+	}
+
+	perf_event_free_bpf_prog(event);
+	perf_free_addr_filters(event);
+
+	if (event->destroy) {
+		event->destroy(event);
+		event->destroy = NULL;
+	}
+
+	if (event->pmu_ctx) {
+		put_pmu_ctx(event->pmu_ctx);
+		event->pmu_ctx = NULL;
+	}
+
+	exclusive_event_destroy(event);
+	module_put(pmu->module);
+
+	event->pmu = NULL; /* force fault instead of UAF */
+}
+
+static void pmu_detach_event(struct pmu *pmu, struct perf_event *event)
+{
+	struct perf_event_context *ctx;
+
+	ctx = perf_event_ctx_lock(event);
+	__pmu_detach_event(pmu, event, ctx);
+	perf_event_ctx_unlock(event, ctx);
+
+	scoped_guard (spinlock, &pmu->events_lock)
+		list_del(&event->pmu_list);
+}
+
+static struct perf_event *pmu_get_event(struct pmu *pmu)
+{
+	struct perf_event *event;
+
+	guard(spinlock)(&pmu->events_lock);
+	list_for_each_entry(event, &pmu->events, pmu_list) {
+		if (atomic_long_inc_not_zero(&event->refcount))
+			return event;
+	}
+
+	return NULL;
+}
+
+static bool pmu_empty(struct pmu *pmu)
+{
+	guard(spinlock)(&pmu->events_lock);
+	return list_empty(&pmu->events);
+}
+
+static void pmu_detach_events(struct pmu *pmu)
+{
+	struct perf_event *event;
+
+	for (;;) {
+		event = pmu_get_event(pmu);
+		if (!event)
+			break;
+
+		pmu_detach_event(pmu, event);
+		put_event(event);
+	}
+
+	/*
+	 * wait for pending _free_event()s
+	 */
+	wait_var_event(pmu, pmu_empty(pmu));
+}
+
+int perf_pmu_unregister(struct pmu *pmu)
 {
 	scoped_guard (mutex, &pmus_lock) {
+		if (!idr_cmpxchg(&pmu_idr, pmu->type, pmu, NULL))
+			return -EINVAL;
+
 		list_del_rcu(&pmu->entry);
-		idr_remove(&pmu_idr, pmu->type);
 	}
 
 	/*
 	 * We dereference the pmu list under both SRCU and regular RCU, so
 	 * synchronize against both of those.
+	 *
+	 * Notably, the entirety of event creation, from perf_init_event()
+	 * (which will now fail, because of the above) until
+	 * perf_install_in_context() should be under SRCU such that
+	 * this synchronizes against event creation. This avoids trying to
+	 * detach events that are not fully formed.
 	 */
 	synchronize_srcu(&pmus_srcu);
 	synchronize_rcu();
 
+	if (pmu->event_unmapped && !pmu_empty(pmu)) {
+		/*
+		 * Can't force remove events when pmu::event_unmapped()
+		 * is used in perf_mmap_close().
+		 */
+		guard(mutex)(&pmus_lock);
+		idr_cmpxchg(&pmu_idr, pmu->type, NULL, pmu);
+		list_add_rcu(&pmu->entry, &pmus);
+		return -EBUSY;
+	}
+
+	scoped_guard (mutex, &pmus_lock)
+		idr_remove(&pmu_idr, pmu->type);
+
+	/*
+	 * PMU is removed from the pmus list, so no new events will
+	 * be created, now take care of the existing ones.
+	 */
+	pmu_detach_events(pmu);
+
+	/*
+	 * PMU is unused, make it go away.
+	 */
 	perf_pmu_free(pmu);
+	return 0;
 }
 EXPORT_SYMBOL_GPL(perf_pmu_unregister);
 
@@ -12366,7 +12541,7 @@ static struct pmu *perf_init_event(struct perf_event *event)
 	struct pmu *pmu;
 	int type, ret;
 
-	guard(srcu)(&pmus_srcu);
+	guard(srcu)(&pmus_srcu); /* pmu idr/list access */
 
 	/*
 	 * Save original type before calling pmu->event_init() since certain
@@ -12590,6 +12765,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	INIT_LIST_HEAD(&event->active_entry);
 	INIT_LIST_HEAD(&event->addr_filters.list);
 	INIT_HLIST_NODE(&event->hlist_entry);
+	INIT_LIST_HEAD(&event->pmu_list);
 
 
 	init_waitqueue_head(&event->waitq);
@@ -12768,6 +12944,13 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	/* symmetric to unaccount_event() in _free_event() */
 	account_event(event);
 
+	/*
+	 * Event creation should be under SRCU, see perf_pmu_unregister().
+	 */
+	lockdep_assert_held(&pmus_srcu);
+	scoped_guard (spinlock, &pmu->events_lock)
+		list_add(&event->pmu_list, &pmu->events);
+
 	return_ptr(event);
 }
 
@@ -12967,6 +13150,9 @@ set:
 		goto unlock;
 
 	if (output_event) {
+		if (output_event->state <= PERF_EVENT_STATE_REVOKED)
+			goto unlock;
+
 		/* get the rb we want to redirect to */
 		rb = ring_buffer_get(output_event);
 		if (!rb)
@@ -13148,6 +13334,11 @@ SYSCALL_DEFINE5(perf_event_open,
 	if (event_fd < 0)
 		return event_fd;
 
+	/*
+	 * Event creation should be under SRCU, see perf_pmu_unregister().
+	 */
+	guard(srcu)(&pmus_srcu);
+
 	CLASS(fd, group)(group_fd);     // group_fd == -1 => empty
 	if (group_fd != -1) {
 		if (!is_perf_file(group)) {
@@ -13155,6 +13346,10 @@ SYSCALL_DEFINE5(perf_event_open,
 			goto err_fd;
 		}
 		group_leader = fd_file(group)->private_data;
+		if (group_leader->state <= PERF_EVENT_STATE_REVOKED) {
+			err = -ENODEV;
+			goto err_fd;
+		}
 		if (flags & PERF_FLAG_FD_OUTPUT)
 			output_event = group_leader;
 		if (flags & PERF_FLAG_FD_NO_GROUP)
@@ -13451,7 +13646,7 @@ err_cred:
 	if (task)
 		up_read(&task->signal->exec_update_lock);
 err_alloc:
-	free_event(event);
+	put_event(event);
 err_task:
 	if (task)
 		put_task_struct(task);
@@ -13488,6 +13683,11 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
 	if (attr->aux_output || attr->aux_action)
 		return ERR_PTR(-EINVAL);
 
+	/*
+	 * Event creation should be under SRCU, see perf_pmu_unregister().
+	 */
+	guard(srcu)(&pmus_srcu);
+
 	event = perf_event_alloc(attr, cpu, task, NULL, NULL,
 				 overflow_handler, context, -1);
 	if (IS_ERR(event)) {
@@ -13559,7 +13759,7 @@ err_unlock:
 	perf_unpin_context(ctx);
 	put_ctx(ctx);
 err_alloc:
-	free_event(event);
+	put_event(event);
 err:
 	return ERR_PTR(err);
 }
@@ -13699,10 +13899,15 @@ static void sync_child_event(struct perf_event *child_event)
 }
 
 static void
-perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
+perf_event_exit_event(struct perf_event *event,
+		      struct perf_event_context *ctx, bool revoke)
 {
 	struct perf_event *parent_event = event->parent;
-	unsigned long detach_flags = 0;
+	unsigned long detach_flags = DETACH_EXIT;
+	bool is_child = !!parent_event;
+
+	if (parent_event == EVENT_TOMBSTONE)
+		parent_event = NULL;
 
 	if (parent_event) {
 		/*
@@ -13717,22 +13922,29 @@ perf_event_exit_event(struct perf_event *event, struct perf_event_context *ctx)
 		 * Do destroy all inherited groups, we don't care about those
 		 * and being thorough is better.
 		 */
-		detach_flags = DETACH_GROUP | DETACH_CHILD;
+		detach_flags |= DETACH_GROUP | DETACH_CHILD;
 		mutex_lock(&parent_event->child_mutex);
 	}
 
-	perf_remove_from_context(event, detach_flags | DETACH_EXIT);
+	if (revoke)
+		detach_flags |= DETACH_GROUP | DETACH_REVOKE;
 
+	perf_remove_from_context(event, detach_flags);
 	/*
 	 * Child events can be freed.
 	 */
-	if (parent_event) {
-		mutex_unlock(&parent_event->child_mutex);
-		/*
-		 * Kick perf_poll() for is_event_hup();
-		 */
-		perf_event_wakeup(parent_event);
-		put_event(event);
+	if (is_child) {
+		if (parent_event) {
+			mutex_unlock(&parent_event->child_mutex);
+			/*
+			 * Kick perf_poll() for is_event_hup();
+			 */
+			perf_event_wakeup(parent_event);
+			/*
+			 * pmu_detach_event() will have an extra refcount.
+			 */
+			put_event(event);
+		}
 		return;
 	}
 
@@ -13796,7 +14008,7 @@ static void perf_event_exit_task_context(struct task_struct *task, bool exit)
 		perf_event_task(task, ctx, 0);
 
 	list_for_each_entry_safe(child_event, next, &ctx->event_list, event_entry)
-		perf_event_exit_event(child_event, ctx);
+		perf_event_exit_event(child_event, ctx, false);
 
 	mutex_unlock(&ctx->mutex);
 
@@ -13949,6 +14161,14 @@ inherit_event(struct perf_event *parent_event,
 	if (parent_event->parent)
 		parent_event = parent_event->parent;
 
+	if (parent_event->state <= PERF_EVENT_STATE_REVOKED)
+		return NULL;
+
+	/*
+	 * Event creation should be under SRCU, see perf_pmu_unregister().
+	 */
+	guard(srcu)(&pmus_srcu);
+
 	child_event = perf_event_alloc(&parent_event->attr,
 					   parent_event->cpu,
 					   child,
@@ -13962,7 +14182,7 @@ inherit_event(struct perf_event *parent_event,
 
 	pmu_ctx = find_get_pmu_context(child_event->pmu, child_ctx, child_event);
 	if (IS_ERR(pmu_ctx)) {
-		free_event(child_event);
+		put_event(child_event);
 		return ERR_CAST(pmu_ctx);
 	}
 	child_event->pmu_ctx = pmu_ctx;
@@ -13977,7 +14197,7 @@ inherit_event(struct perf_event *parent_event,
 	if (is_orphaned_event(parent_event) ||
 	    !atomic_long_inc_not_zero(&parent_event->refcount)) {
 		mutex_unlock(&parent_event->child_mutex);
-		free_event(child_event);
+		put_event(child_event);
 		return NULL;
 	}
 

