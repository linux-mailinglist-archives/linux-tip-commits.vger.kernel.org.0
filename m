Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BB953F4795
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Aug 2021 11:32:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235886AbhHWJd3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 23 Aug 2021 05:33:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45366 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235866AbhHWJd2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 23 Aug 2021 05:33:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 49C22C061757;
        Mon, 23 Aug 2021 02:32:46 -0700 (PDT)
Date:   Mon, 23 Aug 2021 09:32:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1629711164;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AFqSQYjvG7MOiHhVYglTwHaXEPz43vEkqci/gd+mtlg=;
        b=2MvJ0IntLXe3MwaaPQGv5MBF8N2Z7+GKsk+H/o//sxFNPGyQaQJeOCW88pBw3rApYlcMIy
        l5Ic4+O6SULt787gCGn+ux7a0nMQwsyXHvOce8Xpc4/wjQsUmpz8aSDc9RYq0hWRBc9Gw1
        lrgrH7j42oflXZpB3LpziGpPs+gRV+r3ATLB8ZmAbe8HgvfbXTEo2axboLgkMVdmNxRx/N
        0SUrc+omUIdZj6ALrVt8o4tqK8LfvPyj6t9D9QAwxlie4gunmYbItM5q9ildV821cpaBsg
        ulCQRQrdr/byNGfasvdT5g8eB9r4NCHo1i69qLzWZ5x09WYTwPjXXI6SQ9xYQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1629711164;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AFqSQYjvG7MOiHhVYglTwHaXEPz43vEkqci/gd+mtlg=;
        b=z0iPnSzlApWsssV1m2DSHt5IZmyYkm3cwCLhB0NHvIwhpZ7DDb4BObw9ShRfmulE3gjDnm
        Mgoksxbj54rQBdDA==
From:   "tip-bot2 for Kim Phillips" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/amd/uncore: Allow the driver to be built as a module
Cc:     Kim Phillips <kim.phillips@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210817221048.88063-8-kim.phillips@amd.com>
References: <20210817221048.88063-8-kim.phillips@amd.com>
MIME-Version: 1.0
Message-ID: <162971116413.25758.1318593988723804136.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     50b46ab90f7c43a1adcc9099211b7447818d446e
Gitweb:        https://git.kernel.org/tip/50b46ab90f7c43a1adcc9099211b7447818d446e
Author:        Kim Phillips <kim.phillips@amd.com>
AuthorDate:    Tue, 17 Aug 2021 17:10:47 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 20 Aug 2021 12:33:13 +02:00

perf/amd/uncore: Allow the driver to be built as a module

Add support to build the AMD uncore driver as a module.
This is in order to facilitate development.

Signed-off-by: Kim Phillips <kim.phillips@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
