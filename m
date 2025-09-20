Return-Path: <linux-tip-commits+bounces-6698-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C2499B8CD32
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 18:29:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1B22017E3A2
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 16:29:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A40F4307488;
	Sat, 20 Sep 2025 16:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="PNz5BlgJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eml6uzzH"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A506F305E3E;
	Sat, 20 Sep 2025 16:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758385675; cv=none; b=uaOT6pvPIfRFaagUI3PYSw04SOGF0IYSP7jDk0LY18zuf09f+AlWynh/TYzenXZp1cZzNL6IUBLo9d43W/5OxAyDsNZiuvrj2JFvii8aqdfebQRHlczrZG2BJUBm+ALjviQBxMRvkkqElwNvk3mfdQSExx2hd/eMWvlaUJ1Vv9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758385675; c=relaxed/simple;
	bh=1olV1pqk44GXAG0Pi1dMaqmH7ppEPfWZYfUy/++Irek=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=YzjIqVmaBeZ/PYmpcedvp54MvhLU+8xeORLLGmJXtIJpEoASQHDYB5kLqRZpAm72twpKRSOiYgrafNBS+03XyQR+Wwz4SKPOu4CP0sWBLp1EuEDtPFGdv1cCmVpqkjmnS695v6stFwCfwJN2nfdGg0xyzkP/i86wD/Co9Mus1yE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=PNz5BlgJ; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=eml6uzzH; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 20 Sep 2025 16:27:49 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758385671;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5CxWJzutEqtMcFDuuTDQm2O4Vg0uOabMOJP8TTur0m8=;
	b=PNz5BlgJUZm8CwOBMqnO7KGgS3enH6YyS/zJtmyjmRRT3sHaYOrR9IXEwexbsOq0srPW2f
	DW8ZxVx/3466jqwE6w4EjD2Wgz+GxAHWpBS99RulN9lPkEbetMauNubJM09BKX5sX6QJlp
	bpf7BEqk8V869f+rwjyo1TOi1SHOt3tw3Wpc+EnTpJgWFIO4PqV221SkJT76n0cttCHhYf
	ug/l2TWCBm70Sot6lLaSy2qG254o4Ol5DockuMqGYs1xKwb/cGocelZuLhh5ydWP/LOY2Y
	StAmy44Vi+zh+0kKiDjNMumG2ZM37jGTRFOuUEA4bh9alEOoQ1ITprnIqdhwKw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758385671;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5CxWJzutEqtMcFDuuTDQm2O4Vg0uOabMOJP8TTur0m8=;
	b=eml6uzzHL+GKZ7ebZMHMQM1UzX2ZIqi10t8RtV+a5SX+OHFIcIofB9rxhcgtyPQMpsvz8A
	cJ7KQ3Hevs10DsCw==
From: tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] selftests/futex: Refactor futex_wait_wouldblock
 with kselftest_harness.h
Cc: andrealmeid@igalia.com, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250917-tonyk-robust_test_cleanup-v3-6-306b373c244d@igalia.com>
References: <20250917-tonyk-robust_test_cleanup-v3-6-306b373c244d@igalia.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175838566982.709179.13272307930106304776.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     f5a16834410a89f929657d9b8a5a4011c05293c8
Gitweb:        https://git.kernel.org/tip/f5a16834410a89f929657d9b8a5a4011c05=
293c8
Author:        Andr=C3=A9 Almeida <andrealmeid@igalia.com>
AuthorDate:    Wed, 17 Sep 2025 18:21:45 -03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 20 Sep 2025 18:11:54 +02:00

selftests/futex: Refactor futex_wait_wouldblock with kselftest_harness.h

To reduce the boilerplate code, refactor futex_wait_wouldblock test to
use kselftest_harness header instead of futex's logging header.

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/testing/selftests/futex/functional/futex_wait_wouldblock.c | 76 ++++++=
+++++++++++++++-------------------------------------------------
 tools/testing/selftests/futex/functional/run.sh                  |  2 +-
 2 files changed, 24 insertions(+), 54 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c=
 b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
index 2d8230d..36b7a54 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_wouldblock.c
@@ -21,72 +21,44 @@
 #include <stdlib.h>
 #include <string.h>
 #include <time.h>
+
 #include "futextest.h"
 #include "futex2test.h"
-#include "logging.h"
+#include "../../kselftest_harness.h"
=20
-#define TEST_NAME "futex-wait-wouldblock"
 #define timeout_ns 100000
=20
-void usage(char *prog)
-{
-	printf("Usage: %s\n", prog);
-	printf("  -c	Use color\n");
-	printf("  -h	Display this help message\n");
-	printf("  -v L	Verbosity level: %d=3DQUIET %d=3DCRITICAL %d=3DINFO\n",
-	       VQUIET, VCRITICAL, VINFO);
-}
-
-int main(int argc, char *argv[])
+TEST(futex_wait_wouldblock)
 {
 	struct timespec to =3D {.tv_sec =3D 0, .tv_nsec =3D timeout_ns};
 	futex_t f1 =3D FUTEX_INITIALIZER;
-	int res, ret =3D RET_PASS;
-	int c;
-	struct futex_waitv waitv =3D {
-			.uaddr =3D (uintptr_t)&f1,
-			.val =3D f1+1,
-			.flags =3D FUTEX_32,
-			.__reserved =3D 0
-		};
+	int res;
=20
-	while ((c =3D getopt(argc, argv, "cht:v:")) !=3D -1) {
-		switch (c) {
-		case 'c':
-			log_color(1);
-			break;
-		case 'h':
-			usage(basename(argv[0]));
-			exit(0);
-		case 'v':
-			log_verbosity(atoi(optarg));
-			break;
-		default:
-			usage(basename(argv[0]));
-			exit(1);
-		}
-	}
-
-	ksft_print_header();
-	ksft_set_plan(2);
-	ksft_print_msg("%s: Test the unexpected futex value in FUTEX_WAIT\n",
-	       basename(argv[0]));
-
-	info("Calling futex_wait on f1: %u @ %p with val=3D%u\n", f1, &f1, f1+1);
+	ksft_print_dbg_msg("Calling futex_wait on f1: %u @ %p with val=3D%u\n", f1,=
 &f1, f1+1);
 	res =3D futex_wait(&f1, f1+1, &to, FUTEX_PRIVATE_FLAG);
 	if (!res || errno !=3D EWOULDBLOCK) {
 		ksft_test_result_fail("futex_wait returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret =3D RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_wait\n");
 	}
+}
=20
-	if (clock_gettime(CLOCK_MONOTONIC, &to)) {
-		error("clock_gettime failed\n", errno);
-		return errno;
-	}
+TEST(futex_waitv_wouldblock)
+{
+	struct timespec to =3D {.tv_sec =3D 0, .tv_nsec =3D timeout_ns};
+	futex_t f1 =3D FUTEX_INITIALIZER;
+	struct futex_waitv waitv =3D {
+		.uaddr		=3D (uintptr_t)&f1,
+		.val		=3D f1 + 1,
+		.flags		=3D FUTEX_32,
+		.__reserved	=3D 0,
+	};
+	int res;
+
+	if (clock_gettime(CLOCK_MONOTONIC, &to))
+		ksft_exit_fail_msg("clock_gettime failed %d\n", errno);
=20
 	to.tv_nsec +=3D timeout_ns;
=20
@@ -95,17 +67,15 @@ int main(int argc, char *argv[])
 		to.tv_nsec -=3D 1000000000;
 	}
=20
-	info("Calling futex_waitv on f1: %u @ %p with val=3D%u\n", f1, &f1, f1+1);
+	ksft_print_dbg_msg("Calling futex_waitv on f1: %u @ %p with val=3D%u\n", f1=
, &f1, f1+1);
 	res =3D futex_waitv(&waitv, 1, 0, &to, CLOCK_MONOTONIC);
 	if (!res || errno !=3D EWOULDBLOCK) {
 		ksft_test_result_fail("futex_waitv returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret =3D RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_waitv\n");
 	}
-
-	ksft_print_cnts();
-	return ret;
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/=
selftests/futex/functional/run.sh
index 0af6950..a5246d5 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -44,7 +44,7 @@ echo
 ./futex_wait_timeout
=20
 echo
-./futex_wait_wouldblock $COLOR
+./futex_wait_wouldblock
=20
 echo
 ./futex_wait_uninitialized_heap $COLOR

