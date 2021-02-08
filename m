Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4113D3131B7
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Feb 2021 13:04:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233168AbhBHMEJ (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 8 Feb 2021 07:04:09 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36286 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233510AbhBHMBV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 8 Feb 2021 07:01:21 -0500
Date:   Mon, 08 Feb 2021 12:00:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612785639;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/0oy2jLEBcKqauRQo4yp+K/JYA9+Jpwd4lNquu4Opn4=;
        b=Zz2gK5oUsgR4MUAOPUs+WNwsKhPp3hurvmpXs+8JcASl4h5H+UREDMO3VgHAMfYtzLj/En
        ipedTSes9gl0dA98gtTesfb1NP6ZS09K+97f5yyYwcxAWKS+1idlKTPsUQ4dAC+rSiWNCr
        nnubGD3oN1lPphL8jZPIzYVYIWxIrcOyTJSzWfWII59eoqGj8L792KGH5VzFTZz3ByKdYi
        WJjvsOz8P4p0dv7m06fxtF10sdbmM0C5eoNWB64KSM9F0z9NOLkzi9GdNCBkCtQsso1lb0
        Ip0BQl9Iq2+1SwzWDZAVtxR49ZfvyIFb3xbNu05nep/ng7i6LQBHzjvBlrIPOw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612785639;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/0oy2jLEBcKqauRQo4yp+K/JYA9+Jpwd4lNquu4Opn4=;
        b=V6JwmfiDn57Jc/SPKhh0ovhTRgY86m8FPFDvG9LILHGDaGdCR54MkZGXkhFJ6mZwvto/mK
        /JXj0Ok6Ld09lWDg==
From:   "tip-bot2 for Peter Zijlstra (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] preempt/dynamic: Support dynamic preempt with
 preempt= boot option
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210118141223.123667-9-frederic@kernel.org>
References: <20210118141223.123667-9-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <161278563889.23325.16615646963543538971.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     4f8a0041162ab74ba5f89ee58f8aad59c4c85d22
Gitweb:        https://git.kernel.org/tip/4f8a0041162ab74ba5f89ee58f8aad59c4c85d22
Author:        Peter Zijlstra (Intel) <peterz@infradead.org>
AuthorDate:    Mon, 18 Jan 2021 15:12:23 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 05 Feb 2021 17:19:58 +01:00

preempt/dynamic: Support dynamic preempt with preempt= boot option

Support the preempt= boot option and patch the static call sites
accordingly.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210118141223.123667-9-frederic@kernel.org
---
 kernel/sched/core.c | 67 +++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 66 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cd0c46f..0562992 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -12,6 +12,7 @@
 
 #include "sched.h"
 
+#include <linux/entry-common.h>
 #include <linux/nospec.h>
 
 #include <linux/kcov.h>
@@ -5314,9 +5315,73 @@ DEFINE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func);
 EXPORT_STATIC_CALL(preempt_schedule_notrace);
 #endif
 
-
 #endif /* CONFIG_PREEMPTION */
 
+#ifdef CONFIG_PREEMPT_DYNAMIC
+
+/*
+ * SC:cond_resched
+ * SC:might_resched
+ * SC:preempt_schedule
+ * SC:preempt_schedule_notrace
+ * SC:irqentry_exit_cond_resched
+ *
+ *
+ * NONE:
+ *   cond_resched               <- __cond_resched
+ *   might_resched              <- RET0
+ *   preempt_schedule           <- NOP
+ *   preempt_schedule_notrace   <- NOP
+ *   irqentry_exit_cond_resched <- NOP
+ *
+ * VOLUNTARY:
+ *   cond_resched               <- __cond_resched
+ *   might_resched              <- __cond_resched
+ *   preempt_schedule           <- NOP
+ *   preempt_schedule_notrace   <- NOP
+ *   irqentry_exit_cond_resched <- NOP
+ *
+ * FULL:
+ *   cond_resched               <- RET0
+ *   might_resched              <- RET0
+ *   preempt_schedule           <- preempt_schedule
+ *   preempt_schedule_notrace   <- preempt_schedule_notrace
+ *   irqentry_exit_cond_resched <- irqentry_exit_cond_resched
+ */
+static int __init setup_preempt_mode(char *str)
+{
+	if (!strcmp(str, "none")) {
+		static_call_update(cond_resched, __cond_resched);
+		static_call_update(might_resched, (typeof(&__cond_resched)) __static_call_return0);
+		static_call_update(preempt_schedule, (typeof(&preempt_schedule)) NULL);
+		static_call_update(preempt_schedule_notrace, (typeof(&preempt_schedule_notrace)) NULL);
+		static_call_update(irqentry_exit_cond_resched, (typeof(&irqentry_exit_cond_resched)) NULL);
+		pr_info("Dynamic Preempt: %s\n", str);
+	} else if (!strcmp(str, "voluntary")) {
+		static_call_update(cond_resched, __cond_resched);
+		static_call_update(might_resched, __cond_resched);
+		static_call_update(preempt_schedule, (typeof(&preempt_schedule)) NULL);
+		static_call_update(preempt_schedule_notrace, (typeof(&preempt_schedule_notrace)) NULL);
+		static_call_update(irqentry_exit_cond_resched, (typeof(&irqentry_exit_cond_resched)) NULL);
+		pr_info("Dynamic Preempt: %s\n", str);
+	} else if (!strcmp(str, "full")) {
+		static_call_update(cond_resched, (typeof(&__cond_resched)) __static_call_return0);
+		static_call_update(might_resched, (typeof(&__cond_resched)) __static_call_return0);
+		static_call_update(preempt_schedule, __preempt_schedule_func);
+		static_call_update(preempt_schedule_notrace, __preempt_schedule_notrace_func);
+		static_call_update(irqentry_exit_cond_resched, irqentry_exit_cond_resched);
+		pr_info("Dynamic Preempt: %s\n", str);
+	} else {
+		pr_warn("Dynamic Preempt: Unsupported preempt mode %s, default to full\n", str);
+		return 1;
+	}
+	return 0;
+}
+__setup("preempt=", setup_preempt_mode);
+
+#endif /* CONFIG_PREEMPT_DYNAMIC */
+
+
 /*
  * This is the entry point to schedule() from kernel preemption
  * off of irq context.
