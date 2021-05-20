Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4D838AFD8
	for <lists+linux-tip-commits@lfdr.de>; Thu, 20 May 2021 15:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239372AbhETNZD (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 20 May 2021 09:25:03 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:46866 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237007AbhETNYz (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 20 May 2021 09:24:55 -0400
Date:   Thu, 20 May 2021 13:23:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1621517012;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kOEPpL3tVxVr58047U9fHBQOdauXHRIlzyZmclFhDRA=;
        b=E1QQCVLZQels3elmxpL0Hx2WGjyyaH2wp4S82hjwNlIY+GpUS5mmH7f3gJQmnuLaphUzW9
        DxanceioEM3Q2e+Y0jPX9K9D8mHMKUxe0y8BrIcaEzR9x0hOU2hArKf6wknwXbd+SnGNJa
        gokzilePEXwbzGTfD2P4tcz+bsdcBl3OiW4q+22vUCB8ebUxp7FYSrF9kZmpAj8AC7KqKC
        6qwEPfHrO5N3g4m0Csqqrru03ySDXepe4mCtnTBAngPTL6doDNEooVCsl7lYNZpSygl3vN
        LisUlM6w+KAaNn+CXoW1AT2sq1DpObVUM9BTTjhSG+d5XFdd+2D2+A2Ao19/Lg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1621517012;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=kOEPpL3tVxVr58047U9fHBQOdauXHRIlzyZmclFhDRA=;
        b=NbUvwxKc8BDMglpsY4NIQg0tDwVhzRgVC5UE4zMuBD3tAOjXwtq9QLSTBZoW5ckAXEzH/Q
        yaf+xMIvretcu8Bw==
From:   "tip-bot2 for H. Peter Anvin (Intel)" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] selftests/x86/syscall: Simplify message reporting in
 syscall_numbering
Cc:     "H. Peter Anvin (Intel)" <hpa@zytor.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210518191303.4135296-3-hpa@zytor.com>
References: <20210518191303.4135296-3-hpa@zytor.com>
MIME-Version: 1.0
Message-ID: <162151701197.29796.5302522714945670258.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     c5c39488dcb5f818bb07f856a349262d667ef147
Gitweb:        https://git.kernel.org/tip/c5c39488dcb5f818bb07f856a349262d667ef147
Author:        H. Peter Anvin (Intel) <hpa@zytor.com>
AuthorDate:    Tue, 18 May 2021 12:12:59 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 20 May 2021 15:19:48 +02:00

selftests/x86/syscall: Simplify message reporting in syscall_numbering

Reduce some boiler plate in printing and indenting messages.
This makes it easier to produce clean status output.

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210518191303.4135296-3-hpa@zytor.com

---
 tools/testing/selftests/x86/syscall_numbering.c | 103 ++++++++++-----
 1 file changed, 72 insertions(+), 31 deletions(-)

diff --git a/tools/testing/selftests/x86/syscall_numbering.c b/tools/testing/selftests/x86/syscall_numbering.c
index 7dd86bc..434fe0e 100644
--- a/tools/testing/selftests/x86/syscall_numbering.c
+++ b/tools/testing/selftests/x86/syscall_numbering.c
@@ -16,6 +16,7 @@
 #include <string.h>
 #include <fcntl.h>
 #include <limits.h>
+#include <sysexits.h>
 
 /* Common system call numbers */
 #define SYS_READ	  0
@@ -34,6 +35,33 @@
 
 static unsigned int nerr = 0;	/* Cumulative error count */
 static int nullfd = -1;		/* File descriptor for /dev/null */
+static int indent = 0;
+
+static inline unsigned int offset(void)
+{
+	return 8 + indent * 4;
+}
+
+#define msg(lvl, fmt, ...) printf("%-*s" fmt, offset(), "[" #lvl "]", \
+				  ## __VA_ARGS__)
+
+#define run(fmt, ...)  msg(RUN,  fmt, ## __VA_ARGS__)
+#define info(fmt, ...) msg(INFO, fmt, ## __VA_ARGS__)
+#define ok(fmt, ...)   msg(OK,   fmt, ## __VA_ARGS__)
+
+#define fail(fmt, ...)					\
+	do {						\
+		msg(FAIL, fmt, ## __VA_ARGS__);		\
+		nerr++;					\
+	} while (0)
+
+#define crit(fmt, ...)					\
+	do {						\
+		indent = 0;				\
+		msg(FAIL, fmt, ## __VA_ARGS__);		\
+		msg(SKIP, "Unable to run test\n");	\
+		exit(EX_OSERR);
+	} while (0)
 
 /*
  * Directly invokes the given syscall with nullfd as the first argument
@@ -91,28 +119,37 @@ static unsigned int _check_for(int msb, int start, int end, long long expect,
 {
 	unsigned int err = 0;
 
+	indent++;
+	if (start != end)
+		indent++;
+
 	for (int nr = start; nr <= end; nr++) {
 		long long ret = probe_syscall(msb, nr);
 
 		if (ret != expect) {
-			printf("[FAIL]\t      %s returned %lld, but it should have returned %s\n",
+			fail("%s returned %lld, but it should have returned %s\n",
 			       syscall_str(msb, nr, nr),
 			       ret, expect_str);
 			err++;
 		}
 	}
 
+	if (start != end)
+		indent--;
+
 	if (err) {
 		nerr += err;
 		if (start != end)
-			printf("[FAIL]\t      %s had %u failure%s\n",
+			fail("%s had %u failure%s\n",
 			       syscall_str(msb, start, end),
-			       err, (err == 1) ? "s" : "");
+			       err, err == 1 ? "s" : "");
 	} else {
-		printf("[OK]\t      %s returned %s as expected\n",
-		       syscall_str(msb, start, end), expect_str);
+		ok("%s returned %s as expected\n",
+		   syscall_str(msb, start, end), expect_str);
 	}
 
+	indent--;
+
 	return err;
 }
 
@@ -137,35 +174,38 @@ static bool check_enosys(int msb, int nr)
 static bool test_x32(void)
 {
 	long long ret;
-	long long mypid = getpid();
+	pid_t mypid = getpid();
+	bool with_x32;
 
-	printf("[RUN]\tChecking for x32 by calling x32 getpid()\n");
+	run("Checking for x32 by calling x32 getpid()\n");
 	ret = probe_syscall(0, SYS_GETPID | X32_BIT);
 
+	indent++;
 	if (ret == mypid) {
-		printf("[INFO]\t   x32 is supported\n");
-		return true;
+		info("x32 is supported\n");
+		with_x32 = true;
 	} else if (ret == -ENOSYS) {
-		printf("[INFO]\t   x32 is not supported\n");
-		return false;
+		info("x32 is not supported\n");
+		with_x32 = false;
 	} else {
-		printf("[FAIL]\t   x32 getpid() returned %lld, but it should have returned either %lld or -ENOSYS\n", ret, mypid);
-		nerr++;
-		return true;	/* Proceed as if... */
+		fail("x32 getpid() returned %lld, but it should have returned either %lld or -ENOSYS\n", ret, mypid);
+		with_x32 = false;
 	}
+	indent--;
+	return with_x32;
 }
 
 static void test_syscalls_common(int msb)
 {
-	printf("[RUN]\t   Checking some common syscalls as 64 bit\n");
+	run("Checking some common syscalls as 64 bit\n");
 	check_zero(msb, SYS_READ);
 	check_zero(msb, SYS_WRITE);
 
-	printf("[RUN]\t   Checking some 64-bit only syscalls as 64 bit\n");
+	run("Checking some 64-bit only syscalls as 64 bit\n");
 	check_zero(msb, X64_READV);
 	check_zero(msb, X64_WRITEV);
 
-	printf("[RUN]\t   Checking out of range system calls\n");
+	run("Checking out of range system calls\n");
 	check_for(msb, -64, -1, -ENOSYS);
 	check_for(msb, X32_BIT-64, X32_BIT-1, -ENOSYS);
 	check_for(msb, -64-X32_BIT, -1-X32_BIT, -ENOSYS);
@@ -180,18 +220,18 @@ static void test_syscalls_with_x32(int msb)
 	 * set.  Calling them without the x32 bit set is
 	 * nonsense and should not work.
 	 */
-	printf("[RUN]\t   Checking x32 syscalls as 64 bit\n");
+	run("Checking x32 syscalls as 64 bit\n");
 	check_for(msb, 512, 547, -ENOSYS);
 
-	printf("[RUN]\t   Checking some common syscalls as x32\n");
+	run("Checking some common syscalls as x32\n");
 	check_zero(msb, SYS_READ   | X32_BIT);
 	check_zero(msb, SYS_WRITE  | X32_BIT);
 
-	printf("[RUN]\t   Checking some x32 syscalls as x32\n");
+	run("Checking some x32 syscalls as x32\n");
 	check_zero(msb, X32_READV  | X32_BIT);
 	check_zero(msb, X32_WRITEV | X32_BIT);
 
-	printf("[RUN]\t   Checking some 64-bit syscalls as x32\n");
+	run("Checking some 64-bit syscalls as x32\n");
 	check_enosys(msb, X64_IOCTL  | X32_BIT);
 	check_enosys(msb, X64_READV  | X32_BIT);
 	check_enosys(msb, X64_WRITEV | X32_BIT);
@@ -199,7 +239,7 @@ static void test_syscalls_with_x32(int msb)
 
 static void test_syscalls_without_x32(int msb)
 {
-	printf("[RUN]\t  Checking for absence of x32 system calls\n");
+	run("Checking for absence of x32 system calls\n");
 	check_for(msb, 0 | X32_BIT, 999 | X32_BIT, -ENOSYS);
 }
 
@@ -217,14 +257,18 @@ static void test_syscall_numbering(void)
 	 */
 	for (size_t i = 0; i < sizeof(msbs)/sizeof(msbs[0]); i++) {
 		int msb = msbs[i];
-		printf("[RUN]\tChecking system calls with msb = %d (0x%x)\n",
-		       msb, msb);
+		run("Checking system calls with msb = %d (0x%x)\n",
+		    msb, msb);
+
+		indent++;
 
 		test_syscalls_common(msb);
 		if (with_x32)
 			test_syscalls_with_x32(msb);
 		else
 			test_syscalls_without_x32(msb);
+
+		indent--;
 	}
 }
 
@@ -241,19 +285,16 @@ int main(void)
 	 */
 	nullfd = open("/dev/null", O_RDWR);
 	if (nullfd < 0) {
-		printf("[FAIL]\tUnable to open /dev/null: %s\n",
-		       strerror(errno));
-		printf("[SKIP]\tCannot execute test\n");
-		return 71;	/* EX_OSERR */
+		crit("Unable to open /dev/null: %s\n", strerror(errno));
 	}
 
 	test_syscall_numbering();
 	if (!nerr) {
-		printf("[OK]\tAll system calls succeeded or failed as expected\n");
+		ok("All system calls succeeded or failed as expected\n");
 		return 0;
 	} else {
-		printf("[FAIL]\tA total of %u system call%s had incorrect behavior\n",
-		       nerr, nerr != 1 ? "s" : "");
+		fail("A total of %u system call%s had incorrect behavior\n",
+		     nerr, nerr != 1 ? "s" : "");
 		return 1;
 	}
 }
