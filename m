Return-Path: <linux-tip-commits+bounces-4780-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 72C54A823C7
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 13:43:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3CBEC1B8730B
	for <lists+linux-tip-commits@lfdr.de>; Wed,  9 Apr 2025 11:43:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB902566CB;
	Wed,  9 Apr 2025 11:43:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fVGkFW0h";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NxImjkab"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4221025DCE9;
	Wed,  9 Apr 2025 11:43:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744199002; cv=none; b=PVlRgvJLa73xFaUHdn751GE1BUI4sQfAGzZkT6rZ+J/NOMUkfvDeZuDzdRYI7gzh5B0lQYx88Vad1TQzEObQ/IY3OipRk0gPRod1PmZ4N1483ea7O7DryExLtM8z8x0y3NWyBw90amR4DkJQJ6WWpFNqOhY8N12ADvZV1GcUS4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744199002; c=relaxed/simple;
	bh=GCEzTCN8j1TFCLA47hW6Uzx/74x4tdL8sxO/xgJYB2A=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=O4ujeUglUWIf9wD4tkzFO/LDjqQjYXJnxBpCatWtJr5LMqRy8GbSpZsAGLaSgK/czAJXCEHcVuTp3EqAU7vBS9QLeODn3mJCdrwwycfBD7/rafB5QF5nTUVSYAtUmutQcCdW3edmtDsvMc/HypFAoruNorQiXZ1gCoaldDjGYZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fVGkFW0h; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=NxImjkab; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 09 Apr 2025 11:43:12 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744198998;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=124keJ7+ZcHJxug6ZEbsPoU9KgZKTJ+YIiBVjnFJwcI=;
	b=fVGkFW0hr1frKsCWhPukaZlYsTBe67XTgLMLrJRFkE0F8hUTWWMj9OXtSJSTSKK7IoH/32
	I/UExxpKpjm0H9kboTX/trdVw5esUFl/eLyM3FaiVX8DETKnVhXj69vRSIAWryDS5FIMsF
	qsbIQKekqv5d6tax6eEy/DDyQtTIvx3DaFA0pC3TYC+YAsaGsi0zEuZgQirlnnd4HAGgF1
	EOuYtrfGI/XDGOj4i9ovWKd6+tw/mihDSPZzuhPuYDNFMp7rY/+veRg9NGTuqz6AH+UX96
	Si+quWl/T9jxO/ts0Y6nkD9Vb/h4bslzwiarDjOVRoGzPkiQfob4VcqYDBPo1Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744198998;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=124keJ7+ZcHJxug6ZEbsPoU9KgZKTJ+YIiBVjnFJwcI=;
	b=NxImjkabTRsxpOO6l6hEItPhLvcgj7zCfPdL4//xt2F6W+xoactOpkBvoPhnWUrMJSA16U
	vEhfo6DPxj8bw6DQ==
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
Message-ID: <174419899320.31282.8132370167321915356.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     67e74815ee151e1caccd0b4fcdc6c3bb90c09354
Gitweb:        https://git.kernel.org/tip/67e74815ee151e1caccd0b4fcdc6c3bb90c09354
Author:        Mark Barnett <mark.barnett@arm.com>
AuthorDate:    Tue, 08 Apr 2025 18:15:26 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 09 Apr 2025 12:52:26 +02:00

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

