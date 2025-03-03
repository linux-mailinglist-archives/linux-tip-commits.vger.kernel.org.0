Return-Path: <linux-tip-commits+bounces-3817-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 68829A4CBAE
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 20:13:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DAE443A009E
	for <lists+linux-tip-commits@lfdr.de>; Mon,  3 Mar 2025 19:12:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0AD222DFBE;
	Mon,  3 Mar 2025 19:12:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="oQ8Yf6Qo";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TOgpXeQC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB35F33F6;
	Mon,  3 Mar 2025 19:12:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741029179; cv=none; b=R56doCjG0Jo/qvB8X77YQ/6zTLO8voRGqoK+FCTo5SaxnGIdS5S/feKAbynP77ohn3WZg0NCLTt5aukcO7xMy/qWpyNZSFhRgRNV4gc19wvBtSCGUglLhDmR/cRsAVsiYchZhAUcBZ6he2aqFN9pAJhYB7RZiiMMMV8jEztJxhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741029179; c=relaxed/simple;
	bh=RhWzJ5cGJbTAX1qFTIhmvOmtt+Z6+41M5p+5ypQLIpc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=V0+Oasb3uSXKDiuq0qkHzcCkdrFqYwYnmFHVcl8iKGrfvXGhHwhYOl8VGuxdIB2JIiFSttGlxKM+Dx59sYAugQJBJPJl4s65/iggf2TmurTX8UVfY23Zo6FhbTzbBGgGWafZhQO7S4qi6AVDTHIr7KbBQ36NSREALP+RaF+hCUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=oQ8Yf6Qo; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TOgpXeQC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Mon, 03 Mar 2025 19:12:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1741029175;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zc5nI91PmVznub9umFDWK90R+1kvOUTypqlHvUTSjhc=;
	b=oQ8Yf6Qobsn1Fb+ohK/gQp9UuBfBKJjaS+iS9W/g6Jz8GLGrZ/RStttvzXOeVLvIkAgWMS
	4pqHm8yl4iKptXtGlxyFP3UzgSYHibtzdTdtlUaGMuR/1rVsCBgPbOZ8y6Bm4GlrGvEb0t
	MQW2VRfUOL+6OQMRSlgWjTrLhH9g89rWmGEaVly9ys7MwFxGD7wmzW4Ke3ha16scZDpvFs
	NLSGjJcFU6s7Sebm6VUXCelFQNeGmbh4XP7d1Uh38i+Mf//ifEZ3sUwkwHE6xQWzGXXdf9
	gJA4RSiOLW1UMkwJUpj1VpPX8b/WLAGrNZBWcuiRM2DbEgCeosdsPeCuMxV2/Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1741029175;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=zc5nI91PmVznub9umFDWK90R+1kvOUTypqlHvUTSjhc=;
	b=TOgpXeQCi0y20NkmE7cZmTJdqwvlaaHVoi4W3S5PP3RnPEUNgoVABtWfFfTk6VjTM3bfWh
	7HDxEloqciXxIMDw==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] selftests: vDSO: vdso_standalone_test_x86: Switch
 to nolibc
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 Vincenzo Frascino <vincenzo.frascino@arm.com>,
 Shuah Khan <skhan@linuxfoundation.org>, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20250226-parse_vdso-nolibc-v2-16-28e14e031ed8@linutronix.de>
References: <20250226-parse_vdso-nolibc-v2-16-28e14e031ed8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <174102917410.14745.10743571529785587283.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     8770a9183fe18442c7cfbb56bb7e006462775a91
Gitweb:        https://git.kernel.org/tip/8770a9183fe18442c7cfbb56bb7e0064627=
75a91
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Wed, 26 Feb 2025 12:44:55 +01:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Mon, 03 Mar 2025 20:00:13 +01:00

selftests: vDSO: vdso_standalone_test_x86: Switch to nolibc

vdso_standalone_test_x86 provides its own ASM syscall wrappers and
_start() implementation. The in-tree nolibc library already provides
this functionality for multiple architectures. By making use of nolibc,
the standalone testcase can be built from the exact same codebase as the
non-standalone version.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Vincenzo Frascino <vincenzo.frascino@arm.com>
Acked-by: Shuah Khan <skhan@linuxfoundation.org>
Link: https://lore.kernel.org/all/20250226-parse_vdso-nolibc-v2-16-28e14e031e=
d8@linutronix.de
---
 tools/testing/selftests/vDSO/Makefile                   |   8 +-
 tools/testing/selftests/vDSO/vdso_standalone_test_x86.c | 175 +------
 2 files changed, 39 insertions(+), 144 deletions(-)

diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/=
vDSO/Makefile
index bc8ca18..12a0614 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -22,13 +22,17 @@ include ../lib.mk
=20
 CFLAGS +=3D $(TOOLS_INCLUDES)
=20
+CFLAGS_NOLIBC :=3D -nostdlib -nostdinc -ffreestanding -fno-asynchronous-unwi=
nd-tables \
+		 -fno-stack-protector -include $(top_srcdir)/tools/include/nolibc/nolibc.h=
 \
+		 -I$(top_srcdir)/tools/include/nolibc/ $(KHDR_INCLUDES)
+
 $(OUTPUT)/vdso_test_gettimeofday: parse_vdso.c vdso_test_gettimeofday.c
 $(OUTPUT)/vdso_test_getcpu: parse_vdso.c vdso_test_getcpu.c
 $(OUTPUT)/vdso_test_abi: parse_vdso.c vdso_test_abi.c
 $(OUTPUT)/vdso_test_clock_getres: vdso_test_clock_getres.c
=20
-$(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c
-$(OUTPUT)/vdso_standalone_test_x86: CFLAGS +=3D-nostdlib -fno-asynchronous-u=
nwind-tables -fno-stack-protector
+$(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c =
| headers
+$(OUTPUT)/vdso_standalone_test_x86: CFLAGS:=3D$(CFLAGS_NOLIBC) $(CFLAGS)
=20
 $(OUTPUT)/vdso_test_correctness: vdso_test_correctness.c
 $(OUTPUT)/vdso_test_correctness: LDFLAGS +=3D -ldl
diff --git a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c b/tools/=
testing/selftests/vDSO/vdso_standalone_test_x86.c
index 500608f..9ce795b 100644
--- a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
+++ b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
@@ -1,167 +1,58 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * vdso_test.c: Sample code to test parse_vdso.c on x86
- * Copyright (c) 2011-2014 Andy Lutomirski
+ * vdso_test_gettimeofday.c: Sample code to test parse_vdso.c and
+ *                           vDSO gettimeofday()
+ * Copyright (c) 2014 Andy Lutomirski
  *
- * You can amuse yourself by compiling with:
- * gcc -std=3Dgnu99 -nostdlib
- *     -Os -fno-asynchronous-unwind-tables -flto -lgcc_s
- *      vdso_standalone_test_x86.c parse_vdso.c
- * to generate a small binary.  On x86_64, you can omit -lgcc_s
- * if you want the binary to be completely standalone.
+ * Compile with:
+ * gcc -std=3Dgnu99 vdso_test_gettimeofday.c parse_vdso_gettimeofday.c
+ *
+ * Tested on x86, 32-bit and 64-bit.  It may work on other architectures, to=
o.
  */
=20
-#include <sys/syscall.h>
+#include <stdio.h>
+#ifndef NOLIBC
+#include <sys/auxv.h>
 #include <sys/time.h>
-#include <unistd.h>
-#include <stdint.h>
-#include <linux/auxvec.h>
-
-#include "parse_vdso.h"
-
-/* We need some libc functions... */
-int strcmp(const char *a, const char *b)
-{
-	/* This implementation is buggy: it never returns -1. */
-	while (*a || *b) {
-		if (*a !=3D *b)
-			return 1;
-		if (*a =3D=3D 0 || *b =3D=3D 0)
-			return 1;
-		a++;
-		b++;
-	}
-
-	return 0;
-}
-
-/*
- * The clang build needs this, although gcc does not.
- * Stolen from lib/string.c.
- */
-void *memcpy(void *dest, const void *src, size_t count)
-{
-	char *tmp =3D dest;
-	const char *s =3D src;
-
-	while (count--)
-		*tmp++ =3D *s++;
-	return dest;
-}
-
-/* ...and two syscalls.  This is x86-specific. */
-static inline long x86_syscall3(long nr, long a0, long a1, long a2)
-{
-	long ret;
-#ifdef __x86_64__
-	asm volatile ("syscall" : "=3Da" (ret) : "a" (nr),
-		      "D" (a0), "S" (a1), "d" (a2) :
-		      "cc", "memory", "rcx",
-		      "r8", "r9", "r10", "r11" );
-#else
-	asm volatile ("int $0x80" : "=3Da" (ret) : "a" (nr),
-		      "b" (a0), "c" (a1), "d" (a2) :
-		      "cc", "memory" );
 #endif
-	return ret;
-}
-
-static inline long linux_write(int fd, const void *data, size_t len)
-{
-	return x86_syscall3(__NR_write, fd, (long)data, (long)len);
-}
=20
-static inline void linux_exit(int code)
-{
-	x86_syscall3(__NR_exit, code, 0, 0);
-}
-
-void to_base10(char *lastdig, time_t n)
-{
-	while (n) {
-		*lastdig =3D (n % 10) + '0';
-		n /=3D 10;
-		lastdig--;
-	}
-}
+#include "../kselftest.h"
+#include "parse_vdso.h"
+#include "vdso_config.h"
+#include "vdso_call.h"
=20
-unsigned long getauxval(const unsigned long *auxv, unsigned long type)
+int main(int argc, char **argv)
 {
-	unsigned long ret;
-
-	if (!auxv)
-		return 0;
-
-	while (1) {
-		if (!auxv[0] && !auxv[1]) {
-			ret =3D 0;
-			break;
-		}
+	const char *version =3D versions[VDSO_VERSION];
+	const char **name =3D (const char **)&names[VDSO_NAMES];
=20
-		if (auxv[0] =3D=3D type) {
-			ret =3D auxv[1];
-			break;
-		}
-
-		auxv +=3D 2;
+	unsigned long sysinfo_ehdr =3D getauxval(AT_SYSINFO_EHDR);
+	if (!sysinfo_ehdr) {
+		printf("AT_SYSINFO_EHDR is not present!\n");
+		return KSFT_SKIP;
 	}
=20
-	return ret;
-}
-
-void c_main(void **stack)
-{
-	/* Parse the stack */
-	long argc =3D (long)*stack;
-	stack +=3D argc + 2;
-
-	/* Now we're pointing at the environment.  Skip it. */
-	while(*stack)
-		stack++;
-	stack++;
-
-	/* Now we're pointing at auxv.  Initialize the vDSO parser. */
-	vdso_init_from_sysinfo_ehdr(getauxval((unsigned long *)stack, AT_SYSINFO_EH=
DR));
+	vdso_init_from_sysinfo_ehdr(getauxval(AT_SYSINFO_EHDR));
=20
 	/* Find gettimeofday. */
 	typedef long (*gtod_t)(struct timeval *tv, struct timezone *tz);
-	gtod_t gtod =3D (gtod_t)vdso_sym("LINUX_2.6", "__vdso_gettimeofday");
+	gtod_t gtod =3D (gtod_t)vdso_sym(version, name[0]);
=20
-	if (!gtod)
-		linux_exit(1);
+	if (!gtod) {
+		printf("Could not find %s\n", name[0]);
+		return KSFT_SKIP;
+	}
=20
 	struct timeval tv;
-	long ret =3D gtod(&tv, 0);
+	long ret =3D VDSO_CALL(gtod, 2, &tv, 0);
=20
 	if (ret =3D=3D 0) {
-		char buf[] =3D "The time is                     .000000\n";
-		to_base10(buf + 31, tv.tv_sec);
-		to_base10(buf + 38, tv.tv_usec);
-		linux_write(1, buf, sizeof(buf) - 1);
+		printf("The time is %lld.%06lld\n",
+		       (long long)tv.tv_sec, (long long)tv.tv_usec);
 	} else {
-		linux_exit(ret);
+		printf("%s failed\n", name[0]);
+		return KSFT_FAIL;
 	}
=20
-	linux_exit(0);
+	return 0;
 }
-
-/*
- * This is the real entry point.  It passes the initial stack into
- * the C entry point.
- */
-asm (
-	".text\n"
-	".global _start\n"
-	".type _start,@function\n"
-	"_start:\n\t"
-#ifdef __x86_64__
-	"mov %rsp,%rdi\n\t"
-	"and $-16,%rsp\n\t"
-	"sub $8,%rsp\n\t"
-	"jmp c_main"
-#else
-	"push %esp\n\t"
-	"call c_main\n\t"
-	"int $3"
-#endif
-	);

