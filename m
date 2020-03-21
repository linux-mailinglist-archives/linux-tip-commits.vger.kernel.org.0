Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 432CC18E283
	for <lists+linux-tip-commits@lfdr.de>; Sat, 21 Mar 2020 16:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727710AbgCUPbM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 21 Mar 2020 11:31:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38921 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727659AbgCUPap (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 21 Mar 2020 11:30:45 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jFg59-0004zQ-8h; Sat, 21 Mar 2020 16:30:39 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D52D51C22E5;
        Sat, 21 Mar 2020 16:30:33 +0100 (CET)
Date:   Sat, 21 Mar 2020 15:30:33 -0000
From:   "tip-bot2 for Brian Gerst" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/entry/32: Clean up syscall_32.tbl
Cc:     Brian Gerst <brgerst@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200313195144.164260-14-brgerst@gmail.com>
References: <20200313195144.164260-14-brgerst@gmail.com>
MIME-Version: 1.0
Message-ID: <158480463345.28353.8555607497568621163.tip-bot2@tip-bot2>
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

Commit-ID:     a845a6cf1dad16fa86007c86702fb27fec89d38b
Gitweb:        https://git.kernel.org/tip/a845a6cf1dad16fa86007c86702fb27fec89d38b
Author:        Brian Gerst <brgerst@gmail.com>
AuthorDate:    Fri, 13 Mar 2020 15:51:39 -04:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 21 Mar 2020 16:03:23 +01:00

x86/entry/32: Clean up syscall_32.tbl

After removal of the __ia32_ prefix, remove compat entries that are now
identical to the native entry.

Converted with this script and fixing up whitespace:

while read nr abi name entry compat; do
    if [ "${nr:0:1}" = "#" ]; then
        echo $nr $abi $name $entry $compat
        continue
    fi
    if [ "$entry" = "$compat" ]; then
        compat=""
    fi
    echo "$nr	$abi	$name		$entry		$compat"
done

Signed-off-by: Brian Gerst <brgerst@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lkml.kernel.org/r/20200313195144.164260-14-brgerst@gmail.com

---
 arch/x86/entry/syscalls/syscall_32.tbl | 578 ++++++++++++------------
 1 file changed, 289 insertions(+), 289 deletions(-)

diff --git a/arch/x86/entry/syscalls/syscall_32.tbl b/arch/x86/entry/syscalls/syscall_32.tbl
index 390c212..b0712cd 100644
--- a/arch/x86/entry/syscalls/syscall_32.tbl
+++ b/arch/x86/entry/syscalls/syscall_32.tbl
@@ -11,179 +11,179 @@
 #
 # The abi is always "i386" for this file.
 #
-0	i386	restart_syscall		sys_restart_syscall		sys_restart_syscall
-1	i386	exit			sys_exit			sys_exit
-2	i386	fork			sys_fork			sys_fork
-3	i386	read			sys_read			sys_read
-4	i386	write			sys_write			sys_write
+0	i386	restart_syscall		sys_restart_syscall
+1	i386	exit			sys_exit
+2	i386	fork			sys_fork
+3	i386	read			sys_read
+4	i386	write			sys_write
 5	i386	open			sys_open			compat_sys_open
-6	i386	close			sys_close			sys_close
-7	i386	waitpid			sys_waitpid			sys_waitpid
-8	i386	creat			sys_creat			sys_creat
-9	i386	link			sys_link			sys_link
-10	i386	unlink			sys_unlink			sys_unlink
+6	i386	close			sys_close
+7	i386	waitpid			sys_waitpid
+8	i386	creat			sys_creat
+9	i386	link			sys_link
+10	i386	unlink			sys_unlink
 11	i386	execve			sys_execve			compat_sys_execve
-12	i386	chdir			sys_chdir			sys_chdir
-13	i386	time			sys_time32			sys_time32
-14	i386	mknod			sys_mknod			sys_mknod
-15	i386	chmod			sys_chmod			sys_chmod
-16	i386	lchown			sys_lchown16			sys_lchown16
+12	i386	chdir			sys_chdir
+13	i386	time			sys_time32
+14	i386	mknod			sys_mknod
+15	i386	chmod			sys_chmod
+16	i386	lchown			sys_lchown16
 17	i386	break
-18	i386	oldstat			sys_stat			sys_stat
+18	i386	oldstat			sys_stat
 19	i386	lseek			sys_lseek			compat_sys_lseek
-20	i386	getpid			sys_getpid			sys_getpid
+20	i386	getpid			sys_getpid
 21	i386	mount			sys_mount			compat_sys_mount
-22	i386	umount			sys_oldumount			sys_oldumount
-23	i386	setuid			sys_setuid16			sys_setuid16
-24	i386	getuid			sys_getuid16			sys_getuid16
-25	i386	stime			sys_stime32			sys_stime32
+22	i386	umount			sys_oldumount
+23	i386	setuid			sys_setuid16
+24	i386	getuid			sys_getuid16
+25	i386	stime			sys_stime32
 26	i386	ptrace			sys_ptrace			compat_sys_ptrace
-27	i386	alarm			sys_alarm			sys_alarm
-28	i386	oldfstat		sys_fstat			sys_fstat
-29	i386	pause			sys_pause			sys_pause
-30	i386	utime			sys_utime32			sys_utime32
+27	i386	alarm			sys_alarm
+28	i386	oldfstat		sys_fstat
+29	i386	pause			sys_pause
+30	i386	utime			sys_utime32
 31	i386	stty
 32	i386	gtty
-33	i386	access			sys_access			sys_access
-34	i386	nice			sys_nice			sys_nice
+33	i386	access			sys_access
+34	i386	nice			sys_nice
 35	i386	ftime
-36	i386	sync			sys_sync			sys_sync
-37	i386	kill			sys_kill			sys_kill
-38	i386	rename			sys_rename			sys_rename
-39	i386	mkdir			sys_mkdir			sys_mkdir
-40	i386	rmdir			sys_rmdir			sys_rmdir
-41	i386	dup			sys_dup				sys_dup
-42	i386	pipe			sys_pipe			sys_pipe
+36	i386	sync			sys_sync
+37	i386	kill			sys_kill
+38	i386	rename			sys_rename
+39	i386	mkdir			sys_mkdir
+40	i386	rmdir			sys_rmdir
+41	i386	dup			sys_dup
+42	i386	pipe			sys_pipe
 43	i386	times			sys_times			compat_sys_times
 44	i386	prof
-45	i386	brk			sys_brk				sys_brk
-46	i386	setgid			sys_setgid16			sys_setgid16
-47	i386	getgid			sys_getgid16			sys_getgid16
-48	i386	signal			sys_signal			sys_signal
-49	i386	geteuid			sys_geteuid16			sys_geteuid16
-50	i386	getegid			sys_getegid16			sys_getegid16
-51	i386	acct			sys_acct			sys_acct
-52	i386	umount2			sys_umount			sys_umount
+45	i386	brk			sys_brk
+46	i386	setgid			sys_setgid16
+47	i386	getgid			sys_getgid16
+48	i386	signal			sys_signal
+49	i386	geteuid			sys_geteuid16
+50	i386	getegid			sys_getegid16
+51	i386	acct			sys_acct
+52	i386	umount2			sys_umount
 53	i386	lock
 54	i386	ioctl			sys_ioctl			compat_sys_ioctl
 55	i386	fcntl			sys_fcntl			compat_sys_fcntl64
 56	i386	mpx
-57	i386	setpgid			sys_setpgid			sys_setpgid
+57	i386	setpgid			sys_setpgid
 58	i386	ulimit
-59	i386	oldolduname		sys_olduname			sys_olduname
-60	i386	umask			sys_umask			sys_umask
-61	i386	chroot			sys_chroot			sys_chroot
+59	i386	oldolduname		sys_olduname
+60	i386	umask			sys_umask
+61	i386	chroot			sys_chroot
 62	i386	ustat			sys_ustat			compat_sys_ustat
-63	i386	dup2			sys_dup2			sys_dup2
-64	i386	getppid			sys_getppid			sys_getppid
-65	i386	getpgrp			sys_getpgrp			sys_getpgrp
-66	i386	setsid			sys_setsid			sys_setsid
+63	i386	dup2			sys_dup2
+64	i386	getppid			sys_getppid
+65	i386	getpgrp			sys_getpgrp
+66	i386	setsid			sys_setsid
 67	i386	sigaction		sys_sigaction			compat_sys_sigaction
-68	i386	sgetmask		sys_sgetmask			sys_sgetmask
-69	i386	ssetmask		sys_ssetmask			sys_ssetmask
-70	i386	setreuid		sys_setreuid16			sys_setreuid16
-71	i386	setregid		sys_setregid16			sys_setregid16
-72	i386	sigsuspend		sys_sigsuspend			sys_sigsuspend
+68	i386	sgetmask		sys_sgetmask
+69	i386	ssetmask		sys_ssetmask
+70	i386	setreuid		sys_setreuid16
+71	i386	setregid		sys_setregid16
+72	i386	sigsuspend		sys_sigsuspend
 73	i386	sigpending		sys_sigpending			compat_sys_sigpending
-74	i386	sethostname		sys_sethostname			sys_sethostname
+74	i386	sethostname		sys_sethostname
 75	i386	setrlimit		sys_setrlimit			compat_sys_setrlimit
 76	i386	getrlimit		sys_old_getrlimit		compat_sys_old_getrlimit
 77	i386	getrusage		sys_getrusage			compat_sys_getrusage
 78	i386	gettimeofday		sys_gettimeofday		compat_sys_gettimeofday
 79	i386	settimeofday		sys_settimeofday		compat_sys_settimeofday
-80	i386	getgroups		sys_getgroups16			sys_getgroups16
-81	i386	setgroups		sys_setgroups16			sys_setgroups16
+80	i386	getgroups		sys_getgroups16
+81	i386	setgroups		sys_setgroups16
 82	i386	select			sys_old_select			compat_sys_old_select
-83	i386	symlink			sys_symlink			sys_symlink
-84	i386	oldlstat		sys_lstat			sys_lstat
-85	i386	readlink		sys_readlink			sys_readlink
-86	i386	uselib			sys_uselib			sys_uselib
-87	i386	swapon			sys_swapon			sys_swapon
-88	i386	reboot			sys_reboot			sys_reboot
+83	i386	symlink			sys_symlink
+84	i386	oldlstat		sys_lstat
+85	i386	readlink		sys_readlink
+86	i386	uselib			sys_uselib
+87	i386	swapon			sys_swapon
+88	i386	reboot			sys_reboot
 89	i386	readdir			sys_old_readdir			compat_sys_old_readdir
 90	i386	mmap			sys_old_mmap			compat_sys_x86_mmap
-91	i386	munmap			sys_munmap			sys_munmap
+91	i386	munmap			sys_munmap
 92	i386	truncate		sys_truncate			compat_sys_truncate
 93	i386	ftruncate		sys_ftruncate			compat_sys_ftruncate
-94	i386	fchmod			sys_fchmod			sys_fchmod
-95	i386	fchown			sys_fchown16			sys_fchown16
-96	i386	getpriority		sys_getpriority			sys_getpriority
-97	i386	setpriority		sys_setpriority			sys_setpriority
+94	i386	fchmod			sys_fchmod
+95	i386	fchown			sys_fchown16
+96	i386	getpriority		sys_getpriority
+97	i386	setpriority		sys_setpriority
 98	i386	profil
 99	i386	statfs			sys_statfs			compat_sys_statfs
 100	i386	fstatfs			sys_fstatfs			compat_sys_fstatfs
-101	i386	ioperm			sys_ioperm			sys_ioperm
+101	i386	ioperm			sys_ioperm
 102	i386	socketcall		sys_socketcall			compat_sys_socketcall
-103	i386	syslog			sys_syslog			sys_syslog
+103	i386	syslog			sys_syslog
 104	i386	setitimer		sys_setitimer			compat_sys_setitimer
 105	i386	getitimer		sys_getitimer			compat_sys_getitimer
 106	i386	stat			sys_newstat			compat_sys_newstat
 107	i386	lstat			sys_newlstat			compat_sys_newlstat
 108	i386	fstat			sys_newfstat			compat_sys_newfstat
-109	i386	olduname		sys_uname			sys_uname
-110	i386	iopl			sys_iopl			sys_iopl
-111	i386	vhangup			sys_vhangup			sys_vhangup
+109	i386	olduname		sys_uname
+110	i386	iopl			sys_iopl
+111	i386	vhangup			sys_vhangup
 112	i386	idle
 113	i386	vm86old			sys_vm86old			sys_ni_syscall
 114	i386	wait4			sys_wait4			compat_sys_wait4
-115	i386	swapoff			sys_swapoff			sys_swapoff
+115	i386	swapoff			sys_swapoff
 116	i386	sysinfo			sys_sysinfo			compat_sys_sysinfo
 117	i386	ipc			sys_ipc				compat_sys_ipc
-118	i386	fsync			sys_fsync			sys_fsync
+118	i386	fsync			sys_fsync
 119	i386	sigreturn		sys_sigreturn			compat_sys_sigreturn
 120	i386	clone			sys_clone			compat_sys_x86_clone
-121	i386	setdomainname		sys_setdomainname		sys_setdomainname
-122	i386	uname			sys_newuname			sys_newuname
-123	i386	modify_ldt		sys_modify_ldt			sys_modify_ldt
-124	i386	adjtimex		sys_adjtimex_time32			sys_adjtimex_time32
-125	i386	mprotect		sys_mprotect			sys_mprotect
+121	i386	setdomainname		sys_setdomainname
+122	i386	uname			sys_newuname
+123	i386	modify_ldt		sys_modify_ldt
+124	i386	adjtimex		sys_adjtimex_time32
+125	i386	mprotect		sys_mprotect
 126	i386	sigprocmask		sys_sigprocmask			compat_sys_sigprocmask
 127	i386	create_module
-128	i386	init_module		sys_init_module			sys_init_module
-129	i386	delete_module		sys_delete_module		sys_delete_module
+128	i386	init_module		sys_init_module
+129	i386	delete_module		sys_delete_module
 130	i386	get_kernel_syms
 131	i386	quotactl		sys_quotactl			compat_sys_quotactl32
-132	i386	getpgid			sys_getpgid			sys_getpgid
-133	i386	fchdir			sys_fchdir			sys_fchdir
-134	i386	bdflush			sys_bdflush			sys_bdflush
-135	i386	sysfs			sys_sysfs			sys_sysfs
-136	i386	personality		sys_personality			sys_personality
+132	i386	getpgid			sys_getpgid
+133	i386	fchdir			sys_fchdir
+134	i386	bdflush			sys_bdflush
+135	i386	sysfs			sys_sysfs
+136	i386	personality		sys_personality
 137	i386	afs_syscall
-138	i386	setfsuid		sys_setfsuid16			sys_setfsuid16
-139	i386	setfsgid		sys_setfsgid16			sys_setfsgid16
-140	i386	_llseek			sys_llseek			sys_llseek
+138	i386	setfsuid		sys_setfsuid16
+139	i386	setfsgid		sys_setfsgid16
+140	i386	_llseek			sys_llseek
 141	i386	getdents		sys_getdents			compat_sys_getdents
 142	i386	_newselect		sys_select			compat_sys_select
-143	i386	flock			sys_flock			sys_flock
-144	i386	msync			sys_msync			sys_msync
+143	i386	flock			sys_flock
+144	i386	msync			sys_msync
 145	i386	readv			sys_readv			compat_sys_readv
 146	i386	writev			sys_writev			compat_sys_writev
-147	i386	getsid			sys_getsid			sys_getsid
-148	i386	fdatasync		sys_fdatasync			sys_fdatasync
+147	i386	getsid			sys_getsid
+148	i386	fdatasync		sys_fdatasync
 149	i386	_sysctl			sys_sysctl			compat_sys_sysctl
-150	i386	mlock			sys_mlock			sys_mlock
-151	i386	munlock			sys_munlock			sys_munlock
-152	i386	mlockall		sys_mlockall			sys_mlockall
-153	i386	munlockall		sys_munlockall			sys_munlockall
-154	i386	sched_setparam		sys_sched_setparam		sys_sched_setparam
-155	i386	sched_getparam		sys_sched_getparam		sys_sched_getparam
-156	i386	sched_setscheduler	sys_sched_setscheduler		sys_sched_setscheduler
-157	i386	sched_getscheduler	sys_sched_getscheduler		sys_sched_getscheduler
-158	i386	sched_yield		sys_sched_yield			sys_sched_yield
-159	i386	sched_get_priority_max	sys_sched_get_priority_max	sys_sched_get_priority_max
-160	i386	sched_get_priority_min	sys_sched_get_priority_min	sys_sched_get_priority_min
-161	i386	sched_rr_get_interval	sys_sched_rr_get_interval_time32	sys_sched_rr_get_interval_time32
-162	i386	nanosleep		sys_nanosleep_time32		sys_nanosleep_time32
-163	i386	mremap			sys_mremap			sys_mremap
-164	i386	setresuid		sys_setresuid16			sys_setresuid16
-165	i386	getresuid		sys_getresuid16			sys_getresuid16
+150	i386	mlock			sys_mlock
+151	i386	munlock			sys_munlock
+152	i386	mlockall		sys_mlockall
+153	i386	munlockall		sys_munlockall
+154	i386	sched_setparam		sys_sched_setparam
+155	i386	sched_getparam		sys_sched_getparam
+156	i386	sched_setscheduler	sys_sched_setscheduler
+157	i386	sched_getscheduler	sys_sched_getscheduler
+158	i386	sched_yield		sys_sched_yield
+159	i386	sched_get_priority_max	sys_sched_get_priority_max
+160	i386	sched_get_priority_min	sys_sched_get_priority_min
+161	i386	sched_rr_get_interval	sys_sched_rr_get_interval_time32
+162	i386	nanosleep		sys_nanosleep_time32
+163	i386	mremap			sys_mremap
+164	i386	setresuid		sys_setresuid16
+165	i386	getresuid		sys_getresuid16
 166	i386	vm86			sys_vm86			sys_ni_syscall
 167	i386	query_module
-168	i386	poll			sys_poll			sys_poll
+168	i386	poll			sys_poll
 169	i386	nfsservctl
-170	i386	setresgid		sys_setresgid16			sys_setresgid16
-171	i386	getresgid		sys_getresgid16			sys_getresgid16
-172	i386	prctl			sys_prctl			sys_prctl
+170	i386	setresgid		sys_setresgid16
+171	i386	getresgid		sys_getresgid16
+172	i386	prctl			sys_prctl
 173	i386	rt_sigreturn		sys_rt_sigreturn		compat_sys_rt_sigreturn
 174	i386	rt_sigaction		sys_rt_sigaction		compat_sys_rt_sigaction
 175	i386	rt_sigprocmask		sys_rt_sigprocmask		compat_sys_rt_sigprocmask
@@ -193,252 +193,252 @@
 179	i386	rt_sigsuspend		sys_rt_sigsuspend		compat_sys_rt_sigsuspend
 180	i386	pread64			sys_pread64			compat_sys_x86_pread
 181	i386	pwrite64		sys_pwrite64			compat_sys_x86_pwrite
-182	i386	chown			sys_chown16			sys_chown16
-183	i386	getcwd			sys_getcwd			sys_getcwd
-184	i386	capget			sys_capget			sys_capget
-185	i386	capset			sys_capset			sys_capset
+182	i386	chown			sys_chown16
+183	i386	getcwd			sys_getcwd
+184	i386	capget			sys_capget
+185	i386	capset			sys_capset
 186	i386	sigaltstack		sys_sigaltstack			compat_sys_sigaltstack
 187	i386	sendfile		sys_sendfile			compat_sys_sendfile
 188	i386	getpmsg
 189	i386	putpmsg
-190	i386	vfork			sys_vfork			sys_vfork
+190	i386	vfork			sys_vfork
 191	i386	ugetrlimit		sys_getrlimit			compat_sys_getrlimit
-192	i386	mmap2			sys_mmap_pgoff			sys_mmap_pgoff
+192	i386	mmap2			sys_mmap_pgoff
 193	i386	truncate64		sys_truncate64			compat_sys_x86_truncate64
 194	i386	ftruncate64		sys_ftruncate64			compat_sys_x86_ftruncate64
 195	i386	stat64			sys_stat64			compat_sys_x86_stat64
 196	i386	lstat64			sys_lstat64			compat_sys_x86_lstat64
 197	i386	fstat64			sys_fstat64			compat_sys_x86_fstat64
-198	i386	lchown32		sys_lchown			sys_lchown
-199	i386	getuid32		sys_getuid			sys_getuid
-200	i386	getgid32		sys_getgid			sys_getgid
-201	i386	geteuid32		sys_geteuid			sys_geteuid
-202	i386	getegid32		sys_getegid			sys_getegid
-203	i386	setreuid32		sys_setreuid			sys_setreuid
-204	i386	setregid32		sys_setregid			sys_setregid
-205	i386	getgroups32		sys_getgroups			sys_getgroups
-206	i386	setgroups32		sys_setgroups			sys_setgroups
-207	i386	fchown32		sys_fchown			sys_fchown
-208	i386	setresuid32		sys_setresuid			sys_setresuid
-209	i386	getresuid32		sys_getresuid			sys_getresuid
-210	i386	setresgid32		sys_setresgid			sys_setresgid
-211	i386	getresgid32		sys_getresgid			sys_getresgid
-212	i386	chown32			sys_chown			sys_chown
-213	i386	setuid32		sys_setuid			sys_setuid
-214	i386	setgid32		sys_setgid			sys_setgid
-215	i386	setfsuid32		sys_setfsuid			sys_setfsuid
-216	i386	setfsgid32		sys_setfsgid			sys_setfsgid
-217	i386	pivot_root		sys_pivot_root			sys_pivot_root
-218	i386	mincore			sys_mincore			sys_mincore
-219	i386	madvise			sys_madvise			sys_madvise
-220	i386	getdents64		sys_getdents64			sys_getdents64
+198	i386	lchown32		sys_lchown
+199	i386	getuid32		sys_getuid
+200	i386	getgid32		sys_getgid
+201	i386	geteuid32		sys_geteuid
+202	i386	getegid32		sys_getegid
+203	i386	setreuid32		sys_setreuid
+204	i386	setregid32		sys_setregid
+205	i386	getgroups32		sys_getgroups
+206	i386	setgroups32		sys_setgroups
+207	i386	fchown32		sys_fchown
+208	i386	setresuid32		sys_setresuid
+209	i386	getresuid32		sys_getresuid
+210	i386	setresgid32		sys_setresgid
+211	i386	getresgid32		sys_getresgid
+212	i386	chown32			sys_chown
+213	i386	setuid32		sys_setuid
+214	i386	setgid32		sys_setgid
+215	i386	setfsuid32		sys_setfsuid
+216	i386	setfsgid32		sys_setfsgid
+217	i386	pivot_root		sys_pivot_root
+218	i386	mincore			sys_mincore
+219	i386	madvise			sys_madvise
+220	i386	getdents64		sys_getdents64
 221	i386	fcntl64			sys_fcntl64			compat_sys_fcntl64
 # 222 is unused
 # 223 is unused
-224	i386	gettid			sys_gettid			sys_gettid
+224	i386	gettid			sys_gettid
 225	i386	readahead		sys_readahead			compat_sys_x86_readahead
-226	i386	setxattr		sys_setxattr			sys_setxattr
-227	i386	lsetxattr		sys_lsetxattr			sys_lsetxattr
-228	i386	fsetxattr		sys_fsetxattr			sys_fsetxattr
-229	i386	getxattr		sys_getxattr			sys_getxattr
-230	i386	lgetxattr		sys_lgetxattr			sys_lgetxattr
-231	i386	fgetxattr		sys_fgetxattr			sys_fgetxattr
-232	i386	listxattr		sys_listxattr			sys_listxattr
-233	i386	llistxattr		sys_llistxattr			sys_llistxattr
-234	i386	flistxattr		sys_flistxattr			sys_flistxattr
-235	i386	removexattr		sys_removexattr			sys_removexattr
-236	i386	lremovexattr		sys_lremovexattr		sys_lremovexattr
-237	i386	fremovexattr		sys_fremovexattr		sys_fremovexattr
-238	i386	tkill			sys_tkill			sys_tkill
-239	i386	sendfile64		sys_sendfile64			sys_sendfile64
-240	i386	futex			sys_futex_time32		sys_futex_time32
+226	i386	setxattr		sys_setxattr
+227	i386	lsetxattr		sys_lsetxattr
+228	i386	fsetxattr		sys_fsetxattr
+229	i386	getxattr		sys_getxattr
+230	i386	lgetxattr		sys_lgetxattr
+231	i386	fgetxattr		sys_fgetxattr
+232	i386	listxattr		sys_listxattr
+233	i386	llistxattr		sys_llistxattr
+234	i386	flistxattr		sys_flistxattr
+235	i386	removexattr		sys_removexattr
+236	i386	lremovexattr		sys_lremovexattr
+237	i386	fremovexattr		sys_fremovexattr
+238	i386	tkill			sys_tkill
+239	i386	sendfile64		sys_sendfile64
+240	i386	futex			sys_futex_time32
 241	i386	sched_setaffinity	sys_sched_setaffinity		compat_sys_sched_setaffinity
 242	i386	sched_getaffinity	sys_sched_getaffinity		compat_sys_sched_getaffinity
-243	i386	set_thread_area		sys_set_thread_area		sys_set_thread_area
-244	i386	get_thread_area		sys_get_thread_area		sys_get_thread_area
+243	i386	set_thread_area		sys_set_thread_area
+244	i386	get_thread_area		sys_get_thread_area
 245	i386	io_setup		sys_io_setup			compat_sys_io_setup
-246	i386	io_destroy		sys_io_destroy			sys_io_destroy
-247	i386	io_getevents		sys_io_getevents_time32		sys_io_getevents_time32
+246	i386	io_destroy		sys_io_destroy
+247	i386	io_getevents		sys_io_getevents_time32
 248	i386	io_submit		sys_io_submit			compat_sys_io_submit
-249	i386	io_cancel		sys_io_cancel			sys_io_cancel
+249	i386	io_cancel		sys_io_cancel
 250	i386	fadvise64		sys_fadvise64			compat_sys_x86_fadvise64
 # 251 is available for reuse (was briefly sys_set_zone_reclaim)
-252	i386	exit_group		sys_exit_group			sys_exit_group
+252	i386	exit_group		sys_exit_group
 253	i386	lookup_dcookie		sys_lookup_dcookie		compat_sys_lookup_dcookie
-254	i386	epoll_create		sys_epoll_create		sys_epoll_create
-255	i386	epoll_ctl		sys_epoll_ctl			sys_epoll_ctl
-256	i386	epoll_wait		sys_epoll_wait			sys_epoll_wait
-257	i386	remap_file_pages	sys_remap_file_pages		sys_remap_file_pages
-258	i386	set_tid_address		sys_set_tid_address		sys_set_tid_address
+254	i386	epoll_create		sys_epoll_create
+255	i386	epoll_ctl		sys_epoll_ctl
+256	i386	epoll_wait		sys_epoll_wait
+257	i386	remap_file_pages	sys_remap_file_pages
+258	i386	set_tid_address		sys_set_tid_address
 259	i386	timer_create		sys_timer_create		compat_sys_timer_create
-260	i386	timer_settime		sys_timer_settime32		sys_timer_settime32
-261	i386	timer_gettime		sys_timer_gettime32		sys_timer_gettime32
-262	i386	timer_getoverrun	sys_timer_getoverrun		sys_timer_getoverrun
-263	i386	timer_delete		sys_timer_delete		sys_timer_delete
-264	i386	clock_settime		sys_clock_settime32		sys_clock_settime32
-265	i386	clock_gettime		sys_clock_gettime32		sys_clock_gettime32
-266	i386	clock_getres		sys_clock_getres_time32		sys_clock_getres_time32
-267	i386	clock_nanosleep		sys_clock_nanosleep_time32	sys_clock_nanosleep_time32
+260	i386	timer_settime		sys_timer_settime32
+261	i386	timer_gettime		sys_timer_gettime32
+262	i386	timer_getoverrun	sys_timer_getoverrun
+263	i386	timer_delete		sys_timer_delete
+264	i386	clock_settime		sys_clock_settime32
+265	i386	clock_gettime		sys_clock_gettime32
+266	i386	clock_getres		sys_clock_getres_time32
+267	i386	clock_nanosleep		sys_clock_nanosleep_time32
 268	i386	statfs64		sys_statfs64			compat_sys_statfs64
 269	i386	fstatfs64		sys_fstatfs64			compat_sys_fstatfs64
-270	i386	tgkill			sys_tgkill			sys_tgkill
-271	i386	utimes			sys_utimes_time32		sys_utimes_time32
+270	i386	tgkill			sys_tgkill
+271	i386	utimes			sys_utimes_time32
 272	i386	fadvise64_64		sys_fadvise64_64		compat_sys_x86_fadvise64_64
 273	i386	vserver
-274	i386	mbind			sys_mbind			sys_mbind
+274	i386	mbind			sys_mbind
 275	i386	get_mempolicy		sys_get_mempolicy		compat_sys_get_mempolicy
-276	i386	set_mempolicy		sys_set_mempolicy		sys_set_mempolicy
+276	i386	set_mempolicy		sys_set_mempolicy
 277	i386	mq_open			sys_mq_open			compat_sys_mq_open
-278	i386	mq_unlink		sys_mq_unlink			sys_mq_unlink
-279	i386	mq_timedsend		sys_mq_timedsend_time32		sys_mq_timedsend_time32
-280	i386	mq_timedreceive		sys_mq_timedreceive_time32	sys_mq_timedreceive_time32
+278	i386	mq_unlink		sys_mq_unlink
+279	i386	mq_timedsend		sys_mq_timedsend_time32
+280	i386	mq_timedreceive		sys_mq_timedreceive_time32
 281	i386	mq_notify		sys_mq_notify			compat_sys_mq_notify
 282	i386	mq_getsetattr		sys_mq_getsetattr		compat_sys_mq_getsetattr
 283	i386	kexec_load		sys_kexec_load			compat_sys_kexec_load
 284	i386	waitid			sys_waitid			compat_sys_waitid
 # 285 sys_setaltroot
-286	i386	add_key			sys_add_key			sys_add_key
-287	i386	request_key		sys_request_key			sys_request_key
+286	i386	add_key			sys_add_key
+287	i386	request_key		sys_request_key
 288	i386	keyctl			sys_keyctl			compat_sys_keyctl
-289	i386	ioprio_set		sys_ioprio_set			sys_ioprio_set
-290	i386	ioprio_get		sys_ioprio_get			sys_ioprio_get
-291	i386	inotify_init		sys_inotify_init		sys_inotify_init
-292	i386	inotify_add_watch	sys_inotify_add_watch		sys_inotify_add_watch
-293	i386	inotify_rm_watch	sys_inotify_rm_watch		sys_inotify_rm_watch
-294	i386	migrate_pages		sys_migrate_pages		sys_migrate_pages
+289	i386	ioprio_set		sys_ioprio_set
+290	i386	ioprio_get		sys_ioprio_get
+291	i386	inotify_init		sys_inotify_init
+292	i386	inotify_add_watch	sys_inotify_add_watch
+293	i386	inotify_rm_watch	sys_inotify_rm_watch
+294	i386	migrate_pages		sys_migrate_pages
 295	i386	openat			sys_openat			compat_sys_openat
-296	i386	mkdirat			sys_mkdirat			sys_mkdirat
-297	i386	mknodat			sys_mknodat			sys_mknodat
-298	i386	fchownat		sys_fchownat			sys_fchownat
-299	i386	futimesat		sys_futimesat_time32		sys_futimesat_time32
+296	i386	mkdirat			sys_mkdirat
+297	i386	mknodat			sys_mknodat
+298	i386	fchownat		sys_fchownat
+299	i386	futimesat		sys_futimesat_time32
 300	i386	fstatat64		sys_fstatat64			compat_sys_x86_fstatat
-301	i386	unlinkat		sys_unlinkat			sys_unlinkat
-302	i386	renameat		sys_renameat			sys_renameat
-303	i386	linkat			sys_linkat			sys_linkat
-304	i386	symlinkat		sys_symlinkat			sys_symlinkat
-305	i386	readlinkat		sys_readlinkat			sys_readlinkat
-306	i386	fchmodat		sys_fchmodat			sys_fchmodat
-307	i386	faccessat		sys_faccessat			sys_faccessat
+301	i386	unlinkat		sys_unlinkat
+302	i386	renameat		sys_renameat
+303	i386	linkat			sys_linkat
+304	i386	symlinkat		sys_symlinkat
+305	i386	readlinkat		sys_readlinkat
+306	i386	fchmodat		sys_fchmodat
+307	i386	faccessat		sys_faccessat
 308	i386	pselect6		sys_pselect6_time32		compat_sys_pselect6_time32
 309	i386	ppoll			sys_ppoll_time32		compat_sys_ppoll_time32
-310	i386	unshare			sys_unshare			sys_unshare
+310	i386	unshare			sys_unshare
 311	i386	set_robust_list		sys_set_robust_list		compat_sys_set_robust_list
 312	i386	get_robust_list		sys_get_robust_list		compat_sys_get_robust_list
-313	i386	splice			sys_splice			sys_splice
+313	i386	splice			sys_splice
 314	i386	sync_file_range		sys_sync_file_range		compat_sys_x86_sync_file_range
-315	i386	tee			sys_tee				sys_tee
+315	i386	tee			sys_tee
 316	i386	vmsplice		sys_vmsplice			compat_sys_vmsplice
 317	i386	move_pages		sys_move_pages			compat_sys_move_pages
-318	i386	getcpu			sys_getcpu			sys_getcpu
-319	i386	epoll_pwait		sys_epoll_pwait			sys_epoll_pwait
-320	i386	utimensat		sys_utimensat_time32		sys_utimensat_time32
+318	i386	getcpu			sys_getcpu
+319	i386	epoll_pwait		sys_epoll_pwait
+320	i386	utimensat		sys_utimensat_time32
 321	i386	signalfd		sys_signalfd			compat_sys_signalfd
-322	i386	timerfd_create		sys_timerfd_create		sys_timerfd_create
-323	i386	eventfd			sys_eventfd			sys_eventfd
+322	i386	timerfd_create		sys_timerfd_create
+323	i386	eventfd			sys_eventfd
 324	i386	fallocate		sys_fallocate			compat_sys_x86_fallocate
-325	i386	timerfd_settime		sys_timerfd_settime32		sys_timerfd_settime32
-326	i386	timerfd_gettime		sys_timerfd_gettime32		sys_timerfd_gettime32
+325	i386	timerfd_settime		sys_timerfd_settime32
+326	i386	timerfd_gettime		sys_timerfd_gettime32
 327	i386	signalfd4		sys_signalfd4			compat_sys_signalfd4
-328	i386	eventfd2		sys_eventfd2			sys_eventfd2
-329	i386	epoll_create1		sys_epoll_create1		sys_epoll_create1
-330	i386	dup3			sys_dup3			sys_dup3
-331	i386	pipe2			sys_pipe2			sys_pipe2
-332	i386	inotify_init1		sys_inotify_init1		sys_inotify_init1
+328	i386	eventfd2		sys_eventfd2
+329	i386	epoll_create1		sys_epoll_create1
+330	i386	dup3			sys_dup3
+331	i386	pipe2			sys_pipe2
+332	i386	inotify_init1		sys_inotify_init1
 333	i386	preadv			sys_preadv			compat_sys_preadv
 334	i386	pwritev			sys_pwritev			compat_sys_pwritev
 335	i386	rt_tgsigqueueinfo	sys_rt_tgsigqueueinfo		compat_sys_rt_tgsigqueueinfo
-336	i386	perf_event_open		sys_perf_event_open		sys_perf_event_open
+336	i386	perf_event_open		sys_perf_event_open
 337	i386	recvmmsg		sys_recvmmsg_time32		compat_sys_recvmmsg_time32
-338	i386	fanotify_init		sys_fanotify_init		sys_fanotify_init
+338	i386	fanotify_init		sys_fanotify_init
 339	i386	fanotify_mark		sys_fanotify_mark		compat_sys_fanotify_mark
-340	i386	prlimit64		sys_prlimit64			sys_prlimit64
-341	i386	name_to_handle_at	sys_name_to_handle_at		sys_name_to_handle_at
+340	i386	prlimit64		sys_prlimit64
+341	i386	name_to_handle_at	sys_name_to_handle_at
 342	i386	open_by_handle_at	sys_open_by_handle_at		compat_sys_open_by_handle_at
-343	i386	clock_adjtime		sys_clock_adjtime32		sys_clock_adjtime32
-344	i386	syncfs			sys_syncfs			sys_syncfs
+343	i386	clock_adjtime		sys_clock_adjtime32
+344	i386	syncfs			sys_syncfs
 345	i386	sendmmsg		sys_sendmmsg			compat_sys_sendmmsg
-346	i386	setns			sys_setns			sys_setns
+346	i386	setns			sys_setns
 347	i386	process_vm_readv	sys_process_vm_readv		compat_sys_process_vm_readv
 348	i386	process_vm_writev	sys_process_vm_writev		compat_sys_process_vm_writev
-349	i386	kcmp			sys_kcmp			sys_kcmp
-350	i386	finit_module		sys_finit_module		sys_finit_module
-351	i386	sched_setattr		sys_sched_setattr		sys_sched_setattr
-352	i386	sched_getattr		sys_sched_getattr		sys_sched_getattr
-353	i386	renameat2		sys_renameat2			sys_renameat2
-354	i386	seccomp			sys_seccomp			sys_seccomp
-355	i386	getrandom		sys_getrandom			sys_getrandom
-356	i386	memfd_create		sys_memfd_create		sys_memfd_create
-357	i386	bpf			sys_bpf				sys_bpf
+349	i386	kcmp			sys_kcmp
+350	i386	finit_module		sys_finit_module
+351	i386	sched_setattr		sys_sched_setattr
+352	i386	sched_getattr		sys_sched_getattr
+353	i386	renameat2		sys_renameat2
+354	i386	seccomp			sys_seccomp
+355	i386	getrandom		sys_getrandom
+356	i386	memfd_create		sys_memfd_create
+357	i386	bpf			sys_bpf
 358	i386	execveat		sys_execveat			compat_sys_execveat
-359	i386	socket			sys_socket			sys_socket
-360	i386	socketpair		sys_socketpair			sys_socketpair
-361	i386	bind			sys_bind			sys_bind
-362	i386	connect			sys_connect			sys_connect
-363	i386	listen			sys_listen			sys_listen
-364	i386	accept4			sys_accept4			sys_accept4
+359	i386	socket			sys_socket
+360	i386	socketpair		sys_socketpair
+361	i386	bind			sys_bind
+362	i386	connect			sys_connect
+363	i386	listen			sys_listen
+364	i386	accept4			sys_accept4
 365	i386	getsockopt		sys_getsockopt			compat_sys_getsockopt
 366	i386	setsockopt		sys_setsockopt			compat_sys_setsockopt
-367	i386	getsockname		sys_getsockname			sys_getsockname
-368	i386	getpeername		sys_getpeername			sys_getpeername
-369	i386	sendto			sys_sendto			sys_sendto
+367	i386	getsockname		sys_getsockname
+368	i386	getpeername		sys_getpeername
+369	i386	sendto			sys_sendto
 370	i386	sendmsg			sys_sendmsg			compat_sys_sendmsg
 371	i386	recvfrom		sys_recvfrom			compat_sys_recvfrom
 372	i386	recvmsg			sys_recvmsg			compat_sys_recvmsg
-373	i386	shutdown		sys_shutdown			sys_shutdown
-374	i386	userfaultfd		sys_userfaultfd			sys_userfaultfd
-375	i386	membarrier		sys_membarrier			sys_membarrier
-376	i386	mlock2			sys_mlock2			sys_mlock2
-377	i386	copy_file_range		sys_copy_file_range		sys_copy_file_range
+373	i386	shutdown		sys_shutdown
+374	i386	userfaultfd		sys_userfaultfd
+375	i386	membarrier		sys_membarrier
+376	i386	mlock2			sys_mlock2
+377	i386	copy_file_range		sys_copy_file_range
 378	i386	preadv2			sys_preadv2			compat_sys_preadv2
 379	i386	pwritev2		sys_pwritev2			compat_sys_pwritev2
-380	i386	pkey_mprotect		sys_pkey_mprotect		sys_pkey_mprotect
-381	i386	pkey_alloc		sys_pkey_alloc			sys_pkey_alloc
-382	i386	pkey_free		sys_pkey_free			sys_pkey_free
-383	i386	statx			sys_statx			sys_statx
+380	i386	pkey_mprotect		sys_pkey_mprotect
+381	i386	pkey_alloc		sys_pkey_alloc
+382	i386	pkey_free		sys_pkey_free
+383	i386	statx			sys_statx
 384	i386	arch_prctl		sys_arch_prctl			compat_sys_arch_prctl
 385	i386	io_pgetevents		sys_io_pgetevents_time32	compat_sys_io_pgetevents
-386	i386	rseq			sys_rseq			sys_rseq
-393	i386	semget			sys_semget    			sys_semget
+386	i386	rseq			sys_rseq
+393	i386	semget			sys_semget
 394	i386	semctl			sys_semctl    			compat_sys_semctl
-395	i386	shmget			sys_shmget    			sys_shmget
+395	i386	shmget			sys_shmget
 396	i386	shmctl			sys_shmctl    			compat_sys_shmctl
 397	i386	shmat			sys_shmat     			compat_sys_shmat
-398	i386	shmdt			sys_shmdt     			sys_shmdt
-399	i386	msgget			sys_msgget    			sys_msgget
+398	i386	shmdt			sys_shmdt
+399	i386	msgget			sys_msgget
 400	i386	msgsnd			sys_msgsnd    			compat_sys_msgsnd
 401	i386	msgrcv			sys_msgrcv    			compat_sys_msgrcv
 402	i386	msgctl			sys_msgctl    			compat_sys_msgctl
-403	i386	clock_gettime64		sys_clock_gettime		sys_clock_gettime
-404	i386	clock_settime64		sys_clock_settime		sys_clock_settime
-405	i386	clock_adjtime64		sys_clock_adjtime		sys_clock_adjtime
-406	i386	clock_getres_time64	sys_clock_getres		sys_clock_getres
-407	i386	clock_nanosleep_time64	sys_clock_nanosleep		sys_clock_nanosleep
-408	i386	timer_gettime64		sys_timer_gettime		sys_timer_gettime
-409	i386	timer_settime64		sys_timer_settime		sys_timer_settime
-410	i386	timerfd_gettime64	sys_timerfd_gettime		sys_timerfd_gettime
-411	i386	timerfd_settime64	sys_timerfd_settime		sys_timerfd_settime
-412	i386	utimensat_time64	sys_utimensat			sys_utimensat
+403	i386	clock_gettime64		sys_clock_gettime
+404	i386	clock_settime64		sys_clock_settime
+405	i386	clock_adjtime64		sys_clock_adjtime
+406	i386	clock_getres_time64	sys_clock_getres
+407	i386	clock_nanosleep_time64	sys_clock_nanosleep
+408	i386	timer_gettime64		sys_timer_gettime
+409	i386	timer_settime64		sys_timer_settime
+410	i386	timerfd_gettime64	sys_timerfd_gettime
+411	i386	timerfd_settime64	sys_timerfd_settime
+412	i386	utimensat_time64	sys_utimensat
 413	i386	pselect6_time64		sys_pselect6			compat_sys_pselect6_time64
 414	i386	ppoll_time64		sys_ppoll			compat_sys_ppoll_time64
-416	i386	io_pgetevents_time64	sys_io_pgetevents		sys_io_pgetevents
+416	i386	io_pgetevents_time64	sys_io_pgetevents
 417	i386	recvmmsg_time64		sys_recvmmsg			compat_sys_recvmmsg_time64
-418	i386	mq_timedsend_time64	sys_mq_timedsend		sys_mq_timedsend
-419	i386	mq_timedreceive_time64	sys_mq_timedreceive		sys_mq_timedreceive
-420	i386	semtimedop_time64	sys_semtimedop			sys_semtimedop
+418	i386	mq_timedsend_time64	sys_mq_timedsend
+419	i386	mq_timedreceive_time64	sys_mq_timedreceive
+420	i386	semtimedop_time64	sys_semtimedop
 421	i386	rt_sigtimedwait_time64	sys_rt_sigtimedwait		compat_sys_rt_sigtimedwait_time64
-422	i386	futex_time64		sys_futex			sys_futex
-423	i386	sched_rr_get_interval_time64	sys_sched_rr_get_interval	sys_sched_rr_get_interval
-424	i386	pidfd_send_signal	sys_pidfd_send_signal		sys_pidfd_send_signal
-425	i386	io_uring_setup		sys_io_uring_setup		sys_io_uring_setup
-426	i386	io_uring_enter		sys_io_uring_enter		sys_io_uring_enter
-427	i386	io_uring_register	sys_io_uring_register		sys_io_uring_register
-428	i386	open_tree		sys_open_tree			sys_open_tree
-429	i386	move_mount		sys_move_mount			sys_move_mount
-430	i386	fsopen			sys_fsopen			sys_fsopen
-431	i386	fsconfig		sys_fsconfig			sys_fsconfig
-432	i386	fsmount			sys_fsmount			sys_fsmount
-433	i386	fspick			sys_fspick			sys_fspick
-434	i386	pidfd_open		sys_pidfd_open			sys_pidfd_open
-435	i386	clone3			sys_clone3			sys_clone3
-437	i386	openat2			sys_openat2			sys_openat2
-438	i386	pidfd_getfd		sys_pidfd_getfd			sys_pidfd_getfd
+422	i386	futex_time64		sys_futex
+423	i386	sched_rr_get_interval_time64	sys_sched_rr_get_interval
+424	i386	pidfd_send_signal	sys_pidfd_send_signal
+425	i386	io_uring_setup		sys_io_uring_setup
+426	i386	io_uring_enter		sys_io_uring_enter
+427	i386	io_uring_register	sys_io_uring_register
+428	i386	open_tree		sys_open_tree
+429	i386	move_mount		sys_move_mount
+430	i386	fsopen			sys_fsopen
+431	i386	fsconfig		sys_fsconfig
+432	i386	fsmount			sys_fsmount
+433	i386	fspick			sys_fspick
+434	i386	pidfd_open		sys_pidfd_open
+435	i386	clone3			sys_clone3
+437	i386	openat2			sys_openat2
+438	i386	pidfd_getfd		sys_pidfd_getfd
