Return-Path: <linux-tip-commits+bounces-5034-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A009EA91D24
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 15:01:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ED5FD3A875D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 17 Apr 2025 13:01:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B88D2459D3;
	Thu, 17 Apr 2025 13:01:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="iQD/Y14r";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ogxRwOJC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F538178395;
	Thu, 17 Apr 2025 13:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744894893; cv=none; b=EPLZ3z0WJ7bq/YeQBB3UkiLIrElg8cuawSFh/mXMXD5aFqLl5/wRPYBbtGldflQnvVqrN+5QL9y3bkLB+VZCYmm2pePuEB4wk9HBojTlhctFzzhEFYK76ivlPZNVgEEBtu84Js/Ps9D7+EY9pe2/HUwvZNiU9VMTN+J5KlfXnAI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744894893; c=relaxed/simple;
	bh=Tp3zBnYJSkLVrv66epjTqTr/n2fFwQYCN671xUBNVlQ=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=P9Yy3trWSEpsIw7IcePRF/dS4+plUBmxzJEKo8FJd8rb9sMrX6dlK5qf8oPglXOrRnjOBxtFfvsmvRY2kgWUj0ZA6r44aAEQyIAc44VtmrMiGUrkcSiwgJ/UsQiyP3bA5QfejII/UGI63RKfJCJnedHEpUe+Hiopjr61+FzDSsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=iQD/Y14r; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=ogxRwOJC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Thu, 17 Apr 2025 13:01:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1744894889;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4hLWtaqr77TCr/RuGLqxzYHlEYYMeGiMD4czMix1SSY=;
	b=iQD/Y14rUhjAykczQPZhk1Rxo4l2wAUSRkibINMOgQyPWGi8nHG50BH4c38QwslO9351Ce
	v6thQd/jihuqirOxbEHOsjdSvtF0xbCr3mrghLInbKEyrloSh8V2ERsYp+98pvo8D9seum
	nZpQy5eHbkfKshqgDt1LcARxRnknsONZdiN8Hi9uPnWDTjd9+ncMfix3BNbyJ5EAiVIV4I
	wt5hBViVlbzWSpv9cTKnkHEz5MXQjnPNic3RVBNP1cZCyXxABkRIRmtGPQd/H2qlP/1pxT
	VlK2RLItPjkrNi2zgVH9k7Dl/2NBn2mCws1jblyxDMfmb3FywA2tt1K3Sj0vWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1744894889;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=4hLWtaqr77TCr/RuGLqxzYHlEYYMeGiMD4czMix1SSY=;
	b=ogxRwOJCSagNOwns1VzyRRJBWlIgPei5nXKsT3ogRU+qEADFOyEt8lvfNEQQCmlfXKaCvc
	NypoAdeFRHT9mBDw==
From: "tip-bot2 for Dapeng Mi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Decouple BTS initialization from
 PEBS initialization
Cc: Dapeng Mi <dapeng1.mi@linux.intel.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>, x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250415114428.341182-5-dapeng1.mi@linux.intel.com>
References: <20250415114428.341182-5-dapeng1.mi@linux.intel.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174489488800.31282.11319373754198048027.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d971342d38bf228ea4c137249501eb5be38ee958
Gitweb:        https://git.kernel.org/tip/d971342d38bf228ea4c137249501eb5be38ee958
Author:        Dapeng Mi <dapeng1.mi@linux.intel.com>
AuthorDate:    Tue, 15 Apr 2025 11:44:10 
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 17 Apr 2025 14:21:24 +02:00

perf/x86/intel: Decouple BTS initialization from PEBS initialization

Move x86_pmu.bts flag initialization into bts_init() from
intel_ds_init() and rename intel_ds_init() to intel_pebs_init() since it
fully initializes PEBS now after removing the x86_pmu.bts
initialization.

It's safe to move x86_pmu.bts into bts_init() since all x86_pmu.bts flag
are called after bts_init() execution.

Signed-off-by: Dapeng Mi <dapeng1.mi@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20250415114428.341182-5-dapeng1.mi@linux.intel.com
---
 arch/x86/events/intel/bts.c  | 6 +++++-
 arch/x86/events/intel/core.c | 2 +-
 arch/x86/events/intel/ds.c   | 5 ++---
 arch/x86/events/perf_event.h | 2 +-
 4 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/arch/x86/events/intel/bts.c b/arch/x86/events/intel/bts.c
index 16bc89c..9560f69 100644
--- a/arch/x86/events/intel/bts.c
+++ b/arch/x86/events/intel/bts.c
@@ -599,7 +599,11 @@ static void bts_event_read(struct perf_event *event)
 
 static __init int bts_init(void)
 {
-	if (!boot_cpu_has(X86_FEATURE_DTES64) || !x86_pmu.bts)
+	if (!boot_cpu_has(X86_FEATURE_DTES64))
+		return -ENODEV;
+
+	x86_pmu.bts = boot_cpu_has(X86_FEATURE_BTS);
+	if (!x86_pmu.bts)
 		return -ENODEV;
 
 	if (boot_cpu_has(X86_FEATURE_PTI)) {
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index c7937b8..16049ba 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -6928,7 +6928,7 @@ __init int intel_pmu_init(void)
 	if (boot_cpu_has(X86_FEATURE_ARCH_LBR))
 		intel_pmu_arch_lbr_init();
 
-	intel_ds_init();
+	intel_pebs_init();
 
 	x86_add_quirk(intel_arch_events_quirk); /* Install first, so it runs last */
 
diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index fcf9c5b..d894cf3 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -2651,10 +2651,10 @@ static void intel_pmu_drain_pebs_icl(struct pt_regs *iregs, struct perf_sample_d
 }
 
 /*
- * BTS, PEBS probe and setup
+ * PEBS probe and setup
  */
 
-void __init intel_ds_init(void)
+void __init intel_pebs_init(void)
 {
 	/*
 	 * No support for 32bit formats
@@ -2662,7 +2662,6 @@ void __init intel_ds_init(void)
 	if (!boot_cpu_has(X86_FEATURE_DTES64))
 		return;
 
-	x86_pmu.bts  = boot_cpu_has(X86_FEATURE_BTS);
 	x86_pmu.pebs = boot_cpu_has(X86_FEATURE_PEBS);
 	x86_pmu.pebs_buffer_size = PEBS_BUFFER_SIZE;
 	if (x86_pmu.version <= 4)
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 46bbb50..ac6743e 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1673,7 +1673,7 @@ void intel_pmu_drain_pebs_buffer(void);
 
 void intel_pmu_store_pebs_lbrs(struct lbr_entry *lbr);
 
-void intel_ds_init(void);
+void intel_pebs_init(void);
 
 void intel_pmu_lbr_save_brstack(struct perf_sample_data *data,
 				struct cpu_hw_events *cpuc,

