Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4AC9F31DA31
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Feb 2021 14:20:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232803AbhBQNTW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Feb 2021 08:19:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232893AbhBQNS4 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Feb 2021 08:18:56 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C53CBC061794;
        Wed, 17 Feb 2021 05:17:36 -0800 (PST)
Date:   Wed, 17 Feb 2021 13:17:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613567855;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mQH3pzUmuCM8YqWtcx+/HWZGGkXVhD1XXMTj/Zs6nrc=;
        b=IVg5xJFRWrkMeDEqSv784O1ItzHNBCKoRRmFDQY38EnUX62T9upFRpHwSJtyhCBpwbbia2
        F5MxsAh+bu9hNnceVXFMCt1WTaNvHKx9eSkpth37PgzSpdcP153jg/3RtbT0fD60Sr/OeU
        /pYiiY1Pqp6HBkq1zDJTaXh3X3pg0Bb6gM6C75y4/36AdtMiUxQDM0rxW0wFiDSrNqt8BH
        alR+pf1EiFGFO99fUjvG5muoU2l8SHV5XET1Zilb5LETZ+KfqiUNQZfd020NLOLX5raF2P
        csbTgYR/sXXRa/W9+EplwXbGvEwIIgDCzGY9p7B5b/0l7Ytyq4e1CkWaogm/Dw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613567855;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mQH3pzUmuCM8YqWtcx+/HWZGGkXVhD1XXMTj/Zs6nrc=;
        b=tCr2fJJm92MbIwJXYnwHAONP0afE0iV1wSsaX71vFDM5VL+GcURlt8Jm85MncAFB4am5Lu
        YQAQEcKw7oofA1Cw==
From:   "tip-bot2 for Peter Zijlstra (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] preempt/dynamic: Provide cond_resched() and
 might_resched() static calls
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210118141223.123667-6-frederic@kernel.org>
References: <20210118141223.123667-6-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <161356785481.20312.6418097474032725065.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     b965f1ddb47daa5b8b2e2bc9c921431236830367
Gitweb:        https://git.kernel.org/tip/b965f1ddb47daa5b8b2e2bc9c921431236830367
Author:        Peter Zijlstra (Intel) <peterz@infradead.org>
AuthorDate:    Mon, 18 Jan 2021 15:12:20 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Feb 2021 14:12:42 +01:00

preempt/dynamic: Provide cond_resched() and might_resched() static calls

Provide static calls to control cond_resched() (called in !CONFIG_PREEMPT)
and might_resched() (called in CONFIG_PREEMPT_VOLUNTARY) to that we
can override their behaviour when preempt= is overriden.

Since the default behaviour is full preemption, both their calls are
ignored when preempt= isn't passed.

  [fweisbec: branch might_resched() directly to __cond_resched(), only
             define static calls when PREEMPT_DYNAMIC]

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20210118141223.123667-6-frederic@kernel.org
---
 include/linux/kernel.h | 23 +++++++++++++++++++----
 include/linux/sched.h  | 27 ++++++++++++++++++++++++---
 kernel/sched/core.c    | 16 +++++++++++++---
 3 files changed, 56 insertions(+), 10 deletions(-)

diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index f7902d8..cfd3d34 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -15,7 +15,7 @@
 #include <linux/typecheck.h>
 #include <linux/printk.h>
 #include <linux/build_bug.h>
-
+#include <linux/static_call_types.h>
 #include <asm/byteorder.h>
 
 #include <uapi/linux/kernel.h>
@@ -81,11 +81,26 @@ struct pt_regs;
 struct user;
 
 #ifdef CONFIG_PREEMPT_VOLUNTARY
-extern int _cond_resched(void);
-# define might_resched() _cond_resched()
+
+extern int __cond_resched(void);
+# define might_resched() __cond_resched()
+
+#elif defined(CONFIG_PREEMPT_DYNAMIC)
+
+extern int __cond_resched(void);
+
+DECLARE_STATIC_CALL(might_resched, __cond_resched);
+
+static __always_inline void might_resched(void)
+{
+	static_call(might_resched)();
+}
+
 #else
+
 # define might_resched() do { } while (0)
-#endif
+
+#endif /* CONFIG_PREEMPT_* */
 
 #ifdef CONFIG_DEBUG_ATOMIC_SLEEP
 extern void ___might_sleep(const char *file, int line, int preempt_offset);
diff --git a/include/linux/sched.h b/include/linux/sched.h
index e115222..2f35594 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1871,11 +1871,32 @@ static inline int test_tsk_need_resched(struct task_struct *tsk)
  * value indicates whether a reschedule was done in fact.
  * cond_resched_lock() will drop the spinlock before scheduling,
  */
-#ifndef CONFIG_PREEMPTION
-extern int _cond_resched(void);
+#if !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC)
+extern int __cond_resched(void);
+
+#ifdef CONFIG_PREEMPT_DYNAMIC
+
+DECLARE_STATIC_CALL(cond_resched, __cond_resched);
+
+static __always_inline int _cond_resched(void)
+{
+	return static_call(cond_resched)();
+}
+
 #else
+
+static inline int _cond_resched(void)
+{
+	return __cond_resched();
+}
+
+#endif /* CONFIG_PREEMPT_DYNAMIC */
+
+#else
+
 static inline int _cond_resched(void) { return 0; }
-#endif
+
+#endif /* !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC) */
 
 #define cond_resched() ({			\
 	___might_sleep(__FILE__, __LINE__, 0);	\
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 4afbdd2..f7c8fd8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -6785,17 +6785,27 @@ SYSCALL_DEFINE0(sched_yield)
 	return 0;
 }
 
-#ifndef CONFIG_PREEMPTION
-int __sched _cond_resched(void)
+#if !defined(CONFIG_PREEMPTION) || defined(CONFIG_PREEMPT_DYNAMIC)
+int __sched __cond_resched(void)
 {
 	if (should_resched(0)) {
 		preempt_schedule_common();
 		return 1;
 	}
+#ifndef CONFIG_PREEMPT_RCU
 	rcu_all_qs();
+#endif
 	return 0;
 }
-EXPORT_SYMBOL(_cond_resched);
+EXPORT_SYMBOL(__cond_resched);
+#endif
+
+#ifdef CONFIG_PREEMPT_DYNAMIC
+DEFINE_STATIC_CALL_RET0(cond_resched, __cond_resched);
+EXPORT_STATIC_CALL(cond_resched);
+
+DEFINE_STATIC_CALL_RET0(might_resched, __cond_resched);
+EXPORT_STATIC_CALL(might_resched);
 #endif
 
 /*
