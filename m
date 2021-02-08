Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE5C3131BC
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Feb 2021 13:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbhBHMEY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 8 Feb 2021 07:04:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39106 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233526AbhBHMBV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 8 Feb 2021 07:01:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2866BC061786;
        Mon,  8 Feb 2021 04:00:41 -0800 (PST)
Date:   Mon, 08 Feb 2021 12:00:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612785639;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rSONLyQItreTpHUxhkWNqYbLWLJ8bVl2PLSrb68pai8=;
        b=tM6A5jl0cC0guVX3K4sb7LQADLM/Ig+FP6Eg9F2hQULJpHw71yb9L9yqu8yn30hVjdx/9B
        BmdohOh0K6FHWBhdZh7TR4thKp/wn6BOPoOkVQW06UB1TE+I5M8h/Czt+drEzx0GtWwM1R
        tXloyrJsBEySMImbv/oVNbjZiGXNAjc5QNkrV1+Q2Tg3oC13DKO//6XOvPEi9sYC5LxKXc
        z6ejKGxWwLvavS6bn4rLzP/PNwQnGXJ+DWUoxAzy1aHxLEDYrFu6HARcPbF9rzPADGUHR2
        2uQJ0d/2kcj9WKzVlFOch9b9r8TCA2YMcfC3YQGiPr9NmVC6D+XKDHTaEKNw1w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612785639;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rSONLyQItreTpHUxhkWNqYbLWLJ8bVl2PLSrb68pai8=;
        b=siINJS1T6LSY9Zf9NHbYbb5XIoEX6vIkq3A2znc+cWlt4+KBdU1a74C83RIcq8IjUokQlx
        +8qTkKswnPobVcDw==
From:   "tip-bot2 for Peter Zijlstra (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] preempt/dynamic: Provide
 irqentry_exit_cond_resched() static call
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210118141223.123667-8-frederic@kernel.org>
References: <20210118141223.123667-8-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <161278563912.23325.5897230789443632080.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     74345075999752a7a9c805fe5e2ec770345cd1ca
Gitweb:        https://git.kernel.org/tip/74345075999752a7a9c805fe5e2ec770345cd1ca
Author:        Peter Zijlstra (Intel) <peterz@infradead.org>
AuthorDate:    Mon, 18 Jan 2021 15:12:22 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 05 Feb 2021 17:19:57 +01:00

preempt/dynamic: Provide irqentry_exit_cond_resched() static call

Provide static call to control IRQ preemption (called in CONFIG_PREEMPT)
so that we can override its behaviour when preempt= is overriden.

Since the default behaviour is full preemption, its call is
initialized to provide IRQ preemption when preempt= isn't passed.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210118141223.123667-8-frederic@kernel.org
---
 include/linux/entry-common.h |  4 ++++
 kernel/entry/common.c        | 10 +++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index ca86a00..1401c93 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -2,6 +2,7 @@
 #ifndef __LINUX_ENTRYCOMMON_H
 #define __LINUX_ENTRYCOMMON_H
 
+#include <linux/static_call_types.h>
 #include <linux/tracehook.h>
 #include <linux/syscalls.h>
 #include <linux/seccomp.h>
@@ -453,6 +454,9 @@ irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
  * Conditional reschedule with additional sanity checks.
  */
 void irqentry_exit_cond_resched(void);
+#ifdef CONFIG_PREEMPT_DYNAMIC
+DECLARE_STATIC_CALL(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+#endif
 
 /**
  * irqentry_exit - Handle return from exception that used irqentry_enter()
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 3783416..84fa7ec 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -393,6 +393,9 @@ void irqentry_exit_cond_resched(void)
 			preempt_schedule_irq();
 	}
 }
+#ifdef CONFIG_PREEMPT_DYNAMIC
+DEFINE_STATIC_CALL(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+#endif
 
 noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 {
@@ -419,8 +422,13 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 		}
 
 		instrumentation_begin();
-		if (IS_ENABLED(CONFIG_PREEMPTION))
+		if (IS_ENABLED(CONFIG_PREEMPTION)) {
+#ifdef CONFIG_PREEMT_DYNAMIC
+			static_call(irqentry_exit_cond_resched)();
+#else
 			irqentry_exit_cond_resched();
+#endif
+		}
 		/* Covers both tracing and lockdep */
 		trace_hardirqs_on();
 		instrumentation_end();
