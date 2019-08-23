Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 911899A578
	for <lists+linux-tip-commits@lfdr.de>; Fri, 23 Aug 2019 04:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390240AbfHWC2M (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 22 Aug 2019 22:28:12 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:33780 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389611AbfHWC2L (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 22 Aug 2019 22:28:11 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i0zJ8-00018M-Tc; Fri, 23 Aug 2019 04:28:07 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 5FD7F1C0883;
        Fri, 23 Aug 2019 04:28:06 +0200 (CEST)
Date:   Fri, 23 Aug 2019 02:28:06 -0000
From:   tip-bot2 for Arnaldo Carvalho de Melo <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf top: Show info message while collecting samples
Cc:     linux-kernel@vger.kernel.org,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>
In-Reply-To: <tip-xcui60p1v6ozijfam2o89ya8@git.kernel.org>
References: <tip-xcui60p1v6ozijfam2o89ya8@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156652728629.12687.5301871982730827427.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from
 these emails
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

The following commit has been merged into the perf/core branch of tip:

Commit-ID:     5c959b6d8f9369e42a3cb0423bcce9ac069cee55
Gitweb:        https://git.kernel.org/tip/5c959b6d8f9369e42a3cb0423bcce9ac069cee55
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Mon, 19 Aug 2019 16:48:25 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 20 Aug 2019 12:22:39 -03:00

perf top: Show info message while collecting samples

Give visual cue about what is happening while initially collecting the
minimal set of samples to collect/sort/display.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-xcui60p1v6ozijfam2o89ya8@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index b195b1b..30547fd 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2894,6 +2894,9 @@ static int perf_evsel__hists_browse(struct evsel *evsel, int nr_events,
 	if (symbol_conf.col_width_list_str)
 		perf_hpp__set_user_width(symbol_conf.col_width_list_str);
 
+	if (!is_report_browser(hbt))
+		browser->b.no_samples_msg = "Collecting samples...";
+
 	while (1) {
 		struct thread *thread = NULL;
 		struct map *map = NULL;
