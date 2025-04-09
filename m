Return-Path: <linux-tip-commits+bounces-4791-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DA93A8240A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 13:55:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 01743881D8C
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 11:53:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DABD325D1ED;
	Wed,  9 Apr 2025 11:53:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iVOLLRRT";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="bEAVEZf7"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1985F2253E4;
	Wed,  9 Apr 2025 11:53:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744199635; cv=none; b=mlPXlQLRDKJH57nXKdy3EXfHDwh6KMDNxrLzJng9+ZEzoiH/mO5JgqTfnWmbUmZMCz4i5b5d5p2GEgLtyiBpWs1CBCV0GHWBCh+ELhLpG0wsnDqJgKnFgCVgOdEkcdf2pX2ZlDGjU0VmDOPneht2evRlShcJx3QZVtMR8HVXsWg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744199635; c=relaxed/simple;
	bh=3+pciIttb1v5VOKDbxeFevbCiEP+2uFpMVPMQBUt7c0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=frto/pjaaA3o06TOQFu2uqyEtP3Z52BRXIyhWjnV5uLLX9BA1fUBaih5+humqqyiOGPt5gmMoJXUcgAfrcGcka3R6gYTDVGw62G+3fAcVicIba+SbHKb41JwuhSOMxYEG56K0PYOLmeYU7sJauAlFp/hSI/l23qXiENVYWsPbxE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iVOLLRRT; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=bEAVEZf7; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Apr 2025 11:53:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744199632;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZ6vN31dRlpsarFlVDk1LelmuJSiMZi+RiVrp7J8eZ8=;
	b=iVOLLRRTwCoEFar/oDweOAtb12MdQ2h4uzW9R4+kw5uORzAO/SES2YYNIGU6SOqiHW2/rq
	6RwbWwHFaJlANbsWZxEG9iuOFdg7Cnfr8us3aFhgLR3aJ86nz6f7NYN7NDVUellgwaFLdn
	uthbbLzw5L2NT2HpFMnm7RgeAF+FXDxXSefXfF/q/CEA/W43y5mQPv9w+iR/6qBm2qYwEj
	iT5tfPI9+VXEh6ShqLofiSmSQA2TXGsIN/KT6S7Tkr2hxB6qNo0aB7jMvaL77FoIp0lcsA
	yKVSD4c7E3slleZpNsx6jNEZ3PlInqmX2mdpeo51wE05a3Jh0Qn2B1ZeZxygNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744199632;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZZ6vN31dRlpsarFlVDk1LelmuJSiMZi+RiVrp7J8eZ8=;
	b=bEAVEZf7UteB0Phbwe7WgrHpby5iEBA63q3FQ1X7c1CMwyTjPYDC5EPke/BhjENGUn76Rf
	z8Bwq1SJuTE5j7Cw==
From: "tip-bot2 for Mark Barnett" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/arch: Record sample last_period before updating
 on the x86 and PowerPC platforms
Cc: Mark Barnett <mark.barnett@arm.com>, Ingo Molnar <mingo@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250408171530.140858-2-mark.barnett@arm.com>
References: <20250408171530.140858-2-mark.barnett@arm.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174419963135.31282.14918812320661180622.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     1734d98fbcce343eafba16e18e3a3001b3e94ab5
Gitweb:        https://git.kernel.org/tip/1734d98fbcce343eafba16e18e3a3001b3e94ab5
Author:        Mark Barnett <mark.barnett@arm.com>
AuthorDate:    Tue, 08 Apr 2025 18:15:26 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 09 Apr 2025 13:45:08 +02:00

perf/arch: Record sample last_period before updating on the x86 and PowerPC platforms

This change alters the PowerPC and x86 driver implementations to record
the last sample period before the event is updated for the next period.

A common pattern in PMU driver implementations is to have a
"*_event_set_period" function which takes care of updating the various
period-related fields in a perf_event structure. In most cases, the
drivers choose to call this function after initializing a sample data
structure with perf_sample_data_init. The x86 and PowerPC drivers
deviate from this, choosing to update the period before initializing the
sample data. When using an event with an alternate sample period, this
causes an incorrect period to be written to the sample data that gets
reported to userspace.

Signed-off-by: Mark Barnett <mark.barnett@arm.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20250408171530.140858-2-mark.barnett@arm.com
---
 arch/powerpc/perf/core-book3s.c  | 3 ++-
 arch/powerpc/perf/core-fsl-emb.c | 3 ++-
 arch/x86/events/core.c           | 4 +++-
 arch/x86/events/intel/core.c     | 5 ++++-
 arch/x86/events/intel/knc.c      | 4 +++-
 5 files changed, 14 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index b906d28..42ff4d1 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -2239,6 +2239,7 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 			       struct pt_regs *regs)
 {
 	u64 period = event->hw.sample_period;
+	const u64 last_period = event->hw.last_period;
 	s64 prev, delta, left;
 	int record = 0;
 
@@ -2320,7 +2321,7 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 	if (record) {
 		struct perf_sample_data data;
 
-		perf_sample_data_init(&data, ~0ULL, event->hw.last_period);
+		perf_sample_data_init(&data, ~0ULL, last_period);
 
 		if (event->attr.sample_type & PERF_SAMPLE_ADDR_TYPE)
 			perf_get_data_addr(event, regs, &data.addr);
diff --git a/arch/powerpc/perf/core-fsl-emb.c b/arch/powerpc/perf/core-fsl-emb.c
index 1a53ab0..d2ffcc7 100644
--- a/arch/powerpc/perf/core-fsl-emb.c
+++ b/arch/powerpc/perf/core-fsl-emb.c
@@ -590,6 +590,7 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 			       struct pt_regs *regs)
 {
 	u64 period = event->hw.sample_period;
+	const u64 last_period = event->hw.last_period;
 	s64 prev, delta, left;
 	int record = 0;
 
@@ -632,7 +633,7 @@ static void record_and_restart(struct perf_event *event, unsigned long val,
 	if (record) {
 		struct perf_sample_data data;
 
-		perf_sample_data_init(&data, 0, event->hw.last_period);
+		perf_sample_data_init(&data, 0, last_period);
 
 		if (perf_event_overflow(event, &data, regs))
 			fsl_emb_pmu_stop(event, 0);
diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index f53ae1f..cae2132 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1684,6 +1684,7 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 	struct cpu_hw_events *cpuc;
 	struct perf_event *event;
 	int idx, handled = 0;
+	u64 last_period;
 	u64 val;
 
 	cpuc = this_cpu_ptr(&cpu_hw_events);
@@ -1703,6 +1704,7 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 			continue;
 
 		event = cpuc->events[idx];
+		last_period = event->hw.last_period;
 
 		val = static_call(x86_pmu_update)(event);
 		if (val & (1ULL << (x86_pmu.cntval_bits - 1)))
@@ -1716,7 +1718,7 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 		if (!static_call(x86_pmu_set_period)(event))
 			continue;
 
-		perf_sample_data_init(&data, 0, event->hw.last_period);
+		perf_sample_data_init(&data, 0, last_period);
 
 		perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
 
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 3152a01..0ceaa1b 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3223,6 +3223,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 
 	for_each_set_bit(bit, (unsigned long *)&status, X86_PMC_IDX_MAX) {
 		struct perf_event *event = cpuc->events[bit];
+		u64 last_period;
 
 		handled++;
 
@@ -3250,10 +3251,12 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		if (is_pebs_counter_event_group(event))
 			x86_pmu.drain_pebs(regs, &data);
 
+		last_period = event->hw.last_period;
+
 		if (!intel_pmu_save_and_restart(event))
 			continue;
 
-		perf_sample_data_init(&data, 0, event->hw.last_period);
+		perf_sample_data_init(&data, 0, last_period);
 
 		if (has_branch_stack(event))
 			intel_pmu_lbr_save_brstack(&data, cpuc, event);
diff --git a/arch/x86/events/intel/knc.c b/arch/x86/events/intel/knc.c
index 034a1f6..3e8ec04 100644
--- a/arch/x86/events/intel/knc.c
+++ b/arch/x86/events/intel/knc.c
@@ -241,16 +241,18 @@ again:
 
 	for_each_set_bit(bit, (unsigned long *)&status, X86_PMC_IDX_MAX) {
 		struct perf_event *event = cpuc->events[bit];
+		u64 last_period;
 
 		handled++;
 
 		if (!test_bit(bit, cpuc->active_mask))
 			continue;
 
+		last_period = event->hw.last_period;
 		if (!intel_pmu_save_and_restart(event))
 			continue;
 
-		perf_sample_data_init(&data, 0, event->hw.last_period);
+		perf_sample_data_init(&data, 0, last_period);
 
 		if (perf_event_overflow(event, &data, regs))
 			x86_pmu_stop(event, 0);

