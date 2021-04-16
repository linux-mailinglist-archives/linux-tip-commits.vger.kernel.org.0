Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA4EA36248D
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Apr 2021 17:55:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235867AbhDPPyN (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Apr 2021 11:54:13 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58184 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235689AbhDPPyH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Apr 2021 11:54:07 -0400
Date:   Fri, 16 Apr 2021 15:53:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1618588421;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lnu4T3cswxls+tJVsMJI6VS7beKHORnpxNYvU6mtNig=;
        b=GTwS/cWuFDwUPxiOVbxciaIYGmTUFgY5o29Ku9KAJN23bgRGCU8Piw68y7hHVcG//pLO+K
        q+G/LqQWFdewxQOLDJt8TorxvNGXFXcKd3FdQPt7v/MT1Nh6+d+wCbWY4hIuKVrLVG70YK
        yLUL1oIrj7GSDN+P3t/AqwEuusQHTzkAfUP6GnK3jIIJyS7cM/RO5HSN3yujeimPJGJxfj
        JcunWhioYcviUVkOpq0czMkudaSdljrByiV7DQ1qNNiz5jg5SYxjBJSHcfddlbdoQM/Q5H
        MmMh94uAZpX8Kr+bKAj/pYeGdO2sOUYd52bHk9bnWcOzArqw3klX79cDiowOJA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1618588421;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lnu4T3cswxls+tJVsMJI6VS7beKHORnpxNYvU6mtNig=;
        b=8bpS5M7My6Od2n5ZkxomTWXhtZcKpd+N1RKfkSNeDrPlJFynZ1GBS3rkX1wyI0uKQe1Cx0
        pa5V1xt6fOwwAWAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched,fair: Alternative sched_slice()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210412102001.611897312@infradead.org>
References: <20210412102001.611897312@infradead.org>
MIME-Version: 1.0
Message-ID: <161858842081.29796.1137333756957597015.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     0c2de3f054a59f15e01804b75a04355c48de628c
Gitweb:        https://git.kernel.org/tip/0c2de3f054a59f15e01804b75a04355c48de628c
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Thu, 25 Mar 2021 13:44:46 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 16 Apr 2021 17:06:35 +02:00

sched,fair: Alternative sched_slice()

The current sched_slice() seems to have issues; there's two possible
things that could be improved:

 - the 'nr_running' used for __sched_period() is daft when cgroups are
   considered. Using the RQ wide h_nr_running seems like a much more
   consistent number.

 - (esp) cgroups can slice it real fine, which makes for easy
   over-scheduling, ensure min_gran is what the name says.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210412102001.611897312@infradead.org
---
 kernel/sched/fair.c     | 12 +++++++++++-
 kernel/sched/features.h |  3 +++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b3ea14c..49636a4 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -687,7 +687,13 @@ static u64 __sched_period(unsigned long nr_running)
  */
 static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 {
-	u64 slice = __sched_period(cfs_rq->nr_running + !se->on_rq);
+	unsigned int nr_running = cfs_rq->nr_running;
+	u64 slice;
+
+	if (sched_feat(ALT_PERIOD))
+		nr_running = rq_of(cfs_rq)->cfs.h_nr_running;
+
+	slice = __sched_period(nr_running + !se->on_rq);
 
 	for_each_sched_entity(se) {
 		struct load_weight *load;
@@ -704,6 +710,10 @@ static u64 sched_slice(struct cfs_rq *cfs_rq, struct sched_entity *se)
 		}
 		slice = __calc_delta(slice, se->load.weight, load);
 	}
+
+	if (sched_feat(BASE_SLICE))
+		slice = max(slice, (u64)sysctl_sched_min_granularity);
+
 	return slice;
 }
 
diff --git a/kernel/sched/features.h b/kernel/sched/features.h
index 422fa68..011c5ec 100644
--- a/kernel/sched/features.h
+++ b/kernel/sched/features.h
@@ -90,3 +90,6 @@ SCHED_FEAT(WA_BIAS, true)
  */
 SCHED_FEAT(UTIL_EST, true)
 SCHED_FEAT(UTIL_EST_FASTUP, true)
+
+SCHED_FEAT(ALT_PERIOD, true)
+SCHED_FEAT(BASE_SLICE, true)
