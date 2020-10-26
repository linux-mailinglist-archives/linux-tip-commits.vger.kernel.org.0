Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D32E298D4A
	for <lists+linux-tip-commits@lfdr.de>; Mon, 26 Oct 2020 13:53:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775653AbgJZMwh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 26 Oct 2020 08:52:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39794 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1775643AbgJZMwg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 26 Oct 2020 08:52:36 -0400
Date:   Mon, 26 Oct 2020 12:52:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603716753;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6LSDfYGPt3hGFamsmvTLldy54nU92LS6/+BzPM7oNnE=;
        b=vNd4O039GzbJwUHx6iCZettlgVQiPlfOJsWVmHnm7IlVMMzLsxHf1ZfDDylOuQEErTUViS
        m/eRZAOkMIebvneF0bAyx1jWCxbYxQh3D3j32EmUSwv1ZTAxQiXazgIRQbQMwmfezaadBv
        Xx2YU8Ftq1ylqGZUS5ER3l+xgd2fUgGPm46ZtmjRojMrqGXxGLOJtp9/8FHQOyeYtuhVLc
        KsOwunF9JOykQ1xsQv6qqodAWGLSjoYfjbN9YC/1PQ9iS3izhOLuJ1hV6cpGMhG6aTmXB2
        9hhwEaqSVAE6RKO0XPnC/t/qJqlZpE1YemqQxwO2IvP6uJ2hGGN6jfck+knQuQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603716753;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=6LSDfYGPt3hGFamsmvTLldy54nU92LS6/+BzPM7oNnE=;
        b=819MlzkNvuOF3CvthqFD6HxUdOAOqoZdzGmwLbH4dXh86GGJ9yr9dFM93BexykYLfRvJqk
        YIfiAwAPR6NyCKCQ==
From:   "tip-bot2 for Gabriel Krisman Bertazi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/cleanups] x86/mm: Convert mmu context ia32_compat into a
 proper flags field
Cc:     Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Lutomirski <luto@kernel.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201004032536.1229030-10-krisman@collabora.com>
References: <20201004032536.1229030-10-krisman@collabora.com>
MIME-Version: 1.0
Message-ID: <160371675292.397.16758659806817657829.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/cleanups branch of tip:

Commit-ID:     ff170cd0595398a7b66cb40f249eb2f10c29b66d
Gitweb:        https://git.kernel.org/tip/ff170cd0595398a7b66cb40f249eb2f10c29b66d
Author:        Gabriel Krisman Bertazi <krisman@collabora.com>
AuthorDate:    Sat, 03 Oct 2020 23:25:35 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 26 Oct 2020 13:46:47 +01:00

x86/mm: Convert mmu context ia32_compat into a proper flags field

The ia32_compat attribute is a weird thing.  It mirrors TIF_IA32 and
TIF_X32 and is used only in two very unrelated places: (1) to decide if
the vsyscall page is accessible (2) for uprobes to find whether the
patched instruction is 32 or 64 bit.

In preparation to remove the TIF flags, a new mechanism is required for
ia32_compat, but given its odd semantics, adding a real flags field which
configures these specific behaviours is the best option.

So, set_personality_x64() can ask for the vsyscall page, which is not
available in x32/ia32 and set_personality_ia32() can configure the uprobe
code as needed.

uprobe cannot rely on other methods like user_64bit_mode() to decide how
to patch, so it needs some specific flag like this.

Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Andy Lutomirski<luto@kernel.org>
Link: https://lore.kernel.org/r/20201004032536.1229030-10-krisman@collabora.com
---
 arch/x86/entry/vsyscall/vsyscall_64.c |  2 +-
 arch/x86/include/asm/mmu.h            |  9 +++++++--
 arch/x86/include/asm/mmu_context.h    |  2 +-
 arch/x86/kernel/process_64.c          | 17 +++++++++++------
 4 files changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index 44c3310..1b40b92 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -316,7 +316,7 @@ static struct vm_area_struct gate_vma __ro_after_init = {
 struct vm_area_struct *get_gate_vma(struct mm_struct *mm)
 {
 #ifdef CONFIG_COMPAT
-	if (!mm || mm->context.ia32_compat)
+	if (!mm || !(mm->context.flags & MM_CONTEXT_HAS_VSYSCALL))
 		return NULL;
 #endif
 	if (vsyscall_mode == NONE)
diff --git a/arch/x86/include/asm/mmu.h b/arch/x86/include/asm/mmu.h
index 9257667..5d74946 100644
--- a/arch/x86/include/asm/mmu.h
+++ b/arch/x86/include/asm/mmu.h
@@ -6,6 +6,12 @@
 #include <linux/rwsem.h>
 #include <linux/mutex.h>
 #include <linux/atomic.h>
+#include <linux/bits.h>
+
+/* Uprobes on this MM assume 32-bit code */
+#define MM_CONTEXT_UPROBE_IA32	BIT(0)
+/* vsyscall page is accessible on this MM */
+#define MM_CONTEXT_HAS_VSYSCALL	BIT(1)
 
 /*
  * x86 has arch-specific MMU state beyond what lives in mm_struct.
@@ -33,8 +39,7 @@ typedef struct {
 #endif
 
 #ifdef CONFIG_X86_64
-	/* True if mm supports a task running in 32 bit compatibility mode. */
-	unsigned short ia32_compat;
+	unsigned short flags;
 #endif
 
 	struct mutex lock;
diff --git a/arch/x86/include/asm/mmu_context.h b/arch/x86/include/asm/mmu_context.h
index d98016b..054a791 100644
--- a/arch/x86/include/asm/mmu_context.h
+++ b/arch/x86/include/asm/mmu_context.h
@@ -177,7 +177,7 @@ static inline void arch_exit_mmap(struct mm_struct *mm)
 static inline bool is_64bit_mm(struct mm_struct *mm)
 {
 	return	!IS_ENABLED(CONFIG_IA32_EMULATION) ||
-		!(mm->context.ia32_compat == TIF_IA32);
+		!(mm->context.flags & MM_CONTEXT_UPROBE_IA32);
 }
 #else
 static inline bool is_64bit_mm(struct mm_struct *mm)
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index 5fb4103..d6efaf6 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -646,10 +646,8 @@ void set_personality_64bit(void)
 	/* Pretend that this comes from a 64bit execve */
 	task_pt_regs(current)->orig_ax = __NR_execve;
 	current_thread_info()->status &= ~TS_COMPAT;
-
-	/* Ensure the corresponding mm is not marked. */
 	if (current->mm)
-		current->mm->context.ia32_compat = 0;
+		current->mm->context.flags = MM_CONTEXT_HAS_VSYSCALL;
 
 	/* TBD: overwrites user setup. Should have two bits.
 	   But 64bit processes have always behaved this way,
@@ -664,7 +662,8 @@ static void __set_personality_x32(void)
 	clear_thread_flag(TIF_IA32);
 	set_thread_flag(TIF_X32);
 	if (current->mm)
-		current->mm->context.ia32_compat = TIF_X32;
+		current->mm->context.flags = 0;
+
 	current->personality &= ~READ_IMPLIES_EXEC;
 	/*
 	 * in_32bit_syscall() uses the presence of the x32 syscall bit
@@ -684,8 +683,14 @@ static void __set_personality_ia32(void)
 #ifdef CONFIG_IA32_EMULATION
 	set_thread_flag(TIF_IA32);
 	clear_thread_flag(TIF_X32);
-	if (current->mm)
-		current->mm->context.ia32_compat = TIF_IA32;
+	if (current->mm) {
+		/*
+		 * uprobes applied to this MM need to know this and
+		 * cannot use user_64bit_mode() at that time.
+		 */
+		current->mm->context.flags = MM_CONTEXT_UPROBE_IA32;
+	}
+
 	current->personality |= force_personality32;
 	/* Prepare the first "return" to user space */
 	task_pt_regs(current)->orig_ax = __NR_ia32_execve;
