Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5B2F31DA1D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Feb 2021 14:20:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232869AbhBQNS1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Feb 2021 08:18:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45230 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232827AbhBQNSS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Feb 2021 08:18:18 -0500
Date:   Wed, 17 Feb 2021 13:17:34 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613567854;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YmCB05hpa+0Z0irgXs42zcb8Hvgup3x1aLiEnJL6+wg=;
        b=OeNNX8ovwwoC7OeDfQB5yvqQwifZFtG57dCOc5gWRvBzBNEKbyYcsE90qn0JM7+sez77uS
        1h2oq0gWHRopfFYXzCZ61J/F9Z7V48SCAEmAorCu49i/V6kmzG5J5kINVpK2OwVGMU5GXz
        AJVmaBhZoyIe2ThmMRDjWEmRH5iGzZi8g+r4tU/w70aGX/ZaFVKRwn2aTIz2xOV4UbXbPL
        oo2UKyVXOJ1/SbnoF1adHD2KP1PnPSq0plYlP0chy1VN86ezQgp1nNAjYSSTe97pixbwmN
        O+XqooCsH2nqbtjMtKb0M2g2GOdbBByRx187TAnLWGx3KZ3drq2Jd8nIMKYBjQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613567854;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YmCB05hpa+0Z0irgXs42zcb8Hvgup3x1aLiEnJL6+wg=;
        b=2qmzEPE/Tq7RipdXE+yypoxwYCqcxlsMnNszZGPmpxwUWPuh9v7+i9ShU3p095Vz8iTg3C
        anDu4phh02VsehCg==
From:   "tip-bot2 for Peter Zijlstra (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] preempt/dynamic: Provide
 irqentry_exit_cond_resched() static call
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210118141223.123667-8-frederic@kernel.org>
References: <20210118141223.123667-8-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <161356785431.20312.17594381361120515669.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     40607ee97e4eec5655cc0f76a720bdc4c63a6434
Gitweb:        https://git.kernel.org/tip/40607ee97e4eec5655cc0f76a720bdc4c63a6434
Author:        Peter Zijlstra (Intel) <peterz@infradead.org>
AuthorDate:    Mon, 18 Jan 2021 15:12:22 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Feb 2021 14:12:42 +01:00

preempt/dynamic: Provide irqentry_exit_cond_resched() static call

Provide static call to control IRQ preemption (called in CONFIG_PREEMPT)
so that we can override its behaviour when preempt= is overriden.

Since the default behaviour is full preemption, its call is
initialized to provide IRQ preemption when preempt= isn't passed.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lkml.kernel.org/r/20210118141223.123667-8-frederic@kernel.org
---
 include/linux/entry-common.h |  4 ++++
 kernel/entry/common.c        | 10 +++++++++-
 2 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index a104b29..883acef 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -2,6 +2,7 @@
 #ifndef __LINUX_ENTRYCOMMON_H
 #define __LINUX_ENTRYCOMMON_H
 
+#include <linux/static_call_types.h>
 #include <linux/tracehook.h>
 #include <linux/syscalls.h>
 #include <linux/seccomp.h>
@@ -454,6 +455,9 @@ irqentry_state_t noinstr irqentry_enter(struct pt_regs *regs);
  * Conditional reschedule with additional sanity checks.
  */
 void irqentry_exit_cond_resched(void);
+#ifdef CONFIG_PREEMPT_DYNAMIC
+DECLARE_STATIC_CALL(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+#endif
 
 /**
  * irqentry_exit - Handle return from exception that used irqentry_enter()
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index f9d491b..f09cae3 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -385,6 +385,9 @@ void irqentry_exit_cond_resched(void)
 			preempt_schedule_irq();
 	}
 }
+#ifdef CONFIG_PREEMPT_DYNAMIC
+DEFINE_STATIC_CALL(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+#endif
 
 noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 {
@@ -411,8 +414,13 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
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
