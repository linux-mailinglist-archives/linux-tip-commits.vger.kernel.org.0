Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05D7413755A
	for <lists+linux-tip-commits@lfdr.de>; Fri, 10 Jan 2020 18:56:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728719AbgAJRx1 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 10 Jan 2020 12:53:27 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:59161 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728670AbgAJRx0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 10 Jan 2020 12:53:26 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1ipyTH-0001gX-Fi; Fri, 10 Jan 2020 18:53:19 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 06C6B1C2D52;
        Fri, 10 Jan 2020 18:53:16 +0100 (CET)
Date:   Fri, 10 Jan 2020 17:53:15 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf hists browser: Generalize the do_zoom_dso() function
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@intel.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <tip-ae9cjel6v05wjnz9r6z77b6x@git.kernel.org>
References: <tip-ae9cjel6v05wjnz9r6z77b6x@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157867879588.30329.18089380547917073763.tip-bot2@tip-bot2>
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

Commit-ID:     632003f400d341592b6af8d96bd83b74a0329fe3
Gitweb:        https://git.kernel.org/tip/632003f400d341592b6af8d96bd83b74a0329fe3
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Thu, 12 Dec 2019 11:55:54 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Mon, 06 Jan 2020 11:46:10 -03:00

perf hists browser: Generalize the do_zoom_dso() function

We'll use it to provide a top level hotkey to zoom into the kernel dso
directly.

Reviewed-by: Jiri Olsa <jolsa@kernel.org>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jin Yao <yao.jin@linux.intel.com>
Cc: Kan Liang <kan.liang@intel.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-ae9cjel6v05wjnz9r6z77b6x@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/ui/browsers/hists.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/tools/perf/ui/browsers/hists.c b/tools/perf/ui/browsers/hists.c
index a4413d9..8aba1ae 100644
--- a/tools/perf/ui/browsers/hists.c
+++ b/tools/perf/ui/browsers/hists.c
@@ -2530,11 +2530,8 @@ add_thread_opt(struct hist_browser *browser, struct popup_action *act,
 	return 1;
 }
 
-static int
-do_zoom_dso(struct hist_browser *browser, struct popup_action *act)
+static int hists_browser__zoom_map(struct hist_browser *browser, struct map *map)
 {
-	struct map *map = act->ms.map;
-
 	if (!hists__has(browser->hists, dso) || map == NULL)
 		return 0;
 
@@ -2557,6 +2554,12 @@ do_zoom_dso(struct hist_browser *browser, struct popup_action *act)
 }
 
 static int
+do_zoom_dso(struct hist_browser *browser, struct popup_action *act)
+{
+	return hists_browser__zoom_map(browser, act->ms.map);
+}
+
+static int
 add_dso_opt(struct hist_browser *browser, struct popup_action *act,
 	    char **optstr, struct map *map)
 {
