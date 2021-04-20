Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD33136569C
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Apr 2021 12:49:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231933AbhDTKrY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Apr 2021 06:47:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51776 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231697AbhDTKrU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Apr 2021 06:47:20 -0400
Date:   Tue, 20 Apr 2021 10:46:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618915608;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Me9XW91LlQeBfIHqYlIkIglxDJcf6L3rT+dG+kW4VAI=;
        b=CPmvPPDsh8A2P5bxUCvCCPKOlvekcWs4liqVylChGc1sCugorlxrYKLxiXiYyUcjKSdI32
        jHBLjlD86nD0gQkpLAFxBZZCbIlBU4wPzZkic0Nutczs+xHKkdRc/iYOKff1byhuto5bKV
        D2eFpwTqDmfAOKfUbQVFhGOmd4pMUpi3HT7TQAJThgjr/o5+PtBEBnEjxrBtqe3zAE/Iut
        d/OEgAK6hitod6GCxbsp7w6YfJsqkhwyuv9OV1lHtGhRcWKyz+LSfOBAvvi1z4U4srjbiF
        +uc0LOJziV6WQ8ijKPlQVojLp883TdZMV3KILdbhT9VCZn4k2x6OM3w1yiRHlw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618915608;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Me9XW91LlQeBfIHqYlIkIglxDJcf6L3rT+dG+kW4VAI=;
        b=pkfuCpAbAv+N5iU7MLzVql/9z0GwMd3QipIt5GgqdakeliE6bHZX42lMq/CySzSgOEpr4/
        8dxus4a1OXiapuAg==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86: Hybrid PMU support for unconstrained
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kan Liang <kan.liang@linux.intel.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <1618237865-33448-8-git-send-email-kan.liang@linux.intel.com>
References: <1618237865-33448-8-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161891560757.29796.6555570837621149245.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     eaacf07d1116f6bf3b93b265515fccf2301097f2
Gitweb:        https://git.kernel.org/tip/eaacf07d1116f6bf3b93b265515fccf2301097f2
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 12 Apr 2021 07:30:47 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 19 Apr 2021 20:03:25 +02:00

perf/x86: Hybrid PMU support for unconstrained

The unconstrained value depends on the number of GP and fixed counters.
Each hybrid PMU should use its own unconstrained.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/1618237865-33448-8-git-send-email-kan.liang@linux.intel.com
---
 arch/x86/events/intel/core.c |  2 +-
 arch/x86/events/perf_event.h | 11 +++++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/arch/x86/events/intel/core.c b/arch/x86/events/intel/core.c
index 3ea0126..4cfc382 100644
--- a/arch/x86/events/intel/core.c
+++ b/arch/x86/events/intel/core.c
@@ -3147,7 +3147,7 @@ x86_get_event_constraints(struct cpu_hw_events *cpuc, int idx,
 		}
 	}
 
-	return &unconstrained;
+	return &hybrid_var(cpuc->pmu, unconstrained);
 }
 
 static struct event_constraint *
diff --git a/arch/x86/events/perf_event.h b/arch/x86/events/perf_event.h
index 0539ad4..2688e45 100644
--- a/arch/x86/events/perf_event.h
+++ b/arch/x86/events/perf_event.h
@@ -638,6 +638,7 @@ struct x86_hybrid_pmu {
 	int				max_pebs_events;
 	int				num_counters;
 	int				num_counters_fixed;
+	struct event_constraint		unconstrained;
 };
 
 static __always_inline struct x86_hybrid_pmu *hybrid_pmu(struct pmu *pmu)
@@ -658,6 +659,16 @@ extern struct static_key_false perf_is_hybrid;
 	__Fp;						\
 }))
 
+#define hybrid_var(_pmu, _var)				\
+(*({							\
+	typeof(&_var) __Fp = &_var;			\
+							\
+	if (is_hybrid() && (_pmu))			\
+		__Fp = &hybrid_pmu(_pmu)->_var;		\
+							\
+	__Fp;						\
+}))
+
 /*
  * struct x86_pmu - generic x86 pmu
  */
