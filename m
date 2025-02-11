Return-Path: <linux-tip-commits+bounces-3353-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0561A30F30
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Feb 2025 16:06:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C76277A1EE7
	for <lists+linux-tip-commits@lfdr.de>; Tue, 11 Feb 2025 15:05:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573BA2512EE;
	Tue, 11 Feb 2025 15:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aEVKlUrV";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="p7W2w0op"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E5981CB31D;
	Tue, 11 Feb 2025 15:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739286371; cv=none; b=bLX9HkIWbdp9+gs0UZ9swpKYySNYq478YKVz3cbfvpFeUHCOheZ1GySLMJs67y6uQHRV32ojJFwamWOARYucKP39CJ+xLvFdkevX3Aps8gbWd8jb0DXbZ+lZFKCW4LMuJc1+YzG1D/SRbaWDaLXeYq9m0DgMCmCKIY9V4YP0A60=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739286371; c=relaxed/simple;
	bh=X7OMa9JvXglNs86kgmBAU94vP2N14IIzmEi3YWaou2k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TjbRc2I2HObIH/0ZJmYAWIQOjhgMVNyacRWnqadw3gHOkm3AW577QmFOb1rh7CjXvWdtU3odKi+M4ql2Yi/t5WgQlNTmcoSsj7U7zMNze3Nwb9OF7mjrK8hy+Mm2C+DMy2HRQYIX9MtCV3nPeAjoXGpUfYxhIMUJsrCculafVSQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aEVKlUrV; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=p7W2w0op; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 11 Feb 2025 15:06:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1739286367;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3cfGzFeIiFrRQ79pEaGhqZnnk9mmzpJhfGXh0AKjW9g=;
	b=aEVKlUrV8ajcJoLUhTxmwrlajw57VTLctO6iPDtNo3htbY/hGCkftSf2TPrPvxEqv+CphP
	dA7GVzWzOaZ9F3yrtOsWjZkM7gTfG0PfU03NdQdcOkHWw3ZuhoM7TNyHxiSxRsDnuxVglZ
	cxUwfIUqGr8yUtvuwN/DJcDB1ha1Av4wT6yNLzuyrdIlYxU5ZrwL+9sYRdXYu+TR3TQcjS
	Qli4a0bRmlHu6JJAtjOvS8rB+K8DBcxkDfRJcfcwWT9jly32yJjmY+NiygazcYVJRL1IW5
	70Nir+hwDKjnCjhc+BXMTKMBm6kSmH6OTazWEtn15pWovJGexaS3jeepHM9+KQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1739286367;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3cfGzFeIiFrRQ79pEaGhqZnnk9mmzpJhfGXh0AKjW9g=;
	b=p7W2w0opMdavUvWvFduA+8rjM99EfVf1kZFyTXBeUj6twjqqj+ueRtkurdQa+vFKRs9l+2
	I4zU/mpatawnMdCQ==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel: Clean up PEBS-via-PT on hybrid
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250129154820.3755948-2-kan.liang@linux.intel.com>
References: <20250129154820.3755948-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173928636713.10177.3195303394479719181.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     0a5561501397e2bbd0fb0e300eb489f72a90597a
Gitweb:        https://git.kernel.org/tip/0a5561501397e2bbd0fb0e300eb489f72a90597a
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Wed, 29 Jan 2025 07:48:18 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 08 Feb 2025 15:47:25 +01:00

perf/x86/intel: Clean up PEBS-via-PT on hybrid

The PEBS-via-PT feature is exposed for the e-core of some hybrid
platforms, e.g., ADL and MTL. But it never works.

$ dmesg | grep PEBS
[    1.793888] core: cpu_atom PMU driver: PEBS-via-PT

$ perf record -c 1000 -e '{intel_pt/branch=0/,
cpu_atom/cpu-cycles,aux-output/pp}' -C8
Error:
The sys_perf_event_open() syscall returned with 22 (Invalid argument)
for event (cpu_atom/cpu-cycles,aux-output/pp).
"dmesg | grep -i perf" may provide additional information.

The "PEBS-via-PT" is printed if the corresponding bit of per-PMU
capabilities is set. Since the feature is supported by the e-core HW,
perf sets the bit for e-core. However, for Intel PT, if a feature is not
supported on all CPUs, it is not supported at all. The PEBS-via-PT event
cannot be created successfully.

The PEBS-via-PT is no longer enumerated on the latest hybrid platform. It
will be deprecated on future platforms with Arch PEBS. Let's remove it
from the existing hybrid platforms.

Fixes: d9977c43bff8 ("perf/x86: Register hybrid PMUs")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20250129154820.3755948-2-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 10 ----------
 arch/x86/events/intel/ds.c   | 10 +++++++++-
 2 files changed, 9 insertions(+), 11 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 7601196..966f783 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4941,11 +4941,6 @@ static void intel_pmu_check_hybrid_pmus(struct x86_hybrid_pmu *pmu)
 	else
 		pmu->intel_ctrl &= ~(1ULL << GLOBAL_CTRL_EN_PERF_METRICS);
 
-	if (pmu->intel_cap.pebs_output_pt_available)
-		pmu->pmu.capabilities |= PERF_PMU_CAP_AUX_OUTPUT;
-	else
-		pmu->pmu.capabilities &= ~PERF_PMU_CAP_AUX_OUTPUT;
-
 	intel_pmu_check_event_constraints(pmu->event_constraints,
 					  pmu->cntr_mask64,
 					  pmu->fixed_cntr_mask64,
@@ -5023,9 +5018,6 @@ static bool init_hybrid_pmu(int cpu)
 
 	pr_info("%s PMU driver: ", pmu->name);
 
-	if (pmu->intel_cap.pebs_output_pt_available)
-		pr_cont("PEBS-via-PT ");
-
 	pr_cont("\n");
 
 	x86_pmu_show_pmu_cap(&pmu->pmu);
@@ -6370,11 +6362,9 @@ static __always_inline int intel_pmu_init_hybrid(enum hybrid_pmu_type pmus)
 		pmu->intel_cap.capabilities = x86_pmu.intel_cap.capabilities;
 		if (pmu->pmu_type & hybrid_small_tiny) {
 			pmu->intel_cap.perf_metrics = 0;
-			pmu->intel_cap.pebs_output_pt_available = 1;
 			pmu->mid_ack = true;
 		} else if (pmu->pmu_type & hybrid_big) {
 			pmu->intel_cap.perf_metrics = 1;
-			pmu->intel_cap.pebs_output_pt_available = 0;
 			pmu->late_ack = true;
 		}
 	}
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index ba74e11..c2e2eae 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2578,7 +2578,15 @@ void __init intel_ds_init(void)
 			}
 			pr_cont("PEBS fmt4%c%s, ", pebs_type, pebs_qual);
 
-			if (!is_hybrid() && x86_pmu.intel_cap.pebs_output_pt_available) {
+			/*
+			 * The PEBS-via-PT is not supported on hybrid platforms,
+			 * because not all CPUs of a hybrid machine support it.
+			 * The global x86_pmu.intel_cap, which only contains the
+			 * common capabilities, is used to check the availability
+			 * of the feature. The per-PMU pebs_output_pt_available
+			 * in a hybrid machine should be ignored.
+			 */
+			if (x86_pmu.intel_cap.pebs_output_pt_available) {
 				pr_cont("PEBS-via-PT, ");
 				x86_get_pmu(smp_processor_id())->capabilities |= PERF_PMU_CAP_AUX_OUTPUT;
 			}

