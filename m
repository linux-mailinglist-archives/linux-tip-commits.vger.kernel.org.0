Return-Path: <linux-tip-commits+bounces-4750-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E083A81555
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 21:05:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 61C781BA2221
	for <lists+linux-tip-commits@lfdr.de>; Tue,  8 Apr 2025 19:05:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433D824290C;
	Tue,  8 Apr 2025 19:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dzKU7ZBy";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PlLwO5n6"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A2023E33E;
	Tue,  8 Apr 2025 19:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744139103; cv=none; b=aKnFHuV3mWaKJEqbbzcOdzErJvFueoBl8QX9EBrMj4BTZRvxPyoPZyCGGj4nxBRRpqDDa83EdJaI/STgTqVTpCHK8KCrOW/tqPJAjXrauYM3ipcJ/o86rXsMf76+AiEaZ+kyRx7xYjOqEFjco9bNVd64jElVHE1PFMC731wGjVQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744139103; c=relaxed/simple;
	bh=etO5Rxr3kbo5q6ARLiFeArHUNwzsPkinNqgy/kQzHac=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QWrwR0I8HEjoWd0R5FaINrm1614DpDt+F0BX0nMNGwJ7ynJbLhtDlfkSKUovzaO6tajQ6uQ5vEPXmfXCcmeKZZ+173+5oQHc4wmSttm25cA3P0O431Q/ZMUU/ovU1xhDmS9UOIBuiBTcDeBT11SaRa0nFkwpTaYh8COdWLrqQq8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dzKU7ZBy; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PlLwO5n6; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 08 Apr 2025 19:04:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744139099;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SPrIBgTQZjtEiBLIySu/QU1Um6Vtg8RowcyIdRcgf28=;
	b=dzKU7ZByMyoRCEGl8QV4ZaiR+uaBEAIQYfd1mUNHzCyWbhWGXVjhbpsKyj8vJiaI5Y/Ed8
	1piia/Gg6yHtIj1aUNaHtWWCvcUCkOEzm7TkdvT07wmWBVYW4zIlppKg8rfb6BlB41t9eP
	fJgPYUMnogB1ICJWjvZDgi35SjnOUVrJ76LawurqQVLi6bbLIC+Q+GDXcQ89x31YE0yV57
	RrTWkjFVkpx7CfvFIeWkR7EFaNPOfq4KtHFTEQSPVzuq0iLeFbpHI7VEx8BaxZdo8d1uie
	c76P76rRkyGBd30ea+Q9kjBVSSz6YqaU0nPCpChh+QRJTAOhiYNnp32wueN7Lw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744139099;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SPrIBgTQZjtEiBLIySu/QU1Um6Vtg8RowcyIdRcgf28=;
	b=PlLwO5n6fuagqrSF9BhtpyV30lZZ8qvQKecDPb0sv7LNonNfJwu58xc8k5/Q29jeoBSla4
	XhgqFXawAC0kUmCg==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/intel: Track the num of events needs late setup
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Thomas Falcon <thomas.falcon@intel.com>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250327195217.2683619-3-kan.liang@linux.intel.com>
References: <20250327195217.2683619-3-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174413909896.31282.5281771887955722948.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     0a6557938d8f189024a03aca77e58763930840ee
Gitweb:        https://git.kernel.org/tip/0a6557938d8f189024a03aca77e58763930840ee
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 27 Mar 2025 12:52:14 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 08 Apr 2025 20:55:48 +02:00

perf/x86/intel: Track the num of events needs late setup

When a machine supports PEBS v6, perf unconditionally searches the
cpuc->event_list[] for every event and check if the late setup is
required, which is unnecessary.

The late setup is only required for special events, e.g., events support
counters snapshotting feature. Add n_late_setup to track the num of
events that needs the late setup.

Other features, e.g., auto counter reload feature, require the late
setup as well. Add a wrapper, intel_pmu_pebs_late_setup, for the events
that support counters snapshotting feature.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Thomas Falcon <thomas.falcon@intel.com>
Link: https://lkml.kernel.org/r/20250327195217.2683619-3-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 14 ++++++++++++++
 arch/x86/events/intel/ds.c   |  3 +--
 arch/x86/events/perf_event.h |  5 +++++
 3 files changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 9724928..6105024 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2603,6 +2603,8 @@ static void intel_pmu_del_event(struct perf_event *event)
 		intel_pmu_lbr_del(event);
 	if (event->attr.precise_ip)
 		intel_pmu_pebs_del(event);
+	if (is_pebs_counter_event_group(event))
+		this_cpu_ptr(&cpu_hw_events)->n_late_setup--;
 }
 
 static int icl_set_topdown_event_period(struct perf_event *event)
@@ -2914,12 +2916,24 @@ static void intel_pmu_enable_event(struct perf_event *event)
 	}
 }
 
+void intel_pmu_late_setup(void)
+{
+	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
+
+	if (!cpuc->n_late_setup)
+		return;
+
+	intel_pmu_pebs_late_setup(cpuc);
+}
+
 static void intel_pmu_add_event(struct perf_event *event)
 {
 	if (event->attr.precise_ip)
 		intel_pmu_pebs_add(event);
 	if (intel_pmu_needs_branch_stack(event))
 		intel_pmu_lbr_add(event);
+	if (is_pebs_counter_event_group(event))
+		this_cpu_ptr(&cpu_hw_events)->n_late_setup++;
 }
 
 /*
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 1f7e1a6..486881f 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -1355,9 +1355,8 @@ static void __intel_pmu_pebs_update_cfg(struct perf_event *event,
 }
 
 
-static void intel_pmu_late_setup(void)
+void intel_pmu_pebs_late_setup(struct cpu_hw_events *cpuc)
 {
-	struct cpu_hw_events *cpuc = this_cpu_ptr(&cpu_hw_events);
 	struct perf_event *event;
 	u64 pebs_data_cfg = 0;
 	int i;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index f5ba165..4410cf0 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -261,6 +261,7 @@ struct cpu_hw_events {
 	struct event_constraint	*event_constraint[X86_PMC_IDX_MAX];
 
 	int			n_excl; /* the number of exclusive events */
+	int			n_late_setup; /* the num of events needs late setup */
 
 	unsigned int		txn_flags;
 	int			is_fake;
@@ -1581,6 +1582,8 @@ void intel_pmu_disable_bts(void);
 
 int intel_pmu_drain_bts_buffer(void);
 
+void intel_pmu_late_setup(void);
+
 u64 grt_latency_data(struct perf_event *event, u64 status);
 
 u64 cmt_latency_data(struct perf_event *event, u64 status);
@@ -1637,6 +1640,8 @@ void intel_pmu_pebs_disable_all(void);
 
 void intel_pmu_pebs_sched_task(struct perf_event_pmu_context *pmu_ctx, bool sched_in);
 
+void intel_pmu_pebs_late_setup(struct cpu_hw_events *cpuc);
+
 void intel_pmu_drain_pebs_buffer(void);
 
 void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr);

