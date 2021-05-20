Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C5A1938AFDF
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 May 2021 15:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242367AbhETNZH (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 20 May 2021 09:25:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238818AbhETNZB (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 20 May 2021 09:25:01 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB315C061574;
        Thu, 20 May 2021 06:23:34 -0700 (PDT)
Date:   Thu, 20 May 2021 13:23:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621517012;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EycEA4W3gtvbK/uF3+XHFT8p72TOW6URWUMIL4r9X00=;
        b=vPlPhqmYTdrtxNNLyTLR5/eC/x92n04e5U62LNNlZExHP5RZdQAz+0HQIV0JxR346xpVmO
        sPZWvj7n3zBzuymjKMMY4xtTHaMV0J3ffhtfXCcFu7tF7yo1fzVTZAZSrW9FA2ZM43WuDz
        4NMn/yudc48gqEL6W4jsdNShnn+E7HD/qvp+HZsoxWzuT6aCHq0qToMBEcknIX2cd+mfRi
        ANm7JDSN/ZsP15+C7t1p/B40OAxCpg4Ts7IQagNo4MtoO7NUc4kxwQDOe3Br2iG8WxvRO1
        +aA75FRDYcx8cehtxgF8hxUo9tZ2BwlVcYBimyPTlad1njf4FEBWVrz4UmMwRA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621517012;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=EycEA4W3gtvbK/uF3+XHFT8p72TOW6URWUMIL4r9X00=;
        b=2iauXlatpRSLtmp0cyILst6w83C7vK4yOKTLIMMwoUxzK+5KuqRHA0I7naFox3+0A84DYi
        5sUqxrTVC5f9NkCw==
From:   "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] selftests/x86/syscall: Add tests under ptrace to
 syscall_numbering_64
Cc:     "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210518191303.4135296-4-hpa@zytor.com>
References: <20210518191303.4135296-4-hpa@zytor.com>
MIME-Version: 1.0
Message-ID: <162151701150.29796.11792322454134034227.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     795e2a023b8080b95442811f26f0762184116caa
Gitweb:        https://git.kernel.org/tip/795e2a023b8080b95442811f26f0762184116caa
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 18 May 2021 12:13:00 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 20 May 2021 15:19:48 +02:00

selftests/x86/syscall: Add tests under ptrace to syscall_numbering_64

Add tests running under ptrace for syscall_numbering_64. ptrace stopping on
syscall entry and possibly modifying the syscall number (regs.orig_rax) or
the default return value (regs.rax) can have different results than the
normal system call path.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210518191303.4135296-4-hpa@zytor.com

---
 tools/testing/selftests/x86/syscall_numbering.c | 232 +++++++++++++--
 1 file changed, 207 insertions(+), 25 deletions(-)

diff --git a/tools/testing/selftests/x86/syscall_numbering.c b/tools/testing/selftests/x86/syscall_numbering.c
index 434fe0e..9915917 100644
--- a/tools/testing/selftests/x86/syscall_numbering.c
+++ b/tools/testing/selftests/x86/syscall_numbering.c
@@ -16,8 +16,16 @@
 #include <string.h>
 #include <fcntl.h>
 #include <limits.h>
+#include <signal.h>
 #include <sysexits.h>
 
+#include <sys/ptrace.h>
+#include <sys/user.h>
+#include <sys/wait.h>
+#include <sys/mman.h>
+
+#include <linux/ptrace.h>
+
 /* Common system call numbers */
 #define SYS_READ	  0
 #define SYS_WRITE	  1
@@ -33,13 +41,45 @@
 
 #define X32_BIT 0x40000000
 
-static unsigned int nerr = 0;	/* Cumulative error count */
 static int nullfd = -1;		/* File descriptor for /dev/null */
-static int indent = 0;
+static bool with_x32;		/* x32 supported on this kernel? */
+
+enum ptrace_pass {
+	PTP_NOTHING,
+	PTP_GETREGS,
+	PTP_WRITEBACK,
+	PTP_FUZZRET,
+	PTP_FUZZHIGH,
+	PTP_INTNUM,
+	PTP_DONE
+};
+
+static const char * const ptrace_pass_name[] =
+{
+	[PTP_NOTHING]	= "just stop, no data read",
+	[PTP_GETREGS]	= "only getregs",
+	[PTP_WRITEBACK]	= "getregs, unmodified setregs",
+	[PTP_FUZZRET]	= "modifying the default return",
+	[PTP_FUZZHIGH]	= "clobbering the top 32 bits",
+	[PTP_INTNUM]	= "sign-extending the syscall number",
+};
+
+/*
+ * Shared memory block between tracer and test
+ */
+struct shared {
+	unsigned int nerr;	/* Total error count */
+	unsigned int indent;	/* Message indentation level */
+	enum ptrace_pass ptrace_pass;
+	bool probing_syscall;	/* In probe_syscall() */
+};
+static volatile struct shared *sh;
 
 static inline unsigned int offset(void)
 {
-	return 8 + indent * 4;
+	unsigned int level = sh ? sh->indent : 0;
+
+	return 8 + level * 4;
 }
 
 #define msg(lvl, fmt, ...) printf("%-*s" fmt, offset(), "[" #lvl "]", \
@@ -52,16 +92,19 @@ static inline unsigned int offset(void)
 #define fail(fmt, ...)					\
 	do {						\
 		msg(FAIL, fmt, ## __VA_ARGS__);		\
-		nerr++;					\
-	} while (0)
+		sh->nerr++;				\
+       } while (0)
 
 #define crit(fmt, ...)					\
 	do {						\
-		indent = 0;				\
+		sh->indent = 0;				\
 		msg(FAIL, fmt, ## __VA_ARGS__);		\
 		msg(SKIP, "Unable to run test\n");	\
-		exit(EX_OSERR);
-	} while (0)
+		exit(EX_OSERR);				\
+       } while (0)
+
+/* Sentinel for ptrace-modified return value */
+#define MODIFIED_BY_PTRACE	-9999
 
 /*
  * Directly invokes the given syscall with nullfd as the first argument
@@ -69,7 +112,7 @@ static inline unsigned int offset(void)
  * end up intercepting some system calls for some reason, or modify
  * the system call number itself.
  */
-static inline long long probe_syscall(int msb, int lsb)
+static long long probe_syscall(int msb, int lsb)
 {
 	register long long arg1 asm("rdi") = nullfd;
 	register long long arg2 asm("rsi") = 0;
@@ -80,11 +123,21 @@ static inline long long probe_syscall(int msb, int lsb)
 	long long nr = ((long long)msb << 32) | (unsigned int)lsb;
 	long long ret;
 
+	/*
+	 * We pass in an extra copy of the extended system call number
+	 * in %rbx, so we can examine it from the ptrace handler without
+	 * worrying about it being possibly modified. This is to test
+	 * the validity of struct user regs.orig_rax a.k.a.
+	 * struct pt_regs.orig_ax.
+	 */
+	sh->probing_syscall = true;
 	asm volatile("syscall"
 		     : "=a" (ret)
-		     : "a" (nr), "r" (arg1), "r" (arg2), "r" (arg3),
+		     : "a" (nr), "b" (nr),
+		       "r" (arg1), "r" (arg2), "r" (arg3),
 		       "r" (arg4), "r" (arg5), "r" (arg6)
 		     : "rcx", "r11", "memory", "cc");
+	sh->probing_syscall = false;
 
 	return ret;
 }
@@ -119,9 +172,9 @@ static unsigned int _check_for(int msb, int start, int end, long long expect,
 {
 	unsigned int err = 0;
 
-	indent++;
+	sh->indent++;
 	if (start != end)
-		indent++;
+		sh->indent++;
 
 	for (int nr = start; nr <= end; nr++) {
 		long long ret = probe_syscall(msb, nr);
@@ -135,20 +188,19 @@ static unsigned int _check_for(int msb, int start, int end, long long expect,
 	}
 
 	if (start != end)
-		indent--;
+		sh->indent--;
 
 	if (err) {
-		nerr += err;
 		if (start != end)
 			fail("%s had %u failure%s\n",
-			       syscall_str(msb, start, end),
-			       err, err == 1 ? "s" : "");
+			     syscall_str(msb, start, end),
+			     err, err == 1 ? "s" : "");
 	} else {
 		ok("%s returned %s as expected\n",
 		   syscall_str(msb, start, end), expect_str);
 	}
 
-	indent--;
+	sh->indent--;
 
 	return err;
 }
@@ -175,12 +227,11 @@ static bool test_x32(void)
 {
 	long long ret;
 	pid_t mypid = getpid();
-	bool with_x32;
 
 	run("Checking for x32 by calling x32 getpid()\n");
 	ret = probe_syscall(0, SYS_GETPID | X32_BIT);
 
-	indent++;
+	sh->indent++;
 	if (ret == mypid) {
 		info("x32 is supported\n");
 		with_x32 = true;
@@ -188,15 +239,17 @@ static bool test_x32(void)
 		info("x32 is not supported\n");
 		with_x32 = false;
 	} else {
-		fail("x32 getpid() returned %lld, but it should have returned either %lld or -ENOSYS\n", ret, mypid);
+		fail("x32 getpid() returned %lld, but it should have returned either %lld or -ENOSYS\n", ret, (long long)mypid);
 		with_x32 = false;
 	}
-	indent--;
+	sh->indent--;
 	return with_x32;
 }
 
 static void test_syscalls_common(int msb)
 {
+	enum ptrace_pass pass = sh->ptrace_pass;
+
 	run("Checking some common syscalls as 64 bit\n");
 	check_zero(msb, SYS_READ);
 	check_zero(msb, SYS_WRITE);
@@ -206,7 +259,11 @@ static void test_syscalls_common(int msb)
 	check_zero(msb, X64_WRITEV);
 
 	run("Checking out of range system calls\n");
-	check_for(msb, -64, -1, -ENOSYS);
+	check_for(msb, -64, -2, -ENOSYS);
+	if (pass >= PTP_FUZZRET)
+		check_for(msb, -1, -1, MODIFIED_BY_PTRACE);
+	else
+		check_for(msb, -1, -1, -ENOSYS);
 	check_for(msb, X32_BIT-64, X32_BIT-1, -ENOSYS);
 	check_for(msb, -64-X32_BIT, -1-X32_BIT, -ENOSYS);
 	check_for(msb, INT_MAX-64, INT_MAX-1, -ENOSYS);
@@ -249,7 +306,8 @@ static void test_syscall_numbering(void)
 		0, 1, -1, X32_BIT-1, X32_BIT, X32_BIT-1, -X32_BIT, INT_MAX,
 		INT_MIN, INT_MIN+1
 	};
-	bool with_x32 = test_x32();
+
+	sh->indent++;
 
 	/*
 	 * The MSB is supposed to be ignored, so we loop over a few
@@ -260,7 +318,7 @@ static void test_syscall_numbering(void)
 		run("Checking system calls with msb = %d (0x%x)\n",
 		    msb, msb);
 
-		indent++;
+		sh->indent++;
 
 		test_syscalls_common(msb);
 		if (with_x32)
@@ -268,12 +326,119 @@ static void test_syscall_numbering(void)
 		else
 			test_syscalls_without_x32(msb);
 
-		indent--;
+		sh->indent--;
+	}
+
+	sh->indent--;
+}
+
+static void syscall_numbering_tracee(void)
+{
+	enum ptrace_pass pass;
+
+	if (ptrace(PTRACE_TRACEME, 0, 0, 0)) {
+		crit("Failed to request tracing\n");
+		return;
+	}
+	raise(SIGSTOP);
+
+	for (sh->ptrace_pass = pass = PTP_NOTHING; pass < PTP_DONE;
+	     sh->ptrace_pass = ++pass) {
+		run("Running tests under ptrace: %s\n", ptrace_pass_name[pass]);
+		test_syscall_numbering();
+	}
+}
+
+static void mess_with_syscall(pid_t testpid, enum ptrace_pass pass)
+{
+	struct user_regs_struct regs;
+
+	sh->probing_syscall = false; /* Do this on entry only */
+
+	/* For these, don't even getregs */
+	if (pass == PTP_NOTHING || pass == PTP_DONE)
+		return;
+
+	ptrace(PTRACE_GETREGS, testpid, NULL, &regs);
+
+	if (regs.orig_rax != regs.rbx) {
+		fail("orig_rax %#llx doesn't match syscall number %#llx\n",
+		     (unsigned long long)regs.orig_rax,
+		     (unsigned long long)regs.rbx);
+	}
+
+	switch (pass) {
+	case PTP_GETREGS:
+		/* Just read, no writeback */
+		return;
+	case PTP_WRITEBACK:
+		/* Write back the same register state verbatim */
+		break;
+	case PTP_FUZZRET:
+		regs.rax = MODIFIED_BY_PTRACE;
+		break;
+	case PTP_FUZZHIGH:
+		regs.rax = MODIFIED_BY_PTRACE;
+		regs.orig_rax = regs.orig_rax | 0xffffffff00000000ULL;
+		break;
+	case PTP_INTNUM:
+		regs.rax = MODIFIED_BY_PTRACE;
+		regs.orig_rax = (int)regs.orig_rax;
+		break;
+	default:
+		crit("invalid ptrace_pass\n");
+		break;
+	}
+
+	ptrace(PTRACE_SETREGS, testpid, NULL, &regs);
+}
+
+static void syscall_numbering_tracer(pid_t testpid)
+{
+	int wstatus;
+
+	do {
+		pid_t wpid = waitpid(testpid, &wstatus, 0);
+		if (wpid < 0 && errno != EINTR)
+			break;
+		if (wpid != testpid)
+			continue;
+		if (!WIFSTOPPED(wstatus))
+			break;	/* Thread exited? */
+
+		if (sh->probing_syscall && WSTOPSIG(wstatus) == SIGTRAP)
+			mess_with_syscall(testpid, sh->ptrace_pass);
+	} while (sh->ptrace_pass != PTP_DONE &&
+		 !ptrace(PTRACE_SYSCALL, testpid, NULL, NULL));
+
+	ptrace(PTRACE_DETACH, testpid, NULL, NULL);
+
+	/* Wait for the child process to terminate */
+	while (waitpid(testpid, &wstatus, 0) != testpid || !WIFEXITED(wstatus))
+		/* wait some more */;
+}
+
+static void test_traced_syscall_numbering(void)
+{
+	pid_t testpid;
+
+	/* Launch the test thread; this thread continues as the tracer thread */
+	testpid = fork();
+
+	if (testpid < 0) {
+		crit("Unable to launch tracer process\n");
+	} else if (testpid == 0) {
+		syscall_numbering_tracee();
+		_exit(0);
+	} else {
+		syscall_numbering_tracer(testpid);
 	}
 }
 
 int main(void)
 {
+	unsigned int nerr;
+
 	/*
 	 * It is quite likely to get a segfault on a failure, so make
 	 * sure the message gets out by setting stdout to nonbuffered.
@@ -288,7 +453,24 @@ int main(void)
 		crit("Unable to open /dev/null: %s\n", strerror(errno));
 	}
 
+	/*
+	 * Set up a block of shared memory...
+	 */
+	sh = mmap(NULL, sysconf(_SC_PAGE_SIZE), PROT_READ|PROT_WRITE,
+		  MAP_ANONYMOUS|MAP_SHARED, 0, 0);
+	if (sh == MAP_FAILED) {
+		crit("Unable to allocated shared memory block: %s\n",
+		     strerror(errno));
+	}
+
+	with_x32 = test_x32();
+
+	run("Running tests without ptrace...\n");
 	test_syscall_numbering();
+
+	test_traced_syscall_numbering();
+
+	nerr = sh->nerr;
 	if (!nerr) {
 		ok("All system calls succeeded or failed as expected\n");
 		return 0;
