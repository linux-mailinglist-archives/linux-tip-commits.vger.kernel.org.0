Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CAFAB1882FA
	for <lists+linux-tip-commits@lfdr.de>; Tue, 17 Mar 2020 13:08:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726498AbgCQMH4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 17 Mar 2020 08:07:56 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:54345 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726821AbgCQMHy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 17 Mar 2020 08:07:54 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEB0Y-0000Ej-PC; Tue, 17 Mar 2020 13:07:42 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2E7951C228E;
        Tue, 17 Mar 2020 13:07:42 +0100 (CET)
Date:   Tue, 17 Mar 2020 12:07:41 -0000
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd/uncore: Add support for Family 19h L3 PMU
Cc:     Kim Phillips <kim.phillips@amd.com>, Borislav Petkov <bp@suse.de>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200313231024.17601-3-kim.phillips@amd.com>
References: <20200313231024.17601-3-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <158444686182.28353.8090928318657769294.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e48667b865480d8bf0f1171a8b474ffc785b9ace
Gitweb:        https://git.kernel.org/tip/e48667b865480d8bf0f1171a8b474ffc785b9ace
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Fri, 13 Mar 2020 18:10:24 -05:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Tue, 17 Mar 2020 13:01:03 +01:00

perf/amd/uncore: Add support for Family 19h L3 PMU

Family 19h introduces change in slice, core and thread specification in
its L3 Performance Event Select (ChL3PmcCfg) h/w register. The change is
incompatible with Family 17h's version of the register.

Introduce a new path in l3_thread_slice_mask() to do things differently
for Family 19h vs. Family 17h, otherwise the new hardware doesn't get
programmed correctly.

Instead of a linear core--thread bitmask, Family 19h takes an encoded
core number, and a separate thread mask. There are new bits that are set
for all cores and all slices, of which only the latter is used, since
the driver counts events for all slices on behalf of the specified CPU.

Also update amd_uncore_init() to base its L2/NB vs. L3/Data Fabric mode
decision based on Family 17h or above, not just 17h and 18h: the Family
19h Data Fabric PMC is compatible with the Family 17h DF PMC.

 [ bp: Touchups. ]

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20200313231024.17601-3-kim.phillips@amd.com
---
 arch/x86/events/amd/uncore.c      | 20 ++++++++++++++------
 arch/x86/include/asm/perf_event.h | 15 +++++++++++++--
 2 files changed, 27 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index 07af497..46018e5 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -191,10 +191,18 @@ static u64 l3_thread_slice_mask(int cpu)
 	if (topology_smt_supported() && !topology_is_primary_thread(cpu))
 		thread = 1;
 
-	shift = AMD64_L3_THREAD_SHIFT + 2 * (core % 4) + thread;
+	if (boot_cpu_data.x86 <= 0x18) {
+		shift = AMD64_L3_THREAD_SHIFT + 2 * (core % 4) + thread;
+		thread_mask = BIT_ULL(shift);
+
+		return AMD64_L3_SLICE_MASK | thread_mask;
+	}
+
+	core = (core << AMD64_L3_COREID_SHIFT) & AMD64_L3_COREID_MASK;
+	shift = AMD64_L3_THREAD_SHIFT + thread;
 	thread_mask = BIT_ULL(shift);
 
-	return AMD64_L3_SLICE_MASK | thread_mask;
+	return AMD64_L3_EN_ALL_SLICES | core | thread_mask;
 }
 
 static int amd_uncore_event_init(struct perf_event *event)
@@ -223,8 +231,8 @@ static int amd_uncore_event_init(struct perf_event *event)
 		return -EINVAL;
 
 	/*
-	 * SliceMask and ThreadMask need to be set for certain L3 events in
-	 * Family 17h. For other events, the two fields do not affect the count.
+	 * SliceMask and ThreadMask need to be set for certain L3 events.
+	 * For other events, the two fields do not affect the count.
 	 */
 	if (l3_mask && is_llc_event(event))
 		hwc->config |= l3_thread_slice_mask(event->cpu);
@@ -533,9 +541,9 @@ static int __init amd_uncore_init(void)
 	if (!boot_cpu_has(X86_FEATURE_TOPOEXT))
 		return -ENODEV;
 
-	if (boot_cpu_data.x86 == 0x17 || boot_cpu_data.x86 == 0x18) {
+	if (boot_cpu_data.x86 >= 0x17) {
 		/*
-		 * For F17h or F18h, the Northbridge counters are
+		 * For F17h and above, the Northbridge counters are
 		 * repurposed as Data Fabric counters. Also, L3
 		 * counters are supported too. The PMUs are exported
 		 * based on family as either L2 or L3 and NB or DF.
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 29964b0..e855e9c 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -50,11 +50,22 @@
 
 #define AMD64_L3_SLICE_SHIFT				48
 #define AMD64_L3_SLICE_MASK				\
-	((0xFULL) << AMD64_L3_SLICE_SHIFT)
+	(0xFULL << AMD64_L3_SLICE_SHIFT)
+#define AMD64_L3_SLICEID_MASK				\
+	(0x7ULL << AMD64_L3_SLICE_SHIFT)
 
 #define AMD64_L3_THREAD_SHIFT				56
 #define AMD64_L3_THREAD_MASK				\
-	((0xFFULL) << AMD64_L3_THREAD_SHIFT)
+	(0xFFULL << AMD64_L3_THREAD_SHIFT)
+#define AMD64_L3_F19H_THREAD_MASK			\
+	(0x3ULL << AMD64_L3_THREAD_SHIFT)
+
+#define AMD64_L3_EN_ALL_CORES				BIT_ULL(47)
+#define AMD64_L3_EN_ALL_SLICES				BIT_ULL(46)
+
+#define AMD64_L3_COREID_SHIFT				42
+#define AMD64_L3_COREID_MASK				\
+	(0x7ULL << AMD64_L3_COREID_SHIFT)
 
 #define X86_RAW_EVENT_MASK		\
 	(ARCH_PERFMON_EVENTSEL_EVENT |	\
