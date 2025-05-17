Return-Path: <linux-tip-commits+bounces-5661-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A708ABAA1A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 14:59:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CF01F9E0F2D
	for <lists+linux-tip-commits@lfdr.de>; Sat, 17 May 2025 12:59:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74A4C1DF97D;
	Sat, 17 May 2025 12:59:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="0Om75EA5";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ORIuqj1K"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C381D10E9;
	Sat, 17 May 2025 12:59:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747486791; cv=none; b=a6Pb4W0yCONCyOg/GMixe/+kakaH5Pq1e+FK48T+jNJcf3mFg0i54Pc0ff8WqMtXpY6HddwTJ4ax2CT2sL3ecJsD5K9BJlP03olAC4IItIFyOjOiM6QjZAiDEbcNd/vvSJtqp/YO7YmLEM5LYoo811Q1ZZeUJSQv9q9V2jSZfuw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747486791; c=relaxed/simple;
	bh=0mMDRy1b2yRgy90TvSbSKUlqY37D7lYIjf2FijldRz8=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Chy38ZSuTP98KE/Ij0uY2EiEExCfFfnC21eN4cijAuZE6aaj0/QRDG5zipg6clsNXbPpYOxSfFf5zg+dE0kjr9WHjmz68Dbewd2F5HSr3Pm3+vi/hTXktSAzC6oVS4u1DVbI4yTChH8ozZGAxUfKgSdaVajHQj+V+h3KDP+yHZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=0Om75EA5; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ORIuqj1K; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 17 May 2025 12:59:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747486787;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NSUOBKxZ6phfUyk3cllQ+R4FMe5a+C7SOJL6FYLJ9/w=;
	b=0Om75EA5d54u688lpANlfIq5ZFsHhBy8UKmZQtQCXiOIl6CHEvPPqYvnQJlpmKz9SnZiqU
	iyvRGYe+gpDWkwXgAZAP0fBvl+KC/8BvdZUZaTjFFyyMV6kJpjL1+Lexa3VF2AaPv1IV3C
	QtLLXGNkKPFiDtGjIWRewkZNqqUpo89wdBk007hU2MmbE069HtaOLomv0+oaYfrSAHzDc8
	1j7RoL8FWvxSDHA8j5t+LCza7XwP+RWivWCcKUpM44l68/mzY/fCUpaZ0t8zk8G8mbg2Io
	2UNTuWozH6tIpi4ig7Rrhtk1G4D/LI2M1PXIXfJGcSxnssXtcNXDqYuMlHs4gw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747486787;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NSUOBKxZ6phfUyk3cllQ+R4FMe5a+C7SOJL6FYLJ9/w=;
	b=ORIuqj1KoAyjGte6x0pYf4OBsuaPrucgry8Odv3bWqt38PJHFMyUF2o8i1mUqfme+rFvh3
	1I+K1vbNjaBdwdBw==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Add the is_event_in_freq_mode() helper to
 simplify the code
Cc: Kan Liang <kan.liang@linux.intel.com>, Ingo Molnar <mingo@kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250516182853.2610284-2-kan.liang@linux.intel.com>
References: <20250516182853.2610284-2-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174748678630.406.13302797229812275159.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     ca559503b89c30bc49178d0e4a1e0b23f991fb9f
Gitweb:        https://git.kernel.org/tip/ca559503b89c30bc49178d0e4a1e0b23f991fb9f
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Fri, 16 May 2025 11:28:38 -07:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 17 May 2025 10:02:27 +02:00

perf/core: Add the is_event_in_freq_mode() helper to simplify the code

Add a helper to check if an event is in freq mode to improve readability.

No functional changes.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250516182853.2610284-2-kan.liang@linux.intel.com
---
 kernel/events/core.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index b846107..952340f 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -2351,6 +2351,11 @@ event_filter_match(struct perf_event *event)
 	       perf_cgroup_match(event);
 }
 
+static inline bool is_event_in_freq_mode(struct perf_event *event)
+{
+	return event->attr.freq && event->attr.sample_freq;
+}
+
 static void
 event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
 {
@@ -2388,7 +2393,7 @@ event_sched_out(struct perf_event *event, struct perf_event_context *ctx)
 
 	if (!is_software_event(event))
 		cpc->active_oncpu--;
-	if (event->attr.freq && event->attr.sample_freq) {
+	if (is_event_in_freq_mode(event)) {
 		ctx->nr_freq--;
 		epc->nr_freq--;
 	}
@@ -2686,7 +2691,7 @@ event_sched_in(struct perf_event *event, struct perf_event_context *ctx)
 
 	if (!is_software_event(event))
 		cpc->active_oncpu++;
-	if (event->attr.freq && event->attr.sample_freq) {
+	if (is_event_in_freq_mode(event)) {
 		ctx->nr_freq++;
 		epc->nr_freq++;
 	}
@@ -4252,11 +4257,11 @@ static void perf_adjust_freq_unthr_events(struct list_head *event_list)
 		if (hwc->interrupts == MAX_INTERRUPTS) {
 			hwc->interrupts = 0;
 			perf_log_throttle(event, 1);
-			if (!event->attr.freq || !event->attr.sample_freq)
+			if (!is_event_in_freq_mode(event))
 				event->pmu->start(event, 0);
 		}
 
-		if (!event->attr.freq || !event->attr.sample_freq)
+		if (!is_event_in_freq_mode(event))
 			continue;
 
 		/*
@@ -12848,7 +12853,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 
 	hwc = &event->hw;
 	hwc->sample_period = attr->sample_period;
-	if (attr->freq && attr->sample_freq)
+	if (is_event_in_freq_mode(event))
 		hwc->sample_period = 1;
 	hwc->last_period = hwc->sample_period;
 

