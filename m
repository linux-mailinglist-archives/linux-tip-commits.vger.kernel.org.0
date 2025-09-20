Return-Path: <linux-tip-commits+bounces-6697-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 89DBAB8CD3B
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 18:29:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 83ABC3AEEFF
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 16:28:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54A6306492;
	Sat, 20 Sep 2025 16:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="G5ZtRL1P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Lgj6eWCF"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283A73054F8;
	Sat, 20 Sep 2025 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758385673; cv=none; b=iLErrpTTtwmQKhT9/aP9xGH1x8BUf3KFGaNxAfj7YqYViICpIAbmeHgx/pBW/1Tfpw1VfeM1tSUtbKkLcWuFCYAb6iICIBaG2ZzvP8yRavFbjyKhGmeJcuPoeHJYInSAl22bu3NwfWxOJCg5KfvT9o09+OYNckQDhb+R+3R0iAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758385673; c=relaxed/simple;
	bh=kjGYOz7A+n7N7Wrm9BNoZ27pd6bV+OxXpJRtln6miTg=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=g+tbejJMpKvVj8zUU4f7C5/DDjmrQqtXEgaIAGU9OEbxRrkJsqzaIGIq4qaVYx21m9Lb3vhChKCE0Hfo3/q+fsvJDwKVeG4qH6GKmzaQH4k8h5mpzrYNvayLZXLhjnVl3yZzZ76jVe/XjDrLFQkSRFVuPONE+dhkkAf/SVtl6pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=G5ZtRL1P; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=Lgj6eWCF; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 20 Sep 2025 16:27:48 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758385670;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F6K87nRD7CfPXlQbzQb/Db8XNEmC12eKofCwH7DA1Dg=;
	b=G5ZtRL1P6BYIlRKVsGddUH7gvI1/6aMn1fqSDWrzLEBT0v6h4DASufEd/ZsmYGrEHIqsoX
	Q2Lfgc33R+E4jil/wkt5+r5aoRMOYc+qqyfRn1roIK3jgJThWy2ynzLrgrbdLsr6WZ8lJr
	6LwlabKC785os/t2LB3gkg2KNQv6QqbLJA8H71Z/Bpv6kUlr73daUZPfAKtTOphw4eMUhX
	RK1U52nEGSpusP/fP67fj9oOXojwZ/pOs4IcoRgslgNzBvcZkaniXSWcc7M/NVUbPuA8pP
	76EAeLDesOD67r7x9YSMGibYqFKde1XltF6bFuQnN/DGXWk26MgrekkqClv2ng==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758385670;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=F6K87nRD7CfPXlQbzQb/Db8XNEmC12eKofCwH7DA1Dg=;
	b=Lgj6eWCFp/HOpSRcGiVbdLdYCt+6HVswZiR+crQfoYFn8j6k3Oo6SzZxMFZse/LT8ytsVY
	ntDUHjEs4rjPXIAA==
From: tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] selftests/futex: Refactor
 futex_wait_unitialized_heap with kselftest_harness.h
Cc: andrealmeid@igalia.com, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250917-tonyk-robust_test_cleanup-v3-7-306b373c244d@igalia.com>
References: <20250917-tonyk-robust_test_cleanup-v3-7-306b373c244d@igalia.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175838566871.709179.2287443169008716957.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     af3c79f8575d751914d1175c02dc024ecc173c58
Gitweb:        https://git.kernel.org/tip/af3c79f8575d751914d1175c02dc024ecc1=
73c58
Author:        Andr=C3=A9 Almeida <andrealmeid@igalia.com>
AuthorDate:    Wed, 17 Sep 2025 18:21:46 -03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 20 Sep 2025 18:11:54 +02:00

selftests/futex: Refactor futex_wait_unitialized_heap with kselftest_harness.h

To reduce the boilerplate code, refactor futex_wait_unitialized_heap
test to use kselftest_harness header instead of futex's logging header.

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/testing/selftests/futex/functional/futex_wait_uninitialized_heap.c | 7=
6 ++++++++++++++++------------------------------------------------------
 tools/testing/selftests/futex/functional/run.sh                          |  =
2 +-
 2 files changed, 19 insertions(+), 59 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait_uninitialize=
d_heap.c b/tools/testing/selftests/futex/functional/futex_wait_uninitialized_=
heap.c
index ed9cd07..ce23015 100644
--- a/tools/testing/selftests/futex/functional/futex_wait_uninitialized_heap.c
+++ b/tools/testing/selftests/futex/functional/futex_wait_uninitialized_heap.c
@@ -29,95 +29,55 @@
 #include <linux/futex.h>
 #include <libgen.h>
=20
-#include "logging.h"
 #include "futextest.h"
+#include "../../kselftest_harness.h"
=20
-#define TEST_NAME "futex-wait-uninitialized-heap"
 #define WAIT_US 5000000
=20
 static int child_blocked =3D 1;
-static int child_ret;
+static bool child_ret;
 void *buf;
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
 void *wait_thread(void *arg)
 {
 	int res;
=20
-	child_ret =3D RET_PASS;
+	child_ret =3D true;
 	res =3D futex_wait(buf, 1, NULL, 0);
 	child_blocked =3D 0;
=20
 	if (res !=3D 0 && errno !=3D EWOULDBLOCK) {
-		error("futex failure\n", errno);
-		child_ret =3D RET_ERROR;
+		ksft_exit_fail_msg("futex failure\n");
+		child_ret =3D false;
 	}
 	pthread_exit(NULL);
 }
=20
-int main(int argc, char **argv)
+TEST(futex_wait_uninitialized_heap)
 {
-	int c, ret =3D RET_PASS;
 	long page_size;
 	pthread_t thr;
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
+	int ret;
=20
 	page_size =3D sysconf(_SC_PAGESIZE);
=20
 	buf =3D mmap(NULL, page_size, PROT_READ|PROT_WRITE,
 		   MAP_PRIVATE|MAP_ANONYMOUS, 0, 0);
-	if (buf =3D=3D (void *)-1) {
-		error("mmap\n", errno);
-		exit(1);
-	}
-
-	ksft_print_header();
-	ksft_set_plan(1);
-	ksft_print_msg("%s: Test the uninitialized futex value in FUTEX_WAIT\n",
-	       basename(argv[0]));
-
+	if (buf =3D=3D (void *)-1)
+		ksft_exit_fail_msg("mmap\n");
=20
 	ret =3D pthread_create(&thr, NULL, wait_thread, NULL);
-	if (ret) {
-		error("pthread_create\n", errno);
-		ret =3D RET_ERROR;
-		goto out;
-	}
+	if (ret)
+		ksft_exit_fail_msg("pthread_create\n");
=20
-	info("waiting %dus for child to return\n", WAIT_US);
+	ksft_print_dbg_msg("waiting %dus for child to return\n", WAIT_US);
 	usleep(WAIT_US);
=20
-	ret =3D child_ret;
-	if (child_blocked) {
-		fail("child blocked in kernel\n");
-		ret =3D RET_FAIL;
-	}
+	if (child_blocked)
+		ksft_test_result_fail("child blocked in kernel\n");
=20
- out:
-	print_result(TEST_NAME, ret);
-	return ret;
+	if (!child_ret)
+		ksft_test_result_fail("child error\n");
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/=
selftests/futex/functional/run.sh
index a5246d5..6cb07a4 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -47,7 +47,7 @@ echo
 ./futex_wait_wouldblock
=20
 echo
-./futex_wait_uninitialized_heap $COLOR
+./futex_wait_uninitialized_heap
 ./futex_wait_private_mapped_file $COLOR
=20
 echo

