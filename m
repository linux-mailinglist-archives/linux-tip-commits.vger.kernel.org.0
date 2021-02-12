Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C8E0319EA7
	for <lists+linux-tip-commits@lfdr.de>; Fri, 12 Feb 2021 13:42:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbhBLMjs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 12 Feb 2021 07:39:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbhBLMia (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 12 Feb 2021 07:38:30 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CFB9C06178B;
        Fri, 12 Feb 2021 04:37:09 -0800 (PST)
Date:   Fri, 12 Feb 2021 12:37:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1613133425;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pGoksZCG4uuUCm7jg192kUqu3nkqhWsWhJ05rL2N4pU=;
        b=aumVxR1nbW/K1jrvFtMJttLhROqGoNftMKkdlOEVlBu6F4SW8Dn1NMtCZ8vTP7O/5Nz30n
        CPMt0ZTdoZeAR1eQVpgyhmTE75lQORFkhJrEHEnlb/cNpnECfbb0m0pTvdlgzqxYzbqebr
        W6fHs9jlPD5mXb2e2a3jC4bov/5hdWs9ImSN+issuABDk9xQ/6HAkUu0KkFaGX5D4zQRTl
        EE+SJuj6NWiUomwgrH83lCZErypCBGEKSdFgMckbTvM4TxNjScmRCFce8ytkEFotS8DmM4
        l46zwTbiT0a2SjBVZYXkeUOI6m3w/B/3fzteofT+5dcworYVqkMDFbbG5ubN3g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1613133425;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:  content-transfer-encoding:content-transfer-encoding;
        bh=pGoksZCG4uuUCm7jg192kUqu3nkqhWsWhJ05rL2N4pU=;
        b=pg1xhJFdB5BvjF4N125+mM/YiXTASda0wnqTaT3FzxnT1YK/HF0rP0WWu/7zzAFhoHNSG9
        LsFOKadiQRtdZzCg==
From:   "tip-bot2 for Willy Tarreau" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: core/rcu] tools/nolibc: Emit detailed error for missing
 alternate syscall number definitions
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Willy Tarreau <w@1wt.eu>,
        "Paul E. McKenney" <paulmck@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
MIME-Version: 1.0
Message-ID: <161313342502.23325.2848737068366858395.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the core/rcu branch of tip:

Commit-ID:     35635d7fa689492ca9edb1d949f1805f074ecf1a
Gitweb:        https://git.kernel.org/tip/35635d7fa689492ca9edb1d949f1805f074ecf1a
Author:        Willy Tarreau <w@1wt.eu>
AuthorDate:    Thu, 21 Jan 2021 08:20:30 +01:00
Committer:     Paul E. McKenney <paulmck@kernel.org>
CommitterDate: Thu, 21 Jan 2021 10:06:45 -08:00

tools/nolibc: Emit detailed error for missing alternate syscall number definitions

Some syscalls can be implemented from different __NR_* variants. For
example, sys_dup2() can be implemented based on __NR_dup3 or __NR_dup2.
In this case it is useful to mention both alternatives in error messages
when neither are detected. This information will help the user search for
the right one (e.g __NR_dup3) instead of just the fallback (__NR_dup2)
which might not exist on the platform.

This is a port of nolibc's upstream commit a21080d2ba41 to the Linux
kernel.

Suggested-by: Mark Rutland <mark.rutland@arm.com>
Link: https://lore.kernel.org/lkml/20210120145447.GC77728@C02TD0UTHF1T.local/
Tested-by: Valentin Schneider <valentin.schneider@arm.com>
Tested-by: Mark Rutland <mark.rutland@arm.com> [arm64]
Signed-off-by: Willy Tarreau <w@1wt.eu>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 tools/include/nolibc/nolibc.h | 52 +++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 13 deletions(-)

diff --git a/tools/include/nolibc/nolibc.h b/tools/include/nolibc/nolibc.h
index 475d956..618acad 100644
--- a/tools/include/nolibc/nolibc.h
+++ b/tools/include/nolibc/nolibc.h
@@ -1446,8 +1446,10 @@ int sys_chmod(const char *path, mode_t mode)
 {
 #ifdef __NR_fchmodat
 	return my_syscall4(__NR_fchmodat, AT_FDCWD, path, mode, 0);
-#else
+#elif defined(__NR_chmod)
 	return my_syscall2(__NR_chmod, path, mode);
+#else
+#error Neither __NR_fchmodat nor __NR_chmod defined, cannot implement sys_chmod()
 #endif
 }
 
@@ -1456,8 +1458,10 @@ int sys_chown(const char *path, uid_t owner, gid_t group)
 {
 #ifdef __NR_fchownat
 	return my_syscall5(__NR_fchownat, AT_FDCWD, path, owner, group, 0);
-#else
+#elif defined(__NR_chown)
 	return my_syscall3(__NR_chown, path, owner, group);
+#else
+#error Neither __NR_fchownat nor __NR_chown defined, cannot implement sys_chown()
 #endif
 }
 
@@ -1492,8 +1496,10 @@ int sys_dup2(int old, int new)
 {
 #ifdef __NR_dup3
 	return my_syscall3(__NR_dup3, old, new, 0);
-#else
+#elif defined(__NR_dup2)
 	return my_syscall2(__NR_dup2, old, new);
+#else
+#error Neither __NR_dup3 nor __NR_dup2 defined, cannot implement sys_dup2()
 #endif
 }
 
@@ -1512,8 +1518,10 @@ pid_t sys_fork(void)
 	 * will not use the rest with no other flag.
 	 */
 	return my_syscall5(__NR_clone, SIGCHLD, 0, 0, 0, 0);
-#else
+#elif defined(__NR_fork)
 	return my_syscall0(__NR_fork);
+#else
+#error Neither __NR_clone nor __NR_fork defined, cannot implement sys_fork()
 #endif
 }
 
@@ -1570,8 +1578,10 @@ int sys_link(const char *old, const char *new)
 {
 #ifdef __NR_linkat
 	return my_syscall5(__NR_linkat, AT_FDCWD, old, AT_FDCWD, new, 0);
-#else
+#elif defined(__NR_link)
 	return my_syscall2(__NR_link, old, new);
+#else
+#error Neither __NR_linkat nor __NR_link defined, cannot implement sys_link()
 #endif
 }
 
@@ -1586,8 +1596,10 @@ int sys_mkdir(const char *path, mode_t mode)
 {
 #ifdef __NR_mkdirat
 	return my_syscall3(__NR_mkdirat, AT_FDCWD, path, mode);
-#else
+#elif defined(__NR_mkdir)
 	return my_syscall2(__NR_mkdir, path, mode);
+#else
+#error Neither __NR_mkdirat nor __NR_mkdir defined, cannot implement sys_mkdir()
 #endif
 }
 
@@ -1596,8 +1608,10 @@ long sys_mknod(const char *path, mode_t mode, dev_t dev)
 {
 #ifdef __NR_mknodat
 	return my_syscall4(__NR_mknodat, AT_FDCWD, path, mode, dev);
-#else
+#elif defined(__NR_mknod)
 	return my_syscall3(__NR_mknod, path, mode, dev);
+#else
+#error Neither __NR_mknodat nor __NR_mknod defined, cannot implement sys_mknod()
 #endif
 }
 
@@ -1613,8 +1627,10 @@ int sys_open(const char *path, int flags, mode_t mode)
 {
 #ifdef __NR_openat
 	return my_syscall4(__NR_openat, AT_FDCWD, path, flags, mode);
-#else
+#elif defined(__NR_open)
 	return my_syscall3(__NR_open, path, flags, mode);
+#else
+#error Neither __NR_openat nor __NR_open defined, cannot implement sys_open()
 #endif
 }
 
@@ -1635,8 +1651,10 @@ int sys_poll(struct pollfd *fds, int nfds, int timeout)
 		t.tv_nsec = (timeout % 1000) * 1000000;
 	}
 	return my_syscall4(__NR_ppoll, fds, nfds, (timeout >= 0) ? &t : NULL, NULL);
-#else
+#elif defined(__NR_poll)
 	return my_syscall3(__NR_poll, fds, nfds, timeout);
+#else
+#error Neither __NR_ppoll nor __NR_poll defined, cannot implement sys_poll()
 #endif
 }
 
@@ -1676,11 +1694,13 @@ int sys_select(int nfds, fd_set *rfds, fd_set *wfds, fd_set *efds, struct timeva
 		t.tv_nsec = timeout->tv_usec * 1000;
 	}
 	return my_syscall6(__NR_pselect6, nfds, rfds, wfds, efds, timeout ? &t : NULL, NULL);
-#else
+#elif defined(__NR__newselect) || defined(__NR_select)
 #ifndef __NR__newselect
 #define __NR__newselect __NR_select
 #endif
 	return my_syscall5(__NR__newselect, nfds, rfds, wfds, efds, timeout);
+#else
+#error None of __NR_select, __NR_pselect6, nor __NR__newselect defined, cannot implement sys_select()
 #endif
 }
 
@@ -1705,8 +1725,10 @@ int sys_stat(const char *path, struct stat *buf)
 #ifdef __NR_newfstatat
 	/* only solution for arm64 */
 	ret = my_syscall4(__NR_newfstatat, AT_FDCWD, path, &stat, 0);
-#else
+#elif defined(__NR_stat)
 	ret = my_syscall2(__NR_stat, path, &stat);
+#else
+#error Neither __NR_newfstatat nor __NR_stat defined, cannot implement sys_stat()
 #endif
 	buf->st_dev     = stat.st_dev;
 	buf->st_ino     = stat.st_ino;
@@ -1730,8 +1752,10 @@ int sys_symlink(const char *old, const char *new)
 {
 #ifdef __NR_symlinkat
 	return my_syscall3(__NR_symlinkat, old, AT_FDCWD, new);
-#else
+#elif defined(__NR_symlink)
 	return my_syscall2(__NR_symlink, old, new);
+#else
+#error Neither __NR_symlinkat nor __NR_symlink defined, cannot implement sys_symlink()
 #endif
 }
 
@@ -1752,8 +1776,10 @@ int sys_unlink(const char *path)
 {
 #ifdef __NR_unlinkat
 	return my_syscall3(__NR_unlinkat, AT_FDCWD, path, 0);
-#else
+#elif defined(__NR_unlink)
 	return my_syscall1(__NR_unlink, path);
+#else
+#error Neither __NR_unlinkat nor __NR_unlink defined, cannot implement sys_unlink()
 #endif
 }
 
