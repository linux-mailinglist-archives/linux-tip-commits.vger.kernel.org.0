Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 662931CAEDA
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 May 2020 15:16:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728609AbgEHNLq (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 8 May 2020 09:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728171AbgEHNEx (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 8 May 2020 09:04:53 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 326A8C05BD0B;
        Fri,  8 May 2020 06:04:53 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gJ-0007Bp-Tf; Fri, 08 May 2020 15:04:48 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 1B1171C0493;
        Fri,  8 May 2020 15:04:45 +0200 (CEST)
Date:   Fri, 08 May 2020 13:04:45 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evsel: Rename perf_evsel__env() to evsel__env()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894308502.8414.14606444643162583874.tip-bot2@tip-bot2>
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

Commit-ID:     6e6d1d654ecdfd07890f9c0fc30f3222885c7571
Gitweb:        https://git.kernel.org/tip/6e6d1d654ecdfd07890f9c0fc30f3222885c7571
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 04 May 2020 13:44:03 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:31 -03:00

perf evsel: Rename perf_evsel__env() to evsel__env()

As it is a 'struct evsel' method, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-trace.c | 2 +-
 tools/perf/util/annotate.c | 2 +-
 tools/perf/util/evsel.c    | 2 +-
 tools/perf/util/evsel.h    | 2 +-
 tools/perf/util/machine.c  | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/tools/perf/builtin-trace.c b/tools/perf/builtin-trace.c
index 025e190..3157571 100644
--- a/tools/perf/builtin-trace.c
+++ b/tools/perf/builtin-trace.c
@@ -2382,7 +2382,7 @@ static int trace__fprintf_callchain(struct trace *trace, struct perf_sample *sam
 
 static const char *errno_to_name(struct evsel *evsel, int err)
 {
-	struct perf_env *env = perf_evsel__env(evsel);
+	struct perf_env *env = evsel__env(evsel);
 	const char *arch_name = perf_env__arch(env);
 
 	return arch_syscalls__strerrno(arch_name, err);
diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index dc3342f..d828c2d 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -2156,7 +2156,7 @@ int symbol__annotate(struct map_symbol *ms, struct evsel *evsel,
 		.evsel		= evsel,
 		.options	= options,
 	};
-	struct perf_env *env = perf_evsel__env(evsel);
+	struct perf_env *env = evsel__env(evsel);
 	const char *arch_name = perf_env__arch(env);
 	struct arch *arch;
 	int err;
diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index 5908cd8..32d178a 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2563,7 +2563,7 @@ int evsel__open_strerror(struct evsel *evsel, struct target *target,
 			 err, str_error_r(err, sbuf, sizeof(sbuf)), evsel__name(evsel));
 }
 
-struct perf_env *perf_evsel__env(struct evsel *evsel)
+struct perf_env *evsel__env(struct evsel *evsel)
 {
 	if (evsel && evsel->evlist)
 		return evsel->evlist->env;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 9de7efb..d76111c 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -401,7 +401,7 @@ static inline bool evsel__has_br_stack(const struct evsel *evsel)
 	       evsel->synth_sample_type & PERF_SAMPLE_BRANCH_STACK;
 }
 
-struct perf_env *perf_evsel__env(struct evsel *evsel);
+struct perf_env *evsel__env(struct evsel *evsel);
 
 int perf_evsel__store_ids(struct evsel *evsel, struct evlist *evlist);
 #endif /* __PERF_EVSEL_H */
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index da630e9..8ed2135 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2619,7 +2619,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 		chain_nr = chain->nr;
 
 	if (evsel__has_branch_callstack(evsel)) {
-		struct perf_env *env = perf_evsel__env(evsel);
+		struct perf_env *env = evsel__env(evsel);
 
 		err = resolve_lbr_callchain_sample(thread, cursor, sample, parent,
 						   root_al, max_stack,
