Return-Path: <linux-tip-commits+bounces-5700-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A7278ABF41D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 14:19:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ACD0B8E4E74
	for <lists+linux-tip-commits@lfdr.de>; Wed, 21 May 2025 12:17:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 874FE26E14A;
	Wed, 21 May 2025 12:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ceFAoCgf";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/KZiRwkx"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0A2D26B94A;
	Wed, 21 May 2025 12:16:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747829766; cv=none; b=g2Dgf0HJj91P3FG0hxPExd6ggXTHEt+ywcK8eg1ygNhjLco2URwqOG3COEgUurpOPGWpvgL+QgsZR2JvGFm8Pc8aezkc+s/jKR6xicWSEXbe3kzuke41uEfJ08kK5uM8B1tiWZ6ED11tHpFd9yGzmZiV7PmsdWkK2xIljBXlCto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747829766; c=relaxed/simple;
	bh=kfe4FQVrwIQ/6XPj7kGxKDOcP3N1rv0gTZ5UvqsJbQM=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=nPwiNPeVIrR8ppnNsT2BzYDzuLQZzw1DnESrgCrxSvdx7P5vIXrUFIBsppem8vu7MOo+WIVdQ2Fxaw7PfcSichJ6jvKSZvlFWy0VWqvTiJFPXZcWN/9MX9zISdXaUIEtcoV3RHs28Bru1qKMRyvj9ph2s4AxXJWI8qpnbuix1p0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ceFAoCgf; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/KZiRwkx; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 21 May 2025 12:16:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747829763;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LbOtLHp08giVLOD+0bYf//Y+uw0o520QSXBJ30jyBjw=;
	b=ceFAoCgfPnDXDzwlG99IXFUCY59RlnJtmOSK/E2EeUvfgZhRedoDNhlqHhtbKaJpXCpoOU
	7LxIPVCqSMHcj6rLg42Bn96gNzLsyJQhId2LN2jML0kOzqbshBnsCXYrRs506yFhFKwh9a
	MvPUlCdSu5r4aP2xoqfQeLGDdtMEIn9ZcvpFDfFlQc+QIlnBqVGQPmU+kOuvK5LajGGFOw
	4zmcOYSd45oRTcEOCACUgH4k9xoVISqmVY1Uuogez47UAzKUR8yh5PXsa1xf278n3XPGVq
	UVjIsjS/vQTdtOwgxWtkrSkYoc74kUN5qoYRFK+MKfZzSCnLOgpPcSgFr1hGbg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747829763;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=LbOtLHp08giVLOD+0bYf//Y+uw0o520QSXBJ30jyBjw=;
	b=/KZiRwkxUCJ2uVKmZxJGDYCyJ1ToC8fb8aWlxdH7mKD6rfMZf4zGFAHoXg6/ImNODs7LfR
	cZIdVs4vNseRehBg==
From: "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: perf/core] perf/x86/intel: Remove driver-specific throttle support
Cc: Kan Liang <kan.liang@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250520181644.2673067-4-kan.liang@linux.intel.com>
References: <20250520181644.2673067-4-kan.liang@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174782976245.406.13828505450890251421.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b8328f67206c672a7140fd3a259892e17d96bbe6
Gitweb:        https://git.kernel.org/tip/b8328f67206c672a7140fd3a259892e17d96bbe6
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Tue, 20 May 2025 11:16:31 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 21 May 2025 13:57:43 +02:00

perf/x86/intel: Remove driver-specific throttle support

The throttle support has been added in the generic code. Remove
the driver-specific throttle support.

Besides the throttle, perf_event_overflow may return true because of
event_limit. It already does an inatomic event disable. The pmu->stop
is not required either.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lore.kernel.org/r/20250520181644.2673067-4-kan.liang@linux.intel.com
---
 arch/x86/events/core.c       | 3 +--
 arch/x86/events/intel/core.c | 6 ++----
 arch/x86/events/intel/ds.c   | 7 +++----
 arch/x86/events/intel/knc.c  | 3 +--
 arch/x86/events/intel/p4.c   | 3 +--
 5 files changed, 8 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 92c3fb6..4c49eef 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1728,8 +1728,7 @@ int x86_pmu_handle_irq(struct pt_regs *regs)
 
 		perf_sample_save_brstack(&data, event, &cpuc->lbr_stack, NULL);
 
-		if (perf_event_overflow(event, &data, regs))
-			x86_pmu_stop(event, 0);
+		perf_event_overflow(event, &data, regs);
 	}
 
 	if (handled)
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index cd63292..3a319cf 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3138,8 +3138,7 @@ static void x86_pmu_handle_guest_pebs(struct pt_regs *regs,
 			continue;
 
 		perf_sample_data_init(data, 0, event->hw.last_period);
-		if (perf_event_overflow(event, data, regs))
-			x86_pmu_stop(event, 0);
+		perf_event_overflow(event, data, regs);
 
 		/* Inject one fake event is enough. */
 		break;
@@ -3282,8 +3281,7 @@ static int handle_pmi_common(struct pt_regs *regs, u64 status)
 		if (has_branch_stack(event))
 			intel_pmu_lbr_save_brstack(&data, cpuc, event);
 
-		if (perf_event_overflow(event, &data, regs))
-			x86_pmu_stop(event, 0);
+		perf_event_overflow(event, &data, regs);
 	}
 
 	return handled;
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 319d0d4..fb02e43 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2359,8 +2359,7 @@ __intel_pmu_pebs_last_event(struct perf_event *event,
 		 * All but the last records are processed.
 		 * The last one is left to be able to call the overflow handler.
 		 */
-		if (perf_event_overflow(event, data, regs))
-			x86_pmu_stop(event, 0);
+		perf_event_overflow(event, data, regs);
 	}
 
 	if (hwc->flags & PERF_X86_EVENT_AUTO_RELOAD) {
@@ -2588,8 +2587,8 @@ static void intel_pmu_drain_pebs_nhm(struct pt_regs *iregs, struct perf_sample_d
 		if (error[bit]) {
 			perf_log_lost_samples(event, error[bit]);
 
-			if (iregs && perf_event_account_interrupt(event))
-				x86_pmu_stop(event, 0);
+			if (iregs)
+				perf_event_account_interrupt(event);
 		}
 
 		if (counts[bit]) {
diff --git a/arch/x86/events/intel/knc.c b/arch/x86/events/intel/knc.c
index 3e8ec04..3845891 100644
--- a/arch/x86/events/intel/knc.c
+++ b/arch/x86/events/intel/knc.c
@@ -254,8 +254,7 @@ again:
 
 		perf_sample_data_init(&data, 0, last_period);
 
-		if (perf_event_overflow(event, &data, regs))
-			x86_pmu_stop(event, 0);
+		perf_event_overflow(event, &data, regs);
 	}
 
 	/*
diff --git a/arch/x86/events/intel/p4.c b/arch/x86/events/intel/p4.c
index c85a9fc..126d5ae 100644
--- a/arch/x86/events/intel/p4.c
+++ b/arch/x86/events/intel/p4.c
@@ -1072,8 +1072,7 @@ static int p4_pmu_handle_irq(struct pt_regs *regs)
 			continue;
 
 
-		if (perf_event_overflow(event, &data, regs))
-			x86_pmu_stop(event, 0);
+		perf_event_overflow(event, &data, regs);
 	}
 
 	if (handled)

