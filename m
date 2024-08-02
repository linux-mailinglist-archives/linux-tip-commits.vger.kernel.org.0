Return-Path: <linux-tip-commits+bounces-1916-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6E63B945E40
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 15:01:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56C0B2838CD
	for <lists+linux-tip-commits@lfdr.de>; Fri,  2 Aug 2024 13:01:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC1EA1E4863;
	Fri,  2 Aug 2024 13:01:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="YO14ctjh";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="tyGTrJH1"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE71B14A0A0;
	Fri,  2 Aug 2024 13:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722603674; cv=none; b=X9to6uS5y0AVVFePpF+VWieGL22dXE0JvmbAq5PUSy/97/oK+ueEG6PBP43z5QvYSskVIlL839Hy58eA0Zd7p1WSLWg3RZ3bf6bhtFrQ6VLdGbvsgweG3WWIekQng+np6uZbER3oUOlsPdKISvXOoa3TN6kkyqWgODEgfGac+1k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722603674; c=relaxed/simple;
	bh=ZA9UC3a+BNOei/vccWUoYIYWn7O8dv1LEtIvuPprSsI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=lf4r7sN4IcSn4nhHq54OYCuQ98SPsJDVIZ033IFGXMLte+IAyIOI+XA09IJYegu9RKnPVx48RQHYNoViHLcQ4mRrEMgtMwxQ4evab4zm2n7A/AeG9oMs+5wblgqml5e6kn6pPbk3P/19y3UMt4fVfWzDzKgwE3xuC8wBT2/SWbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=YO14ctjh; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=tyGTrJH1; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 02 Aug 2024 13:01:10 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1722603671;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m5248gMf343v5obBil9iLPhH/BHKOfb6tOWiNppC/cw=;
	b=YO14ctjhWRRVcoO8dBY4PTS5S2XRQ7tLPPX04zf9PoWcpX7eNR0HjYAza7vIWvug7JMLH5
	n1WYj68N/RpWNYYKY0Fp5nESJtP5IMQy2U4mDCluf/l64KKZXf5N2Wxvm9JLWXdrKitmIT
	UUMD73LkRyNflLTPofeL4qzT7d3cbGeOJfm5oe6i4GtqNsH9Ya9z16QwtzcjctubUqPKqy
	Nlucy5QDVQvW0MClO4nkSpmbK9zAFUNypM2Fsl3egu6kCr+EC7jrfo0kSDT2QAceOpUSie
	c/vh+6XPqm3r1OobqFZSj+Xc8eRyIfsehD9HT12jV75+HHY/tilCF6nR4z2x2w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1722603671;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=m5248gMf343v5obBil9iLPhH/BHKOfb6tOWiNppC/cw=;
	b=tyGTrJH1c9jd3XtX+ESgo1HjpUtGmawY/wfee5Dwklj5KyACMBgAPcIdsdh8EsuigzlikI
	iqqBgD/it4H6nbBQ==
From: "tip-bot2 for Keith Lucas" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/mm] selftests/mm: Add new testcases for pkeys
Cc: Keith Lucas <keith.lucas@oracle.com>,
 Aruna Ramakrishna <aruna.ramakrishna@oracle.com>,
 Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20240802061318.2140081-6-aruna.ramakrishna@oracle.com>
References: <20240802061318.2140081-6-aruna.ramakrishna@oracle.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <172260367052.2215.17368883146969180596.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/mm branch of tip:

Commit-ID:     6998a73efbb8a87f4dd0bddde90b7f5b0d47b5e0
Gitweb:        https://git.kernel.org/tip/6998a73efbb8a87f4dd0bddde90b7f5b0d47b5e0
Author:        Keith Lucas <keith.lucas@oracle.com>
AuthorDate:    Fri, 02 Aug 2024 06:13:18 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 02 Aug 2024 14:12:21 +02:00

selftests/mm: Add new testcases for pkeys

Add a few new tests to exercise the signal handler flow, especially with
PKEY 0 disabled:

 - Verify that the SIGSEGV handler is invoked when pkey 0 is disabled.

 - Verify that a thread which disables PKEY 0 segfaults with PKUERR when
   accessing the stack.

 - Verify that the SIGSEGV handler that uses an alternate signal stack is
   correctly invoked when the thread disabled PKEY 0

 - Verify that the PKRU value set by the application is correctly restored
   upon return from signal handling.

 - Verify that sigreturn() is able to restore the altstack even if the
   thread had PKEY 0 disabled

[ Aruna: Adapted to upstream ]
[ tglx: Made it actually compile. Restored protection_keys compile. Added
  	useful info to the changelog instead of bare function names. ]

Signed-off-by: Keith Lucas <keith.lucas@oracle.com>
Signed-off-by: Aruna Ramakrishna <aruna.ramakrishna@oracle.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20240802061318.2140081-6-aruna.ramakrishna@oracle.com
---
 tools/testing/selftests/mm/Makefile                |   1 +-
 tools/testing/selftests/mm/pkey-helpers.h          |  13 +-
 tools/testing/selftests/mm/pkey_sighandler_tests.c | 481 ++++++++++++-
 tools/testing/selftests/mm/protection_keys.c       |  10 +-
 4 files changed, 494 insertions(+), 11 deletions(-)
 create mode 100644 tools/testing/selftests/mm/pkey_sighandler_tests.c

diff --git a/tools/testing/selftests/mm/Makefile b/tools/testing/selftests/mm/Makefile
index 901e0d0..1f176ff 100644
--- a/tools/testing/selftests/mm/Makefile
+++ b/tools/testing/selftests/mm/Makefile
@@ -88,6 +88,7 @@ CAN_BUILD_X86_64 := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_64bit_pr
 CAN_BUILD_WITH_NOPIE := $(shell ./../x86/check_cc.sh "$(CC)" ../x86/trivial_program.c -no-pie)
 
 VMTARGETS := protection_keys
+VMTARGETS += pkey_sighandler_tests
 BINARIES_32 := $(VMTARGETS:%=%_32)
 BINARIES_64 := $(VMTARGETS:%=%_64)
 
diff --git a/tools/testing/selftests/mm/pkey-helpers.h b/tools/testing/selftests/mm/pkey-helpers.h
index 1af3156..4d31a30 100644
--- a/tools/testing/selftests/mm/pkey-helpers.h
+++ b/tools/testing/selftests/mm/pkey-helpers.h
@@ -79,7 +79,18 @@ extern void abort_hooks(void);
 	}					\
 } while (0)
 
-__attribute__((noinline)) int read_ptr(int *ptr);
+#define barrier() __asm__ __volatile__("": : :"memory")
+#ifndef noinline
+# define noinline __attribute__((noinline))
+#endif
+
+noinline int read_ptr(int *ptr)
+{
+	/* Keep GCC from optimizing this away somehow */
+	barrier();
+	return *ptr;
+}
+
 void expected_pkey_fault(int pkey);
 int sys_pkey_alloc(unsigned long flags, unsigned long init_val);
 int sys_pkey_free(unsigned long pkey);
diff --git a/tools/testing/selftests/mm/pkey_sighandler_tests.c b/tools/testing/selftests/mm/pkey_sighandler_tests.c
new file mode 100644
index 0000000..a8088b6
--- /dev/null
+++ b/tools/testing/selftests/mm/pkey_sighandler_tests.c
@@ -0,0 +1,481 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Tests Memory Protection Keys (see Documentation/core-api/protection-keys.rst)
+ *
+ * The testcases in this file exercise various flows related to signal handling,
+ * using an alternate signal stack, with the default pkey (pkey 0) disabled.
+ *
+ * Compile with:
+ * gcc -mxsave      -o pkey_sighandler_tests -O2 -g -std=gnu99 -pthread -Wall pkey_sighandler_tests.c -I../../../../tools/include -lrt -ldl -lm
+ * gcc -mxsave -m32 -o pkey_sighandler_tests -O2 -g -std=gnu99 -pthread -Wall pkey_sighandler_tests.c -I../../../../tools/include -lrt -ldl -lm
+ */
+#define _GNU_SOURCE
+#define __SANE_USERSPACE_TYPES__
+#include <errno.h>
+#include <sys/syscall.h>
+#include <string.h>
+#include <stdio.h>
+#include <stdint.h>
+#include <stdbool.h>
+#include <signal.h>
+#include <assert.h>
+#include <stdlib.h>
+#include <sys/mman.h>
+#include <sys/types.h>
+#include <sys/stat.h>
+#include <unistd.h>
+#include <pthread.h>
+#include <limits.h>
+
+#include "pkey-helpers.h"
+
+#define STACK_SIZE PTHREAD_STACK_MIN
+
+void expected_pkey_fault(int pkey) {}
+
+pthread_mutex_t mutex = PTHREAD_MUTEX_INITIALIZER;
+pthread_cond_t cond = PTHREAD_COND_INITIALIZER;
+siginfo_t siginfo = {0};
+
+/*
+ * We need to use inline assembly instead of glibc's syscall because glibc's
+ * syscall will attempt to access the PLT in order to call a library function
+ * which is protected by MPK 0 which we don't have access to.
+ */
+static inline __always_inline
+long syscall_raw(long n, long a1, long a2, long a3, long a4, long a5, long a6)
+{
+	unsigned long ret;
+#ifdef __x86_64__
+	register long r10 asm("r10") = a4;
+	register long r8 asm("r8") = a5;
+	register long r9 asm("r9") = a6;
+	asm volatile ("syscall"
+		      : "=a"(ret)
+		      : "a"(n), "D"(a1), "S"(a2), "d"(a3), "r"(r10), "r"(r8), "r"(r9)
+		      : "rcx", "r11", "memory");
+#elif defined __i386__
+	asm volatile ("int $0x80"
+		      : "=a"(ret)
+		      : "a"(n), "b"(a1), "c"(a2), "d"(a3), "S"(a4), "D"(a5)
+		      : "memory");
+#else
+# error syscall_raw() not implemented
+#endif
+	return ret;
+}
+
+static void sigsegv_handler(int signo, siginfo_t *info, void *ucontext)
+{
+	pthread_mutex_lock(&mutex);
+
+	memcpy(&siginfo, info, sizeof(siginfo_t));
+
+	pthread_cond_signal(&cond);
+	pthread_mutex_unlock(&mutex);
+
+	syscall_raw(SYS_exit, 0, 0, 0, 0, 0, 0);
+}
+
+static void sigusr1_handler(int signo, siginfo_t *info, void *ucontext)
+{
+	pthread_mutex_lock(&mutex);
+
+	memcpy(&siginfo, info, sizeof(siginfo_t));
+
+	pthread_cond_signal(&cond);
+	pthread_mutex_unlock(&mutex);
+}
+
+static void sigusr2_handler(int signo, siginfo_t *info, void *ucontext)
+{
+	/*
+	 * pkru should be the init_pkru value which enabled MPK 0 so
+	 * we can use library functions.
+	 */
+	printf("%s invoked.\n", __func__);
+}
+
+static void raise_sigusr2(void)
+{
+	pid_t tid = 0;
+
+	tid = syscall_raw(SYS_gettid, 0, 0, 0, 0, 0, 0);
+
+	syscall_raw(SYS_tkill, tid, SIGUSR2, 0, 0, 0, 0);
+
+	/*
+	 * We should return from the signal handler here and be able to
+	 * return to the interrupted thread.
+	 */
+}
+
+static void *thread_segv_with_pkey0_disabled(void *ptr)
+{
+	/* Disable MPK 0 (and all others too) */
+	__write_pkey_reg(0x55555555);
+
+	/* Segfault (with SEGV_MAPERR) */
+	*(int *) (0x1) = 1;
+	return NULL;
+}
+
+static void *thread_segv_pkuerr_stack(void *ptr)
+{
+	/* Disable MPK 0 (and all others too) */
+	__write_pkey_reg(0x55555555);
+
+	/* After we disable MPK 0, we can't access the stack to return */
+	return NULL;
+}
+
+static void *thread_segv_maperr_ptr(void *ptr)
+{
+	stack_t *stack = ptr;
+	int *bad = (int *)1;
+
+	/*
+	 * Setup alternate signal stack, which should be pkey_mprotect()ed by
+	 * MPK 0. The thread's stack cannot be used for signals because it is
+	 * not accessible by the default init_pkru value of 0x55555554.
+	 */
+	syscall_raw(SYS_sigaltstack, (long)stack, 0, 0, 0, 0, 0);
+
+	/* Disable MPK 0.  Only MPK 1 is enabled. */
+	__write_pkey_reg(0x55555551);
+
+	/* Segfault */
+	*bad = 1;
+	syscall_raw(SYS_exit, 0, 0, 0, 0, 0, 0);
+	return NULL;
+}
+
+/*
+ * Verify that the sigsegv handler is invoked when pkey 0 is disabled.
+ * Note that the new thread stack and the alternate signal stack is
+ * protected by MPK 0.
+ */
+static void test_sigsegv_handler_with_pkey0_disabled(void)
+{
+	struct sigaction sa;
+	pthread_attr_t attr;
+	pthread_t thr;
+
+	sa.sa_flags = SA_SIGINFO;
+
+	sa.sa_sigaction = sigsegv_handler;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(SIGSEGV, &sa, NULL) == -1) {
+		perror("sigaction");
+		exit(EXIT_FAILURE);
+	}
+
+	memset(&siginfo, 0, sizeof(siginfo));
+
+	pthread_attr_init(&attr);
+	pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
+
+	pthread_create(&thr, &attr, thread_segv_with_pkey0_disabled, NULL);
+
+	pthread_mutex_lock(&mutex);
+	while (siginfo.si_signo == 0)
+		pthread_cond_wait(&cond, &mutex);
+	pthread_mutex_unlock(&mutex);
+
+	ksft_test_result(siginfo.si_signo == SIGSEGV &&
+			 siginfo.si_code == SEGV_MAPERR &&
+			 siginfo.si_addr == (void *)1,
+			 "%s\n", __func__);
+}
+
+/*
+ * Verify that the sigsegv handler is invoked when pkey 0 is disabled.
+ * Note that the new thread stack and the alternate signal stack is
+ * protected by MPK 0, which renders them inaccessible when MPK 0
+ * is disabled. So just the return from the thread should cause a
+ * segfault with SEGV_PKUERR.
+ */
+static void test_sigsegv_handler_cannot_access_stack(void)
+{
+	struct sigaction sa;
+	pthread_attr_t attr;
+	pthread_t thr;
+
+	sa.sa_flags = SA_SIGINFO;
+
+	sa.sa_sigaction = sigsegv_handler;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(SIGSEGV, &sa, NULL) == -1) {
+		perror("sigaction");
+		exit(EXIT_FAILURE);
+	}
+
+	memset(&siginfo, 0, sizeof(siginfo));
+
+	pthread_attr_init(&attr);
+	pthread_attr_setdetachstate(&attr, PTHREAD_CREATE_DETACHED);
+
+	pthread_create(&thr, &attr, thread_segv_pkuerr_stack, NULL);
+
+	pthread_mutex_lock(&mutex);
+	while (siginfo.si_signo == 0)
+		pthread_cond_wait(&cond, &mutex);
+	pthread_mutex_unlock(&mutex);
+
+	ksft_test_result(siginfo.si_signo == SIGSEGV &&
+			 siginfo.si_code == SEGV_PKUERR,
+			 "%s\n", __func__);
+}
+
+/*
+ * Verify that the sigsegv handler that uses an alternate signal stack
+ * is correctly invoked for a thread which uses a non-zero MPK to protect
+ * its own stack, and disables all other MPKs (including 0).
+ */
+static void test_sigsegv_handler_with_different_pkey_for_stack(void)
+{
+	struct sigaction sa;
+	static stack_t sigstack;
+	void *stack;
+	int pkey;
+	int parent_pid = 0;
+	int child_pid = 0;
+
+	sa.sa_flags = SA_SIGINFO | SA_ONSTACK;
+
+	sa.sa_sigaction = sigsegv_handler;
+
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(SIGSEGV, &sa, NULL) == -1) {
+		perror("sigaction");
+		exit(EXIT_FAILURE);
+	}
+
+	stack = mmap(0, STACK_SIZE, PROT_READ | PROT_WRITE,
+		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	assert(stack != MAP_FAILED);
+
+	/* Allow access to MPK 0 and MPK 1 */
+	__write_pkey_reg(0x55555550);
+
+	/* Protect the new stack with MPK 1 */
+	pkey = pkey_alloc(0, 0);
+	pkey_mprotect(stack, STACK_SIZE, PROT_READ | PROT_WRITE, pkey);
+
+	/* Set up alternate signal stack that will use the default MPK */
+	sigstack.ss_sp = mmap(0, STACK_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC,
+			      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	sigstack.ss_flags = 0;
+	sigstack.ss_size = STACK_SIZE;
+
+	memset(&siginfo, 0, sizeof(siginfo));
+
+	/* Use clone to avoid newer glibcs using rseq on new threads */
+	long ret = syscall_raw(SYS_clone,
+			       CLONE_VM | CLONE_FS | CLONE_FILES |
+			       CLONE_SIGHAND | CLONE_THREAD | CLONE_SYSVSEM |
+			       CLONE_PARENT_SETTID | CLONE_CHILD_CLEARTID |
+			       CLONE_DETACHED,
+			       (long) ((char *)(stack) + STACK_SIZE),
+			       (long) &parent_pid,
+			       (long) &child_pid, 0, 0);
+
+	if (ret < 0) {
+		errno = -ret;
+		perror("clone");
+	} else if (ret == 0) {
+		thread_segv_maperr_ptr(&sigstack);
+		syscall_raw(SYS_exit, 0, 0, 0, 0, 0, 0);
+	}
+
+	pthread_mutex_lock(&mutex);
+	while (siginfo.si_signo == 0)
+		pthread_cond_wait(&cond, &mutex);
+	pthread_mutex_unlock(&mutex);
+
+	ksft_test_result(siginfo.si_signo == SIGSEGV &&
+			 siginfo.si_code == SEGV_MAPERR &&
+			 siginfo.si_addr == (void *)1,
+			 "%s\n", __func__);
+}
+
+/*
+ * Verify that the PKRU value set by the application is correctly
+ * restored upon return from signal handling.
+ */
+static void test_pkru_preserved_after_sigusr1(void)
+{
+	struct sigaction sa;
+	unsigned long pkru = 0x45454544;
+
+	sa.sa_flags = SA_SIGINFO;
+
+	sa.sa_sigaction = sigusr1_handler;
+	sigemptyset(&sa.sa_mask);
+	if (sigaction(SIGUSR1, &sa, NULL) == -1) {
+		perror("sigaction");
+		exit(EXIT_FAILURE);
+	}
+
+	memset(&siginfo, 0, sizeof(siginfo));
+
+	__write_pkey_reg(pkru);
+
+	raise(SIGUSR1);
+
+	pthread_mutex_lock(&mutex);
+	while (siginfo.si_signo == 0)
+		pthread_cond_wait(&cond, &mutex);
+	pthread_mutex_unlock(&mutex);
+
+	/* Ensure the pkru value is the same after returning from signal. */
+	ksft_test_result(pkru == __read_pkey_reg() &&
+			 siginfo.si_signo == SIGUSR1,
+			 "%s\n", __func__);
+}
+
+static noinline void *thread_sigusr2_self(void *ptr)
+{
+	/*
+	 * A const char array like "Resuming after SIGUSR2" won't be stored on
+	 * the stack and the code could access it via an offset from the program
+	 * counter. This makes sure it's on the function's stack frame.
+	 */
+	char str[] = {'R', 'e', 's', 'u', 'm', 'i', 'n', 'g', ' ',
+		'a', 'f', 't', 'e', 'r', ' ',
+		'S', 'I', 'G', 'U', 'S', 'R', '2',
+		'.', '.', '.', '\n', '\0'};
+	stack_t *stack = ptr;
+
+	/*
+	 * Setup alternate signal stack, which should be pkey_mprotect()ed by
+	 * MPK 0. The thread's stack cannot be used for signals because it is
+	 * not accessible by the default init_pkru value of 0x55555554.
+	 */
+	syscall(SYS_sigaltstack, (long)stack, 0, 0, 0, 0, 0);
+
+	/* Disable MPK 0.  Only MPK 2 is enabled. */
+	__write_pkey_reg(0x55555545);
+
+	raise_sigusr2();
+
+	/* Do something, to show the thread resumed execution after the signal */
+	syscall_raw(SYS_write, 1, (long) str, sizeof(str) - 1, 0, 0, 0);
+
+	/*
+	 * We can't return to test_pkru_sigreturn because it
+	 * will attempt to use a %rbp value which is on the stack
+	 * of the main thread.
+	 */
+	syscall_raw(SYS_exit, 0, 0, 0, 0, 0, 0);
+	return NULL;
+}
+
+/*
+ * Verify that sigreturn is able to restore altstack even if the thread had
+ * disabled pkey 0.
+ */
+static void test_pkru_sigreturn(void)
+{
+	struct sigaction sa = {0};
+	static stack_t sigstack;
+	void *stack;
+	int pkey;
+	int parent_pid = 0;
+	int child_pid = 0;
+
+	sa.sa_handler = SIG_DFL;
+	sa.sa_flags = 0;
+	sigemptyset(&sa.sa_mask);
+
+	/*
+	 * For this testcase, we do not want to handle SIGSEGV. Reset handler
+	 * to default so that the application can crash if it receives SIGSEGV.
+	 */
+	if (sigaction(SIGSEGV, &sa, NULL) == -1) {
+		perror("sigaction");
+		exit(EXIT_FAILURE);
+	}
+
+	sa.sa_flags = SA_SIGINFO | SA_ONSTACK;
+	sa.sa_sigaction = sigusr2_handler;
+	sigemptyset(&sa.sa_mask);
+
+	if (sigaction(SIGUSR2, &sa, NULL) == -1) {
+		perror("sigaction");
+		exit(EXIT_FAILURE);
+	}
+
+	stack = mmap(0, STACK_SIZE, PROT_READ | PROT_WRITE,
+		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+
+	assert(stack != MAP_FAILED);
+
+	/*
+	 * Allow access to MPK 0 and MPK 2. The child thread (to be created
+	 * later in this flow) will have its stack protected by MPK 2, whereas
+	 * the current thread's stack is protected by the default MPK 0. Hence
+	 * both need to be enabled.
+	 */
+	__write_pkey_reg(0x55555544);
+
+	/* Protect the stack with MPK 2 */
+	pkey = pkey_alloc(0, 0);
+	pkey_mprotect(stack, STACK_SIZE, PROT_READ | PROT_WRITE, pkey);
+
+	/* Set up alternate signal stack that will use the default MPK */
+	sigstack.ss_sp = mmap(0, STACK_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC,
+			      MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	sigstack.ss_flags = 0;
+	sigstack.ss_size = STACK_SIZE;
+
+	/* Use clone to avoid newer glibcs using rseq on new threads */
+	long ret = syscall_raw(SYS_clone,
+			       CLONE_VM | CLONE_FS | CLONE_FILES |
+			       CLONE_SIGHAND | CLONE_THREAD | CLONE_SYSVSEM |
+			       CLONE_PARENT_SETTID | CLONE_CHILD_CLEARTID |
+			       CLONE_DETACHED,
+			       (long) ((char *)(stack) + STACK_SIZE),
+			       (long) &parent_pid,
+			       (long) &child_pid, 0, 0);
+
+	if (ret < 0) {
+		errno = -ret;
+		perror("clone");
+	}  else if (ret == 0) {
+		thread_sigusr2_self(&sigstack);
+		syscall_raw(SYS_exit, 0, 0, 0, 0, 0, 0);
+	}
+
+	child_pid =  ret;
+	/* Check that thread exited */
+	do {
+		sched_yield();
+		ret = syscall_raw(SYS_tkill, child_pid, 0, 0, 0, 0, 0);
+	} while (ret != -ESRCH && ret != -EINVAL);
+
+	ksft_test_result_pass("%s\n", __func__);
+}
+
+static void (*pkey_tests[])(void) = {
+	test_sigsegv_handler_with_pkey0_disabled,
+	test_sigsegv_handler_cannot_access_stack,
+	test_sigsegv_handler_with_different_pkey_for_stack,
+	test_pkru_preserved_after_sigusr1,
+	test_pkru_sigreturn
+};
+
+int main(int argc, char *argv[])
+{
+	int i;
+
+	ksft_print_header();
+	ksft_set_plan(ARRAY_SIZE(pkey_tests));
+
+	for (i = 0; i < ARRAY_SIZE(pkey_tests); i++)
+		(*pkey_tests[i])();
+
+	ksft_finished();
+	return 0;
+}
diff --git a/tools/testing/selftests/mm/protection_keys.c b/tools/testing/selftests/mm/protection_keys.c
index eaa6d1f..cc6de16 100644
--- a/tools/testing/selftests/mm/protection_keys.c
+++ b/tools/testing/selftests/mm/protection_keys.c
@@ -950,16 +950,6 @@ void close_test_fds(void)
 	nr_test_fds = 0;
 }
 
-#define barrier() __asm__ __volatile__("": : :"memory")
-__attribute__((noinline)) int read_ptr(int *ptr)
-{
-	/*
-	 * Keep GCC from optimizing this away somehow
-	 */
-	barrier();
-	return *ptr;
-}
-
 void test_pkey_alloc_free_attach_pkey0(int *ptr, u16 pkey)
 {
 	int i, err;

