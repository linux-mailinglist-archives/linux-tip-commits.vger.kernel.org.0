Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 103E0365694
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231616AbhDTKrV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:47:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51726 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231720AbhDTKrS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 06:47:18 -0400
Date:   Tue, 20 Apr 2021 10:46:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618915606;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7oCBInMN1U2Z+0UqKq+DjT86NbNKVxJz1s8+neUJqFA=;
        b=qqfKmzTy3n6xZW0JBpy5IEou7LcwUvzm9Jb+p1VLcU+tpdAhEb5FqEX81BCoQ7ZvRT+6AB
        OMBOZUstB/LYQLwGQIH4cvZWgZmRmnD+zxjvJwVL93FW4VLyjVTCoIfTNvQccdpMFzQSfs
        V/mpj1V7lTKXALuKdxXAjjUGucB825pF81ZvIiq+nvID0pw6ieFUjOd2qzywmZ0xWNWT1U
        bjkdaTy4IrZRhGzpHMqn1QRDctRkLVbN3nL0sThzKdioivKCCamBUjkfvK9BSlH3OTlO88
        nhsFVDR123pW+zqWPnihnu7S6nMj3RJfUmlNVnjwHyNR5jCtw+tDvQRWgpXAdQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915606;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7oCBInMN1U2Z+0UqKq+DjT86NbNKVxJz1s8+neUJqFA=;
        b=o1+Vx18ddMBaYBy2lOlhUR/fLI3BCBO4cYK1RDLQOg7LXv271BwQz95u/dzLtARAIcmsCO
        we+KqAhXlAJTMGBA==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Factor out intel_pmu_check_num_counters
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1618237865-33448-12-git-send-email-kan.liang@linux.intel.com>
References: <1618237865-33448-12-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161891560610.29796.15047527697144952551.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b8c4d1a87610ba20da1abddb7aacbde0b2817c1a
Gitweb:        https://git.kernel.org/tip/b8c4d1a87610ba20da1abddb7aacbde0b2817c1a
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 12 Apr 2021 07:30:51 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 19 Apr 2021 20:03:26 +02:00

perf/x86/intel: Factor out intel_pmu_check_num_counters

Each Hybrid PMU has to check its own number of counters and mask fixed
counters before registration.

The intel_pmu_check_num_counters will be reused later to check the
number of the counters for each hybrid PMU.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/1618237865-33448-12-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 38 ++++++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index f727aa5..d7e2021 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5064,6 +5064,26 @@ static const struct attribute_group *attr_update[] = {
 
 static struct attribute *empty_attrs;
 
+static void intel_pmu_check_num_counters(int *num_counters,
+					 int *num_counters_fixed,
+					 u64 *intel_ctrl, u64 fixed_mask)
+{
+	if (*num_counters > INTEL_PMC_MAX_GENERIC) {
+		WARN(1, KERN_ERR "hw perf events %d > max(%d), clipping!",
+		     *num_counters, INTEL_PMC_MAX_GENERIC);
+		*num_counters = INTEL_PMC_MAX_GENERIC;
+	}
+	*intel_ctrl = (1ULL << *num_counters) - 1;
+
+	if (*num_counters_fixed > INTEL_PMC_MAX_FIXED) {
+		WARN(1, KERN_ERR "hw perf events fixed %d > max(%d), clipping!",
+		     *num_counters_fixed, INTEL_PMC_MAX_FIXED);
+		*num_counters_fixed = INTEL_PMC_MAX_FIXED;
+	}
+
+	*intel_ctrl |= fixed_mask << INTEL_PMC_IDX_FIXED;
+}
+
 __init int intel_pmu_init(void)
 {
 	struct attribute **extra_skl_attr = &empty_attrs;
@@ -5703,20 +5723,10 @@ __init int intel_pmu_init(void)
 
 	x86_pmu.attr_update = attr_update;
 
-	if (x86_pmu.num_counters > INTEL_PMC_MAX_GENERIC) {
-		WARN(1, KERN_ERR "hw perf events %d > max(%d), clipping!",
-		     x86_pmu.num_counters, INTEL_PMC_MAX_GENERIC);
-		x86_pmu.num_counters = INTEL_PMC_MAX_GENERIC;
-	}
-	x86_pmu.intel_ctrl = (1ULL << x86_pmu.num_counters) - 1;
-
-	if (x86_pmu.num_counters_fixed > INTEL_PMC_MAX_FIXED) {
-		WARN(1, KERN_ERR "hw perf events fixed %d > max(%d), clipping!",
-		     x86_pmu.num_counters_fixed, INTEL_PMC_MAX_FIXED);
-		x86_pmu.num_counters_fixed = INTEL_PMC_MAX_FIXED;
-	}
-
-	x86_pmu.intel_ctrl |= (u64)fixed_mask << INTEL_PMC_IDX_FIXED;
+	intel_pmu_check_num_counters(&x86_pmu.num_counters,
+				     &x86_pmu.num_counters_fixed,
+				     &x86_pmu.intel_ctrl,
+				     (u64)fixed_mask);
 
 	/* AnyThread may be deprecated on arch perfmon v5 or later */
 	if (x86_pmu.intel_cap.anythread_deprecated)
