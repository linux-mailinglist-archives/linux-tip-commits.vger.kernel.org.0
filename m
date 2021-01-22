Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AD82A300A43
	for <lists+linux-tip-commits@lfdr.de>; Fri, 22 Jan 2021 18:51:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728923AbhAVRup (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 22 Jan 2021 12:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729267AbhAVRmZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 22 Jan 2021 12:42:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97750C0613D6;
        Fri, 22 Jan 2021 09:41:38 -0800 (PST)
Date:   Fri, 22 Jan 2021 17:41:36 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1611337296;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NZre0rtm0ik9c9K+MY0f0zk7+c0MzlrD4JNer3gU+IA=;
        b=pNtzCsCCmnfERAHzKyAJ9oCezsVQyNQij15fPfuB2BFMhEyX2yZLDE1nh5oqCEt3Uh6Z14
        b6kH8iK4UdVbFR3eUIvi+46NHRJJLnT93gdW5z48n0YR3Aiee6bHAnJ2oZy+Z1HuIEWJ2L
        Mhys+qdiJNrO5K4X8xJt/xteIgTjCpxWqi7g1A0YTyxYEoxUC5KdfD13C0qtuF0Y3vwH8N
        Mc/nxpZHgDw97/gLKAPxbj2YEwT48blDSoJ4f1l7DbeXjoUIkCnxKmuoqWSn5mpdrG8G5I
        QERVIaWvKmyCQy6KjO4t0Kri7bGWNSIsf29VzvTtN1jMP1syO4BD8JuQzLPLew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1611337296;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NZre0rtm0ik9c9K+MY0f0zk7+c0MzlrD4JNer3gU+IA=;
        b=FMf3jv4ptYe+KFe/GA78yzIHCpLxjoQ9RkQdZBYSSbVmK/4FOXUNZNRKGQUAQ5DKw6O79T
        eWc1ihHAUx1sfbAw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched: Don't run cpu-online with balance_push() enabled
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210121103506.415606087@infradead.org>
References: <20210121103506.415606087@infradead.org>
MIME-Version: 1.0
Message-ID: <161133729610.414.12540823678408067540.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     22f667c97aadbf481e2cae2d6feabdf431e27b31
Gitweb:        https://git.kernel.org/tip/22f667c97aadbf481e2cae2d6feabdf431e27b31
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 15 Jan 2021 18:17:45 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 22 Jan 2021 15:09:42 +01:00

sched: Don't run cpu-online with balance_push() enabled

We don't need to push away tasks when we come online, mark the push
complete right before the CPU dies.

XXX hotplug state machine has trouble with rollback here.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/20210121103506.415606087@infradead.org
---
 kernel/sched/core.c | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 627534f..8da0fd7 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7320,10 +7320,12 @@ static void balance_push_set(int cpu, bool on)
 	struct rq_flags rf;
 
 	rq_lock_irqsave(rq, &rf);
-	if (on)
+	if (on) {
+		WARN_ON_ONCE(rq->balance_callback);
 		rq->balance_callback = &balance_push_callback;
-	else
+	} else if (rq->balance_callback == &balance_push_callback) {
 		rq->balance_callback = NULL;
+	}
 	rq_unlock_irqrestore(rq, &rf);
 }
 
@@ -7441,6 +7443,10 @@ int sched_cpu_activate(unsigned int cpu)
 	struct rq *rq = cpu_rq(cpu);
 	struct rq_flags rf;
 
+	/*
+	 * Make sure that when the hotplug state machine does a roll-back
+	 * we clear balance_push. Ideally that would happen earlier...
+	 */
 	balance_push_set(cpu, false);
 
 #ifdef CONFIG_SCHED_SMT
@@ -7608,6 +7614,12 @@ int sched_cpu_dying(unsigned int cpu)
 	}
 	rq_unlock_irqrestore(rq, &rf);
 
+	/*
+	 * Now that the CPU is offline, make sure we're welcome
+	 * to new tasks once we come back up.
+	 */
+	balance_push_set(cpu, false);
+
 	calc_load_migrate(rq);
 	update_max_interval();
 	nohz_balance_exit_idle(rq);
