Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E26337EDDA
	for <lists+linux-tip-commits@lfdr.de>; Thu, 13 May 2021 00:53:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1382473AbhELUza (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 12 May 2021 16:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359630AbhELSxm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 12 May 2021 14:53:42 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7F6FC0613ED;
        Wed, 12 May 2021 11:50:09 -0700 (PDT)
Date:   Wed, 12 May 2021 18:50:07 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1620845408;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yrZEYGg22iU4PvAHomrgotrJaJDq0HrQ0SHNi3BqUn0=;
        b=Tu581bm1Fo8avpJPMxJbPRTTcVzH1NMobr8kIYXalzkQhAthLmrS8rLT0uH77RQd6asdk2
        c5BfN7ZW/UtNquq9aeYHPwU9vwCJYRxSxRsREDHRB2UPSIygBxprPBDTCeSxPC8VaF/ln2
        jt0BXz6FGE2HnbUw9Ot+9Hjw9G+hyblcC727grkJAUf8JJxyZGHJLus3prKOTi1VCRwn5P
        aJzv4RagqmNUybgrJ4G56LUNz2vFaBYHE5RZ1aOBka0MPQ4X4t8zPkSEbj3HJi2g8UX/gA
        drqsS+VsCTlkJgGfLWKXhsSMwW9Z61qaM3JpdBS99hX7XCksvhHKD519T0gPAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1620845408;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yrZEYGg22iU4PvAHomrgotrJaJDq0HrQ0SHNi3BqUn0=;
        b=J/gpcuHXS32tjbFO00E3Aija/ztTOAFv5cfRqc4SsZLxl+8b2rzpXCfVl1DGzoWQzF9hn3
        tRDfHnQptrZ7I1Bw==
From:   tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] selftests: futex: Expand timeout test
Cc:     andrealmeid@collabora.com, Ingo Molnar <mingo@kernel.org>,
        x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20210427135328.11013-3-andrealmeid@collabora.com>
References: <20210427135328.11013-3-andrealmeid@collabora.com>
MIME-Version: 1.0
Message-ID: <162084540749.29796.13674112601731526898.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     f4addd54b1617067f735ad194a3580a2db7b8bf5
Gitweb:        https://git.kernel.org/tip/f4addd54b1617067f735ad194a3580a2db7=
b8bf5
Author:        Andr=C3=A9 Almeida <andrealmeid@collabora.com>
AuthorDate:    Tue, 27 Apr 2021 10:53:28 -03:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Wed, 12 May 2021 20:44:59 +02:00

selftests: futex: Expand timeout test

Improve futex timeout testing by checking all the operations that
supports timeout and their available modes.

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/20210427135328.11013-3-andrealmeid@collabora.=
com
---
 tools/testing/selftests/futex/functional/futex_wait_timeout.c | 126 ++++++-
 1 file changed, 110 insertions(+), 16 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait_timeout.c b/=
tools/testing/selftests/futex/functional/futex_wait_timeout.c
index ee55e6d..1f8f6da 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_timeout.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_timeout.c
@@ -11,21 +11,18 @@
  *
  * HISTORY
  *      2009-Nov-6: Initial version by Darren Hart <dvhart@linux.intel.com>
+ *      2021-Apr-26: More test cases by Andr=C3=A9 Almeida <andrealmeid@coll=
abora.com>
  *
  ***************************************************************************=
**/
=20
-#include <errno.h>
-#include <getopt.h>
-#include <stdio.h>
-#include <stdlib.h>
-#include <string.h>
-#include <time.h>
+#include <pthread.h>
 #include "futextest.h"
 #include "logging.h"
=20
 #define TEST_NAME "futex-wait-timeout"
=20
 static long timeout_ns =3D 100000;	/* 100us default timeout */
+static futex_t futex_pi;
=20
 void usage(char *prog)
 {
@@ -37,11 +34,67 @@ void usage(char *prog)
 	       VQUIET, VCRITICAL, VINFO);
 }
=20
+/*
+ * Get a PI lock and hold it forever, so the main thread lock_pi will block
+ * and we can test the timeout
+ */
+void *get_pi_lock(void *arg)
+{
+	int ret;
+	volatile futex_t lock =3D 0;
+
+	ret =3D futex_lock_pi(&futex_pi, NULL, 0, 0);
+	if (ret !=3D 0)
+		error("futex_lock_pi failed\n", ret);
+
+	/* Blocks forever */
+	ret =3D futex_wait(&lock, 0, NULL, 0);
+	error("futex_wait failed\n", ret);
+
+	return NULL;
+}
+
+/*
+ * Check if the function returned the expected error
+ */
+static void test_timeout(int res, int *ret, char *test_name, int err)
+{
+	if (!res || errno !=3D err) {
+		ksft_test_result_fail("%s returned %d\n", test_name,
+				      res < 0 ? errno : res);
+		*ret =3D RET_FAIL;
+	} else {
+		ksft_test_result_pass("%s succeeds\n", test_name);
+	}
+}
+
+/*
+ * Calculate absolute timeout and correct overflow
+ */
+static int futex_get_abs_timeout(clockid_t clockid, struct timespec *to,
+				 long timeout_ns)
+{
+	if (clock_gettime(clockid, to)) {
+		error("clock_gettime failed\n", errno);
+		return errno;
+	}
+
+	to->tv_nsec +=3D timeout_ns;
+
+	if (to->tv_nsec >=3D 1000000000) {
+		to->tv_sec++;
+		to->tv_nsec -=3D 1000000000;
+	}
+
+	return 0;
+}
+
 int main(int argc, char *argv[])
 {
 	futex_t f1 =3D FUTEX_INITIALIZER;
-	struct timespec to;
 	int res, ret =3D RET_PASS;
+	struct timespec to;
+	pthread_t thread;
 	int c;
=20
 	while ((c =3D getopt(argc, argv, "cht:v:")) !=3D -1) {
@@ -65,22 +118,63 @@ int main(int argc, char *argv[])
 	}
=20
 	ksft_print_header();
-	ksft_set_plan(1);
+	ksft_set_plan(7);
 	ksft_print_msg("%s: Block on a futex and wait for timeout\n",
 	       basename(argv[0]));
 	ksft_print_msg("\tArguments: timeout=3D%ldns\n", timeout_ns);
=20
-	/* initialize timeout */
+	pthread_create(&thread, NULL, get_pi_lock, NULL);
+
+	/* initialize relative timeout */
 	to.tv_sec =3D 0;
 	to.tv_nsec =3D timeout_ns;
=20
-	info("Calling futex_wait on f1: %u @ %p\n", f1, &f1);
-	res =3D futex_wait(&f1, f1, &to, FUTEX_PRIVATE_FLAG);
-	if (!res || errno !=3D ETIMEDOUT) {
-		fail("futex_wait returned %d\n", ret < 0 ? errno : ret);
-		ret =3D RET_FAIL;
-	}
+	res =3D futex_wait(&f1, f1, &to, 0);
+	test_timeout(res, &ret, "futex_wait relative", ETIMEDOUT);
+
+	/* FUTEX_WAIT_BITSET with CLOCK_REALTIME */
+	if (futex_get_abs_timeout(CLOCK_REALTIME, &to, timeout_ns))
+		return RET_FAIL;
+	res =3D futex_wait_bitset(&f1, f1, &to, 1, FUTEX_CLOCK_REALTIME);
+	test_timeout(res, &ret, "futex_wait_bitset realtime", ETIMEDOUT);
+
+	/* FUTEX_WAIT_BITSET with CLOCK_MONOTONIC */
+	if (futex_get_abs_timeout(CLOCK_MONOTONIC, &to, timeout_ns))
+		return RET_FAIL;
+	res =3D futex_wait_bitset(&f1, f1, &to, 1, 0);
+	test_timeout(res, &ret, "futex_wait_bitset monotonic", ETIMEDOUT);
+
+	/* FUTEX_WAIT_REQUEUE_PI with CLOCK_REALTIME */
+	if (futex_get_abs_timeout(CLOCK_REALTIME, &to, timeout_ns))
+		return RET_FAIL;
+	res =3D futex_wait_requeue_pi(&f1, f1, &futex_pi, &to, FUTEX_CLOCK_REALTIME=
);
+	test_timeout(res, &ret, "futex_wait_requeue_pi realtime", ETIMEDOUT);
+
+	/* FUTEX_WAIT_REQUEUE_PI with CLOCK_MONOTONIC */
+	if (futex_get_abs_timeout(CLOCK_MONOTONIC, &to, timeout_ns))
+		return RET_FAIL;
+	res =3D futex_wait_requeue_pi(&f1, f1, &futex_pi, &to, 0);
+	test_timeout(res, &ret, "futex_wait_requeue_pi monotonic", ETIMEDOUT);
+
+	/*
+	 * FUTEX_LOCK_PI with CLOCK_REALTIME
+	 * Due to historical reasons, FUTEX_LOCK_PI supports only realtime
+	 * clock, but requires the caller to not set CLOCK_REALTIME flag.
+	 *
+	 * If you call FUTEX_LOCK_PI with a monotonic clock, it'll be
+	 * interpreted as a realtime clock, and (unless you mess your machine's
+	 * time or your time machine) the monotonic clock value is always
+	 * smaller than realtime and the syscall will timeout immediately.
+	 */
+	if (futex_get_abs_timeout(CLOCK_REALTIME, &to, timeout_ns))
+		return RET_FAIL;
+	res =3D futex_lock_pi(&futex_pi, &to, 0, 0);
+	test_timeout(res, &ret, "futex_lock_pi realtime", ETIMEDOUT);
+
+	/* Test operations that don't support FUTEX_CLOCK_REALTIME */
+	res =3D futex_lock_pi(&futex_pi, NULL, 0, FUTEX_CLOCK_REALTIME);
+	test_timeout(res, &ret, "futex_lock_pi invalid timeout flag", ENOSYS);
=20
-	print_result(TEST_NAME, ret);
+	ksft_print_cnts();
 	return ret;
 }
