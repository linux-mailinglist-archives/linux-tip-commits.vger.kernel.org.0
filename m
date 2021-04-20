Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF6B365692
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:46:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbhDTKrU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:47:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51760 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231699AbhDTKrS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 06:47:18 -0400
Date:   Tue, 20 Apr 2021 10:46:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618915606;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iUhV24AHF2gQf7jCEY6harnTV3RREe8Kfa2IMBsStjU=;
        b=ZL8FGYflNYvcvC3ddLvZAuIdV3/5VB9Qqu68Dq3eJDZmBuXuyJzn5ROhwVh4pLjLFmt6BH
        Y6BnEo6v0W8m4tZPRImyQS0zJP5Fs0kwXTxVWHq+2BXDIwnKqpQV+EIdcU+yUT3tqXx+C4
        nANeOR0tOWJNx9+PVCowrRHXkHKQeaQVdNYTf2PhYCV2BD8Xag6iJjMpwaqwkucLSHNu6i
        isD8mLR+yJ2NWEw24q9S+uc8uIDYaVYLwA8RuDXL+9Wjkm16ueDPY5Hd8z5aLR2U08rGl/
        BlXx79MgEk9JhNomB0pdiaMCApz5l+ts8Gf/Qj9CXzlwCA5A42F0hR+EH8t0VQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915606;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iUhV24AHF2gQf7jCEY6harnTV3RREe8Kfa2IMBsStjU=;
        b=pm/8yNETuxXde9y2y1xmLeIshLEVyFhns/vi87INW/xYAqR7cFAqs3gCJYfrmG7qmOkZJm
        DQahu1mKEt7ZMZBQ==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Factor out intel_pmu_check_extra_regs
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1618237865-33448-14-git-send-email-kan.liang@linux.intel.com>
References: <1618237865-33448-14-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161891560539.29796.12004051168002944954.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     34d5b61f29eea656be4283213273c33d5987e4d2
Gitweb:        https://git.kernel.org/tip/34d5b61f29eea656be4283213273c33d5987e4d2
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 12 Apr 2021 07:30:53 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 19 Apr 2021 20:03:26 +02:00

perf/x86/intel: Factor out intel_pmu_check_extra_regs

Each Hybrid PMU has to check and update its own extra registers before
registration.

The intel_pmu_check_extra_regs will be reused later to check the extra
registers of each hybrid PMU.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/1618237865-33448-14-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c | 35 +++++++++++++++++++++--------------
 1 file changed, 21 insertions(+), 14 deletions(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 5c5f330..55ccfbb 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -5127,6 +5127,26 @@ static void intel_pmu_check_event_constraints(struct event_constraint *event_con
 	}
 }
 
+static void intel_pmu_check_extra_regs(struct extra_reg *extra_regs)
+{
+	struct extra_reg *er;
+
+	/*
+	 * Access extra MSR may cause #GP under certain circumstances.
+	 * E.g. KVM doesn't support offcore event
+	 * Check all extra_regs here.
+	 */
+	if (!extra_regs)
+		return;
+
+	for (er = extra_regs; er->msr; er++) {
+		er->extra_msr_access = check_msr(er->msr, 0x11UL);
+		/* Disable LBR select mapping */
+		if ((er->idx == EXTRA_REG_LBR) && !er->extra_msr_access)
+			x86_pmu.lbr_sel_map = NULL;
+	}
+}
+
 __init int intel_pmu_init(void)
 {
 	struct attribute **extra_skl_attr = &empty_attrs;
@@ -5138,7 +5158,6 @@ __init int intel_pmu_init(void)
 	union cpuid10_eax eax;
 	union cpuid10_ebx ebx;
 	unsigned int fixed_mask;
-	struct extra_reg *er;
 	bool pmem = false;
 	int version, i;
 	char *name;
@@ -5795,19 +5814,7 @@ __init int intel_pmu_init(void)
 	if (x86_pmu.lbr_nr)
 		pr_cont("%d-deep LBR, ", x86_pmu.lbr_nr);
 
-	/*
-	 * Access extra MSR may cause #GP under certain circumstances.
-	 * E.g. KVM doesn't support offcore event
-	 * Check all extra_regs here.
-	 */
-	if (x86_pmu.extra_regs) {
-		for (er = x86_pmu.extra_regs; er->msr; er++) {
-			er->extra_msr_access = check_msr(er->msr, 0x11UL);
-			/* Disable LBR select mapping */
-			if ((er->idx == EXTRA_REG_LBR) && !er->extra_msr_access)
-				x86_pmu.lbr_sel_map = NULL;
-		}
-	}
+	intel_pmu_check_extra_regs(x86_pmu.extra_regs);
 
 	/* Support full width counters using alternative MSR range */
 	if (x86_pmu.intel_cap.full_width_write) {
