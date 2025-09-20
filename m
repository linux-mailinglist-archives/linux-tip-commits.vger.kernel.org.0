Return-Path: <linux-tip-commits+bounces-6700-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC530B8CD38
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 18:29:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7533118956C3
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 16:29:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED89C3081DD;
	Sat, 20 Sep 2025 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EVCDj63k";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="UTbQRWJC"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB58306B0C;
	Sat, 20 Sep 2025 16:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758385676; cv=none; b=OBTjgQvU5EdbBnsW8LHHC3H4XJlP1fAqupALMz3fpysfOeUg1hYYapLIWQWLodg+Rrc/806M4uPwuluBjQzCQ4cv1XEufl3kUiWUfl2EUS3A9CrYF6WLMgdWXZhWO3t9w31c5LBk2DY0cDe4hGLfRrZ0pWEN/rgBChLmDjoroGU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758385676; c=relaxed/simple;
	bh=VOYBNOXizuxChfrrqVs/pYu7WtBlu24NhqcbJdepKRc=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=ENurmDKmeW/bw/FURfvZe0C6k407yoQX9MSzLFNWP/UXyBBGgs4HMG7t0ROrrTksb7bN4hY247VZEmvhkn2mVvgXHwyAftyO3Ex4fV5gctHZS/p38GSCm0zoQnwpcMPEtH+fYNIay2E4YR5sSWJF0THhK3Q2SjKJ6DulMeXBuPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=EVCDj63k; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=UTbQRWJC; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 20 Sep 2025 16:27:51 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758385673;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vz/m/gIQhYaWXVR8rpabQ/IsFAnn/Tyhf/AnmAKKcvk=;
	b=EVCDj63kV+5l4aaJh2zlKc3bQzIG+Ttkz6BpIGUswJWsRmLQ77LVrHBKme7ywmsRvoYX83
	qI8wBFY0JBYBXSuz8CUUdm828Nkn07JPS1mxC27GdEMt3j94GePHVONTrR3L/vdwFtnm4H
	9umFwQq/G9VS8hV2I8n2O7oTpeU+FpxVP4WdeK+DtaBe3EdqF/67e1O/mUwVaQSvYjOcXB
	nfCVP8EOsjuuKszUkFiuxlEXK8IR8rbzJC1fe0s+4DeZ1xZ3pSRqgpkfO7QIQEfNZCwXi2
	ZpOTdU4+5VtXN/svWejiIBvrYDmeSnjTj/nAoLYIM5IHOiFk+Qdd96annpT/8w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758385673;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vz/m/gIQhYaWXVR8rpabQ/IsFAnn/Tyhf/AnmAKKcvk=;
	b=UTbQRWJCD2FOxjtks70mEGdXV6n4YByh3Ff8VU4PHiyB+97Jr3DS+bvL1LVL1G8sLKii2W
	z8+WvYizO9cCFECg==
From: tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] selftests/futex: Refactor
 futex_requeue_pi_signal_restart with kselftest_harness.h
Cc: andrealmeid@igalia.com, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250917-tonyk-robust_test_cleanup-v3-4-306b373c244d@igalia.com>
References: <20250917-tonyk-robust_test_cleanup-v3-4-306b373c244d@igalia.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175838567197.709179.13581049966032518652.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     2ef0615685094f6c7ad7e18498759f90015b7de8
Gitweb:        https://git.kernel.org/tip/2ef0615685094f6c7ad7e18498759f90015=
b7de8
Author:        Andr=C3=A9 Almeida <andrealmeid@igalia.com>
AuthorDate:    Wed, 17 Sep 2025 18:21:43 -03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 20 Sep 2025 18:11:54 +02:00

selftests/futex: Refactor futex_requeue_pi_signal_restart with kselftest_harn=
ess.h

To reduce the boilerplate code, refactor futex_requeue_pi_signal_restart
test to use kselftest_harness header instead of futex's logging header.

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/testing/selftests/futex/functional/futex_requeue_pi_signal_restart.c |=
 129 ++++++++++++++++++++--------------------------------------------------
 tools/testing/selftests/futex/functional/run.sh                            |=
   2 +-
 2 files changed, 38 insertions(+), 93 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi_signal=
_restart.c b/tools/testing/selftests/futex/functional/futex_requeue_pi_signal=
_restart.c
index c6b8f32..e34ee0f 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi_signal_restar=
t.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi_signal_restar=
t.c
@@ -24,11 +24,11 @@
 #include <stdio.h>
 #include <stdlib.h>
 #include <string.h>
+
 #include "atomic.h"
 #include "futextest.h"
-#include "logging.h"
+#include "../../kselftest_harness.h"
=20
-#define TEST_NAME "futex-requeue-pi-signal-restart"
 #define DELAY_US 100
=20
 futex_t f1 =3D FUTEX_INITIALIZER;
@@ -37,15 +37,6 @@ atomic_t requeued =3D ATOMIC_INITIALIZER;
=20
 int waiter_ret =3D 0;
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
 int create_rt_thread(pthread_t *pth, void*(*func)(void *), void *arg,
 		     int policy, int prio)
 {
@@ -57,35 +48,28 @@ int create_rt_thread(pthread_t *pth, void*(*func)(void *)=
, void *arg,
 	memset(&schedp, 0, sizeof(schedp));
=20
 	ret =3D pthread_attr_setinheritsched(&attr, PTHREAD_EXPLICIT_SCHED);
-	if (ret) {
-		error("pthread_attr_setinheritsched\n", ret);
-		return -1;
-	}
+	if (ret)
+		ksft_exit_fail_msg("pthread_attr_setinheritsched\n");
=20
 	ret =3D pthread_attr_setschedpolicy(&attr, policy);
-	if (ret) {
-		error("pthread_attr_setschedpolicy\n", ret);
-		return -1;
-	}
+	if (ret)
+		ksft_exit_fail_msg("pthread_attr_setschedpolicy\n");
=20
 	schedp.sched_priority =3D prio;
 	ret =3D pthread_attr_setschedparam(&attr, &schedp);
-	if (ret) {
-		error("pthread_attr_setschedparam\n", ret);
-		return -1;
-	}
+	if (ret)
+		ksft_exit_fail_msg("pthread_attr_setschedparam\n");
=20
 	ret =3D pthread_create(pth, &attr, func, arg);
-	if (ret) {
-		error("pthread_create\n", ret);
-		return -1;
-	}
+	if (ret)
+		ksft_exit_fail_msg("pthread_create\n");
+
 	return 0;
 }
=20
 void handle_signal(int signo)
 {
-	info("signal received %s requeue\n",
+	ksft_print_dbg_msg("signal received %s requeue\n",
 	     requeued.val ? "after" : "prior to");
 }
=20
@@ -94,78 +78,46 @@ void *waiterfn(void *arg)
 	unsigned int old_val;
 	int res;
=20
-	waiter_ret =3D RET_PASS;
-
-	info("Waiter running\n");
-	info("Calling FUTEX_LOCK_PI on f2=3D%x @ %p\n", f2, &f2);
+	ksft_print_dbg_msg("Waiter running\n");
+	ksft_print_dbg_msg("Calling FUTEX_LOCK_PI on f2=3D%x @ %p\n", f2, &f2);
 	old_val =3D f1;
 	res =3D futex_wait_requeue_pi(&f1, old_val, &(f2), NULL,
 				    FUTEX_PRIVATE_FLAG);
 	if (!requeued.val || errno !=3D EWOULDBLOCK) {
-		fail("unexpected return from futex_wait_requeue_pi: %d (%s)\n",
+		ksft_test_result_fail("unexpected return from futex_wait_requeue_pi: %d (%=
s)\n",
 		     res, strerror(errno));
-		info("w2:futex: %x\n", f2);
+		ksft_print_dbg_msg("w2:futex: %x\n", f2);
 		if (!res)
 			futex_unlock_pi(&f2, FUTEX_PRIVATE_FLAG);
-		waiter_ret =3D RET_FAIL;
 	}
=20
-	info("Waiter exiting with %d\n", waiter_ret);
 	pthread_exit(NULL);
 }
=20
=20
-int main(int argc, char *argv[])
+TEST(futex_requeue_pi_signal_restart)
 {
 	unsigned int old_val;
 	struct sigaction sa;
 	pthread_t waiter;
-	int c, res, ret =3D RET_PASS;
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
-	ksft_print_msg("%s: Test signal handling during requeue_pi\n",
-	       basename(argv[0]));
-	ksft_print_msg("\tArguments: <none>\n");
+	int res;
=20
 	sa.sa_handler =3D handle_signal;
 	sigemptyset(&sa.sa_mask);
 	sa.sa_flags =3D 0;
-	if (sigaction(SIGUSR1, &sa, NULL)) {
-		error("sigaction\n", errno);
-		exit(1);
-	}
+	if (sigaction(SIGUSR1, &sa, NULL))
+		ksft_exit_fail_msg("sigaction\n");
=20
-	info("m1:f2: %x\n", f2);
-	info("Creating waiter\n");
+	ksft_print_dbg_msg("m1:f2: %x\n", f2);
+	ksft_print_dbg_msg("Creating waiter\n");
 	res =3D create_rt_thread(&waiter, waiterfn, NULL, SCHED_FIFO, 1);
-	if (res) {
-		error("Creating waiting thread failed", res);
-		ret =3D RET_ERROR;
-		goto out;
-	}
+	if (res)
+		ksft_exit_fail_msg("Creating waiting thread failed");
=20
-	info("Calling FUTEX_LOCK_PI on f2=3D%x @ %p\n", f2, &f2);
-	info("m2:f2: %x\n", f2);
+	ksft_print_dbg_msg("Calling FUTEX_LOCK_PI on f2=3D%x @ %p\n", f2, &f2);
+	ksft_print_dbg_msg("m2:f2: %x\n", f2);
 	futex_lock_pi(&f2, 0, 0, FUTEX_PRIVATE_FLAG);
-	info("m3:f2: %x\n", f2);
+	ksft_print_dbg_msg("m3:f2: %x\n", f2);
=20
 	while (1) {
 		/*
@@ -173,11 +125,11 @@ int main(int argc, char *argv[])
 		 * restart futex_wait_requeue_pi() in the kernel. Wait for the
 		 * waiter to block on f1 again.
 		 */
-		info("Issuing SIGUSR1 to waiter\n");
+		ksft_print_dbg_msg("Issuing SIGUSR1 to waiter\n");
 		pthread_kill(waiter, SIGUSR1);
 		usleep(DELAY_US);
=20
-		info("Requeueing waiter via FUTEX_CMP_REQUEUE_PI\n");
+		ksft_print_dbg_msg("Requeueing waiter via FUTEX_CMP_REQUEUE_PI\n");
 		old_val =3D f1;
 		res =3D futex_cmp_requeue_pi(&f1, old_val, &(f2), 1, 0,
 					   FUTEX_PRIVATE_FLAG);
@@ -191,12 +143,10 @@ int main(int argc, char *argv[])
 			atomic_set(&requeued, 1);
 			break;
 		} else if (res < 0) {
-			error("FUTEX_CMP_REQUEUE_PI failed\n", errno);
-			ret =3D RET_ERROR;
-			break;
+			ksft_exit_fail_msg("FUTEX_CMP_REQUEUE_PI failed\n");
 		}
 	}
-	info("m4:f2: %x\n", f2);
+	ksft_print_dbg_msg("m4:f2: %x\n", f2);
=20
 	/*
 	 * Signal the waiter after requeue, waiter should return from
@@ -204,19 +154,14 @@ int main(int argc, char *argv[])
 	 * futex_unlock_pi() can't happen before the signal wakeup is detected
 	 * in the kernel.
 	 */
-	info("Issuing SIGUSR1 to waiter\n");
+	ksft_print_dbg_msg("Issuing SIGUSR1 to waiter\n");
 	pthread_kill(waiter, SIGUSR1);
-	info("Waiting for waiter to return\n");
+	ksft_print_dbg_msg("Waiting for waiter to return\n");
 	pthread_join(waiter, NULL);
=20
-	info("Calling FUTEX_UNLOCK_PI on mutex=3D%x @ %p\n", f2, &f2);
+	ksft_print_dbg_msg("Calling FUTEX_UNLOCK_PI on mutex=3D%x @ %p\n", f2, &f2);
 	futex_unlock_pi(&f2, FUTEX_PRIVATE_FLAG);
-	info("m5:f2: %x\n", f2);
-
- out:
-	if (ret =3D=3D RET_PASS && waiter_ret)
-		ret =3D waiter_ret;
-
-	print_result(TEST_NAME, ret);
-	return ret;
+	ksft_print_dbg_msg("m5:f2: %x\n", f2);
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/=
selftests/futex/functional/run.sh
index cc1b743..6d48a7e 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -38,7 +38,7 @@ echo
 ./futex_requeue_pi_mismatched_ops
=20
 echo
-./futex_requeue_pi_signal_restart $COLOR
+./futex_requeue_pi_signal_restart
=20
 echo
 ./futex_wait_timeout $COLOR

