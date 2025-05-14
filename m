Return-Path: <linux-tip-commits+bounces-5541-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B8F0AB69D8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 May 2025 13:28:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67C9E1B623C2
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 May 2025 11:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3696F2797AB;
	Wed, 14 May 2025 11:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="osmreAO0";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="yHt0XU60"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10205270EDD;
	Wed, 14 May 2025 11:26:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747222007; cv=none; b=dvbiN5W8FijopgRhgxnCH4JRBxxvtnwRjzK12PGgIRqybRSU3ev/1LMa48WXQ9LFNawgW2Byg8dmsuwLiUAXFg+m4KytAglVKFFXZ5OcELmOkXxWXfAD+OHCfaqbMzR4m7pYZh4v9XVrsL1uw7QQln6pY5NwTQhvCjHI8pC9lTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747222007; c=relaxed/simple;
	bh=Dmdzq1HqHXFlGeScLcvyy5MJykYpW5jdCrDxBib4pnw=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=S41sHsamm+SuG4hVJ/3WF5uHXE4fP30vOy5dCHiX1KwFfBpSuhTEz53bM6G1WOMEXzxRi2FeV26xrIpBivAx3REHoV0M3pwQCZQpx/TFr/iFzuxSHnpF1TJq/xZGYT+tslJUxzQUA0NFoJsajOfyNIjPaIMb5pgJqueP9E3msLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=osmreAO0; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=yHt0XU60; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 May 2025 11:26:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1747222003;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r4MmoorwssmZnnFVueAQ9JshEtVxtY1NBr4ukutp5m4=;
	b=osmreAO0DZNGqhkXZGr9UMKMn2JYRagkNpxIEJyJYuEEldLyGMHA9gOk3Z5PVBRcMT0tER
	aw4S1meVt0Rcypus2ouYoEU2+z69YKjREzQCPtXUXMcO5oqSv6Y+83u172sp3R4EkwMv6U
	Az7QJeEMKVDUa9d5Kh7GzSH0VOejCvX2mngeFmrBISy4KvMadIxrzS9yMVNU741cKaXIMt
	Tq2PZ64DuLhPay+v+OiVvd68YjUvr93yyZ36FyBjfSTsKZb0gY/9R+hap2xNCgp1c8Srzd
	Hw5L/HIkRsHjyGbLG7YreH+VLh4OIIn/V1oglPnYohizoblTZyWw4f+dOT3cvg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1747222003;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=r4MmoorwssmZnnFVueAQ9JshEtVxtY1NBr4ukutp5m4=;
	b=yHt0XU6093AyjKDo6KXKxsd/KmyaUMhjspQpH5j8zeQDbtw2Gitnn16hAWkP0Kr3HzuERW
	DcpTkf5PEq57NkDQ==
From: "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: sched/core] sched,livepatch: Untangle cond_resched() and live-patching
Cc: "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Thomas Gleixner <tglx@linutronix.de>, Petr Mladek <pmladek@suse.com>,
 Miroslav Benes <mbenes@suse.cz>, Josh Poimboeuf <jpoimboe@kernel.org>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250509113659.wkP_HJ5z@linutronix.de>
References: <20250509113659.wkP_HJ5z@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174722200203.406.16353479744714543012.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     676e8cf70cb0533e1118e29898c9a9c33ae3a10f
Gitweb:        https://git.kernel.org/tip/676e8cf70cb0533e1118e29898c9a9c33ae3a10f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Fri, 09 May 2025 13:36:59 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 14 May 2025 13:16:24 +02:00

sched,livepatch: Untangle cond_resched() and live-patching

With the goal of deprecating / removing VOLUNTARY preempt, live-patch
needs to stop relying on cond_resched() to make forward progress.

Instead, rely on schedule() with TASK_FREEZABLE set. Just like
live-patching, the freezer needs to be able to stop tasks in a safe /
known state.

[bigeasy: use likely() in __klp_sched_try_switch() and update comments]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Petr Mladek <pmladek@suse.com>
Tested-by: Petr Mladek <pmladek@suse.com>
Tested-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Miroslav Benes <mbenes@suse.cz>
Acked-by: Josh Poimboeuf <jpoimboe@kernel.org>
Link: https://lore.kernel.org/r/20250509113659.wkP_HJ5z@linutronix.de
---
 include/linux/livepatch_sched.h | 14 +++------
 include/linux/sched.h           |  6 +----
 kernel/livepatch/transition.c   | 49 ++++++++-----------------------
 kernel/sched/core.c             | 50 +++++---------------------------
 4 files changed, 27 insertions(+), 92 deletions(-)

diff --git a/include/linux/livepatch_sched.h b/include/linux/livepatch_sched.h
index 013794f..065c185 100644
--- a/include/linux/livepatch_sched.h
+++ b/include/linux/livepatch_sched.h
@@ -3,27 +3,23 @@
 #define _LINUX_LIVEPATCH_SCHED_H_
 
 #include <linux/jump_label.h>
-#include <linux/static_call_types.h>
+#include <linux/sched.h>
 
 #ifdef CONFIG_LIVEPATCH
 
 void __klp_sched_try_switch(void);
 
-#if !defined(CONFIG_PREEMPT_DYNAMIC) || !defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
-
 DECLARE_STATIC_KEY_FALSE(klp_sched_try_switch_key);
 
-static __always_inline void klp_sched_try_switch(void)
+static __always_inline void klp_sched_try_switch(struct task_struct *curr)
 {
-	if (static_branch_unlikely(&klp_sched_try_switch_key))
+	if (static_branch_unlikely(&klp_sched_try_switch_key) &&
+	    READ_ONCE(curr->__state) & TASK_FREEZABLE)
 		__klp_sched_try_switch();
 }
 
-#endif /* !CONFIG_PREEMPT_DYNAMIC || !CONFIG_HAVE_PREEMPT_DYNAMIC_CALL */
-
 #else /* !CONFIG_LIVEPATCH */
-static inline void klp_sched_try_switch(void) {}
-static inline void __klp_sched_try_switch(void) {}
+static inline void klp_sched_try_switch(struct task_struct *curr) {}
 #endif /* CONFIG_LIVEPATCH */
 
 #endif /* _LINUX_LIVEPATCH_SCHED_H_ */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index f96ac19..b981959 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -44,7 +44,6 @@
 #include <linux/seqlock_types.h>
 #include <linux/kcsan.h>
 #include <linux/rv.h>
-#include <linux/livepatch_sched.h>
 #include <linux/uidgid_types.h>
 #include <linux/tracepoint-defs.h>
 #include <asm/kmap_size.h>
@@ -2089,9 +2088,6 @@ extern int __cond_resched(void);
 
 #if defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
 
-void sched_dynamic_klp_enable(void);
-void sched_dynamic_klp_disable(void);
-
 DECLARE_STATIC_CALL(cond_resched, __cond_resched);
 
 static __always_inline int _cond_resched(void)
@@ -2112,7 +2108,6 @@ static __always_inline int _cond_resched(void)
 
 static inline int _cond_resched(void)
 {
-	klp_sched_try_switch();
 	return __cond_resched();
 }
 
@@ -2122,7 +2117,6 @@ static inline int _cond_resched(void)
 
 static inline int _cond_resched(void)
 {
-	klp_sched_try_switch();
 	return 0;
 }
 
diff --git a/kernel/livepatch/transition.c b/kernel/livepatch/transition.c
index ba06945..2351a19 100644
--- a/kernel/livepatch/transition.c
+++ b/kernel/livepatch/transition.c
@@ -29,22 +29,13 @@ static unsigned int klp_signals_cnt;
 
 /*
  * When a livepatch is in progress, enable klp stack checking in
- * cond_resched().  This helps CPU-bound kthreads get patched.
+ * schedule().  This helps CPU-bound kthreads get patched.
  */
-#if defined(CONFIG_PREEMPT_DYNAMIC) && defined(CONFIG_HAVE_PREEMPT_DYNAMIC_CALL)
-
-#define klp_cond_resched_enable() sched_dynamic_klp_enable()
-#define klp_cond_resched_disable() sched_dynamic_klp_disable()
-
-#else /* !CONFIG_PREEMPT_DYNAMIC || !CONFIG_HAVE_PREEMPT_DYNAMIC_CALL */
 
 DEFINE_STATIC_KEY_FALSE(klp_sched_try_switch_key);
-EXPORT_SYMBOL(klp_sched_try_switch_key);
 
-#define klp_cond_resched_enable() static_branch_enable(&klp_sched_try_switch_key)
-#define klp_cond_resched_disable() static_branch_disable(&klp_sched_try_switch_key)
-
-#endif /* CONFIG_PREEMPT_DYNAMIC && CONFIG_HAVE_PREEMPT_DYNAMIC_CALL */
+#define klp_resched_enable() static_branch_enable(&klp_sched_try_switch_key)
+#define klp_resched_disable() static_branch_disable(&klp_sched_try_switch_key)
 
 /*
  * This work can be performed periodically to finish patching or unpatching any
@@ -365,26 +356,18 @@ static bool klp_try_switch_task(struct task_struct *task)
 
 void __klp_sched_try_switch(void)
 {
-	if (likely(!klp_patch_pending(current)))
-		return;
-
 	/*
-	 * This function is called from cond_resched() which is called in many
-	 * places throughout the kernel.  Using the klp_mutex here might
-	 * deadlock.
-	 *
-	 * Instead, disable preemption to prevent racing with other callers of
-	 * klp_try_switch_task().  Thanks to task_call_func() they won't be
-	 * able to switch this task while it's running.
+	 * This function is called from __schedule() while a context switch is
+	 * about to happen. Preemption is already disabled and klp_mutex
+	 * can't be acquired.
+	 * Disabled preemption is used to prevent racing with other callers of
+	 * klp_try_switch_task(). Thanks to task_call_func() they won't be
+	 * able to switch to this task while it's running.
 	 */
-	preempt_disable();
+	lockdep_assert_preemption_disabled();
 
-	/*
-	 * Make sure current didn't get patched between the above check and
-	 * preempt_disable().
-	 */
-	if (unlikely(!klp_patch_pending(current)))
-		goto out;
+	if (likely(!klp_patch_pending(current)))
+		return;
 
 	/*
 	 * Enforce the order of the TIF_PATCH_PENDING read above and the
@@ -395,11 +378,7 @@ void __klp_sched_try_switch(void)
 	smp_rmb();
 
 	klp_try_switch_task(current);
-
-out:
-	preempt_enable();
 }
-EXPORT_SYMBOL(__klp_sched_try_switch);
 
 /*
  * Sends a fake signal to all non-kthread tasks with TIF_PATCH_PENDING set.
@@ -508,7 +487,7 @@ void klp_try_complete_transition(void)
 	}
 
 	/* Done!  Now cleanup the data structures. */
-	klp_cond_resched_disable();
+	klp_resched_disable();
 	patch = klp_transition_patch;
 	klp_complete_transition();
 
@@ -560,7 +539,7 @@ void klp_start_transition(void)
 			set_tsk_thread_flag(task, TIF_PATCH_PENDING);
 	}
 
-	klp_cond_resched_enable();
+	klp_resched_enable();
 
 	klp_signals_cnt = 0;
 }
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index a3507ed..bece0ba 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -66,6 +66,7 @@
 #include <linux/vtime.h>
 #include <linux/wait_api.h>
 #include <linux/workqueue_api.h>
+#include <linux/livepatch_sched.h>
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 # ifdef CONFIG_GENERIC_ENTRY
@@ -6676,6 +6677,8 @@ static void __sched notrace __schedule(int sched_mode)
 	if (sched_feat(HRTICK) || sched_feat(HRTICK_DL))
 		hrtick_clear(rq);
 
+	klp_sched_try_switch(prev);
+
 	local_irq_disable();
 	rcu_note_context_switch(preempt);
 
@@ -7336,7 +7339,6 @@ EXPORT_STATIC_CALL_TRAMP(might_resched);
 static DEFINE_STATIC_KEY_FALSE(sk_dynamic_cond_resched);
 int __sched dynamic_cond_resched(void)
 {
-	klp_sched_try_switch();
 	if (!static_branch_unlikely(&sk_dynamic_cond_resched))
 		return 0;
 	return __cond_resched();
@@ -7508,7 +7510,6 @@ int sched_dynamic_mode(const char *str)
 #endif
 
 static DEFINE_MUTEX(sched_dynamic_mutex);
-static bool klp_override;
 
 static void __sched_dynamic_update(int mode)
 {
@@ -7516,8 +7517,7 @@ static void __sched_dynamic_update(int mode)
 	 * Avoid {NONE,VOLUNTARY} -> FULL transitions from ever ending up in
 	 * the ZERO state, which is invalid.
 	 */
-	if (!klp_override)
-		preempt_dynamic_enable(cond_resched);
+	preempt_dynamic_enable(cond_resched);
 	preempt_dynamic_enable(might_resched);
 	preempt_dynamic_enable(preempt_schedule);
 	preempt_dynamic_enable(preempt_schedule_notrace);
@@ -7526,8 +7526,7 @@ static void __sched_dynamic_update(int mode)
 
 	switch (mode) {
 	case preempt_dynamic_none:
-		if (!klp_override)
-			preempt_dynamic_enable(cond_resched);
+		preempt_dynamic_enable(cond_resched);
 		preempt_dynamic_disable(might_resched);
 		preempt_dynamic_disable(preempt_schedule);
 		preempt_dynamic_disable(preempt_schedule_notrace);
@@ -7538,8 +7537,7 @@ static void __sched_dynamic_update(int mode)
 		break;
 
 	case preempt_dynamic_voluntary:
-		if (!klp_override)
-			preempt_dynamic_enable(cond_resched);
+		preempt_dynamic_enable(cond_resched);
 		preempt_dynamic_enable(might_resched);
 		preempt_dynamic_disable(preempt_schedule);
 		preempt_dynamic_disable(preempt_schedule_notrace);
@@ -7550,8 +7548,7 @@ static void __sched_dynamic_update(int mode)
 		break;
 
 	case preempt_dynamic_full:
-		if (!klp_override)
-			preempt_dynamic_disable(cond_resched);
+		preempt_dynamic_disable(cond_resched);
 		preempt_dynamic_disable(might_resched);
 		preempt_dynamic_enable(preempt_schedule);
 		preempt_dynamic_enable(preempt_schedule_notrace);
@@ -7562,8 +7559,7 @@ static void __sched_dynamic_update(int mode)
 		break;
 
 	case preempt_dynamic_lazy:
-		if (!klp_override)
-			preempt_dynamic_disable(cond_resched);
+		preempt_dynamic_disable(cond_resched);
 		preempt_dynamic_disable(might_resched);
 		preempt_dynamic_enable(preempt_schedule);
 		preempt_dynamic_enable(preempt_schedule_notrace);
@@ -7584,36 +7580,6 @@ void sched_dynamic_update(int mode)
 	mutex_unlock(&sched_dynamic_mutex);
 }
 
-#ifdef CONFIG_HAVE_PREEMPT_DYNAMIC_CALL
-
-static int klp_cond_resched(void)
-{
-	__klp_sched_try_switch();
-	return __cond_resched();
-}
-
-void sched_dynamic_klp_enable(void)
-{
-	mutex_lock(&sched_dynamic_mutex);
-
-	klp_override = true;
-	static_call_update(cond_resched, klp_cond_resched);
-
-	mutex_unlock(&sched_dynamic_mutex);
-}
-
-void sched_dynamic_klp_disable(void)
-{
-	mutex_lock(&sched_dynamic_mutex);
-
-	klp_override = false;
-	__sched_dynamic_update(preempt_dynamic_mode);
-
-	mutex_unlock(&sched_dynamic_mutex);
-}
-
-#endif /* CONFIG_HAVE_PREEMPT_DYNAMIC_CALL */
-
 static int __init setup_preempt_mode(char *str)
 {
 	int mode = sched_dynamic_mode(str);

