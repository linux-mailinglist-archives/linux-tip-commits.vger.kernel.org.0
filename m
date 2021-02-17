Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D5DD631DA14
	for <lists+linux-tip-commits@lfdr.de>; Wed, 17 Feb 2021 14:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232854AbhBQNSU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 17 Feb 2021 08:18:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45132 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231703AbhBQNSO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 17 Feb 2021 08:18:14 -0500
Date:   Wed, 17 Feb 2021 13:17:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613567851;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gE9WVdKS8Np5uJgazh8C/sfdqwqMVwU+lqHROJmW72M=;
        b=cZnjjlUvZtzC32k5MY+hpK+vn6TyfQ0TIWGkfvjQFRkuD0JWfmYuhHfz2f3AK4at4pMlZS
        HdU56vyJ8VHYNZjDaR6mWqEnuPgv43HMMR1GRxJdf8+WvQuhStmF6Z2uxFvHjaXiwrekMq
        aJh1NUFp2UhLHivsFrquN3VLPDvQv/31KUXjF5DQMEz6W9jyVDuVfyKVqpJeCSsLueTckI
        imF/jwLXAKv1sUtiWU3Rb55JHpjEQ9d8dmr4SNeutalC5/2mkK27qkvvHTud6g4hrBosME
        43lskEo+ygLwTVNy+6ox6vkGoumdwo7D896/qxqCWDjgOT97rj/dvPgGYLkNrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613567851;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=gE9WVdKS8Np5uJgazh8C/sfdqwqMVwU+lqHROJmW72M=;
        b=fNrmRX2UqbW/C1l8tQuiawVr3F10T/vdbjL+MjlFskAvxCwwKOFary9v/ELBeTiZlBNLe2
        SxmpUmzb7OHOM9Dw==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched,x86: Allow !PREEMPT_DYNAMIC
Cc:     Mike Galbraith <efault@gmx.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YCK1+JyFNxQnWeXK@hirez.programming.kicks-ass.net>
References: <YCK1+JyFNxQnWeXK@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <161356785045.20312.7404465373129724665.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     c5e6fc08feb2b88dc5dac2f3c817e1c2a4cafda4
Gitweb:        https://git.kernel.org/tip/c5e6fc08feb2b88dc5dac2f3c817e1c2a4cafda4
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 09 Feb 2021 22:02:33 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 17 Feb 2021 14:12:43 +01:00

sched,x86: Allow !PREEMPT_DYNAMIC

Allow building x86 with PREEMPT_DYNAMIC=n, this is needed for
PREEMPT_RT as it makes no sense to not have full preemption on
PREEMPT_RT.

Fixes: 8c98e8cf723c ("preempt/dynamic: Provide preempt_schedule[_notrace]() static calls")
Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Tested-by: Mike Galbraith <efault@gmx.de>
Link: https://lkml.kernel.org/r/YCK1+JyFNxQnWeXK@hirez.programming.kicks-ass.net
---
 arch/x86/include/asm/preempt.h | 24 ++++++++++++++++++------
 1 file changed, 18 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 0aa96f8..f8cb8af 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -110,6 +110,13 @@ extern asmlinkage void preempt_schedule_thunk(void);
 
 #define __preempt_schedule_func preempt_schedule_thunk
 
+extern asmlinkage void preempt_schedule_notrace(void);
+extern asmlinkage void preempt_schedule_notrace_thunk(void);
+
+#define __preempt_schedule_notrace_func preempt_schedule_notrace_thunk
+
+#ifdef CONFIG_PREEMPT_DYNAMIC
+
 DECLARE_STATIC_CALL(preempt_schedule, __preempt_schedule_func);
 
 #define __preempt_schedule() \
@@ -118,11 +125,6 @@ do { \
 	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule) : ASM_CALL_CONSTRAINT); \
 } while (0)
 
-extern asmlinkage void preempt_schedule_notrace(void);
-extern asmlinkage void preempt_schedule_notrace_thunk(void);
-
-#define __preempt_schedule_notrace_func preempt_schedule_notrace_thunk
-
 DECLARE_STATIC_CALL(preempt_schedule_notrace, __preempt_schedule_notrace_func);
 
 #define __preempt_schedule_notrace() \
@@ -131,6 +133,16 @@ do { \
 	asm volatile ("call " STATIC_CALL_TRAMP_STR(preempt_schedule_notrace) : ASM_CALL_CONSTRAINT); \
 } while (0)
 
-#endif
+#else /* PREEMPT_DYNAMIC */
+
+#define __preempt_schedule() \
+	asm volatile ("call preempt_schedule_thunk" : ASM_CALL_CONSTRAINT);
+
+#define __preempt_schedule_notrace() \
+	asm volatile ("call preempt_schedule_notrace_thunk" : ASM_CALL_CONSTRAINT);
+
+#endif /* PREEMPT_DYNAMIC */
+
+#endif /* PREEMPTION */
 
 #endif /* __ASM_PREEMPT_H */
