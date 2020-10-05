Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8D41B283126
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Oct 2020 09:54:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725936AbgJEHyB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Oct 2020 03:54:01 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56810 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725887AbgJEHyA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Oct 2020 03:54:00 -0400
Date:   Mon, 05 Oct 2020 07:53:58 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601884438;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QYbK7mfoPdUfMhJx3wXEL/7eldwIVbW55QkmynmJOCg=;
        b=U9tKX5k46+7Q3OXbntUakEq+8F8GVdhGhDaPrJZKM4rpr8i95uYYfr1bQkQDZJd2x6/nQh
        KrIRjA5yYs2kKu005gidxxzHBgskVzTgSACM1A8my3GKlMB65JVsNBR0IEDw5XDV9H3KE8
        QiAOxBBcpT2YlX+UbaR+wh6U1yZ7CbzgQJDckniQacHlw4CCDhBXFQmYx7JhZ1mOPzai0f
        AEXPt/1xUQn2E337SAuv85oGyI/I7lREaYMJAjeppGb6r58l6lI1fXSeF7ltpmudEquUaT
        AiO4B58eiGzx+QdlKvTImwTQdk48UyPocw8dTLFOryKSUcF2ZYpz+nQiKGxm1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601884438;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QYbK7mfoPdUfMhJx3wXEL/7eldwIVbW55QkmynmJOCg=;
        b=uKMYVXDXdxvtgJrEgjw0KxHO2oXj58P731l1xl0Og153yrdtXeg90MCX8K7Sw6FlV61uy6
        4iDtOaL2ZNaJ5KBA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Check perf metrics feature for each CPU
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201001211711.25708-1-kan.liang@linux.intel.com>
References: <20201001211711.25708-1-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <160188443801.7002.1461664942801340207.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     80a5ce116fc084e8a25d5a936617699e2931b611
Gitweb:        https://git.kernel.org/tip/80a5ce116fc084e8a25d5a936617699e2931b611
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 01 Oct 2020 14:17:11 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 03 Oct 2020 16:30:56 +02:00

perf/x86/intel: Check perf metrics feature for each CPU

It might be possible that different CPUs have different CPU metrics on a
platform. In this case, writing the GLOBAL_CTRL_EN_PERF_METRICS bit to
the GLOBAL_CTRL register of a CPU, which doesn't support the TopDown
perf metrics feature, causes MSR access error.

Current TopDown perf metrics feature is enumerated using the boot CPU's
PERF_CAPABILITIES MSR. The MSR only indicates the boot CPU supports this
feature.

Check the PERF_CAPABILITIES MSR for each CPU. If any CPU doesn't support
the perf metrics feature, disable the feature globally.

Fixes: 59a854e2f3b9 ("perf/x86/intel: Support TopDown metrics on Ice Lake")
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201001211711.25708-1-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index bdf28d2..7186098 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4083,6 +4083,17 @@ static void intel_pmu_cpu_starting(int cpu)
 	if (x86_pmu.counter_freezing)
 		enable_counter_freeze();
 
+	/* Disable perf metrics if any added CPU doesn't support it. */
+	if (x86_pmu.intel_cap.perf_metrics) {
+		union perf_capabilities perf_cap;
+
+		rdmsrl(MSR_IA32_PERF_CAPABILITIES, perf_cap.capabilities);
+		if (!perf_cap.perf_metrics) {
+			x86_pmu.intel_cap.perf_metrics = 0;
+			x86_pmu.intel_ctrl &= ~(1ULL << GLOBAL_CTRL_EN_PERF_METRICS);
+		}
+	}
+
 	if (!cpuc->shared_regs)
 		return;
 
