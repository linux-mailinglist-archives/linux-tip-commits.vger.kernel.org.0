Return-Path: <linux-tip-commits+bounces-1550-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 84F5491CB4D
	for <lists+linux-tip-commits@lfdr.de>; Sat, 29 Jun 2024 07:49:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A612283FC9
	for <lists+linux-tip-commits@lfdr.de>; Sat, 29 Jun 2024 05:49:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 473F52BD0F;
	Sat, 29 Jun 2024 05:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hDIPQ+xQ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eWkX7sSw"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A7C346BF;
	Sat, 29 Jun 2024 05:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719640167; cv=none; b=ozBsv+hQw8J665FEOofUPQTm8FWhh7rXX1O4ssB3TLGuzVij2ARNArI+gjuv/zB6KnhvEKhKhUsnrjDTBRpMx57kk+DGtRNKDqZpruHVsoh65EcTbAvo8D3FiBdO4aJpTO4SphrjaC6tcHjYX9bRrv/I+o9K0Sw3TNgOm5keSBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719640167; c=relaxed/simple;
	bh=o6xiJHuoqXFiCUu7Xp1kl7D7rdjav3EtDILuxOL3hWg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=luW2iu0E6Q9D5R41HLXwH/P0N1ATIHiNEpiCfI9dh6Awecn5FCculR0iKMxu+jwlQjv2XJeNICamvwu4XVN7a085p1pdkJ636dfC9tGRRGKiHRc/X86hNZgcEv0h8jlxODk86D1GN7ri3h5tMdj+NESmbikKp0knC3jxWeKRe3c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hDIPQ+xQ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eWkX7sSw; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 29 Jun 2024 05:49:23 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1719640163;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7kpEeQxv39OQTp3uK272a30HgTrbp5rOT5Om+Pfw440=;
	b=hDIPQ+xQciYno06WRViVqFNyW+e+kpXXPYdzUmkfjL/dGDGmhkxf1kd6rpAle0xPD1MF4H
	1dJFDVAwlY7neZcmDh4kyHFTeXUR9cdepqVZYBDqZkkfdl/X7q1KtfBKJ5aP91LksQPHj3
	sovnKYpiFmKj7RHT1sfpNI2uCvTNbXyN/6H+6UcHueRrjVDyV7BcEgZ54WB4ai8UDGIHHj
	f/Ud4GDfON4p8OrkNlkl61qG4dPwR9b27aGmYFt2sMiR5xBMTWXNTmN7pnJGJXTPiwIMoO
	CMin3nOXYP+U+YclSLxQOCaHIsQ7lPN6Vvqu+CqfbOQcGgubHJ5svX2VP4q14w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1719640163;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7kpEeQxv39OQTp3uK272a30HgTrbp5rOT5Om+Pfw440=;
	b=eWkX7sSwqyTIp65LTQ+0mVVdGY9G5GHuLvXxYMzJLRDF1Xn6qeO3+zlsAwU4BcDfXF658V
	XQnOm5l1o6977VCw==
From: "tip-bot2 for Josh Poimboeuf" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject:
 [tip: x86/bugs] x86/syscall: Mark exit[_group] syscall handlers __noreturn
Cc: "Paul E. McKenney" <paulmck@kernel.org>,
 Josh Poimboeuf <jpoimboe@kernel.org>, "Borislav Petkov (AMD)" <bp@alien8.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <5d8882bc077d8eadcc7fd1740b56dfb781f12288.1719381528.git.jpoimboe@kernel.org>
References:
 <5d8882bc077d8eadcc7fd1740b56dfb781f12288.1719381528.git.jpoimboe@kernel.org>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <171964016319.2215.4322352593093412269.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

The following commit has been merged into the x86/bugs branch of tip:

Commit-ID:     9142be9e6443fd641ca37f820efe00d9cd890eb1
Gitweb:        https://git.kernel.org/tip/9142be9e6443fd641ca37f820efe00d9cd890eb1
Author:        Josh Poimboeuf <jpoimboe@kernel.org>
AuthorDate:    Tue, 25 Jun 2024 23:02:00 -07:00
Committer:     Borislav Petkov (AMD) <bp@alien8.de>
CommitterDate: Fri, 28 Jun 2024 15:23:38 +02:00

x86/syscall: Mark exit[_group] syscall handlers __noreturn

The direct-call syscall dispatch function doesn't know that the exit()
and exit_group() syscall handlers don't return, so the call sites aren't
optimized accordingly.

Fix that by marking the exit syscall declarations __noreturn.

Fixes the following warnings:

  vmlinux.o: warning: objtool: x64_sys_call+0x2804: __x64_sys_exit() is missing a __noreturn annotation
  vmlinux.o: warning: objtool: ia32_sys_call+0x29b6: __ia32_sys_exit_group() is missing a __noreturn annotation

Fixes: 1e3ad78334a6 ("x86/syscall: Don't force use of indirect calls for system calls")
Closes: https://lkml.kernel.org/lkml/6dba9b32-db2c-4e6d-9500-7a08852f17a3@paulmck-laptop
Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Josh Poimboeuf <jpoimboe@kernel.org>
Signed-off-by: Borislav Petkov (AMD) <bp@alien8.de>
Tested-by: Paul E. McKenney <paulmck@kernel.org>
Link: https://lore.kernel.org/r/5d8882bc077d8eadcc7fd1740b56dfb781f12288.1719381528.git.jpoimboe@kernel.org
---
 arch/x86/entry/syscall_32.c            | 10 ++++++----
 arch/x86/entry/syscall_64.c            |  9 ++++++---
 arch/x86/entry/syscall_x32.c           |  7 +++++--
 arch/x86/entry/syscalls/syscall_32.tbl |  6 +++---
 arch/x86/entry/syscalls/syscall_64.tbl |  6 +++---
 arch/x86/um/sys_call_table_32.c        | 10 ++++++----
 arch/x86/um/sys_call_table_64.c        | 11 +++++++----
 scripts/syscalltbl.sh                  | 18 ++++++++++++++++--
 tools/objtool/noreturns.h              |  4 ++++
 9 files changed, 56 insertions(+), 25 deletions(-)

diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index c2235ba..8cc9950 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -14,9 +14,12 @@
 #endif
 
 #define __SYSCALL(nr, sym) extern long __ia32_##sym(const struct pt_regs *);
-
+#define __SYSCALL_NORETURN(nr, sym) extern long __noreturn __ia32_##sym(const struct pt_regs *);
 #include <asm/syscalls_32.h>
-#undef __SYSCALL
+#undef  __SYSCALL
+
+#undef  __SYSCALL_NORETURN
+#define __SYSCALL_NORETURN __SYSCALL
 
 /*
  * The sys_call_table[] is no longer used for system calls, but
@@ -28,11 +31,10 @@
 const sys_call_ptr_t sys_call_table[] = {
 #include <asm/syscalls_32.h>
 };
-#undef __SYSCALL
+#undef  __SYSCALL
 #endif
 
 #define __SYSCALL(nr, sym) case nr: return __ia32_##sym(regs);
-
 long ia32_sys_call(const struct pt_regs *regs, unsigned int nr)
 {
 	switch (nr) {
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index 33b3f09..ba83544 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -8,8 +8,12 @@
 #include <asm/syscall.h>
 
 #define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
+#define __SYSCALL_NORETURN(nr, sym) extern long __noreturn __x64_##sym(const struct pt_regs *);
 #include <asm/syscalls_64.h>
-#undef __SYSCALL
+#undef  __SYSCALL
+
+#undef  __SYSCALL_NORETURN
+#define __SYSCALL_NORETURN __SYSCALL
 
 /*
  * The sys_call_table[] is no longer used for system calls, but
@@ -20,10 +24,9 @@
 const sys_call_ptr_t sys_call_table[] = {
 #include <asm/syscalls_64.h>
 };
-#undef __SYSCALL
+#undef  __SYSCALL
 
 #define __SYSCALL(nr, sym) case nr: return __x64_##sym(regs);
-
 long x64_sys_call(const struct pt_regs *regs, unsigned int nr)
 {
 	switch (nr) {
diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
index 03de4a9..fb77908 100644
--- a/arch/x86/entry/syscall_x32.c
+++ b/arch/x86/entry/syscall_x32.c
@@ -8,11 +8,14 @@
 #include <asm/syscall.h>
 
 #define __SYSCALL(nr, sym) extern long __x64_##sym(const struct pt_regs *);
+#define __SYSCALL_NORETURN(nr, sym) extern long __noreturn __x64_##sym(const struct pt_regs *);
 #include <asm/syscalls_x32.h>
-#undef __SYSCALL
+#undef  __SYSCALL
 
-#define __SYSCALL(nr, sym) case nr: return __x64_##sym(regs);
+#undef  __SYSCALL_NORETURN
+#define __SYSCALL_NORETURN __SYSCALL
 
+#define __SYSCALL(nr, sym) case nr: return __x64_##sym(regs);
 long x32_sys_call(const struct pt_regs *regs, unsigned int nr)
 {
 	switch (nr) {
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 7fd1f57..09ca75b 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -2,7 +2,7 @@
 # 32-bit system call numbers and entry vectors
 #
 # The format is:
-# <number> <abi> <name> <entry point> <compat entry point>
+# <number> <abi> <name> <entry point> [<compat entry point> [noreturn]]
 #
 # The __ia32_sys and __ia32_compat_sys stubs are created on-the-fly for
 # sys_*() system calls and compat_sys_*() compat system calls if
@@ -12,7 +12,7 @@
 # The abi is always "i386" for this file.
 #
 0	i386	restart_syscall		sys_restart_syscall
-1	i386	exit			sys_exit
+1	i386	exit			sys_exit			-			noreturn
 2	i386	fork			sys_fork
 3	i386	read			sys_read
 4	i386	write			sys_write
@@ -263,7 +263,7 @@
 249	i386	io_cancel		sys_io_cancel
 250	i386	fadvise64		sys_ia32_fadvise64
 # 251 is available for reuse (was briefly sys_set_zone_reclaim)
-252	i386	exit_group		sys_exit_group
+252	i386	exit_group		sys_exit_group			-			noreturn
 253	i386	lookup_dcookie
 254	i386	epoll_create		sys_epoll_create
 255	i386	epoll_ctl		sys_epoll_ctl
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index a396f6e..a8068f9 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -2,7 +2,7 @@
 # 64-bit system call numbers and entry vectors
 #
 # The format is:
-# <number> <abi> <name> <entry point>
+# <number> <abi> <name> <entry point> [<compat entry point> [noreturn]]
 #
 # The __x64_sys_*() stubs are created on-the-fly for sys_*() system calls
 #
@@ -68,7 +68,7 @@
 57	common	fork			sys_fork
 58	common	vfork			sys_vfork
 59	64	execve			sys_execve
-60	common	exit			sys_exit
+60	common	exit			sys_exit			-			noreturn
 61	common	wait4			sys_wait4
 62	common	kill			sys_kill
 63	common	uname			sys_newuname
@@ -239,7 +239,7 @@
 228	common	clock_gettime		sys_clock_gettime
 229	common	clock_getres		sys_clock_getres
 230	common	clock_nanosleep		sys_clock_nanosleep
-231	common	exit_group		sys_exit_group
+231	common	exit_group		sys_exit_group			-			noreturn
 232	common	epoll_wait		sys_epoll_wait
 233	common	epoll_ctl		sys_epoll_ctl
 234	common	tgkill			sys_tgkill
diff --git a/arch/x86/um/sys_call_table_32.c b/arch/x86/um/sys_call_table_32.c
index 89df5d8..5165513 100644
--- a/arch/x86/um/sys_call_table_32.c
+++ b/arch/x86/um/sys_call_table_32.c
@@ -9,6 +9,10 @@
 #include <linux/cache.h>
 #include <asm/syscall.h>
 
+extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long,
+				      unsigned long, unsigned long,
+				      unsigned long, unsigned long);
+
 /*
  * Below you can see, in terms of #define's, the differences between the x86-64
  * and the UML syscall table.
@@ -22,15 +26,13 @@
 #define sys_vm86 sys_ni_syscall
 
 #define __SYSCALL_WITH_COMPAT(nr, native, compat)	__SYSCALL(nr, native)
+#define __SYSCALL_NORETURN __SYSCALL
 
 #define __SYSCALL(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 #include <asm/syscalls_32.h>
+#undef  __SYSCALL
 
-#undef __SYSCALL
 #define __SYSCALL(nr, sym) sym,
-
-extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
-
 const sys_call_ptr_t sys_call_table[] ____cacheline_aligned = {
 #include <asm/syscalls_32.h>
 };
diff --git a/arch/x86/um/sys_call_table_64.c b/arch/x86/um/sys_call_table_64.c
index b0b4cfd..943d414 100644
--- a/arch/x86/um/sys_call_table_64.c
+++ b/arch/x86/um/sys_call_table_64.c
@@ -9,6 +9,10 @@
 #include <linux/cache.h>
 #include <asm/syscall.h>
 
+extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long,
+				      unsigned long, unsigned long,
+				      unsigned long, unsigned long);
+
 /*
  * Below you can see, in terms of #define's, the differences between the x86-64
  * and the UML syscall table.
@@ -18,14 +22,13 @@
 #define sys_iopl sys_ni_syscall
 #define sys_ioperm sys_ni_syscall
 
+#define __SYSCALL_NORETURN __SYSCALL
+
 #define __SYSCALL(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
 #include <asm/syscalls_64.h>
+#undef  __SYSCALL
 
-#undef __SYSCALL
 #define __SYSCALL(nr, sym) sym,
-
-extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
-
 const sys_call_ptr_t sys_call_table[] ____cacheline_aligned = {
 #include <asm/syscalls_64.h>
 };
diff --git a/scripts/syscalltbl.sh b/scripts/syscalltbl.sh
index 6abe143..6a903b8 100755
--- a/scripts/syscalltbl.sh
+++ b/scripts/syscalltbl.sh
@@ -54,7 +54,7 @@ nxt=0
 
 grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | {
 
-	while read nr abi name native compat ; do
+	while read nr abi name native compat noreturn; do
 
 		if [ $nxt -gt $nr ]; then
 			echo "error: $infile: syscall table is not sorted or duplicates the same syscall number" >&2
@@ -66,7 +66,21 @@ grep -E "^[0-9]+[[:space:]]+$abis" "$infile" | {
 			nxt=$((nxt + 1))
 		done
 
-		if [ -n "$compat" ]; then
+		if [ "$compat" = "-" ]; then
+			unset compat
+		fi
+
+		if [ -n "$noreturn" ]; then
+			if [ "$noreturn" != "noreturn" ]; then
+				echo "error: $infile: invalid string \"$noreturn\" in 'noreturn' column"
+				exit 1
+			fi
+			if [ -n "$compat" ]; then
+				echo "__SYSCALL_COMPAT_NORETURN($nr, $native, $compat)"
+			else
+				echo "__SYSCALL_NORETURN($nr, $native)"
+			fi
+		elif [ -n "$compat" ]; then
 			echo "__SYSCALL_WITH_COMPAT($nr, $native, $compat)"
 		elif [ -n "$native" ]; then
 			echo "__SYSCALL($nr, $native)"
diff --git a/tools/objtool/noreturns.h b/tools/objtool/noreturns.h
index 7ebf29c..1e8141e 100644
--- a/tools/objtool/noreturns.h
+++ b/tools/objtool/noreturns.h
@@ -7,12 +7,16 @@
  * Yes, this is unfortunate.  A better solution is in the works.
  */
 NORETURN(__fortify_panic)
+NORETURN(__ia32_sys_exit)
+NORETURN(__ia32_sys_exit_group)
 NORETURN(__kunit_abort)
 NORETURN(__module_put_and_kthread_exit)
 NORETURN(__reiserfs_panic)
 NORETURN(__stack_chk_fail)
 NORETURN(__tdx_hypercall_failed)
 NORETURN(__ubsan_handle_builtin_unreachable)
+NORETURN(__x64_sys_exit)
+NORETURN(__x64_sys_exit_group)
 NORETURN(arch_cpu_idle_dead)
 NORETURN(bch2_trans_in_restart_error)
 NORETURN(bch2_trans_restart_error)

