Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEB737F87E
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 May 2021 15:17:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233914AbhEMNS5 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 13 May 2021 09:18:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58502 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233912AbhEMNSk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 13 May 2021 09:18:40 -0400
Date:   Thu, 13 May 2021 13:17:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620911848;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aQfNCQFLUNQVCobFxfW3SliZtfG5eXZJ+5/XNeXgtn4=;
        b=O9ggrOQeMjzTZjrQwP8J+ThmfMtSJwqWQbJMWgdkxqIEbX6a9tSQ2l6gZ6bXuDdIe4cRay
        XimMd8SMWjszHk6suwUzL+moH6XXdZ3JVP2aDwEOP49HbhVSRa/TOfE9wzcKIvy6/6aGSa
        nAjqZzfxoD/JHTYRbgoCNngJJ9xCcXIUHdpZ4UUcjQVBf1VbTB7k+xkPaY2Dk25OWFDlHE
        IkD9s4GsKN10Leg1/jLSTmHeP5yc+cJSAJzWRb6ZJAeNDJamb2IQIs9+p3tlX12sQ9jb2f
        8fprVlXH/kxFICkUwzfxDhLc+NgGVBwpua0cbibSvvxE2J01bYvPQq8/4SgXGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620911848;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aQfNCQFLUNQVCobFxfW3SliZtfG5eXZJ+5/XNeXgtn4=;
        b=4/fNz8A57nxZ9jmQDIqLZKoYclyyTian+cKtfQhTHwuH9Ew4qQ8z+BAhSGALTVwIYYtwW8
        AvId0snLF/2uUzCA==
From:   "tip-bot2 for Marcelo Tosatti" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/nohz] tick/nohz: Change signal tick dependency to wake
 up CPUs of member tasks
Cc:     Marcelo Tosatti <mtosatti@redhat.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210512232924.150322-8-frederic@kernel.org>
References: <20210512232924.150322-8-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <162091184733.29796.351230001844921759.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/nohz branch of tip:

Commit-ID:     1e4ca26d367ae71743e25068e5cd8750ef3f5f7d
Gitweb:        https://git.kernel.org/tip/1e4ca26d367ae71743e25068e5cd8750ef3f5f7d
Author:        Marcelo Tosatti <mtosatti@redhat.com>
AuthorDate:    Thu, 13 May 2021 01:29:21 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Thu, 13 May 2021 14:21:22 +02:00

tick/nohz: Change signal tick dependency to wake up CPUs of member tasks

Rather than waking up all nohz_full CPUs on the system, only wake up
the target CPUs of member threads of the signal.

Reduces interruptions to nohz_full CPUs.

Signed-off-by: Marcelo Tosatti <mtosatti@redhat.com>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Acked-by: Peter Zijlstra <peterz@infradead.org>
Link: https://lore.kernel.org/r/20210512232924.150322-8-frederic@kernel.org
---
 include/linux/tick.h           |  8 ++++----
 kernel/time/posix-cpu-timers.c |  4 ++--
 kernel/time/tick-sched.c       | 15 +++++++++++++--
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/include/linux/tick.h b/include/linux/tick.h
index 2258984..0bb80a7 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -211,7 +211,7 @@ extern void tick_nohz_dep_set_task(struct task_struct *tsk,
 				   enum tick_dep_bits bit);
 extern void tick_nohz_dep_clear_task(struct task_struct *tsk,
 				     enum tick_dep_bits bit);
-extern void tick_nohz_dep_set_signal(struct signal_struct *signal,
+extern void tick_nohz_dep_set_signal(struct task_struct *tsk,
 				     enum tick_dep_bits bit);
 extern void tick_nohz_dep_clear_signal(struct signal_struct *signal,
 				       enum tick_dep_bits bit);
@@ -256,11 +256,11 @@ static inline void tick_dep_clear_task(struct task_struct *tsk,
 	if (tick_nohz_full_enabled())
 		tick_nohz_dep_clear_task(tsk, bit);
 }
-static inline void tick_dep_set_signal(struct signal_struct *signal,
+static inline void tick_dep_set_signal(struct task_struct *tsk,
 				       enum tick_dep_bits bit)
 {
 	if (tick_nohz_full_enabled())
-		tick_nohz_dep_set_signal(signal, bit);
+		tick_nohz_dep_set_signal(tsk, bit);
 }
 static inline void tick_dep_clear_signal(struct signal_struct *signal,
 					 enum tick_dep_bits bit)
@@ -288,7 +288,7 @@ static inline void tick_dep_set_task(struct task_struct *tsk,
 				     enum tick_dep_bits bit) { }
 static inline void tick_dep_clear_task(struct task_struct *tsk,
 				       enum tick_dep_bits bit) { }
-static inline void tick_dep_set_signal(struct signal_struct *signal,
+static inline void tick_dep_set_signal(struct task_struct *tsk,
 				       enum tick_dep_bits bit) { }
 static inline void tick_dep_clear_signal(struct signal_struct *signal,
 					 enum tick_dep_bits bit) { }
diff --git a/kernel/time/posix-cpu-timers.c b/kernel/time/posix-cpu-timers.c
index 3bb96a8..29a5e54 100644
--- a/kernel/time/posix-cpu-timers.c
+++ b/kernel/time/posix-cpu-timers.c
@@ -523,7 +523,7 @@ static void arm_timer(struct k_itimer *timer, struct task_struct *p)
 	if (CPUCLOCK_PERTHREAD(timer->it_clock))
 		tick_dep_set_task(p, TICK_DEP_BIT_POSIX_TIMER);
 	else
-		tick_dep_set_signal(p->signal, TICK_DEP_BIT_POSIX_TIMER);
+		tick_dep_set_signal(p, TICK_DEP_BIT_POSIX_TIMER);
 }
 
 /*
@@ -1358,7 +1358,7 @@ void set_process_cpu_timer(struct task_struct *tsk, unsigned int clkid,
 	if (*newval < *nextevt)
 		*nextevt = *newval;
 
-	tick_dep_set_signal(tsk->signal, TICK_DEP_BIT_POSIX_TIMER);
+	tick_dep_set_signal(tsk, TICK_DEP_BIT_POSIX_TIMER);
 }
 
 static int do_cpu_nanosleep(const clockid_t which_clock, int flags,
diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
index b90ca66..acbe672 100644
--- a/kernel/time/tick-sched.c
+++ b/kernel/time/tick-sched.c
@@ -444,9 +444,20 @@ EXPORT_SYMBOL_GPL(tick_nohz_dep_clear_task);
  * Set a per-taskgroup tick dependency. Posix CPU timers need this in order to elapse
  * per process timers.
  */
-void tick_nohz_dep_set_signal(struct signal_struct *sig, enum tick_dep_bits bit)
+void tick_nohz_dep_set_signal(struct task_struct *tsk,
+			      enum tick_dep_bits bit)
 {
-	tick_nohz_dep_set_all(&sig->tick_dep_mask, bit);
+	int prev;
+	struct signal_struct *sig = tsk->signal;
+
+	prev = atomic_fetch_or(BIT(bit), &sig->tick_dep_mask);
+	if (!prev) {
+		struct task_struct *t;
+
+		lockdep_assert_held(&tsk->sighand->siglock);
+		__for_each_thread(sig, t)
+			tick_nohz_kick_task(t);
+	}
 }
 
 void tick_nohz_dep_clear_signal(struct signal_struct *sig, enum tick_dep_bits bit)
