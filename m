Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46AE11CAED1
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 May 2020 15:16:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729995AbgEHNEs (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 8 May 2020 09:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729403AbgEHNEr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 8 May 2020 09:04:47 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84066C05BD09;
        Fri,  8 May 2020 06:04:47 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gF-000792-Ci; Fri, 08 May 2020 15:04:43 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 159FC1C0475;
        Fri,  8 May 2020 15:04:43 +0200 (CEST)
Date:   Fri, 08 May 2020 13:04:43 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf sched: Rename perf_evsel__*() operating on
 'struct evsel *' to evsel__*()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894308303.8414.8565640572584487073.tip-bot2@tip-bot2>
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

Commit-ID:     3b7313f2d7bbff44ea951c6602bee58c0148cf21
Gitweb:        https://git.kernel.org/tip/3b7313f2d7bbff44ea951c6602bee58c0148cf21
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 04 May 2020 13:56:31 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:31 -03:00

perf sched: Rename perf_evsel__*() operating on 'struct evsel *' to evsel__*()

As those is a 'struct evsel' methods, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-sched.c | 17 ++++++++---------
 1 file changed, 8 insertions(+), 9 deletions(-)

diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index b993980..459e422 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -1848,7 +1848,7 @@ static inline void print_sched_time(unsigned long long nsecs, int width)
  * returns runtime data for event, allocating memory for it the
  * first time it is used.
  */
-static struct evsel_runtime *perf_evsel__get_runtime(struct evsel *evsel)
+static struct evsel_runtime *evsel__get_runtime(struct evsel *evsel)
 {
 	struct evsel_runtime *r = evsel->priv;
 
@@ -1863,10 +1863,9 @@ static struct evsel_runtime *perf_evsel__get_runtime(struct evsel *evsel)
 /*
  * save last time event was seen per cpu
  */
-static void perf_evsel__save_time(struct evsel *evsel,
-				  u64 timestamp, u32 cpu)
+static void evsel__save_time(struct evsel *evsel, u64 timestamp, u32 cpu)
 {
-	struct evsel_runtime *r = perf_evsel__get_runtime(evsel);
+	struct evsel_runtime *r = evsel__get_runtime(evsel);
 
 	if (r == NULL)
 		return;
@@ -1890,9 +1889,9 @@ static void perf_evsel__save_time(struct evsel *evsel,
 }
 
 /* returns last time this event was seen on the given cpu */
-static u64 perf_evsel__get_time(struct evsel *evsel, u32 cpu)
+static u64 evsel__get_time(struct evsel *evsel, u32 cpu)
 {
-	struct evsel_runtime *r = perf_evsel__get_runtime(evsel);
+	struct evsel_runtime *r = evsel__get_runtime(evsel);
 
 	if ((r == NULL) || (r->last_time == NULL) || (cpu >= r->ncpu))
 		return 0;
@@ -2548,7 +2547,7 @@ static int timehist_sched_change_event(struct perf_tool *tool,
 		goto out;
 	}
 
-	tprev = perf_evsel__get_time(evsel, sample->cpu);
+	tprev = evsel__get_time(evsel, sample->cpu);
 
 	/*
 	 * If start time given:
@@ -2631,7 +2630,7 @@ out:
 		tr->ready_to_run = 0;
 	}
 
-	perf_evsel__save_time(evsel, sample->time, sample->cpu);
+	evsel__save_time(evsel, sample->time, sample->cpu);
 
 	return rc;
 }
@@ -2941,7 +2940,7 @@ static int timehist_check_attr(struct perf_sched *sched,
 	struct evsel_runtime *er;
 
 	list_for_each_entry(evsel, &evlist->core.entries, core.node) {
-		er = perf_evsel__get_runtime(evsel);
+		er = evsel__get_runtime(evsel);
 		if (er == NULL) {
 			pr_err("Failed to allocate memory for evsel runtime data\n");
 			return -1;
