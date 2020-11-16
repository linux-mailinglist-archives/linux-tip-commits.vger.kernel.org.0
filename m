Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C7102B537C
	for <lists+linux-tip-commits@lfdr.de>; Mon, 16 Nov 2020 22:13:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732643AbgKPVLg (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 16 Nov 2020 16:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732508AbgKPVLf (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 16 Nov 2020 16:11:35 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C567BC0613CF;
        Mon, 16 Nov 2020 13:11:34 -0800 (PST)
Date:   Mon, 16 Nov 2020 21:11:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1605561093;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GPex/fqO289ubdGDIBERIN3HCCs9Mw2Q89VfWpfg0UY=;
        b=xZjNtonTOYNCFZwkAcHPwK8cQF4JmuENptCV4drIPpt7QnqMlSdO4EA/fYcw5PV2ugbCIe
        aUPhER3mmg6bJIrpbCE6vL2e7SCaDoMN9LfaM98FjCEVdNIL9Cf+9zIQiqRFIWyCgR8h/v
        HgmwDK/49TML0+d9sOuzWwFmLBbxHntmWRch9LBT/NZkO01AuGUoxozRbo0z0OSUTv9829
        cZCSpv2aMB/0ESa3aHvnjYI5Su+D/nAqwJyxuJ4urbBZmP/N/f0C21JBfTFfaISblVy76k
        IOlfS6hTTB6RjHM9TimeWWyGmgNyca+O864hhKw+ClRZWiEgom8V2y0J7VFPrg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1605561093;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=GPex/fqO289ubdGDIBERIN3HCCs9Mw2Q89VfWpfg0UY=;
        b=AOxjLBLfmxpqBZsPkLCV4cVG7P6+ZIfeByMHxgAmTLao92V+YUZ+YZPxwKmIxWO0cDiN0k
        rIFIy3NtpFa4XEAg==
From:   "tip-bot2 for Gabriel Krisman Bertazi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/entry] seccomp: Migrate to use SYSCALL_WORK flag
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20201116174206.2639648-5-krisman@collabora.com>
References: <20201116174206.2639648-5-krisman@collabora.com>
MIME-Version: 1.0
Message-ID: <160556109254.11244.5144167448024963441.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     23d67a54857a768acdb0804cdd6037c324a50ecd
Gitweb:        https://git.kernel.org/tip/23d67a54857a768acdb0804cdd6037c324a50ecd
Author:        Gabriel Krisman Bertazi <krisman@collabora.com>
AuthorDate:    Mon, 16 Nov 2020 12:42:00 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 16 Nov 2020 21:53:15 +01:00

seccomp: Migrate to use SYSCALL_WORK flag

On architectures using the generic syscall entry code the architecture
independent syscall work is moved to flags in thread_info::syscall_work.
This removes architecture dependencies and frees up TIF bits.

Define SYSCALL_WORK_SECCOMP, use it in the generic entry code and convert
the code which uses the TIF specific helper functions to use the new
*_syscall_work() helpers which either resolve to the new mode for users of
the generic entry code or to the TIF based functions for the other
architectures.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Andy Lutomirski <luto@kernel.org>
Link: https://lore.kernel.org/r/20201116174206.2639648-5-krisman@collabora.com
---
 include/asm-generic/syscall.h | 2 +-
 include/linux/entry-common.h  | 8 ++------
 include/linux/seccomp.h       | 2 +-
 include/linux/thread_info.h   | 6 ++++++
 kernel/entry/common.c         | 2 +-
 kernel/fork.c                 | 2 +-
 kernel/seccomp.c              | 6 +++---
 7 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/include/asm-generic/syscall.h b/include/asm-generic/syscall.h
index f3135e7..524d8e6 100644
--- a/include/asm-generic/syscall.h
+++ b/include/asm-generic/syscall.h
@@ -135,7 +135,7 @@ void syscall_set_arguments(struct task_struct *task, struct pt_regs *regs,
  * Returns the AUDIT_ARCH_* based on the system call convention in use.
  *
  * It's only valid to call this when @task is stopped on entry to a system
- * call, due to %TIF_SYSCALL_TRACE, %TIF_SYSCALL_AUDIT, or %TIF_SECCOMP.
+ * call, due to %TIF_SYSCALL_TRACE, %TIF_SYSCALL_AUDIT, or %SYSCALL_WORK_SECCOMP.
  *
  * Architectures which permit CONFIG_HAVE_ARCH_SECCOMP_FILTER must
  * provide an implementation of this.
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 3fe8f86..fa3cdb1 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -21,10 +21,6 @@
 # define _TIF_SYSCALL_TRACEPOINT	(0)
 #endif
 
-#ifndef _TIF_SECCOMP
-# define _TIF_SECCOMP			(0)
-#endif
-
 #ifndef _TIF_SYSCALL_AUDIT
 # define _TIF_SYSCALL_AUDIT		(0)
 #endif
@@ -49,7 +45,7 @@
 #endif
 
 #define SYSCALL_ENTER_WORK						\
-	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT | _TIF_SECCOMP |	\
+	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT  |			\
 	 _TIF_SYSCALL_TRACEPOINT | _TIF_SYSCALL_EMU |			\
 	 ARCH_SYSCALL_ENTER_WORK)
 
@@ -64,7 +60,7 @@
 	(_TIF_SYSCALL_TRACE | _TIF_SYSCALL_AUDIT |			\
 	 _TIF_SYSCALL_TRACEPOINT | ARCH_SYSCALL_EXIT_WORK)
 
-#define SYSCALL_WORK_ENTER	(0)
+#define SYSCALL_WORK_ENTER	(SYSCALL_WORK_SECCOMP)
 #define SYSCALL_WORK_EXIT	(0)
 
 /*
diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 02aef28..47763f3 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -42,7 +42,7 @@ struct seccomp {
 extern int __secure_computing(const struct seccomp_data *sd);
 static inline int secure_computing(void)
 {
-	if (unlikely(test_thread_flag(TIF_SECCOMP)))
+	if (unlikely(test_syscall_work(SECCOMP)))
 		return  __secure_computing(NULL);
 	return 0;
 }
diff --git a/include/linux/thread_info.h b/include/linux/thread_info.h
index 0e9fb15..a308ba4 100644
--- a/include/linux/thread_info.h
+++ b/include/linux/thread_info.h
@@ -35,6 +35,12 @@ enum {
 	GOOD_STACK,
 };
 
+enum syscall_work_bit {
+	SYSCALL_WORK_BIT_SECCOMP,
+};
+
+#define SYSCALL_WORK_SECCOMP		BIT(SYSCALL_WORK_BIT_SECCOMP)
+
 #include <asm/thread_info.h>
 
 #ifdef __KERNEL__
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index e7a11e3..5747a6e 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -54,7 +54,7 @@ static long syscall_trace_enter(struct pt_regs *regs, long syscall,
 	}
 
 	/* Do seccomp after ptrace, to catch any tracer changes. */
-	if (ti_work & _TIF_SECCOMP) {
+	if (work & SYSCALL_WORK_SECCOMP) {
 		ret = __secure_computing(NULL);
 		if (ret == -1L)
 			return ret;
diff --git a/kernel/fork.c b/kernel/fork.c
index 32083db..bc5b109 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1625,7 +1625,7 @@ static void copy_seccomp(struct task_struct *p)
 	 * to manually enable the seccomp thread flag here.
 	 */
 	if (p->seccomp.mode != SECCOMP_MODE_DISABLED)
-		set_tsk_thread_flag(p, TIF_SECCOMP);
+		set_task_syscall_work(p, SECCOMP);
 #endif
 }
 
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 8ad7a29..f67e92d 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -356,14 +356,14 @@ static inline void seccomp_assign_mode(struct task_struct *task,
 
 	task->seccomp.mode = seccomp_mode;
 	/*
-	 * Make sure TIF_SECCOMP cannot be set before the mode (and
+	 * Make sure SYSCALL_WORK_SECCOMP cannot be set before the mode (and
 	 * filter) is set.
 	 */
 	smp_mb__before_atomic();
 	/* Assume default seccomp processes want spec flaw mitigation. */
 	if ((flags & SECCOMP_FILTER_FLAG_SPEC_ALLOW) == 0)
 		arch_seccomp_spec_mitigate(task);
-	set_tsk_thread_flag(task, TIF_SECCOMP);
+	set_task_syscall_work(task, SECCOMP);
 }
 
 #ifdef CONFIG_SECCOMP_FILTER
@@ -929,7 +929,7 @@ static int __seccomp_filter(int this_syscall, const struct seccomp_data *sd,
 
 	/*
 	 * Make sure that any changes to mode from another thread have
-	 * been seen after TIF_SECCOMP was seen.
+	 * been seen after SYSCALL_WORK_SECCOMP was seen.
 	 */
 	rmb();
 
