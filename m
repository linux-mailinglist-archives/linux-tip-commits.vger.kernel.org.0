Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC50DD6F01
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2019 07:35:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727384AbfJOFeh convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 15 Oct 2019 01:34:37 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42105 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728530AbfJOFcH (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 15 Oct 2019 01:32:07 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFRB-0000GZ-4H; Tue, 15 Oct 2019 07:32:01 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 80E5C1C04E3;
        Tue, 15 Oct 2019 07:31:44 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:44 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evlist: Factor out asprintf routine to build a
 tracepoint pid filter
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Luis =?utf-8?q?Cl=C3=A1udio_Gon=C3=A7alves?= 
        <lclaudio@redhat.com>, Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-798vlyqfqw938ehoe8etivx1@git.kernel.org>
References: <tip-798vlyqfqw938ehoe8etivx1@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157111750441.12254.2682920950006262782.tip-bot2@tip-bot2>
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

Commit-ID:     05cea4492c9dd28439cc73de1047ab3b26033736
Gitweb:        https://git.kernel.org/tip/05cea4492c9dd28439cc73de1047ab3b26033736
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 07 Oct 2019 16:43:03 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 09 Oct 2019 11:23:52 -03:00

perf evlist: Factor out asprintf routine to build a tracepoint pid filter

Will be used to append such lists to existing filters.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Luis Cláudio Gonçalves <lclaudio@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-798vlyqfqw938ehoe8etivx1@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index b4c43ac..c1b4608 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1053,6 +1053,9 @@ int perf_evlist__set_tp_filter(struct evlist *evlist, const char *filter)
 	struct evsel *evsel;
 	int err = 0;
 
+	if (filter == NULL)
+		return -1;
+
 	evlist__for_each_entry(evlist, evsel) {
 		if (evsel->core.attr.type != PERF_TYPE_TRACEPOINT)
 			continue;
@@ -1065,16 +1068,15 @@ int perf_evlist__set_tp_filter(struct evlist *evlist, const char *filter)
 	return err;
 }
 
-int perf_evlist__set_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *pids)
+static char *asprintf__tp_filter_pids(size_t npids, pid_t *pids)
 {
 	char *filter;
-	int ret = -1;
 	size_t i;
 
 	for (i = 0; i < npids; ++i) {
 		if (i == 0) {
 			if (asprintf(&filter, "common_pid != %d", pids[i]) < 0)
-				return -1;
+				return NULL;
 		} else {
 			char *tmp;
 
@@ -1086,9 +1088,18 @@ int perf_evlist__set_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *
 		}
 	}
 
-	ret = perf_evlist__set_tp_filter(evlist, filter);
+	return filter;
 out_free:
 	free(filter);
+	return NULL;
+}
+
+int perf_evlist__set_tp_filter_pids(struct evlist *evlist, size_t npids, pid_t *pids)
+{
+	char *filter = asprintf__tp_filter_pids(npids, pids);
+	int ret = perf_evlist__set_tp_filter(evlist, filter);
+
+	free(filter);
 	return ret;
 }
 
