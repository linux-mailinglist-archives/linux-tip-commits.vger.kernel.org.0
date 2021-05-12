Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6959037BA74
	for <lists+linux-tip-commits@lfdr.de>; Wed, 12 May 2021 12:28:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbhELK3u (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 06:29:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:50576 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbhELK3k (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 06:29:40 -0400
Date:   Wed, 12 May 2021 10:28:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620815311;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ROj/MIT/eu3/TkvR6Y3ds+CV+uoi/1jboacWObQXHXU=;
        b=KkBaRwSXPIUt9G2RoAlxuE/9z0UtsTXVTaAchVSvKCfkLt4ssZmlkggHr36H7C/Utj6Ymg
        ii+YYOeCQTVbcfIeK4BFCDnmrW/pekS27tmjwhehLs7/d5mBaIg2B58J3eREI4URD5O+Fs
        ZyhGgw55wAN+Qsr+UbUBTFEzmnysu62Ro2bf7ZvOymcJkCeSLl2/8ivL3DzO5lZP8dY2Ai
        UgcJCREhye3fYXr3da2DC+93rMngCELUc1sT9Rq7gP6+dYdqVVDiUkjOEPRbtPju8h52OB
        33t2+7aMcZ5aptBiuNEWsc98Tqvzs1ojkmQTk83R/oDV8swTgZEH6uk5zN/Q7g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620815311;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ROj/MIT/eu3/TkvR6Y3ds+CV+uoi/1jboacWObQXHXU=;
        b=XUDHEQTXA1iayjKCl6tBA3Tj9fvPuK6cM70L+GwBWMMTe6uaLytedcpEH+DoiHTGdxsu9E
        cixFgBv1BusAVjCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] delayacct: Use sched_clock()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Rik van Riel <riel@surriel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Balbir Singh <bsingharora@gmail.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210505111525.001031466@infradead.org>
References: <20210505111525.001031466@infradead.org>
MIME-Version: 1.0
Message-ID: <162081531128.29796.18316814517076123725.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4b7a08a0b6e4e910a6feee438d76e426381df0cb
Gitweb:        https://git.kernel.org/tip/4b7a08a0b6e4e910a6feee438d76e426381df0cb
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 04 May 2021 22:43:48 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 12 May 2021 11:43:23 +02:00

delayacct: Use sched_clock()

Like all scheduler statistics, use sched_clock() based time.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Rik van Riel <riel@surriel.com>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Johannes Weiner <hannes@cmpxchg.org>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Link: https://lkml.kernel.org/r/20210505111525.001031466@infradead.org
---
 kernel/delayacct.c | 22 ++++++++++------------
 1 file changed, 10 insertions(+), 12 deletions(-)

diff --git a/kernel/delayacct.c b/kernel/delayacct.c
index 2772575..3fe7cd5 100644
--- a/kernel/delayacct.c
+++ b/kernel/delayacct.c
@@ -7,9 +7,9 @@
 #include <linux/sched.h>
 #include <linux/sched/task.h>
 #include <linux/sched/cputime.h>
+#include <linux/sched/clock.h>
 #include <linux/slab.h>
 #include <linux/taskstats.h>
-#include <linux/time.h>
 #include <linux/sysctl.h>
 #include <linux/delayacct.h>
 #include <linux/module.h>
@@ -42,10 +42,9 @@ void __delayacct_tsk_init(struct task_struct *tsk)
  * Finish delay accounting for a statistic using its timestamps (@start),
  * accumalator (@total) and @count
  */
-static void delayacct_end(raw_spinlock_t *lock, u64 *start, u64 *total,
-			  u32 *count)
+static void delayacct_end(raw_spinlock_t *lock, u64 *start, u64 *total, u32 *count)
 {
-	s64 ns = ktime_get_ns() - *start;
+	s64 ns = local_clock() - *start;
 	unsigned long flags;
 
 	if (ns > 0) {
@@ -58,7 +57,7 @@ static void delayacct_end(raw_spinlock_t *lock, u64 *start, u64 *total,
 
 void __delayacct_blkio_start(void)
 {
-	current->delays->blkio_start = ktime_get_ns();
+	current->delays->blkio_start = local_clock();
 }
 
 /*
@@ -151,21 +150,20 @@ __u64 __delayacct_blkio_ticks(struct task_struct *tsk)
 
 void __delayacct_freepages_start(void)
 {
-	current->delays->freepages_start = ktime_get_ns();
+	current->delays->freepages_start = local_clock();
 }
 
 void __delayacct_freepages_end(void)
 {
-	delayacct_end(
-		&current->delays->lock,
-		&current->delays->freepages_start,
-		&current->delays->freepages_delay,
-		&current->delays->freepages_count);
+	delayacct_end(&current->delays->lock,
+		      &current->delays->freepages_start,
+		      &current->delays->freepages_delay,
+		      &current->delays->freepages_count);
 }
 
 void __delayacct_thrashing_start(void)
 {
-	current->delays->thrashing_start = ktime_get_ns();
+	current->delays->thrashing_start = local_clock();
 }
 
 void __delayacct_thrashing_end(void)
