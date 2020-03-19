Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BCD3C18B8C7
	for <lists+linux-tip-commits@lfdr.de>; Thu, 19 Mar 2020 15:11:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727933AbgCSOLM (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 19 Mar 2020 10:11:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:32848 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727949AbgCSOLL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 19 Mar 2020 10:11:11 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEvsw-0002Fw-Th; Thu, 19 Mar 2020 15:10:59 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 32D0D1C22AC;
        Thu, 19 Mar 2020 15:10:52 +0100 (CET)
Date:   Thu, 19 Mar 2020 14:10:51 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf expr: Add expr.c object
Cc:     Jiri Olsa <jolsa@kernel.org>, Andi Kleen <ak@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Kajol Jain <kjain@linux.ibm.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200228093616.67125-2-jolsa@kernel.org>
References: <20200228093616.67125-2-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <158462705181.28353.9884213405921971659.tip-bot2@tip-bot2>
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

Commit-ID:     576a65b6974ddc830a89b6feb6823bd6b5914bde
Gitweb:        https://git.kernel.org/tip/576a65b6974ddc830a89b6feb6823bd6b5914bde
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Fri, 28 Feb 2020 10:36:12 +01:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 09 Mar 2020 21:43:24 -03:00

perf expr: Add expr.c object

Add generic expr code into new expr.c object.

The expr.c object will be mainly used in following change that will get
rid of the manual flex code,

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Reviewed-by: Andi Kleen <ak@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Kajol Jain <kjain@linux.ibm.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: http://lore.kernel.org/lkml/20200228093616.67125-2-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/Build  |  1 +
 tools/perf/util/expr.c | 19 +++++++++++++++++++
 tools/perf/util/expr.y | 16 ----------------
 3 files changed, 20 insertions(+), 16 deletions(-)
 create mode 100644 tools/perf/util/expr.c

diff --git a/tools/perf/util/Build b/tools/perf/util/Build
index 07da6c7..6fdf073 100644
--- a/tools/perf/util/Build
+++ b/tools/perf/util/Build
@@ -122,6 +122,7 @@ perf-y += vsprintf.o
 perf-y += units.o
 perf-y += time-utils.o
 perf-y += expr-bison.o
+perf-y += expr.o
 perf-y += branch.o
 perf-y += mem2node.o
 
diff --git a/tools/perf/util/expr.c b/tools/perf/util/expr.c
new file mode 100644
index 0000000..816b23b
--- /dev/null
+++ b/tools/perf/util/expr.c
@@ -0,0 +1,19 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <assert.h>
+#include "expr.h"
+
+/* Caller must make sure id is allocated */
+void expr__add_id(struct parse_ctx *ctx, const char *name, double val)
+{
+	int idx;
+
+	assert(ctx->num_ids < MAX_PARSE_ID);
+	idx = ctx->num_ids++;
+	ctx->ids[idx].name = name;
+	ctx->ids[idx].val = val;
+}
+
+void expr__ctx_init(struct parse_ctx *ctx)
+{
+	ctx->num_ids = 0;
+}
diff --git a/tools/perf/util/expr.y b/tools/perf/util/expr.y
index 7d22624..7cea8b7 100644
--- a/tools/perf/util/expr.y
+++ b/tools/perf/util/expr.y
@@ -6,7 +6,6 @@
 #define IN_EXPR_Y 1
 #include "expr.h"
 #include "smt.h"
-#include <assert.h>
 #include <string.h>
 
 #define MAXIDLEN 256
@@ -169,21 +168,6 @@ static int expr__lex(YYSTYPE *res, const char **pp)
 	return tok;
 }
 
-/* Caller must make sure id is allocated */
-void expr__add_id(struct parse_ctx *ctx, const char *name, double val)
-{
-	int idx;
-	assert(ctx->num_ids < MAX_PARSE_ID);
-	idx = ctx->num_ids++;
-	ctx->ids[idx].name = name;
-	ctx->ids[idx].val = val;
-}
-
-void expr__ctx_init(struct parse_ctx *ctx)
-{
-	ctx->num_ids = 0;
-}
-
 static bool already_seen(const char *val, const char *one, const char **other,
 			 int num_other)
 {
