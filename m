Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B788528310A
	for <lists+linux-tip-commits@lfdr.de>; Mon,  5 Oct 2020 09:43:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgJEHnZ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 5 Oct 2020 03:43:25 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56722 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725873AbgJEHnY (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 5 Oct 2020 03:43:24 -0400
Date:   Mon, 05 Oct 2020 07:43:21 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1601883801;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bMq73A0NSByxPOSQeJNBiuFJsBNyJS81+JWcW/XuiL0=;
        b=Gj5VIyQcZpTL8T3YZEtFHIDbfPYQgldq5u5FnlTQF78Y78atMrOqVhi3tuZ83A47Pri81d
        /opGuY/z8ooroefmpxN1F6p0D3QUrk2ebz6rP7rJUuB1JDXiP8k/CFeHSKNQF35FrkQ33Z
        mz2iKSpiU60XmYExzl05qcF2gR9pDsT6NhJ94OJdk6vIAW6s/r1MsLRMIQzDCn/YyNho87
        jPS6/IPzmT/1vyr6UaS09Y8oDe6EAMPoxvDTbcE5B72bqnZEQuN2lRq0mzqDX/0H9DriBy
        znQpdeK2F8NNJGUCtBcsgdmoJt5i/tsq3/dW43/Wmy4csiPHCH+KY4CqdvXPgw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1601883801;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bMq73A0NSByxPOSQeJNBiuFJsBNyJS81+JWcW/XuiL0=;
        b=aG7xqTMUuwRo0e7TdwnLGl6YoeGfpCWFKpAzhYj+JrX3h4q+ZbIxRgzoItydt1QcYVP88o
        0/2W/bjm4Pu848Bw==
From:   "tip-bot2 for Peter Oskolkov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/fair: Tweak pick_next_entity()
Cc:     Peter Oskolkov <posk@google.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guitttot@linaro.org>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200930173532.1069092-1-posk@google.com>
References: <20200930173532.1069092-1-posk@google.com>
MIME-Version: 1.0
Message-ID: <160188380104.7002.8503046414879998622.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     9abb897345ce1d41257567f571a78137c961c405
Gitweb:        https://git.kernel.org/tip/9abb897345ce1d41257567f571a78137c961c405
Author:        Peter Oskolkov <posk@google.com>
AuthorDate:    Wed, 30 Sep 2020 10:35:32 -07:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Sat, 03 Oct 2020 16:30:52 +02:00

sched/fair: Tweak pick_next_entity()

Currently, pick_next_entity(...) has the following structure
(simplified):

  [...]
  if (last_buddy_ok())
    result = last_buddy;
  if (next_buddy_ok())
    result = next_buddy;
  [...]

The intended behavior is to prefer next buddy over last buddy;
the current code somewhat obfuscates this, and also wastes
cycles checking the last buddy when eventually the next buddy is
picked up.

So this patch refactors two 'ifs' above into

  [...]
  if (next_buddy_ok())
      result = next_buddy;
  else if (last_buddy_ok())
      result = last_buddy;
  [...]

Signed-off-by: Peter Oskolkov <posk@google.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guitttot@linaro.org>
Link: https://lkml.kernel.org/r/20200930173532.1069092-1-posk@google.com
---
 kernel/sched/fair.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index fc3410b..cec6cf9 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -4465,17 +4465,17 @@ pick_next_entity(struct cfs_rq *cfs_rq, struct sched_entity *curr)
 			se = second;
 	}
 
-	/*
-	 * Prefer last buddy, try to return the CPU to a preempted task.
-	 */
-	if (cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, left) < 1)
-		se = cfs_rq->last;
-
-	/*
-	 * Someone really wants this to run. If it's not unfair, run it.
-	 */
-	if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) < 1)
+	if (cfs_rq->next && wakeup_preempt_entity(cfs_rq->next, left) < 1) {
+		/*
+		 * Someone really wants this to run. If it's not unfair, run it.
+		 */
 		se = cfs_rq->next;
+	} else if (cfs_rq->last && wakeup_preempt_entity(cfs_rq->last, left) < 1) {
+		/*
+		 * Prefer last buddy, try to return the CPU to a preempted task.
+		 */
+		se = cfs_rq->last;
+	}
 
 	clear_buddies(cfs_rq, se);
 
