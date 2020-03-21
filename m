Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E1F7118E27A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 21 Mar 2020 16:31:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727780AbgCUPar (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 21 Mar 2020 11:30:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38894 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727609AbgCUPaq (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 21 Mar 2020 11:30:46 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFg54-0004zo-Qe; Sat, 21 Mar 2020 16:30:35 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4C0C21C22E4;
        Sat, 21 Mar 2020 16:30:34 +0100 (CET)
Date:   Sat, 21 Mar 2020 15:30:33 -0000
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry: Remove ABI prefixes from functions in
 syscall tables
Cc:     Brian Gerst <brgerst@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200313195144.164260-13-brgerst@gmail.com>
References: <20200313195144.164260-13-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <158480463396.28353.11013539177052426605.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     cab56d3484d4bb8b21e4d9500392ac1ce99af026
Gitweb:        https://git.kernel.org/tip/cab56d3484d4bb8b21e4d9500392ac1ce99af026
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 13 Mar 2020 15:51:38 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 21 Mar 2020 16:03:23 +01:00

x86/entry: Remove ABI prefixes from functions in syscall tables

Move the ABI prefixes to the __SYSCALL_[abi]() macros.  This allows removal
of the need to strip the prefix for UML.

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200313195144.164260-13-brgerst@gmail.com

---
 arch/x86/entry/syscall_32.c            |   6 +-
 arch/x86/entry/syscall_64.c            |   4 +-
 arch/x86/entry/syscall_x32.c           |   8 +-
 arch/x86/entry/syscalls/syscall_32.tbl | 818 ++++++++++++------------
 arch/x86/entry/syscalls/syscall_64.tbl | 740 +++++++++++-----------
 arch/x86/entry/syscalls/syscalltbl.sh  |  14 +-
 6 files changed, 791 insertions(+), 799 deletions(-)

diff --git a/arch/x86/entry/syscall_32.c b/arch/x86/entry/syscall_32.c
index 9f4cab4..41ec9c6 100644
--- a/arch/x86/entry/syscall_32.c
+++ b/arch/x86/entry/syscall_32.c
@@ -9,7 +9,7 @@
 
 #ifdef CONFIG_IA32_EMULATION
 /* On X86_64, we use struct pt_regs * to pass parameters to syscalls */
-#define __SYSCALL_I386(nr, sym) extern asmlinkage long sym(const struct pt_regs *);
+#define __SYSCALL_I386(nr, sym) extern asmlinkage long __ia32_##sym(const struct pt_regs *);
 #define __sys_ni_syscall __ia32_sys_ni_syscall
 #else /* CONFIG_IA32_EMULATION */
 #define __SYSCALL_I386(nr, sym) extern asmlinkage long sym(unsigned long, unsigned long, unsigned long, unsigned long, unsigned long, unsigned long);
@@ -20,7 +20,11 @@ extern asmlinkage long sys_ni_syscall(unsigned long, unsigned long, unsigned lon
 #include <asm/syscalls_32.h>
 #undef __SYSCALL_I386
 
+#ifdef CONFIG_IA32_EMULATION
+#define __SYSCALL_I386(nr, sym) [nr] = __ia32_##sym,
+#else /* CONFIG_IA32_EMULATION */
 #define __SYSCALL_I386(nr, sym) [nr] = sym,
+#endif /* CONFIG_IA32_EMULATION */
 
 __visible const sys_call_ptr_t ia32_sys_call_table[__NR_ia32_syscall_max+1] = {
 	/*
diff --git a/arch/x86/entry/syscall_64.c b/arch/x86/entry/syscall_64.c
index 03645f9..66d3e65 100644
--- a/arch/x86/entry/syscall_64.c
+++ b/arch/x86/entry/syscall_64.c
@@ -11,11 +11,11 @@
 #define __SYSCALL_X32(nr, sym)
 #define __SYSCALL_COMMON(nr, sym) __SYSCALL_64(nr, sym)
 
-#define __SYSCALL_64(nr, sym) extern asmlinkage long sym(const struct pt_regs *);
+#define __SYSCALL_64(nr, sym) extern asmlinkage long __x64_##sym(const struct pt_regs *);
 #include <asm/syscalls_64.h>
 #undef __SYSCALL_64
 
-#define __SYSCALL_64(nr, sym) [nr] = sym,
+#define __SYSCALL_64(nr, sym) [nr] = __x64_##sym,
 
 asmlinkage const sys_call_ptr_t sys_call_table[__NR_syscall_max+1] = {
 	/*
diff --git a/arch/x86/entry/syscall_x32.c b/arch/x86/entry/syscall_x32.c
index 57a151a..2fb09ef 100644
--- a/arch/x86/entry/syscall_x32.c
+++ b/arch/x86/entry/syscall_x32.c
@@ -10,14 +10,14 @@
 
 #define __SYSCALL_64(nr, sym)
 
-#define __SYSCALL_X32(nr, sym) extern asmlinkage long sym(const struct pt_regs *);
-#define __SYSCALL_COMMON(nr, sym) extern asmlinkage long sym(const struct pt_regs *);
+#define __SYSCALL_X32(nr, sym) extern asmlinkage long __x32_##sym(const struct pt_regs *);
+#define __SYSCALL_COMMON(nr, sym) extern asmlinkage long __x64_##sym(const struct pt_regs *);
 #include <asm/syscalls_64.h>
 #undef __SYSCALL_X32
 #undef __SYSCALL_COMMON
 
-#define __SYSCALL_X32(nr, sym) [nr] = sym,
-#define __SYSCALL_COMMON(nr, sym) [nr] = sym,
+#define __SYSCALL_X32(nr, sym) [nr] = __x32_##sym,
+#define __SYSCALL_COMMON(nr, sym) [nr] = __x64_##sym,
 
 asmlinkage const sys_call_ptr_t x32_sys_call_table[__NR_x32_syscall_max+1] = {
 	/*
diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index c17cb77..390c212 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -11,434 +11,434 @@
 #
 # The abi is always "i386" for this file.
 #
-0	i386	restart_syscall		sys_restart_syscall		__ia32_sys_restart_syscall
-1	i386	exit			sys_exit			__ia32_sys_exit
-2	i386	fork			sys_fork			__ia32_sys_fork
-3	i386	read			sys_read			__ia32_sys_read
-4	i386	write			sys_write			__ia32_sys_write
-5	i386	open			sys_open			__ia32_compat_sys_open
-6	i386	close			sys_close			__ia32_sys_close
-7	i386	waitpid			sys_waitpid			__ia32_sys_waitpid
-8	i386	creat			sys_creat			__ia32_sys_creat
-9	i386	link			sys_link			__ia32_sys_link
-10	i386	unlink			sys_unlink			__ia32_sys_unlink
-11	i386	execve			sys_execve			__ia32_compat_sys_execve
-12	i386	chdir			sys_chdir			__ia32_sys_chdir
-13	i386	time			sys_time32			__ia32_sys_time32
-14	i386	mknod			sys_mknod			__ia32_sys_mknod
-15	i386	chmod			sys_chmod			__ia32_sys_chmod
-16	i386	lchown			sys_lchown16			__ia32_sys_lchown16
+0	i386	restart_syscall		sys_restart_syscall		sys_restart_syscall
+1	i386	exit			sys_exit			sys_exit
+2	i386	fork			sys_fork			sys_fork
+3	i386	read			sys_read			sys_read
+4	i386	write			sys_write			sys_write
+5	i386	open			sys_open			compat_sys_open
+6	i386	close			sys_close			sys_close
+7	i386	waitpid			sys_waitpid			sys_waitpid
+8	i386	creat			sys_creat			sys_creat
+9	i386	link			sys_link			sys_link
+10	i386	unlink			sys_unlink			sys_unlink
+11	i386	execve			sys_execve			compat_sys_execve
+12	i386	chdir			sys_chdir			sys_chdir
+13	i386	time			sys_time32			sys_time32
+14	i386	mknod			sys_mknod			sys_mknod
+15	i386	chmod			sys_chmod			sys_chmod
+16	i386	lchown			sys_lchown16			sys_lchown16
 17	i386	break
-18	i386	oldstat			sys_stat			__ia32_sys_stat
-19	i386	lseek			sys_lseek			__ia32_compat_sys_lseek
-20	i386	getpid			sys_getpid			__ia32_sys_getpid
-21	i386	mount			sys_mount			__ia32_compat_sys_mount
-22	i386	umount			sys_oldumount			__ia32_sys_oldumount
-23	i386	setuid			sys_setuid16			__ia32_sys_setuid16
-24	i386	getuid			sys_getuid16			__ia32_sys_getuid16
-25	i386	stime			sys_stime32			__ia32_sys_stime32
-26	i386	ptrace			sys_ptrace			__ia32_compat_sys_ptrace
-27	i386	alarm			sys_alarm			__ia32_sys_alarm
-28	i386	oldfstat		sys_fstat			__ia32_sys_fstat
-29	i386	pause			sys_pause			__ia32_sys_pause
-30	i386	utime			sys_utime32			__ia32_sys_utime32
+18	i386	oldstat			sys_stat			sys_stat
+19	i386	lseek			sys_lseek			compat_sys_lseek
+20	i386	getpid			sys_getpid			sys_getpid
+21	i386	mount			sys_mount			compat_sys_mount
+22	i386	umount			sys_oldumount			sys_oldumount
+23	i386	setuid			sys_setuid16			sys_setuid16
+24	i386	getuid			sys_getuid16			sys_getuid16
+25	i386	stime			sys_stime32			sys_stime32
+26	i386	ptrace			sys_ptrace			compat_sys_ptrace
+27	i386	alarm			sys_alarm			sys_alarm
+28	i386	oldfstat		sys_fstat			sys_fstat
+29	i386	pause			sys_pause			sys_pause
+30	i386	utime			sys_utime32			sys_utime32
 31	i386	stty
 32	i386	gtty
-33	i386	access			sys_access			__ia32_sys_access
-34	i386	nice			sys_nice			__ia32_sys_nice
+33	i386	access			sys_access			sys_access
+34	i386	nice			sys_nice			sys_nice
 35	i386	ftime
-36	i386	sync			sys_sync			__ia32_sys_sync
-37	i386	kill			sys_kill			__ia32_sys_kill
-38	i386	rename			sys_rename			__ia32_sys_rename
-39	i386	mkdir			sys_mkdir			__ia32_sys_mkdir
-40	i386	rmdir			sys_rmdir			__ia32_sys_rmdir
-41	i386	dup			sys_dup				__ia32_sys_dup
-42	i386	pipe			sys_pipe			__ia32_sys_pipe
-43	i386	times			sys_times			__ia32_compat_sys_times
+36	i386	sync			sys_sync			sys_sync
+37	i386	kill			sys_kill			sys_kill
+38	i386	rename			sys_rename			sys_rename
+39	i386	mkdir			sys_mkdir			sys_mkdir
+40	i386	rmdir			sys_rmdir			sys_rmdir
+41	i386	dup			sys_dup				sys_dup
+42	i386	pipe			sys_pipe			sys_pipe
+43	i386	times			sys_times			compat_sys_times
 44	i386	prof
-45	i386	brk			sys_brk				__ia32_sys_brk
-46	i386	setgid			sys_setgid16			__ia32_sys_setgid16
-47	i386	getgid			sys_getgid16			__ia32_sys_getgid16
-48	i386	signal			sys_signal			__ia32_sys_signal
-49	i386	geteuid			sys_geteuid16			__ia32_sys_geteuid16
-50	i386	getegid			sys_getegid16			__ia32_sys_getegid16
-51	i386	acct			sys_acct			__ia32_sys_acct
-52	i386	umount2			sys_umount			__ia32_sys_umount
+45	i386	brk			sys_brk				sys_brk
+46	i386	setgid			sys_setgid16			sys_setgid16
+47	i386	getgid			sys_getgid16			sys_getgid16
+48	i386	signal			sys_signal			sys_signal
+49	i386	geteuid			sys_geteuid16			sys_geteuid16
+50	i386	getegid			sys_getegid16			sys_getegid16
+51	i386	acct			sys_acct			sys_acct
+52	i386	umount2			sys_umount			sys_umount
 53	i386	lock
-54	i386	ioctl			sys_ioctl			__ia32_compat_sys_ioctl
-55	i386	fcntl			sys_fcntl			__ia32_compat_sys_fcntl64
+54	i386	ioctl			sys_ioctl			compat_sys_ioctl
+55	i386	fcntl			sys_fcntl			compat_sys_fcntl64
 56	i386	mpx
-57	i386	setpgid			sys_setpgid			__ia32_sys_setpgid
+57	i386	setpgid			sys_setpgid			sys_setpgid
 58	i386	ulimit
-59	i386	oldolduname		sys_olduname			__ia32_sys_olduname
-60	i386	umask			sys_umask			__ia32_sys_umask
-61	i386	chroot			sys_chroot			__ia32_sys_chroot
-62	i386	ustat			sys_ustat			__ia32_compat_sys_ustat
-63	i386	dup2			sys_dup2			__ia32_sys_dup2
-64	i386	getppid			sys_getppid			__ia32_sys_getppid
-65	i386	getpgrp			sys_getpgrp			__ia32_sys_getpgrp
-66	i386	setsid			sys_setsid			__ia32_sys_setsid
-67	i386	sigaction		sys_sigaction			__ia32_compat_sys_sigaction
-68	i386	sgetmask		sys_sgetmask			__ia32_sys_sgetmask
-69	i386	ssetmask		sys_ssetmask			__ia32_sys_ssetmask
-70	i386	setreuid		sys_setreuid16			__ia32_sys_setreuid16
-71	i386	setregid		sys_setregid16			__ia32_sys_setregid16
-72	i386	sigsuspend		sys_sigsuspend			__ia32_sys_sigsuspend
-73	i386	sigpending		sys_sigpending			__ia32_compat_sys_sigpending
-74	i386	sethostname		sys_sethostname			__ia32_sys_sethostname
-75	i386	setrlimit		sys_setrlimit			__ia32_compat_sys_setrlimit
-76	i386	getrlimit		sys_old_getrlimit		__ia32_compat_sys_old_getrlimit
-77	i386	getrusage		sys_getrusage			__ia32_compat_sys_getrusage
-78	i386	gettimeofday		sys_gettimeofday		__ia32_compat_sys_gettimeofday
-79	i386	settimeofday		sys_settimeofday		__ia32_compat_sys_settimeofday
-80	i386	getgroups		sys_getgroups16			__ia32_sys_getgroups16
-81	i386	setgroups		sys_setgroups16			__ia32_sys_setgroups16
-82	i386	select			sys_old_select			__ia32_compat_sys_old_select
-83	i386	symlink			sys_symlink			__ia32_sys_symlink
-84	i386	oldlstat		sys_lstat			__ia32_sys_lstat
-85	i386	readlink		sys_readlink			__ia32_sys_readlink
-86	i386	uselib			sys_uselib			__ia32_sys_uselib
-87	i386	swapon			sys_swapon			__ia32_sys_swapon
-88	i386	reboot			sys_reboot			__ia32_sys_reboot
-89	i386	readdir			sys_old_readdir			__ia32_compat_sys_old_readdir
-90	i386	mmap			sys_old_mmap			__ia32_compat_sys_x86_mmap
-91	i386	munmap			sys_munmap			__ia32_sys_munmap
-92	i386	truncate		sys_truncate			__ia32_compat_sys_truncate
-93	i386	ftruncate		sys_ftruncate			__ia32_compat_sys_ftruncate
-94	i386	fchmod			sys_fchmod			__ia32_sys_fchmod
-95	i386	fchown			sys_fchown16			__ia32_sys_fchown16
-96	i386	getpriority		sys_getpriority			__ia32_sys_getpriority
-97	i386	setpriority		sys_setpriority			__ia32_sys_setpriority
+59	i386	oldolduname		sys_olduname			sys_olduname
+60	i386	umask			sys_umask			sys_umask
+61	i386	chroot			sys_chroot			sys_chroot
+62	i386	ustat			sys_ustat			compat_sys_ustat
+63	i386	dup2			sys_dup2			sys_dup2
+64	i386	getppid			sys_getppid			sys_getppid
+65	i386	getpgrp			sys_getpgrp			sys_getpgrp
+66	i386	setsid			sys_setsid			sys_setsid
+67	i386	sigaction		sys_sigaction			compat_sys_sigaction
+68	i386	sgetmask		sys_sgetmask			sys_sgetmask
+69	i386	ssetmask		sys_ssetmask			sys_ssetmask
+70	i386	setreuid		sys_setreuid16			sys_setreuid16
+71	i386	setregid		sys_setregid16			sys_setregid16
+72	i386	sigsuspend		sys_sigsuspend			sys_sigsuspend
+73	i386	sigpending		sys_sigpending			compat_sys_sigpending
+74	i386	sethostname		sys_sethostname			sys_sethostname
+75	i386	setrlimit		sys_setrlimit			compat_sys_setrlimit
+76	i386	getrlimit		sys_old_getrlimit		compat_sys_old_getrlimit
+77	i386	getrusage		sys_getrusage			compat_sys_getrusage
+78	i386	gettimeofday		sys_gettimeofday		compat_sys_gettimeofday
+79	i386	settimeofday		sys_settimeofday		compat_sys_settimeofday
+80	i386	getgroups		sys_getgroups16			sys_getgroups16
+81	i386	setgroups		sys_setgroups16			sys_setgroups16
+82	i386	select			sys_old_select			compat_sys_old_select
+83	i386	symlink			sys_symlink			sys_symlink
+84	i386	oldlstat		sys_lstat			sys_lstat
+85	i386	readlink		sys_readlink			sys_readlink
+86	i386	uselib			sys_uselib			sys_uselib
+87	i386	swapon			sys_swapon			sys_swapon
+88	i386	reboot			sys_reboot			sys_reboot
+89	i386	readdir			sys_old_readdir			compat_sys_old_readdir
+90	i386	mmap			sys_old_mmap			compat_sys_x86_mmap
+91	i386	munmap			sys_munmap			sys_munmap
+92	i386	truncate		sys_truncate			compat_sys_truncate
+93	i386	ftruncate		sys_ftruncate			compat_sys_ftruncate
+94	i386	fchmod			sys_fchmod			sys_fchmod
+95	i386	fchown			sys_fchown16			sys_fchown16
+96	i386	getpriority		sys_getpriority			sys_getpriority
+97	i386	setpriority		sys_setpriority			sys_setpriority
 98	i386	profil
-99	i386	statfs			sys_statfs			__ia32_compat_sys_statfs
-100	i386	fstatfs			sys_fstatfs			__ia32_compat_sys_fstatfs
-101	i386	ioperm			sys_ioperm			__ia32_sys_ioperm
-102	i386	socketcall		sys_socketcall			__ia32_compat_sys_socketcall
-103	i386	syslog			sys_syslog			__ia32_sys_syslog
-104	i386	setitimer		sys_setitimer			__ia32_compat_sys_setitimer
-105	i386	getitimer		sys_getitimer			__ia32_compat_sys_getitimer
-106	i386	stat			sys_newstat			__ia32_compat_sys_newstat
-107	i386	lstat			sys_newlstat			__ia32_compat_sys_newlstat
-108	i386	fstat			sys_newfstat			__ia32_compat_sys_newfstat
-109	i386	olduname		sys_uname			__ia32_sys_uname
-110	i386	iopl			sys_iopl			__ia32_sys_iopl
-111	i386	vhangup			sys_vhangup			__ia32_sys_vhangup
+99	i386	statfs			sys_statfs			compat_sys_statfs
+100	i386	fstatfs			sys_fstatfs			compat_sys_fstatfs
+101	i386	ioperm			sys_ioperm			sys_ioperm
+102	i386	socketcall		sys_socketcall			compat_sys_socketcall
+103	i386	syslog			sys_syslog			sys_syslog
+104	i386	setitimer		sys_setitimer			compat_sys_setitimer
+105	i386	getitimer		sys_getitimer			compat_sys_getitimer
+106	i386	stat			sys_newstat			compat_sys_newstat
+107	i386	lstat			sys_newlstat			compat_sys_newlstat
+108	i386	fstat			sys_newfstat			compat_sys_newfstat
+109	i386	olduname		sys_uname			sys_uname
+110	i386	iopl			sys_iopl			sys_iopl
+111	i386	vhangup			sys_vhangup			sys_vhangup
 112	i386	idle
-113	i386	vm86old			sys_vm86old			__ia32_sys_ni_syscall
-114	i386	wait4			sys_wait4			__ia32_compat_sys_wait4
-115	i386	swapoff			sys_swapoff			__ia32_sys_swapoff
-116	i386	sysinfo			sys_sysinfo			__ia32_compat_sys_sysinfo
-117	i386	ipc			sys_ipc				__ia32_compat_sys_ipc
-118	i386	fsync			sys_fsync			__ia32_sys_fsync
-119	i386	sigreturn		sys_sigreturn			__ia32_compat_sys_sigreturn
-120	i386	clone			sys_clone			__ia32_compat_sys_x86_clone
-121	i386	setdomainname		sys_setdomainname		__ia32_sys_setdomainname
-122	i386	uname			sys_newuname			__ia32_sys_newuname
-123	i386	modify_ldt		sys_modify_ldt			__ia32_sys_modify_ldt
-124	i386	adjtimex		sys_adjtimex_time32			__ia32_sys_adjtimex_time32
-125	i386	mprotect		sys_mprotect			__ia32_sys_mprotect
-126	i386	sigprocmask		sys_sigprocmask			__ia32_compat_sys_sigprocmask
+113	i386	vm86old			sys_vm86old			sys_ni_syscall
+114	i386	wait4			sys_wait4			compat_sys_wait4
+115	i386	swapoff			sys_swapoff			sys_swapoff
+116	i386	sysinfo			sys_sysinfo			compat_sys_sysinfo
+117	i386	ipc			sys_ipc				compat_sys_ipc
+118	i386	fsync			sys_fsync			sys_fsync
+119	i386	sigreturn		sys_sigreturn			compat_sys_sigreturn
+120	i386	clone			sys_clone			compat_sys_x86_clone
+121	i386	setdomainname		sys_setdomainname		sys_setdomainname
+122	i386	uname			sys_newuname			sys_newuname
+123	i386	modify_ldt		sys_modify_ldt			sys_modify_ldt
+124	i386	adjtimex		sys_adjtimex_time32			sys_adjtimex_time32
+125	i386	mprotect		sys_mprotect			sys_mprotect
+126	i386	sigprocmask		sys_sigprocmask			compat_sys_sigprocmask
 127	i386	create_module
-128	i386	init_module		sys_init_module			__ia32_sys_init_module
-129	i386	delete_module		sys_delete_module		__ia32_sys_delete_module
+128	i386	init_module		sys_init_module			sys_init_module
+129	i386	delete_module		sys_delete_module		sys_delete_module
 130	i386	get_kernel_syms
-131	i386	quotactl		sys_quotactl			__ia32_compat_sys_quotactl32
-132	i386	getpgid			sys_getpgid			__ia32_sys_getpgid
-133	i386	fchdir			sys_fchdir			__ia32_sys_fchdir
-134	i386	bdflush			sys_bdflush			__ia32_sys_bdflush
-135	i386	sysfs			sys_sysfs			__ia32_sys_sysfs
-136	i386	personality		sys_personality			__ia32_sys_personality
+131	i386	quotactl		sys_quotactl			compat_sys_quotactl32
+132	i386	getpgid			sys_getpgid			sys_getpgid
+133	i386	fchdir			sys_fchdir			sys_fchdir
+134	i386	bdflush			sys_bdflush			sys_bdflush
+135	i386	sysfs			sys_sysfs			sys_sysfs
+136	i386	personality		sys_personality			sys_personality
 137	i386	afs_syscall
-138	i386	setfsuid		sys_setfsuid16			__ia32_sys_setfsuid16
-139	i386	setfsgid		sys_setfsgid16			__ia32_sys_setfsgid16
-140	i386	_llseek			sys_llseek			__ia32_sys_llseek
-141	i386	getdents		sys_getdents			__ia32_compat_sys_getdents
-142	i386	_newselect		sys_select			__ia32_compat_sys_select
-143	i386	flock			sys_flock			__ia32_sys_flock
-144	i386	msync			sys_msync			__ia32_sys_msync
-145	i386	readv			sys_readv			__ia32_compat_sys_readv
-146	i386	writev			sys_writev			__ia32_compat_sys_writev
-147	i386	getsid			sys_getsid			__ia32_sys_getsid
-148	i386	fdatasync		sys_fdatasync			__ia32_sys_fdatasync
-149	i386	_sysctl			sys_sysctl			__ia32_compat_sys_sysctl
-150	i386	mlock			sys_mlock			__ia32_sys_mlock
-151	i386	munlock			sys_munlock			__ia32_sys_munlock
-152	i386	mlockall		sys_mlockall			__ia32_sys_mlockall
-153	i386	munlockall		sys_munlockall			__ia32_sys_munlockall
-154	i386	sched_setparam		sys_sched_setparam		__ia32_sys_sched_setparam
-155	i386	sched_getparam		sys_sched_getparam		__ia32_sys_sched_getparam
-156	i386	sched_setscheduler	sys_sched_setscheduler		__ia32_sys_sched_setscheduler
-157	i386	sched_getscheduler	sys_sched_getscheduler		__ia32_sys_sched_getscheduler
-158	i386	sched_yield		sys_sched_yield			__ia32_sys_sched_yield
-159	i386	sched_get_priority_max	sys_sched_get_priority_max	__ia32_sys_sched_get_priority_max
-160	i386	sched_get_priority_min	sys_sched_get_priority_min	__ia32_sys_sched_get_priority_min
-161	i386	sched_rr_get_interval	sys_sched_rr_get_interval_time32	__ia32_sys_sched_rr_get_interval_time32
-162	i386	nanosleep		sys_nanosleep_time32		__ia32_sys_nanosleep_time32
-163	i386	mremap			sys_mremap			__ia32_sys_mremap
-164	i386	setresuid		sys_setresuid16			__ia32_sys_setresuid16
-165	i386	getresuid		sys_getresuid16			__ia32_sys_getresuid16
-166	i386	vm86			sys_vm86			__ia32_sys_ni_syscall
+138	i386	setfsuid		sys_setfsuid16			sys_setfsuid16
+139	i386	setfsgid		sys_setfsgid16			sys_setfsgid16
+140	i386	_llseek			sys_llseek			sys_llseek
+141	i386	getdents		sys_getdents			compat_sys_getdents
+142	i386	_newselect		sys_select			compat_sys_select
+143	i386	flock			sys_flock			sys_flock
+144	i386	msync			sys_msync			sys_msync
+145	i386	readv			sys_readv			compat_sys_readv
+146	i386	writev			sys_writev			compat_sys_writev
+147	i386	getsid			sys_getsid			sys_getsid
+148	i386	fdatasync		sys_fdatasync			sys_fdatasync
+149	i386	_sysctl			sys_sysctl			compat_sys_sysctl
+150	i386	mlock			sys_mlock			sys_mlock
+151	i386	munlock			sys_munlock			sys_munlock
+152	i386	mlockall		sys_mlockall			sys_mlockall
+153	i386	munlockall		sys_munlockall			sys_munlockall
+154	i386	sched_setparam		sys_sched_setparam		sys_sched_setparam
+155	i386	sched_getparam		sys_sched_getparam		sys_sched_getparam
+156	i386	sched_setscheduler	sys_sched_setscheduler		sys_sched_setscheduler
+157	i386	sched_getscheduler	sys_sched_getscheduler		sys_sched_getscheduler
+158	i386	sched_yield		sys_sched_yield			sys_sched_yield
+159	i386	sched_get_priority_max	sys_sched_get_priority_max	sys_sched_get_priority_max
+160	i386	sched_get_priority_min	sys_sched_get_priority_min	sys_sched_get_priority_min
+161	i386	sched_rr_get_interval	sys_sched_rr_get_interval_time32	sys_sched_rr_get_interval_time32
+162	i386	nanosleep		sys_nanosleep_time32		sys_nanosleep_time32
+163	i386	mremap			sys_mremap			sys_mremap
+164	i386	setresuid		sys_setresuid16			sys_setresuid16
+165	i386	getresuid		sys_getresuid16			sys_getresuid16
+166	i386	vm86			sys_vm86			sys_ni_syscall
 167	i386	query_module
-168	i386	poll			sys_poll			__ia32_sys_poll
+168	i386	poll			sys_poll			sys_poll
 169	i386	nfsservctl
-170	i386	setresgid		sys_setresgid16			__ia32_sys_setresgid16
-171	i386	getresgid		sys_getresgid16			__ia32_sys_getresgid16
-172	i386	prctl			sys_prctl			__ia32_sys_prctl
-173	i386	rt_sigreturn		sys_rt_sigreturn		__ia32_compat_sys_rt_sigreturn
-174	i386	rt_sigaction		sys_rt_sigaction		__ia32_compat_sys_rt_sigaction
-175	i386	rt_sigprocmask		sys_rt_sigprocmask		__ia32_compat_sys_rt_sigprocmask
-176	i386	rt_sigpending		sys_rt_sigpending		__ia32_compat_sys_rt_sigpending
-177	i386	rt_sigtimedwait		sys_rt_sigtimedwait_time32	__ia32_compat_sys_rt_sigtimedwait_time32
-178	i386	rt_sigqueueinfo		sys_rt_sigqueueinfo		__ia32_compat_sys_rt_sigqueueinfo
-179	i386	rt_sigsuspend		sys_rt_sigsuspend		__ia32_compat_sys_rt_sigsuspend
-180	i386	pread64			sys_pread64			__ia32_compat_sys_x86_pread
-181	i386	pwrite64		sys_pwrite64			__ia32_compat_sys_x86_pwrite
-182	i386	chown			sys_chown16			__ia32_sys_chown16
-183	i386	getcwd			sys_getcwd			__ia32_sys_getcwd
-184	i386	capget			sys_capget			__ia32_sys_capget
-185	i386	capset			sys_capset			__ia32_sys_capset
-186	i386	sigaltstack		sys_sigaltstack			__ia32_compat_sys_sigaltstack
-187	i386	sendfile		sys_sendfile			__ia32_compat_sys_sendfile
+170	i386	setresgid		sys_setresgid16			sys_setresgid16
+171	i386	getresgid		sys_getresgid16			sys_getresgid16
+172	i386	prctl			sys_prctl			sys_prctl
+173	i386	rt_sigreturn		sys_rt_sigreturn		compat_sys_rt_sigreturn
+174	i386	rt_sigaction		sys_rt_sigaction		compat_sys_rt_sigaction
+175	i386	rt_sigprocmask		sys_rt_sigprocmask		compat_sys_rt_sigprocmask
+176	i386	rt_sigpending		sys_rt_sigpending		compat_sys_rt_sigpending
+177	i386	rt_sigtimedwait		sys_rt_sigtimedwait_time32	compat_sys_rt_sigtimedwait_time32
+178	i386	rt_sigqueueinfo		sys_rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
+179	i386	rt_sigsuspend		sys_rt_sigsuspend		compat_sys_rt_sigsuspend
+180	i386	pread64			sys_pread64			compat_sys_x86_pread
+181	i386	pwrite64		sys_pwrite64			compat_sys_x86_pwrite
+182	i386	chown			sys_chown16			sys_chown16
+183	i386	getcwd			sys_getcwd			sys_getcwd
+184	i386	capget			sys_capget			sys_capget
+185	i386	capset			sys_capset			sys_capset
+186	i386	sigaltstack		sys_sigaltstack			compat_sys_sigaltstack
+187	i386	sendfile		sys_sendfile			compat_sys_sendfile
 188	i386	getpmsg
 189	i386	putpmsg
-190	i386	vfork			sys_vfork			__ia32_sys_vfork
-191	i386	ugetrlimit		sys_getrlimit			__ia32_compat_sys_getrlimit
-192	i386	mmap2			sys_mmap_pgoff			__ia32_sys_mmap_pgoff
-193	i386	truncate64		sys_truncate64			__ia32_compat_sys_x86_truncate64
-194	i386	ftruncate64		sys_ftruncate64			__ia32_compat_sys_x86_ftruncate64
-195	i386	stat64			sys_stat64			__ia32_compat_sys_x86_stat64
-196	i386	lstat64			sys_lstat64			__ia32_compat_sys_x86_lstat64
-197	i386	fstat64			sys_fstat64			__ia32_compat_sys_x86_fstat64
-198	i386	lchown32		sys_lchown			__ia32_sys_lchown
-199	i386	getuid32		sys_getuid			__ia32_sys_getuid
-200	i386	getgid32		sys_getgid			__ia32_sys_getgid
-201	i386	geteuid32		sys_geteuid			__ia32_sys_geteuid
-202	i386	getegid32		sys_getegid			__ia32_sys_getegid
-203	i386	setreuid32		sys_setreuid			__ia32_sys_setreuid
-204	i386	setregid32		sys_setregid			__ia32_sys_setregid
-205	i386	getgroups32		sys_getgroups			__ia32_sys_getgroups
-206	i386	setgroups32		sys_setgroups			__ia32_sys_setgroups
-207	i386	fchown32		sys_fchown			__ia32_sys_fchown
-208	i386	setresuid32		sys_setresuid			__ia32_sys_setresuid
-209	i386	getresuid32		sys_getresuid			__ia32_sys_getresuid
-210	i386	setresgid32		sys_setresgid			__ia32_sys_setresgid
-211	i386	getresgid32		sys_getresgid			__ia32_sys_getresgid
-212	i386	chown32			sys_chown			__ia32_sys_chown
-213	i386	setuid32		sys_setuid			__ia32_sys_setuid
-214	i386	setgid32		sys_setgid			__ia32_sys_setgid
-215	i386	setfsuid32		sys_setfsuid			__ia32_sys_setfsuid
-216	i386	setfsgid32		sys_setfsgid			__ia32_sys_setfsgid
-217	i386	pivot_root		sys_pivot_root			__ia32_sys_pivot_root
-218	i386	mincore			sys_mincore			__ia32_sys_mincore
-219	i386	madvise			sys_madvise			__ia32_sys_madvise
-220	i386	getdents64		sys_getdents64			__ia32_sys_getdents64
-221	i386	fcntl64			sys_fcntl64			__ia32_compat_sys_fcntl64
+190	i386	vfork			sys_vfork			sys_vfork
+191	i386	ugetrlimit		sys_getrlimit			compat_sys_getrlimit
+192	i386	mmap2			sys_mmap_pgoff			sys_mmap_pgoff
+193	i386	truncate64		sys_truncate64			compat_sys_x86_truncate64
+194	i386	ftruncate64		sys_ftruncate64			compat_sys_x86_ftruncate64
+195	i386	stat64			sys_stat64			compat_sys_x86_stat64
+196	i386	lstat64			sys_lstat64			compat_sys_x86_lstat64
+197	i386	fstat64			sys_fstat64			compat_sys_x86_fstat64
+198	i386	lchown32		sys_lchown			sys_lchown
+199	i386	getuid32		sys_getuid			sys_getuid
+200	i386	getgid32		sys_getgid			sys_getgid
+201	i386	geteuid32		sys_geteuid			sys_geteuid
+202	i386	getegid32		sys_getegid			sys_getegid
+203	i386	setreuid32		sys_setreuid			sys_setreuid
+204	i386	setregid32		sys_setregid			sys_setregid
+205	i386	getgroups32		sys_getgroups			sys_getgroups
+206	i386	setgroups32		sys_setgroups			sys_setgroups
+207	i386	fchown32		sys_fchown			sys_fchown
+208	i386	setresuid32		sys_setresuid			sys_setresuid
+209	i386	getresuid32		sys_getresuid			sys_getresuid
+210	i386	setresgid32		sys_setresgid			sys_setresgid
+211	i386	getresgid32		sys_getresgid			sys_getresgid
+212	i386	chown32			sys_chown			sys_chown
+213	i386	setuid32		sys_setuid			sys_setuid
+214	i386	setgid32		sys_setgid			sys_setgid
+215	i386	setfsuid32		sys_setfsuid			sys_setfsuid
+216	i386	setfsgid32		sys_setfsgid			sys_setfsgid
+217	i386	pivot_root		sys_pivot_root			sys_pivot_root
+218	i386	mincore			sys_mincore			sys_mincore
+219	i386	madvise			sys_madvise			sys_madvise
+220	i386	getdents64		sys_getdents64			sys_getdents64
+221	i386	fcntl64			sys_fcntl64			compat_sys_fcntl64
 # 222 is unused
 # 223 is unused
-224	i386	gettid			sys_gettid			__ia32_sys_gettid
-225	i386	readahead		sys_readahead			__ia32_compat_sys_x86_readahead
-226	i386	setxattr		sys_setxattr			__ia32_sys_setxattr
-227	i386	lsetxattr		sys_lsetxattr			__ia32_sys_lsetxattr
-228	i386	fsetxattr		sys_fsetxattr			__ia32_sys_fsetxattr
-229	i386	getxattr		sys_getxattr			__ia32_sys_getxattr
-230	i386	lgetxattr		sys_lgetxattr			__ia32_sys_lgetxattr
-231	i386	fgetxattr		sys_fgetxattr			__ia32_sys_fgetxattr
-232	i386	listxattr		sys_listxattr			__ia32_sys_listxattr
-233	i386	llistxattr		sys_llistxattr			__ia32_sys_llistxattr
-234	i386	flistxattr		sys_flistxattr			__ia32_sys_flistxattr
-235	i386	removexattr		sys_removexattr			__ia32_sys_removexattr
-236	i386	lremovexattr		sys_lremovexattr		__ia32_sys_lremovexattr
-237	i386	fremovexattr		sys_fremovexattr		__ia32_sys_fremovexattr
-238	i386	tkill			sys_tkill			__ia32_sys_tkill
-239	i386	sendfile64		sys_sendfile64			__ia32_sys_sendfile64
-240	i386	futex			sys_futex_time32		__ia32_sys_futex_time32
-241	i386	sched_setaffinity	sys_sched_setaffinity		__ia32_compat_sys_sched_setaffinity
-242	i386	sched_getaffinity	sys_sched_getaffinity		__ia32_compat_sys_sched_getaffinity
-243	i386	set_thread_area		sys_set_thread_area		__ia32_sys_set_thread_area
-244	i386	get_thread_area		sys_get_thread_area		__ia32_sys_get_thread_area
-245	i386	io_setup		sys_io_setup			__ia32_compat_sys_io_setup
-246	i386	io_destroy		sys_io_destroy			__ia32_sys_io_destroy
-247	i386	io_getevents		sys_io_getevents_time32		__ia32_sys_io_getevents_time32
-248	i386	io_submit		sys_io_submit			__ia32_compat_sys_io_submit
-249	i386	io_cancel		sys_io_cancel			__ia32_sys_io_cancel
-250	i386	fadvise64		sys_fadvise64			__ia32_compat_sys_x86_fadvise64
+224	i386	gettid			sys_gettid			sys_gettid
+225	i386	readahead		sys_readahead			compat_sys_x86_readahead
+226	i386	setxattr		sys_setxattr			sys_setxattr
+227	i386	lsetxattr		sys_lsetxattr			sys_lsetxattr
+228	i386	fsetxattr		sys_fsetxattr			sys_fsetxattr
+229	i386	getxattr		sys_getxattr			sys_getxattr
+230	i386	lgetxattr		sys_lgetxattr			sys_lgetxattr
+231	i386	fgetxattr		sys_fgetxattr			sys_fgetxattr
+232	i386	listxattr		sys_listxattr			sys_listxattr
+233	i386	llistxattr		sys_llistxattr			sys_llistxattr
+234	i386	flistxattr		sys_flistxattr			sys_flistxattr
+235	i386	removexattr		sys_removexattr			sys_removexattr
+236	i386	lremovexattr		sys_lremovexattr		sys_lremovexattr
+237	i386	fremovexattr		sys_fremovexattr		sys_fremovexattr
+238	i386	tkill			sys_tkill			sys_tkill
+239	i386	sendfile64		sys_sendfile64			sys_sendfile64
+240	i386	futex			sys_futex_time32		sys_futex_time32
+241	i386	sched_setaffinity	sys_sched_setaffinity		compat_sys_sched_setaffinity
+242	i386	sched_getaffinity	sys_sched_getaffinity		compat_sys_sched_getaffinity
+243	i386	set_thread_area		sys_set_thread_area		sys_set_thread_area
+244	i386	get_thread_area		sys_get_thread_area		sys_get_thread_area
+245	i386	io_setup		sys_io_setup			compat_sys_io_setup
+246	i386	io_destroy		sys_io_destroy			sys_io_destroy
+247	i386	io_getevents		sys_io_getevents_time32		sys_io_getevents_time32
+248	i386	io_submit		sys_io_submit			compat_sys_io_submit
+249	i386	io_cancel		sys_io_cancel			sys_io_cancel
+250	i386	fadvise64		sys_fadvise64			compat_sys_x86_fadvise64
 # 251 is available for reuse (was briefly sys_set_zone_reclaim)
-252	i386	exit_group		sys_exit_group			__ia32_sys_exit_group
-253	i386	lookup_dcookie		sys_lookup_dcookie		__ia32_compat_sys_lookup_dcookie
-254	i386	epoll_create		sys_epoll_create		__ia32_sys_epoll_create
-255	i386	epoll_ctl		sys_epoll_ctl			__ia32_sys_epoll_ctl
-256	i386	epoll_wait		sys_epoll_wait			__ia32_sys_epoll_wait
-257	i386	remap_file_pages	sys_remap_file_pages		__ia32_sys_remap_file_pages
-258	i386	set_tid_address		sys_set_tid_address		__ia32_sys_set_tid_address
-259	i386	timer_create		sys_timer_create		__ia32_compat_sys_timer_create
-260	i386	timer_settime		sys_timer_settime32		__ia32_sys_timer_settime32
-261	i386	timer_gettime		sys_timer_gettime32		__ia32_sys_timer_gettime32
-262	i386	timer_getoverrun	sys_timer_getoverrun		__ia32_sys_timer_getoverrun
-263	i386	timer_delete		sys_timer_delete		__ia32_sys_timer_delete
-264	i386	clock_settime		sys_clock_settime32		__ia32_sys_clock_settime32
-265	i386	clock_gettime		sys_clock_gettime32		__ia32_sys_clock_gettime32
-266	i386	clock_getres		sys_clock_getres_time32		__ia32_sys_clock_getres_time32
-267	i386	clock_nanosleep		sys_clock_nanosleep_time32	__ia32_sys_clock_nanosleep_time32
-268	i386	statfs64		sys_statfs64			__ia32_compat_sys_statfs64
-269	i386	fstatfs64		sys_fstatfs64			__ia32_compat_sys_fstatfs64
-270	i386	tgkill			sys_tgkill			__ia32_sys_tgkill
-271	i386	utimes			sys_utimes_time32		__ia32_sys_utimes_time32
-272	i386	fadvise64_64		sys_fadvise64_64		__ia32_compat_sys_x86_fadvise64_64
+252	i386	exit_group		sys_exit_group			sys_exit_group
+253	i386	lookup_dcookie		sys_lookup_dcookie		compat_sys_lookup_dcookie
+254	i386	epoll_create		sys_epoll_create		sys_epoll_create
+255	i386	epoll_ctl		sys_epoll_ctl			sys_epoll_ctl
+256	i386	epoll_wait		sys_epoll_wait			sys_epoll_wait
+257	i386	remap_file_pages	sys_remap_file_pages		sys_remap_file_pages
+258	i386	set_tid_address		sys_set_tid_address		sys_set_tid_address
+259	i386	timer_create		sys_timer_create		compat_sys_timer_create
+260	i386	timer_settime		sys_timer_settime32		sys_timer_settime32
+261	i386	timer_gettime		sys_timer_gettime32		sys_timer_gettime32
+262	i386	timer_getoverrun	sys_timer_getoverrun		sys_timer_getoverrun
+263	i386	timer_delete		sys_timer_delete		sys_timer_delete
+264	i386	clock_settime		sys_clock_settime32		sys_clock_settime32
+265	i386	clock_gettime		sys_clock_gettime32		sys_clock_gettime32
+266	i386	clock_getres		sys_clock_getres_time32		sys_clock_getres_time32
+267	i386	clock_nanosleep		sys_clock_nanosleep_time32	sys_clock_nanosleep_time32
+268	i386	statfs64		sys_statfs64			compat_sys_statfs64
+269	i386	fstatfs64		sys_fstatfs64			compat_sys_fstatfs64
+270	i386	tgkill			sys_tgkill			sys_tgkill
+271	i386	utimes			sys_utimes_time32		sys_utimes_time32
+272	i386	fadvise64_64		sys_fadvise64_64		compat_sys_x86_fadvise64_64
 273	i386	vserver
-274	i386	mbind			sys_mbind			__ia32_sys_mbind
-275	i386	get_mempolicy		sys_get_mempolicy		__ia32_compat_sys_get_mempolicy
-276	i386	set_mempolicy		sys_set_mempolicy		__ia32_sys_set_mempolicy
-277	i386	mq_open			sys_mq_open			__ia32_compat_sys_mq_open
-278	i386	mq_unlink		sys_mq_unlink			__ia32_sys_mq_unlink
-279	i386	mq_timedsend		sys_mq_timedsend_time32		__ia32_sys_mq_timedsend_time32
-280	i386	mq_timedreceive		sys_mq_timedreceive_time32	__ia32_sys_mq_timedreceive_time32
-281	i386	mq_notify		sys_mq_notify			__ia32_compat_sys_mq_notify
-282	i386	mq_getsetattr		sys_mq_getsetattr		__ia32_compat_sys_mq_getsetattr
-283	i386	kexec_load		sys_kexec_load			__ia32_compat_sys_kexec_load
-284	i386	waitid			sys_waitid			__ia32_compat_sys_waitid
+274	i386	mbind			sys_mbind			sys_mbind
+275	i386	get_mempolicy		sys_get_mempolicy		compat_sys_get_mempolicy
+276	i386	set_mempolicy		sys_set_mempolicy		sys_set_mempolicy
+277	i386	mq_open			sys_mq_open			compat_sys_mq_open
+278	i386	mq_unlink		sys_mq_unlink			sys_mq_unlink
+279	i386	mq_timedsend		sys_mq_timedsend_time32		sys_mq_timedsend_time32
+280	i386	mq_timedreceive		sys_mq_timedreceive_time32	sys_mq_timedreceive_time32
+281	i386	mq_notify		sys_mq_notify			compat_sys_mq_notify
+282	i386	mq_getsetattr		sys_mq_getsetattr		compat_sys_mq_getsetattr
+283	i386	kexec_load		sys_kexec_load			compat_sys_kexec_load
+284	i386	waitid			sys_waitid			compat_sys_waitid
 # 285 sys_setaltroot
-286	i386	add_key			sys_add_key			__ia32_sys_add_key
-287	i386	request_key		sys_request_key			__ia32_sys_request_key
-288	i386	keyctl			sys_keyctl			__ia32_compat_sys_keyctl
-289	i386	ioprio_set		sys_ioprio_set			__ia32_sys_ioprio_set
-290	i386	ioprio_get		sys_ioprio_get			__ia32_sys_ioprio_get
-291	i386	inotify_init		sys_inotify_init		__ia32_sys_inotify_init
-292	i386	inotify_add_watch	sys_inotify_add_watch		__ia32_sys_inotify_add_watch
-293	i386	inotify_rm_watch	sys_inotify_rm_watch		__ia32_sys_inotify_rm_watch
-294	i386	migrate_pages		sys_migrate_pages		__ia32_sys_migrate_pages
-295	i386	openat			sys_openat			__ia32_compat_sys_openat
-296	i386	mkdirat			sys_mkdirat			__ia32_sys_mkdirat
-297	i386	mknodat			sys_mknodat			__ia32_sys_mknodat
-298	i386	fchownat		sys_fchownat			__ia32_sys_fchownat
-299	i386	futimesat		sys_futimesat_time32		__ia32_sys_futimesat_time32
-300	i386	fstatat64		sys_fstatat64			__ia32_compat_sys_x86_fstatat
-301	i386	unlinkat		sys_unlinkat			__ia32_sys_unlinkat
-302	i386	renameat		sys_renameat			__ia32_sys_renameat
-303	i386	linkat			sys_linkat			__ia32_sys_linkat
-304	i386	symlinkat		sys_symlinkat			__ia32_sys_symlinkat
-305	i386	readlinkat		sys_readlinkat			__ia32_sys_readlinkat
-306	i386	fchmodat		sys_fchmodat			__ia32_sys_fchmodat
-307	i386	faccessat		sys_faccessat			__ia32_sys_faccessat
-308	i386	pselect6		sys_pselect6_time32		__ia32_compat_sys_pselect6_time32
-309	i386	ppoll			sys_ppoll_time32		__ia32_compat_sys_ppoll_time32
-310	i386	unshare			sys_unshare			__ia32_sys_unshare
-311	i386	set_robust_list		sys_set_robust_list		__ia32_compat_sys_set_robust_list
-312	i386	get_robust_list		sys_get_robust_list		__ia32_compat_sys_get_robust_list
-313	i386	splice			sys_splice			__ia32_sys_splice
-314	i386	sync_file_range		sys_sync_file_range		__ia32_compat_sys_x86_sync_file_range
-315	i386	tee			sys_tee				__ia32_sys_tee
-316	i386	vmsplice		sys_vmsplice			__ia32_compat_sys_vmsplice
-317	i386	move_pages		sys_move_pages			__ia32_compat_sys_move_pages
-318	i386	getcpu			sys_getcpu			__ia32_sys_getcpu
-319	i386	epoll_pwait		sys_epoll_pwait			__ia32_sys_epoll_pwait
-320	i386	utimensat		sys_utimensat_time32		__ia32_sys_utimensat_time32
-321	i386	signalfd		sys_signalfd			__ia32_compat_sys_signalfd
-322	i386	timerfd_create		sys_timerfd_create		__ia32_sys_timerfd_create
-323	i386	eventfd			sys_eventfd			__ia32_sys_eventfd
-324	i386	fallocate		sys_fallocate			__ia32_compat_sys_x86_fallocate
-325	i386	timerfd_settime		sys_timerfd_settime32		__ia32_sys_timerfd_settime32
-326	i386	timerfd_gettime		sys_timerfd_gettime32		__ia32_sys_timerfd_gettime32
-327	i386	signalfd4		sys_signalfd4			__ia32_compat_sys_signalfd4
-328	i386	eventfd2		sys_eventfd2			__ia32_sys_eventfd2
-329	i386	epoll_create1		sys_epoll_create1		__ia32_sys_epoll_create1
-330	i386	dup3			sys_dup3			__ia32_sys_dup3
-331	i386	pipe2			sys_pipe2			__ia32_sys_pipe2
-332	i386	inotify_init1		sys_inotify_init1		__ia32_sys_inotify_init1
-333	i386	preadv			sys_preadv			__ia32_compat_sys_preadv
-334	i386	pwritev			sys_pwritev			__ia32_compat_sys_pwritev
-335	i386	rt_tgsigqueueinfo	sys_rt_tgsigqueueinfo		__ia32_compat_sys_rt_tgsigqueueinfo
-336	i386	perf_event_open		sys_perf_event_open		__ia32_sys_perf_event_open
-337	i386	recvmmsg		sys_recvmmsg_time32		__ia32_compat_sys_recvmmsg_time32
-338	i386	fanotify_init		sys_fanotify_init		__ia32_sys_fanotify_init
-339	i386	fanotify_mark		sys_fanotify_mark		__ia32_compat_sys_fanotify_mark
-340	i386	prlimit64		sys_prlimit64			__ia32_sys_prlimit64
-341	i386	name_to_handle_at	sys_name_to_handle_at		__ia32_sys_name_to_handle_at
-342	i386	open_by_handle_at	sys_open_by_handle_at		__ia32_compat_sys_open_by_handle_at
-343	i386	clock_adjtime		sys_clock_adjtime32		__ia32_sys_clock_adjtime32
-344	i386	syncfs			sys_syncfs			__ia32_sys_syncfs
-345	i386	sendmmsg		sys_sendmmsg			__ia32_compat_sys_sendmmsg
-346	i386	setns			sys_setns			__ia32_sys_setns
-347	i386	process_vm_readv	sys_process_vm_readv		__ia32_compat_sys_process_vm_readv
-348	i386	process_vm_writev	sys_process_vm_writev		__ia32_compat_sys_process_vm_writev
-349	i386	kcmp			sys_kcmp			__ia32_sys_kcmp
-350	i386	finit_module		sys_finit_module		__ia32_sys_finit_module
-351	i386	sched_setattr		sys_sched_setattr		__ia32_sys_sched_setattr
-352	i386	sched_getattr		sys_sched_getattr		__ia32_sys_sched_getattr
-353	i386	renameat2		sys_renameat2			__ia32_sys_renameat2
-354	i386	seccomp			sys_seccomp			__ia32_sys_seccomp
-355	i386	getrandom		sys_getrandom			__ia32_sys_getrandom
-356	i386	memfd_create		sys_memfd_create		__ia32_sys_memfd_create
-357	i386	bpf			sys_bpf				__ia32_sys_bpf
-358	i386	execveat		sys_execveat			__ia32_compat_sys_execveat
-359	i386	socket			sys_socket			__ia32_sys_socket
-360	i386	socketpair		sys_socketpair			__ia32_sys_socketpair
-361	i386	bind			sys_bind			__ia32_sys_bind
-362	i386	connect			sys_connect			__ia32_sys_connect
-363	i386	listen			sys_listen			__ia32_sys_listen
-364	i386	accept4			sys_accept4			__ia32_sys_accept4
-365	i386	getsockopt		sys_getsockopt			__ia32_compat_sys_getsockopt
-366	i386	setsockopt		sys_setsockopt			__ia32_compat_sys_setsockopt
-367	i386	getsockname		sys_getsockname			__ia32_sys_getsockname
-368	i386	getpeername		sys_getpeername			__ia32_sys_getpeername
-369	i386	sendto			sys_sendto			__ia32_sys_sendto
-370	i386	sendmsg			sys_sendmsg			__ia32_compat_sys_sendmsg
-371	i386	recvfrom		sys_recvfrom			__ia32_compat_sys_recvfrom
-372	i386	recvmsg			sys_recvmsg			__ia32_compat_sys_recvmsg
-373	i386	shutdown		sys_shutdown			__ia32_sys_shutdown
-374	i386	userfaultfd		sys_userfaultfd			__ia32_sys_userfaultfd
-375	i386	membarrier		sys_membarrier			__ia32_sys_membarrier
-376	i386	mlock2			sys_mlock2			__ia32_sys_mlock2
-377	i386	copy_file_range		sys_copy_file_range		__ia32_sys_copy_file_range
-378	i386	preadv2			sys_preadv2			__ia32_compat_sys_preadv2
-379	i386	pwritev2		sys_pwritev2			__ia32_compat_sys_pwritev2
-380	i386	pkey_mprotect		sys_pkey_mprotect		__ia32_sys_pkey_mprotect
-381	i386	pkey_alloc		sys_pkey_alloc			__ia32_sys_pkey_alloc
-382	i386	pkey_free		sys_pkey_free			__ia32_sys_pkey_free
-383	i386	statx			sys_statx			__ia32_sys_statx
-384	i386	arch_prctl		sys_arch_prctl			__ia32_compat_sys_arch_prctl
-385	i386	io_pgetevents		sys_io_pgetevents_time32	__ia32_compat_sys_io_pgetevents
-386	i386	rseq			sys_rseq			__ia32_sys_rseq
-393	i386	semget			sys_semget    			__ia32_sys_semget
-394	i386	semctl			sys_semctl    			__ia32_compat_sys_semctl
-395	i386	shmget			sys_shmget    			__ia32_sys_shmget
-396	i386	shmctl			sys_shmctl    			__ia32_compat_sys_shmctl
-397	i386	shmat			sys_shmat     			__ia32_compat_sys_shmat
-398	i386	shmdt			sys_shmdt     			__ia32_sys_shmdt
-399	i386	msgget			sys_msgget    			__ia32_sys_msgget
-400	i386	msgsnd			sys_msgsnd    			__ia32_compat_sys_msgsnd
-401	i386	msgrcv			sys_msgrcv    			__ia32_compat_sys_msgrcv
-402	i386	msgctl			sys_msgctl    			__ia32_compat_sys_msgctl
-403	i386	clock_gettime64		sys_clock_gettime		__ia32_sys_clock_gettime
-404	i386	clock_settime64		sys_clock_settime		__ia32_sys_clock_settime
-405	i386	clock_adjtime64		sys_clock_adjtime		__ia32_sys_clock_adjtime
-406	i386	clock_getres_time64	sys_clock_getres		__ia32_sys_clock_getres
-407	i386	clock_nanosleep_time64	sys_clock_nanosleep		__ia32_sys_clock_nanosleep
-408	i386	timer_gettime64		sys_timer_gettime		__ia32_sys_timer_gettime
-409	i386	timer_settime64		sys_timer_settime		__ia32_sys_timer_settime
-410	i386	timerfd_gettime64	sys_timerfd_gettime		__ia32_sys_timerfd_gettime
-411	i386	timerfd_settime64	sys_timerfd_settime		__ia32_sys_timerfd_settime
-412	i386	utimensat_time64	sys_utimensat			__ia32_sys_utimensat
-413	i386	pselect6_time64		sys_pselect6			__ia32_compat_sys_pselect6_time64
-414	i386	ppoll_time64		sys_ppoll			__ia32_compat_sys_ppoll_time64
-416	i386	io_pgetevents_time64	sys_io_pgetevents		__ia32_sys_io_pgetevents
-417	i386	recvmmsg_time64		sys_recvmmsg			__ia32_compat_sys_recvmmsg_time64
-418	i386	mq_timedsend_time64	sys_mq_timedsend		__ia32_sys_mq_timedsend
-419	i386	mq_timedreceive_time64	sys_mq_timedreceive		__ia32_sys_mq_timedreceive
-420	i386	semtimedop_time64	sys_semtimedop			__ia32_sys_semtimedop
-421	i386	rt_sigtimedwait_time64	sys_rt_sigtimedwait		__ia32_compat_sys_rt_sigtimedwait_time64
-422	i386	futex_time64		sys_futex			__ia32_sys_futex
-423	i386	sched_rr_get_interval_time64	sys_sched_rr_get_interval	__ia32_sys_sched_rr_get_interval
-424	i386	pidfd_send_signal	sys_pidfd_send_signal		__ia32_sys_pidfd_send_signal
-425	i386	io_uring_setup		sys_io_uring_setup		__ia32_sys_io_uring_setup
-426	i386	io_uring_enter		sys_io_uring_enter		__ia32_sys_io_uring_enter
-427	i386	io_uring_register	sys_io_uring_register		__ia32_sys_io_uring_register
-428	i386	open_tree		sys_open_tree			__ia32_sys_open_tree
-429	i386	move_mount		sys_move_mount			__ia32_sys_move_mount
-430	i386	fsopen			sys_fsopen			__ia32_sys_fsopen
-431	i386	fsconfig		sys_fsconfig			__ia32_sys_fsconfig
-432	i386	fsmount			sys_fsmount			__ia32_sys_fsmount
-433	i386	fspick			sys_fspick			__ia32_sys_fspick
-434	i386	pidfd_open		sys_pidfd_open			__ia32_sys_pidfd_open
-435	i386	clone3			sys_clone3			__ia32_sys_clone3
-437	i386	openat2			sys_openat2			__ia32_sys_openat2
-438	i386	pidfd_getfd		sys_pidfd_getfd			__ia32_sys_pidfd_getfd
+286	i386	add_key			sys_add_key			sys_add_key
+287	i386	request_key		sys_request_key			sys_request_key
+288	i386	keyctl			sys_keyctl			compat_sys_keyctl
+289	i386	ioprio_set		sys_ioprio_set			sys_ioprio_set
+290	i386	ioprio_get		sys_ioprio_get			sys_ioprio_get
+291	i386	inotify_init		sys_inotify_init		sys_inotify_init
+292	i386	inotify_add_watch	sys_inotify_add_watch		sys_inotify_add_watch
+293	i386	inotify_rm_watch	sys_inotify_rm_watch		sys_inotify_rm_watch
+294	i386	migrate_pages		sys_migrate_pages		sys_migrate_pages
+295	i386	openat			sys_openat			compat_sys_openat
+296	i386	mkdirat			sys_mkdirat			sys_mkdirat
+297	i386	mknodat			sys_mknodat			sys_mknodat
+298	i386	fchownat		sys_fchownat			sys_fchownat
+299	i386	futimesat		sys_futimesat_time32		sys_futimesat_time32
+300	i386	fstatat64		sys_fstatat64			compat_sys_x86_fstatat
+301	i386	unlinkat		sys_unlinkat			sys_unlinkat
+302	i386	renameat		sys_renameat			sys_renameat
+303	i386	linkat			sys_linkat			sys_linkat
+304	i386	symlinkat		sys_symlinkat			sys_symlinkat
+305	i386	readlinkat		sys_readlinkat			sys_readlinkat
+306	i386	fchmodat		sys_fchmodat			sys_fchmodat
+307	i386	faccessat		sys_faccessat			sys_faccessat
+308	i386	pselect6		sys_pselect6_time32		compat_sys_pselect6_time32
+309	i386	ppoll			sys_ppoll_time32		compat_sys_ppoll_time32
+310	i386	unshare			sys_unshare			sys_unshare
+311	i386	set_robust_list		sys_set_robust_list		compat_sys_set_robust_list
+312	i386	get_robust_list		sys_get_robust_list		compat_sys_get_robust_list
+313	i386	splice			sys_splice			sys_splice
+314	i386	sync_file_range		sys_sync_file_range		compat_sys_x86_sync_file_range
+315	i386	tee			sys_tee				sys_tee
+316	i386	vmsplice		sys_vmsplice			compat_sys_vmsplice
+317	i386	move_pages		sys_move_pages			compat_sys_move_pages
+318	i386	getcpu			sys_getcpu			sys_getcpu
+319	i386	epoll_pwait		sys_epoll_pwait			sys_epoll_pwait
+320	i386	utimensat		sys_utimensat_time32		sys_utimensat_time32
+321	i386	signalfd		sys_signalfd			compat_sys_signalfd
+322	i386	timerfd_create		sys_timerfd_create		sys_timerfd_create
+323	i386	eventfd			sys_eventfd			sys_eventfd
+324	i386	fallocate		sys_fallocate			compat_sys_x86_fallocate
+325	i386	timerfd_settime		sys_timerfd_settime32		sys_timerfd_settime32
+326	i386	timerfd_gettime		sys_timerfd_gettime32		sys_timerfd_gettime32
+327	i386	signalfd4		sys_signalfd4			compat_sys_signalfd4
+328	i386	eventfd2		sys_eventfd2			sys_eventfd2
+329	i386	epoll_create1		sys_epoll_create1		sys_epoll_create1
+330	i386	dup3			sys_dup3			sys_dup3
+331	i386	pipe2			sys_pipe2			sys_pipe2
+332	i386	inotify_init1		sys_inotify_init1		sys_inotify_init1
+333	i386	preadv			sys_preadv			compat_sys_preadv
+334	i386	pwritev			sys_pwritev			compat_sys_pwritev
+335	i386	rt_tgsigqueueinfo	sys_rt_tgsigqueueinfo		compat_sys_rt_tgsigqueueinfo
+336	i386	perf_event_open		sys_perf_event_open		sys_perf_event_open
+337	i386	recvmmsg		sys_recvmmsg_time32		compat_sys_recvmmsg_time32
+338	i386	fanotify_init		sys_fanotify_init		sys_fanotify_init
+339	i386	fanotify_mark		sys_fanotify_mark		compat_sys_fanotify_mark
+340	i386	prlimit64		sys_prlimit64			sys_prlimit64
+341	i386	name_to_handle_at	sys_name_to_handle_at		sys_name_to_handle_at
+342	i386	open_by_handle_at	sys_open_by_handle_at		compat_sys_open_by_handle_at
+343	i386	clock_adjtime		sys_clock_adjtime32		sys_clock_adjtime32
+344	i386	syncfs			sys_syncfs			sys_syncfs
+345	i386	sendmmsg		sys_sendmmsg			compat_sys_sendmmsg
+346	i386	setns			sys_setns			sys_setns
+347	i386	process_vm_readv	sys_process_vm_readv		compat_sys_process_vm_readv
+348	i386	process_vm_writev	sys_process_vm_writev		compat_sys_process_vm_writev
+349	i386	kcmp			sys_kcmp			sys_kcmp
+350	i386	finit_module		sys_finit_module		sys_finit_module
+351	i386	sched_setattr		sys_sched_setattr		sys_sched_setattr
+352	i386	sched_getattr		sys_sched_getattr		sys_sched_getattr
+353	i386	renameat2		sys_renameat2			sys_renameat2
+354	i386	seccomp			sys_seccomp			sys_seccomp
+355	i386	getrandom		sys_getrandom			sys_getrandom
+356	i386	memfd_create		sys_memfd_create		sys_memfd_create
+357	i386	bpf			sys_bpf				sys_bpf
+358	i386	execveat		sys_execveat			compat_sys_execveat
+359	i386	socket			sys_socket			sys_socket
+360	i386	socketpair		sys_socketpair			sys_socketpair
+361	i386	bind			sys_bind			sys_bind
+362	i386	connect			sys_connect			sys_connect
+363	i386	listen			sys_listen			sys_listen
+364	i386	accept4			sys_accept4			sys_accept4
+365	i386	getsockopt		sys_getsockopt			compat_sys_getsockopt
+366	i386	setsockopt		sys_setsockopt			compat_sys_setsockopt
+367	i386	getsockname		sys_getsockname			sys_getsockname
+368	i386	getpeername		sys_getpeername			sys_getpeername
+369	i386	sendto			sys_sendto			sys_sendto
+370	i386	sendmsg			sys_sendmsg			compat_sys_sendmsg
+371	i386	recvfrom		sys_recvfrom			compat_sys_recvfrom
+372	i386	recvmsg			sys_recvmsg			compat_sys_recvmsg
+373	i386	shutdown		sys_shutdown			sys_shutdown
+374	i386	userfaultfd		sys_userfaultfd			sys_userfaultfd
+375	i386	membarrier		sys_membarrier			sys_membarrier
+376	i386	mlock2			sys_mlock2			sys_mlock2
+377	i386	copy_file_range		sys_copy_file_range		sys_copy_file_range
+378	i386	preadv2			sys_preadv2			compat_sys_preadv2
+379	i386	pwritev2		sys_pwritev2			compat_sys_pwritev2
+380	i386	pkey_mprotect		sys_pkey_mprotect		sys_pkey_mprotect
+381	i386	pkey_alloc		sys_pkey_alloc			sys_pkey_alloc
+382	i386	pkey_free		sys_pkey_free			sys_pkey_free
+383	i386	statx			sys_statx			sys_statx
+384	i386	arch_prctl		sys_arch_prctl			compat_sys_arch_prctl
+385	i386	io_pgetevents		sys_io_pgetevents_time32	compat_sys_io_pgetevents
+386	i386	rseq			sys_rseq			sys_rseq
+393	i386	semget			sys_semget    			sys_semget
+394	i386	semctl			sys_semctl    			compat_sys_semctl
+395	i386	shmget			sys_shmget    			sys_shmget
+396	i386	shmctl			sys_shmctl    			compat_sys_shmctl
+397	i386	shmat			sys_shmat     			compat_sys_shmat
+398	i386	shmdt			sys_shmdt     			sys_shmdt
+399	i386	msgget			sys_msgget    			sys_msgget
+400	i386	msgsnd			sys_msgsnd    			compat_sys_msgsnd
+401	i386	msgrcv			sys_msgrcv    			compat_sys_msgrcv
+402	i386	msgctl			sys_msgctl    			compat_sys_msgctl
+403	i386	clock_gettime64		sys_clock_gettime		sys_clock_gettime
+404	i386	clock_settime64		sys_clock_settime		sys_clock_settime
+405	i386	clock_adjtime64		sys_clock_adjtime		sys_clock_adjtime
+406	i386	clock_getres_time64	sys_clock_getres		sys_clock_getres
+407	i386	clock_nanosleep_time64	sys_clock_nanosleep		sys_clock_nanosleep
+408	i386	timer_gettime64		sys_timer_gettime		sys_timer_gettime
+409	i386	timer_settime64		sys_timer_settime		sys_timer_settime
+410	i386	timerfd_gettime64	sys_timerfd_gettime		sys_timerfd_gettime
+411	i386	timerfd_settime64	sys_timerfd_settime		sys_timerfd_settime
+412	i386	utimensat_time64	sys_utimensat			sys_utimensat
+413	i386	pselect6_time64		sys_pselect6			compat_sys_pselect6_time64
+414	i386	ppoll_time64		sys_ppoll			compat_sys_ppoll_time64
+416	i386	io_pgetevents_time64	sys_io_pgetevents		sys_io_pgetevents
+417	i386	recvmmsg_time64		sys_recvmmsg			compat_sys_recvmmsg_time64
+418	i386	mq_timedsend_time64	sys_mq_timedsend		sys_mq_timedsend
+419	i386	mq_timedreceive_time64	sys_mq_timedreceive		sys_mq_timedreceive
+420	i386	semtimedop_time64	sys_semtimedop			sys_semtimedop
+421	i386	rt_sigtimedwait_time64	sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
+422	i386	futex_time64		sys_futex			sys_futex
+423	i386	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
+424	i386	pidfd_send_signal	sys_pidfd_send_signal		sys_pidfd_send_signal
+425	i386	io_uring_setup		sys_io_uring_setup		sys_io_uring_setup
+426	i386	io_uring_enter		sys_io_uring_enter		sys_io_uring_enter
+427	i386	io_uring_register	sys_io_uring_register		sys_io_uring_register
+428	i386	open_tree		sys_open_tree			sys_open_tree
+429	i386	move_mount		sys_move_mount			sys_move_mount
+430	i386	fsopen			sys_fsopen			sys_fsopen
+431	i386	fsconfig		sys_fsconfig			sys_fsconfig
+432	i386	fsmount			sys_fsmount			sys_fsmount
+433	i386	fspick			sys_fspick			sys_fspick
+434	i386	pidfd_open		sys_pidfd_open			sys_pidfd_open
+435	i386	clone3			sys_clone3			sys_clone3
+437	i386	openat2			sys_openat2			sys_openat2
+438	i386	pidfd_getfd		sys_pidfd_getfd			sys_pidfd_getfd
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index e8fb722..37b844f 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -8,357 +8,357 @@
 #
 # The abi is "common", "64" or "x32" for this file.
 #
-0	common	read			__x64_sys_read
-1	common	write			__x64_sys_write
-2	common	open			__x64_sys_open
-3	common	close			__x64_sys_close
-4	common	stat			__x64_sys_newstat
-5	common	fstat			__x64_sys_newfstat
-6	common	lstat			__x64_sys_newlstat
-7	common	poll			__x64_sys_poll
-8	common	lseek			__x64_sys_lseek
-9	common	mmap			__x64_sys_mmap
-10	common	mprotect		__x64_sys_mprotect
-11	common	munmap			__x64_sys_munmap
-12	common	brk			__x64_sys_brk
-13	64	rt_sigaction		__x64_sys_rt_sigaction
-14	common	rt_sigprocmask		__x64_sys_rt_sigprocmask
-15	64	rt_sigreturn		__x64_sys_rt_sigreturn
-16	64	ioctl			__x64_sys_ioctl
-17	common	pread64			__x64_sys_pread64
-18	common	pwrite64		__x64_sys_pwrite64
-19	64	readv			__x64_sys_readv
-20	64	writev			__x64_sys_writev
-21	common	access			__x64_sys_access
-22	common	pipe			__x64_sys_pipe
-23	common	select			__x64_sys_select
-24	common	sched_yield		__x64_sys_sched_yield
-25	common	mremap			__x64_sys_mremap
-26	common	msync			__x64_sys_msync
-27	common	mincore			__x64_sys_mincore
-28	common	madvise			__x64_sys_madvise
-29	common	shmget			__x64_sys_shmget
-30	common	shmat			__x64_sys_shmat
-31	common	shmctl			__x64_sys_shmctl
-32	common	dup			__x64_sys_dup
-33	common	dup2			__x64_sys_dup2
-34	common	pause			__x64_sys_pause
-35	common	nanosleep		__x64_sys_nanosleep
-36	common	getitimer		__x64_sys_getitimer
-37	common	alarm			__x64_sys_alarm
-38	common	setitimer		__x64_sys_setitimer
-39	common	getpid			__x64_sys_getpid
-40	common	sendfile		__x64_sys_sendfile64
-41	common	socket			__x64_sys_socket
-42	common	connect			__x64_sys_connect
-43	common	accept			__x64_sys_accept
-44	common	sendto			__x64_sys_sendto
-45	64	recvfrom		__x64_sys_recvfrom
-46	64	sendmsg			__x64_sys_sendmsg
-47	64	recvmsg			__x64_sys_recvmsg
-48	common	shutdown		__x64_sys_shutdown
-49	common	bind			__x64_sys_bind
-50	common	listen			__x64_sys_listen
-51	common	getsockname		__x64_sys_getsockname
-52	common	getpeername		__x64_sys_getpeername
-53	common	socketpair		__x64_sys_socketpair
-54	64	setsockopt		__x64_sys_setsockopt
-55	64	getsockopt		__x64_sys_getsockopt
-56	common	clone			__x64_sys_clone
-57	common	fork			__x64_sys_fork
-58	common	vfork			__x64_sys_vfork
-59	64	execve			__x64_sys_execve
-60	common	exit			__x64_sys_exit
-61	common	wait4			__x64_sys_wait4
-62	common	kill			__x64_sys_kill
-63	common	uname			__x64_sys_newuname
-64	common	semget			__x64_sys_semget
-65	common	semop			__x64_sys_semop
-66	common	semctl			__x64_sys_semctl
-67	common	shmdt			__x64_sys_shmdt
-68	common	msgget			__x64_sys_msgget
-69	common	msgsnd			__x64_sys_msgsnd
-70	common	msgrcv			__x64_sys_msgrcv
-71	common	msgctl			__x64_sys_msgctl
-72	common	fcntl			__x64_sys_fcntl
-73	common	flock			__x64_sys_flock
-74	common	fsync			__x64_sys_fsync
-75	common	fdatasync		__x64_sys_fdatasync
-76	common	truncate		__x64_sys_truncate
-77	common	ftruncate		__x64_sys_ftruncate
-78	common	getdents		__x64_sys_getdents
-79	common	getcwd			__x64_sys_getcwd
-80	common	chdir			__x64_sys_chdir
-81	common	fchdir			__x64_sys_fchdir
-82	common	rename			__x64_sys_rename
-83	common	mkdir			__x64_sys_mkdir
-84	common	rmdir			__x64_sys_rmdir
-85	common	creat			__x64_sys_creat
-86	common	link			__x64_sys_link
-87	common	unlink			__x64_sys_unlink
-88	common	symlink			__x64_sys_symlink
-89	common	readlink		__x64_sys_readlink
-90	common	chmod			__x64_sys_chmod
-91	common	fchmod			__x64_sys_fchmod
-92	common	chown			__x64_sys_chown
-93	common	fchown			__x64_sys_fchown
-94	common	lchown			__x64_sys_lchown
-95	common	umask			__x64_sys_umask
-96	common	gettimeofday		__x64_sys_gettimeofday
-97	common	getrlimit		__x64_sys_getrlimit
-98	common	getrusage		__x64_sys_getrusage
-99	common	sysinfo			__x64_sys_sysinfo
-100	common	times			__x64_sys_times
-101	64	ptrace			__x64_sys_ptrace
-102	common	getuid			__x64_sys_getuid
-103	common	syslog			__x64_sys_syslog
-104	common	getgid			__x64_sys_getgid
-105	common	setuid			__x64_sys_setuid
-106	common	setgid			__x64_sys_setgid
-107	common	geteuid			__x64_sys_geteuid
-108	common	getegid			__x64_sys_getegid
-109	common	setpgid			__x64_sys_setpgid
-110	common	getppid			__x64_sys_getppid
-111	common	getpgrp			__x64_sys_getpgrp
-112	common	setsid			__x64_sys_setsid
-113	common	setreuid		__x64_sys_setreuid
-114	common	setregid		__x64_sys_setregid
-115	common	getgroups		__x64_sys_getgroups
-116	common	setgroups		__x64_sys_setgroups
-117	common	setresuid		__x64_sys_setresuid
-118	common	getresuid		__x64_sys_getresuid
-119	common	setresgid		__x64_sys_setresgid
-120	common	getresgid		__x64_sys_getresgid
-121	common	getpgid			__x64_sys_getpgid
-122	common	setfsuid		__x64_sys_setfsuid
-123	common	setfsgid		__x64_sys_setfsgid
-124	common	getsid			__x64_sys_getsid
-125	common	capget			__x64_sys_capget
-126	common	capset			__x64_sys_capset
-127	64	rt_sigpending		__x64_sys_rt_sigpending
-128	64	rt_sigtimedwait		__x64_sys_rt_sigtimedwait
-129	64	rt_sigqueueinfo		__x64_sys_rt_sigqueueinfo
-130	common	rt_sigsuspend		__x64_sys_rt_sigsuspend
-131	64	sigaltstack		__x64_sys_sigaltstack
-132	common	utime			__x64_sys_utime
-133	common	mknod			__x64_sys_mknod
+0	common	read			sys_read
+1	common	write			sys_write
+2	common	open			sys_open
+3	common	close			sys_close
+4	common	stat			sys_newstat
+5	common	fstat			sys_newfstat
+6	common	lstat			sys_newlstat
+7	common	poll			sys_poll
+8	common	lseek			sys_lseek
+9	common	mmap			sys_mmap
+10	common	mprotect		sys_mprotect
+11	common	munmap			sys_munmap
+12	common	brk			sys_brk
+13	64	rt_sigaction		sys_rt_sigaction
+14	common	rt_sigprocmask		sys_rt_sigprocmask
+15	64	rt_sigreturn		sys_rt_sigreturn
+16	64	ioctl			sys_ioctl
+17	common	pread64			sys_pread64
+18	common	pwrite64		sys_pwrite64
+19	64	readv			sys_readv
+20	64	writev			sys_writev
+21	common	access			sys_access
+22	common	pipe			sys_pipe
+23	common	select			sys_select
+24	common	sched_yield		sys_sched_yield
+25	common	mremap			sys_mremap
+26	common	msync			sys_msync
+27	common	mincore			sys_mincore
+28	common	madvise			sys_madvise
+29	common	shmget			sys_shmget
+30	common	shmat			sys_shmat
+31	common	shmctl			sys_shmctl
+32	common	dup			sys_dup
+33	common	dup2			sys_dup2
+34	common	pause			sys_pause
+35	common	nanosleep		sys_nanosleep
+36	common	getitimer		sys_getitimer
+37	common	alarm			sys_alarm
+38	common	setitimer		sys_setitimer
+39	common	getpid			sys_getpid
+40	common	sendfile		sys_sendfile64
+41	common	socket			sys_socket
+42	common	connect			sys_connect
+43	common	accept			sys_accept
+44	common	sendto			sys_sendto
+45	64	recvfrom		sys_recvfrom
+46	64	sendmsg			sys_sendmsg
+47	64	recvmsg			sys_recvmsg
+48	common	shutdown		sys_shutdown
+49	common	bind			sys_bind
+50	common	listen			sys_listen
+51	common	getsockname		sys_getsockname
+52	common	getpeername		sys_getpeername
+53	common	socketpair		sys_socketpair
+54	64	setsockopt		sys_setsockopt
+55	64	getsockopt		sys_getsockopt
+56	common	clone			sys_clone
+57	common	fork			sys_fork
+58	common	vfork			sys_vfork
+59	64	execve			sys_execve
+60	common	exit			sys_exit
+61	common	wait4			sys_wait4
+62	common	kill			sys_kill
+63	common	uname			sys_newuname
+64	common	semget			sys_semget
+65	common	semop			sys_semop
+66	common	semctl			sys_semctl
+67	common	shmdt			sys_shmdt
+68	common	msgget			sys_msgget
+69	common	msgsnd			sys_msgsnd
+70	common	msgrcv			sys_msgrcv
+71	common	msgctl			sys_msgctl
+72	common	fcntl			sys_fcntl
+73	common	flock			sys_flock
+74	common	fsync			sys_fsync
+75	common	fdatasync		sys_fdatasync
+76	common	truncate		sys_truncate
+77	common	ftruncate		sys_ftruncate
+78	common	getdents		sys_getdents
+79	common	getcwd			sys_getcwd
+80	common	chdir			sys_chdir
+81	common	fchdir			sys_fchdir
+82	common	rename			sys_rename
+83	common	mkdir			sys_mkdir
+84	common	rmdir			sys_rmdir
+85	common	creat			sys_creat
+86	common	link			sys_link
+87	common	unlink			sys_unlink
+88	common	symlink			sys_symlink
+89	common	readlink		sys_readlink
+90	common	chmod			sys_chmod
+91	common	fchmod			sys_fchmod
+92	common	chown			sys_chown
+93	common	fchown			sys_fchown
+94	common	lchown			sys_lchown
+95	common	umask			sys_umask
+96	common	gettimeofday		sys_gettimeofday
+97	common	getrlimit		sys_getrlimit
+98	common	getrusage		sys_getrusage
+99	common	sysinfo			sys_sysinfo
+100	common	times			sys_times
+101	64	ptrace			sys_ptrace
+102	common	getuid			sys_getuid
+103	common	syslog			sys_syslog
+104	common	getgid			sys_getgid
+105	common	setuid			sys_setuid
+106	common	setgid			sys_setgid
+107	common	geteuid			sys_geteuid
+108	common	getegid			sys_getegid
+109	common	setpgid			sys_setpgid
+110	common	getppid			sys_getppid
+111	common	getpgrp			sys_getpgrp
+112	common	setsid			sys_setsid
+113	common	setreuid		sys_setreuid
+114	common	setregid		sys_setregid
+115	common	getgroups		sys_getgroups
+116	common	setgroups		sys_setgroups
+117	common	setresuid		sys_setresuid
+118	common	getresuid		sys_getresuid
+119	common	setresgid		sys_setresgid
+120	common	getresgid		sys_getresgid
+121	common	getpgid			sys_getpgid
+122	common	setfsuid		sys_setfsuid
+123	common	setfsgid		sys_setfsgid
+124	common	getsid			sys_getsid
+125	common	capget			sys_capget
+126	common	capset			sys_capset
+127	64	rt_sigpending		sys_rt_sigpending
+128	64	rt_sigtimedwait		sys_rt_sigtimedwait
+129	64	rt_sigqueueinfo		sys_rt_sigqueueinfo
+130	common	rt_sigsuspend		sys_rt_sigsuspend
+131	64	sigaltstack		sys_sigaltstack
+132	common	utime			sys_utime
+133	common	mknod			sys_mknod
 134	64	uselib
-135	common	personality		__x64_sys_personality
-136	common	ustat			__x64_sys_ustat
-137	common	statfs			__x64_sys_statfs
-138	common	fstatfs			__x64_sys_fstatfs
-139	common	sysfs			__x64_sys_sysfs
-140	common	getpriority		__x64_sys_getpriority
-141	common	setpriority		__x64_sys_setpriority
-142	common	sched_setparam		__x64_sys_sched_setparam
-143	common	sched_getparam		__x64_sys_sched_getparam
-144	common	sched_setscheduler	__x64_sys_sched_setscheduler
-145	common	sched_getscheduler	__x64_sys_sched_getscheduler
-146	common	sched_get_priority_max	__x64_sys_sched_get_priority_max
-147	common	sched_get_priority_min	__x64_sys_sched_get_priority_min
-148	common	sched_rr_get_interval	__x64_sys_sched_rr_get_interval
-149	common	mlock			__x64_sys_mlock
-150	common	munlock			__x64_sys_munlock
-151	common	mlockall		__x64_sys_mlockall
-152	common	munlockall		__x64_sys_munlockall
-153	common	vhangup			__x64_sys_vhangup
-154	common	modify_ldt		__x64_sys_modify_ldt
-155	common	pivot_root		__x64_sys_pivot_root
-156	64	_sysctl			__x64_sys_sysctl
-157	common	prctl			__x64_sys_prctl
-158	common	arch_prctl		__x64_sys_arch_prctl
-159	common	adjtimex		__x64_sys_adjtimex
-160	common	setrlimit		__x64_sys_setrlimit
-161	common	chroot			__x64_sys_chroot
-162	common	sync			__x64_sys_sync
-163	common	acct			__x64_sys_acct
-164	common	settimeofday		__x64_sys_settimeofday
-165	common	mount			__x64_sys_mount
-166	common	umount2			__x64_sys_umount
-167	common	swapon			__x64_sys_swapon
-168	common	swapoff			__x64_sys_swapoff
-169	common	reboot			__x64_sys_reboot
-170	common	sethostname		__x64_sys_sethostname
-171	common	setdomainname		__x64_sys_setdomainname
-172	common	iopl			__x64_sys_iopl
-173	common	ioperm			__x64_sys_ioperm
+135	common	personality		sys_personality
+136	common	ustat			sys_ustat
+137	common	statfs			sys_statfs
+138	common	fstatfs			sys_fstatfs
+139	common	sysfs			sys_sysfs
+140	common	getpriority		sys_getpriority
+141	common	setpriority		sys_setpriority
+142	common	sched_setparam		sys_sched_setparam
+143	common	sched_getparam		sys_sched_getparam
+144	common	sched_setscheduler	sys_sched_setscheduler
+145	common	sched_getscheduler	sys_sched_getscheduler
+146	common	sched_get_priority_max	sys_sched_get_priority_max
+147	common	sched_get_priority_min	sys_sched_get_priority_min
+148	common	sched_rr_get_interval	sys_sched_rr_get_interval
+149	common	mlock			sys_mlock
+150	common	munlock			sys_munlock
+151	common	mlockall		sys_mlockall
+152	common	munlockall		sys_munlockall
+153	common	vhangup			sys_vhangup
+154	common	modify_ldt		sys_modify_ldt
+155	common	pivot_root		sys_pivot_root
+156	64	_sysctl			sys_sysctl
+157	common	prctl			sys_prctl
+158	common	arch_prctl		sys_arch_prctl
+159	common	adjtimex		sys_adjtimex
+160	common	setrlimit		sys_setrlimit
+161	common	chroot			sys_chroot
+162	common	sync			sys_sync
+163	common	acct			sys_acct
+164	common	settimeofday		sys_settimeofday
+165	common	mount			sys_mount
+166	common	umount2			sys_umount
+167	common	swapon			sys_swapon
+168	common	swapoff			sys_swapoff
+169	common	reboot			sys_reboot
+170	common	sethostname		sys_sethostname
+171	common	setdomainname		sys_setdomainname
+172	common	iopl			sys_iopl
+173	common	ioperm			sys_ioperm
 174	64	create_module
-175	common	init_module		__x64_sys_init_module
-176	common	delete_module		__x64_sys_delete_module
+175	common	init_module		sys_init_module
+176	common	delete_module		sys_delete_module
 177	64	get_kernel_syms
 178	64	query_module
-179	common	quotactl		__x64_sys_quotactl
+179	common	quotactl		sys_quotactl
 180	64	nfsservctl
 181	common	getpmsg
 182	common	putpmsg
 183	common	afs_syscall
 184	common	tuxcall
 185	common	security
-186	common	gettid			__x64_sys_gettid
-187	common	readahead		__x64_sys_readahead
-188	common	setxattr		__x64_sys_setxattr
-189	common	lsetxattr		__x64_sys_lsetxattr
-190	common	fsetxattr		__x64_sys_fsetxattr
-191	common	getxattr		__x64_sys_getxattr
-192	common	lgetxattr		__x64_sys_lgetxattr
-193	common	fgetxattr		__x64_sys_fgetxattr
-194	common	listxattr		__x64_sys_listxattr
-195	common	llistxattr		__x64_sys_llistxattr
-196	common	flistxattr		__x64_sys_flistxattr
-197	common	removexattr		__x64_sys_removexattr
-198	common	lremovexattr		__x64_sys_lremovexattr
-199	common	fremovexattr		__x64_sys_fremovexattr
-200	common	tkill			__x64_sys_tkill
-201	common	time			__x64_sys_time
-202	common	futex			__x64_sys_futex
-203	common	sched_setaffinity	__x64_sys_sched_setaffinity
-204	common	sched_getaffinity	__x64_sys_sched_getaffinity
+186	common	gettid			sys_gettid
+187	common	readahead		sys_readahead
+188	common	setxattr		sys_setxattr
+189	common	lsetxattr		sys_lsetxattr
+190	common	fsetxattr		sys_fsetxattr
+191	common	getxattr		sys_getxattr
+192	common	lgetxattr		sys_lgetxattr
+193	common	fgetxattr		sys_fgetxattr
+194	common	listxattr		sys_listxattr
+195	common	llistxattr		sys_llistxattr
+196	common	flistxattr		sys_flistxattr
+197	common	removexattr		sys_removexattr
+198	common	lremovexattr		sys_lremovexattr
+199	common	fremovexattr		sys_fremovexattr
+200	common	tkill			sys_tkill
+201	common	time			sys_time
+202	common	futex			sys_futex
+203	common	sched_setaffinity	sys_sched_setaffinity
+204	common	sched_getaffinity	sys_sched_getaffinity
 205	64	set_thread_area
-206	64	io_setup		__x64_sys_io_setup
-207	common	io_destroy		__x64_sys_io_destroy
-208	common	io_getevents		__x64_sys_io_getevents
-209	64	io_submit		__x64_sys_io_submit
-210	common	io_cancel		__x64_sys_io_cancel
+206	64	io_setup		sys_io_setup
+207	common	io_destroy		sys_io_destroy
+208	common	io_getevents		sys_io_getevents
+209	64	io_submit		sys_io_submit
+210	common	io_cancel		sys_io_cancel
 211	64	get_thread_area
-212	common	lookup_dcookie		__x64_sys_lookup_dcookie
-213	common	epoll_create		__x64_sys_epoll_create
+212	common	lookup_dcookie		sys_lookup_dcookie
+213	common	epoll_create		sys_epoll_create
 214	64	epoll_ctl_old
 215	64	epoll_wait_old
-216	common	remap_file_pages	__x64_sys_remap_file_pages
-217	common	getdents64		__x64_sys_getdents64
-218	common	set_tid_address		__x64_sys_set_tid_address
-219	common	restart_syscall		__x64_sys_restart_syscall
-220	common	semtimedop		__x64_sys_semtimedop
-221	common	fadvise64		__x64_sys_fadvise64
-222	64	timer_create		__x64_sys_timer_create
-223	common	timer_settime		__x64_sys_timer_settime
-224	common	timer_gettime		__x64_sys_timer_gettime
-225	common	timer_getoverrun	__x64_sys_timer_getoverrun
-226	common	timer_delete		__x64_sys_timer_delete
-227	common	clock_settime		__x64_sys_clock_settime
-228	common	clock_gettime		__x64_sys_clock_gettime
-229	common	clock_getres		__x64_sys_clock_getres
-230	common	clock_nanosleep		__x64_sys_clock_nanosleep
-231	common	exit_group		__x64_sys_exit_group
-232	common	epoll_wait		__x64_sys_epoll_wait
-233	common	epoll_ctl		__x64_sys_epoll_ctl
-234	common	tgkill			__x64_sys_tgkill
-235	common	utimes			__x64_sys_utimes
+216	common	remap_file_pages	sys_remap_file_pages
+217	common	getdents64		sys_getdents64
+218	common	set_tid_address		sys_set_tid_address
+219	common	restart_syscall		sys_restart_syscall
+220	common	semtimedop		sys_semtimedop
+221	common	fadvise64		sys_fadvise64
+222	64	timer_create		sys_timer_create
+223	common	timer_settime		sys_timer_settime
+224	common	timer_gettime		sys_timer_gettime
+225	common	timer_getoverrun	sys_timer_getoverrun
+226	common	timer_delete		sys_timer_delete
+227	common	clock_settime		sys_clock_settime
+228	common	clock_gettime		sys_clock_gettime
+229	common	clock_getres		sys_clock_getres
+230	common	clock_nanosleep		sys_clock_nanosleep
+231	common	exit_group		sys_exit_group
+232	common	epoll_wait		sys_epoll_wait
+233	common	epoll_ctl		sys_epoll_ctl
+234	common	tgkill			sys_tgkill
+235	common	utimes			sys_utimes
 236	64	vserver
-237	common	mbind			__x64_sys_mbind
-238	common	set_mempolicy		__x64_sys_set_mempolicy
-239	common	get_mempolicy		__x64_sys_get_mempolicy
-240	common	mq_open			__x64_sys_mq_open
-241	common	mq_unlink		__x64_sys_mq_unlink
-242	common	mq_timedsend		__x64_sys_mq_timedsend
-243	common	mq_timedreceive		__x64_sys_mq_timedreceive
-244	64	mq_notify		__x64_sys_mq_notify
-245	common	mq_getsetattr		__x64_sys_mq_getsetattr
-246	64	kexec_load		__x64_sys_kexec_load
-247	64	waitid			__x64_sys_waitid
-248	common	add_key			__x64_sys_add_key
-249	common	request_key		__x64_sys_request_key
-250	common	keyctl			__x64_sys_keyctl
-251	common	ioprio_set		__x64_sys_ioprio_set
-252	common	ioprio_get		__x64_sys_ioprio_get
-253	common	inotify_init		__x64_sys_inotify_init
-254	common	inotify_add_watch	__x64_sys_inotify_add_watch
-255	common	inotify_rm_watch	__x64_sys_inotify_rm_watch
-256	common	migrate_pages		__x64_sys_migrate_pages
-257	common	openat			__x64_sys_openat
-258	common	mkdirat			__x64_sys_mkdirat
-259	common	mknodat			__x64_sys_mknodat
-260	common	fchownat		__x64_sys_fchownat
-261	common	futimesat		__x64_sys_futimesat
-262	common	newfstatat		__x64_sys_newfstatat
-263	common	unlinkat		__x64_sys_unlinkat
-264	common	renameat		__x64_sys_renameat
-265	common	linkat			__x64_sys_linkat
-266	common	symlinkat		__x64_sys_symlinkat
-267	common	readlinkat		__x64_sys_readlinkat
-268	common	fchmodat		__x64_sys_fchmodat
-269	common	faccessat		__x64_sys_faccessat
-270	common	pselect6		__x64_sys_pselect6
-271	common	ppoll			__x64_sys_ppoll
-272	common	unshare			__x64_sys_unshare
-273	64	set_robust_list		__x64_sys_set_robust_list
-274	64	get_robust_list		__x64_sys_get_robust_list
-275	common	splice			__x64_sys_splice
-276	common	tee			__x64_sys_tee
-277	common	sync_file_range		__x64_sys_sync_file_range
-278	64	vmsplice		__x64_sys_vmsplice
-279	64	move_pages		__x64_sys_move_pages
-280	common	utimensat		__x64_sys_utimensat
-281	common	epoll_pwait		__x64_sys_epoll_pwait
-282	common	signalfd		__x64_sys_signalfd
-283	common	timerfd_create		__x64_sys_timerfd_create
-284	common	eventfd			__x64_sys_eventfd
-285	common	fallocate		__x64_sys_fallocate
-286	common	timerfd_settime		__x64_sys_timerfd_settime
-287	common	timerfd_gettime		__x64_sys_timerfd_gettime
-288	common	accept4			__x64_sys_accept4
-289	common	signalfd4		__x64_sys_signalfd4
-290	common	eventfd2		__x64_sys_eventfd2
-291	common	epoll_create1		__x64_sys_epoll_create1
-292	common	dup3			__x64_sys_dup3
-293	common	pipe2			__x64_sys_pipe2
-294	common	inotify_init1		__x64_sys_inotify_init1
-295	64	preadv			__x64_sys_preadv
-296	64	pwritev			__x64_sys_pwritev
-297	64	rt_tgsigqueueinfo	__x64_sys_rt_tgsigqueueinfo
-298	common	perf_event_open		__x64_sys_perf_event_open
-299	64	recvmmsg		__x64_sys_recvmmsg
-300	common	fanotify_init		__x64_sys_fanotify_init
-301	common	fanotify_mark		__x64_sys_fanotify_mark
-302	common	prlimit64		__x64_sys_prlimit64
-303	common	name_to_handle_at	__x64_sys_name_to_handle_at
-304	common	open_by_handle_at	__x64_sys_open_by_handle_at
-305	common	clock_adjtime		__x64_sys_clock_adjtime
-306	common	syncfs			__x64_sys_syncfs
-307	64	sendmmsg		__x64_sys_sendmmsg
-308	common	setns			__x64_sys_setns
-309	common	getcpu			__x64_sys_getcpu
-310	64	process_vm_readv	__x64_sys_process_vm_readv
-311	64	process_vm_writev	__x64_sys_process_vm_writev
-312	common	kcmp			__x64_sys_kcmp
-313	common	finit_module		__x64_sys_finit_module
-314	common	sched_setattr		__x64_sys_sched_setattr
-315	common	sched_getattr		__x64_sys_sched_getattr
-316	common	renameat2		__x64_sys_renameat2
-317	common	seccomp			__x64_sys_seccomp
-318	common	getrandom		__x64_sys_getrandom
-319	common	memfd_create		__x64_sys_memfd_create
-320	common	kexec_file_load		__x64_sys_kexec_file_load
-321	common	bpf			__x64_sys_bpf
-322	64	execveat		__x64_sys_execveat
-323	common	userfaultfd		__x64_sys_userfaultfd
-324	common	membarrier		__x64_sys_membarrier
-325	common	mlock2			__x64_sys_mlock2
-326	common	copy_file_range		__x64_sys_copy_file_range
-327	64	preadv2			__x64_sys_preadv2
-328	64	pwritev2		__x64_sys_pwritev2
-329	common	pkey_mprotect		__x64_sys_pkey_mprotect
-330	common	pkey_alloc		__x64_sys_pkey_alloc
-331	common	pkey_free		__x64_sys_pkey_free
-332	common	statx			__x64_sys_statx
-333	common	io_pgetevents		__x64_sys_io_pgetevents
-334	common	rseq			__x64_sys_rseq
+237	common	mbind			sys_mbind
+238	common	set_mempolicy		sys_set_mempolicy
+239	common	get_mempolicy		sys_get_mempolicy
+240	common	mq_open			sys_mq_open
+241	common	mq_unlink		sys_mq_unlink
+242	common	mq_timedsend		sys_mq_timedsend
+243	common	mq_timedreceive		sys_mq_timedreceive
+244	64	mq_notify		sys_mq_notify
+245	common	mq_getsetattr		sys_mq_getsetattr
+246	64	kexec_load		sys_kexec_load
+247	64	waitid			sys_waitid
+248	common	add_key			sys_add_key
+249	common	request_key		sys_request_key
+250	common	keyctl			sys_keyctl
+251	common	ioprio_set		sys_ioprio_set
+252	common	ioprio_get		sys_ioprio_get
+253	common	inotify_init		sys_inotify_init
+254	common	inotify_add_watch	sys_inotify_add_watch
+255	common	inotify_rm_watch	sys_inotify_rm_watch
+256	common	migrate_pages		sys_migrate_pages
+257	common	openat			sys_openat
+258	common	mkdirat			sys_mkdirat
+259	common	mknodat			sys_mknodat
+260	common	fchownat		sys_fchownat
+261	common	futimesat		sys_futimesat
+262	common	newfstatat		sys_newfstatat
+263	common	unlinkat		sys_unlinkat
+264	common	renameat		sys_renameat
+265	common	linkat			sys_linkat
+266	common	symlinkat		sys_symlinkat
+267	common	readlinkat		sys_readlinkat
+268	common	fchmodat		sys_fchmodat
+269	common	faccessat		sys_faccessat
+270	common	pselect6		sys_pselect6
+271	common	ppoll			sys_ppoll
+272	common	unshare			sys_unshare
+273	64	set_robust_list		sys_set_robust_list
+274	64	get_robust_list		sys_get_robust_list
+275	common	splice			sys_splice
+276	common	tee			sys_tee
+277	common	sync_file_range		sys_sync_file_range
+278	64	vmsplice		sys_vmsplice
+279	64	move_pages		sys_move_pages
+280	common	utimensat		sys_utimensat
+281	common	epoll_pwait		sys_epoll_pwait
+282	common	signalfd		sys_signalfd
+283	common	timerfd_create		sys_timerfd_create
+284	common	eventfd			sys_eventfd
+285	common	fallocate		sys_fallocate
+286	common	timerfd_settime		sys_timerfd_settime
+287	common	timerfd_gettime		sys_timerfd_gettime
+288	common	accept4			sys_accept4
+289	common	signalfd4		sys_signalfd4
+290	common	eventfd2		sys_eventfd2
+291	common	epoll_create1		sys_epoll_create1
+292	common	dup3			sys_dup3
+293	common	pipe2			sys_pipe2
+294	common	inotify_init1		sys_inotify_init1
+295	64	preadv			sys_preadv
+296	64	pwritev			sys_pwritev
+297	64	rt_tgsigqueueinfo	sys_rt_tgsigqueueinfo
+298	common	perf_event_open		sys_perf_event_open
+299	64	recvmmsg		sys_recvmmsg
+300	common	fanotify_init		sys_fanotify_init
+301	common	fanotify_mark		sys_fanotify_mark
+302	common	prlimit64		sys_prlimit64
+303	common	name_to_handle_at	sys_name_to_handle_at
+304	common	open_by_handle_at	sys_open_by_handle_at
+305	common	clock_adjtime		sys_clock_adjtime
+306	common	syncfs			sys_syncfs
+307	64	sendmmsg		sys_sendmmsg
+308	common	setns			sys_setns
+309	common	getcpu			sys_getcpu
+310	64	process_vm_readv	sys_process_vm_readv
+311	64	process_vm_writev	sys_process_vm_writev
+312	common	kcmp			sys_kcmp
+313	common	finit_module		sys_finit_module
+314	common	sched_setattr		sys_sched_setattr
+315	common	sched_getattr		sys_sched_getattr
+316	common	renameat2		sys_renameat2
+317	common	seccomp			sys_seccomp
+318	common	getrandom		sys_getrandom
+319	common	memfd_create		sys_memfd_create
+320	common	kexec_file_load		sys_kexec_file_load
+321	common	bpf			sys_bpf
+322	64	execveat		sys_execveat
+323	common	userfaultfd		sys_userfaultfd
+324	common	membarrier		sys_membarrier
+325	common	mlock2			sys_mlock2
+326	common	copy_file_range		sys_copy_file_range
+327	64	preadv2			sys_preadv2
+328	64	pwritev2		sys_pwritev2
+329	common	pkey_mprotect		sys_pkey_mprotect
+330	common	pkey_alloc		sys_pkey_alloc
+331	common	pkey_free		sys_pkey_free
+332	common	statx			sys_statx
+333	common	io_pgetevents		sys_io_pgetevents
+334	common	rseq			sys_rseq
 # don't use numbers 387 through 423, add new calls after the last
 # 'common' entry
-424	common	pidfd_send_signal	__x64_sys_pidfd_send_signal
-425	common	io_uring_setup		__x64_sys_io_uring_setup
-426	common	io_uring_enter		__x64_sys_io_uring_enter
-427	common	io_uring_register	__x64_sys_io_uring_register
-428	common	open_tree		__x64_sys_open_tree
-429	common	move_mount		__x64_sys_move_mount
-430	common	fsopen			__x64_sys_fsopen
-431	common	fsconfig		__x64_sys_fsconfig
-432	common	fsmount			__x64_sys_fsmount
-433	common	fspick			__x64_sys_fspick
-434	common	pidfd_open		__x64_sys_pidfd_open
-435	common	clone3			__x64_sys_clone3
-437	common	openat2			__x64_sys_openat2
-438	common	pidfd_getfd		__x64_sys_pidfd_getfd
+424	common	pidfd_send_signal	sys_pidfd_send_signal
+425	common	io_uring_setup		sys_io_uring_setup
+426	common	io_uring_enter		sys_io_uring_enter
+427	common	io_uring_register	sys_io_uring_register
+428	common	open_tree		sys_open_tree
+429	common	move_mount		sys_move_mount
+430	common	fsopen			sys_fsopen
+431	common	fsconfig		sys_fsconfig
+432	common	fsmount			sys_fsmount
+433	common	fspick			sys_fspick
+434	common	pidfd_open		sys_pidfd_open
+435	common	clone3			sys_clone3
+437	common	openat2			sys_openat2
+438	common	pidfd_getfd		sys_pidfd_getfd
 
 #
 # x32-specific system call numbers start at 512 to avoid cache impact
@@ -366,39 +366,39 @@
 # on-the-fly for compat_sys_*() compatibility system calls if X86_X32
 # is defined.
 #
-512	x32	rt_sigaction		__x32_compat_sys_rt_sigaction
-513	x32	rt_sigreturn		__x32_compat_sys_x32_rt_sigreturn
-514	x32	ioctl			__x32_compat_sys_ioctl
-515	x32	readv			__x32_compat_sys_readv
-516	x32	writev			__x32_compat_sys_writev
-517	x32	recvfrom		__x32_compat_sys_recvfrom
-518	x32	sendmsg			__x32_compat_sys_sendmsg
-519	x32	recvmsg			__x32_compat_sys_recvmsg
-520	x32	execve			__x32_compat_sys_execve
-521	x32	ptrace			__x32_compat_sys_ptrace
-522	x32	rt_sigpending		__x32_compat_sys_rt_sigpending
-523	x32	rt_sigtimedwait		__x32_compat_sys_rt_sigtimedwait_time64
-524	x32	rt_sigqueueinfo		__x32_compat_sys_rt_sigqueueinfo
-525	x32	sigaltstack		__x32_compat_sys_sigaltstack
-526	x32	timer_create		__x32_compat_sys_timer_create
-527	x32	mq_notify		__x32_compat_sys_mq_notify
-528	x32	kexec_load		__x32_compat_sys_kexec_load
-529	x32	waitid			__x32_compat_sys_waitid
-530	x32	set_robust_list		__x32_compat_sys_set_robust_list
-531	x32	get_robust_list		__x32_compat_sys_get_robust_list
-532	x32	vmsplice		__x32_compat_sys_vmsplice
-533	x32	move_pages		__x32_compat_sys_move_pages
-534	x32	preadv			__x32_compat_sys_preadv64
-535	x32	pwritev			__x32_compat_sys_pwritev64
-536	x32	rt_tgsigqueueinfo	__x32_compat_sys_rt_tgsigqueueinfo
-537	x32	recvmmsg		__x32_compat_sys_recvmmsg_time64
-538	x32	sendmmsg		__x32_compat_sys_sendmmsg
-539	x32	process_vm_readv	__x32_compat_sys_process_vm_readv
-540	x32	process_vm_writev	__x32_compat_sys_process_vm_writev
-541	x32	setsockopt		__x32_compat_sys_setsockopt
-542	x32	getsockopt		__x32_compat_sys_getsockopt
-543	x32	io_setup		__x32_compat_sys_io_setup
-544	x32	io_submit		__x32_compat_sys_io_submit
-545	x32	execveat		__x32_compat_sys_execveat
-546	x32	preadv2			__x32_compat_sys_preadv64v2
-547	x32	pwritev2		__x32_compat_sys_pwritev64v2
+512	x32	rt_sigaction		compat_sys_rt_sigaction
+513	x32	rt_sigreturn		compat_sys_x32_rt_sigreturn
+514	x32	ioctl			compat_sys_ioctl
+515	x32	readv			compat_sys_readv
+516	x32	writev			compat_sys_writev
+517	x32	recvfrom		compat_sys_recvfrom
+518	x32	sendmsg			compat_sys_sendmsg
+519	x32	recvmsg			compat_sys_recvmsg
+520	x32	execve			compat_sys_execve
+521	x32	ptrace			compat_sys_ptrace
+522	x32	rt_sigpending		compat_sys_rt_sigpending
+523	x32	rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
+524	x32	rt_sigqueueinfo		compat_sys_rt_sigqueueinfo
+525	x32	sigaltstack		compat_sys_sigaltstack
+526	x32	timer_create		compat_sys_timer_create
+527	x32	mq_notify		compat_sys_mq_notify
+528	x32	kexec_load		compat_sys_kexec_load
+529	x32	waitid			compat_sys_waitid
+530	x32	set_robust_list		compat_sys_set_robust_list
+531	x32	get_robust_list		compat_sys_get_robust_list
+532	x32	vmsplice		compat_sys_vmsplice
+533	x32	move_pages		compat_sys_move_pages
+534	x32	preadv			compat_sys_preadv64
+535	x32	pwritev			compat_sys_pwritev64
+536	x32	rt_tgsigqueueinfo	compat_sys_rt_tgsigqueueinfo
+537	x32	recvmmsg		compat_sys_recvmmsg_time64
+538	x32	sendmmsg		compat_sys_sendmmsg
+539	x32	process_vm_readv	compat_sys_process_vm_readv
+540	x32	process_vm_writev	compat_sys_process_vm_writev
+541	x32	setsockopt		compat_sys_setsockopt
+542	x32	getsockopt		compat_sys_getsockopt
+543	x32	io_setup		compat_sys_io_setup
+544	x32	io_submit		compat_sys_io_submit
+545	x32	execveat		compat_sys_execveat
+546	x32	preadv2			compat_sys_preadv64v2
+547	x32	pwritev2		compat_sys_pwritev64v2
diff --git a/arch/x86/entry/syscalls/syscalltbl.sh b/arch/x86/entry/syscalls/syscalltbl.sh
index 6106ed3..929bde1 100644
--- a/arch/x86/entry/syscalls/syscalltbl.sh
+++ b/arch/x86/entry/syscalls/syscalltbl.sh
@@ -17,27 +17,15 @@ emit() {
     local nr="$2"
     local entry="$3"
     local compat="$4"
-    local umlentry=""
 
     if [ "$abi" != "I386" -a -n "$compat" ]; then
 	echo "a compat entry ($abi: $compat) for a 64-bit syscall makes no sense" >&2
 	exit 1
     fi
 
-    # For CONFIG_UML, we need to strip the __x64_sys prefix
-    if [ "${entry}" != "${entry#__x64_sys}" ]; then
-	    umlentry="sys${entry#__x64_sys}"
-    fi
-
     if [ -z "$compat" ]; then
-	if [ -n "$entry" -a -z "$umlentry" ]; then
-	    syscall_macro "$abi" "$nr" "$entry"
-	elif [ -n "$umlentry" ]; then # implies -n "$entry"
-	    echo "#ifdef CONFIG_X86"
+	if [ -n "$entry" ]; then
 	    syscall_macro "$abi" "$nr" "$entry"
-	    echo "#else /* CONFIG_UML */"
-	    syscall_macro "$abi" "$nr" "$umlentry"
-	    echo "#endif"
 	fi
     else
 	echo "#ifdef CONFIG_X86_32"
