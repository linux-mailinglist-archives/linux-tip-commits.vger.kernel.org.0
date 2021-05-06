Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 44E1E375511
	for <lists+linux-tip-commits@lfdr.de>; Thu,  6 May 2021 15:48:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234393AbhEFNtU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 6 May 2021 09:49:20 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:40464 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234033AbhEFNtT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 6 May 2021 09:49:19 -0400
Date:   Thu, 06 May 2021 13:48:18 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620308899;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zuqG7zDjHOvJGRUdaha22LJ3Sayo8vnyPDl9IGBoSyY=;
        b=EwuVSPmVJ57+O4NShKRNrtKQfJA8epABMmsDpNbKE/p/sg9AvFFIeTCdb4PYQvLQslOuDZ
        0v39EL06BdhxdUt+rKQ3K9/MC0cLO+KoSqTSoB+2GtE8wSXyx10RY5Bl3mTghp36rmUCrG
        0ItcH5YNA6vkR3dw6/pmn56+JpmlC+bzOm1LfdeVNTU3qbmWxUyNQQG414eI5F7XejkvJ1
        yGeNNXkJT6Zx0vHFUxqLtdDjGDP8o+8U7xr2Cc1KmF+EbZTtaisuWsbORuTU/eymPyQBwL
        iSkZR6V2DFzs7r7pjEYTU7PwE7LXNERmG+TgneM5xBX3rV4GFFWB0ZfFndAVmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620308899;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zuqG7zDjHOvJGRUdaha22LJ3Sayo8vnyPDl9IGBoSyY=;
        b=7ucQVoHjOAHGmQ5s3ZbeogHHa9lBq0QY2NMC3BzEw7NatPdQF+YL1zoIW5MjgPug1bLLHr
        rQDmGX8ZbbOKQxAg==
From:   "tip-bot2 for Suravee Suthikulpanit" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] x86/events/amd/iommu: Fix invalid Perf result due
 to IOMMU PMC power-gating
Cc:     Alexander Monakov <amonakov@ispras.ru>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210504065236.4415-1-suravee.suthikulpanit@amd.com>
References: <20210504065236.4415-1-suravee.suthikulpanit@amd.com>
MIME-Version: 1.0
Message-ID: <162030889887.29796.12426716742809018792.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     e10de314287c2c14b0e6f0e3e961975ce2f4a83d
Gitweb:        https://git.kernel.org/tip/e10de314287c2c14b0e6f0e3e961975ce2f4a83d
Author:        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
AuthorDate:    Tue, 04 May 2021 01:52:36 -05:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 06 May 2021 15:33:37 +02:00

x86/events/amd/iommu: Fix invalid Perf result due to IOMMU PMC power-gating

On certain AMD platforms, when the IOMMU performance counter source
(csource) field is zero, power-gating for the counter is enabled, which
prevents write access and returns zero for read access.

This can cause invalid perf result especially when event multiplexing
is needed (i.e. more number of events than available counters) since
the current logic keeps track of the previously read counter value,
and subsequently re-program the counter to continue counting the event.
With power-gating enabled, we cannot gurantee successful re-programming
of the counter.

Workaround this issue by :

1. Modifying the ordering of setting/reading counters and enabing/
   disabling csources to only access the counter when the csource
   is set to non-zero.

2. Since AMD IOMMU PMU does not support interrupt mode, the logic
   can be simplified to always start counting with value zero,
   and accumulate the counter value when stopping without the need
   to keep track and reprogram the counter with the previously read
   counter value.

This has been tested on systems with and without power-gating.

Fixes: 994d6608efe4 ("iommu/amd: Remove performance counter pre-initialization test")
Suggested-by: Alexander Monakov <amonakov@ispras.ru>
Signed-off-by: Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210504065236.4415-1-suravee.suthikulpanit@amd.com
---
 arch/x86/events/amd/iommu.c | 47 +++++++++++++++++++-----------------
 1 file changed, 26 insertions(+), 21 deletions(-)

diff --git a/arch/x86/events/amd/iommu.c b/arch/x86/events/amd/iommu.c
index 6a98a76..2da6139 100644
--- a/arch/x86/events/amd/iommu.c
+++ b/arch/x86/events/amd/iommu.c
@@ -18,8 +18,6 @@
 #include "../perf_event.h"
 #include "iommu.h"
 
-#define COUNTER_SHIFT		16
-
 /* iommu pmu conf masks */
 #define GET_CSOURCE(x)     ((x)->conf & 0xFFULL)
 #define GET_DEVID(x)       (((x)->conf >> 8)  & 0xFFFFULL)
@@ -285,22 +283,31 @@ static void perf_iommu_start(struct perf_event *event, int flags)
 	WARN_ON_ONCE(!(hwc->state & PERF_HES_UPTODATE));
 	hwc->state = 0;
 
+	/*
+	 * To account for power-gating, which prevents write to
+	 * the counter, we need to enable the counter
+	 * before setting up counter register.
+	 */
+	perf_iommu_enable_event(event);
+
 	if (flags & PERF_EF_RELOAD) {
-		u64 prev_raw_count = local64_read(&hwc->prev_count);
+		u64 count = 0;
 		struct amd_iommu *iommu = perf_event_2_iommu(event);
 
+		/*
+		 * Since the IOMMU PMU only support counting mode,
+		 * the counter always start with value zero.
+		 */
 		amd_iommu_pc_set_reg(iommu, hwc->iommu_bank, hwc->iommu_cntr,
-				     IOMMU_PC_COUNTER_REG, &prev_raw_count);
+				     IOMMU_PC_COUNTER_REG, &count);
 	}
 
-	perf_iommu_enable_event(event);
 	perf_event_update_userpage(event);
-
 }
 
 static void perf_iommu_read(struct perf_event *event)
 {
-	u64 count, prev, delta;
+	u64 count;
 	struct hw_perf_event *hwc = &event->hw;
 	struct amd_iommu *iommu = perf_event_2_iommu(event);
 
@@ -311,14 +318,11 @@ static void perf_iommu_read(struct perf_event *event)
 	/* IOMMU pc counter register is only 48 bits */
 	count &= GENMASK_ULL(47, 0);
 
-	prev = local64_read(&hwc->prev_count);
-	if (local64_cmpxchg(&hwc->prev_count, prev, count) != prev)
-		return;
-
-	/* Handle 48-bit counter overflow */
-	delta = (count << COUNTER_SHIFT) - (prev << COUNTER_SHIFT);
-	delta >>= COUNTER_SHIFT;
-	local64_add(delta, &event->count);
+	/*
+	 * Since the counter always start with value zero,
+	 * simply just accumulate the count for the event.
+	 */
+	local64_add(count, &event->count);
 }
 
 static void perf_iommu_stop(struct perf_event *event, int flags)
@@ -328,15 +332,16 @@ static void perf_iommu_stop(struct perf_event *event, int flags)
 	if (hwc->state & PERF_HES_UPTODATE)
 		return;
 
+	/*
+	 * To account for power-gating, in which reading the counter would
+	 * return zero, we need to read the register before disabling.
+	 */
+	perf_iommu_read(event);
+	hwc->state |= PERF_HES_UPTODATE;
+
 	perf_iommu_disable_event(event);
 	WARN_ON_ONCE(hwc->state & PERF_HES_STOPPED);
 	hwc->state |= PERF_HES_STOPPED;
-
-	if (hwc->state & PERF_HES_UPTODATE)
-		return;
-
-	perf_iommu_read(event);
-	hwc->state |= PERF_HES_UPTODATE;
 }
 
 static int perf_iommu_add(struct perf_event *event, int flags)
