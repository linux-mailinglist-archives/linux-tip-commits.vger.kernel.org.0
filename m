Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 348BB3118BF
	for <lists+linux-tip-commits@lfdr.de>; Sat,  6 Feb 2021 03:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231424AbhBFCpA (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 5 Feb 2021 21:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231476AbhBFCkR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 5 Feb 2021 21:40:17 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46D2BC08ED89;
        Fri,  5 Feb 2021 15:25:31 -0800 (PST)
Date:   Fri, 05 Feb 2021 23:24:42 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1612567484;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZnEceAcJS8RbJxqxuC/DUSlKXfvuFogvHWnmfyoEmiA=;
        b=28/ipzOD5LSAJOUrZzG3hp6nprNMFCNX8AZgsojfv9lWAjQngJTYk7BdEjN55dDZIlhiFv
        UqrWXs5z7rrxlvQ0x3bmpWRCmBZvSkEuGc6znGOTCxB3N9DFhZB1itcepMNaGTFu+khzSj
        qZ38kAUhu4htRL1mBPy9xNixaZLg0pfYirjZI6SKHoGHgsUHeSKPwOn3vH230ExZi0rxDG
        7b8fNNSYOnGy78dO/jkNYc45kg7TGB7EBXHzefOs9eXuM20ISTFxCVP3T1DDXcgeSMGuhJ
        BZau0XNcT6Y4yQ+PWNxCpbJkA9vMuslApWfKmoX1GNPnImZLyXMOIwAuqNlmzg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1612567484;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZnEceAcJS8RbJxqxuC/DUSlKXfvuFogvHWnmfyoEmiA=;
        b=Ye5Akb2u3WJjSCUVfGjj1Yfc7D3mxj0401n8rUN3VqQZ+ADPyjm1zD28Z9bbIHqGUWibXM
        B38fBtakSHOm2PAw==
From:   "tip-bot2 for Gabriel Krisman Bertazi" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/urgent] entry: Use different define for selector variable in SUD
Cc:     "Michael Kerrisk (man-pages)" <mtk.manpages@gmail.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210205184321.2062251-1-krisman@collabora.com>
References: <20210205184321.2062251-1-krisman@collabora.com>
MIME-Version: 1.0
Message-ID: <161256748291.23325.9194806071651632586.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/urgent branch of tip:

Commit-ID:     36a6c843fd0d8e02506681577e96dabd203dd8e8
Gitweb:        https://git.kernel.org/tip/36a6c843fd0d8e02506681577e96dabd203dd8e8
Author:        Gabriel Krisman Bertazi <krisman@collabora.com>
AuthorDate:    Fri, 05 Feb 2021 13:43:21 -05:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 06 Feb 2021 00:21:42 +01:00

entry: Use different define for selector variable in SUD

Michael Kerrisk suggested that, from an API perspective, it is a bad
idea to share the PR_SYS_DISPATCH_ defines between the prctl operation
and the selector variable.

Therefore, define two new constants to be used by SUD's selector variable
and update the corresponding documentation and test cases.

While this changes the API syscall user dispatch has never been part of a
Linux release, it will show up for the first time in 5.11.

Suggested-by: Michael Kerrisk (man-pages) <mtk.manpages@gmail.com>
Signed-off-by: Gabriel Krisman Bertazi <krisman@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210205184321.2062251-1-krisman@collabora.com


---
 Documentation/admin-guide/syscall-user-dispatch.rst           |  4 +-
 include/uapi/linux/prctl.h                                    |  3 ++-
 kernel/entry/syscall_user_dispatch.c                          |  4 +-
 tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c |  8 ++--
 tools/testing/selftests/syscall_user_dispatch/sud_test.c      | 14 ++++---
 5 files changed, 20 insertions(+), 13 deletions(-)

diff --git a/Documentation/admin-guide/syscall-user-dispatch.rst b/Documentation/admin-guide/syscall-user-dispatch.rst
index a380d65..6031495 100644
--- a/Documentation/admin-guide/syscall-user-dispatch.rst
+++ b/Documentation/admin-guide/syscall-user-dispatch.rst
@@ -70,8 +70,8 @@ trampoline code on the vDSO, that trampoline is never intercepted.
 [selector] is a pointer to a char-sized region in the process memory
 region, that provides a quick way to enable disable syscall redirection
 thread-wide, without the need to invoke the kernel directly.  selector
-can be set to PR_SYS_DISPATCH_ON or PR_SYS_DISPATCH_OFF.  Any other
-value should terminate the program with a SIGSYS.
+can be set to SYSCALL_DISPATCH_FILTER_ALLOW or SYSCALL_DISPATCH_FILTER_BLOCK.
+Any other value should terminate the program with a SIGSYS.
 
 Security Notes
 --------------
diff --git a/include/uapi/linux/prctl.h b/include/uapi/linux/prctl.h
index 90deb41..667f1ae 100644
--- a/include/uapi/linux/prctl.h
+++ b/include/uapi/linux/prctl.h
@@ -251,5 +251,8 @@ struct prctl_mm_map {
 #define PR_SET_SYSCALL_USER_DISPATCH	59
 # define PR_SYS_DISPATCH_OFF		0
 # define PR_SYS_DISPATCH_ON		1
+/* The control values for the user space selector when dispatch is enabled */
+# define SYSCALL_DISPATCH_FILTER_ALLOW	0
+# define SYSCALL_DISPATCH_FILTER_BLOCK	1
 
 #endif /* _LINUX_PRCTL_H */
diff --git a/kernel/entry/syscall_user_dispatch.c b/kernel/entry/syscall_user_dispatch.c
index b0338a5..c240302 100644
--- a/kernel/entry/syscall_user_dispatch.c
+++ b/kernel/entry/syscall_user_dispatch.c
@@ -50,10 +50,10 @@ bool syscall_user_dispatch(struct pt_regs *regs)
 		if (unlikely(__get_user(state, sd->selector)))
 			do_exit(SIGSEGV);
 
-		if (likely(state == PR_SYS_DISPATCH_OFF))
+		if (likely(state == SYSCALL_DISPATCH_FILTER_ALLOW))
 			return false;
 
-		if (state != PR_SYS_DISPATCH_ON)
+		if (state != SYSCALL_DISPATCH_FILTER_BLOCK)
 			do_exit(SIGSYS);
 	}
 
diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c b/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c
index 6689f11..073a037 100644
--- a/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_benchmark.c
@@ -22,6 +22,8 @@
 # define PR_SET_SYSCALL_USER_DISPATCH	59
 # define PR_SYS_DISPATCH_OFF	0
 # define PR_SYS_DISPATCH_ON	1
+# define SYSCALL_DISPATCH_FILTER_ALLOW	0
+# define SYSCALL_DISPATCH_FILTER_BLOCK	1
 #endif
 
 #ifdef __NR_syscalls
@@ -55,8 +57,8 @@ unsigned long trapped_call_count = 0;
 unsigned long native_call_count = 0;
 
 char selector;
-#define SYSCALL_BLOCK   (selector = PR_SYS_DISPATCH_ON)
-#define SYSCALL_UNBLOCK (selector = PR_SYS_DISPATCH_OFF)
+#define SYSCALL_BLOCK   (selector = SYSCALL_DISPATCH_FILTER_BLOCK)
+#define SYSCALL_UNBLOCK (selector = SYSCALL_DISPATCH_FILTER_ALLOW)
 
 #define CALIBRATION_STEP 100000
 #define CALIBRATE_TO_SECS 5
@@ -170,7 +172,7 @@ int main(void)
 	syscall(MAGIC_SYSCALL_1);
 
 #ifdef TEST_BLOCKED_RETURN
-	if (selector == PR_SYS_DISPATCH_OFF) {
+	if (selector == SYSCALL_DISPATCH_FILTER_ALLOW) {
 		fprintf(stderr, "Failed to return with selector blocked.\n");
 		exit(-1);
 	}
diff --git a/tools/testing/selftests/syscall_user_dispatch/sud_test.c b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
index 6498b05..b5d592d 100644
--- a/tools/testing/selftests/syscall_user_dispatch/sud_test.c
+++ b/tools/testing/selftests/syscall_user_dispatch/sud_test.c
@@ -18,6 +18,8 @@
 # define PR_SET_SYSCALL_USER_DISPATCH	59
 # define PR_SYS_DISPATCH_OFF	0
 # define PR_SYS_DISPATCH_ON	1
+# define SYSCALL_DISPATCH_FILTER_ALLOW	0
+# define SYSCALL_DISPATCH_FILTER_BLOCK	1
 #endif
 
 #ifndef SYS_USER_DISPATCH
@@ -30,8 +32,8 @@
 # define MAGIC_SYSCALL_1 (0xff00)  /* Bad Linux syscall number */
 #endif
 
-#define SYSCALL_DISPATCH_ON(x) ((x) = 1)
-#define SYSCALL_DISPATCH_OFF(x) ((x) = 0)
+#define SYSCALL_DISPATCH_ON(x) ((x) = SYSCALL_DISPATCH_FILTER_BLOCK)
+#define SYSCALL_DISPATCH_OFF(x) ((x) = SYSCALL_DISPATCH_FILTER_ALLOW)
 
 /* Test Summary:
  *
@@ -56,7 +58,7 @@
 
 TEST_SIGNAL(dispatch_trigger_sigsys, SIGSYS)
 {
-	char sel = 0;
+	char sel = SYSCALL_DISPATCH_FILTER_ALLOW;
 	struct sysinfo info;
 	int ret;
 
@@ -79,7 +81,7 @@ TEST_SIGNAL(dispatch_trigger_sigsys, SIGSYS)
 
 TEST(bad_prctl_param)
 {
-	char sel = 0;
+	char sel = SYSCALL_DISPATCH_FILTER_ALLOW;
 	int op;
 
 	/* Invalid op */
@@ -220,7 +222,7 @@ TEST_SIGNAL(bad_selector, SIGSYS)
 	sigset_t mask;
 	struct sysinfo info;
 
-	glob_sel = 0;
+	glob_sel = SYSCALL_DISPATCH_FILTER_ALLOW;
 	nr_syscalls_emulated = 0;
 	si_code = 0;
 	si_errno = 0;
@@ -288,7 +290,7 @@ TEST(direct_dispatch_range)
 {
 	int ret = 0;
 	struct sysinfo info;
-	char sel = 0;
+	char sel = SYSCALL_DISPATCH_FILTER_ALLOW;
 
 	/*
 	 * Instead of calculating libc addresses; allow the entire
