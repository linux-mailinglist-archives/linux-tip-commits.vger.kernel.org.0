Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4EC221B44E5
	for <lists+linux-tip-commits@lfdr.de>; Wed, 22 Apr 2020 14:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728268AbgDVMWT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 22 Apr 2020 08:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728736AbgDVMRk (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 22 Apr 2020 08:17:40 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C30DEC03C1A8;
        Wed, 22 Apr 2020 05:17:40 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jREJr-0007qm-4l; Wed, 22 Apr 2020 14:17:35 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6929A1C0820;
        Wed, 22 Apr 2020 14:17:26 +0200 (CEST)
Date:   Wed, 22 Apr 2020 12:17:26 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf intel-bts: Implement ->evsel_is_auxtrace() callback
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200401101613.6201-4-adrian.hunter@intel.com>
References: <20200401101613.6201-4-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <158755784604.28353.17477698557383210733.tip-bot2@tip-bot2>
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

Commit-ID:     966246f597deafbcb1d8c126865b4efdc2be776e
Gitweb:        https://git.kernel.org/tip/966246f597deafbcb1d8c126865b4efdc2be776e
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Wed, 01 Apr 2020 13:16:00 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 16 Apr 2020 12:19:15 -03:00

perf intel-bts: Implement ->evsel_is_auxtrace() callback

Implement ->evsel_is_auxtrace() callback.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200401101613.6201-4-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/intel-bts.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/tools/perf/util/intel-bts.c b/tools/perf/util/intel-bts.c
index 34cb380..059e1c8 100644
--- a/tools/perf/util/intel-bts.c
+++ b/tools/perf/util/intel-bts.c
@@ -728,6 +728,15 @@ static void intel_bts_free(struct perf_session *session)
 	free(bts);
 }
 
+static bool intel_bts_evsel_is_auxtrace(struct perf_session *session,
+					struct evsel *evsel)
+{
+	struct intel_bts *bts = container_of(session->auxtrace, struct intel_bts,
+					     auxtrace);
+
+	return evsel->core.attr.type == bts->pmu_type;
+}
+
 struct intel_bts_synth {
 	struct perf_tool dummy_tool;
 	struct perf_session *session;
@@ -883,6 +892,7 @@ int intel_bts_process_auxtrace_info(union perf_event *event,
 	bts->auxtrace.flush_events = intel_bts_flush;
 	bts->auxtrace.free_events = intel_bts_free_events;
 	bts->auxtrace.free = intel_bts_free;
+	bts->auxtrace.evsel_is_auxtrace = intel_bts_evsel_is_auxtrace;
 	session->auxtrace = &bts->auxtrace;
 
 	intel_bts_print_info(&auxtrace_info->priv[0], INTEL_BTS_PMU_TYPE,
