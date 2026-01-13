Return-Path: <linux-tip-commits+bounces-7950-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BD57D192D5
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 14:52:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5C20330ACE15
	for <lists+linux-tip-commits@lfdr.de>; Tue, 13 Jan 2026 13:47:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F41A3921E9;
	Tue, 13 Jan 2026 13:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qEYbr4Ie";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="DMZckDsi"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0BC33921E7;
	Tue, 13 Jan 2026 13:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768312060; cv=none; b=C0Z5EKALnn/xjhNejJ9svNI7DmsrAUnqugNgTmqatG9NVDc5tgtx+GB6rzYHoikG1x9XzhszUu7X6OlcFuZKG74eo48YL+VZUakae2nYOZOT65wQPsbJDCc+3dX03XacyiY2xIp1ybvhho7yM5NWZE6BBVTbaGrZJDBSAuXjz1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768312060; c=relaxed/simple;
	bh=g35sRKSqjqCDT8lv1ET+KglEOyEcBh2wHe2YXifp+ck=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=QzZEecNKr7I7c+7FEHnh4PM6dUz5TzRv66yNffLuLGhCy0Tc9kEx8WymA2okFIjSUswO0iFDvXpS+y30sv+69vsIporSvvzEbAGLgUhSAnypaF+skWx/1pGNmGv5ig/7ecBruwxrJpflf1Cd0+4L7Juwe7KKKUX9S8VxCXI+zk0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=qEYbr4Ie; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=DMZckDsi; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 13 Jan 2026 13:47:31 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768312053;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9wzylzhgX65HR5iop++OVBXxlxkbx5c7YNsgR5IPr90=;
	b=qEYbr4Ie5vzaq7Uee0DifYZ6CnvnebbIRnxKbxKV0a2pOUnIEr5+MObJ+ICCBwqQzcB6mo
	mSCqq00z9sTUEpqxm7X1MW716XXn2gPYPLv2HPCnT69IfQMflSjQsO9t22ZMCAH0RnWrnV
	iMk5LaVTY+vEl6LhIaA7/lzOYh79iGEWpDkZsO2O9IZoHkANZkTZqLpDfJ+4ZBSyG3Iu7j
	T3TdcMz/jMlGQMstkJMEkiH+C+HgwUS+4O0UJ3yRNL591xUGWAYhcMCiECgHGmKEYOgBvV
	/kbuCnFkC3SOXJ7tqeDAvXQprKDGWtWbN0wAWR//t54S/QVGPSLA59nEQnhqjw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768312053;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9wzylzhgX65HR5iop++OVBXxlxkbx5c7YNsgR5IPr90=;
	b=DMZckDsiX0kS1Jtgf4qMdAS7eywn10lmir+FHt7pCwB2WecnmrGtP1Uxkd6IPlQLt43Om6
	Bp4Nd15tunQyPACg==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] vdso: Remove struct getcpu_cache
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@kernel.org>,
 Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <hca@linux.ibm.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251230-getcpu_cache-v3-1-fb9c5f880ebe@linutronix.de>
References: <20251230-getcpu_cache-v3-1-fb9c5f880ebe@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176831205139.510.9338853772305071154.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     083103ebab933fd7752e21060a2974e2e9546b1a
Gitweb:        https://git.kernel.org/tip/083103ebab933fd7752e21060a2974e2e95=
46b1a
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 30 Dec 2025 08:08:44 +01:00
Committer:     Thomas Gleixner <tglx@kernel.org>
CommitterDate: Tue, 13 Jan 2026 14:42:24 +01:00

vdso: Remove struct getcpu_cache

The cache parameter of getcpu() is useless nowadays for various reasons.

  * It is never passed by userspace for either the vDSO or syscalls.
  * It is never used by the kernel.
  * It could not be made to work on the current vDSO architecture.
  * The structure definition is not part of the UAPI headers.
  * vdso_getcpu() is superseded by restartable sequences in any case.

Remove the struct and its header.

As a side-effect this gets rid of an unwanted inclusion of the linux/
header namespace from vDSO code.

[ tglx: Adapt to s390 upstream changes */

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@kernel.org>
Acked-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Heiko Carstens <hca@linux.ibm.com> # s390
Link: https://patch.msgid.link/20251230-getcpu_cache-v3-1-fb9c5f880ebe@linutr=
onix.de
---
 arch/loongarch/vdso/vgetcpu.c                   |  5 +---
 arch/s390/kernel/vdso/getcpu.c                  |  2 +-
 arch/s390/kernel/vdso/vdso.h                    |  4 +---
 arch/x86/entry/vdso/vgetcpu.c                   |  5 +---
 arch/x86/include/asm/vdso/processor.h           |  4 +---
 include/linux/getcpu.h                          | 19 +----------------
 include/linux/syscalls.h                        |  3 +--
 kernel/sys.c                                    |  4 +---
 tools/testing/selftests/vDSO/vdso_test_getcpu.c |  4 +---
 9 files changed, 10 insertions(+), 40 deletions(-)
 delete mode 100644 include/linux/getcpu.h

diff --git a/arch/loongarch/vdso/vgetcpu.c b/arch/loongarch/vdso/vgetcpu.c
index 73af492..6f054ec 100644
--- a/arch/loongarch/vdso/vgetcpu.c
+++ b/arch/loongarch/vdso/vgetcpu.c
@@ -4,7 +4,6 @@
  */
=20
 #include <asm/vdso.h>
-#include <linux/getcpu.h>
=20
 static __always_inline int read_cpu_id(void)
 {
@@ -28,8 +27,8 @@ static __always_inline int read_cpu_id(void)
 }
=20
 extern
-int __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache=
 *unused);
-int __vdso_getcpu(unsigned int *cpu, unsigned int *node, struct getcpu_cache=
 *unused)
+int __vdso_getcpu(unsigned int *cpu, unsigned int *node, void *unused);
+int __vdso_getcpu(unsigned int *cpu, unsigned int *node, void *unused)
 {
 	int cpu_id;
=20
diff --git a/arch/s390/kernel/vdso/getcpu.c b/arch/s390/kernel/vdso/getcpu.c
index 5c5d4a8..2058711 100644
--- a/arch/s390/kernel/vdso/getcpu.c
+++ b/arch/s390/kernel/vdso/getcpu.c
@@ -6,7 +6,7 @@
 #include <asm/timex.h>
 #include "vdso.h"
=20
-int __s390_vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *u=
nused)
+int __s390_vdso_getcpu(unsigned *cpu, unsigned *node, void *unused)
 {
 	union tod_clock clk;
=20
diff --git a/arch/s390/kernel/vdso/vdso.h b/arch/s390/kernel/vdso/vdso.h
index 8cff033..1fe52a6 100644
--- a/arch/s390/kernel/vdso/vdso.h
+++ b/arch/s390/kernel/vdso/vdso.h
@@ -4,9 +4,7 @@
=20
 #include <vdso/datapage.h>
=20
-struct getcpu_cache;
-
-int __s390_vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *u=
nused);
+int __s390_vdso_getcpu(unsigned *cpu, unsigned *node, void *unused);
 int __s390_vdso_gettimeofday(struct __kernel_old_timeval *tv, struct timezon=
e *tz);
 int __s390_vdso_clock_gettime(clockid_t clock, struct __kernel_timespec *ts);
 int __s390_vdso_clock_getres(clockid_t clock, struct __kernel_timespec *ts);
diff --git a/arch/x86/entry/vdso/vgetcpu.c b/arch/x86/entry/vdso/vgetcpu.c
index e464030..6381b47 100644
--- a/arch/x86/entry/vdso/vgetcpu.c
+++ b/arch/x86/entry/vdso/vgetcpu.c
@@ -6,17 +6,16 @@
  */
=20
 #include <linux/kernel.h>
-#include <linux/getcpu.h>
 #include <asm/segment.h>
 #include <vdso/processor.h>
=20
 notrace long
-__vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *unused)
+__vdso_getcpu(unsigned *cpu, unsigned *node, void *unused)
 {
 	vdso_read_cpunode(cpu, node);
=20
 	return 0;
 }
=20
-long getcpu(unsigned *cpu, unsigned *node, struct getcpu_cache *tcache)
+long getcpu(unsigned *cpu, unsigned *node, void *tcache)
 	__attribute__((weak, alias("__vdso_getcpu")));
diff --git a/arch/x86/include/asm/vdso/processor.h b/arch/x86/include/asm/vds=
o/processor.h
index 7000aeb..93e0e24 100644
--- a/arch/x86/include/asm/vdso/processor.h
+++ b/arch/x86/include/asm/vdso/processor.h
@@ -18,9 +18,7 @@ static __always_inline void cpu_relax(void)
 	native_pause();
 }
=20
-struct getcpu_cache;
-
-notrace long __vdso_getcpu(unsigned *cpu, unsigned *node, struct getcpu_cach=
e *unused);
+notrace long __vdso_getcpu(unsigned *cpu, unsigned *node, void *unused);
=20
 #endif /* __ASSEMBLER__ */
=20
diff --git a/include/linux/getcpu.h b/include/linux/getcpu.h
deleted file mode 100644
index c304dcd..0000000
--- a/include/linux/getcpu.h
+++ /dev/null
@@ -1,19 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_GETCPU_H
-#define _LINUX_GETCPU_H 1
-
-/* Cache for getcpu() to speed it up. Results might be a short time
-   out of date, but will be faster.
-
-   User programs should not refer to the contents of this structure.
-   I repeat they should not refer to it. If they do they will break
-   in future kernels.
-
-   It is only a private cache for vgetcpu(). It will change in future kernel=
s.
-   The user program must store this information per thread (__thread)
-   If you want 100% accurate information pass NULL instead. */
-struct getcpu_cache {
-	unsigned long blob[128 / sizeof(long)];
-};
-
-#endif
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index cf84d98..23704e0 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -59,7 +59,6 @@ struct compat_stat;
 struct old_timeval32;
 struct robust_list_head;
 struct futex_waitv;
-struct getcpu_cache;
 struct old_linux_dirent;
 struct perf_event_attr;
 struct file_handle;
@@ -718,7 +717,7 @@ asmlinkage long sys_getrusage(int who, struct rusage __us=
er *ru);
 asmlinkage long sys_umask(int mask);
 asmlinkage long sys_prctl(int option, unsigned long arg2, unsigned long arg3,
 			unsigned long arg4, unsigned long arg5);
-asmlinkage long sys_getcpu(unsigned __user *cpu, unsigned __user *node, stru=
ct getcpu_cache __user *cache);
+asmlinkage long sys_getcpu(unsigned __user *cpu, unsigned __user *node, void=
 __user *cache);
 asmlinkage long sys_gettimeofday(struct __kernel_old_timeval __user *tv,
 				struct timezone __user *tz);
 asmlinkage long sys_settimeofday(struct __kernel_old_timeval __user *tv,
diff --git a/kernel/sys.c b/kernel/sys.c
index 8b58eec..f1780ab 100644
--- a/kernel/sys.c
+++ b/kernel/sys.c
@@ -31,7 +31,6 @@
 #include <linux/tty.h>
 #include <linux/signal.h>
 #include <linux/cn_proc.h>
-#include <linux/getcpu.h>
 #include <linux/task_io_accounting_ops.h>
 #include <linux/seccomp.h>
 #include <linux/cpu.h>
@@ -2876,8 +2875,7 @@ SYSCALL_DEFINE5(prctl, int, option, unsigned long, arg2=
, unsigned long, arg3,
 	return error;
 }
=20
-SYSCALL_DEFINE3(getcpu, unsigned __user *, cpup, unsigned __user *, nodep,
-		struct getcpu_cache __user *, unused)
+SYSCALL_DEFINE3(getcpu, unsigned __user *, cpup, unsigned __user *, nodep, v=
oid __user *, unused)
 {
 	int err =3D 0;
 	int cpu =3D raw_smp_processor_id();
diff --git a/tools/testing/selftests/vDSO/vdso_test_getcpu.c b/tools/testing/=
selftests/vDSO/vdso_test_getcpu.c
index bea8ad5..3fe49cb 100644
--- a/tools/testing/selftests/vDSO/vdso_test_getcpu.c
+++ b/tools/testing/selftests/vDSO/vdso_test_getcpu.c
@@ -16,9 +16,7 @@
 #include "vdso_config.h"
 #include "vdso_call.h"
=20
-struct getcpu_cache;
-typedef long (*getcpu_t)(unsigned int *, unsigned int *,
-			 struct getcpu_cache *);
+typedef long (*getcpu_t)(unsigned int *, unsigned int *, void *);
=20
 int main(int argc, char **argv)
 {

