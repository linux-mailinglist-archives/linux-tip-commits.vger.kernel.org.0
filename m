Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 01E2A2AD697
	for <lists+linux-tip-commits@lfdr.de>; Tue, 10 Nov 2020 13:45:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729183AbgKJMpU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 10 Nov 2020 07:45:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726462AbgKJMpT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 10 Nov 2020 07:45:19 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEBADC0613CF;
        Tue, 10 Nov 2020 04:45:19 -0800 (PST)
Date:   Tue, 10 Nov 2020 12:45:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605012318;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HrTgrf7/CGEXNHmsjzQw3hJOy7cpo4rYK2KkMa6DqNg=;
        b=YRUMLgQbeEve/2EJef4jQi4n1x2DSds5VbaWIfz5XujhwfKDRNyLiqKaGX2uCmdcRhD0RY
        +RlBAC5SRBEmaq6aaKsSnrDYZiwt8saATXyZL8zvsYuIqpxOHsODcWt88NFcQKT/yQSK2h
        qVCM+FdftwQBOsFKNzTtwOO82oNs/OhaX7LWhTslmzMVZqZ4vrfTduiD64hZ8KV/J1pj48
        9oZyuFjInBw8l7K4nLpTfQtqso7KBwCOBNAFfaquMKS+TII8ZfwAwPk2ES1j0S+Q9YgqxE
        UgrhXTeLQ04pOnWKc63+PDdzUtUv9ZstIQsY/9+vB1Q4KVVIi3uOLOfBzikb/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605012318;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=HrTgrf7/CGEXNHmsjzQw3hJOy7cpo4rYK2KkMa6DqNg=;
        b=fSo1sY0WJx8AXUQhZIXx6bHjM17xgROvt+RFQ5AzVyZwPDR67cZTUIT5fyepRvEE6PIxF5
        DHkT65lNVGE5yyBA==
From:   "tip-bot2 for Stephane Eranian" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf/x86/intel: Make anythread filter support conditional
Cc:     Stephane Eranian <eranian@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201028194247.3160610-1-eranian@google.com>
References: <20201028194247.3160610-1-eranian@google.com>
MIME-Version: 1.0
Message-ID: <160501231688.11244.5518242768684799323.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     cadbaa039b99a6d5c26ce1c7f2fc0325943e605a
Gitweb:        https://git.kernel.org/tip/cadbaa039b99a6d5c26ce1c7f2fc0325943e605a
Author:        Stephane Eranian <eranian@google.com>
AuthorDate:    Wed, 28 Oct 2020 12:42:47 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 09 Nov 2020 18:12:36 +01:00

perf/x86/intel: Make anythread filter support conditional

Starting with Arch Perfmon v5, the anythread filter on generic counters may be
deprecated. The current kernel was exporting the any filter without checking.
On Icelake, it means you could do cpu/event=0x3c,any/ even though the filter
does not exist. This patch corrects the problem by relying on the CPUID 0xa leaf
function to determine if anythread is supported or not as described in the
Intel SDM Vol3b 18.2.5.1 AnyThread Deprecation section.

Signed-off-by: Stephane Eranian <eranian@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201028194247.3160610-1-eranian@google.com
---
 arch/x86/events/intel/core.c      | 10 ++++++++++
 arch/x86/events/perf_event.h      |  1 +
 arch/x86/include/asm/perf_event.h |  4 +++-
 arch/x86/kvm/cpuid.c              |  4 +++-
 4 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index c37387c..af457f8 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -4987,6 +4987,12 @@ __init int intel_pmu_init(void)
 
 	x86_add_quirk(intel_arch_events_quirk); /* Install first, so it runs last */
 
+	if (version >= 5) {
+		x86_pmu.intel_cap.anythread_deprecated = edx.split.anythread_deprecated;
+		if (x86_pmu.intel_cap.anythread_deprecated)
+			pr_cont(" AnyThread deprecated, ");
+	}
+
 	/*
 	 * Install the hw-cache-events table:
 	 */
@@ -5512,6 +5518,10 @@ __init int intel_pmu_init(void)
 	x86_pmu.intel_ctrl |=
 		((1LL << x86_pmu.num_counters_fixed)-1) << INTEL_PMC_IDX_FIXED;
 
+	/* AnyThread may be deprecated on arch perfmon v5 or later */
+	if (x86_pmu.intel_cap.anythread_deprecated)
+		x86_pmu.format_attrs = intel_arch_formats_attr;
+
 	if (x86_pmu.event_constraints) {
 		/*
 		 * event on fixed counter2 (REF_CYCLES) only works on this
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 1d1fe46..6a8edfe 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -585,6 +585,7 @@ union perf_capabilities {
 		u64     pebs_baseline:1;
 		u64	perf_metrics:1;
 		u64	pebs_output_pt_available:1;
+		u64	anythread_deprecated:1;
 	};
 	u64	capabilities;
 };
diff --git a/arch/x86/include/asm/perf_event.h b/arch/x86/include/asm/perf_event.h
index 6960cd6..b9a7fd0 100644
--- a/arch/x86/include/asm/perf_event.h
+++ b/arch/x86/include/asm/perf_event.h
@@ -137,7 +137,9 @@ union cpuid10_edx {
 	struct {
 		unsigned int num_counters_fixed:5;
 		unsigned int bit_width_fixed:8;
-		unsigned int reserved:19;
+		unsigned int reserved1:2;
+		unsigned int anythread_deprecated:1;
+		unsigned int reserved2:16;
 	} split;
 	unsigned int full;
 };
diff --git a/arch/x86/kvm/cpuid.c b/arch/x86/kvm/cpuid.c
index 06a278b..0752dec 100644
--- a/arch/x86/kvm/cpuid.c
+++ b/arch/x86/kvm/cpuid.c
@@ -672,7 +672,9 @@ static inline int __do_cpuid_func(struct kvm_cpuid_array *array, u32 function)
 
 		edx.split.num_counters_fixed = min(cap.num_counters_fixed, MAX_FIXED_COUNTERS);
 		edx.split.bit_width_fixed = cap.bit_width_fixed;
-		edx.split.reserved = 0;
+		edx.split.anythread_deprecated = 1;
+		edx.split.reserved1 = 0;
+		edx.split.reserved2 = 0;
 
 		entry->eax = eax.full;
 		entry->ebx = cap.events_mask;
