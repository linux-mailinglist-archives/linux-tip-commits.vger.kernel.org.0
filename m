Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 031C1359D5A
	for <lists+linux-tip-commits@lfdr.de>; Fri,  9 Apr 2021 13:30:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231402AbhDILar (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 9 Apr 2021 07:30:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232087AbhDILaq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 9 Apr 2021 07:30:46 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFB07C061760;
        Fri,  9 Apr 2021 04:30:33 -0700 (PDT)
Date:   Fri, 09 Apr 2021 11:30:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617967831;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Km7DiN2FPvX3T9yR0beKC7ca7dahwW7kRvrJji7fck8=;
        b=0DfX++Sx5LdcS/BaxXC73uqQItd9fLAXa18fcFpwOvzTGY746+jvcUP4P7+70nJ77L+tEr
        fyL5hk/pt4HDaoW7mCJCr7g+8JoLz8kWZcdkLA7Ond6GAoaBN+TG7JZ0w7+aGeritbvMBM
        9CIWcNPqTahwHAnKczDYtQC3dThVVLgkmhmEQ4afVAD4fEVniIyLkdtvu9TzJJjusyCJCg
        D+2p6LVYjhxZa+LDT14sjlYISw+jzO/aD+AL8+tZXvKQt+8M9+16pZPzreIeSI9U2rYsTF
        dj/ds7M/zIAC9kYE3qRbtdHV/UL7rxD4eRV80Q+40WUZVBGWQhFY3JKsvcQmKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617967831;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Km7DiN2FPvX3T9yR0beKC7ca7dahwW7kRvrJji7fck8=;
        b=DmH7xFUcepLJJq3jHreMmYwKkz/JvvasO9VGvTNdJ7/76SgYFpm4Su2DBvN1B5BIOs1j9X
        +uk4cUwOD8HVsJCw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] static_call: Relax static_call_update() function
 argument type
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YFoN7nCl8OfGtpeh@hirez.programming.kicks-ass.net>
References: <YFoN7nCl8OfGtpeh@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <161796783069.29796.12129990523788339245.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     9432bbd969c667fc9c4b1c140c5a745ff2a7b540
Gitweb:        https://git.kernel.org/tip/9432bbd969c667fc9c4b1c140c5a745ff2a7b540
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 23 Mar 2021 16:49:03 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 09 Apr 2021 13:22:12 +02:00

static_call: Relax static_call_update() function argument type

static_call_update() had stronger type requirements than regular C,
relax them to match. Instead of requiring the @func argument has the
exact matching type, allow any type which C is willing to promote to the
right (function) pointer type. Specifically this allows (void *)
arguments.

This cleans up a bunch of static_call_update() callers for
PREEMPT_DYNAMIC and should get around silly GCC11 warnings for free.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/YFoN7nCl8OfGtpeh@hirez.programming.kicks-ass.net
---
 include/linux/static_call.h |  4 ++--
 kernel/sched/core.c         | 18 +++++++++---------
 2 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/include/linux/static_call.h b/include/linux/static_call.h
index 85ecc78..8d50f62 100644
--- a/include/linux/static_call.h
+++ b/include/linux/static_call.h
@@ -113,9 +113,9 @@ extern void arch_static_call_transform(void *site, void *tramp, void *func, bool
 
 #define static_call_update(name, func)					\
 ({									\
-	BUILD_BUG_ON(!__same_type(*(func), STATIC_CALL_TRAMP(name)));	\
+	typeof(&STATIC_CALL_TRAMP(name)) __F = (func);			\
 	__static_call_update(&STATIC_CALL_KEY(name),			\
-			     STATIC_CALL_TRAMP_ADDR(name), func);	\
+			     STATIC_CALL_TRAMP_ADDR(name), __F);	\
 })
 
 #ifdef CONFIG_HAVE_STATIC_CALL_INLINE
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 9819121..67f9890 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5396,25 +5396,25 @@ static void sched_dynamic_update(int mode)
 	switch (mode) {
 	case preempt_dynamic_none:
 		static_call_update(cond_resched, __cond_resched);
-		static_call_update(might_resched, (typeof(&__cond_resched)) __static_call_return0);
-		static_call_update(preempt_schedule, (typeof(&preempt_schedule)) NULL);
-		static_call_update(preempt_schedule_notrace, (typeof(&preempt_schedule_notrace)) NULL);
-		static_call_update(irqentry_exit_cond_resched, (typeof(&irqentry_exit_cond_resched)) NULL);
+		static_call_update(might_resched, (void *)&__static_call_return0);
+		static_call_update(preempt_schedule, NULL);
+		static_call_update(preempt_schedule_notrace, NULL);
+		static_call_update(irqentry_exit_cond_resched, NULL);
 		pr_info("Dynamic Preempt: none\n");
 		break;
 
 	case preempt_dynamic_voluntary:
 		static_call_update(cond_resched, __cond_resched);
 		static_call_update(might_resched, __cond_resched);
-		static_call_update(preempt_schedule, (typeof(&preempt_schedule)) NULL);
-		static_call_update(preempt_schedule_notrace, (typeof(&preempt_schedule_notrace)) NULL);
-		static_call_update(irqentry_exit_cond_resched, (typeof(&irqentry_exit_cond_resched)) NULL);
+		static_call_update(preempt_schedule, NULL);
+		static_call_update(preempt_schedule_notrace, NULL);
+		static_call_update(irqentry_exit_cond_resched, NULL);
 		pr_info("Dynamic Preempt: voluntary\n");
 		break;
 
 	case preempt_dynamic_full:
-		static_call_update(cond_resched, (typeof(&__cond_resched)) __static_call_return0);
-		static_call_update(might_resched, (typeof(&__cond_resched)) __static_call_return0);
+		static_call_update(cond_resched, (void *)&__static_call_return0);
+		static_call_update(might_resched, (void *)&__static_call_return0);
 		static_call_update(preempt_schedule, __preempt_schedule_func);
 		static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
 		static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
