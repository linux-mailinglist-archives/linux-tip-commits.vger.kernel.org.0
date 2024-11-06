Return-Path: <linux-tip-commits+bounces-2765-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C0A39BE4B8
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 11:50:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 90CB11F262BD
	for <lists+linux-tip-commits@lfdr.de>; Wed,  6 Nov 2024 10:50:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0496F1DE8A2;
	Wed,  6 Nov 2024 10:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Y/gOmH6f";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k+m+wBBP"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E2F61D278C;
	Wed,  6 Nov 2024 10:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730890109; cv=none; b=aKXWwxpFmtJrBDvN5dWxYs4tmWk1Ew/pcussx9iwfaXolTTJu40i2Kyq/F+ogcwvKErBRZ2IHGozSiMnJX8FuRoD1LCPuWAhe9N2ISLt57ia11K3FFHcU5H6dP2BSIs2iAVKDVFd5aDcGRp5Qdi/Y/nweGF9L/pB7n4xYALy1yk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730890109; c=relaxed/simple;
	bh=+hIUylHoEFGibmSnJELESYNVXq1dm54Vbi6yLlxd1A0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eWW3c3DmjlsdQOLl4YDfqf1AOWiNxcJTBMcYvNWrHZ5FVfoV1/DMo7BYpNTPRdiK/8uQ08pQ2hbKS8KCwrDSppD7BW1OtGSdaclFPV21IYp22narmzKsQHDkRFX/BUjqoF34pW4iwh1X7ojEPeBzidoJ0WpNr8rH6w0GnpVP5hE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Y/gOmH6f; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k+m+wBBP; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 06 Nov 2024 10:48:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1730890105;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tLFWAKJ8EcjJyjsdsqIOnt+CwKDMZfpo2b5RQUxBTcw=;
	b=Y/gOmH6fvsM3nQ+t1lFiFJi3WdmyiETdZ8mcof/nFtsygMNmqNbhPiTGETg6v8OuEjgJMG
	eZ7tyomUQFQNwzHWlIHAbLXb9b5/HrWzHGikewrw3vwEKGpebzkCeMyEsoGvZ6zYztNEKC
	fMxn2q5jICKG3Lf6kC8sHu0hBYlO0ub+Zh6DzwTsdaPeugMMGmvTEqwh1EbITglwj7aJ6c
	wqciSFXncJCkKkAPV07Mi1444h21hNebqyZmpHqlhOy/UUZ5MEiPfWTiRcDLuao8nXGXoB
	JB+qFShoAOpI1k3Cfp4FU4bb2kA3+WoGbHOsL7m+yNmlEHXdJ8ypo+warGUKtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1730890105;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tLFWAKJ8EcjJyjsdsqIOnt+CwKDMZfpo2b5RQUxBTcw=;
	b=k+m+wBBPT/vSszdPjqxULa8S6HKFh91wsPXOcl7ukzavkLlG0xZLAGZD4TQCQ+1NxuaXcK
	3RC/Jy74k8mtVKAw==
From: "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/core: Add aux_pause, aux_resume, aux_start_paused
Cc: Adrian Hunter <adrian.hunter@intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 James Clark <james.clark@arm.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241022155920.17511-3-adrian.hunter@intel.com>
References: <20241022155920.17511-3-adrian.hunter@intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173089010481.32228.360950035677955876.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     18d92bb57c39504d9da11c6ef604f58eb1d5a117
Gitweb:        https://git.kernel.org/tip/18d92bb57c39504d9da11c6ef604f58eb1d5a117
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Tue, 22 Oct 2024 18:59:08 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Nov 2024 12:55:43 +01:00

perf/core: Add aux_pause, aux_resume, aux_start_paused

Hardware traces, such as instruction traces, can produce a vast amount of
trace data, so being able to reduce tracing to more specific circumstances
can be useful.

The ability to pause or resume tracing when another event happens, can do
that.

Add ability for an event to "pause" or "resume" AUX area tracing.

Add aux_pause bit to perf_event_attr to indicate that, if the event
happens, the associated AUX area tracing should be paused. Ditto
aux_resume. Do not allow aux_pause and aux_resume to be set together.

Add aux_start_paused bit to perf_event_attr to indicate to an AUX area
event that it should start in a "paused" state.

Add aux_paused to struct hw_perf_event for AUX area events to keep track of
the "paused" state. aux_paused is initialized to aux_start_paused.

Add PERF_EF_PAUSE and PERF_EF_RESUME modes for ->stop() and ->start()
callbacks. Call as needed, during __perf_event_output(). Add
aux_in_pause_resume to struct perf_buffer to prevent races with the NMI
handler. Pause/resume in NMI context will miss out if it coincides with
another pause/resume.

To use aux_pause or aux_resume, an event must be in a group with the AUX
area event as the group leader.

Example (requires Intel PT and tools patches also):

 $ perf record --kcore -e intel_pt/aux-action=start-paused/k,syscalls:sys_enter_newuname/aux-action=resume/,syscalls:sys_exit_newuname/aux-action=pause/ uname
 Linux
 [ perf record: Woken up 1 times to write data ]
 [ perf record: Captured and wrote 0.043 MB perf.data ]
 $ perf script --call-trace
 uname   30805 [000] 24001.058782799: name: 0x7ffc9c1865b0
 uname   30805 [000] 24001.058784424:  psb offs: 0
 uname   30805 [000] 24001.058784424:  cbr: 39 freq: 3904 MHz (139%)
 uname   30805 [000] 24001.058784629: ([kernel.kallsyms])        debug_smp_processor_id
 uname   30805 [000] 24001.058784629: ([kernel.kallsyms])        __x64_sys_newuname
 uname   30805 [000] 24001.058784629: ([kernel.kallsyms])            down_read
 uname   30805 [000] 24001.058784629: ([kernel.kallsyms])                __cond_resched
 uname   30805 [000] 24001.058784629: ([kernel.kallsyms])                preempt_count_add
 uname   30805 [000] 24001.058784629: ([kernel.kallsyms])                    in_lock_functions
 uname   30805 [000] 24001.058784629: ([kernel.kallsyms])                preempt_count_sub
 uname   30805 [000] 24001.058784629: ([kernel.kallsyms])            up_read
 uname   30805 [000] 24001.058784629: ([kernel.kallsyms])                preempt_count_add
 uname   30805 [000] 24001.058784838: ([kernel.kallsyms])                    in_lock_functions
 uname   30805 [000] 24001.058784838: ([kernel.kallsyms])                preempt_count_sub
 uname   30805 [000] 24001.058784838: ([kernel.kallsyms])            _copy_to_user
 uname   30805 [000] 24001.058784838: ([kernel.kallsyms])        syscall_exit_to_user_mode
 uname   30805 [000] 24001.058784838: ([kernel.kallsyms])            syscall_exit_work
 uname   30805 [000] 24001.058784838: ([kernel.kallsyms])                perf_syscall_exit
 uname   30805 [000] 24001.058784838: ([kernel.kallsyms])                    debug_smp_processor_id
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                    perf_trace_buf_alloc
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                        perf_swevent_get_recursion_context
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                            debug_smp_processor_id
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                        debug_smp_processor_id
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                    perf_tp_event
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                        perf_trace_buf_update
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                            tracing_gen_ctx_irq_test
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                        perf_swevent_event
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                            __perf_event_account_interrupt
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                                __this_cpu_preempt_check
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                            perf_event_output_forward
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                                perf_event_aux_pause
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                                    ring_buffer_get
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                                        __rcu_read_lock
 uname   30805 [000] 24001.058785046: ([kernel.kallsyms])                                        __rcu_read_unlock
 uname   30805 [000] 24001.058785254: ([kernel.kallsyms])                                    pt_event_stop
 uname   30805 [000] 24001.058785254: ([kernel.kallsyms])                                        debug_smp_processor_id
 uname   30805 [000] 24001.058785254: ([kernel.kallsyms])                                        debug_smp_processor_id
 uname   30805 [000] 24001.058785254: ([kernel.kallsyms])                                        native_write_msr
 uname   30805 [000] 24001.058785463: ([kernel.kallsyms])                                        native_write_msr
 uname   30805 [000] 24001.058785639: 0x0

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: James Clark <james.clark@arm.com>
Link: https://lkml.kernel.org/r/20241022155920.17511-3-adrian.hunter@intel.com
---
 include/linux/perf_event.h      | 28 ++++++++++++-
 include/uapi/linux/perf_event.h | 11 ++++-
 kernel/events/core.c            | 75 ++++++++++++++++++++++++++++++--
 kernel/events/internal.h        |  1 +-
 4 files changed, 110 insertions(+), 5 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index fb90884..91b3100 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -170,6 +170,12 @@ struct hw_perf_event {
 		};
 		struct { /* aux / Intel-PT */
 			u64		aux_config;
+			/*
+			 * For AUX area events, aux_paused cannot be a state
+			 * flag because it can be updated asynchronously to
+			 * state.
+			 */
+			unsigned int	aux_paused;
 		};
 		struct { /* software */
 			struct hrtimer	hrtimer;
@@ -294,6 +300,7 @@ struct perf_event_pmu_context;
 #define PERF_PMU_CAP_NO_EXCLUDE			0x0040
 #define PERF_PMU_CAP_AUX_OUTPUT			0x0080
 #define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0100
+#define PERF_PMU_CAP_AUX_PAUSE			0x0200
 
 /**
  * pmu::scope
@@ -384,6 +391,8 @@ struct pmu {
 #define PERF_EF_START	0x01		/* start the counter when adding    */
 #define PERF_EF_RELOAD	0x02		/* reload the counter when starting */
 #define PERF_EF_UPDATE	0x04		/* update the counter when stopping */
+#define PERF_EF_PAUSE	0x08		/* AUX area event, pause tracing */
+#define PERF_EF_RESUME	0x10		/* AUX area event, resume tracing */
 
 	/*
 	 * Adds/Removes a counter to/from the PMU, can be done inside a
@@ -423,6 +432,18 @@ struct pmu {
 	 *
 	 * ->start() with PERF_EF_RELOAD will reprogram the counter
 	 *  value, must be preceded by a ->stop() with PERF_EF_UPDATE.
+	 *
+	 * ->stop() with PERF_EF_PAUSE will stop as simply as possible. Will not
+	 * overlap another ->stop() with PERF_EF_PAUSE nor ->start() with
+	 * PERF_EF_RESUME.
+	 *
+	 * ->start() with PERF_EF_RESUME will start as simply as possible but
+	 * only if the counter is not otherwise stopped. Will not overlap
+	 * another ->start() with PERF_EF_RESUME nor ->stop() with
+	 * PERF_EF_PAUSE.
+	 *
+	 * Notably, PERF_EF_PAUSE/PERF_EF_RESUME *can* be concurrent with other
+	 * ->stop()/->start() invocations, just not itself.
 	 */
 	void (*start)			(struct perf_event *event, int flags);
 	void (*stop)			(struct perf_event *event, int flags);
@@ -1679,6 +1700,13 @@ static inline bool has_aux(struct perf_event *event)
 	return event->pmu->setup_aux;
 }
 
+static inline bool has_aux_action(struct perf_event *event)
+{
+	return event->attr.aux_sample_size ||
+	       event->attr.aux_pause ||
+	       event->attr.aux_resume;
+}
+
 static inline bool is_write_backward(struct perf_event *event)
 {
 	return !!event->attr.write_backward;
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index 4842c36..0524d54 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -511,7 +511,16 @@ struct perf_event_attr {
 	__u16	sample_max_stack;
 	__u16	__reserved_2;
 	__u32	aux_sample_size;
-	__u32	__reserved_3;
+
+	union {
+		__u32	aux_action;
+		struct {
+			__u32	aux_start_paused :  1, /* start AUX area tracing paused */
+				aux_pause        :  1, /* on overflow, pause AUX area tracing */
+				aux_resume       :  1, /* on overflow, resume AUX area tracing */
+				__reserved_3     : 29;
+		};
+	};
 
 	/*
 	 * User provided data if sigtrap=1, passed back to user via
diff --git a/kernel/events/core.c b/kernel/events/core.c
index e3589c4..0e9cfe6 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2146,7 +2146,7 @@ static void perf_put_aux_event(struct perf_event *event)
 
 static bool perf_need_aux_event(struct perf_event *event)
 {
-	return !!event->attr.aux_output || !!event->attr.aux_sample_size;
+	return event->attr.aux_output || has_aux_action(event);
 }
 
 static int perf_get_aux_event(struct perf_event *event,
@@ -2171,6 +2171,10 @@ static int perf_get_aux_event(struct perf_event *event,
 	    !perf_aux_output_match(event, group_leader))
 		return 0;
 
+	if ((event->attr.aux_pause || event->attr.aux_resume) &&
+	    !(group_leader->pmu->capabilities & PERF_PMU_CAP_AUX_PAUSE))
+		return 0;
+
 	if (event->attr.aux_sample_size && !group_leader->pmu->snapshot_aux)
 		return 0;
 
@@ -8016,6 +8020,49 @@ void perf_prepare_header(struct perf_event_header *header,
 	WARN_ON_ONCE(header->size & 7);
 }
 
+static void __perf_event_aux_pause(struct perf_event *event, bool pause)
+{
+	if (pause) {
+		if (!event->hw.aux_paused) {
+			event->hw.aux_paused = 1;
+			event->pmu->stop(event, PERF_EF_PAUSE);
+		}
+	} else {
+		if (event->hw.aux_paused) {
+			event->hw.aux_paused = 0;
+			event->pmu->start(event, PERF_EF_RESUME);
+		}
+	}
+}
+
+static void perf_event_aux_pause(struct perf_event *event, bool pause)
+{
+	struct perf_buffer *rb;
+
+	if (WARN_ON_ONCE(!event))
+		return;
+
+	rb = ring_buffer_get(event);
+	if (!rb)
+		return;
+
+	scoped_guard (irqsave) {
+		/*
+		 * Guard against self-recursion here. Another event could trip
+		 * this same from NMI context.
+		 */
+		if (READ_ONCE(rb->aux_in_pause_resume))
+			break;
+
+		WRITE_ONCE(rb->aux_in_pause_resume, 1);
+		barrier();
+		__perf_event_aux_pause(event, pause);
+		barrier();
+		WRITE_ONCE(rb->aux_in_pause_resume, 0);
+	}
+	ring_buffer_put(rb);
+}
+
 static __always_inline int
 __perf_event_output(struct perf_event *event,
 		    struct perf_sample_data *data,
@@ -9818,9 +9865,12 @@ static int __perf_event_overflow(struct perf_event *event,
 
 	ret = __perf_event_account_interrupt(event, throttle);
 
+	if (event->attr.aux_pause)
+		perf_event_aux_pause(event->aux_event, true);
+
 	if (event->prog && event->prog->type == BPF_PROG_TYPE_PERF_EVENT &&
 	    !bpf_overflow_handler(event, data, regs))
-		return ret;
+		goto out;
 
 	/*
 	 * XXX event_limit might not quite work as expected on inherited
@@ -9882,6 +9932,9 @@ static int __perf_event_overflow(struct perf_event *event,
 		event->pending_wakeup = 1;
 		irq_work_queue(&event->pending_irq);
 	}
+out:
+	if (event->attr.aux_resume)
+		perf_event_aux_pause(event->aux_event, false);
 
 	return ret;
 }
@@ -12273,11 +12326,25 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	}
 
 	if (event->attr.aux_output &&
-	    !(pmu->capabilities & PERF_PMU_CAP_AUX_OUTPUT)) {
+	    (!(pmu->capabilities & PERF_PMU_CAP_AUX_OUTPUT) ||
+	     event->attr.aux_pause || event->attr.aux_resume)) {
 		err = -EOPNOTSUPP;
 		goto err_pmu;
 	}
 
+	if (event->attr.aux_pause && event->attr.aux_resume) {
+		err = -EINVAL;
+		goto err_pmu;
+	}
+
+	if (event->attr.aux_start_paused) {
+		if (!(pmu->capabilities & PERF_PMU_CAP_AUX_PAUSE)) {
+			err = -EOPNOTSUPP;
+			goto err_pmu;
+		}
+		event->hw.aux_paused = 1;
+	}
+
 	if (cgroup_fd != -1) {
 		err = perf_cgroup_connect(cgroup_fd, event, attr, group_leader);
 		if (err)
@@ -13073,7 +13140,7 @@ perf_event_create_kernel_counter(struct perf_event_attr *attr, int cpu,
 	 * Grouping is not supported for kernel events, neither is 'AUX',
 	 * make sure the caller's intentions are adjusted.
 	 */
-	if (attr->aux_output)
+	if (attr->aux_output || attr->aux_action)
 		return ERR_PTR(-EINVAL);
 
 	event = perf_event_alloc(attr, cpu, task, NULL, NULL,
diff --git a/kernel/events/internal.h b/kernel/events/internal.h
index e072d99..249288d 100644
--- a/kernel/events/internal.h
+++ b/kernel/events/internal.h
@@ -52,6 +52,7 @@ struct perf_buffer {
 	void				(*free_aux)(void *);
 	refcount_t			aux_refcount;
 	int				aux_in_sampling;
+	int				aux_in_pause_resume;
 	void				**aux_pages;
 	void				*aux_priv;
 

