Return-Path: <linux-tip-commits+bounces-2378-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3727C994621
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 13:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81968B230F1
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Oct 2024 11:07:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CF641DED6F;
	Tue,  8 Oct 2024 11:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="t8oaPkhW";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OiWkWLAK"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA3721DE2A2;
	Tue,  8 Oct 2024 11:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728385522; cv=none; b=qURXmhW4U/NQlW5SSm2iO5TVetzuf+snPzFVOgz3EphFxWy9XFaVJ98+Qo4TlbEozWb4MNzVR07kViItTx1jjJwtLKraDC5SH8WeUcFmawTZoQxufYDCb3cRECVhZ4H5vv9zWkN/8qADru1yQdFgFI65srtdaLhxXpWq8lU396w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728385522; c=relaxed/simple;
	bh=l1RjmCgMtzghZm4yqPwjoXe20UUnoQXiRdZ8SSNTDYw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=HTxIA5lqDsLm8o1/eJUQkCNLR+9aPNFm7N4N6D157nqPqovVGKKQPlKB7aDh80FlpWIPmj8Js7+sQP1lnWk5PQmH1g7nOn3gE9BdCJZo/Ma5h2WAM7CNUSBnnSoLd6/ezGF4h/lH2g4pk8Gd11Xv23RBV89Yp/elYkJoOx+w8yo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=t8oaPkhW; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OiWkWLAK; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Oct 2024 11:05:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1728385518;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZWpOciaBSgipzOwOCe6Jf+8injiJvrdoA7gDdXubhb4=;
	b=t8oaPkhW2ZRHDpD1N7g65FPh/8ZYW9UGxxsIaX2G1Sc7Yxw2z5o70s1wg8aWBOO7/ix6tZ
	MBNN1DsgO9opvea57T14xUpugeMSIfjYfrMrH4KwRvKBKgkMoANFYPmZ+iBAgy32yc7AOJ
	k6z2zXiMKSVkDvcgSdC2k0GJWgLrzS44u+2T9NSUCesByY1xAf8Bo4oY4Ea+GAnf2mNFx7
	a0AQjIL8bbKcEf1LAzqqHoYThZEkecq17kaVkDDAW7mkQJCVmyvxSmx7J8t0LRJiH8l+Vm
	7rAtsdXEcRAFO33c3RjnJMYMJzfY8CPNvnLlSJB3pMeU/adY9/hPKzNJPK3yRg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1728385518;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZWpOciaBSgipzOwOCe6Jf+8injiJvrdoA7gDdXubhb4=;
	b=OiWkWLAK0gNyncU83dNusXlQvUqqTX4y4wiCPDplNtwbHU3SeUHKgZ6Xe/mZc7YjljAGq5
	0GoRoD9gwZiQutAw==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/intel: Support hybrid PMU with multiple atom uarchs
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Kan Liang <kan.liang@linux.intel.com>, Yongwei Ma <yongwei.ma@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20240820073853.1974746-4-dapeng1.mi@linux.intel.com>
References: <20240820073853.1974746-4-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172838551741.1442.13496540876259871950.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9f4a39757c81d532f64232702537c53ad4092a5e
Gitweb:        https://git.kernel.org/tip/9f4a39757c81d532f64232702537c53ad4092a5e
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Tue, 20 Aug 2024 07:38:52 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 07 Oct 2024 09:28:43 +02:00

perf/x86/intel: Support hybrid PMU with multiple atom uarchs

The upcoming ARL-H hybrid processor contains 2 different atom uarchs
which have different PMU capabilities. To distinguish these atom uarchs,
CPUID.1AH.EAX[23:0] defines a native model ID which can be used to
uniquely identify the uarch of the core by combining with core type.

Thus a 3rd hybrid pmu type "hybrid_tiny" is defined to mark the 2nd
atom uarch. The helper find_hybrid_pmu_for_cpu() would compare the
hybrid pmu type and dynamically read core native id from cpu to identify
the corresponding hybrid pmu structure.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Kan Liang <kan.liang@linux.intel.com>
Tested-by: Yongwei Ma <yongwei.ma@intel.com>
Link: https://lkml.kernel.org/r/20240820073853.1974746-4-dapeng1.mi@linux.intel.com
---
 arch/x86/events/intel/core.c | 28 +++++++++++++++++++---------
 arch/x86/events/perf_event.h | 18 +++++++++++++++++-
 2 files changed, 36 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index d879478..6b9884e 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4924,17 +4924,26 @@ static struct x86_hybrid_pmu *find_hybrid_pmu_for_cpu(void)
 
 	/*
 	 * This essentially just maps between the 'hybrid_cpu_type'
-	 * and 'hybrid_pmu_type' enums:
+	 * and 'hybrid_pmu_type' enums except for ARL-H processor
+	 * which needs to compare atom uarch native id since ARL-H
+	 * contains two different atom uarchs.
 	 */
 	for (i = 0; i < x86_pmu.num_hybrid_pmus; i++) {
 		enum hybrid_pmu_type pmu_type = x86_pmu.hybrid_pmu[i].pmu_type;
+		u32 native_id;
 
-		if (cpu_type == HYBRID_INTEL_CORE &&
-		    pmu_type == hybrid_big)
-			return &x86_pmu.hybrid_pmu[i];
-		if (cpu_type == HYBRID_INTEL_ATOM &&
-		    pmu_type == hybrid_small)
+		if (cpu_type == HYBRID_INTEL_CORE && pmu_type == hybrid_big)
 			return &x86_pmu.hybrid_pmu[i];
+		if (cpu_type == HYBRID_INTEL_ATOM) {
+			if (x86_pmu.num_hybrid_pmus == 2 && pmu_type == hybrid_small)
+				return &x86_pmu.hybrid_pmu[i];
+
+			native_id = get_this_hybrid_cpu_native_id();
+			if (native_id == skt_native_id && pmu_type == hybrid_small)
+				return &x86_pmu.hybrid_pmu[i];
+			if (native_id == cmt_native_id && pmu_type == hybrid_tiny)
+				return &x86_pmu.hybrid_pmu[i];
+		}
 	}
 
 	return NULL;
@@ -6238,8 +6247,9 @@ static inline int intel_pmu_v6_addr_offset(int index, bool eventsel)
 }
 
 static const struct { enum hybrid_pmu_type id; char *name; } intel_hybrid_pmu_type_map[] __initconst = {
-	{ hybrid_small, "cpu_atom" },
-	{ hybrid_big, "cpu_core" },
+	{ hybrid_small,	"cpu_atom" },
+	{ hybrid_big,	"cpu_core" },
+	{ hybrid_tiny,	"cpu_lowpower" },
 };
 
 static __always_inline int intel_pmu_init_hybrid(enum hybrid_pmu_type pmus)
@@ -6272,7 +6282,7 @@ static __always_inline int intel_pmu_init_hybrid(enum hybrid_pmu_type pmus)
 							0, x86_pmu_num_counters(&pmu->pmu), 0, 0);
 
 		pmu->intel_cap.capabilities = x86_pmu.intel_cap.capabilities;
-		if (pmu->pmu_type & hybrid_small) {
+		if (pmu->pmu_type & hybrid_small_tiny) {
 			pmu->intel_cap.perf_metrics = 0;
 			pmu->intel_cap.pebs_output_pt_available = 1;
 			pmu->mid_ack = true;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index fdd7d03..909467d 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -668,6 +668,12 @@ enum {
 #define PERF_PEBS_DATA_SOURCE_GRT_MAX	0x10
 #define PERF_PEBS_DATA_SOURCE_GRT_MASK	(PERF_PEBS_DATA_SOURCE_GRT_MAX - 1)
 
+/*
+ * CPUID.1AH.EAX[31:0] uniquely identifies the microarchitecture
+ * of the core. Bits 31-24 indicates its core type (Core or Atom)
+ * and Bits [23:0] indicates the native model ID of the core.
+ * Core type and native model ID are defined in below enumerations.
+ */
 enum hybrid_cpu_type {
 	HYBRID_INTEL_NONE,
 	HYBRID_INTEL_ATOM	= 0x20,
@@ -676,13 +682,23 @@ enum hybrid_cpu_type {
 
 #define X86_HYBRID_PMU_ATOM_IDX		0
 #define X86_HYBRID_PMU_CORE_IDX		1
+#define X86_HYBRID_PMU_TINY_IDX		2
 
 enum hybrid_pmu_type {
 	not_hybrid,
 	hybrid_small		= BIT(X86_HYBRID_PMU_ATOM_IDX),
 	hybrid_big		= BIT(X86_HYBRID_PMU_CORE_IDX),
+	hybrid_tiny		= BIT(X86_HYBRID_PMU_TINY_IDX),
+
+	/* The belows are only used for matching */
+	hybrid_big_small	= hybrid_big   | hybrid_small,
+	hybrid_small_tiny	= hybrid_small | hybrid_tiny,
+	hybrid_big_small_tiny	= hybrid_big   | hybrid_small_tiny,
+};
 
-	hybrid_big_small	= hybrid_big | hybrid_small, /* only used for matching */
+enum atom_native_id {
+	cmt_native_id           = 0x2,  /* Crestmont */
+	skt_native_id           = 0x3,  /* Skymont */
 };
 
 struct x86_hybrid_pmu {

