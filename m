Return-Path: <linux-tip-commits+bounces-6699-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 506B0B8CD4A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 18:30:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 35E297C7EE2
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 16:29:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 029D5307AD7;
	Sat, 20 Sep 2025 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="rTYZH1HY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="L2nPSBGc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A514B305E3F;
	Sat, 20 Sep 2025 16:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758385675; cv=none; b=Dmm28sQulyHqqRDRD9hRNLiLcLKSvZCnmrWm4E+8C9ySqMqcee35/4Df/moTY3D8/V54Beyn6s957pa/rOTpaTQjUE3zLNG2lbccM+XoBL95K/TuD1qDypfOxvPbTJGq8VGPwRnKgbydhzXCCKLQ+IsCW6ehmeHlePnEGz9nBIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758385675; c=relaxed/simple;
	bh=9Bkiq2s9X+PQa+E0SfvCnShvcQGtPrj9fUqXamz6eCg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=LGs4/3oLjtJibDTWZHLVJlhm28C0jRwi4RODv4qnzS3Jq6qoKh+lex0zK1IvT7miePpbLtwdzIBJSuVPZM8ydqDXawe5QefHUEsqwzL69uou4/0Kb9ZYH4iWfzo9dEOf9BoV5Jbo8Be8amOYzEjIqXiO3WnJULtYoaAktbV2wHg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=rTYZH1HY; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=L2nPSBGc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 20 Sep 2025 16:27:50 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758385672;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQywxqkz89nXpIHexFTiWz0n1o8apeEiK7h8QovnIBs=;
	b=rTYZH1HYrb7/2MMHS5Qxj0s070U3Gq1XT5+TPjOYV8sG9lSt2ahdBHuJS5wryqA/C59b9L
	wgnoqIgc0aUvjV9w/Yab9XShMh3E7cJNPczTTm2QVtoy+VU1UkyiCxvbZzG9gHvrJ8HHSi
	63uDcmVc256EgCMreW8aqUjHbMbezxlzLSSTdGw99ENxLHIwj8suSpa3Px3lxih/n30TkH
	4IiIpxW2YaRKOFWnpJQ9khU6HoNc1M8lRAzzkhQEeVtKyNaaw2W7mNhKbDe2fY/3qMjtp5
	9cVppDSPLZ/5R93eW9/ElSn4hB+Y+eNFo7uDnsE5ul9AO5ATsRtg+atml9eydg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758385672;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZQywxqkz89nXpIHexFTiWz0n1o8apeEiK7h8QovnIBs=;
	b=L2nPSBGcJfrQrHOtnnavIjw6JHaSPcT+M2sEfMHORbIEpIo0DhY3iiNr5lp++fDbQXIYLr
	Y6zpF5YakLUJy9Bg==
From: tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] selftests/futex: Refactor futex_wait_timeout
 with kselftest_harness.h
Cc: andrealmeid@igalia.com, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250917-tonyk-robust_test_cleanup-v3-5-306b373c244d@igalia.com>
References: <20250917-tonyk-robust_test_cleanup-v3-5-306b373c244d@igalia.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175838567089.709179.4382462202737324354.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     0c02abf6389e01a3b78091394bc9624d5f1d84fb
Gitweb:        https://git.kernel.org/tip/0c02abf6389e01a3b78091394bc9624d5f1=
d84fb
Author:        Andr=C3=A9 Almeida <andrealmeid@igalia.com>
AuthorDate:    Wed, 17 Sep 2025 18:21:44 -03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 20 Sep 2025 18:11:54 +02:00

selftests/futex: Refactor futex_wait_timeout with kselftest_harness.h

To reduce the boilerplate code, refactor futex_wait_timeout test to use
kselftest_harness header instead of futex's logging header.

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/testing/selftests/futex/functional/futex_wait_timeout.c | 139 +++----
 tools/testing/selftests/futex/functional/run.sh               |   2 +-
 2 files changed, 61 insertions(+), 80 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait_timeout.c b/=
tools/testing/selftests/futex/functional/futex_wait_timeout.c
index d183f87..0c8766a 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_timeout.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
@@ -16,26 +16,15 @@
  ***************************************************************************=
**/
=20
 #include <pthread.h>
+
 #include "futextest.h"
 #include "futex2test.h"
-#include "logging.h"
-
-#define TEST_NAME "futex-wait-timeout"
+#include "../../kselftest_harness.h"
=20
 static long timeout_ns =3D 100000;	/* 100us default timeout */
 static futex_t futex_pi;
 static pthread_barrier_t barrier;
=20
-void usage(char *prog)
-{
-	printf("Usage: %s\n", prog);
-	printf("  -c	Use color\n");
-	printf("  -h	Display this help message\n");
-	printf("  -t N	Timeout in nanoseconds (default: 100,000)\n");
-	printf("  -v L	Verbosity level: %d=3DQUIET %d=3DCRITICAL %d=3DINFO\n",
-	       VQUIET, VCRITICAL, VINFO);
-}
-
 /*
  * Get a PI lock and hold it forever, so the main thread lock_pi will block
  * and we can test the timeout
@@ -47,13 +36,13 @@ void *get_pi_lock(void *arg)
=20
 	ret =3D futex_lock_pi(&futex_pi, NULL, 0, 0);
 	if (ret !=3D 0)
-		error("futex_lock_pi failed\n", ret);
+		ksft_exit_fail_msg("futex_lock_pi failed\n");
=20
 	pthread_barrier_wait(&barrier);
=20
 	/* Blocks forever */
 	ret =3D futex_wait(&lock, 0, NULL, 0);
-	error("futex_wait failed\n", ret);
+	ksft_exit_fail_msg("futex_wait failed\n");
=20
 	return NULL;
 }
@@ -61,12 +50,11 @@ void *get_pi_lock(void *arg)
 /*
  * Check if the function returned the expected error
  */
-static void test_timeout(int res, int *ret, char *test_name, int err)
+static void test_timeout(int res, char *test_name, int err)
 {
 	if (!res || errno !=3D err) {
 		ksft_test_result_fail("%s returned %d\n", test_name,
 				      res < 0 ? errno : res);
-		*ret =3D RET_FAIL;
 	} else {
 		ksft_test_result_pass("%s succeeds\n", test_name);
 	}
@@ -78,10 +66,8 @@ static void test_timeout(int res, int *ret, char *test_nam=
e, int err)
 static int futex_get_abs_timeout(clockid_t clockid, struct timespec *to,
 				 long timeout_ns)
 {
-	if (clock_gettime(clockid, to)) {
-		error("clock_gettime failed\n", errno);
-		return errno;
-	}
+	if (clock_gettime(clockid, to))
+		ksft_exit_fail_msg("clock_gettime failed\n");
=20
 	to->tv_nsec +=3D timeout_ns;
=20
@@ -93,83 +79,66 @@ static int futex_get_abs_timeout(clockid_t clockid, struc=
t timespec *to,
 	return 0;
 }
=20
-int main(int argc, char *argv[])
+TEST(wait_bitset)
 {
 	futex_t f1 =3D FUTEX_INITIALIZER;
-	int res, ret =3D RET_PASS;
 	struct timespec to;
-	pthread_t thread;
-	int c;
-	struct futex_waitv waitv =3D {
-			.uaddr =3D (uintptr_t)&f1,
-			.val =3D f1,
-			.flags =3D FUTEX_32,
-			.__reserved =3D 0
-		};
-
-	while ((c =3D getopt(argc, argv, "cht:v:")) !=3D -1) {
-		switch (c) {
-		case 'c':
-			log_color(1);
-			break;
-		case 'h':
-			usage(basename(argv[0]));
-			exit(0);
-		case 't':
-			timeout_ns =3D atoi(optarg);
-			break;
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
-	ksft_set_plan(9);
-	ksft_print_msg("%s: Block on a futex and wait for timeout\n",
-	       basename(argv[0]));
-	ksft_print_msg("\tArguments: timeout=3D%ldns\n", timeout_ns);
-
-	pthread_barrier_init(&barrier, NULL, 2);
-	pthread_create(&thread, NULL, get_pi_lock, NULL);
+	int res;
=20
 	/* initialize relative timeout */
 	to.tv_sec =3D 0;
 	to.tv_nsec =3D timeout_ns;
=20
 	res =3D futex_wait(&f1, f1, &to, 0);
-	test_timeout(res, &ret, "futex_wait relative", ETIMEDOUT);
+	test_timeout(res, "futex_wait relative", ETIMEDOUT);
=20
 	/* FUTEX_WAIT_BITSET with CLOCK_REALTIME */
 	if (futex_get_abs_timeout(CLOCK_REALTIME, &to, timeout_ns))
-		return RET_FAIL;
+		ksft_test_result_error("get_time error");
 	res =3D futex_wait_bitset(&f1, f1, &to, 1, FUTEX_CLOCK_REALTIME);
-	test_timeout(res, &ret, "futex_wait_bitset realtime", ETIMEDOUT);
+	test_timeout(res, "futex_wait_bitset realtime", ETIMEDOUT);
=20
 	/* FUTEX_WAIT_BITSET with CLOCK_MONOTONIC */
 	if (futex_get_abs_timeout(CLOCK_MONOTONIC, &to, timeout_ns))
-		return RET_FAIL;
+		ksft_test_result_error("get_time error");
 	res =3D futex_wait_bitset(&f1, f1, &to, 1, 0);
-	test_timeout(res, &ret, "futex_wait_bitset monotonic", ETIMEDOUT);
+	test_timeout(res, "futex_wait_bitset monotonic", ETIMEDOUT);
+}
+
+TEST(requeue_pi)
+{
+	futex_t f1 =3D FUTEX_INITIALIZER;
+	struct timespec to;
+	int res;
=20
 	/* FUTEX_WAIT_REQUEUE_PI with CLOCK_REALTIME */
 	if (futex_get_abs_timeout(CLOCK_REALTIME, &to, timeout_ns))
-		return RET_FAIL;
+		ksft_test_result_error("get_time error");
 	res =3D futex_wait_requeue_pi(&f1, f1, &futex_pi, &to, FUTEX_CLOCK_REALTIME=
);
-	test_timeout(res, &ret, "futex_wait_requeue_pi realtime", ETIMEDOUT);
+	test_timeout(res, "futex_wait_requeue_pi realtime", ETIMEDOUT);
=20
 	/* FUTEX_WAIT_REQUEUE_PI with CLOCK_MONOTONIC */
 	if (futex_get_abs_timeout(CLOCK_MONOTONIC, &to, timeout_ns))
-		return RET_FAIL;
+		ksft_test_result_error("get_time error");
 	res =3D futex_wait_requeue_pi(&f1, f1, &futex_pi, &to, 0);
-	test_timeout(res, &ret, "futex_wait_requeue_pi monotonic", ETIMEDOUT);
+	test_timeout(res, "futex_wait_requeue_pi monotonic", ETIMEDOUT);
+
+}
+
+TEST(lock_pi)
+{
+	struct timespec to;
+	pthread_t thread;
+	int res;
+
+	/* Create a thread that will lock forever so any waiter will timeout */
+	pthread_barrier_init(&barrier, NULL, 2);
+	pthread_create(&thread, NULL, get_pi_lock, NULL);
=20
 	/* Wait until the other thread calls futex_lock_pi() */
 	pthread_barrier_wait(&barrier);
 	pthread_barrier_destroy(&barrier);
+
 	/*
 	 * FUTEX_LOCK_PI with CLOCK_REALTIME
 	 * Due to historical reasons, FUTEX_LOCK_PI supports only realtime
@@ -181,26 +150,38 @@ int main(int argc, char *argv[])
 	 * smaller than realtime and the syscall will timeout immediately.
 	 */
 	if (futex_get_abs_timeout(CLOCK_REALTIME, &to, timeout_ns))
-		return RET_FAIL;
+		ksft_test_result_error("get_time error");
 	res =3D futex_lock_pi(&futex_pi, &to, 0, 0);
-	test_timeout(res, &ret, "futex_lock_pi realtime", ETIMEDOUT);
+	test_timeout(res, "futex_lock_pi realtime", ETIMEDOUT);
=20
 	/* Test operations that don't support FUTEX_CLOCK_REALTIME */
 	res =3D futex_lock_pi(&futex_pi, NULL, 0, FUTEX_CLOCK_REALTIME);
-	test_timeout(res, &ret, "futex_lock_pi invalid timeout flag", ENOSYS);
+	test_timeout(res, "futex_lock_pi invalid timeout flag", ENOSYS);
+}
+
+TEST(waitv)
+{
+	futex_t f1 =3D FUTEX_INITIALIZER;
+	struct futex_waitv waitv =3D {
+		.uaddr		=3D (uintptr_t)&f1,
+		.val		=3D f1,
+		.flags		=3D FUTEX_32,
+		.__reserved	=3D 0,
+	};
+	struct timespec to;
+	int res;
=20
 	/* futex_waitv with CLOCK_MONOTONIC */
 	if (futex_get_abs_timeout(CLOCK_MONOTONIC, &to, timeout_ns))
-		return RET_FAIL;
+		ksft_test_result_error("get_time error");
 	res =3D futex_waitv(&waitv, 1, 0, &to, CLOCK_MONOTONIC);
-	test_timeout(res, &ret, "futex_waitv monotonic", ETIMEDOUT);
+	test_timeout(res, "futex_waitv monotonic", ETIMEDOUT);
=20
 	/* futex_waitv with CLOCK_REALTIME */
 	if (futex_get_abs_timeout(CLOCK_REALTIME, &to, timeout_ns))
-		return RET_FAIL;
+		ksft_test_result_error("get_time error");
 	res =3D futex_waitv(&waitv, 1, 0, &to, CLOCK_REALTIME);
-	test_timeout(res, &ret, "futex_waitv realtime", ETIMEDOUT);
-
-	ksft_print_cnts();
-	return ret;
+	test_timeout(res, "futex_waitv realtime", ETIMEDOUT);
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/=
selftests/futex/functional/run.sh
index 6d48a7e..0af6950 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -41,7 +41,7 @@ echo
 ./futex_requeue_pi_signal_restart
=20
 echo
-./futex_wait_timeout $COLOR
+./futex_wait_timeout
=20
 echo
 ./futex_wait_wouldblock $COLOR

