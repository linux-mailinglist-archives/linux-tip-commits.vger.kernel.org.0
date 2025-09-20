Return-Path: <linux-tip-commits+bounces-6695-lists+linux-tip-commits=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E054B8CD26
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 18:29:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E2FE87C7380
	for <lists+linux-tip-commits@lfdr.de>; Sat, 20 Sep 2025 16:28:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5E22A305065;
	Sat, 20 Sep 2025 16:27:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="KgIt+Xv6";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="unwdhQQc"
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64679303A1E;
	Sat, 20 Sep 2025 16:27:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758385671; cv=none; b=DCoezav0SH0qtDCsx9HzMdCkSnR9AAPv9RkU9lSzM020u/rtcBKtgj+aTSeyTN/HxTcwM6rKzvEMlAHKuIxIK+7y/5rjkkdSWttTjmcV1fRT9VHtBuIT4mI9bjEkxZLWLa7hJ5DAhYe7apMm4GMZwlUJHHiqtSCzxGdERBSJJzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758385671; c=relaxed/simple;
	bh=j5PaLUbTlguiRFMgz+P0q0Kvvgzv4Hk7wD6C+m35cIk=;
	h=Date:From:To:Subject:Cc:In-Reply-To:References:MIME-Version:
	 Message-ID:Content-Type; b=iEPbrMj52k/Wv9E3PI0l0qejdeoyJzLoVrzIpykYb1wj0kw/JX7f6vfc1+ddFpBVqTgGQwwM51c/hhcmQqQJE6sRnJB/fYvpuFCPY08WHZPDU6Va3UacwmRQiqq+5xDBkjwXJTqh1zodV72vcSJqQIVuwd2zCCNUrQY14huxvOI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=KgIt+Xv6; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=unwdhQQc; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Date: Sat, 20 Sep 2025 16:27:46 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1758385667;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8brx2n2fuFPwi6+xc1jhWz9znEAX0uYPOtUOgjcJjUc=;
	b=KgIt+Xv6d+yL07vHLTK2Bpnqa8mGzHHITOs33HmkILV7w+BfZSaH32paciLuAwTe7LvoF6
	Pp6Tnp4Z1WaQjn/dLq8hl8Oxannf8OB2v0+a/dJw5WgZgpvwZHonnzlf8BUn7itugyK0qr
	McK1TMB5VHXSGwE2McYtTPvTcAE4boKQmWTvE2WWf7OH9+lFzn40SUjy5Jlvn252hhcBnM
	wy79a34OD7p5PpoCjau9PS1yQ/m50M5bkmd0pRD6BqWh5f8zqk0kFFpmQ6qpT7l8eoFxPk
	acO+Bp2aWTiOIBhqaFNo+LMC+rdIOb09wo8rPkMITD8/IyEwRgJj3NMldHt1nQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1758385667;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8brx2n2fuFPwi6+xc1jhWz9znEAX0uYPOtUOgjcJjUc=;
	b=unwdhQQcsSTy5TX8M09oiLIfn9NWnR6ZFgIZmQOSIDO1m28CXz3H6TJbanJ/Q+EBtxA8xn
	P5h+7HXa7UuKEQBQ==
From: tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: locking/futex] selftests/futex: Refactor futex_wait with
 kselftest_harness.h
Cc: andrealmeid@igalia.com, Thomas Gleixner <tglx@linutronix.de>,
 x86@kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20250917-tonyk-robust_test_cleanup-v3-9-306b373c244d@igalia.com>
References: <20250917-tonyk-robust_test_cleanup-v3-9-306b373c244d@igalia.com>
Precedence: bulk
X-Mailing-List: linux-tip-commits@vger.kernel.org
List-Id: <linux-tip-commits.vger.kernel.org>
List-Subscribe: <mailto:linux-tip-commits+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-tip-commits+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <175838566654.709179.14223868025194566065.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the locking/futex branch of tip:

Commit-ID:     e5c04d0f3ea0dfa4858a449ff3153bc3cef6a140
Gitweb:        https://git.kernel.org/tip/e5c04d0f3ea0dfa4858a449ff3153bc3cef=
6a140
Author:        Andr=C3=A9 Almeida <andrealmeid@igalia.com>
AuthorDate:    Wed, 17 Sep 2025 18:21:48 -03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Sat, 20 Sep 2025 18:11:55 +02:00

selftests/futex: Refactor futex_wait with kselftest_harness.h

To reduce the boilerplate code, refactor futex_wait test to use
kselftest_harness header instead of futex's logging header.

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@igalia.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 tools/testing/selftests/futex/functional/futex_wait.c | 103 +++------
 tools/testing/selftests/futex/functional/run.sh       |   2 +-
 2 files changed, 39 insertions(+), 66 deletions(-)

diff --git a/tools/testing/selftests/futex/functional/futex_wait.c b/tools/te=
sting/selftests/futex/functional/futex_wait.c
index 685140d..152ca46 100644
--- a/tools/testing/selftests/futex/functional/futex_wait.c
+++ b/tools/testing/selftests/futex/functional/futex_wait.c
@@ -9,25 +9,16 @@
 #include <sys/shm.h>
 #include <sys/mman.h>
 #include <fcntl.h>
-#include "logging.h"
+
 #include "futextest.h"
+#include "../../kselftest_harness.h"
=20
-#define TEST_NAME "futex-wait"
 #define timeout_ns  30000000
 #define WAKE_WAIT_US 10000
 #define SHM_PATH "futex_shm_file"
=20
 void *futex;
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
 static void *waiterfn(void *arg)
 {
 	struct timespec to;
@@ -45,53 +36,37 @@ static void *waiterfn(void *arg)
 	return NULL;
 }
=20
-int main(int argc, char *argv[])
+TEST(private_futex)
 {
-	int res, ret =3D RET_PASS, fd, c, shm_id;
-	u_int32_t f_private =3D 0, *shared_data;
 	unsigned int flags =3D FUTEX_PRIVATE_FLAG;
+	u_int32_t f_private =3D 0;
 	pthread_t waiter;
-	void *shm;
+	int res;
=20
 	futex =3D &f_private;
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
-	ksft_set_plan(3);
-	ksft_print_msg("%s: Test futex_wait\n", basename(argv[0]));
-
 	/* Testing a private futex */
-	info("Calling private futex_wait on futex: %p\n", futex);
+	ksft_print_dbg_msg("Calling private futex_wait on futex: %p\n", futex);
 	if (pthread_create(&waiter, NULL, waiterfn, (void *) &flags))
-		error("pthread_create failed\n", errno);
+		ksft_exit_fail_msg("pthread_create failed\n");
=20
 	usleep(WAKE_WAIT_US);
=20
-	info("Calling private futex_wake on futex: %p\n", futex);
+	ksft_print_dbg_msg("Calling private futex_wake on futex: %p\n", futex);
 	res =3D futex_wake(futex, 1, FUTEX_PRIVATE_FLAG);
 	if (res !=3D 1) {
 		ksft_test_result_fail("futex_wake private returned: %d %s\n",
 				      errno, strerror(errno));
-		ret =3D RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_wake private succeeds\n");
 	}
+}
+
+TEST(anon_page)
+{
+	u_int32_t *shared_data;
+	pthread_t waiter;
+	int res, shm_id;
=20
 	/* Testing an anon page shared memory */
 	shm_id =3D shmget(IPC_PRIVATE, 4096, IPC_CREAT | 0666);
@@ -105,67 +80,65 @@ int main(int argc, char *argv[])
 	*shared_data =3D 0;
 	futex =3D shared_data;
=20
-	info("Calling shared (page anon) futex_wait on futex: %p\n", futex);
+	ksft_print_dbg_msg("Calling shared (page anon) futex_wait on futex: %p\n", =
futex);
 	if (pthread_create(&waiter, NULL, waiterfn, NULL))
-		error("pthread_create failed\n", errno);
+		ksft_exit_fail_msg("pthread_create failed\n");
=20
 	usleep(WAKE_WAIT_US);
=20
-	info("Calling shared (page anon) futex_wake on futex: %p\n", futex);
+	ksft_print_dbg_msg("Calling shared (page anon) futex_wake on futex: %p\n", =
futex);
 	res =3D futex_wake(futex, 1, 0);
 	if (res !=3D 1) {
 		ksft_test_result_fail("futex_wake shared (page anon) returned: %d %s\n",
 				      errno, strerror(errno));
-		ret =3D RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_wake shared (page anon) succeeds\n");
 	}
=20
+	shmdt(shared_data);
+}
+
+TEST(file_backed)
+{
+	u_int32_t f_private =3D 0;
+	pthread_t waiter;
+	int res, fd;
+	void *shm;
=20
 	/* Testing a file backed shared memory */
 	fd =3D open(SHM_PATH, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);
-	if (fd < 0) {
-		perror("open");
-		exit(1);
-	}
+	if (fd < 0)
+		ksft_exit_fail_msg("open");
=20
-	if (ftruncate(fd, sizeof(f_private))) {
-		perror("ftruncate");
-		exit(1);
-	}
+	if (ftruncate(fd, sizeof(f_private)))
+		ksft_exit_fail_msg("ftruncate");
=20
 	shm =3D mmap(NULL, sizeof(f_private), PROT_READ | PROT_WRITE, MAP_SHARED, f=
d, 0);
-	if (shm =3D=3D MAP_FAILED) {
-		perror("mmap");
-		exit(1);
-	}
+	if (shm =3D=3D MAP_FAILED)
+		ksft_exit_fail_msg("mmap");
=20
 	memcpy(shm, &f_private, sizeof(f_private));
=20
 	futex =3D shm;
=20
-	info("Calling shared (file backed) futex_wait on futex: %p\n", futex);
+	ksft_print_dbg_msg("Calling shared (file backed) futex_wait on futex: %p\n"=
, futex);
 	if (pthread_create(&waiter, NULL, waiterfn, NULL))
-		error("pthread_create failed\n", errno);
+		ksft_exit_fail_msg("pthread_create failed\n");
=20
 	usleep(WAKE_WAIT_US);
=20
-	info("Calling shared (file backed) futex_wake on futex: %p\n", futex);
+	ksft_print_dbg_msg("Calling shared (file backed) futex_wake on futex: %p\n"=
, futex);
 	res =3D futex_wake(shm, 1, 0);
 	if (res !=3D 1) {
 		ksft_test_result_fail("futex_wake shared (file backed) returned: %d %s\n",
 				      errno, strerror(errno));
-		ret =3D RET_FAIL;
 	} else {
 		ksft_test_result_pass("futex_wake shared (file backed) succeeds\n");
 	}
=20
-	/* Freeing resources */
-	shmdt(shared_data);
 	munmap(shm, sizeof(f_private));
 	remove(SHM_PATH);
 	close(fd);
-
-	ksft_print_cnts();
-	return ret;
 }
+
+TEST_HARNESS_MAIN
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/=
selftests/futex/functional/run.sh
index 87666f2..1ce0f20 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -51,7 +51,7 @@ echo
 ./futex_wait_private_mapped_file
=20
 echo
-./futex_wait $COLOR
+./futex_wait
=20
 echo
 ./futex_requeue $COLOR

