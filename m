Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B73FC440DC4
	for <lists+linux-tip-commits@lfdr.de>; Sun, 31 Oct 2021 11:16:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230505AbhJaKTB (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 31 Oct 2021 06:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230309AbhJaKTA (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 31 Oct 2021 06:19:00 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A106C061570;
        Sun, 31 Oct 2021 03:16:28 -0700 (PDT)
Date:   Sun, 31 Oct 2021 10:16:26 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635675387;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3/aqh/hDBvKlRDYUag7BPNoidPusmkWpvk8Q5e4Ty+k=;
        b=BcOE4Ji567zelabrZ+PuRygx/GPgbUOy+c4tpDwu0yuRDYv4LOLLGkPJZYvPKXK3RG5lbM
        tm0waMOdps0QfXirzHsQHqPXUtCI0RfdV2Ybu/83JHUgfmHCCpgk4QLbAjfQZxjdL3jcy5
        FN6ZcBv/2PnJUqjEuq/sh/VrAMKQ5H/XKnyeuEaHspQX+Ok+aiL3IyujWW9wwZB9wTgqQ1
        unS8/C5c/FiHHQM950js1clH68Ro7WrLU3s09j3O2lA89sGr1rDss5CKF93Jj9SULN2nK1
        n6Ivu3hqReN6uKYmh1NzjNS5fQ6OeSEr89QOmpDUW9gI4vRKEZmqqqMMBlss+g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635675387;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3/aqh/hDBvKlRDYUag7BPNoidPusmkWpvk8Q5e4Ty+k=;
        b=Bbrn25AvaFL7m7nOcWORsuDBtoSlzj3HHqNWTVpEIS0y4DiA9Ni1ZF8Hl5tRG6fkoZ/a7K
        P1N5X/h0vJDCTQBA==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Skip update_blocked_averages if we are
 defering load balance
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211019123537.17146-3-vincent.guittot@linaro.org>
References: <20211019123537.17146-3-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <163567538617.626.6566030882638028616.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9d783c8dd112ad4b619e74e4bf57d2be0b400693
Gitweb:        https://git.kernel.org/tip/9d783c8dd112ad4b619e74e4bf57d2be0b400693
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Tue, 19 Oct 2021 14:35:34 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sun, 31 Oct 2021 11:11:37 +01:00

sched/fair: Skip update_blocked_averages if we are defering load balance

In newidle_balance(), the scheduler skips load balance to the new idle cpu
when the 1st sd of this_rq is:

   this_rq->avg_idle < sd->max_newidle_lb_cost

Doing a costly call to update_blocked_averages() will not be useful and
simply adds overhead when this condition is true.

Check the condition early in newidle_balance() to skip
update_blocked_averages() when possible.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Tim Chen <tim.c.chen@linux.intel.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Mel Gorman <mgorman@suse.de>
Link: https://lore.kernel.org/r/20211019123537.17146-3-vincent.guittot@linaro.org
---
 kernel/sched/fair.c |  9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index c014567..c4c3686 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10873,17 +10873,20 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	 */
 	rq_unpin_lock(this_rq, rf);
 
+	rcu_read_lock();
+	sd = rcu_dereference_check_sched_domain(this_rq->sd);
+
 	if (this_rq->avg_idle < sysctl_sched_migration_cost ||
-	    !READ_ONCE(this_rq->rd->overload)) {
+	    !READ_ONCE(this_rq->rd->overload) ||
+	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
 
-		rcu_read_lock();
-		sd = rcu_dereference_check_sched_domain(this_rq->sd);
 		if (sd)
 			update_next_balance(sd, &next_balance);
 		rcu_read_unlock();
 
 		goto out;
 	}
+	rcu_read_unlock();
 
 	raw_spin_rq_unlock(this_rq);
 
