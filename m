Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0D5F7A26B2
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Aug 2019 21:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728438AbfH2TCR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Aug 2019 15:02:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51552 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728907AbfH2TCQ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Aug 2019 15:02:16 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i3PgL-0005GA-Jb; Thu, 29 Aug 2019 21:02:05 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 413C11C07C3;
        Thu, 29 Aug 2019 21:02:01 +0200 (CEST)
Date:   Thu, 29 Aug 2019 19:02:01 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Add 'union perf_event' to perf/event.h
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190828135717.7245-22-jolsa@kernel.org>
References: <20190828135717.7245-22-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <156710532113.10604.10416691783935836000.tip-bot2@tip-bot2>
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

Commit-ID:     7510410a38c71eb5d45217a4934e60eef88c04e1
Gitweb:        https://git.kernel.org/tip/7510410a38c71eb5d45217a4934e60eef88c04e1
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Wed, 28 Aug 2019 15:57:15 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 29 Aug 2019 08:36:12 -03:00

libperf: Add 'union perf_event' to perf/event.h

So it's available for libperf's users.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-22-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 36 ++++++++++++++++++++++++++++-
 tools/perf/util/event.h             | 36 +----------------------------
 2 files changed, 36 insertions(+), 36 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index ef7a46e..a5b08ef 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -323,4 +323,40 @@ struct compressed_event {
 	char			 data[];
 };
 
+union perf_event {
+	struct perf_event_header	header;
+	struct perf_record_mmap		mmap;
+	struct perf_record_mmap2	mmap2;
+	struct perf_record_comm		comm;
+	struct perf_record_namespaces	namespaces;
+	struct perf_record_fork		fork;
+	struct perf_record_lost		lost;
+	struct perf_record_lost_samples	lost_samples;
+	struct perf_record_read		read;
+	struct perf_record_throttle	throttle;
+	struct perf_record_sample	sample;
+	struct perf_record_bpf_event	bpf;
+	struct perf_record_ksymbol	ksymbol;
+	struct attr_event		attr;
+	struct event_update_event	event_update;
+	struct event_type_event		event_type;
+	struct tracing_data_event	tracing_data;
+	struct build_id_event		build_id;
+	struct id_index_event		id_index;
+	struct auxtrace_info_event	auxtrace_info;
+	struct auxtrace_event		auxtrace;
+	struct auxtrace_error_event	auxtrace_error;
+	struct aux_event		aux;
+	struct itrace_start_event	itrace_start;
+	struct context_switch_event	context_switch;
+	struct thread_map_event		thread_map;
+	struct cpu_map_event		cpu_map;
+	struct stat_config_event	stat_config;
+	struct stat_event		stat;
+	struct stat_round_event		stat_round;
+	struct time_conv_event		time_conv;
+	struct feature_event		feat;
+	struct compressed_event		pack;
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index ee2ee23..e15eed5 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -337,42 +337,6 @@ enum {
 	PERF_STAT_ROUND_TYPE__FINAL	= 1,
 };
 
-union perf_event {
-	struct perf_event_header	header;
-	struct perf_record_mmap		mmap;
-	struct perf_record_mmap2	mmap2;
-	struct perf_record_comm		comm;
-	struct perf_record_namespaces	namespaces;
-	struct perf_record_fork		fork;
-	struct perf_record_lost		lost;
-	struct perf_record_lost_samples	lost_samples;
-	struct perf_record_read		read;
-	struct perf_record_throttle	throttle;
-	struct perf_record_sample	sample;
-	struct perf_record_bpf_event	bpf;
-	struct perf_record_ksymbol	ksymbol;
-	struct attr_event		attr;
-	struct event_update_event	event_update;
-	struct event_type_event		event_type;
-	struct tracing_data_event	tracing_data;
-	struct build_id_event		build_id;
-	struct id_index_event		id_index;
-	struct auxtrace_info_event	auxtrace_info;
-	struct auxtrace_event		auxtrace;
-	struct auxtrace_error_event	auxtrace_error;
-	struct aux_event		aux;
-	struct itrace_start_event	itrace_start;
-	struct context_switch_event	context_switch;
-	struct thread_map_event		thread_map;
-	struct cpu_map_event		cpu_map;
-	struct stat_config_event	stat_config;
-	struct stat_event		stat;
-	struct stat_round_event		stat_round;
-	struct time_conv_event		time_conv;
-	struct feature_event		feat;
-	struct compressed_event		pack;
-};
-
 void perf_event__print_totals(void);
 
 struct perf_tool;
