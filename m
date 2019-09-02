Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EFD3DA5138
	for <lists+linux-tip-commits@lfdr.de>; Mon,  2 Sep 2019 10:18:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729378AbfIBIRu (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 2 Sep 2019 04:17:50 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:56366 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730345AbfIBIQ6 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 2 Sep 2019 04:16:58 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i4hW7-0008D4-NF; Mon, 02 Sep 2019 10:16:51 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id EE4AC1C0DE7;
        Mon,  2 Sep 2019 10:16:40 +0200 (CEST)
Date:   Mon, 02 Sep 2019 08:16:40 -0000
From:   "tip-bot2 for Jin Yao" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf pmu: Change convert_scale from static to global
Cc:     Jin Yao <yao.jin@linux.intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Kan Liang <kan.liang@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190828055932.8269-2-yao.jin@linux.intel.com>
References: <20190828055932.8269-2-yao.jin@linux.intel.com>
MIME-Version: 1.0
Message-ID: <156741220086.17378.14383384648862196300.tip-bot2@tip-bot2>
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

Commit-ID:     a55ab7c4ca6986a542d313b02043a39ebf712a39
Gitweb:        https://git.kernel.org/tip/a55ab7c4ca6986a542d313b02043a39ebf712a39
Author:        Jin Yao <yao.jin@linux.intel.com>
AuthorDate:    Wed, 28 Aug 2019 13:59:29 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 31 Aug 2019 22:27:51 -03:00

perf pmu: Change convert_scale from static to global

The function convert_scale() can be used to convert string to unit and
scale. For example,

  s = "6000000000ns";
  convert_scale(s, &unit, &scale);

unit = "ns", scale = 6000000000.

Currently this function is static. This patch renames the function to
perf_pmu__convert_scale and changes the function to global.  No
functional change.

Signed-off-by: Jin Yao <yao.jin@linux.intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20190828055932.8269-2-yao.jin@linux.intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/pmu.c | 6 +++---
 tools/perf/util/pmu.h | 2 ++
 2 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/pmu.c b/tools/perf/util/pmu.c
index 6b3448f..fb597fa 100644
--- a/tools/perf/util/pmu.c
+++ b/tools/perf/util/pmu.c
@@ -102,7 +102,7 @@ static int pmu_format(const char *name, struct list_head *format)
 	return 0;
 }
 
-static int convert_scale(const char *scale, char **end, double *sval)
+int perf_pmu__convert_scale(const char *scale, char **end, double *sval)
 {
 	char *lc;
 	int ret = 0;
@@ -165,7 +165,7 @@ static int perf_pmu__parse_scale(struct perf_pmu_alias *alias, char *dir, char *
 	else
 		scale[sret] = '\0';
 
-	ret = convert_scale(scale, NULL, &alias->scale);
+	ret = perf_pmu__convert_scale(scale, NULL, &alias->scale);
 error:
 	close(fd);
 	return ret;
@@ -373,7 +373,7 @@ static int __perf_pmu__new_alias(struct list_head *list, char *dir, char *name,
 				desc ? strdup(desc) : NULL;
 	alias->topic = topic ? strdup(topic) : NULL;
 	if (unit) {
-		if (convert_scale(unit, &unit, &alias->scale) < 0)
+		if (perf_pmu__convert_scale(unit, &unit, &alias->scale) < 0)
 			return -1;
 		snprintf(alias->unit, sizeof(alias->unit), "%s", unit);
 	}
diff --git a/tools/perf/util/pmu.h b/tools/perf/util/pmu.h
index 3f8b79b..f36ade6 100644
--- a/tools/perf/util/pmu.h
+++ b/tools/perf/util/pmu.h
@@ -96,4 +96,6 @@ struct perf_event_attr *perf_pmu__get_default_config(struct perf_pmu *pmu);
 
 struct pmu_events_map *perf_pmu__find_map(struct perf_pmu *pmu);
 
+int perf_pmu__convert_scale(const char *scale, char **end, double *sval);
+
 #endif /* __PMU_H */
