Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD67BA5143
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Sep 2019 10:18:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729843AbfIBISR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 2 Sep 2019 04:18:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56307 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730291AbfIBIQu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 2 Sep 2019 04:16:50 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i4hW2-0008A9-8h; Mon, 02 Sep 2019 10:16:46 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 142E01C0DF9;
        Mon,  2 Sep 2019 10:16:38 +0200 (CEST)
Date:   Mon, 02 Sep 2019 08:16:37 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tools: Remove needless thread_map.h include directives
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-fyzvg64cz1ikvyxp8d6nrhz1@git.kernel.org>
References: <tip-fyzvg64cz1ikvyxp8d6nrhz1@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156741219795.17363.6738160777033230898.tip-bot2@tip-bot2>
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

Commit-ID:     ef7d95661d046eddf2cf33847278781404679a2f
Gitweb:        https://git.kernel.org/tip/ef7d95661d046eddf2cf33847278781404679a2f
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 30 Aug 2019 12:18:50 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 31 Aug 2019 22:24:10 -03:00

perf tools: Remove needless thread_map.h include directives

Now that thread_map.h isn't included by any other header, we can check where
it is really needed, i.e. we can remove it and be sure that it isn't
being obtained indirectly.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-fyzvg64cz1ikvyxp8d6nrhz1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c | 1 -
 tools/perf/builtin-top.c          | 1 -
 tools/perf/util/cs-etm.c          | 1 -
 3 files changed, 3 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index 197041f..59e44f9 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -24,7 +24,6 @@
 #include "../../util/evlist.h"
 #include "../../util/evsel.h"
 #include "../../util/pmu.h"
-#include "../../util/thread_map.h"
 #include "../../util/cs-etm.h"
 #include "../../util/util.h"
 
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index eb94121..726e3f2 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -32,7 +32,6 @@
 #include "util/map.h"
 #include "util/session.h"
 #include "util/symbol.h"
-#include "util/thread_map.h"
 #include "util/top.h"
 #include "util/util.h"
 #include <linux/rbtree.h>
diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 3ed1d3b..30c2048 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -30,7 +30,6 @@
 #include "symbol.h"
 #include "tool.h"
 #include "thread.h"
-#include "thread_map.h"
 #include "thread-stack.h"
 #include <tools/libc_compat.h>
 #include "util.h"
