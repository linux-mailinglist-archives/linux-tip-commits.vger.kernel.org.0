Return-Path: <linux-tip-commits+bounces-1601-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5CD04928E74
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Jul 2024 23:06:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 878511C21558
	for <lists+linux-tip-commits@lfdr.de>; Fri,  5 Jul 2024 21:06:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CECD144D11;
	Fri,  5 Jul 2024 21:06:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="SBvPPyXb";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KjE/+Fi4"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A12D6E5FD;
	Fri,  5 Jul 2024 21:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720213604; cv=none; b=C/ebIlzHwGC+s+3aQjWRFxMFNQhrWX2yUyxd7aPp7r7Cvq4/u7zxs5qNGzS9BPkTkoZjHqSsKXKlrAYERBrPlLW5tjnOw+iQ4YnEVmaTOcD+DyHcaL75hD6vKTYw5i5uhTkY3cjaEQNuMfgHc+eqRS+sHOhUo/OZmqkPaZ7FU3Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720213604; c=relaxed/simple;
	bh=XWryfH3TB8cCYM4OZvTyd02VYjCEf4jbm6tttB9OSew=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=aSv1a1U/Uo5VzRF4TnZqOZs+tcRSz2CUdZKuuPO91k4/IJLyPwlXhNC7hMePxSRvLcGxegq2g/k8HfGzQuMc7Isflf9OUwavW6jOML+p/CYBlBbacHmMFU8Z3BZeTAypL0qHc1PdqCENm9NV/9HcyT7E5fINuBPZr+H1Wx+JCI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=SBvPPyXb; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KjE/+Fi4; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 05 Jul 2024 21:06:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1720213601;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dcIzD+cP3zSq83stslrSdUAtI/IEQdf9Krzujt0LW6w=;
	b=SBvPPyXbS1+eAWGxwZHCilTSr+7qQ9zb7yKCZNQiDcWEBtHCTFRmE4FNlOSGgTkA8PcHbC
	/1U9yMdlIUKThoX4rFPQYX1tRcYnaDW7JyTHaAIf5VvMsGv/2qMUQDhYpTyWc476eUZBd5
	t154sDMnYMqL5Wg4mAqK7QDmWFtO8+VMg1wAam+AnHdfECM9VV74UgAASwQdGqe0FAfg8a
	vEBJzbhrB5TqsNYpW46YnYcx22mrNbt1/CebvsDOMA6Tqi3PcVskW2KsoXUOLvSYsdGy/k
	l91GVJLGPcK5c08G+2HRxvaB9A7Tk0LTRUDXwStfclkBvb/xxkPZN4Bl1bdymQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1720213601;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=dcIzD+cP3zSq83stslrSdUAtI/IEQdf9Krzujt0LW6w=;
	b=KjE/+Fi4NEShNs8iuV/bN5LaywX5PqJ4t3/OIVNdQjBcbY55bBgLjBcA5fOnm5Icr7Bu6a
	mVdLzjjgPeaVE6Aw==
From: "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd/uncore: Avoid PMU registration if
 counters are unavailable
Cc: Sandipan Das <sandipan.das@amd.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240626074404.1044230-1-sandipan.das@amd.com>
References: <20240626074404.1044230-1-sandipan.das@amd.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172021360059.2215.17531547792114902747.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     f997e208b6c96858a2f6c0855debfbdb9b52f131
Gitweb:        https://git.kernel.org/tip/f997e208b6c96858a2f6c0855debfbdb9b52f131
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Wed, 26 Jun 2024 13:14:04 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 04 Jul 2024 16:00:41 +02:00

perf/x86/amd/uncore: Avoid PMU registration if counters are unavailable

X86_FEATURE_PERFCTR_NB and X86_FEATURE_PERFCTR_LLC are derived from
CPUID leaf 0x80000001 ECX bits 24 and 28 respectively and denote the
availability of DF and L3 counters. When these bits are not set, the
corresponding PMUs have no counters and hence, should not be registered.

Fixes: 07888daa056e ("perf/x86/amd/uncore: Move discovery and registration")
Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20240626074404.1044230-1-sandipan.das@amd.com
---
 arch/x86/events/amd/uncore.c | 22 ++++++++++++++--------
 1 file changed, 14 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 0fafe23..a0b4405 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -658,17 +658,20 @@ int amd_uncore_df_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 {
 	struct attribute **df_attr = amd_uncore_df_format_attr;
 	struct amd_uncore_pmu *pmu;
+	int num_counters;
 
 	/* Run just once */
 	if (uncore->init_done)
 		return amd_uncore_ctx_init(uncore, cpu);
 
+	num_counters = amd_uncore_ctx_num_pmcs(uncore, cpu);
+	if (!num_counters)
+		goto done;
+
 	/* No grouping, single instance for a system */
 	uncore->pmus = kzalloc(sizeof(*uncore->pmus), GFP_KERNEL);
-	if (!uncore->pmus) {
-		uncore->num_pmus = 0;
+	if (!uncore->pmus)
 		goto done;
-	}
 
 	/*
 	 * For Family 17h and above, the Northbridge counters are repurposed
@@ -678,7 +681,7 @@ int amd_uncore_df_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 	pmu = &uncore->pmus[0];
 	strscpy(pmu->name, boot_cpu_data.x86 >= 0x17 ? "amd_df" : "amd_nb",
 		sizeof(pmu->name));
-	pmu->num_counters = amd_uncore_ctx_num_pmcs(uncore, cpu);
+	pmu->num_counters = num_counters;
 	pmu->msr_base = MSR_F15H_NB_PERF_CTL;
 	pmu->rdpmc_base = RDPMC_BASE_NB;
 	pmu->group = amd_uncore_ctx_gid(uncore, cpu);
@@ -789,17 +792,20 @@ int amd_uncore_l3_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 {
 	struct attribute **l3_attr = amd_uncore_l3_format_attr;
 	struct amd_uncore_pmu *pmu;
+	int num_counters;
 
 	/* Run just once */
 	if (uncore->init_done)
 		return amd_uncore_ctx_init(uncore, cpu);
 
+	num_counters = amd_uncore_ctx_num_pmcs(uncore, cpu);
+	if (!num_counters)
+		goto done;
+
 	/* No grouping, single instance for a system */
 	uncore->pmus = kzalloc(sizeof(*uncore->pmus), GFP_KERNEL);
-	if (!uncore->pmus) {
-		uncore->num_pmus = 0;
+	if (!uncore->pmus)
 		goto done;
-	}
 
 	/*
 	 * For Family 17h and above, L3 cache counters are available instead
@@ -809,7 +815,7 @@ int amd_uncore_l3_ctx_init(struct amd_uncore *uncore, unsigned int cpu)
 	pmu = &uncore->pmus[0];
 	strscpy(pmu->name, boot_cpu_data.x86 >= 0x17 ? "amd_l3" : "amd_l2",
 		sizeof(pmu->name));
-	pmu->num_counters = amd_uncore_ctx_num_pmcs(uncore, cpu);
+	pmu->num_counters = num_counters;
 	pmu->msr_base = MSR_F16H_L2I_PERF_CTL;
 	pmu->rdpmc_base = RDPMC_BASE_LLC;
 	pmu->group = amd_uncore_ctx_gid(uncore, cpu);

