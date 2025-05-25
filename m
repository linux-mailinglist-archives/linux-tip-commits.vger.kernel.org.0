Return-Path: <linux-tip-commits+bounces-5741-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D4C64AC32E7
	for <lists+linux-tip-commits@lfdr.de>; Sun, 25 May 2025 10:14:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 976AE3AE173
	for <lists+linux-tip-commits@lfdr.de>; Sun, 25 May 2025 08:13:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A646C3BBF2;
	Sun, 25 May 2025 08:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iPtKQ2Pj";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dZtRMIvK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DA5BDDBC;
	Sun, 25 May 2025 08:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748160843; cv=none; b=SLRYWPptZ0X6TTJI773oOYz7Bra2JAueryDsESDfSWIK9mcAf2KcYqgHeEC+adpAGJ2tNUNLELyGTkomcRsE0djTeUYA5lG34FM4wGGvVn9kbC2OU78aAkmBILgGVgZk99T6c3eY9aUPLoa91kjprhBWQ4qru2AMi9/y4AymKKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748160843; c=relaxed/simple;
	bh=dIPRMd2IlvGlOKnlln67L0v0VbURlJGuDCWunk9jrHs=;
	h=Date:From:To:Subject:Cc:MIME-Version:Message-ID:Content-Type; b=DIA3uVYSuT4WNTTVQ8R4Fknq297j56uXMk4GppoC6TsGgRjdwc0f8MvuE9oxZIU3DYN27yN4cdeqNZtJ7evpCLhQzEucaobQiluKGZpBti1Q/SldRLNfut32Bo1FpQ+N+9hiB9gyTfInpHYhLYh9BqIascYnto0S0V5SPUOdhRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iPtKQ2Pj; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dZtRMIvK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sun, 25 May 2025 08:13:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1748160833;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=lIbaSQI+wJjPQgsiBf8Bm9Ofyn63M/0Na2ZbMuoJQsg=;
	b=iPtKQ2Pjnr8hhzEyF5827pt4gHMuWmJ7OBE5roPiliLA9gIeCQCy4biBEzqcbTAbvLXG2q
	ZeRDMFaILNF8QLqM3dSaj4DmMMbHZnVy3KH/z/vZYfhFl0Mz8rJ/e/io+cr4M4+w929IMC
	VlU8rCqu+n4zOJULrHu17Ckkqp/wClMrJPghJx2TWmKbrZMWvzt+ECBy053h0KJIbQzofa
	MeW2lD1uNZaajeDAC18r+oK9qDl38J/OsKkU10GnO9aMKeM0cAfJzD5sDyAQC86D1+TC8i
	WO7AZRZRyT4y5b4vtWJnfOa8GPvSHKAGDP5ewDtF/riKmi7GUbHDdFmTULqUrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1748160833;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
	bh=lIbaSQI+wJjPQgsiBf8Bm9Ofyn63M/0Na2ZbMuoJQsg=;
	b=dZtRMIvKpeqTyG4XLAdra7PSfzazLHIBP6GwhD5bXRdyeCWHoHZ1HwMNYBvaO2Vc04se7Z
	Z6IckJBb6TpTVKCA==
From: "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/headers: Clean up <linux/perf_event.h> a bit
Cc: Peter Zijlstra <peterz@infradead.org>,
 Arnaldo Carvalho de Melo <acme@redhat.com>, Jiri Olsa <jolsa@redhat.com>,
 Alexander Shishkin <alexander.shishkin@linux.intel.com>,
 Mark Rutland <mark.rutland@arm.com>, Namhyung Kim <namhyung@kernel.org>,
 Ian Rogers <irogers@google.com>, linux-kernel@vger.kernel.org,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174816083204.406.14746906241136194554.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e7d952cc39fca34386ec9f15f68cb2eaac01b5ae
Gitweb:        https://git.kernel.org/tip/e7d952cc39fca34386ec9f15f68cb2eaac01b5ae
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Sat, 24 May 2025 11:23:25 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sun, 25 May 2025 09:51:56 +02:00

perf/headers: Clean up <linux/perf_event.h> a bit

Do a bit of readability spring cleaning:

 - Fix misaligned structure member in perf_addr_filter: the new
   struct perf_addr_filter::action member was too long, but when
   it was added it was not aligned properly. Align all fields to
   the customary column 41 alignment of most of the rest of the
   header.

 - Adjust the vertical alignment of the definition of other
   structures and definitions as well, so that the 'most of' in
   the previous paragraph changes to 'all of'. ;-)

 - Prettify the assignments in perf_clear_branch_entry_bitfields()

 - Move comments from CPP definitions to outside the macro

 - Move perf_guest_info_callbacks and related defines from the front
   of the header closer to where it's used within the header.

 - And more #endif markers for larger CPP blocks and standardize
   #if/#else/#endif blocks to the following nomenclature:

	#ifdef CONFIG_FOO
	...
	#else /* !CONFIG_FOO: */
	...
	#endif /* !CONFIG_FOO */

 - Standardize on consistently using the 'extern' storage class where
   appropriate, we had cases where method prototypes sometimes omitted
   the storage class:

	extern void perf_pmu_migrate_context(struct pmu *pmu,
					int src_cpu, int dst_cpu);
	int perf_event_read_local(struct perf_event *event, u64 *value,
				  u64 *enabled, u64 *running);
	extern u64 perf_event_read_value(struct perf_event *event,
					 u64 *enabled, u64 *running);

   Which is obviously a bit confusing and adds unnecessary noise.

 - s/__u64/u64 and similar cleanups: there's no point in using __u64
   in non-UAPI headers, and doing so only adds unnecessary visual noise.

 - Harmonize all multi-parameter function prototypes along the following
   style:

	extern struct perf_event *
	perf_event_create_kernel_counter(struct perf_event_attr *attr,
					 int cpu,
					 struct task_struct *task,
					 perf_overflow_handler_t callback,
					 void *context);
 - etc.

Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Ian Rogers <irogers@google.com>
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Ingo Molnar <mingo@kernel.org>
---
 include/linux/perf_event.h | 282 +++++++++++++++++++-----------------
 1 file changed, 155 insertions(+), 127 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index a96c00e..52dc7cf 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -26,18 +26,9 @@
 # include <asm/local64.h>
 #endif
 
-#define PERF_GUEST_ACTIVE	0x01
-#define PERF_GUEST_USER	0x02
-
-struct perf_guest_info_callbacks {
-	unsigned int			(*state)(void);
-	unsigned long			(*get_ip)(void);
-	unsigned int			(*handle_intel_pt_intr)(void);
-};
-
 #ifdef CONFIG_HAVE_HW_BREAKPOINT
-#include <linux/rhashtable-types.h>
-#include <asm/hw_breakpoint.h>
+# include <linux/rhashtable-types.h>
+# include <asm/hw_breakpoint.h>
 #endif
 
 #include <linux/list.h>
@@ -62,19 +53,20 @@ struct perf_guest_info_callbacks {
 #include <linux/security.h>
 #include <linux/static_call.h>
 #include <linux/lockdep.h>
+
 #include <asm/local.h>
 
 struct perf_callchain_entry {
-	__u64				nr;
-	__u64				ip[]; /* /proc/sys/kernel/perf_event_max_stack */
+	u64				nr;
+	u64				ip[]; /* /proc/sys/kernel/perf_event_max_stack */
 };
 
 struct perf_callchain_entry_ctx {
-	struct perf_callchain_entry *entry;
-	u32			    max_stack;
-	u32			    nr;
-	short			    contexts;
-	bool			    contexts_maxed;
+	struct perf_callchain_entry	*entry;
+	u32				max_stack;
+	u32				nr;
+	short				contexts;
+	bool				contexts_maxed;
 };
 
 typedef unsigned long (*perf_copy_f)(void *dst, const void *src,
@@ -121,8 +113,8 @@ static __always_inline bool perf_raw_frag_last(const struct perf_raw_frag *frag)
  * already stored in age order, the hw_idx should be 0.
  */
 struct perf_branch_stack {
-	__u64				nr;
-	__u64				hw_idx;
+	u64				nr;
+	u64				hw_idx;
 	struct perf_branch_entry	entries[];
 };
 
@@ -132,10 +124,10 @@ struct task_struct;
  * extra PMU register associated with an event
  */
 struct hw_perf_event_extra {
-	u64		config;	/* register value */
-	unsigned int	reg;	/* register address or index */
-	int		alloc;	/* extra register already allocated */
-	int		idx;	/* index in shared_regs->regs[] */
+	u64				config;	/* register value */
+	unsigned int			reg;	/* register address or index */
+	int				alloc;	/* extra register already allocated */
+	int				idx;	/* index in shared_regs->regs[] */
 };
 
 /**
@@ -144,8 +136,8 @@ struct hw_perf_event_extra {
  * PERF_EVENT_FLAG_ARCH bits are reserved for architecture-specific
  * usage.
  */
-#define PERF_EVENT_FLAG_ARCH			0x0fffffff
-#define PERF_EVENT_FLAG_USER_READ_CNT		0x80000000
+#define PERF_EVENT_FLAG_ARCH		0x0fffffff
+#define PERF_EVENT_FLAG_USER_READ_CNT	0x80000000
 
 static_assert((PERF_EVENT_FLAG_USER_READ_CNT & PERF_EVENT_FLAG_ARCH) == 0);
 
@@ -227,9 +219,14 @@ struct hw_perf_event {
 /*
  * hw_perf_event::state flags; used to track the PERF_EF_* state.
  */
-#define PERF_HES_STOPPED	0x01 /* the counter is stopped */
-#define PERF_HES_UPTODATE	0x02 /* event->count up-to-date */
-#define PERF_HES_ARCH		0x04
+
+/* the counter is stopped */
+#define PERF_HES_STOPPED		0x01
+
+/* event->count up-to-date */
+#define PERF_HES_UPTODATE		0x02
+
+#define PERF_HES_ARCH			0x04
 
 	int				state;
 
@@ -278,7 +275,7 @@ struct hw_perf_event {
 	 */
 	u64				freq_time_stamp;
 	u64				freq_count_stamp;
-#endif
+#endif /* CONFIG_PERF_EVENTS */
 };
 
 struct perf_event;
@@ -287,29 +284,33 @@ struct perf_event_pmu_context;
 /*
  * Common implementation detail of pmu::{start,commit,cancel}_txn
  */
-#define PERF_PMU_TXN_ADD  0x1		/* txn to add/schedule event on PMU */
-#define PERF_PMU_TXN_READ 0x2		/* txn to read event group from PMU */
+
+/* txn to add/schedule event on PMU */
+#define PERF_PMU_TXN_ADD		0x1
+
+/* txn to read event group from PMU */
+#define PERF_PMU_TXN_READ		0x2
 
 /**
  * pmu::capabilities flags
  */
-#define PERF_PMU_CAP_NO_INTERRUPT		0x0001
-#define PERF_PMU_CAP_NO_NMI			0x0002
-#define PERF_PMU_CAP_AUX_NO_SG			0x0004
-#define PERF_PMU_CAP_EXTENDED_REGS		0x0008
-#define PERF_PMU_CAP_EXCLUSIVE			0x0010
-#define PERF_PMU_CAP_ITRACE			0x0020
-#define PERF_PMU_CAP_NO_EXCLUDE			0x0040
-#define PERF_PMU_CAP_AUX_OUTPUT			0x0080
-#define PERF_PMU_CAP_EXTENDED_HW_TYPE		0x0100
-#define PERF_PMU_CAP_AUX_PAUSE			0x0200
-#define PERF_PMU_CAP_AUX_PREFER_LARGE		0x0400
+#define PERF_PMU_CAP_NO_INTERRUPT	0x0001
+#define PERF_PMU_CAP_NO_NMI		0x0002
+#define PERF_PMU_CAP_AUX_NO_SG		0x0004
+#define PERF_PMU_CAP_EXTENDED_REGS	0x0008
+#define PERF_PMU_CAP_EXCLUSIVE		0x0010
+#define PERF_PMU_CAP_ITRACE		0x0020
+#define PERF_PMU_CAP_NO_EXCLUDE		0x0040
+#define PERF_PMU_CAP_AUX_OUTPUT		0x0080
+#define PERF_PMU_CAP_EXTENDED_HW_TYPE	0x0100
+#define PERF_PMU_CAP_AUX_PAUSE		0x0200
+#define PERF_PMU_CAP_AUX_PREFER_LARGE	0x0400
 
 /**
  * pmu::scope
  */
 enum perf_pmu_scope {
-	PERF_PMU_SCOPE_NONE	= 0,
+	PERF_PMU_SCOPE_NONE = 0,
 	PERF_PMU_SCOPE_CORE,
 	PERF_PMU_SCOPE_DIE,
 	PERF_PMU_SCOPE_CLUSTER,
@@ -393,11 +394,21 @@ struct pmu {
 	 * Flags for ->add()/->del()/ ->start()/->stop(). There are
 	 * matching hw_perf_event::state flags.
 	 */
-#define PERF_EF_START	0x01		/* start the counter when adding    */
-#define PERF_EF_RELOAD	0x02		/* reload the counter when starting */
-#define PERF_EF_UPDATE	0x04		/* update the counter when stopping */
-#define PERF_EF_PAUSE	0x08		/* AUX area event, pause tracing */
-#define PERF_EF_RESUME	0x10		/* AUX area event, resume tracing */
+
+/* start the counter when adding    */
+#define PERF_EF_START			0x01
+
+/* reload the counter when starting */
+#define PERF_EF_RELOAD			0x02
+
+/* update the counter when stopping */
+#define PERF_EF_UPDATE			0x04
+
+/* AUX area event, pause tracing */
+#define PERF_EF_PAUSE			0x08
+
+/* AUX area event, resume tracing */
+#define PERF_EF_RESUME			0x10
 
 	/*
 	 * Adds/Removes a counter to/from the PMU, can be done inside a
@@ -596,10 +607,10 @@ enum perf_addr_filter_action_t {
  * This is a hardware-agnostic filter configuration as specified by the user.
  */
 struct perf_addr_filter {
-	struct list_head	entry;
-	struct path		path;
-	unsigned long		offset;
-	unsigned long		size;
+	struct list_head		entry;
+	struct path			path;
+	unsigned long			offset;
+	unsigned long			size;
 	enum perf_addr_filter_action_t	action;
 };
 
@@ -614,14 +625,14 @@ struct perf_addr_filter {
  * bundled together; see perf_event_addr_filters().
  */
 struct perf_addr_filters_head {
-	struct list_head	list;
-	raw_spinlock_t		lock;
-	unsigned int		nr_file_filters;
+	struct list_head		list;
+	raw_spinlock_t			lock;
+	unsigned int			nr_file_filters;
 };
 
 struct perf_addr_filter_range {
-	unsigned long		start;
-	unsigned long		size;
+	unsigned long			start;
+	unsigned long			size;
 };
 
 /**
@@ -669,24 +680,24 @@ struct swevent_hlist {
 	struct rcu_head			rcu_head;
 };
 
-#define PERF_ATTACH_CONTEXT	0x0001
-#define PERF_ATTACH_GROUP	0x0002
-#define PERF_ATTACH_TASK	0x0004
-#define PERF_ATTACH_TASK_DATA	0x0008
-#define PERF_ATTACH_GLOBAL_DATA	0x0010
-#define PERF_ATTACH_SCHED_CB	0x0020
-#define PERF_ATTACH_CHILD	0x0040
-#define PERF_ATTACH_EXCLUSIVE	0x0080
-#define PERF_ATTACH_CALLCHAIN	0x0100
-#define PERF_ATTACH_ITRACE	0x0200
+#define PERF_ATTACH_CONTEXT		0x0001
+#define PERF_ATTACH_GROUP		0x0002
+#define PERF_ATTACH_TASK		0x0004
+#define PERF_ATTACH_TASK_DATA		0x0008
+#define PERF_ATTACH_GLOBAL_DATA		0x0010
+#define PERF_ATTACH_SCHED_CB		0x0020
+#define PERF_ATTACH_CHILD		0x0040
+#define PERF_ATTACH_EXCLUSIVE		0x0080
+#define PERF_ATTACH_CALLCHAIN		0x0100
+#define PERF_ATTACH_ITRACE		0x0200
 
 struct bpf_prog;
 struct perf_cgroup;
 struct perf_buffer;
 
 struct pmu_event_list {
-	raw_spinlock_t		lock;
-	struct list_head	list;
+	raw_spinlock_t			lock;
+	struct list_head		list;
 };
 
 /*
@@ -696,12 +707,12 @@ struct pmu_event_list {
  * disabled is sufficient since it will hold-off the IPIs.
  */
 #ifdef CONFIG_PROVE_LOCKING
-#define lockdep_assert_event_ctx(event)				\
+# define lockdep_assert_event_ctx(event)			\
 	WARN_ON_ONCE(__lockdep_enabled &&			\
 		     (this_cpu_read(hardirqs_enabled) &&	\
 		      lockdep_is_held(&(event)->ctx->mutex) != LOCK_STATE_HELD))
 #else
-#define lockdep_assert_event_ctx(event)
+# define lockdep_assert_event_ctx(event)
 #endif
 
 #define for_each_sibling_event(sibling, event)			\
@@ -859,9 +870,9 @@ struct perf_event {
 #ifdef CONFIG_EVENT_TRACING
 	struct trace_event_call		*tp_event;
 	struct event_filter		*filter;
-#ifdef CONFIG_FUNCTION_TRACER
+# ifdef CONFIG_FUNCTION_TRACER
 	struct ftrace_ops               ftrace_ops;
-#endif
+# endif
 #endif
 
 #ifdef CONFIG_CGROUP_PERF
@@ -880,7 +891,7 @@ struct perf_event {
 	 * of it. event->orig_type contains original 'type' requested by
 	 * user.
 	 */
-	__u32				orig_type;
+	u32				orig_type;
 #endif /* CONFIG_PERF_EVENTS */
 };
 
@@ -945,8 +956,8 @@ static inline bool perf_pmu_ctx_is_active(struct perf_event_pmu_context *epc)
 }
 
 struct perf_event_groups {
-	struct rb_root	tree;
-	u64		index;
+	struct rb_root			tree;
+	u64				index;
 };
 
 
@@ -1189,16 +1200,18 @@ extern void perf_pmu_resched(struct pmu *pmu);
 extern int perf_event_refresh(struct perf_event *event, int refresh);
 extern void perf_event_update_userpage(struct perf_event *event);
 extern int perf_event_release_kernel(struct perf_event *event);
+
 extern struct perf_event *
 perf_event_create_kernel_counter(struct perf_event_attr *attr,
-				int cpu,
-				struct task_struct *task,
-				perf_overflow_handler_t callback,
-				void *context);
+				 int cpu,
+				 struct task_struct *task,
+				 perf_overflow_handler_t callback,
+				 void *context);
+
 extern void perf_pmu_migrate_context(struct pmu *pmu,
-				int src_cpu, int dst_cpu);
-int perf_event_read_local(struct perf_event *event, u64 *value,
-			  u64 *enabled, u64 *running);
+				     int src_cpu, int dst_cpu);
+extern int perf_event_read_local(struct perf_event *event, u64 *value,
+				 u64 *enabled, u64 *running);
 extern u64 perf_event_read_value(struct perf_event *event,
 				 u64 *enabled, u64 *running);
 
@@ -1415,14 +1428,14 @@ static inline u32 perf_sample_data_size(struct perf_sample_data *data,
  */
 static inline void perf_clear_branch_entry_bitfields(struct perf_branch_entry *br)
 {
-	br->mispred = 0;
-	br->predicted = 0;
-	br->in_tx = 0;
-	br->abort = 0;
-	br->cycles = 0;
-	br->type = 0;
-	br->spec = PERF_BR_SPEC_NA;
-	br->reserved = 0;
+	br->mispred	= 0;
+	br->predicted	= 0;
+	br->in_tx	= 0;
+	br->abort	= 0;
+	br->cycles	= 0;
+	br->type	= 0;
+	br->spec	= PERF_BR_SPEC_NA;
+	br->reserved	= 0;
 }
 
 extern void perf_output_sample(struct perf_output_handle *handle,
@@ -1611,7 +1624,17 @@ extern void perf_event_bpf_event(struct bpf_prog *prog,
 				 enum perf_bpf_event_type type,
 				 u16 flags);
 
+#define PERF_GUEST_ACTIVE		0x01
+#define PERF_GUEST_USER			0x02
+
+struct perf_guest_info_callbacks {
+	unsigned int			(*state)(void);
+	unsigned long			(*get_ip)(void);
+	unsigned int			(*handle_intel_pt_intr)(void);
+};
+
 #ifdef CONFIG_GUEST_PERF_EVENTS
+
 extern struct perf_guest_info_callbacks __rcu *perf_guest_cbs;
 
 DECLARE_STATIC_CALL(__perf_guest_state, *perf_guest_cbs->state);
@@ -1622,21 +1645,27 @@ static inline unsigned int perf_guest_state(void)
 {
 	return static_call(__perf_guest_state)();
 }
+
 static inline unsigned long perf_guest_get_ip(void)
 {
 	return static_call(__perf_guest_get_ip)();
 }
+
 static inline unsigned int perf_guest_handle_intel_pt_intr(void)
 {
 	return static_call(__perf_guest_handle_intel_pt_intr)();
 }
+
 extern void perf_register_guest_info_callbacks(struct perf_guest_info_callbacks *cbs);
 extern void perf_unregister_guest_info_callbacks(struct perf_guest_info_callbacks *cbs);
-#else
+
+#else /* !CONFIG_GUEST_PERF_EVENTS: */
+
 static inline unsigned int perf_guest_state(void)		 { return 0; }
 static inline unsigned long perf_guest_get_ip(void)		 { return 0; }
 static inline unsigned int perf_guest_handle_intel_pt_intr(void) { return 0; }
-#endif /* CONFIG_GUEST_PERF_EVENTS */
+
+#endif /* !CONFIG_GUEST_PERF_EVENTS */
 
 extern void perf_event_exec(void);
 extern void perf_event_comm(struct task_struct *tsk, bool exec);
@@ -1666,6 +1695,7 @@ static inline int perf_callchain_store_context(struct perf_callchain_entry_ctx *
 {
 	if (ctx->contexts < sysctl_perf_event_max_contexts_per_stack) {
 		struct perf_callchain_entry *entry = ctx->entry;
+
 		entry->ip[entry->nr++] = ip;
 		++ctx->contexts;
 		return 0;
@@ -1679,6 +1709,7 @@ static inline int perf_callchain_store(struct perf_callchain_entry_ctx *ctx, u64
 {
 	if (ctx->nr < ctx->max_stack && !ctx->contexts_maxed) {
 		struct perf_callchain_entry *entry = ctx->entry;
+
 		entry->ip[entry->nr++] = ip;
 		++ctx->nr;
 		return 0;
@@ -1705,7 +1736,7 @@ static inline int perf_is_paranoid(void)
 	return sysctl_perf_event_paranoid > -1;
 }
 
-int perf_allow_kernel(void);
+extern int perf_allow_kernel(void);
 
 static inline int perf_allow_cpu(void)
 {
@@ -1827,7 +1858,7 @@ extern int perf_output_begin_backward(struct perf_output_handle *handle,
 
 extern void perf_output_end(struct perf_output_handle *handle);
 extern unsigned int perf_output_copy(struct perf_output_handle *handle,
-			     const void *buf, unsigned int len);
+				     const void *buf, unsigned int len);
 extern unsigned int perf_output_skip(struct perf_output_handle *handle,
 				     unsigned int len);
 extern long perf_output_copy_aux(struct perf_output_handle *aux_handle,
@@ -1844,7 +1875,9 @@ extern void perf_event_task_tick(void);
 extern int perf_event_account_interrupt(struct perf_event *event);
 extern int perf_event_period(struct perf_event *event, u64 value);
 extern u64 perf_event_pause(struct perf_event *event, bool reset);
+
 #else /* !CONFIG_PERF_EVENTS: */
+
 static inline void *
 perf_aux_output_begin(struct perf_output_handle *handle,
 		      struct perf_event *event)				{ return NULL; }
@@ -1922,19 +1955,14 @@ static inline void perf_event_disable(struct perf_event *event)		{ }
 static inline int __perf_event_disable(void *info)			{ return -1; }
 static inline void perf_event_task_tick(void)				{ }
 static inline int perf_event_release_kernel(struct perf_event *event)	{ return 0; }
-static inline int perf_event_period(struct perf_event *event, u64 value)
-{
-	return -EINVAL;
-}
-static inline u64 perf_event_pause(struct perf_event *event, bool reset)
-{
-	return 0;
-}
-static inline int perf_exclude_event(struct perf_event *event, struct pt_regs *regs)
-{
-	return 0;
-}
-#endif
+static inline int
+perf_event_period(struct perf_event *event, u64 value)			{ return -EINVAL; }
+static inline u64
+perf_event_pause(struct perf_event *event, bool reset)			{ return 0; }
+static inline int
+perf_exclude_event(struct perf_event *event, struct pt_regs *regs)	{ return 0; }
+
+#endif /* !CONFIG_PERF_EVENTS */
 
 #if defined(CONFIG_PERF_EVENTS) && defined(CONFIG_CPU_SUP_INTEL)
 extern void perf_restore_debug_store(void);
@@ -1942,31 +1970,31 @@ extern void perf_restore_debug_store(void);
 static inline void perf_restore_debug_store(void)			{ }
 #endif
 
-#define perf_output_put(handle, x) perf_output_copy((handle), &(x), sizeof(x))
+#define perf_output_put(handle, x)	perf_output_copy((handle), &(x), sizeof(x))
 
 struct perf_pmu_events_attr {
-	struct device_attribute attr;
-	u64 id;
-	const char *event_str;
+	struct device_attribute		attr;
+	u64				id;
+	const char			*event_str;
 };
 
 struct perf_pmu_events_ht_attr {
-	struct device_attribute			attr;
-	u64					id;
-	const char				*event_str_ht;
-	const char				*event_str_noht;
+	struct device_attribute		attr;
+	u64				id;
+	const char			*event_str_ht;
+	const char			*event_str_noht;
 };
 
 struct perf_pmu_events_hybrid_attr {
-	struct device_attribute			attr;
-	u64					id;
-	const char				*event_str;
-	u64					pmu_type;
+	struct device_attribute		attr;
+	u64				id;
+	const char			*event_str;
+	u64				pmu_type;
 };
 
 struct perf_pmu_format_hybrid_attr {
-	struct device_attribute			attr;
-	u64					pmu_type;
+	struct device_attribute		attr;
+	u64				pmu_type;
 };
 
 ssize_t perf_event_sysfs_show(struct device *dev, struct device_attribute *attr,
@@ -2008,11 +2036,11 @@ static struct device_attribute format_attr_##_name = __ATTR_RO(_name)
 
 /* Performance counter hotplug functions */
 #ifdef CONFIG_PERF_EVENTS
-int perf_event_init_cpu(unsigned int cpu);
-int perf_event_exit_cpu(unsigned int cpu);
+extern int perf_event_init_cpu(unsigned int cpu);
+extern int perf_event_exit_cpu(unsigned int cpu);
 #else
-#define perf_event_init_cpu	NULL
-#define perf_event_exit_cpu	NULL
+# define perf_event_init_cpu		NULL
+# define perf_event_exit_cpu		NULL
 #endif
 
 extern void arch_perf_update_userpage(struct perf_event *event,

