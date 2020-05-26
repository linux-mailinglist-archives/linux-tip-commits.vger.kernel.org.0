Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C283119E39E
	for <lists+linux-tip-commits@lfdr.de>; Sat,  4 Apr 2020 10:45:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726551AbgDDImO (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 4 Apr 2020 04:42:14 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41687 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbgDDImM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 4 Apr 2020 04:42:12 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeNO-0001DA-GJ; Sat, 04 Apr 2020 10:42:02 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 826721C0493;
        Sat,  4 Apr 2020 10:41:57 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:41:56 -0000
From:   "tip-bot2 for John Garry" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf jevents: Add some test events
Cc:     John Garry <john.garry@huawei.com>, Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        James Clark <james.clark@arm.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>, linuxarm@huawei.com,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1584442939-8911-2-git-send-email-john.garry@huawei.com>
References: <1584442939-8911-2-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Message-ID: <158598971698.28353.17567235259894969705.tip-bot2@tip-bot2>
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

Commit-ID:     c52db67a74b3a9b834af4588489cfea22ec280a3
Gitweb:        https://git.kernel.org/tip/c52db67a74b3a9b834af4588489cfea22ec280a3
Author:        John Garry <john.garry@huawei.com>
AuthorDate:    Tue, 17 Mar 2020 19:02:13 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 24 Mar 2020 10:35:59 -03:00

perf jevents: Add some test events

Add some test PMU events. The events are randomly chosen from x86 and
arm64 JSONs. The events include CPU and uncore events.

Signed-off-by: John Garry <john.garry@huawei.com>
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
Link: http://lore.kernel.org/lkml/1584442939-8911-2-git-send-email-john.garry@huawei.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/pmu-events/arch/test/test_cpu/branch.json | 12 +++++-
 tools/perf/pmu-events/arch/test/test_cpu/other.json  | 26 +++++++++++-
 tools/perf/pmu-events/arch/test/test_cpu/uncore.json | 21 +++++++++-
 3 files changed, 59 insertions(+)
 create mode 100644 tools/perf/pmu-events/arch/test/test_cpu/branch.json
 create mode 100644 tools/perf/pmu-events/arch/test/test_cpu/other.json
 create mode 100644 tools/perf/pmu-events/arch/test/test_cpu/uncore.json

diff --git a/tools/perf/pmu-events/arch/test/test_cpu/branch.json b/tools/perf/pmu-events/arch/test/test_cpu/branch.json
new file mode 100644
index 0000000..93ddfd8
--- /dev/null
+++ b/tools/perf/pmu-events/arch/test/test_cpu/branch.json
@@ -0,0 +1,12 @@
+[
+  {
+    "EventName": "bp_l1_btb_correct",
+    "EventCode": "0x8a",
+    "BriefDescription": "L1 BTB Correction."
+  },
+  {
+    "EventName": "bp_l2_btb_correct",
+    "EventCode": "0x8b",
+    "BriefDescription": "L2 BTB Correction."
+  }
+]
diff --git a/tools/perf/pmu-events/arch/test/test_cpu/other.json b/tools/perf/pmu-events/arch/test/test_cpu/other.json
new file mode 100644
index 0000000..7d53d7e
--- /dev/null
+++ b/tools/perf/pmu-events/arch/test/test_cpu/other.json
@@ -0,0 +1,26 @@
+[
+    {
+        "EventCode": "0x6",
+        "Counter": "0,1",
+        "UMask": "0x80",
+        "EventName": "SEGMENT_REG_LOADS.ANY",
+        "SampleAfterValue": "200000",
+        "BriefDescription": "Number of segment register loads."
+    },
+    {
+        "EventCode": "0x9",
+        "Counter": "0,1",
+        "UMask": "0x20",
+        "EventName": "DISPATCH_BLOCKED.ANY",
+        "SampleAfterValue": "200000",
+        "BriefDescription": "Memory cluster signals to block micro-op dispatch for any reason"
+    },
+    {
+        "EventCode": "0x3A",
+        "Counter": "0,1",
+        "UMask": "0x0",
+        "EventName": "EIST_TRANS",
+        "SampleAfterValue": "200000",
+        "BriefDescription": "Number of Enhanced Intel SpeedStep(R) Technology (EIST) transitions"
+    }
+]
\ No newline at end of file
diff --git a/tools/perf/pmu-events/arch/test/test_cpu/uncore.json b/tools/perf/pmu-events/arch/test/test_cpu/uncore.json
new file mode 100644
index 0000000..d0a890c
--- /dev/null
+++ b/tools/perf/pmu-events/arch/test/test_cpu/uncore.json
@@ -0,0 +1,21 @@
+[
+ {
+	    "EventCode": "0x02",
+	    "EventName": "uncore_hisi_ddrc.flux_wcmd",
+	    "BriefDescription": "DDRC write commands",
+	    "PublicDescription": "DDRC write commands",
+	    "Unit": "hisi_sccl,ddrc"
+   },
+   {
+	    "Unit": "CBO",
+	    "EventCode": "0x22",
+	    "UMask": "0x81",
+	    "EventName": "UNC_CBO_XSNP_RESPONSE.MISS_EVICTION",
+	    "BriefDescription": "A cross-core snoop resulted from L3 Eviction which misses in some processor core.",
+	    "PublicDescription": "A cross-core snoop resulted from L3 Eviction which misses in some processor core.",
+	    "Counter": "0,1",
+	    "CounterMask": "0",
+	    "Invert": "0",
+	    "EdgeDetect": "0"
+  }
+]
