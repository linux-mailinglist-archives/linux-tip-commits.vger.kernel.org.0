Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EE1AA909C6
	for <lists+linux-tip-commits@lfdr.de>; Fri, 16 Aug 2019 22:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727637AbfHPUz7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 16 Aug 2019 16:55:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:43967 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727589AbfHPUz7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 16 Aug 2019 16:55:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7GKtqNC2959986
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Fri, 16 Aug 2019 13:55:52 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7GKtqNC2959986
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565988953;
        bh=4sEqVcEsymt42gK9JBnVxDODfzRKFQClWToB8diSlGU=;
        h=Date:From:Cc:Reply-To:To:Subject:From;
        b=qUtctX/4jSQyXH16x3vBbD0zI9RBOl1/bRy0+Rr29qiDRc0cRnSgvRR+EnbBy+N3P
         xZSEbyMvdUANXjBFEo+lt0oOXFKADIuBDmmMauwe+4IFRqn2D0Zyi3WEnAylWC2atI
         ZdXsiMu9/IMdFn9lP1WfHUFa6OHvo9sd4Hx1BeaC0D9A6PE26F4LBxC8BEO3dx3sKt
         q5V2grz7w1YF/PDwsys4pBQ0hHwCt9Zj/8+3VybuETDQ3GpS+d8/JmBVNTvanDX4g8
         7V/mBsC1wmwnK8UsunKgO6mLGfyHKwmss6e4euN2lQ9yD4imn8dIQUiTLgCw9LqcLW
         GqK6NN3VV5EkA==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7GKtqYT2959983;
        Fri, 16 Aug 2019 13:55:52 -0700
Date:   Fri, 16 Aug 2019 13:55:52 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Arnaldo Carvalho de Melo <tipbot@zytor.com>
Message-ID: <tip-1kvrdi7weuz3hxycwvarcu6v@git.kernel.org>
Cc:     namhyung@kernel.org, mingo@kernel.org, jolsa@kernel.org,
        tglx@linutronix.de, linux-kernel@vger.kernel.org,
        fweimer@redhat.com, hpa@zytor.com, wcohen@redhat.com,
        adrian.hunter@intel.com, acme@redhat.com
Reply-To: linux-kernel@vger.kernel.org, tglx@linutronix.de,
          fweimer@redhat.com, wcohen@redhat.com, hpa@zytor.com,
          acme@redhat.com, adrian.hunter@intel.com, namhyung@kernel.org,
          jolsa@kernel.org, mingo@kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf evswitch: Move enoent error message printing
 to separate function
Git-Commit-ID: c9a4269930dada68971a4a97f3abf079af8cde4e
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot.git.kernel.org>
Robot-Unsubscribe: Contact <mailto:hpa@kernel.org> to get blacklisted from
 these emails
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=UTF-8
Content-Disposition: inline
X-Spam-Status: No, score=-0.2 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        DATE_IN_FUTURE_96_Q,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF
        autolearn=no autolearn_force=no version=3.4.2
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on terminus.zytor.com
Sender: linux-tip-commits-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-tip-commits.vger.kernel.org>
X-Mailing-List: linux-tip-commits@vger.kernel.org

Commit-ID:  c9a4269930dada68971a4a97f3abf079af8cde4e
Gitweb:     https://git.kernel.org/tip/c9a4269930dada68971a4a97f3abf079af8cde4e
Author:     Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate: Thu, 15 Aug 2019 11:35:56 -0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Thu, 15 Aug 2019 12:26:04 -0300

perf evswitch: Move enoent error message printing to separate function

Allows adding hints there, will be done in followup patch.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Florian Weimer <fweimer@redhat.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: William Cohen <wcohen@redhat.com>
Link: https://lkml.kernel.org/n/tip-1kvrdi7weuz3hxycwvarcu6v@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/evswitch.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/evswitch.c b/tools/perf/util/evswitch.c
index b57b5f0816f5..71daed615a2c 100644
--- a/tools/perf/util/evswitch.c
+++ b/tools/perf/util/evswitch.c
@@ -31,12 +31,17 @@ bool evswitch__discard(struct evswitch *evswitch, struct evsel *evsel)
 	return false;
 }
 
+static int evswitch__fprintf_enoent(FILE *fp, const char *evtype, const char *evname)
+{
+	return fprintf(fp, "ERROR: switch-%s event not found (%s)\n", evtype, evname);
+}
+
 int evswitch__init(struct evswitch *evswitch, struct evlist *evlist, FILE *fp)
 {
 	if (evswitch->on_name) {
 		evswitch->on = perf_evlist__find_evsel_by_str(evlist, evswitch->on_name);
 		if (evswitch->on == NULL) {
-			fprintf(fp, "switch-on event not found (%s)\n", evswitch->on_name);
+			evswitch__fprintf_enoent(fp, "on", evswitch->on_name);
 			return -ENOENT;
 		}
 		evswitch->discarding = true;
@@ -45,7 +50,7 @@ int evswitch__init(struct evswitch *evswitch, struct evlist *evlist, FILE *fp)
 	if (evswitch->off_name) {
 		evswitch->off = perf_evlist__find_evsel_by_str(evlist, evswitch->off_name);
 		if (evswitch->off == NULL) {
-			fprintf(fp, "switch-off event not found (%s)\n", evswitch->off_name);
+			evswitch__fprintf_enoent(fp, "off", evswitch->off_name);
 			return -ENOENT;
 		}
 	}
