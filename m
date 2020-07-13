Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC2021843E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  8 Jul 2020 11:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728625AbgGHJv5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 8 Jul 2020 05:51:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:48010 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728660AbgGHJv4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 8 Jul 2020 05:51:56 -0400
Date:   Wed, 08 Jul 2020 09:51:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594201913;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kMKbfOGFEtvyd8U45jdjk/aZBBQAwGanGVZ9xTxWXfU=;
        b=CDTkBkN0UuWBj94afgr0QsAEjtGGmsNQ1z4qrI8cM7yiFbIGlr5Mc7kUQvaCBtG4NPH86c
        rGvbFSTl6zNJagD511bKK5wbHI4NE0Aro5pgb6XUJzXtH/bytrF4E+Y2n1IBvLb2RdYN25
        R4RXNdd8OrOqu3qQfxstf6hDpiFes9r/fTR+4xh4sX+/hepXzdHbZgG8n01DSxxIt0l76O
        Op9QJn9RZag5D5ifD9WvXE2TrFhYvv092u3i7feUuSMhMWYOzw7XtzjOpeH40aQNc4xbhF
        2CbU80B6PUXY5iyuaU7sq+p1DzzPwLlYCZSlSrDEDOxIqJivdehQ38UJJsFLvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594201913;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kMKbfOGFEtvyd8U45jdjk/aZBBQAwGanGVZ9xTxWXfU=;
        b=3pqvOBoYQ/vVzQVE/hUgFd9uWcWbjRGVE3YY+CsN6mJmzVk4DZ4gUXuHMTGkZKzHlagNN0
        gk2P/Xpmuro944CA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/lbr: Use dynamic data structure for task_ctx
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1593780569-62993-7-git-send-email-kan.liang@linux.intel.com>
References: <1593780569-62993-7-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <159420191288.4006.3420651578991456355.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f42be8651a7a9d5cb165e5d176fc0b09621b4f4d
Gitweb:        https://git.kernel.org/tip/f42be8651a7a9d5cb165e5d176fc0b09621b4f4d
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 03 Jul 2020 05:49:12 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 08 Jul 2020 11:38:52 +02:00

perf/x86/intel/lbr: Use dynamic data structure for task_ctx

The type of task_ctx is hardcoded as struct x86_perf_task_context,
which doesn't apply for Architecture LBR. For example, Architecture LBR
doesn't have the TOS MSR. The number of LBR entries is variable. A new
struct will be introduced for Architecture LBR. Perf has to determine
the type of task_ctx at run time.

The type of task_ctx pointer is changed to 'void *', which will be
determined at run time.

The generic LBR optimization can be shared between Architecture LBR and
model-specific LBR. Both need to access the structure for the generic
LBR optimization. A helper task_context_opt() is introduced to retrieve
the pointer of the structure at run time.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1593780569-62993-7-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/lbr.c  | 59 +++++++++++++++--------------------
 arch/x86/events/perf_event.h |  7 +++-
 2 files changed, 32 insertions(+), 34 deletions(-)

diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index bba9939..e62baa9 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -355,18 +355,17 @@ void intel_pmu_lbr_restore(void *ctx)
 		wrmsrl(MSR_LBR_SELECT, task_ctx->lbr_sel);
 }
 
-static __always_inline bool
-lbr_is_reset_in_cstate(struct x86_perf_task_context *task_ctx)
+static __always_inline bool lbr_is_reset_in_cstate(void *ctx)
 {
-	return !rdlbr_from(task_ctx->tos);
+	return !rdlbr_from(((struct x86_perf_task_context *)ctx)->tos);
 }
 
-static void __intel_pmu_lbr_restore(struct x86_perf_task_context *task_ctx)
+static void __intel_pmu_lbr_restore(void *ctx)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	if (task_ctx->opt.lbr_callstack_users == 0 ||
-	    task_ctx->opt.lbr_stack_state == LBR_NONE) {
+	if (task_context_opt(ctx)->lbr_callstack_users == 0 ||
+	    task_context_opt(ctx)->lbr_stack_state == LBR_NONE) {
 		intel_pmu_lbr_reset();
 		return;
 	}
@@ -376,16 +375,16 @@ static void __intel_pmu_lbr_restore(struct x86_perf_task_context *task_ctx)
 	 * - No one else touched them, and
 	 * - Was not cleared in Cstate
 	 */
-	if ((task_ctx == cpuc->last_task_ctx) &&
-	    (task_ctx->opt.log_id == cpuc->last_log_id) &&
-	    !lbr_is_reset_in_cstate(task_ctx)) {
-		task_ctx->opt.lbr_stack_state = LBR_NONE;
+	if ((ctx == cpuc->last_task_ctx) &&
+	    (task_context_opt(ctx)->log_id == cpuc->last_log_id) &&
+	    !lbr_is_reset_in_cstate(ctx)) {
+		task_context_opt(ctx)->lbr_stack_state = LBR_NONE;
 		return;
 	}
 
-	x86_pmu.lbr_restore(task_ctx);
+	x86_pmu.lbr_restore(ctx);
 
-	task_ctx->opt.lbr_stack_state = LBR_NONE;
+	task_context_opt(ctx)->lbr_stack_state = LBR_NONE;
 }
 
 void intel_pmu_lbr_save(void *ctx)
@@ -415,27 +414,27 @@ void intel_pmu_lbr_save(void *ctx)
 		rdmsrl(MSR_LBR_SELECT, task_ctx->lbr_sel);
 }
 
-static void __intel_pmu_lbr_save(struct x86_perf_task_context *task_ctx)
+static void __intel_pmu_lbr_save(void *ctx)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 
-	if (task_ctx->opt.lbr_callstack_users == 0) {
-		task_ctx->opt.lbr_stack_state = LBR_NONE;
+	if (task_context_opt(ctx)->lbr_callstack_users == 0) {
+		task_context_opt(ctx)->lbr_stack_state = LBR_NONE;
 		return;
 	}
 
-	x86_pmu.lbr_save(task_ctx);
+	x86_pmu.lbr_save(ctx);
 
-	task_ctx->opt.lbr_stack_state = LBR_VALID;
+	task_context_opt(ctx)->lbr_stack_state = LBR_VALID;
 
-	cpuc->last_task_ctx = task_ctx;
-	cpuc->last_log_id = ++task_ctx->opt.log_id;
+	cpuc->last_task_ctx = ctx;
+	cpuc->last_log_id = ++task_context_opt(ctx)->log_id;
 }
 
 void intel_pmu_lbr_swap_task_ctx(struct perf_event_context *prev,
 				 struct perf_event_context *next)
 {
-	struct x86_perf_task_context *prev_ctx_data, *next_ctx_data;
+	void *prev_ctx_data, *next_ctx_data;
 
 	swap(prev->task_ctx_data, next->task_ctx_data);
 
@@ -451,14 +450,14 @@ void intel_pmu_lbr_swap_task_ctx(struct perf_event_context *prev,
 	if (!prev_ctx_data || !next_ctx_data)
 		return;
 
-	swap(prev_ctx_data->opt.lbr_callstack_users,
-	     next_ctx_data->opt.lbr_callstack_users);
+	swap(task_context_opt(prev_ctx_data)->lbr_callstack_users,
+	     task_context_opt(next_ctx_data)->lbr_callstack_users);
 }
 
 void intel_pmu_lbr_sched_task(struct perf_event_context *ctx, bool sched_in)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	struct x86_perf_task_context *task_ctx;
+	void *task_ctx;
 
 	if (!cpuc->lbr_users)
 		return;
@@ -495,7 +494,6 @@ static inline bool branch_user_callstack(unsigned br_sel)
 void intel_pmu_lbr_add(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	struct x86_perf_task_context *task_ctx;
 
 	if (!x86_pmu.lbr_nr)
 		return;
@@ -505,10 +503,8 @@ void intel_pmu_lbr_add(struct perf_event *event)
 
 	cpuc->br_sel = event->hw.branch_reg.reg;
 
-	if (branch_user_callstack(cpuc->br_sel) && event->ctx->task_ctx_data) {
-		task_ctx = event->ctx->task_ctx_data;
-		task_ctx->opt.lbr_callstack_users++;
-	}
+	if (branch_user_callstack(cpuc->br_sel) && event->ctx->task_ctx_data)
+		task_context_opt(event->ctx->task_ctx_data)->lbr_callstack_users++;
 
 	/*
 	 * Request pmu::sched_task() callback, which will fire inside the
@@ -539,16 +535,13 @@ void intel_pmu_lbr_add(struct perf_event *event)
 void intel_pmu_lbr_del(struct perf_event *event)
 {
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
-	struct x86_perf_task_context *task_ctx;
 
 	if (!x86_pmu.lbr_nr)
 		return;
 
 	if (branch_user_callstack(cpuc->br_sel) &&
-	    event->ctx->task_ctx_data) {
-		task_ctx = event->ctx->task_ctx_data;
-		task_ctx->opt.lbr_callstack_users--;
-	}
+	    event->ctx->task_ctx_data)
+		task_context_opt(event->ctx->task_ctx_data)->lbr_callstack_users--;
 
 	if (event->hw.flags & PERF_X86_EVENT_LBR_SELECT)
 		cpuc->lbr_select = 0;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 96d73cd..7dbf148 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -247,7 +247,7 @@ struct cpu_hw_events {
 	struct perf_branch_entry	lbr_entries[MAX_LBR_ENTRIES];
 	struct er_account		*lbr_sel;
 	u64				br_sel;
-	struct x86_perf_task_context	*last_task_ctx;
+	void				*last_task_ctx;
 	int				last_log_id;
 	int				lbr_select;
 
@@ -800,6 +800,11 @@ static struct perf_pmu_events_ht_attr event_attr_##v = {		\
 struct pmu *x86_get_pmu(void);
 extern struct x86_pmu x86_pmu __read_mostly;
 
+static __always_inline struct x86_perf_task_context_opt *task_context_opt(void *ctx)
+{
+	return &((struct x86_perf_task_context *)ctx)->opt;
+}
+
 static inline bool x86_pmu_has_lbr_callstack(void)
 {
 	return  x86_pmu.lbr_sel_map &&
