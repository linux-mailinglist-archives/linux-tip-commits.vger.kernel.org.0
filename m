Return-Path: <linux-tip-commits+bounces-7971-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 22561D1BD64
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 01:44:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 0AF8230081A9
	for <lists+linux-tip-commits@lfdr.de>; Wed, 14 Jan 2026 00:44:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 691B52288D5;
	Wed, 14 Jan 2026 00:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WW3smxnn";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="aIeP3m+O"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2EF4221290;
	Wed, 14 Jan 2026 00:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768351495; cv=none; b=VHXwjbMomxeEXH6kDgYrusWfZUc6yxUMd65OaMr4yH3uHVT+wRJLLqVGoZU7QPf4IdSfgZBCjlckVcb3mb15rjHL5bgjlfZ9RbSa6tGDU4ZN9zUDNKr6RfWZjtMzY3Jv9eBij9rqBSpNFApfqV1prIINgmMq+WRO9XmjOmMId9k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768351495; c=relaxed/simple;
	bh=yTYF3w9YlJWmmIhomt91Nu+D21M9uBLQeAsPK50kALc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Mw2q6NWiCR1mqVFKSHvrWid+vDiQLMyq3TalyQr62u8S0+xJFfWAG5oMeHtkLrKStxfCkb61pc88ODPRFiZSGIQymk2oAaSXvSbysWKEG9NDPtURdMBBTZWX9NogL13RX+u80vJVeul5lmdHhdsocdfHe9cEaEYJjWI/q9bemZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WW3smxnn; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=aIeP3m+O; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Wed, 14 Jan 2026 00:44:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1768351492;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MuUNQtxGXj0Kqzysi+8Qd76xUIGLQyIlvSPuSux1DBI=;
	b=WW3smxnnChGzkHJ4nQMgXrGth0OV8Ao7S0aVD6tGhxztpXof0gGr9O0cA2VuuI3JgBVi+Q
	k2ah3mJQYk+IEQ+0pEDL9gANxUgyhlTmA9dxQTrxb4LAvCrL2URbYDrylN8nVZL7AGU0rm
	qqIGucG8WcIkvgh7Om/wH4lYn2nDchDaD2ZtUVE7sQut4tMMbz6Ee/ujBL01eWxa4WY2GA
	ytL99kH4ENxdUHgwe82SktF/uwBLm2V0MylED+bLsdCF/pCxIaEU4Apdp71FLGdBz//Wmg
	1ZV2EKFFBASOFsf20r7nK764QhvVnoQOoY2zY87K1qtHM6JSMoHDvehyfuzcYQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1768351492;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MuUNQtxGXj0Kqzysi+8Qd76xUIGLQyIlvSPuSux1DBI=;
	b=aIeP3m+OiYh7P6Qqw8nrS9gxZ+llcfxYwyANDw4BsCJxdh34zlXTnmQWvrklqx9J4W2WgZ
	6T5nyM3l43I88CBQ==
From: "tip-bot2 for H. Peter Anvin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] x86/vdso: Abstract out vdso system call internals
Cc: "H. Peter Anvin (Intel)" <hpa@zytor.com>,
 Dave Hansen <dave.hansen@linux.intel.com>, Uros Bizjak <ubizjak@gmail.com>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20251216212606.1325678-9-hpa@zytor.com>
References: <20251216212606.1325678-9-hpa@zytor.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <176835149103.510.4356195110678065212.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     a0636d4c3ad0da0cd6069eb6fef5d2b7d3449378
Gitweb:        https://git.kernel.org/tip/a0636d4c3ad0da0cd6069eb6fef5d2b7d34=
49378
Author:        H. Peter Anvin <hpa@zytor.com>
AuthorDate:    Tue, 16 Dec 2025 13:26:02 -08:00
Committer:     Dave Hansen <dave.hansen@linux.intel.com>
CommitterDate: Tue, 13 Jan 2026 16:37:58 -08:00

x86/vdso: Abstract out vdso system call internals

Abstract out the calling of true system calls from the vdso into
macros.

It has been a very long time since gcc did not allow %ebx or %ebp in
inline asm in 32-bit PIC mode; remove the corresponding hacks.

Remove the use of memory output constraints in gettimeofday.h in favor
of "memory" clobbers. The resulting code is identical for the current
use cases, as the system call is usually a terminal fallback anyway,
and it merely complicates the macroization.

This patch adds only a handful of more lines of code than it removes,
and in fact could be made substantially smaller by removing the macros
for the argument counts that aren't currently used, however, it seems
better to be general from the start.

[ v3: remove stray comment from prototyping; remove VDSO_SYSCALL6()
      since it would require special handling on 32 bits and is
      currently unused. (Uros Biszjak)

      Indent nested preprocessor directives. ]

Signed-off-by: H. Peter Anvin (Intel) <hpa@zytor.com>
Signed-off-by: Dave Hansen <dave.hansen@linux.intel.com>
Acked-by: Uros Bizjak <ubizjak@gmail.com>
Link: https://patch.msgid.link/20251216212606.1325678-9-hpa@zytor.com
---
 arch/x86/include/asm/vdso/gettimeofday.h | 108 +---------------------
 arch/x86/include/asm/vdso/sys_call.h     | 103 +++++++++++++++++++++-
 2 files changed, 111 insertions(+), 100 deletions(-)
 create mode 100644 arch/x86/include/asm/vdso/sys_call.h

diff --git a/arch/x86/include/asm/vdso/gettimeofday.h b/arch/x86/include/asm/=
vdso/gettimeofday.h
index 73b2e7e..3cf214c 100644
--- a/arch/x86/include/asm/vdso/gettimeofday.h
+++ b/arch/x86/include/asm/vdso/gettimeofday.h
@@ -18,6 +18,7 @@
 #include <asm/msr.h>
 #include <asm/pvclock.h>
 #include <clocksource/hyperv_timer.h>
+#include <asm/vdso/sys_call.h>
=20
 #define VDSO_HAS_TIME 1
=20
@@ -53,130 +54,37 @@ extern struct ms_hyperv_tsc_page hvclock_page
 	__attribute__((visibility("hidden")));
 #endif
=20
-#ifndef BUILD_VDSO32
-
 static __always_inline
 long clock_gettime_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 {
-	long ret;
-
-	asm ("syscall" : "=3Da" (ret), "=3Dm" (*_ts) :
-	     "0" (__NR_clock_gettime), "D" (_clkid), "S" (_ts) :
-	     "rcx", "r11");
-
-	return ret;
+	return VDSO_SYSCALL2(clock_gettime,64,_clkid,_ts);
 }
=20
 static __always_inline
 long gettimeofday_fallback(struct __kernel_old_timeval *_tv,
 			   struct timezone *_tz)
 {
-	long ret;
-
-	asm("syscall" : "=3Da" (ret) :
-	    "0" (__NR_gettimeofday), "D" (_tv), "S" (_tz) : "memory");
-
-	return ret;
+	return VDSO_SYSCALL2(gettimeofday,,_tv,_tz);
 }
=20
 static __always_inline
 long clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
 {
-	long ret;
-
-	asm ("syscall" : "=3Da" (ret), "=3Dm" (*_ts) :
-	     "0" (__NR_clock_getres), "D" (_clkid), "S" (_ts) :
-	     "rcx", "r11");
-
-	return ret;
+	return VDSO_SYSCALL2(clock_getres,_time64,_clkid,_ts);
 }
=20
-#else
-
-static __always_inline
-long clock_gettime_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
-{
-	long ret;
-
-	asm (
-		"mov %%ebx, %%edx \n"
-		"mov %[clock], %%ebx \n"
-		"call __kernel_vsyscall \n"
-		"mov %%edx, %%ebx \n"
-		: "=3Da" (ret), "=3Dm" (*_ts)
-		: "0" (__NR_clock_gettime64), [clock] "g" (_clkid), "c" (_ts)
-		: "edx");
-
-	return ret;
-}
+#ifndef CONFIG_X86_64
=20
 static __always_inline
 long clock_gettime32_fallback(clockid_t _clkid, struct old_timespec32 *_ts)
 {
-	long ret;
-
-	asm (
-		"mov %%ebx, %%edx \n"
-		"mov %[clock], %%ebx \n"
-		"call __kernel_vsyscall \n"
-		"mov %%edx, %%ebx \n"
-		: "=3Da" (ret), "=3Dm" (*_ts)
-		: "0" (__NR_clock_gettime), [clock] "g" (_clkid), "c" (_ts)
-		: "edx");
-
-	return ret;
-}
-
-static __always_inline
-long gettimeofday_fallback(struct __kernel_old_timeval *_tv,
-			   struct timezone *_tz)
-{
-	long ret;
-
-	asm(
-		"mov %%ebx, %%edx \n"
-		"mov %2, %%ebx \n"
-		"call __kernel_vsyscall \n"
-		"mov %%edx, %%ebx \n"
-		: "=3Da" (ret)
-		: "0" (__NR_gettimeofday), "g" (_tv), "c" (_tz)
-		: "memory", "edx");
-
-	return ret;
+	return VDSO_SYSCALL2(clock_gettime,,_clkid,_ts);
 }
=20
 static __always_inline long
-clock_getres_fallback(clockid_t _clkid, struct __kernel_timespec *_ts)
-{
-	long ret;
-
-	asm (
-		"mov %%ebx, %%edx \n"
-		"mov %[clock], %%ebx \n"
-		"call __kernel_vsyscall \n"
-		"mov %%edx, %%ebx \n"
-		: "=3Da" (ret), "=3Dm" (*_ts)
-		: "0" (__NR_clock_getres_time64), [clock] "g" (_clkid), "c" (_ts)
-		: "edx");
-
-	return ret;
-}
-
-static __always_inline
-long clock_getres32_fallback(clockid_t _clkid, struct old_timespec32 *_ts)
+clock_getres32_fallback(clockid_t _clkid, struct old_timespec32 *_ts)
 {
-	long ret;
-
-	asm (
-		"mov %%ebx, %%edx \n"
-		"mov %[clock], %%ebx \n"
-		"call __kernel_vsyscall \n"
-		"mov %%edx, %%ebx \n"
-		: "=3Da" (ret), "=3Dm" (*_ts)
-		: "0" (__NR_clock_getres), [clock] "g" (_clkid), "c" (_ts)
-		: "edx");
-
-	return ret;
+	return VDSO_SYSCALL2(clock_getres,,_clkid,_ts);
 }
=20
 #endif
diff --git a/arch/x86/include/asm/vdso/sys_call.h b/arch/x86/include/asm/vdso=
/sys_call.h
new file mode 100644
index 0000000..dcfd17c
--- /dev/null
+++ b/arch/x86/include/asm/vdso/sys_call.h
@@ -0,0 +1,103 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Macros for issuing an inline system call from the vDSO.
+ */
+
+#ifndef X86_ASM_VDSO_SYS_CALL_H
+#define X86_ASM_VDSO_SYS_CALL_H
+
+#include <linux/compiler.h>
+#include <asm/cpufeatures.h>
+#include <asm/alternative.h>
+
+#ifdef CONFIG_X86_64
+# define __sys_instr	"syscall"
+# define __sys_clobber	"rcx", "r11", "memory"
+# define __sys_nr(x,y)	__NR_ ## x
+# define __sys_reg1	"rdi"
+# define __sys_reg2	"rsi"
+# define __sys_reg3	"rdx"
+# define __sys_reg4	"r10"
+# define __sys_reg5	"r8"
+#else
+# define __sys_instr	"call __kernel_vsyscall"
+# define __sys_clobber	"memory"
+# define __sys_nr(x,y)	__NR_ ## x ## y
+# define __sys_reg1	"ebx"
+# define __sys_reg2	"ecx"
+# define __sys_reg3	"edx"
+# define __sys_reg4	"esi"
+# define __sys_reg5	"edi"
+#endif
+
+/*
+ * Example usage:
+ *
+ * result =3D VDSO_SYSCALL3(foo,64,x,y,z);
+ *
+ * ... calls foo(x,y,z) on 64 bits, and foo64(x,y,z) on 32 bits.
+ *
+ * VDSO_SYSCALL6() is currently missing, because it would require
+ * special handling for %ebp on 32 bits when the vdso is compiled with
+ * frame pointers enabled (the default on 32 bits.) Add it as a special
+ * case when and if it becomes necessary.
+ */
+#define _VDSO_SYSCALL(name,suf32,...)					\
+	({								\
+		long _sys_num_ret =3D __sys_nr(name,suf32);		\
+		asm_inline volatile(					\
+			__sys_instr					\
+			: "+a" (_sys_num_ret)				\
+			: __VA_ARGS__					\
+			: __sys_clobber);				\
+		_sys_num_ret;						\
+	})
+
+#define VDSO_SYSCALL0(name,suf32)					\
+	_VDSO_SYSCALL(name,suf32)
+#define VDSO_SYSCALL1(name,suf32,a1)					\
+	({								\
+		register long _sys_arg1 asm(__sys_reg1) =3D (long)(a1);	\
+		_VDSO_SYSCALL(name,suf32,				\
+			      "r" (_sys_arg1));				\
+	})
+#define VDSO_SYSCALL2(name,suf32,a1,a2)				\
+	({								\
+		register long _sys_arg1 asm(__sys_reg1) =3D (long)(a1);	\
+		register long _sys_arg2 asm(__sys_reg2) =3D (long)(a2);	\
+		_VDSO_SYSCALL(name,suf32,				\
+			      "r" (_sys_arg1), "r" (_sys_arg2));	\
+	})
+#define VDSO_SYSCALL3(name,suf32,a1,a2,a3)				\
+	({								\
+		register long _sys_arg1 asm(__sys_reg1) =3D (long)(a1);	\
+		register long _sys_arg2 asm(__sys_reg2) =3D (long)(a2);	\
+		register long _sys_arg3 asm(__sys_reg3) =3D (long)(a3);	\
+		_VDSO_SYSCALL(name,suf32,				\
+			      "r" (_sys_arg1), "r" (_sys_arg2),		\
+			      "r" (_sys_arg3));				\
+	})
+#define VDSO_SYSCALL4(name,suf32,a1,a2,a3,a4)				\
+	({								\
+		register long _sys_arg1 asm(__sys_reg1) =3D (long)(a1);	\
+		register long _sys_arg2 asm(__sys_reg2) =3D (long)(a2);	\
+		register long _sys_arg3 asm(__sys_reg3) =3D (long)(a3);	\
+		register long _sys_arg4 asm(__sys_reg4) =3D (long)(a4);	\
+		_VDSO_SYSCALL(name,suf32,				\
+			      "r" (_sys_arg1), "r" (_sys_arg2),		\
+			      "r" (_sys_arg3), "r" (_sys_arg4));	\
+	})
+#define VDSO_SYSCALL5(name,suf32,a1,a2,a3,a4,a5)			\
+	({								\
+		register long _sys_arg1 asm(__sys_reg1) =3D (long)(a1);	\
+		register long _sys_arg2 asm(__sys_reg2) =3D (long)(a2);	\
+		register long _sys_arg3 asm(__sys_reg3) =3D (long)(a3);	\
+		register long _sys_arg4 asm(__sys_reg4) =3D (long)(a4);	\
+		register long _sys_arg5 asm(__sys_reg5) =3D (long)(a5);	\
+		_VDSO_SYSCALL(name,suf32,				\
+			      "r" (_sys_arg1), "r" (_sys_arg2),		\
+			      "r" (_sys_arg3), "r" (_sys_arg4),		\
+			      "r" (_sys_arg5));				\
+	})
+
+#endif /* X86_VDSO_SYS_CALL_H */

