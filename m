Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 68BE138AFD9
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 May 2021 15:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240075AbhETNZF (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 20 May 2021 09:25:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46870 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237067AbhETNYz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 20 May 2021 09:24:55 -0400
Date:   Thu, 20 May 2021 13:23:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621517013;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hXL1QNNL3x/jfEKm72lylL3RDIX8kzDs9hG+O/OKw3M=;
        b=DqQ1V3rmCE8yMZZD0IZcx2+Wr5gDkyNez75jdg/4owBuUItm2w8Y5qBlZpshUPvWtEARkW
        PQe+nIHVgXz57bnUjw5LiDm377c2wGTtEDYo4PlZqXVZ498Vw5xuOZYhSaHvS1WlummBd1
        AL98DLO33rmpWuZ9u42vVHvqpe8arBsI8C/mAhXygzGcY7GY7QdAiKOv+5j15fVspGYrtx
        M+5AyldNDJzZmAB9cD7mCpt+F4kHqub0kVbUAy7fiR4m0DJniYlQB7AtSl0LOgWVzCg6Ne
        FJ+MZ/l7DWKdUF+LLgBlK+G5LYYuy09drb036rAWRXWrVYbwl1n6uD5ED/ZU+w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621517013;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hXL1QNNL3x/jfEKm72lylL3RDIX8kzDs9hG+O/OKw3M=;
        b=BLdv5wAk68ik04o2cm1zZItDJGJqiN7JQUtIWucwMwRhW0Me70Unbxdq/87saFNG7iY6P6
        V3Eu668CB/HKixCg==
From:   "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] selftests/x86/syscall: Update and extend
 syscall_numbering_64
Cc:     "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210518191303.4135296-2-hpa@zytor.com>
References: <20210518191303.4135296-2-hpa@zytor.com>
MIME-Version: 1.0
Message-ID: <162151701247.29796.2076391014082162446.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     15c82d98a0f783bd4b2715ea910f7bb526367f54
Gitweb:        https://git.kernel.org/tip/15c82d98a0f783bd4b2715ea910f7bb526367f54
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 18 May 2021 12:12:58 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 20 May 2021 15:19:48 +02:00

selftests/x86/syscall: Update and extend syscall_numbering_64

Update the syscall_numbering_64 selftest to reflect that a system call is
to be extended from 32 bits. Add a mix of tests for valid and invalid
system calls in 64-bit and x32 space.

Use an explicit system call instruction, because the glibc syscall()
wrapper might intercept instructions, extend the system call number
independently, or anything similar.

Use long long instead of long to make it possible to compile this test
on x32 as well as 64 bits.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210518191303.4135296-2-hpa@zytor.com

---
 tools/testing/selftests/x86/syscall_numbering.c | 274 ++++++++++++---
 1 file changed, 222 insertions(+), 52 deletions(-)

diff --git a/tools/testing/selftests/x86/syscall_numbering.c b/tools/testing/selftests/x86/syscall_numbering.c
index d6b09cb..7dd86bc 100644
--- a/tools/testing/selftests/x86/syscall_numbering.c
+++ b/tools/testing/selftests/x86/syscall_numbering.c
@@ -1,6 +1,8 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 /*
- * syscall_arg_fault.c - tests faults 32-bit fast syscall stack args
+ * syscall_numbering.c - test calling the x86-64 kernel with various
+ * valid and invalid system call numbers.
+ *
  * Copyright (c) 2018 Andrew Lutomirski
  */
 
@@ -11,79 +13,247 @@
 #include <stdbool.h>
 #include <errno.h>
 #include <unistd.h>
-#include <syscall.h>
+#include <string.h>
+#include <fcntl.h>
+#include <limits.h>
 
-static int nerrs;
+/* Common system call numbers */
+#define SYS_READ	  0
+#define SYS_WRITE	  1
+#define SYS_GETPID	 39
+/* x64-only system call numbers */
+#define X64_IOCTL	 16
+#define X64_READV	 19
+#define X64_WRITEV	 20
+/* x32-only system call numbers (without X32_BIT) */
+#define X32_IOCTL	514
+#define X32_READV	515
+#define X32_WRITEV	516
 
-#define X32_BIT 0x40000000UL
+#define X32_BIT 0x40000000
 
-static void check_enosys(unsigned long nr, bool *ok)
+static unsigned int nerr = 0;	/* Cumulative error count */
+static int nullfd = -1;		/* File descriptor for /dev/null */
+
+/*
+ * Directly invokes the given syscall with nullfd as the first argument
+ * and the rest zero. Avoids involving glibc wrappers in case they ever
+ * end up intercepting some system calls for some reason, or modify
+ * the system call number itself.
+ */
+static inline long long probe_syscall(int msb, int lsb)
 {
-	/* If this fails, a segfault is reasonably likely. */
-	fflush(stdout);
-
-	long ret = syscall(nr, 0, 0, 0, 0, 0, 0);
-	if (ret == 0) {
-		printf("[FAIL]\tsyscall %lu succeeded, but it should have failed\n", nr);
-		*ok = false;
-	} else if (errno != ENOSYS) {
-		printf("[FAIL]\tsyscall %lu had error code %d, but it should have reported ENOSYS\n", nr, errno);
-		*ok = false;
-	}
+	register long long arg1 asm("rdi") = nullfd;
+	register long long arg2 asm("rsi") = 0;
+	register long long arg3 asm("rdx") = 0;
+	register long long arg4 asm("r10") = 0;
+	register long long arg5 asm("r8")  = 0;
+	register long long arg6 asm("r9")  = 0;
+	long long nr = ((long long)msb << 32) | (unsigned int)lsb;
+	long long ret;
+
+	asm volatile("syscall"
+		     : "=a" (ret)
+		     : "a" (nr), "r" (arg1), "r" (arg2), "r" (arg3),
+		       "r" (arg4), "r" (arg5), "r" (arg6)
+		     : "rcx", "r11", "memory", "cc");
+
+	return ret;
 }
 
-static void test_x32_without_x32_bit(void)
+static const char *syscall_str(int msb, int start, int end)
 {
-	bool ok = true;
+	static char buf[64];
+	const char * const type = (start & X32_BIT) ? "x32" : "x64";
+	int lsb = start;
 
 	/*
-	 * Syscalls 512-547 are "x32" syscalls.  They are intended to be
-	 * called with the x32 (0x40000000) bit set.  Calling them without
-	 * the x32 bit set is nonsense and should not work.
+	 * Improve readability by stripping the x32 bit, but round
+	 * toward zero so we don't display -1 as -1073741825.
 	 */
-	printf("[RUN]\tChecking syscalls 512-547\n");
-	for (int i = 512; i <= 547; i++)
-		check_enosys(i, &ok);
+	if (lsb < 0)
+		lsb |= X32_BIT;
+	else
+		lsb &= ~X32_BIT;
+
+	if (start == end)
+		snprintf(buf, sizeof buf, "%s syscall %d:%d",
+			 type, msb, lsb);
+	else
+		snprintf(buf, sizeof buf, "%s syscalls %d:%d..%d",
+			 type, msb, lsb, lsb + (end-start));
+
+	return buf;
+}
+
+static unsigned int _check_for(int msb, int start, int end, long long expect,
+			       const char *expect_str)
+{
+	unsigned int err = 0;
+
+	for (int nr = start; nr <= end; nr++) {
+		long long ret = probe_syscall(msb, nr);
+
+		if (ret != expect) {
+			printf("[FAIL]\t      %s returned %lld, but it should have returned %s\n",
+			       syscall_str(msb, nr, nr),
+			       ret, expect_str);
+			err++;
+		}
+	}
 
+	if (err) {
+		nerr += err;
+		if (start != end)
+			printf("[FAIL]\t      %s had %u failure%s\n",
+			       syscall_str(msb, start, end),
+			       err, (err == 1) ? "s" : "");
+	} else {
+		printf("[OK]\t      %s returned %s as expected\n",
+		       syscall_str(msb, start, end), expect_str);
+	}
+
+	return err;
+}
+
+#define check_for(msb,start,end,expect) \
+	_check_for(msb,start,end,expect,#expect)
+
+static bool check_zero(int msb, int nr)
+{
+	return check_for(msb, nr, nr, 0);
+}
+
+static bool check_enosys(int msb, int nr)
+{
+	return check_for(msb, nr, nr, -ENOSYS);
+}
+
+/*
+ * Anyone diagnosing a failure will want to know whether the kernel
+ * supports x32. Tell them. This can also be used to conditionalize
+ * tests based on existence or nonexistence of x32.
+ */
+static bool test_x32(void)
+{
+	long long ret;
+	long long mypid = getpid();
+
+	printf("[RUN]\tChecking for x32 by calling x32 getpid()\n");
+	ret = probe_syscall(0, SYS_GETPID | X32_BIT);
+
+	if (ret == mypid) {
+		printf("[INFO]\t   x32 is supported\n");
+		return true;
+	} else if (ret == -ENOSYS) {
+		printf("[INFO]\t   x32 is not supported\n");
+		return false;
+	} else {
+		printf("[FAIL]\t   x32 getpid() returned %lld, but it should have returned either %lld or -ENOSYS\n", ret, mypid);
+		nerr++;
+		return true;	/* Proceed as if... */
+	}
+}
+
+static void test_syscalls_common(int msb)
+{
+	printf("[RUN]\t   Checking some common syscalls as 64 bit\n");
+	check_zero(msb, SYS_READ);
+	check_zero(msb, SYS_WRITE);
+
+	printf("[RUN]\t   Checking some 64-bit only syscalls as 64 bit\n");
+	check_zero(msb, X64_READV);
+	check_zero(msb, X64_WRITEV);
+
+	printf("[RUN]\t   Checking out of range system calls\n");
+	check_for(msb, -64, -1, -ENOSYS);
+	check_for(msb, X32_BIT-64, X32_BIT-1, -ENOSYS);
+	check_for(msb, -64-X32_BIT, -1-X32_BIT, -ENOSYS);
+	check_for(msb, INT_MAX-64, INT_MAX-1, -ENOSYS);
+}
+
+static void test_syscalls_with_x32(int msb)
+{
 	/*
-	 * Check that a handful of 64-bit-only syscalls are rejected if the x32
-	 * bit is set.
+	 * Syscalls 512-547 are "x32" syscalls.  They are
+	 * intended to be called with the x32 (0x40000000) bit
+	 * set.  Calling them without the x32 bit set is
+	 * nonsense and should not work.
 	 */
-	printf("[RUN]\tChecking some 64-bit syscalls in x32 range\n");
-	check_enosys(16 | X32_BIT, &ok);	/* ioctl */
-	check_enosys(19 | X32_BIT, &ok);	/* readv */
-	check_enosys(20 | X32_BIT, &ok);	/* writev */
+	printf("[RUN]\t   Checking x32 syscalls as 64 bit\n");
+	check_for(msb, 512, 547, -ENOSYS);
+
+	printf("[RUN]\t   Checking some common syscalls as x32\n");
+	check_zero(msb, SYS_READ   | X32_BIT);
+	check_zero(msb, SYS_WRITE  | X32_BIT);
+
+	printf("[RUN]\t   Checking some x32 syscalls as x32\n");
+	check_zero(msb, X32_READV  | X32_BIT);
+	check_zero(msb, X32_WRITEV | X32_BIT);
+
+	printf("[RUN]\t   Checking some 64-bit syscalls as x32\n");
+	check_enosys(msb, X64_IOCTL  | X32_BIT);
+	check_enosys(msb, X64_READV  | X32_BIT);
+	check_enosys(msb, X64_WRITEV | X32_BIT);
+}
+
+static void test_syscalls_without_x32(int msb)
+{
+	printf("[RUN]\t  Checking for absence of x32 system calls\n");
+	check_for(msb, 0 | X32_BIT, 999 | X32_BIT, -ENOSYS);
+}
+
+static void test_syscall_numbering(void)
+{
+	static const int msbs[] = {
+		0, 1, -1, X32_BIT-1, X32_BIT, X32_BIT-1, -X32_BIT, INT_MAX,
+		INT_MIN, INT_MIN+1
+	};
+	bool with_x32 = test_x32();
 
 	/*
-	 * Check some syscalls with high bits set.
+	 * The MSB is supposed to be ignored, so we loop over a few
+	 * to test that out.
 	 */
-	printf("[RUN]\tChecking numbers above 2^32-1\n");
-	check_enosys((1UL << 32), &ok);
-	check_enosys(X32_BIT | (1UL << 32), &ok);
+	for (size_t i = 0; i < sizeof(msbs)/sizeof(msbs[0]); i++) {
+		int msb = msbs[i];
+		printf("[RUN]\tChecking system calls with msb = %d (0x%x)\n",
+		       msb, msb);
 
-	if (!ok)
-		nerrs++;
-	else
-		printf("[OK]\tThey all returned -ENOSYS\n");
+		test_syscalls_common(msb);
+		if (with_x32)
+			test_syscalls_with_x32(msb);
+		else
+			test_syscalls_without_x32(msb);
+	}
 }
 
-int main()
+int main(void)
 {
 	/*
-	 * Anyone diagnosing a failure will want to know whether the kernel
-	 * supports x32.  Tell them.
+	 * It is quite likely to get a segfault on a failure, so make
+	 * sure the message gets out by setting stdout to nonbuffered.
 	 */
-	printf("\tChecking for x32...");
-	fflush(stdout);
-	if (syscall(39 | X32_BIT, 0, 0, 0, 0, 0, 0) >= 0) {
-		printf(" supported\n");
-	} else if (errno == ENOSYS) {
-		printf(" not supported\n");
-	} else {
-		printf(" confused\n");
-	}
+	setvbuf(stdout, NULL, _IONBF, 0);
 
-	test_x32_without_x32_bit();
+	/*
+	 * Harmless file descriptor to work on...
+	 */
+	nullfd = open("/dev/null", O_RDWR);
+	if (nullfd < 0) {
+		printf("[FAIL]\tUnable to open /dev/null: %s\n",
+		       strerror(errno));
+		printf("[SKIP]\tCannot execute test\n");
+		return 71;	/* EX_OSERR */
+	}
 
-	return nerrs ? 1 : 0;
+	test_syscall_numbering();
+	if (!nerr) {
+		printf("[OK]\tAll system calls succeeded or failed as expected\n");
+		return 0;
+	} else {
+		printf("[FAIL]\tA total of %u system call%s had incorrect behavior\n",
+		       nerr, nerr != 1 ? "s" : "");
+		return 1;
+	}
 }
