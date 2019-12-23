Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6974B129B1D
	for <lists+linux-tip-commits@lfdr.de>; Mon, 23 Dec 2019 22:35:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbfLWVfb (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 23 Dec 2019 16:35:31 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:38404 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726832AbfLWVfa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 23 Dec 2019 16:35:30 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ijVMB-0007BJ-FM; Mon, 23 Dec 2019 22:35:15 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id E33F21C2BAC;
        Mon, 23 Dec 2019 22:35:14 +0100 (CET)
Date:   Mon, 23 Dec 2019 21:35:14 -0000
From:   "tip-bot2 for Jin Yao" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf report: Fix incorrectly added dimensions as
 switch perf data file
Cc:     Jin Yao <yao.jin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Feng Tang <feng.tang@intel.com>, Jin Yao <yao.jin@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191220013722.20592-1-yao.jin@linux.intel.com>
References: <20191220013722.20592-1-yao.jin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <157713691482.30329.9182370791656078999.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     0feba17bd7ee3b7e03d141f119049dcc23efa94e
Gitweb:        https://git.kernel.org/tip/0feba17bd7ee3b7e03d141f119049dcc23efa94e
Author:        Jin Yao <yao.jin@linux.intel.com>
AuthorDate:    Fri, 20 Dec 2019 09:37:19 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 20 Dec 2019 18:49:27 -03:00

perf report: Fix incorrectly added dimensions as switch perf data file

We observed an issue that was some extra columns displayed after switching
perf data file in browser. The steps to reproduce:

1. perf record -a -e cycles,instructions -- sleep 3
2. perf report --group
3. In browser, we use hotkey 's' to switch to another perf.data
4. Now in browser, the extra columns 'Self' and 'Children' are displayed.

The issue is setup_sorting() executed again after repeat path, so dimensions
are added again.

This patch checks the last key returned from __cmd_report(). If it's
K_SWITCH_INPUT_DATA, skips the setup_sorting().

Fixes: ad0de0971b7f ("perf report: Enable the runtime switching of perf data file")
Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Feng Tang <feng.tang@intel.com>
Cc: Jin Yao <yao.jin@intel.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191220013722.20592-1-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-report.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 387311c..de98858 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -1076,6 +1076,7 @@ int cmd_report(int argc, const char **argv)
 	struct stat st;
 	bool has_br_stack = false;
 	int branch_mode = -1;
+	int last_key = 0;
 	bool branch_call_mode = false;
 #define CALLCHAIN_DEFAULT_OPT  "graph,0.5,caller,function,percent"
 	static const char report_callchain_help[] = "Display call graph (stack chain/backtrace):\n\n"
@@ -1450,7 +1451,8 @@ repeat:
 		sort_order = sort_tmp;
 	}
 
-	if (setup_sorting(session->evlist) < 0) {
+	if ((last_key != K_SWITCH_INPUT_DATA) &&
+	    (setup_sorting(session->evlist) < 0)) {
 		if (sort_order)
 			parse_options_usage(report_usage, options, "s", 1);
 		if (field_order)
@@ -1530,6 +1532,7 @@ repeat:
 	ret = __cmd_report(&report);
 	if (ret == K_SWITCH_INPUT_DATA) {
 		perf_session__delete(session);
+		last_key = K_SWITCH_INPUT_DATA;
 		goto repeat;
 	} else
 		ret = 0;
