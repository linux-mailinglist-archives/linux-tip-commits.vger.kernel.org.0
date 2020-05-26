Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89EB919E397
	for <lists+linux-tip-commits@lfdr.de>; Sat,  4 Apr 2020 10:45:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726334AbgDDImG (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 4 Apr 2020 04:42:06 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41587 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726443AbgDDImF (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 4 Apr 2020 04:42:05 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeN2-0000ua-OT; Sat, 04 Apr 2020 10:41:40 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6E1511C047B;
        Sat,  4 Apr 2020 10:41:40 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:41:40 -0000
From:   "tip-bot2 for Andreas Gerstmayr" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf script report: Fix SEGFAULT when using DWARF mode
Cc:     Andreas Gerstmayr <agerstmayr@redhat.com>,
        Kim Phillips <kim.phillips@amd.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200402125417.422232-1-agerstmayr@redhat.com>
References: <20200402125417.422232-1-agerstmayr@redhat.com>
MIME-Version: 1.0
Message-ID: <158598970009.28353.16717946414374202141.tip-bot2@tip-bot2>
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

The following commit has been merged into the perf/urgent branch of tip:

Commit-ID:     1a4025f06059eeaecb2ef24363350ea3431568df
Gitweb:        https://git.kernel.org/tip/1a4025f06059eeaecb2ef24363350ea3431568df
Author:        Andreas Gerstmayr <agerstmayr@redhat.com>
AuthorDate:    Thu, 02 Apr 2020 14:54:16 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 03 Apr 2020 09:39:53 -03:00

perf script report: Fix SEGFAULT when using DWARF mode

When running perf script report with a Python script and a callgraph in
DWARF mode, intr_regs->regs can be 0 and therefore crashing the regs_map
function.

Added a check for this condition (same check as in builtin-script.c:595).

Signed-off-by: Andreas Gerstmayr <agerstmayr@redhat.com>
Tested-by: Kim Phillips <kim.phillips@amd.com>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Kan Liang <kan.liang@linux.intel.com>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Steven Rostedt (VMware) <rostedt@goodmis.org>
Link: http://lore.kernel.org/lkml/20200402125417.422232-1-agerstmayr@redhat.com
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/scripting-engines/trace-event-python.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/tools/perf/util/scripting-engines/trace-event-python.c b/tools/perf/util/scripting-engines/trace-event-python.c
index 8c1b27c..2c372cf 100644
--- a/tools/perf/util/scripting-engines/trace-event-python.c
+++ b/tools/perf/util/scripting-engines/trace-event-python.c
@@ -694,6 +694,9 @@ static int regs_map(struct regs_dump *regs, uint64_t mask, char *bf, int size)
 
 	bf[0] = 0;
 
+	if (!regs || !regs->regs)
+		return 0;
+
 	for_each_set_bit(r, (unsigned long *) &mask, sizeof(mask) * 8) {
 		u64 val = regs->regs[i++];
 
