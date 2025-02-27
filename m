Return-Path: <linux-tip-commits+bounces-3712-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C3B4A47E4D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 13:55:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 29CB81890FE4
	for <lists+linux-tip-commits@lfdr.de>; Thu, 27 Feb 2025 12:55:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4317F22DF92;
	Thu, 27 Feb 2025 12:55:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="VcHGpoM7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="E/dokj5x"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B30522C322;
	Thu, 27 Feb 2025 12:55:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740660923; cv=none; b=G22vZvo91IIpZaJ0AUYYQ2ksFgBhk1YdBJ9aOBFdiT67FUHQ9dwsq30L5eaLISONUd9UPFwmHkseJ1Eo/FsKdA0F54oBX5H8Tr0KfwIoIn/qW51bLpFDrvfRaMzJqdMNJAl/VogVJefay6LrmsvjYAAHNRDuhnKzfBovX94wNc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740660923; c=relaxed/simple;
	bh=LwNtvh8C2KEuNWGti1/9iNgX1e6W6E9MIg1jthKPFOQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=e/wrHTpIpV5o3CdhKg4Kyn+/NFObEs8WK5HYvceloICVd/Bco/XToXkkaKy9t/uekNV6DkT4Qh4o/hBpf9v7cssfdkjDV7F8e99ZAyIhugLx530iaFH1csbAWwQ0NcqjgTQhm9BoqhJGIGqyxwM8nrlNmJ+lTm82lVb8N/dUQQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=VcHGpoM7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=E/dokj5x; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 27 Feb 2025 12:55:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740660919;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZhVCtjVqD+hu8HWY0jRjZaM2PSfP6Pvbp45j/SKg3uY=;
	b=VcHGpoM7PZ301ueF5qbOtOllBVEKmM0JQKExBzpdE/1xYclmnpJJecu9R0TiNudO1fqiJ0
	kTNHEXBHsiih4rvWcLm36AqYUg3EsUA3gS7We6OhmcBy+R78Nf1A+FnF9P+exRgikhViNF
	OV26BrVVrYDm4amvu+mRE03BuRB9DgMezOvh70xGE2OOylxCD9JbGSzc/JCZWcmKj5I4YE
	cg0+g2wQKJLJvndpMmFJaRjJO42WaEIoEw1yoAeUfMxaf5CjAXgKrSRyRX6h/lMRsj4Tz4
	itrZED589Gvf8SYnZw/v//TmFgmxWzr1aIvFQrJzd5I55f5DalalT9n8IYw11A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740660919;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZhVCtjVqD+hu8HWY0jRjZaM2PSfP6Pvbp45j/SKg3uY=;
	b=E/dokj5xoxAu3so4j2VVvWrD1YaekWAHxa3U7wYiKR0zZj1X72w8xwRfU0d5w/emYwXEEE
	5jkwOzIjgsk2v7Cw==
From: "tip-bot2 for Pawan Gupta" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/cpu] perf/x86/intel: Use cache cpu-type for hybrid PMU selection
Cc: Dave Hansen <dave.hansen@linux.intel.com>,
 Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241211-add-cpu-type-v5-3-2ae010f50370@linux.intel.com>
References: <20241211-add-cpu-type-v5-3-2ae010f50370@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174066091867.10177.12031046335954587631.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/cpu branch of tip:

Commit-ID:     c4a8b7116b9927f7b00bd68140e285662a03068e
Gitweb:        https://git.kernel.org/tip/c4a8b7116b9927f7b00bd68140e285662a03068e
Author:        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
AuthorDate:    Wed, 11 Dec 2024 22:57:36 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 27 Feb 2025 13:34:52 +01:00

perf/x86/intel: Use cache cpu-type for hybrid PMU selection

get_this_hybrid_cpu_type() misses a case when cpu-type is populated
regardless of X86_FEATURE_HYBRID_CPU. This is particularly true for hybrid
variants that have P or E cores fused off.

Instead use the cpu-type cached in struct x86_topology, as it does not rely
on hybrid feature to enumerate cpu-type. This can also help avoid the
model-specific fixup get_hybrid_cpu_type(). Also replace the
get_this_hybrid_cpu_native_id() with its cached value in struct
x86_topology.

While at it, remove enum hybrid_cpu_type as it serves no purpose when we
have the exact cpu-types defined in enum intel_cpu_type. Also rename
atom_native_id to intel_native_id and move it to intel-family.h where
intel_cpu_type lives.

Suggested-by: Dave Hansen <dave.hansen@linux.intel.com>
Signed-off-by: Pawan Gupta <pawan.kumar.gupta@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Link: https://lore.kernel.org/r/20241211-add-cpu-type-v5-3-2ae010f50370@linux.intel.com
---
 arch/x86/events/intel/core.c        | 19 ++++++++++---------
 arch/x86/events/perf_event.h        | 19 +------------------
 arch/x86/include/asm/intel-family.h | 15 ++++++++++++++-
 3 files changed, 25 insertions(+), 28 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 3cf65e9..397c545 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4606,9 +4606,9 @@ static int adl_hw_config(struct perf_event *event)
 	return -EOPNOTSUPP;
 }
 
-static enum hybrid_cpu_type adl_get_hybrid_cpu_type(void)
+static enum intel_cpu_type adl_get_hybrid_cpu_type(void)
 {
-	return HYBRID_INTEL_CORE;
+	return INTEL_CPU_TYPE_CORE;
 }
 
 static inline bool erratum_hsw11(struct perf_event *event)
@@ -4953,7 +4953,8 @@ static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
 
 static struct x86_hybrid_pmu *find_hybrid_pmu_for_cpu(void)
 {
-	u8 cpu_type = get_this_hybrid_cpu_type();
+	struct cpuinfo_x86 *c = &cpu_data(smp_processor_id());
+	enum intel_cpu_type cpu_type = c->topo.intel_type;
 	int i;
 
 	/*
@@ -4962,7 +4963,7 @@ static struct x86_hybrid_pmu *find_hybrid_pmu_for_cpu(void)
 	 * on it. There should be a fixup function provided for these
 	 * troublesome CPUs (->get_hybrid_cpu_type).
 	 */
-	if (cpu_type == HYBRID_INTEL_NONE) {
+	if (cpu_type == INTEL_CPU_TYPE_UNKNOWN) {
 		if (x86_pmu.get_hybrid_cpu_type)
 			cpu_type = x86_pmu.get_hybrid_cpu_type();
 		else
@@ -4979,16 +4980,16 @@ static struct x86_hybrid_pmu *find_hybrid_pmu_for_cpu(void)
 		enum hybrid_pmu_type pmu_type = x86_pmu.hybrid_pmu[i].pmu_type;
 		u32 native_id;
 
-		if (cpu_type == HYBRID_INTEL_CORE && pmu_type == hybrid_big)
+		if (cpu_type == INTEL_CPU_TYPE_CORE && pmu_type == hybrid_big)
 			return &x86_pmu.hybrid_pmu[i];
-		if (cpu_type == HYBRID_INTEL_ATOM) {
+		if (cpu_type == INTEL_CPU_TYPE_ATOM) {
 			if (x86_pmu.num_hybrid_pmus == 2 && pmu_type == hybrid_small)
 				return &x86_pmu.hybrid_pmu[i];
 
-			native_id = get_this_hybrid_cpu_native_id();
-			if (native_id == skt_native_id && pmu_type == hybrid_small)
+			native_id = c->topo.intel_native_model_id;
+			if (native_id == INTEL_ATOM_SKT_NATIVE_ID && pmu_type == hybrid_small)
 				return &x86_pmu.hybrid_pmu[i];
-			if (native_id == cmt_native_id && pmu_type == hybrid_tiny)
+			if (native_id == INTEL_ATOM_CMT_NATIVE_ID && pmu_type == hybrid_tiny)
 				return &x86_pmu.hybrid_pmu[i];
 		}
 	}
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 31c2771..7b18754 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -669,18 +669,6 @@ enum {
 #define PERF_PEBS_DATA_SOURCE_GRT_MAX	0x10
 #define PERF_PEBS_DATA_SOURCE_GRT_MASK	(PERF_PEBS_DATA_SOURCE_GRT_MAX - 1)
 
-/*
- * CPUID.1AH.EAX[31:0] uniquely identifies the microarchitecture
- * of the core. Bits 31-24 indicates its core type (Core or Atom)
- * and Bits [23:0] indicates the native model ID of the core.
- * Core type and native model ID are defined in below enumerations.
- */
-enum hybrid_cpu_type {
-	HYBRID_INTEL_NONE,
-	HYBRID_INTEL_ATOM	= 0x20,
-	HYBRID_INTEL_CORE	= 0x40,
-};
-
 #define X86_HYBRID_PMU_ATOM_IDX		0
 #define X86_HYBRID_PMU_CORE_IDX		1
 #define X86_HYBRID_PMU_TINY_IDX		2
@@ -697,11 +685,6 @@ enum hybrid_pmu_type {
 	hybrid_big_small_tiny	= hybrid_big   | hybrid_small_tiny,
 };
 
-enum atom_native_id {
-	cmt_native_id           = 0x2,  /* Crestmont */
-	skt_native_id           = 0x3,  /* Skymont */
-};
-
 struct x86_hybrid_pmu {
 	struct pmu			pmu;
 	const char			*name;
@@ -994,7 +977,7 @@ struct x86_pmu {
 	 */
 	int				num_hybrid_pmus;
 	struct x86_hybrid_pmu		*hybrid_pmu;
-	enum hybrid_cpu_type (*get_hybrid_cpu_type)	(void);
+	enum intel_cpu_type (*get_hybrid_cpu_type)	(void);
 };
 
 struct x86_perf_task_context_opt {
diff --git a/arch/x86/include/asm/intel-family.h b/arch/x86/include/asm/intel-family.h
index f9f67af..b657d78 100644
--- a/arch/x86/include/asm/intel-family.h
+++ b/arch/x86/include/asm/intel-family.h
@@ -182,10 +182,23 @@
 /* Family 19 */
 #define INTEL_PANTHERCOVE_X		IFM(19, 0x01) /* Diamond Rapids */
 
-/* CPU core types */
+/*
+ * Intel CPU core types
+ *
+ * CPUID.1AH.EAX[31:0] uniquely identifies the microarchitecture
+ * of the core. Bits 31-24 indicates its core type (Core or Atom)
+ * and Bits [23:0] indicates the native model ID of the core.
+ * Core type and native model ID are defined in below enumerations.
+ */
 enum intel_cpu_type {
+	INTEL_CPU_TYPE_UNKNOWN,
 	INTEL_CPU_TYPE_ATOM = 0x20,
 	INTEL_CPU_TYPE_CORE = 0x40,
 };
 
+enum intel_native_id {
+	INTEL_ATOM_CMT_NATIVE_ID = 0x2,  /* Crestmont */
+	INTEL_ATOM_SKT_NATIVE_ID = 0x3,  /* Skymont */
+};
+
 #endif /* _ASM_X86_INTEL_FAMILY_H */

