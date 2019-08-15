Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5BBAF8E84D
	for <lists+linux-tip-commits@lfdr.de>; Thu, 15 Aug 2019 11:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731034AbfHOJb7 (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Thu, 15 Aug 2019 05:31:59 -0400
Received: from terminus.zytor.com ([198.137.202.136]:59075 "EHLO
        terminus.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbfHOJb7 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Thu, 15 Aug 2019 05:31:59 -0400
Received: from terminus.zytor.com (localhost [127.0.0.1])
        by terminus.zytor.com (8.15.2/8.15.2) with ESMTPS id x7F9Ulo82274336
        (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NO);
        Thu, 15 Aug 2019 02:30:47 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 terminus.zytor.com x7F9Ulo82274336
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019071901; t=1565861448;
        bh=ryK/i0opVEjqljhEhP68pSxQuEjiS3PvWgpRKu4s5ok=;
        h=Date:From:Cc:Reply-To:In-Reply-To:References:To:Subject:From;
        b=rb0E/5V9EvXnBe8SOu5pJE2nIgSUCtU6+WJmVB2yZxhHJcl3TLgFbTO8+nZsKAfoy
         GP9MNTPU1wwZaSzTjqolKYwxXJ4M2eU0VpHZtnvaxXiRWqbiz/MXgkz+f4rTJrreb4
         B+n866Ho79ROiZPJCd/o0rHANDf2cEwSYdx2EL8y0+iWzkkRO9+tBjTTzKYw+9jxtj
         eaul/T1DDOh7R5K8ub8O/0kKog9O4dox/uYb57ywcqWY9MwLpsvy4VE3Yd7KtbltHW
         7hOWIMiKkfUJmrQ2l/0K7t5Bzu0nTvkYgENKrG5Uh8liPNRVmtZxBBm88zuisr+/lF
         +lJZvKM21JBvw==
Received: (from tipbot@localhost)
        by terminus.zytor.com (8.15.2/8.15.2/Submit) id x7F9Ukax2274333;
        Thu, 15 Aug 2019 02:30:46 -0700
Date:   Thu, 15 Aug 2019 02:30:46 -0700
X-Authentication-Warning: terminus.zytor.com: tipbot set sender to tipbot@zytor.com using -f
From:   tip-bot for Adrian Hunter <tipbot@zytor.com>
Message-ID: <tip-181ebb5e23a5e480f6d6aa2816a9c4aaa65afa59@git.kernel.org>
Cc:     hpa@zytor.com, linux-kernel@vger.kernel.org, namhyung@kernel.org,
        peterz@infradead.org, acme@redhat.com, kan.liang@linux.intel.com,
        jolsa@kernel.org, tglx@linutronix.de,
        alexander.shishkin@linux.intel.com, adrian.hunter@intel.com,
        mingo@kernel.org
Reply-To: alexander.shishkin@linux.intel.com, kan.liang@linux.intel.com,
          jolsa@kernel.org, acme@redhat.com, namhyung@kernel.org,
          mingo@kernel.org, adrian.hunter@intel.com, tglx@linutronix.de,
          peterz@infradead.org, linux-kernel@vger.kernel.org, hpa@zytor.com
In-Reply-To: <20190806084606.4021-5-alexander.shishkin@linux.intel.com>
References: <20190806084606.4021-5-alexander.shishkin@linux.intel.com>
To:     linux-tip-commits@vger.kernel.org
Subject: [tip:perf/core] perf tools: Add itrace option 'o' to synthesize
 aux-output events
Git-Commit-ID: 181ebb5e23a5e480f6d6aa2816a9c4aaa65afa59
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

Commit-ID:  181ebb5e23a5e480f6d6aa2816a9c4aaa65afa59
Gitweb:     https://git.kernel.org/tip/181ebb5e23a5e480f6d6aa2816a9c4aaa65afa59
Author:     Adrian Hunter <adrian.hunter@intel.com>
AuthorDate: Tue, 6 Aug 2019 11:46:03 +0300
Committer:  Arnaldo Carvalho de Melo <acme@redhat.com>
CommitDate: Wed, 14 Aug 2019 10:59:59 -0300

perf tools: Add itrace option 'o' to synthesize aux-output events

Add itrace option 'o' to synthesize events recorded in the AUX area due
to the use of perf record's aux-output config term.

Signed-off-by: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lkml.kernel.org/r/20190806084606.4021-5-alexander.shishkin@linux.intel.com
Signed-off-by: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/Documentation/itrace.txt | 2 ++
 tools/perf/util/auxtrace.c          | 4 ++++
 tools/perf/util/auxtrace.h          | 3 +++
 3 files changed, 9 insertions(+)

diff --git a/tools/perf/Documentation/itrace.txt b/tools/perf/Documentation/itrace.txt
index c2182cbabde3..82ff7dad40c2 100644
--- a/tools/perf/Documentation/itrace.txt
+++ b/tools/perf/Documentation/itrace.txt
@@ -5,6 +5,8 @@
 		x	synthesize transactions events
 		w	synthesize ptwrite events
 		p	synthesize power events
+		o	synthesize other events recorded due to the use
+			of aux-output (refer to perf record)
 		e	synthesize error events
 		d	create a debug log
 		g	synthesize a call chain (use with i or x)
diff --git a/tools/perf/util/auxtrace.c b/tools/perf/util/auxtrace.c
index 72ce4c5e7c78..60428576426e 100644
--- a/tools/perf/util/auxtrace.c
+++ b/tools/perf/util/auxtrace.c
@@ -974,6 +974,7 @@ void itrace_synth_opts__set_default(struct itrace_synth_opts *synth_opts,
 	synth_opts->transactions = true;
 	synth_opts->ptwrites = true;
 	synth_opts->pwr_events = true;
+	synth_opts->other_events = true;
 	synth_opts->errors = true;
 	if (no_sample) {
 		synth_opts->period_type = PERF_ITRACE_PERIOD_INSTRUCTIONS;
@@ -1071,6 +1072,9 @@ int itrace_parse_synth_opts(const struct option *opt, const char *str,
 		case 'p':
 			synth_opts->pwr_events = true;
 			break;
+		case 'o':
+			synth_opts->other_events = true;
+			break;
 		case 'e':
 			synth_opts->errors = true;
 			break;
diff --git a/tools/perf/util/auxtrace.h b/tools/perf/util/auxtrace.h
index 8ccabacd0b11..8e637ac3918e 100644
--- a/tools/perf/util/auxtrace.h
+++ b/tools/perf/util/auxtrace.h
@@ -60,6 +60,8 @@ enum itrace_period_type {
  * @transactions: whether to synthesize events for transactions
  * @ptwrites: whether to synthesize events for ptwrites
  * @pwr_events: whether to synthesize power events
+ * @other_events: whether to synthesize other events recorded due to the use of
+ *                aux_output
  * @errors: whether to synthesize decoder error events
  * @dont_decode: whether to skip decoding entirely
  * @log: write a decoding log
@@ -86,6 +88,7 @@ struct itrace_synth_opts {
 	bool			transactions;
 	bool			ptwrites;
 	bool			pwr_events;
+	bool			other_events;
 	bool			errors;
 	bool			dont_decode;
 	bool			log;
