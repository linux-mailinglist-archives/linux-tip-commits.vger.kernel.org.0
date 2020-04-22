Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 32EC91B44F8
	for <lists+linux-tip-commits@lfdr.de>; Wed, 22 Apr 2020 14:23:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728147AbgDVMR3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 22 Apr 2020 08:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726557AbgDVMR2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 22 Apr 2020 08:17:28 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93F36C03C1AB;
        Wed, 22 Apr 2020 05:17:28 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jREJf-0007jp-8u; Wed, 22 Apr 2020 14:17:23 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 94FC61C0451;
        Wed, 22 Apr 2020 14:17:20 +0200 (CEST)
Date:   Wed, 22 Apr 2020 12:17:20 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evsel: Rearrange perf_evsel__config_leader_sampling()
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200401101613.6201-15-adrian.hunter@intel.com>
References: <20200401101613.6201-15-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <158755784015.28353.12868145634316707518.tip-bot2@tip-bot2>
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

Commit-ID:     3713eb371c873e6bed713d78f1bdd5e8be0764a3
Gitweb:        https://git.kernel.org/tip/3713eb371c873e6bed713d78f1bdd5e8be0764a3
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Wed, 01 Apr 2020 13:16:11 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 18 Apr 2020 09:05:00 -03:00

perf evsel: Rearrange perf_evsel__config_leader_sampling()

In preparation for adding support for leader sampling with AUX area events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200401101613.6201-15-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/record.c | 26 +++++++++++++-------------
 1 file changed, 13 insertions(+), 13 deletions(-)

diff --git a/tools/perf/util/record.c b/tools/perf/util/record.c
index 8870ae4..32aeeb8 100644
--- a/tools/perf/util/record.c
+++ b/tools/perf/util/record.c
@@ -172,24 +172,24 @@ static void perf_evsel__config_leader_sampling(struct evsel *evsel)
 	struct perf_event_attr *attr = &evsel->core.attr;
 	struct evsel *leader = evsel->leader;
 
+	if (leader == evsel || !leader->sample_read)
+		return;
+
 	/*
 	 * Disable sampling for all group members other
 	 * than leader in case leader 'leads' the sampling.
 	 */
-	if (leader != evsel && leader->sample_read) {
-		attr->freq           = 0;
-		attr->sample_freq    = 0;
-		attr->sample_period  = 0;
-		attr->write_backward = 0;
+	attr->freq           = 0;
+	attr->sample_freq    = 0;
+	attr->sample_period  = 0;
+	attr->write_backward = 0;
 
-		/*
-		 * We don't get sample for slave events, we make them
-		 * when delivering group leader sample. Set the slave
-		 * event to follow the master sample_type to ease up
-		 * report.
-		 */
-		attr->sample_type = leader->core.attr.sample_type;
-	}
+	/*
+	 * We don't get a sample for slave events, we make them when delivering
+	 * the group leader sample. Set the slave event to follow the master
+	 * sample_type to ease up reporting.
+	 */
+	attr->sample_type = leader->core.attr.sample_type;
 }
 
 void perf_evlist__config(struct evlist *evlist, struct record_opts *opts,
