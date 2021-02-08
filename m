Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DD4F83131BD
	for <lists+linux-tip-commits@lfdr.de>; Mon,  8 Feb 2021 13:05:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233417AbhBHME2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 8 Feb 2021 07:04:28 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36306 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233528AbhBHMBX (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 8 Feb 2021 07:01:23 -0500
Date:   Mon, 08 Feb 2021 12:00:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612785639;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PxRA7XWowwajpMWzOrnt+RfpNDfyICmRi7r+ty6r9cQ=;
        b=4Y9wkgeOIe98K9Lb5q2ujZMFBmQJhJo8wwwsjxNsOpV/t3QP1WPXqLzYcno556wAR1asYw
        qwGyqteo600YMdxCRleNLsnJJrY1JThgPtH61hQ0CIPqh+EhQWeOKkUaKvWhZePjhSKJjv
        tZIuofPuoZwLwXTDEoBbCTZF98Ob5zuNOME9bmDJZxKQMXAnXGudT7DV7INlZtm1EkdtwD
        E4rTIU/Hx1x0jPpD8Nj5xSAKp/FOtJxpoEdvI4JRE5Weq/RB0MG0b0hqDEFtpPUHhlH/b4
        G7ftI5blTwa09JRiCcg0KdA79TF4sxX0meOeNQEoupf2zcArkQ7I8NBdU5g5KQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612785639;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PxRA7XWowwajpMWzOrnt+RfpNDfyICmRi7r+ty6r9cQ=;
        b=x+Bt2kZHnlwVwyvHSY1w6EkkK+lisQdbQ2jAUnh7TmZMk0fmF8oQ9hy4CVAHIQbQoylApQ
        w4tDggm94nfSUjCQ==
From:   "tip-bot2 for Peter Zijlstra (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] preempt/dynamic: Provide
 preempt_schedule[_notrace]() static calls
Cc:     "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Frederic Weisbecker <frederic@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210118141223.123667-7-frederic@kernel.org>
References: <20210118141223.123667-7-frederic@kernel.org>
MIME-Version: 1.0
Message-ID: <161278563937.23325.13632797418141466848.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     8c98e8cf723c3ab2ac924b0942dd3b8074f874e5
Gitweb:        https://git.kernel.org/tip/8c98e8cf723c3ab2ac924b0942dd3b8074f874e5
Author:        Peter Zijlstra (Intel) <peterz@infradead.org>
AuthorDate:    Mon, 18 Jan 2021 15:12:21 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Fri, 05 Feb 2021 17:19:57 +01:00

preempt/dynamic: Provide preempt_schedule[_notrace]() static calls

Provide static calls to control preempt_schedule[_notrace]()
(called in CONFIG_PREEMPT) so that we can override their behaviour when
preempt= is overriden.

Since the default behaviour is full preemption, both their calls are
initialized to the arch provided wrapper, if any.

[fweisbec: only define static calls when PREEMPT_DYNAMIC, make it less
           dependent on x86 with __preempt_schedule_func]
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Link: https://lkml.kernel.org/r/20210118141223.123667-7-frederic@kernel.org
---
 arch/x86/include/asm/preempt.h | 34 +++++++++++++++++++++++++--------
 kernel/sched/core.c            | 12 ++++++++++++-
 2 files changed, 38 insertions(+), 8 deletions(-)

diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 69485ca..9b12dce 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -5,6 +5,7 @@
 #include <asm/rmwcc.h>
 #include <asm/percpu.h>
 #include <linux/thread_info.h>
+#include <linux/static_call_types.h>
 
 DECLARE_PER_CPU(int, __preempt_count);
 
@@ -103,16 +104,33 @@ static __always_inline bool should_resched(int preempt_offset)
 }
 
 #ifdef CONFIG_PREEMPTION
-  extern asmlinkage void preempt_schedule_thunk(void);
-# define __preempt_schedule() \
-	asm volatile ("call preempt_schedule_thunk" : ASM_CALL_CONSTRAINT)
 
-  extern asmlinkage void preempt_schedule(void);
-  extern asmlinkage void preempt_schedule_notrace_thunk(void);
-# define __preempt_schedule_notrace() \
-	asm volatile ("call preempt_schedule_notrace_thunk" : ASM_CALL_CONSTRAINT)
+extern asmlinkage void preempt_schedule(void);
+extern asmlinkage void preempt_schedule_thunk(void);
+
+#define __preempt_schedule_func preempt_schedule_thunk
+
+DECLARE_STATIC_CALL(preempt_schedule, __preempt_schedule_func);
+
+#define __preempt_schedule() \
+do { \
+	__ADDRESSABLE(STATIC_CALL_KEY(preempt_schedule)); \
+	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule) : ASM_CALL_CONSTRAINT); \
+} while (0)
+
+extern asmlinkage void preempt_schedule_notrace(void);
+extern asmlinkage void preempt_schedule_notrace_thunk(void);
+
+#define __preempt_schedule_notrace_func preempt_schedule_notrace_thunk
+
+DECLARE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func);
+
+#define __preempt_schedule_notrace() \
+do { \
+	__ADDRESSABLE(STATIC_CALL_KEY(preempt_schedule_notrace)); \
+	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule_notrace) : ASM_CALL_CONSTRAINT); \
+} while (0)
 
-  extern asmlinkage void preempt_schedule_notrace(void);
 #endif
 
 #endif /* __ASM_PREEMPT_H */
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index bc7b00b..cd0c46f 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5251,6 +5251,12 @@ asmlinkage __visible void __sched notrace preempt_schedule(void)
 NOKPROBE_SYMBOL(preempt_schedule);
 EXPORT_SYMBOL(preempt_schedule);
 
+#ifdef CONFIG_PREEMPT_DYNAMIC
+DEFINE_STATIC_CALL(preempt_schedule, __preempt_schedule_func);
+EXPORT_STATIC_CALL(preempt_schedule);
+#endif
+
+
 /**
  * preempt_schedule_notrace - preempt_schedule called by tracing
  *
@@ -5303,6 +5309,12 @@ asmlinkage __visible void __sched notrace preempt_schedule_notrace(void)
 }
 EXPORT_SYMBOL_GPL(preempt_schedule_notrace);
 
+#ifdef CONFIG_PREEMPT_DYNAMIC
+DEFINE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func);
+EXPORT_STATIC_CALL(preempt_schedule_notrace);
+#endif
+
+
 #endif /* CONFIG_PREEMPTION */
 
 /*
