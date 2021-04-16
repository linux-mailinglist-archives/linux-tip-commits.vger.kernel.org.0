Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D2F3E362357
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Apr 2021 17:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245430AbhDPPCT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Apr 2021 11:02:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245324AbhDPPCR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Apr 2021 11:02:17 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2756AC06175F;
        Fri, 16 Apr 2021 08:01:52 -0700 (PDT)
Date:   Fri, 16 Apr 2021 15:01:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618585310;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=k8FmU4HY1xQa3gFWt3udRSjCOJ6imc/Xux2mb+ILKXg=;
        b=f2lKRsjFEdjiU9sGOiylCWwL6l8D0c2wts8O0IjTL71988ViAGp5mYNrx9+wi0ffGzc9H6
        VbJMtddRNhVYO8MTk4np/Gv6I4mKFN/f3UjKoVBgxLr2l4Pl89jY/jHCCN0EdkOZRULon9
        pAqLCp1/9jIMWDxE9RXvUJngKU218LXWJZIaMi9UOGKI+L6VBp+WUO8sgCNGJ1eE6vuQYR
        /R6ZNTF0btr2vn/3KuWZjjelk66Ay+tjQCOgcw0nowD1x6kAhQ9xt9yga+H0nsgEd2UvBj
        2BD8He1z9dRN34UZUBjERd5G1J3oAoW+LJ2/mf/fwEPoyrIwQnQUlWsjCamS0Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618585310;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=k8FmU4HY1xQa3gFWt3udRSjCOJ6imc/Xux2mb+ILKXg=;
        b=kzJd+o0Atv8l/65/XWVm8LQh5jn+Vwi32UecVv6tcVNzBv9Caztp2CvTzS6K1iXFZPjU92
        ae9AePLtmgN4IuAQ==
From:   "tip-bot2 for Marco Elver" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Add support for SIGTRAP on perf events
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161858530998.29796.5867430906963081816.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     97ba62b278674293762c3d91f724f1bb922f04e0
Gitweb:        https://git.kernel.org/tip/97ba62b278674293762c3d91f724f1bb922f04e0
Author:        Marco Elver <elver@google.com>
AuthorDate:    Thu, 08 Apr 2021 12:36:01 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Apr 2021 16:32:41 +02:00

perf: Add support for SIGTRAP on perf events

Adds bit perf_event_attr::sigtrap, which can be set to cause events to
send SIGTRAP (with si_code TRAP_PERF) to the task where the event
occurred. The primary motivation is to support synchronous signals on
perf events in the task where an event (such as breakpoints) triggered.

To distinguish perf events based on the event type, the type is set in
si_errno. For events that are associated with an address, si_addr is
copied from perf_sample_data.

The new field perf_event_attr::sig_data is copied to si_perf, which
allows user space to disambiguate which event (of the same type)
triggered the signal. For example, user space could encode the relevant
information it cares about in sig_data.

We note that the choice of an opaque u64 provides the simplest and most
flexible option. Alternatives where a reference to some user space data
is passed back suffer from the problem that modification of referenced
data (be it the event fd, or the perf_event_attr) can race with the
signal being delivered (of course, the same caveat applies if user space
decides to store a pointer in sig_data, but the ABI explicitly avoids
prescribing such a design).

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Marco Elver <elver@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Dmitry Vyukov <dvyukov@google.com>
Link: https://lore.kernel.org/lkml/YBv3rAT566k+6zjg@hirez.programming.kicks-ass.net/
---
 include/linux/perf_event.h      |  1 +-
 include/uapi/linux/perf_event.h | 10 ++++++-
 kernel/events/core.c            | 49 +++++++++++++++++++++++++++++++-
 3 files changed, 58 insertions(+), 2 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 1660039..7d7280a 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -735,6 +735,7 @@ struct perf_event {
 	int				pending_wakeup;
 	int				pending_kill;
 	int				pending_disable;
+	unsigned long			pending_addr;	/* SIGTRAP */
 	struct irq_work			pending;
 
 	atomic_t			event_limit;
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 8c5b9f5..31b00e3 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -311,6 +311,7 @@ enum perf_event_read_format {
 #define PERF_ATTR_SIZE_VER4	104	/* add: sample_regs_intr */
 #define PERF_ATTR_SIZE_VER5	112	/* add: aux_watermark */
 #define PERF_ATTR_SIZE_VER6	120	/* add: aux_sample_size */
+#define PERF_ATTR_SIZE_VER7	128	/* add: sig_data */
 
 /*
  * Hardware event_id to monitor via a performance monitoring event:
@@ -391,7 +392,8 @@ struct perf_event_attr {
 				build_id       :  1, /* use build id in mmap2 events */
 				inherit_thread :  1, /* children only inherit if cloned with CLONE_THREAD */
 				remove_on_exec :  1, /* event is removed from task on exec */
-				__reserved_1   : 27;
+				sigtrap        :  1, /* send synchronous SIGTRAP on event */
+				__reserved_1   : 26;
 
 	union {
 		__u32		wakeup_events;	  /* wakeup every n events */
@@ -443,6 +445,12 @@ struct perf_event_attr {
 	__u16	__reserved_2;
 	__u32	aux_sample_size;
 	__u32	__reserved_3;
+
+	/*
+	 * User provided data if sigtrap=1, passed back to user via
+	 * siginfo_t::si_perf, e.g. to permit user to identify the event.
+	 */
+	__u64	sig_data;
 };
 
 /*
diff --git a/kernel/events/core.c b/kernel/events/core.c
index e4a584b..6f0723c 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -6392,6 +6392,33 @@ void perf_event_wakeup(struct perf_event *event)
 	}
 }
 
+static void perf_sigtrap(struct perf_event *event)
+{
+	struct kernel_siginfo info;
+
+	/*
+	 * We'd expect this to only occur if the irq_work is delayed and either
+	 * ctx->task or current has changed in the meantime. This can be the
+	 * case on architectures that do not implement arch_irq_work_raise().
+	 */
+	if (WARN_ON_ONCE(event->ctx->task != current))
+		return;
+
+	/*
+	 * perf_pending_event() can race with the task exiting.
+	 */
+	if (current->flags & PF_EXITING)
+		return;
+
+	clear_siginfo(&info);
+	info.si_signo = SIGTRAP;
+	info.si_code = TRAP_PERF;
+	info.si_errno = event->attr.type;
+	info.si_perf = event->attr.sig_data;
+	info.si_addr = (void __user *)event->pending_addr;
+	force_sig_info(&info);
+}
+
 static void perf_pending_event_disable(struct perf_event *event)
 {
 	int cpu = READ_ONCE(event->pending_disable);
@@ -6401,6 +6428,13 @@ static void perf_pending_event_disable(struct perf_event *event)
 
 	if (cpu == smp_processor_id()) {
 		WRITE_ONCE(event->pending_disable, -1);
+
+		if (event->attr.sigtrap) {
+			perf_sigtrap(event);
+			atomic_set_release(&event->event_limit, 1); /* rearm event */
+			return;
+		}
+
 		perf_event_disable_local(event);
 		return;
 	}
@@ -9103,6 +9137,7 @@ static int __perf_event_overflow(struct perf_event *event,
 	if (events && atomic_dec_and_test(&event->event_limit)) {
 		ret = 1;
 		event->pending_kill = POLL_HUP;
+		event->pending_addr = data->addr;
 
 		perf_event_disable_inatomic(event);
 	}
@@ -11384,6 +11419,10 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		if (!task || cpu != -1)
 			return ERR_PTR(-EINVAL);
 	}
+	if (attr->sigtrap && !task) {
+		/* Requires a task: avoid signalling random tasks. */
+		return ERR_PTR(-EINVAL);
+	}
 
 	node = (cpu >= 0) ? cpu_to_node(cpu) : -1;
 	event = kmem_cache_alloc_node(perf_event_cache, GFP_KERNEL | __GFP_ZERO,
@@ -11432,6 +11471,9 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 
 	event->state		= PERF_EVENT_STATE_INACTIVE;
 
+	if (event->attr.sigtrap)
+		atomic_set(&event->event_limit, 1);
+
 	if (task) {
 		event->attach_state = PERF_ATTACH_TASK;
 		/*
@@ -11710,6 +11752,9 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 	if (attr->remove_on_exec && attr->enable_on_exec)
 		return -EINVAL;
 
+	if (attr->sigtrap && !attr->remove_on_exec)
+		return -EINVAL;
+
 out:
 	return ret;
 
@@ -12936,7 +12981,9 @@ inherit_task_group(struct perf_event *event, struct task_struct *parent,
 	struct perf_event_context *child_ctx;
 
 	if (!event->attr.inherit ||
-	    (event->attr.inherit_thread && !(clone_flags & CLONE_THREAD))) {
+	    (event->attr.inherit_thread && !(clone_flags & CLONE_THREAD)) ||
+	    /* Do not inherit if sigtrap and signal handlers were cleared. */
+	    (event->attr.sigtrap && (clone_flags & CLONE_CLEAR_SIGHAND))) {
 		*inherited_all = 0;
 		return 0;
 	}
