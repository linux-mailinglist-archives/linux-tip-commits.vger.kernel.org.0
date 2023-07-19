Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C79575A233
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 Jul 2023 00:47:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230321AbjGSWrh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 19 Jul 2023 18:47:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjGSWrc (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 19 Jul 2023 18:47:32 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C69F1FF9;
        Wed, 19 Jul 2023 15:47:29 -0700 (PDT)
Date:   Wed, 19 Jul 2023 22:47:27 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1689806847;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=npG77xGBJ3PocLgMU1SoHgVQkoK3cz9mMpKKZcK4ytM=;
        b=ONaJnZwsHztFQOuNxKz7FHNLngPGnKiWlIzRyxncMRmkYt4BNG9qp/w2BPJt9CQyls6ATu
        5ynIbnfPpq/2qgxZ2LHJwmzhPv1vzLUBT1RLYfWdkABkM4Q/ChiJ9zSH7mUsnWjXbFJcLN
        xosB24fTfRI2G0NWfjTRh23iBEXSOnReNUV4gVRT34n8kolRkAJVU9iOqeO9UR9uMVb+Os
        leDlNApIeQ4fbNvphCUGbTRbVEdkgDoOC2QQIfyEWpMIdZ0u7eQGWLFShaSfc70RGU+lVB
        lJxIZ6cBG3Ma19MXb3LQI9Lh3/MpTHR0o0f7ydM7/yiXHDDv9h18k99mzlNlzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1689806847;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=npG77xGBJ3PocLgMU1SoHgVQkoK3cz9mMpKKZcK4ytM=;
        b=QTfxM6c8PdFz35ItB2Z628oewKAvRB67ow1AtQy0uAVp06b1PyPA49Bvl3ThsljqZfX7FL
        a2dcfpMtMoSaiSAw==
From:   "tip-bot2 for Rick Edgecombe" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/shstk] selftests/x86: Add shadow stack test
Cc:     "Yu-cheng Yu" <yu-cheng.yu@intel.com>,
        Rick Edgecombe <rick.p.edgecombe@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "Mike Rapoport (IBM)" <rppt@kernel.org>,
        Pengfei Xu <pengfei.xu@intel.com>,
        John Allen <john.allen@amd.com>,
        Kees Cook <keescook@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <168980684710.28540.2834377400291598752.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/shstk branch of tip:

Commit-ID:     3e28f4c53284c092f7915f75e20d6ab4083270f5
Gitweb:        https://git.kernel.org/tip/3e28f4c53284c092f7915f75e20d6ab4083270f5
Author:        Rick Edgecombe <rick.p.edgecombe@intel.com>
AuthorDate:    Mon, 12 Jun 2023 17:11:05 -07:00
Committer:     Rick Edgecombe <rick.p.edgecombe@intel.com>
CommitterDate: Tue, 11 Jul 2023 14:14:15 -07:00

selftests/x86: Add shadow stack test

Add a simple selftest for exercising some shadow stack behavior:
 - map_shadow_stack syscall and pivot
 - Faulting in shadow stack memory
 - Handling shadow stack violations
 - GUP of shadow stack memory
 - mprotect() of shadow stack memory
 - Userfaultfd on shadow stack memory
 - 32 bit segmentation
 - Guard gap test
 - Ptrace test

Co-developed-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Yu-cheng Yu <yu-cheng.yu@intel.com>
Signed-off-by: Rick Edgecombe <rick.p.edgecombe@intel.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Mike Rapoport (IBM) <rppt@kernel.org>
Tested-by: Pengfei Xu <pengfei.xu@intel.com>
Tested-by: John Allen <john.allen@amd.com>
Tested-by: Kees Cook <keescook@chromium.org>
Link: https://lore.kernel.org/all/20230613001108.3040476-40-rick.p.edgecombe%40intel.com
---
 tools/testing/selftests/x86/Makefile            |   2 +-
 tools/testing/selftests/x86/test_shadow_stack.c | 884 +++++++++++++++-
 2 files changed, 885 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/x86/test_shadow_stack.c

diff --git a/tools/testing/selftests/x86/Makefile b/tools/testing/selftests/x86/Makefile
index 598135d..7e8c937 100644
--- a/tools/testing/selftests/x86/Makefile
+++ b/tools/testing/selftests/x86/Makefile
@@ -18,7 +18,7 @@ TARGETS_C_32BIT_ONLY := entry_from_vm86 test_syscall_vdso unwind_vdso \
 			test_FCMOV test_FCOMI test_FISTTP \
 			vdso_restorer
 TARGETS_C_64BIT_ONLY := fsgsbase sysret_rip syscall_numbering \
-			corrupt_xstate_header amx lam
+			corrupt_xstate_header amx lam test_shadow_stack
 # Some selftests require 32bit support enabled also on 64bit systems
 TARGETS_C_32BIT_NEEDED := ldt_gdt ptrace_syscall
 
diff --git a/tools/testing/selftests/x86/test_shadow_stack.c b/tools/testing/selftests/x86/test_shadow_stack.c
new file mode 100644
index 0000000..2188968
--- /dev/null
+++ b/tools/testing/selftests/x86/test_shadow_stack.c
@@ -0,0 +1,884 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This program test's basic kernel shadow stack support. It enables shadow
+ * stack manual via the arch_prctl(), instead of relying on glibc. It's
+ * Makefile doesn't compile with shadow stack support, so it doesn't rely on
+ * any particular glibc. As a result it can't do any operations that require
+ * special glibc shadow stack support (longjmp(), swapcontext(), etc). Just
+ * stick to the basics and hope the compiler doesn't do anything strange.
+ */
+
+#define _GNU_SOURCE
+
+#include <sys/syscall.h>
+#include <asm/mman.h>
+#include <sys/mman.h>
+#include <sys/stat.h>
+#include <sys/wait.h>
+#include <stdio.h>
+#include <stdlib.h>
+#include <fcntl.h>
+#include <unistd.h>
+#include <string.h>
+#include <errno.h>
+#include <stdbool.h>
+#include <x86intrin.h>
+#include <asm/prctl.h>
+#include <sys/prctl.h>
+#include <stdint.h>
+#include <signal.h>
+#include <pthread.h>
+#include <sys/ioctl.h>
+#include <linux/userfaultfd.h>
+#include <setjmp.h>
+#include <sys/ptrace.h>
+#include <sys/signal.h>
+#include <linux/elf.h>
+
+/*
+ * Define the ABI defines if needed, so people can run the tests
+ * without building the headers.
+ */
+#ifndef __NR_map_shadow_stack
+#define __NR_map_shadow_stack	452
+
+#define SHADOW_STACK_SET_TOKEN	(1ULL << 0)
+
+#define ARCH_SHSTK_ENABLE	0x5001
+#define ARCH_SHSTK_DISABLE	0x5002
+#define ARCH_SHSTK_LOCK		0x5003
+#define ARCH_SHSTK_UNLOCK	0x5004
+#define ARCH_SHSTK_STATUS	0x5005
+
+#define ARCH_SHSTK_SHSTK	(1ULL <<  0)
+#define ARCH_SHSTK_WRSS		(1ULL <<  1)
+
+#define NT_X86_SHSTK	0x204
+#endif
+
+#define SS_SIZE 0x200000
+#define PAGE_SIZE 0x1000
+
+#if (__GNUC__ < 8) || (__GNUC__ == 8 && __GNUC_MINOR__ < 5)
+int main(int argc, char *argv[])
+{
+	printf("[SKIP]\tCompiler does not support CET.\n");
+	return 0;
+}
+#else
+void write_shstk(unsigned long *addr, unsigned long val)
+{
+	asm volatile("wrssq %[val], (%[addr])\n"
+		     : "=m" (addr)
+		     : [addr] "r" (addr), [val] "r" (val));
+}
+
+static inline unsigned long __attribute__((always_inline)) get_ssp(void)
+{
+	unsigned long ret = 0;
+
+	asm volatile("xor %0, %0; rdsspq %0" : "=r" (ret));
+	return ret;
+}
+
+/*
+ * For use in inline enablement of shadow stack.
+ *
+ * The program can't return from the point where shadow stack gets enabled
+ * because there will be no address on the shadow stack. So it can't use
+ * syscall() for enablement, since it is a function.
+ *
+ * Based on code from nolibc.h. Keep a copy here because this can't pull in all
+ * of nolibc.h.
+ */
+#define ARCH_PRCTL(arg1, arg2)					\
+({								\
+	long _ret;						\
+	register long _num  asm("eax") = __NR_arch_prctl;	\
+	register long _arg1 asm("rdi") = (long)(arg1);		\
+	register long _arg2 asm("rsi") = (long)(arg2);		\
+								\
+	asm volatile (						\
+		"syscall\n"					\
+		: "=a"(_ret)					\
+		: "r"(_arg1), "r"(_arg2),			\
+		  "0"(_num)					\
+		: "rcx", "r11", "memory", "cc"			\
+	);							\
+	_ret;							\
+})
+
+void *create_shstk(void *addr)
+{
+	return (void *)syscall(__NR_map_shadow_stack, addr, SS_SIZE, SHADOW_STACK_SET_TOKEN);
+}
+
+void *create_normal_mem(void *addr)
+{
+	return mmap(addr, SS_SIZE, PROT_READ | PROT_WRITE,
+		    MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+}
+
+void free_shstk(void *shstk)
+{
+	munmap(shstk, SS_SIZE);
+}
+
+int reset_shstk(void *shstk)
+{
+	return madvise(shstk, SS_SIZE, MADV_DONTNEED);
+}
+
+void try_shstk(unsigned long new_ssp)
+{
+	unsigned long ssp;
+
+	printf("[INFO]\tnew_ssp = %lx, *new_ssp = %lx\n",
+	       new_ssp, *((unsigned long *)new_ssp));
+
+	ssp = get_ssp();
+	printf("[INFO]\tchanging ssp from %lx to %lx\n", ssp, new_ssp);
+
+	asm volatile("rstorssp (%0)\n":: "r" (new_ssp));
+	asm volatile("saveprevssp");
+	printf("[INFO]\tssp is now %lx\n", get_ssp());
+
+	/* Switch back to original shadow stack */
+	ssp -= 8;
+	asm volatile("rstorssp (%0)\n":: "r" (ssp));
+	asm volatile("saveprevssp");
+}
+
+int test_shstk_pivot(void)
+{
+	void *shstk = create_shstk(0);
+
+	if (shstk == MAP_FAILED) {
+		printf("[FAIL]\tError creating shadow stack: %d\n", errno);
+		return 1;
+	}
+	try_shstk((unsigned long)shstk + SS_SIZE - 8);
+	free_shstk(shstk);
+
+	printf("[OK]\tShadow stack pivot\n");
+	return 0;
+}
+
+int test_shstk_faults(void)
+{
+	unsigned long *shstk = create_shstk(0);
+
+	/* Read shadow stack, test if it's zero to not get read optimized out */
+	if (*shstk != 0)
+		goto err;
+
+	/* Wrss memory that was already read. */
+	write_shstk(shstk, 1);
+	if (*shstk != 1)
+		goto err;
+
+	/* Page out memory, so we can wrss it again. */
+	if (reset_shstk((void *)shstk))
+		goto err;
+
+	write_shstk(shstk, 1);
+	if (*shstk != 1)
+		goto err;
+
+	printf("[OK]\tShadow stack faults\n");
+	return 0;
+
+err:
+	return 1;
+}
+
+unsigned long saved_ssp;
+unsigned long saved_ssp_val;
+volatile bool segv_triggered;
+
+void __attribute__((noinline)) violate_ss(void)
+{
+	saved_ssp = get_ssp();
+	saved_ssp_val = *(unsigned long *)saved_ssp;
+
+	/* Corrupt shadow stack */
+	printf("[INFO]\tCorrupting shadow stack\n");
+	write_shstk((void *)saved_ssp, 0);
+}
+
+void segv_handler(int signum, siginfo_t *si, void *uc)
+{
+	printf("[INFO]\tGenerated shadow stack violation successfully\n");
+
+	segv_triggered = true;
+
+	/* Fix shadow stack */
+	write_shstk((void *)saved_ssp, saved_ssp_val);
+}
+
+int test_shstk_violation(void)
+{
+	struct sigaction sa = {};
+
+	sa.sa_sigaction = segv_handler;
+	sa.sa_flags = SA_SIGINFO;
+	if (sigaction(SIGSEGV, &sa, NULL))
+		return 1;
+
+	segv_triggered = false;
+
+	/* Make sure segv_triggered is set before violate_ss() */
+	asm volatile("" : : : "memory");
+
+	violate_ss();
+
+	signal(SIGSEGV, SIG_DFL);
+
+	printf("[OK]\tShadow stack violation test\n");
+
+	return !segv_triggered;
+}
+
+/* Gup test state */
+#define MAGIC_VAL 0x12345678
+bool is_shstk_access;
+void *shstk_ptr;
+int fd;
+
+void reset_test_shstk(void *addr)
+{
+	if (shstk_ptr)
+		free_shstk(shstk_ptr);
+	shstk_ptr = create_shstk(addr);
+}
+
+void test_access_fix_handler(int signum, siginfo_t *si, void *uc)
+{
+	printf("[INFO]\tViolation from %s\n", is_shstk_access ? "shstk access" : "normal write");
+
+	segv_triggered = true;
+
+	/* Fix shadow stack */
+	if (is_shstk_access) {
+		reset_test_shstk(shstk_ptr);
+		return;
+	}
+
+	free_shstk(shstk_ptr);
+	create_normal_mem(shstk_ptr);
+}
+
+bool test_shstk_access(void *ptr)
+{
+	is_shstk_access = true;
+	segv_triggered = false;
+	write_shstk(ptr, MAGIC_VAL);
+
+	asm volatile("" : : : "memory");
+
+	return segv_triggered;
+}
+
+bool test_write_access(void *ptr)
+{
+	is_shstk_access = false;
+	segv_triggered = false;
+	*(unsigned long *)ptr = MAGIC_VAL;
+
+	asm volatile("" : : : "memory");
+
+	return segv_triggered;
+}
+
+bool gup_write(void *ptr)
+{
+	unsigned long val;
+
+	lseek(fd, (unsigned long)ptr, SEEK_SET);
+	if (write(fd, &val, sizeof(val)) < 0)
+		return 1;
+
+	return 0;
+}
+
+bool gup_read(void *ptr)
+{
+	unsigned long val;
+
+	lseek(fd, (unsigned long)ptr, SEEK_SET);
+	if (read(fd, &val, sizeof(val)) < 0)
+		return 1;
+
+	return 0;
+}
+
+int test_gup(void)
+{
+	struct sigaction sa = {};
+	int status;
+	pid_t pid;
+
+	sa.sa_sigaction = test_access_fix_handler;
+	sa.sa_flags = SA_SIGINFO;
+	if (sigaction(SIGSEGV, &sa, NULL))
+		return 1;
+
+	segv_triggered = false;
+
+	fd = open("/proc/self/mem", O_RDWR);
+	if (fd == -1)
+		return 1;
+
+	reset_test_shstk(0);
+	if (gup_read(shstk_ptr))
+		return 1;
+	if (test_shstk_access(shstk_ptr))
+		return 1;
+	printf("[INFO]\tGup read -> shstk access success\n");
+
+	reset_test_shstk(0);
+	if (gup_write(shstk_ptr))
+		return 1;
+	if (test_shstk_access(shstk_ptr))
+		return 1;
+	printf("[INFO]\tGup write -> shstk access success\n");
+
+	reset_test_shstk(0);
+	if (gup_read(shstk_ptr))
+		return 1;
+	if (!test_write_access(shstk_ptr))
+		return 1;
+	printf("[INFO]\tGup read -> write access success\n");
+
+	reset_test_shstk(0);
+	if (gup_write(shstk_ptr))
+		return 1;
+	if (!test_write_access(shstk_ptr))
+		return 1;
+	printf("[INFO]\tGup write -> write access success\n");
+
+	close(fd);
+
+	/* COW/gup test */
+	reset_test_shstk(0);
+	pid = fork();
+	if (!pid) {
+		fd = open("/proc/self/mem", O_RDWR);
+		if (fd == -1)
+			exit(1);
+
+		if (gup_write(shstk_ptr)) {
+			close(fd);
+			exit(1);
+		}
+		close(fd);
+		exit(0);
+	}
+	waitpid(pid, &status, 0);
+	if (WEXITSTATUS(status)) {
+		printf("[FAIL]\tWrite in child failed\n");
+		return 1;
+	}
+	if (*(unsigned long *)shstk_ptr == MAGIC_VAL) {
+		printf("[FAIL]\tWrite in child wrote through to shared memory\n");
+		return 1;
+	}
+
+	printf("[INFO]\tCow gup write -> write access success\n");
+
+	free_shstk(shstk_ptr);
+
+	signal(SIGSEGV, SIG_DFL);
+
+	printf("[OK]\tShadow gup test\n");
+
+	return 0;
+}
+
+int test_mprotect(void)
+{
+	struct sigaction sa = {};
+
+	sa.sa_sigaction = test_access_fix_handler;
+	sa.sa_flags = SA_SIGINFO;
+	if (sigaction(SIGSEGV, &sa, NULL))
+		return 1;
+
+	segv_triggered = false;
+
+	/* mprotect a shadow stack as read only */
+	reset_test_shstk(0);
+	if (mprotect(shstk_ptr, SS_SIZE, PROT_READ) < 0) {
+		printf("[FAIL]\tmprotect(PROT_READ) failed\n");
+		return 1;
+	}
+
+	/* try to wrss it and fail */
+	if (!test_shstk_access(shstk_ptr)) {
+		printf("[FAIL]\tShadow stack access to read-only memory succeeded\n");
+		return 1;
+	}
+
+	/*
+	 * The shadow stack was reset above to resolve the fault, make the new one
+	 * read-only.
+	 */
+	if (mprotect(shstk_ptr, SS_SIZE, PROT_READ) < 0) {
+		printf("[FAIL]\tmprotect(PROT_READ) failed\n");
+		return 1;
+	}
+
+	/* then back to writable */
+	if (mprotect(shstk_ptr, SS_SIZE, PROT_WRITE | PROT_READ) < 0) {
+		printf("[FAIL]\tmprotect(PROT_WRITE) failed\n");
+		return 1;
+	}
+
+	/* then wrss to it and succeed */
+	if (test_shstk_access(shstk_ptr)) {
+		printf("[FAIL]\tShadow stack access to mprotect() writable memory failed\n");
+		return 1;
+	}
+
+	free_shstk(shstk_ptr);
+
+	signal(SIGSEGV, SIG_DFL);
+
+	printf("[OK]\tmprotect() test\n");
+
+	return 0;
+}
+
+char zero[4096];
+
+static void *uffd_thread(void *arg)
+{
+	struct uffdio_copy req;
+	int uffd = *(int *)arg;
+	struct uffd_msg msg;
+	int ret;
+
+	while (1) {
+		ret = read(uffd, &msg, sizeof(msg));
+		if (ret > 0)
+			break;
+		else if (errno == EAGAIN)
+			continue;
+		return (void *)1;
+	}
+
+	req.dst = msg.arg.pagefault.address;
+	req.src = (__u64)zero;
+	req.len = 4096;
+	req.mode = 0;
+
+	if (ioctl(uffd, UFFDIO_COPY, &req))
+		return (void *)1;
+
+	return (void *)0;
+}
+
+int test_userfaultfd(void)
+{
+	struct uffdio_register uffdio_register;
+	struct uffdio_api uffdio_api;
+	struct sigaction sa = {};
+	pthread_t thread;
+	void *res;
+	int uffd;
+
+	sa.sa_sigaction = test_access_fix_handler;
+	sa.sa_flags = SA_SIGINFO;
+	if (sigaction(SIGSEGV, &sa, NULL))
+		return 1;
+
+	uffd = syscall(__NR_userfaultfd, O_CLOEXEC | O_NONBLOCK);
+	if (uffd < 0) {
+		printf("[SKIP]\tUserfaultfd unavailable.\n");
+		return 0;
+	}
+
+	reset_test_shstk(0);
+
+	uffdio_api.api = UFFD_API;
+	uffdio_api.features = 0;
+	if (ioctl(uffd, UFFDIO_API, &uffdio_api))
+		goto err;
+
+	uffdio_register.range.start = (__u64)shstk_ptr;
+	uffdio_register.range.len = 4096;
+	uffdio_register.mode = UFFDIO_REGISTER_MODE_MISSING;
+	if (ioctl(uffd, UFFDIO_REGISTER, &uffdio_register))
+		goto err;
+
+	if (pthread_create(&thread, NULL, &uffd_thread, &uffd))
+		goto err;
+
+	reset_shstk(shstk_ptr);
+	test_shstk_access(shstk_ptr);
+
+	if (pthread_join(thread, &res))
+		goto err;
+
+	if (test_shstk_access(shstk_ptr))
+		goto err;
+
+	free_shstk(shstk_ptr);
+
+	signal(SIGSEGV, SIG_DFL);
+
+	if (!res)
+		printf("[OK]\tUserfaultfd test\n");
+	return !!res;
+err:
+	free_shstk(shstk_ptr);
+	close(uffd);
+	signal(SIGSEGV, SIG_DFL);
+	return 1;
+}
+
+/* Simple linked list for keeping track of mappings in test_guard_gap() */
+struct node {
+	struct node *next;
+	void *mapping;
+};
+
+/*
+ * This tests whether mmap will place other mappings in a shadow stack's guard
+ * gap. The steps are:
+ *   1. Finds an empty place by mapping and unmapping something.
+ *   2. Map a shadow stack in the middle of the known empty area.
+ *   3. Map a bunch of PAGE_SIZE mappings. These will use the search down
+ *      direction, filling any gaps until it encounters the shadow stack's
+ *      guard gap.
+ *   4. When a mapping lands below the shadow stack from step 2, then all
+ *      of the above gaps are filled. The search down algorithm will have
+ *      looked at the shadow stack gaps.
+ *   5. See if it landed in the gap.
+ */
+int test_guard_gap(void)
+{
+	void *free_area, *shstk, *test_map = (void *)0xFFFFFFFFFFFFFFFF;
+	struct node *head = NULL, *cur;
+
+	free_area = mmap(0, SS_SIZE * 3, PROT_READ | PROT_WRITE,
+			 MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	munmap(free_area, SS_SIZE * 3);
+
+	shstk = create_shstk(free_area + SS_SIZE);
+	if (shstk == MAP_FAILED)
+		return 1;
+
+	while (test_map > shstk) {
+		test_map = mmap(0, PAGE_SIZE, PROT_READ | PROT_WRITE,
+				MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+		if (test_map == MAP_FAILED)
+			return 1;
+		cur = malloc(sizeof(*cur));
+		cur->mapping = test_map;
+
+		cur->next = head;
+		head = cur;
+	}
+
+	while (head) {
+		cur = head;
+		head = cur->next;
+		munmap(cur->mapping, PAGE_SIZE);
+		free(cur);
+	}
+
+	free_shstk(shstk);
+
+	if (shstk - test_map - PAGE_SIZE != PAGE_SIZE)
+		return 1;
+
+	printf("[OK]\tGuard gap test\n");
+
+	return 0;
+}
+
+/*
+ * Too complicated to pull it out of the 32 bit header, but also get the
+ * 64 bit one needed above. Just define a copy here.
+ */
+#define __NR_compat_sigaction 67
+
+/*
+ * Call 32 bit signal handler to get 32 bit signals ABI. Make sure
+ * to push the registers that will get clobbered.
+ */
+int sigaction32(int signum, const struct sigaction *restrict act,
+		struct sigaction *restrict oldact)
+{
+	register long syscall_reg asm("eax") = __NR_compat_sigaction;
+	register long signum_reg asm("ebx") = signum;
+	register long act_reg asm("ecx") = (long)act;
+	register long oldact_reg asm("edx") = (long)oldact;
+	int ret = 0;
+
+	asm volatile ("int $0x80;"
+		      : "=a"(ret), "=m"(oldact)
+		      : "r"(syscall_reg), "r"(signum_reg), "r"(act_reg),
+			"r"(oldact_reg)
+		      : "r8", "r9", "r10", "r11"
+		     );
+
+	return ret;
+}
+
+sigjmp_buf jmp_buffer;
+
+void segv_gp_handler(int signum, siginfo_t *si, void *uc)
+{
+	segv_triggered = true;
+
+	/*
+	 * To work with old glibc, this can't rely on siglongjmp working with
+	 * shadow stack enabled, so disable shadow stack before siglongjmp().
+	 */
+	ARCH_PRCTL(ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK);
+	siglongjmp(jmp_buffer, -1);
+}
+
+/*
+ * Transition to 32 bit mode and check that a #GP triggers a segfault.
+ */
+int test_32bit(void)
+{
+	struct sigaction sa = {};
+	struct sigaction *sa32;
+
+	/* Create sigaction in 32 bit address range */
+	sa32 = mmap(0, 4096, PROT_READ | PROT_WRITE,
+		    MAP_32BIT | MAP_PRIVATE | MAP_ANONYMOUS, 0, 0);
+	sa32->sa_flags = SA_SIGINFO;
+
+	sa.sa_sigaction = segv_gp_handler;
+	sa.sa_flags = SA_SIGINFO;
+	if (sigaction(SIGSEGV, &sa, NULL))
+		return 1;
+
+
+	segv_triggered = false;
+
+	/* Make sure segv_triggered is set before triggering the #GP */
+	asm volatile("" : : : "memory");
+
+	/*
+	 * Set handler to somewhere in 32 bit address space
+	 */
+	sa32->sa_handler = (void *)sa32;
+	if (sigaction32(SIGUSR1, sa32, NULL))
+		return 1;
+
+	if (!sigsetjmp(jmp_buffer, 1))
+		raise(SIGUSR1);
+
+	if (segv_triggered)
+		printf("[OK]\t32 bit test\n");
+
+	return !segv_triggered;
+}
+
+void segv_handler_ptrace(int signum, siginfo_t *si, void *uc)
+{
+	/* The SSP adjustment caused a segfault. */
+	exit(0);
+}
+
+int test_ptrace(void)
+{
+	unsigned long saved_ssp, ssp = 0;
+	struct sigaction sa= {};
+	struct iovec iov;
+	int status;
+	int pid;
+
+	iov.iov_base = &ssp;
+	iov.iov_len = sizeof(ssp);
+
+	pid = fork();
+	if (!pid) {
+		ssp = get_ssp();
+
+		sa.sa_sigaction = segv_handler_ptrace;
+		sa.sa_flags = SA_SIGINFO;
+		if (sigaction(SIGSEGV, &sa, NULL))
+			return 1;
+
+		ptrace(PTRACE_TRACEME, NULL, NULL, NULL);
+		/*
+		 * The parent will tweak the SSP and return from this function
+		 * will #CP.
+		 */
+		raise(SIGTRAP);
+
+		exit(1);
+	}
+
+	while (waitpid(pid, &status, 0) != -1 && WSTOPSIG(status) != SIGTRAP);
+
+	if (ptrace(PTRACE_GETREGSET, pid, NT_X86_SHSTK, &iov)) {
+		printf("[INFO]\tFailed to PTRACE_GETREGS\n");
+		goto out_kill;
+	}
+
+	if (!ssp) {
+		printf("[INFO]\tPtrace child SSP was 0\n");
+		goto out_kill;
+	}
+
+	saved_ssp = ssp;
+
+	iov.iov_len = 0;
+	if (!ptrace(PTRACE_SETREGSET, pid, NT_X86_SHSTK, &iov)) {
+		printf("[INFO]\tToo small size accepted via PTRACE_SETREGS\n");
+		goto out_kill;
+	}
+
+	iov.iov_len = sizeof(ssp) + 1;
+	if (!ptrace(PTRACE_SETREGSET, pid, NT_X86_SHSTK, &iov)) {
+		printf("[INFO]\tToo large size accepted via PTRACE_SETREGS\n");
+		goto out_kill;
+	}
+
+	ssp += 1;
+	if (!ptrace(PTRACE_SETREGSET, pid, NT_X86_SHSTK, &iov)) {
+		printf("[INFO]\tUnaligned SSP written via PTRACE_SETREGS\n");
+		goto out_kill;
+	}
+
+	ssp = 0xFFFFFFFFFFFF0000;
+	if (!ptrace(PTRACE_SETREGSET, pid, NT_X86_SHSTK, &iov)) {
+		printf("[INFO]\tKernel range SSP written via PTRACE_SETREGS\n");
+		goto out_kill;
+	}
+
+	/*
+	 * Tweak the SSP so the child with #CP when it resumes and returns
+	 * from raise()
+	 */
+	ssp = saved_ssp + 8;
+	iov.iov_len = sizeof(ssp);
+	if (ptrace(PTRACE_SETREGSET, pid, NT_X86_SHSTK, &iov)) {
+		printf("[INFO]\tFailed to PTRACE_SETREGS\n");
+		goto out_kill;
+	}
+
+	if (ptrace(PTRACE_DETACH, pid, NULL, NULL)) {
+		printf("[INFO]\tFailed to PTRACE_DETACH\n");
+		goto out_kill;
+	}
+
+	waitpid(pid, &status, 0);
+	if (WEXITSTATUS(status))
+		return 1;
+
+	printf("[OK]\tPtrace test\n");
+	return 0;
+
+out_kill:
+	kill(pid, SIGKILL);
+	return 1;
+}
+
+int main(int argc, char *argv[])
+{
+	int ret = 0;
+
+	if (ARCH_PRCTL(ARCH_SHSTK_ENABLE, ARCH_SHSTK_SHSTK)) {
+		printf("[SKIP]\tCould not enable Shadow stack\n");
+		return 1;
+	}
+
+	if (ARCH_PRCTL(ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK)) {
+		ret = 1;
+		printf("[FAIL]\tDisabling shadow stack failed\n");
+	}
+
+	if (ARCH_PRCTL(ARCH_SHSTK_ENABLE, ARCH_SHSTK_SHSTK)) {
+		printf("[SKIP]\tCould not re-enable Shadow stack\n");
+		return 1;
+	}
+
+	if (ARCH_PRCTL(ARCH_SHSTK_ENABLE, ARCH_SHSTK_WRSS)) {
+		printf("[SKIP]\tCould not enable WRSS\n");
+		ret = 1;
+		goto out;
+	}
+
+	/* Should have succeeded if here, but this is a test, so double check. */
+	if (!get_ssp()) {
+		printf("[FAIL]\tShadow stack disabled\n");
+		return 1;
+	}
+
+	if (test_shstk_pivot()) {
+		ret = 1;
+		printf("[FAIL]\tShadow stack pivot\n");
+		goto out;
+	}
+
+	if (test_shstk_faults()) {
+		ret = 1;
+		printf("[FAIL]\tShadow stack fault test\n");
+		goto out;
+	}
+
+	if (test_shstk_violation()) {
+		ret = 1;
+		printf("[FAIL]\tShadow stack violation test\n");
+		goto out;
+	}
+
+	if (test_gup()) {
+		ret = 1;
+		printf("[FAIL]\tShadow shadow stack gup\n");
+		goto out;
+	}
+
+	if (test_mprotect()) {
+		ret = 1;
+		printf("[FAIL]\tShadow shadow mprotect test\n");
+		goto out;
+	}
+
+	if (test_userfaultfd()) {
+		ret = 1;
+		printf("[FAIL]\tUserfaultfd test\n");
+		goto out;
+	}
+
+	if (test_guard_gap()) {
+		ret = 1;
+		printf("[FAIL]\tGuard gap test\n");
+		goto out;
+	}
+
+	if (test_ptrace()) {
+		ret = 1;
+		printf("[FAIL]\tptrace test\n");
+	}
+
+	if (test_32bit()) {
+		ret = 1;
+		printf("[FAIL]\t32 bit test\n");
+		goto out;
+	}
+
+	return ret;
+
+out:
+	/*
+	 * Disable shadow stack before the function returns, or there will be a
+	 * shadow stack violation.
+	 */
+	if (ARCH_PRCTL(ARCH_SHSTK_DISABLE, ARCH_SHSTK_SHSTK)) {
+		ret = 1;
+		printf("[FAIL]\tDisabling shadow stack failed\n");
+	}
+
+	return ret;
+}
+#endif
