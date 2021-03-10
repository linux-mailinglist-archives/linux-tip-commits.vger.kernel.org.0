Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 81B78333B56
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Mar 2021 12:27:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232732AbhCJL0m (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Mar 2021 06:26:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59408 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231696AbhCJL0W (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Mar 2021 06:26:22 -0500
Date:   Wed, 10 Mar 2021 11:26:20 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1615375580;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h389p6FHMVwl0NH9HAX4yy8Z9Ckmi6Bs2yNrlrbIY7Q=;
        b=DRDv/6nq9Oot+B5t40KKKIiLj64I9JB0Fn8YJws06DCnWIrTix8GQIAmE6S9XAxE4/QOIf
        GJiq+iEPYIfs0/WbEB8dZxQEpmHcRd8F/LEgId9pX/XXfPBBVTIcLa2bfr9Guqw2jEfkTm
        avd6cm8XMpuuXEZDpsv5cAH6zJXuHadebUe9NQ7IUfeZzPJ2DmS6Ntg3DaqLcggMe99HxB
        k0YxZUIuoECETrQj8labCikhmul/Y1wmBFaRxGvfls4ef+Ds+92pQiz+tb0Coq5ca8DouN
        uja39gjSp0wQvAHb2tDqgMNACWmuaYnXCfNGd5My0OdX0r8QNNvxwzxN/rxJWg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1615375580;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=h389p6FHMVwl0NH9HAX4yy8Z9Ckmi6Bs2yNrlrbIY7Q=;
        b=quiPChoat4BR14F+J7192SCqC9K9x/ZPwmQ92kAss5gHf3ugvIzB0pFhE3qNW60GHzxrDr
        vzPC0W1Oy4bIYKDw==
From:   "tip-bot2 for Edmundo Carmona Antoranz" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Remove unnecessary variable from schedule_tail()
Cc:     Edmundo Carmona Antoranz <eantoranz@gmail.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210306210739.1370486-1-eantoranz@gmail.com>
References: <20210306210739.1370486-1-eantoranz@gmail.com>
MIME-Version: 1.0
Message-ID: <161537558015.398.4747038691034454737.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     13c2235b2b2870675195f0b551275d1abdd81068
Gitweb:        https://git.kernel.org/tip/13c2235b2b2870675195f0b551275d1abdd81068
Author:        Edmundo Carmona Antoranz <eantoranz@gmail.com>
AuthorDate:    Sat, 06 Mar 2021 15:07:39 -06:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 10 Mar 2021 09:51:49 +01:00

sched: Remove unnecessary variable from schedule_tail()

Since 565790d28b1 (sched: Fix balance_callback(), 2020-05-11), there
is no longer a need to reuse the result value of the call to finish_task_switch()
inside schedule_tail(), therefore the variable used to hold that value
(rq) is no longer needed.

Signed-off-by: Edmundo Carmona Antoranz <eantoranz@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210306210739.1370486-1-eantoranz@gmail.com
---
 kernel/sched/core.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d2629fd..28c4df6 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4253,8 +4253,6 @@ static struct rq *finish_task_switch(struct task_struct *prev)
 asmlinkage __visible void schedule_tail(struct task_struct *prev)
 	__releases(rq->lock)
 {
-	struct rq *rq;
-
 	/*
 	 * New tasks start with FORK_PREEMPT_COUNT, see there and
 	 * finish_task_switch() for details.
@@ -4264,7 +4262,7 @@ asmlinkage __visible void schedule_tail(struct task_struct *prev)
 	 * PREEMPT_COUNT kernels).
 	 */
 
-	rq = finish_task_switch(prev);
+	finish_task_switch(prev);
 	preempt_enable();
 
 	if (current->set_child_tid)
