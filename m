Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F21953B0027
	for <lists+linux-tip-commits@lfdr.de>; Tue, 22 Jun 2021 11:26:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbhFVJ2X (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 22 Jun 2021 05:28:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229656AbhFVJ2W (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 22 Jun 2021 05:28:22 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2CEC061574;
        Tue, 22 Jun 2021 02:26:06 -0700 (PDT)
Date:   Tue, 22 Jun 2021 09:26:04 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1624353965;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tSYr4ddWAsBkcdC3ZfyxfZQVW98Sf6QUw1RHZQqCwcQ=;
        b=pIAH2TGUrWbNyltFaz3Rmzma7bFKzazBq+b8qx1GXpCVt3mheEcqAAosR8g6GsFS62ammP
        QqBvIwV+RLdWtMQKen7gczDxmUFHH0XFbJq2fKLdLYFEimoExGnrF/vX8ebk0BIxi6Ulji
        W/pyuToz07XGuR98qxJ/hYd+/pdnYWlGTT4HE6bygXYYrW1HsrEU9yz2EfzXyggYN+B8u2
        XftMILYRV5ITAVgX17Keh0Ffw/LCkKJXyzWDKAVyQ9QF6DzvG+P4swJ6gntuVGsMyEPpTI
        8qsQLRWDwEV/nQntGHXlW5/QCapNTnmHBZAtTC4EBDRf66deYhNOOpBMSRebrQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1624353965;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=tSYr4ddWAsBkcdC3ZfyxfZQVW98Sf6QUw1RHZQqCwcQ=;
        b=1GHHI24/cVHyji6JheYPiNlNQeDzFNqbq7AUq3itNrJjlrggV/WYRyO9YVBHuLQe55QsF1
        FdrDcojL08lCt2AQ==
From:   tip-bot2 for =?utf-8?q?Andr=C3=A9?= Almeida 
        <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] selftests: futex: Add futex compare requeue test
Cc:     andrealmeid@collabora.com, Thomas Gleixner <tglx@linutronix.de>,
        Davidlohr Bueso <dbueso@suse.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210531165036.41468-3-andrealmeid@collabora.com>
References: <20210531165036.41468-3-andrealmeid@collabora.com>
MIME-Version: 1.0
Message-ID: <162435396422.395.17379563097333004962.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     7cb5dd8e2c8ce2b8f778f37cfd8bb955d663d16d
Gitweb:        https://git.kernel.org/tip/7cb5dd8e2c8ce2b8f778f37cfd8bb955d66=
3d16d
Author:        Andr=C3=A9 Almeida <andrealmeid@collabora.com>
AuthorDate:    Mon, 31 May 2021 13:50:36 -03:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 22 Jun 2021 11:20:16 +02:00

selftests: futex: Add futex compare requeue test

Add testing for futex_cmp_requeue(). The first test just requeues from one
waiter to another one, and wakes it. The second performs both wake and
requeue, and checks the return values to see if the operation woke/requeued
the expected number of waiters.

Signed-off-by: Andr=C3=A9 Almeida <andrealmeid@collabora.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Acked-by: Davidlohr Bueso <dbueso@suse.de>
Link: https://lore.kernel.org/r/20210531165036.41468-3-andrealmeid@collabora.=
com

---
 tools/testing/selftests/futex/functional/.gitignore      |   1 +-
 tools/testing/selftests/futex/functional/Makefile        |   3 +-
 tools/testing/selftests/futex/functional/futex_requeue.c | 136 +++++++-
 tools/testing/selftests/futex/functional/run.sh          |   3 +-
 4 files changed, 142 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/futex/functional/futex_requeue.c

diff --git a/tools/testing/selftests/futex/functional/.gitignore b/tools/test=
ing/selftests/futex/functional/.gitignore
index bd24699..0e78b49 100644
--- a/tools/testing/selftests/futex/functional/.gitignore
+++ b/tools/testing/selftests/futex/functional/.gitignore
@@ -7,3 +7,4 @@ futex_wait_timeout
 futex_wait_uninitialized_heap
 futex_wait_wouldblock
 futex_wait
+futex_requeue
diff --git a/tools/testing/selftests/futex/functional/Makefile b/tools/testin=
g/selftests/futex/functional/Makefile
index 20a5b4a..bd1fec5 100644
--- a/tools/testing/selftests/futex/functional/Makefile
+++ b/tools/testing/selftests/futex/functional/Makefile
@@ -16,7 +16,8 @@ TEST_GEN_FILES :=3D \
 	futex_requeue_pi_mismatched_ops \
 	futex_wait_uninitialized_heap \
 	futex_wait_private_mapped_file \
-	futex_wait
+	futex_wait \
+	futex_requeue
=20
 TEST_PROGS :=3D run.sh
=20
diff --git a/tools/testing/selftests/futex/functional/futex_requeue.c b/tools=
/testing/selftests/futex/functional/futex_requeue.c
new file mode 100644
index 0000000..51485be
--- /dev/null
+++ b/tools/testing/selftests/futex/functional/futex_requeue.c
@@ -0,0 +1,136 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * Copyright Collabora Ltd., 2021
+ *
+ * futex cmp requeue test by Andr=C3=A9 Almeida <andrealmeid@collabora.com>
+ */
+
+#include <pthread.h>
+#include <limits.h>
+#include "logging.h"
+#include "futextest.h"
+
+#define TEST_NAME "futex-requeue"
+#define timeout_ns  30000000
+#define WAKE_WAIT_US 10000
+
+volatile futex_t *f1;
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
+void *waiterfn(void *arg)
+{
+	struct timespec to;
+
+	to.tv_sec =3D 0;
+	to.tv_nsec =3D timeout_ns;
+
+	if (futex_wait(f1, *f1, &to, 0))
+		printf("waiter failed errno %d\n", errno);
+
+	return NULL;
+}
+
+int main(int argc, char *argv[])
+{
+	pthread_t waiter[10];
+	int res, ret =3D RET_PASS;
+	int c, i;
+	volatile futex_t _f1 =3D 0;
+	volatile futex_t f2 =3D 0;
+
+	f1 =3D &_f1;
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
+	ksft_set_plan(2);
+	ksft_print_msg("%s: Test futex_requeue\n",
+		       basename(argv[0]));
+
+	/*
+	 * Requeue a waiter from f1 to f2, and wake f2.
+	 */
+	if (pthread_create(&waiter[0], NULL, waiterfn, NULL))
+		error("pthread_create failed\n", errno);
+
+	usleep(WAKE_WAIT_US);
+
+	info("Requeuing 1 futex from f1 to f2\n");
+	res =3D futex_cmp_requeue(f1, 0, &f2, 0, 1, 0);
+	if (res !=3D 1) {
+		ksft_test_result_fail("futex_requeue simple returned: %d %s\n",
+				      res ? errno : res,
+				      res ? strerror(errno) : "");
+		ret =3D RET_FAIL;
+	}
+
+
+	info("Waking 1 futex at f2\n");
+	res =3D futex_wake(&f2, 1, 0);
+	if (res !=3D 1) {
+		ksft_test_result_fail("futex_requeue simple returned: %d %s\n",
+				      res ? errno : res,
+				      res ? strerror(errno) : "");
+		ret =3D RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex_requeue simple succeeds\n");
+	}
+
+
+	/*
+	 * Create 10 waiters at f1. At futex_requeue, wake 3 and requeue 7.
+	 * At futex_wake, wake INT_MAX (should be exactly 7).
+	 */
+	for (i =3D 0; i < 10; i++) {
+		if (pthread_create(&waiter[i], NULL, waiterfn, NULL))
+			error("pthread_create failed\n", errno);
+	}
+
+	usleep(WAKE_WAIT_US);
+
+	info("Waking 3 futexes at f1 and requeuing 7 futexes from f1 to f2\n");
+	res =3D futex_cmp_requeue(f1, 0, &f2, 3, 7, 0);
+	if (res !=3D 10) {
+		ksft_test_result_fail("futex_requeue many returned: %d %s\n",
+				      res ? errno : res,
+				      res ? strerror(errno) : "");
+		ret =3D RET_FAIL;
+	}
+
+	info("Waking INT_MAX futexes at f2\n");
+	res =3D futex_wake(&f2, INT_MAX, 0);
+	if (res !=3D 7) {
+		ksft_test_result_fail("futex_requeue many returned: %d %s\n",
+				      res ? errno : res,
+				      res ? strerror(errno) : "");
+		ret =3D RET_FAIL;
+	} else {
+		ksft_test_result_pass("futex_requeue many succeeds\n");
+	}
+
+	ksft_print_cnts();
+	return ret;
+}
diff --git a/tools/testing/selftests/futex/functional/run.sh b/tools/testing/=
selftests/futex/functional/run.sh
index d5e1430..11a9d62 100755
--- a/tools/testing/selftests/futex/functional/run.sh
+++ b/tools/testing/selftests/futex/functional/run.sh
@@ -76,3 +76,6 @@ echo
=20
 echo
 ./futex_wait $COLOR
+
+echo
+./futex_requeue $COLOR
