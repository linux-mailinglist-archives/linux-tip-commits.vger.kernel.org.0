Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31A0845C70D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 24 Nov 2021 15:17:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351293AbhKXOVH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 24 Nov 2021 09:21:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353396AbhKXOSv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 24 Nov 2021 09:18:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 878AEC09DADF;
        Wed, 24 Nov 2021 04:30:57 -0800 (PST)
Date:   Wed, 24 Nov 2021 12:30:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637757056;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SmJkv/73K7AIfKmQv+NqpEF7xbC8bJ5CMN8mL52NsPs=;
        b=GXSFt9L+tB4IsTpDEagl1pSJeDmulxKwlBnpXlZS7sOwDZvT8KsrxQSU2NHGAhaVCa1CgK
        4K4zSO/9NX1dxDbKP898NLYY8u+BxPVDJoU/B25WNfgLT0eQwGdi6hfM0wvIUc0BrGbBMs
        cz8SymN8HipMimbQsCJFO8uQN/LHuzAs/CskuAEhIyZGQpLaLHkJuZ40zsLpR0s0XYoXPT
        cjg3dK5235nS7BvELPTHe66wLv2iWe1IUwDpcapW6PKdDFqX/Z2zO4VLVJc3X6La5ezABL
        o4XuVRI81SXN85gkH4XKnRW9GHlLm1YZaZ86lyz6cMITAcOEecrhjpXyQxUrSQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637757056;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=SmJkv/73K7AIfKmQv+NqpEF7xbC8bJ5CMN8mL52NsPs=;
        b=unk0yRg5yE8zrkqtsLyda0Z2djMcRgz1SWQvF3U5HCMpf/YHnPGQ+rsHnsU/dIQyJUUV/S
        M1nTzLaOz9ZS5vCw==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/scs: Reset task stack state in bringup_cpu()
Cc:     Qian Cai <quic_qiancai@quicinc.com>,
        Mark Rutland <mark.rutland@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        x86@kernel.org, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <163775705481.11128.5927783579382442225.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     dce1ca0525bfdc8a69a9343bc714fbc19a2f04b3
Gitweb:        https://git.kernel.org/tip/dce1ca0525bfdc8a69a9343bc714fbc19a2f04b3
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Tue, 23 Nov 2021 11:40:47 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 24 Nov 2021 12:20:27 +01:00

sched/scs: Reset task stack state in bringup_cpu()

To hot unplug a CPU, the idle task on that CPU calls a few layers of C
code before finally leaving the kernel. When KASAN is in use, poisoned
shadow is left around for each of the active stack frames, and when
shadow call stacks are in use. When shadow call stacks (SCS) are in use
the task's saved SCS SP is left pointing at an arbitrary point within
the task's shadow call stack.

When a CPU is offlined than onlined back into the kernel, this stale
state can adversely affect execution. Stale KASAN shadow can alias new
stackframes and result in bogus KASAN warnings. A stale SCS SP is
effectively a memory leak, and prevents a portion of the shadow call
stack being used. Across a number of hotplug cycles the idle task's
entire shadow call stack can become unusable.

We previously fixed the KASAN issue in commit:

  e1b77c92981a5222 ("sched/kasan: remove stale KASAN poison after hotplug")

... by removing any stale KASAN stack poison immediately prior to
onlining a CPU.

Subsequently in commit:

  f1a0a376ca0c4ef1 ("sched/core: Initialize the idle task with preemption disabled")

... the refactoring left the KASAN and SCS cleanup in one-time idle
thread initialization code rather than something invoked prior to each
CPU being onlined, breaking both as above.

We fixed SCS (but not KASAN) in commit:

  63acd42c0d4942f7 ("sched/scs: Reset the shadow stack when idle_task_exit")

... but as this runs in the context of the idle task being offlined it's
potentially fragile.

To fix these consistently and more robustly, reset the SCS SP and KASAN
shadow of a CPU's idle task immediately before we online that CPU in
bringup_cpu(). This ensures the idle task always has a consistent state
when it is running, and removes the need to so so when exiting an idle
task.

Whenever any thread is created, dup_task_struct() will give the task a
stack which is free of KASAN shadow, and initialize the task's SCS SP,
so there's no need to specially initialize either for idle thread within
init_idle(), as this was only necessary to handle hotplug cycles.

I've tested this on arm64 with:

* gcc 11.1.0, defconfig +KASAN_INLINE, KASAN_STACK
* clang 12.0.0, defconfig +KASAN_INLINE, KASAN_STACK, SHADOW_CALL_STACK

... offlining and onlining CPUS with:

| while true; do
|   for C in /sys/devices/system/cpu/cpu*/online; do
|     echo 0 > $C;
|     echo 1 > $C;
|   done
| done

Fixes: f1a0a376ca0c4ef1 ("sched/core: Initialize the idle task with preemption disabled")
Reported-by: Qian Cai <quic_qiancai@quicinc.com>
Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Qian Cai <quic_qiancai@quicinc.com>
Link: https://lore.kernel.org/lkml/20211115113310.35693-1-mark.rutland@arm.com/
---
 kernel/cpu.c        | 7 +++++++
 kernel/sched/core.c | 4 ----
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/kernel/cpu.c b/kernel/cpu.c
index 192e43a..407a256 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -31,6 +31,7 @@
 #include <linux/smpboot.h>
 #include <linux/relay.h>
 #include <linux/slab.h>
+#include <linux/scs.h>
 #include <linux/percpu-rwsem.h>
 #include <linux/cpuset.h>
 
@@ -588,6 +589,12 @@ static int bringup_cpu(unsigned int cpu)
 	int ret;
 
 	/*
+	 * Reset stale stack state from the last time this CPU was online.
+	 */
+	scs_task_reset(idle);
+	kasan_unpoison_task_stack(idle);
+
+	/*
 	 * Some architectures have to walk the irq descriptors to
 	 * setup the vector space for the cpu which comes online.
 	 * Prevent irq alloc/free across the bringup.
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 3c9b0fd..76f9dee 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -8619,9 +8619,6 @@ void __init init_idle(struct task_struct *idle, int cpu)
 	idle->flags |= PF_IDLE | PF_KTHREAD | PF_NO_SETAFFINITY;
 	kthread_set_per_cpu(idle, cpu);
 
-	scs_task_reset(idle);
-	kasan_unpoison_task_stack(idle);
-
 #ifdef CONFIG_SMP
 	/*
 	 * It's possible that init_idle() gets called multiple times on a task,
@@ -8777,7 +8774,6 @@ void idle_task_exit(void)
 		finish_arch_post_lock_switch();
 	}
 
-	scs_task_reset(current);
 	/* finish_cpu(), as ran on the BP, will clean up the active_mm state */
 }
 
