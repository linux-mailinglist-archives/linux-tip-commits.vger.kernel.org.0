Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE2036569B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbhDTKrY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:47:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51760 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231806AbhDTKrT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 06:47:19 -0400
Date:   Tue, 20 Apr 2021 10:46:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618915607;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nxvb2d9t7QtL3szi9lkQKfjp4rSxFhQi2y9/y6ctxB4=;
        b=JcDa2yvBMB4ZursT6R3nIo2BQqMddqAje0qoHJh1jmNi5BDZzyl4pVyAltBCMN2Vgcy3cy
        2ShxM/45Zetwm3OxoyFxIMRFF+sUwcvW255zI3xg6V/haPTuoKwhA7SmZNjV8YSC8JK5vk
        4GK8D63ZO1YZAvYVq52uuEmZ/tveTWCbPviRDfo3lz0gt50xavx3iXO8OwcXTLT1iBBzF7
        GjAe9PzlT4hxV5mD4+xgNgCzPTPXiMDJa5Bae36+glfP3yOTj5hiTvhiRmP0ZHo7yYQ2K/
        1Jkg3IKaQqXXY1lKLK/GRI3qUzUW5ZMYNgsAvF/SnJo6mhUuk3RL09S6A+K42Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915607;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nxvb2d9t7QtL3szi9lkQKfjp4rSxFhQi2y9/y6ctxB4=;
        b=JEiw7esu38g6DvcipTNot9vXHez8a5DAMVBLgsH7LiUWLBmoIlr1adjT+RWW49WdjRnn65
        zhLcelkqgNRCIdDg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Hybrid PMU support for hardware cache event
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1618237865-33448-9-git-send-email-kan.liang@linux.intel.com>
References: <1618237865-33448-9-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161891560719.29796.6182339486933075554.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     0d18f2dfead8dd63bf1186c9ef38528d6a615a55
Gitweb:        https://git.kernel.org/tip/0d18f2dfead8dd63bf1186c9ef38528d6a615a55
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 12 Apr 2021 07:30:48 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 19 Apr 2021 20:03:25 +02:00

perf/x86: Hybrid PMU support for hardware cache event

The hardware cache events are different among hybrid PMUs. Each hybrid
PMU should have its own hw cache event table.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1618237865-33448-9-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/core.c       |  5 ++---
 arch/x86/events/perf_event.h |  9 +++++++++
 2 files changed, 11 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/core.c b/arch/x86/events/core.c
index 1aeb31c..e8cb892 100644
--- a/arch/x86/events/core.c
+++ b/arch/x86/events/core.c
@@ -376,8 +376,7 @@ set_ext_hw_attr(struct hw_perf_event *hwc, struct perf_event *event)
 		return -EINVAL;
 	cache_result = array_index_nospec(cache_result, PERF_COUNT_HW_CACHE_RESULT_MAX);
 
-	val = hw_cache_event_ids[cache_type][cache_op][cache_result];
-
+	val = hybrid_var(event->pmu, hw_cache_event_ids)[cache_type][cache_op][cache_result];
 	if (val == 0)
 		return -ENOENT;
 
@@ -385,7 +384,7 @@ set_ext_hw_attr(struct hw_perf_event *hwc, struct perf_event *event)
 		return -EINVAL;
 
 	hwc->config |= val;
-	attr->config1 = hw_cache_extra_regs[cache_type][cache_op][cache_result];
+	attr->config1 = hybrid_var(event->pmu, hw_cache_extra_regs)[cache_type][cache_op][cache_result];
 	return x86_pmu_extra_regs(val, event);
 }
 
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 2688e45..b65cf46 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -639,6 +639,15 @@ struct x86_hybrid_pmu {
 	int				num_counters;
 	int				num_counters_fixed;
 	struct event_constraint		unconstrained;
+
+	u64				hw_cache_event_ids
+					[PERF_COUNT_HW_CACHE_MAX]
+					[PERF_COUNT_HW_CACHE_OP_MAX]
+					[PERF_COUNT_HW_CACHE_RESULT_MAX];
+	u64				hw_cache_extra_regs
+					[PERF_COUNT_HW_CACHE_MAX]
+					[PERF_COUNT_HW_CACHE_OP_MAX]
+					[PERF_COUNT_HW_CACHE_RESULT_MAX];
 };
 
 static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *pmu)
