Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3E1529E9B1
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Oct 2020 11:53:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725774AbgJ2Kw5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Oct 2020 06:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726885AbgJ2Kvp (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Oct 2020 06:51:45 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D7B58C0613D3;
        Thu, 29 Oct 2020 03:51:44 -0700 (PDT)
Date:   Thu, 29 Oct 2020 10:51:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603968703;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D7+ECYjm99yWKNOlQAiuEYWqORzhy6nrucWXVty8Cko=;
        b=J1VIl1h3uC4sLpc4tWjYtCbA537/nQE3P2Q/SSiFoR3cFtuG/8+adHSaa4yvscfvAWU+em
        WlAXtvSME4MIP5TE0+d6TLra3z3VxjuC/B4Ni9NHNuk2g36DATIlz9r/QTVmFqqSHTP63m
        4Vo4XsVz1Op51e/YAp+iE2HDVLE0RV6buKiyS4wXsRqS2ZC+K3rK7gBpeihnwgQKtH8EBR
        Z3US5r/O9BDQEpzfuOYajXdon63pV3nZpHY+fK6H1OHa0cZM/Ncp7OmRbUCuHW6rtBP7iv
        LicXPAEdjmANqOC5dXCvDo4YDtFTzcAqLbJSiGKVyVg24lp+9AJ2QlccEa8/Nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603968703;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=D7+ECYjm99yWKNOlQAiuEYWqORzhy6nrucWXVty8Cko=;
        b=ZhIdV/T5z9EpZlmniXdzECpZyPI0uW14IewxqibI497pKHzTS+GZHPyTN6BFUtfSSBDlYJ
        FWYVfrAh4VQyC8Aw==
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf/x86/intel: Support PERF_SAMPLE_DATA_PAGE_SIZE
Cc:     Kan Liang <kan.liang@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201001135749.2804-3-kan.liang@linux.intel.com>
References: <20201001135749.2804-3-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <160396870260.397.6602768915985059175.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     76a5433f95f32d8a17c9f836be2084ed947c466b
Gitweb:        https://git.kernel.org/tip/76a5433f95f32d8a17c9f836be2084ed947c466b
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Thu, 01 Oct 2020 06:57:47 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 29 Oct 2020 11:00:38 +01:00

perf/x86/intel: Support PERF_SAMPLE_DATA_PAGE_SIZE

The new sample type, PERF_SAMPLE_DATA_PAGE_SIZE, requires the virtual
address. Update the data->addr if the sample type is set.

The large PEBS is disabled with the sample type, because perf doesn't
support munmap tracking yet. The PEBS buffer for large PEBS cannot be
flushed for each munmap. Wrong page size may be calculated. The large
PEBS can be enabled later separately when munmap tracking is supported.

Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20201001135749.2804-3-kan.liang@linux.intel.com
---
 arch/x86/events/intel/ds.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/arch/x86/events/intel/ds.c b/arch/x86/events/intel/ds.c
index 404315d..444e5f0 100644
--- a/arch/x86/events/intel/ds.c
+++ b/arch/x86/events/intel/ds.c
@@ -959,7 +959,8 @@ static void adaptive_pebs_record_size_update(void)
 
 #define PERF_PEBS_MEMINFO_TYPE	(PERF_SAMPLE_ADDR | PERF_SAMPLE_DATA_SRC |   \
 				PERF_SAMPLE_PHYS_ADDR | PERF_SAMPLE_WEIGHT | \
-				PERF_SAMPLE_TRANSACTION)
+				PERF_SAMPLE_TRANSACTION |		     \
+				PERF_SAMPLE_DATA_PAGE_SIZE)
 
 static u64 pebs_update_adaptive_cfg(struct perf_event *event)
 {
@@ -1335,6 +1336,10 @@ static u64 get_data_src(struct perf_event *event, u64 aux)
 	return val;
 }
 
+#define PERF_SAMPLE_ADDR_TYPE	(PERF_SAMPLE_ADDR |		\
+				 PERF_SAMPLE_PHYS_ADDR |	\
+				 PERF_SAMPLE_DATA_PAGE_SIZE)
+
 static void setup_pebs_fixed_sample_data(struct perf_event *event,
 				   struct pt_regs *iregs, void *__pebs,
 				   struct perf_sample_data *data,
@@ -1449,7 +1454,7 @@ static void setup_pebs_fixed_sample_data(struct perf_event *event,
 	}
 
 
-	if ((sample_type & (PERF_SAMPLE_ADDR | PERF_SAMPLE_PHYS_ADDR)) &&
+	if ((sample_type & PERF_SAMPLE_ADDR_TYPE) &&
 	    x86_pmu.intel_cap.pebs_format >= 1)
 		data->addr = pebs->dla;
 
@@ -1577,7 +1582,7 @@ static void setup_pebs_adaptive_sample_data(struct perf_event *event,
 		if (sample_type & PERF_SAMPLE_DATA_SRC)
 			data->data_src.val = get_data_src(event, meminfo->aux);
 
-		if (sample_type & (PERF_SAMPLE_ADDR | PERF_SAMPLE_PHYS_ADDR))
+		if (sample_type & PERF_SAMPLE_ADDR_TYPE)
 			data->addr = meminfo->address;
 
 		if (sample_type & PERF_SAMPLE_TRANSACTION)
