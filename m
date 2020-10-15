Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 250C628EF6B
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Oct 2020 11:35:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730757AbgJOJfh (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 15 Oct 2020 05:35:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730755AbgJOJfg (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 15 Oct 2020 05:35:36 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52B21C061755;
        Thu, 15 Oct 2020 02:35:36 -0700 (PDT)
Date:   Thu, 15 Oct 2020 09:35:33 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1602754534;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8pzU8307S+NBSsLiJ2mItS3Ff6k+hS6qnBXCo7/7sdo=;
        b=vSkBWZ5dsJ9oXKRcScAHzQQL3jLlFLdKpcOzhl67k3SXBoTKGUsvDvEF0ATyn/ZXQRmN67
        nQBd/JIZ59qKgve/BU5Zy40LONmlLyA4a/bulCNqClwWzywDz4FcdNAl8IyyWb2PSNKhh0
        d1Ztp4agtS4YmBQg76vpLEsypu1mmeEKjVcynKO5FeJ556r1va3DIEGXUCxaSxOg82wlZm
        rwbbvQw0Abt9XnvajNK9KIEoU0wS+iiPvQtCmxV6sulaUPF+JSFGXfpLa32KrQ0o6RMu1y
        c5AtinLw4fA9NKePVlns3CtDXMJ3JoMAfKWh4Wf5rDe+b4Yva3eew08fPwALVA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1602754534;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8pzU8307S+NBSsLiJ2mItS3Ff6k+hS6qnBXCo7/7sdo=;
        b=Q3Ur16YFeXOp8fdeukMB4TNINPZ0SvdhvlCPkHM1c/wBPEQIekakSedVEDah5WtnV33lYo
        KAPALNrOY4gC0gBQ==
From:   "tip-bot2 for Andrei Vagin" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: timers/urgent] selftests/timens: Add a test for futex()
Cc:     Andrei Vagin <avagin@gmail.com>,
        Thomas Gleixner <tglx@linutronix.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20201015072909.271426-2-avagin@gmail.com>
References: <20201015072909.271426-2-avagin@gmail.com>
MIME-Version: 1.0
Message-ID: <160275453302.7002.11708173541121385671.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the timers/urgent branch of tip:

Commit-ID:     4cdf42596216e08051c0ccc4c896dcb8b2d22f10
Gitweb:        https://git.kernel.org/tip/4cdf42596216e08051c0ccc4c896dcb8b2d22f10
Author:        Andrei Vagin <avagin@gmail.com>
AuthorDate:    Thu, 15 Oct 2020 00:29:09 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 15 Oct 2020 11:24:04 +02:00

selftests/timens: Add a test for futex()

Output on success:
 $ ./futex
 1..1
 ok 1 futex
 # Totals: pass:1 fail:0 xfail:0 xpass:0 skip:0 error:0

Signed-off-by: Andrei Vagin <avagin@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20201015072909.271426-2-avagin@gmail.com

---
 tools/testing/selftests/timens/Makefile |   2 +-
 tools/testing/selftests/timens/futex.c  | 107 +++++++++++++++++++++++-
 2 files changed, 108 insertions(+), 1 deletion(-)
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
index 0000000..173760d
--- /dev/null
+++ b/tools/testing/selftests/timens/futex.c
@@ -0,0 +1,107 @@
+// SPDX-License-Identifier: GPL-2.0
+#define _GNU_SOURCE
+#include <sched.h>
+
+#include <linux/unistd.h>
+#include <linux/futex.h>
+#include <stdlib.h>
+#include <signal.h>
+#include <stdio.h>
+#include <stdint.h>
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
+static int run_test(void)
+{
+	struct timespec timeout, end;
+	int val = 0;
+
+	clock_gettime(CLOCK_MONOTONIC, &timeout);
+	timeout.tv_nsec += NSEC_PER_SEC / 10; // 100ms
+	if (timeout.tv_nsec > NSEC_PER_SEC) {
+		timeout.tv_sec++;
+		timeout.tv_nsec -= NSEC_PER_SEC;
+	}
+
+	if (syscall(__NR_futex, &val, FUTEX_WAIT_BITSET, 0,
+		    &timeout, 0, FUTEX_BITSET_MATCH_ANY) >= 0) {
+		ksft_test_result_fail("futex didn't return ETIMEDOUT");
+		return 1;
+	}
+
+	if (errno != ETIMEDOUT) {
+		ksft_test_result_fail("futex didn't return ETIMEDOUT: %s",
+							strerror(errno));
+		return 1;
+	}
+
+	clock_gettime(CLOCK_MONOTONIC, &end);
+
+	if (end.tv_sec < timeout.tv_sec ||
+	    (end.tv_sec == timeout.tv_sec && end.tv_nsec < timeout.tv_sec)) {
+		ksft_test_result_fail("futex slept less than 100ms");
+		return 1;
+	}
+
+
+	ksft_test_result_pass("futex\n");
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
+	check_supported_timers();
+
+	ksft_set_plan(1);
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
+		if (run_test())
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
