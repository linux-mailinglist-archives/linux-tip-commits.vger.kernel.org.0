Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 02880A269F
	for <lists+linux-tip-commits@lfdr.de>; Thu, 29 Aug 2019 21:01:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728162AbfH2TBy (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 29 Aug 2019 15:01:54 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:51321 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727437AbfH2TBy (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 29 Aug 2019 15:01:54 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1i3Pg6-00055D-Ln; Thu, 29 Aug 2019 21:01:50 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 3BF891C0DE6;
        Thu, 29 Aug 2019 21:01:50 +0200 (CEST)
Date:   Thu, 29 Aug 2019 19:01:50 -0000
From:   "tip-bot2 for Namhyung Kim" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf top: Decay all events in the evlist
Cc:     Namhyung Kim <namhyung@kernel.org>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20190827231555.121411-1-namhyung@kernel.org>
References: <20190827231555.121411-1-namhyung@kernel.org>
MIME-Version: 1.0
Message-ID: <156710531015.10535.694740864937088447.tip-bot2@tip-bot2>
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

Commit-ID:     ea4385f804eadce3f4fd8698d4ffd9e85fb6d5e0
Gitweb:        https://git.kernel.org/tip/ea4385f804eadce3f4fd8698d4ffd9e85fb6d5e0
Author:        Namhyung Kim <namhyung@kernel.org>
AuthorDate:    Wed, 28 Aug 2019 08:15:54 +09:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 28 Aug 2019 18:15:03 -03:00

perf top: Decay all events in the evlist

Currently perf top only decays entries in a selected evsel.  I don't
know whether it's intended (maybe due to performance reason?) but anyway
it might show incorrect output when event group is used since users will
see leader event is decayed but others are not.

This patch moves the decay code into perf_top__resort_hists() so that
stdio and TUI code shared the logic.

Signed-off-by: Namhyung Kim <namhyung@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lkml.kernel.org/r/20190827231555.121411-1-namhyung@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/builtin-top.c | 38 +++++++++++++-------------------------
 1 file changed, 13 insertions(+), 25 deletions(-)

diff --git a/tools/perf/builtin-top.c b/tools/perf/builtin-top.c
index 42ba733..104dbb1 100644
--- a/tools/perf/builtin-top.c
+++ b/tools/perf/builtin-top.c
@@ -265,13 +265,23 @@ static void perf_top__show_details(struct perf_top *top)
 	pthread_mutex_unlock(&notes->lock);
 }
 
-static void evlist__resort_hists(struct evlist *evlist)
+static void perf_top__resort_hists(struct perf_top *t)
 {
+	struct evlist *evlist = t->evlist;
 	struct evsel *pos;
 
 	evlist__for_each_entry(evlist, pos) {
 		struct hists *hists = evsel__hists(pos);
 
+		if (evlist->enabled) {
+			if (t->zero) {
+				hists__delete_entries(hists);
+			} else {
+				hists__decay_entries(hists, t->hide_user_symbols,
+						     t->hide_kernel_symbols);
+			}
+		}
+
 		hists__collapse_resort(hists, NULL);
 
 		/* Non-group events are considered as leader */
@@ -320,16 +330,7 @@ static void perf_top__print_sym_table(struct perf_top *top)
 		return;
 	}
 
-	if (top->evlist->enabled) {
-		if (top->zero) {
-			hists__delete_entries(hists);
-		} else {
-			hists__decay_entries(hists, top->hide_user_symbols,
-					     top->hide_kernel_symbols);
-		}
-	}
-
-	evlist__resort_hists(top->evlist);
+	perf_top__resort_hists(top);
 
 	hists__output_recalc_col_len(hists, top->print_entries - printed);
 	putchar('\n');
@@ -577,24 +578,11 @@ static bool perf_top__handle_keypress(struct perf_top *top, int c)
 static void perf_top__sort_new_samples(void *arg)
 {
 	struct perf_top *t = arg;
-	struct evsel *evsel = t->sym_evsel;
-	struct hists *hists;
 
 	if (t->evlist->selected != NULL)
 		t->sym_evsel = t->evlist->selected;
 
-	hists = evsel__hists(evsel);
-
-	if (t->evlist->enabled) {
-		if (t->zero) {
-			hists__delete_entries(hists);
-		} else {
-			hists__decay_entries(hists, t->hide_user_symbols,
-					     t->hide_kernel_symbols);
-		}
-	}
-
-	evlist__resort_hists(t->evlist);
+	perf_top__resort_hists(t);
 
 	if (t->lost || t->drop)
 		pr_warning("Too slow to read ring buffer (change period (-c/-F) or limit CPUs (-C)\n");
