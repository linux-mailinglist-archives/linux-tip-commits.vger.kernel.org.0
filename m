Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E5833F081
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 13:39:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230063AbhCQMii (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 08:38:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbhCQMi1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 08:38:27 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 350F8C06174A;
        Wed, 17 Mar 2021 05:38:27 -0700 (PDT)
Date:   Wed, 17 Mar 2021 12:38:25 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615984705;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bSltvtaYx8C1Wn8fbfUtSG9Vg3+XsiDW4bhaxhvv/Yo=;
        b=ZnAba2Q6xW88dv5y7qyK/l2gDqpAT5EBcDt8OEeuUSsTnnlqeuAq2PwYfxV8EqvkN3GGvs
        v3wV7lTOdfcat90moRfG0bS49SxQjl+YrlteTB4QcfFBEHyi7ZitFFuuX+ugSjZY5WsCnx
        a2Cn5sqx/+9b0GSNJg+1gYySc81WAs/xfw/v6CXx0/2PTo6Rm46r/ViAEw5E0aNwk5SLmE
        ij0LxcxlaVAp04CIUrALjjzJwG+HBzlrRbtw/RrM34wB3a3hqTS14rT8OhIWR7w+YlMc4R
        gyTj9aIjR9T5f8xJjM2lBcVtJgzwCx5MD8TGYIPe/CU4SlFI8nJXw+vznuILEg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615984705;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bSltvtaYx8C1Wn8fbfUtSG9Vg3+XsiDW4bhaxhvv/Yo=;
        b=EJ7asX4RMAcMUqgBMw8ER22RQ3D3J/8jFkw8Cgr5/P31zxr4gH+EfS3qQeZ6ONaMBunIfE
        5UcPWt0bZgGPABDA==
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf core: Allocate perf_buffer in the target node memory
Cc:     Namhyung Kim <namhyung@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210315033436.682438-1-namhyung@kernel.org>
References: <20210315033436.682438-1-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <161598470527.398.15328587861840487615.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     9483409ab5067941860754e78a4a44a60311d276
Gitweb:        https://git.kernel.org/tip/9483409ab5067941860754e78a4a44a60311d276
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Mon, 15 Mar 2021 12:34:36 +09:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 16 Mar 2021 21:44:42 +01:00

perf core: Allocate perf_buffer in the target node memory

I found the ring buffer pages are allocated in the node but the ring
buffer itself is not.  Let's convert it to use kzalloc_node() too.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210315033436.682438-1-namhyung@kernel.org
---
 kernel/events/ring_buffer.c |  9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/events/ring_buffer.c b/kernel/events/ring_buffer.c
index ef91ae7..bd55ccc 100644
--- a/kernel/events/ring_buffer.c
+++ b/kernel/events/ring_buffer.c
@@ -804,7 +804,7 @@ struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
 {
 	struct perf_buffer *rb;
 	unsigned long size;
-	int i;
+	int i, node;
 
 	size = sizeof(struct perf_buffer);
 	size += nr_pages * sizeof(void *);
@@ -812,7 +812,8 @@ struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
 	if (order_base_2(size) >= PAGE_SHIFT+MAX_ORDER)
 		goto fail;
 
-	rb = kzalloc(size, GFP_KERNEL);
+	node = (cpu == -1) ? cpu : cpu_to_node(cpu);
+	rb = kzalloc_node(size, GFP_KERNEL, node);
 	if (!rb)
 		goto fail;
 
@@ -906,11 +907,13 @@ struct perf_buffer *rb_alloc(int nr_pages, long watermark, int cpu, int flags)
 	struct perf_buffer *rb;
 	unsigned long size;
 	void *all_buf;
+	int node;
 
 	size = sizeof(struct perf_buffer);
 	size += sizeof(void *);
 
-	rb = kzalloc(size, GFP_KERNEL);
+	node = (cpu == -1) ? cpu : cpu_to_node(cpu);
+	rb = kzalloc_node(size, GFP_KERNEL, node);
 	if (!rb)
 		goto fail;
 
