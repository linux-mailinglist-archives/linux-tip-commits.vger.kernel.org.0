Return-Path: <linux-tip-commits+bounces-5843-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 18010AD930A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 18:45:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2FA8C188B465
	for <lists+linux-tip-commits@lfdr.de>; Fri, 13 Jun 2025 16:45:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 26EA3219A7E;
	Fri, 13 Jun 2025 16:44:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="dXzBDihS";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Z+/4N+hH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0344A214A6E;
	Fri, 13 Jun 2025 16:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749833076; cv=none; b=kqBdrltIElix0U9qcZXAN4wc1fpYj3ekXTKmOInTZhykzro4VdSVHf1IIWgC3TLebJQ+ntLOv9opPK9cH8cYnQgVhKvMUgy6xENGts+DZIYTxPeH4j7y3DpuKQFUj/7YYqaoum817YYyYaBe7TiNkd94WM2e9ZvaveMFMLvj3h0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749833076; c=relaxed/simple;
	bh=0ZXN1WuV/lX7XS3COQuAduKIyu3l3gNG/FKH5ieV37k=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=CR0hB24EMrq2bcwV87kQeBR8BcY5MjcB6WDWlrXxn/5tMBFWMtSyWuAGxLFeP7a2qjlnYdcJps4wNTsmJRtgCixp9X0UZpAse2YKK7IIt3r2YcRXl5xx1nu5CPHhgZg7ITE7tDKvRhrC2lBtdV1doxSR9HDAB7su23PyZB+ZTzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=dXzBDihS; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Z+/4N+hH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Fri, 13 Jun 2025 16:44:30 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1749833072;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nu6v3mRl1qoly5n2cH0SCi/xD4oj/b5Ro11XBLt1fLs=;
	b=dXzBDihSyY13Ywa39zUR46JliPoMsMECx1T4P60Y8toN4e3WNsprCnXgSQd72D4xJQRvmL
	IYMs7zP4avp2bVyy0rBaNrHgNnN1BKtnQ7qZLhsB7nThwhV87KEaf36LT9uYqAZSBeC7Rr
	iqwec5YKDfE4jVf5O5Fegb49TFg+6jR+gIuE40ArPLw/cgGYyvczT9HrAZLAvPL5ehXEzO
	d7RJ+CoCbi1mlm27CgxwATdV5+xTXdM9qgW5eafDrPcmus35Zr7Ssr5woLtH+KSVSHgZvj
	kXWxrPsmwQE4OIQtYat4W/hNkuhVsL5q/skZHriuWvwDTicB+LDfvB/jX/uH0g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1749833072;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nu6v3mRl1qoly5n2cH0SCi/xD4oj/b5Ro11XBLt1fLs=;
	b=Z+/4N+hHebZGm69C3bfcv1W38feYlwSfwrKG/XNehUa65AivcCBiW/aO9iIGT/0WWRcYhB
	PTBaPnJcLPZqFdDA==
From: "tip-bot2 for Dmitry Vyukov" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: core/entry] selftests: Add tests for PR_SYS_DISPATCH_INCLUSIVE_ON
Cc: Dmitry Vyukov <dvyukov@google.com>, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <8df4b50b176b073550bab5b3f3faff752c5f8e17.1747839857.git.dvyukov@google.com>
References:
 <8df4b50b176b073550bab5b3f3faff752c5f8e17.1747839857.git.dvyukov@google.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174983307077.406.14570090888290217227.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the core/entry branch of tip:

Commit-ID:     b6a5a16b8b59476156dc6d6f73bffaf3a1707adb
Gitweb:        https://git.kernel.org/tip/b6a5a16b8b59476156dc6d6f73bffaf3a1707adb
Author:        Dmitry Vyukov <dvyukov@google.com>
AuthorDate:    Wed, 21 May 2025 17:04:30 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Fri, 13 Jun 2025 18:36:39 +02:00

selftests: Add tests for PR_SYS_DISPATCH_INCLUSIVE_ON

Add tests for PR_SYS_DISPATCH_INCLUSIVE_ON correct/incorrect args,
and a test that ensures that the specified range is respected
by both PR_SYS_DISPATCH_EXCLUSIVE_ON and PR_SYS_DISPATCH_INCLUSIVE_ON.

Signed-off-by: Dmitry Vyukov <dvyukov@google.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/8df4b50b176b073550bab5b3f3faff752c5f8e17.1747839857.git.dvyukov@google.com


---
 tools/testing/selftests/syscall_user_dispatch/sud_test.c | 94 +++++--
 1 file changed, 74 insertions(+), 20 deletions(-)

diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
index 48cf01a..2eb2c06 100644
--- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
@@ -10,6 +10,8 @@
 #include <sys/sysinfo.h>
 #include <sys/syscall.h>
 #include <signal.h>
+#include <stdbool.h>
+#include <stdlib.h>
 
 #include <asm/unistd.h>
 #include "../kselftest_harness.h"
@@ -17,11 +19,15 @@
 #ifndef PR_SET_SYSCALL_USER_DISPATCH
 # define PR_SET_SYSCALL_USER_DISPATCH	59
 # define PR_SYS_DISPATCH_OFF	0
-# define PR_SYS_DISPATCH_ON	1
 # define SYSCALL_DISPATCH_FILTER_ALLOW	0
 # define SYSCALL_DISPATCH_FILTER_BLOCK	1
 #endif
 
+#ifndef PR_SYS_DISPATCH_EXCLUSIVE_ON
+# define PR_SYS_DISPATCH_EXCLUSIVE_ON	1
+# define PR_SYS_DISPATCH_INCLUSIVE_ON	2
+#endif
+
 #ifndef SYS_USER_DISPATCH
 # define SYS_USER_DISPATCH	2
 #endif
@@ -65,7 +71,7 @@ TEST_SIGNAL(dispatch_trigger_sigsys, SIGSYS)
 	ret = sysinfo(&info);
 	ASSERT_EQ(0, ret);
 
-	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, 0, &sel);
+	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_EXCLUSIVE_ON, 0, 0, &sel);
 	ASSERT_EQ(0, ret) {
 		TH_LOG("Kernel does not support CONFIG_SYSCALL_USER_DISPATCH");
 	}
@@ -118,8 +124,8 @@ TEST(bad_prctl_param)
 	/* Valid parameter */
 	prctl_valid(_metadata, op, 0x0, 0x0, 0x0);
 
-	/* PR_SYS_DISPATCH_ON */
-	op = PR_SYS_DISPATCH_ON;
+	/* PR_SYS_DISPATCH_EXCLUSIVE_ON */
+	op = PR_SYS_DISPATCH_EXCLUSIVE_ON;
 
 	/* Dispatcher region is bad (offset > 0 && len == 0) */
 	prctl_invalid(_metadata, op, 0x1, 0x0, &sel, EINVAL);
@@ -131,12 +137,24 @@ TEST(bad_prctl_param)
 	/*
 	 * Dispatcher range overflows unsigned long
 	 */
-	prctl_invalid(_metadata, PR_SYS_DISPATCH_ON, 1, -1L, &sel, EINVAL);
+	prctl_invalid(_metadata, PR_SYS_DISPATCH_EXCLUSIVE_ON, 1, -1L, &sel, EINVAL);
 
 	/*
 	 * Allowed range overflows usigned long
 	 */
-	prctl_invalid(_metadata, PR_SYS_DISPATCH_ON, -1L, 0x1, &sel, EINVAL);
+	prctl_invalid(_metadata, PR_SYS_DISPATCH_EXCLUSIVE_ON, -1L, 0x1, &sel, EINVAL);
+
+	/* 0 len should fail for PR_SYS_DISPATCH_INCLUSIVE_ON */
+	prctl_invalid(_metadata, PR_SYS_DISPATCH_INCLUSIVE_ON, 1, 0, 0, EINVAL);
+
+	/* Range wrap-around should fail */
+	prctl_invalid(_metadata, PR_SYS_DISPATCH_INCLUSIVE_ON, -1L, 2, 0, EINVAL);
+
+	/* Normal range shouldn't fail */
+	prctl_valid(_metadata, PR_SYS_DISPATCH_INCLUSIVE_ON, 2, 3, 0);
+
+	/* Invalid selector */
+	prctl_invalid(_metadata, PR_SYS_DISPATCH_INCLUSIVE_ON, 2, 3, (void *) -1, EFAULT);
 }
 
 /*
@@ -147,11 +165,13 @@ char glob_sel;
 int nr_syscalls_emulated;
 int si_code;
 int si_errno;
+unsigned long syscall_addr;
 
 static void handle_sigsys(int sig, siginfo_t *info, void *ucontext)
 {
 	si_code = info->si_code;
 	si_errno = info->si_errno;
+	syscall_addr = (unsigned long)info->si_call_addr;
 
 	if (info->si_syscall == MAGIC_SYSCALL_1)
 		nr_syscalls_emulated++;
@@ -174,31 +194,34 @@ static void handle_sigsys(int sig, siginfo_t *info, void *ucontext)
 #endif
 }
 
-TEST(dispatch_and_return)
+int setup_sigsys_handler(void)
 {
-	long ret;
 	struct sigaction act;
 	sigset_t mask;
 
-	glob_sel = 0;
-	nr_syscalls_emulated = 0;
-	si_code = 0;
-	si_errno = 0;
-
 	memset(&act, 0, sizeof(act));
 	sigemptyset(&mask);
-
 	act.sa_sigaction = handle_sigsys;
 	act.sa_flags = SA_SIGINFO;
 	act.sa_mask = mask;
+	return sigaction(SIGSYS, &act, NULL);
+}
 
-	ret = sigaction(SIGSYS, &act, NULL);
-	ASSERT_EQ(0, ret);
+TEST(dispatch_and_return)
+{
+	long ret;
+
+	glob_sel = 0;
+	nr_syscalls_emulated = 0;
+	si_code = 0;
+	si_errno = 0;
+
+	ASSERT_EQ(0, setup_sigsys_handler());
 
 	/* Make sure selector is good prior to prctl. */
 	SYSCALL_DISPATCH_OFF(glob_sel);
 
-	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, 0, &glob_sel);
+	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_EXCLUSIVE_ON, 0, 0, &glob_sel);
 	ASSERT_EQ(0, ret) {
 		TH_LOG("Kernel does not support CONFIG_SYSCALL_USER_DISPATCH");
 	}
@@ -254,7 +277,7 @@ TEST_SIGNAL(bad_selector, SIGSYS)
 	/* Make sure selector is good prior to prctl. */
 	SYSCALL_DISPATCH_OFF(glob_sel);
 
-	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, 0, &glob_sel);
+	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_EXCLUSIVE_ON, 0, 0, &glob_sel);
 	ASSERT_EQ(0, ret) {
 		TH_LOG("Kernel does not support CONFIG_SYSCALL_USER_DISPATCH");
 	}
@@ -278,7 +301,7 @@ TEST(disable_dispatch)
 	struct sysinfo info;
 	char sel = 0;
 
-	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, 0, &sel);
+	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_EXCLUSIVE_ON, 0, 0, &sel);
 	ASSERT_EQ(0, ret) {
 		TH_LOG("Kernel does not support CONFIG_SYSCALL_USER_DISPATCH");
 	}
@@ -310,7 +333,7 @@ TEST(direct_dispatch_range)
 	 * Instead of calculating libc addresses; allow the entire
 	 * memory map and lock the selector.
 	 */
-	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_ON, 0, -1L, &sel);
+	ret = prctl(PR_SET_SYSCALL_USER_DISPATCH, PR_SYS_DISPATCH_EXCLUSIVE_ON, 0, -1L, &sel);
 	ASSERT_EQ(0, ret) {
 		TH_LOG("Kernel does not support CONFIG_SYSCALL_USER_DISPATCH");
 	}
@@ -323,4 +346,35 @@ TEST(direct_dispatch_range)
 	}
 }
 
+static void test_range(struct __test_metadata *_metadata,
+		       unsigned long op, unsigned long off,
+		       unsigned long size, bool dispatch)
+{
+	nr_syscalls_emulated = 0;
+	SYSCALL_DISPATCH_OFF(glob_sel);
+	EXPECT_EQ(0, prctl(PR_SET_SYSCALL_USER_DISPATCH, op, off, size, &glob_sel));
+	SYSCALL_DISPATCH_ON(glob_sel);
+	if (dispatch) {
+		EXPECT_EQ(syscall(MAGIC_SYSCALL_1), MAGIC_SYSCALL_1);
+		EXPECT_EQ(nr_syscalls_emulated, 1);
+	} else {
+		EXPECT_EQ(syscall(MAGIC_SYSCALL_1), -1);
+		EXPECT_EQ(nr_syscalls_emulated, 0);
+	}
+}
+
+TEST(dispatch_range)
+{
+	ASSERT_EQ(0, setup_sigsys_handler());
+	test_range(_metadata, PR_SYS_DISPATCH_EXCLUSIVE_ON, 0, 0, true);
+	test_range(_metadata, PR_SYS_DISPATCH_EXCLUSIVE_ON, syscall_addr, 1, false);
+	test_range(_metadata, PR_SYS_DISPATCH_EXCLUSIVE_ON, syscall_addr-100, 200, false);
+	test_range(_metadata, PR_SYS_DISPATCH_EXCLUSIVE_ON, syscall_addr+1, 100, true);
+	test_range(_metadata, PR_SYS_DISPATCH_EXCLUSIVE_ON, syscall_addr-100, 100, true);
+	test_range(_metadata, PR_SYS_DISPATCH_INCLUSIVE_ON, syscall_addr, 1, true);
+	test_range(_metadata, PR_SYS_DISPATCH_INCLUSIVE_ON, syscall_addr-1, 1, false);
+	test_range(_metadata, PR_SYS_DISPATCH_INCLUSIVE_ON, syscall_addr+1, 1, false);
+	SYSCALL_DISPATCH_OFF(glob_sel);
+}
+
 TEST_HARNESS_MAIN

