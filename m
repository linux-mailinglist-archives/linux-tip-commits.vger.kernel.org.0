Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BD7BF367B2A
	for <lists+linux-tip-commits@lfdr.de>; Thu, 22 Apr 2021 09:36:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230354AbhDVHgi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 22 Apr 2021 03:36:38 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:36656 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230270AbhDVHgh (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 22 Apr 2021 03:36:37 -0400
Date:   Thu, 22 Apr 2021 07:36:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1619076961;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5BPjRU/aio+uIA/kawT7pY2czn5LygKfqK3VbBVRqeg=;
        b=dkrArgqvcAz5iZKUzXoONvQVvTq/FSg4e2hRg5IZKud5H4QwbQHFA/8oaE2Yj9wS2pZnzM
        PZUQLrXSxzjcddTbvKV96IAN6nSHIlhy1VnfIa0GBiNf9TxtFT6nMm/os59jJThnW9qeE2
        Ng4xEaWUf38ShsLBkR1CszZ9ynacOyz8/xjCoMEMA6YI+eaFON01jTmSLkTACk66kvBVCb
        YweqUohbOjQ4oG78hL9xjWbHnJQ+aceC8qzH+iOf1fk/52zorU91DIWN+NIwX2M83AxUI4
        zNGwU0xF9R98Q6obiX8ayWEHdRh/pmH3fJ92hfxau+8P4Ddbfj/8DWG6TWJ4Pg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1619076961;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5BPjRU/aio+uIA/kawT7pY2czn5LygKfqK3VbBVRqeg=;
        b=I+EqDfc1W2L45D8Wvbnj98Ij1lpj7pzrTmUXul2iX65VSmG2AQ5zUQAYtyuyYeR/H+MZT+
        2VW+gYj9QD4d0jDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] cpumask/hotplug: Fix cpu_dying() state tracking
Cc:     Vincent Donnefort <vincent.donnefort@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <YH7r+AoQEReSvxBI@hirez.programming.kicks-ass.net>
References: <YH7r+AoQEReSvxBI@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <161907696123.29796.5912921804095003664.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     2ea46c6fc9452ac100ad907b051d797225847e33
Gitweb:        https://git.kernel.org/tip/2ea46c6fc9452ac100ad907b051d797225847e33
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 20 Apr 2021 20:04:19 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 21 Apr 2021 13:55:43 +02:00

cpumask/hotplug: Fix cpu_dying() state tracking

Vincent reported that for states with a NULL startup/teardown function
we do not call cpuhp_invoke_callback() (because there is none) and as
such we'll not update the cpu_dying() state.

The stale cpu_dying() can eventually lead to triggering BUG().

Rectify this by updating cpu_dying() in the exact same places the
hotplug machinery tracks its directional state, namely
cpuhp_set_state() and cpuhp_reset_state().

Reported-by: Vincent Donnefort <vincent.donnefort@arm.com>
Suggested-by: Vincent Donnefort <vincent.donnefort@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Donnefort <vincent.donnefort@arm.com>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Link: https://lkml.kernel.org/r/YH7r+AoQEReSvxBI@hirez.programming.kicks-ass.net
---
 kernel/cpu.c | 16 +++++++++++-----
 1 file changed, 11 insertions(+), 5 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 838dcf2..e538518 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -63,6 +63,7 @@ struct cpuhp_cpu_state {
 	bool			rollback;
 	bool			single;
 	bool			bringup;
+	int			cpu;
 	struct hlist_node	*node;
 	struct hlist_node	*last;
 	enum cpuhp_state	cb_state;
@@ -160,9 +161,6 @@ static int cpuhp_invoke_callback(unsigned int cpu, enum cpuhp_state state,
 	int (*cb)(unsigned int cpu);
 	int ret, cnt;
 
-	if (cpu_dying(cpu) != !bringup)
-		set_cpu_dying(cpu, !bringup);
-
 	if (st->fail == state) {
 		st->fail = CPUHP_INVALID;
 		return -EAGAIN;
@@ -467,13 +465,16 @@ static inline enum cpuhp_state
 cpuhp_set_state(struct cpuhp_cpu_state *st, enum cpuhp_state target)
 {
 	enum cpuhp_state prev_state = st->state;
+	bool bringup = st->state < target;
 
 	st->rollback = false;
 	st->last = NULL;
 
 	st->target = target;
 	st->single = false;
-	st->bringup = st->state < target;
+	st->bringup = bringup;
+	if (cpu_dying(st->cpu) != !bringup)
+		set_cpu_dying(st->cpu, !bringup);
 
 	return prev_state;
 }
@@ -481,6 +482,8 @@ cpuhp_set_state(struct cpuhp_cpu_state *st, enum cpuhp_state target)
 static inline void
 cpuhp_reset_state(struct cpuhp_cpu_state *st, enum cpuhp_state prev_state)
 {
+	bool bringup = !st->bringup;
+
 	st->target = prev_state;
 
 	/*
@@ -503,7 +506,9 @@ cpuhp_reset_state(struct cpuhp_cpu_state *st, enum cpuhp_state prev_state)
 			st->state++;
 	}
 
-	st->bringup = !st->bringup;
+	st->bringup = bringup;
+	if (cpu_dying(st->cpu) != !bringup)
+		set_cpu_dying(st->cpu, !bringup);
 }
 
 /* Regular hotplug invocation of the AP hotplug thread */
@@ -693,6 +698,7 @@ static void cpuhp_create(unsigned int cpu)
 
 	init_completion(&st->done_up);
 	init_completion(&st->done_down);
+	st->cpu = cpu;
 }
 
 static int cpuhp_should_run(unsigned int cpu)
