Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA353131B5
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Feb 2021 13:04:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233171AbhBHMDv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 8 Feb 2021 07:03:51 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36260 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233361AbhBHMBV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 8 Feb 2021 07:01:21 -0500
Date:   Mon, 08 Feb 2021 12:00:38 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612785638;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=u1vDYv7AJqNBfPTmH3PtamVzT+ln1aI0pl5c84l3wA0=;
        b=QY0Fpx3n1mBjk88augLM7Lgn4OSWKVJaJYSeoxBHS4hwydOtGJF2V1VZ+bd3vUrDgLkaE3
        /uLo71pjtshv5s/YDObUpceUaeZ9mKp5LPZ/35ynwIhbA8efXT+PyWYoMQZ+0Q8X2M0yX8
        XSS2KyMdm/0mCCmicEVeEUz1xr85FLf+PKR+RYN3nZn+dyDEgzKTAVH3ccgWgLygjz5f6b
        vvFWVcqB4V9fbmcWSv7g7yPjieCOI6OZ7Xlu+ogjjsp84Tu7FSH9KRXuq+ytBX40JeXrls
        7uY7l3WqIgjQxJerQbSNCtduayXYeIDmxFotOZhfcsqWyeSDPo/FC7dXlCMtqg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612785638;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=u1vDYv7AJqNBfPTmH3PtamVzT+ln1aI0pl5c84l3wA0=;
        b=F+JD6Op+nhoiZvJsxXL1AIEVbXgoQKS76QtFUz+U686MsbeVphRZytRBnttYJgHV13sKlR
        T4+Z67nflIg3TtDw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Harden PREEMPT_DYNAMIC
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161278563804.23325.3092408762385428647.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     936eba768e7d4701373115977db1dbe954b6f6af
Gitweb:        https://git.kernel.org/tip/936eba768e7d4701373115977db1dbe954b6f6af
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 25 Jan 2021 16:26:50 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 05 Feb 2021 17:19:59 +01:00

sched: Harden PREEMPT_DYNAMIC

Use the new EXPORT_STATIC_CALL_TRAMP() / static_call_mod() to unexport
the static_call_key for the PREEMPT_DYNAMIC calls such that modules
can no longer update these calls.

Having modules change/hi-jack the preemption calls would be horrible.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 arch/x86/include/asm/preempt.h | 4 ++--
 include/linux/kernel.h         | 2 +-
 include/linux/sched.h          | 2 +-
 kernel/sched/core.c            | 8 ++++----
 4 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 9b12dce..0aa96f8 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -114,7 +114,7 @@ DECLARE_STATIC_CALL(preempt_schedule, __preempt_schedule_func);
 
 #define __preempt_schedule() \
 do { \
-	__ADDRESSABLE(STATIC_CALL_KEY(preempt_schedule)); \
+	__STATIC_CALL_MOD_ADDRESSABLE(preempt_schedule); \
 	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule) : ASM_CALL_CONSTRAINT); \
 } while (0)
 
@@ -127,7 +127,7 @@ DECLARE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func);
 
 #define __preempt_schedule_notrace() \
 do { \
-	__ADDRESSABLE(STATIC_CALL_KEY(preempt_schedule_notrace)); \
+	__STATIC_CALL_MOD_ADDRESSABLE(preempt_schedule_notrace); \
 	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule_notrace) : ASM_CALL_CONSTRAINT); \
 } while (0)
 
diff --git a/include/linux/kernel.h b/include/linux/kernel.h
index cfd3d34..5b7ed6d 100644
--- a/include/linux/kernel.h
+++ b/include/linux/kernel.h
@@ -93,7 +93,7 @@ DECLARE_STATIC_CALL(might_resched, __cond_resched);
 
 static __always_inline void might_resched(void)
 {
-	static_call(might_resched)();
+	static_call_mod(might_resched)();
 }
 
 #else
diff --git a/include/linux/sched.h b/include/linux/sched.h
index 2f35594..4d56828 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1880,7 +1880,7 @@ DECLARE_STATIC_CALL(cond_resched, __cond_resched);
 
 static __always_inline int _cond_resched(void)
 {
-	return static_call(cond_resched)();
+	return static_call_mod(cond_resched)();
 }
 
 #else
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c659266..81e1e19 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5254,7 +5254,7 @@ EXPORT_SYMBOL(preempt_schedule);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 DEFINE_STATIC_CALL(preempt_schedule, __preempt_schedule_func);
-EXPORT_STATIC_CALL(preempt_schedule);
+EXPORT_STATIC_CALL_TRAMP(preempt_schedule);
 #endif
 
 
@@ -5312,7 +5312,7 @@ EXPORT_SYMBOL_GPL(preempt_schedule_notrace);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 DEFINE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func);
-EXPORT_STATIC_CALL(preempt_schedule_notrace);
+EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
 #endif
 
 #endif /* CONFIG_PREEMPTION */
@@ -6982,10 +6982,10 @@ EXPORT_SYMBOL(__cond_resched);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 DEFINE_STATIC_CALL_RET0(cond_resched, __cond_resched);
-EXPORT_STATIC_CALL(cond_resched);
+EXPORT_STATIC_CALL_TRAMP(cond_resched);
 
 DEFINE_STATIC_CALL_RET0(might_resched, __cond_resched);
-EXPORT_STATIC_CALL(might_resched);
+EXPORT_STATIC_CALL_TRAMP(might_resched);
 #endif
 
 /*
