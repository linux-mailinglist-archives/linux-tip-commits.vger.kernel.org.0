Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 13C0F436562
	for <lists+linux-tip-commits@lfdr.de>; Thu, 21 Oct 2021 17:12:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231897AbhJUPOt (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 21 Oct 2021 11:14:49 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60788 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231769AbhJUPOq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 21 Oct 2021 11:14:46 -0400
Date:   Thu, 21 Oct 2021 15:12:29 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634829150;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=biD6AN3t4iq1yWmfuTYmVcGuzbrNHHwHgg6DwTq9Gik=;
        b=HI1EArdXcKJnivUJ5QY2W773iTtTEL0YZzRdw0yorc/1BUlYO+cqjkNBD3oO4KD3KGpmCR
        IVYJjSXpK/yS/jg2DsQyYJswDXTMDiBb77M/iB15eQMmkifBz6VU48quoTgj6NEgzvoXJW
        RdcAr82526ahLLJOLWNHhIVXp+EDjrDjqwJ94jK1Q9GDbmF/fZN0eVTZRQbzMYUpyil1Bb
        RFwDZAvUeRcZEgkvoBnvimwDHX0zLOqVQHp2sMZgBD4Y0G2wkC27FSWaaQaH0f/GRPM5bh
        dtfg6AIWhdfialg/wZheltWII5V5egPubmbkPXw/LMVKUi82v8/OguIZkRBxkA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634829150;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=biD6AN3t4iq1yWmfuTYmVcGuzbrNHHwHgg6DwTq9Gik=;
        b=tM0Jtk8KPkNEzC0wwjTRK5NGs13bsEe5TGjZhsqcuKS65zDnkYN19PsVTF1XERI6kVjYQm
        rmy+1qLh6DlSIGBA==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/process: Move arch_thread_struct_whitelist() out of line
Cc:     Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@suse.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20211013145322.869001791@linutronix.de>
References: <20211013145322.869001791@linutronix.de>
MIME-Version: 1.0
Message-ID: <163482914934.25758.14955770516847538749.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     2dd8eedc80b184bb16aad697ae60367c5bf07299
Gitweb:        https://git.kernel.org/tip/2dd8eedc80b184bb16aad697ae60367c5bf07299
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Wed, 13 Oct 2021 16:55:45 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 21 Oct 2021 09:33:41 +02:00

x86/process: Move arch_thread_struct_whitelist() out of line

In preparation for dynamically enabled FPU features move the function
out of line as the goal is to expose less and not more information.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211013145322.869001791@linutronix.de
---
 arch/x86/include/asm/processor.h |  9 +++------
 arch/x86/kernel/fpu/core.c       | 10 ++++++++++
 arch/x86/kernel/fpu/internal.h   |  2 ++
 3 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 4519d33..1bd3e8d 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -461,9 +461,6 @@ DECLARE_PER_CPU(struct irq_stack *, hardirq_stack_ptr);
 DECLARE_PER_CPU(struct irq_stack *, softirq_stack_ptr);
 #endif	/* !X86_64 */
 
-extern unsigned int fpu_kernel_xstate_size;
-extern unsigned int fpu_user_xstate_size;
-
 struct perf_event;
 
 struct thread_struct {
@@ -537,12 +534,12 @@ struct thread_struct {
 	 */
 };
 
-/* Whitelist the FPU register state from the task_struct for hardened usercopy. */
+extern void fpu_thread_struct_whitelist(unsigned long *offset, unsigned long *size);
+
 static inline void arch_thread_struct_whitelist(unsigned long *offset,
 						unsigned long *size)
 {
-	*offset = offsetof(struct thread_struct, fpu.__fpstate.regs);
-	*size = fpu_kernel_xstate_size;
+	fpu_thread_struct_whitelist(offset, size);
 }
 
 static inline void
diff --git a/arch/x86/kernel/fpu/core.c b/arch/x86/kernel/fpu/core.c
index 14560fd..c6df975 100644
--- a/arch/x86/kernel/fpu/core.c
+++ b/arch/x86/kernel/fpu/core.c
@@ -405,6 +405,16 @@ int fpu_clone(struct task_struct *dst)
 }
 
 /*
+ * Whitelist the FPU register state embedded into task_struct for hardened
+ * usercopy.
+ */
+void fpu_thread_struct_whitelist(unsigned long *offset, unsigned long *size)
+{
+	*offset = offsetof(struct thread_struct, fpu.__fpstate.regs);
+	*size = fpu_kernel_xstate_size;
+}
+
+/*
  * Drops current FPU state: deactivates the fpregs and
  * the fpstate. NOTE: it still leaves previous contents
  * in the fpregs in the eager-FPU case.
diff --git a/arch/x86/kernel/fpu/internal.h b/arch/x86/kernel/fpu/internal.h
index e1d8a35..5c4f71f 100644
--- a/arch/x86/kernel/fpu/internal.h
+++ b/arch/x86/kernel/fpu/internal.h
@@ -2,6 +2,8 @@
 #ifndef __X86_KERNEL_FPU_INTERNAL_H
 #define __X86_KERNEL_FPU_INTERNAL_H
 
+extern unsigned int fpu_kernel_xstate_size;
+extern unsigned int fpu_user_xstate_size;
 extern struct fpstate init_fpstate;
 
 /* CPU feature check wrappers */
