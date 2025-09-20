Return-Path: <linux-tip-commits+bounces-6694-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 751D0B8CD1A
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 18:28:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7A3E9562830
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 16:28:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 372FE303C81;
	Sat, 20 Sep 2025 16:27:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="fZtY0vys";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="69EPLKgf"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 304971DFF7;
	Sat, 20 Sep 2025 16:27:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758385670; cv=none; b=B0CAe496bacCxPjRWArxUr0BWpi3TyVx0H5RUZmXFpW9YRhR9prC7fQNkNGVUhIqGo3kq9b2Kp2nh5JQvEa3HdlTy45yJgWyjx758m+5H4MLdS52dkZQ+riQ+TmYHWA3iKYtjSu4W/Y4UhsiFXPGp71SVtpGAzZM2+Y5bkLvBmI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758385670; c=relaxed/simple;
	bh=hcIlBLuH3+dLt3KfGGszEIxWdTVDSEl5uwDOdZE/z4U=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=Ofiffva/WHgCsVN6149gBVNRIA6e0p24daweJpCHizVqiMiRXTwvB0WOPXtxin1d/Jm9PlYMt5g1mrgBTA3a1RDuz2RmP2pzzYoWXI+Q1YtBloLu+v1rqFMt897DmO4ZI3AV8CTnHKeFs3wO2hy0Ru7qUD54l3m71eEpL3yKj+Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=fZtY0vys; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=69EPLKgf; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 20 Sep 2025 16:27:45 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758385666;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8eGVEAG7sBxV5nzd35tZcIXxS5Z2e5sDUiEBwJdCNLc=;
	b=fZtY0vysI7La0pO4JtXgShuKAbyEhHyl6Au02TIT+QIzjtEjFUM3cJQ4Mf/noxDJ0hfpku
	nb7PVwJSmZGeIZ5Htch034tQ7ERLmatsWkB5yJt0w59+lfF2q7JQtbMs+OcTGQ6S46QIk4
	+OnvDgwpgMUzZSn0cu5Xx/BUU7yaHze5qjZMTnwzK316+Ie84EPAm0KUUGfAu7EE29OViW
	+f4lJe/bSOqBwsgggLIp0sJsIJ3jZaBbvCyYyyCCjIoZ1rUir2JLVh18uttF3KtCcIuTQZ
	6rjwHwwxD58wOJLxn3+zSbqymJCtc8563qoMYhix/ef42iW/Zh7JJJQwp9BEhA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758385666;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8eGVEAG7sBxV5nzd35tZcIXxS5Z2e5sDUiEBwJdCNLc=;
	b=69EPLKgfOhItrmy6ZbrtbQ8NA9QfYaEILn+WTxKWKGJNj2OkV9rfLwNvRKy0LciqsNbhoY
	cNGColvB/5ggO9Cw==
From: tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] selftests/futex: Refactor futex_requeue with
 kselftest_harness.h
Cc: andrealmeid@igalia.com, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To:
 <20250917-tonyk-robust_test_cleanup-v3-10-306b373c244d@igalia.com>
References: <20250917-tonyk-robust_test_cleanup-v3-10-306b373c244d@igalia.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175838566538.709179.16017435544111349160.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     f341a20f6d7e25669b2fdf2b071bdd92962e5897
Gitweb:        https://git.kernel.org/tip/f341a20f6d7e25669b2fdf2b071bdd92962=
e5897
Author:        Andr=C3=A9 Almeida <andrealmeid@igalia.com>
AuthorDate:    Wed, 17 Sep 2025 18:21:49 -03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 20 Sep 2025 18:11:55 +02:00

selftests/futex: Refactor futex_requeue with kselftest_harness.h

To reduce the boilerplate code, refactor futex_requeue test to use
kselftest_harness header instead of futex's logging header.

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/testing/selftests/futex/functional/futex_requeue.c | 76 ++-----
 tools/testing/selftests/futex/functional/run.sh          |  2 +-
 2 files changed, 24 insertions(+), 54 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue.c b/tools=
/testing/selftests/futex/functional/futex_requeue.c
index 51485be..69e2555 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue.c
@@ -7,24 +7,15 @@
=20
 #include <pthread.h>
 #include <limits.h>
-#include "logging.h"
+
 #include "futextest.h"
+#include "../../kselftest_harness.h"
=20
-#define TEST_NAME "futex-requeue"
 #define timeout_ns  30000000
 #define WAKE_WAIT_US 10000
=20
 volatile futex_t *f1;
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
@@ -38,67 +29,49 @@ void *waiterfn(void *arg)
 	return NULL;
 }
=20
-int main(int argc, char *argv[])
+TEST(requeue_single)
 {
-	pthread_t waiter[10];
-	int res, ret =3D RET_PASS;
-	int c, i;
 	volatile futex_t _f1 =3D 0;
 	volatile futex_t f2 =3D 0;
+	pthread_t waiter[10];
+	int res;
=20
 	f1 =3D &_f1;
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
-	ksft_print_msg("%s: Test futex_requeue\n",
-		       basename(argv[0]));
-
 	/*
 	 * Requeue a waiter from f1 to f2, and wake f2.
 	 */
 	if (pthread_create(&waiter[0], NULL, waiterfn, NULL))
-		error("pthread_create failed\n", errno);
+		ksft_exit_fail_msg("pthread_create failed\n");
=20
 	usleep(WAKE_WAIT_US);
=20
-	info("Requeuing 1 futex from f1 to f2\n");
+	ksft_print_dbg_msg("Requeuing 1 futex from f1 to f2\n");
 	res =3D futex_cmp_requeue(f1, 0, &f2, 0, 1, 0);
-	if (res !=3D 1) {
+	if (res !=3D 1)
 		ksft_test_result_fail("futex_requeue simple returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret =3D RET_FAIL;
-	}
=20
-
-	info("Waking 1 futex at f2\n");
+	ksft_print_dbg_msg("Waking 1 futex at f2\n");
 	res =3D futex_wake(&f2, 1, 0);
 	if (res !=3D 1) {
 		ksft_test_result_fail("futex_requeue simple returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret =3D RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_requeue simple succeeds\n");
 	}
+}
+
+TEST(requeue_multiple)
+{
+	volatile futex_t _f1 =3D 0;
+	volatile futex_t f2 =3D 0;
+	pthread_t waiter[10];
+	int res, i;
=20
+	f1 =3D &_f1;
=20
 	/*
 	 * Create 10 waiters at f1. At futex_requeue, wake 3 and requeue 7.
@@ -106,31 +79,28 @@ int main(int argc, char *argv[])
 	 */
 	for (i =3D 0; i < 10; i++) {
 		if (pthread_create(&waiter[i], NULL, waiterfn, NULL))
-			error("pthread_create failed\n", errno);
+			ksft_exit_fail_msg("pthread_create failed\n");
 	}
=20
 	usleep(WAKE_WAIT_US);
=20
-	info("Waking 3 futexes at f1 and requeuing 7 futexes from f1 to f2\n");
+	ksft_print_dbg_msg("Waking 3 futexes at f1 and requeuing 7 futexes from f1 =
to f2\n");
 	res =3D futex_cmp_requeue(f1, 0, &f2, 3, 7, 0);
 	if (res !=3D 10) {
 		ksft_test_result_fail("futex_requeue many returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret =3D RET_FAIL;
 	}
=20
-	info("Waking INT_MAX futexes at f2\n");
+	ksft_print_dbg_msg("Waking INT_MAX futexes at f2\n");
 	res =3D futex_wake(&f2, INT_MAX, 0);
 	if (res !=3D 7) {
 		ksft_test_result_fail("futex_requeue many returned: %d %s\n",
 				      res ? errno : res,
 				      res ? strerror(errno) : "");
-		ret =3D RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_requeue many succeeds\n");
 	}
-
-	ksft_print_cnts();
-	return ret;
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/=
selftests/futex/functional/run.sh
index 1ce0f20..b711351 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -54,7 +54,7 @@ echo
 ./futex_wait
=20
 echo
-./futex_requeue $COLOR
+./futex_requeue
=20
 echo
 ./futex_waitv $COLOR

