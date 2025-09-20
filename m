Return-Path: <linux-tip-commits+bounces-6696-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id AC62DB8CD23
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 18:28:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 923594E165E
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 16:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AEA58305963;
	Sat, 20 Sep 2025 16:27:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="b6O34Hjw";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="/EkspJxM"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E07DE304BC6;
	Sat, 20 Sep 2025 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758385672; cv=none; b=RTL4x7uyeo2+ue8gpz1IiaWyKxbg8azY9CEjSOsh9DUYjGBkDHOHl2fK/LBjjSSS/HLFv1pt+mNzUFzj3x6ohl7qO2k5i466QdrinidDHhn0zqFgO9C26JHsOg/o9OyKvtA67uPCpo7Ndp8UD9L9Mezp3fSmnlt1lj4FAOl1PQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758385672; c=relaxed/simple;
	bh=V/wD2FYwRxw50iA1lPpbxHkHqIOW4ThCT5/iaCu9dns=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Vloxi/wqwIsp+9IJsB7s6OhujHs+2jwpREY3/u7Vb8GVBNA7r+nBP61WlIC03M3CIOAcDwOM3jOUOXXMwkLr69woDY2ECi64yjlCNaLCQw1GGUrkGpnWn24APYfGbhuKtvtJZhSgFrd2ygKIpQLsTB9ViqHVK4RUlZiUQ+UeZ10=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=b6O34Hjw; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=/EkspJxM; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 20 Sep 2025 16:27:47 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758385668;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w0fUanBeL+Wxwis/Pg3zl3cFEz1ZOgaPOcx2QTyZO7Y=;
	b=b6O34Hjw5ZZ3OllXw7kRvrR2oT4/E4TetZw+g26ul1kPABvmqR7fuYM87ZLmw57O6zgm9Z
	Zy/OF8rIIXhVwXN6roJQOEVGSyIWDVtoK6dOvPymsgIWIZ57cfbwvPtHJN2RBCJxxuQZkf
	7SEJCJ37/9YXXiO08sFc9lw3alMYPzgAMuyb1uJU5POu87EZo1qbiBkVWGPl+3D/vaoSTf
	64mGyClOPtphDyy+Gvt1b3vXmsw3V2Of/YkwOz/5zUJHsFTE5dpU0qsxQhH4qWqygudq8W
	D3qxKdLMAB1cgoRsEag1BepWcw8nY3KjM8A2q7804RGE1U+qgW2YDFHbQD5Shw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758385668;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=w0fUanBeL+Wxwis/Pg3zl3cFEz1ZOgaPOcx2QTyZO7Y=;
	b=/EkspJxM95X69xDIEdGHZxIJ6DQ7S+INSUB4noDaNZJ116Pi35NCK3HzNiDYlJOVmeP5yj
	tTR4GCpfqj3SkzCA==
From: tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] selftests/futex: Refactor
 futex_wait_private_mapped_file with kselftest_harness.h
Cc: andrealmeid@igalia.com, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250917-tonyk-robust_test_cleanup-v3-8-306b373c244d@igalia.com>
References: <20250917-tonyk-robust_test_cleanup-v3-8-306b373c244d@igalia.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175838566761.709179.11399112230131123761.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     14d016bd72822c0464e9aed4b6a620474923818d
Gitweb:        https://git.kernel.org/tip/14d016bd72822c0464e9aed4b6a62047492=
3818d
Author:        Andr=C3=A9 Almeida <andrealmeid@igalia.com>
AuthorDate:    Wed, 17 Sep 2025 18:21:47 -03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 20 Sep 2025 18:11:54 +02:00

selftests/futex: Refactor futex_wait_private_mapped_file with kselftest_harne=
ss.h

To reduce the boilerplate code, refactor futex_wait_private_mapped_file
test to use kselftest_harness header instead of futex's logging header.

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/testing/selftests/futex/functional/futex_wait_private_mapped_file.c | =
83 ++++++++++++++++------------------------------------------------------
 tools/testing/selftests/futex/functional/run.sh                           | =
 2 +-
 2 files changed, 21 insertions(+), 64 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait_private_mapp=
ed_file.c b/tools/testing/selftests/futex/functional/futex_wait_private_mappe=
d_file.c
index fb4148f..8952ebd 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_private_mapped_file=
.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_private_mapped_file=
.c
@@ -27,10 +27,9 @@
 #include <libgen.h>
 #include <signal.h>
=20
-#include "logging.h"
 #include "futextest.h"
+#include "../../kselftest_harness.h"
=20
-#define TEST_NAME "futex-wait-private-mapped-file"
 #define PAGE_SZ 4096
=20
 char pad[PAGE_SZ] =3D {1};
@@ -40,86 +39,44 @@ char pad2[PAGE_SZ] =3D {1};
 #define WAKE_WAIT_US 3000000
 struct timespec wait_timeout =3D { .tv_sec =3D 5, .tv_nsec =3D 0};
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
 void *thr_futex_wait(void *arg)
 {
 	int ret;
=20
-	info("futex wait\n");
+	ksft_print_dbg_msg("futex wait\n");
 	ret =3D futex_wait(&val, 1, &wait_timeout, 0);
-	if (ret && errno !=3D EWOULDBLOCK && errno !=3D ETIMEDOUT) {
-		error("futex error.\n", errno);
-		print_result(TEST_NAME, RET_ERROR);
-		exit(RET_ERROR);
-	}
+	if (ret && errno !=3D EWOULDBLOCK && errno !=3D ETIMEDOUT)
+		ksft_exit_fail_msg("futex error.\n");
=20
 	if (ret && errno =3D=3D ETIMEDOUT)
-		fail("waiter timedout\n");
+		ksft_exit_fail_msg("waiter timedout\n");
=20
-	info("futex_wait: ret =3D %d, errno =3D %d\n", ret, errno);
+	ksft_print_dbg_msg("futex_wait: ret =3D %d, errno =3D %d\n", ret, errno);
=20
 	return NULL;
 }
=20
-int main(int argc, char **argv)
+TEST(wait_private_mapped_file)
 {
 	pthread_t thr;
-	int ret =3D RET_PASS;
 	int res;
-	int c;
-
-	while ((c =3D getopt(argc, argv, "chv:")) !=3D -1) {
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
-	ksft_set_plan(1);
-	ksft_print_msg(
-		"%s: Test the futex value of private file mappings in FUTEX_WAIT\n",
-		basename(argv[0]));
-
-	ret =3D pthread_create(&thr, NULL, thr_futex_wait, NULL);
-	if (ret < 0) {
-		fprintf(stderr, "pthread_create error\n");
-		ret =3D RET_ERROR;
-		goto out;
-	}
-
-	info("wait a while\n");
+
+	res =3D pthread_create(&thr, NULL, thr_futex_wait, NULL);
+	if (res < 0)
+		ksft_exit_fail_msg("pthread_create error\n");
+
+	ksft_print_dbg_msg("wait a while\n");
 	usleep(WAKE_WAIT_US);
 	val =3D 2;
 	res =3D futex_wake(&val, 1, 0);
-	info("futex_wake %d\n", res);
-	if (res !=3D 1) {
-		fail("FUTEX_WAKE didn't find the waiting thread.\n");
-		ret =3D RET_FAIL;
-	}
+	ksft_print_dbg_msg("futex_wake %d\n", res);
+	if (res !=3D 1)
+		ksft_exit_fail_msg("FUTEX_WAKE didn't find the waiting thread.\n");
=20
-	info("join\n");
+	ksft_print_dbg_msg("join\n");
 	pthread_join(thr, NULL);
=20
- out:
-	print_result(TEST_NAME, ret);
-	return ret;
+	ksft_test_result_pass("wait_private_mapped_file");
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/=
selftests/futex/functional/run.sh
index 6cb07a4..87666f2 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -48,7 +48,7 @@ echo
=20
 echo
 ./futex_wait_uninitialized_heap
-./futex_wait_private_mapped_file $COLOR
+./futex_wait_private_mapped_file
=20
 echo
 ./futex_wait $COLOR

