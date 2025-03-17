Return-Path: <linux-tip-commits+bounces-4250-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 69EC3A64A2C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 52861188E095
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1F39235C15;
	Mon, 17 Mar 2025 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="GDouBI4T";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="j0qpGc+/"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB6C2343B5;
	Mon, 17 Mar 2025 10:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207654; cv=none; b=cq5TuEjKrbnfiuM/zc7e/veEevLYrTxf5DtcWZ2+S2Ff6zPI08nkGViKAKZZWxTxnOMNW2hY/TTjAchSkU4hvUy4WmvQ4mZsc5xQBuPu4DA3IP85UKOP+7PPc32Eu1fuIcXcbXYjI35Tivm5O1mbw1KS/vHcruGp7LTtdATVl4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207654; c=relaxed/simple;
	bh=YhMThoc2d5rae1aDjHX0ez76MInfL7Rsls7A3ODhjyA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ItEihXwkFPFu/LCBKBH+OQWcqx9jB/V/vtowPDV04aTu+8xiTgtGSbym8JQl24oZbLHkVlcYdIM8/bCK0vWGKpcHdSaYVld985yjYPfGJsoNt1EwnQP+8lU2SwonYgZ0b4DlygtjoyAOn5oEFGr8kTAA3R0Hfr9tO+HuIRKPNQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=GDouBI4T; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=j0qpGc+/; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:34:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742207651;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZpaSuzaf728MATHvVSA2BwH6/wTY21Pv3gelhbSZtLg=;
	b=GDouBI4TrKACDsYQ3mb2h02ZyBjQpL5XDxY4gG5GRpSY2XXsDmpIXrbPqeVvULektxWqk4
	kQG+pFdvEyaniJg+P8D9FxVPHTVtyOW+G96GwQkGo8kF8PJvV1GeXLR0KpiaWGu8D4ifoh
	Z8btMxUSH87dSJt5aXwOc3sue6G1NukGnchd63iCdJeJlgz31lAALDaSs14POj3m71cYyR
	cKI5EZ6W9xMY0q4XC2+xGrXQHDc5plfwKUKGWxlcGz0/zycG6T9lZutR679/RMS5zPtdJ0
	WotvHGmyI0/sXC//EpsLE+n0tZYnmdA4iJM1QtriwIuJNCeFEW5Ch1egK7Jrbw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742207651;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZpaSuzaf728MATHvVSA2BwH6/wTY21Pv3gelhbSZtLg=;
	b=j0qpGc+/0GpONcqIXbBuyIp8v4snMt6fZo7KIzs9sdKHO6pqIqDxO0cK3wn5IVAORDO9K0
	Pno0ZJ+gr7P6AdDQ==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: attach/detach PMU specific data
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250314172700.438923-3-kan.liang@linux.intel.com>
References: <20250314172700.438923-3-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220765069.14745.13303279600998112051.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     506e64e710ff9573fd2b86686528762b7901b5e4
Gitweb:        https://git.kernel.org/tip/506e64e710ff9573fd2b86686528762b7901b5e4
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 14 Mar 2025 10:26:56 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:23:37 +01:00

perf: attach/detach PMU specific data

The LBR call stack data has to be saved/restored during context switch
to fix the shorter LBRs call stacks issue in the  system-wide mode.
Allocate PMU specific data and attach them to the corresponding
task_struct during LBR call stack monitoring.

When a LBR call stack event is accounted, the perf_ctx_data for the
related tasks will be allocated/attached by attach_perf_ctx_data().
When a LBR call stack event is unaccounted, the perf_ctx_data for
related tasks will be detached/freed by detach_perf_ctx_data().

The LBR call stack event could be a per-task event or a system-wide
event.
- For a per-task event, perf only allocates the perf_ctx_data for the
  current task. If the allocation fails, perf will error out.
- For a system-wide event, perf has to allocate the perf_ctx_data for
  both the existing tasks and the upcoming tasks.
  The allocation for the existing tasks is done in perf_event_alloc().
  If any allocation fails, perf will error out.
  The allocation for the new tasks will be done in perf_event_fork().
  A global reader/writer semaphore, global_ctx_data_rwsem, is added to
  address the global race.
- The perf_ctx_data only be freed by the last LBR call stack event.
  The number of the per-task events is tracked by refcount of each task.
  Since the system-wide events impact all tasks, it's not practical to
  go through the whole task list to update the refcount for each
  system-wide event. The number of system-wide events is tracked by a
  global variable global_ctx_data_ref.

Suggested-by: "Peter Zijlstra (Intel)" <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250314172700.438923-3-kan.liang@linux.intel.com
---
 include/linux/perf_event.h |   3 +-
 kernel/events/core.c       | 289 ++++++++++++++++++++++++++++++++++++-
 2 files changed, 291 insertions(+), 1 deletion(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 75d9b1e..2551170 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -676,11 +676,12 @@ struct swevent_hlist {
 #define PERF_ATTACH_GROUP	0x0002
 #define PERF_ATTACH_TASK	0x0004
 #define PERF_ATTACH_TASK_DATA	0x0008
-#define PERF_ATTACH_ITRACE	0x0010
+#define PERF_ATTACH_GLOBAL_DATA	0x0010
 #define PERF_ATTACH_SCHED_CB	0x0020
 #define PERF_ATTACH_CHILD	0x0040
 #define PERF_ATTACH_EXCLUSIVE	0x0080
 #define PERF_ATTACH_CALLCHAIN	0x0100
+#define PERF_ATTACH_ITRACE	0x0200
 
 struct bpf_prog;
 struct perf_cgroup;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 20d28b7..e86d35e 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -55,6 +55,7 @@
 #include <linux/pgtable.h>
 #include <linux/buildid.h>
 #include <linux/task_work.h>
+#include <linux/percpu-rwsem.h>
 
 #include "internal.h"
 
@@ -5217,6 +5218,225 @@ static void unaccount_freq_event(void)
 		atomic_dec(&nr_freq_events);
 }
 
+
+static struct perf_ctx_data *
+alloc_perf_ctx_data(struct kmem_cache *ctx_cache, bool global)
+{
+	struct perf_ctx_data *cd;
+
+	cd = kzalloc(sizeof(*cd), GFP_KERNEL);
+	if (!cd)
+		return NULL;
+
+	cd->data = kmem_cache_zalloc(ctx_cache, GFP_KERNEL);
+	if (!cd->data) {
+		kfree(cd);
+		return NULL;
+	}
+
+	cd->global = global;
+	cd->ctx_cache = ctx_cache;
+	refcount_set(&cd->refcount, 1);
+
+	return cd;
+}
+
+static void free_perf_ctx_data(struct perf_ctx_data *cd)
+{
+	kmem_cache_free(cd->ctx_cache, cd->data);
+	kfree(cd);
+}
+
+static void __free_perf_ctx_data_rcu(struct rcu_head *rcu_head)
+{
+	struct perf_ctx_data *cd;
+
+	cd = container_of(rcu_head, struct perf_ctx_data, rcu_head);
+	free_perf_ctx_data(cd);
+}
+
+static inline void perf_free_ctx_data_rcu(struct perf_ctx_data *cd)
+{
+	call_rcu(&cd->rcu_head, __free_perf_ctx_data_rcu);
+}
+
+static int
+attach_task_ctx_data(struct task_struct *task, struct kmem_cache *ctx_cache,
+		     bool global)
+{
+	struct perf_ctx_data *cd, *old = NULL;
+
+	cd = alloc_perf_ctx_data(ctx_cache, global);
+	if (!cd)
+		return -ENOMEM;
+
+	for (;;) {
+		if (try_cmpxchg((struct perf_ctx_data **)&task->perf_ctx_data, &old, cd)) {
+			if (old)
+				perf_free_ctx_data_rcu(old);
+			return 0;
+		}
+
+		if (!old) {
+			/*
+			 * After seeing a dead @old, we raced with
+			 * removal and lost, try again to install @cd.
+			 */
+			continue;
+		}
+
+		if (refcount_inc_not_zero(&old->refcount)) {
+			free_perf_ctx_data(cd); /* unused */
+			return 0;
+		}
+
+		/*
+		 * @old is a dead object, refcount==0 is stable, try and
+		 * replace it with @cd.
+		 */
+	}
+	return 0;
+}
+
+static void __detach_global_ctx_data(void);
+DEFINE_STATIC_PERCPU_RWSEM(global_ctx_data_rwsem);
+static refcount_t global_ctx_data_ref;
+
+static int
+attach_global_ctx_data(struct kmem_cache *ctx_cache)
+{
+	struct task_struct *g, *p;
+	struct perf_ctx_data *cd;
+	int ret;
+
+	if (refcount_inc_not_zero(&global_ctx_data_ref))
+		return 0;
+
+	guard(percpu_write)(&global_ctx_data_rwsem);
+	if (refcount_inc_not_zero(&global_ctx_data_ref))
+		return 0;
+again:
+	/* Allocate everything */
+	scoped_guard (rcu) {
+		for_each_process_thread(g, p) {
+			cd = rcu_dereference(p->perf_ctx_data);
+			if (cd && !cd->global) {
+				cd->global = 1;
+				if (!refcount_inc_not_zero(&cd->refcount))
+					cd = NULL;
+			}
+			if (!cd) {
+				get_task_struct(p);
+				goto alloc;
+			}
+		}
+	}
+
+	refcount_set(&global_ctx_data_ref, 1);
+
+	return 0;
+alloc:
+	ret = attach_task_ctx_data(p, ctx_cache, true);
+	put_task_struct(p);
+	if (ret) {
+		__detach_global_ctx_data();
+		return ret;
+	}
+	goto again;
+}
+
+static int
+attach_perf_ctx_data(struct perf_event *event)
+{
+	struct task_struct *task = event->hw.target;
+	struct kmem_cache *ctx_cache = event->pmu->task_ctx_cache;
+	int ret;
+
+	if (!ctx_cache)
+		return -ENOMEM;
+
+	if (task)
+		return attach_task_ctx_data(task, ctx_cache, false);
+
+	ret = attach_global_ctx_data(ctx_cache);
+	if (ret)
+		return ret;
+
+	event->attach_state |= PERF_ATTACH_GLOBAL_DATA;
+	return 0;
+}
+
+static void
+detach_task_ctx_data(struct task_struct *p)
+{
+	struct perf_ctx_data *cd;
+
+	scoped_guard (rcu) {
+		cd = rcu_dereference(p->perf_ctx_data);
+		if (!cd || !refcount_dec_and_test(&cd->refcount))
+			return;
+	}
+
+	/*
+	 * The old ctx_data may be lost because of the race.
+	 * Nothing is required to do for the case.
+	 * See attach_task_ctx_data().
+	 */
+	if (try_cmpxchg((struct perf_ctx_data **)&p->perf_ctx_data, &cd, NULL))
+		perf_free_ctx_data_rcu(cd);
+}
+
+static void __detach_global_ctx_data(void)
+{
+	struct task_struct *g, *p;
+	struct perf_ctx_data *cd;
+
+again:
+	scoped_guard (rcu) {
+		for_each_process_thread(g, p) {
+			cd = rcu_dereference(p->perf_ctx_data);
+			if (!cd || !cd->global)
+				continue;
+			cd->global = 0;
+			get_task_struct(p);
+			goto detach;
+		}
+	}
+	return;
+detach:
+	detach_task_ctx_data(p);
+	put_task_struct(p);
+	goto again;
+}
+
+static void detach_global_ctx_data(void)
+{
+	if (refcount_dec_not_one(&global_ctx_data_ref))
+		return;
+
+	guard(percpu_write)(&global_ctx_data_rwsem);
+	if (!refcount_dec_and_test(&global_ctx_data_ref))
+		return;
+
+	/* remove everything */
+	__detach_global_ctx_data();
+}
+
+static void detach_perf_ctx_data(struct perf_event *event)
+{
+	struct task_struct *task = event->hw.target;
+
+	event->attach_state &= ~PERF_ATTACH_TASK_DATA;
+
+	if (task)
+		return detach_task_ctx_data(task);
+
+	if (event->attach_state & PERF_ATTACH_GLOBAL_DATA) {
+		detach_global_ctx_data();
+		event->attach_state &= ~PERF_ATTACH_GLOBAL_DATA;
+	}
+}
+
 static void unaccount_event(struct perf_event *event)
 {
 	bool dec = false;
@@ -5398,6 +5618,9 @@ static void __free_event(struct perf_event *event)
 	if (is_cgroup_event(event))
 		perf_detach_cgroup(event);
 
+	if (event->attach_state & PERF_ATTACH_TASK_DATA)
+		detach_perf_ctx_data(event);
+
 	if (event->destroy)
 		event->destroy(event);
 
@@ -8607,10 +8830,58 @@ static void perf_event_task(struct task_struct *task,
 		       task_ctx);
 }
 
+/*
+ * Allocate data for a new task when profiling system-wide
+ * events which require PMU specific data
+ */
+static void
+perf_event_alloc_task_data(struct task_struct *child,
+			   struct task_struct *parent)
+{
+	struct kmem_cache *ctx_cache = NULL;
+	struct perf_ctx_data *cd;
+
+	if (!refcount_read(&global_ctx_data_ref))
+		return;
+
+	scoped_guard (rcu) {
+		cd = rcu_dereference(parent->perf_ctx_data);
+		if (cd)
+			ctx_cache = cd->ctx_cache;
+	}
+
+	if (!ctx_cache)
+		return;
+
+	guard(percpu_read)(&global_ctx_data_rwsem);
+	scoped_guard (rcu) {
+		cd = rcu_dereference(child->perf_ctx_data);
+		if (!cd) {
+			/*
+			 * A system-wide event may be unaccount,
+			 * when attaching the perf_ctx_data.
+			 */
+			if (!refcount_read(&global_ctx_data_ref))
+				return;
+			goto attach;
+		}
+
+		if (!cd->global) {
+			cd->global = 1;
+			refcount_inc(&cd->refcount);
+		}
+	}
+
+	return;
+attach:
+	attach_task_ctx_data(child, ctx_cache, true);
+}
+
 void perf_event_fork(struct task_struct *task)
 {
 	perf_event_task(task, NULL, 1);
 	perf_event_namespaces(task);
+	perf_event_alloc_task_data(task, current);
 }
 
 /*
@@ -12491,6 +12762,18 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		return (void*)pmu;
 
 	/*
+	 * The PERF_ATTACH_TASK_DATA is set in the event_init()->hw_config().
+	 * The attach should be right after the perf_init_event().
+	 * Otherwise, the __free_event() would mistakenly detach the non-exist
+	 * perf_ctx_data because of the other errors between them.
+	 */
+	if (event->attach_state & PERF_ATTACH_TASK_DATA) {
+		err = attach_perf_ctx_data(event);
+		if (err)
+			return ERR_PTR(err);
+	}
+
+	/*
 	 * Disallow uncore-task events. Similarly, disallow uncore-cgroup
 	 * events (they don't make sense as the cgroup will be different
 	 * on other CPUs in the uncore mask).
@@ -13637,6 +13920,12 @@ void perf_event_exit_task(struct task_struct *child)
 	 * At this point we need to send EXIT events to cpu contexts.
 	 */
 	perf_event_task(child, NULL, 0);
+
+	/*
+	 * Detach the perf_ctx_data for the system-wide event.
+	 */
+	guard(percpu_read)(&global_ctx_data_rwsem);
+	detach_task_ctx_data(child);
 }
 
 static void perf_free_event(struct perf_event *event,

