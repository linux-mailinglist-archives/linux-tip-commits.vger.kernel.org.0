Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2002C33F07A
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 13:39:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230032AbhCQMig (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 08:38:36 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49730 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbhCQMi0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Mar 2021 08:38:26 -0400
Date:   Wed, 17 Mar 2021 12:38:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615984705;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1SZDgpfOuuz/BhoB8fdoXCpfWlE6IOw6ms5Dh77lO4w=;
        b=uMOtnH57eZFZcn4bsmBzC6DM9p1D3+RkqeJir7JgCTGCeLpogKAhUA2Y9fXIGWe+dU+BNp
        76GcAemJqpR9iebUs4P9ap7Y6PHalDAJ6UDkhyB1vIZ84hLfvzrMsH2ohVk7IuceJATz+t
        69GzlELj9OkQ8Nu2JImp7VpARUbS65dH7CdnrjCp6Ts2vuNij9gVwpIvGlyNVk0fHf9tTs
        esIEG9RFv6tIgGC4GupyjyLiGgFUWbZK4PT7YmuJRTn5gj9PwuOfT3BD9+el8wOHuKtgvM
        2OaOTWRv4zQ+dEp4EK8lvnPK8+z6Oa7zVsJWzSWNu3W495J0C24gLp5Dymbzxw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615984705;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1SZDgpfOuuz/BhoB8fdoXCpfWlE6IOw6ms5Dh77lO4w=;
        b=6VFLWRSqmD5XIlXBROY3ViL+9S3mdCPVxuDrkMY4b3upKePMt6sGhQAh2YoJoR6ifmnAJK
        cfAelQ/Jx2yuK7Cw==
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf core: Add a kmem_cache for struct perf_event
Cc:     Namhyung Kim <namhyung@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210311115413.444407-1-namhyung@kernel.org>
References: <20210311115413.444407-1-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <161598470492.398.3094442077954239689.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     bdacfaf26da166dd56c62f23f27a4b3e71f2d89e
Gitweb:        https://git.kernel.org/tip/bdacfaf26da166dd56c62f23f27a4b3e71f2d89e
Author:        Namhyung Kim <namhyung@google.com>
AuthorDate:    Thu, 11 Mar 2021 20:54:12 +09:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 16 Mar 2021 21:44:42 +01:00

perf core: Add a kmem_cache for struct perf_event

The kernel can allocate a lot of struct perf_event when profiling. For
example, 256 cpu x 8 events x 20 cgroups = 40K instances of the struct
would be allocated on a large system.

The size of struct perf_event in my setup is 1152 byte. As it's
allocated by kmalloc, the actual allocation size would be rounded up
to 2K.

Then there's 896 byte (~43%) of waste per instance resulting in total
~35MB with 40K instances. We can create a dedicated kmem_cache to
avoid such a big unnecessary memory consumption.

With this change, I can see below (note this machine has 112 cpus).

  # grep perf_event /proc/slabinfo
  perf_event    224    784   1152    7    2 : tunables   24   12    8 : slabdata    112    112      0

The sixth column is pages-per-slab which is 2, and the fifth column is
obj-per-slab which is 7.  Thus actually it can use 1152 x 7 = 8064
byte in the 8K, and wasted memory is (8192 - 8064) / 7 = ~18 byte per
instance.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210311115413.444407-1-namhyung@kernel.org
---
 kernel/events/core.c |  9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index 03db40f..f526ddb 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -405,6 +405,7 @@ static LIST_HEAD(pmus);
 static DEFINE_MUTEX(pmus_lock);
 static struct srcu_struct pmus_srcu;
 static cpumask_var_t perf_online_mask;
+static struct kmem_cache *perf_event_cache;
 
 /*
  * perf event paranoia level:
@@ -4611,7 +4612,7 @@ static void free_event_rcu(struct rcu_head *head)
 	if (event->ns)
 		put_pid_ns(event->ns);
 	perf_event_free_filter(event);
-	kfree(event);
+	kmem_cache_free(perf_event_cache, event);
 }
 
 static void ring_buffer_attach(struct perf_event *event,
@@ -11293,7 +11294,7 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 			return ERR_PTR(-EINVAL);
 	}
 
-	event = kzalloc(sizeof(*event), GFP_KERNEL);
+	event = kmem_cache_zalloc(perf_event_cache, GFP_KERNEL);
 	if (!event)
 		return ERR_PTR(-ENOMEM);
 
@@ -11497,7 +11498,7 @@ err_ns:
 		put_pid_ns(event->ns);
 	if (event->hw.target)
 		put_task_struct(event->hw.target);
-	kfree(event);
+	kmem_cache_free(perf_event_cache, event);
 
 	return ERR_PTR(err);
 }
@@ -13130,6 +13131,8 @@ void __init perf_event_init(void)
 	ret = init_hw_breakpoint();
 	WARN(ret, "hw_breakpoint initialization failed with: %d", ret);
 
+	perf_event_cache = KMEM_CACHE(perf_event, SLAB_PANIC);
+
 	/*
 	 * Build time assertion that we keep the data_head at the intended
 	 * location.  IOW, validation we got the __reserved[] size right.
