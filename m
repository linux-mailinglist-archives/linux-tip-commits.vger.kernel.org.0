Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2B7382F6004
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Jan 2021 12:31:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728824AbhANLa0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 14 Jan 2021 06:30:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726948AbhANLaW (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 14 Jan 2021 06:30:22 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4DC6C0613D6;
        Thu, 14 Jan 2021 03:29:07 -0800 (PST)
Date:   Thu, 14 Jan 2021 11:29:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1610623746;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/UusE7S7X/Bu4d8l/hL8T9ugF+/T68MT1V1isQyK0UQ=;
        b=Yz/1srcsCEvHHQnke19KCI7znxgRWzb050x+LicErlxup7tGnTPbwgEYfUr6FCFbv224em
        1Co+tFrXlDo27G38KCjiZ/H3aM1c5yFjpQdmXvKmLDqdKygzE3Af/epdXqrsuEgagEqT0H
        CPeGB/d39pxNS3yQvj9r9LYTHldZ6MQLzZfPuLSse61uAi//Th3aWWT4n6tONvij1oS+YY
        9/7A+p5mbRl3DzNobQEv2N/CtmkmD4tnUdt9qrQDZokVkVPcDqJEyQsupHCwOmrtG/EJTK
        pHl6abORVIq5tBwYo+We9PIraQtoYMo074AQLN6IR8bj5oo/LLy/g2p2MPi/0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1610623746;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/UusE7S7X/Bu4d8l/hL8T9ugF+/T68MT1V1isQyK0UQ=;
        b=61V8Zv5daCHVdWC1sJrQM+eGKFA51NwGEoQ85MKK+bOerACU2BIAIVsRhredi+fdfuFcDI
        uYMk7J+7Wwy5wDAQ==
From:   "tip-bot2 for Vincent Guittot" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Reduce cases for active balance
Cc:     Vincent Guittot <vincent.guittot@linaro.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210107103325.30851-4-vincent.guittot@linaro.org>
References: <20210107103325.30851-4-vincent.guittot@linaro.org>
MIME-Version: 1.0
Message-ID: <161062374566.414.13015378085673509435.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     e9b9734b74656abb585a7f6fabf1d30ce00e51ea
Gitweb:        https://git.kernel.org/tip/e9b9734b74656abb585a7f6fabf1d30ce00e51ea
Author:        Vincent Guittot <vincent.guittot@linaro.org>
AuthorDate:    Thu, 07 Jan 2021 11:33:25 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 14 Jan 2021 11:20:11 +01:00

sched/fair: Reduce cases for active balance

Active balance is triggered for a number of voluntary cases like misfit
or pinned tasks cases but also after that a number of load balance
attempts failed to migrate a task. There is no need to use active load
balance when the group is overloaded because an overloaded state means
that there is at least one waiting task. Nevertheless, the waiting task
is not selected and detached until the threshold becomes higher than its
load. This threshold increases with the number of failed lb (see the
condition if ((load >> env->sd->nr_balance_failed) > env->imbalance) in
detach_tasks()) and the waiting task will end up to be selected after a
number of attempts.

Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Acked-by: Mel Gorman <mgorman@suse.de>
Link: https://lkml.kernel.org/r/20210107103325.30851-4-vincent.guittot@linaro.org
---
 kernel/sched/fair.c | 45 ++++++++++++++++++++++----------------------
 1 file changed, 23 insertions(+), 22 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 48f99c8..53802b7 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9512,13 +9512,32 @@ asym_active_balance(struct lb_env *env)
 }
 
 static inline bool
-voluntary_active_balance(struct lb_env *env)
+imbalanced_active_balance(struct lb_env *env)
+{
+	struct sched_domain *sd = env->sd;
+
+	/*
+	 * The imbalanced case includes the case of pinned tasks preventing a fair
+	 * distribution of the load on the system but also the even distribution of the
+	 * threads on a system with spare capacity
+	 */
+	if ((env->migration_type == migrate_task) &&
+	    (sd->nr_balance_failed > sd->cache_nice_tries+2))
+		return 1;
+
+	return 0;
+}
+
+static int need_active_balance(struct lb_env *env)
 {
 	struct sched_domain *sd = env->sd;
 
 	if (asym_active_balance(env))
 		return 1;
 
+	if (imbalanced_active_balance(env))
+		return 1;
+
 	/*
 	 * The dst_cpu is idle and the src_cpu CPU has only 1 CFS task.
 	 * It's worth migrating the task if the src_cpu's capacity is reduced
@@ -9538,16 +9557,6 @@ voluntary_active_balance(struct lb_env *env)
 	return 0;
 }
 
-static int need_active_balance(struct lb_env *env)
-{
-	struct sched_domain *sd = env->sd;
-
-	if (voluntary_active_balance(env))
-		return 1;
-
-	return unlikely(sd->nr_balance_failed > sd->cache_nice_tries+2);
-}
-
 static int active_load_balance_cpu_stop(void *data);
 
 static int should_we_balance(struct lb_env *env)
@@ -9800,21 +9809,13 @@ more_balance:
 			/* We've kicked active balancing, force task migration. */
 			sd->nr_balance_failed = sd->cache_nice_tries+1;
 		}
-	} else
+	} else {
 		sd->nr_balance_failed = 0;
+	}
 
-	if (likely(!active_balance) || voluntary_active_balance(&env)) {
+	if (likely(!active_balance) || need_active_balance(&env)) {
 		/* We were unbalanced, so reset the balancing interval */
 		sd->balance_interval = sd->min_interval;
-	} else {
-		/*
-		 * If we've begun active balancing, start to back off. This
-		 * case may not be covered by the all_pinned logic if there
-		 * is only 1 task on the busy runqueue (because we don't call
-		 * detach_tasks).
-		 */
-		if (sd->balance_interval < sd->max_interval)
-			sd->balance_interval *= 2;
 	}
 
 	goto out;
