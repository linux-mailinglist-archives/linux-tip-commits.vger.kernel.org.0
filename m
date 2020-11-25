Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F1EA2C41A4
	for <lists+linux-tip-commits@lfdr.de>; Wed, 25 Nov 2020 15:05:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729778AbgKYOC5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 25 Nov 2020 09:02:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729665AbgKYOC4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 25 Nov 2020 09:02:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 831EEC0613D4;
        Wed, 25 Nov 2020 06:02:56 -0800 (PST)
Date:   Wed, 25 Nov 2020 14:02:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606312974;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zik3pD3pAMcLo00rzi52xKR1J/P6MFCpraviybB5muo=;
        b=gpE3Y6RrE/czAB70Ge7iw1xsLzWnCv3vXf9EfeO7cFERhvzHxjskgfWzwsHJyawp8/8ckW
        PxZLguz1zaDyT1fD02QziUkOwFjxhCNmAfMGC5iPjblYny8icm12bvZgmj4InyMP7Z45rx
        0XYstdl2H7yYL4h10vNVDwLxAV5GrtGQjw4/idqex79l75AMrt/b9rng96u/MbAs3uYnMc
        qgG+ccAAqsBradER15ycIxlLlAZ/PXyrPfAyJwP5hxN5j7Wpfi9ZUL9jlQE0+P2R3hVpni
        iFeNvY5aqeNZ5pta6eAlX0uKQT8Amy9K8GDOonwA7Wr8T2UWWKRO4a9it0qxHA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606312974;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zik3pD3pAMcLo00rzi52xKR1J/P6MFCpraviybB5muo=;
        b=0UAwbGQtW4ZNO2gPAYjWjKGcGz8aBZpVH6rWgbnsVUtO+OzIWneyAxq05cTgcfPGK/Zhci
        JJMhn0TV2QKrO6Dg==
From:   "tip-bot2 for Mel Gorman" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/numa: Rename nr_running and break out the
 magic number
Cc:     Mel Gorman <mgorman@techsingularity.net>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201120090630.3286-2-mgorman@techsingularity.net>
References: <20201120090630.3286-2-mgorman@techsingularity.net>
MIME-Version: 1.0
Message-ID: <160631297374.3364.8410979966998376995.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     abeae76a47005aa3f07c9be12d8076365622e25c
Gitweb:        https://git.kernel.org/tip/abeae76a47005aa3f07c9be12d8076365622e25c
Author:        Mel Gorman <mgorman@techsingularity.net>
AuthorDate:    Fri, 20 Nov 2020 09:06:27 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 24 Nov 2020 16:47:47 +01:00

sched/numa: Rename nr_running and break out the magic number

This is simply a preparation patch to make the following patches easier
to read. No functional change.

Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20201120090630.3286-2-mgorman@techsingularity.net
---
 kernel/sched/fair.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 6691e28..9d10abe 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -1559,7 +1559,7 @@ struct task_numa_env {
 static unsigned long cpu_load(struct rq *rq);
 static unsigned long cpu_runnable(struct rq *rq);
 static unsigned long cpu_util(int cpu);
-static inline long adjust_numa_imbalance(int imbalance, int nr_running);
+static inline long adjust_numa_imbalance(int imbalance, int dst_running);
 
 static inline enum
 numa_type numa_classify(unsigned int imbalance_pct,
@@ -8991,7 +8991,9 @@ next_group:
 	}
 }
 
-static inline long adjust_numa_imbalance(int imbalance, int nr_running)
+#define NUMA_IMBALANCE_MIN 2
+
+static inline long adjust_numa_imbalance(int imbalance, int dst_running)
 {
 	unsigned int imbalance_min;
 
@@ -8999,8 +9001,8 @@ static inline long adjust_numa_imbalance(int imbalance, int nr_running)
 	 * Allow a small imbalance based on a simple pair of communicating
 	 * tasks that remain local when the source domain is almost idle.
 	 */
-	imbalance_min = 2;
-	if (nr_running <= imbalance_min)
+	imbalance_min = NUMA_IMBALANCE_MIN;
+	if (dst_running <= imbalance_min)
 		return 0;
 
 	return imbalance;
