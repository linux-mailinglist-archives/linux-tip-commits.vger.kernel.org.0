Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE300315316
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Feb 2021 16:46:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232458AbhBIPpx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 9 Feb 2021 10:45:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232563AbhBIPpt (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 9 Feb 2021 10:45:49 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60BA0C06178B;
        Tue,  9 Feb 2021 07:45:08 -0800 (PST)
Date:   Tue, 09 Feb 2021 15:45:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612885506;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=5D200P5+1pe7/GLBz27A2sB6ncXo5vKnJ9+nzSGMmKs=;
        b=bTcNUpNKU3/wBk2NdInwtxyo6w4ZCIym48t7zm+ETxm/M5g7qL2uNyPHisl8M99IWuGZH5
        uRGtn/l8swBs8amwsAoV4d/J+ogafqkqCV2wjulThUfK7EFtuUofKUBYRW1Q/hU85SeN/T
        CjuKP4oPfgeaFLBEzn4stPFAVSZY4irmE0y2I++EmDZUgHHrToEkvBTHmNZMi/qLoJhL51
        kKyViSrxDy4ZDc2S0qHd5Nf4zDPH0xNSDqVtBALRzoSU59G40jd2x9ODdUcNqWUOcXTE/1
        GdnTN0+WBROHxBP3KnWl2bpwLR6/dowxoI2B17IkMqc2nFJnkMsU/1CETJGQyA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612885506;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=5D200P5+1pe7/GLBz27A2sB6ncXo5vKnJ9+nzSGMmKs=;
        b=owAuPiJU7f6OZwgiEKJ9aClW8KnO7CA1/i5MPEC0RjJsEsE+esgpwqwYE0GlnakWdAYds5
        nnVrmIDh7i3/CgCg==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched: Harden PREEMPT_DYNAMIC
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161288550623.23325.15273780016472163.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     355b3a57ddba71b73a99aa249a99aed6ed904606
Gitweb:        https://git.kernel.org/tip/355b3a57ddba71b73a99aa249a99aed6ed904606
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Mon, 25 Jan 2021 16:26:50 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 09 Feb 2021 16:31:03 +01:00

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
index cb226f7..d93d02b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5253,7 +5253,7 @@ EXPORT_SYMBOL(preempt_schedule);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 DEFINE_STATIC_CALL(preempt_schedule, __preempt_schedule_func);
-EXPORT_STATIC_CALL(preempt_schedule);
+EXPORT_STATIC_CALL_TRAMP(preempt_schedule);
 #endif
 
 
@@ -5311,7 +5311,7 @@ EXPORT_SYMBOL_GPL(preempt_schedule_notrace);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 DEFINE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func);
-EXPORT_STATIC_CALL(preempt_schedule_notrace);
+EXPORT_STATIC_CALL_TRAMP(preempt_schedule_notrace);
 #endif
 
 #endif /* CONFIG_PREEMPTION */
@@ -6983,10 +6983,10 @@ EXPORT_SYMBOL(__cond_resched);
 
 #ifdef CONFIG_PREEMPT_DYNAMIC
 DEFINE_STATIC_CALL_RET0(cond_resched, __cond_resched);
-EXPORT_STATIC_CALL(cond_resched);
+EXPORT_STATIC_CALL_TRAMP(cond_resched);
 
 DEFINE_STATIC_CALL_RET0(might_resched, __cond_resched);
-EXPORT_STATIC_CALL(might_resched);
+EXPORT_STATIC_CALL_TRAMP(might_resched);
 #endif
 
 /*
