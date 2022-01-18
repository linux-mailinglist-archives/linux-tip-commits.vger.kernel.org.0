Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32AD6492481
	for <lists+linux-tip-commits@lfdr.de>; Tue, 18 Jan 2022 12:18:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239351AbiARLR4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 18 Jan 2022 06:17:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40482 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239234AbiARLRy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 18 Jan 2022 06:17:54 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E80E2C06161C;
        Tue, 18 Jan 2022 03:17:53 -0800 (PST)
Date:   Tue, 18 Jan 2022 11:17:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1642504672;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lf5HEBqdMy/A1LTAzm0duZYsJsmofxMm6iJlBZ4YxIg=;
        b=eFr7LtAMWTGnbAMi/m8FCpmi6NPml7YquqNXME7byniGXhbony8sTjK5meBb3vuNUR/9xL
        cEUX6eQfMxx3703gTVHIu+IXRhAbpZ/1q0PjYGCUEFPq3B3XlMLP/uUjzRHLKOt+g4f4o0
        QHbLhqpHjSJyoU2/fPSKuFJ0Jy6IDpmkWpf9V+vFmVUrLacdFMAGyQxJf8NoMFwS+gzxDk
        7PiAfsb782hmA1jfhldItV37nZFceAs+Zygw4yxdUU8n5uAUDCdZ1ZyRoajgaO5DizOBmZ
        NspMuEyxruWT1SdM6B6JLACaZPRBXQ86K7DKSAYbVmYYJM35x7Fu6hAXMphTtA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1642504672;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lf5HEBqdMy/A1LTAzm0duZYsJsmofxMm6iJlBZ4YxIg=;
        b=pgLzIWjKsLFbigEWXBwaTFP2uQZrMRn2TyMWvWGf9wEeKQmhblGdI3iAwmAXVtqfbLyiYb
        VmVBtF0C70b/GvCQ==
From:   "tip-bot2 for Peter Zijlstra (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel/lbr: Support LBR format V7
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1641315077-96661-1-git-send-email-peterz@infradead.org>
References: <1641315077-96661-1-git-send-email-peterz@infradead.org>
MIME-Version: 1.0
Message-ID: <164250467157.16921.4840042202249745824.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     1ac7fd8159a842b3aa51f0b46a351fa3eeb8fbf3
Gitweb:        https://git.kernel.org/tip/1ac7fd8159a842b3aa51f0b46a351fa3eeb8fbf3
Author:        Peter Zijlstra (Intel) <peterz@infradead.org>
AuthorDate:    Tue, 04 Jan 2022 08:51:16 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 18 Jan 2022 12:09:48 +01:00

perf/x86/intel/lbr: Support LBR format V7

The Goldmont plus and Tremont have LBR format V7. The V7 has LBR_INFO,
which is the same as LBR format V5. But V7 doesn't support TSX.

Without the patch, the associated misprediction and cycles information
in the LBR_INFO may be lost on a Goldmont plus platform.
For Tremont, the patch only impacts the non-PEBS events. Because of the
adaptive PEBS, the LBR_INFO is always processed for a PEBS event.

Currently, two different ways are used to check the LBR capabilities,
which make the codes complex and confusing.
For the LBR format V4 and earlier, the global static lbr_desc array is
used to store the flags for the LBR capabilities in each LBR format.
For LBR format V5 and V6, the current code checks the version number
for the LBR capabilities.

There are common LBR capabilities among LBR format versions. Several
flags for the LBR capabilities are introduced into the struct x86_pmu.
The flags, which can be shared among LBR formats, are used to check
the LBR capabilities. Add intel_pmu_lbr_init() to set the flags
accordingly at boot time.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Kan Liang <kan.liang@linux.intel.com>
Link: https://lkml.kernel.org/r/1641315077-96661-1-git-send-email-peterz@infradead.org
---
 arch/x86/events/intel/core.c |   2 +-
 arch/x86/events/intel/lbr.c  | 114 +++++++++++++++++++---------------
 arch/x86/events/perf_event.h |  10 ++-
 3 files changed, 75 insertions(+), 51 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index d5f940c..c914340 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6353,6 +6353,8 @@ __init int intel_pmu_init(void)
 	}
 
 	if (x86_pmu.lbr_nr) {
+		intel_pmu_lbr_init();
+
 		pr_cont("%d-deep LBR, ", x86_pmu.lbr_nr);
 
 		/* only support branch_stack snapshot for perfmon >= v2 */
diff --git a/arch/x86/events/intel/lbr.c b/arch/x86/events/intel/lbr.c
index 8043213..b7228a1 100644
--- a/arch/x86/events/intel/lbr.c
+++ b/arch/x86/events/intel/lbr.c
@@ -8,14 +8,6 @@
 
 #include "../perf_event.h"
 
-static const enum {
-	LBR_EIP_FLAGS		= 1,
-	LBR_TSX			= 2,
-} lbr_desc[LBR_FORMAT_MAX_KNOWN + 1] = {
-	[LBR_FORMAT_EIP_FLAGS]  = LBR_EIP_FLAGS,
-	[LBR_FORMAT_EIP_FLAGS2] = LBR_EIP_FLAGS | LBR_TSX,
-};
-
 /*
  * Intel LBR_SELECT bits
  * Intel Vol3a, April 2011, Section 16.7 Table 16-10
@@ -243,7 +235,7 @@ void intel_pmu_lbr_reset_64(void)
 	for (i = 0; i < x86_pmu.lbr_nr; i++) {
 		wrmsrl(x86_pmu.lbr_from + i, 0);
 		wrmsrl(x86_pmu.lbr_to   + i, 0);
-		if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO)
+		if (x86_pmu.lbr_has_info)
 			wrmsrl(x86_pmu.lbr_info + i, 0);
 	}
 }
@@ -305,11 +297,10 @@ enum {
  */
 static inline bool lbr_from_signext_quirk_needed(void)
 {
-	int lbr_format = x86_pmu.intel_cap.lbr_format;
 	bool tsx_support = boot_cpu_has(X86_FEATURE_HLE) ||
 			   boot_cpu_has(X86_FEATURE_RTM);
 
-	return !tsx_support && (lbr_desc[lbr_format] & LBR_TSX);
+	return !tsx_support && x86_pmu.lbr_has_tsx;
 }
 
 static DEFINE_STATIC_KEY_FALSE(lbr_from_quirk_key);
@@ -427,12 +418,12 @@ rdlbr_all(struct lbr_entry *lbr, unsigned int idx, bool need_info)
 
 void intel_pmu_lbr_restore(void *ctx)
 {
-	bool need_info = x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO;
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct x86_perf_task_context *task_ctx = ctx;
-	int i;
-	unsigned lbr_idx, mask;
+	bool need_info = x86_pmu.lbr_has_info;
 	u64 tos = task_ctx->tos;
+	unsigned lbr_idx, mask;
+	int i;
 
 	mask = x86_pmu.lbr_nr - 1;
 	for (i = 0; i < task_ctx->valid_lbrs; i++) {
@@ -444,7 +435,7 @@ void intel_pmu_lbr_restore(void *ctx)
 		lbr_idx = (tos - i) & mask;
 		wrlbr_from(lbr_idx, 0);
 		wrlbr_to(lbr_idx, 0);
-		if (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO)
+		if (need_info)
 			wrlbr_info(lbr_idx, 0);
 	}
 
@@ -519,9 +510,9 @@ static void __intel_pmu_lbr_restore(void *ctx)
 
 void intel_pmu_lbr_save(void *ctx)
 {
-	bool need_info = x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO;
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct x86_perf_task_context *task_ctx = ctx;
+	bool need_info = x86_pmu.lbr_has_info;
 	unsigned lbr_idx, mask;
 	u64 tos;
 	int i;
@@ -816,7 +807,6 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 {
 	bool need_info = false, call_stack = false;
 	unsigned long mask = x86_pmu.lbr_nr - 1;
-	int lbr_format = x86_pmu.intel_cap.lbr_format;
 	u64 tos = intel_pmu_lbr_tos();
 	int i;
 	int out = 0;
@@ -831,9 +821,7 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 	for (i = 0; i < num; i++) {
 		unsigned long lbr_idx = (tos - i) & mask;
 		u64 from, to, mis = 0, pred = 0, in_tx = 0, abort = 0;
-		int skip = 0;
 		u16 cycles = 0;
-		int lbr_flags = lbr_desc[lbr_format];
 
 		from = rdlbr_from(lbr_idx, NULL);
 		to   = rdlbr_to(lbr_idx, NULL);
@@ -845,37 +833,39 @@ void intel_pmu_lbr_read_64(struct cpu_hw_events *cpuc)
 		if (call_stack && !from)
 			break;
 
-		if (lbr_format == LBR_FORMAT_INFO && need_info) {
-			u64 info;
-
-			info = rdlbr_info(lbr_idx, NULL);
-			mis = !!(info & LBR_INFO_MISPRED);
-			pred = !mis;
-			in_tx = !!(info & LBR_INFO_IN_TX);
-			abort = !!(info & LBR_INFO_ABORT);
-			cycles = (info & LBR_INFO_CYCLES);
-		}
-
-		if (lbr_format == LBR_FORMAT_TIME) {
-			mis = !!(from & LBR_FROM_FLAG_MISPRED);
-			pred = !mis;
-			skip = 1;
-			cycles = ((to >> 48) & LBR_INFO_CYCLES);
-
-			to = (u64)((((s64)to) << 16) >> 16);
-		}
-
-		if (lbr_flags & LBR_EIP_FLAGS) {
-			mis = !!(from & LBR_FROM_FLAG_MISPRED);
-			pred = !mis;
-			skip = 1;
-		}
-		if (lbr_flags & LBR_TSX) {
-			in_tx = !!(from & LBR_FROM_FLAG_IN_TX);
-			abort = !!(from & LBR_FROM_FLAG_ABORT);
-			skip = 3;
+		if (x86_pmu.lbr_has_info) {
+			if (need_info) {
+				u64 info;
+
+				info = rdlbr_info(lbr_idx, NULL);
+				mis = !!(info & LBR_INFO_MISPRED);
+				pred = !mis;
+				cycles = (info & LBR_INFO_CYCLES);
+				if (x86_pmu.lbr_has_tsx) {
+					in_tx = !!(info & LBR_INFO_IN_TX);
+					abort = !!(info & LBR_INFO_ABORT);
+				}
+			}
+		} else {
+			int skip = 0;
+
+			if (x86_pmu.lbr_from_flags) {
+				mis = !!(from & LBR_FROM_FLAG_MISPRED);
+				pred = !mis;
+				skip = 1;
+			}
+			if (x86_pmu.lbr_has_tsx) {
+				in_tx = !!(from & LBR_FROM_FLAG_IN_TX);
+				abort = !!(from & LBR_FROM_FLAG_ABORT);
+				skip = 3;
+			}
+			from = (u64)((((s64)from) << skip) >> skip);
+
+			if (x86_pmu.lbr_to_cycles) {
+				cycles = ((to >> 48) & LBR_INFO_CYCLES);
+				to = (u64)((((s64)to) << 16) >> 16);
+			}
 		}
-		from = (u64)((((s64)from) << skip) >> skip);
 
 		/*
 		 * Some CPUs report duplicated abort records,
@@ -1120,7 +1110,7 @@ static int intel_pmu_setup_hw_lbr_filter(struct perf_event *event)
 
 	if ((br_type & PERF_SAMPLE_BRANCH_NO_CYCLES) &&
 	    (br_type & PERF_SAMPLE_BRANCH_NO_FLAGS) &&
-	    (x86_pmu.intel_cap.lbr_format == LBR_FORMAT_INFO))
+	    x86_pmu.lbr_has_info)
 		reg->config |= LBR_NO_INFO;
 
 	return 0;
@@ -1706,6 +1696,30 @@ void intel_pmu_lbr_init_knl(void)
 		x86_pmu.intel_cap.lbr_format = LBR_FORMAT_EIP_FLAGS;
 }
 
+void intel_pmu_lbr_init(void)
+{
+	switch (x86_pmu.intel_cap.lbr_format) {
+	case LBR_FORMAT_EIP_FLAGS2:
+		x86_pmu.lbr_has_tsx = 1;
+		fallthrough;
+	case LBR_FORMAT_EIP_FLAGS:
+		x86_pmu.lbr_from_flags = 1;
+		break;
+
+	case LBR_FORMAT_INFO:
+		x86_pmu.lbr_has_tsx = 1;
+		fallthrough;
+	case LBR_FORMAT_INFO2:
+		x86_pmu.lbr_has_info = 1;
+		break;
+
+	case LBR_FORMAT_TIME:
+		x86_pmu.lbr_from_flags = 1;
+		x86_pmu.lbr_to_cycles = 1;
+		break;
+	}
+}
+
 /*
  * LBR state size is variable based on the max number of registers.
  * This calculates the expected state size, which should match
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 9d376e5..150261d 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -215,7 +215,8 @@ enum {
 	LBR_FORMAT_EIP_FLAGS2	= 0x04,
 	LBR_FORMAT_INFO		= 0x05,
 	LBR_FORMAT_TIME		= 0x06,
-	LBR_FORMAT_MAX_KNOWN    = LBR_FORMAT_TIME,
+	LBR_FORMAT_INFO2	= 0x07,
+	LBR_FORMAT_MAX_KNOWN    = LBR_FORMAT_INFO2,
 };
 
 enum {
@@ -840,6 +841,11 @@ struct x86_pmu {
 	bool		lbr_double_abort;	   /* duplicated lbr aborts */
 	bool		lbr_pt_coexist;		   /* (LBR|BTS) may coexist with PT */
 
+	unsigned int	lbr_has_info:1;
+	unsigned int	lbr_has_tsx:1;
+	unsigned int	lbr_from_flags:1;
+	unsigned int	lbr_to_cycles:1;
+
 	/*
 	 * Intel Architectural LBR CPUID Enumeration
 	 */
@@ -1392,6 +1398,8 @@ void intel_pmu_lbr_init_skl(void);
 
 void intel_pmu_lbr_init_knl(void);
 
+void intel_pmu_lbr_init(void);
+
 void intel_pmu_arch_lbr_init(void);
 
 void intel_pmu_pebs_data_source_nhm(void);
