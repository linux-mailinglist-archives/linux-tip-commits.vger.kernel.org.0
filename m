Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9952B38FC65
	for <lists+linux-tip-commits@lfdr.de>; Tue, 25 May 2021 10:13:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbhEYIPS (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 25 May 2021 04:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232093AbhEYIPI (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 25 May 2021 04:15:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B657C06138A;
        Tue, 25 May 2021 01:13:19 -0700 (PDT)
Date:   Tue, 25 May 2021 08:13:16 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621930397;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dntve2KX4ut2jU2DPuRWmkt8UyWOlLzwMue+XtlwPSw=;
        b=1084+iD6DtM/2L6OpcuQAhle5SHb0UgzSt4m5tAAGdR2gac3/J50PR0qTF2zDsU6/7bQki
        nQZC1AKoxQYiqNg53jrGTQHibbeS81EmvHiTKyh+Y8hYAmydAssRtDKtbfJz3up2EupZxi
        F5wKOY8Oh3YOCxifEWwT7xtNX8B80NhdNzWMUSuMxeJ7H6gc6jOMCoAV349tZm4YUoBgFg
        90WAh/0Qmvmu7NdBVqi5eHnkNBbKHvM5gTwrHZUQBXZ0f6FBNloHIYnMU1rLZy7qokv1Zn
        4J3CaolPhSjn5l+UiveIMTT4fW8dqxEfzZQ2Cr7r0pGgU+PhY/6MSh3y9LRJxQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621930397;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dntve2KX4ut2jU2DPuRWmkt8UyWOlLzwMue+XtlwPSw=;
        b=OmcoG0v+NgBrvj71V55HbKMdq9FdwPcUyuMG+vbFNZbQN3Fcc3vQwll7CgqBnVrFfQuHqM
        71jaLdWkA6yAQjCA==
From:   "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Use int everywhere for system call numbers
Cc:     "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210518191303.4135296-7-hpa@zytor.com>
References: <20210518191303.4135296-7-hpa@zytor.com>
MIME-Version: 1.0
Message-ID: <162193039683.29796.7156654843953588379.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     2978996f620001f4e748c79af0fe89be729ef58d
Gitweb:        https://git.kernel.org/tip/2978996f620001f4e748c79af0fe89be729ef58d
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 18 May 2021 12:13:03 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 25 May 2021 10:07:00 +02:00

x86/entry: Use int everywhere for system call numbers

System call numbers are defined as int, so use int everywhere for system
call numbers. This is strictly a cleanup; it should not change anything
user visible; all ABI changes have been done in the preceeding patches.

[ tglx: Replaced the unsigned long cast ]

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210518191303.4135296-7-hpa@zytor.com

---
 arch/x86/entry/common.c        | 87 ++++++++++++++++++++++-----------
 arch/x86/include/asm/syscall.h |  2 +-
 2 files changed, 60 insertions(+), 29 deletions(-)

diff --git a/arch/x86/entry/common.c b/arch/x86/entry/common.c
index f51bc17..ee95fe3 100644
--- a/arch/x86/entry/common.c
+++ b/arch/x86/entry/common.c
@@ -36,49 +36,81 @@
 #include <asm/irq_stack.h>
 
 #ifdef CONFIG_X86_64
-__visible noinstr void do_syscall_64(struct pt_regs *regs, unsigned long nr)
+
+static __always_inline bool do_syscall_x64(struct pt_regs *regs, int nr)
+{
+	/*
+	 * Convert negative numbers to very high and thus out of range
+	 * numbers for comparisons.
+	 */
+	unsigned int unr = nr;
+
+	if (likely(unr < NR_syscalls)) {
+		unr = array_index_nospec(unr, NR_syscalls);
+		regs->ax = sys_call_table[unr](regs);
+		return true;
+	}
+	return false;
+}
+
+static __always_inline bool do_syscall_x32(struct pt_regs *regs, int nr)
+{
+	/*
+	 * Adjust the starting offset of the table, and convert numbers
+	 * < __X32_SYSCALL_BIT to very high and thus out of range
+	 * numbers for comparisons.
+	 */
+	unsigned int xnr = nr - __X32_SYSCALL_BIT;
+
+	if (IS_ENABLED(CONFIG_X86_X32_ABI) && likely(xnr < X32_NR_syscalls)) {
+		xnr = array_index_nospec(xnr, X32_NR_syscalls);
+		regs->ax = x32_sys_call_table[xnr](regs);
+		return true;
+	}
+	return false;
+}
+
+__visible noinstr void do_syscall_64(struct pt_regs *regs, int nr)
 {
 	add_random_kstack_offset();
 	nr = syscall_enter_from_user_mode(regs, nr);
 
 	instrumentation_begin();
-	if (likely(nr < NR_syscalls)) {
-		nr = array_index_nospec(nr, NR_syscalls);
-		regs->ax = sys_call_table[nr](regs);
-#ifdef CONFIG_X86_X32_ABI
-	} else if (likely((nr & __X32_SYSCALL_BIT) &&
-			  (nr & ~__X32_SYSCALL_BIT) < X32_NR_syscalls)) {
-		nr = array_index_nospec(nr & ~__X32_SYSCALL_BIT,
-					X32_NR_syscalls);
-		regs->ax = x32_sys_call_table[nr](regs);
-#endif
-	} else if (unlikely((int)nr != -1)) {
+
+	if (!do_syscall_x64(regs, nr) && !do_syscall_x32(regs, nr) && nr != -1) {
+		/* Invalid system call, but still a system call. */
 		regs->ax = __x64_sys_ni_syscall(regs);
 	}
+
 	instrumentation_end();
 	syscall_exit_to_user_mode(regs);
 }
 #endif
 
 #if defined(CONFIG_X86_32) || defined(CONFIG_IA32_EMULATION)
-static __always_inline unsigned int syscall_32_enter(struct pt_regs *regs)
+static __always_inline int syscall_32_enter(struct pt_regs *regs)
 {
 	if (IS_ENABLED(CONFIG_IA32_EMULATION))
 		current_thread_info()->status |= TS_COMPAT;
 
-	return (unsigned int)regs->orig_ax;
+	return (int)regs->orig_ax;
 }
 
 /*
  * Invoke a 32-bit syscall.  Called with IRQs on in CONTEXT_KERNEL.
  */
-static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs,
-						  unsigned int nr)
+static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs, int nr)
 {
-	if (likely(nr < IA32_NR_syscalls)) {
-		nr = array_index_nospec(nr, IA32_NR_syscalls);
-		regs->ax = ia32_sys_call_table[nr](regs);
-	} else if (unlikely((int)nr != -1)) {
+	/*
+	 * Convert negative numbers to very high and thus out of range
+	 * numbers for comparisons.
+	 */
+	unsigned int unr = nr;
+
+	if (likely(unr < IA32_NR_syscalls)) {
+		unr = array_index_nospec(unr, IA32_NR_syscalls);
+		regs->ax = ia32_sys_call_table[unr](regs);
+	} else if (nr != -1) {
 		regs->ax = __ia32_sys_ni_syscall(regs);
 	}
 }
@@ -86,15 +118,15 @@ static __always_inline void do_syscall_32_irqs_on(struct pt_regs *regs,
 /* Handles int $0x80 */
 __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
 {
-	unsigned int nr = syscall_32_enter(regs);
+	int nr = syscall_32_enter(regs);
 
 	add_random_kstack_offset();
 	/*
-	 * Subtlety here: if ptrace pokes something larger than 2^32-1 into
-	 * orig_ax, the unsigned int return value truncates it.  This may
-	 * or may not be necessary, but it matches the old asm behavior.
+	 * Subtlety here: if ptrace pokes something larger than 2^31-1 into
+	 * orig_ax, the int return value truncates it. This matches
+	 * the semantics of syscall_get_nr().
 	 */
-	nr = (unsigned int)syscall_enter_from_user_mode(regs, nr);
+	nr = syscall_enter_from_user_mode(regs, nr);
 	instrumentation_begin();
 
 	do_syscall_32_irqs_on(regs, nr);
@@ -105,7 +137,7 @@ __visible noinstr void do_int80_syscall_32(struct pt_regs *regs)
 
 static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 {
-	unsigned int nr = syscall_32_enter(regs);
+	int nr = syscall_32_enter(regs);
 	int res;
 
 	add_random_kstack_offset();
@@ -140,8 +172,7 @@ static noinstr bool __do_fast_syscall_32(struct pt_regs *regs)
 		return false;
 	}
 
-	/* The case truncates any ptrace induced syscall nr > 2^32 -1 */
-	nr = (unsigned int)syscall_enter_from_user_mode_work(regs, nr);
+	nr = syscall_enter_from_user_mode_work(regs, nr);
 
 	/* Now this is just like a normal syscall. */
 	do_syscall_32_irqs_on(regs, nr);
diff --git a/arch/x86/include/asm/syscall.h b/arch/x86/include/asm/syscall.h
index f6593ca..f7e2d82 100644
--- a/arch/x86/include/asm/syscall.h
+++ b/arch/x86/include/asm/syscall.h
@@ -159,7 +159,7 @@ static inline int syscall_get_arch(struct task_struct *task)
 		? AUDIT_ARCH_I386 : AUDIT_ARCH_X86_64;
 }
 
-void do_syscall_64(struct pt_regs *regs, unsigned long nr);
+void do_syscall_64(struct pt_regs *regs, int nr);
 void do_int80_syscall_32(struct pt_regs *regs);
 long do_fast_syscall_32(struct pt_regs *regs);
 
