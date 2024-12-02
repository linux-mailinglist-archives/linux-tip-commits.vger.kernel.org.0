Return-Path: <linux-tip-commits+bounces-2913-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 22F2E9DFFFA
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:17:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D20FE280F7B
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:17:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6AEAD2040AD;
	Mon,  2 Dec 2024 11:14:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="jBHdmTb9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="3GAEboGN"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE26202F89;
	Mon,  2 Dec 2024 11:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138064; cv=none; b=ole5d1Cbt00DSXilFdNkyNVUd/3xnA+sMrbnIDlSQOOJ9V7+BttuKYvmfDsUaUsw6p++1n98GdnJu0VxfY0TUnTZbBGMbEbQYNrezySRW7OytItr2+RI6cWATS2cnm9tYdY4APhTHnm4KID3KXWmj+6ZlBDY+ylZzbNZKQ33vlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138064; c=relaxed/simple;
	bh=z3UHv6gCQLM1chxHYnq222GAr+iYbtDDHQriEvRCViQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=TOdW6qVSkl+HBdaK08we8bKxZj6YhsxZcXI+H43pXek/A6PcKqqsbHgpxBZbckTctoym2Kc/cJgOOj5e5wrCrIbtGIhObnBIY3MSsvM+zEuOjFHhx6wBAq5ypeJPXVNl17D89r2S/mveiWIj+4Nug+YcRVW/XRIxHdaouAk2L10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=jBHdmTb9; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=3GAEboGN; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:14:19 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138060;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R24HSpESnriYx1By+lEkQ7gAtELrPZksmqZEnQ/ha/k=;
	b=jBHdmTb96iTzDv0jWTSbiaJZB0SoYgzNJO1tkQSjDwUzd2elOk9hhbrvkKtKn6A+5EJehU
	OqF09amRzwxfeHneJtz9Kjn8fiSEbIDz5uBNecj6A7KGdQyB8oqxX3+cUSe1CdY0C5kLHk
	21hFKq9/JTae3TvMSHwGxfXf73hDwsKsO0Z42m94z8LkQYF9NG9DxksPAPMAB2CYKrXTZh
	6HWhPZFqV5MG4CGD+vMHRT7qyhr1CN4Upikoa9qXFu6/UbSuhnmeQ/3wBUuUmCq2L+0eT/
	AaNGasvRPMNEf0RUZ6t4xWLctC8iayxdcC5FD5Tlzg8CtEapsPJx+3uqWwXGiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138060;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=R24HSpESnriYx1By+lEkQ7gAtELrPZksmqZEnQ/ha/k=;
	b=3GAEboGNclYAHDzQw3nVDJJ4BoN2AsD7iHURbU3nZ8wNBTq+KjP/ygTgke7MixJvaTNsEw
	BYlkzad7F68jXsBQ==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/ds: Simplify the PEBS records
 processing for adaptive PEBS
Cc: Stephane Eranian <eranian@google.com>,
 Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Dapeng Mi <dapeng1.mi@linux.intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20241119135504.1463839-5-kan.liang@linux.intel.com>
References: <20241119135504.1463839-5-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313805993.412.3435947024790206212.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     ae55e308bde2267df79c4475daa85e174b7ab4c8
Gitweb:        https://git.kernel.org/tip/ae55e308bde2267df79c4475daa85e174b7ab4c8
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 19 Nov 2024 05:55:04 -08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:34 +01:00

perf/x86/intel/ds: Simplify the PEBS records processing for adaptive PEBS

The current code may iterate all the PEBS records in the DS area several
times. The first loop is to find all active events and calculate the
available records for each event. Then iterate the whole buffer again
and again to process available records until all active events are
processed.

The algorithm is inherited from the old generations. The old PEBS
hardware does not deal well with the situation when events happen near
each other. SW has to drop the error records. Multiple iterations are
required.

The hardware limit has been addressed on newer platforms with adaptive
PEBS. A simple one-iteration algorithm is introduced.

The samples are output by record order with the patch, rather than the
event order. It doesn't impact the post-processing. The perf tool always
sorts the records by time before presenting them to the end user.

In an NMI, the last record has to be specially handled. Add a last[]
variable to track the last unprocessed record of each event.

Test:

11 PEBS events are used in the perf test. Only the basic information is
collected.
perf record -e instructions:up,...,instructions:up -c 2000003 benchmark

The ftrace is used to record the duration of the
intel_pmu_drain_pebs_icl().

The average duration reduced from 62.04us to 57.94us.

A small improvement can be observed with the new algorithm.
Also, the implementation becomes simpler and more straightforward.

Suggested-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Link: https://lore.kernel.org/r/20241119135504.1463839-5-kan.liang@linux.intel.com
---
 arch/x86/events/intel/ds.c | 43 ++++++++++++++++++++++++-------------
 1 file changed, 29 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 79a3467..8dcf90f 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2425,8 +2425,12 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_data *data)
 {
 	short counts[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS] = {};
+	void *last[INTEL_PMC_IDX_FIXED + MAX_FIXED_PEBS_EVENTS];
 	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct debug_store *ds = cpuc->ds;
+	struct x86_perf_regs perf_regs;
+	struct pt_regs *regs = &perf_regs.regs;
+	struct pebs_basic *basic;
 	struct perf_event *event;
 	void *base, *at, *top;
 	int bit;
@@ -2448,30 +2452,41 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 		return;
 	}
 
-	for (at = base; at < top; at += cpuc->pebs_record_size) {
+	if (!iregs)
+		iregs = &dummy_iregs;
+
+	/* Process all but the last event for each counter. */
+	for (at = base; at < top; at += basic->format_size) {
 		u64 pebs_status;
 
-		pebs_status = get_pebs_status(at) & cpuc->pebs_enabled;
-		pebs_status &= mask;
+		basic = at;
+		if (basic->format_size != cpuc->pebs_record_size)
+			continue;
+
+		pebs_status = basic->applicable_counters & cpuc->pebs_enabled & mask;
+		for_each_set_bit(bit, (unsigned long *)&pebs_status, X86_PMC_IDX_MAX) {
+			event = cpuc->events[bit];
 
-		for_each_set_bit(bit, (unsigned long *)&pebs_status, X86_PMC_IDX_MAX)
-			counts[bit]++;
+			if (WARN_ON_ONCE(!event) ||
+			    WARN_ON_ONCE(!event->attr.precise_ip))
+				continue;
+
+			if (counts[bit]++) {
+				__intel_pmu_pebs_event(event, iregs, regs, data, last[bit],
+						       setup_pebs_adaptive_sample_data);
+			}
+			last[bit] = at;
+		}
 	}
 
 	for_each_set_bit(bit, (unsigned long *)&mask, X86_PMC_IDX_MAX) {
-		if (counts[bit] == 0)
+		if (!counts[bit])
 			continue;
 
 		event = cpuc->events[bit];
-		if (WARN_ON_ONCE(!event))
-			continue;
-
-		if (WARN_ON_ONCE(!event->attr.precise_ip))
-			continue;
 
-		__intel_pmu_pebs_events(event, iregs, data, base,
-					top, bit, counts[bit],
-					setup_pebs_adaptive_sample_data);
+		__intel_pmu_pebs_last_event(event, iregs, regs, data, last[bit],
+					    counts[bit], setup_pebs_adaptive_sample_data);
 	}
 }
 

