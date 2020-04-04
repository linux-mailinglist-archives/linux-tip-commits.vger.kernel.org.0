Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AA81F19E3FB
	for <lists+linux-tip-commits@lfdr.de>; Sat,  4 Apr 2020 10:50:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726277AbgDDItr (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Sat, 4 Apr 2020 04:49:47 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:41857 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726066AbgDDItr (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Sat, 4 Apr 2020 04:49:47 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1jKeUi-0001bp-Gv; Sat, 04 Apr 2020 10:49:36 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 958861C0243;
        Sat,  4 Apr 2020 10:41:48 +0200 (CEST)
Date:   Sat, 04 Apr 2020 08:41:48 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf python: Include rwsem.c in the pythong biding
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200403123606.GC23243@kernel.org>
References: <20200403123606.GC23243@kernel.org>
MIME-Version: 1.0
Message-ID: <158598970825.28353.17098687600421476935.tip-bot2@tip-bot2>
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

Commit-ID:     460c3ed999d700fa84c953f83141f580ef456b3c
Gitweb:        https://git.kernel.org/tip/460c3ed999d700fa84c953f83141f580ef456b3c
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Fri, 03 Apr 2020 09:29:52 -03:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 03 Apr 2020 09:37:55 -03:00

perf python: Include rwsem.c in the pythong biding

We'll need it for the cgroup patches, and its better to have it in a
separate patch in case we need to later revert the cgroup patches.

I.e. without this we have:

  [root@five ~]# perf test -v python
  19: 'import perf' in python                               :
  --- start ---
  test child forked, pid 148447
  Traceback (most recent call last):
    File "<stdin>", line 1, in <module>
  ImportError: /tmp/build/perf/python/perf.cpython-37m-x86_64-linux-gnu.so: undefined symbol: down_write
  test child finished with -1
  ---- end ----
  'import perf' in python: FAILED!
  [root@five ~]#

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Alexander Shishkin <alexander.shishkin@linux.intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Mark Rutland <mark.rutland@arm.com>
Cc: Namhyung Kim <namhyung@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Link: http://lore.kernel.org/lkml/20200403123606.GC23243@kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/python-ext-sources | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/python-ext-sources b/tools/perf/util/python-ext-sources
index e7279ea..a9d9c14 100644
--- a/tools/perf/util/python-ext-sources
+++ b/tools/perf/util/python-ext-sources
@@ -34,3 +34,4 @@ util/string.c
 util/symbol_fprintf.c
 util/units.c
 util/affinity.c
+util/rwsem.c
