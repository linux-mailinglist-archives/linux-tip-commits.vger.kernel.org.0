Return-Path: <linux-tip-commits+bounces-6512-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CBB77B4A66A
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 11:03:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 696413A227E
	for <lists+linux-tip-commits@lfdr.de>; Tue,  9 Sep 2025 09:02:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0350D2741C9;
	Tue,  9 Sep 2025 09:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="IIDQADgO";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="l82E0+Sf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52B5C1A4E70;
	Tue,  9 Sep 2025 09:02:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757408557; cv=none; b=RXhcNViqi8wD5eAb9yI5wc8LW7/r95mtzFRiRJtsSOmgCL8bwPhWC/QlZ3B+r4afuQrOIHUe1SaLFo63Hq+v67SR1Fmjg3l2teKJHfV1SdQJA2V82wJNh36h6h20TcqzmCmJJ67ZcOR9vICJuKzV0NnoaKtEwSFoxEWzp8azvoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757408557; c=relaxed/simple;
	bh=EIwdTPSsthwINXLiqzL2/xOmGg+SzdhUSXyKicm6qEo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=pDM71ejONiBjdEDPWrnVioyII4D5VcrRLP7G9hLVYgvyvojwIgkEB3GS1Q+9qBNhJ6EDMyYrjfxbjDmZDVN95/dAxbRfND+G7ArhtNupxcEdhEQ8JErtNTU+2jP1MRNMIoKGSmZPn2yzl+y2vyxlVgZCOkJMCGsmmTjRSP+iKI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=IIDQADgO; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=l82E0+Sf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 09 Sep 2025 09:02:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1757408554;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rkzt4fOlY3iscHnRGdHeViGmEfrGtWKbA7OuKyLGTUQ=;
	b=IIDQADgOEG4iJS4ZlxoCFCQWLGU7uyWuB77CNT4To0j1bz4DD5s9wyH80NaE+eY0ZdwTtU
	sd21WuZPMluHwMcdebpNtQdG9sPs+zE6ENGBzm+dL2vCuoef36a4XdpZaBEg3Nm5LCpZXE
	X/47ufAPW/wfjp/adgfOMOqA1qYieQkSiZOcMmU7To3Zhsls93baq9aKla0vAzWDNriXk4
	k0JfEYYU96y0qaSbGwPiON+1e9zapUYPv8dQ3lxRAQtXUH0K8dp0XpIkeAXpmXDjNZKMos
	5FG5Z7gNVXHwdn1cfYg9hL8kNdUfHkRAGjy33hiRNVOCKClm4LKlmjn/frK1rQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1757408554;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=rkzt4fOlY3iscHnRGdHeViGmEfrGtWKbA7OuKyLGTUQ=;
	b=l82E0+SfREH+yh9Dy3z2pap3JMzCZ9RvLo/rL8R8VWzSybdbbsj3+OzOajlmmGRZwZo9pw
	s6RYN+727Z2YQDCw==
From: tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] selftests: vDSO: Drop vdso_test_clock_getres
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250812-vdso-tests-fixes-v2-8-90f499dd35f8@linutronix.de>
References: <20250812-vdso-tests-fixes-v2-8-90f499dd35f8@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175740855292.1920.17183431952741104096.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     e82bf7570d5ca3667a9038a3c5a42d451b949d89
Gitweb:        https://git.kernel.org/tip/e82bf7570d5ca3667a9038a3c5a42d451b9=
49d89
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Tue, 12 Aug 2025 07:39:09 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 09 Sep 2025 10:57:39 +02:00

selftests: vDSO: Drop vdso_test_clock_getres

vdso_test_abi provides the exact same functionality, properly uses
kselftest.h and explicitly calls into the vDSO without relying on the libc.

Drop the pointless testcase.

Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/all/20250812-vdso-tests-fixes-v2-8-90f499dd35f8=
@linutronix.de

---
 tools/testing/selftests/vDSO/.gitignore               |   1 +-
 tools/testing/selftests/vDSO/Makefile                 |   2 +-
 tools/testing/selftests/vDSO/vdso_test_clock_getres.c | 123 +---------
 3 files changed, 126 deletions(-)
 delete mode 100644 tools/testing/selftests/vDSO/vdso_test_clock_getres.c

diff --git a/tools/testing/selftests/vDSO/.gitignore b/tools/testing/selftest=
s/vDSO/.gitignore
index 30d5c8f..ba322a3 100644
--- a/tools/testing/selftests/vDSO/.gitignore
+++ b/tools/testing/selftests/vDSO/.gitignore
@@ -1,7 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 vdso_test
 vdso_test_abi
-vdso_test_clock_getres
 vdso_test_correctness
 vdso_test_gettimeofday
 vdso_test_getcpu
diff --git a/tools/testing/selftests/vDSO/Makefile b/tools/testing/selftests/=
vDSO/Makefile
index 918a2ca..e361aca 100644
--- a/tools/testing/selftests/vDSO/Makefile
+++ b/tools/testing/selftests/vDSO/Makefile
@@ -4,7 +4,6 @@ include ../../../scripts/Makefile.arch
 TEST_GEN_PROGS :=3D vdso_test_gettimeofday
 TEST_GEN_PROGS +=3D vdso_test_getcpu
 TEST_GEN_PROGS +=3D vdso_test_abi
-TEST_GEN_PROGS +=3D vdso_test_clock_getres
 ifeq ($(ARCH),$(filter $(ARCH),x86 x86_64))
 TEST_GEN_PROGS +=3D vdso_standalone_test_x86
 endif
@@ -29,7 +28,6 @@ CFLAGS_NOLIBC :=3D -nostdlib -nostdinc -ffreestanding -fno-=
asynchronous-unwind-tab
 $(OUTPUT)/vdso_test_gettimeofday: parse_vdso.c vdso_test_gettimeofday.c
 $(OUTPUT)/vdso_test_getcpu: parse_vdso.c vdso_test_getcpu.c
 $(OUTPUT)/vdso_test_abi: parse_vdso.c vdso_test_abi.c
-$(OUTPUT)/vdso_test_clock_getres: vdso_test_clock_getres.c
=20
 $(OUTPUT)/vdso_standalone_test_x86: vdso_standalone_test_x86.c parse_vdso.c =
| headers
 $(OUTPUT)/vdso_standalone_test_x86: CFLAGS:=3D$(CFLAGS_NOLIBC) $(CFLAGS)
diff --git a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c b/tools/te=
sting/selftests/vDSO/vdso_test_clock_getres.c
deleted file mode 100644
index b5d5f59..0000000
--- a/tools/testing/selftests/vDSO/vdso_test_clock_getres.c
+++ /dev/null
@@ -1,123 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note
-/*
- * vdso_clock_getres.c: Sample code to test clock_getres.
- * Copyright (c) 2019 Arm Ltd.
- *
- * Compile with:
- * gcc -std=3Dgnu99 vdso_clock_getres.c
- *
- * Tested on ARM, ARM64, MIPS32, x86 (32-bit and 64-bit),
- * Power (32-bit and 64-bit), S390x (32-bit and 64-bit).
- * Might work on other architectures.
- */
-
-#define _GNU_SOURCE
-#include <elf.h>
-#include <fcntl.h>
-#include <stdint.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <time.h>
-#include <sys/auxv.h>
-#include <sys/mman.h>
-#include <sys/time.h>
-#include <unistd.h>
-#include <sys/syscall.h>
-
-#include "../kselftest.h"
-
-static long syscall_clock_getres(clockid_t _clkid, struct timespec *_ts)
-{
-	long ret;
-
-	ret =3D syscall(SYS_clock_getres, _clkid, _ts);
-
-	return ret;
-}
-
-const char *vdso_clock_name[12] =3D {
-	"CLOCK_REALTIME",
-	"CLOCK_MONOTONIC",
-	"CLOCK_PROCESS_CPUTIME_ID",
-	"CLOCK_THREAD_CPUTIME_ID",
-	"CLOCK_MONOTONIC_RAW",
-	"CLOCK_REALTIME_COARSE",
-	"CLOCK_MONOTONIC_COARSE",
-	"CLOCK_BOOTTIME",
-	"CLOCK_REALTIME_ALARM",
-	"CLOCK_BOOTTIME_ALARM",
-	"CLOCK_SGI_CYCLE",
-	"CLOCK_TAI",
-};
-
-/*
- * This function calls clock_getres in vdso and by system call
- * with different values for clock_id.
- *
- * Example of output:
- *
- * clock_id: CLOCK_REALTIME [PASS]
- * clock_id: CLOCK_BOOTTIME [PASS]
- * clock_id: CLOCK_TAI [PASS]
- * clock_id: CLOCK_REALTIME_COARSE [PASS]
- * clock_id: CLOCK_MONOTONIC [PASS]
- * clock_id: CLOCK_MONOTONIC_RAW [PASS]
- * clock_id: CLOCK_MONOTONIC_COARSE [PASS]
- */
-static inline int vdso_test_clock(unsigned int clock_id)
-{
-	struct timespec x, y;
-
-	printf("clock_id: %s", vdso_clock_name[clock_id]);
-	clock_getres(clock_id, &x);
-	syscall_clock_getres(clock_id, &y);
-
-	if ((x.tv_sec !=3D y.tv_sec) || (x.tv_nsec !=3D y.tv_nsec)) {
-		printf(" [FAIL]\n");
-		return KSFT_FAIL;
-	}
-
-	printf(" [PASS]\n");
-	return KSFT_PASS;
-}
-
-int main(int argc, char **argv)
-{
-	int ret =3D 0;
-
-#if _POSIX_TIMERS > 0
-
-#ifdef CLOCK_REALTIME
-	ret +=3D vdso_test_clock(CLOCK_REALTIME);
-#endif
-
-#ifdef CLOCK_BOOTTIME
-	ret +=3D vdso_test_clock(CLOCK_BOOTTIME);
-#endif
-
-#ifdef CLOCK_TAI
-	ret +=3D vdso_test_clock(CLOCK_TAI);
-#endif
-
-#ifdef CLOCK_REALTIME_COARSE
-	ret +=3D vdso_test_clock(CLOCK_REALTIME_COARSE);
-#endif
-
-#ifdef CLOCK_MONOTONIC
-	ret +=3D vdso_test_clock(CLOCK_MONOTONIC);
-#endif
-
-#ifdef CLOCK_MONOTONIC_RAW
-	ret +=3D vdso_test_clock(CLOCK_MONOTONIC_RAW);
-#endif
-
-#ifdef CLOCK_MONOTONIC_COARSE
-	ret +=3D vdso_test_clock(CLOCK_MONOTONIC_COARSE);
-#endif
-
-#endif
-	if (ret > 0)
-		return KSFT_FAIL;
-
-	return KSFT_PASS;
-}

