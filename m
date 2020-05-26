Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12BC11CAE7E
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 May 2020 15:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgEHNKY (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 8 May 2020 09:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730438AbgEHNFJ (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 8 May 2020 09:05:09 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 017C9C05BD0B;
        Fri,  8 May 2020 06:05:09 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2ga-0007OD-CL; Fri, 08 May 2020 15:05:04 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id AFECD1C04D3;
        Fri,  8 May 2020 15:04:52 +0200 (CEST)
Date:   Fri, 08 May 2020 13:04:52 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evsel: Rename *perf_evsel__*name() to *evsel__*name()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894309261.8414.17195395651204787289.tip-bot2@tip-bot2>
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

Commit-ID:     8ab2e96d8ff188006f1e3346a56443cd07fe1858
Gitweb:        https://git.kernel.org/tip/8ab2e96d8ff188006f1e3346a56443cd07fe1858
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Wed, 29 Apr 2020 16:07:09 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:30 -03:00

perf evsel: Rename *perf_evsel__*name() to *evsel__*name()

As they are 'struct evsel' methods or related routines, not part of
tools/lib/perf/, aka libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/arch/arm/util/cs-etm.c                      |  2 +-
 tools/perf/builtin-c2c.c                               |  3 +-
 tools/perf/builtin-diff.c                              |  2 +-
 tools/perf/builtin-inject.c                            |  7 +-
 tools/perf/builtin-kmem.c                              |  2 +-
 tools/perf/builtin-record.c                            |  2 +-
 tools/perf/builtin-report.c                            |  4 +-
 tools/perf/builtin-sched.c                             |  4 +-
 tools/perf/builtin-script.c                            | 14 +-
 tools/perf/builtin-stat.c                              |  8 +-
 tools/perf/builtin-top.c                               |  8 +-
 tools/perf/builtin-trace.c                             | 22 +--
 tools/perf/tests/event_update.c                        |  2 +-
 tools/perf/tests/evsel-roundtrip-name.c                | 14 +--
 tools/perf/tests/mmap-basic.c                          |  2 +-
 tools/perf/tests/parse-events.c                        | 14 +-
 tools/perf/ui/browsers/hists.c                         |  8 +-
 tools/perf/ui/gtk/hists.c                              |  2 +-
 tools/perf/util/annotate.c                             |  4 +-
 tools/perf/util/data-convert-bt.c                      |  2 +-
 tools/perf/util/evsel.c                                | 70 ++++-----
 tools/perf/util/evsel.h                                |  7 +-
 tools/perf/util/evsel_fprintf.c                        |  6 +-
 tools/perf/util/header.c                               |  7 +-
 tools/perf/util/hist.c                                 |  4 +-
 tools/perf/util/intel-pt.c                             |  2 +-
 tools/perf/util/parse-events.c                         |  3 +-
 tools/perf/util/scripting-engines/trace-event-python.c |  6 +-
 tools/perf/util/session.c                              |  3 +-
 tools/perf/util/stat-display.c                         |  9 +-
 tools/perf/util/stat.c                                 |  4 +-
 tools/perf/util/top.c                                  |  2 +-
 32 files changed, 117 insertions(+), 132 deletions(-)

diff --git a/tools/perf/arch/arm/util/cs-etm.c b/tools/perf/arch/arm/util/cs-etm.c
index b8df805..53db3c2 100644
--- a/tools/perf/arch/arm/util/cs-etm.c
+++ b/tools/perf/arch/arm/util/cs-etm.c
@@ -233,7 +233,7 @@ static int cs_etm_set_sink_attr(struct perf_pmu *pmu,
 		ret = perf_pmu__scan_file(pmu, path, "%x", &hash);
 		if (ret != 1) {
 			pr_err("failed to set sink \"%s\" on event %s with %d (%s)\n",
-			       sink, perf_evsel__name(evsel), errno,
+			       sink, evsel__name(evsel), errno,
 			       str_error_r(errno, msg, sizeof(msg)));
 			return ret;
 		}
diff --git a/tools/perf/builtin-c2c.c b/tools/perf/builtin-c2c.c
index 0e14c18..1baf4ca 100644
--- a/tools/perf/builtin-c2c.c
+++ b/tools/perf/builtin-c2c.c
@@ -2259,8 +2259,7 @@ static void print_c2c_info(FILE *out, struct perf_session *session)
 	fprintf(out, "=================================================\n");
 
 	evlist__for_each_entry(evlist, evsel) {
-		fprintf(out, "%-36s: %s\n", first ? "  Events" : "",
-			perf_evsel__name(evsel));
+		fprintf(out, "%-36s: %s\n", first ? "  Events" : "", evsel__name(evsel));
 		first = false;
 	}
 	fprintf(out, "  Cachelines sort on                : %s HITMs\n",
diff --git a/tools/perf/builtin-diff.c b/tools/perf/builtin-diff.c
index 59d40f0..b74a60f 100644
--- a/tools/perf/builtin-diff.c
+++ b/tools/perf/builtin-diff.c
@@ -981,7 +981,7 @@ static void data_process(void)
 
 		if (!quiet) {
 			fprintf(stdout, "%s# Event '%s'\n#\n", first ? "" : "\n",
-				perf_evsel__name(evsel_base));
+				evsel__name(evsel_base));
 		}
 
 		first = false;
diff --git a/tools/perf/builtin-inject.c b/tools/perf/builtin-inject.c
index 7c4403c..952df51 100644
--- a/tools/perf/builtin-inject.c
+++ b/tools/perf/builtin-inject.c
@@ -565,7 +565,7 @@ static int perf_evsel__check_stype(struct evsel *evsel,
 				   u64 sample_type, const char *sample_msg)
 {
 	struct perf_event_attr *attr = &evsel->core.attr;
-	const char *name = perf_evsel__name(evsel);
+	const char *name = evsel__name(evsel);
 
 	if (!(attr->sample_type & sample_type)) {
 		pr_err("Samples for %s event do not have %s attribute set.",
@@ -622,7 +622,7 @@ static int __cmd_inject(struct perf_inject *inject)
 		struct evsel *evsel;
 
 		evlist__for_each_entry(session->evlist, evsel) {
-			const char *name = perf_evsel__name(evsel);
+			const char *name = evsel__name(evsel);
 
 			if (!strcmp(name, "sched:sched_switch")) {
 				if (perf_evsel__check_stype(evsel, PERF_SAMPLE_TID, "TID"))
@@ -691,8 +691,7 @@ static int __cmd_inject(struct perf_inject *inject)
 			evsel = perf_evlist__id2evsel_strict(session->evlist,
 							     inject->aux_id);
 			if (evsel) {
-				pr_debug("Deleting %s\n",
-					 perf_evsel__name(evsel));
+				pr_debug("Deleting %s\n", evsel__name(evsel));
 				evlist__remove(session->evlist, evsel);
 				evsel__delete(evsel);
 			}
diff --git a/tools/perf/builtin-kmem.c b/tools/perf/builtin-kmem.c
index 003c85f..f91a050 100644
--- a/tools/perf/builtin-kmem.c
+++ b/tools/perf/builtin-kmem.c
@@ -1391,7 +1391,7 @@ static int __cmd_kmem(struct perf_session *session)
 	}
 
 	evlist__for_each_entry(session->evlist, evsel) {
-		if (!strcmp(perf_evsel__name(evsel), "kmem:mm_page_alloc") &&
+		if (!strcmp(evsel__name(evsel), "kmem:mm_page_alloc") &&
 		    perf_evsel__field(evsel, "pfn")) {
 			use_pfn = true;
 			break;
diff --git a/tools/perf/builtin-record.c b/tools/perf/builtin-record.c
index cfb9a69..ab303c4 100644
--- a/tools/perf/builtin-record.c
+++ b/tools/perf/builtin-record.c
@@ -879,7 +879,7 @@ try_again:
 
 	if (perf_evlist__apply_filters(evlist, &pos)) {
 		pr_err("failed to set filter \"%s\" on event %s with %d (%s)\n",
-			pos->filter, perf_evsel__name(pos), errno,
+			pos->filter, evsel__name(pos), errno,
 			str_error_r(errno, msg, sizeof(msg)));
 		rc = -1;
 		goto out;
diff --git a/tools/perf/builtin-report.c b/tools/perf/builtin-report.c
index 0eea667..b5dd93a 100644
--- a/tools/perf/builtin-report.c
+++ b/tools/perf/builtin-report.c
@@ -321,7 +321,7 @@ static int process_read_event(struct perf_tool *tool,
 	struct report *rep = container_of(tool, struct report, tool);
 
 	if (rep->show_threads) {
-		const char *name = perf_evsel__name(evsel);
+		const char *name = evsel__name(evsel);
 		int err = perf_read_values_add_value(&rep->show_threads_values,
 					   event->read.pid, event->read.tid,
 					   evsel->idx,
@@ -537,7 +537,7 @@ static int perf_evlist__tty_browse_hists(struct evlist *evlist,
 
 	evlist__for_each_entry(evlist, pos) {
 		struct hists *hists = evsel__hists(pos);
-		const char *evname = perf_evsel__name(pos);
+		const char *evname = evsel__name(pos);
 
 		if (symbol_conf.event_group &&
 		    !perf_evsel__is_group_leader(pos))
diff --git a/tools/perf/builtin-sched.c b/tools/perf/builtin-sched.c
index 82fcc2c..5c00526 100644
--- a/tools/perf/builtin-sched.c
+++ b/tools/perf/builtin-sched.c
@@ -2136,7 +2136,7 @@ static bool is_idle_sample(struct perf_sample *sample,
 			   struct evsel *evsel)
 {
 	/* pid 0 == swapper == idle task */
-	if (strcmp(perf_evsel__name(evsel), "sched:sched_switch") == 0)
+	if (strcmp(evsel__name(evsel), "sched:sched_switch") == 0)
 		return perf_evsel__intval(evsel, sample, "prev_pid") == 0;
 
 	return sample->pid == 0;
@@ -2355,7 +2355,7 @@ static bool timehist_skip_sample(struct perf_sched *sched,
 	}
 
 	if (sched->idle_hist) {
-		if (strcmp(perf_evsel__name(evsel), "sched:sched_switch"))
+		if (strcmp(evsel__name(evsel), "sched:sched_switch"))
 			rc = true;
 		else if (perf_evsel__intval(evsel, sample, "prev_pid") != 0 &&
 			 perf_evsel__intval(evsel, sample, "next_pid") != 0)
diff --git a/tools/perf/builtin-script.c b/tools/perf/builtin-script.c
index 907b5c9..8ca24e3 100644
--- a/tools/perf/builtin-script.c
+++ b/tools/perf/builtin-script.c
@@ -273,7 +273,7 @@ static struct evsel_script *perf_evsel_script__new(struct evsel *evsel,
 	struct evsel_script *es = zalloc(sizeof(*es));
 
 	if (es != NULL) {
-		if (asprintf(&es->filename, "%s.%s.dump", data->file.path, perf_evsel__name(evsel)) < 0)
+		if (asprintf(&es->filename, "%s.%s.dump", data->file.path, evsel__name(evsel)) < 0)
 			goto out_free;
 		es->fp = fopen(es->filename, "w");
 		if (es->fp == NULL)
@@ -366,7 +366,7 @@ static int perf_evsel__do_check_stype(struct evsel *evsel,
 	if (output[type].user_set_fields & field) {
 		if (allow_user_set)
 			return 0;
-		evname = perf_evsel__name(evsel);
+		evname = evsel__name(evsel);
 		pr_err("Samples for '%s' event do not have %s attribute set. "
 		       "Cannot print '%s' field.\n",
 		       evname, sample_msg, output_field2str(field));
@@ -375,7 +375,7 @@ static int perf_evsel__do_check_stype(struct evsel *evsel,
 
 	/* user did not ask for it explicitly so remove from the default list */
 	output[type].fields &= ~field;
-	evname = perf_evsel__name(evsel);
+	evname = evsel__name(evsel);
 	pr_debug("Samples for '%s' event do not have %s attribute set. "
 		 "Skipping '%s' field.\n",
 		 evname, sample_msg, output_field2str(field));
@@ -1712,7 +1712,7 @@ static int perf_evlist__max_name_len(struct evlist *evlist)
 	int max = 0;
 
 	evlist__for_each_entry(evlist, evsel) {
-		int len = strlen(perf_evsel__name(evsel));
+		int len = strlen(evsel__name(evsel));
 
 		max = MAX(len, max);
 	}
@@ -1886,7 +1886,7 @@ static void process_event(struct perf_script *script,
 		fprintf(fp, "%10" PRIu64 " ", sample->period);
 
 	if (PRINT_FIELD(EVNAME)) {
-		const char *evname = perf_evsel__name(evsel);
+		const char *evname = evsel__name(evsel);
 
 		if (!script->name_width)
 			script->name_width = perf_evlist__max_name_len(script->session->evlist);
@@ -2003,7 +2003,7 @@ static void __process_stat(struct evsel *counter, u64 tstamp)
 				counts->ena,
 				counts->run,
 				tstamp,
-				perf_evsel__name(counter));
+				evsel__name(counter));
 		}
 	}
 }
@@ -2975,7 +2975,7 @@ static int check_ev_match(char *dir_name, char *scriptname,
 
 			match = 0;
 			evlist__for_each_entry(session->evlist, pos) {
-				if (!strcmp(perf_evsel__name(pos), evname)) {
+				if (!strcmp(evsel__name(pos), evname)) {
 					match = 1;
 					break;
 				}
diff --git a/tools/perf/builtin-stat.c b/tools/perf/builtin-stat.c
index 3f050d8..6bc1336 100644
--- a/tools/perf/builtin-stat.c
+++ b/tools/perf/builtin-stat.c
@@ -306,7 +306,7 @@ static int read_counter_cpu(struct evsel *counter, struct timespec *rs, int cpu)
 		if (verbose > 1) {
 			fprintf(stat_config.output,
 				"%s: %d: %" PRIu64 " %" PRIu64 " %" PRIu64 "\n",
-					perf_evsel__name(counter),
+					evsel__name(counter),
 					cpu,
 					count->val, count->ena, count->run);
 		}
@@ -455,7 +455,7 @@ static enum counter_recovery stat_handle_error(struct evsel *counter)
 	    errno == ENXIO) {
 		if (verbose > 0)
 			ui__warning("%s event is not supported by the kernel.\n",
-				    perf_evsel__name(counter));
+				    evsel__name(counter));
 		counter->supported = false;
 		/*
 		 * errored is a sticky flag that means one of the counter's
@@ -605,7 +605,7 @@ try_again:
 				if (!counter->reset_group)
 					continue;
 try_again_reset:
-				pr_debug2("reopening weak %s\n", perf_evsel__name(counter));
+				pr_debug2("reopening weak %s\n", evsel__name(counter));
 				if (create_perf_stat_counter(counter, &stat_config, &target,
 							     counter->cpu_iter - 1) < 0) {
 
@@ -643,7 +643,7 @@ try_again_reset:
 
 	if (perf_evlist__apply_filters(evsel_list, &counter)) {
 		pr_err("failed to set filter \"%s\" on event %s with %d (%s)\n",
-			counter->filter, perf_evsel__name(counter), errno,
+			counter->filter, evsel__name(counter), errno,
 			str_error_r(errno, msg, sizeof(msg)));
 		return -1;
 	}
diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index de24ace..55edab9 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -255,7 +255,7 @@ static void perf_top__show_details(struct perf_top *top)
 	if (notes->src == NULL)
 		goto out_unlock;
 
-	printf("Showing %s for %s\n", perf_evsel__name(top->sym_evsel), symbol->name);
+	printf("Showing %s for %s\n", evsel__name(top->sym_evsel), symbol->name);
 	printf("  Events  Pcnt (>=%d%%)\n", top->annotation_opts.min_pcnt);
 
 	more = symbol__annotate_printf(&he->ms, top->sym_evsel, &top->annotation_opts);
@@ -442,7 +442,7 @@ static void perf_top__print_mapped_keys(struct perf_top *top)
 	fprintf(stdout, "\t[e]     display entries (lines).           \t(%d)\n", top->print_entries);
 
 	if (top->evlist->core.nr_entries > 1)
-		fprintf(stdout, "\t[E]     active event counter.              \t(%s)\n", perf_evsel__name(top->sym_evsel));
+		fprintf(stdout, "\t[E]     active event counter.              \t(%s)\n", evsel__name(top->sym_evsel));
 
 	fprintf(stdout, "\t[f]     profile display filter (count).    \t(%d)\n", top->count_filter);
 
@@ -529,13 +529,13 @@ static bool perf_top__handle_keypress(struct perf_top *top, int c)
 				fprintf(stderr, "\nAvailable events:");
 
 				evlist__for_each_entry(top->evlist, top->sym_evsel)
-					fprintf(stderr, "\n\t%d %s", top->sym_evsel->idx, perf_evsel__name(top->sym_evsel));
+					fprintf(stderr, "\n\t%d %s", top->sym_evsel->idx, evsel__name(top->sym_evsel));
 
 				prompt_integer(&counter, "Enter details event counter");
 
 				if (counter >= top->evlist->core.nr_entries) {
 					top->sym_evsel = evlist__first(top->evlist);
-					fprintf(stderr, "Sorry, no such event, using %s.\n", perf_evsel__name(top->sym_evsel));
+					fprintf(stderr, "Sorry, no such event, using %s.\n", evsel__name(top->sym_evsel));
 					sleep(1);
 					break;
 				}
diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index f2e8325..1411e27 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2074,7 +2074,7 @@ static struct syscall *trace__syscall_info(struct trace *trace,
 		if (verbose > 1) {
 			static u64 n;
 			fprintf(trace->output, "Invalid syscall %d id, skipping (%s, %" PRIu64 ") ...\n",
-				id, perf_evsel__name(evsel), ++n);
+				id, evsel__name(evsel), ++n);
 		}
 		return NULL;
 	}
@@ -2206,7 +2206,7 @@ static int trace__fprintf_sample(struct trace *trace, struct evsel *evsel,
 		double ts = (double)sample->time / NSEC_PER_MSEC;
 
 		printed += fprintf(trace->output, "%22s %10.3f %s %d/%d [%d]\n",
-				   perf_evsel__name(evsel), ts,
+				   evsel__name(evsel), ts,
 				   thread__comm_str(thread),
 				   sample->pid, sample->tid, sample->cpu);
 	}
@@ -2513,7 +2513,7 @@ errno_print: {
 	if (callchain_ret > 0)
 		trace__fprintf_callchain(trace, sample);
 	else if (callchain_ret < 0)
-		pr_err("Problem processing %s callchain, skipping...\n", perf_evsel__name(evsel));
+		pr_err("Problem processing %s callchain, skipping...\n", evsel__name(evsel));
 out:
 	ttrace->entry_pending = false;
 	err = 0;
@@ -2795,7 +2795,7 @@ newline:
 	if (callchain_ret > 0)
 		trace__fprintf_callchain(trace, sample);
 	else if (callchain_ret < 0)
-		pr_err("Problem processing %s callchain, skipping...\n", perf_evsel__name(evsel));
+		pr_err("Problem processing %s callchain, skipping...\n", evsel__name(evsel));
 
 	++trace->nr_events_printed;
 
@@ -2890,7 +2890,7 @@ static int trace__pgfault(struct trace *trace,
 	if (callchain_ret > 0)
 		trace__fprintf_callchain(trace, sample);
 	else if (callchain_ret < 0)
-		pr_err("Problem processing %s callchain, skipping...\n", perf_evsel__name(evsel));
+		pr_err("Problem processing %s callchain, skipping...\n", evsel__name(evsel));
 
 	++trace->nr_events_printed;
 out:
@@ -3032,7 +3032,7 @@ static bool evlist__add_vfs_getname(struct evlist *evlist)
 	}
 
 	evlist__for_each_entry_safe(evlist, evsel, tmp) {
-		if (!strstarts(perf_evsel__name(evsel), "probe:vfs_getname"))
+		if (!strstarts(evsel__name(evsel), "probe:vfs_getname"))
 			continue;
 
 		if (perf_evsel__field(evsel, "pathname")) {
@@ -3093,7 +3093,7 @@ static void trace__handle_event(struct trace *trace, union perf_event *event, st
 	if (evsel->core.attr.type == PERF_TYPE_TRACEPOINT &&
 	    sample->raw_data == NULL) {
 		fprintf(trace->output, "%s sample with no payload for tid: %d, cpu %d, raw_size=%d, skipping...\n",
-		       perf_evsel__name(evsel), sample->tid,
+		       evsel__name(evsel), sample->tid,
 		       sample->cpu, sample->raw_size);
 	} else {
 		tracepoint_handler handler = evsel->handler;
@@ -4108,7 +4108,7 @@ out_error:
 out_error_apply_filters:
 	fprintf(trace->output,
 		"Failed to set filter \"%s\" on event %s with %d (%s)\n",
-		evsel->filter, perf_evsel__name(evsel), errno,
+		evsel->filter, evsel__name(evsel), errno,
 		str_error_r(errno, errbuf, sizeof(errbuf)));
 	goto out_delete_evlist;
 }
@@ -4989,7 +4989,7 @@ int cmd_trace(int argc, const char **argv)
 	 */
 	if (trace.syscalls.events.augmented) {
 		evlist__for_each_entry(trace.evlist, evsel) {
-			bool raw_syscalls_sys_exit = strcmp(perf_evsel__name(evsel), "raw_syscalls:sys_exit") == 0;
+			bool raw_syscalls_sys_exit = strcmp(evsel__name(evsel), "raw_syscalls:sys_exit") == 0;
 
 			if (raw_syscalls_sys_exit) {
 				trace.raw_augmented_syscalls = true;
@@ -4997,7 +4997,7 @@ int cmd_trace(int argc, const char **argv)
 			}
 
 			if (trace.syscalls.events.augmented->priv == NULL &&
-			    strstr(perf_evsel__name(evsel), "syscalls:sys_enter")) {
+			    strstr(evsel__name(evsel), "syscalls:sys_enter")) {
 				struct evsel *augmented = trace.syscalls.events.augmented;
 				if (perf_evsel__init_augmented_syscall_tp(augmented, evsel) ||
 				    perf_evsel__init_augmented_syscall_tp_args(augmented))
@@ -5020,7 +5020,7 @@ int cmd_trace(int argc, const char **argv)
 				evsel->handler = trace__sys_enter;
 			}
 
-			if (strstarts(perf_evsel__name(evsel), "syscalls:sys_exit_")) {
+			if (strstarts(evsel__name(evsel), "syscalls:sys_exit_")) {
 				struct syscall_tp *sc;
 init_augmented_syscall_tp:
 				if (perf_evsel__init_augmented_syscall_tp(evsel, evsel))
diff --git a/tools/perf/tests/event_update.c b/tools/perf/tests/event_update.c
index c727379..bdcf032 100644
--- a/tools/perf/tests/event_update.c
+++ b/tools/perf/tests/event_update.c
@@ -109,7 +109,7 @@ int test__event_update(struct test *test __maybe_unused, int subtest __maybe_unu
 	TEST_ASSERT_VAL("failed to synthesize attr update scale",
 			!perf_event__synthesize_event_update_scale(NULL, evsel, process_event_scale));
 
-	tmp.name = perf_evsel__name(evsel);
+	tmp.name = evsel__name(evsel);
 
 	TEST_ASSERT_VAL("failed to synthesize attr update name",
 			!perf_event__synthesize_event_update_name(&tmp.tool, evsel, process_event_name));
diff --git a/tools/perf/tests/evsel-roundtrip-name.c b/tools/perf/tests/evsel-roundtrip-name.c
index 956205b..f052851 100644
--- a/tools/perf/tests/evsel-roundtrip-name.c
+++ b/tools/perf/tests/evsel-roundtrip-name.c
@@ -24,8 +24,7 @@ static int perf_evsel__roundtrip_cache_name_test(void)
 				continue;
 
 			for (i = 0; i < PERF_COUNT_HW_CACHE_RESULT_MAX; i++) {
-				__perf_evsel__hw_cache_type_op_res_name(type, op, i,
-									name, sizeof(name));
+				__evsel__hw_cache_type_op_res_name(type, op, i, name, sizeof(name));
 				err = parse_events(evlist, name, NULL);
 				if (err)
 					ret = err;
@@ -43,15 +42,14 @@ static int perf_evsel__roundtrip_cache_name_test(void)
 				continue;
 
 			for (i = 0; i < PERF_COUNT_HW_CACHE_RESULT_MAX; i++) {
-				__perf_evsel__hw_cache_type_op_res_name(type, op, i,
-									name, sizeof(name));
+				__evsel__hw_cache_type_op_res_name(type, op, i, name, sizeof(name));
 				if (evsel->idx != idx)
 					continue;
 
 				++idx;
 
-				if (strcmp(perf_evsel__name(evsel), name)) {
-					pr_debug("%s != %s\n", perf_evsel__name(evsel), name);
+				if (strcmp(evsel__name(evsel), name)) {
+					pr_debug("%s != %s\n", evsel__name(evsel), name);
 					ret = -1;
 				}
 
@@ -84,9 +82,9 @@ static int __perf_evsel__name_array_test(const char *names[], int nr_names)
 
 	err = 0;
 	evlist__for_each_entry(evlist, evsel) {
-		if (strcmp(perf_evsel__name(evsel), names[evsel->idx])) {
+		if (strcmp(evsel__name(evsel), names[evsel->idx])) {
 			--err;
-			pr_debug("%s != %s\n", perf_evsel__name(evsel), names[evsel->idx]);
+			pr_debug("%s != %s\n", evsel__name(evsel), names[evsel->idx]);
 		}
 	}
 
diff --git a/tools/perf/tests/mmap-basic.c b/tools/perf/tests/mmap-basic.c
index 5f4c0db..e9c0c64 100644
--- a/tools/perf/tests/mmap-basic.c
+++ b/tools/perf/tests/mmap-basic.c
@@ -150,7 +150,7 @@ out_init:
 		if (nr_events[evsel->idx] != expected_nr_events[evsel->idx]) {
 			pr_debug("expected %d %s events, got %d\n",
 				 expected_nr_events[evsel->idx],
-				 perf_evsel__name(evsel), nr_events[evsel->idx]);
+				 evsel__name(evsel), nr_events[evsel->idx]);
 			err = -1;
 			goto out_delete_evlist;
 		}
diff --git a/tools/perf/tests/parse-events.c b/tools/perf/tests/parse-events.c
index 902bd9d..732dde2 100644
--- a/tools/perf/tests/parse-events.c
+++ b/tools/perf/tests/parse-events.c
@@ -371,7 +371,7 @@ static int test__checkevent_breakpoint_modifier(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong name",
-			!strcmp(perf_evsel__name(evsel), "mem:0:u"));
+			!strcmp(evsel__name(evsel), "mem:0:u"));
 
 	return test__checkevent_breakpoint(evlist);
 }
@@ -385,7 +385,7 @@ static int test__checkevent_breakpoint_x_modifier(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
 	TEST_ASSERT_VAL("wrong precise_ip", !evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong name",
-			!strcmp(perf_evsel__name(evsel), "mem:0:x:k"));
+			!strcmp(evsel__name(evsel), "mem:0:x:k"));
 
 	return test__checkevent_breakpoint_x(evlist);
 }
@@ -399,7 +399,7 @@ static int test__checkevent_breakpoint_r_modifier(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude_hv", !evsel->core.attr.exclude_hv);
 	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong name",
-			!strcmp(perf_evsel__name(evsel), "mem:0:r:hp"));
+			!strcmp(evsel__name(evsel), "mem:0:r:hp"));
 
 	return test__checkevent_breakpoint_r(evlist);
 }
@@ -413,7 +413,7 @@ static int test__checkevent_breakpoint_w_modifier(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
 	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong name",
-			!strcmp(perf_evsel__name(evsel), "mem:0:w:up"));
+			!strcmp(evsel__name(evsel), "mem:0:w:up"));
 
 	return test__checkevent_breakpoint_w(evlist);
 }
@@ -427,7 +427,7 @@ static int test__checkevent_breakpoint_rw_modifier(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong exclude_hv", evsel->core.attr.exclude_hv);
 	TEST_ASSERT_VAL("wrong precise_ip", evsel->core.attr.precise_ip);
 	TEST_ASSERT_VAL("wrong name",
-			!strcmp(perf_evsel__name(evsel), "mem:0:rw:kp"));
+			!strcmp(evsel__name(evsel), "mem:0:rw:kp"));
 
 	return test__checkevent_breakpoint_rw(evlist);
 }
@@ -498,7 +498,7 @@ static int test__checkevent_pmu_name(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong number of entries", 2 == evlist->core.nr_entries);
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",  1 == evsel->core.attr.config);
-	TEST_ASSERT_VAL("wrong name", !strcmp(perf_evsel__name(evsel), "krava"));
+	TEST_ASSERT_VAL("wrong name", !strcmp(evsel__name(evsel), "krava"));
 
 	/* cpu/config=2/u" */
 	evsel = perf_evsel__next(evsel);
@@ -506,7 +506,7 @@ static int test__checkevent_pmu_name(struct evlist *evlist)
 	TEST_ASSERT_VAL("wrong type", PERF_TYPE_RAW == evsel->core.attr.type);
 	TEST_ASSERT_VAL("wrong config",  2 == evsel->core.attr.config);
 	TEST_ASSERT_VAL("wrong name",
-			!strcmp(perf_evsel__name(evsel), "cpu/config=2/u"));
+			!strcmp(evsel__name(evsel), "cpu/config=2/u"));
 
 	return 0;
 }
diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index 487e54e..1ad64ca 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -3416,7 +3416,7 @@ static void perf_evsel_menu__write(struct ui_browser *browser,
 	struct hists *hists = evsel__hists(evsel);
 	bool current_entry = ui_browser__is_current_entry(browser, row);
 	unsigned long nr_events = hists->stats.nr_events[PERF_RECORD_SAMPLE];
-	const char *ev_name = perf_evsel__name(evsel);
+	const char *ev_name = evsel__name(evsel);
 	char bf[256], unit;
 	const char *warn = " ";
 	size_t printed;
@@ -3427,7 +3427,7 @@ static void perf_evsel_menu__write(struct ui_browser *browser,
 	if (perf_evsel__is_group_event(evsel)) {
 		struct evsel *pos;
 
-		ev_name = perf_evsel__group_name(evsel);
+		ev_name = evsel__group_name(evsel);
 
 		for_each_group_member(pos, evsel) {
 			struct hists *pos_hists = evsel__hists(pos);
@@ -3587,7 +3587,7 @@ static int __perf_evlist__tui_browse_hists(struct evlist *evlist,
 	ui_helpline__push("Press ESC to exit");
 
 	evlist__for_each_entry(evlist, pos) {
-		const char *ev_name = perf_evsel__name(pos);
+		const char *ev_name = evsel__name(pos);
 		size_t line_len = strlen(ev_name) + 7;
 
 		if (menu.b.width < line_len)
@@ -3640,7 +3640,7 @@ static int block_hists_browser__title(struct hist_browser *browser, char *bf,
 				      size_t size)
 {
 	struct hists *hists = evsel__hists(browser->block_evsel);
-	const char *evname = perf_evsel__name(browser->block_evsel);
+	const char *evname = evsel__name(browser->block_evsel);
 	unsigned long nr_samples = hists->stats.nr_events[PERF_RECORD_SAMPLE];
 	int ret;
 
diff --git a/tools/perf/ui/gtk/hists.c b/tools/perf/ui/gtk/hists.c
index ed1a97b..50c072d 100644
--- a/tools/perf/ui/gtk/hists.c
+++ b/tools/perf/ui/gtk/hists.c
@@ -635,7 +635,7 @@ int perf_evlist__gtk_browse_hists(struct evlist *evlist,
 
 	evlist__for_each_entry(evlist, pos) {
 		struct hists *hists = evsel__hists(pos);
-		const char *evname = perf_evsel__name(pos);
+		const char *evname = evsel__name(pos);
 		GtkWidget *scrolled_window;
 		GtkWidget *tab_label;
 		char buf[512];
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index 9760d58..37d9562 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2344,7 +2344,7 @@ int symbol__annotate_printf(struct map_symbol *ms, struct evsel *evsel,
 	struct dso *dso = map->dso;
 	char *filename;
 	const char *d_filename;
-	const char *evsel_name = perf_evsel__name(evsel);
+	const char *evsel_name = evsel__name(evsel);
 	struct annotation *notes = symbol__annotation(sym);
 	struct sym_hist *h = annotation__histogram(notes, evsel->idx);
 	struct annotation_line *pos, *queue = NULL;
@@ -2505,7 +2505,7 @@ static int symbol__annotate_fprintf2(struct symbol *sym, FILE *fp,
 int map_symbol__annotation_dump(struct map_symbol *ms, struct evsel *evsel,
 				struct annotation_options *opts)
 {
-	const char *ev_name = perf_evsel__name(evsel);
+	const char *ev_name = evsel__name(evsel);
 	char buf[1024];
 	char *filename;
 	int err = -1;
diff --git a/tools/perf/util/data-convert-bt.c b/tools/perf/util/data-convert-bt.c
index dbc772b..54c345e 100644
--- a/tools/perf/util/data-convert-bt.c
+++ b/tools/perf/util/data-convert-bt.c
@@ -1155,7 +1155,7 @@ static int add_event(struct ctf_writer *cw, struct evsel *evsel)
 {
 	struct bt_ctf_event_class *event_class;
 	struct evsel_priv *priv;
-	const char *name = perf_evsel__name(evsel);
+	const char *name = evsel__name(evsel);
 	int ret;
 
 	pr("Adding event '%s' (type %d)\n", name, evsel->core.attr.type);
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 3a16728..167599e 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -385,7 +385,7 @@ const char *perf_evsel__hw_names[PERF_COUNT_HW_MAX] = {
 	"ref-cycles",
 };
 
-static const char *__perf_evsel__hw_name(u64 config)
+static const char *__evsel__hw_name(u64 config)
 {
 	if (config < PERF_COUNT_HW_MAX && perf_evsel__hw_names[config])
 		return perf_evsel__hw_names[config];
@@ -429,9 +429,9 @@ static int perf_evsel__add_modifiers(struct evsel *evsel, char *bf, size_t size)
 	return r;
 }
 
-static int perf_evsel__hw_name(struct evsel *evsel, char *bf, size_t size)
+static int evsel__hw_name(struct evsel *evsel, char *bf, size_t size)
 {
-	int r = scnprintf(bf, size, "%s", __perf_evsel__hw_name(evsel->core.attr.config));
+	int r = scnprintf(bf, size, "%s", __evsel__hw_name(evsel->core.attr.config));
 	return r + perf_evsel__add_modifiers(evsel, bf + r, size - r);
 }
 
@@ -448,20 +448,20 @@ const char *perf_evsel__sw_names[PERF_COUNT_SW_MAX] = {
 	"dummy",
 };
 
-static const char *__perf_evsel__sw_name(u64 config)
+static const char *__evsel__sw_name(u64 config)
 {
 	if (config < PERF_COUNT_SW_MAX && perf_evsel__sw_names[config])
 		return perf_evsel__sw_names[config];
 	return "unknown-software";
 }
 
-static int perf_evsel__sw_name(struct evsel *evsel, char *bf, size_t size)
+static int evsel__sw_name(struct evsel *evsel, char *bf, size_t size)
 {
-	int r = scnprintf(bf, size, "%s", __perf_evsel__sw_name(evsel->core.attr.config));
+	int r = scnprintf(bf, size, "%s", __evsel__sw_name(evsel->core.attr.config));
 	return r + perf_evsel__add_modifiers(evsel, bf + r, size - r);
 }
 
-static int __perf_evsel__bp_name(char *bf, size_t size, u64 addr, u64 type)
+static int __evsel__bp_name(char *bf, size_t size, u64 addr, u64 type)
 {
 	int r;
 
@@ -479,10 +479,10 @@ static int __perf_evsel__bp_name(char *bf, size_t size, u64 addr, u64 type)
 	return r;
 }
 
-static int perf_evsel__bp_name(struct evsel *evsel, char *bf, size_t size)
+static int evsel__bp_name(struct evsel *evsel, char *bf, size_t size)
 {
 	struct perf_event_attr *attr = &evsel->core.attr;
-	int r = __perf_evsel__bp_name(bf, size, attr->bp_addr, attr->bp_type);
+	int r = __evsel__bp_name(bf, size, attr->bp_addr, attr->bp_type);
 	return r + perf_evsel__add_modifiers(evsel, bf + r, size - r);
 }
 
@@ -539,8 +539,7 @@ bool perf_evsel__is_cache_op_valid(u8 type, u8 op)
 		return false;	/* invalid */
 }
 
-int __perf_evsel__hw_cache_type_op_res_name(u8 type, u8 op, u8 result,
-					    char *bf, size_t size)
+int __evsel__hw_cache_type_op_res_name(u8 type, u8 op, u8 result, char *bf, size_t size)
 {
 	if (result) {
 		return scnprintf(bf, size, "%s-%s-%s", perf_evsel__hw_cache[type][0],
@@ -552,7 +551,7 @@ int __perf_evsel__hw_cache_type_op_res_name(u8 type, u8 op, u8 result,
 			 perf_evsel__hw_cache_op[op][1]);
 }
 
-static int __perf_evsel__hw_cache_name(u64 config, char *bf, size_t size)
+static int __evsel__hw_cache_name(u64 config, char *bf, size_t size)
 {
 	u8 op, result, type = (config >>  0) & 0xff;
 	const char *err = "unknown-ext-hardware-cache-type";
@@ -574,30 +573,30 @@ static int __perf_evsel__hw_cache_name(u64 config, char *bf, size_t size)
 	if (!perf_evsel__is_cache_op_valid(type, op))
 		goto out_err;
 
-	return __perf_evsel__hw_cache_type_op_res_name(type, op, result, bf, size);
+	return __evsel__hw_cache_type_op_res_name(type, op, result, bf, size);
 out_err:
 	return scnprintf(bf, size, "%s", err);
 }
 
-static int perf_evsel__hw_cache_name(struct evsel *evsel, char *bf, size_t size)
+static int evsel__hw_cache_name(struct evsel *evsel, char *bf, size_t size)
 {
-	int ret = __perf_evsel__hw_cache_name(evsel->core.attr.config, bf, size);
+	int ret = __evsel__hw_cache_name(evsel->core.attr.config, bf, size);
 	return ret + perf_evsel__add_modifiers(evsel, bf + ret, size - ret);
 }
 
-static int perf_evsel__raw_name(struct evsel *evsel, char *bf, size_t size)
+static int evsel__raw_name(struct evsel *evsel, char *bf, size_t size)
 {
 	int ret = scnprintf(bf, size, "raw 0x%" PRIx64, evsel->core.attr.config);
 	return ret + perf_evsel__add_modifiers(evsel, bf + ret, size - ret);
 }
 
-static int perf_evsel__tool_name(char *bf, size_t size)
+static int evsel__tool_name(char *bf, size_t size)
 {
 	int ret = scnprintf(bf, size, "duration_time");
 	return ret;
 }
 
-const char *perf_evsel__name(struct evsel *evsel)
+const char *evsel__name(struct evsel *evsel)
 {
 	char bf[128];
 
@@ -609,22 +608,22 @@ const char *perf_evsel__name(struct evsel *evsel)
 
 	switch (evsel->core.attr.type) {
 	case PERF_TYPE_RAW:
-		perf_evsel__raw_name(evsel, bf, sizeof(bf));
+		evsel__raw_name(evsel, bf, sizeof(bf));
 		break;
 
 	case PERF_TYPE_HARDWARE:
-		perf_evsel__hw_name(evsel, bf, sizeof(bf));
+		evsel__hw_name(evsel, bf, sizeof(bf));
 		break;
 
 	case PERF_TYPE_HW_CACHE:
-		perf_evsel__hw_cache_name(evsel, bf, sizeof(bf));
+		evsel__hw_cache_name(evsel, bf, sizeof(bf));
 		break;
 
 	case PERF_TYPE_SOFTWARE:
 		if (evsel->tool_event)
-			perf_evsel__tool_name(bf, sizeof(bf));
+			evsel__tool_name(bf, sizeof(bf));
 		else
-			perf_evsel__sw_name(evsel, bf, sizeof(bf));
+			evsel__sw_name(evsel, bf, sizeof(bf));
 		break;
 
 	case PERF_TYPE_TRACEPOINT:
@@ -632,7 +631,7 @@ const char *perf_evsel__name(struct evsel *evsel)
 		break;
 
 	case PERF_TYPE_BREAKPOINT:
-		perf_evsel__bp_name(evsel, bf, sizeof(bf));
+		evsel__bp_name(evsel, bf, sizeof(bf));
 		break;
 
 	default:
@@ -649,7 +648,7 @@ out_unknown:
 	return "unknown";
 }
 
-const char *perf_evsel__group_name(struct evsel *evsel)
+const char *evsel__group_name(struct evsel *evsel)
 {
 	return evsel->group_name ?: "anon group";
 }
@@ -668,17 +667,15 @@ int perf_evsel__group_desc(struct evsel *evsel, char *buf, size_t size)
 {
 	int ret = 0;
 	struct evsel *pos;
-	const char *group_name = perf_evsel__group_name(evsel);
+	const char *group_name = evsel__group_name(evsel);
 
 	if (!evsel->forced_leader)
 		ret = scnprintf(buf, size, "%s { ", group_name);
 
-	ret += scnprintf(buf + ret, size - ret, "%s",
-			 perf_evsel__name(evsel));
+	ret += scnprintf(buf + ret, size - ret, "%s", evsel__name(evsel));
 
 	for_each_group_member(pos, evsel)
-		ret += scnprintf(buf + ret, size - ret, ", %s",
-				 perf_evsel__name(pos));
+		ret += scnprintf(buf + ret, size - ret, ", %s", evsel__name(pos));
 
 	if (!evsel->forced_leader)
 		ret += scnprintf(buf + ret, size - ret, " }");
@@ -2421,7 +2418,7 @@ bool perf_evsel__fallback(struct evsel *evsel, int err,
 		return true;
 	} else if (err == EACCES && !evsel->core.attr.exclude_kernel &&
 		   (paranoid = perf_event_paranoid()) > 1) {
-		const char *name = perf_evsel__name(evsel);
+		const char *name = evsel__name(evsel);
 		char *new_name;
 		const char *sep = ":";
 
@@ -2499,8 +2496,7 @@ int perf_evsel__open_strerror(struct evsel *evsel, struct target *target,
 	case EACCES:
 		if (err == EPERM)
 			printed = scnprintf(msg, size,
-				"No permission to enable %s event.\n\n",
-				perf_evsel__name(evsel));
+				"No permission to enable %s event.\n\n", evsel__name(evsel));
 
 		return scnprintf(msg + printed, size - printed,
 		 "You may not have permission to collect %sstats.\n\n"
@@ -2519,8 +2515,7 @@ int perf_evsel__open_strerror(struct evsel *evsel, struct target *target,
 				 target->system_wide ? "system-wide " : "",
 				 perf_event_paranoid());
 	case ENOENT:
-		return scnprintf(msg, size, "The %s event is not supported.",
-				 perf_evsel__name(evsel));
+		return scnprintf(msg, size, "The %s event is not supported.", evsel__name(evsel));
 	case EMFILE:
 		return scnprintf(msg, size, "%s",
 			 "Too many events are opened.\n"
@@ -2544,7 +2539,7 @@ int perf_evsel__open_strerror(struct evsel *evsel, struct target *target,
 		if (evsel->core.attr.sample_period != 0)
 			return scnprintf(msg, size,
 	"%s: PMU Hardware doesn't support sampling/overflow-interrupts. Try 'perf stat'",
-					 perf_evsel__name(evsel));
+					 evsel__name(evsel));
 		if (evsel->core.attr.precise_ip)
 			return scnprintf(msg, size, "%s",
 	"\'precise\' request may not be supported. Try removing 'p' modifier.");
@@ -2577,8 +2572,7 @@ int perf_evsel__open_strerror(struct evsel *evsel, struct target *target,
 	return scnprintf(msg, size,
 	"The sys_perf_event_open() syscall returned with %d (%s) for event (%s).\n"
 	"/bin/dmesg | grep -i perf may provide additional information.\n",
-			 err, str_error_r(err, sbuf, sizeof(sbuf)),
-			 perf_evsel__name(evsel));
+			 err, str_error_r(err, sbuf, sizeof(sbuf)), evsel__name(evsel));
 }
 
 struct perf_env *perf_evsel__env(struct evsel *evsel)
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 580975c..7160f3d 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -208,11 +208,10 @@ extern const char *perf_evsel__hw_cache_result[PERF_COUNT_HW_CACHE_RESULT_MAX]
 					      [PERF_EVSEL__MAX_ALIASES];
 extern const char *perf_evsel__hw_names[PERF_COUNT_HW_MAX];
 extern const char *perf_evsel__sw_names[PERF_COUNT_SW_MAX];
-int __perf_evsel__hw_cache_type_op_res_name(u8 type, u8 op, u8 result,
-					    char *bf, size_t size);
-const char *perf_evsel__name(struct evsel *evsel);
+int __evsel__hw_cache_type_op_res_name(u8 type, u8 op, u8 result, char *bf, size_t size);
+const char *evsel__name(struct evsel *evsel);
 
-const char *perf_evsel__group_name(struct evsel *evsel);
+const char *evsel__group_name(struct evsel *evsel);
 int perf_evsel__group_desc(struct evsel *evsel, char *buf, size_t size);
 
 void __perf_evsel__set_sample_bit(struct evsel *evsel,
diff --git a/tools/perf/util/evsel_fprintf.c b/tools/perf/util/evsel_fprintf.c
index 3b48428..b4c3c7b 100644
--- a/tools/perf/util/evsel_fprintf.c
+++ b/tools/perf/util/evsel_fprintf.c
@@ -50,16 +50,16 @@ int perf_evsel__fprintf(struct evsel *evsel,
 		if (evsel->core.nr_members > 1)
 			printed += fprintf(fp, "%s{", evsel->group_name ?: "");
 
-		printed += fprintf(fp, "%s", perf_evsel__name(evsel));
+		printed += fprintf(fp, "%s", evsel__name(evsel));
 		for_each_group_member(pos, evsel)
-			printed += fprintf(fp, ",%s", perf_evsel__name(pos));
+			printed += fprintf(fp, ",%s", evsel__name(pos));
 
 		if (evsel->core.nr_members > 1)
 			printed += fprintf(fp, "}");
 		goto out;
 	}
 
-	printed += fprintf(fp, "%s", perf_evsel__name(evsel));
+	printed += fprintf(fp, "%s", evsel__name(evsel));
 
 	if (details->verbose) {
 		printed += perf_event_attr__fprintf(fp, &evsel->core.attr,
diff --git a/tools/perf/util/header.c b/tools/perf/util/header.c
index 28e82da..8903194 100644
--- a/tools/perf/util/header.c
+++ b/tools/perf/util/header.c
@@ -525,7 +525,7 @@ static int write_event_desc(struct feat_fd *ff,
 		/*
 		 * write event string as passed on cmdline
 		 */
-		ret = do_write_string(ff, perf_evsel__name(evsel));
+		ret = do_write_string(ff, evsel__name(evsel));
 		if (ret < 0)
 			return ret;
 		/*
@@ -1909,12 +1909,11 @@ static void print_group_desc(struct feat_fd *ff, FILE *fp)
 	evlist__for_each_entry(session->evlist, evsel) {
 		if (perf_evsel__is_group_leader(evsel) &&
 		    evsel->core.nr_members > 1) {
-			fprintf(fp, "# group: %s{%s", evsel->group_name ?: "",
-				perf_evsel__name(evsel));
+			fprintf(fp, "# group: %s{%s", evsel->group_name ?: "", evsel__name(evsel));
 
 			nr = evsel->core.nr_members - 1;
 		} else if (nr) {
-			fprintf(fp, ",%s", perf_evsel__name(evsel));
+			fprintf(fp, ",%s", evsel__name(evsel));
 
 			if (--nr == 0)
 				fprintf(fp, "}\n");
diff --git a/tools/perf/util/hist.c b/tools/perf/util/hist.c
index c2550db..fa77574 100644
--- a/tools/perf/util/hist.c
+++ b/tools/perf/util/hist.c
@@ -2660,7 +2660,7 @@ size_t perf_evlist__fprintf_nr_events(struct evlist *evlist, FILE *fp)
 	size_t ret = 0;
 
 	evlist__for_each_entry(evlist, pos) {
-		ret += fprintf(fp, "%s stats:\n", perf_evsel__name(pos));
+		ret += fprintf(fp, "%s stats:\n", evsel__name(pos));
 		ret += events_stats__fprintf(&evsel__hists(pos)->stats, fp);
 	}
 
@@ -2684,7 +2684,7 @@ int __hists__scnprintf_title(struct hists *hists, char *bf, size_t size, bool sh
 	unsigned long nr_samples = hists->stats.nr_events[PERF_RECORD_SAMPLE];
 	u64 nr_events = hists->stats.total_period;
 	struct evsel *evsel = hists_to_evsel(hists);
-	const char *ev_name = perf_evsel__name(evsel);
+	const char *ev_name = evsel__name(evsel);
 	char buf[512], sample_freq_str[64] = "";
 	size_t buflen = sizeof(buf);
 	char ref[30] = " show reference callgraph, ";
diff --git a/tools/perf/util/intel-pt.c b/tools/perf/util/intel-pt.c
index 59811b3..59829f2 100644
--- a/tools/perf/util/intel-pt.c
+++ b/tools/perf/util/intel-pt.c
@@ -3037,7 +3037,7 @@ static struct evsel *intel_pt_find_sched_switch(struct evlist *evlist)
 	struct evsel *evsel;
 
 	evlist__for_each_entry_reverse(evlist, evsel) {
-		const char *name = perf_evsel__name(evsel);
+		const char *name = evsel__name(evsel);
 
 		if (!strcmp(name, "sched:sched_switch"))
 			return evsel;
diff --git a/tools/perf/util/parse-events.c b/tools/perf/util/parse-events.c
index 6dc9e57..2252f49 100644
--- a/tools/perf/util/parse-events.c
+++ b/tools/perf/util/parse-events.c
@@ -2631,8 +2631,7 @@ restart:
 				continue;
 
 			for (i = 0; i < PERF_COUNT_HW_CACHE_RESULT_MAX; i++) {
-				__perf_evsel__hw_cache_type_op_res_name(type, op, i,
-									name, sizeof(name));
+				__evsel__hw_cache_type_op_res_name(type, op, i, name, sizeof(name));
 				if (event_glob != NULL && !strglobmatch(name, event_glob))
 					continue;
 
diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 2c372cf..739516f 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -741,7 +741,7 @@ static PyObject *get_perf_sample_dict(struct perf_sample *sample,
 	if (!dict_sample)
 		Py_FatalError("couldn't create Python dictionary");
 
-	pydict_set_item_string_decref(dict, "ev_name", _PyUnicode_FromString(perf_evsel__name(evsel)));
+	pydict_set_item_string_decref(dict, "ev_name", _PyUnicode_FromString(evsel__name(evsel)));
 	pydict_set_item_string_decref(dict, "attr", _PyBytes_FromStringAndSize((const char *)&evsel->core.attr, sizeof(evsel->core.attr)));
 
 	pydict_set_item_string_decref(dict_sample, "pid",
@@ -968,7 +968,7 @@ static int python_export_evsel(struct db_export *dbe, struct evsel *evsel)
 	t = tuple_new(2);
 
 	tuple_set_u64(t, 0, evsel->db_id);
-	tuple_set_string(t, 1, perf_evsel__name(evsel));
+	tuple_set_string(t, 1, evsel__name(evsel));
 
 	call_object(tables->evsel_handler, t, "evsel_table");
 
@@ -1349,7 +1349,7 @@ static void get_handler_name(char *str, size_t size,
 {
 	char *p = str;
 
-	scnprintf(str, size, "stat__%s", perf_evsel__name(evsel));
+	scnprintf(str, size, "stat__%s", evsel__name(evsel));
 
 	while ((p = strchr(p, ':'))) {
 		*p = '_';
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 2b5a08a..7f7d3a1 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1280,8 +1280,7 @@ static void dump_read(struct evsel *evsel, union perf_event *event)
 		return;
 
 	printf(": %d %d %s %" PRI_lu64 "\n", event->read.pid, event->read.tid,
-	       perf_evsel__name(evsel),
-	       event->read.value);
+	       evsel__name(evsel), event->read.value);
 
 	if (!evsel)
 		return;
diff --git a/tools/perf/util/stat-display.c b/tools/perf/util/stat-display.c
index b0e5d85..7f46e28 100644
--- a/tools/perf/util/stat-display.c
+++ b/tools/perf/util/stat-display.c
@@ -246,7 +246,7 @@ static const char *fixunit(char *buf, struct evsel *evsel,
 			   const char *unit)
 {
 	if (!strncmp(unit, "of all", 6)) {
-		snprintf(buf, 1024, "%s %s", perf_evsel__name(evsel),
+		snprintf(buf, 1024, "%s %s", evsel__name(evsel),
 			 unit);
 		return buf;
 	}
@@ -367,7 +367,7 @@ static void abs_printout(struct perf_stat_config *config,
 			config->csv_output ? 0 : config->unit_width,
 			evsel->unit, config->csv_sep);
 
-	fprintf(output, "%-*s", config->csv_output ? 0 : 25, perf_evsel__name(evsel));
+	fprintf(output, "%-*s", config->csv_output ? 0 : 25, evsel__name(evsel));
 
 	print_cgroup(config, evsel);
 }
@@ -461,8 +461,7 @@ static void printout(struct perf_stat_config *config, int id, int nr,
 			counter->unit, config->csv_sep);
 
 		fprintf(config->output, "%*s",
-			config->csv_output ? 0 : -25,
-			perf_evsel__name(counter));
+			config->csv_output ? 0 : -25, evsel__name(counter));
 
 		print_cgroup(config, counter);
 
@@ -559,7 +558,7 @@ static void collect_all_aliases(struct perf_stat_config *config, struct evsel *c
 
 	alias = list_prepare_entry(counter, &(evlist->core.entries), core.node);
 	list_for_each_entry_continue (alias, &evlist->core.entries, core.node) {
-		if (strcmp(perf_evsel__name(alias), perf_evsel__name(counter)) ||
+		if (strcmp(evsel__name(alias), evsel__name(counter)) ||
 		    alias->scale != counter->scale ||
 		    alias->cgrp != counter->cgrp ||
 		    strcmp(alias->unit, counter->unit) ||
diff --git a/tools/perf/util/stat.c b/tools/perf/util/stat.c
index 4e6e770..c27f01b 100644
--- a/tools/perf/util/stat.c
+++ b/tools/perf/util/stat.c
@@ -108,7 +108,7 @@ static void perf_stat_evsel_id_init(struct evsel *evsel)
 	/* ps->id is 0 hence PERF_STAT_EVSEL_ID__NONE by default */
 
 	for (i = 0; i < PERF_STAT_EVSEL_ID__MAX; i++) {
-		if (!strcmp(perf_evsel__name(evsel), id_str[i])) {
+		if (!strcmp(evsel__name(evsel), id_str[i])) {
 			ps->id = i;
 			break;
 		}
@@ -392,7 +392,7 @@ int perf_stat_process_counter(struct perf_stat_config *config,
 
 	if (verbose > 0) {
 		fprintf(config->output, "%s: %" PRIu64 " %" PRIu64 " %" PRIu64 "\n",
-			perf_evsel__name(counter), count[0], count[1], count[2]);
+			evsel__name(counter), count[0], count[1], count[2]);
 	}
 
 	/*
diff --git a/tools/perf/util/top.c b/tools/perf/util/top.c
index 3dce2de..27945ee 100644
--- a/tools/perf/util/top.c
+++ b/tools/perf/util/top.c
@@ -77,7 +77,7 @@ size_t perf_top__header_snprintf(struct perf_top *top, char *bf, size_t size)
 				opts->freq ? "Hz" : "");
 	}
 
-	ret += SNPRINTF(bf + ret, size - ret, "%s", perf_evsel__name(top->sym_evsel));
+	ret += SNPRINTF(bf + ret, size - ret, "%s", evsel__name(top->sym_evsel));
 
 	ret += SNPRINTF(bf + ret, size - ret, "], ");
 
