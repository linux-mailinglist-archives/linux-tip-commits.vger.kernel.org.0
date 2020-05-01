Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5856E1C1CDB
	for <lists+linux-tip-commits@lfdr.de>; Fri,  1 May 2020 20:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730576AbgEASWS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 1 May 2020 14:22:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730566AbgEASWS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 1 May 2020 14:22:18 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150A9C061A0C;
        Fri,  1 May 2020 11:22:18 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jUaId-0003ZQ-Vg; Fri, 01 May 2020 20:22:12 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 0A2861C04CD;
        Fri,  1 May 2020 20:22:11 +0200 (CEST)
Date:   Fri, 01 May 2020 18:22:11 -0000
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: find_idlest_group(): Remove unused
 sd_flag parameter
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200415210512.805-2-valentin.schneider@arm.com>
References: <20200415210512.805-2-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <158835733100.8414.8749051754124595190.tip-bot2@tip-bot2>
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

Commit-ID:     45da27732b0b9b7a04696653065d5e6037bc5ac0
Gitweb:        https://git.kernel.org/tip/45da27732b0b9b7a04696653065d5e6037bc5ac0
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Wed, 15 Apr 2020 22:05:04 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 30 Apr 2020 20:14:39 +02:00

sched/fair: find_idlest_group(): Remove unused sd_flag parameter

The last use of that parameter was removed by commit

  57abff067a08 ("sched/fair: Rework find_idlest_group()")

Get rid of the parameter.

Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20200415210512.805-2-valentin.schneider@arm.com
---
 kernel/sched/fair.c | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 63419c6..617ca44 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -5825,8 +5825,7 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
 }
 
 static struct sched_group *
-find_idlest_group(struct sched_domain *sd, struct task_struct *p,
-		  int this_cpu, int sd_flag);
+find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu);
 
 /*
  * find_idlest_group_cpu - find the idlest CPU among the CPUs in the group.
@@ -5909,7 +5908,7 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
 			continue;
 		}
 
-		group = find_idlest_group(sd, p, cpu, sd_flag);
+		group = find_idlest_group(sd, p, cpu);
 		if (!group) {
 			sd = sd->child;
 			continue;
@@ -8681,8 +8680,7 @@ static bool update_pick_idlest(struct sched_group *idlest,
  * Assumes p is allowed on at least one CPU in sd.
  */
 static struct sched_group *
-find_idlest_group(struct sched_domain *sd, struct task_struct *p,
-		  int this_cpu, int sd_flag)
+find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 {
 	struct sched_group *idlest = NULL, *local = NULL, *group = sd->groups;
 	struct sg_lb_stats local_sgs, tmp_sgs;
