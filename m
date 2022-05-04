Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D0C9519B8E
	for <lists+linux-tip-commits@lfdr.de>; Wed,  4 May 2022 11:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347176AbiEDJ1J (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 4 May 2022 05:27:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347137AbiEDJ1C (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 4 May 2022 05:27:02 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B1AF222B3;
        Wed,  4 May 2022 02:23:26 -0700 (PDT)
Date:   Wed, 04 May 2022 09:23:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1651656204;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=apvhUqgA5fesdTmfgsR6JbCSnigppljrynuw0Qm14eI=;
        b=KS6UHbto2JE2reO2sq0uFPMcc6nbYeMC14cK//1I6NEw5QEDtqwfFmUZhLdgbXIv+EvIBx
        j1P9UPxvh7RR4HEZj2fFucHWgR+OyFVhUblANtDi9C/PLb0MN1l3FpE4QyIkiy7MDMZsuc
        ygFrennY2hPvjTrnWqsokrqSCDiMZNaBQruN8h3/L+89ngMNwHplj1cVRZDU/IspZsLnew
        FI4kG+3Nb6ksH7Nq6rikYU8Gg5zkRix4FxHUluZLBkz94fkDfDA0PDitkKsK46fojuer92
        EjlxoFKLGxQGr0udtKDguFawC5evVkVsR1KGb8Qg6DquRpNtbRV6WiGX3A4k0A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1651656204;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=apvhUqgA5fesdTmfgsR6JbCSnigppljrynuw0Qm14eI=;
        b=097yVG1zcUxlTR8sxMmoporuMreq+OBZk7C7STF6PZ5E4UjX3bxs5ir01tz0+pRt4Bs+Ma
        D+EJ63I095qVxXAg==
From:   "tip-bot2 for Sandipan Das" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/amd/core: Detect PerfMonV2 support
Cc:     Sandipan Das <sandipan.das@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: =?utf-8?q?=3Cdc8672ecbddff394e088ca8abf94b089b8ecc2e7=2E16505?=
 =?utf-8?q?15382=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
References: =?utf-8?q?=3Cdc8672ecbddff394e088ca8abf94b089b8ecc2e7=2E165051?=
 =?utf-8?q?5382=2Egit=2Esandipan=2Edas=40amd=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <165165620357.4207.13021265622696818819.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     21d59e3e2c403c83ba196a5857d517054124168e
Gitweb:        https://git.kernel.org/tip/21d59e3e2c403c83ba196a5857d517054124168e
Author:        Sandipan Das <sandipan.das@amd.com>
AuthorDate:    Thu, 21 Apr 2022 11:16:55 +05:30
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 04 May 2022 11:18:26 +02:00

perf/x86/amd/core: Detect PerfMonV2 support

AMD Performance Monitoring Version 2 (PerfMonV2) introduces
some new Core PMU features such as detection of the number
of available PMCs and managing PMCs using global registers
namely, PerfCntrGlobalCtl and PerfCntrGlobalStatus.

Clearing PerfCntrGlobalCtl and PerfCntrGlobalStatus ensures
that all PMCs are inactive and have no pending overflows
when CPUs are onlined or offlined.

The PMU version (x86_pmu.version) now indicates PerfMonV2
support and will be used to bypass the new features on
unsupported processors.

Signed-off-by: Sandipan Das <sandipan.das@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/dc8672ecbddff394e088ca8abf94b089b8ecc2e7.1650515382.git.sandipan.das@amd.com
---
 arch/x86/events/amd/core.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/arch/x86/events/amd/core.c b/arch/x86/events/amd/core.c
index 8e1e818..b70dfa0 100644
--- a/arch/x86/events/amd/core.c
+++ b/arch/x86/events/amd/core.c
@@ -19,6 +19,9 @@ static unsigned long perf_nmi_window;
 #define AMD_MERGE_EVENT ((0xFULL << 32) | 0xFFULL)
 #define AMD_MERGE_EVENT_ENABLE (AMD_MERGE_EVENT | ARCH_PERFMON_EVENTSEL_ENABLE)
 
+/* PMC Enable and Overflow bits for PerfCntrGlobal* registers */
+static u64 amd_pmu_global_cntr_mask __read_mostly;
+
 static __initconst const u64 amd_hw_cache_event_ids
 				[PERF_COUNT_HW_CACHE_MAX]
 				[PERF_COUNT_HW_CACHE_OP_MAX]
@@ -578,6 +581,18 @@ static struct amd_nb *amd_alloc_nb(int cpu)
 	return nb;
 }
 
+static void amd_pmu_cpu_reset(int cpu)
+{
+	if (x86_pmu.version < 2)
+		return;
+
+	/* Clear enable bits i.e. PerfCntrGlobalCtl.PerfCntrEn */
+	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_CTL, 0);
+
+	/* Clear overflow bits i.e. PerfCntrGLobalStatus.PerfCntrOvfl */
+	wrmsrl(MSR_AMD64_PERF_CNTR_GLOBAL_STATUS_CLR, amd_pmu_global_cntr_mask);
+}
+
 static int amd_pmu_cpu_prepare(int cpu)
 {
 	struct cpu_hw_events *cpuc = &per_cpu(cpu_hw_events, cpu);
@@ -625,6 +640,7 @@ static void amd_pmu_cpu_starting(int cpu)
 	cpuc->amd_nb->refcnt++;
 
 	amd_brs_reset();
+	amd_pmu_cpu_reset(cpu);
 }
 
 static void amd_pmu_cpu_dead(int cpu)
@@ -644,6 +660,8 @@ static void amd_pmu_cpu_dead(int cpu)
 
 		cpuhw->amd_nb = NULL;
 	}
+
+	amd_pmu_cpu_reset(cpu);
 }
 
 /*
@@ -1185,6 +1203,15 @@ static int __init amd_core_pmu_init(void)
 	x86_pmu.eventsel	= MSR_F15H_PERF_CTL;
 	x86_pmu.perfctr		= MSR_F15H_PERF_CTR;
 	x86_pmu.num_counters	= AMD64_NUM_COUNTERS_CORE;
+
+	/* Check for Performance Monitoring v2 support */
+	if (boot_cpu_has(X86_FEATURE_PERFMON_V2)) {
+		/* Update PMU version for later usage */
+		x86_pmu.version = 2;
+
+		amd_pmu_global_cntr_mask = (1ULL << x86_pmu.num_counters) - 1;
+	}
+
 	/*
 	 * AMD Core perfctr has separate MSRs for the NB events, see
 	 * the amd/uncore.c driver.
