Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0486EA26EE
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Aug 2019 21:04:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbfH2TER (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Aug 2019 15:04:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51408 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728643AbfH2TCC (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Aug 2019 15:02:02 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i3Pg9-000578-C3; Thu, 29 Aug 2019 21:01:53 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id D7DE71C07C3;
        Thu, 29 Aug 2019 21:01:52 +0200 (CEST)
Date:   Thu, 29 Aug 2019 19:01:52 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Add PERF_RECORD_HEADER_EVENT_TYPE 'struct
 event_type_event' to perf/event.h
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190828135717.7245-5-jolsa@kernel.org>
References: <20190828135717.7245-5-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <156710531279.10551.4551872307837566933.tip-bot2@tip-bot2>
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

Commit-ID:     0f5b1a28c03d416f7a66d47a9b2f18942e334fc6
Gitweb:        https://git.kernel.org/tip/0f5b1a28c03d416f7a66d47a9b2f18942e334fc6
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Wed, 28 Aug 2019 15:56:58 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 28 Aug 2019 18:15:04 -03:00

libperf: Add PERF_RECORD_HEADER_EVENT_TYPE 'struct event_type_event' to perf/event.h

Move the PERF_RECORD_HEADER_EVENT_TYPE event definition to libperf's event.h.

In order to keep libperf simple, we switch 'u64/u32/u16/u8'
types used events to their generic '__u*' versions.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190828135717.7245-5-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/lib/include/perf/event.h | 12 ++++++++++++
 tools/perf/util/event.h             | 12 ------------
 2 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/tools/perf/lib/include/perf/event.h b/tools/perf/lib/include/perf/event.h
index 3d99818..ecd1536 100644
--- a/tools/perf/lib/include/perf/event.h
+++ b/tools/perf/lib/include/perf/event.h
@@ -163,4 +163,16 @@ struct event_update_event {
 	char			 data[];
 };
 
+#define MAX_EVENT_NAME 64
+
+struct perf_trace_event_type {
+	__u64			 event_id;
+	char			 name[MAX_EVENT_NAME];
+};
+
+struct event_type_event {
+	struct perf_event_header	 header;
+	struct perf_trace_event_type	 event_type;
+};
+
 #endif /* __LIBPERF_EVENT_H */
diff --git a/tools/perf/util/event.h b/tools/perf/util/event.h
index a579e6b..00725a1 100644
--- a/tools/perf/util/event.h
+++ b/tools/perf/util/event.h
@@ -337,18 +337,6 @@ struct events_stats {
 	u32 nr_proc_map_timeout;
 };
 
-#define MAX_EVENT_NAME 64
-
-struct perf_trace_event_type {
-	u64	event_id;
-	char	name[MAX_EVENT_NAME];
-};
-
-struct event_type_event {
-	struct perf_event_header header;
-	struct perf_trace_event_type event_type;
-};
-
 struct tracing_data_event {
 	struct perf_event_header header;
 	u32 size;
