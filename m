Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2932532B06A
	for <lists+linux-tip-commits@lfdr.de>; Wed,  3 Mar 2021 04:43:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235185AbhCCDiQ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 2 Mar 2021 22:38:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378854AbhCBJDa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 2 Mar 2021 04:03:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDD1C0617A7;
        Tue,  2 Mar 2021 01:01:57 -0800 (PST)
Date:   Tue, 02 Mar 2021 09:01:55 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1614675715;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5BZjNMIXgFfSomf3xmqb3d4aOeU+GIFK8CehFXU27Kk=;
        b=kustaK1dyzIL3krfrrqPNQlOcCDdFUrejwPnmZRBpgeUugJ5hGElX2Lw3NLspo2yKnUIvF
        BqGIJYycoTLV9dOWPwC5xb/VozhooWYG+uhVkV38y08Cs+i9U5MCDXjpx1K474l+zsGwwQ
        PEmeo3F9eSbrRcyDlHgFneir03U8xg5AivHW2DPbEIsGdsML2SSYZu4bVp13dceqIg/TeD
        QjljhZ+nfHCdeFnRrEWIwcnmXDdmX2hKyNTQFV05Zi4yjpOvhDjG5s24+3u4ncKUNuSWJF
        CsZGE/dMkJvgeM7vvReI8W0EIn19d1O6jWupL5bzYMYNmqYVtkjUhCuv2z0JuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1614675715;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5BZjNMIXgFfSomf3xmqb3d4aOeU+GIFK8CehFXU27Kk=;
        b=6duYSOL+/p0imB22FS46KMwTCHWN05o5sqeWHTX93iG2OxLtgBQ/w1I5365hn9xVH1+VPn
        FTXMFYt9UxWP16AQ==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Merge for each idle cpu loop of ILB
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210224133007.28644-5-vincent.guittot@linaro.org>
References: <20210224133007.28644-5-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <161467571515.20312.5741237333961915372.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c0d2f3b54ed88ce1079f8ffb094205d3f578a9bb
Gitweb:        https://git.kernel.org/tip/c0d2f3b54ed88ce1079f8ffb094205d3f578a9bb
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Wed, 24 Feb 2021 14:30:04 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Mon, 01 Mar 2021 18:17:24 +01:00

sched/fair: Merge for each idle cpu loop of ILB

Remove the specific case for handling this_cpu outside for_each_cpu() loop
when running ILB. Instead we use for_each_cpu_wrap() and start with the
next cpu after this_cpu so we will continue to finish with this_cpu.

update_nohz_stats() is now used for this_cpu too and will prevents
unnecessary update. We don't need a special case for handling the update of
nohz.next_balance for this_cpu anymore because it is now handled by the
loop like others.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210224133007.28644-5-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 32 +++++++-------------------------
 1 file changed, 7 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 1b91030..3c00918 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -10043,22 +10043,9 @@ out:
 	 * When the cpu is attached to null domain for ex, it will not be
 	 * updated.
 	 */
-	if (likely(update_next_balance)) {
+	if (likely(update_next_balance))
 		rq->next_balance = next_balance;
 
-#ifdef CONFIG_NO_HZ_COMMON
-		/*
-		 * If this CPU has been elected to perform the nohz idle
-		 * balance. Other idle CPUs have already rebalanced with
-		 * nohz_idle_balance() and nohz.next_balance has been
-		 * updated accordingly. This CPU is now running the idle load
-		 * balance for itself and we need to update the
-		 * nohz.next_balance accordingly.
-		 */
-		if ((idle == CPU_IDLE) && time_after(nohz.next_balance, rq->next_balance))
-			nohz.next_balance = rq->next_balance;
-#endif
-	}
 }
 
 static inline int on_null_domain(struct rq *rq)
@@ -10385,8 +10372,12 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 	 */
 	smp_mb();
 
-	for_each_cpu(balance_cpu, nohz.idle_cpus_mask) {
-		if (balance_cpu == this_cpu || !idle_cpu(balance_cpu))
+	/*
+	 * Start with the next CPU after this_cpu so we will end with this_cpu and let a
+	 * chance for other idle cpu to pull load.
+	 */
+	for_each_cpu_wrap(balance_cpu,  nohz.idle_cpus_mask, this_cpu+1) {
+		if (!idle_cpu(balance_cpu))
 			continue;
 
 		/*
@@ -10432,15 +10423,6 @@ static void _nohz_idle_balance(struct rq *this_rq, unsigned int flags,
 	if (likely(update_next_balance))
 		nohz.next_balance = next_balance;
 
-	/* Newly idle CPU doesn't need an update */
-	if (idle != CPU_NEWLY_IDLE) {
-		update_blocked_averages(this_cpu);
-		has_blocked_load |= this_rq->has_blocked_load;
-	}
-
-	if (flags & NOHZ_BALANCE_KICK)
-		rebalance_domains(this_rq, CPU_IDLE);
-
 	WRITE_ONCE(nohz.next_blocked,
 		now + msecs_to_jiffies(LOAD_AVG_PERIOD));
 
