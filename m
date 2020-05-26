Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBEB19E3CA
	for <lists+linux-tip-commits@lfdr.de>; Sat,  4 Apr 2020 10:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726474AbgDDInd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 4 Apr 2020 04:43:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41713 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726520AbgDDImO (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 4 Apr 2020 04:42:14 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeNM-00016H-7g; Sat, 04 Apr 2020 10:42:00 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7438D1C07A5;
        Sat,  4 Apr 2020 10:41:52 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:41:52 -0000
From:   "tip-bot2 for Ian Rogers" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf parse-events: Add defensive NULL check
Cc:     Ian Rogers <irogers@google.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        John Garry <john.garry@huawei.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Stephane Eranian <eranian@google.com>,
        clang-built-linux@googlegroups.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200325164022.41385-1-irogers@google.com>
References: <20200325164022.41385-1-irogers@google.com>
MIME-Version: 1.0
Message-ID: <158598971212.28353.3722461127643050599.tip-bot2@tip-bot2>
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

Commit-ID:     2a3d252dffe14582f238e21b09923e3772263123
Gitweb:        https://git.kernel.org/tip/2a3d252dffe14582f238e21b09923e3772263123
Author:        Ian Rogers <irogers@google.com>
AuthorDate:    Wed, 25 Mar 2020 09:40:22 -07:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 26 Mar 2020 11:03:53 -03:00

perf parse-events: Add defensive NULL check

Terms may have a NULL config in which case a strcmp will SEGV. This can
be reproduced with:

  perf stat -e '*/event=?,nr/' sleep 1

Add a NULL check to avoid this. This was caught by LLVM's libfuzzer.

Signed-off-by: Ian Rogers <irogers@google.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: John Garry <john.garry@huawei.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Stephane Eranian <eranian@google.com>
Cc: clang-built-linux@googlegroups.com
Link: http://lore.kernel.org/lkml/20200325164022.41385-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 616fbda..ef6a63f 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -984,12 +984,11 @@ static int pmu_resolve_param_term(struct parse_events_term *term,
 	struct parse_events_term *t;
 
 	list_for_each_entry(t, head_terms, list) {
-		if (t->type_val == PARSE_EVENTS__TERM_TYPE_NUM) {
-			if (!strcmp(t->config, term->config)) {
-				t->used = true;
-				*value = t->val.num;
-				return 0;
-			}
+		if (t->type_val == PARSE_EVENTS__TERM_TYPE_NUM &&
+		    t->config && !strcmp(t->config, term->config)) {
+			t->used = true;
+			*value = t->val.num;
+			return 0;
 		}
 	}
 
