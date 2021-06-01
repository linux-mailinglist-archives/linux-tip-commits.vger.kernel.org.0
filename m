Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C05B3974ED
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jun 2021 16:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234220AbhFAOGk (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 1 Jun 2021 10:06:40 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33158 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234191AbhFAOGj (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 1 Jun 2021 10:06:39 -0400
Date:   Tue, 01 Jun 2021 14:04:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1622556297;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=85oWepKuBZhquuUtAM41JTzu8qQtxv0Ix5BcI0/vp4w=;
        b=ZdBEALaJv3aRcFerkAXP4pAuSmW0LdS6Y498TRzWCO+xWE/c6SbzHBwXy18k8PjJWOfNb8
        is+dLhlNN6GeZBVgqpzIxRtbJQuezXxH3Q1UeNRKAoqfaiw59AZciLZFdlZ6ah5dOagBbo
        leBJtjqRMq+42ebr6/KE8fI/kofXUgdwAcHOLjRndnbN2Uif4OE5n7M0zmBGR1HuvEIvPY
        1SWrWGPymBOSOaik3APRs5uh9BeBt/mb/BgYy3Q90l4iMU51e+4PeQLjY7N/Ury632NIJc
        Hq0lMWuY2vQ4fDEj3ipFF2tpzyqnmTbkVkIBNJSMWwhi/ikMeZtHOg4I2+8DNw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1622556297;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=85oWepKuBZhquuUtAM41JTzu8qQtxv0Ix5BcI0/vp4w=;
        b=O1vjBbWDmqp77/FCAo/+0Ef3t+G5sFv1tH3EIVvx4KXterONSHqDWkFn8jJ60q426YaE5x
        uj7VLZHXJAk1I6AQ==
From:   "tip-bot2 for Odin Ugedal" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Fix ascii art by relpacing tabs
Cc:     Odin Ugedal <odin@uged.al>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210518125202.78658-4-odin@uged.al>
References: <20210518125202.78658-4-odin@uged.al>
MIME-Version: 1.0
Message-ID: <162255629652.29796.7294465727073405136.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     08f7c2f4d0e9f4283f5796b8168044c034a1bfcb
Gitweb:        https://git.kernel.org/tip/08f7c2f4d0e9f4283f5796b8168044c034a1bfcb
Author:        Odin Ugedal <odin@uged.al>
AuthorDate:    Tue, 18 May 2021 14:52:02 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Jun 2021 16:00:11 +02:00

sched/fair: Fix ascii art by relpacing tabs

When using something other than 8 spaces per tab, this ascii art
makes not sense, and the reader might end up wondering what this
advanced equation "is".

Signed-off-by: Odin Ugedal <odin@uged.al>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Vincent Guittot <vincent.guittot@linaro.org>
Link: https://lkml.kernel.org/r/20210518125202.78658-4-odin@uged.al
---
 kernel/sched/fair.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 161b92a..a2c30e5 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -3093,7 +3093,7 @@ void reweight_task(struct task_struct *p, int prio)
  *
  *                     tg->weight * grq->load.weight
  *   ge->load.weight = -----------------------------               (1)
- *			  \Sum grq->load.weight
+ *                       \Sum grq->load.weight
  *
  * Now, because computing that sum is prohibitively expensive to compute (been
  * there, done that) we approximate it with this average stuff. The average
@@ -3107,7 +3107,7 @@ void reweight_task(struct task_struct *p, int prio)
  *
  *                     tg->weight * grq->avg.load_avg
  *   ge->load.weight = ------------------------------              (3)
- *				tg->load_avg
+ *                             tg->load_avg
  *
  * Where: tg->load_avg ~= \Sum grq->avg.load_avg
  *
@@ -3123,7 +3123,7 @@ void reweight_task(struct task_struct *p, int prio)
  *
  *                     tg->weight * grq->load.weight
  *   ge->load.weight = ----------------------------- = tg->weight   (4)
- *			    grp->load.weight
+ *                         grp->load.weight
  *
  * That is, the sum collapses because all other CPUs are idle; the UP scenario.
  *
@@ -3142,7 +3142,7 @@ void reweight_task(struct task_struct *p, int prio)
  *
  *                     tg->weight * grq->load.weight
  *   ge->load.weight = -----------------------------		   (6)
- *				tg_load_avg'
+ *                             tg_load_avg'
  *
  * Where:
  *
