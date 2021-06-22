Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 075133B0028
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Jun 2021 11:26:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbhFVJ2Y (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 22 Jun 2021 05:28:24 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:55992 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbhFVJ2X (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 22 Jun 2021 05:28:23 -0400
Date:   Tue, 22 Jun 2021 09:26:05 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624353966;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1xd+HccFec4E0C+9o73D+3xQp59+JWn/FLDxbfMJm0k=;
        b=V3qaey1a1G5O9IVdMYUR0zB6f29uOram3+c633PXZjYe2+4oLZfwelfRfkeQ2jN1/qWCba
        A9k9EobF23PK//9CyZs6ZNqsI/OdqVrbu3HEaF58XmQGZyCe8YBXLvEaHrm9WvZ4+xNOgY
        NprziMMBhpZzB9IG6ClCL+/RoDRmrhq29r22dcZMNIe3CBFItlQlen3eNJIKBogR34ZTEy
        0TnoM7IBIpUMcysmXa7ecaeUGp5wMd7JXAUxzYzpogychOOhnLpwVni6OZyBgxeUqHHUFV
        BJqoTzn6BrIMaCMf3msxaESy74wipo7mhN1nt+Pcj9obKeWhnirL1+oeN1+tiw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624353966;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1xd+HccFec4E0C+9o73D+3xQp59+JWn/FLDxbfMJm0k=;
        b=bXB/yacL6emGAIwHgbTAJdw59ncb3ZNLwwwsfWjlBDlE9QtkKc7AkLNZyHWMDFBBvisvjJ
        GY51OUfBr2+hUlAA==
From:   tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] selftests: futex: Add futex wait test
Cc:     andrealmeid@collabora.com, Thomas Gleixner <tglx@linutronix.de>,
        Davidlohr Bueso <dbueso@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210531165036.41468-2-andrealmeid@collabora.com>
References: <20210531165036.41468-2-andrealmeid@collabora.com>
MIME-Version: 1.0
Message-ID: <162435396526.395.9420418857340307876.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     c3d128581f64a9b3729e697a63760ff0a2c4a8fe
Gitweb:        https://git.kernel.org/tip/c3d128581f64a9b3729e697a63760ff0a2c=
4a8fe
Author:        Andr=C3=A9 Almeida <andrealmeid@collabora.com>
AuthorDate:    Mon, 31 May 2021 13:50:35 -03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 22 Jun 2021 11:20:15 +02:00

selftests: futex: Add futex wait test

There are three different strategies to uniquely identify a futex in the
kernel:

 - Private futexes: uses the pointer to mm_struct and the page address

 - Shared futexes: checks if the page containing the address is a PageAnon:
   - If it is, uses the same data as a private futexes
   - If it isn't, uses an inode sequence number from struct inode and
      the page's index

Create a selftest to check those three paths and basic wait/wake
mechanism.

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
Link: https://lore.kernel.org/r/20210531165036.41468-2-andrealmeid@collabora.=
com

---
 tools/testing/selftests/futex/functional/.gitignore   |   1 +-
 tools/testing/selftests/futex/functional/Makefile     |   3 +-
 tools/testing/selftests/futex/functional/futex_wait.c | 171 +++++++++-
 tools/testing/selftests/futex/functional/run.sh       |   3 +-
 4 files changed, 177 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/futex/functional/futex_wait.c

diff --git a/tools/testing/selftests/futex/functional/.gitignore b/tools/test=
ing/selftests/futex/functional/.gitignore
index 0efcd49..bd24699 100644
--- a/tools/testing/selftests/futex/functional/.gitignore
+++ b/tools/testing/selftests/futex/functional/.gitignore
@@ -6,3 +6,4 @@ futex_wait_private_mapped_file
 futex_wait_timeout
 futex_wait_uninitialized_heap
 futex_wait_wouldblock
+futex_wait
diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testin=
g/selftests/futex/functional/Makefile
index 1d2b3b2..20a5b4a 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -15,7 +15,8 @@ TEST_GEN_FILES :=3D \
 	futex_requeue_pi_signal_restart \
 	futex_requeue_pi_mismatched_ops \
 	futex_wait_uninitialized_heap \
-	futex_wait_private_mapped_file
+	futex_wait_private_mapped_file \
+	futex_wait
=20
 TEST_PROGS :=3D run.sh
=20
diff --git a/tools/testing/selftests/futex/functional/futex_wait.c b/tools/te=
sting/selftests/futex/functional/futex_wait.c
new file mode 100644
index 0000000..685140d
--- /dev/null
+++ b/tools/testing/selftests/futex/functional/futex_wait.c
@@ -0,0 +1,171 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright Collabora Ltd., 2021
+ *
+ * futex cmp requeue test by Andr=C3=A9 Almeida <andrealmeid@collabora.com>
+ */
+
+#include <pthread.h>
+#include <sys/shm.h>
+#include <sys/mman.h>
+#include <fcntl.h>
+#include "logging.h"
+#include "futextest.h"
+
+#define TEST_NAME "futex-wait"
+#define timeout_ns  30000000
+#define WAKE_WAIT_US 10000
+#define SHM_PATH "futex_shm_file"
+
+void *futex;
+
+void usage(char *prog)
+{
+	printf("Usage: %s\n", prog);
+	printf("  -c	Use color\n");
+	printf("  -h	Display this help message\n");
+	printf("  -v L	Verbosity level: %d=3DQUIET %d=3DCRITICAL %d=3DINFO\n",
+	       VQUIET, VCRITICAL, VINFO);
+}
+
+static void *waiterfn(void *arg)
+{
+	struct timespec to;
+	unsigned int flags =3D 0;
+
+	if (arg)
+		flags =3D *((unsigned int *) arg);
+
+	to.tv_sec =3D 0;
+	to.tv_nsec =3D timeout_ns;
+
+	if (futex_wait(futex, 0, &to, flags))
+		printf("waiter failed errno %d\n", errno);
+
+	return NULL;
+}
+
+int main(int argc, char *argv[])
+{
+	int res, ret =3D RET_PASS, fd, c, shm_id;
+	u_int32_t f_private =3D 0, *shared_data;
+	unsigned int flags =3D FUTEX_PRIVATE_FLAG;
+	pthread_t waiter;
+	void *shm;
+
+	futex =3D &f_private;
+
+	while ((c =3D getopt(argc, argv, "cht:v:")) !=3D -1) {
+		switch (c) {
+		case 'c':
+			log_color(1);
+			break;
+		case 'h':
+			usage(basename(argv[0]));
+			exit(0);
+		case 'v':
+			log_verbosity(atoi(optarg));
+			break;
+		default:
+			usage(basename(argv[0]));
+			exit(1);
+		}
+	}
+
+	ksft_print_header();
+	ksft_set_plan(3);
+	ksft_print_msg("%s: Test futex_wait\n", basename(argv[0]));
+
+	/* Testing a private futex */
+	info("Calling private futex_wait on futex: %p\n", futex);
+	if (pthread_create(&waiter, NULL, waiterfn, (void *) &flags))
+		error("pthread_create failed\n", errno);
+
+	usleep(WAKE_WAIT_US);
+
+	info("Calling private futex_wake on futex: %p\n", futex);
+	res =3D futex_wake(futex, 1, FUTEX_PRIVATE_FLAG);
+	if (res !=3D 1) {
+		ksft_test_result_fail("futex_wake private returned: %d %s\n",
+				      errno, strerror(errno));
+		ret =3D RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex_wake private succeeds\n");
+	}
+
+	/* Testing an anon page shared memory */
+	shm_id =3D shmget(IPC_PRIVATE, 4096, IPC_CREAT | 0666);
+	if (shm_id < 0) {
+		perror("shmget");
+		exit(1);
+	}
+
+	shared_data =3D shmat(shm_id, NULL, 0);
+
+	*shared_data =3D 0;
+	futex =3D shared_data;
+
+	info("Calling shared (page anon) futex_wait on futex: %p\n", futex);
+	if (pthread_create(&waiter, NULL, waiterfn, NULL))
+		error("pthread_create failed\n", errno);
+
+	usleep(WAKE_WAIT_US);
+
+	info("Calling shared (page anon) futex_wake on futex: %p\n", futex);
+	res =3D futex_wake(futex, 1, 0);
+	if (res !=3D 1) {
+		ksft_test_result_fail("futex_wake shared (page anon) returned: %d %s\n",
+				      errno, strerror(errno));
+		ret =3D RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex_wake shared (page anon) succeeds\n");
+	}
+
+
+	/* Testing a file backed shared memory */
+	fd =3D open(SHM_PATH, O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);
+	if (fd < 0) {
+		perror("open");
+		exit(1);
+	}
+
+	if (ftruncate(fd, sizeof(f_private))) {
+		perror("ftruncate");
+		exit(1);
+	}
+
+	shm =3D mmap(NULL, sizeof(f_private), PROT_READ | PROT_WRITE, MAP_SHARED, f=
d, 0);
+	if (shm =3D=3D MAP_FAILED) {
+		perror("mmap");
+		exit(1);
+	}
+
+	memcpy(shm, &f_private, sizeof(f_private));
+
+	futex =3D shm;
+
+	info("Calling shared (file backed) futex_wait on futex: %p\n", futex);
+	if (pthread_create(&waiter, NULL, waiterfn, NULL))
+		error("pthread_create failed\n", errno);
+
+	usleep(WAKE_WAIT_US);
+
+	info("Calling shared (file backed) futex_wake on futex: %p\n", futex);
+	res =3D futex_wake(shm, 1, 0);
+	if (res !=3D 1) {
+		ksft_test_result_fail("futex_wake shared (file backed) returned: %d %s\n",
+				      errno, strerror(errno));
+		ret =3D RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex_wake shared (file backed) succeeds\n");
+	}
+
+	/* Freeing resources */
+	shmdt(shared_data);
+	munmap(shm, sizeof(f_private));
+	remove(SHM_PATH);
+	close(fd);
+
+	ksft_print_cnts();
+	return ret;
+}
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/=
selftests/futex/functional/run.sh
index 1acb6ac..d5e1430 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -73,3 +73,6 @@ echo
 echo
 ./futex_wait_uninitialized_heap $COLOR
 ./futex_wait_private_mapped_file $COLOR
+
+echo
+./futex_wait $COLOR
