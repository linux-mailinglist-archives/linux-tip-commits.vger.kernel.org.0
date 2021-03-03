Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82B5D32C78B
	for <lists+linux-tip-commits@lfdr.de>; Thu,  4 Mar 2021 02:11:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358743AbhCDAcP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 3 Mar 2021 19:32:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1842924AbhCCKWg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 3 Mar 2021 05:22:36 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C809C08EC31;
        Wed,  3 Mar 2021 01:49:39 -0800 (PST)
Date:   Wed, 03 Mar 2021 09:49:37 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614764978;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/kpGDB+dtKyI/ybyOwa/9kKmrICWwBnWQy1b8eKtTxk=;
        b=JaCWgQGYIVDDJh0wZCn13hIhBcO6ExwkreY9w82DzsluNT0LaJdUV6XmkaUFW8qnGKa8cg
        9sNM5M0puRk2Stin6II69gte7W8OFQBLEdAiINycR44Pi5ATk7xfAN7sXAMDjmXdE847SG
        mwqMDIbydYXOTMcPiYVcoKaPSQsFnA86WYXGDVD34lpI4AfHkbZy5QrUVHnNLFtBkoAiVt
        Iqs+1WdgkcOMp8ik269opzjsB7dAAudMs4g9GPRceMUxSnNqZVjhY+oECXGGltbM2ULW82
        UN7cm0sKUxJsIL6xiAwugK9FS/KK1BD/3AFko8i5ReJIEz5Kj327pB3xFCsk8A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614764978;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/kpGDB+dtKyI/ybyOwa/9kKmrICWwBnWQy1b8eKtTxk=;
        b=xQx2StjM0GskqPkhlZENO7uI8kN7+JmtTSeJS2YEX2CceNI1NS/DCbTuAuL18pPyN1t066
        +Ql5pYw1IICvDrBw==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Reorder newidle_balance pulled_task tests
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210224133007.28644-6-vincent.guittot@linaro.org>
References: <20210224133007.28644-6-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <161476497748.20312.7719009634434548681.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     053192dea58da994fb3dd7ad235440accf292a08
Gitweb:        https://git.kernel.org/tip/053192dea58da994fb3dd7ad235440accf292a08
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Wed, 24 Feb 2021 14:30:05 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 03 Mar 2021 10:32:59 +01:00

sched/fair: Reorder newidle_balance pulled_task tests

Reorder the tests and skip useless ones when no load balance has been
performed and rq lock has not been released.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210224133007.28644-6-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3c00918..356a245 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10584,7 +10584,6 @@ static int newidle_balance(struct rq *this_rq, struct rq_flags *rf)
 	if (curr_cost > this_rq->max_idle_balance_cost)
 		this_rq->max_idle_balance_cost = curr_cost;
 
-out:
 	/*
 	 * While browsing the domains, we released the rq lock, a task could
 	 * have been enqueued in the meantime. Since we're not going idle,
@@ -10593,14 +10592,15 @@ out:
 	if (this_rq->cfs.h_nr_running && !pulled_task)
 		pulled_task = 1;
 
-	/* Move the next balance forward */
-	if (time_after(this_rq->next_balance, next_balance))
-		this_rq->next_balance = next_balance;
-
 	/* Is there a task of a high priority class? */
 	if (this_rq->nr_running != this_rq->cfs.h_nr_running)
 		pulled_task = -1;
 
+out:
+	/* Move the next balance forward */
+	if (time_after(this_rq->next_balance, next_balance))
+		this_rq->next_balance = next_balance;
+
 	if (pulled_task)
 		this_rq->idle_stamp = 0;
 	else
