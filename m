Return-Path: <linux-tip-commits+bounces-3611-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93AF6A44268
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Feb 2025 15:20:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 02ED8188ADEB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 Feb 2025 14:15:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4524226A095;
	Tue, 25 Feb 2025 14:15:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2/kGHnxa";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="k6aCjhhO"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 527C12698A8;
	Tue, 25 Feb 2025 14:14:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740492901; cv=none; b=GlL7Seom6RgNBgiQ5l2Gz/cM/Eq394CBJa+RQy7J2YZXPuHVEZ0SruT9BcV9Ndd36YrkyUHmw/QQHsCudQJEBDhPSBUef9tP/wA428QSDveOmrZXUX5/yMQb7zOs1wO+Hv3F3Ei67GymszOMxFuXybytKmZxKFjm5I45Rczp3Ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740492901; c=relaxed/simple;
	bh=+035asVq2cxln6cQ58kGp3DD4QTDg0lBGUxK768xxPA=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=eTZwNiffY9cVZ6coFLBt4mmdpE4CueZWsLWmfw88Yk7KTBck1xQh7E3Mr4DKVKrcM0YW8vbRRgpdWiibosvLEKu0asZYpwWxAqLbuejWSQUCeR47E6PJR/CMBdMbUi0hpGTS/cjqMHkNy3G8XUeX9SODfrFb1b1WzKQ1Hss/Mf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=2/kGHnxa; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=k6aCjhhO; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 25 Feb 2025 14:14:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740492897;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LIcfAAvaX2I1vLPgxgFdi4ri+8uIld27xT+PmxqyfcA=;
	b=2/kGHnxaBKu+p+swcKkSSdJ5dNvyWLe36rZQye+VPqiKI1RD4RQjlbE5zr2j/7b/MQQxdl
	V7Kevm9dxgQvOgEX67uPpGMWiEcRMPG1L7l2oA2mTYM+dsYo4KtNIGKhDEJ+/azCcoH4Ok
	eA0ylDzy7J5uQkOpxo48LrkccgBAwSF4mw6BQajYkhu1RFn9L7F6JKMd8lxR5w/LFnuFOJ
	xZOzt6j2yYDUk8+VJFeCt3w8Yjy6llvV/YtOXmS6MEgo9sHEWJFSYIibdpVR/97l5wkedT
	gbLKDI1FTPGt8788xBn/mtznHd9fHu8ktHR09sguzhQa0S/Oae1Jzj+0TtU8kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740492897;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LIcfAAvaX2I1vLPgxgFdi4ri+8uIld27xT+PmxqyfcA=;
	b=k6aCjhhOZ+R7YcsA6uBjsSDWjlIhVcYNJSP5myMTj4Zv42VwX24a8lQ2EMWHVSobX8mEEe
	rEUNTixaze7G7HAA==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel: New start period for the freq mode
Cc: Kan Liang <kan.liang@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250117151913.3043942-3-kan.liang@linux.intel.com>
References: <20250117151913.3043942-3-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174049289305.10177.5945609508670753411.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     287b2d17fa77c812812fefd47ee22f90d9922e91
Gitweb:        https://git.kernel.org/tip/287b2d17fa77c812812fefd47ee22f90d9922e91
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 17 Jan 2025 07:19:13 -08:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Tue, 25 Feb 2025 14:54:14 +01:00

perf/x86/intel: New start period for the freq mode

Freqency mode is the current default mode of Linux perf. A period of 1 is
used as a starting period. The period is auto-adjusted on each tick or an
overflow, to meet the frequency target.

The start period of 1 is too low and may trigger some issues:

- Many HWs do not support period 1 well.
  https://lore.kernel.org/lkml/875xs2oh69.ffs@tglx/

- For an event that occurs frequently, period 1 is too far away from the
  real period. Lots of samples are generated at the beginning.
  The distribution of samples may not be even.

- A low starting period for frequently occurring events also challenges
  virtualization, which has a longer path to handle a PMI.

The limit_period value only checks the minimum acceptable value for HW.
It cannot be used to set the start period, because some events may
need a very low period. The limit_period cannot be set too high. It
doesn't help with the events that occur frequently.

It's hard to find a universal starting period for all events. The idea
implemented by this patch is to only give an estimate for the popular
HW and HW cache events. For the rest of the events, start from the lowest
possible recommended value.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250117151913.3043942-3-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 85 +++++++++++++++++++++++++++++++++++-
 1 file changed, 85 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index cdcebf3..cdb19e3 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3952,6 +3952,85 @@ static inline bool intel_pmu_has_cap(struct perf_event *event, int idx)
 	return test_bit(idx, (unsigned long *)&intel_cap->capabilities);
 }
 
+static u64 intel_pmu_freq_start_period(struct perf_event *event)
+{
+	int type = event->attr.type;
+	u64 config, factor;
+	s64 start;
+
+	/*
+	 * The 127 is the lowest possible recommended SAV (sample after value)
+	 * for a 4000 freq (default freq), according to the event list JSON file.
+	 * Also, assume the workload is idle 50% time.
+	 */
+	factor = 64 * 4000;
+	if (type != PERF_TYPE_HARDWARE && type != PERF_TYPE_HW_CACHE)
+		goto end;
+
+	/*
+	 * The estimation of the start period in the freq mode is
+	 * based on the below assumption.
+	 *
+	 * For a cycles or an instructions event, 1GHZ of the
+	 * underlying platform, 1 IPC. The workload is idle 50% time.
+	 * The start period = 1,000,000,000 * 1 / freq / 2.
+	 *		    = 500,000,000 / freq
+	 *
+	 * Usually, the branch-related events occur less than the
+	 * instructions event. According to the Intel event list JSON
+	 * file, the SAV (sample after value) of a branch-related event
+	 * is usually 1/4 of an instruction event.
+	 * The start period of branch-related events = 125,000,000 / freq.
+	 *
+	 * The cache-related events occurs even less. The SAV is usually
+	 * 1/20 of an instruction event.
+	 * The start period of cache-related events = 25,000,000 / freq.
+	 */
+	config = event->attr.config & PERF_HW_EVENT_MASK;
+	if (type == PERF_TYPE_HARDWARE) {
+		switch (config) {
+		case PERF_COUNT_HW_CPU_CYCLES:
+		case PERF_COUNT_HW_INSTRUCTIONS:
+		case PERF_COUNT_HW_BUS_CYCLES:
+		case PERF_COUNT_HW_STALLED_CYCLES_FRONTEND:
+		case PERF_COUNT_HW_STALLED_CYCLES_BACKEND:
+		case PERF_COUNT_HW_REF_CPU_CYCLES:
+			factor = 500000000;
+			break;
+		case PERF_COUNT_HW_BRANCH_INSTRUCTIONS:
+		case PERF_COUNT_HW_BRANCH_MISSES:
+			factor = 125000000;
+			break;
+		case PERF_COUNT_HW_CACHE_REFERENCES:
+		case PERF_COUNT_HW_CACHE_MISSES:
+			factor = 25000000;
+			break;
+		default:
+			goto end;
+		}
+	}
+
+	if (type == PERF_TYPE_HW_CACHE)
+		factor = 25000000;
+end:
+	/*
+	 * Usually, a prime or a number with less factors (close to prime)
+	 * is chosen as an SAV, which makes it less likely that the sampling
+	 * period synchronizes with some periodic event in the workload.
+	 * Minus 1 to make it at least avoiding values near power of twos
+	 * for the default freq.
+	 */
+	start = DIV_ROUND_UP_ULL(factor, event->attr.sample_freq) - 1;
+
+	if (start > x86_pmu.max_period)
+		start = x86_pmu.max_period;
+
+	if (x86_pmu.limit_period)
+		x86_pmu.limit_period(event, &start);
+
+	return start;
+}
+
 static int intel_pmu_hw_config(struct perf_event *event)
 {
 	int ret = x86_pmu_hw_config(event);
@@ -3963,6 +4042,12 @@ static int intel_pmu_hw_config(struct perf_event *event)
 	if (ret)
 		return ret;
 
+	if (event->attr.freq && event->attr.sample_freq) {
+		event->hw.sample_period = intel_pmu_freq_start_period(event);
+		event->hw.last_period = event->hw.sample_period;
+		local64_set(&event->hw.period_left, event->hw.sample_period);
+	}
+
 	if (event->attr.precise_ip) {
 		if ((event->attr.config & INTEL_ARCH_EVENT_MASK) == INTEL_FIXED_VLBR_EVENT)
 			return -EINVAL;

