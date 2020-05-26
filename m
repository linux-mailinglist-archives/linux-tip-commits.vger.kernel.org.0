Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 310EF1B441D
	for <lists+linux-tip-commits@lfdr.de>; Wed, 22 Apr 2020 14:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728540AbgDVMRc (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 22 Apr 2020 08:17:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728202AbgDVMRa (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 22 Apr 2020 08:17:30 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BD05C03C1A9;
        Wed, 22 Apr 2020 05:17:30 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jREJg-0007lQ-L1; Wed, 22 Apr 2020 14:17:24 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 692781C0809;
        Wed, 22 Apr 2020 14:17:22 +0200 (CEST)
Date:   Wed, 22 Apr 2020 12:17:22 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf evsel: Add support for synthesized sample type
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200401101613.6201-11-adrian.hunter@intel.com>
References: <20200401101613.6201-11-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <158755784205.28353.2280122449890986259.tip-bot2@tip-bot2>
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

Commit-ID:     e11869a065e36f3d22a575ccfb1097c262bb4f6e
Gitweb:        https://git.kernel.org/tip/e11869a065e36f3d22a575ccfb1097c262bb4f6e
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Wed, 01 Apr 2020 13:16:07 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 16 Apr 2020 12:19:17 -03:00

perf evsel: Add support for synthesized sample type

For reporting purposes, an evsel sample can have a callchain synthesized
from AUX area data. Add support for keeping track of synthesized sample
types. Note, the recorded sample_type cannot be changed because it is
needed to continue to parse events.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200401101613.6201-11-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evsel.h | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/evsel.h b/tools/perf/util/evsel.h
index 53187c5..e64ed42 100644
--- a/tools/perf/util/evsel.h
+++ b/tools/perf/util/evsel.h
@@ -104,6 +104,14 @@ struct evsel {
 		perf_evsel__sb_cb_t	*cb;
 		void			*data;
 	} side_band;
+	/*
+	 * For reporting purposes, an evsel sample can have a callchain
+	 * synthesized from AUX area data. Keep track of synthesized sample
+	 * types here. Note, the recorded sample_type cannot be changed because
+	 * it is needed to continue to parse events.
+	 * See also evsel__has_callchain().
+	 */
+	__u64			synth_sample_type;
 };
 
 struct perf_missing_features {
@@ -398,7 +406,12 @@ static inline bool perf_evsel__has_branch_hw_idx(const struct evsel *evsel)
 
 static inline bool evsel__has_callchain(const struct evsel *evsel)
 {
-	return (evsel->core.attr.sample_type & PERF_SAMPLE_CALLCHAIN) != 0;
+	/*
+	 * For reporting purposes, an evsel sample can have a recorded callchain
+	 * or a callchain synthesized from AUX area data.
+	 */
+	return evsel->core.attr.sample_type & PERF_SAMPLE_CALLCHAIN ||
+	       evsel->synth_sample_type & PERF_SAMPLE_CALLCHAIN;
 }
 
 struct perf_env *perf_evsel__env(struct evsel *evsel);
