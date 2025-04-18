Return-Path: <linux-tip-commits+bounces-5067-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 423A1A934D6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 10:45:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 658271745F1
	for <lists+linux-tip-commits@lfdr.de>; Fri, 18 Apr 2025 08:45:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB20270EA3;
	Fri, 18 Apr 2025 08:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uaRXT6Kf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KuKWZaEj"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF2026FD82;
	Fri, 18 Apr 2025 08:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744965926; cv=none; b=Ok2+184xEJea6Pclp3pIgQ/xihDQjs1dfyQtAGXXNZ8F0BLK85gg7mqCAJPdxUnG5xUsaemLMvTUcpbJ2POVdBp6SKtco8Ecjc14bjc0VTI+hAasLiKOWYVpZ8UIoWHlVrBuSBUGY2ND18GBWjQqe90Kj89oNrKkfh0yc3ScGF4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744965926; c=relaxed/simple;
	bh=sQ8D+YxMBXfZ7+nvjQdcu4OaKc96nWESkOahKi/kDvE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=s/+kmKSvSDYIbVIleSaXGRTDmGV+xn350JfUAEnMCobccVzvVLcPruH+3ATugnmkgKAQBV7bISIeE8SjvG7CGzMFP5IpVMC5QFnJDKLWxJwqkh49sj/YkmFy1A/VcLrF/ZIf3iEuJykKp7CTztoSFugeuxqZk4lIJRsEL+ZEgXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uaRXT6Kf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KuKWZaEj; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 18 Apr 2025 08:45:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744965922;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6JeTXHD3FqF4JWV80ix6RtQdud0Ex4qprowxaUetYOs=;
	b=uaRXT6Kfchnl7bIxUcymdIgSj3eAeVC8TwS+edhliByEmP8c21kZ7gGI1JhPWh4OFa/MIe
	nQSUDZhEJFLLayHOQdeegA54f3QFk1vUnck9gKTMzTxaqV+Ij2ErPEnQm0pWjAKmueMCQg
	C+AFFS+si1TaReAcn0CJqdRy+w3w6xmddvq8gCxlo0Homa35yEIXCGe8pk3Ku40NkfzaLx
	KLCMhlRbkBvJoqOdkvfD6pfVbYwYDrahCIyokoHZwKeI+4YbXvbHkcklGMb+wGuJrNSIto
	X0CXDxQ1br+h6MV8/FJMmq788qHQ8JsDWpNe8yI4Lq6csiP2u7Kv9AiDun7uXw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744965922;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6JeTXHD3FqF4JWV80ix6RtQdud0Ex4qprowxaUetYOs=;
	b=KuKWZaEjdihEw5BegWa2X3jOeF765m/oZ+3r0x7HGWSEoa0zySO9mhGRJf81bKHttWWCgq
	LDwal++UHuVKncAA==
From: "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel/uncore: Use HRTIMER_MODE_HARD for
 detecting overflows
Cc: Peter Zijlstra <peterz@infradead.org>, Sandipan Das <sandipan.das@amd.com>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3C0ad4698465077225769e8edd5b2c7e8f48f636d5=2E17449?=
 =?utf-8?q?06694=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3C0ad4698465077225769e8edd5b2c7e8f48f636d5=2E174490?=
 =?utf-8?q?6694=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174496592184.31282.8164200843782365980.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     05c9b0cbe4b822c42382d27e3f73918600594882
Gitweb:        https://git.kernel.org/tip/05c9b0cbe4b822c42382d27e3f73918600594882
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Fri, 18 Apr 2025 09:13:00 +05:30
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 18 Apr 2025 10:35:33 +02:00

perf/x86/intel/uncore: Use HRTIMER_MODE_HARD for detecting overflows

hrtimer handlers can be deferred to softirq context and affect timely
detection of counter overflows. Hence switch to HRTIMER_MODE_HARD.

Disabling and re-enabling IRQs in the hrtimer handler is not required
as pmu->start() and pmu->stop() can no longer intervene while updating
event->hw.prev_count.

Suggested-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/0ad4698465077225769e8edd5b2c7e8f48f636d5.1744906694.git.sandipan.das@amd.com
---
 arch/x86/events/intel/uncore.c | 12 ++----------
 1 file changed, 2 insertions(+), 10 deletions(-)

diff --git a/arch/x86/events/intel/uncore.c b/arch/x86/events/intel/uncore.c
index a34e50f..5811e17 100644
--- a/arch/x86/events/intel/uncore.c
+++ b/arch/x86/events/intel/uncore.c
@@ -305,17 +305,11 @@ static enum hrtimer_restart uncore_pmu_hrtimer(struct hrtimer *hrtimer)
 {
 	struct intel_uncore_box *box;
 	struct perf_event *event;
-	unsigned long flags;
 	int bit;
 
 	box = container_of(hrtimer, struct intel_uncore_box, hrtimer);
 	if (!box->n_active || box->cpu != smp_processor_id())
 		return HRTIMER_NORESTART;
-	/*
-	 * disable local interrupt to prevent uncore_pmu_event_start/stop
-	 * to interrupt the update process
-	 */
-	local_irq_save(flags);
 
 	/*
 	 * handle boxes with an active event list as opposed to active
@@ -328,8 +322,6 @@ static enum hrtimer_restart uncore_pmu_hrtimer(struct hrtimer *hrtimer)
 	for_each_set_bit(bit, box->active_mask, UNCORE_PMC_IDX_MAX)
 		uncore_perf_event_update(box, box->events[bit]);
 
-	local_irq_restore(flags);
-
 	hrtimer_forward_now(hrtimer, ns_to_ktime(box->hrtimer_duration));
 	return HRTIMER_RESTART;
 }
@@ -337,7 +329,7 @@ static enum hrtimer_restart uncore_pmu_hrtimer(struct hrtimer *hrtimer)
 void uncore_pmu_start_hrtimer(struct intel_uncore_box *box)
 {
 	hrtimer_start(&box->hrtimer, ns_to_ktime(box->hrtimer_duration),
-		      HRTIMER_MODE_REL_PINNED);
+		      HRTIMER_MODE_REL_PINNED_HARD);
 }
 
 void uncore_pmu_cancel_hrtimer(struct intel_uncore_box *box)
@@ -347,7 +339,7 @@ void uncore_pmu_cancel_hrtimer(struct intel_uncore_box *box)
 
 static void uncore_pmu_init_hrtimer(struct intel_uncore_box *box)
 {
-	hrtimer_setup(&box->hrtimer, uncore_pmu_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
+	hrtimer_setup(&box->hrtimer, uncore_pmu_hrtimer, CLOCK_MONOTONIC, HRTIMER_MODE_REL_HARD);
 }
 
 static struct intel_uncore_box *uncore_alloc_box(struct intel_uncore_type *type,

