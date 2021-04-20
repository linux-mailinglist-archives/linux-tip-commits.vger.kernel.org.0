Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1000F365691
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbhDTKrU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:47:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51694 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231668AbhDTKrR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 06:47:17 -0400
Date:   Tue, 20 Apr 2021 10:46:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618915605;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NLmVmR/FMbrFBUFyVKQGXOG90bNyLkxW7lhJieuuxGM=;
        b=qoJxkr8Ju/uNNCqV20GqXbLb9+Q5NkhjtgN+Lmytrxt6xTo/SXe6wXbPe+K38AW0etiAww
        /i55urp0gS/PooqXj+cHXNAPbib3kXW7OAmmIWejEqeaMg3DKiTaeP90NN3Jpej0XdeDUu
        72v+Fe9O36BJUZOPkwc2OMmz13qLIDqzqSMaZxOel0x3RveMIO8cNrl1Mtju98K1cS4AdH
        zNRHUncGs2R/uqqXIZZQaXX/kMuAJJC+dHfzLmpRmElSXzncIMqjKDTlhZ9VaVJ4gf8ipk
        gNPT2DjBM+eVSMe5KP86qZMk8fb++KKghOruVRENFIWdIfNmd95/QBu96YA4kg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915605;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NLmVmR/FMbrFBUFyVKQGXOG90bNyLkxW7lhJieuuxGM=;
        b=WqH+2K1Kotq+U1fM9+SiCdFdTOKT5ugHDvE1Og+x4PE1CItjPIV7ic7aZosc2qc/Xy/i91
        6QhGr57hHQpjJ/Bg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Factor out x86_pmu_show_pmu_cap
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1618237865-33448-16-git-send-email-kan.liang@linux.intel.com>
References: <1618237865-33448-16-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161891560460.29796.11163420194789025178.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e11c1a7eb302ac8f6f47c18fa662546405a5fd83
Gitweb:        https://git.kernel.org/tip/e11c1a7eb302ac8f6f47c18fa662546405a5fd83
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 12 Apr 2021 07:30:55 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 19 Apr 2021 20:03:27 +02:00

perf/x86: Factor out x86_pmu_show_pmu_cap

The PMU capabilities are different among hybrid PMUs. Perf should dump
the PMU capabilities information for each hybrid PMU.

Factor out x86_pmu_show_pmu_cap() which shows the PMU capabilities
information. The function will be reused later when registering a
dedicated hybrid PMU.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/1618237865-33448-16-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/core.c       | 25 ++++++++++++++++---------
 arch/x86/events/perf_event.h |  3 +++
 2 files changed, 19 insertions(+), 9 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index ed8dcfb..2e7ae52 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -1976,6 +1976,20 @@ static void _x86_pmu_read(struct perf_event *event)
 	x86_perf_event_update(event);
 }
 
+void x86_pmu_show_pmu_cap(int num_counters, int num_counters_fixed,
+			  u64 intel_ctrl)
+{
+	pr_info("... version:                %d\n",     x86_pmu.version);
+	pr_info("... bit width:              %d\n",     x86_pmu.cntval_bits);
+	pr_info("... generic registers:      %d\n",     num_counters);
+	pr_info("... value mask:             %016Lx\n", x86_pmu.cntval_mask);
+	pr_info("... max period:             %016Lx\n", x86_pmu.max_period);
+	pr_info("... fixed-purpose events:   %lu\n",
+			hweight64((((1ULL << num_counters_fixed) - 1)
+					<< INTEL_PMC_IDX_FIXED) & intel_ctrl));
+	pr_info("... event mask:             %016Lx\n", intel_ctrl);
+}
+
 static int __init init_hw_perf_events(void)
 {
 	struct x86_pmu_quirk *quirk;
@@ -2036,15 +2050,8 @@ static int __init init_hw_perf_events(void)
 
 	pmu.attr_update = x86_pmu.attr_update;
 
-	pr_info("... version:                %d\n",     x86_pmu.version);
-	pr_info("... bit width:              %d\n",     x86_pmu.cntval_bits);
-	pr_info("... generic registers:      %d\n",     x86_pmu.num_counters);
-	pr_info("... value mask:             %016Lx\n", x86_pmu.cntval_mask);
-	pr_info("... max period:             %016Lx\n", x86_pmu.max_period);
-	pr_info("... fixed-purpose events:   %lu\n",
-			hweight64((((1ULL << x86_pmu.num_counters_fixed) - 1)
-					<< INTEL_PMC_IDX_FIXED) & x86_pmu.intel_ctrl));
-	pr_info("... event mask:             %016Lx\n", x86_pmu.intel_ctrl);
+	x86_pmu_show_pmu_cap(x86_pmu.num_counters, x86_pmu.num_counters_fixed,
+			     x86_pmu.intel_ctrl);
 
 	if (!x86_pmu.read)
 		x86_pmu.read = _x86_pmu_read;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index d8c448b..a3534e3 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -1092,6 +1092,9 @@ void x86_pmu_enable_event(struct perf_event *event);
 
 int x86_pmu_handle_irq(struct pt_regs *regs);
 
+void x86_pmu_show_pmu_cap(int num_counters, int num_counters_fixed,
+			  u64 intel_ctrl);
+
 extern struct event_constraint emptyconstraint;
 
 extern struct event_constraint unconstrained;
