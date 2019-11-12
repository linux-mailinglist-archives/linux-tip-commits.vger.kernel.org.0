Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 968EAF8E55
	for <lists+linux-tip-commits@lfdr.de>; Tue, 12 Nov 2019 12:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbfKLLVW (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Tue, 12 Nov 2019 06:21:22 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:33731 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727399AbfKLLSR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Tue, 12 Nov 2019 06:18:17 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iUUBX-0000XM-0F; Tue, 12 Nov 2019 12:18:11 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 6EA2A1C04E8;
        Tue, 12 Nov 2019 12:18:06 +0100 (CET)
Date:   Tue, 12 Nov 2019 11:18:06 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/core] perf map: Check if the map still has some refcounts on exit
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>, Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-hany65tbeavsax7n3xvwl9pc@git.kernel.org>
References: <tip-hany65tbeavsax7n3xvwl9pc@git.kernel.org>
MIME-Version: 1.0
Message-ID: <157355748604.29376.4716695740555468697.tip-bot2@tip-bot2>
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

Commit-ID:     ee2555b612869a763563c5389ad789a52db0afd1
Gitweb:        https://git.kernel.org/tip/ee2555b612869a763563c5389ad789a52db0afd1
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 25 Oct 2019 15:14:50 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Wed, 06 Nov 2019 15:43:06 -03:00

perf map: Check if the map still has some refcounts on exit

We were checking just if it was still on some rb tree, but that is not
the only way that this map can still have references, map->refcnt is
there exactly for this, use it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Andi Kleen <ak@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-hany65tbeavsax7n3xvwl9pc@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/map.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/map.c b/tools/perf/util/map.c
index eec9b28..c9ba495 100644
--- a/tools/perf/util/map.c
+++ b/tools/perf/util/map.c
@@ -288,7 +288,7 @@ bool map__has_symbols(const struct map *map)
 
 static void map__exit(struct map *map)
 {
-	BUG_ON(!RB_EMPTY_NODE(&map->rb_node));
+	BUG_ON(refcount_read(&map->refcnt) != 0);
 	dso__zput(map->dso);
 }
 
