Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2E6A41B4420
	for <lists+linux-tip-commits@lfdr.de>; Wed, 22 Apr 2020 14:17:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727882AbgDVMR3 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 22 Apr 2020 08:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726110AbgDVMR2 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 22 Apr 2020 08:17:28 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88BD4C03C1A9;
        Wed, 22 Apr 2020 05:17:28 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jREJd-0007jA-MV; Wed, 22 Apr 2020 14:17:21 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 168401C04D7;
        Wed, 22 Apr 2020 14:17:20 +0200 (CEST)
Date:   Wed, 22 Apr 2020 12:17:19 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evlist: Allow multiple read formats
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200401101613.6201-16-adrian.hunter@intel.com>
References: <20200401101613.6201-16-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <158755783969.28353.16994734516402400838.tip-bot2@tip-bot2>
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

Commit-ID:     94d3820f2e18d3c88f833baec8d6ad5b3489fa59
Gitweb:        https://git.kernel.org/tip/94d3820f2e18d3c88f833baec8d6ad5b3489fa59
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Wed, 01 Apr 2020 13:16:12 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Sat, 18 Apr 2020 09:05:00 -03:00

perf evlist: Allow multiple read formats

Tools find the correct evsel, and therefore read format, using the event
ID, so it isn't necessary for all read formats to be the same. In the
case of leader-sampling of AUX area events, dummy tracking events will
have a different read format, so relax the validation to become a debug
message only.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200401101613.6201-16-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evlist.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evlist.c b/tools/perf/util/evlist.c
index 1548237..82d9f9b 100644
--- a/tools/perf/util/evlist.c
+++ b/tools/perf/util/evlist.c
@@ -1131,8 +1131,10 @@ bool perf_evlist__valid_read_format(struct evlist *evlist)
 	u64 sample_type = first->core.attr.sample_type;
 
 	evlist__for_each_entry(evlist, pos) {
-		if (read_format != pos->core.attr.read_format)
-			return false;
+		if (read_format != pos->core.attr.read_format) {
+			pr_debug("Read format differs %#" PRIx64 " vs %#" PRIx64 "\n",
+				 read_format, (u64)pos->core.attr.read_format);
+		}
 	}
 
 	/* PERF_SAMPLE_READ imples PERF_FORMAT_ID. */
