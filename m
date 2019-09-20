Return-Path: <linux-tip-commits-owner@vger.kernel.org>
X-Original-To: lists+linux-tip-commits@lfdr.de
Delivered-To: lists+linux-tip-commits@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09091B9528
	for <lists+linux-tip-commits@lfdr.de>; Fri, 20 Sep 2019 18:21:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404969AbfITQVR (ORCPT <rfc822;lists+linux-tip-commits@lfdr.de>);
        Fri, 20 Sep 2019 12:21:17 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:52850 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404943AbfITQVR (ORCPT
        <rfc822;linux-tip-commits@vger.kernel.org>);
        Fri, 20 Sep 2019 12:21:17 -0400
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1iBLei-00048W-9J; Fri, 20 Sep 2019 18:21:12 +0200
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 93DCE1C0E33;
        Fri, 20 Sep 2019 18:21:00 +0200 (CEST)
Date:   Fri, 20 Sep 2019 16:21:00 -0000
From:   "tip-bot2 for Arnaldo Carvalho de Melo" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: perf/urgent] perf probe: Add missing build-id.h header.
Cc:     Adrian Hunter <adrian.hunter@intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        linux-kernel@vger.kernel.org
In-Reply-To: <tip-7u3sf4j5huhi3mqa1q77524b@git.kernel.org>
References: <tip-7u3sf4j5huhi3mqa1q77524b@git.kernel.org>
MIME-Version: 1.0
Message-ID: <156899646055.24167.4075828663931632576.tip-bot2@tip-bot2>
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

Commit-ID:     36f3f450a8dc02d9ba0d31bc31d5b329759ed855
Gitweb:        https://git.kernel.org/tip/36f3f450a8dc02d9ba0d31bc31d5b329759ed855
Author:        Arnaldo Carvalho de Melo <acme@redhat.com>
AuthorDate:    Tue, 10 Sep 2019 16:16:27 +01:00
Committer:     Arnaldo Carvalho de Melo <acme@redhat.com>
CommitterDate: Fri, 20 Sep 2019 09:19:20 -03:00

perf probe: Add missing build-id.h header.

It uses things defined in that header and was getting it only
indirectly, thru dso.h, fix it.

Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: Jiri Olsa <jolsa@kernel.org>
Cc: Namhyung Kim <namhyung@kernel.org>
Link: https://lkml.kernel.org/n/tip-7u3sf4j5huhi3mqa1q77524b@git.kernel.org
Signed-off-by: Arnaldo Carvalho de Melo <acme@redhat.com>
---
 tools/perf/util/probe-file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/tools/perf/util/probe-file.c b/tools/perf/util/probe-file.c
index d13db55..b659466 100644
--- a/tools/perf/util/probe-file.c
+++ b/tools/perf/util/probe-file.c
@@ -16,6 +16,7 @@
 #include "strlist.h"
 #include "strfilter.h"
 #include "debug.h"
+#include "build-id.h"
 #include "dso.h"
 #include "color.h"
 #include "symbol.h"
