Return-Path: <linux-tip-commits+bounces-3754-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B33CA4ADA6
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Mar 2025 21:08:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 314341894A5A
	for <lists+linux-tip-commits@lfdr.de>; Sat,  1 Mar 2025 20:08:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 696191EA7D6;
	Sat,  1 Mar 2025 20:07:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WLJJJq1E";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="gw5nIJAZ"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB571E9906;
	Sat,  1 Mar 2025 20:07:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740859657; cv=none; b=bfGRN+XaWymwTjCC1xCn2ZyffUKWAfpZbL4TsiMw+jsZY4pRMLxbcHxAsBlogsyxWHDMU3Gq8aGBOu5OcohWsG/bEPyLGVvA/Goy66Au2WGfZPDwrt/dWKk0mqV73NYUK1pRiwoH9HLfCLK4LofoEsjZp489NdmyT4jA/FIZu+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740859657; c=relaxed/simple;
	bh=StIZGEb4ic/H2cmYGZ/TyOyDK52KcGWJF4mwZ+qfit0=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qgtsypzChGg6u78+KpaRbClVxx8fph0jeWZiOtRIlnT4/c6sTXl7wURCU4+5G3fjmUFRowqpMLIZW2qfMsPQVQhSinjIXy9gJeAp0Kf6dCNNMy0HZ2Of3VBeTTRRJQ9pHm2UQ/FmxzX0UYXrjN5AvOSn2IJy9+8BvzyA09C9TkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WLJJJq1E; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=gw5nIJAZ; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 01 Mar 2025 20:07:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1740859653;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RX2f5EfL3rXOWJMkXmUHx9UJal6rsy9W8BOmLbbTUkA=;
	b=WLJJJq1EbJkKBUV9sX5UmyFvwHl2dhFEQhmEjLDYwFzDwwqEbFuLrzH2ktZLIyrnU0qcYu
	/c1Tbb9LIhOrMdT8CJX99Jr+tc+rCAroC36iFq97IGnKkIvne/EXwcpxDzi+haR9zhAddH
	zF7ypNS1IbcDTk1SOaSvKYAYK1fj8YsklIg7v27O+XS3/GNZfYFHMOM3TkpnPgFehUu7E1
	wJTa4+ifuaMHPQFn0Q1LMBJHHC6+oxoQdT/nn1DeC0dZJHgMqYLp+Wl5WBt5nSHb6vSuyp
	QnvaZq22SdrhLvB+bm9KcHdZu+EksdioxSuU5aCRD53fgRNkkNOIDiWGXwF9tg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1740859653;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RX2f5EfL3rXOWJMkXmUHx9UJal6rsy9W8BOmLbbTUkA=;
	b=gw5nIJAZlI3k0aecAi3mOaslNiN4uBwwgwO9Xw23KNu/sl7npI1r2gmWbjIH5yaNJEoHay
	W/GdMzNXR34UzpBQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/core: Merge struct pmu::pmu_disable_count into
 struct perf_cpu_pmu_context::pmu_disable_count
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241104135518.518730578@infradead.org>
References: <20241104135518.518730578@infradead.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174085965291.10177.5103031623453156623.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     46cc0835d258934bcad1fa921c2688db98b2dabd
Gitweb:        https://git.kernel.org/tip/46cc0835d258934bcad1fa921c2688db98b2dabd
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 04 Nov 2024 14:39:18 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Sat, 01 Mar 2025 20:00:11 +01:00

perf/core: Merge struct pmu::pmu_disable_count into struct perf_cpu_pmu_context::pmu_disable_count

Because it makes no sense to have two per-cpu allocations per pmu.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20241104135518.518730578@infradead.org
---
 include/linux/perf_event.h |  2 +-
 kernel/events/core.c       | 12 ++++--------
 2 files changed, 5 insertions(+), 9 deletions(-)

diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 8c0117b..5f293e6 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -343,7 +343,6 @@ struct pmu {
 	 */
 	unsigned int			scope;
 
-	int __percpu			*pmu_disable_count;
 	struct perf_cpu_pmu_context __percpu *cpu_pmu_context;
 	atomic_t			exclusive_cnt; /* < 0: cpu; > 0: tsk */
 	int				task_ctx_nr;
@@ -1031,6 +1030,7 @@ struct perf_cpu_pmu_context {
 
 	int				active_oncpu;
 	int				exclusive;
+	int				pmu_disable_count;
 
 	raw_spinlock_t			hrtimer_lock;
 	struct hrtimer			hrtimer;
diff --git a/kernel/events/core.c b/kernel/events/core.c
index 348a379..8321b71 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -1219,21 +1219,22 @@ static int perf_mux_hrtimer_restart_ipi(void *arg)
 
 void perf_pmu_disable(struct pmu *pmu)
 {
-	int *count = this_cpu_ptr(pmu->pmu_disable_count);
+	int *count = &this_cpu_ptr(pmu->cpu_pmu_context)->pmu_disable_count;
 	if (!(*count)++)
 		pmu->pmu_disable(pmu);
 }
 
 void perf_pmu_enable(struct pmu *pmu)
 {
-	int *count = this_cpu_ptr(pmu->pmu_disable_count);
+	int *count = &this_cpu_ptr(pmu->cpu_pmu_context)->pmu_disable_count;
 	if (!--(*count))
 		pmu->pmu_enable(pmu);
 }
 
 static void perf_assert_pmu_disabled(struct pmu *pmu)
 {
-	WARN_ON_ONCE(*this_cpu_ptr(pmu->pmu_disable_count) == 0);
+	int *count = &this_cpu_ptr(pmu->cpu_pmu_context)->pmu_disable_count;
+	WARN_ON_ONCE(*count == 0);
 }
 
 static inline void perf_pmu_read(struct perf_event *event)
@@ -11906,7 +11907,6 @@ static bool idr_cmpxchg(struct idr *idr, unsigned long id, void *old, void *new)
 
 static void perf_pmu_free(struct pmu *pmu)
 {
-	free_percpu(pmu->pmu_disable_count);
 	if (pmu_bus_running && pmu->dev && pmu->dev != PMU_NULL_DEV) {
 		if (pmu->nr_addr_filters)
 			device_remove_file(pmu->dev, &dev_attr_nr_addr_filters);
@@ -11925,10 +11925,6 @@ int perf_pmu_register(struct pmu *_pmu, const char *name, int type)
 	struct pmu *pmu __free(pmu_unregister) = _pmu;
 	guard(mutex)(&pmus_lock);
 
-	pmu->pmu_disable_count = alloc_percpu(int);
-	if (!pmu->pmu_disable_count)
-		return -ENOMEM;
-
 	if (WARN_ONCE(!name, "Can not register anonymous pmu.\n"))
 		return -EINVAL;
 

