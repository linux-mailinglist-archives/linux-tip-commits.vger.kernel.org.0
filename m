Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5273C31DA1E
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Feb 2021 14:20:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbhBQNSa (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Feb 2021 08:18:30 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45222 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232817AbhBQNSS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Feb 2021 08:18:18 -0500
Date:   Wed, 17 Feb 2021 13:17:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613567853;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=120EgLZCiv+lY1x1HrRrWKK4fxpgUnxAN7Gz8wubKQ8=;
        b=EzVlo+Euhm57swOzkMqWybGoBLo5D1MDem+bgb+EmbhMcToxjt7C7q/DceR5WZZXgi2QdS
        OLc/1ENOIenUMKoUlH2FfL7KOM2WYSWS2XK86Ye79RoQKZA7ubetlhBpDHWzt0iD4V6b+l
        WsoBYgGi5fKJUJj4nQA56B/em+xeDPwVyZH80nGdEfM9ioVqXMW+R1ORUkjI6qvhwE8ceX
        I6n3kxIreSELBpxoSJUDOBuXTFP9Llp4p0igYi1uq73TJen4qbkon8mARroNRd/6NDNrI8
        BtpW1Md8Z+Dc0FjEN2fGWM/4osR4pHLexvtw4bBfd+0ezfZxTTQlS0n+AAkyaQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613567853;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=120EgLZCiv+lY1x1HrRrWKK4fxpgUnxAN7Gz8wubKQ8=;
        b=Krb/g30KspE9GlSaSGhoC8CRkZL/YSdsn3x0+utbAT/1/jtV3As0R5EXe7npN8Thw0NsHl
        WiAqVpeEeyV0CUDQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Harden PREEMPT_DYNAMIC
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161356785323.20312.3165332853226182145.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     ef72661e28c64ad610f89acc2832ec67b27ba438
Gitweb:        https://git.kernel.org/tip/ef72661e28c64ad610f89acc2832ec67b27ba438
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 25 Jan 2021 16:26:50 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Feb 2021 14:12:42 +01:00

sched: Harden PREEMPT_DYNAMIC

Use the new EXPORT_STATIC_CALL_TRAMP() / static_call_mod() to unexport
the static_call_key for the PREEMPT_DYNAMIC calls such that modules
can no longer update these calls.

Having modules change/hi-jack the preemption calls would be horrible.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
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
index 4a17bb5..cec507b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5267,7 +5267,7 @@ EXPORT_SYMBOL(preempt_schedule);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 DEFINE_STATIC_CALL(preempt_schedule, __preempt_schedule_func);
-EXPORT_STATIC_CALL(preempt_schedule);
+EXPORT_STATIC_CALL_TRAMP(preempt_schedule);
 #endif
 
 
@@ -5325,7 +5325,7 @@ EXPORT_SYMBOL_GPL(preempt_schedule_notrace);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 DEFINE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func);
-EXPORT_STATIC_CALL(preempt_schedule_notrace);
+EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
 #endif
 
 #endif /* CONFIG_PREEMPTION */
@@ -6997,10 +6997,10 @@ EXPORT_SYMBOL(__cond_resched);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 DEFINE_STATIC_CALL_RET0(cond_resched, __cond_resched);
-EXPORT_STATIC_CALL(cond_resched);
+EXPORT_STATIC_CALL_TRAMP(cond_resched);
 
 DEFINE_STATIC_CALL_RET0(might_resched, __cond_resched);
-EXPORT_STATIC_CALL(might_resched);
+EXPORT_STATIC_CALL_TRAMP(might_resched);
 #endif
 
 /*
