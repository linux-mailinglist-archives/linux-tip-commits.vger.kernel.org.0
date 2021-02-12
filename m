Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50466319E89
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:38:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231484AbhBLMiU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:38:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:45320 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231260AbhBLMhu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:37:50 -0500
Date:   Fri, 12 Feb 2021 12:37:06 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133426;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xvScgZzu0y2CsM+k3X8Mfc9PDRdmGvOKHudQODlnAbk=;
        b=gUdYZne9gOh2p+qmDx4DZwWY5FXKzQQStLXsSMMjKHMgVCslR1SdAjnO3uXDLOmX4+gFPf
        t5ySj4VzGX2y733dqpDcqFNuHyni2XK1LQ0MkI+auurM3nzFy9JL2CXzMyuP0HqgdH5Ubi
        NvWzSp/49WeMpl079WKZEFyFblZUVYcdDvRWN3WG7Y6RPafRMtm/Khf8UZDqLTG18pnGNx
        Xrgf07d3lNcKfZJl7LDhip+CE0X/OayWZFNUCmyDF+WzAWFY08fvMG6d8EI1DUQTOdDCMj
        dfnAzDLn4JvXYdDj3osjlILFUV/2YE2jZHxUL8j2BaCdSxjOnJUUyu9LC9gaag==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133426;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=xvScgZzu0y2CsM+k3X8Mfc9PDRdmGvOKHudQODlnAbk=;
        b=41dp4avj9jvG3Fqg+bQHW6QVky0e5ojTB9Rl8m4FGAH2KXkcjFpoJWamcTNQZR1dQ57hLj
        9x3ullHDUD0JVRDQ==
From:   "tip-bot2 for Willy Tarreau" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] tools/nolibc: Implement fork() based on clone()
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        Mark Rutland <mark.rutland@arm.com>, Willy Tarreau <w@1wt.eu>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313342629.23325.12823145130445742962.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     be60ca41fbaa93bc8f92b24e34d8cc62af41300d
Gitweb:        https://git.kernel.org/tip/be60ca41fbaa93bc8f92b24e34d8cc62af41300d
Author:        Willy Tarreau <w@1wt.eu>
AuthorDate:    Thu, 21 Jan 2021 08:20:26 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 21 Jan 2021 10:06:44 -08:00

tools/nolibc: Implement fork() based on clone()

Some archs such as arm64 do not have fork() and have to use clone()
instead.  This commit therefore makes fork() use clone() when
available. This requires including signal.h to get the definition of
SIGCHLD.  This is a port of nolibc's upstream commit d2dc42fd6149 to
the Linux kernel.

Fixes: 66b6f755ad45 ("rcutorture: Import a copy of nolibc")
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com> [arm64]
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/nolibc.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 9209da8..fdd5524 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -271,6 +271,8 @@ struct stat {
 #define WEXITSTATUS(status)   (((status) & 0xff00) >> 8)
 #define WIFEXITED(status)     (((status) & 0x7f) == 0)
 
+/* for SIGCHLD */
+#include <asm/signal.h>
 
 /* Below comes the architecture-specific code. For each architecture, we have
  * the syscall declarations and the _start code definition. This is the only
@@ -1529,7 +1531,15 @@ int sys_execve(const char *filename, char *const argv[], char *const envp[])
 static __attribute__((unused))
 pid_t sys_fork(void)
 {
+#ifdef __NR_clone
+	/* note: some archs only have clone() and not fork(). Different archs
+	 * have a different API, but most archs have the flags on first arg and
+	 * will not use the rest with no other flag.
+	 */
+	return my_syscall5(__NR_clone, SIGCHLD, 0, 0, 0, 0);
+#else
 	return my_syscall0(__NR_fork);
+#endif
 }
 
 static __attribute__((unused))
