Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A29521CAED4
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 May 2020 15:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730200AbgEHNEv (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 8 May 2020 09:04:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729385AbgEHNEu (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 8 May 2020 09:04:50 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96DD1C05BD43;
        Fri,  8 May 2020 06:04:50 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gH-0007AK-Er; Fri, 08 May 2020 15:04:45 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4115B1C04CD;
        Fri,  8 May 2020 15:04:44 +0200 (CEST)
Date:   Fri, 08 May 2020 13:04:44 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf stat: Rename perf_evsel__*() operating on
 'struct evsel *' to evsel__*()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894308416.8414.9605094159789737027.tip-bot2@tip-bot2>
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

Commit-ID:     ddc6999eaf4edfde287ef012591c51f726690778
Gitweb:        https://git.kernel.org/tip/ddc6999eaf4edfde287ef012591c51f726690778
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 04 May 2020 13:46:34 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:31 -03:00

perf stat: Rename perf_evsel__*() operating on 'struct evsel *' to evsel__*()

As those is a 'struct evsel' methods, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-stat.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index b2a9719..e0c1ad2 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -238,9 +238,8 @@ static int write_stat_round_event(u64 tm, u64 type)
 
 #define SID(e, x, y) xyarray__entry(e->core.sample_id, x, y)
 
-static int
-perf_evsel__write_stat_event(struct evsel *counter, u32 cpu, u32 thread,
-			     struct perf_counts_values *count)
+static int evsel__write_stat_event(struct evsel *counter, u32 cpu, u32 thread,
+				   struct perf_counts_values *count)
 {
 	struct perf_sample_id *sid = SID(counter, cpu, thread);
 
@@ -297,7 +296,7 @@ static int read_counter_cpu(struct evsel *counter, struct timespec *rs, int cpu)
 		perf_counts__set_loaded(counter->counts, cpu, thread, false);
 
 		if (STAT_RECORD) {
-			if (perf_evsel__write_stat_event(counter, cpu, thread, count)) {
+			if (evsel__write_stat_event(counter, cpu, thread, count)) {
 				pr_err("failed to write stat event\n");
 				return -1;
 			}
@@ -410,7 +409,7 @@ static void workload_exec_failed_signal(int signo __maybe_unused, siginfo_t *inf
 	workload_exec_errno = info->si_value.sival_int;
 }
 
-static bool perf_evsel__should_store_id(struct evsel *counter)
+static bool evsel__should_store_id(struct evsel *counter)
 {
 	return STAT_RECORD || counter->core.attr.read_format & PERF_FORMAT_ID;
 }
@@ -635,7 +634,7 @@ try_again_reset:
 		if (l > stat_config.unit_width)
 			stat_config.unit_width = l;
 
-		if (perf_evsel__should_store_id(counter) &&
+		if (evsel__should_store_id(counter) &&
 		    evsel__store_ids(counter, evsel_list))
 			return -1;
 	}
