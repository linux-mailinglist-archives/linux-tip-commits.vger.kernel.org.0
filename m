Return-Path: <linux-tip-commits+bounces-4748-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 31623A81553
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 21:05:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6BACD1BA1C84
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 19:05:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34DB623F412;
	Tue,  8 Apr 2025 19:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ij2N01l3";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YlPKfR0D"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D0031CD1E0;
	Tue,  8 Apr 2025 19:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139102; cv=none; b=MGFIGxyEXNZ6fRQsDcCteFlyUcNaxTu1Mw8zRmdxcf4lZ7fDaItJQzF9IpW7apZ9rKz0JRg3/SNIblb43JGgJilbvHP07AbiYVnzPxjMj0VH0PcUaQ0duy7cY+wGYCEkaZ3JtEWoDSjP6HECgwsvncA0ahnfWytapEjp+eh2kzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139102; c=relaxed/simple;
	bh=pp9ZSiF31gO1luJsRcp1ScynOVufAQYh0s9NSzlOXZs=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=dY6pz+o7s9r8Eb4EsCOZY69f/vdmO3uj9JmXvfhoAnkVREX/Jv/h4TYzQfSG42PE/JZzUUPvJ/LK5U20watJHndt4NcRU9bNOgPYtSbQi1rXQ8uqruwbRTfYkDdvpJq6OQ8s0AAgWW33N9ZxyKy22tWCHbAR3GEnT2eR/QzWAag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ij2N01l3; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YlPKfR0D; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Apr 2025 19:04:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744139098;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qiEWWQdodPE311SJkdgd9BCElzJ+IlZCpHBf10zLR+c=;
	b=ij2N01l3cNK/BzJwBI5Op0ObCWVmhS9b/YwxqS6tyUE1R+AtUVfBoKzaKDcuW4Rb0LLYxC
	qHcKfNu6JqBSHHbueui90jeFSBMPhDs+KtsTfpRy5yUjhBSXeXeR3mxnjHmb8ClLe8QzPH
	64ONZbGrcrjVBCYPjItAjJYrKcgRdA2rU+7pAqLsCVHRz+2wkIo2r4eKNk0Fui8UIDcQXn
	iAxKmKuLqpaxvsYwzbEwNWW4XoAUQIx+07xm6McgRxm+db+Gfu484s0iEsOHi1ODSNriAJ
	YwiSYSXbEPPJGmIO2T/usNVJCaGvSCLQCS9UW4BrQLtZqWVpIieA2PG9vdjQlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744139098;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=qiEWWQdodPE311SJkdgd9BCElzJ+IlZCpHBf10zLR+c=;
	b=YlPKfR0D7Q68ahVT2D714xrjghItCgPJyAgExGqSEkdrp/eK6ZHsWwr7Zyw9DRfCtghGon
	+3JfRWv2TkaRlkBA==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Add CPUID enumeration for the auto
 counter reload
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Thomas Falcon <thomas.falcon@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250327195217.2683619-5-kan.liang@linux.intel.com>
References: <20250327195217.2683619-5-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174413909765.31282.11473149016229388139.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     1856c6c2f8416b1340652cccfa1fc302ac8d5ecd
Gitweb:        https://git.kernel.org/tip/1856c6c2f8416b1340652cccfa1fc302ac8d5ecd
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 27 Mar 2025 12:52:16 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Apr 2025 20:55:49 +02:00

perf/x86/intel: Add CPUID enumeration for the auto counter reload

The counters that support the auto counter reload feature can be
enumerated in the CPUID Leaf 0x23 sub-leaf 0x2.

Add acr_cntr_mask to store the mask of counters which are reloadable.
Add acr_cause_mask to store the mask of counters which can cause reload.
Since the e-core and p-core may have different numbers of counters,
track the masks in the struct x86_hybrid_pmu as well.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Link: https://lkml.kernel.org/r/20250327195217.2683619-5-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c      | 10 ++++++++++
 arch/x86/events/perf_event.h      | 17 +++++++++++++++++
 arch/x86/include/asm/perf_event.h |  1 +
 3 files changed, 28 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 6105024..876678a 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5069,6 +5069,16 @@ static void update_pmu_cap(struct x86_hybrid_pmu *pmu)
 		pmu->fixed_cntr_mask64 = fixed_cntr;
 	}
 
+	if (eax.split.acr_subleaf) {
+		cpuid_count(ARCH_PERFMON_EXT_LEAF, ARCH_PERFMON_ACR_LEAF,
+			    &cntr, &fixed_cntr, &ecx, &edx);
+		/* The mask of the counters which can be reloaded */
+		pmu->acr_cntr_mask64 = cntr | ((u64)fixed_cntr << INTEL_PMC_IDX_FIXED);
+
+		/* The mask of the counters which can cause a reload of reloadable counters */
+		pmu->acr_cause_mask64 = ecx | ((u64)edx << INTEL_PMC_IDX_FIXED);
+	}
+
 	if (!intel_pmu_broken_perf_cap()) {
 		/* Perf Metric (Bit 15) and PEBS via PT (Bit 16) are hybrid enumeration */
 		rdmsrl(MSR_IA32_PERF_CAPABILITIES, pmu->intel_cap.capabilities);
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 4410cf0..ab9af2e 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -708,6 +708,15 @@ struct x86_hybrid_pmu {
 			u64		fixed_cntr_mask64;
 			unsigned long	fixed_cntr_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
 	};
+
+	union {
+			u64		acr_cntr_mask64;
+			unsigned long	acr_cntr_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
+	};
+	union {
+			u64		acr_cause_mask64;
+			unsigned long	acr_cause_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
+	};
 	struct event_constraint		unconstrained;
 
 	u64				hw_cache_event_ids
@@ -806,6 +815,14 @@ struct x86_pmu {
 			u64		fixed_cntr_mask64;
 			unsigned long	fixed_cntr_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
 	};
+	union {
+			u64		acr_cntr_mask64;
+			unsigned long	acr_cntr_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
+	};
+	union {
+			u64		acr_cause_mask64;
+			unsigned long	acr_cause_mask[BITS_TO_LONGS(X86_PMC_IDX_MAX)];
+	};
 	int		cntval_bits;
 	u64		cntval_mask;
 	union {
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 812dac3..70d1d94 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -195,6 +195,7 @@ union cpuid10_edx {
  */
 #define ARCH_PERFMON_EXT_LEAF			0x00000023
 #define ARCH_PERFMON_NUM_COUNTER_LEAF		0x1
+#define ARCH_PERFMON_ACR_LEAF			0x2
 
 union cpuid35_eax {
 	struct {

