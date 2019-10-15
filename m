Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B0AC8D6F28
	for <lists+linux-tip-commits@lfdr.de>; Tue, 15 Oct 2019 07:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727333AbfJOFgI (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 15 Oct 2019 01:36:08 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41976 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728431AbfJOFb5 (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 15 Oct 2019 01:31:57 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iKFQu-000085-Uj; Tue, 15 Oct 2019 07:31:45 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 551911C0493;
        Tue, 15 Oct 2019 07:31:40 +0200 (CEST)
Date:   Tue, 15 Oct 2019 05:31:40 -0000
From:   "tip-bot2 for Jiri Olsa" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf tools: Use perf_mmap way to detect aux mmap
Cc:     Jiri Olsa <jolsa@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Michael Petlan <mpetlan@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <20191007125344.14268-9-jolsa@kernel.org>
References: <20191007125344.14268-9-jolsa@kernel.org>
MIME-Version: 1.0
Message-ID: <157111750023.12254.15935532577728517772.tip-bot2@tip-bot2>
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

Commit-ID:     1d40ae4e1784bfa1646fd153ca022db21511284f
Gitweb:        https://git.kernel.org/tip/1d40ae4e1784bfa1646fd153ca022db21511284f
Author:        Jiri Olsa <jolsa@kernel.org>
AuthorDate:    Mon, 07 Oct 2019 14:53:16 +02:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Thu, 10 Oct 2019 10:11:54 -03:00

perf tools: Use perf_mmap way to detect aux mmap

We will move this code to libperf shortly, so we need to free it of
'struct auxtrace_mmap' usage, because it won't be available in libperf
(for now).

The perf_event_mmap_page::aux_size is set when the aux mmap is mapped,
so the check is equivalent.

Signed-off-by: Jiri Olsa <jolsa@kernel.org>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Michael Petlan <mpetlan@redhat.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20191007125344.14268-9-jolsa@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/mmap.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/tools/perf/util/mmap.c b/tools/perf/util/mmap.c
index 9f150d5..f246dd4 100644
--- a/tools/perf/util/mmap.c
+++ b/tools/perf/util/mmap.c
@@ -107,7 +107,9 @@ union perf_event *perf_mmap__read_event(struct mmap *map)
 
 static bool perf_mmap__empty(struct mmap *map)
 {
-	return perf_mmap__read_head(map) == map->core.prev && !map->auxtrace_mmap.base;
+	struct perf_event_mmap_page *pc = map->core.base;
+
+	return perf_mmap__read_head(map) == map->core.prev && !pc->aux_size;
 }
 
 void perf_mmap__consume(struct mmap *map)
