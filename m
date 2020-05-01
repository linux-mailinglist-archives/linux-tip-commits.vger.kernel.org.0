Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE82C1C1CFD
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 May 2020 20:26:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730668AbgEASW3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 1 May 2020 14:22:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730653AbgEASWZ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 1 May 2020 14:22:25 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E578C061A0E;
        Fri,  1 May 2020 11:22:25 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jUaIg-0003aq-0S; Fri, 01 May 2020 20:22:14 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id BDC771C0085;
        Fri,  1 May 2020 20:22:11 +0200 (CEST)
Date:   Fri, 01 May 2020 18:22:11 -0000
From:   "tip-bot2 for Peng Wang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Simplify the code of should_we_balance()
Cc:     Peng Wang <rocking@linux.alibaba.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: =?utf-8?q?=3C245c792f0e580b3ca342ad61257f4c066ee0f84f=2E15865?=
 =?utf-8?q?94833=2Egit=2Erocking=40linux=2Ealibaba=2Ecom=3E?=
References: =?utf-8?q?=3C245c792f0e580b3ca342ad61257f4c066ee0f84f=2E158659?=
 =?utf-8?q?4833=2Egit=2Erocking=40linux=2Ealibaba=2Ecom=3E?=
MIME-Version: 1.0
Message-ID: <158835733170.8414.4894119200502655023.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     64297f2b03cc7a6d0184a435f1b296beca1bedd1
Gitweb:        https://git.kernel.org/tip/64297f2b03cc7a6d0184a435f1b296beca1bedd1
Author:        Peng Wang <rocking@linux.alibaba.com>
AuthorDate:    Sat, 11 Apr 2020 17:20:20 +08:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 30 Apr 2020 20:14:38 +02:00

sched/fair: Simplify the code of should_we_balance()

We only consider group_balance_cpu() after there is no idle
cpu. So, just do comparison before return at these two cases.

Signed-off-by: Peng Wang <rocking@linux.alibaba.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/245c792f0e580b3ca342ad61257f4c066ee0f84f.1586594833.git.rocking@linux.alibaba.com
---
 kernel/sched/fair.c | 16 +++++-----------
 1 file changed, 5 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 3d6ce75..63419c6 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9413,7 +9413,7 @@ static int active_load_balance_cpu_stop(void *data);
 static int should_we_balance(struct lb_env *env)
 {
 	struct sched_group *sg = env->sd->groups;
-	int cpu, balance_cpu = -1;
+	int cpu;
 
 	/*
 	 * Ensure the balancing environment is consistent; can happen
@@ -9434,18 +9434,12 @@ static int should_we_balance(struct lb_env *env)
 		if (!idle_cpu(cpu))
 			continue;
 
-		balance_cpu = cpu;
-		break;
+		/* Are we the first idle CPU? */
+		return cpu == env->dst_cpu;
 	}
 
-	if (balance_cpu == -1)
-		balance_cpu = group_balance_cpu(sg);
-
-	/*
-	 * First idle CPU or the first CPU(busiest) in this sched group
-	 * is eligible for doing load balancing at this and above domains.
-	 */
-	return balance_cpu == env->dst_cpu;
+	/* Are we the first CPU of this group ? */
+	return group_balance_cpu(sg) == env->dst_cpu;
 }
 
 /*
