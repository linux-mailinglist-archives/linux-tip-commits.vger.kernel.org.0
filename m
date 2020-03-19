Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C14D518B8FD
	for <lists+linux-tip-commits@lfdr.de>; Thu, 19 Mar 2020 15:13:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727875AbgCSOMd (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 19 Mar 2020 10:12:33 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:60973 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727828AbgCSOLC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 19 Mar 2020 10:11:02 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jEvsr-00027B-2i; Thu, 19 Mar 2020 15:10:53 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4DA1A1C22A6;
        Thu, 19 Mar 2020 15:10:47 +0100 (CET)
Date:   Thu, 19 Mar 2020 14:10:46 -0000
From:   "tip-bot2 for Kan Liang" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf util: Factor out sysctl__nmi_watchdog_enabled()
Cc:     Andi Kleen <ak@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1582581564-184429-4-git-send-email-kan.liang@linux.intel.com>
References: <1582581564-184429-4-git-send-email-kan.liang@linux.intel.com>
MIME-Version: 1.0
Message-ID: <158462704694.28353.6873127426138751069.tip-bot2@tip-bot2>
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

Commit-ID:     2a14c1bf017f48a17c8c0ba26a22625363e77cc7
Gitweb:        https://git.kernel.org/tip/2a14c1bf017f48a17c8c0ba26a22625363e77cc7
Author:        Kan Liang <kan.liang@linux.intel.com>
AuthorDate:    Mon, 24 Feb 2020 13:59:22 -08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 10 Mar 2020 14:46:19 -03:00

perf util: Factor out sysctl__nmi_watchdog_enabled()

The NMI watchdog status is required for metric group constraint
examination.  Factor out sysctl__nmi_watchdog_enabled() to retrieve the
NMI watchdog status.

Users may count more than one metric group each time. If so, the NMI
watchdog status may be retrieved several times. To reduce the overhead,
cache the NMI watchdog status.

Replace the NMI watchdog status checking in print_footer() by
sysctl__nmi_watchdog_enabled().

Suggested-by: Andi Kleen <ak@linux.intel.com>
Signed-off-by: Kan Liang <kan.liang@linux.intel.com>
Acked-by: Jiri Olsa <jolsa@redhat.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Link: http://lore.kernel.org/lkml/1582581564-184429-4-git-send-email-kan.liang@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/stat-display.c |  6 ++----
 tools/perf/util/util.c         | 18 ++++++++++++++++++
 tools/perf/util/util.h         |  2 ++
 3 files changed, 22 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index d89cb0d..76c6052 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -16,6 +16,7 @@
 #include <linux/ctype.h>
 #include "cgroup.h"
 #include <api/fs/fs.h>
+#include "util.h"
 
 #define CNTR_NOT_SUPPORTED	"<not supported>"
 #define CNTR_NOT_COUNTED	"<not counted>"
@@ -1097,7 +1098,6 @@ static void print_footer(struct perf_stat_config *config)
 {
 	double avg = avg_stats(config->walltime_nsecs_stats) / NSEC_PER_SEC;
 	FILE *output = config->output;
-	int n;
 
 	if (!config->null_run)
 		fprintf(output, "\n");
@@ -1131,9 +1131,7 @@ static void print_footer(struct perf_stat_config *config)
 	}
 	fprintf(output, "\n\n");
 
-	if (config->print_free_counters_hint &&
-	    sysctl__read_int("kernel/nmi_watchdog", &n) >= 0 &&
-	    n > 0)
+	if (config->print_free_counters_hint && sysctl__nmi_watchdog_enabled())
 		fprintf(output,
 "Some events weren't counted. Try disabling the NMI watchdog:\n"
 "	echo 0 > /proc/sys/kernel/nmi_watchdog\n"
diff --git a/tools/perf/util/util.c b/tools/perf/util/util.c
index 969ae56..d707c96 100644
--- a/tools/perf/util/util.c
+++ b/tools/perf/util/util.c
@@ -55,6 +55,24 @@ int sysctl__max_stack(void)
 	return sysctl_perf_event_max_stack;
 }
 
+bool sysctl__nmi_watchdog_enabled(void)
+{
+	static bool cached;
+	static bool nmi_watchdog;
+	int value;
+
+	if (cached)
+		return nmi_watchdog;
+
+	if (sysctl__read_int("kernel/nmi_watchdog", &value) < 0)
+		return false;
+
+	nmi_watchdog = (value > 0) ? true : false;
+	cached = true;
+
+	return nmi_watchdog;
+}
+
 bool test_attr__enabled;
 
 bool perf_host  = true;
diff --git a/tools/perf/util/util.h b/tools/perf/util/util.h
index 9969b8b..f486fdd 100644
--- a/tools/perf/util/util.h
+++ b/tools/perf/util/util.h
@@ -29,6 +29,8 @@ size_t hex_width(u64 v);
 
 int sysctl__max_stack(void);
 
+bool sysctl__nmi_watchdog_enabled(void);
+
 int fetch_kernel_version(unsigned int *puint,
 			 char *str, size_t str_sz);
 #define KVER_VERSION(x)		(((x) >> 16) & 0xff)
