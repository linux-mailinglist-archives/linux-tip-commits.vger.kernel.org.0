Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB34C30BD89
	for <lists+linux-tip-commits@lfdr.de>; Tue,  2 Feb 2021 12:59:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbhBBL6G (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 2 Feb 2021 06:58:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230094AbhBBL5r (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 2 Feb 2021 06:57:47 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8C67C0613ED;
        Tue,  2 Feb 2021 03:57:06 -0800 (PST)
Date:   Tue, 02 Feb 2021 11:57:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612267025;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BTqhzy0swtGTcFRqZ45syccKiKLrZke2fR2cwC4GAMc=;
        b=smUrQ5YKVEVj3ePS1WtppI3DPeKht8rV9cvFdwA+H74cyzOM+H/Q+a5CZ0xNrHY7E2lta9
        fpizs7D/qRc1jMsRS+sQNJD7IOQ3kZTdFM2kiPuJzW9gxfAUZnJXRP6X7ymtNsQSJWWLN4
        VE82TZumcdVLq1XvxsMGzjR3X4rx8KD2fmzfryx3AICMvp/T5TijxjBkqo178O6Rb1B2Kr
        e1+fUCCKk/qZaqyG3feQ4PUNdA/rnCsIZKOII8FLIZjzGF5tdqcwWrLbuv8THTXWjZh6xa
        7YeWoXAk7po4dYZFTU80KVw/q1Fc7E8vYdMlMwt+DSMz3Mq95I2RLWj315FCAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612267025;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BTqhzy0swtGTcFRqZ45syccKiKLrZke2fR2cwC4GAMc=;
        b=heBKAZKfsvWym14smtSjbdeVExtcNZqm+yKzN1rpTfBRPCCplhDlr336tJJFR5P7qcnA0S
        mPIQ9TKmNWdb3UCQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Add PERF_SAMPLE_WEIGHT_STRUCT
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1611873611-156687-2-git-send-email-kan.liang@linux.intel.com>
References: <1611873611-156687-2-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161226702451.23325.12333875715789285602.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     2a6c6b7d7ad346f0679d0963cb19b3f0ea7ef32c
Gitweb:        https://git.kernel.org/tip/2a6c6b7d7ad346f0679d0963cb19b3f0ea7ef32c
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 28 Jan 2021 14:40:07 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 01 Feb 2021 15:31:36 +01:00

perf/core: Add PERF_SAMPLE_WEIGHT_STRUCT

Current PERF_SAMPLE_WEIGHT sample type is very useful to expresses the
cost of an action represented by the sample. This allows the profiler
to scale the samples to be more informative to the programmer. It could
also help to locate a hotspot, e.g., when profiling by memory latencies,
the expensive load appear higher up in the histograms. But current
PERF_SAMPLE_WEIGHT sample type is solely determined by one factor. This
could be a problem, if users want two or more factors to contribute to
the weight. For example, Golden Cove core PMU can provide both the
instruction latency and the cache Latency information as factors for the
memory profiling.

For current X86 platforms, although meminfo::latency is defined as a
u64, only the lower 32 bits include the valid data in practice (No
memory access could last than 4G cycles). The higher 32 bits can be used
to store new factors.

Add a new sample type, PERF_SAMPLE_WEIGHT_STRUCT, to indicate the new
sample weight structure. It shares the same space as the
PERF_SAMPLE_WEIGHT sample type.

Users can apply either the PERF_SAMPLE_WEIGHT sample type or the
PERF_SAMPLE_WEIGHT_STRUCT sample type to retrieve the sample weight, but
they cannot apply both sample types simultaneously.

Currently, only X86 and PowerPC use the PERF_SAMPLE_WEIGHT sample type.
- For PowerPC, there is nothing changed for the PERF_SAMPLE_WEIGHT
  sample type. There is no effect for the new PERF_SAMPLE_WEIGHT_STRUCT
  sample type. PowerPC can re-struct the weight field similarly later.
- For X86, the same value will be dumped for the PERF_SAMPLE_WEIGHT
  sample type or the PERF_SAMPLE_WEIGHT_STRUCT sample type for now.
  The following patches will apply the new factors for the
  PERF_SAMPLE_WEIGHT_STRUCT sample type.

The field in the union perf_sample_weight should be shared among
different architectures. A generic name is required, but it's hard to
abstract a name that applies to all architectures. For example, on X86,
the fields are to store all kinds of latency. While on PowerPC, it
stores MMCRA[TECX/TECM], which should not be latency. So a general name
prefix 'var$NUM' is used here.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1611873611-156687-2-git-send-email-kan.liang@linux.intel.com
---
 arch/powerpc/perf/core-book3s.c |  2 +-
 arch/x86/events/intel/ds.c      | 17 ++++++-------
 include/linux/perf_event.h      |  4 +--
 include/uapi/linux/perf_event.h | 42 ++++++++++++++++++++++++++++++--
 kernel/events/core.c            | 11 +++++---
 5 files changed, 59 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 28206b1..869d999 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2195,7 +2195,7 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 
 		if (event->attr.sample_type & PERF_SAMPLE_WEIGHT &&
 						ppmu->get_mem_weight)
-			ppmu->get_mem_weight(&data.weight);
+			ppmu->get_mem_weight(&data.weight.full);
 
 		if (perf_event_overflow(event, &data, regs))
 			power_pmu_stop(event, 0);
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 67dbc91..2f54b1f 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -960,7 +960,8 @@ static void adaptive_pebs_record_size_update(void)
 }
 
 #define PERF_PEBS_MEMINFO_TYPE	(PERF_SAMPLE_ADDR | PERF_SAMPLE_DATA_SRC |   \
-				PERF_SAMPLE_PHYS_ADDR | PERF_SAMPLE_WEIGHT | \
+				PERF_SAMPLE_PHYS_ADDR |			     \
+				PERF_SAMPLE_WEIGHT_TYPE |		     \
 				PERF_SAMPLE_TRANSACTION |		     \
 				PERF_SAMPLE_DATA_PAGE_SIZE)
 
@@ -987,7 +988,7 @@ static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 	gprs = (sample_type & PERF_SAMPLE_REGS_INTR) &&
 	       (attr->sample_regs_intr & PEBS_GP_REGS);
 
-	tsx_weight = (sample_type & PERF_SAMPLE_WEIGHT) &&
+	tsx_weight = (sample_type & PERF_SAMPLE_WEIGHT_TYPE) &&
 		     ((attr->config & INTEL_ARCH_EVENT_MASK) ==
 		      x86_pmu.rtm_abort_event);
 
@@ -1369,8 +1370,8 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 	/*
 	 * Use latency for weight (only avail with PEBS-LL)
 	 */
-	if (fll && (sample_type & PERF_SAMPLE_WEIGHT))
-		data->weight = pebs->lat;
+	if (fll && (sample_type & PERF_SAMPLE_WEIGHT_TYPE))
+		data->weight.full = pebs->lat;
 
 	/*
 	 * data.data_src encodes the data source
@@ -1462,8 +1463,8 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 
 	if (x86_pmu.intel_cap.pebs_format >= 2) {
 		/* Only set the TSX weight when no memory weight. */
-		if ((sample_type & PERF_SAMPLE_WEIGHT) && !fll)
-			data->weight = intel_get_tsx_weight(pebs->tsx_tuning);
+		if ((sample_type & PERF_SAMPLE_WEIGHT_TYPE) && !fll)
+			data->weight.full = intel_get_tsx_weight(pebs->tsx_tuning);
 
 		if (sample_type & PERF_SAMPLE_TRANSACTION)
 			data->txn = intel_get_tsx_transaction(pebs->tsx_tuning,
@@ -1577,8 +1578,8 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 	}
 
 	if (format_size & PEBS_DATACFG_MEMINFO) {
-		if (sample_type & PERF_SAMPLE_WEIGHT)
-			data->weight = meminfo->latency ?:
+		if (sample_type & PERF_SAMPLE_WEIGHT_TYPE)
+			data->weight.full = meminfo->latency ?:
 				intel_get_tsx_weight(meminfo->tsx_tuning);
 
 		if (sample_type & PERF_SAMPLE_DATA_SRC)
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 9a38f57..fab42cf 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -998,7 +998,7 @@ struct perf_sample_data {
 	struct perf_raw_record		*raw;
 	struct perf_branch_stack	*br_stack;
 	u64				period;
-	u64				weight;
+	union perf_sample_weight	weight;
 	u64				txn;
 	union  perf_mem_data_src	data_src;
 
@@ -1047,7 +1047,7 @@ static inline void perf_sample_data_init(struct perf_sample_data *data,
 	data->raw  = NULL;
 	data->br_stack = NULL;
 	data->period = period;
-	data->weight = 0;
+	data->weight.full = 0;
 	data->data_src.val = PERF_MEM_NA;
 	data->txn = 0;
 }
diff --git a/include/uapi/linux/perf_event.h b/include/uapi/linux/perf_event.h
index b15e344..b2cc246 100644
--- a/include/uapi/linux/perf_event.h
+++ b/include/uapi/linux/perf_event.h
@@ -145,12 +145,14 @@ enum perf_event_sample_format {
 	PERF_SAMPLE_CGROUP			= 1U << 21,
 	PERF_SAMPLE_DATA_PAGE_SIZE		= 1U << 22,
 	PERF_SAMPLE_CODE_PAGE_SIZE		= 1U << 23,
+	PERF_SAMPLE_WEIGHT_STRUCT		= 1U << 24,
 
-	PERF_SAMPLE_MAX = 1U << 24,		/* non-ABI */
+	PERF_SAMPLE_MAX = 1U << 25,		/* non-ABI */
 
 	__PERF_SAMPLE_CALLCHAIN_EARLY		= 1ULL << 63, /* non-ABI; internal use */
 };
 
+#define PERF_SAMPLE_WEIGHT_TYPE	(PERF_SAMPLE_WEIGHT | PERF_SAMPLE_WEIGHT_STRUCT)
 /*
  * values to program into branch_sample_type when PERF_SAMPLE_BRANCH is set
  *
@@ -890,7 +892,24 @@ enum perf_event_type {
 	 * 	  char			data[size];
 	 * 	  u64			dyn_size; } && PERF_SAMPLE_STACK_USER
 	 *
-	 *	{ u64			weight;   } && PERF_SAMPLE_WEIGHT
+	 *	{ union perf_sample_weight
+	 *	 {
+	 *		u64		full; && PERF_SAMPLE_WEIGHT
+	 *	#if defined(__LITTLE_ENDIAN_BITFIELD)
+	 *		struct {
+	 *			u32	var1_dw;
+	 *			u16	var2_w;
+	 *			u16	var3_w;
+	 *		} && PERF_SAMPLE_WEIGHT_STRUCT
+	 *	#elif defined(__BIG_ENDIAN_BITFIELD)
+	 *		struct {
+	 *			u16	var3_w;
+	 *			u16	var2_w;
+	 *			u32	var1_dw;
+	 *		} && PERF_SAMPLE_WEIGHT_STRUCT
+	 *	#endif
+	 *	 }
+	 *	}
 	 *	{ u64			data_src; } && PERF_SAMPLE_DATA_SRC
 	 *	{ u64			transaction; } && PERF_SAMPLE_TRANSACTION
 	 *	{ u64			abi; # enum perf_sample_regs_abi
@@ -1248,4 +1267,23 @@ struct perf_branch_entry {
 		reserved:40;
 };
 
+union perf_sample_weight {
+	__u64		full;
+#if defined(__LITTLE_ENDIAN_BITFIELD)
+	struct {
+		__u32	var1_dw;
+		__u16	var2_w;
+		__u16	var3_w;
+	};
+#elif defined(__BIG_ENDIAN_BITFIELD)
+	struct {
+		__u16	var3_w;
+		__u16	var2_w;
+		__u32	var1_dw;
+	};
+#else
+#error "Unknown endianness"
+#endif
+};
+
 #endif /* _UAPI_LINUX_PERF_EVENT_H */
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 55d1879..5206097 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1879,8 +1879,8 @@ static void __perf_event_header_size(struct perf_event *event, u64 sample_type)
 	if (sample_type & PERF_SAMPLE_PERIOD)
 		size += sizeof(data->period);
 
-	if (sample_type & PERF_SAMPLE_WEIGHT)
-		size += sizeof(data->weight);
+	if (sample_type & PERF_SAMPLE_WEIGHT_TYPE)
+		size += sizeof(data->weight.full);
 
 	if (sample_type & PERF_SAMPLE_READ)
 		size += event->read_size;
@@ -6907,8 +6907,8 @@ void perf_output_sample(struct perf_output_handle *handle,
 					  data->regs_user.regs);
 	}
 
-	if (sample_type & PERF_SAMPLE_WEIGHT)
-		perf_output_put(handle, data->weight);
+	if (sample_type & PERF_SAMPLE_WEIGHT_TYPE)
+		perf_output_put(handle, data->weight.full);
 
 	if (sample_type & PERF_SAMPLE_DATA_SRC)
 		perf_output_put(handle, data->data_src.val);
@@ -11564,6 +11564,9 @@ static int perf_copy_attr(struct perf_event_attr __user *uattr,
 	if (attr->sample_type & PERF_SAMPLE_CGROUP)
 		return -EINVAL;
 #endif
+	if ((attr->sample_type & PERF_SAMPLE_WEIGHT) &&
+	    (attr->sample_type & PERF_SAMPLE_WEIGHT_STRUCT))
+		return -EINVAL;
 
 out:
 	return ret;
