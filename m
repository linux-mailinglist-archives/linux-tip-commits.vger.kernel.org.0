Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6B7A71CAE55
	for <lists+linux-tip-commits@lfdr.de>; Fri,  8 May 2020 15:11:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728556AbgEHNI4 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 8 May 2020 09:08:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730513AbgEHNF0 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 8 May 2020 09:05:26 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94918C05BD43;
        Fri,  8 May 2020 06:05:26 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jX2gm-0007da-Uq; Fri, 08 May 2020 15:05:17 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 2EE5E1C0859;
        Fri,  8 May 2020 15:05:03 +0200 (CEST)
Date:   Fri, 08 May 2020 13:05:03 -0000
From:   "tip-bot2 for He Zhe" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] libperf: Add NULL pointer check for cpu_map
 iteration and NULL assignment for all_cpus.
Cc:     He Zhe <zhe.he@windriver.com>, Jiri Olsa <jolsa@kernel.org>,
        Andi Kleen <ak@linux.intel.com>, Kyle Meyer <meyerk@hpe.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1583665157-349023-1-git-send-email-zhe.he@windriver.com>
References: <1583665157-349023-1-git-send-email-zhe.he@windriver.com>
MIME-Version: 1.0
Message-ID: <158894310315.8414.14232504007074036765.tip-bot2@tip-bot2>
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

Commit-ID:     44d041b7b2c11b6739501fd3763cc6fed62cf0ed
Gitweb:        https://git.kernel.org/tip/44d041b7b2c11b6739501fd3763cc6fed62cf0ed
Author:        He Zhe <zhe.he@windriver.com>
AuthorDate:    Sun, 08 Mar 2020 18:59:17 +08:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Tue, 05 May 2020 16:35:29 -03:00

libperf: Add NULL pointer check for cpu_map iteration and NULL assignment for all_cpus.

A NULL pointer may be passed to perf_cpu_map__cpu and then cause a
crash, such as the one commit cb71f7d43ece ("libperf: Setup initial
evlist::all_cpus value") fix.

Signed-off-by: He Zhe <zhe.he@windriver.com>
Acked-by: Jiri Olsa <jolsa@kernel.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Kyle Meyer <meyerk@hpe.com>
Link: http://lore.kernel.org/lkml/1583665157-349023-1-git-send-email-zhe.he@windriver.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/lib/perf/cpumap.c | 2 +-
 tools/lib/perf/evlist.c | 1 +
 2 files changed, 2 insertions(+), 1 deletion(-)

diff --git a/tools/lib/perf/cpumap.c b/tools/lib/perf/cpumap.c
index f93f4e7..ca02150 100644
--- a/tools/lib/perf/cpumap.c
+++ b/tools/lib/perf/cpumap.c
@@ -247,7 +247,7 @@ out:
 
 int perf_cpu_map__cpu(const struct perf_cpu_map *cpus, int idx)
 {
-	if (idx < cpus->nr)
+	if (cpus && idx < cpus->nr)
 		return cpus->map[idx];
 
 	return -1;
diff --git a/tools/lib/perf/evlist.c b/tools/lib/perf/evlist.c
index def5505..c481b62 100644
--- a/tools/lib/perf/evlist.c
+++ b/tools/lib/perf/evlist.c
@@ -125,6 +125,7 @@ void perf_evlist__exit(struct perf_evlist *evlist)
 	perf_cpu_map__put(evlist->cpus);
 	perf_thread_map__put(evlist->threads);
 	evlist->cpus = NULL;
+	evlist->all_cpus = NULL;
 	evlist->threads = NULL;
 	fdarray__exit(&evlist->pollfd);
 }
