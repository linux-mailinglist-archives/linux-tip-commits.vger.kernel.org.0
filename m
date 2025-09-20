Return-Path: <linux-tip-commits+bounces-6689-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CE2B8CCF6
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 18:27:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 099AC162F2F
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 16:27:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08AED2FD7A5;
	Sat, 20 Sep 2025 16:27:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="hSxNwZvd";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="8RgSmbsU"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C832D0C68;
	Sat, 20 Sep 2025 16:27:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758385664; cv=none; b=bVAOSxdbkbU+kVlyts75WWdBQOcrM1DDWj1hXMcl+yl/R5CRgPCwnVW4upDvHRFUyys1mh5KnoV9qQi0TluQQlA1j4E2Tdj9smVWfpiGYuIiPABOcPVuSI15R3ngxOwZPsKJHbKvWagyxDs12s4WGILkHyi+1Dfrsfdq0REc0DQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758385664; c=relaxed/simple;
	bh=9VrjTx1M88LRzVqdTOoqFT0Sa1HNU9fWpSVUCcsjG80=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=blN2FkXsKByTdMzlfuDo4pPvjVSikqWU5fG8vFOnoNB9FPeJ4CgqnfCGFeCr19vxawciJj6z0BCttxqMV1Ao/eX3MleK4O2Uz1eaRd1JMOeqk7BHxpCokrwKotGs7Y1xni9naAT7U0k5TQ2/Y63+tdKz08FtD0WcEs+7P4271kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=hSxNwZvd; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=8RgSmbsU; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 20 Sep 2025 16:27:39 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758385661;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J1zXwYG3IVHQnFl1JAxE287te4VsjlqDJNG19CPxRp4=;
	b=hSxNwZvdGmPhoGFum0NZtq2hrs5R4pKwjd9sQhTIzwWttPWyu6uF7wrsZTi0PJT9lS/PHb
	Pm9E8KUPgpI5FxGP9nFD8BJbWV/XWEmJJuvwswKTSMOJxtNI5mlL7XGpjNF5BxnHKOXhGF
	X2ItpW1kbioT59kqKmfaQL1HVSiVEzKn9A2rxzul3DZsdeBJmlTs2hb/xKAtkX9ApUrYMt
	Jyg6bV4UhEaFFkc/P3m4s6SIYNFI64qWD20zAmKLgTVDJ/yuJBYw93rUd5lMxx90MXFmUa
	I+CBT0VTBCAs25ajQPvKAyhA6bD26307NK05LFUWNzfvIAl5yacyC+Oc7Dhxcw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758385661;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=J1zXwYG3IVHQnFl1JAxE287te4VsjlqDJNG19CPxRp4=;
	b=8RgSmbsUNP5dyScIEJOKSQadPvDEwF2VgWKQT2wHmRs3k04dR1ODyRNPno8y+5y8Wxzg0r
	JteIxtbzEpcv7WBw==
From: tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] selftests/futex: Remove logging.h file
Cc: andrealmeid@igalia.com, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20250917-tonyk-robust_test_cleanup-v3-15-306b373c244d@igalia.com>
References: <20250917-tonyk-robust_test_cleanup-v3-15-306b373c244d@igalia.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175838565998.709179.15210082344273321193.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     520db0559deff096c33a95dd3be2583e02771261
Gitweb:        https://git.kernel.org/tip/520db0559deff096c33a95dd3be2583e027=
71261
Author:        Andr=C3=A9 Almeida <andrealmeid@igalia.com>
AuthorDate:    Wed, 17 Sep 2025 18:21:54 -03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 20 Sep 2025 18:11:56 +02:00

selftests/futex: Remove logging.h file

Every futex selftest uses the kselftest_harness.h helper and don't need
the logging.h file. Delete it.

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/testing/selftests/futex/functional/Makefile |   3 +-
 tools/testing/selftests/futex/include/logging.h   | 148 +-------------
 2 files changed, 1 insertion(+), 150 deletions(-)
 delete mode 100644 tools/testing/selftests/futex/include/logging.h

diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testin=
g/selftests/futex/functional/Makefile
index bd50aec..490ace1 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -8,8 +8,7 @@ LDLIBS :=3D -lpthread -lrt -lnuma
=20
 LOCAL_HDRS :=3D \
 	../include/futextest.h \
-	../include/atomic.h \
-	../include/logging.h
+	../include/atomic.h
 TEST_GEN_PROGS :=3D \
 	futex_wait_timeout \
 	futex_wait_wouldblock \
diff --git a/tools/testing/selftests/futex/include/logging.h b/tools/testing/=
selftests/futex/include/logging.h
deleted file mode 100644
index 874c69c..0000000
--- a/tools/testing/selftests/futex/include/logging.h
+++ /dev/null
@@ -1,148 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-or-later */
-/***************************************************************************=
***
- *
- *   Copyright =C2=A9 International Business Machines  Corp., 2009
- *
- * DESCRIPTION
- *      Glibc independent futex library for testing kernel functionality.
- *
- * AUTHOR
- *      Darren Hart <dvhart@linux.intel.com>
- *
- * HISTORY
- *      2009-Nov-6: Initial version by Darren Hart <dvhart@linux.intel.com>
- *
- ***************************************************************************=
**/
-
-#ifndef _LOGGING_H
-#define _LOGGING_H
-
-#include <stdio.h>
-#include <string.h>
-#include <unistd.h>
-#include <linux/futex.h>
-#include "kselftest.h"
-
-/*
- * Define PASS, ERROR, and FAIL strings with and without color escape
- * sequences, default to no color.
- */
-#define ESC 0x1B, '['
-#define BRIGHT '1'
-#define GREEN '3', '2'
-#define YELLOW '3', '3'
-#define RED '3', '1'
-#define ESCEND 'm'
-#define BRIGHT_GREEN ESC, BRIGHT, ';', GREEN, ESCEND
-#define BRIGHT_YELLOW ESC, BRIGHT, ';', YELLOW, ESCEND
-#define BRIGHT_RED ESC, BRIGHT, ';', RED, ESCEND
-#define RESET_COLOR ESC, '0', 'm'
-static const char PASS_COLOR[] =3D {BRIGHT_GREEN, ' ', 'P', 'A', 'S', 'S',
-				  RESET_COLOR, 0};
-static const char ERROR_COLOR[] =3D {BRIGHT_YELLOW, 'E', 'R', 'R', 'O', 'R',
-				   RESET_COLOR, 0};
-static const char FAIL_COLOR[] =3D {BRIGHT_RED, ' ', 'F', 'A', 'I', 'L',
-				  RESET_COLOR, 0};
-static const char INFO_NORMAL[] =3D " INFO";
-static const char PASS_NORMAL[] =3D " PASS";
-static const char ERROR_NORMAL[] =3D "ERROR";
-static const char FAIL_NORMAL[] =3D " FAIL";
-const char *INFO =3D INFO_NORMAL;
-const char *PASS =3D PASS_NORMAL;
-const char *ERROR =3D ERROR_NORMAL;
-const char *FAIL =3D FAIL_NORMAL;
-
-/* Verbosity setting for INFO messages */
-#define VQUIET    0
-#define VCRITICAL 1
-#define VINFO     2
-#define VMAX      VINFO
-int _verbose =3D VCRITICAL;
-
-/* Functional test return codes */
-#define RET_PASS   0
-#define RET_ERROR -1
-#define RET_FAIL  -2
-
-/**
- * log_color() - Use colored output for PASS, ERROR, and FAIL strings
- * @use_color:	use color (1) or not (0)
- */
-void log_color(int use_color)
-{
-	if (use_color) {
-		PASS =3D PASS_COLOR;
-		ERROR =3D ERROR_COLOR;
-		FAIL =3D FAIL_COLOR;
-	} else {
-		PASS =3D PASS_NORMAL;
-		ERROR =3D ERROR_NORMAL;
-		FAIL =3D FAIL_NORMAL;
-	}
-}
-
-/**
- * log_verbosity() - Set verbosity of test output
- * @verbose:	Enable (1) verbose output or not (0)
- *
- * Currently setting verbose=3D1 will enable INFO messages and 0 will disable
- * them. FAIL and ERROR messages are always displayed.
- */
-void log_verbosity(int level)
-{
-	if (level > VMAX)
-		level =3D VMAX;
-	else if (level < 0)
-		level =3D 0;
-	_verbose =3D level;
-}
-
-/**
- * print_result() - Print standard PASS | ERROR | FAIL results
- * @ret:	the return value to be considered: 0 | RET_ERROR | RET_FAIL
- *
- * print_result() is primarily intended for functional tests.
- */
-void print_result(const char *test_name, int ret)
-{
-	switch (ret) {
-	case RET_PASS:
-		ksft_test_result_pass("%s\n", test_name);
-		ksft_print_cnts();
-		return;
-	case RET_ERROR:
-		ksft_test_result_error("%s\n", test_name);
-		ksft_print_cnts();
-		return;
-	case RET_FAIL:
-		ksft_test_result_fail("%s\n", test_name);
-		ksft_print_cnts();
-		return;
-	}
-}
-
-/* log level macros */
-#define info(message, vargs...) \
-do { \
-	if (_verbose >=3D VINFO) \
-		fprintf(stderr, "\t%s: "message, INFO, ##vargs); \
-} while (0)
-
-#define error(message, err, args...) \
-do { \
-	if (_verbose >=3D VCRITICAL) {\
-		if (err) \
-			fprintf(stderr, "\t%s: %s: "message, \
-				ERROR, strerror(err), ##args); \
-		else \
-			fprintf(stderr, "\t%s: "message, ERROR, ##args); \
-	} \
-} while (0)
-
-#define fail(message, args...) \
-do { \
-	if (_verbose >=3D VCRITICAL) \
-		fprintf(stderr, "\t%s: "message, FAIL, ##args); \
-} while (0)
-
-#endif

