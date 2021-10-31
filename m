Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB243440DC0
	for <lists+linux-tip-commits@lfdr.de>; Sun, 31 Oct 2021 11:16:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230289AbhJaKTA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sun, 31 Oct 2021 06:19:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbhJaKS7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sun, 31 Oct 2021 06:18:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CE1BC061570;
        Sun, 31 Oct 2021 03:16:27 -0700 (PDT)
Date:   Sun, 31 Oct 2021 10:16:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1635675385;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JzHdHJlbHhuYY33VjvFtkANtOHHDGM4IHZMWFqy4M/Q=;
        b=JJwpCNQnAVnclfOizdf8ZoYm1wHEYHyzhsi0+7EOT5N8Kj14TNqoD6nWBLH0OfwAsYjbfr
        QA01H1he1lVuSGpRBB3hGI3kWGHhF0XpKDQWr33I5QERdMlpcmPYhlJpttzU90sNHnk5Da
        8ulriR6d3v8BqItKSHuTtUVZ3eZmCXWtIqULTZHZizOGSH4WJS3Zy7z9GqP7JzQJxLoDmI
        uLw7hTtNYPmOqTw7uG0/JekjWvWbbomLaMCinpf/yQfCXv7QyNwdkjVN2aY38F0WGWivzM
        eWQK52wMe9w+TcUQdOD5kqqlzN1sp7vMcb4gq3O+cCsNKSSAaG0Dl68ojxvzkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1635675385;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JzHdHJlbHhuYY33VjvFtkANtOHHDGM4IHZMWFqy4M/Q=;
        b=wPhA+6Yln8yBKbUWEBn5w4/r9EHtynh5EdF0aYr+5tTWKPt6y1qCEIUgxPi50rRN2Iaxyk
        i4fy9bvArzfyLGDg==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Remove sysctl_sched_migration_cost condition
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Mel Gorman <mgorman@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211019123537.17146-5-vincent.guittot@linaro.org>
References: <20211019123537.17146-5-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <163567538466.626.13781105021301301557.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c5b0a7eefc70150caf23e37bc9d639c68c87a097
Gitweb:        https://git.kernel.org/tip/c5b0a7eefc70150caf23e37bc9d639c68c87a097
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Tue, 19 Oct 2021 14:35:36 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sun, 31 Oct 2021 11:11:38 +01:00

sched/fair: Remove sysctl_sched_migration_cost condition

With a default value of 500us, sysctl_sched_migration_cost is
significanlty higher than the cost of load_balance. Remove the
condition and rely on the sd->max_newidle_lb_cost to abort
newidle_balance.

Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Acked-by: Mel Gorman <mgorman@suse.de>
Link: https://lore.kernel.org/r/20211019123537.17146-5-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index e50fd75..57eae0e 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10895,8 +10895,7 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	rcu_read_lock();
 	sd = rcu_dereference_check_sched_domain(this_rq->sd);
 
-	if (this_rq->avg_idle < sysctl_sched_migration_cost ||
-	    !READ_ONCE(this_rq->rd->overload) ||
+	if (!READ_ONCE(this_rq->rd->overload) ||
 	    (sd && this_rq->avg_idle < sd->max_newidle_lb_cost)) {
 
 		if (sd)
