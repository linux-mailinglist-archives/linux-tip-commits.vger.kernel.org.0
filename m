Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3F01F33F07D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Mar 2021 13:39:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230044AbhCQMih (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Mar 2021 08:38:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:49722 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229720AbhCQMi0 (ORCPT
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
        bh=Oo3oLl3D3bCZ7C7ENIbBzljLTNO/XAjw/77NsIFNlU8=;
        b=tK0JNqTYRiVp0FLKrMv0b3iKuU6ney3sh6cZMRVaOc2Vsy8AW1XXX9SRnBkGAOb2szkJNW
        SerJj0xYxmXmNOsOywobpU8WdmwkrwAUDNTTGwLObVTKCpxzptn0ZQb40gSWgVUXA7ME2+
        IbF63FQDRIERnAURxmgLeTyLSTdDdKzuYAaLWoODkznBjET1Wx08RjleTZw7c+mgUImCcH
        lN9YjJre8S8mckxkaBu8mYyGbgrpKadTPRajQofyYKS1g26uX7tL+wJqp65UXKu/OacJQi
        jlxjPQ1g6UFapngLEYL/KoBKUcHl/zU5K1YAbJHRbwMgzDQ8gAWZnwULAuc9HA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615984705;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oo3oLl3D3bCZ7C7ENIbBzljLTNO/XAjw/77NsIFNlU8=;
        b=cYBFrArA7jJAGmiiGN88QfqcoOd4WGYPDX07itlSTaqyIl0hicBnQMo73HI5WbD0H5zd78
        9NSwZQuRpp3cpZCA==
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf core: Allocate perf_event in the target node memory
Cc:     Namhyung Kim <namhyung@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210311115413.444407-2-namhyung@kernel.org>
References: <20210311115413.444407-2-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <161598470458.398.13204797977122218988.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     ff65338e78418e5970a7aabbabb94c46f2bb821d
Gitweb:        https://git.kernel.org/tip/ff65338e78418e5970a7aabbabb94c46f2bb821d
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Thu, 11 Mar 2021 20:54:13 +09:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 16 Mar 2021 21:44:43 +01:00

perf core: Allocate perf_event in the target node memory

For cpu events, it'd better allocating them in the corresponding node
memory as they would be mostly accessed by the target cpu.  Although
perf tools sets the cpu affinity before calling perf_event_open, there
are places it doesn't (notably perf record) and we should consider
other external users too.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210311115413.444407-2-namhyung@kernel.org
---
 kernel/events/core.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/events/core.c b/kernel/events/core.c
index f526ddb..6182cb1 100644
--- a/kernel/events/core.c
+++ b/kernel/events/core.c
@@ -11288,13 +11288,16 @@ perf_event_alloc(struct perf_event_attr *attr, int cpu,
 	struct perf_event *event;
 	struct hw_perf_event *hwc;
 	long err = -EINVAL;
+	int node;
 
 	if ((unsigned)cpu >= nr_cpu_ids) {
 		if (!task || cpu != -1)
 			return ERR_PTR(-EINVAL);
 	}
 
-	event = kmem_cache_zalloc(perf_event_cache, GFP_KERNEL);
+	node = (cpu >= 0) ? cpu_to_node(cpu) : -1;
+	event = kmem_cache_alloc_node(perf_event_cache, GFP_KERNEL | __GFP_ZERO,
+				      node);
 	if (!event)
 		return ERR_PTR(-ENOMEM);
 
