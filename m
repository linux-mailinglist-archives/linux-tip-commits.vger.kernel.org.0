Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D822300A60
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Jan 2021 18:59:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729276AbhAVRvZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 22 Jan 2021 12:51:25 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:55700 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729244AbhAVRm1 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 22 Jan 2021 12:42:27 -0500
Date:   Fri, 22 Jan 2021 17:41:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611337295;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/1vB1QUr1165eo6pyFtEfPYX+ErJNEqfinIUJxVvEKM=;
        b=FgFz+xSpdCwceSvwMneDofsr/4IGvBsvNSTtgt7M6OP3LYqtA/b64ByVj60QsI1jJwOVr9
        jwUwoVcp34Oq6FCojfbVK7uKe/zxKOZbTUibtzPNEKtPHrPDh1qxU4TsNyCgWj8z4uQW5w
        hXTEHsGeohmwEEk7sd0NteIRT2PH53rdSfPujxlawt2ZPvIcxNhYJb10vzCQU0QIAuIgT2
        5loVuKF3Uf6EAuDqKdio/qqdYtq9RmKEr8gSwzHqwtI3BC81/I9U/qKINTf2iIgrtsiHWn
        L683C1tma7Y1zCKEo5D9PaN0mZz7k1ycaQYEQaw3u/XMYaftg8c4GXqXETwo9A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611337295;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/1vB1QUr1165eo6pyFtEfPYX+ErJNEqfinIUJxVvEKM=;
        b=aUEgvQPZmCkjbVtnI2Fs/Hi5NoGAUz6+y1WbwmHqgN5iySfuy1YvQeP4f8CKOA0+5MGcuy
        Nucw2zrX4f+zvtDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Prepare to use balance_push in ttwu()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210121103506.966069627@infradead.org>
References: <20210121103506.966069627@infradead.org>
MIME-Version: 1.0
Message-ID: <161133729464.414.3770602797973233529.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     975707f227b07a8212060f94447171d15d7a681b
Gitweb:        https://git.kernel.org/tip/975707f227b07a8212060f94447171d15d7a681b
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 20 Jan 2021 15:05:41 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Jan 2021 15:09:43 +01:00

sched: Prepare to use balance_push in ttwu()

In preparation of using the balance_push state in ttwu() we need it to
provide a reliable and consistent state.

The immediate problem is that rq->balance_callback gets cleared every
schedule() and then re-set in the balance_push_callback() itself. This
is not a reliable signal, so add a variable that stays set during the
entire time.

Also move setting it before the synchronize_rcu() in
sched_cpu_deactivate(), such that we get guaranteed visibility to
ttwu(), which is a preempt-disable region.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210121103506.966069627@infradead.org
---
 kernel/sched/core.c  | 11 ++++++-----
 kernel/sched/sched.h |  1 +
 2 files changed, 7 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 8da0fd7..16946b5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7320,6 +7320,7 @@ static void balance_push_set(int cpu, bool on)
 	struct rq_flags rf;
 
 	rq_lock_irqsave(rq, &rf);
+	rq->balance_push = on;
 	if (on) {
 		WARN_ON_ONCE(rq->balance_callback);
 		rq->balance_callback = &balance_push_callback;
@@ -7489,17 +7490,17 @@ int sched_cpu_deactivate(unsigned int cpu)
 	int ret;
 
 	set_cpu_active(cpu, false);
+	balance_push_set(cpu, true);
+
 	/*
-	 * We've cleared cpu_active_mask, wait for all preempt-disabled and RCU
-	 * users of this state to go away such that all new such users will
-	 * observe it.
+	 * We've cleared cpu_active_mask / set balance_push, wait for all
+	 * preempt-disabled and RCU users of this state to go away such that
+	 * all new such users will observe it.
 	 *
 	 * Do sync before park smpboot threads to take care the rcu boost case.
 	 */
 	synchronize_rcu();
 
-	balance_push_set(cpu, true);
-
 	rq_lock_irqsave(rq, &rf);
 	if (rq->rd) {
 		update_rq_clock(rq);
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 12ada79..bb09988 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -975,6 +975,7 @@ struct rq {
 	unsigned long		cpu_capacity_orig;
 
 	struct callback_head	*balance_callback;
+	unsigned char		balance_push;
 
 	unsigned char		nohz_idle_balance;
 	unsigned char		idle_balance;
