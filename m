Return-Path: <linux-tip-commits+bounces-5779-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id E911FAD8387
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 09:02:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 5AB5D7AA020
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 07:00:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 082FE2248A4;
	Fri, 13 Jun 2025 07:00:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="nXugKei7";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="xpkN7uRX"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C1225B2E7;
	Fri, 13 Jun 2025 07:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749798014; cv=none; b=mu+WPf01E/NBsgRicz8pLiAU9qYeaefklBz4tLzFPaEEuThDZ3uuWbjQDFZ4tl6kGXGX3llIQ5jJX+/7vTZtgZAsbkV1wXZ49aA7UHa94R8cfyvidJhPjYmkzenziFWrfcRYeJ+wfPezBw7c+kpHh2A/c/mOn3X0uwIypalE3MA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749798014; c=relaxed/simple;
	bh=DeOmYTSoKgBkmYi9I5R5quW70ynWeDv7CtQf+tfZ4vE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=f0wWczY3ccq9CYywYzgXo045qFgw5BGq39YRKRP99S9gRWMzA5ucZDEc9I58nzMot6X//BC/Z3oBkwyBi62gCj2AavP9ZkDodL06uXQum9O+qq+ysnDOotQTljquMjdtI+mNU5f0kc/i67FACevVS0+drKM/kxpe1/1vZt/7EMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=nXugKei7; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=xpkN7uRX; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 07:00:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749798002;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ftHLU2dio7N6OSbWClpfkNKh90adIr1QvhYTKh536ow=;
	b=nXugKei7IhCTL5Ys3wktoDGOmp8pUQYE7TPtlVtkHnQygrglvXbhZf5jzVLQK6n2FeyXq6
	HE17HOFRNMbFCHIN+abQgamXWJIj39jIQjRSR02lMDHDA8qOln07JgJU11ps/sXKZs83Bl
	PM0tSHtvAcTgsNReBOqr6wj3Pv9M2/Z5VMocgkfsCtopYW7rGlkBPZevPdc0m+Afpzaq8U
	utzaMb8g8JqpEd7kxR5y5qX3p4ow4d5UjTf+bd3Z2eAqDV1lQnACKroY/RuIvHD6CkC11T
	7Urh1TaplKqPTtTrMnVc1uijknCHPtrq3C1HGvLp/KUAHLLCAKubsx1EJF/upQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749798002;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ftHLU2dio7N6OSbWClpfkNKh90adIr1QvhYTKh536ow=;
	b=xpkN7uRXWSMSKt1klGaYMdXXlWD9hbPULP+twFjWLvyYaGSA74qgKS0oLiF0YYSFOqE+k2
	rg5eNrCBvJumn9BQ==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel: Fix crashing bug in
 icl_update_topdown_event
Cc: Vince Weaver <vincent.weaver@maine.edu>,
 Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250612143818.2889040-1-kan.liang@linux.intel.com>
References: <20250612143818.2889040-1-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174979800111.406.4606845775414969638.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     e49460a2d03fd8689ce5f7f2d79ff159734ad563
Gitweb:        https://git.kernel.org/tip/e49460a2d03fd8689ce5f7f2d79ff159734ad563
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 12 Jun 2025 07:38:18 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 13 Jun 2025 08:54:21 +02:00

perf/x86/intel: Fix crashing bug in icl_update_topdown_event

The perf_fuzzer found a hard-lock crash on a RaptorLake machine.

  Oops: general protection fault, maybe for address 0xffff89aeceab400: 0000
  CPU: 23 UID: 0 PID: 0 Comm: swapper/23
  Tainted: [W]=WARN
  Hardware name: Dell Inc. Precision 9660/0VJ762
  RIP: 0010:native_read_pmc+0x7/0x40
  Code: cc e8 8d a9 01 00 48 89 03 5b cd cc cc cc cc 0f 1f ...
  RSP: 000:fffb03100273de8 EFLAGS: 00010046
  ....
  Call Trace:
    <TASK>
    icl_update_topdown_event+0x165/0x190
    ? ktime_get+0x38/0xd0
    intel_pmu_read_event+0xf9/0x210
    __perf_event_read+0xf9/0x210

The CPUs 16-23 are E-core CPUs that don't support perf metrics feature.
The icl_update_topdown_event() should not be invoked.

It's an regression of the commit f9bdf1f95339 ("perf/x86/intel: Avoid
disable PMU if !cpuc->enabled in sample read"). The is_topdown_event()
is mistakenly used to replace the is_topdown_count() to check if the
topdown functions for the perf metrics feature should be invoked.  The
is_topdown_event() only checks the event encoding. It's possible that
the same encoding 0x0400 is created on an e-core CPU (although there
is no valid event with such encoding on e-core).  The
is_topdown_count() checks the PERF_X86_EVENT_TOPDOWN flag. Only when
the topdown events require the perf metrics magic, the flag is set.

It should be a typo when merging the intel_pmu_auto_reload_read() and
intel_pmu_read_topdown_event() in the commit.

Fixes: f9bdf1f95339 ("perf/x86/intel: Avoid disable PMU if !cpuc->enabled in sample read")
Closes: https://lore.kernel.org/lkml/352f0709-f026-cd45-e60c-60dfd97f73f3@maine.edu/
Reported-by: Vince Weaver <vincent.weaver@maine.edu>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Vince Weaver <vincent.weaver@maine.edu>
Link: https://lore.kernel.org/r/20250612143818.2889040-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 741b229..c2fb729 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2826,7 +2826,7 @@ static void intel_pmu_read_event(struct perf_event *event)
 		 * If the PEBS counters snapshotting is enabled,
 		 * the topdown event is available in PEBS records.
 		 */
-		if (is_topdown_event(event) && !is_pebs_counter_event_group(event))
+		if (is_topdown_count(event) && !is_pebs_counter_event_group(event))
 			static_call(intel_pmu_update_topdown_event)(event, NULL);
 		else
 			intel_pmu_drain_pebs_buffer();

