Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8B242D7FB
	for <lists+linux-tip-commits@lfdr.de>; Thu, 14 Oct 2021 13:16:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230447AbhJNLSb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 14 Oct 2021 07:18:31 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41842 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbhJNLS2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 14 Oct 2021 07:18:28 -0400
Date:   Thu, 14 Oct 2021 11:16:22 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634210183;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zH3seKDaWZaonrwoUsgAgpKAGBRA0J9C0WdC66iknEo=;
        b=LSNg8RADO54irUYU+J2WS2IT/0/nXFdxxA89J5iFHMJHYs1twoXjYeQvwhKAf5M0Z2Yuc/
        CEw8rh2wVGYUuWvNutq2YhYS07MKPqsz676W7G7bU0PC/+Va0dnleAEjkaH7VMokBeNF/+
        4n4WB3B0go46x18EHJnOuEoJiad9/YtlW/Q74Y53aEhJ0a9+SA7jgDDEhXA6EV26O2P83I
        3VroN3lOGiIwWYNyRvp3mIF+Ol7qZw8N/hwmnOuj1fvSq8vQU1k/3ga0QluoPsY4muD8Mq
        4/p4Y1p9ChT4siqvvImKiiHXtQVW/PnNdQXPhmnrUVuQYMR8mISZvOcEVP42lQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634210183;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zH3seKDaWZaonrwoUsgAgpKAGBRA0J9C0WdC66iknEo=;
        b=tIMnMANlAxPQET5wrw3ONC9REr9L5l553FRlSRC3ArMDEf126cUkSco0CkY2NUFGypHq7O
        EA/DdWA8CllgIKCA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched,livepatch: Use wake_up_if_idle()
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Petr Mladek <pmladek@suse.com>,
        Miroslav Benes <mbenes@suse.cz>,
        Vasily Gorbik <gor@linux.ibm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210929151723.162004989@infradead.org>
References: <20210929151723.162004989@infradead.org>
MIME-Version: 1.0
Message-ID: <163421018265.25758.5701287622030890933.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     5de62ea84abd732ded7c5569426fd71c0420f83e
Gitweb:        https://git.kernel.org/tip/5de62ea84abd732ded7c5569426fd71c0420f83e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 21 Sep 2021 22:16:02 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Thu, 14 Oct 2021 13:09:25 +02:00

sched,livepatch: Use wake_up_if_idle()

Make sure to prod idle CPUs so they call klp_update_patch_state().

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Acked-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Vasily Gorbik <gor@linux.ibm.com>
Tested-by: Petr Mladek <pmladek@suse.com>
Tested-by: Vasily Gorbik <gor@linux.ibm.com> # on s390
Link: https://lkml.kernel.org/r/20210929151723.162004989@infradead.org
---
 include/linux/sched/idle.h    | 4 ++++
 kernel/livepatch/transition.c | 5 ++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/include/linux/sched/idle.h b/include/linux/sched/idle.h
index 22873d2..d73d314 100644
--- a/include/linux/sched/idle.h
+++ b/include/linux/sched/idle.h
@@ -11,7 +11,11 @@ enum cpu_idle_type {
 	CPU_MAX_IDLE_TYPES
 };
 
+#ifdef CONFIG_SMP
 extern void wake_up_if_idle(int cpu);
+#else
+static inline void wake_up_if_idle(int cpu) { }
+#endif
 
 /*
  * Idle thread specific functions to determine the need_resched
diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index 75251e9..5683ac0 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -413,8 +413,11 @@ void klp_try_complete_transition(void)
 	for_each_possible_cpu(cpu) {
 		task = idle_task(cpu);
 		if (cpu_online(cpu)) {
-			if (!klp_try_switch_task(task))
+			if (!klp_try_switch_task(task)) {
 				complete = false;
+				/* Make idle task go through the main loop. */
+				wake_up_if_idle(cpu);
+			}
 		} else if (task->patch_state != klp_target_state) {
 			/* offline idle tasks can be switched immediately */
 			clear_tsk_thread_flag(task, TIF_PATCH_PENDING);
