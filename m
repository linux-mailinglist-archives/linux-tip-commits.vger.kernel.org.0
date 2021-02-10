Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A885C316866
	for <lists+linux-tip-commits@lfdr.de>; Wed, 10 Feb 2021 14:55:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231682AbhBJNyf (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 10 Feb 2021 08:54:35 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59980 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbhBJNyS (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 10 Feb 2021 08:54:18 -0500
Date:   Wed, 10 Feb 2021 13:53:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612965212;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oZ02RpwwhZ2MWdwBo+q/06o4EC/gBce/LpplT82nv5w=;
        b=hHTqsiu4xqbLjPTEuVBufNkQLZ6saoGQsOiNklQYn0MfpOH4OnWiHCl4+UmFsGUSQCq1+2
        nya2uFIZBK4HCvmTgU+xxsltX8YjeWev6380nA7ZHkU59e9CsNRFsNiu9ktX5l9dsMyq50
        CmbyHLnxyIh2V1/1ELkx5AGxvgrTdaD/krwmdOvYEHzGmPaF2w6tUVYv/U6hWoqZ5ibNYi
        9F3bqVtM/XX9+7c2LXDOtp95O/ChsJmHCu7eY8roZr8WKhpyDiZ/Ok7KlDqFv2Ph3Fwsjd
        DL9Od9FoKiMHIvKiaJaVHmEPYJtaw5Pp1KQT4T3yxScvmlbnHTSvW+fStf9vqA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612965212;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oZ02RpwwhZ2MWdwBo+q/06o4EC/gBce/LpplT82nv5w=;
        b=ggdglj+1PTNSBTBXbi0sOKsDrNSPOpzxbIFShpC4spQm0vHNdL7Mta7ZbS5ZLbFOTbi5wi
        maJ34AgTYY2wS8BQ==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched,x86: Allow !PREEMPT_DYNAMIC
Cc:     Mike Galbraith <efault@gmx.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YCK1+JyFNxQnWeXK@hirez.programming.kicks-ass.net>
References: <YCK1+JyFNxQnWeXK@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <161296521143.23325.3662179234825253723.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     82891be90f3c42dc964fd61b8b2a89de12940c9f
Gitweb:        https://git.kernel.org/tip/82891be90f3c42dc964fd61b8b2a89de12940c9f
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Tue, 09 Feb 2021 22:02:33 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 10 Feb 2021 14:44:51 +01:00

sched,x86: Allow !PREEMPT_DYNAMIC

Allow building x86 with PREEMPT_DYNAMIC=n, this is needed for
PREEMPT_RT as it makes no sense to not have full preemption on
PREEMPT_RT.

Fixes: 8c98e8cf723c ("preempt/dynamic: Provide preempt_schedule[_notrace]() static calls")
Reported-by: Mike Galbraith <efault@gmx.de>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
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
