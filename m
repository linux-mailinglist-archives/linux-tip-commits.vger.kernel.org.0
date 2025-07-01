Return-Path: <linux-tip-commits+bounces-5965-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F1AAEFB8B
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jul 2025 16:06:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2D5E0188F1D7
	for <lists+linux-tip-commits@lfdr.de>; Tue,  1 Jul 2025 14:04:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCE35279346;
	Tue,  1 Jul 2025 13:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="HJtAi2OU";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TRj6a/kV"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2087027932B;
	Tue,  1 Jul 2025 13:59:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751378358; cv=none; b=pHNb8uEB3jNa0eawl9brfRTfVc7lYWngbMnx2o17NKQ5f3DNSVKjzo6O3oBsiu7hYpR2NmoDKmHv5vXbZ3VihEJxLsV278KT/SYomC4Hu6Ayw3J6O5LFzShiaHLyScjHhhYDda6uvgvll6WwkTJ99XmJHSs8NSJ1THIqtgOcy/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751378358; c=relaxed/simple;
	bh=Wj0h5mtjuvAQ8XXT+1sn/d20i3PcB8cDqerBrv3F6NE=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=N2npjAlnFbLtMelrbxUDESZ+L8mKedAz5Wdo34gv8YEVDu97naZMg3PCE6RHS4mHSwoU4QIo39jvzNyAvNqQ0wZB9esTxqJGMvmrGLT8ATCL/ONJMqAxVlyLhRaUox5sdIWI4wUVOFP/H2Mx2MuNiSTVxknH+PSWroeTZj2YFUw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=HJtAi2OU; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TRj6a/kV; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Tue, 01 Jul 2025 13:59:13 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1751378354;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MbK2Ux2Bw7t6VsL7KsvBsDQ5CEAlP7/oux8nm42uEkU=;
	b=HJtAi2OUMtM2jhiaC1ARoJlQ2/Q3rz0Vs5Wq3kcgtx5e2HXuHqs5tLBhiBVqoLMcXX1dv7
	qoAH9f+ooWZm9/Z2zAqZEepEg4sxXKYZApIxn8qSLfq5Ft2IC1YocI1tsj/uEoZgO/jhtD
	fqW6NC56G6wZeBQmGM9pQe3DFrRQzfAosnFdgGwwtkB1bq2qP3G5j01mDrcf+/Fe2OiZdj
	8ksOZZzSlPn2EKjBtYq6kAEXSOyb/D7radlOfFLSt5agkHrPG4M1d09lFoydvS6e1dnaoL
	twtPsb7bSpeC4TyF4Mrwg9nwfABW0H57vwpx3OnZCraSVGK8+1XDaYd5AL0vzQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1751378354;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MbK2Ux2Bw7t6VsL7KsvBsDQ5CEAlP7/oux8nm42uEkU=;
	b=TRj6a/kVzTkE51p8uFiIbTCogfu8DhLMst7xOGK7ViLnWA9xarQgTvC3YR2MwigL2prN7c
	G3J0+LIm+rxJ18BA==
From:
 tip-bot2 for Thomas =?utf-8?q?Wei=C3=9Fschuh?= <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: timers/vdso] selftests: vDSO: vdso_standalone_test_x86: Replace
 source file with symlink
Cc: thomas.weissschuh@linutronix.de, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250611-selftests-vdso-fixes-v3-9-e62e37a6bcf5@linutronix.de>
References: <20250611-selftests-vdso-fixes-v3-9-e62e37a6bcf5@linutronix.de>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175137835327.406.9253965691286380497.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the timers/vdso branch of tip:

Commit-ID:     437079605c26dc7c98586580a8c01b5f7f746a79
Gitweb:        https://git.kernel.org/tip/437079605c26dc7c98586580a8c01b5f7f7=
46a79
Author:        Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
AuthorDate:    Wed, 11 Jun 2025 12:33:59 +02:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 01 Jul 2025 15:50:43 +02:00

selftests: vDSO: vdso_standalone_test_x86: Replace source file with symlink

With the switch over to nolibc the source file vdso_standalone_test_x86.c
was intended to be replaced with a symlink to vdso_test_gettimeofday.c.
This was the patch that was submitted to LKML, but during application the
symlink was replaced by a textual copy of the linked-to file.

Having two copies introduces the possibility of divergence and increases
maintenance burden, switch back to a symlink.

Fixes: 8770a9183fe1 ("selftests: vDSO: vdso_standalone_test_x86: Switch to no=
libc")
Signed-off-by: Thomas Wei=C3=9Fschuh <thomas.weissschuh@linutronix.de>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/lkml/20250226-parse_vdso-nolibc-v2-16-28e14e031=
ed8@linutronix.de/
Link: https://lore.kernel.org/all/20250611-selftests-vdso-fixes-v3-9-e62e37a6=
bcf5@linutronix.de


---
 tools/testing/selftests/vDSO/vdso_standalone_test_x86.c | 58 +--------
 tools/testing/selftests/vDSO/vdso_standalone_test_x86.c |  1 +-
 2 files changed, 1 insertion(+), 58 deletions(-)
 delete mode 100644 tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
 create mode 120000 tools/testing/selftests/vDSO/vdso_standalone_test_x86.c

diff --git a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c b/tools/=
testing/selftests/vDSO/vdso_standalone_test_x86.c
deleted file mode 100644
index 9ce795b..0000000
--- a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
+++ /dev/null
@@ -1,58 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-only
-/*
- * vdso_test_gettimeofday.c: Sample code to test parse_vdso.c and
- *                           vDSO gettimeofday()
- * Copyright (c) 2014 Andy Lutomirski
- *
- * Compile with:
- * gcc -std=3Dgnu99 vdso_test_gettimeofday.c parse_vdso_gettimeofday.c
- *
- * Tested on x86, 32-bit and 64-bit.  It may work on other architectures, to=
o.
- */
-
-#include <stdio.h>
-#ifndef NOLIBC
-#include <sys/auxv.h>
-#include <sys/time.h>
-#endif
-
-#include "../kselftest.h"
-#include "parse_vdso.h"
-#include "vdso_config.h"
-#include "vdso_call.h"
-
-int main(int argc, char **argv)
-{
-	const char *version =3D versions[VDSO_VERSION];
-	const char **name =3D (const char **)&names[VDSO_NAMES];
-
-	unsigned long sysinfo_ehdr =3D getauxval(AT_SYSINFO_EHDR);
-	if (!sysinfo_ehdr) {
-		printf("AT_SYSINFO_EHDR is not present!\n");
-		return KSFT_SKIP;
-	}
-
-	vdso_init_from_sysinfo_ehdr(getauxval(AT_SYSINFO_EHDR));
-
-	/* Find gettimeofday. */
-	typedef long (*gtod_t)(struct timeval *tv, struct timezone *tz);
-	gtod_t gtod =3D (gtod_t)vdso_sym(version, name[0]);
-
-	if (!gtod) {
-		printf("Could not find %s\n", name[0]);
-		return KSFT_SKIP;
-	}
-
-	struct timeval tv;
-	long ret =3D VDSO_CALL(gtod, 2, &tv, 0);
-
-	if (ret =3D=3D 0) {
-		printf("The time is %lld.%06lld\n",
-		       (long long)tv.tv_sec, (long long)tv.tv_usec);
-	} else {
-		printf("%s failed\n", name[0]);
-		return KSFT_FAIL;
-	}
-
-	return 0;
-}
diff --git a/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c b/tools/=
testing/selftests/vDSO/vdso_standalone_test_x86.c
new file mode 120000
index 0000000..4d3d96f
--- /dev/null
+++ b/tools/testing/selftests/vDSO/vdso_standalone_test_x86.c
@@ -0,0 +1 @@
+vdso_test_gettimeofday.c
\ No newline at end of file

