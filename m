Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FAE245F5CB
	for <lists+linux-tip-commits@lfdr.de>; Fri, 26 Nov 2021 21:25:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240904AbhKZU2U (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 26 Nov 2021 15:28:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33296 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239601AbhKZU0L (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 26 Nov 2021 15:26:11 -0500
Date:   Fri, 26 Nov 2021 20:22:56 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1637958177;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O9C03Wsmr4jqo0oG1QQpzdldjays0nreAkAivV+ikOI=;
        b=3UbSCgj3SBF1OCeFs94DCYpjL1LIARrTxaXuK1TpM7nCQGJZji9LHT8muQcwQy/bU7fwe9
        /GZKGIO9SlgfjHaqO4HIEZIbnAjWEPaomy5MdH3U+yYnQEVTs1FBTkUs61j/E3xoLr/2oQ
        L+wqPKv0Y2kOCYj/XJs2ql+m2r6Uxl9W44c8ybl0GvQOc7smTt4sLk6yAxgISh2jRAAKmQ
        cuGNLo6TZEfRzLXD2Nv8FNikaVCbqUu7hpwhTvXzghyBSH5h6l7Jig/Hkd+kHpSjt2Y7D+
        zTgfdPx5AsSsAryoOabu+JyeB6GoD2uOSqm+5XOFVLRC/pHCXtihXza4hLpoNA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1637958177;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O9C03Wsmr4jqo0oG1QQpzdldjays0nreAkAivV+ikOI=;
        b=jgINBFN6vp9mYflYZUwlKvVUwb+E44ANj7ROBPq6fYNS9p4QarC7EjTQYOK+Gew1FK41da
        o12709XrLAV1FYCg==
From:   "tip-bot2 for Mark Rutland" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] arm64: snapshot thread flags
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Will Deacon <will@kernel.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211117163050.53986-7-mark.rutland@arm.com>
References: <20211117163050.53986-7-mark.rutland@arm.com>
MIME-Version: 1.0
Message-ID: <163795817677.11128.14392009886950339362.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     67c76c3dc0ef46f44715e866c7d4ef81a5a2872d
Gitweb:        https://git.kernel.org/tip/67c76c3dc0ef46f44715e866c7d4ef81a5a2872d
Author:        Mark Rutland <mark.rutland@arm.com>
AuthorDate:    Wed, 17 Nov 2021 16:30:44 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 26 Nov 2021 21:20:13 +01:00

arm64: snapshot thread flags

Some thread flags can be set remotely, and so even when IRQs are
disabled, the flags can change under our feet. Generally this is
unlikely to cause a problem in practice, but it is somewhat unsound, and
KCSAN will legitimately warn that there is a data race.

To avoid such issues, a snapshot of the flags has to be taken prior to
using them. Some places already use READ_ONCE() for that, others do not.

Convert them all to the new flag accessor helpers.

Signed-off-by: Mark Rutland <mark.rutland@arm.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Will Deacon <will@kernel.org>
Acked-by: Paul E. McKenney <paulmck@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Link: https://lore.kernel.org/r/20211117163050.53986-7-mark.rutland@arm.com
---
 arch/arm64/kernel/entry-common.c | 2 +-
 arch/arm64/kernel/ptrace.c       | 4 ++--
 arch/arm64/kernel/signal.c       | 2 +-
 arch/arm64/kernel/syscall.c      | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index f7408ed..ef7fcef 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -129,7 +129,7 @@ static __always_inline void prepare_exit_to_user_mode(struct pt_regs *regs)
 
 	local_daif_mask();
 
-	flags = READ_ONCE(current_thread_info()->flags);
+	flags = read_thread_flags();
 	if (unlikely(flags & _TIF_WORK_MASK))
 		do_notify_resume(regs, flags);
 }
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 88a9034..33cac3d 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -1839,7 +1839,7 @@ static void tracehook_report_syscall(struct pt_regs *regs,
 
 int syscall_trace_enter(struct pt_regs *regs)
 {
-	unsigned long flags = READ_ONCE(current_thread_info()->flags);
+	unsigned long flags = read_thread_flags();
 
 	if (flags & (_TIF_SYSCALL_EMU | _TIF_SYSCALL_TRACE)) {
 		tracehook_report_syscall(regs, PTRACE_SYSCALL_ENTER);
@@ -1862,7 +1862,7 @@ int syscall_trace_enter(struct pt_regs *regs)
 
 void syscall_trace_exit(struct pt_regs *regs)
 {
-	unsigned long flags = READ_ONCE(current_thread_info()->flags);
+	unsigned long flags = read_thread_flags();
 
 	audit_syscall_exit(regs);
 
diff --git a/arch/arm64/kernel/signal.c b/arch/arm64/kernel/signal.c
index 8f6372b..d8aaf4b 100644
--- a/arch/arm64/kernel/signal.c
+++ b/arch/arm64/kernel/signal.c
@@ -948,7 +948,7 @@ void do_notify_resume(struct pt_regs *regs, unsigned long thread_flags)
 		}
 
 		local_daif_mask();
-		thread_flags = READ_ONCE(current_thread_info()->flags);
+		thread_flags = read_thread_flags();
 	} while (thread_flags & _TIF_WORK_MASK);
 }
 
diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
index 50a0f1a..c938603 100644
--- a/arch/arm64/kernel/syscall.c
+++ b/arch/arm64/kernel/syscall.c
@@ -81,7 +81,7 @@ void syscall_trace_exit(struct pt_regs *regs);
 static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 			   const syscall_fn_t syscall_table[])
 {
-	unsigned long flags = current_thread_info()->flags;
+	unsigned long flags = read_thread_flags();
 
 	regs->orig_x0 = regs->regs[0];
 	regs->syscallno = scno;
@@ -148,7 +148,7 @@ static void el0_svc_common(struct pt_regs *regs, int scno, int sc_nr,
 	 */
 	if (!has_syscall_work(flags) && !IS_ENABLED(CONFIG_DEBUG_RSEQ)) {
 		local_daif_mask();
-		flags = current_thread_info()->flags;
+		flags = read_thread_flags();
 		if (!has_syscall_work(flags) && !(flags & _TIF_SINGLESTEP))
 			return;
 		local_daif_restore(DAIF_PROCCTX);
