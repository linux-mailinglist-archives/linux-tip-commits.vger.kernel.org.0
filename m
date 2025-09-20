Return-Path: <linux-tip-commits+bounces-6693-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id CDA9DB8CD14
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 18:28:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 35D524E1677
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 16:28:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B981D303A2A;
	Sat, 20 Sep 2025 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="uKdy0jIc";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fT2ISNML"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85E6830216B;
	Sat, 20 Sep 2025 16:27:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758385669; cv=none; b=RyN+yfKcZ3zZyKqg1z66adLgrPlO+GLEdGO6E3f7rkRWaF2/lRy+Xd9VH0cOJw599hnuaWx7j7j7X2yl4roVkm5YO6/AhPD3Gbh2eV5rLNB3bHBWSltuy1rolHKJQkfACBYb+dP5/kB6RWr/oV29Ct3SKnYfmYNOM14zC2Opr24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758385669; c=relaxed/simple;
	bh=Lz9ZPS+D4xn92kJH8T4zx/FPq/ZIinCI86Gm9tjEuxI=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=m2eZlaJBufDk49RvzDNcxKcpR05Gjba1gRlxJmwiYPPOIdcERgtd6xgiwc6Z/hfmUsyHmCSAF/jcGt6dylkKvpzmKSUilEp/Kqy+A5JefhUiU7B8yF52zASOZxa7T5U7BpHc9DabUVw3aJOUFWLtc3qByiN4YvO1Dt518ZJcExk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=uKdy0jIc; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fT2ISNML; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 20 Sep 2025 16:27:44 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758385665;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8crrU/dO19LSJiqPYFgiK9Jy6TbjJbVXcFHeK0J12Jw=;
	b=uKdy0jIcGBhnohSsGmE2Bb4dpPZa5jPLGG1WoYns3wp7oPfvHsjZIsEjLJbz7UCO35qYOR
	1yQvRBSe4bllfsyIMa1hqYkuS0eJW20V1OsF6dhTM7IkGOC/BjMp54QlbeMd+ERkgzITGa
	7cqIxS2xwIQvtfJWPr1wl72M0k+dEpa+Eok6wE0DLEQlwH+HsGi8mRGgD6r5i6vq6lvCWS
	r0sKXH+VO/g76idfHIKmOZ1+wJOE8KyWBlYylzKpkWLOSx9rJQ1+mEox4q2qO2cKKY/j8e
	enM0btTIpdbRAb65SJtp4yaBKVnVaAGZ4oCtzoWuX0wZujNkrLlpKHqgC1HMkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758385665;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8crrU/dO19LSJiqPYFgiK9Jy6TbjJbVXcFHeK0J12Jw=;
	b=fT2ISNMLMBbNNxOmp1NC2ao/4AbsrKCjJa9qF1qV613NZalawRU7MAG7Ma8Gm0JQiON+ti
	/LPdwsRvJBSleABw==
From: tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] selftests/futex: Refactor futex_waitv with
 kselftest_harness.h
Cc: andrealmeid@igalia.com, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20250917-tonyk-robust_test_cleanup-v3-11-306b373c244d@igalia.com>
References: <20250917-tonyk-robust_test_cleanup-v3-11-306b373c244d@igalia.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175838566433.709179.15528388899396076146.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     a91e8e372e4f1ecce2a87905d4fa437865158b1e
Gitweb:        https://git.kernel.org/tip/a91e8e372e4f1ecce2a87905d4fa4378651=
58b1e
Author:        Andr=C3=A9 Almeida <andrealmeid@igalia.com>
AuthorDate:    Wed, 17 Sep 2025 18:21:50 -03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 20 Sep 2025 18:11:55 +02:00

selftests/futex: Refactor futex_waitv with kselftest_harness.h

To reduce the boilerplate code, refactor futex_waitv test to use
kselftest_harness header instead of futex's logging header.

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/testing/selftests/futex/functional/futex_waitv.c |  99 +++-----
 tools/testing/selftests/futex/functional/run.sh        |   2 +-
 2 files changed, 45 insertions(+), 56 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_waitv.c b/tools/t=
esting/selftests/futex/functional/futex_waitv.c
index a94337f..c684b10 100644
--- a/tools/testing/selftests/futex/functional/futex_waitv.c
+++ b/tools/testing/selftests/futex/functional/futex_waitv.c
@@ -15,25 +15,16 @@
 #include <pthread.h>
 #include <stdint.h>
 #include <sys/shm.h>
+
 #include "futextest.h"
 #include "futex2test.h"
-#include "logging.h"
+#include "../../kselftest_harness.h"
=20
-#define TEST_NAME "futex-wait"
 #define WAKE_WAIT_US 10000
 #define NR_FUTEXES 30
 static struct futex_waitv waitv[NR_FUTEXES];
 u_int32_t futexes[NR_FUTEXES] =3D {0};
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
 void *waiterfn(void *arg)
 {
 	struct timespec to;
@@ -41,7 +32,7 @@ void *waiterfn(void *arg)
=20
 	/* setting absolute timeout for futex2 */
 	if (clock_gettime(CLOCK_MONOTONIC, &to))
-		error("gettime64 failed\n", errno);
+		ksft_exit_fail_msg("gettime64 failed\n");
=20
 	to.tv_sec++;
=20
@@ -57,34 +48,10 @@ void *waiterfn(void *arg)
 	return NULL;
 }
=20
-int main(int argc, char *argv[])
+TEST(private_waitv)
 {
 	pthread_t waiter;
-	int res, ret =3D RET_PASS;
-	struct timespec to;
-	int c, i;
-
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
-	ksft_set_plan(7);
-	ksft_print_msg("%s: Test FUTEX_WAITV\n",
-		       basename(argv[0]));
+	int res, i;
=20
 	for (i =3D 0; i < NR_FUTEXES; i++) {
 		waitv[i].uaddr =3D (uintptr_t)&futexes[i];
@@ -95,7 +62,7 @@ int main(int argc, char *argv[])
=20
 	/* Private waitv */
 	if (pthread_create(&waiter, NULL, waiterfn, NULL))
-		error("pthread_create failed\n", errno);
+		ksft_exit_fail_msg("pthread_create failed\n");
=20
 	usleep(WAKE_WAIT_US);
=20
@@ -104,10 +71,15 @@ int main(int argc, char *argv[])
 		ksft_test_result_fail("futex_wake private returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret =3D RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_waitv private\n");
 	}
+}
+
+TEST(shared_waitv)
+{
+	pthread_t waiter;
+	int res, i;
=20
 	/* Shared waitv */
 	for (i =3D 0; i < NR_FUTEXES; i++) {
@@ -128,7 +100,7 @@ int main(int argc, char *argv[])
 	}
=20
 	if (pthread_create(&waiter, NULL, waiterfn, NULL))
-		error("pthread_create failed\n", errno);
+		ksft_exit_fail_msg("pthread_create failed\n");
=20
 	usleep(WAKE_WAIT_US);
=20
@@ -137,19 +109,24 @@ int main(int argc, char *argv[])
 		ksft_test_result_fail("futex_wake shared returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret =3D RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_waitv shared\n");
 	}
=20
 	for (i =3D 0; i < NR_FUTEXES; i++)
 		shmdt(u64_to_ptr(waitv[i].uaddr));
+}
+
+TEST(invalid_flag)
+{
+	struct timespec to;
+	int res;
=20
 	/* Testing a waiter without FUTEX_32 flag */
 	waitv[0].flags =3D FUTEX_PRIVATE_FLAG;
=20
 	if (clock_gettime(CLOCK_MONOTONIC, &to))
-		error("gettime64 failed\n", errno);
+		ksft_exit_fail_msg("gettime64 failed\n");
=20
 	to.tv_sec++;
=20
@@ -158,17 +135,22 @@ int main(int argc, char *argv[])
 		ksft_test_result_fail("futex_waitv private returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret =3D RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_waitv without FUTEX_32\n");
 	}
+}
+
+TEST(unaligned_address)
+{
+	struct timespec to;
+	int res;
=20
 	/* Testing a waiter with an unaligned address */
 	waitv[0].flags =3D FUTEX_PRIVATE_FLAG | FUTEX_32;
 	waitv[0].uaddr =3D 1;
=20
 	if (clock_gettime(CLOCK_MONOTONIC, &to))
-		error("gettime64 failed\n", errno);
+		ksft_exit_fail_msg("gettime64 failed\n");
=20
 	to.tv_sec++;
=20
@@ -177,16 +159,21 @@ int main(int argc, char *argv[])
 		ksft_test_result_fail("futex_wake private returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret =3D RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_waitv with an unaligned address\n");
 	}
+}
+
+TEST(null_address)
+{
+	struct timespec to;
+	int res;
=20
 	/* Testing a NULL address for waiters.uaddr */
 	waitv[0].uaddr =3D 0x00000000;
=20
 	if (clock_gettime(CLOCK_MONOTONIC, &to))
-		error("gettime64 failed\n", errno);
+		ksft_exit_fail_msg("gettime64 failed\n");
=20
 	to.tv_sec++;
=20
@@ -195,14 +182,13 @@ int main(int argc, char *argv[])
 		ksft_test_result_fail("futex_waitv private returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret =3D RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_waitv NULL address in waitv.uaddr\n");
 	}
=20
 	/* Testing a NULL address for *waiters */
 	if (clock_gettime(CLOCK_MONOTONIC, &to))
-		error("gettime64 failed\n", errno);
+		ksft_exit_fail_msg("gettime64 failed\n");
=20
 	to.tv_sec++;
=20
@@ -211,14 +197,19 @@ int main(int argc, char *argv[])
 		ksft_test_result_fail("futex_waitv private returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret =3D RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_waitv NULL address in *waiters\n");
 	}
+}
+
+TEST(invalid_clockid)
+{
+	struct timespec to;
+	int res;
=20
 	/* Testing an invalid clockid */
 	if (clock_gettime(CLOCK_MONOTONIC, &to))
-		error("gettime64 failed\n", errno);
+		ksft_exit_fail_msg("gettime64 failed\n");
=20
 	to.tv_sec++;
=20
@@ -227,11 +218,9 @@ int main(int argc, char *argv[])
 		ksft_test_result_fail("futex_waitv private returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret =3D RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_waitv invalid clockid\n");
 	}
-
-	ksft_print_cnts();
-	return ret;
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/=
selftests/futex/functional/run.sh
index b711351..4a7b0ef 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -57,7 +57,7 @@ echo
 ./futex_requeue
=20
 echo
-./futex_waitv $COLOR
+./futex_waitv
=20
 echo
 ./futex_priv_hash $COLOR

