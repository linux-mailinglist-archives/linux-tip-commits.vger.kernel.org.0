Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9F031293F51
	for <lists+linux-tip-commits@lfdr.de>; Tue, 20 Oct 2020 17:11:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731697AbgJTPL2 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 20 Oct 2020 11:11:28 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:39844 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731515AbgJTPL2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 20 Oct 2020 11:11:28 -0400
Date:   Tue, 20 Oct 2020 15:11:24 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1603206685;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ekFItAWJ1ze8vFXI1VwjUFhiU2AljGkjZruFekV/cKQ=;
        b=aZ5YlqBXpSoP7mI4CG43CGpyK2LcP/9AaCD59Lzv9a8izREunHllyG34J++cJKMXN5Oh7W
        KSotwui9Jm05JVV4a8iS2DGvKVw1CsKbQUS2fqAyMpQKLYjWfgZq3t+ca6tm2NT7xnRZEs
        6dntH20DHdPu7R0DVUk7jSndXww0GerjHaa8jV7t/LRu3W//TijWaoU/0Bytrwx+WuingL
        SV4bXp1j73bw4dZMmfQ0qFXn/TaGA50ju1+jLpSaN6O/Id4YNzliVe2arDyK3vTx7t44oD
        GLMuSIbiw66kheicabNw4GWtl3BXYp75V5aj9yALmq5ab8ZuuMbWDmaXgsrQWw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1603206685;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ekFItAWJ1ze8vFXI1VwjUFhiU2AljGkjZruFekV/cKQ=;
        b=nMH8l//n79B5Qdbm4bnHFdfe//XJKsFPIkNLnQLRXMNe8swaMSCU6EDVtQRrQy9zrgFIcw
        67SZv+1TNu5sefDw==
From:   "tip-bot2 for Andrei Vagin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] selftests/timens: Add a test for futex()
Cc:     Andrei Vagin <avagin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201015160020.293748-2-avagin@gmail.com>
References: <20201015160020.293748-2-avagin@gmail.com>
MIME-Version: 1.0
Message-ID: <160320668450.7002.12252523367418798020.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     a4fd8414659bf470e2146b352574bbd274e54b7a
Gitweb:        https://git.kernel.org/tip/a4fd8414659bf470e2146b352574bbd274e54b7a
Author:        Andrei Vagin <avagin@gmail.com>
AuthorDate:    Thu, 15 Oct 2020 09:00:20 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Tue, 20 Oct 2020 17:02:57 +02:00

selftests/timens: Add a test for futex()

Output on success:
 1..2
 ok 1 futex with the 0 clockid
 ok 2 futex with the 1 clockid
 # Totals: pass:2 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201015160020.293748-2-avagin@gmail.com

---
 tools/testing/selftests/timens/Makefile |   2 +-
 tools/testing/selftests/timens/futex.c  | 110 +++++++++++++++++++++++-
 2 files changed, 111 insertions(+), 1 deletion(-)
 create mode 100644 tools/testing/selftests/timens/futex.c

diff --git a/tools/testing/selftests/timens/Makefile b/tools/testing/selftests/timens/Makefile
index b4fd9a9..3a5936c 100644
--- a/tools/testing/selftests/timens/Makefile
+++ b/tools/testing/selftests/timens/Makefile
@@ -1,4 +1,4 @@
-TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs exec
+TEST_GEN_PROGS := timens timerfd timer clock_nanosleep procfs exec futex
 TEST_GEN_PROGS_EXTENDED := gettime_perf
 
 CFLAGS := -Wall -Werror -pthread
diff --git a/tools/testing/selftests/timens/futex.c b/tools/testing/selftests/timens/futex.c
new file mode 100644
index 0000000..6b2b926
--- /dev/null
+++ b/tools/testing/selftests/timens/futex.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sched.h>
+
+#include <linux/unistd.h>
+#include <linux/futex.h>
+#include <stdio.h>
+#include <string.h>
+#include <sys/syscall.h>
+#include <sys/types.h>
+#include <sys/wait.h>
+#include <time.h>
+#include <unistd.h>
+
+#include "log.h"
+#include "timens.h"
+
+#define NSEC_PER_SEC 1000000000ULL
+
+static int run_test(int clockid)
+{
+	int futex_op = FUTEX_WAIT_BITSET;
+	struct timespec timeout, end;
+	int val = 0;
+
+	if (clockid == CLOCK_REALTIME)
+		futex_op |= FUTEX_CLOCK_REALTIME;
+
+	clock_gettime(clockid, &timeout);
+	timeout.tv_nsec += NSEC_PER_SEC / 10; // 100ms
+	if (timeout.tv_nsec > NSEC_PER_SEC) {
+		timeout.tv_sec++;
+		timeout.tv_nsec -= NSEC_PER_SEC;
+	}
+
+	if (syscall(__NR_futex, &val, futex_op, 0,
+		    &timeout, 0, FUTEX_BITSET_MATCH_ANY) >= 0) {
+		ksft_test_result_fail("futex didn't return ETIMEDOUT\n");
+		return 1;
+	}
+
+	if (errno != ETIMEDOUT) {
+		ksft_test_result_fail("futex didn't return ETIMEDOUT: %s\n",
+							strerror(errno));
+		return 1;
+	}
+
+	clock_gettime(clockid, &end);
+
+	if (end.tv_sec < timeout.tv_sec ||
+	    (end.tv_sec == timeout.tv_sec && end.tv_nsec < timeout.tv_nsec)) {
+		ksft_test_result_fail("futex slept less than 100ms\n");
+		return 1;
+	}
+
+
+	ksft_test_result_pass("futex with the %d clockid\n", clockid);
+
+	return 0;
+}
+
+int main(int argc, char *argv[])
+{
+	int status, len, fd;
+	char buf[4096];
+	pid_t pid;
+	struct timespec mtime_now;
+
+	nscheck();
+
+	ksft_set_plan(2);
+
+	clock_gettime(CLOCK_MONOTONIC, &mtime_now);
+
+	if (unshare_timens())
+		return 1;
+
+	len = snprintf(buf, sizeof(buf), "%d %d 0",
+			CLOCK_MONOTONIC, 70 * 24 * 3600);
+	fd = open("/proc/self/timens_offsets", O_WRONLY);
+	if (fd < 0)
+		return pr_perror("/proc/self/timens_offsets");
+
+	if (write(fd, buf, len) != len)
+		return pr_perror("/proc/self/timens_offsets");
+
+	close(fd);
+
+	pid = fork();
+	if (pid < 0)
+		return pr_perror("Unable to fork");
+	if (pid == 0) {
+		int ret = 0;
+
+		ret |= run_test(CLOCK_REALTIME);
+		ret |= run_test(CLOCK_MONOTONIC);
+		if (ret)
+			ksft_exit_fail();
+		ksft_exit_pass();
+		return 0;
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
