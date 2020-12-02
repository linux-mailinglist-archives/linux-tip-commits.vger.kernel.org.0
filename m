Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 933E82CBF49
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Dec 2020 15:14:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730311AbgLBONU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 2 Dec 2020 09:13:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730117AbgLBONU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 2 Dec 2020 09:13:20 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A45E2C061A47;
        Wed,  2 Dec 2020 06:12:05 -0800 (PST)
Date:   Wed, 02 Dec 2020 14:12:03 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606918323;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0xhFKn9cC3CvXtrrC2xV7RipX38G9ljTwnURORWDKp8=;
        b=V8HZsyFfhKKEaCxN01jBWp/kwSW2yQdpO2rWHWy+YmsYqbTFqX2CWen5ROGEOVVCETcX2G
        sb5bjc2AstLoJS2k2Q7FjANdOhVP2sjAZLFxVuuR0F9U8bgsyhqSDDrH1G/U/ThqZwKkS4
        Jg10Smmju/SbAXAooPj05lyOj14ArTtBEifDaeTlvbYI6Tb41QUHQM1JyfVAyBuQSvZ6v4
        Mv1fDBAWLKg+kUJtDSQickxVBf8UNDftOsa10/tLPb4E4XaGLda0X3mWVL5DnwxzFNeprp
        b8AbmzJ7uDJMsnGmUGlIubaUB6nPpZvD8aQXFi80uXtGN/suXQv2x3iiEOqogg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606918323;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0xhFKn9cC3CvXtrrC2xV7RipX38G9ljTwnURORWDKp8=;
        b=r+6AbPRmmCosmDA/1M/3Ub9++8iRb60gOWrWk9jAnHXq871HrZmuFEpj+EXkrIrUrnotOI
        UONpj0kyOnfrrzAw==
From:   "tip-bot2 for Gabriel Krisman Bertazi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] entry: Support Syscall User Dispatch on common
 syscall entry
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201127193238.821364-5-krisman@collabora.com>
References: <20201127193238.821364-5-krisman@collabora.com>
MIME-Version: 1.0
Message-ID: <160691832324.3364.1175492009497252965.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     11894468e39def270199f845b76df6c36d4ed133
Gitweb:        https://git.kernel.org/tip/11894468e39def270199f845b76df6c36d4ed133
Author:        Gabriel Krisman Bertazi <krisman@collabora.com>
AuthorDate:    Fri, 27 Nov 2020 14:32:35 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Dec 2020 15:07:56 +01:00

entry: Support Syscall User Dispatch on common syscall entry

Syscall User Dispatch (SUD) must take precedence over seccomp and
ptrace, since the use case is emulation (it can be invoked with a
different ABI) such that seccomp filtering by syscall number doesn't
make sense in the first place.  In addition, either the syscall is
dispatched back to userspace, in which case there is no resource for to
trace, or the syscall will be executed, and seccomp/ptrace will execute
next.

Since SUD runs before tracepoints, it needs to be a SYSCALL_WORK_EXIT as
well, just to prevent a trace exit event when dispatch was triggered.
For that, the on_syscall_dispatch() examines context to skip the
tracepoint, audit and other work.

[ tglx: Add a comment on the exit side ]

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Acked-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/r/20201127193238.821364-5-krisman@collabora.com
---
 include/linux/entry-common.h |  2 ++
 kernel/entry/common.c        | 25 +++++++++++++++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 49b26b2..a6e98b4 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -44,10 +44,12 @@
 				 SYSCALL_WORK_SYSCALL_TRACE |		\
 				 SYSCALL_WORK_SYSCALL_EMU |		\
 				 SYSCALL_WORK_SYSCALL_AUDIT |		\
+				 SYSCALL_WORK_SYSCALL_USER_DISPATCH |	\
 				 ARCH_SYSCALL_WORK_ENTER)
 #define SYSCALL_WORK_EXIT	(SYSCALL_WORK_SYSCALL_TRACEPOINT |	\
 				 SYSCALL_WORK_SYSCALL_TRACE |		\
 				 SYSCALL_WORK_SYSCALL_AUDIT |		\
+				 SYSCALL_WORK_SYSCALL_USER_DISPATCH |	\
 				 ARCH_SYSCALL_WORK_EXIT)
 
 /*
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 91e8fd5..e661e70 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -5,6 +5,8 @@
 #include <linux/livepatch.h>
 #include <linux/audit.h>
 
+#include "common.h"
+
 #define CREATE_TRACE_POINTS
 #include <trace/events/syscalls.h>
 
@@ -46,6 +48,16 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
 {
 	long ret = 0;
 
+	/*
+	 * Handle Syscall User Dispatch.  This must comes first, since
+	 * the ABI here can be something that doesn't make sense for
+	 * other syscall_work features.
+	 */
+	if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
+		if (syscall_user_dispatch(regs))
+			return -1L;
+	}
+
 	/* Handle ptrace */
 	if (work & (SYSCALL_WORK_SYSCALL_TRACE | SYSCALL_WORK_SYSCALL_EMU)) {
 		ret = arch_syscall_enter_tracehook(regs);
@@ -230,6 +242,19 @@ static void syscall_exit_work(struct pt_regs *regs, unsigned long work)
 {
 	bool step;
 
+	/*
+	 * If the syscall was rolled back due to syscall user dispatching,
+	 * then the tracers below are not invoked for the same reason as
+	 * the entry side was not invoked in syscall_trace_enter(): The ABI
+	 * of these syscalls is unknown.
+	 */
+	if (work & SYSCALL_WORK_SYSCALL_USER_DISPATCH) {
+		if (unlikely(current->syscall_dispatch.on_dispatch)) {
+			current->syscall_dispatch.on_dispatch = false;
+			return;
+		}
+	}
+
 	audit_syscall_exit(regs);
 
 	if (work & SYSCALL_WORK_SYSCALL_TRACEPOINT)
