Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9227D13AA44
	for <lists+linux-tip-commits@lfdr.de>; Tue, 14 Jan 2020 14:06:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729102AbgANNEj (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 14 Jan 2020 08:04:39 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:43119 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbgANNCV (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 14 Jan 2020 08:02:21 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1irLpm-0004aY-H3; Tue, 14 Jan 2020 14:02:14 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3461D1C07FA;
        Tue, 14 Jan 2020 14:02:14 +0100 (CET)
Date:   Tue, 14 Jan 2020 13:02:14 -0000
From:   "tip-bot2 for Andrei Vagin" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/core] selftests/timens: Add a test for timerfd
Cc:     Andrei Vagin <avagin@gmail.com>, Dmitry Safonov <dima@arista.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191112012724.250792-30-dima@arista.com>
References: <20191112012724.250792-30-dima@arista.com>
MIME-Version: 1.0
Message-ID: <157900693401.396.18220148724378132319.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/core branch of tip:

Commit-ID:     11873de3ce4d2fe289d51932c03b3668cf519186
Gitweb:        https://git.kernel.org/tip/11873de3ce4d2fe289d51932c03b3668cf519186
Author:        Andrei Vagin <avagin@gmail.com>
AuthorDate:    Tue, 12 Nov 2019 01:27:18 
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 14 Jan 2020 12:21:00 +01:00

selftests/timens: Add a test for timerfd

Check that timerfd_create() takes into account clock offsets.

Output on success:
 1..3
 ok 1 clockid=7
 ok 2 clockid=1
 ok 3 clockid=9
 # Pass 3 Fail 0 Xfail 0 Xpass 0 Skip 0 Error 0

Output on failure:
 1..3
 not ok 1 clockid: 7 elapsed: 0
 not ok 2 clockid: 1 elapsed: 0
 not ok 3 clockid: 9 elapsed: 0
 Bail out!

Output with lack of permissions:
 1..3
 not ok 1 # SKIP need to run as root

Output without support of time namespaces:
 1..3
 not ok 1 # SKIP Time namespaces are not supported

Co-developed-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Dmitry Safonov <dima@arista.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20191112012724.250792-30-dima@arista.com


---
 tools/testing/selftests/timens/.gitignore |   1 +-
 tools/testing/selftests/timens/Makefile   |   2 +-
 tools/testing/selftests/timens/timerfd.c  | 128 +++++++++++++++++++++-
 3 files changed, 130 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/timens/timerfd.c

diff --git a/tools/testing/selftests/timens/.gitignore b/tools/testing/selftests/timens/.gitignore
index 27a6932..b609f6e 100644
--- a/tools/testing/selftests/timens/.gitignore
+++ b/tools/testing/selftests/timens/.gitignore
@@ -1 +1,2 @@
 timens
+timerfd
diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
index 49a9dcc..293aed6 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -1,4 +1,4 @@
-TEST_GEN_PROGS := timens
+TEST_GEN_PROGS := timens timerfd
 
 CFLAGS := -Wall -Werror
 LDFLAGS := -lrt
diff --git a/tools/testing/selftests/timens/timerfd.c b/tools/testing/selftests/timens/timerfd.c
new file mode 100644
index 0000000..eff1ec5
--- /dev/null
+++ b/tools/testing/selftests/timens/timerfd.c
@@ -0,0 +1,128 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sched.h>
+
+#include <sys/timerfd.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <stdio.h>
+#include <stdint.h>
+
+#include "log.h"
+#include "timens.h"
+
+static int tclock_gettime(clock_t clockid, struct timespec *now)
+{
+	if (clockid == CLOCK_BOOTTIME_ALARM)
+		clockid = CLOCK_BOOTTIME;
+	return clock_gettime(clockid, now);
+}
+
+int run_test(int clockid, struct timespec now)
+{
+	struct itimerspec new_value;
+	long long elapsed;
+	int fd, i;
+
+	if (tclock_gettime(clockid, &now))
+		return pr_perror("clock_gettime(%d)", clockid);
+
+	for (i = 0; i < 2; i++) {
+		int flags = 0;
+
+		new_value.it_value.tv_sec = 3600;
+		new_value.it_value.tv_nsec = 0;
+		new_value.it_interval.tv_sec = 1;
+		new_value.it_interval.tv_nsec = 0;
+
+		if (i == 1) {
+			new_value.it_value.tv_sec += now.tv_sec;
+			new_value.it_value.tv_nsec += now.tv_nsec;
+		}
+
+		fd = timerfd_create(clockid, 0);
+		if (fd == -1)
+			return pr_perror("timerfd_create(%d)", clockid);
+
+		if (i == 1)
+			flags |= TFD_TIMER_ABSTIME;
+
+		if (timerfd_settime(fd, flags, &new_value, NULL))
+			return pr_perror("timerfd_settime(%d)", clockid);
+
+		if (timerfd_gettime(fd, &new_value))
+			return pr_perror("timerfd_gettime(%d)", clockid);
+
+		elapsed = new_value.it_value.tv_sec;
+		if (abs(elapsed - 3600) > 60) {
+			ksft_test_result_fail("clockid: %d elapsed: %lld\n",
+					      clockid, elapsed);
+			return 1;
+		}
+
+		close(fd);
+	}
+
+	ksft_test_result_pass("clockid=%d\n", clockid);
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int ret, status, len, fd;
+	char buf[4096];
+	pid_t pid;
+	struct timespec btime_now, mtime_now;
+
+	nscheck();
+
+	ksft_set_plan(3);
+
+	clock_gettime(CLOCK_MONOTONIC, &mtime_now);
+	clock_gettime(CLOCK_BOOTTIME, &btime_now);
+
+	if (unshare_timens())
+		return 1;
+
+	len = snprintf(buf, sizeof(buf), "%d %d 0\n%d %d 0",
+			CLOCK_MONOTONIC, 70 * 24 * 3600,
+			CLOCK_BOOTTIME, 9 * 24 * 3600);
+	fd = open("/proc/self/timens_offsets", O_WRONLY);
+	if (fd < 0)
+		return pr_perror("/proc/self/timens_offsets");
+
+	if (write(fd, buf, len) != len)
+		return pr_perror("/proc/self/timens_offsets");
+
+	close(fd);
+	mtime_now.tv_sec += 70 * 24 * 3600;
+	btime_now.tv_sec += 9 * 24 * 3600;
+
+	pid = fork();
+	if (pid < 0)
+		return pr_perror("Unable to fork");
+	if (pid == 0) {
+		ret = 0;
+		ret |= run_test(CLOCK_BOOTTIME, btime_now);
+		ret |= run_test(CLOCK_MONOTONIC, mtime_now);
+		ret |= run_test(CLOCK_BOOTTIME_ALARM, btime_now);
+
+		if (ret)
+			ksft_exit_fail();
+		ksft_exit_pass();
+		return ret;
+	}
+
+	if (waitpid(pid, &status, 0) != pid)
+		return pr_perror("Unable to wait the child process");
+
+	if (WIFEXITED(status))
+		return WEXITSTATUS(status);
+
+	return 1;
+}
