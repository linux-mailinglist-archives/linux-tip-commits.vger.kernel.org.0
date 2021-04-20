Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A79E6365696
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:46:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231859AbhDTKrV (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:47:21 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51694 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbhDTKrT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 06:47:19 -0400
Date:   Tue, 20 Apr 2021 10:46:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618915607;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w3q2yXDb0NuYOY6pu0WwE3gDziNmEsfNWMH6rmlli/g=;
        b=oYG3j7Q4KJWCkPAwpF6zlyMLagaaOaSOaM7N8062SDS1v+Jn1mHJUmDki3IIqLQGHgcjMk
        cCngkJl5663Vwd2dHjeU6vJ2MybIKz0CuovyJoEwH0jcyQnS2be/JLwhsGiMKIZivE+WEu
        GIGNyboxFedV2hZgYcx0pqKPabReMzcVulmXKqixXfGZLnG5JRK7kveIDozxXHxuiAjhYL
        O85NEszblNfAcBKAXQZxrxJqZPOLriCDQQyCiGi5mLVOf2CDtrUqm2yz4raJy0d3yYcN2B
        YuGwA0CmJZFp/owk+ciDSl+mvJNJ52J8eKze07S3XzGIlS0sR3Qz0Enx+p/z2A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915607;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=w3q2yXDb0NuYOY6pu0WwE3gDziNmEsfNWMH6rmlli/g=;
        b=IxJ5vQZJo8scXMJIwz8oAh4Emdcfm7cg2szfJt6kYeyADGXx4JojIeFF5dFl1iR/KCNI1N
        t/hVV8KadacMYoBg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Hybrid PMU support for extra_regs
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andi Kleen <ak@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1618237865-33448-11-git-send-email-kan.liang@linux.intel.com>
References: <1618237865-33448-11-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161891560647.29796.8373012017821829003.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     183af7366b4e813ee4e0b995ff731e3ac28251f0
Gitweb:        https://git.kernel.org/tip/183af7366b4e813ee4e0b995ff731e3ac28251f0
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 12 Apr 2021 07:30:50 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 19 Apr 2021 20:03:26 +02:00

perf/x86: Hybrid PMU support for extra_regs

Different hybrid PMU may have different extra registers, e.g. Core PMU
may have offcore registers, frontend register and ldlat register. Atom
core may only have offcore registers and ldlat register. Each hybrid PMU
should use its own extra_regs.

An Intel Hybrid system should always have extra registers.
Unconditionally allocate shared_regs for Intel Hybrid system.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Link: https://lkml.kernel.org/r/1618237865-33448-11-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/core.c       |  5 +++--
 arch/x86/events/intel/core.c | 15 +++++++++------
 arch/x86/events/perf_event.h |  1 +
 3 files changed, 13 insertions(+), 8 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index f92d234..57d3fe1 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -154,15 +154,16 @@ again:
  */
 static int x86_pmu_extra_regs(u64 config, struct perf_event *event)
 {
+	struct extra_reg *extra_regs = hybrid(event->pmu, extra_regs);
 	struct hw_perf_event_extra *reg;
 	struct extra_reg *er;
 
 	reg = &event->hw.extra_reg;
 
-	if (!x86_pmu.extra_regs)
+	if (!extra_regs)
 		return 0;
 
-	for (er = x86_pmu.extra_regs; er->msr; er++) {
+	for (er = extra_regs; er->msr; er++) {
 		if (er->event != (config & er->config_mask))
 			continue;
 		if (event->attr.config1 & ~er->valid_mask)
diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 447a80f..f727aa5 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -2966,8 +2966,10 @@ intel_vlbr_constraints(struct perf_event *event)
 	return NULL;
 }
 
-static int intel_alt_er(int idx, u64 config)
+static int intel_alt_er(struct cpu_hw_events *cpuc,
+			int idx, u64 config)
 {
+	struct extra_reg *extra_regs = hybrid(cpuc->pmu, extra_regs);
 	int alt_idx = idx;
 
 	if (!(x86_pmu.flags & PMU_FL_HAS_RSP_1))
@@ -2979,7 +2981,7 @@ static int intel_alt_er(int idx, u64 config)
 	if (idx == EXTRA_REG_RSP_1)
 		alt_idx = EXTRA_REG_RSP_0;
 
-	if (config & ~x86_pmu.extra_regs[alt_idx].valid_mask)
+	if (config & ~extra_regs[alt_idx].valid_mask)
 		return idx;
 
 	return alt_idx;
@@ -2987,15 +2989,16 @@ static int intel_alt_er(int idx, u64 config)
 
 static void intel_fixup_er(struct perf_event *event, int idx)
 {
+	struct extra_reg *extra_regs = hybrid(event->pmu, extra_regs);
 	event->hw.extra_reg.idx = idx;
 
 	if (idx == EXTRA_REG_RSP_0) {
 		event->hw.config &= ~INTEL_ARCH_EVENT_MASK;
-		event->hw.config |= x86_pmu.extra_regs[EXTRA_REG_RSP_0].event;
+		event->hw.config |= extra_regs[EXTRA_REG_RSP_0].event;
 		event->hw.extra_reg.reg = MSR_OFFCORE_RSP_0;
 	} else if (idx == EXTRA_REG_RSP_1) {
 		event->hw.config &= ~INTEL_ARCH_EVENT_MASK;
-		event->hw.config |= x86_pmu.extra_regs[EXTRA_REG_RSP_1].event;
+		event->hw.config |= extra_regs[EXTRA_REG_RSP_1].event;
 		event->hw.extra_reg.reg = MSR_OFFCORE_RSP_1;
 	}
 }
@@ -3071,7 +3074,7 @@ again:
 		 */
 		c = NULL;
 	} else {
-		idx = intel_alt_er(idx, reg->config);
+		idx = intel_alt_er(cpuc, idx, reg->config);
 		if (idx != reg->idx) {
 			raw_spin_unlock_irqrestore(&era->lock, flags);
 			goto again;
@@ -4155,7 +4158,7 @@ int intel_cpuc_prepare(struct cpu_hw_events *cpuc, int cpu)
 {
 	cpuc->pebs_record_size = x86_pmu.pebs_record_size;
 
-	if (x86_pmu.extra_regs || x86_pmu.lbr_sel_map) {
+	if (is_hybrid() || x86_pmu.extra_regs || x86_pmu.lbr_sel_map) {
 		cpuc->shared_regs = allocate_shared_regs(cpu);
 		if (!cpuc->shared_regs)
 			goto err;
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 34b7fc9..d8c448b 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -650,6 +650,7 @@ struct x86_hybrid_pmu {
 					[PERF_COUNT_HW_CACHE_RESULT_MAX];
 	struct event_constraint		*event_constraints;
 	struct event_constraint		*pebs_constraints;
+	struct extra_reg		*extra_regs;
 };
 
 static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *pmu)
