Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 584353F8381
	for <lists+linux-tip-commits@lfdr.de>; Thu, 26 Aug 2021 10:09:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240327AbhHZIKk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 26 Aug 2021 04:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240118AbhHZIKj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 26 Aug 2021 04:10:39 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 352CFC061757;
        Thu, 26 Aug 2021 01:09:52 -0700 (PDT)
Date:   Thu, 26 Aug 2021 08:09:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629965390;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i1hzitIR/2JRsSVDL+vTG8mjWplfSh/G8llvGqpFg2k=;
        b=lBXHEy/JZKsCjQIzCNWaabKUMEQsMJsArr14jf9+11YBQKgI/FxXZeQsYvqjUt416LCdRU
        LPIivGVdGdgQKmPUtOe01RMsM5FZuv5nZjqdTJjbar/KLRZQYDCqK2o4CBKovAo6h6aYiE
        oeSVbwPyVFznNqQRF37PdaBVQZ/Wo6stchdbTnFtNC43H0le5sga33z/rQciERR0kR48I9
        h6KvdF1xtTB058pCX3FstRCiLkpu//3fpR4oNKWGmrI5q/D0agdVJljD/Aq0lBbxXIjw7b
        CA8JmTbP+5ZpA4zjX+Pf9DWWpBNWgMt2jmtZNjjVBZiThVlnl/kW6A8Wq8IYOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629965390;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i1hzitIR/2JRsSVDL+vTG8mjWplfSh/G8llvGqpFg2k=;
        b=1pE5A6w3WwAN6Vw2TArR/Lt2HclRzJbgMzlmVddUzhLK0BvrAQfYwobzbJYgUc1cxgUv4p
        jKDkjXTwtWtW9eCg==
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd/uncore: Allow the driver to be built as a module
Cc:     Kim Phillips <kim.phillips@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210817221048.88063-8-kim.phillips@amd.com>
References: <20210817221048.88063-8-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <162996539004.25758.14799927560283241124.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     05485745ad482c1910a45f23a5c255f6a0df0f46
Gitweb:        https://git.kernel.org/tip/05485745ad482c1910a45f23a5c255f6a0df0f46
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Tue, 17 Aug 2021 17:10:47 -05:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 26 Aug 2021 09:14:36 +02:00

perf/amd/uncore: Allow the driver to be built as a module

Add support to build the AMD uncore driver as a module.

This is in order to facilitate development without having
to reboot the kernel in most cases.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210817221048.88063-8-kim.phillips@amd.com
---
 arch/x86/events/Kconfig      | 10 ++++++++++
 arch/x86/events/amd/Makefile |  5 +++--
 arch/x86/events/amd/uncore.c | 28 +++++++++++++++++++++++++++-
 3 files changed, 40 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/Kconfig b/arch/x86/events/Kconfig
index 39d9ded..d6cdfe6 100644
--- a/arch/x86/events/Kconfig
+++ b/arch/x86/events/Kconfig
@@ -34,4 +34,14 @@ config PERF_EVENTS_AMD_POWER
 	  (CPUID Fn8000_0007_EDX[12]) interface to calculate the
 	  average power consumption on Family 15h processors.
 
+config PERF_EVENTS_AMD_UNCORE
+	tristate "AMD Uncore performance events"
+	depends on PERF_EVENTS && CPU_SUP_AMD
+	default y
+	help
+	  Include support for AMD uncore performance events for use with
+	  e.g., perf stat -e amd_l3/.../,amd_df/.../.
+
+	  To compile this driver as a module, choose M here: the
+	  module will be called 'amd-uncore'.
 endmenu
diff --git a/arch/x86/events/amd/Makefile b/arch/x86/events/amd/Makefile
index fe8795a..6cbe38d 100644
--- a/arch/x86/events/amd/Makefile
+++ b/arch/x86/events/amd/Makefile
@@ -1,8 +1,9 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_CPU_SUP_AMD)		+= core.o uncore.o
+obj-$(CONFIG_CPU_SUP_AMD)		+= core.o
 obj-$(CONFIG_PERF_EVENTS_AMD_POWER)	+= power.o
 obj-$(CONFIG_X86_LOCAL_APIC)		+= ibs.o
+obj-$(CONFIG_PERF_EVENTS_AMD_UNCORE)	+= amd-uncore.o
+amd-uncore-objs				:= uncore.o
 ifdef CONFIG_AMD_IOMMU
 obj-$(CONFIG_CPU_SUP_AMD)		+= iommu.o
 endif
-
diff --git a/arch/x86/events/amd/uncore.c b/arch/x86/events/amd/uncore.c
index a01f9f1..0d04414 100644
--- a/arch/x86/events/amd/uncore.c
+++ b/arch/x86/events/amd/uncore.c
@@ -347,6 +347,7 @@ static struct pmu amd_nb_pmu = {
 	.stop		= amd_uncore_stop,
 	.read		= amd_uncore_read,
 	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
+	.module		= THIS_MODULE,
 };
 
 static struct pmu amd_llc_pmu = {
@@ -360,6 +361,7 @@ static struct pmu amd_llc_pmu = {
 	.stop		= amd_uncore_stop,
 	.read		= amd_uncore_read,
 	.capabilities	= PERF_PMU_CAP_NO_EXCLUDE | PERF_PMU_CAP_NO_INTERRUPT,
+	.module		= THIS_MODULE,
 };
 
 static struct amd_uncore *amd_uncore_alloc(unsigned int cpu)
@@ -665,4 +667,28 @@ fail_nb:
 
 	return ret;
 }
-device_initcall(amd_uncore_init);
+
+static void __exit amd_uncore_exit(void)
+{
+	cpuhp_remove_state(CPUHP_AP_PERF_X86_AMD_UNCORE_ONLINE);
+	cpuhp_remove_state(CPUHP_AP_PERF_X86_AMD_UNCORE_STARTING);
+	cpuhp_remove_state(CPUHP_PERF_X86_AMD_UNCORE_PREP);
+
+	if (boot_cpu_has(X86_FEATURE_PERFCTR_LLC)) {
+		perf_pmu_unregister(&amd_llc_pmu);
+		free_percpu(amd_uncore_llc);
+		amd_uncore_llc = NULL;
+	}
+
+	if (boot_cpu_has(X86_FEATURE_PERFCTR_NB)) {
+		perf_pmu_unregister(&amd_nb_pmu);
+		free_percpu(amd_uncore_nb);
+		amd_uncore_nb = NULL;
+	}
+}
+
+module_init(amd_uncore_init);
+module_exit(amd_uncore_exit);
+
+MODULE_DESCRIPTION("AMD Uncore Driver");
+MODULE_LICENSE("GPL v2");
