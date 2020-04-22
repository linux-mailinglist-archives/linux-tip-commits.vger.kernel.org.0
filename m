Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BB2641B44E6
	for <lists+linux-tip-commits@lfdr.de>; Wed, 22 Apr 2020 14:22:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726060AbgDVMWT (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Wed, 22 Apr 2020 08:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728755AbgDVMRm (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Wed, 22 Apr 2020 08:17:42 -0400
Received: from Galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD9DC03C1A8;
        Wed, 22 Apr 2020 05:17:41 -0700 (PDT)
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jREJl-0007qC-9I; Wed, 22 Apr 2020 14:17:29 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 7B5611C0809;
        Wed, 22 Apr 2020 14:17:25 +0200 (CEST)
Date:   Wed, 22 Apr 2020 12:17:25 -0000
From:   "tip-bot2 for Adrian Hunter" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf cs-etm: Implement ->evsel_is_auxtrace() callback
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@redhat.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200401101613.6201-6-adrian.hunter@intel.com>
References: <20200401101613.6201-6-adrian.hunter@intel.com>
MIME-Version: 1.0
Message-ID: <158755784506.28353.8721773656438110928.tip-bot2@tip-bot2>
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

Commit-ID:     a58ab57caad02b0d854969e191b5d1d4b0f90930
Gitweb:        https://git.kernel.org/tip/a58ab57caad02b0d854969e191b5d1d4b0f90930
Author:        Adrian Hunter <adrian.hunter@intel.com>
AuthorDate:    Wed, 01 Apr 2020 13:16:02 +03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 16 Apr 2020 12:19:15 -03:00

perf cs-etm: Implement ->evsel_is_auxtrace() callback

Implement ->evsel_is_auxtrace() callback.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Link: http://lore.kernel.org/lkml/20200401101613.6201-6-adrian.hunter@intel.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/cs-etm.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/perf/util/cs-etm.c b/tools/perf/util/cs-etm.c
index 62d2f9b..3c802fd 100644
--- a/tools/perf/util/cs-etm.c
+++ b/tools/perf/util/cs-etm.c
@@ -631,6 +631,16 @@ static void cs_etm__free(struct perf_session *session)
 	zfree(&aux);
 }
 
+static bool cs_etm__evsel_is_auxtrace(struct perf_session *session,
+				      struct evsel *evsel)
+{
+	struct cs_etm_auxtrace *aux = container_of(session->auxtrace,
+						   struct cs_etm_auxtrace,
+						   auxtrace);
+
+	return evsel->core.attr.type == aux->pmu_type;
+}
+
 static u8 cs_etm__cpu_mode(struct cs_etm_queue *etmq, u64 address)
 {
 	struct machine *machine;
@@ -2618,6 +2628,7 @@ int cs_etm__process_auxtrace_info(union perf_event *event,
 	etm->auxtrace.flush_events = cs_etm__flush_events;
 	etm->auxtrace.free_events = cs_etm__free_events;
 	etm->auxtrace.free = cs_etm__free;
+	etm->auxtrace.evsel_is_auxtrace = cs_etm__evsel_is_auxtrace;
 	session->auxtrace = &etm->auxtrace;
 
 	etm->unknown_thread = thread__new(999999999, 999999999);
