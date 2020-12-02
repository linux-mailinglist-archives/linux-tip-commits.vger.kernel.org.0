Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39C7A2CB933
	for <lists+linux-tip-commits@lfdr.de>; Wed,  2 Dec 2020 10:41:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388408AbgLBJkE (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 2 Dec 2020 04:40:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728260AbgLBJjv (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 2 Dec 2020 04:39:51 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D9D8C061A49;
        Wed,  2 Dec 2020 01:38:31 -0800 (PST)
Date:   Wed, 02 Dec 2020 09:38:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1606901908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KICQ28RBCz5AeFudANSUVqgZTLquGEcNH5uMWX8iSV0=;
        b=TvFCzEeoKBW5g0va9Y5AlWy/OwXVus6VUKKoKNxTx2zael5/1zQ5JmwruYChuNCylb5tiV
        56XpNFipnoXwPx5U0COpBBhsfl4REpSvDzkN88D9zkO4NldD3VjR4CxxsMxdfSGgczYs/K
        oRIfYPg+8PK1KpIyAJLxmg2eJeoiVoPRqhPQ6PuwWL2hPUPg8QeZeScZO6SHDku5LJAbss
        9JzBEG0c/9832R9+nGrTg4cI280SCA7wnogaMnYTrH07zUS9hgcuOuS5ePqgp7wpWz8i75
        zWBFMHYWJL818mvqXMXInHV2KiTNoWawtogMR2XPIObPUhwgglvwRMLzIjYq6w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1606901908;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KICQ28RBCz5AeFudANSUVqgZTLquGEcNH5uMWX8iSV0=;
        b=Q0cs0iAp7B55bhN6F9uBtr9GXeRzuIsldhksCewEJ6r75eziIXJIOuNWBQICg04uaWy0Aq
        TChLOkvwlwKIVNCw==
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
Message-ID: <160690190760.3364.8545413026277401547.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     5a5c45c624b8851cbfd269d5b0a8856a2b728502
Gitweb:        https://git.kernel.org/tip/5a5c45c624b8851cbfd269d5b0a8856a2b728502
Author:        Gabriel Krisman Bertazi <krisman@collabora.com>
AuthorDate:    Fri, 27 Nov 2020 14:32:35 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 02 Dec 2020 10:32:17 +01:00

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
