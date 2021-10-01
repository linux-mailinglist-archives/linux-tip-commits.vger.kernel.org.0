Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC30641F06C
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 Oct 2021 17:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354885AbhJAPHo (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 1 Oct 2021 11:07:44 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58050 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354896AbhJAPHe (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 1 Oct 2021 11:07:34 -0400
Date:   Fri, 01 Oct 2021 15:05:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1633100749;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZUmFATD4gDQYSNRQUDDhyLHPjpwH2BqkDjAYToaiYQw=;
        b=qmjHo5QJcxdM9tNavc7UDOQdUjiYDlSfyKLkkALzJBgYoH3wnrIT3GUvLZXrBd0cLEguiI
        eXHyTSjc+ZDPsno6lJy89SfHzJcTMF1GQlZN/4qALVyQbNcO88yQpcS/NezJdcb+vNC5I3
        l3DzTPiAg3jB+VCe7YZW3T4r1GE7AhNi/ilGEhGgLVUzjTnRVik/iNtw2Wt1iG12YliDI+
        tNNxCbvE64VbztbD/qCYL7NmaXBZjzTRYQ1szTzq/5mON6SCshGFklGQ2J2bB0r/OUrt6U
        HY/PTFhqi90VyfmokI0OwO4PHZZQE5LD1nFTUyCGWB6D7JXiH4R7KO1PMniu3A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1633100749;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZUmFATD4gDQYSNRQUDDhyLHPjpwH2BqkDjAYToaiYQw=;
        b=2Ur6u5b/shPXKO7c3gTTvCF3eqqiu4sNPo2GzygCVd1HO6nq+MZRpnL1/ZuEW/KjQ0dz03
        KP1z0EkTAJ5rzOCw==
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
Message-ID: <163310074833.25758.3229584088214293831.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     959fc676791b91088b96341b644b92c8c52c7455
Gitweb:        https://git.kernel.org/tip/959fc676791b91088b96341b644b92c8c52c7455
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Tue, 28 Sep 2021 12:35:44 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 01 Oct 2021 13:58:08 +02:00

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
index 2ce015c..8943dbb 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -6380,11 +6380,6 @@ static int select_idle_sibling(struct task_struct *p, int prev, int target)
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
 
