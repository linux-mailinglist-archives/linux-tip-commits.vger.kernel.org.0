Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 52CF3F8DFB
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 Nov 2019 12:19:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727611AbfKLLSi (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 12 Nov 2019 06:18:38 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:34082 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727598AbfKLLSi (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 12 Nov 2019 06:18:38 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUUBg-0000gf-HQ; Tue, 12 Nov 2019 12:18:20 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4C7CA1C0084;
        Tue, 12 Nov 2019 12:18:14 +0100 (CET)
Date:   Tue, 12 Nov 2019 11:18:13 -0000
From:   "tip-bot2 for Leo Yan" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tests: Fix a typo
Cc:     Leo Yan <leo.yan@linaro.org>, Will Deacon <will@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191023083324.12093-1-leo.yan@linaro.org>
References: <20191023083324.12093-1-leo.yan@linaro.org>
MIME-Version: 1.0
Message-ID: <157355749390.29376.17458804774402570506.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     b7dc21f546d854aea75245efd88d455f39f5d005
Gitweb:        https://git.kernel.org/tip/b7dc21f546d854aea75245efd88d455f39f5d005
Author:        Leo Yan <leo.yan@linaro.org>
AuthorDate:    Wed, 23 Oct 2019 16:33:24 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 06 Nov 2019 15:43:05 -03:00

perf tests: Fix a typo

Correct typo in comment: s/suck/stuck.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
Reported-by: Will Deacon <will@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Florian Fainelli <f.fainelli@gmail.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191023083324.12093-1-leo.yan@linaro.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/bp_signal.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/tests/bp_signal.c b/tools/perf/tests/bp_signal.c
index 166f411..415903b 100644
--- a/tools/perf/tests/bp_signal.c
+++ b/tools/perf/tests/bp_signal.c
@@ -295,7 +295,7 @@ bool test__bp_signal_is_supported(void)
 	 * breakpointed instruction.
 	 *
 	 * Since arm64 has the same issue with arm for the single-step
-	 * handling, this case also gets suck on the breakpointed
+	 * handling, this case also gets stuck on the breakpointed
 	 * instruction.
 	 *
 	 * Just disable the test for these architectures until these
