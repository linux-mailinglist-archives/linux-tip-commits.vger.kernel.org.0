Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0073C2B5382
	for <lists+linux-tip-commits@lfdr.de>; Mon, 16 Nov 2020 22:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731771AbgKPVLh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 16 Nov 2020 16:11:37 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43772 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731935AbgKPVLf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 16 Nov 2020 16:11:35 -0500
Date:   Mon, 16 Nov 2020 21:11:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605561092;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yzfT8KCQokd4Je7WqOU1mpYQ7nP3MyjPDDi9WMUaA/s=;
        b=16XhnnLfyyJZkqmHKS+3ESBR2jV+g/tlwSVbek6ba/CX82GsE2lMo+lBjFQjQKyrJWwTU5
        7FXgsj6OvouIByn55ldCbCkYoivucOHRRpnjdNTjnzPptBECVAtZhyWgAIjt1Velfgkqwh
        VSyJY95jheghh7NaAiV/4GpUbKHgFF4WPCspZtWnyehJO50gAtPX3r1UjN7LPEdyWQPuIF
        /Gff354yPqdbYQqhtVuPtTLi5Km5aq5uSwptoIdir2BR5i223980Ond2j17A25wGrnQ/3O
        MLia9lkQINzX7w/7h6tzXtLC0eGG/G8Fe+UpFXFbiH9SOOcFZOmFFl/FPTEQsg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605561092;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yzfT8KCQokd4Je7WqOU1mpYQ7nP3MyjPDDi9WMUaA/s=;
        b=D0szBGpKX9EkRXYcl8Me05Ayzfe7O5PLye+5+KBgjOoEY/AeMiyMAF1/yKAjpFSZ/Ox2eh
        o10LT2DczZrpqMDw==
From:   "tip-bot2 for Gabriel Krisman Bertazi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] tracepoints: Migrate to use SYSCALL_WORK flag
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201116174206.2639648-6-krisman@collabora.com>
References: <20201116174206.2639648-6-krisman@collabora.com>
MIME-Version: 1.0
Message-ID: <160556109198.11244.8461994332034727316.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     524666cb5de7c38a1925e7401a6e59d68682dd8c
Gitweb:        https://git.kernel.org/tip/524666cb5de7c38a1925e7401a6e59d68682dd8c
Author:        Gabriel Krisman Bertazi <krisman@collabora.com>
AuthorDate:    Mon, 16 Nov 2020 12:42:01 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 16 Nov 2020 21:53:15 +01:00

tracepoints: Migrate to use SYSCALL_WORK flag

On architectures using the generic syscall entry code the architecture
independent syscall work is moved to flags in thread_info::syscall_work.
This removes architecture dependencies and frees up TIF bits.

Define SYSCALL_WORK_SYSCALL_TRACEPOINT, use it in the generic entry code
and convert the code which uses the TIF specific helper functions to use
the new *_syscall_work() helpers which either resolve to the new mode for
users of the generic entry code or to the TIF based functions for the other
architectures.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20201116174206.2639648-6-krisman@collabora.com
---
 include/linux/entry-common.h | 13 +++++--------
 include/linux/thread_info.h  |  2 ++
 include/trace/syscall.h      |  6 +++---
 kernel/entry/common.c        |  4 ++--
 kernel/trace/trace_events.c  |  8 ++++----
 kernel/tracepoint.c          |  4 ++--
 6 files changed, 18 insertions(+), 19 deletions(-)

diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index fa3cdb1..2a01eee 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -17,10 +17,6 @@
 # define _TIF_SYSCALL_EMU		(0)
 #endif
 
-#ifndef _TIF_SYSCALL_TRACEPOINT
-# define _TIF_SYSCALL_TRACEPOINT	(0)
-#endif
-
 #ifndef _TIF_SYSCALL_AUDIT
 # define _TIF_SYSCALL_AUDIT		(0)
 #endif
@@ -46,7 +42,7 @@
 
 #define SYSCALL_ENTER_WORK						\
 	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT  |			\
-	 _TIF_SYSCALL_TRACEPOINT | _TIF_SYSCALL_EMU |			\
+	 _TIF_SYSCALL_EMU |						\
 	 ARCH_SYSCALL_ENTER_WORK)
 
 /*
@@ -58,10 +54,11 @@
 
 #define SYSCALL_EXIT_WORK						\
 	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT |			\
-	 _TIF_SYSCALL_TRACEPOINT | ARCH_SYSCALL_EXIT_WORK)
+	 ARCH_SYSCALL_EXIT_WORK)
 
-#define SYSCALL_WORK_ENTER	(SYSCALL_WORK_SECCOMP)
-#define SYSCALL_WORK_EXIT	(0)
+#define SYSCALL_WORK_ENTER	(SYSCALL_WORK_SECCOMP |			\
+				 SYSCALL_WORK_SYSCALL_TRACEPOINT)
+#define SYSCALL_WORK_EXIT	(SYSCALL_WORK_SYSCALL_TRACEPOINT)
 
 /*
  * TIF flags handled in exit_to_user_mode_loop()
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index a308ba4..c232043 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -37,9 +37,11 @@ enum {
 
 enum syscall_work_bit {
 	SYSCALL_WORK_BIT_SECCOMP,
+	SYSCALL_WORK_BIT_SYSCALL_TRACEPOINT,
 };
 
 #define SYSCALL_WORK_SECCOMP		BIT(SYSCALL_WORK_BIT_SECCOMP)
+#define SYSCALL_WORK_SYSCALL_TRACEPOINT	BIT(SYSCALL_WORK_BIT_SYSCALL_TRACEPOINT)
 
 #include <asm/thread_info.h>
 
diff --git a/include/trace/syscall.h b/include/trace/syscall.h
index dc8ac27..8e193f3 100644
--- a/include/trace/syscall.h
+++ b/include/trace/syscall.h
@@ -37,10 +37,10 @@ struct syscall_metadata {
 #if defined(CONFIG_TRACEPOINTS) && defined(CONFIG_HAVE_SYSCALL_TRACEPOINTS)
 static inline void syscall_tracepoint_update(struct task_struct *p)
 {
-	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
-		set_tsk_thread_flag(p, TIF_SYSCALL_TRACEPOINT);
+	if (test_syscall_work(SYSCALL_TRACEPOINT))
+		set_task_syscall_work(p, SYSCALL_TRACEPOINT);
 	else
-		clear_tsk_thread_flag(p, TIF_SYSCALL_TRACEPOINT);
+		clear_task_syscall_work(p, SYSCALL_TRACEPOINT);
 }
 #else
 static inline void syscall_tracepoint_update(struct task_struct *p)
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index 5747a6e..f651967 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -63,7 +63,7 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
 	/* Either of the above might have changed the syscall number */
 	syscall = syscall_get_nr(current, regs);
 
-	if (unlikely(ti_work & _TIF_SYSCALL_TRACEPOINT))
+	if (unlikely(work & SYSCALL_WORK_SYSCALL_TRACEPOINT))
 		trace_sys_enter(regs, syscall);
 
 	syscall_enter_audit(regs, syscall);
@@ -233,7 +233,7 @@ static void syscall_exit_work(struct pt_regs *regs, unsigned long ti_work,
 
 	audit_syscall_exit(regs);
 
-	if (ti_work & _TIF_SYSCALL_TRACEPOINT)
+	if (work & SYSCALL_WORK_SYSCALL_TRACEPOINT)
 		trace_sys_exit(regs, syscall_get_return_value(current, regs));
 
 	step = report_single_step(ti_work);
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index 47a71f9..adf65b5 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3428,10 +3428,10 @@ static __init int event_trace_enable(void)
  * initialize events and perhaps start any events that are on the
  * command line. Unfortunately, there are some events that will not
  * start this early, like the system call tracepoints that need
- * to set the TIF_SYSCALL_TRACEPOINT flag of pid 1. But event_trace_enable()
- * is called before pid 1 starts, and this flag is never set, making
- * the syscall tracepoint never get reached, but the event is enabled
- * regardless (and not doing anything).
+ * to set the %SYSCALL_WORK_SYSCALL_TRACEPOINT flag of pid 1. But
+ * event_trace_enable() is called before pid 1 starts, and this flag
+ * is never set, making the syscall tracepoint never get reached, but
+ * the event is enabled regardless (and not doing anything).
  */
 static __init int event_trace_enable_again(void)
 {
diff --git a/kernel/tracepoint.c b/kernel/tracepoint.c
index 3f659f8..7261fa0 100644
--- a/kernel/tracepoint.c
+++ b/kernel/tracepoint.c
@@ -594,7 +594,7 @@ int syscall_regfunc(void)
 	if (!sys_tracepoint_refcount) {
 		read_lock(&tasklist_lock);
 		for_each_process_thread(p, t) {
-			set_tsk_thread_flag(t, TIF_SYSCALL_TRACEPOINT);
+			set_task_syscall_work(t, SYSCALL_TRACEPOINT);
 		}
 		read_unlock(&tasklist_lock);
 	}
@@ -611,7 +611,7 @@ void syscall_unregfunc(void)
 	if (!sys_tracepoint_refcount) {
 		read_lock(&tasklist_lock);
 		for_each_process_thread(p, t) {
-			clear_tsk_thread_flag(t, TIF_SYSCALL_TRACEPOINT);
+			clear_task_syscall_work(t, SYSCALL_TRACEPOINT);
 		}
 		read_unlock(&tasklist_lock);
 	}
