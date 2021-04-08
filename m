Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC22C3582F6
	for <lists+linux-tip-commits@lfdr.de>; Thu,  8 Apr 2021 14:13:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbhDHMNx (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 8 Apr 2021 08:13:53 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:43200 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbhDHMNx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 8 Apr 2021 08:13:53 -0400
Date:   Thu, 08 Apr 2021 12:13:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1617884021;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NFRpOciehEP7XXap4n9wiWt3b54WKnAhswjRmZ64ELs=;
        b=EO4WmbNPaiVcqEAPONpyeqZFkLbeZtrPpSOxRElFj/Gzts9lux+P8ZYiKTByKPkAoxD95j
        kc336VWrSIqU5rR5zUNGjwiMzQ0jNQKBX/Eh3YYHa7wUUqrCVlp/ZeJdQVyHcesxNDwCqQ
        9YX92ElkKi9p3h8KOJ0R5fXy2D3lQ7dgbC82rZE2UCQEve7+3+x4/TSONxzwdW0/0nVS0S
        YFXawSShF1N1/sqj6y3FGdIW/bnuIyOjSy2NPzwhvAA9b8k4PprmqxdFB9zYut/PNIPEhP
        rLSGSGdG0bqcmPvKh15tVdUF7DHwVmJq423ld7GdqHARR3Dzoe/JjCJYUWWvUw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1617884021;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NFRpOciehEP7XXap4n9wiWt3b54WKnAhswjRmZ64ELs=;
        b=iPpROZl0+LEdEMo1H16XNSWvSznLfzJ51lXbVfsAMoeFscrpHEyLjGPWr1VoYGEyHh+RoS
        MlOgq8WhOFqK7OBA==
From:   "tip-bot2 for Kees Cook" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/entry] lkdtm: Add REPORT_STACK for checking stack offsets
Cc:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20210401232347.2791257-7-keescook@chromium.org>
References: <20210401232347.2791257-7-keescook@chromium.org>
MIME-Version: 1.0
Message-ID: <161788402056.29796.10077892383325680647.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the x86/entry branch of tip:

Commit-ID:     68ef8735d253f3d840082b78f996bf2d89ee6e5f
Gitweb:        https://git.kernel.org/tip/68ef8735d253f3d840082b78f996bf2d89ee6e5f
Author:        Kees Cook <keescook@chromium.org>
AuthorDate:    Thu, 01 Apr 2021 16:23:47 -07:00
Committer:     Thomas Gleixner <tglx@linutronix.de>
CommitterDate: Thu, 08 Apr 2021 14:05:20 +02:00

lkdtm: Add REPORT_STACK for checking stack offsets

For validating the stack offset behavior, report the offset from a given
process's first seen stack address. Add s script to calculate the results
to the LKDTM kselftests.

Signed-off-by: Kees Cook <keescook@chromium.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Link: https://lore.kernel.org/r/20210401232347.2791257-7-keescook@chromium.org

---
 drivers/misc/lkdtm/bugs.c                      | 17 ++++++++-
 drivers/misc/lkdtm/core.c                      |  1 +-
 drivers/misc/lkdtm/lkdtm.h                     |  1 +-
 tools/testing/selftests/lkdtm/.gitignore       |  1 +-
 tools/testing/selftests/lkdtm/Makefile         |  1 +-
 tools/testing/selftests/lkdtm/stack-entropy.sh | 36 +++++++++++++++++-
 6 files changed, 57 insertions(+)
 create mode 100755 tools/testing/selftests/lkdtm/stack-entropy.sh

diff --git a/drivers/misc/lkdtm/bugs.c b/drivers/misc/lkdtm/bugs.c
index 110f5a8..0e8254d 100644
--- a/drivers/misc/lkdtm/bugs.c
+++ b/drivers/misc/lkdtm/bugs.c
@@ -134,6 +134,23 @@ noinline void lkdtm_CORRUPT_STACK_STRONG(void)
 	__lkdtm_CORRUPT_STACK((void *)&data);
 }
 
+static pid_t stack_pid;
+static unsigned long stack_addr;
+
+void lkdtm_REPORT_STACK(void)
+{
+	volatile uintptr_t magic;
+	pid_t pid = task_pid_nr(current);
+
+	if (pid != stack_pid) {
+		pr_info("Starting stack offset tracking for pid %d\n", pid);
+		stack_pid = pid;
+		stack_addr = (uintptr_t)&magic;
+	}
+
+	pr_info("Stack offset: %d\n", (int)(stack_addr - (uintptr_t)&magic));
+}
+
 void lkdtm_UNALIGNED_LOAD_STORE_WRITE(void)
 {
 	static u8 data[5] __attribute__((aligned(4))) = {1, 2, 3, 4, 5};
diff --git a/drivers/misc/lkdtm/core.c b/drivers/misc/lkdtm/core.c
index b2aff4d..8024b6a 100644
--- a/drivers/misc/lkdtm/core.c
+++ b/drivers/misc/lkdtm/core.c
@@ -110,6 +110,7 @@ static const struct crashtype crashtypes[] = {
 	CRASHTYPE(EXHAUST_STACK),
 	CRASHTYPE(CORRUPT_STACK),
 	CRASHTYPE(CORRUPT_STACK_STRONG),
+	CRASHTYPE(REPORT_STACK),
 	CRASHTYPE(CORRUPT_LIST_ADD),
 	CRASHTYPE(CORRUPT_LIST_DEL),
 	CRASHTYPE(STACK_GUARD_PAGE_LEADING),
diff --git a/drivers/misc/lkdtm/lkdtm.h b/drivers/misc/lkdtm/lkdtm.h
index 5ae48c6..99f90d3 100644
--- a/drivers/misc/lkdtm/lkdtm.h
+++ b/drivers/misc/lkdtm/lkdtm.h
@@ -17,6 +17,7 @@ void lkdtm_LOOP(void);
 void lkdtm_EXHAUST_STACK(void);
 void lkdtm_CORRUPT_STACK(void);
 void lkdtm_CORRUPT_STACK_STRONG(void);
+void lkdtm_REPORT_STACK(void);
 void lkdtm_UNALIGNED_LOAD_STORE_WRITE(void);
 void lkdtm_SOFTLOCKUP(void);
 void lkdtm_HARDLOCKUP(void);
diff --git a/tools/testing/selftests/lkdtm/.gitignore b/tools/testing/selftests/lkdtm/.gitignore
index f262126..d4b0be8 100644
--- a/tools/testing/selftests/lkdtm/.gitignore
+++ b/tools/testing/selftests/lkdtm/.gitignore
@@ -1,2 +1,3 @@
 *.sh
 !run.sh
+!stack-entropy.sh
diff --git a/tools/testing/selftests/lkdtm/Makefile b/tools/testing/selftests/lkdtm/Makefile
index 1bcc9ee..c71109c 100644
--- a/tools/testing/selftests/lkdtm/Makefile
+++ b/tools/testing/selftests/lkdtm/Makefile
@@ -5,6 +5,7 @@ include ../lib.mk
 
 # NOTE: $(OUTPUT) won't get default value if used before lib.mk
 TEST_FILES := tests.txt
+TEST_PROGS := stack-entropy.sh
 TEST_GEN_PROGS = $(patsubst %,$(OUTPUT)/%.sh,$(shell awk '{print $$1}' tests.txt | sed -e 's/\#//'))
 all: $(TEST_GEN_PROGS)
 
diff --git a/tools/testing/selftests/lkdtm/stack-entropy.sh b/tools/testing/selftests/lkdtm/stack-entropy.sh
new file mode 100755
index 0000000..b1b8a50
--- /dev/null
+++ b/tools/testing/selftests/lkdtm/stack-entropy.sh
@@ -0,0 +1,36 @@
+#!/bin/sh
+# SPDX-License-Identifier: GPL-2.0
+#
+# Measure kernel stack entropy by sampling via LKDTM's REPORT_STACK test.
+set -e
+samples="${1:-1000}"
+
+# Capture dmesg continuously since it may fill up depending on sample size.
+log=$(mktemp -t stack-entropy-XXXXXX)
+dmesg --follow >"$log" & pid=$!
+report=-1
+for i in $(seq 1 $samples); do
+        echo "REPORT_STACK" >/sys/kernel/debug/provoke-crash/DIRECT
+	if [ -t 1 ]; then
+		percent=$(( 100 * $i / $samples ))
+		if [ "$percent" -ne "$report" ]; then
+			/bin/echo -en "$percent%\r"
+			report="$percent"
+		fi
+	fi
+done
+kill "$pid"
+
+# Count unique offsets since last run.
+seen=$(tac "$log" | grep -m1 -B"$samples"0 'Starting stack offset' | \
+	grep 'Stack offset' | awk '{print $NF}' | sort | uniq -c | wc -l)
+bits=$(echo "obase=2; $seen" | bc | wc -L)
+echo "Bits of stack entropy: $bits"
+rm -f "$log"
+
+# We would expect any functional stack randomization to be at least 5 bits.
+if [ "$bits" -lt 5 ]; then
+	exit 1
+else
+	exit 0
+fi
