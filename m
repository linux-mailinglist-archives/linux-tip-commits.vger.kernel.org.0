Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 731ABD6EB1
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2019 07:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728483AbfJOFcL convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 15 Oct 2019 01:32:11 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42131 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728551AbfJOFcK (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:10 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFRA-0000G0-1q; Tue, 15 Oct 2019 07:32:00 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id DC3831C04CF;
        Tue, 15 Oct 2019 07:31:43 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:43 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evlist: Introduce append_tp_filter_pid() and
 append_tp_filter_pids()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-daynpknni44ywuzi8iua57nn@git.kernel.org>
References: <tip-daynpknni44ywuzi8iua57nn@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157111750377.12254.9662918016580898240.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     1827ab5ba8e1d0354cc36b3692444306ced01471
Gitweb:        https://git.kernel.org/tip/1827ab5ba8e1d0354cc36b3692444306ced01471
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 07 Oct 2019 17:00:34 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 09 Oct 2019 11:23:52 -03:00

perf evlist: Introduce append_tp_filter_pid() and append_tp_filter_pids()

We'll need this to support 'perf trace e tracepoint --filter=expr', as
the command line tracepoint filter is attache to the preceding evsel,
just like in 'perf record' and when we go to set pid filters, which we
do at the minimum to filter 'perf trace' own syscalls, we need to
append, not set the tp filter.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-daynpknni44ywuzi8iua57nn@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 14 ++++++++++++++
 tools/perf/util/evlist.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 1650d24..e33b46a 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1128,6 +1128,20 @@ int perf_evlist__set_tp_filter_pid(struct evlist *evlist, pid_t pid)
 	return perf_evlist__set_tp_filter_pids(evlist, 1, &pid);
 }
 
+int perf_evlist__append_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *pids)
+{
+	char *filter = asprintf__tp_filter_pids(npids, pids);
+	int ret = perf_evlist__append_tp_filter(evlist, filter);
+
+	free(filter);
+	return ret;
+}
+
+int perf_evlist__append_tp_filter_pid(struct evlist *evlist, pid_t pid)
+{
+	return perf_evlist__append_tp_filter_pids(evlist, 1, &pid);
+}
+
 bool perf_evlist__valid_sample_type(struct evlist *evlist)
 {
 	struct evsel *pos;
diff --git a/tools/perf/util/evlist.h b/tools/perf/util/evlist.h
index c58fd19..1305140 100644
--- a/tools/perf/util/evlist.h
+++ b/tools/perf/util/evlist.h
@@ -142,6 +142,9 @@ int perf_evlist__set_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *
 
 int perf_evlist__append_tp_filter(struct evlist *evlist, const char *filter);
 
+int perf_evlist__append_tp_filter_pid(struct evlist *evlist, pid_t pid);
+int perf_evlist__append_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *pids);
+
 struct evsel *
 perf_evlist__find_tracepoint_by_id(struct evlist *evlist, int id);
 
