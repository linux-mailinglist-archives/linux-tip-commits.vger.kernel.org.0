Return-Path: <linux-tip-commits+bounces-3757-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33181A4ADA9
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Mar 2025 21:08:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0006B1894032
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Mar 2025 20:08:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 119AE1EB183;
	Sat,  1 Mar 2025 20:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="zDCha87y";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ZtuXNiBH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9C061E9B08;
	Sat,  1 Mar 2025 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740859657; cv=none; b=JZXj73YkLEWtPVoqhPhR5yFBL1woPJVYG0/qQnJM0IKUT90jeLQQwOoXUtnVeVcuY2VaiSKBjiRah3+GpNJbRfzlWyUrkZWXEYNAXa3Jjb2vIwsktPAo9obSa7tMBvePHtvUbhTyBPF9wjEsM/YGP1Z4BVtSMpRgiEOur8IYnUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740859657; c=relaxed/simple;
	bh=JwZJzHhiQ7Z94VAB8wpXDGpa5KQMmYufv1thC0w579M=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=tpV4GjpT/9oDz4bFK7uIBvxjfjuWDUhSCibFoJkgs7S8jL5xBqvObjY07Gazlqnjrn5KRmgrzvlkdyORW9AX6ussGuK0iarXuBmCwURfO3oc+3p71y+k3VgVQZNcfCwHRiQuNIpBn6foZZ0nW35mJrOSMP7NbPESFc5OvTH2+PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=zDCha87y; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ZtuXNiBH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Mar 2025 20:07:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740859654;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z20tt95jdyXy5GthmJaT85ijipUAxH1eo4R0XWCM5h4=;
	b=zDCha87ymbqvTLtcP1ocKBb+nruTnr1HF8CjLEQX5dQgMfWGlItDXIFwNACleSg7BPDwq8
	Tm+HtG5YlCIxFkgka09W69XQtbAoSFQsao5p2D5T7FR9p1YRU5P8SA58AKEWdCf0aDu3/P
	gE/uFVaPGw0rzJR6PYf1aS8BQr09YaWttYn8ge2jAWFiIR4BHUrz5TpL5v6o2fWmCspXgq
	C1w9wxhCOnnPMv4J0ReV3iqgSGijKwcd6rKYIs+cULBVnMgQBNrnI6KxCVfKZ+EarDvtKF
	itBrqmErvkdhzybMYcy+1BddOj1DQFnTXbKpMkcvXf8toW64rwAl7abbJoWfvw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740859654;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Z20tt95jdyXy5GthmJaT85ijipUAxH1eo4R0XWCM5h4=;
	b=ZtuXNiBHoz/WmqckHONaKsCCGJrCEkZZvnt9GYem2G5+NMxMvo3ojYtOxvWwDfym/4cqDX
	j+qmEjF1c5Ydi3BA==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Simplify perf_event_alloc()
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241104135518.410755241@infradead.org>
References: <20241104135518.410755241@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174085965375.10177.14960924353010260131.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     ebfe83832e392f25b4fe1fedf816eebb76f1f5b4
Gitweb:        https://git.kernel.org/tip/ebfe83832e392f25b4fe1fedf816eebb76f1f5b4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 04 Nov 2024 14:39:17 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 01 Mar 2025 19:54:06 +01:00

perf/core: Simplify perf_event_alloc()

Using the previous simplifications, transition perf_event_alloc() to
the cleanup way of things -- reducing error path magic.

[ mingo: Ported it to recent kernels. ]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20241104135518.410755241@infradead.org
---
 kernel/events/core.c | 59 ++++++++++++++++---------------------------
 1 file changed, 22 insertions(+), 37 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index fd35236..348a379 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -5410,6 +5410,8 @@ static void __free_event(struct perf_event *event)
 	call_rcu(&event->rcu_head, free_event_rcu);
 }
 
+DEFINE_FREE(__free_event, struct perf_event *, if (_T) __free_event(_T))
+
 /* vs perf_event_alloc() success */
 static void _free_event(struct perf_event *event)
 {
@@ -12291,7 +12293,6 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		 void *context, int cgroup_fd)
 {
 	struct pmu *pmu;
-	struct perf_event *event;
 	struct hw_perf_event *hwc;
 	long err = -EINVAL;
 	int node;
@@ -12306,8 +12307,8 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	}
 
 	node = (cpu >= 0) ? cpu_to_node(cpu) : -1;
-	event = kmem_cache_alloc_node(perf_event_cache, GFP_KERNEL | __GFP_ZERO,
-				      node);
+	struct perf_event *event __free(__free_event) =
+		kmem_cache_alloc_node(perf_event_cache, GFP_KERNEL | __GFP_ZERO, node);
 	if (!event)
 		return ERR_PTR(-ENOMEM);
 
@@ -12414,65 +12415,53 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	 * See perf_output_read().
 	 */
 	if (has_inherit_and_sample_read(attr) && !(attr->sample_type & PERF_SAMPLE_TID))
-		goto err;
+		return ERR_PTR(-EINVAL);
 
 	if (!has_branch_stack(event))
 		event->attr.branch_sample_type = 0;
 
 	pmu = perf_init_event(event);
-	if (IS_ERR(pmu)) {
-		err = PTR_ERR(pmu);
-		goto err;
-	}
+	if (IS_ERR(pmu))
+		return (void*)pmu;
 
 	/*
 	 * Disallow uncore-task events. Similarly, disallow uncore-cgroup
 	 * events (they don't make sense as the cgroup will be different
 	 * on other CPUs in the uncore mask).
 	 */
-	if (pmu->task_ctx_nr == perf_invalid_context && (task || cgroup_fd != -1)) {
-		err = -EINVAL;
-		goto err;
-	}
+	if (pmu->task_ctx_nr == perf_invalid_context && (task || cgroup_fd != -1))
+		return ERR_PTR(-EINVAL);
 
 	if (event->attr.aux_output &&
 	    (!(pmu->capabilities & PERF_PMU_CAP_AUX_OUTPUT) ||
-	     event->attr.aux_pause || event->attr.aux_resume)) {
-		err = -EOPNOTSUPP;
-		goto err;
-	}
+	     event->attr.aux_pause || event->attr.aux_resume))
+		return ERR_PTR(-EOPNOTSUPP);
 
-	if (event->attr.aux_pause && event->attr.aux_resume) {
-		err = -EINVAL;
-		goto err;
-	}
+	if (event->attr.aux_pause && event->attr.aux_resume)
+		return ERR_PTR(-EINVAL);
 
 	if (event->attr.aux_start_paused) {
-		if (!(pmu->capabilities & PERF_PMU_CAP_AUX_PAUSE)) {
-			err = -EOPNOTSUPP;
-			goto err;
-		}
+		if (!(pmu->capabilities & PERF_PMU_CAP_AUX_PAUSE))
+			return ERR_PTR(-EOPNOTSUPP);
 		event->hw.aux_paused = 1;
 	}
 
 	if (cgroup_fd != -1) {
 		err = perf_cgroup_connect(cgroup_fd, event, attr, group_leader);
 		if (err)
-			goto err;
+			return ERR_PTR(err);
 	}
 
 	err = exclusive_event_init(event);
 	if (err)
-		goto err;
+		return ERR_PTR(err);
 
 	if (has_addr_filter(event)) {
 		event->addr_filter_ranges = kcalloc(pmu->nr_addr_filters,
 						    sizeof(struct perf_addr_filter_range),
 						    GFP_KERNEL);
-		if (!event->addr_filter_ranges) {
-			err = -ENOMEM;
-			goto err;
-		}
+		if (!event->addr_filter_ranges)
+			return ERR_PTR(-ENOMEM);
 
 		/*
 		 * Clone the parent's vma offsets: they are valid until exec()
@@ -12496,23 +12485,19 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 		if (event->attr.sample_type & PERF_SAMPLE_CALLCHAIN) {
 			err = get_callchain_buffers(attr->sample_max_stack);
 			if (err)
-				goto err;
+				return ERR_PTR(err);
 			event->attach_state |= PERF_ATTACH_CALLCHAIN;
 		}
 	}
 
 	err = security_perf_event_alloc(event);
 	if (err)
-		goto err;
+		return ERR_PTR(err);
 
 	/* symmetric to unaccount_event() in _free_event() */
 	account_event(event);
 
-	return event;
-
-err:
-	__free_event(event);
-	return ERR_PTR(err);
+	return_ptr(event);
 }
 
 static int perf_copy_attr(struct perf_event_attr __user *uattr,

