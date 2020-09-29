Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E98627BE99
	for <lists+linux-tip-commits@lfdr.de>; Tue, 29 Sep 2020 09:57:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725826AbgI2H5a (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 29 Sep 2020 03:57:30 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44420 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727637AbgI2H4x (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 29 Sep 2020 03:56:53 -0400
Date:   Tue, 29 Sep 2020 07:56:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601366210;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2361Blfymd9sqzhCbOPufWv7rAm3Nq1oL7Kw1TiboSM=;
        b=Bwgw9vhjwDSWplsibM20YNx3ZYjat2Qn6BC7VgrgVjhUwSB44UbU+AEmZmU7NavEZBWWj8
        rbrEnNuJCD83Yi7LADe+6oWRGzY3h/h7DaZim7vDg7E9DGMB3jwlUAQmDJevaedyvzhXSp
        FdwdQpuZxmu0SukCozDck6vksGbPrZTFPxc6dze8SlxrBuutuqr0L03by0Yp0J7WqNtLLI
        R/gTsHYwEDG1oCRKKb64goLrrpajX6kb1lMdgs/An6Hpjv5R8pqOWBt0CSF5Y0222gXi5P
        w3Z+NImyC3z/srHVQXJfpKlh74UalfhSLd+4RRgx7iyW4bAZo8gbjrtiaYbWTA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601366210;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=2361Blfymd9sqzhCbOPufWv7rAm3Nq1oL7Kw1TiboSM=;
        b=S38dzOjL4YFeQjDSwCsEpeNrzAhPc62L1b4uIf6PsXjTANJT9A3v9+79tWnFo5PCihGE/3
        P9FyBcgIUB8pXgCQ==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Relax constraint on task's load during
 load balance
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200921072424.14813-2-vincent.guittot@linaro.org>
References: <20200921072424.14813-2-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <160136620995.7002.3858604337402103241.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5a7f555904671c0737819fe4d19bd6143de3f6c0
Gitweb:        https://git.kernel.org/tip/5a7f555904671c0737819fe4d19bd6143de3f6c0
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Mon, 21 Sep 2020 09:24:21 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 25 Sep 2020 14:23:25 +02:00

sched/fair: Relax constraint on task's load during load balance

Some UCs like 9 always running tasks on 8 CPUs can't be balanced and the
load balancer currently migrates the waiting task between the CPUs in an
almost random manner. The success of a rq pulling a task depends of the
value of nr_balance_failed of its domains and its ability to be faster
than others to detach it. This behavior results in an unfair distribution
of the running time between tasks because some CPUs will run most of the
time, if not always, the same task whereas others will share their time
between several tasks.

Instead of using nr_balance_failed as a boolean to relax the condition
for detaching task, the LB will use nr_balanced_failed to relax the
threshold between the tasks'load and the imbalance. This mecanism
prevents the same rq or domain to always win the load balance fight.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Phil Auld <pauld@redhat.com>
Link: https://lkml.kernel.org/r/20200921072424.14813-2-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index b56276a..5e3add3 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7679,8 +7679,8 @@ static int detach_tasks(struct lb_env *env)
 			 * scheduler fails to find a good waiting task to
 			 * migrate.
 			 */
-			if (load/2 > env->imbalance &&
-			    env->sd->nr_balance_failed <= env->sd->cache_nice_tries)
+
+			if ((load >> env->sd->nr_balance_failed) > env->imbalance)
 				goto next;
 
 			env->imbalance -= load;
