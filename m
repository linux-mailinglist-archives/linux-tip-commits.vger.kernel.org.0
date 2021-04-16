Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 18CBC362360
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Apr 2021 17:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245477AbhDPPCZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Apr 2021 11:02:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245427AbhDPPCT (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Apr 2021 11:02:19 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96817C06138A;
        Fri, 16 Apr 2021 08:01:54 -0700 (PDT)
Date:   Fri, 16 Apr 2021 15:01:52 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618585313;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gjSIFZMc4fVpUnEimnjOqoL/dmLQH1GtXHPbFt00Wpo=;
        b=vRj1oHwXAwMp4dbqwWEqu/xAYBGaVfOqhLrKFb5VA6WyxtXQGNjvs4QIBIqtYETP9gcLDD
        SyEQl+EHnymqx91xverBRbvj5CYeuL7x68wmlzK565ZEHxvDlYPlM3BKI1OXsf0YitTPUf
        39U90+uBO0kyd3d8P9CKAvFPX0zbQftLGQ+YKdIxB/wXyx7AW+DFRakKQxn80aAGm4Lszv
        4xxFH18VmxrTxZ0Pdi9OXEbyS0yKBipInPjWSMnYSHukp90xybAvDCwB8gJXEmK19NDkn4
        sJfGD2aAlyBgiEmHzXK5SowmmxvwY9xX4z/pJh7601sb6P5lPKU6cZdraEiifA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618585313;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gjSIFZMc4fVpUnEimnjOqoL/dmLQH1GtXHPbFt00Wpo=;
        b=3fPzNzbaR8+GF4pOAuuNOweXCDQF4VUQyLbNPuI7Zhe3LYNxgd7WKLMaPNBL7uzr0KE+MY
        nJeqeMdq6+JWj/BQ==
From:   "tip-bot2 for Alexander Shishkin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf: Cap allocation order at aux_watermark
Cc:     Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210414154955.49603-2-alexander.shishkin@linux.intel.com>
References: <20210414154955.49603-2-alexander.shishkin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <161858531260.29796.6094672207320806626.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     d68e6799a5c87f415d3bfa0dea49caee28ab00d1
Gitweb:        https://git.kernel.org/tip/d68e6799a5c87f415d3bfa0dea49caee28ab00d1
Author:        Alexander Shishkin <alexander.shishkin@linux.intel.com>
AuthorDate:    Wed, 14 Apr 2021 18:49:54 +03:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Apr 2021 16:32:39 +02:00

perf: Cap allocation order at aux_watermark

Currently, we start allocating AUX pages half the size of the total
requested AUX buffer size, ignoring the attr.aux_watermark setting. This,
in turn, makes intel_pt driver disregard the watermark also, as it uses
page order for its SG (ToPA) configuration.

Now, this can be fixed in the intel_pt PMU driver, but seeing as it's the
only one currently making use of high order allocations, there is no
reason not to fix the allocator instead. This way, any other driver
wishing to add this support would not have to worry about this.

Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210414154955.49603-2-alexander.shishkin@linux.intel.com
---
 kernel/events/ring_buffer.c | 34 ++++++++++++++++++----------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index bd55ccc..5286871 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -674,21 +674,26 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
 	if (!has_aux(event))
 		return -EOPNOTSUPP;
 
-	/*
-	 * We need to start with the max_order that fits in nr_pages,
-	 * not the other way around, hence ilog2() and not get_order.
-	 */
-	max_order = ilog2(nr_pages);
-
-	/*
-	 * PMU requests more than one contiguous chunks of memory
-	 * for SW double buffering
-	 */
 	if (!overwrite) {
-		if (!max_order)
-			return -EINVAL;
+		/*
+		 * Watermark defaults to half the buffer, and so does the
+		 * max_order, to aid PMU drivers in double buffering.
+		 */
+		if (!watermark)
+			watermark = nr_pages << (PAGE_SHIFT - 1);
 
-		max_order--;
+		/*
+		 * Use aux_watermark as the basis for chunking to
+		 * help PMU drivers honor the watermark.
+		 */
+		max_order = get_order(watermark);
+	} else {
+		/*
+		 * We need to start with the max_order that fits in nr_pages,
+		 * not the other way around, hence ilog2() and not get_order.
+		 */
+		max_order = ilog2(nr_pages);
+		watermark = 0;
 	}
 
 	rb->aux_pages = kcalloc_node(nr_pages, sizeof(void *), GFP_KERNEL,
@@ -743,9 +748,6 @@ int rb_alloc_aux(struct perf_buffer *rb, struct perf_event *event,
 	rb->aux_overwrite = overwrite;
 	rb->aux_watermark = watermark;
 
-	if (!rb->aux_watermark && !rb->aux_overwrite)
-		rb->aux_watermark = nr_pages << (PAGE_SHIFT - 1);
-
 out:
 	if (!ret)
 		rb->aux_pgoff = pgoff;
