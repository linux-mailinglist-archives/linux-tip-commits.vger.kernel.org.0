Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 107342F6006
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Jan 2021 12:31:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728840AbhANLa1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 14 Jan 2021 06:30:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727848AbhANLaW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 14 Jan 2021 06:30:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E6E1C0613ED;
        Thu, 14 Jan 2021 03:29:08 -0800 (PST)
Date:   Thu, 14 Jan 2021 11:29:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610623746;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v6k7sQqeuEZVTNhZ6WGxMMwfqWIOex77tltch/QG7Wk=;
        b=ErSCVdWa+dFQL3/qZ0FIUs4UCqDTjrEj2E7/e1t4+tHuYR8UIgRVmJdYs2VNHONsxpxIGA
        6YQv8GRP5ep3tdyBS8H4aqJ5V0up3dUlteVl7CmN0ff1JUbrYSa1mS6RSUKRbv2E8rKI51
        CPv/bFxSjuAbEy/wxCxzWPaUoy1Bvr5s/YUkA2IMXL9P1JIOM6Y4dlLWFJ7rp2g5mamwGi
        6tJp1lLs5mYFatxSQD1YOAbcvgU1qMlE/w5TP8yWwMXJSqOw3ih6hBvY+q0Ilop4bSPa3y
        fnvVyzfNWmCP6TlvAEjliFSkOjnSt62E/wof24BZEFlnf4pPTN1ZFtxWkQIspA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610623746;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=v6k7sQqeuEZVTNhZ6WGxMMwfqWIOex77tltch/QG7Wk=;
        b=lVCjGJQ3Yo5yVPu8MPCbbDqFcqsyFk76zesS2axiSGkc4FXM6jrPB0CCvDQpv+I7zVnQGS
        W3KtVL1Grp1KBlBA==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Skip idle cfs_rq
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210107103325.30851-2-vincent.guittot@linaro.org>
References: <20210107103325.30851-2-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <161062374612.414.2070261593329416590.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     fc488ffd4297f661b3e9d7450dcdb9089a53df7c
Gitweb:        https://git.kernel.org/tip/fc488ffd4297f661b3e9d7450dcdb9089a53df7c
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Thu, 07 Jan 2021 11:33:23 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 14 Jan 2021 11:20:10 +01:00

sched/fair: Skip idle cfs_rq

Don't waste time checking whether an idle cfs_rq could be the busiest
queue. Furthermore, this can end up selecting a cfs_rq with a high load
but being idle in case of migrate_load.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Acked-by: Mel Gorman <mgorman@suse.de>
Link: https://lkml.kernel.org/r/20210107103325.30851-2-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 40d3ebf..13de7ae 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9402,8 +9402,11 @@ static struct rq *find_busiest_queue(struct lb_env *env,
 		if (rt > env->fbq_type)
 			continue;
 
-		capacity = capacity_of(i);
 		nr_running = rq->cfs.h_nr_running;
+		if (!nr_running)
+			continue;
+
+		capacity = capacity_of(i);
 
 		/*
 		 * For ASYM_CPUCAPACITY domains, don't pick a CPU that could
