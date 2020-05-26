Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FBB91CAED5
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 May 2020 15:16:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728300AbgEHNL0 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 8 May 2020 09:11:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729062AbgEHNE5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 8 May 2020 09:04:57 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 974E6C05BD43;
        Fri,  8 May 2020 06:04:56 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gN-0007DK-RO; Fri, 08 May 2020 15:04:52 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 4461C1C04D3;
        Fri,  8 May 2020 15:04:46 +0200 (CEST)
Date:   Fri, 08 May 2020 13:04:46 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evsel: Rename perf_evsel__has*() to evsel__has*()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Message-ID: <158894308623.8414.14162569786716266032.tip-bot2@tip-bot2>
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

Commit-ID:     4f138a9e08a9635ab2b243c1970308766fd14918
Gitweb:        https://git.kernel.org/tip/4f138a9e08a9635ab2b243c1970308766fd14918
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 30 Apr 2020 11:19:45 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:31 -03:00

perf evsel: Rename perf_evsel__has*() to evsel__has*()

As those are 'struct evsel' methods, not part of tools/lib/perf/, aka
libperf, to whom the perf_ prefix belongs.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.c   | 2 +-
 tools/perf/util/evsel.h   | 4 ++--
 tools/perf/util/machine.c | 2 +-
 tools/perf/util/session.c | 4 ++--
 4 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/evsel.c b/tools/perf/util/evsel.c
index b63d9ee..909e993 100644
--- a/tools/perf/util/evsel.c
+++ b/tools/perf/util/evsel.c
@@ -2159,7 +2159,7 @@ int evsel__parse_sample(struct evsel *evsel, union perf_event *event,
 			return -EFAULT;
 
 		sz = data->branch_stack->nr * sizeof(struct branch_entry);
-		if (perf_evsel__has_branch_hw_idx(evsel))
+		if (evsel__has_branch_hw_idx(evsel))
 			sz += sizeof(u64);
 		else
 			data->no_hw_idx = true;
diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index a84a4f6..101cfff 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -372,12 +372,12 @@ for ((_evsel) = _leader; 							\
      (_evsel) && (_evsel)->leader == (_leader);					\
      (_evsel) = list_entry((_evsel)->core.node.next, struct evsel, core.node))
 
-static inline bool perf_evsel__has_branch_callstack(const struct evsel *evsel)
+static inline bool evsel__has_branch_callstack(const struct evsel *evsel)
 {
 	return evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_CALL_STACK;
 }
 
-static inline bool perf_evsel__has_branch_hw_idx(const struct evsel *evsel)
+static inline bool evsel__has_branch_hw_idx(const struct evsel *evsel)
 {
 	return evsel->core.attr.branch_sample_type & PERF_SAMPLE_BRANCH_HW_INDEX;
 }
diff --git a/tools/perf/util/machine.c b/tools/perf/util/machine.c
index 5ac32ca..da630e9 100644
--- a/tools/perf/util/machine.c
+++ b/tools/perf/util/machine.c
@@ -2618,7 +2618,7 @@ static int thread__resolve_callchain_sample(struct thread *thread,
 	if (chain)
 		chain_nr = chain->nr;
 
-	if (perf_evsel__has_branch_callstack(evsel)) {
+	if (evsel__has_branch_callstack(evsel)) {
 		struct perf_env *env = perf_evsel__env(evsel);
 
 		err = resolve_lbr_callchain_sample(thread, cursor, sample, parent,
diff --git a/tools/perf/util/session.c b/tools/perf/util/session.c
index 7f7d3a1..c11d89e 100644
--- a/tools/perf/util/session.c
+++ b/tools/perf/util/session.c
@@ -1059,7 +1059,7 @@ static void callchain__printf(struct evsel *evsel,
 	unsigned int i;
 	struct ip_callchain *callchain = sample->callchain;
 
-	if (perf_evsel__has_branch_callstack(evsel))
+	if (evsel__has_branch_callstack(evsel))
 		callchain__lbr_callstack_printf(sample);
 
 	printf("... FP chain: nr:%" PRIu64 "\n", callchain->nr);
@@ -1244,7 +1244,7 @@ static void dump_sample(struct evsel *evsel, union perf_event *event,
 		callchain__printf(evsel, sample);
 
 	if (evsel__has_br_stack(evsel))
-		branch_stack__printf(sample, perf_evsel__has_branch_callstack(evsel));
+		branch_stack__printf(sample, evsel__has_branch_callstack(evsel));
 
 	if (sample_type & PERF_SAMPLE_REGS_USER)
 		regs_user__printf(sample);
