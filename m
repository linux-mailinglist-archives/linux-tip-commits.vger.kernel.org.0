Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5E44FFF5E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 13 Apr 2022 21:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236349AbiDMTfD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 13 Apr 2022 15:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235045AbiDMTe7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 13 Apr 2022 15:34:59 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AEAF765A3;
        Wed, 13 Apr 2022 12:32:37 -0700 (PDT)
Date:   Wed, 13 Apr 2022 19:32:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649878356;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i6lyY7gYuA3rQrqgOJCKcG1pvgSi2gRjRaKKzPU+WDk=;
        b=IGeIC6Oarbu7Qh2cXS6/G0oHWodiTdhhOt7kZEtjAJA65CiLhQLWgo13um51VHz4El7BXL
        mP8oiLuCKNoG0/jEvwJfhmUbmPxBacmNfJE+NvvGNexTdafvlT60PWu6dFTEthxiYgOPIO
        CfgoHNjLmnxkUl14J7vvgRqUQDIkdg9zzlQ0eLbbou5E7gpR23s2L3Gp8Pp5entrJntN9+
        B7sWs081XsmgpumCCabYKgQ3N7JyAE5MOC6o4zNftp1RzSV56Ip5pfNdB1fozoXnq76WAk
        PhlbPiZXbDmy9FEaJydtH5VzVYsifGGtyMQXdI2g2gxkKdPTzOBsEhn0VPeEOA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649878356;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i6lyY7gYuA3rQrqgOJCKcG1pvgSi2gRjRaKKzPU+WDk=;
        b=6UJQEOHtIWlgxiKw8lZHXo08QPScoIk3lrKd+XTPfaZx/wKkp/oubvkp564n16qU+0yuE+
        WnuT9g8ctmzoleBg==
From:   "tip-bot2 for Steven Price" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: smp/core] cpu/hotplug: Remove the 'cpu' member of cpuhp_cpu_state
Cc:     Steven Price <steven.price@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220411152233.474129-2-steven.price@arm.com>
References: <20220411152233.474129-2-steven.price@arm.com>
MIME-Version: 1.0
Message-ID: <164987835485.4207.7844394206761192724.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the smp/core branch of tip:

Commit-ID:     b7ba6d8dc3569e49800ef0136799f26f43e237e8
Gitweb:        https://git.kernel.org/tip/b7ba6d8dc3569e49800ef0136799f26f43e237e8
Author:        Steven Price <steven.price@arm.com>
AuthorDate:    Mon, 11 Apr 2022 16:22:32 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 13 Apr 2022 21:25:40 +02:00

cpu/hotplug: Remove the 'cpu' member of cpuhp_cpu_state

Currently the setting of the 'cpu' member of struct cpuhp_cpu_state in
cpuhp_create() is too late as it is used earlier in _cpu_up().

If kzalloc_node() in __smpboot_create_thread() fails then the rollback will
be done with st->cpu==0 causing CPU0 to be erroneously set to be dying,
causing the scheduler to get mightily confused and throw its toys out of
the pram.

However the cpu number is actually available directly, so simply remove
the 'cpu' member and avoid the problem in the first place.

Fixes: 2ea46c6fc945 ("cpumask/hotplug: Fix cpu_dying() state tracking")
Signed-off-by: Steven Price <steven.price@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20220411152233.474129-2-steven.price@arm.com

---
 kernel/cpu.c | 36 ++++++++++++++++++------------------
 1 file changed, 18 insertions(+), 18 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 5797c2a..d0a9aa0 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -71,7 +71,6 @@ struct cpuhp_cpu_state {
 	bool			rollback;
 	bool			single;
 	bool			bringup;
-	int			cpu;
 	struct hlist_node	*node;
 	struct hlist_node	*last;
 	enum cpuhp_state	cb_state;
@@ -475,7 +474,7 @@ static inline bool cpu_smt_allowed(unsigned int cpu) { return true; }
 #endif
 
 static inline enum cpuhp_state
-cpuhp_set_state(struct cpuhp_cpu_state *st, enum cpuhp_state target)
+cpuhp_set_state(int cpu, struct cpuhp_cpu_state *st, enum cpuhp_state target)
 {
 	enum cpuhp_state prev_state = st->state;
 	bool bringup = st->state < target;
@@ -486,14 +485,15 @@ cpuhp_set_state(struct cpuhp_cpu_state *st, enum cpuhp_state target)
 	st->target = target;
 	st->single = false;
 	st->bringup = bringup;
-	if (cpu_dying(st->cpu) != !bringup)
-		set_cpu_dying(st->cpu, !bringup);
+	if (cpu_dying(cpu) != !bringup)
+		set_cpu_dying(cpu, !bringup);
 
 	return prev_state;
 }
 
 static inline void
-cpuhp_reset_state(struct cpuhp_cpu_state *st, enum cpuhp_state prev_state)
+cpuhp_reset_state(int cpu, struct cpuhp_cpu_state *st,
+		  enum cpuhp_state prev_state)
 {
 	bool bringup = !st->bringup;
 
@@ -520,8 +520,8 @@ cpuhp_reset_state(struct cpuhp_cpu_state *st, enum cpuhp_state prev_state)
 	}
 
 	st->bringup = bringup;
-	if (cpu_dying(st->cpu) != !bringup)
-		set_cpu_dying(st->cpu, !bringup);
+	if (cpu_dying(cpu) != !bringup)
+		set_cpu_dying(cpu, !bringup);
 }
 
 /* Regular hotplug invocation of the AP hotplug thread */
@@ -541,15 +541,16 @@ static void __cpuhp_kick_ap(struct cpuhp_cpu_state *st)
 	wait_for_ap_thread(st, st->bringup);
 }
 
-static int cpuhp_kick_ap(struct cpuhp_cpu_state *st, enum cpuhp_state target)
+static int cpuhp_kick_ap(int cpu, struct cpuhp_cpu_state *st,
+			 enum cpuhp_state target)
 {
 	enum cpuhp_state prev_state;
 	int ret;
 
-	prev_state = cpuhp_set_state(st, target);
+	prev_state = cpuhp_set_state(cpu, st, target);
 	__cpuhp_kick_ap(st);
 	if ((ret = st->result)) {
-		cpuhp_reset_state(st, prev_state);
+		cpuhp_reset_state(cpu, st, prev_state);
 		__cpuhp_kick_ap(st);
 	}
 
@@ -581,7 +582,7 @@ static int bringup_wait_for_ap(unsigned int cpu)
 	if (st->target <= CPUHP_AP_ONLINE_IDLE)
 		return 0;
 
-	return cpuhp_kick_ap(st, st->target);
+	return cpuhp_kick_ap(cpu, st, st->target);
 }
 
 static int bringup_cpu(unsigned int cpu)
@@ -704,7 +705,7 @@ static int cpuhp_up_callbacks(unsigned int cpu, struct cpuhp_cpu_state *st,
 			 ret, cpu, cpuhp_get_step(st->state)->name,
 			 st->state);
 
-		cpuhp_reset_state(st, prev_state);
+		cpuhp_reset_state(cpu, st, prev_state);
 		if (can_rollback_cpu(st))
 			WARN_ON(cpuhp_invoke_callback_range(false, cpu, st,
 							    prev_state));
@@ -721,7 +722,6 @@ static void cpuhp_create(unsigned int cpu)
 
 	init_completion(&st->done_up);
 	init_completion(&st->done_down);
-	st->cpu = cpu;
 }
 
 static int cpuhp_should_run(unsigned int cpu)
@@ -875,7 +875,7 @@ static int cpuhp_kick_ap_work(unsigned int cpu)
 	cpuhp_lock_release(true);
 
 	trace_cpuhp_enter(cpu, st->target, prev_state, cpuhp_kick_ap_work);
-	ret = cpuhp_kick_ap(st, st->target);
+	ret = cpuhp_kick_ap(cpu, st, st->target);
 	trace_cpuhp_exit(cpu, st->state, prev_state, ret);
 
 	return ret;
@@ -1107,7 +1107,7 @@ static int cpuhp_down_callbacks(unsigned int cpu, struct cpuhp_cpu_state *st,
 			 ret, cpu, cpuhp_get_step(st->state)->name,
 			 st->state);
 
-		cpuhp_reset_state(st, prev_state);
+		cpuhp_reset_state(cpu, st, prev_state);
 
 		if (st->state < prev_state)
 			WARN_ON(cpuhp_invoke_callback_range(true, cpu, st,
@@ -1134,7 +1134,7 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
 
 	cpuhp_tasks_frozen = tasks_frozen;
 
-	prev_state = cpuhp_set_state(st, target);
+	prev_state = cpuhp_set_state(cpu, st, target);
 	/*
 	 * If the current CPU state is in the range of the AP hotplug thread,
 	 * then we need to kick the thread.
@@ -1165,7 +1165,7 @@ static int __ref _cpu_down(unsigned int cpu, int tasks_frozen,
 	ret = cpuhp_down_callbacks(cpu, st, target);
 	if (ret && st->state < prev_state) {
 		if (st->state == CPUHP_TEARDOWN_CPU) {
-			cpuhp_reset_state(st, prev_state);
+			cpuhp_reset_state(cpu, st, prev_state);
 			__cpuhp_kick_ap(st);
 		} else {
 			WARN(1, "DEAD callback error for CPU%d", cpu);
@@ -1352,7 +1352,7 @@ static int _cpu_up(unsigned int cpu, int tasks_frozen, enum cpuhp_state target)
 
 	cpuhp_tasks_frozen = tasks_frozen;
 
-	cpuhp_set_state(st, target);
+	cpuhp_set_state(cpu, st, target);
 	/*
 	 * If the current CPU state is in the range of the AP hotplug thread,
 	 * then we need to kick the thread once more.
