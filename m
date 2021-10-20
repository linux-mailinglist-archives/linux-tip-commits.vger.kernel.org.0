Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B89E434C54
	for <lists+linux-tip-commits@lfdr.de>; Wed, 20 Oct 2021 15:44:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230183AbhJTNqr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 20 Oct 2021 09:46:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52930 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbhJTNqq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 20 Oct 2021 09:46:46 -0400
Date:   Wed, 20 Oct 2021 13:44:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1634737471;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LQIvKqBuCuv1kp87DLnptzkLyxe3zhmj9uCCmtHT1Bo=;
        b=XScPoJUAWx34hkIkSERz+bSpZZRlpD53jsSbaYt4yApoFrUldSm6lLA7OPWJWngWTQqPxC
        CaLlnvjZrOlbQcbv0KwbrJMex/7fTyxntsJAE/XqD74VEBtricHqucVF/zSmy1nLHZHixj
        5EAjt6Oxnyofoc64eV06PZHp2Gme2XlfnzP5XPL9a5HWnacoDxwjrIzVLWpXcz86uw/1mr
        nyJHaQhJMnhmDDsgJVAxYbNMDxc3RtgxV+Z2iWXlXAcQvmigWdb1o0NOrVSXB5q2dn6yFG
        rjffETVuospK/lIXV5+pi4zR9aF7KCW1BmhFyfbOLloeqP6uPeUn2K8ono58Zw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1634737471;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=LQIvKqBuCuv1kp87DLnptzkLyxe3zhmj9uCCmtHT1Bo=;
        b=UVX18xE85T0IthtP3iAbvGJE7e/5JVCzfOQdJ4ECdEJuzabDH2uyCE3gQj2KkBMTF7caDQ
        PKkiAtSgJGgXcPBg==
From:   "tip-bot2 for Thomas Gleixner" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fpu] x86/fpu: Remove internal.h dependency from fpu/signal.h
Cc:     kernel test robot <lkp@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20211015011539.844565975@linutronix.de>
References: <20211015011539.844565975@linutronix.de>
MIME-Version: 1.0
Message-ID: <163473747002.25758.1335312701034555054.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fpu branch of tip:

Commit-ID:     0ae67cc34f765078a63137120e4567ad2f050b75
Gitweb:        https://git.kernel.org/tip/0ae67cc34f765078a63137120e4567ad2f050b75
Author:        Thomas Gleixner <tglx@linutronix.de>
AuthorDate:    Fri, 15 Oct 2021 03:16:35 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Wed, 20 Oct 2021 15:27:29 +02:00

x86/fpu: Remove internal.h dependency from fpu/signal.h

In order to remove internal.h make signal.h independent of it.

Include asm/fpu/xstate.h to fix a missing update_regset_xstate_info()
prototype, which is
Reported-by: kernel test robot <lkp@intel.com>

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20211015011539.844565975@linutronix.de
---
 arch/x86/ia32/ia32_signal.c         |  1 -
 arch/x86/include/asm/fpu/api.h      |  3 +++
 arch/x86/include/asm/fpu/internal.h |  7 -------
 arch/x86/include/asm/fpu/signal.h   | 13 +++++++++++++
 arch/x86/kernel/fpu/signal.c        |  1 -
 arch/x86/kernel/ptrace.c            |  2 +-
 arch/x86/kernel/signal.c            |  1 -
 arch/x86/mm/extable.c               |  3 ++-
 8 files changed, 19 insertions(+), 12 deletions(-)

diff --git a/arch/x86/ia32/ia32_signal.c b/arch/x86/ia32/ia32_signal.c
index 828ab0a..c9c3859 100644
--- a/arch/x86/ia32/ia32_signal.c
+++ b/arch/x86/ia32/ia32_signal.c
@@ -24,7 +24,6 @@
 #include <linux/syscalls.h>
 #include <asm/ucontext.h>
 #include <linux/uaccess.h>
-#include <asm/fpu/internal.h>
 #include <asm/fpu/signal.h>
 #include <asm/ptrace.h>
 #include <asm/ia32_unistd.h>
diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
index 56cf884..17893af 100644
--- a/arch/x86/include/asm/fpu/api.h
+++ b/arch/x86/include/asm/fpu/api.h
@@ -116,6 +116,9 @@ extern void fpstate_init_soft(struct swregs_state *soft);
 static inline void fpstate_init_soft(struct swregs_state *soft) {}
 #endif
 
+/* State tracking */
+DECLARE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
+
 /* fpstate */
 extern union fpregs_state init_fpstate;
 
diff --git a/arch/x86/include/asm/fpu/internal.h b/arch/x86/include/asm/fpu/internal.h
index d8bb491..8f97d3e 100644
--- a/arch/x86/include/asm/fpu/internal.h
+++ b/arch/x86/include/asm/fpu/internal.h
@@ -26,7 +26,6 @@
 /*
  * High level FPU state handling functions:
  */
-extern bool fpu__restore_sig(void __user *buf, int ia32_frame);
 extern void fpu__clear_user_states(struct fpu *fpu);
 extern int  fpu__exception_code(struct fpu *fpu, int trap_nr);
 
@@ -42,10 +41,4 @@ extern void fpu__init_system(struct cpuinfo_x86 *c);
 extern void fpu__init_check_bugs(void);
 extern void fpu__resume_cpu(void);
 
-extern void restore_fpregs_from_fpstate(union fpregs_state *fpstate, u64 mask);
-
-extern bool copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int size);
-
-DECLARE_PER_CPU(struct fpu *, fpu_fpregs_owner_ctx);
-
 #endif /* _ASM_X86_FPU_INTERNAL_H */
diff --git a/arch/x86/include/asm/fpu/signal.h b/arch/x86/include/asm/fpu/signal.h
index 04868a7..9a63a21 100644
--- a/arch/x86/include/asm/fpu/signal.h
+++ b/arch/x86/include/asm/fpu/signal.h
@@ -5,6 +5,11 @@
 #ifndef _ASM_X86_FPU_SIGNAL_H
 #define _ASM_X86_FPU_SIGNAL_H
 
+#include <linux/compat.h>
+#include <linux/user.h>
+
+#include <asm/fpu/types.h>
+
 #ifdef CONFIG_X86_64
 # include <uapi/asm/sigcontext.h>
 # include <asm/user32.h>
@@ -31,4 +36,12 @@ fpu__alloc_mathframe(unsigned long sp, int ia32_frame,
 
 unsigned long fpu__get_fpstate_size(void);
 
+extern bool copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int size);
+extern void fpu__clear_user_states(struct fpu *fpu);
+extern bool fpu__restore_sig(void __user *buf, int ia32_frame);
+
+extern void restore_fpregs_from_fpstate(union fpregs_state *fpstate, u64 mask);
+
+extern bool copy_fpstate_to_sigframe(void __user *buf, void __user *fp, int size);
+
 #endif /* _ASM_X86_FPU_SIGNAL_H */
diff --git a/arch/x86/kernel/fpu/signal.c b/arch/x86/kernel/fpu/signal.c
index 32dbcde..274cd58 100644
--- a/arch/x86/kernel/fpu/signal.c
+++ b/arch/x86/kernel/fpu/signal.c
@@ -7,7 +7,6 @@
 #include <linux/cpu.h>
 #include <linux/pagemap.h>
 
-#include <asm/fpu/internal.h>
 #include <asm/fpu/signal.h>
 #include <asm/fpu/regset.h>
 #include <asm/fpu/xstate.h>
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 4c208ea..6d2244c 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -29,9 +29,9 @@
 
 #include <linux/uaccess.h>
 #include <asm/processor.h>
-#include <asm/fpu/internal.h>
 #include <asm/fpu/signal.h>
 #include <asm/fpu/regset.h>
+#include <asm/fpu/xstate.h>
 #include <asm/debugreg.h>
 #include <asm/ldt.h>
 #include <asm/desc.h>
diff --git a/arch/x86/kernel/signal.c b/arch/x86/kernel/signal.c
index 02ee68e..58bd070 100644
--- a/arch/x86/kernel/signal.c
+++ b/arch/x86/kernel/signal.c
@@ -30,7 +30,6 @@
 
 #include <asm/processor.h>
 #include <asm/ucontext.h>
-#include <asm/fpu/internal.h>
 #include <asm/fpu/signal.h>
 #include <asm/vdso.h>
 #include <asm/mce.h>
diff --git a/arch/x86/mm/extable.c b/arch/x86/mm/extable.c
index 043ec38..79c2e30 100644
--- a/arch/x86/mm/extable.c
+++ b/arch/x86/mm/extable.c
@@ -4,7 +4,8 @@
 #include <linux/sched/debug.h>
 #include <xen/xen.h>
 
-#include <asm/fpu/internal.h>
+#include <asm/fpu/signal.h>
+#include <asm/fpu/xstate.h>
 #include <asm/sev.h>
 #include <asm/traps.h>
 #include <asm/kdebug.h>
