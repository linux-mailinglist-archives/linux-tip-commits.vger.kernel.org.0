Return-Path: <linux-tip-commits+bounces-6701-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 27722B8CD4D
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 18:30:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 799487C7810
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 16:29:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 00C0E309DB5;
	Sat, 20 Sep 2025 16:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="o4KzjZ/6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="upsFfe3k"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 057D4307AE4;
	Sat, 20 Sep 2025 16:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758385677; cv=none; b=Eid6vbcxVkDP60T149C+CWTBvh2oODLLL6JperXwBwfCBuSsZftLD0NlJPVkLnObxeU4c1iiC+e7bsi2sLLoDeHEC5x7mirSkKuFm00PtqszE3piX70O6MhDsnhRMHkMBaVBBS4Zcv5xTdYvyN9zYfyRjIsG+PwE/jwW4/yIf7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758385677; c=relaxed/simple;
	bh=ITIePadTZaVDyEm+L69qMpVLg07+M35k3DchYFFJ514=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=qRN4qYzEgdU+BtvTZVCUTqY3v37ENAr6GhRVNOhCye4Y1ZT7YM9ke9kGjib8+ajmNURcxJPWsPj4uXtPq583Sg7nPXin3d9TRxuVs4B+8EN7ccfvRcymPbq0Ko4199S4dyQojNVmG3cojRostseYZGZS9wo951EGaNvKshrE5kA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=o4KzjZ/6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=upsFfe3k; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 20 Sep 2025 16:27:53 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758385674;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bU43h5CuPyySgYlt+xK08PKyxtyf/hPwtaunUwHfJPg=;
	b=o4KzjZ/6/1irpYQASD0Td+i14TYX/Xv4nbRDcFvdlsYngtRJH1Ihpl5d7UlkhfO6U9jFoR
	UQw2JujNFDFGgn9vhobLspjROC3R3Qy6rwgeIESjFQOQU9f0UNc7J2h1ab4Jr9zgdqabB4
	nx50OCTHxq33W94mnMA/xnuMc1M/JiwYacBcdRjnlMzO6+A8hwYxRSmQZa69Y99WLuJPAx
	KzdLFVdBzjmZqylUSPpbipu0U/xi/8VXccFp62rrVf46IBhDGMdLktFuPbFhBl1Ddi1RrA
	T+Z9G28rg34UTT9DpLm3492XQvr2JXVlD04+H8wqpBm5lf2ws5mixgMvbdzwnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758385674;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bU43h5CuPyySgYlt+xK08PKyxtyf/hPwtaunUwHfJPg=;
	b=upsFfe3kToXse7uBiJsD0jNwhOAndRJ+snmJNidq9IjokzSW4HQ9QESKCImyQD6wIsz39m
	U3Qp+UCHF0y/b3Aw==
From: tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] selftests/futex: Refactor
 futex_requeue_pi_mismatched_ops with kselftest_harness.h
Cc: andrealmeid@igalia.com, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250917-tonyk-robust_test_cleanup-v3-3-306b373c244d@igalia.com>
References: <20250917-tonyk-robust_test_cleanup-v3-3-306b373c244d@igalia.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175838567328.709179.5190893279319457055.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     65a12ce20fb27067c0d946e7dcf83b9c9ff365fd
Gitweb:        https://git.kernel.org/tip/65a12ce20fb27067c0d946e7dcf83b9c9ff=
365fd
Author:        Andr=C3=A9 Almeida <andrealmeid@igalia.com>
AuthorDate:    Wed, 17 Sep 2025 18:21:42 -03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 20 Sep 2025 18:11:53 +02:00

selftests/futex: Refactor futex_requeue_pi_mismatched_ops with kselftest_harn=
ess.h

To reduce the boilerplate code, refactor futex_requeue_pi_mismatched_ops
test to use kselftest_harness header instead of futex's logging header.

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/testing/selftests/futex/functional/futex_requeue_pi_mismatched_ops.c |=
 86 +++++++++++++++++-----------------------------------------------------
 tools/testing/selftests/futex/functional/run.sh                            |=
  2 +-
 2 files changed, 23 insertions(+), 65 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_requeue_pi_mismat=
ched_ops.c b/tools/testing/selftests/futex/functional/futex_requeue_pi_mismat=
ched_ops.c
index d0a4d33..77135a2 100644
--- a/tools/testing/selftests/futex/functional/futex_requeue_pi_mismatched_op=
s.c
+++ b/tools/testing/selftests/futex/functional/futex_requeue_pi_mismatched_op=
s.c
@@ -23,67 +23,32 @@
 #include <stdlib.h>
 #include <string.h>
 #include <time.h>
-#include "futextest.h"
-#include "logging.h"
=20
-#define TEST_NAME "futex-requeue-pi-mismatched-ops"
+#include "futextest.h"
+#include "../../kselftest_harness.h"
=20
 futex_t f1 =3D FUTEX_INITIALIZER;
 futex_t f2 =3D FUTEX_INITIALIZER;
 int child_ret =3D 0;
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
 void *blocking_child(void *arg)
 {
 	child_ret =3D futex_wait(&f1, f1, NULL, FUTEX_PRIVATE_FLAG);
 	if (child_ret < 0) {
 		child_ret =3D -errno;
-		error("futex_wait\n", errno);
+		ksft_exit_fail_msg("futex_wait\n");
 	}
 	return (void *)&child_ret;
 }
=20
-int main(int argc, char *argv[])
+TEST(requeue_pi_mismatched_ops)
 {
-	int ret =3D RET_PASS;
 	pthread_t child;
-	int c;
+	int ret;
=20
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
-	ksft_print_msg("%s: Detect mismatched requeue_pi operations\n",
-	       basename(argv[0]));
+	if (pthread_create(&child, NULL, blocking_child, NULL))
+		ksft_exit_fail_msg("pthread_create\n");
=20
-	if (pthread_create(&child, NULL, blocking_child, NULL)) {
-		error("pthread_create\n", errno);
-		ret =3D RET_ERROR;
-		goto out;
-	}
 	/* Allow the child to block in the kernel. */
 	sleep(1);
=20
@@ -102,34 +67,27 @@ int main(int argc, char *argv[])
 			 * FUTEX_WAKE.
 			 */
 			ret =3D futex_wake(&f1, 1, FUTEX_PRIVATE_FLAG);
-			if (ret =3D=3D 1) {
-				ret =3D RET_PASS;
-			} else if (ret < 0) {
-				error("futex_wake\n", errno);
-				ret =3D RET_ERROR;
-			} else {
-				error("futex_wake did not wake the child\n", 0);
-				ret =3D RET_ERROR;
-			}
+			if (ret =3D=3D 1)
+				ret =3D 0;
+			else if (ret < 0)
+				ksft_exit_fail_msg("futex_wake\n");
+			else
+				ksft_exit_fail_msg("futex_wake did not wake the child\n");
 		} else {
-			error("futex_cmp_requeue_pi\n", errno);
-			ret =3D RET_ERROR;
+			ksft_exit_fail_msg("futex_cmp_requeue_pi\n");
 		}
 	} else if (ret > 0) {
-		fail("futex_cmp_requeue_pi failed to detect the mismatch\n");
-		ret =3D RET_FAIL;
+		ksft_test_result_fail("futex_cmp_requeue_pi failed to detect the mismatch\=
n");
 	} else {
-		error("futex_cmp_requeue_pi found no waiters\n", 0);
-		ret =3D RET_ERROR;
+		ksft_exit_fail_msg("futex_cmp_requeue_pi found no waiters\n");
 	}
=20
 	pthread_join(child, NULL);
=20
-	if (!ret)
-		ret =3D child_ret;
-
- out:
-	/* If the kernel crashes, we shouldn't return at all. */
-	print_result(TEST_NAME, ret);
-	return ret;
+	if (!ret && !child_ret)
+		ksft_test_result_pass("futex_requeue_pi_mismatched_ops passed\n");
+	else
+		ksft_test_result_pass("futex_requeue_pi_mismatched_ops failed\n");
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/=
selftests/futex/functional/run.sh
index d34e223..cc1b743 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -35,7 +35,7 @@ echo
 ./futex_requeue_pi
=20
 echo
-./futex_requeue_pi_mismatched_ops $COLOR
+./futex_requeue_pi_mismatched_ops
=20
 echo
 ./futex_requeue_pi_signal_restart $COLOR

