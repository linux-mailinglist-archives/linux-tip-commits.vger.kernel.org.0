Return-Path: <linux-tip-commits+bounces-6702-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26067B8CD50
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 18:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CFAD87C4729
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 16:29:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D783830AAC2;
	Sat, 20 Sep 2025 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mshZrhIp";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="OTe5K9Bn"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5450B308F28;
	Sat, 20 Sep 2025 16:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758385679; cv=none; b=prwaaNQC786+nKFjAA/lE6JqBxveA5Ht+JFbdbKcTKW0pCLdOd1eIsYLZ2i17YQmUDzHe87r7Wx4P+Y2T+oDWptzAZb4YbXcN5iE3Utrxb0C4NdSs40SB7ft2MFcHrgbg0E4y9FV4DsdHzsT5cirSH4Egd5nrFqY6i+f69mhIb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758385679; c=relaxed/simple;
	bh=h3s6TnvCs87M9fThZvKB99KW++9W8tnfi9AF4GMWTIo=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=uLbTKv3M5P0nehniKyeBhhsASrEPvWu9bwqYrfFRc4pubpA8BJllMoHC2zaZoq7UkirhTXyG97SdnHe0EXfapZaB6049/QUvwWobFGijuLSXe2U6TjrwvRzQA9Dtjtc8qE0ytbLxx5maRfIPeabXSCw/0wZ8tiBm+wYF4fCc0q4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mshZrhIp; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=OTe5K9Bn; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 20 Sep 2025 16:27:54 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758385675;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ly3dIv0dr8wVVTKR8OihNIcJhOQaGee70hPSLYvIpo=;
	b=mshZrhIp+8KsZmCAlP/5lnBPMPEp3p8qRH8scOQDf7O/TK+u/OjkNoaWWnSZm4aptK6k4h
	zlMMiueTj4WQoksQj/tfSXUcdB139mdbx5ERM7+O7+Y2y29mYjBCh2Zd+vNrLge2OuT2PX
	AK8+1DjnXsxSgdTrSV69B3R7chqUflIMTZyCnuhN6pvEcVhEwtrg9PTlN+Jf2iLKWnTnwY
	eADW0IO+pm12fMSB8CJl+wQ/nhllQ9g1bnp20Ec10s5dkOlpQyYv5IZyTFUduHSKSkXsk+
	95M4UxsX983JEBoEPFdAMQKFqg9MDNqVgIwXRGShy9YI0UfyWSMWwC5lTKFOgA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758385675;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6ly3dIv0dr8wVVTKR8OihNIcJhOQaGee70hPSLYvIpo=;
	b=OTe5K9BnOC/zY5Vvsy29F2yZahBvFaYyOu/hrh3w6tv+M1kyGGWAnuD7CMTsPA2Afk/zGg
	lJOljYq8wOtiU7AA==
From: tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] selftests/futex: Refactor futex_requeue_pi with
 kselftest_harness.h
Cc: andrealmeid@igalia.com, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250917-tonyk-robust_test_cleanup-v3-2-306b373c244d@igalia.com>
References: <20250917-tonyk-robust_test_cleanup-v3-2-306b373c244d@igalia.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175838567439.709179.56278220695884672.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     d060495a37cb437459b3d202572d48a73bee8a66
Gitweb:        https://git.kernel.org/tip/d060495a37cb437459b3d202572d48a73be=
e8a66
Author:        Andr=C3=A9 Almeida <andrealmeid@igalia.com>
AuthorDate:    Wed, 17 Sep 2025 18:21:41 -03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 20 Sep 2025 18:11:53 +02:00

selftests/futex: Refactor futex_requeue_pi with kselftest_harness.h

To reduce the boilerplate code, refactor futex_requeue_pi test to use
kselftest_harness header instead of futex's logging header.

Use kselftest fixture feature to make it easy to repeat the same test
with different parameters. With that, drop all repetitive test calls
from run.sh.

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/testing/selftests/futex/functional/futex_requeue_pi.c | 266 +++----
 tools/testing/selftests/futex/functional/run.sh             |  26 +-
 2 files changed, 124 insertions(+), 168 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi.c b/to=
ols/testing/selftests/futex/functional/futex_requeue_pi.c
index 215c6cb..f299d75 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi.c
@@ -26,11 +26,11 @@
 #include <stdlib.h>
 #include <signal.h>
 #include <string.h>
+
 #include "atomic.h"
 #include "futextest.h"
-#include "logging.h"
+#include "../../kselftest_harness.h"
=20
-#define TEST_NAME "futex-requeue-pi"
 #define MAX_WAKE_ITERS 1000
 #define THREAD_MAX 10
 #define SIGNAL_PERIOD_US 100
@@ -42,12 +42,6 @@ futex_t f1 =3D FUTEX_INITIALIZER;
 futex_t f2 =3D FUTEX_INITIALIZER;
 futex_t wake_complete =3D FUTEX_INITIALIZER;
=20
-/* Test option defaults */
-static long timeout_ns;
-static int broadcast;
-static int owner;
-static int locked;
-
 struct thread_arg {
 	long id;
 	struct timespec *timeout;
@@ -56,18 +50,73 @@ struct thread_arg {
 };
 #define THREAD_ARG_INITIALIZER { 0, NULL, 0, 0 }
=20
-void usage(char *prog)
+FIXTURE(args)
 {
-	printf("Usage: %s\n", prog);
-	printf("  -b	Broadcast wakeup (all waiters)\n");
-	printf("  -c	Use color\n");
-	printf("  -h	Display this help message\n");
-	printf("  -l	Lock the pi futex across requeue\n");
-	printf("  -o	Use a third party pi futex owner during requeue (cancels -l)\n=
");
-	printf("  -t N	Timeout in nanoseconds (default: 0)\n");
-	printf("  -v L	Verbosity level: %d=3DQUIET %d=3DCRITICAL %d=3DINFO\n",
-	       VQUIET, VCRITICAL, VINFO);
-}
+};
+
+FIXTURE_SETUP(args)
+{
+};
+
+FIXTURE_TEARDOWN(args)
+{
+};
+
+FIXTURE_VARIANT(args)
+{
+	long timeout_ns;
+	bool broadcast;
+	bool owner;
+	bool locked;
+};
+
+/*
+ * For a given timeout value, this macro creates a test input with all the
+ * possible combinations of valid arguments
+ */
+#define FIXTURE_VARIANT_ADD_TIMEOUT(timeout)		\
+							\
+FIXTURE_VARIANT_ADD(args, t_##timeout)			\
+{							\
+	.timeout_ns =3D timeout,				\
+};							\
+							\
+FIXTURE_VARIANT_ADD(args, t_##timeout##_broadcast)	\
+{							\
+	.timeout_ns =3D timeout,				\
+	.broadcast =3D true,				\
+};							\
+							\
+FIXTURE_VARIANT_ADD(args, t_##timeout##_broadcast_locked) \
+{							\
+	.timeout_ns =3D timeout,				\
+	.broadcast =3D true,				\
+	.locked =3D true,					\
+};							\
+							\
+FIXTURE_VARIANT_ADD(args, t_##timeout##_broadcast_owner) \
+{							\
+	.timeout_ns =3D timeout,				\
+	.broadcast =3D true,				\
+	.owner =3D true,					\
+};							\
+							\
+FIXTURE_VARIANT_ADD(args, t_##timeout##_locked)		\
+{							\
+	.timeout_ns =3D timeout,				\
+	.locked =3D true,					\
+};							\
+							\
+FIXTURE_VARIANT_ADD(args, t_##timeout##_owner)		\
+{							\
+	.timeout_ns =3D timeout,				\
+	.owner =3D true,					\
+};							\
+
+FIXTURE_VARIANT_ADD_TIMEOUT(0);
+FIXTURE_VARIANT_ADD_TIMEOUT(5000);
+FIXTURE_VARIANT_ADD_TIMEOUT(500000);
+FIXTURE_VARIANT_ADD_TIMEOUT(2000000000);
=20
 int create_rt_thread(pthread_t *pth, void*(*func)(void *), void *arg,
 		     int policy, int prio)
@@ -81,26 +130,26 @@ int create_rt_thread(pthread_t *pth, void*(*func)(void *=
), void *arg,
=20
 	ret =3D pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
 	if (ret) {
-		error("pthread_attr_setinheritsched\n", ret);
+		ksft_exit_fail_msg("pthread_attr_setinheritsched\n");
 		return -1;
 	}
=20
 	ret =3D pthread_attr_setschedpolicy(&attr, policy);
 	if (ret) {
-		error("pthread_attr_setschedpolicy\n", ret);
+		ksft_exit_fail_msg("pthread_attr_setschedpolicy\n");
 		return -1;
 	}
=20
 	schedp.sched_priority =3D prio;
 	ret =3D pthread_attr_setschedparam(&attr, &schedp);
 	if (ret) {
-		error("pthread_attr_setschedparam\n", ret);
+		ksft_exit_fail_msg("pthread_attr_setschedparam\n");
 		return -1;
 	}
=20
 	ret =3D pthread_create(pth, &attr, func, arg);
 	if (ret) {
-		error("pthread_create\n", ret);
+		ksft_exit_fail_msg("pthread_create\n");
 		return -1;
 	}
 	return 0;
@@ -112,7 +161,7 @@ void *waiterfn(void *arg)
 	struct thread_arg *args =3D (struct thread_arg *)arg;
 	futex_t old_val;
=20
-	info("Waiter %ld: running\n", args->id);
+	ksft_print_dbg_msg("Waiter %ld: running\n", args->id);
 	/* Each thread sleeps for a different amount of time
 	 * This is to avoid races, because we don't lock the
 	 * external mutex here */
@@ -120,26 +169,25 @@ void *waiterfn(void *arg)
=20
 	old_val =3D f1;
 	atomic_inc(&waiters_blocked);
-	info("Calling futex_wait_requeue_pi: %p (%u) -> %p\n",
+	ksft_print_dbg_msg("Calling futex_wait_requeue_pi: %p (%u) -> %p\n",
 	     &f1, f1, &f2);
 	args->ret =3D futex_wait_requeue_pi(&f1, old_val, &f2, args->timeout,
 					  FUTEX_PRIVATE_FLAG);
=20
-	info("waiter %ld woke with %d %s\n", args->id, args->ret,
+	ksft_print_dbg_msg("waiter %ld woke with %d %s\n", args->id, args->ret,
 	     args->ret < 0 ? strerror(errno) : "");
 	atomic_inc(&waiters_woken);
 	if (args->ret < 0) {
 		if (args->timeout && errno =3D=3D ETIMEDOUT)
 			args->ret =3D 0;
 		else {
-			args->ret =3D RET_ERROR;
-			error("futex_wait_requeue_pi\n", errno);
+			ksft_exit_fail_msg("futex_wait_requeue_pi\n");
 		}
 		futex_lock_pi(&f2, NULL, 0, FUTEX_PRIVATE_FLAG);
 	}
 	futex_unlock_pi(&f2, FUTEX_PRIVATE_FLAG);
=20
-	info("Waiter %ld: exiting with %d\n", args->id, args->ret);
+	ksft_print_dbg_msg("Waiter %ld: exiting with %d\n", args->id, args->ret);
 	pthread_exit((void *)&args->ret);
 }
=20
@@ -152,14 +200,14 @@ void *broadcast_wakerfn(void *arg)
 	int nr_wake =3D 1;
 	int i =3D 0;
=20
-	info("Waker: waiting for waiters to block\n");
+	ksft_print_dbg_msg("Waker: waiting for waiters to block\n");
 	while (waiters_blocked.val < THREAD_MAX)
 		usleep(1000);
 	usleep(1000);
=20
-	info("Waker: Calling broadcast\n");
+	ksft_print_dbg_msg("Waker: Calling broadcast\n");
 	if (args->lock) {
-		info("Calling FUTEX_LOCK_PI on mutex=3D%x @ %p\n", f2, &f2);
+		ksft_print_dbg_msg("Calling FUTEX_LOCK_PI on mutex=3D%x @ %p\n", f2, &f2);
 		futex_lock_pi(&f2, NULL, 0, FUTEX_PRIVATE_FLAG);
 	}
  continue_requeue:
@@ -167,16 +215,14 @@ void *broadcast_wakerfn(void *arg)
 	args->ret =3D futex_cmp_requeue_pi(&f1, old_val, &f2, nr_wake, nr_requeue,
 				   FUTEX_PRIVATE_FLAG);
 	if (args->ret < 0) {
-		args->ret =3D RET_ERROR;
-		error("FUTEX_CMP_REQUEUE_PI failed\n", errno);
+		ksft_exit_fail_msg("FUTEX_CMP_REQUEUE_PI failed\n");
 	} else if (++i < MAX_WAKE_ITERS) {
 		task_count +=3D args->ret;
 		if (task_count < THREAD_MAX - waiters_woken.val)
 			goto continue_requeue;
 	} else {
-		error("max broadcast iterations (%d) reached with %d/%d tasks woken or req=
ueued\n",
-		       0, MAX_WAKE_ITERS, task_count, THREAD_MAX);
-		args->ret =3D RET_ERROR;
+		ksft_exit_fail_msg("max broadcast iterations (%d) reached with %d/%d tasks=
 woken or requeued\n",
+		       MAX_WAKE_ITERS, task_count, THREAD_MAX);
 	}
=20
 	futex_wake(&wake_complete, 1, FUTEX_PRIVATE_FLAG);
@@ -187,7 +233,7 @@ void *broadcast_wakerfn(void *arg)
 	if (args->ret > 0)
 		args->ret =3D task_count;
=20
-	info("Waker: exiting with %d\n", args->ret);
+	ksft_print_dbg_msg("Waker: exiting with %d\n", args->ret);
 	pthread_exit((void *)&args->ret);
 }
=20
@@ -200,20 +246,20 @@ void *signal_wakerfn(void *arg)
 	int nr_wake =3D 1;
 	int i =3D 0;
=20
-	info("Waker: waiting for waiters to block\n");
+	ksft_print_dbg_msg("Waker: waiting for waiters to block\n");
 	while (waiters_blocked.val < THREAD_MAX)
 		usleep(1000);
 	usleep(1000);
=20
 	while (task_count < THREAD_MAX && waiters_woken.val < THREAD_MAX) {
-		info("task_count: %d, waiters_woken: %d\n",
+		ksft_print_dbg_msg("task_count: %d, waiters_woken: %d\n",
 		     task_count, waiters_woken.val);
 		if (args->lock) {
-			info("Calling FUTEX_LOCK_PI on mutex=3D%x @ %p\n",
-			     f2, &f2);
+			ksft_print_dbg_msg("Calling FUTEX_LOCK_PI on mutex=3D%x @ %p\n",
+			    f2, &f2);
 			futex_lock_pi(&f2, NULL, 0, FUTEX_PRIVATE_FLAG);
 		}
-		info("Waker: Calling signal\n");
+		ksft_print_dbg_msg("Waker: Calling signal\n");
 		/* cond_signal */
 		old_val =3D f1;
 		args->ret =3D futex_cmp_requeue_pi(&f1, old_val, &f2,
@@ -221,28 +267,23 @@ void *signal_wakerfn(void *arg)
 						 FUTEX_PRIVATE_FLAG);
 		if (args->ret < 0)
 			args->ret =3D -errno;
-		info("futex: %x\n", f2);
+		ksft_print_dbg_msg("futex: %x\n", f2);
 		if (args->lock) {
-			info("Calling FUTEX_UNLOCK_PI on mutex=3D%x @ %p\n",
-			     f2, &f2);
+			ksft_print_dbg_msg("Calling FUTEX_UNLOCK_PI on mutex=3D%x @ %p\n",
+			    f2, &f2);
 			futex_unlock_pi(&f2, FUTEX_PRIVATE_FLAG);
 		}
-		info("futex: %x\n", f2);
-		if (args->ret < 0) {
-			error("FUTEX_CMP_REQUEUE_PI failed\n", errno);
-			args->ret =3D RET_ERROR;
-			break;
-		}
+		ksft_print_dbg_msg("futex: %x\n", f2);
+		if (args->ret < 0)
+			ksft_exit_fail_msg("FUTEX_CMP_REQUEUE_PI failed\n");
=20
 		task_count +=3D args->ret;
 		usleep(SIGNAL_PERIOD_US);
 		i++;
 		/* we have to loop at least THREAD_MAX times */
 		if (i > MAX_WAKE_ITERS + THREAD_MAX) {
-			error("max signaling iterations (%d) reached, giving up on pending waiter=
s.\n",
-			      0, MAX_WAKE_ITERS + THREAD_MAX);
-			args->ret =3D RET_ERROR;
-			break;
+			ksft_exit_fail_msg("max signaling iterations (%d) reached, giving up on p=
ending waiters.\n",
+			      MAX_WAKE_ITERS + THREAD_MAX);
 		}
 	}
=20
@@ -251,8 +292,8 @@ void *signal_wakerfn(void *arg)
 	if (args->ret >=3D 0)
 		args->ret =3D task_count;
=20
-	info("Waker: exiting with %d\n", args->ret);
-	info("Waker: waiters_woken: %d\n", waiters_woken.val);
+	ksft_print_dbg_msg("Waker: exiting with %d\n", args->ret);
+	ksft_print_dbg_msg("Waker: waiters_woken: %d\n", waiters_woken.val);
 	pthread_exit((void *)&args->ret);
 }
=20
@@ -269,35 +310,40 @@ void *third_party_blocker(void *arg)
 	ret2 =3D futex_unlock_pi(&f2, FUTEX_PRIVATE_FLAG);
=20
  out:
-	if (args->ret || ret2) {
-		error("third_party_blocker() futex error", 0);
-		args->ret =3D RET_ERROR;
-	}
+	if (args->ret || ret2)
+		ksft_exit_fail_msg("third_party_blocker() futex error");
=20
 	pthread_exit((void *)&args->ret);
 }
=20
-int unit_test(int broadcast, long lock, int third_party_owner, long timeout_=
ns)
+TEST_F(args, futex_requeue_pi)
 {
-	void *(*wakerfn)(void *) =3D signal_wakerfn;
 	struct thread_arg blocker_arg =3D THREAD_ARG_INITIALIZER;
 	struct thread_arg waker_arg =3D THREAD_ARG_INITIALIZER;
 	pthread_t waiter[THREAD_MAX], waker, blocker;
-	struct timespec ts, *tsp =3D NULL;
+	void *(*wakerfn)(void *) =3D signal_wakerfn;
+	bool third_party_owner =3D variant->owner;
+	long timeout_ns =3D variant->timeout_ns;
+	bool broadcast =3D variant->broadcast;
 	struct thread_arg args[THREAD_MAX];
-	int *waiter_ret;
-	int i, ret =3D RET_PASS;
+	struct timespec ts, *tsp =3D NULL;
+	bool lock =3D variant->locked;
+	int *waiter_ret, i, ret =3D 0;
+
+	ksft_print_msg(
+		"\tArguments: broadcast=3D%d locked=3D%d owner=3D%d timeout=3D%ldns\n",
+		broadcast, lock, third_party_owner, timeout_ns);
=20
 	if (timeout_ns) {
 		time_t secs;
=20
-		info("timeout_ns =3D %ld\n", timeout_ns);
+		ksft_print_dbg_msg("timeout_ns =3D %ld\n", timeout_ns);
 		ret =3D clock_gettime(CLOCK_MONOTONIC, &ts);
 		secs =3D (ts.tv_nsec + timeout_ns) / 1000000000;
 		ts.tv_nsec =3D ((int64_t)ts.tv_nsec + timeout_ns) % 1000000000;
 		ts.tv_sec +=3D secs;
-		info("ts.tv_sec  =3D %ld\n", ts.tv_sec);
-		info("ts.tv_nsec =3D %ld\n", ts.tv_nsec);
+		ksft_print_dbg_msg("ts.tv_sec  =3D %ld\n", ts.tv_sec);
+		ksft_print_dbg_msg("ts.tv_nsec =3D %ld\n", ts.tv_nsec);
 		tsp =3D &ts;
 	}
=20
@@ -307,10 +353,7 @@ int unit_test(int broadcast, long lock, int third_party_=
owner, long timeout_ns)
 	if (third_party_owner) {
 		if (create_rt_thread(&blocker, third_party_blocker,
 				     (void *)&blocker_arg, SCHED_FIFO, 1)) {
-			error("Creating third party blocker thread failed\n",
-			      errno);
-			ret =3D RET_ERROR;
-			goto out;
+			ksft_exit_fail_msg("Creating third party blocker thread failed\n");
 		}
 	}
=20
@@ -318,20 +361,16 @@ int unit_test(int broadcast, long lock, int third_party=
_owner, long timeout_ns)
 	for (i =3D 0; i < THREAD_MAX; i++) {
 		args[i].id =3D i;
 		args[i].timeout =3D tsp;
-		info("Starting thread %d\n", i);
+		ksft_print_dbg_msg("Starting thread %d\n", i);
 		if (create_rt_thread(&waiter[i], waiterfn, (void *)&args[i],
 				     SCHED_FIFO, 1)) {
-			error("Creating waiting thread failed\n", errno);
-			ret =3D RET_ERROR;
-			goto out;
+			ksft_exit_fail_msg("Creating waiting thread failed\n");
 		}
 	}
 	waker_arg.lock =3D lock;
 	if (create_rt_thread(&waker, wakerfn, (void *)&waker_arg,
 			     SCHED_FIFO, 1)) {
-		error("Creating waker thread failed\n", errno);
-		ret =3D RET_ERROR;
-		goto out;
+		ksft_exit_fail_msg("Creating waker thread failed\n");
 	}
=20
 	/* Wait for threads to finish */
@@ -345,7 +384,6 @@ int unit_test(int broadcast, long lock, int third_party_o=
wner, long timeout_ns)
 		pthread_join(blocker, NULL);
 	pthread_join(waker, NULL);
=20
-out:
 	if (!ret) {
 		if (*waiter_ret)
 			ret =3D *waiter_ret;
@@ -355,66 +393,8 @@ out:
 			ret =3D blocker_arg.ret;
 	}
=20
-	return ret;
+	if (ret)
+		ksft_test_result_fail("fail");
 }
=20
-int main(int argc, char *argv[])
-{
-	char *test_name;
-	int c, ret;
-
-	while ((c =3D getopt(argc, argv, "bchlot:v:")) !=3D -1) {
-		switch (c) {
-		case 'b':
-			broadcast =3D 1;
-			break;
-		case 'c':
-			log_color(1);
-			break;
-		case 'h':
-			usage(basename(argv[0]));
-			exit(0);
-		case 'l':
-			locked =3D 1;
-			break;
-		case 'o':
-			owner =3D 1;
-			locked =3D 0;
-			break;
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
-	ksft_set_plan(1);
-	ksft_print_msg("%s: Test requeue functionality\n", basename(argv[0]));
-	ksft_print_msg(
-		"\tArguments: broadcast=3D%d locked=3D%d owner=3D%d timeout=3D%ldns\n",
-		broadcast, locked, owner, timeout_ns);
-
-	ret =3D asprintf(&test_name,
-		       "%s broadcast=3D%d locked=3D%d owner=3D%d timeout=3D%ldns",
-		       TEST_NAME, broadcast, locked, owner, timeout_ns);
-	if (ret < 0) {
-		ksft_print_msg("Failed to generate test name\n");
-		test_name =3D TEST_NAME;
-	}
-
-	/*
-	 * FIXME: unit_test is obsolete now that we parse options and the
-	 * various style of runs are done by run.sh - simplify the code and move
-	 * unit_test into main()
-	 */
-	ret =3D unit_test(broadcast, locked, owner, timeout_ns);
-
-	print_result(test_name, ret);
-	return ret;
-}
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/=
selftests/futex/functional/run.sh
index 5470088..d34e223 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -32,31 +32,7 @@ fi
=20
=20
 echo
-# requeue pi testing
-# without timeouts
-./futex_requeue_pi $COLOR
-./futex_requeue_pi $COLOR -b
-./futex_requeue_pi $COLOR -b -l
-./futex_requeue_pi $COLOR -b -o
-./futex_requeue_pi $COLOR -l
-./futex_requeue_pi $COLOR -o
-# with timeouts
-./futex_requeue_pi $COLOR -b -l -t 5000
-./futex_requeue_pi $COLOR -l -t 5000
-./futex_requeue_pi $COLOR -b -l -t 500000
-./futex_requeue_pi $COLOR -l -t 500000
-./futex_requeue_pi $COLOR -b -t 5000
-./futex_requeue_pi $COLOR -t 5000
-./futex_requeue_pi $COLOR -b -t 500000
-./futex_requeue_pi $COLOR -t 500000
-./futex_requeue_pi $COLOR -b -o -t 5000
-./futex_requeue_pi $COLOR -l -t 5000
-./futex_requeue_pi $COLOR -b -o -t 500000
-./futex_requeue_pi $COLOR -l -t 500000
-# with long timeout
-./futex_requeue_pi $COLOR -b -l -t 2000000000
-./futex_requeue_pi $COLOR -l -t 2000000000
-
+./futex_requeue_pi
=20
 echo
 ./futex_requeue_pi_mismatched_ops $COLOR

