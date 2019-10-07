Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E7F74CE5AA
	for <lists+linux-tip-commits@lfdr.de>; Mon,  7 Oct 2019 16:49:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728406AbfJGOte (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Mon, 7 Oct 2019 10:49:34 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:44385 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728452AbfJGOtd (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Mon, 7 Oct 2019 10:49:33 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iHUK2-0005v2-Pw; Mon, 07 Oct 2019 16:49:14 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 727B11C079B;
        Mon,  7 Oct 2019 16:49:14 +0200 (CEST)
Date:   Mon, 07 Oct 2019 14:49:14 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf annotate: Return appropriate error code for
 allocation failures
Cc:     "Russell King - ARM Linux admin" <linux@armlinux.org.uk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-8of1cmj3rz0mppfcshc9bbqq@git.kernel.org>
References: <tip-8of1cmj3rz0mppfcshc9bbqq@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157045975441.9978.2180663668706177001.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     16ed3c1e91159e28b02f11f71ff4ce4cbc6f99e4
Gitweb:        https://git.kernel.org/tip/16ed3c1e91159e28b02f11f71ff4ce4cbc6f99e4
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 30 Sep 2019 15:53:33 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 30 Sep 2019 17:30:04 -03:00

perf annotate: Return appropriate error code for allocation failures

We should return errno or the annotation extra range understood by
symbol__strerror_disassemble() instead of -1, fix it, returning ENOMEM
instead.

Reported-by: Russell King - ARM Linux admin <linux@armlinux.org.uk>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>,
Cc: Will Deacon <will@kernel.org>
Link: https://lkml.kernel.org/n/tip-8of1cmj3rz0mppfcshc9bbqq@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/annotate.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/annotate.c b/tools/perf/util/annotate.c
index dc15352..b49ecdd 100644
--- a/tools/perf/util/annotate.c
+++ b/tools/perf/util/annotate.c
@@ -1668,7 +1668,7 @@ static int dso__disassemble_filename(struct dso *dso, char *filename, size_t fil
 
 	build_id_path = strdup(filename);
 	if (!build_id_path)
-		return -1;
+		return ENOMEM;
 
 	/*
 	 * old style build-id cache has name of XX/XXXXXXX.. while
@@ -2977,7 +2977,7 @@ int symbol__annotate2(struct symbol *sym, struct map *map, struct evsel *evsel,
 
 	notes->offsets = zalloc(size * sizeof(struct annotation_line *));
 	if (notes->offsets == NULL)
-		return -1;
+		return ENOMEM;
 
 	if (perf_evsel__is_group_event(evsel))
 		nr_pcnt = evsel->core.nr_members;
