Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B815119E3D2
	for <lists+linux-tip-commits@lfdr.de>; Sat,  4 Apr 2020 10:45:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727417AbgDDInm (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 4 Apr 2020 04:43:42 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41666 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726057AbgDDImL (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 4 Apr 2020 04:42:11 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeNM-0001BN-EH; Sat, 04 Apr 2020 10:42:00 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D5CAF1C0809;
        Sat,  4 Apr 2020 10:41:55 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:41:55 -0000
From:   "tip-bot2 for John Garry" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf test: Add pmu-events test
Cc:     John Garry <john.garry@huawei.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linuxarm@huawei.com,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1584442939-8911-5-git-send-email-john.garry@huawei.com>
References: <1584442939-8911-5-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Message-ID: <158598971550.28353.11400211213936783028.tip-bot2@tip-bot2>
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

Commit-ID:     a6c925fd3aa2aba043a73b0ad57ffd296e1c42c9
Gitweb:        https://git.kernel.org/tip/a6c925fd3aa2aba043a73b0ad57ffd296e1c42c9
Author:        John Garry <john.garry@huawei.com>
AuthorDate:    Tue, 17 Mar 2020 19:02:16 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 24 Mar 2020 10:35:59 -03:00

perf test: Add pmu-events test

The initial test will verify that the test tables in generated pmu-events.c
match against known, expected values.

For known events added in pmu-events/arch/test, we need to add an entry
in test_cpu_aliases_events[] or test_uncore_events[].

A sample run is as follows for x86:

  john@linux-3c19:~/linux> tools/perf/perf test -vv 10
  10: PMU event aliases                                     :
  --- start ---
  test child forked, pid 5316
  testing event table bp_l1_btb_correct: pass
  testing event table bp_l2_btb_correct: pass
  testing event table segment_reg_loads.any: pass
  testing event table dispatch_blocked.any: pass
  testing event table eist_trans: pass
  testing event table uncore_hisi_ddrc.flux_wcmd: pass
  testing event table unc_cbo_xsnp_response.miss_eviction: pass
  test child finished with 0
  ---- end ----
  PMU event aliases: Ok

Signed-off-by: John Garry <john.garry@huawei.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: James Clark <james.clark@arm.com>
Cc: Joakim Zhang <qiangqing.zhang@nxp.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: linuxarm@huawei.com
[ Fixup test_cpu_events[] and test_uncore_events[] sentinels to initialize one of its members to NULL, fixing the build in older compilers ]
Link: http://lore.kernel.org/lkml/1584442939-8911-5-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/tests/Build          |   1 +-
 tools/perf/tests/builtin-test.c |   4 +-
 tools/perf/tests/pmu-events.c   | 233 +++++++++++++++++++++++++++++++-
 tools/perf/tests/tests.h        |   1 +-
 4 files changed, 239 insertions(+)
 create mode 100644 tools/perf/tests/pmu-events.c

diff --git a/tools/perf/tests/Build b/tools/perf/tests/Build
index 1692529..b3d1bf1 100644
--- a/tools/perf/tests/Build
+++ b/tools/perf/tests/Build
@@ -14,6 +14,7 @@ perf-y += evsel-roundtrip-name.o
 perf-y += evsel-tp-sched.o
 perf-y += fdarray.o
 perf-y += pmu.o
+perf-y += pmu-events.o
 perf-y += hists_common.o
 perf-y += hists_link.o
 perf-y += hists_filter.o
diff --git a/tools/perf/tests/builtin-test.c b/tools/perf/tests/builtin-test.c
index 54d9516..b6322eb 100644
--- a/tools/perf/tests/builtin-test.c
+++ b/tools/perf/tests/builtin-test.c
@@ -73,6 +73,10 @@ static struct test generic_tests[] = {
 		.func = test__pmu,
 	},
 	{
+		.desc = "PMU events",
+		.func = test__pmu_events,
+	},
+	{
 		.desc = "DSO data read",
 		.func = test__dso_data,
 	},
diff --git a/tools/perf/tests/pmu-events.c b/tools/perf/tests/pmu-events.c
new file mode 100644
index 0000000..12fc297
--- /dev/null
+++ b/tools/perf/tests/pmu-events.c
@@ -0,0 +1,233 @@
+// SPDX-License-Identifier: GPL-2.0
+#include "parse-events.h"
+#include "pmu.h"
+#include "tests.h"
+#include <errno.h>
+#include <stdio.h>
+#include <linux/kernel.h>
+
+#include "debug.h"
+#include "../pmu-events/pmu-events.h"
+
+struct perf_pmu_test_event {
+	struct pmu_event event;
+};
+static struct perf_pmu_test_event test_cpu_events[] = {
+	{
+		.event = {
+			.name = "bp_l1_btb_correct",
+			.event = "event=0x8a",
+			.desc = "L1 BTB Correction",
+			.topic = "branch",
+		},
+	},
+	{
+		.event = {
+			.name = "bp_l2_btb_correct",
+			.event = "event=0x8b",
+			.desc = "L2 BTB Correction",
+			.topic = "branch",
+		},
+	},
+	{
+		.event = {
+			.name = "segment_reg_loads.any",
+			.event = "umask=0x80,period=200000,event=0x6",
+			.desc = "Number of segment register loads",
+			.topic = "other",
+		},
+	},
+	{
+		.event = {
+			.name = "dispatch_blocked.any",
+			.event = "umask=0x20,period=200000,event=0x9",
+			.desc = "Memory cluster signals to block micro-op dispatch for any reason",
+			.topic = "other",
+		},
+	},
+	{
+		.event = {
+			.name = "eist_trans",
+			.event = "umask=0x0,period=200000,event=0x3a",
+			.desc = "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions",
+			.topic = "other",
+		},
+	},
+	{ /* sentinel */
+		.event = {
+			.name = NULL,
+		},
+	},
+};
+
+static struct perf_pmu_test_event test_uncore_events[] = {
+	{
+		.event = {
+			.name = "uncore_hisi_ddrc.flux_wcmd",
+			.event = "event=0x2",
+			.desc = "DDRC write commands. Unit: hisi_sccl,ddrc ",
+			.topic = "uncore",
+			.long_desc = "DDRC write commands",
+			.pmu = "hisi_sccl,ddrc",
+		},
+	},
+	{
+		.event = {
+			.name = "unc_cbo_xsnp_response.miss_eviction",
+			.event = "umask=0x81,event=0x22",
+			.desc = "Unit: uncore_cbox A cross-core snoop resulted from L3 Eviction which misses in some processor core",
+			.topic = "uncore",
+			.long_desc = "A cross-core snoop resulted from L3 Eviction which misses in some processor core",
+			.pmu = "uncore_cbox",
+		},
+	},
+	{ /* sentinel */
+		.event = {
+			.name = NULL,
+		},
+	}
+};
+
+const int total_test_events_size = ARRAY_SIZE(test_uncore_events);
+
+static bool is_same(const char *reference, const char *test)
+{
+	if (!reference && !test)
+		return true;
+
+	if (reference && !test)
+		return false;
+
+	if (!reference && test)
+		return false;
+
+	return !strcmp(reference, test);
+}
+
+static struct pmu_events_map *__test_pmu_get_events_map(void)
+{
+	struct pmu_events_map *map;
+
+	for (map = &pmu_events_map[0]; map->cpuid; map++) {
+		if (!strcmp(map->cpuid, "testcpu"))
+			return map;
+	}
+
+	pr_err("could not find test events map\n");
+
+	return NULL;
+}
+
+/* Verify generated events from pmu-events.c is as expected */
+static int __test_pmu_event_table(void)
+{
+	struct pmu_events_map *map = __test_pmu_get_events_map();
+	struct pmu_event *table;
+	int map_events = 0, expected_events;
+
+	/* ignore 2x sentinels */
+	expected_events = ARRAY_SIZE(test_cpu_events) +
+			  ARRAY_SIZE(test_uncore_events) - 2;
+
+	if (!map)
+		return -1;
+
+	for (table = map->table; table->name; table++) {
+		struct perf_pmu_test_event *test;
+		struct pmu_event *te;
+		bool found = false;
+
+		if (table->pmu)
+			test = &test_uncore_events[0];
+		else
+			test = &test_cpu_events[0];
+
+		te = &test->event;
+
+		for (; te->name; test++, te = &test->event) {
+			if (strcmp(table->name, te->name))
+				continue;
+			found = true;
+			map_events++;
+
+			if (!is_same(table->desc, te->desc)) {
+				pr_debug2("testing event table %s: mismatched desc, %s vs %s\n",
+					  table->name, table->desc, te->desc);
+				return -1;
+			}
+
+			if (!is_same(table->topic, te->topic)) {
+				pr_debug2("testing event table %s: mismatched topic, %s vs %s\n",
+					  table->name, table->topic,
+					  te->topic);
+				return -1;
+			}
+
+			if (!is_same(table->long_desc, te->long_desc)) {
+				pr_debug2("testing event table %s: mismatched long_desc, %s vs %s\n",
+					  table->name, table->long_desc,
+					  te->long_desc);
+				return -1;
+			}
+
+			if (!is_same(table->unit, te->unit)) {
+				pr_debug2("testing event table %s: mismatched unit, %s vs %s\n",
+					  table->name, table->unit,
+					  te->unit);
+				return -1;
+			}
+
+			if (!is_same(table->perpkg, te->perpkg)) {
+				pr_debug2("testing event table %s: mismatched perpkg, %s vs %s\n",
+					  table->name, table->perpkg,
+					  te->perpkg);
+				return -1;
+			}
+
+			if (!is_same(table->metric_expr, te->metric_expr)) {
+				pr_debug2("testing event table %s: mismatched metric_expr, %s vs %s\n",
+					  table->name, table->metric_expr,
+					  te->metric_expr);
+				return -1;
+			}
+
+			if (!is_same(table->metric_name, te->metric_name)) {
+				pr_debug2("testing event table %s: mismatched metric_name, %s vs %s\n",
+					  table->name,  table->metric_name,
+					  te->metric_name);
+				return -1;
+			}
+
+			if (!is_same(table->deprecated, te->deprecated)) {
+				pr_debug2("testing event table %s: mismatched deprecated, %s vs %s\n",
+					  table->name, table->deprecated,
+					  te->deprecated);
+				return -1;
+			}
+
+			pr_debug("testing event table %s: pass\n", table->name);
+		}
+
+		if (!found) {
+			pr_err("testing event table: could not find event %s\n",
+			       table->name);
+			return -1;
+		}
+	}
+
+	if (map_events != expected_events) {
+		pr_err("testing event table: found %d, but expected %d\n",
+		       map_events, expected_events);
+		return -1;
+	}
+
+	return 0;
+}
+int test__pmu_events(struct test *test __maybe_unused,
+		     int subtest __maybe_unused)
+{
+	if (__test_pmu_event_table())
+		return -1;
+
+	return 0;
+}
diff --git a/tools/perf/tests/tests.h b/tools/perf/tests/tests.h
index 9a160fe..61a1ab0 100644
--- a/tools/perf/tests/tests.h
+++ b/tools/perf/tests/tests.h
@@ -49,6 +49,7 @@ int test__perf_evsel__roundtrip_name_test(struct test *test, int subtest);
 int test__perf_evsel__tp_sched_test(struct test *test, int subtest);
 int test__syscall_openat_tp_fields(struct test *test, int subtest);
 int test__pmu(struct test *test, int subtest);
+int test__pmu_events(struct test *test, int subtest);
 int test__attr(struct test *test, int subtest);
 int test__dso_data(struct test *test, int subtest);
 int test__dso_data_cache(struct test *test, int subtest);
