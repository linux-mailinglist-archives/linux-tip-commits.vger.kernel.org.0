Return-Path: <linux-tip-commits+bounces-3873-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 65EA5A4D74B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 10:04:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F032A3AFC5E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  4 Mar 2025 09:03:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91A96201024;
	Tue,  4 Mar 2025 08:57:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ntEwppIR";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="BOS9BBnx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A5D91FFC6A;
	Tue,  4 Mar 2025 08:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741078631; cv=none; b=qk3hBi5XqKm+stG4M86eO/bVq4j80Nfg6bVsir2W5IyL2GUJDYweZcInt2VIbRDXm/uFxAKdJG+tXXR9WfbKecV1pIlsXWe5n2RFtCqUc7gqGvKyk5GnUnTAkQ0ESpTs+mTcg63E89YXgxuHEPqF52MAFJloCOy99iiwdsJqC0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741078631; c=relaxed/simple;
	bh=WDl6QTjSEHV5AyWtUxFzA0ppaMNWXBeG2gEjJ2aC37I=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=F5XcBi4pHIvXQobYf6ETQKsNHj/Z3x24j6QJ8J76YHMycb1rv5HHLQosMrz2DlGHCU3DRo8wdfmYRIgw9FL+4/OhppXYbdBpMNNSx9zLEz5z8Lh/5TjTCKlA/diFzLEVu0cPPS5xfQBTo2tOLPGFsgRzNHyFMv+Fp4tmFpp3mB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ntEwppIR; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=BOS9BBnx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 04 Mar 2025 08:57:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741078627;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3pMqXQ7GFB19hIW5i2FEQ8RrF3gjhj+Woeyx4CSp3/Q=;
	b=ntEwppIRN/+ou05D6JmzSnJluF3ZD6WXEukxgYbvzm6MyeH3g/ljbGNBs3Gds0/fYlhsEE
	XzbWIAeGABiP7NQqyx2TUj/kiDP6ewnU1DGqWpJI55p0vGrONBrCZE1nPSS9xapO1FUC1S
	2E4oEgQWBIwevN8TXxm0IGxFM7UtJLs6y4rPdzCnCAUF5maJ71+krX54OlYYfzXDv+bwoE
	Ay6/uKEK2cSYJKDbl1rrzZ7KY7AF3bYESBfO1jWG2E2SvwmW1PbXUtMirXaojzLA33ZMwi
	RpIZ5Iv08uWCWckMPjP+JBqgSlicIluY4JoGrDC5JmHOqQWpizD0UFq2r6ay3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741078627;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3pMqXQ7GFB19hIW5i2FEQ8RrF3gjhj+Woeyx4CSp3/Q=;
	b=BOS9BBnxl50tzQXoTqlDwx+8FDRxOpI2EICJJNWoClQ+i1s0rrZVmOyxyunEv/FUD/e93L
	ntD76JY4Eq+XMJBg==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/core: Simplify the perf_event_alloc() error path
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, Ravi Bangoria <ravi.bangoria@amd.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241104135517.967889521@infradead.org>
References: <20241104135517.967889521@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174107862725.14745.3808152785357902038.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     c70ca298036c58a88686ff388d3d367e9d21acf0
Gitweb:        https://git.kernel.org/tip/c70ca298036c58a88686ff388d3d367e9d21acf0
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 04 Nov 2024 14:39:13 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 04 Mar 2025 09:42:14 +01:00

perf/core: Simplify the perf_event_alloc() error path

The error cleanup sequence in perf_event_alloc() is a subset of the
existing _free_event() function (it must of course be).

Split this out into __free_event() and simplify the error path.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Ravi Bangoria <ravi.bangoria@amd.com>
Link: https://lore.kernel.org/r/20241104135517.967889521@infradead.org
---
 include/linux/perf_event.h |  16 ++--
 kernel/events/core.c       | 138 ++++++++++++++++++------------------
 2 files changed, 78 insertions(+), 76 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index c4525ba..8c0117b 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -673,13 +673,15 @@ struct swevent_hlist {
 	struct rcu_head			rcu_head;
 };
 
-#define PERF_ATTACH_CONTEXT	0x01
-#define PERF_ATTACH_GROUP	0x02
-#define PERF_ATTACH_TASK	0x04
-#define PERF_ATTACH_TASK_DATA	0x08
-#define PERF_ATTACH_ITRACE	0x10
-#define PERF_ATTACH_SCHED_CB	0x20
-#define PERF_ATTACH_CHILD	0x40
+#define PERF_ATTACH_CONTEXT	0x0001
+#define PERF_ATTACH_GROUP	0x0002
+#define PERF_ATTACH_TASK	0x0004
+#define PERF_ATTACH_TASK_DATA	0x0008
+#define PERF_ATTACH_ITRACE	0x0010
+#define PERF_ATTACH_SCHED_CB	0x0020
+#define PERF_ATTACH_CHILD	0x0040
+#define PERF_ATTACH_EXCLUSIVE	0x0080
+#define PERF_ATTACH_CALLCHAIN	0x0100
 
 struct bpf_prog;
 struct perf_cgroup;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 6ccf363..1b8b1c8 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5289,6 +5289,8 @@ static int exclusive_event_init(struct perf_event *event)
 			return -EBUSY;
 	}
 
+	event->attach_state |= PERF_ATTACH_EXCLUSIVE;
+
 	return 0;
 }
 
@@ -5296,14 +5298,13 @@ static void exclusive_event_destroy(struct perf_event *event)
 {
 	struct pmu *pmu = event->pmu;
 
-	if (!is_exclusive_pmu(pmu))
-		return;
-
 	/* see comment in exclusive_event_init() */
 	if (event->attach_state & PERF_ATTACH_TASK)
 		atomic_dec(&pmu->exclusive_cnt);
 	else
 		atomic_inc(&pmu->exclusive_cnt);
+
+	event->attach_state &= ~PERF_ATTACH_EXCLUSIVE;
 }
 
 static bool exclusive_event_match(struct perf_event *e1, struct perf_event *e2)
@@ -5362,40 +5363,20 @@ static void perf_pending_task_sync(struct perf_event *event)
 	rcuwait_wait_event(&event->pending_work_wait, !event->pending_work, TASK_UNINTERRUPTIBLE);
 }
 
-static void _free_event(struct perf_event *event)
+/* vs perf_event_alloc() error */
+static void __free_event(struct perf_event *event)
 {
-	irq_work_sync(&event->pending_irq);
-	irq_work_sync(&event->pending_disable_irq);
-	perf_pending_task_sync(event);
+	if (event->attach_state & PERF_ATTACH_CALLCHAIN)
+		put_callchain_buffers();
 
-	unaccount_event(event);
+	kfree(event->addr_filter_ranges);
 
-	security_perf_event_free(event);
-
-	if (event->rb) {
-		/*
-		 * Can happen when we close an event with re-directed output.
-		 *
-		 * Since we have a 0 refcount, perf_mmap_close() will skip
-		 * over us; possibly making our ring_buffer_put() the last.
-		 */
-		mutex_lock(&event->mmap_mutex);
-		ring_buffer_attach(event, NULL);
-		mutex_unlock(&event->mmap_mutex);
-	}
+	if (event->attach_state & PERF_ATTACH_EXCLUSIVE)
+		exclusive_event_destroy(event);
 
 	if (is_cgroup_event(event))
 		perf_detach_cgroup(event);
 
-	if (!event->parent) {
-		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
-			put_callchain_buffers();
-	}
-
-	perf_event_free_bpf_prog(event);
-	perf_addr_filters_splice(event, NULL);
-	kfree(event->addr_filter_ranges);
-
 	if (event->destroy)
 		event->destroy(event);
 
@@ -5406,22 +5387,58 @@ static void _free_event(struct perf_event *event)
 	if (event->hw.target)
 		put_task_struct(event->hw.target);
 
-	if (event->pmu_ctx)
+	if (event->pmu_ctx) {
+		/*
+		 * put_pmu_ctx() needs an event->ctx reference, because of
+		 * epc->ctx.
+		 */
+		WARN_ON_ONCE(!event->ctx);
+		WARN_ON_ONCE(event->pmu_ctx->ctx != event->ctx);
 		put_pmu_ctx(event->pmu_ctx);
+	}
 
 	/*
-	 * perf_event_free_task() relies on put_ctx() being 'last', in particular
-	 * all task references must be cleaned up.
+	 * perf_event_free_task() relies on put_ctx() being 'last', in
+	 * particular all task references must be cleaned up.
 	 */
 	if (event->ctx)
 		put_ctx(event->ctx);
 
-	exclusive_event_destroy(event);
-	module_put(event->pmu->module);
+	if (event->pmu)
+		module_put(event->pmu->module);
 
 	call_rcu(&event->rcu_head, free_event_rcu);
 }
 
+/* vs perf_event_alloc() success */
+static void _free_event(struct perf_event *event)
+{
+	irq_work_sync(&event->pending_irq);
+	irq_work_sync(&event->pending_disable_irq);
+	perf_pending_task_sync(event);
+
+	unaccount_event(event);
+
+	security_perf_event_free(event);
+
+	if (event->rb) {
+		/*
+		 * Can happen when we close an event with re-directed output.
+		 *
+		 * Since we have a 0 refcount, perf_mmap_close() will skip
+		 * over us; possibly making our ring_buffer_put() the last.
+		 */
+		mutex_lock(&event->mmap_mutex);
+		ring_buffer_attach(event, NULL);
+		mutex_unlock(&event->mmap_mutex);
+	}
+
+	perf_event_free_bpf_prog(event);
+	perf_addr_filters_splice(event, NULL);
+
+	__free_event(event);
+}
+
 /*
  * Used to free events which have a known refcount of 1, such as in error paths
  * where the event isn't exposed yet and inherited events.
@@ -12093,8 +12110,10 @@ static int perf_try_init_event(struct pmu *pmu, struct perf_event *event)
 			event->destroy(event);
 	}
 
-	if (ret)
+	if (ret) {
+		event->pmu = NULL;
 		module_put(pmu->module);
+	}
 
 	return ret;
 }
@@ -12422,7 +12441,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	 * See perf_output_read().
 	 */
 	if (has_inherit_and_sample_read(attr) && !(attr->sample_type & PERF_SAMPLE_TID))
-		goto err_ns;
+		goto err;
 
 	if (!has_branch_stack(event))
 		event->attr.branch_sample_type = 0;
@@ -12430,7 +12449,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	pmu = perf_init_event(event);
 	if (IS_ERR(pmu)) {
 		err = PTR_ERR(pmu);
-		goto err_ns;
+		goto err;
 	}
 
 	/*
@@ -12440,25 +12459,25 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	 */
 	if (pmu->task_ctx_nr == perf_invalid_context && (task || cgroup_fd != -1)) {
 		err = -EINVAL;
-		goto err_pmu;
+		goto err;
 	}
 
 	if (event->attr.aux_output &&
 	    (!(pmu->capabilities & PERF_PMU_CAP_AUX_OUTPUT) ||
 	     event->attr.aux_pause || event->attr.aux_resume)) {
 		err = -EOPNOTSUPP;
-		goto err_pmu;
+		goto err;
 	}
 
 	if (event->attr.aux_pause && event->attr.aux_resume) {
 		err = -EINVAL;
-		goto err_pmu;
+		goto err;
 	}
 
 	if (event->attr.aux_start_paused) {
 		if (!(pmu->capabilities & PERF_PMU_CAP_AUX_PAUSE)) {
 			err = -EOPNOTSUPP;
-			goto err_pmu;
+			goto err;
 		}
 		event->hw.aux_paused = 1;
 	}
@@ -12466,12 +12485,12 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	if (cgroup_fd != -1) {
 		err = perf_cgroup_connect(cgroup_fd, event, attr, group_leader);
 		if (err)
-			goto err_pmu;
+			goto err;
 	}
 
 	err = exclusive_event_init(event);
 	if (err)
-		goto err_pmu;
+		goto err;
 
 	if (has_addr_filter(event)) {
 		event->addr_filter_ranges = kcalloc(pmu->nr_addr_filters,
@@ -12479,7 +12498,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 						    GFP_KERNEL);
 		if (!event->addr_filter_ranges) {
 			err = -ENOMEM;
-			goto err_per_task;
+			goto err;
 		}
 
 		/*
@@ -12504,41 +12523,22 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) {
 			err = get_callchain_buffers(attr->sample_max_stack);
 			if (err)
-				goto err_addr_filters;
+				goto err;
+			event->attach_state |= PERF_ATTACH_CALLCHAIN;
 		}
 	}
 
 	err = security_perf_event_alloc(event);
 	if (err)
-		goto err_callchain_buffer;
+		goto err;
 
 	/* symmetric to unaccount_event() in _free_event() */
 	account_event(event);
 
 	return event;
 
-err_callchain_buffer:
-	if (!event->parent) {
-		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN)
-			put_callchain_buffers();
-	}
-err_addr_filters:
-	kfree(event->addr_filter_ranges);
-
-err_per_task:
-	exclusive_event_destroy(event);
-
-err_pmu:
-	if (is_cgroup_event(event))
-		perf_detach_cgroup(event);
-	if (event->destroy)
-		event->destroy(event);
-	module_put(pmu->module);
-err_ns:
-	if (event->hw.target)
-		put_task_struct(event->hw.target);
-	call_rcu(&event->rcu_head, free_event_rcu);
-
+err:
+	__free_event(event);
 	return ERR_PTR(err);
 }
 

