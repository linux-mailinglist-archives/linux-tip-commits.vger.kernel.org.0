Return-Path: <linux-tip-commits+bounces-5170-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 12471AA6D9B
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 11:07:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7D0FB4C148D
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 May 2025 09:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB00424C083;
	Fri,  2 May 2025 09:04:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aI2UzuAN";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="lXQXr6hN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C4D245005;
	Fri,  2 May 2025 09:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746176670; cv=none; b=m0G+6EHipqS8pI0ZQV+Pf4Ax31Qz7NDuGoIqq3xsl/MJmI1F1+f1c6yX0AMKdHL9YFrQyhT8YA21/Lo/zWVzr2ZX+H6p/++c+/rktnB72HV5tDKRGyJr5qI+ljFepD3Dg8SjjK3iIL9yHuqDu6A5z7NAR+5zxCHjpFWCmWzUdk0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746176670; c=relaxed/simple;
	bh=/wVau6KdSpf6tc49isEbiPnqJnfQnF4gLeuIcRrjC7Y=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=GR4q8brqukaIH4uDYqGM9BLGY+P65Ezu4UeZZaWUdP9Qg0HpV1YcJeDs4U1x/OCCWUY+UTSWezdtI/VIRMQDfZM8NP164GqgdtQAmiJpLP8ueuX1f9tcqj8X3GRblAyqfyd8ppXxotuN7hbD5Cos2HIyvw7JZFeo9YtjDnbXg6o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aI2UzuAN; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=lXQXr6hN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 May 2025 09:04:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1746176666;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nekUBVHwZXDekYhC3FBIuR44hcN7MXZdTQP34PSioSc=;
	b=aI2UzuANWyYXuSNuvWnszpAx4QZ5BAyn6J6YehLxhPKMnPHuPhCj6mnCCOw7eK+u6FpBQI
	eoadEC9Ug1+XKPqApOYwiweyfVtQqwcbRvnVFLBHBF6C2RPFcGiMCKVS61k369xk6Ewh95
	8/GzR9c2/CnrD2euSveKO0QwEJZXGU5OVN1zPRFd/m8KvNlEu6Qxpa2PajS38Wb0aBoBGl
	Lh7zKygKj67Drh7Z5pggRM4B2Ro+B7o3oWYG7XNRebtKKfdJHB+0h5mHrW7ljzcC5XGwu2
	YsqJ16Zvc2zeeuZiURtnGIYroyi4ctP1JnK/J2gGPcYObMqT1iEdmeDqOWmlEA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1746176666;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nekUBVHwZXDekYhC3FBIuR44hcN7MXZdTQP34PSioSc=;
	b=lXQXr6hNBJ/NCjBPZXt+2n8uCqW1DUUmlyvbvR5ZrL0sywbGNxY32eqxgC1okrgKU0vEbI
	07XL8vUuzXinCXAg==
From: "tip-bot2 for Xin Li (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/merge] x86/msr: Rename rdpmcl() to rdpmc()
Cc: "Xin Li (Intel)" <xin@zytor.com>, Ingo Molnar <mingo@kernel.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Andy Lutomirski <luto@kernel.org>, Brian Gerst <brgerst@gmail.com>,
 Juergen Gross <jgross@suse.com>, "H. Peter Anvin" <hpa@zytor.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 Kees Cook <keescook@chromium.org>, Borislav Petkov <bp@alien8.de>,
 Thomas Gleixner <tglx@linutronix.de>, Josh Poimboeuf <jpoimboe@redhat.com>,
 Uros Bizjak <ubizjak@gmail.com>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250427092027.1598740-5-xin@zytor.com>
References: <20250427092027.1598740-5-xin@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174617666592.22196.16480563173964161379.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/merge branch of tip:

Commit-ID:     7d9ccde56bc023f9a968db537963a029aa41d902
Gitweb:        https://git.kernel.org/tip/7d9ccde56bc023f9a968db537963a029aa41d902
Author:        Xin Li (Intel) <xin@zytor.com>
AuthorDate:    Sun, 27 Apr 2025 02:20:16 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 02 May 2025 10:25:24 +02:00

x86/msr: Rename rdpmcl() to rdpmc()

Now that rdpmc() is gone, rdpmcl() is the sole PMC read helper,
simply rename rdpmcl() to rdpmc().

Signed-off-by: Xin Li (Intel) <xin@zytor.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Cc: Andy Lutomirski <luto@kernel.org>
Cc: Brian Gerst <brgerst@gmail.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: H. Peter Anvin <hpa@zytor.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Kees Cook <keescook@chromium.org>
Cc: Borislav Petkov <bp@alien8.de>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Josh Poimboeuf <jpoimboe@redhat.com>
Cc: Uros Bizjak <ubizjak@gmail.com>
Link: https://lore.kernel.org/r/20250427092027.1598740-5-xin@zytor.com
---
 arch/x86/events/amd/uncore.c              |  2 +-
 arch/x86/events/core.c                    |  2 +-
 arch/x86/events/intel/core.c              |  4 ++--
 arch/x86/events/intel/ds.c                |  2 +-
 arch/x86/include/asm/msr.h                |  2 +-
 arch/x86/include/asm/paravirt.h           |  2 +-
 arch/x86/kernel/cpu/resctrl/pseudo_lock.c | 12 ++++++------
 7 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 2a3259d..42c833c 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -108,7 +108,7 @@ static void amd_uncore_read(struct perf_event *event)
 	if (hwc->event_base_rdpmc < 0)
 		rdmsrq(hwc->event_base, new);
 	else
-		rdpmcl(hwc->event_base_rdpmc, new);
+		rdpmc(hwc->event_base_rdpmc, new);
 
 	local64_set(&hwc->prev_count, new);
 	delta = (new << COUNTER_SHIFT) - (prev << COUNTER_SHIFT);
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 7cfd376..600c0b6 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -135,7 +135,7 @@ u64 x86_perf_event_update(struct perf_event *event)
 	 */
 	prev_raw_count = local64_read(&hwc->prev_count);
 	do {
-		rdpmcl(hwc->event_base_rdpmc, new_raw_count);
+		rdpmc(hwc->event_base_rdpmc, new_raw_count);
 	} while (!local64_try_cmpxchg(&hwc->prev_count,
 				      &prev_raw_count, new_raw_count));
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 3d80ffb..e8eec16 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2725,12 +2725,12 @@ static u64 intel_update_topdown_event(struct perf_event *event, int metric_end, 
 
 	if (!val) {
 		/* read Fixed counter 3 */
-		rdpmcl((3 | INTEL_PMC_FIXED_RDPMC_BASE), slots);
+		rdpmc((3 | INTEL_PMC_FIXED_RDPMC_BASE), slots);
 		if (!slots)
 			return 0;
 
 		/* read PERF_METRICS */
-		rdpmcl(INTEL_PMC_FIXED_RDPMC_METRICS, metrics);
+		rdpmc(INTEL_PMC_FIXED_RDPMC_METRICS, metrics);
 	} else {
 		slots = val[0];
 		metrics = val[1];
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 00a0a85..346db2f 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2277,7 +2277,7 @@ intel_pmu_save_and_restart_reload(struct perf_event *event, int count)
 	WARN_ON(this_cpu_read(cpu_hw_events.enabled));
 
 	prev_raw_count = local64_read(&hwc->prev_count);
-	rdpmcl(hwc->event_base_rdpmc, new_raw_count);
+	rdpmc(hwc->event_base_rdpmc, new_raw_count);
 	local64_set(&hwc->prev_count, new_raw_count);
 
 	/*
diff --git a/arch/x86/include/asm/msr.h b/arch/x86/include/asm/msr.h
index 07d45fc..435a07b 100644
--- a/arch/x86/include/asm/msr.h
+++ b/arch/x86/include/asm/msr.h
@@ -217,7 +217,7 @@ static inline int rdmsrq_safe(u32 msr, u64 *p)
 	return err;
 }
 
-#define rdpmcl(counter, val) ((val) = native_read_pmc(counter))
+#define rdpmc(counter, val) ((val) = native_read_pmc(counter))
 
 #endif	/* !CONFIG_PARAVIRT_XXL */
 
diff --git a/arch/x86/include/asm/paravirt.h b/arch/x86/include/asm/paravirt.h
index c4dedb9..faa0713 100644
--- a/arch/x86/include/asm/paravirt.h
+++ b/arch/x86/include/asm/paravirt.h
@@ -244,7 +244,7 @@ static inline u64 paravirt_read_pmc(int counter)
 	return PVOP_CALL1(u64, cpu.read_pmc, counter);
 }
 
-#define rdpmcl(counter, val) ((val) = paravirt_read_pmc(counter))
+#define rdpmc(counter, val) ((val) = paravirt_read_pmc(counter))
 
 static inline void paravirt_alloc_ldt(struct desc_struct *ldt, unsigned entries)
 {
diff --git a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
index 26c354b..15ff62d 100644
--- a/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
+++ b/arch/x86/kernel/cpu/resctrl/pseudo_lock.c
@@ -1019,8 +1019,8 @@ static int measure_residency_fn(struct perf_event_attr *miss_attr,
 	 * used in L1 cache, second to capture accurate value that does not
 	 * include cache misses incurred because of instruction loads.
 	 */
-	rdpmcl(hit_pmcnum, hits_before);
-	rdpmcl(miss_pmcnum, miss_before);
+	rdpmc(hit_pmcnum, hits_before);
+	rdpmc(miss_pmcnum, miss_before);
 	/*
 	 * From SDM: Performing back-to-back fast reads are not guaranteed
 	 * to be monotonic.
@@ -1028,8 +1028,8 @@ static int measure_residency_fn(struct perf_event_attr *miss_attr,
 	 * before proceeding.
 	 */
 	rmb();
-	rdpmcl(hit_pmcnum, hits_before);
-	rdpmcl(miss_pmcnum, miss_before);
+	rdpmc(hit_pmcnum, hits_before);
+	rdpmc(miss_pmcnum, miss_before);
 	/*
 	 * Use LFENCE to ensure all previous instructions are retired
 	 * before proceeding.
@@ -1051,8 +1051,8 @@ static int measure_residency_fn(struct perf_event_attr *miss_attr,
 	 * before proceeding.
 	 */
 	rmb();
-	rdpmcl(hit_pmcnum, hits_after);
-	rdpmcl(miss_pmcnum, miss_after);
+	rdpmc(hit_pmcnum, hits_after);
+	rdpmc(miss_pmcnum, miss_after);
 	/*
 	 * Use LFENCE to ensure all previous instructions are retired
 	 * before proceeding.

