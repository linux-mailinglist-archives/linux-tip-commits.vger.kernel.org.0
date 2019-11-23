Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC588107DA6
	for <lists+linux-tip-commits@lfdr.de>; Sat, 23 Nov 2019 09:16:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727351AbfKWIQU (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 23 Nov 2019 03:16:20 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:36265 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbfKWIPM (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 23 Nov 2019 03:15:12 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iYQZO-0002WV-IP; Sat, 23 Nov 2019 09:15:06 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 21C0C1C1AD0;
        Sat, 23 Nov 2019 09:15:01 +0100 (CET)
Date:   Sat, 23 Nov 2019 08:15:01 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf auxtrace: Add support for dumping AUX area samples
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20191115124225.5247-10-adrian.hunter@intel.com>
References: <20191115124225.5247-10-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <157449690106.21853.15204968306870663694.tip-bot2@tip-bot2>
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

Commit-ID:     b04b8dd1e4265525dbd74647f747e63e85540189
Gitweb:        https://git.kernel.org/tip/b04b8dd1e4265525dbd74647f747e63e85540189
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Fri, 15 Nov 2019 14:42:19 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 22 Nov 2019 10:48:13 -03:00

perf auxtrace: Add support for dumping AUX area samples

Add support for dumping AUX area samples i.e. via the perf script/report
 -D (--dump-raw-trace) option.

Committer notes:

Add __maybe_unused to the two args for auxtrace__dump_auxtrace_sample()
for when we don't HAVE_AUXTRACE_SUPPORT.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20191115124225.5247-10-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/auxtrace.c | 10 ++++++++++
 tools/perf/util/auxtrace.h | 11 +++++++++++
 tools/perf/util/session.c  |  9 +++++++--
 3 files changed, 28 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 026585b..4f5c5fe 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -2417,6 +2417,16 @@ int auxtrace__process_event(struct perf_session *session, union perf_event *even
 	return session->auxtrace->process_event(session, event, sample, tool);
 }
 
+void auxtrace__dump_auxtrace_sample(struct perf_session *session,
+				    struct perf_sample *sample)
+{
+	if (!session->auxtrace || !session->auxtrace->dump_auxtrace_sample ||
+	    auxtrace__dont_decode(session))
+		return;
+
+	session->auxtrace->dump_auxtrace_sample(session, sample);
+}
+
 int auxtrace__flush_events(struct perf_session *session, struct perf_tool *tool)
 {
 	if (!session->auxtrace)
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index ab48de1..4a8ac7d 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -141,6 +141,7 @@ struct auxtrace_index {
  * struct auxtrace - session callbacks to allow AUX area data decoding.
  * @process_event: lets the decoder see all session events
  * @process_auxtrace_event: process a PERF_RECORD_AUXTRACE event
+ * @dump_auxtrace_sample: dump AUX area sample data
  * @flush_events: process any remaining data
  * @free_events: free resources associated with event processing
  * @free: free resources associated with the session
@@ -153,6 +154,8 @@ struct auxtrace {
 	int (*process_auxtrace_event)(struct perf_session *session,
 				      union perf_event *event,
 				      struct perf_tool *tool);
+	void (*dump_auxtrace_sample)(struct perf_session *session,
+				     struct perf_sample *sample);
 	int (*flush_events)(struct perf_session *session,
 			    struct perf_tool *tool);
 	void (*free_events)(struct perf_session *session);
@@ -555,6 +558,8 @@ int auxtrace_parse_filters(struct evlist *evlist);
 
 int auxtrace__process_event(struct perf_session *session, union perf_event *event,
 			    struct perf_sample *sample, struct perf_tool *tool);
+void auxtrace__dump_auxtrace_sample(struct perf_session *session,
+				    struct perf_sample *sample);
 int auxtrace__flush_events(struct perf_session *session, struct perf_tool *tool);
 void auxtrace__free_events(struct perf_session *session);
 void auxtrace__free(struct perf_session *session);
@@ -675,6 +680,12 @@ int auxtrace__process_event(struct perf_session *session __maybe_unused,
 }
 
 static inline
+void auxtrace__dump_auxtrace_sample(struct perf_session *session __maybe_unused,
+				    struct perf_sample *sample __maybe_unused)
+{
+}
+
+static inline
 int auxtrace__flush_events(struct perf_session *session __maybe_unused,
 			   struct perf_tool *tool __maybe_unused)
 {
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index dbdb476..ab4dae1 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1496,8 +1496,13 @@ static int perf_session__deliver_event(struct perf_session *session,
 	if (ret > 0)
 		return 0;
 
-	return machines__deliver_event(&session->machines, session->evlist,
-				       event, &sample, tool, file_offset);
+	ret = machines__deliver_event(&session->machines, session->evlist,
+				      event, &sample, tool, file_offset);
+
+	if (dump_trace && sample.aux_sample.size)
+		auxtrace__dump_auxtrace_sample(session, &sample);
+
+	return ret;
 }
 
 static s64 perf_session__process_user_event(struct perf_session *session,
