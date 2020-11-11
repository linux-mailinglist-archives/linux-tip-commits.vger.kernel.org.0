Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD752AEB06
	for <lists+linux-tip-commits@lfdr.de>; Wed, 11 Nov 2020 09:23:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726440AbgKKIXg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 11 Nov 2020 03:23:36 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36524 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726391AbgKKIXa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 11 Nov 2020 03:23:30 -0500
Date:   Wed, 11 Nov 2020 08:23:28 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605083008;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cUQC2Q7cay1Wpan7h8A9R+2dsmyxEmPRMWdof2w9Ghc=;
        b=lr+AcNhU/pX8aSkdVm0J0kutuSAiX+TVmCxYM9EyitUQX+l4pHeZQx9u7GOANHUJ2wPhRg
        YDj8Lqj5jwt6fFEkpvZfjXJ0jYr0f4dzwTcufIqAkpxWXxSburMlocfs9FbfwWLJje5Qak
        TCAswlKvnmZK7BpFvobOAf8i63fMv0z63xr/nx7i/eSABmFaPJFSVEnTYtXPK1Eh+woDWs
        diee+KGvBPnfrsDztFSTmgcxNgY9qknUyB0ESRSYh9VoyR80BVB6ZUoU5rU1RD1dGUfN9T
        g5KqmFjoipN5FUI6rdY2SsmWf+eaka1M5LNaLUV4f7SvTF6PmCKk6pCGTX2MUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605083008;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cUQC2Q7cay1Wpan7h8A9R+2dsmyxEmPRMWdof2w9Ghc=;
        b=hfrFCo1pFgK2qQmkZOrZaCk0aM+au6I3z+OZ/4M9cf9IOfGUxjC7JK0DpiKizQVfNLEliN
        PY38BGl3fL2SSuDQ==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/fair: Ensure tasks spreading in LLC during LB
Cc:     Chris Mason <clm@fb.com>, Rik van Riel <riel@surriel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201102102457.28808-1-vincent.guittot@linaro.org>
References: <20201102102457.28808-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <160508300800.11244.2752247858204582099.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     16b0a7a1a0af9db6e008fecd195fe4d6cb366d83
Gitweb:        https://git.kernel.org/tip/16b0a7a1a0af9db6e008fecd195fe4d6cb366d83
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Mon, 02 Nov 2020 11:24:57 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 10 Nov 2020 18:38:48 +01:00

sched/fair: Ensure tasks spreading in LLC during LB

schbench shows latency increase for 95 percentile above since:
  commit 0b0695f2b34a ("sched/fair: Rework load_balance()")

Align the behavior of the load balancer with the wake up path, which tries
to select an idle CPU which belongs to the LLC for a waking task.

calculate_imbalance() will use nr_running instead of the spare
capacity when CPUs share resources (ie cache) at the domain level. This
will ensure a better spread of tasks on idle CPUs.

Running schbench on a hikey (8cores arm64) shows the problem:

tip/sched/core :
schbench -m 2 -t 4 -s 10000 -c 1000000 -r 10
Latency percentiles (usec)
	50.0th: 33
	75.0th: 45
	90.0th: 51
	95.0th: 4152
	*99.0th: 14288
	99.5th: 14288
	99.9th: 14288
	min=0, max=14276

tip/sched/core + patch :
schbench -m 2 -t 4 -s 10000 -c 1000000 -r 10
Latency percentiles (usec)
	50.0th: 34
	75.0th: 47
	90.0th: 52
	95.0th: 78
	*99.0th: 94
	99.5th: 94
	99.9th: 94
	min=0, max=94

Fixes: 0b0695f2b34a ("sched/fair: Rework load_balance()")
Reported-by: Chris Mason <clm@fb.com>
Suggested-by: Rik van Riel <riel@surriel.com>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Rik van Riel <riel@surriel.com>
Tested-by: Rik van Riel <riel@surriel.com>
Link: https://lkml.kernel.org/r/20201102102457.28808-1-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index aa4c622..210b15f 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9031,7 +9031,8 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
 	 * emptying busiest.
 	 */
 	if (local->group_type == group_has_spare) {
-		if (busiest->group_type > group_fully_busy) {
+		if ((busiest->group_type > group_fully_busy) &&
+		    !(env->sd->flags & SD_SHARE_PKG_RESOURCES)) {
 			/*
 			 * If busiest is overloaded, try to fill spare
 			 * capacity. This might end up creating spare capacity
