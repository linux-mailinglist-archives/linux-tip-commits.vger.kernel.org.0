Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20215102A1B
	for <lists+linux-tip-commits@lfdr.de>; Tue, 19 Nov 2019 17:58:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728459AbfKSQ6Q (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 19 Nov 2019 11:58:16 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:52925 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728725AbfKSQ5R (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 19 Nov 2019 11:57:17 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iX6o9-0007Jh-5M; Tue, 19 Nov 2019 17:56:53 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id C6F121C19CA;
        Tue, 19 Nov 2019 17:56:47 +0100 (CET)
Date:   Tue, 19 Nov 2019 16:56:47 -0000
From:   "tip-bot2 for Ian Rogers" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf parse: Report initial event parsing error
Cc:     Ian Rogers <irogers@google.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Allison Randal <allison@lohutok.net>,
        Andi Kleen <ak@linux.intel.com>,
        Anju T Sudhakar <anju@linux.vnet.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Jin Yao <yao.jin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ravi Bangoria <ravi.bangoria@linux.ibm.com>,
        Stephane Eranian <eranian@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Richter <tmricht@linux.ibm.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191116074652.9960-1-irogers@google.com>
References: <20191116074652.9960-1-irogers@google.com>
MIME-Version: 1.0
Message-ID: <157418260775.12247.1920842780601664691.tip-bot2@tip-bot2>
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

Commit-ID:     a910e4666d61712840c78de33cc7f89de8affa78
Gitweb:        https://git.kernel.org/tip/a910e4666d61712840c78de33cc7f89de8affa78
Author:        Ian Rogers <irogers@google.com>
AuthorDate:    Fri, 15 Nov 2019 23:46:52 -08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 18 Nov 2019 19:14:29 -03:00

perf parse: Report initial event parsing error

Record the first event parsing error and report. Implementing feedback
from Jiri Olsa:

  https://lkml.org/lkml/2019/10/28/680

An example error is:

  $ tools/perf/perf stat -e c/c/
  WARNING: multiple event parsing errors
  event syntax error: 'c/c/'
                         \___ unknown term

  valid terms: event,filter_rem,filter_opc0,edge,filter_isoc,filter_tid,filter_loc,filter_nc,inv,umask,filter_opc1,tid_en,thresh,filter_all_op,filter_not_nm,filter_state,filter_nm,config,config1,config2,name,period,percore

Initial error:

  event syntax error: 'c/c/'
                      \___ Cannot find PMU `c'. Missing kernel support?
  Run 'perf list' for a list of valid events

   Usage: perf stat [<options>] [<command>]

      -e, --event <event>   event selector. use 'perf list' to list available events

Signed-off-by: Ian Rogers <irogers@google.com>
Tested-by: Arnaldo Carvalho de Melo <acme@redhat.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Allison Randal <allison@lohutok.net>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Anju T Sudhakar <anju@linux.vnet.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Davidlohr Bueso <dave@stgolabs.net>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.ibm.com>
Cc: Stephane Eranian <eranian@google.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Thomas Richter <tmricht@linux.ibm.com>
Link: http://lore.kernel.org/lkml/20191116074652.9960-1-irogers@google.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/powerpc/util/kvm-stat.c |  4 +-
 tools/perf/builtin-stat.c               |  2 +-
 tools/perf/builtin-trace.c              | 16 +++--
 tools/perf/tests/parse-events.c         |  3 +-
 tools/perf/util/metricgroup.c           |  2 +-
 tools/perf/util/parse-events.c          | 78 +++++++++++++++++-------
 tools/perf/util/parse-events.h          |  4 +-
 7 files changed, 80 insertions(+), 29 deletions(-)

diff --git a/tools/perf/arch/powerpc/util/kvm-stat.c b/tools/perf/arch/powerpc/util/kvm-stat.c
index 9cc1c4a..1680726 100644
--- a/tools/perf/arch/powerpc/util/kvm-stat.c
+++ b/tools/perf/arch/powerpc/util/kvm-stat.c
@@ -113,10 +113,10 @@ static int is_tracepoint_available(const char *str, struct evlist *evlist)
 	struct parse_events_error err;
 	int ret;
 
-	err.str = NULL;
+	bzero(&err, sizeof(err));
 	ret = parse_events(evlist, str, &err);
 	if (err.str)
-		pr_err("%s : %s\n", str, err.str);
+		parse_events_print_error(&err, "tracepoint");
 	return ret;
 }
 
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 5964e80..0a15253 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -1307,6 +1307,7 @@ static int add_default_attributes(void)
 	if (stat_config.null_run)
 		return 0;
 
+	bzero(&errinfo, sizeof(errinfo));
 	if (transaction_run) {
 		/* Handle -T as -M transaction. Once platform specific metrics
 		 * support has been added to the json files, all archictures
@@ -1364,6 +1365,7 @@ static int add_default_attributes(void)
 			return -1;
 		}
 		if (err) {
+			parse_events_print_error(&errinfo, smi_cost_attrs);
 			fprintf(stderr, "Cannot set up SMI cost events\n");
 			return -1;
 		}
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 43c05ea..46a72ec 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -3016,11 +3016,18 @@ static bool evlist__add_vfs_getname(struct evlist *evlist)
 {
 	bool found = false;
 	struct evsel *evsel, *tmp;
-	struct parse_events_error err = { .idx = 0, };
-	int ret = parse_events(evlist, "probe:vfs_getname*", &err);
+	struct parse_events_error err;
+	int ret;
 
-	if (ret)
+	bzero(&err, sizeof(err));
+	ret = parse_events(evlist, "probe:vfs_getname*", &err);
+	if (ret) {
+		free(err.str);
+		free(err.help);
+		free(err.first_str);
+		free(err.first_help);
 		return false;
+	}
 
 	evlist__for_each_entry_safe(evlist, evsel, tmp) {
 		if (!strstarts(perf_evsel__name(evsel), "probe:vfs_getname"))
@@ -4832,8 +4839,9 @@ int cmd_trace(int argc, const char **argv)
 	 * wrong in more detail.
 	 */
 	if (trace.perfconfig_events != NULL) {
-		struct parse_events_error parse_err = { .idx = 0, };
+		struct parse_events_error parse_err;
 
+		bzero(&parse_err, sizeof(parse_err));
 		err = parse_events(trace.evlist, trace.perfconfig_events, &parse_err);
 		if (err) {
 			parse_events_print_error(&parse_err, trace.perfconfig_events);
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 25e0ed2..091c3ae 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -1768,10 +1768,11 @@ static struct terms_test test__terms[] = {
 
 static int test_event(struct evlist_test *e)
 {
-	struct parse_events_error err = { .idx = 0, };
+	struct parse_events_error err;
 	struct evlist *evlist;
 	int ret;
 
+	bzero(&err, sizeof(err));
 	if (e->valid && !e->valid()) {
 		pr_debug("... SKIP");
 		return 0;
diff --git a/tools/perf/util/metricgroup.c b/tools/perf/util/metricgroup.c
index a7c0424..6a4d350 100644
--- a/tools/perf/util/metricgroup.c
+++ b/tools/perf/util/metricgroup.c
@@ -523,7 +523,7 @@ int metricgroup__parse_groups(const struct option *opt,
 	if (ret)
 		return ret;
 	pr_debug("adding %s\n", extra_events.buf);
-	memset(&parse_error, 0, sizeof(struct parse_events_error));
+	bzero(&parse_error, sizeof(parse_error));
 	ret = parse_events(perf_evlist, extra_events.buf, &parse_error);
 	if (ret) {
 		parse_events_print_error(&parse_error, extra_events.buf);
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 6d18ff9..6bae9d6 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -189,12 +189,29 @@ void parse_events__handle_error(struct parse_events_error *err, int idx,
 		free(help);
 		return;
 	}
-	WARN_ONCE(err->str, "WARNING: multiple event parsing errors\n");
-	err->idx = idx;
-	free(err->str);
-	err->str = str;
-	free(err->help);
-	err->help = help;
+	switch (err->num_errors) {
+	case 0:
+		err->idx = idx;
+		err->str = str;
+		err->help = help;
+		break;
+	case 1:
+		err->first_idx = err->idx;
+		err->idx = idx;
+		err->first_str = err->str;
+		err->str = str;
+		err->first_help = err->help;
+		err->help = help;
+		break;
+	default:
+		WARN_ONCE(1, "WARNING: multiple event parsing errors\n");
+		free(err->str);
+		err->str = str;
+		free(err->help);
+		err->help = help;
+		break;
+	}
+	err->num_errors++;
 }
 
 struct tracepoint_path *tracepoint_id_to_path(u64 config)
@@ -1349,7 +1366,7 @@ int parse_events_add_pmu(struct parse_events_state *parse_state,
 		if (asprintf(&err_str,
 				"Cannot find PMU `%s'. Missing kernel support?",
 				name) >= 0)
-			parse_events__handle_error(err, -1, err_str, NULL);
+			parse_events__handle_error(err, 0, err_str, NULL);
 		return -EINVAL;
 	}
 
@@ -2007,15 +2024,14 @@ static int get_term_width(void)
 	return ws.ws_col > MAX_WIDTH ? MAX_WIDTH : ws.ws_col;
 }
 
-void parse_events_print_error(struct parse_events_error *err,
-			      const char *event)
+static void __parse_events_print_error(int err_idx, const char *err_str,
+				const char *err_help, const char *event)
 {
 	const char *str = "invalid or unsupported event: ";
 	char _buf[MAX_WIDTH];
 	char *buf = (char *) event;
 	int idx = 0;
-
-	if (err->str) {
+	if (err_str) {
 		/* -2 for extra '' in the final fprintf */
 		int width       = get_term_width() - 2;
 		int len_event   = strlen(event);
@@ -2038,8 +2054,8 @@ void parse_events_print_error(struct parse_events_error *err,
 		buf = _buf;
 
 		/* We're cutting from the beginning. */
-		if (err->idx > max_err_idx)
-			cut = err->idx - max_err_idx;
+		if (err_idx > max_err_idx)
+			cut = err_idx - max_err_idx;
 
 		strncpy(buf, event + cut, max_len);
 
@@ -2052,16 +2068,33 @@ void parse_events_print_error(struct parse_events_error *err,
 			buf[max_len] = 0;
 		}
 
-		idx = len_str + err->idx - cut;
+		idx = len_str + err_idx - cut;
 	}
 
 	fprintf(stderr, "%s'%s'\n", str, buf);
 	if (idx) {
-		fprintf(stderr, "%*s\\___ %s\n", idx + 1, "", err->str);
-		if (err->help)
-			fprintf(stderr, "\n%s\n", err->help);
-		zfree(&err->str);
-		zfree(&err->help);
+		fprintf(stderr, "%*s\\___ %s\n", idx + 1, "", err_str);
+		if (err_help)
+			fprintf(stderr, "\n%s\n", err_help);
+	}
+}
+
+void parse_events_print_error(struct parse_events_error *err,
+			      const char *event)
+{
+	if (!err->num_errors)
+		return;
+
+	__parse_events_print_error(err->idx, err->str, err->help, event);
+	zfree(&err->str);
+	zfree(&err->help);
+
+	if (err->num_errors > 1) {
+		fputs("\nInitial error:\n", stderr);
+		__parse_events_print_error(err->first_idx, err->first_str,
+					err->first_help, event);
+		zfree(&err->first_str);
+		zfree(&err->first_help);
 	}
 }
 
@@ -2071,8 +2104,11 @@ int parse_events_option(const struct option *opt, const char *str,
 			int unset __maybe_unused)
 {
 	struct evlist *evlist = *(struct evlist **)opt->value;
-	struct parse_events_error err = { .idx = 0, };
-	int ret = parse_events(evlist, str, &err);
+	struct parse_events_error err;
+	int ret;
+
+	bzero(&err, sizeof(err));
+	ret = parse_events(evlist, str, &err);
 
 	if (ret) {
 		parse_events_print_error(&err, str);
diff --git a/tools/perf/util/parse-events.h b/tools/perf/util/parse-events.h
index 5ee8ac9..ff367f2 100644
--- a/tools/perf/util/parse-events.h
+++ b/tools/perf/util/parse-events.h
@@ -110,9 +110,13 @@ struct parse_events_term {
 };
 
 struct parse_events_error {
+	int   num_errors;       /* number of errors encountered */
 	int   idx;	/* index in the parsed string */
 	char *str;      /* string to display at the index */
 	char *help;	/* optional help string */
+	int   first_idx;/* as above, but for the first encountered error */
+	char *first_str;
+	char *first_help;
 };
 
 struct parse_events_state {
