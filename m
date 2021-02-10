Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0C5C316891
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 15:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231634AbhBJOAa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 09:00:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231754AbhBJOAZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 09:00:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E819C06178A;
        Wed, 10 Feb 2021 05:59:32 -0800 (PST)
Date:   Wed, 10 Feb 2021 13:59:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612965570;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hX916SXnRhDn+Z+tHpMlZ/5GKLNDWSrhS4/UgmLwAww=;
        b=K4D5JQJzcquO1TA3JuJifrj304Jlk3GTSxmS8CQmGJBTTBUbDTqQ4YecUZZD8wKIGzPEvT
        f29mNKbE8VnpPW8PD7iO+HBG46Z3mJuzHuWliGr4wzpZOG9VBibRs2wT2mFQlWIG30k94R
        AgxasldI0j1mxpM2Lwalr/VQOhcISIlYpcG7KK21VW5m20o9qK0G5pXfQsFTCtVqdbnLiX
        k9UG9kfmtCUWL8ISNDrSky0V3wswCfQ5xVrzAsmJvBn5Y6FN6GKjisi/P+wJXfbqKYAQWB
        9ZDXznwQ9YMGQI2hitT0qGTs8Y7C/f88JsDT4zGsgjxnKAisPqZpU5mcsxMIUQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612965570;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hX916SXnRhDn+Z+tHpMlZ/5GKLNDWSrhS4/UgmLwAww=;
        b=ehMotstMOnJwWnSwZbVSZjvQFSs5bnuq5BIes8UH1sEcafVnD5fiHRz3bQvlQibSqL/GnX
        8U9BRtTXXugZHeAQ==
From:   "tip-bot2 for Zhang Rui" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/rapl: Only check lower 32bits for RAPL
 energy counters
Cc:     Zhang Rui <rui.zhang@intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210204161816.12649-2-rui.zhang@intel.com>
References: <20210204161816.12649-2-rui.zhang@intel.com>
MIME-Version: 1.0
Message-ID: <161296557018.23325.4865146815939567306.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b6f78d3fba7f605f673185d7292d84af7576fdc1
Gitweb:        https://git.kernel.org/tip/b6f78d3fba7f605f673185d7292d84af7576fdc1
Author:        Zhang Rui <rui.zhang@intel.com>
AuthorDate:    Fri, 05 Feb 2021 00:18:15 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 10 Feb 2021 14:44:55 +01:00

perf/x86/rapl: Only check lower 32bits for RAPL energy counters

In the RAPL ENERGY_COUNTER MSR, only the lower 32bits represent the energy
counter.

On previous platforms, the higher 32bits are reverved and always return
Zero. But on Intel SapphireRapids platform, the higher 32bits are reused
for other purpose and return non-zero value.

Thus check the lower 32bits only for these ENERGY_COUTNER MSRs, to make
sure the RAPL PMU events are not added erroneously when higher 32bits
contain non-zero value.

Signed-off-by: Zhang Rui <rui.zhang@intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/20210204161816.12649-2-rui.zhang@intel.com
---
 arch/x86/events/rapl.c | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/x86/events/rapl.c b/arch/x86/events/rapl.c
index 7dbbeaa..7ed25b2 100644
--- a/arch/x86/events/rapl.c
+++ b/arch/x86/events/rapl.c
@@ -523,12 +523,15 @@ static bool test_msr(int idx, void *data)
 	return test_bit(idx, (unsigned long *) data);
 }
 
+/* Only lower 32bits of the MSR represents the energy counter */
+#define RAPL_MSR_MASK 0xFFFFFFFF
+
 static struct perf_msr intel_rapl_msrs[] = {
-	[PERF_RAPL_PP0]  = { MSR_PP0_ENERGY_STATUS,      &rapl_events_cores_group, test_msr },
-	[PERF_RAPL_PKG]  = { MSR_PKG_ENERGY_STATUS,      &rapl_events_pkg_group,   test_msr },
-	[PERF_RAPL_RAM]  = { MSR_DRAM_ENERGY_STATUS,     &rapl_events_ram_group,   test_msr },
-	[PERF_RAPL_PP1]  = { MSR_PP1_ENERGY_STATUS,      &rapl_events_gpu_group,   test_msr },
-	[PERF_RAPL_PSYS] = { MSR_PLATFORM_ENERGY_STATUS, &rapl_events_psys_group,  test_msr },
+	[PERF_RAPL_PP0]  = { MSR_PP0_ENERGY_STATUS,      &rapl_events_cores_group, test_msr, false, RAPL_MSR_MASK },
+	[PERF_RAPL_PKG]  = { MSR_PKG_ENERGY_STATUS,      &rapl_events_pkg_group,   test_msr, false, RAPL_MSR_MASK },
+	[PERF_RAPL_RAM]  = { MSR_DRAM_ENERGY_STATUS,     &rapl_events_ram_group,   test_msr, false, RAPL_MSR_MASK },
+	[PERF_RAPL_PP1]  = { MSR_PP1_ENERGY_STATUS,      &rapl_events_gpu_group,   test_msr, false, RAPL_MSR_MASK },
+	[PERF_RAPL_PSYS] = { MSR_PLATFORM_ENERGY_STATUS, &rapl_events_psys_group,  test_msr, false, RAPL_MSR_MASK },
 };
 
 /*
