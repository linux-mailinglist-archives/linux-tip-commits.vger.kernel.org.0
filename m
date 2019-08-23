Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E5D69AF45
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Aug 2019 14:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394575AbfHWMYP (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 23 Aug 2019 08:24:15 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:35254 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387492AbfHWMYN (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 23 Aug 2019 08:24:13 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i18bx-0001q1-0P; Fri, 23 Aug 2019 14:24:09 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AB6EF1C04F3;
        Fri, 23 Aug 2019 14:24:08 +0200 (CEST)
Date:   Fri, 23 Aug 2019 12:24:08 -0000
From:   tip-bot2 for Arnaldo Carvalho de Melo <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tests: Add missing counts.h
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, linux-kernel@vger.kernel.org
In-Reply-To: <tip-phldqlfxxu563txja7evd4zt@git.kernel.org>
References: <tip-phldqlfxxu563txja7evd4zt@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156656304858.32111.3122202198057924685.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from
 these emails
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     e4aec1b1bdad744f3afc3ebf2b337ac1bcfa9be0
Gitweb:        https://git.kernel.org/tip/e4aec1b1bdad744f3afc3ebf2b337ac1bcfa9be0
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 21 Aug 2019 14:01:24 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 22 Aug 2019 17:16:57 -03:00

perf tests: Add missing counts.h

Those are getting counts.h via evsel.h, that don't strictly need
counts.h, just forward declarations for some structs, so add it here
before we remove it from there.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-phldqlfxxu563txja7evd4zt@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/openat-syscall-all-cpus.c | 1 +
 tools/perf/tests/openat-syscall.c          | 1 +
 2 files changed, 2 insertions(+)

diff --git a/tools/perf/tests/openat-syscall-all-cpus.c b/tools/perf/tests/openat-syscall-all-cpus.c
index 8322b6a..4ae4dea 100644
--- a/tools/perf/tests/openat-syscall-all-cpus.c
+++ b/tools/perf/tests/openat-syscall-all-cpus.c
@@ -16,6 +16,7 @@
 #include "cpumap.h"
 #include "debug.h"
 #include "stat.h"
+#include "util/counts.h"
 
 int test__openat_syscall_event_on_all_cpus(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
diff --git a/tools/perf/tests/openat-syscall.c b/tools/perf/tests/openat-syscall.c
index f217972..58df4bd 100644
--- a/tools/perf/tests/openat-syscall.c
+++ b/tools/perf/tests/openat-syscall.c
@@ -10,6 +10,7 @@
 #include "evsel.h"
 #include "debug.h"
 #include "tests.h"
+#include "util/counts.h"
 
 int test__openat_syscall_event(struct test *test __maybe_unused, int subtest __maybe_unused)
 {
