Return-Path: <linux-tip-commits+bounces-2910-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A5AB19DFFF4
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 12:16:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 65B682809E3
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Dec 2024 11:16:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D94032036ED;
	Mon,  2 Dec 2024 11:14:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aryY3eeE";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="86FS4UFg"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 456CA200BA9;
	Mon,  2 Dec 2024 11:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733138062; cv=none; b=rc0AYNRs1jRFnPX5ZaNZDEWwt740l7NTx9P05s3O/b7lU13s1I7C01BJPJXiou3dPd5gIq5bri8zbuCHFS+cQNkvVBb5OJJa0WPAgy+pnVYcqmBTo/DRICluwLoNWVcjBxqmukXigFtASKr/PqyoMl4fQqgDddE2NpNfcaC/W4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733138062; c=relaxed/simple;
	bh=wULnhvIlVk6jasiLq/4/fKlSCePEcLRwDykgAn7X150=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=t90HssmplqKt8RBqr1lmBUCEx9WUY7rEeuXVt8ak3WYCEP1BTUbf4X7lPAoIUSqEV9/Rnj2mNxOrLTCGTqyBQh8wnE4r92TfhRq0uIxJUTvAI2S/ZngoDjPLZZeBPr5nuy4ToqwcDE42rauOTV6828ZUWuYx9Ml/jWr441CDKME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aryY3eeE; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=86FS4UFg; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 02 Dec 2024 11:14:17 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1733138058;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hHExVCewHogB9drld7Pdw1Bt/bDGrt3y7WE4rpmN7lA=;
	b=aryY3eeE0Vxe4ASUiESr0j+YlnfPfa3FrqhuV65APWNE5GOjGYX9mfZcW2Mf+88U4uKTA/
	81B1/dThzHgJx3bkKJBtZv1JO/oUgdxPtfWV06elNJ4qoulg/WU24UL6oSazCvecnKyDM0
	3P3QeOg5TteuiHc8p9MWX9C39W0X9adg+3Tddqun5nXHywFBZrPjPyR9UkIDCqowak3ptI
	drVYCpDbblqUpfzDxLE3xam7xCk9bA13L2gTjAOM+7T5JkKWIQgXwk1UeCqNyu+4aVkJiY
	Owy4353jQuVEAD3+Yo07bApYFMKffEeffimAUU+eMyZzNy5Fa5nmXA+7GrwhKg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1733138058;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hHExVCewHogB9drld7Pdw1Bt/bDGrt3y7WE4rpmN7lA=;
	b=86FS4UFgjP2cRdH9xOhC1m6b0dAvV0Z92RYsiP+PahWqjaOdm45CO7Jxjm1vMbUhcrgfFC
	35eQ21sWx7bapxAw==
From: "tip-bot2 for Dhananjay Ugwekar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/rapl: Rename rapl_pmu variables
Cc: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 "Gautham R. Shenoy" <gautham.shenoy@amd.com>, Zhang Rui <rui.zhang@intel.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20241115060805.447565-5-Dhananjay.Ugwekar@amd.com>
References: <20241115060805.447565-5-Dhananjay.Ugwekar@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <173313805723.412.9968826976353075696.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     8bf1c86e5ac828d7e8b44fe007bf3b14ac7f2b2d
Gitweb:        https://git.kernel.org/tip/8bf1c86e5ac828d7e8b44fe007bf3b14ac7f2b2d
Author:        Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
AuthorDate:    Fri, 15 Nov 2024 06:08:00 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 02 Dec 2024 12:01:35 +01:00

perf/x86/rapl: Rename rapl_pmu variables

Rename struct rapl_pmu variables from "pmu" to "rapl_pmu", to
avoid any confusion between the variables of two different
structs pmu and rapl_pmu. As rapl_pmu also contains a pointer to
struct pmu, which leads to situations in code like pmu->pmu,
which is needlessly confusing. Above scenario is replaced with
much more readable rapl_pmu->pmu with this change.

Also rename "pmus" member in rapl_pmus struct, for same reason.

No functional change.

Signed-off-by: Dhananjay Ugwekar <Dhananjay.Ugwekar@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Reviewed-by: Zhang Rui <rui.zhang@intel.com>
Tested-by: Zhang Rui <rui.zhang@intel.com>
Link: https://lore.kernel.org/r/20241115060805.447565-5-Dhananjay.Ugwekar@amd.com
---
 arch/x86/events/rapl.c | 91 ++++++++++++++++++++---------------------
 1 file changed, 46 insertions(+), 45 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index bf260f4..9b1ec8a 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -129,7 +129,7 @@ struct rapl_pmu {
 struct rapl_pmus {
 	struct pmu		pmu;
 	unsigned int		nr_rapl_pmu;
-	struct rapl_pmu		*pmus[] __counted_by(nr_rapl_pmu);
+	struct rapl_pmu		*rapl_pmu[] __counted_by(nr_rapl_pmu);
 };
 
 enum rapl_unit_quirk {
@@ -228,34 +228,34 @@ static void rapl_start_hrtimer(struct rapl_pmu *pmu)
 
 static enum hrtimer_restart rapl_hrtimer_handle(struct hrtimer *hrtimer)
 {
-	struct rapl_pmu *pmu = container_of(hrtimer, struct rapl_pmu, hrtimer);
+	struct rapl_pmu *rapl_pmu = container_of(hrtimer, struct rapl_pmu, hrtimer);
 	struct perf_event *event;
 	unsigned long flags;
 
-	if (!pmu->n_active)
+	if (!rapl_pmu->n_active)
 		return HRTIMER_NORESTART;
 
-	raw_spin_lock_irqsave(&pmu->lock, flags);
+	raw_spin_lock_irqsave(&rapl_pmu->lock, flags);
 
-	list_for_each_entry(event, &pmu->active_list, active_entry)
+	list_for_each_entry(event, &rapl_pmu->active_list, active_entry)
 		rapl_event_update(event);
 
-	raw_spin_unlock_irqrestore(&pmu->lock, flags);
+	raw_spin_unlock_irqrestore(&rapl_pmu->lock, flags);
 
-	hrtimer_forward_now(hrtimer, pmu->timer_interval);
+	hrtimer_forward_now(hrtimer, rapl_pmu->timer_interval);
 
 	return HRTIMER_RESTART;
 }
 
-static void rapl_hrtimer_init(struct rapl_pmu *pmu)
+static void rapl_hrtimer_init(struct rapl_pmu *rapl_pmu)
 {
-	struct hrtimer *hr = &pmu->hrtimer;
+	struct hrtimer *hr = &rapl_pmu->hrtimer;
 
 	hrtimer_init(hr, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 	hr->function = rapl_hrtimer_handle;
 }
 
-static void __rapl_pmu_event_start(struct rapl_pmu *pmu,
+static void __rapl_pmu_event_start(struct rapl_pmu *rapl_pmu,
 				   struct perf_event *event)
 {
 	if (WARN_ON_ONCE(!(event->hw.state & PERF_HES_STOPPED)))
@@ -263,39 +263,39 @@ static void __rapl_pmu_event_start(struct rapl_pmu *pmu,
 
 	event->hw.state = 0;
 
-	list_add_tail(&event->active_entry, &pmu->active_list);
+	list_add_tail(&event->active_entry, &rapl_pmu->active_list);
 
 	local64_set(&event->hw.prev_count, rapl_read_counter(event));
 
-	pmu->n_active++;
-	if (pmu->n_active == 1)
-		rapl_start_hrtimer(pmu);
+	rapl_pmu->n_active++;
+	if (rapl_pmu->n_active == 1)
+		rapl_start_hrtimer(rapl_pmu);
 }
 
 static void rapl_pmu_event_start(struct perf_event *event, int mode)
 {
-	struct rapl_pmu *pmu = event->pmu_private;
+	struct rapl_pmu *rapl_pmu = event->pmu_private;
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&pmu->lock, flags);
-	__rapl_pmu_event_start(pmu, event);
-	raw_spin_unlock_irqrestore(&pmu->lock, flags);
+	raw_spin_lock_irqsave(&rapl_pmu->lock, flags);
+	__rapl_pmu_event_start(rapl_pmu, event);
+	raw_spin_unlock_irqrestore(&rapl_pmu->lock, flags);
 }
 
 static void rapl_pmu_event_stop(struct perf_event *event, int mode)
 {
-	struct rapl_pmu *pmu = event->pmu_private;
+	struct rapl_pmu *rapl_pmu = event->pmu_private;
 	struct hw_perf_event *hwc = &event->hw;
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&pmu->lock, flags);
+	raw_spin_lock_irqsave(&rapl_pmu->lock, flags);
 
 	/* mark event as deactivated and stopped */
 	if (!(hwc->state & PERF_HES_STOPPED)) {
-		WARN_ON_ONCE(pmu->n_active <= 0);
-		pmu->n_active--;
-		if (pmu->n_active == 0)
-			hrtimer_cancel(&pmu->hrtimer);
+		WARN_ON_ONCE(rapl_pmu->n_active <= 0);
+		rapl_pmu->n_active--;
+		if (rapl_pmu->n_active == 0)
+			hrtimer_cancel(&rapl_pmu->hrtimer);
 
 		list_del(&event->active_entry);
 
@@ -313,23 +313,23 @@ static void rapl_pmu_event_stop(struct perf_event *event, int mode)
 		hwc->state |= PERF_HES_UPTODATE;
 	}
 
-	raw_spin_unlock_irqrestore(&pmu->lock, flags);
+	raw_spin_unlock_irqrestore(&rapl_pmu->lock, flags);
 }
 
 static int rapl_pmu_event_add(struct perf_event *event, int mode)
 {
-	struct rapl_pmu *pmu = event->pmu_private;
+	struct rapl_pmu *rapl_pmu = event->pmu_private;
 	struct hw_perf_event *hwc = &event->hw;
 	unsigned long flags;
 
-	raw_spin_lock_irqsave(&pmu->lock, flags);
+	raw_spin_lock_irqsave(&rapl_pmu->lock, flags);
 
 	hwc->state = PERF_HES_UPTODATE | PERF_HES_STOPPED;
 
 	if (mode & PERF_EF_START)
-		__rapl_pmu_event_start(pmu, event);
+		__rapl_pmu_event_start(rapl_pmu, event);
 
-	raw_spin_unlock_irqrestore(&pmu->lock, flags);
+	raw_spin_unlock_irqrestore(&rapl_pmu->lock, flags);
 
 	return 0;
 }
@@ -343,7 +343,7 @@ static int rapl_pmu_event_init(struct perf_event *event)
 {
 	u64 cfg = event->attr.config & RAPL_EVENT_MASK;
 	int bit, ret = 0;
-	struct rapl_pmu *pmu;
+	struct rapl_pmu *rapl_pmu;
 	unsigned int rapl_pmu_idx;
 
 	/* only look at RAPL events */
@@ -376,10 +376,11 @@ static int rapl_pmu_event_init(struct perf_event *event)
 		return -EINVAL;
 
 	/* must be done before validate_group */
-	pmu = rapl_pmus->pmus[rapl_pmu_idx];
-	if (!pmu)
+	rapl_pmu = rapl_pmus->rapl_pmu[rapl_pmu_idx];
+	if (!rapl_pmu)
 		return -EINVAL;
-	event->pmu_private = pmu;
+
+	event->pmu_private = rapl_pmu;
 	event->hw.event_base = rapl_msrs[bit].msr;
 	event->hw.config = cfg;
 	event->hw.idx = bit;
@@ -606,7 +607,7 @@ static void cleanup_rapl_pmus(void)
 	int i;
 
 	for (i = 0; i < rapl_pmus->nr_rapl_pmu; i++)
-		kfree(rapl_pmus->pmus[i]);
+		kfree(rapl_pmus->rapl_pmu[i]);
 	kfree(rapl_pmus);
 }
 
@@ -621,27 +622,27 @@ static const struct attribute_group *rapl_attr_update[] = {
 
 static int __init init_rapl_pmu(void)
 {
-	struct rapl_pmu *pmu;
+	struct rapl_pmu *rapl_pmu;
 	int idx;
 
 	for (idx = 0; idx < rapl_pmus->nr_rapl_pmu; idx++) {
-		pmu = kzalloc(sizeof(*pmu), GFP_KERNEL);
-		if (!pmu)
+		rapl_pmu = kzalloc(sizeof(*rapl_pmu), GFP_KERNEL);
+		if (!rapl_pmu)
 			goto free;
 
-		raw_spin_lock_init(&pmu->lock);
-		INIT_LIST_HEAD(&pmu->active_list);
-		pmu->pmu = &rapl_pmus->pmu;
-		pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
-		rapl_hrtimer_init(pmu);
+		raw_spin_lock_init(&rapl_pmu->lock);
+		INIT_LIST_HEAD(&rapl_pmu->active_list);
+		rapl_pmu->pmu = &rapl_pmus->pmu;
+		rapl_pmu->timer_interval = ms_to_ktime(rapl_timer_ms);
+		rapl_hrtimer_init(rapl_pmu);
 
-		rapl_pmus->pmus[idx] = pmu;
+		rapl_pmus->rapl_pmu[idx] = rapl_pmu;
 	}
 
 	return 0;
 free:
 	for (; idx > 0; idx--)
-		kfree(rapl_pmus->pmus[idx - 1]);
+		kfree(rapl_pmus->rapl_pmu[idx - 1]);
 	return -ENOMEM;
 }
 
@@ -655,7 +656,7 @@ static int __init init_rapl_pmus(void)
 		rapl_pmu_scope = PERF_PMU_SCOPE_DIE;
 	}
 
-	rapl_pmus = kzalloc(struct_size(rapl_pmus, pmus, nr_rapl_pmu), GFP_KERNEL);
+	rapl_pmus = kzalloc(struct_size(rapl_pmus, rapl_pmu, nr_rapl_pmu), GFP_KERNEL);
 	if (!rapl_pmus)
 		return -ENOMEM;
 

