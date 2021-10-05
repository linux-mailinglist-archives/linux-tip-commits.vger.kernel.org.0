Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5FEEF422A4D
	for <lists+linux-tip-commits@lfdr.de>; Tue,  5 Oct 2021 16:11:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234170AbhJEONs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 5 Oct 2021 10:13:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233705AbhJEONs (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 5 Oct 2021 10:13:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE29C06174E;
        Tue,  5 Oct 2021 07:11:57 -0700 (PDT)
Date:   Tue, 05 Oct 2021 14:11:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633443115;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+6977k9d1oh/RnnmENZ3SD0kuBDSoE4r4cc3YyOvfSM=;
        b=zQi16y9202M77unrg0/77+FHlSsJJhgJCDCAqJhHMZKX0nxuL4GeSNC3DrnWeVuOnNzyZ2
        /5Hw0PvY4gY9AXlhsrbi1CXrNAW1VXgZpwNrVcXqYWWkauK1iqDJQWAkFKsezr+t43CKXV
        rmYhNBVdaj9b2hgDm7pP13SCOpRlkfRdstszMOj2LUflHU+eAi8brvQwsmVRe6dvXA8vHH
        C+UIIdLPreUy58/1+iv93WJoAL6s578bjaEMBr9XpRTisXpMC6CyB5pGVT+14pZ7kxC2Wn
        xKlIa5Lp+esLzN/Dj0xcg7VAbqfyF+or3VNMCuWjjfadLXIX95A7uMIcsFAZdg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633443115;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+6977k9d1oh/RnnmENZ3SD0kuBDSoE4r4cc3YyOvfSM=;
        b=4UP5U6ov99l5088gWeW65HbbNZKsBdqDu8wwKaTGH5MjmMM+nYVZVHEuJCZfrJvT7EeaXu
        aiEunUf1EK/LrLDQ==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Removed useless update of p->recent_used_cpu
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210928103544.27489-1-vincent.guittot@linaro.org>
References: <20210928103544.27489-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <163344311445.25758.8040862728527222906.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     a7ba894821b6ade7bb420455f87020b2838d6180
Gitweb:        https://git.kernel.org/tip/a7ba894821b6ade7bb420455f87020b2838d6180
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Tue, 28 Sep 2021 12:35:44 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Oct 2021 15:52:17 +02:00

sched/fair: Removed useless update of p->recent_used_cpu

Since commit 89aafd67f28c ("sched/fair: Use prev instead of new target as recent_used_cpu"),
p->recent_used_cpu is unconditionnaly set with prev.

Fixes: 89aafd67f28c ("sched/fair: Use prev instead of new target as recent_used_cpu")
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Mel Gorman <mgorman@suse.de>
Link: https://lkml.kernel.org/r/20210928103544.27489-1-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c50ae23..2468d1d 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6413,11 +6413,6 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
 	    (available_idle_cpu(recent_used_cpu) || sched_idle_cpu(recent_used_cpu)) &&
 	    cpumask_test_cpu(p->recent_used_cpu, p->cpus_ptr) &&
 	    asym_fits_capacity(task_util, recent_used_cpu)) {
-		/*
-		 * Replace recent_used_cpu with prev as it is a potential
-		 * candidate for the next wake:
-		 */
-		p->recent_used_cpu = prev;
 		return recent_used_cpu;
 	}
 
