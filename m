Return-Path: <linux-tip-commits+bounces-4252-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 17DD2A64A3D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 11:37:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A69C81885B25
	for <lists+linux-tip-commits@lfdr.de>; Mon, 17 Mar 2025 10:35:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E68B82376E9;
	Mon, 17 Mar 2025 10:34:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RAsxshu0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4xMPaawM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E17233141;
	Mon, 17 Mar 2025 10:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742207656; cv=none; b=scFljH5ltfEOxIWAXb4v8GuBMuaHEWgHXQmlVr2YwihSu4bd03k831kiOGjIyDYr+WfDFifI9ruWDZlfW8u2HrFCJ7u5JCQAXB1ZeSJ872pyaK82Qo/uGSadQiG2tcT7SDsL1UXfJvreWVATc5sLkqancZrYdLMOfNXCs89o/48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742207656; c=relaxed/simple;
	bh=8er5PQBpkh2BAQCZ0fL5d2ugV9avUOhVFlsGagvjrUA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Fozkmpo3wlFBtRFaf/JDsu0LcP1X25nyBUS/lec6Ug1bv/mcocS0VrR0NwcZiubTqD/pux5PKXADqAN/zv+aE0yaZ46FIJ24HOMBkn2iMgj0vppOcdAKGa27SmzEIhYBLHnSpvmWgnn6ffO8t/PoOAjDdEEVVUpXfYiremHuqKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=RAsxshu0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=4xMPaawM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 17 Mar 2025 10:34:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1742207653;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+kDh7kBX8fh9iHcRmMMFxZ44AC9HMU5JiBEMkF+euxI=;
	b=RAsxshu0TwzuW70H3ADFrX41H0eoph/qkOMCTPpEI+2PHbVraZK0etkJbYL9Eyol9NSkUa
	3cqOlXBQ2kLFnMLHP2unDoAM6rMYobf/Bz9eTEX0jaLT/6Q8NZK2lD+M1MdWJW8yMnhQnZ
	jf1Krv/EgblGbZBVYZMozs4rIYbmFYtxWhEPkTBPn9N2+gLT2FEjSny60goq+WiM/gtTTf
	4xP2xhKEQ7w/jWwwbFkoEOWfEtN8Q8px6m1oi78hwITEgXrjC61A4roanMoKIyePtbEDuC
	kFGpGkLMA0FasoCNRekyeOATw8wyUcRe296pic8GwPH/SYJVBB/JCUKWPyRGAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1742207653;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+kDh7kBX8fh9iHcRmMMFxZ44AC9HMU5JiBEMkF+euxI=;
	b=4xMPaawMcCPFRGrujFLYXVw+nkKdLe5gYl7nul5yPFI313MDgbogoPaatqX5J0YGAMZ2vY
	+aTt3Mdyclhne1Bw==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Save PMU specific data in task_struct
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Alexey Budankov <alexey.budankov@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250314172700.438923-1-kan.liang@linux.intel.com>
References: <20250314172700.438923-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174220765241.14745.4382057489908943831.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     cb4369129339060218baca718a578bb0b826e734
Gitweb:        https://git.kernel.org/tip/cb4369129339060218baca718a578bb0b826e734
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 14 Mar 2025 10:26:54 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 17 Mar 2025 11:23:36 +01:00

perf: Save PMU specific data in task_struct

Some PMU specific data has to be saved/restored during context switch,
e.g. LBR call stack data. Currently, the data is saved in event context
structure, but only for per-process event. For system-wide event,
because of missing the LBR call stack data after context switch, LBR
callstacks are always shorter in comparison to per-process mode.

For example,
  Per-process mode:
  $perf record --call-graph lbr -- taskset -c 0 ./tchain_edit

  -   99.90%    99.86%  tchain_edit  tchain_edit       [.] f3
       99.86% _start
          __libc_start_main
          generic_start_main
          main
          f1
        - f2
             f3

  System-wide mode:
  $perf record --call-graph lbr -a -- taskset -c 0 ./tchain_edit

  -   99.88%    99.82%  tchain_edit  tchain_edit        [.] f3
   - 62.02% main
        f1
        f2
        f3
   - 28.83% f1
      - f2
        f3
   - 28.83% f1
      - f2
           f3
   - 8.88% generic_start_main
        main
        f1
        f2
        f3

It isn't practical to simply allocate the data for system-wide event in
CPU context structure for all tasks. We have no idea which CPU a task
will be scheduled to. The duplicated LBR data has to be maintained on
every CPU context structure. That's a huge waste. Otherwise, the LBR
data still lost if the task is scheduled to another CPU.

Save the pmu specific data in task_struct. The size of pmu specific data
is 788 bytes for LBR call stack. Usually, the overall amount of threads
doesn't exceed a few thousands. For 10K threads, keeping LBR data would
consume additional ~8MB. The additional space will only be allocated
during LBR call stack monitoring. It will be released when the
monitoring is finished.

Furthermore, moving task_ctx_data from perf_event_context to task_struct
can reduce complexity and make things clearer. E.g. perf doesn't need to
swap task_ctx_data on optimized context switch path.
This patch set is just the first step. There could be other
optimization/extension on top of this patch set. E.g. for cgroup
profiling, perf just needs to save/store the LBR call stack information
for tasks in specific cgroup. That could reduce the additional space.
Also, the LBR call stack can be available for software events, or allow
even debugging use cases, like LBRs on crash later.

Because of the alignment requirement of Intel Arch LBR, the Kmem cache
is used to allocate the PMU specific data. It's required when child task
allocates the space. Save it in struct perf_ctx_data.
The refcount in struct perf_ctx_data is used to track the users of pmu
specific data.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Alexey Budankov <alexey.budankov@linux.intel.com>
Link: https://lore.kernel.org/r/20250314172700.438923-1-kan.liang@linux.intel.com
---
 include/linux/perf_event.h | 35 +++++++++++++++++++++++++++++++++++
 include/linux/sched.h      |  2 ++
 kernel/events/core.c       |  1 +
 3 files changed, 38 insertions(+)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 3e27082..75d9b1e 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1021,6 +1021,41 @@ struct perf_event_context {
 	local_t				nr_no_switch_fast;
 };
 
+/**
+ * struct perf_ctx_data - PMU specific data for a task
+ * @rcu_head:  To avoid the race on free PMU specific data
+ * @refcount:  To track users
+ * @global:    To track system-wide users
+ * @ctx_cache: Kmem cache of PMU specific data
+ * @data:      PMU specific data
+ *
+ * Currently, the struct is only used in Intel LBR call stack mode to
+ * save/restore the call stack of a task on context switches.
+ *
+ * The rcu_head is used to prevent the race on free the data.
+ * The data only be allocated when Intel LBR call stack mode is enabled.
+ * The data will be freed when the mode is disabled.
+ * The content of the data will only be accessed in context switch, which
+ * should be protected by rcu_read_lock().
+ *
+ * Because of the alignment requirement of Intel Arch LBR, the Kmem cache
+ * is used to allocate the PMU specific data. The ctx_cache is to track
+ * the Kmem cache.
+ *
+ * Careful: Struct perf_ctx_data is added as a pointer in struct task_struct.
+ * When system-wide Intel LBR call stack mode is enabled, a buffer with
+ * constant size will be allocated for each task.
+ * Also, system memory consumption can further grow when the size of
+ * struct perf_ctx_data enlarges.
+ */
+struct perf_ctx_data {
+	struct rcu_head			rcu_head;
+	refcount_t			refcount;
+	int				global;
+	struct kmem_cache		*ctx_cache;
+	void				*data;
+};
+
 struct perf_cpu_pmu_context {
 	struct perf_event_pmu_context	epc;
 	struct perf_event_pmu_context	*task_epc;
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 9632e33..7e183ee 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -65,6 +65,7 @@ struct mempolicy;
 struct nameidata;
 struct nsproxy;
 struct perf_event_context;
+struct perf_ctx_data;
 struct pid_namespace;
 struct pipe_inode_info;
 struct rcu_node;
@@ -1311,6 +1312,7 @@ struct task_struct {
 	struct perf_event_context	*perf_event_ctxp;
 	struct mutex			perf_event_mutex;
 	struct list_head		perf_event_list;
+	struct perf_ctx_data __rcu	*perf_ctx_data;
 #endif
 #ifdef CONFIG_DEBUG_PREEMPT
 	unsigned long			preempt_disable_ip;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index ace1bcc..20d28b7 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -14070,6 +14070,7 @@ int perf_event_init_task(struct task_struct *child, u64 clone_flags)
 	child->perf_event_ctxp = NULL;
 	mutex_init(&child->perf_event_mutex);
 	INIT_LIST_HEAD(&child->perf_event_list);
+	child->perf_ctx_data = NULL;
 
 	ret = perf_event_init_context(child, clone_flags);
 	if (ret) {

