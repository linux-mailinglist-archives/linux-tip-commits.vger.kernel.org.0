Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2FCC210C50
	for <lists+linux-tip-commits@lfdr.de>; Wed,  1 Jul 2020 15:34:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731127AbgGANde (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 1 Jul 2020 09:33:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42056 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730889AbgGANdU (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 1 Jul 2020 09:33:20 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9330CC08C5DB;
        Wed,  1 Jul 2020 06:33:18 -0700 (PDT)
Date:   Wed, 01 Jul 2020 13:33:15 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593610396;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nV5UPlVSRmvJyRUBWyhSuTBEJHhd0yaXBOESqtw5WOQ=;
        b=jUcA5owtUpEziA12gmVjXoJ9SGEZGQSrvKlIkH5msgB0kbIWOV3nNwnr43/PbTV4YElVls
        s0YxyWh4ObhBXbBl01gze6EcuubC8YFnQL2FUL3yOx7Q3twqjVgKonNEH0admjrvCYoVgb
        a4qg8rSNvQp9Rsg35FYnpOF1j0fVhHpJP5gVQmvK3YegZRfJ+X9E2NCNspVLEAMyZ/6kih
        AjMeNBaU7ODvfwHhTPzCNgrOSdDYliso190bpCShi5WeFbFSaF10qw8my6Hn9PufCbC7uE
        bePlwN7H1rIHAbs55nXso5mST5Lo3thKrtsKkZFVdYb+VJU/FyGFvVb9PIpibg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593610396;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nV5UPlVSRmvJyRUBWyhSuTBEJHhd0yaXBOESqtw5WOQ=;
        b=J+CmhYAH9klgYJUzX7dywWx+PqatdXT6zkRmpDdBO/ivMHpozlLX90KJ/o+Ow/kNXGhFrw
        ACpKh5y0w2QqgkDA==
From:   "tip-bot2 for Andy Lutomirski" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/fsgsbase] x86/ptrace: Fix 32-bit PTRACE_SETREGS vs fsbase
 and gsbase
Cc:     Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <229cc6a50ecbb701abd50fe4ddaf0eda888898cd.1593192140.git.luto@kernel.org>
References: <229cc6a50ecbb701abd50fe4ddaf0eda888898cd.1593192140.git.luto@kernel.org>
MIME-Version: 1.0
Message-ID: <159361039565.4006.9146252517585625144.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/fsgsbase branch of tip:

Commit-ID:     40c45904f818c1f6555294ca27afc5fda4f09e68
Gitweb:        https://git.kernel.org/tip/40c45904f818c1f6555294ca27afc5fda4f09e68
Author:        Andy Lutomirski <luto@kernel.org>
AuthorDate:    Fri, 26 Jun 2020 10:24:29 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Wed, 01 Jul 2020 15:27:20 +02:00

x86/ptrace: Fix 32-bit PTRACE_SETREGS vs fsbase and gsbase

Debuggers expect that doing PTRACE_GETREGS, then poking at a tracee
and maybe letting it run for a while, then doing PTRACE_SETREGS will
put the tracee back where it was.  In the specific case of a 32-bit
tracer and tracee, the PTRACE_GETREGS/SETREGS data structure doesn't
have fs_base or gs_base fields, so FSBASE and GSBASE fields are
never stored anywhere.  Everything used to still work because
nonzero FS or GS would result full reloads of the segment registers
when the tracee resumes, and the bases associated with FS==0 or
GS==0 are irrelevant to 32-bit code.

Adding FSGSBASE support broke this: when FSGSBASE is enabled, FSBASE
and GSBASE are now restored independently of FS and GS for all tasks
when context-switched in.  This means that, if a 32-bit tracer
restores a previous state using PTRACE_SETREGS but the tracee's
pre-restore and post-restore bases don't match, then the tracee is
resumed with the wrong base.

Fix it by explicitly loading the base when a 32-bit tracer pokes FS
or GS on a 64-bit kernel.

Also add a test case.

Fixes: 673903495c85 ("x86/process/64: Use FSBSBASE in switch_to() if available")
Signed-off-by: Andy Lutomirski <luto@kernel.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/229cc6a50ecbb701abd50fe4ddaf0eda888898cd.1593192140.git.luto@kernel.org

---
 arch/x86/include/asm/fsgsbase.h                |   2 +-
 arch/x86/kernel/process_64.c                   |   4 +-
 arch/x86/kernel/ptrace.c                       |  43 ++-
 tools/testing/selftests/x86/Makefile           |   2 +-
 tools/testing/selftests/x86/fsgsbase_restore.c | 245 ++++++++++++++++-
 5 files changed, 280 insertions(+), 16 deletions(-)
 create mode 100644 tools/testing/selftests/x86/fsgsbase_restore.c

diff --git a/arch/x86/include/asm/fsgsbase.h b/arch/x86/include/asm/fsgsbase.h
index aefd537..d552646 100644
--- a/arch/x86/include/asm/fsgsbase.h
+++ b/arch/x86/include/asm/fsgsbase.h
@@ -75,6 +75,8 @@ static inline void x86_fsbase_write_cpu(unsigned long fsbase)
 
 extern unsigned long x86_gsbase_read_cpu_inactive(void);
 extern void x86_gsbase_write_cpu_inactive(unsigned long gsbase);
+extern unsigned long x86_fsgsbase_read_task(struct task_struct *task,
+					    unsigned short selector);
 
 #endif /* CONFIG_X86_64 */
 
diff --git a/arch/x86/kernel/process_64.c b/arch/x86/kernel/process_64.c
index d618969..cb8e37d 100644
--- a/arch/x86/kernel/process_64.c
+++ b/arch/x86/kernel/process_64.c
@@ -347,8 +347,8 @@ static __always_inline void x86_fsgsbase_load(struct thread_struct *prev,
 	}
 }
 
-static unsigned long x86_fsgsbase_read_task(struct task_struct *task,
-					    unsigned short selector)
+unsigned long x86_fsgsbase_read_task(struct task_struct *task,
+				     unsigned short selector)
 {
 	unsigned short idx = selector >> 3;
 	unsigned long base;
diff --git a/arch/x86/kernel/ptrace.c b/arch/x86/kernel/ptrace.c
index 1c7646c..3f00648 100644
--- a/arch/x86/kernel/ptrace.c
+++ b/arch/x86/kernel/ptrace.c
@@ -281,17 +281,9 @@ static int set_segment_reg(struct task_struct *task,
 		return -EIO;
 
 	/*
-	 * This function has some ABI oddities.
-	 *
-	 * A 32-bit ptracer probably expects that writing FS or GS will change
-	 * FSBASE or GSBASE respectively.  In the absence of FSGSBASE support,
-	 * this code indeed has that effect.  When FSGSBASE is added, this
-	 * will require a special case.
-	 *
-	 * For existing 64-bit ptracers, writing FS or GS *also* currently
-	 * changes the base if the selector is nonzero the next time the task
-	 * is run.  This behavior may not be needed, and trying to preserve it
-	 * when FSGSBASE is added would be complicated at best.
+	 * Writes to FS and GS will change the stored selector.  Whether
+	 * this changes the segment base as well depends on whether
+	 * FSGSBASE is enabled.
 	 */
 
 	switch (offset) {
@@ -867,14 +859,39 @@ long arch_ptrace(struct task_struct *child, long request,
 static int putreg32(struct task_struct *child, unsigned regno, u32 value)
 {
 	struct pt_regs *regs = task_pt_regs(child);
+	int ret;
 
 	switch (regno) {
 
 	SEG32(cs);
 	SEG32(ds);
 	SEG32(es);
-	SEG32(fs);
-	SEG32(gs);
+
+	/*
+	 * A 32-bit ptracer on a 64-bit kernel expects that writing
+	 * FS or GS will also update the base.  This is needed for
+	 * operations like PTRACE_SETREGS to fully restore a saved
+	 * CPU state.
+	 */
+
+	case offsetof(struct user32, regs.fs):
+		ret = set_segment_reg(child,
+				      offsetof(struct user_regs_struct, fs),
+				      value);
+		if (ret == 0)
+			child->thread.fsbase =
+				x86_fsgsbase_read_task(child, value);
+		return ret;
+
+	case offsetof(struct user32, regs.gs):
+		ret = set_segment_reg(child,
+				      offsetof(struct user_regs_struct, gs),
+				      value);
+		if (ret == 0)
+			child->thread.gsbase =
+				x86_fsgsbase_read_task(child, value);
+		return ret;
+
 	SEG32(ss);
 
 	R32(ebx, bx);
diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 5f16821..3ff9457 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -13,7 +13,7 @@ CAN_BUILD_WITH_NOPIE := $(shell ./check_cc.sh $(CC) trivial_program.c -no-pie)
 TARGETS_C_BOTHBITS := single_step_syscall sysret_ss_attrs syscall_nt test_mremap_vdso \
 			check_initial_reg_state sigreturn iopl ioperm \
 			test_vdso test_vsyscall mov_ss_trap \
-			syscall_arg_fault
+			syscall_arg_fault fsgsbase_restore
 TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
diff --git a/tools/testing/selftests/x86/fsgsbase_restore.c b/tools/testing/selftests/x86/fsgsbase_restore.c
new file mode 100644
index 0000000..6fffadc
--- /dev/null
+++ b/tools/testing/selftests/x86/fsgsbase_restore.c
@@ -0,0 +1,245 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * fsgsbase_restore.c, test ptrace vs fsgsbase
+ * Copyright (c) 2020 Andy Lutomirski
+ *
+ * This test case simulates a tracer redirecting tracee execution to
+ * a function and then restoring tracee state using PTRACE_GETREGS and
+ * PTRACE_SETREGS.  This is similar to what gdb does when doing
+ * 'p func()'.  The catch is that this test has the called function
+ * modify a segment register.  This makes sure that ptrace correctly
+ * restores segment state when using PTRACE_SETREGS.
+ *
+ * This is not part of fsgsbase.c, because that test is 64-bit only.
+ */
+
+#define _GNU_SOURCE
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdbool.h>
+#include <string.h>
+#include <sys/syscall.h>
+#include <unistd.h>
+#include <err.h>
+#include <sys/user.h>
+#include <asm/prctl.h>
+#include <sys/prctl.h>
+#include <asm/ldt.h>
+#include <sys/mman.h>
+#include <stddef.h>
+#include <sys/ptrace.h>
+#include <sys/wait.h>
+#include <stdint.h>
+
+#define EXPECTED_VALUE 0x1337f00d
+
+#ifdef __x86_64__
+# define SEG "%gs"
+#else
+# define SEG "%fs"
+#endif
+
+static unsigned int dereference_seg_base(void)
+{
+	int ret;
+	asm volatile ("mov %" SEG ":(0), %0" : "=rm" (ret));
+	return ret;
+}
+
+static void init_seg(void)
+{
+	unsigned int *target = mmap(
+		NULL, sizeof(unsigned int),
+		PROT_READ | PROT_WRITE,
+		MAP_PRIVATE | MAP_ANONYMOUS | MAP_32BIT, -1, 0);
+	if (target == MAP_FAILED)
+		err(1, "mmap");
+
+	*target = EXPECTED_VALUE;
+
+	printf("\tsegment base address = 0x%lx\n", (unsigned long)target);
+
+	struct user_desc desc = {
+		.entry_number    = 0,
+		.base_addr       = (unsigned int)(uintptr_t)target,
+		.limit           = sizeof(unsigned int) - 1,
+		.seg_32bit       = 1,
+		.contents        = 0, /* Data, grow-up */
+		.read_exec_only  = 0,
+		.limit_in_pages  = 0,
+		.seg_not_present = 0,
+		.useable         = 0
+	};
+	if (syscall(SYS_modify_ldt, 1, &desc, sizeof(desc)) == 0) {
+		printf("\tusing LDT slot 0\n");
+		asm volatile ("mov %0, %" SEG :: "rm" ((unsigned short)0x7));
+	} else {
+		/* No modify_ldt for us (configured out, perhaps) */
+
+		struct user_desc *low_desc = mmap(
+			NULL, sizeof(desc),
+			PROT_READ | PROT_WRITE,
+			MAP_PRIVATE | MAP_ANONYMOUS | MAP_32BIT, -1, 0);
+		memcpy(low_desc, &desc, sizeof(desc));
+
+		low_desc->entry_number = -1;
+
+		/* 32-bit set_thread_area */
+		long ret;
+		asm volatile ("int $0x80"
+			      : "=a" (ret), "+m" (*low_desc)
+			      : "a" (243), "b" (low_desc)
+#ifdef __x86_64__
+			      : "r8", "r9", "r10", "r11"
+#endif
+			);
+		memcpy(&desc, low_desc, sizeof(desc));
+		munmap(low_desc, sizeof(desc));
+
+		if (ret != 0) {
+			printf("[NOTE]\tcould not create a segment -- can't test anything\n");
+			exit(0);
+		}
+		printf("\tusing GDT slot %d\n", desc.entry_number);
+
+		unsigned short sel = (unsigned short)((desc.entry_number << 3) | 0x3);
+		asm volatile ("mov %0, %" SEG :: "rm" (sel));
+	}
+}
+
+static void tracee_zap_segment(void)
+{
+	/*
+	 * The tracer will redirect execution here.  This is meant to
+	 * work like gdb's 'p func()' feature.  The tricky bit is that
+	 * we modify a segment register in order to make sure that ptrace
+	 * can correctly restore segment registers.
+	 */
+	printf("\tTracee: in tracee_zap_segment()\n");
+
+	/*
+	 * Write a nonzero selector with base zero to the segment register.
+	 * Using a null selector would defeat the test on AMD pre-Zen2
+	 * CPUs, as such CPUs don't clear the base when loading a null
+	 * selector.
+	 */
+	unsigned short sel;
+	asm volatile ("mov %%ss, %0\n\t"
+		      "mov %0, %" SEG
+		      : "=rm" (sel));
+
+	pid_t pid = getpid(), tid = syscall(SYS_gettid);
+
+	printf("\tTracee is going back to sleep\n");
+	syscall(SYS_tgkill, pid, tid, SIGSTOP);
+
+	/* Should not get here. */
+	while (true) {
+		printf("[FAIL]\tTracee hit unreachable code\n");
+		pause();
+	}
+}
+
+int main()
+{
+	printf("\tSetting up a segment\n");
+	init_seg();
+
+	unsigned int val = dereference_seg_base();
+	if (val != EXPECTED_VALUE) {
+		printf("[FAIL]\tseg[0] == %x; should be %x\n", val, EXPECTED_VALUE);
+		return 1;
+	}
+	printf("[OK]\tThe segment points to the right place.\n");
+
+	pid_t chld = fork();
+	if (chld < 0)
+		err(1, "fork");
+
+	if (chld == 0) {
+		prctl(PR_SET_PDEATHSIG, SIGKILL, 0, 0, 0, 0);
+
+		if (ptrace(PTRACE_TRACEME, 0, 0, 0) != 0)
+			err(1, "PTRACE_TRACEME");
+
+		pid_t pid = getpid(), tid = syscall(SYS_gettid);
+
+		printf("\tTracee will take a nap until signaled\n");
+		syscall(SYS_tgkill, pid, tid, SIGSTOP);
+
+		printf("\tTracee was resumed.  Will re-check segment.\n");
+
+		val = dereference_seg_base();
+		if (val != EXPECTED_VALUE) {
+			printf("[FAIL]\tseg[0] == %x; should be %x\n", val, EXPECTED_VALUE);
+			exit(1);
+		}
+
+		printf("[OK]\tThe segment points to the right place.\n");
+		exit(0);
+	}
+
+	int status;
+
+	/* Wait for SIGSTOP. */
+	if (waitpid(chld, &status, 0) != chld || !WIFSTOPPED(status))
+		err(1, "waitpid");
+
+	struct user_regs_struct regs;
+
+	if (ptrace(PTRACE_GETREGS, chld, NULL, &regs) != 0)
+		err(1, "PTRACE_GETREGS");
+
+#ifdef __x86_64__
+	printf("\tChild GS=0x%lx, GSBASE=0x%lx\n", (unsigned long)regs.gs, (unsigned long)regs.gs_base);
+#else
+	printf("\tChild FS=0x%lx\n", (unsigned long)regs.xfs);
+#endif
+
+	struct user_regs_struct regs2 = regs;
+#ifdef __x86_64__
+	regs2.rip = (unsigned long)tracee_zap_segment;
+	regs2.rsp -= 128;	/* Don't clobber the redzone. */
+#else
+	regs2.eip = (unsigned long)tracee_zap_segment;
+#endif
+
+	printf("\tTracer: redirecting tracee to tracee_zap_segment()\n");
+	if (ptrace(PTRACE_SETREGS, chld, NULL, &regs2) != 0)
+		err(1, "PTRACE_GETREGS");
+	if (ptrace(PTRACE_CONT, chld, NULL, NULL) != 0)
+		err(1, "PTRACE_GETREGS");
+
+	/* Wait for SIGSTOP. */
+	if (waitpid(chld, &status, 0) != chld || !WIFSTOPPED(status))
+		err(1, "waitpid");
+
+	printf("\tTracer: restoring tracee state\n");
+	if (ptrace(PTRACE_SETREGS, chld, NULL, &regs) != 0)
+		err(1, "PTRACE_GETREGS");
+	if (ptrace(PTRACE_DETACH, chld, NULL, NULL) != 0)
+		err(1, "PTRACE_GETREGS");
+
+	/* Wait for SIGSTOP. */
+	if (waitpid(chld, &status, 0) != chld)
+		err(1, "waitpid");
+
+	if (WIFSIGNALED(status)) {
+		printf("[FAIL]\tTracee crashed\n");
+		return 1;
+	}
+
+	if (!WIFEXITED(status)) {
+		printf("[FAIL]\tTracee stopped for an unexpected reason: %d\n", status);
+		return 1;
+	}
+
+	int exitcode = WEXITSTATUS(status);
+	if (exitcode != 0) {
+		printf("[FAIL]\tTracee reported failure\n");
+		return 1;
+	}
+
+	printf("[OK]\tAll is well.\n");
+	return 0;
+}
